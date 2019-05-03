Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00AC61254C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 02:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfECABn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 20:01:43 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35929 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfECABm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 20:01:42 -0400
Received: by mail-it1-f195.google.com with SMTP id v143so6532826itc.1;
        Thu, 02 May 2019 17:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wsQOjuP2kWERRkDcgSZM8fKmb9mLJZ9LzlX/wNjWpTI=;
        b=Jofg3PYz535AEowjE+OmIQQGlFHxRhyc7gUKkyzm6ZvjjZska+fVsOW772AMX7+Dlg
         UO1kCwNluctqpxpcWA+Z1gpP9lQ37bcVGyG8N4vphJQtHcdUUKnLHFOYtJKlESr60kN2
         R4S9UOPCh/qll6kdb93JJ7ug4702RPIoj7Xr40iQIwU+eaWvn8FGXvvQeWOv8zeWPRSL
         35nwEqg9kxR1WpaxsOWQO/RPjpDSfkCmRIvVnFh9AV6lVRdB/qEkP7goAYNmTUhEbahW
         f3oRJo52KWubGnEKnh7CAkM2IwafjG1jUpF4XNmHsRu/s0IPX61j14N1/OUTe/9XwyRj
         v3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wsQOjuP2kWERRkDcgSZM8fKmb9mLJZ9LzlX/wNjWpTI=;
        b=Aw19oebrvAvvdd+2obXY+l+0mV1BAEGR4GYHhs+VNZGwY4eRhWSERK8eXN40KVeX2/
         Yh9+miN+Szo8BRJ7lnoWzdySQa7gxnkski51SaX5OknSqLM90EtfsjuEOLDr1/D+wuoY
         7Mguvk3+xAlQlJDV+V95X0DRC+hKTaas4A/o+JdL6vmmpVAgzFiTDvPH80stmkbuqoHe
         j8ihuxuIrRLSzSqaion5Xdg+9IrWqEXQPafHepVJ4rfwWiDk8qogkfGI1nCWYOfcJUd/
         l8rN3DytLPlhtoG2m0+VDHNS/X+Fol71T4cjjNGQv2YH+lfpsDvow5roWzYTOjME2IYd
         4wag==
X-Gm-Message-State: APjAAAUduQMF+iTPXyg5oEUwBeiZSrRaHG7BDOMsIH2hyGD8AqwIvwh4
        PZ3zFJp2Mk1EOyFUjD0IS5J3YEjcGPvkRCL3H48=
X-Google-Smtp-Source: APXvYqyWXSgDW50AVjgZSXMI6NtT2sr2+mSI6I+O3oAOKNLlNe9mDS5sd5E2y/30lNLEl906LJKl4PkinJeNYX7XZ8g=
X-Received: by 2002:a24:9412:: with SMTP id j18mr4829897ite.61.1556841701700;
 Thu, 02 May 2019 17:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190424193903.swlfmfuo6cqnpkwa@dcvr> <20190427093319.sgicqik2oqkez3wk@dcvr>
 <CABeXuvrY9QdvF1gTfiMt-eVp7VtobwG9xzjQFkErq+3wpW_P3Q@mail.gmail.com>
 <20190428004858.el3yk6hljloeoxza@dcvr> <20190429204754.hkz7z736tdk4ucum@linux-r8p5>
 <20190429210427.dmfemfft2t2gdwko@dcvr> <CABeXuvqpAjk8ocRUabVU4Yviv7kgRkMneLE1Xy-jAtHdXAHBVw@mail.gmail.com>
 <20190501021405.hfvd7ps623liu25i@dcvr> <20190501073906.ekqr7xbw3qkfgv56@dcvr>
 <CABeXuvq7gCV2qPOo+Q8jvNyRaTvhkRLRbnL_oJ-AuK7Sp=P3QQ@mail.gmail.com>
 <20190501204826.umekxc7oynslakes@dcvr> <CABeXuvqbCDhp+67SpGLAO7dYiWzWufewQBn+MTxY5NYsaQVrPg@mail.gmail.com>
In-Reply-To: <CABeXuvqbCDhp+67SpGLAO7dYiWzWufewQBn+MTxY5NYsaQVrPg@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Thu, 2 May 2019 17:01:30 -0700
Message-ID: <CABeXuvrJrdGFUsv7_cAwtyGpc2LpG21+90=jMR4a+CcUPvysRw@mail.gmail.com>
Subject: Re: Strange issues with epoll since 5.0
To:     Eric Wong <e@80x24.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jason Baron <jbaron@akamai.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Omar Kilani <omar.kilani@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric,
Can you please help test this?
If this solves your problem, I can post the fix.
Thanks,
- Deepa

---------8<-------

Subject: [PATCH] signal: Adjust error codes according to restore_user_sigmask()

For all the syscalls that receive a sigmask from the userland,
the user sigmask is to be in effect through the syscall execution.
At the end of syscall, sigmask of the current process is restored
to what it was before the switch over to user sigmask.
But, for this to be true in practice, the sigmask should be restored
only at the the point we change the saved_sigmask. Anything before
that loses signals. And, anything after is just pointless as the
signal is already lost by restoring the sigmask.

The issue was detected because of a regression caused by 854a6ed56839a.
The patch moved the signal_pending() check closer to restoring of the
user sigmask. But, it failed to update the error code accordingly.

Detailed issue discussion permalink:
https://lore.kernel.org/linux-fsdevel/20190427093319.sgicqik2oqkez3wk@dcvr/

Note that the patch returns interrupted errors (EINTR, ERESTARTNOHAND, etc)
only when there is no other error. If there is a signal and an error like
EINVAL, the syscalls return -EINVAL rather than the interrupted error codes.

Reported-by: Omar Kilani <omar.kilani@gmail.com>
Reported-by: Eric Wong <e@80x24.org>
Fixes: 854a6ed56839a40f6b5d02a2962f48841482eec4 ("signal: Add
restore_user_sigmask()")
Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 fs/aio.c               | 24 ++++++++++++------------
 fs/eventpoll.c         | 14 ++++++++++----
 fs/io_uring.c          |  9 ++++++---
 fs/select.c            | 37 +++++++++++++++++++++----------------
 include/linux/signal.h |  2 +-
 kernel/signal.c        |  8 +++++---
 6 files changed, 55 insertions(+), 39 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 38b741aef0bf..7de2f7573d55 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -2133,7 +2133,7 @@ SYSCALL_DEFINE6(io_pgetevents,
     struct __aio_sigset    ksig = { NULL, };
     sigset_t        ksigmask, sigsaved;
     struct timespec64    ts;
-    int ret;
+    int ret, signal_detected;

     if (timeout && unlikely(get_timespec64(&ts, timeout)))
         return -EFAULT;
@@ -2146,8 +2146,8 @@ SYSCALL_DEFINE6(io_pgetevents,
         return ret;

     ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &ts : NULL);
-    restore_user_sigmask(ksig.sigmask, &sigsaved);
-    if (signal_pending(current) && !ret)
+    signal_detected = restore_user_sigmask(ksig.sigmask, &sigsaved);
+    if (signal_detected && !ret)
         ret = -ERESTARTNOHAND;

     return ret;
@@ -2166,7 +2166,7 @@ SYSCALL_DEFINE6(io_pgetevents_time32,
     struct __aio_sigset    ksig = { NULL, };
     sigset_t        ksigmask, sigsaved;
     struct timespec64    ts;
-    int ret;
+    int ret, signal_detected;

     if (timeout && unlikely(get_old_timespec32(&ts, timeout)))
         return -EFAULT;
@@ -2180,8 +2180,8 @@ SYSCALL_DEFINE6(io_pgetevents_time32,
         return ret;

     ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &ts : NULL);
-    restore_user_sigmask(ksig.sigmask, &sigsaved);
-    if (signal_pending(current) && !ret)
+    signal_detected = restore_user_sigmask(ksig.sigmask, &sigsaved);
+    if (signal_detected && !ret)
         ret = -ERESTARTNOHAND;

     return ret;
@@ -2231,7 +2231,7 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents,
     struct __compat_aio_sigset ksig = { NULL, };
     sigset_t ksigmask, sigsaved;
     struct timespec64 t;
-    int ret;
+    int ret, signal_detected;

     if (timeout && get_old_timespec32(&t, timeout))
         return -EFAULT;
@@ -2244,8 +2244,8 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents,
         return ret;

     ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &t : NULL);
-    restore_user_sigmask(ksig.sigmask, &sigsaved);
-    if (signal_pending(current) && !ret)
+    signal_detected = restore_user_sigmask(ksig.sigmask, &sigsaved);
+    if (signal_detected && !ret)
         ret = -ERESTARTNOHAND;

     return ret;
@@ -2264,7 +2264,7 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents_time64,
     struct __compat_aio_sigset ksig = { NULL, };
     sigset_t ksigmask, sigsaved;
     struct timespec64 t;
-    int ret;
+    int ret, signal_detected;

     if (timeout && get_timespec64(&t, timeout))
         return -EFAULT;
@@ -2277,8 +2277,8 @@ COMPAT_SYSCALL_DEFINE6(io_pgetevents_time64,
         return ret;

     ret = do_io_getevents(ctx_id, min_nr, nr, events, timeout ? &t : NULL);
-    restore_user_sigmask(ksig.sigmask, &sigsaved);
-    if (signal_pending(current) && !ret)
+    signal_detected = restore_user_sigmask(ksig.sigmask, &sigsaved);
+    if (signal_detected && !ret)
         ret = -ERESTARTNOHAND;

     return ret;
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 4a0e98d87fcc..fe5a0724b417 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2317,7 +2317,7 @@ SYSCALL_DEFINE6(epoll_pwait, int, epfd, struct
epoll_event __user *, events,
         int, maxevents, int, timeout, const sigset_t __user *, sigmask,
         size_t, sigsetsize)
 {
-    int error;
+    int error, signal_detected;
     sigset_t ksigmask, sigsaved;

     /*
@@ -2330,7 +2330,10 @@ SYSCALL_DEFINE6(epoll_pwait, int, epfd, struct
epoll_event __user *, events,

     error = do_epoll_wait(epfd, events, maxevents, timeout);

-    restore_user_sigmask(sigmask, &sigsaved);
+    signal_detected = restore_user_sigmask(sigmask, &sigsaved);
+
+    if (signal_detected && !error)
+        error = -EINTR;

     return error;
 }
@@ -2342,7 +2345,7 @@ COMPAT_SYSCALL_DEFINE6(epoll_pwait, int, epfd,
             const compat_sigset_t __user *, sigmask,
             compat_size_t, sigsetsize)
 {
-    long err;
+    long err, signal_detected;
     sigset_t ksigmask, sigsaved;

     /*
@@ -2355,7 +2358,10 @@ COMPAT_SYSCALL_DEFINE6(epoll_pwait, int, epfd,

     err = do_epoll_wait(epfd, events, maxevents, timeout);

-    restore_user_sigmask(sigmask, &sigsaved);
+    signal_detected = restore_user_sigmask(sigmask, &sigsaved);
+
+    if (signal_detected && !err)
+        err = -EINTR;

     return err;
 }
diff --git a/fs/io_uring.c b/fs/io_uring.c
index e2bd77da5e21..e107e299c3f3 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1965,7 +1965,7 @@ static int io_cqring_wait(struct io_ring_ctx
*ctx, int min_events,
     struct io_cq_ring *ring = ctx->cq_ring;
     sigset_t ksigmask, sigsaved;
     DEFINE_WAIT(wait);
-    int ret;
+    int ret, signal_detected;

     /* See comment at the top of this file */
     smp_rmb();
@@ -1996,8 +1996,11 @@ static int io_cqring_wait(struct io_ring_ctx
*ctx, int min_events,

     finish_wait(&ctx->wait, &wait);

-    if (sig)
-        restore_user_sigmask(sig, &sigsaved);
+    if (sig) {
+        signal_detected = restore_user_sigmask(sig, &sigsaved);
+        if (signal_detected && !ret)
+            ret  = -EINTR;
+    }

     return READ_ONCE(ring->r.head) == READ_ONCE(ring->r.tail) ? ret : 0;
 }
diff --git a/fs/select.c b/fs/select.c
index 6cbc9ff56ba0..348dbe5e6dd0 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -732,7 +732,7 @@ static long do_pselect(int n, fd_set __user *inp,
fd_set __user *outp,
 {
     sigset_t ksigmask, sigsaved;
     struct timespec64 ts, end_time, *to = NULL;
-    int ret;
+    int ret, signal_detected;;

     if (tsp) {
         switch (type) {
@@ -760,7 +760,9 @@ static long do_pselect(int n, fd_set __user *inp,
fd_set __user *outp,
     ret = core_sys_select(n, inp, outp, exp, to);
     ret = poll_select_copy_remaining(&end_time, tsp, type, ret);

-    restore_user_sigmask(sigmask, &sigsaved);
+    signal_detected = restore_user_sigmask(sigmask, &sigsaved);
+    if (signal_detected && !ret)
+        ret = -EINTR;

     return ret;
 }
@@ -1089,7 +1091,7 @@ SYSCALL_DEFINE5(ppoll, struct pollfd __user *,
ufds, unsigned int, nfds,
 {
     sigset_t ksigmask, sigsaved;
     struct timespec64 ts, end_time, *to = NULL;
-    int ret;
+    int ret, signal_detected;

     if (tsp) {
         if (get_timespec64(&ts, tsp))
@@ -1106,10 +1108,10 @@ SYSCALL_DEFINE5(ppoll, struct pollfd __user *,
ufds, unsigned int, nfds,

     ret = do_sys_poll(ufds, nfds, to);

-    restore_user_sigmask(sigmask, &sigsaved);
+    signal_detected = restore_user_sigmask(sigmask, &sigsaved);

     /* We can restart this syscall, usually */
-    if (ret == -EINTR)
+    if (ret == -EINTR || (signal_detected && !ret))
         ret = -ERESTARTNOHAND;

     ret = poll_select_copy_remaining(&end_time, tsp, PT_TIMESPEC, ret);
@@ -1125,7 +1127,7 @@ SYSCALL_DEFINE5(ppoll_time32, struct pollfd
__user *, ufds, unsigned int, nfds,
 {
     sigset_t ksigmask, sigsaved;
     struct timespec64 ts, end_time, *to = NULL;
-    int ret;
+    int ret, signal_detected;

     if (tsp) {
         if (get_old_timespec32(&ts, tsp))
@@ -1142,10 +1144,10 @@ SYSCALL_DEFINE5(ppoll_time32, struct pollfd
__user *, ufds, unsigned int, nfds,

     ret = do_sys_poll(ufds, nfds, to);

-    restore_user_sigmask(sigmask, &sigsaved);
+    signal_detected = restore_user_sigmask(sigmask, &sigsaved);

     /* We can restart this syscall, usually */
-    if (ret == -EINTR)
+    if (ret == -EINTR || (signal_detected && !ret))
         ret = -ERESTARTNOHAND;

     ret = poll_select_copy_remaining(&end_time, tsp, PT_OLD_TIMESPEC, ret);
@@ -1324,7 +1326,7 @@ static long do_compat_pselect(int n,
compat_ulong_t __user *inp,
 {
     sigset_t ksigmask, sigsaved;
     struct timespec64 ts, end_time, *to = NULL;
-    int ret;
+    int ret, signal_detected;

     if (tsp) {
         switch (type) {
@@ -1352,7 +1354,10 @@ static long do_compat_pselect(int n,
compat_ulong_t __user *inp,
     ret = compat_core_sys_select(n, inp, outp, exp, to);
     ret = poll_select_copy_remaining(&end_time, tsp, type, ret);

-    restore_user_sigmask(sigmask, &sigsaved);
+    signal_detected = restore_user_sigmask(sigmask, &sigsaved);
+
+    if (signal_detected && !ret)
+        ret = -EINTR;

     return ret;
 }
@@ -1408,7 +1413,7 @@ COMPAT_SYSCALL_DEFINE5(ppoll_time32, struct
pollfd __user *, ufds,
 {
     sigset_t ksigmask, sigsaved;
     struct timespec64 ts, end_time, *to = NULL;
-    int ret;
+    int ret, signal_detected;

     if (tsp) {
         if (get_old_timespec32(&ts, tsp))
@@ -1425,10 +1430,10 @@ COMPAT_SYSCALL_DEFINE5(ppoll_time32, struct
pollfd __user *, ufds,

     ret = do_sys_poll(ufds, nfds, to);

-    restore_user_sigmask(sigmask, &sigsaved);
+    signal_detected = restore_user_sigmask(sigmask, &sigsaved);

     /* We can restart this syscall, usually */
-    if (ret == -EINTR)
+    if (ret == -EINTR || (signal_detected && !ret))
         ret = -ERESTARTNOHAND;

     ret = poll_select_copy_remaining(&end_time, tsp, PT_OLD_TIMESPEC, ret);
@@ -1444,7 +1449,7 @@ COMPAT_SYSCALL_DEFINE5(ppoll_time64, struct
pollfd __user *, ufds,
 {
     sigset_t ksigmask, sigsaved;
     struct timespec64 ts, end_time, *to = NULL;
-    int ret;
+    int ret, signal_detected;

     if (tsp) {
         if (get_timespec64(&ts, tsp))
@@ -1461,10 +1466,10 @@ COMPAT_SYSCALL_DEFINE5(ppoll_time64, struct
pollfd __user *, ufds,

     ret = do_sys_poll(ufds, nfds, to);

-    restore_user_sigmask(sigmask, &sigsaved);
+    signal_detected = restore_user_sigmask(sigmask, &sigsaved);

     /* We can restart this syscall, usually */
-    if (ret == -EINTR)
+    if (ret == -EINTR || (signal_detected && !ret))
         ret = -ERESTARTNOHAND;

     ret = poll_select_copy_remaining(&end_time, tsp, PT_TIMESPEC, ret);
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 9702016734b1..1d36e8629edf 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -275,7 +275,7 @@ extern int __group_send_sig_info(int, struct
kernel_siginfo *, struct task_struc
 extern int sigprocmask(int, sigset_t *, sigset_t *);
 extern int set_user_sigmask(const sigset_t __user *usigmask, sigset_t *set,
     sigset_t *oldset, size_t sigsetsize);
-extern void restore_user_sigmask(const void __user *usigmask,
+extern int restore_user_sigmask(const void __user *usigmask,
                  sigset_t *sigsaved);
 extern void set_current_blocked(sigset_t *);
 extern void __set_current_blocked(const sigset_t *);
diff --git a/kernel/signal.c b/kernel/signal.c
index 3a9e41197d46..4f8b49a7b058 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2845,15 +2845,16 @@ EXPORT_SYMBOL(set_compat_user_sigmask);
  * usigmask: sigmask passed in from userland.
  * sigsaved: saved sigmask when the syscall started and changed the sigmask to
  *           usigmask.
+ * returns 1 in case a pending signal is detected.
  *
  * This is useful for syscalls such as ppoll, pselect, io_pgetevents and
  * epoll_pwait where a new sigmask is passed in from userland for the syscalls.
  */
-void restore_user_sigmask(const void __user *usigmask, sigset_t *sigsaved)
+int restore_user_sigmask(const void __user *usigmask, sigset_t *sigsaved)
 {

     if (!usigmask)
-        return;
+        return 0;
     /*
      * When signals are pending, do not restore them here.
      * Restoring sigmask here can lead to delivering signals that the above
@@ -2862,7 +2863,7 @@ void restore_user_sigmask(const void __user
*usigmask, sigset_t *sigsaved)
     if (signal_pending(current)) {
         current->saved_sigmask = *sigsaved;
         set_restore_sigmask();
-        return;
+        return 1;
     }

     /*
@@ -2870,6 +2871,7 @@ void restore_user_sigmask(const void __user
*usigmask, sigset_t *sigsaved)
      * saved_sigmask when signals are not pending.
      */
     set_current_blocked(sigsaved);
+    return 0;
 }
 EXPORT_SYMBOL(restore_user_sigmask);

-- 
2.21.0.593.g511ec345e18-goog
