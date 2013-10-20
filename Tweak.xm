#import <substrate.h>

//declare hook and orig of ptrace
static int (*ptraceHook)(int request, pid_t pid, caddr_t addr, int data); 
static int (*_ptraceHook(int request, pid_t pid, caddr_t addr, int data); 

//implementation of the hook
static int $ptraceHook(int request, pid_t pid, caddr_t addr, int data) {

if (request == PT_DENY_ATTACH) { //check if the request is PT_DENY_ATTACH

request = -1; //invalidate if it is PT_DENY_ATTACH

}

return _ptraceHook(request,pid,addr,data);  //call orig
 
}

%ctor {

MSHookFunction((void *)MSFindSymbol(NULL,"_ptrace"), (void *)$ptraceHook, (void **)&_ptraceHook);

}