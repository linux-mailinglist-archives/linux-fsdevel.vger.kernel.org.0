Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A941F597C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2019 22:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732783AbfKHVPP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Nov 2019 16:15:15 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:36111 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731743AbfKHVPP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:15:15 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M2ON6-1iUpU10hYc-003rip; Fri, 08 Nov 2019 22:14:55 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 12/23] y2038: syscalls: change remaining timeval to __kernel_old_timeval
Date:   Fri,  8 Nov 2019 22:12:11 +0100
Message-Id: <20191108211323.1806194-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191108210236.1296047-1-arnd@arndb.de>
References: <20191108210236.1296047-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:L5MXbYk31wOXwoBz972x9kuLeZIEuu+iSFnMEMxFsvJUSyMZcA5
 KJDBtqG97dBLfawBhDt9kcwvJVvuwOQ596SiSyGadN0etYEY4mHIcslPBMvhPxUeiASTwtE
 4HuvheJuT5lTmRZ2iJaCMwpj7E00u6pChQLfyfcNCai0JwzuRda/z3lx8uBV/SGvrx3+2hE
 v3L/VsxyHbSgyY9NiNRbA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vzi6yde6b/Y=:ccalfERfsUEw5gS+vbBk40
 2pXxs9573zedbV97jmVac2Hd1aJR6bl5MYGgvW2fYC9hDjckcs4/aqqNfk4Mty8m6lYfGAHO6
 5js6bYy+kzIpVkubVkF9YsvcO3ZZHee5W4p2c9Ysx8xD9jjQpDoqBDPEyJbcwiHVaomVoj4bE
 0WD+6FuQCdvgxREISAkqwJlb7+QF/dBFT5Q6/ZyOfOqXzoH71fKgCQj7KwaSCEuuGd/A4h0aY
 6Px9rTYGebyI6et4h4wCRgTVuMjRrFPuLUQVKDm7opN+aIJUKcMLqYzSwcycK6xPujokgupip
 UXhzNc46PDF4VGfT0TFv05d/rkqfwnz6IMvFI43cxdKN2jBDCPHqDYaF4IHjuLLfS8epEvDca
 dW+YWaydV+DP4dNGpCCUMQ69Gry4TGR1rdE9Hv2g3+tgymMpoiN+PFS7yccDBHBtFgWMhB7uD
 nRUGZXnkIc6ZlbhTmgTEDHv923hP6eoj461EDqMH6o17vOdPIUYLbRBEZdaWpppISWbfNJHFy
 o+CsXM9xLVJ41r2GUsD3OlN9wDF57IkUMTdSP1TPHpLTg8tQt1KSx0liPDIBCsBjmOS27/8Gy
 YgGivN27m6iSpVffP4eDtveIo4c6TU77s/QCmzH6pGzD8y/KWU0GmXMaOCWYHQLrZK4zuAMD2
 +MbnM1nHjqbdI/+v4TPx6KLmftPRa6CP/2wO63/IlA1+yYihaDygxL7/ut0w6qZP/pcCHnD+P
 76rVbneRg0ADgYWIhuBGfGV4KDJJFcgrX/+bta7Ng8mQNlm2w5i0AvGMpldh8EN8mGS0OfNcU
 mEmUPpx/EDdJ828L7cfx83d8ZMGPIKWUYJgwb5MpOxSoVtQw/G3/nESpKWbxtGOyPejhCQcmE
 1qC5qhTto/Pmq0rO3eWQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All of the remaining syscalls that pass a timeval (gettimeofday, utime,
futimesat) can trivially be changed to pass a __kernel_old_timeval
instead, which has a compatible layout, but avoids ambiguity with
the timeval type in user space.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/include/asm/asm-prototypes.h |  3 ++-
 arch/powerpc/kernel/syscalls.c            |  4 ++--
 fs/select.c                               | 10 +++++-----
 fs/utimes.c                               |  8 ++++----
 include/linux/syscalls.h                  | 10 +++++-----
 kernel/power/power.h                      |  2 +-
 kernel/time/time.c                        |  2 +-
 7 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index 8561498e653c..2c25dc079cb9 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -92,7 +92,8 @@ long sys_swapcontext(struct ucontext __user *old_ctx,
 long sys_debug_setcontext(struct ucontext __user *ctx,
 			  int ndbg, struct sig_dbg_op __user *dbg);
 int
-ppc_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp, struct timeval __user *tvp);
+ppc_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp,
+	   struct __kernel_old_timeval __user *tvp);
 unsigned long __init early_init(unsigned long dt_ptr);
 void __init machine_init(u64 dt_ptr);
 #endif
diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
index 3bfb3888e897..078608ec2e92 100644
--- a/arch/powerpc/kernel/syscalls.c
+++ b/arch/powerpc/kernel/syscalls.c
@@ -79,7 +79,7 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, size_t, len,
  * sys_select() with the appropriate args. -- Cort
  */
 int
-ppc_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp, struct timeval __user *tvp)
+ppc_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp, struct __kernel_old_timeval __user *tvp)
 {
 	if ( (unsigned long)n >= 4096 )
 	{
@@ -89,7 +89,7 @@ ppc_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp, s
 		    || __get_user(inp, ((fd_set __user * __user *)(buffer+1)))
 		    || __get_user(outp, ((fd_set  __user * __user *)(buffer+2)))
 		    || __get_user(exp, ((fd_set  __user * __user *)(buffer+3)))
-		    || __get_user(tvp, ((struct timeval  __user * __user *)(buffer+4))))
+		    || __get_user(tvp, ((struct __kernel_old_timeval  __user * __user *)(buffer+4))))
 			return -EFAULT;
 	}
 	return sys_select(n, inp, outp, exp, tvp);
diff --git a/fs/select.c b/fs/select.c
index 53a0c149f528..11d0285d46b7 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -321,7 +321,7 @@ static int poll_select_finish(struct timespec64 *end_time,
 	switch (pt_type) {
 	case PT_TIMEVAL:
 		{
-			struct timeval rtv;
+			struct __kernel_old_timeval rtv;
 
 			if (sizeof(rtv) > sizeof(rtv.tv_sec) + sizeof(rtv.tv_usec))
 				memset(&rtv, 0, sizeof(rtv));
@@ -698,10 +698,10 @@ int core_sys_select(int n, fd_set __user *inp, fd_set __user *outp,
 }
 
 static int kern_select(int n, fd_set __user *inp, fd_set __user *outp,
-		       fd_set __user *exp, struct timeval __user *tvp)
+		       fd_set __user *exp, struct __kernel_old_timeval __user *tvp)
 {
 	struct timespec64 end_time, *to = NULL;
-	struct timeval tv;
+	struct __kernel_old_timeval tv;
 	int ret;
 
 	if (tvp) {
@@ -720,7 +720,7 @@ static int kern_select(int n, fd_set __user *inp, fd_set __user *outp,
 }
 
 SYSCALL_DEFINE5(select, int, n, fd_set __user *, inp, fd_set __user *, outp,
-		fd_set __user *, exp, struct timeval __user *, tvp)
+		fd_set __user *, exp, struct __kernel_old_timeval __user *, tvp)
 {
 	return kern_select(n, inp, outp, exp, tvp);
 }
@@ -810,7 +810,7 @@ SYSCALL_DEFINE6(pselect6_time32, int, n, fd_set __user *, inp, fd_set __user *,
 struct sel_arg_struct {
 	unsigned long n;
 	fd_set __user *inp, *outp, *exp;
-	struct timeval __user *tvp;
+	struct __kernel_old_timeval __user *tvp;
 };
 
 SYSCALL_DEFINE1(old_select, struct sel_arg_struct __user *, arg)
diff --git a/fs/utimes.c b/fs/utimes.c
index 1ba3f7883870..c952b6b3d8a0 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -161,9 +161,9 @@ SYSCALL_DEFINE4(utimensat, int, dfd, const char __user *, filename,
  * utimensat() instead.
  */
 static long do_futimesat(int dfd, const char __user *filename,
-			 struct timeval __user *utimes)
+			 struct __kernel_old_timeval __user *utimes)
 {
-	struct timeval times[2];
+	struct __kernel_old_timeval times[2];
 	struct timespec64 tstimes[2];
 
 	if (utimes) {
@@ -190,13 +190,13 @@ static long do_futimesat(int dfd, const char __user *filename,
 
 
 SYSCALL_DEFINE3(futimesat, int, dfd, const char __user *, filename,
-		struct timeval __user *, utimes)
+		struct __kernel_old_timeval __user *, utimes)
 {
 	return do_futimesat(dfd, filename, utimes);
 }
 
 SYSCALL_DEFINE2(utimes, char __user *, filename,
-		struct timeval __user *, utimes)
+		struct __kernel_old_timeval __user *, utimes)
 {
 	return do_futimesat(AT_FDCWD, filename, utimes);
 }
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 2f27bc9d5ef0..e665920fa359 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -51,7 +51,7 @@ struct statx;
 struct __sysctl_args;
 struct sysinfo;
 struct timespec;
-struct timeval;
+struct __kernel_old_timeval;
 struct __kernel_timex;
 struct timezone;
 struct tms;
@@ -732,7 +732,7 @@ asmlinkage long sys_prctl(int option, unsigned long arg2, unsigned long arg3,
 asmlinkage long sys_getcpu(unsigned __user *cpu, unsigned __user *node, struct getcpu_cache __user *cache);
 
 /* kernel/time.c */
-asmlinkage long sys_gettimeofday(struct timeval __user *tv,
+asmlinkage long sys_gettimeofday(struct __kernel_old_timeval __user *tv,
 				struct timezone __user *tz);
 asmlinkage long sys_settimeofday(struct timeval __user *tv,
 				struct timezone __user *tz);
@@ -1082,9 +1082,9 @@ asmlinkage long sys_time32(old_time32_t __user *tloc);
 asmlinkage long sys_utime(char __user *filename,
 				struct utimbuf __user *times);
 asmlinkage long sys_utimes(char __user *filename,
-				struct timeval __user *utimes);
+				struct __kernel_old_timeval __user *utimes);
 asmlinkage long sys_futimesat(int dfd, const char __user *filename,
-			      struct timeval __user *utimes);
+			      struct __kernel_old_timeval __user *utimes);
 #endif
 asmlinkage long sys_futimesat_time32(unsigned int dfd,
 				     const char __user *filename,
@@ -1098,7 +1098,7 @@ asmlinkage long sys_getdents(unsigned int fd,
 				struct linux_dirent __user *dirent,
 				unsigned int count);
 asmlinkage long sys_select(int n, fd_set __user *inp, fd_set __user *outp,
-			fd_set __user *exp, struct timeval __user *tvp);
+			fd_set __user *exp, struct __kernel_old_timeval __user *tvp);
 asmlinkage long sys_poll(struct pollfd __user *ufds, unsigned int nfds,
 				int timeout);
 asmlinkage long sys_epoll_wait(int epfd, struct epoll_event __user *events,
diff --git a/kernel/power/power.h b/kernel/power/power.h
index 44bee462ff57..7cdc64dc2373 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -179,7 +179,7 @@ extern void swsusp_close(fmode_t);
 extern int swsusp_unmark(void);
 #endif
 
-struct timeval;
+struct __kernel_old_timeval;
 /* kernel/power/swsusp.c */
 extern void swsusp_show_speed(ktime_t, ktime_t, unsigned int, char *);
 
diff --git a/kernel/time/time.c b/kernel/time/time.c
index 7eba7c9a7e3e..bc114f0be8f1 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -137,7 +137,7 @@ SYSCALL_DEFINE1(stime32, old_time32_t __user *, tptr)
 #endif /* __ARCH_WANT_SYS_TIME32 */
 #endif
 
-SYSCALL_DEFINE2(gettimeofday, struct timeval __user *, tv,
+SYSCALL_DEFINE2(gettimeofday, struct __kernel_old_timeval __user *, tv,
 		struct timezone __user *, tz)
 {
 	if (likely(tv != NULL)) {
-- 
2.20.0

