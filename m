Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFCC10CBF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 20:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfEAShf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 14:37:35 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50745 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfEAShf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 14:37:35 -0400
Received: by mail-it1-f194.google.com with SMTP id q14so121300itk.0;
        Wed, 01 May 2019 11:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uy+iWBx+WW6EJbfrO+sYIngfp35VvBvZMQR7Mxibfh8=;
        b=EfkImD+Bve2AkbZWHWfiW54XbW2+cDyaeJktUqG7AUIm1COpQ7IgvnJC9rXv9VdYxb
         DNZQcpymHYaiR/xoOrfBTjEtRO+jGTtKNn1z6rDwf4YFpTNiP5qQLAUdnjm1iawVBMY/
         N6IoCQAIWxP29JXWcXBXa56oLrB11x18o3HO28Nw2I9CZac2BfgkqmZjxHzMkFDYCw3o
         SF+B0MknNV9/cj/RK25F9XDnw4RJ7aOVKTwn4EwucP2sug/f8u9PEzHaSsBUDgcnu3Y/
         XD9BkZYgkLlObNzCFO1L6jrSH1YlE8uKsV84bnpktV8DUj7jkHUmFsu3l42oDRUDMVI6
         kmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uy+iWBx+WW6EJbfrO+sYIngfp35VvBvZMQR7Mxibfh8=;
        b=Jiu1yLWrP7ghsya7itTFSUlUEG7oFGE/iCSEIslXrmMXJYF0Bj9xVah3/tQzyQzLBj
         9vTVcjeKNDpTF08s4JIwsl6w3z1ghO4HilpttYjwRinXp2ingTMJqjHSBasLJmVv4i20
         aKLBSd/kBfstZ4QIhJgUjN+nZdFCYhVGOS90yolv/IXDTJzvEBrezVG65pO5pyAehdK2
         7aWUsw3Xz+2WdQKLcFRJwzcKBddSF551TRIuT63Z24pVTir1POeGPWdAGL5yXfQ0naXs
         /ftDdAoV4PlUqDp9UPRkPwQWxHRvZesb2wU0FetuSnZ35eCP86STYnQexIxgHzpoKTn/
         jCmg==
X-Gm-Message-State: APjAAAW6hK5ruEoTB4uc5MzM/ZDGtuWacUbtWdAAy3N64oPRH8QPz8Bi
        0fwl+2Iy5CEjtpcpuoqE2JK+f+xWKWEn/KjXHOvhQmif
X-Google-Smtp-Source: APXvYqxocDr/k4e6yFxb894ZheCA6S/wbtZAuYtRXtMYKK7NJ9+M8eG//wjx0Ci5R6kiQyMRJMfF5VpU5VBC1IznuDc=
X-Received: by 2002:a24:9412:: with SMTP id j18mr3717991ite.61.1556735854416;
 Wed, 01 May 2019 11:37:34 -0700 (PDT)
MIME-Version: 1.0
References: <CA+8F9hicnF=kvjXPZFQy=Pa2HJUS3JS+G9VswFHNQQynPMHGVQ@mail.gmail.com>
 <20190424193903.swlfmfuo6cqnpkwa@dcvr> <20190427093319.sgicqik2oqkez3wk@dcvr>
 <CABeXuvrY9QdvF1gTfiMt-eVp7VtobwG9xzjQFkErq+3wpW_P3Q@mail.gmail.com>
 <20190428004858.el3yk6hljloeoxza@dcvr> <20190429204754.hkz7z736tdk4ucum@linux-r8p5>
 <20190429210427.dmfemfft2t2gdwko@dcvr> <CABeXuvqpAjk8ocRUabVU4Yviv7kgRkMneLE1Xy-jAtHdXAHBVw@mail.gmail.com>
 <20190501021405.hfvd7ps623liu25i@dcvr> <20190501073906.ekqr7xbw3qkfgv56@dcvr>
In-Reply-To: <20190501073906.ekqr7xbw3qkfgv56@dcvr>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Wed, 1 May 2019 11:37:23 -0700
Message-ID: <CABeXuvq7gCV2qPOo+Q8jvNyRaTvhkRLRbnL_oJ-AuK7Sp=P3QQ@mail.gmail.com>
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

Thanks for trying the fix.

So here is my analysis:

Let's start with epoll_pwait:

ep_poll() is what checks for signal_pending() and is responsible for
setting errno to -EINTR when there is a signal.

So if a signal is received after ep_poll(), it is never noticed by the
syscall during execution.

Moreover, the original code before
854a6ed56839a40f6b5d02a2962f48841482eec4 ("signal: Add
restore_user_sigmask()"), had the following call flow:

     error = do_epoll_wait(epfd, events, maxevents, timeout);

**** Here error = 0 if the signal is received after ep_poll().

-       /*
-        * If we changed the signal mask, we need to restore the original one.
-        * In case we've got a signal while waiting, we do not restore the
-        * signal mask yet, and we allow do_signal() to deliver the signal on
-        * the way back to userspace, before the signal mask is restored.
-        */
-       if (sigmask) {
-               if (error == -EINTR) {
-                       memcpy(&current->saved_sigmask, &sigsaved,
-                              sizeof(sigsaved));
-                       set_restore_sigmask();
-               } else

**** Execution reaches this else statement and the sigmask is restored
directly, ignoring the newly generated signal. The signal is never
handled.

-                       set_current_blocked(&sigsaved);
-       }

In the current execution flow:

    error = do_epoll_wait(epfd, events, maxevents, timeout);

**** error is still 0 as ep_poll() did not detect the signal.

restore_user_sigmask(sigmask, &sigsaved, error == -EITNR);

void restore_user_sigmask(const void __user *usigmask, sigset_t *sigsaved)
{

        if (!usigmask)
                return;
        /*
         * When signals are pending, do not restore them here.
         * Restoring sigmask here can lead to delivering signals that the above
         * syscalls are intended to block because of the sigmask passed in.
         */
        if (signal_pending(current)) {

**** execution path reaches here and do_signal() actually delivers the
signal to userspace. But the errno is not set. So the userspace fails
to notice it.

                current->saved_sigmask = *sigsaved;
                set_restore_sigmask();
                return;
        }

        /*
         * This is needed because the fast syscall return path does not restore
         * saved_sigmask when signals are not pending.
         */
        set_current_blocked(sigsaved);
}

For other syscalls in the same commit:

sys_io_pgetevents() does not seem to have this problem as we are still
checking signal_pending() here.
sys_pselect6() seems to have a similar problem. The changes to
sys_pselect6() also impact sys_select() as the changes are in the
common code path.

So the 854a6ed56839a40f6 seems to be better than the original code in
that it detects the signal. But, the problem is that it doesn't
communicate it to the userspace.

So a patch like below solves the problem. This is incomplete. I'll
verify and send you a proper fix you can test soon. This is just for
the sake of discussion:

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 4a0e98d87fcc..63a387329c3d 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2317,7 +2317,7 @@ SYSCALL_DEFINE6(epoll_pwait, int, epfd, struct
epoll_event __user *, events,
                int, maxevents, int, timeout, const sigset_t __user *, sigmask,
                size_t, sigsetsize)
 {
-       int error;
+       int error, signal_detected;
        sigset_t ksigmask, sigsaved;

        /*
@@ -2330,7 +2330,10 @@ SYSCALL_DEFINE6(epoll_pwait, int, epfd, struct
epoll_event __user *, events,

        error = do_epoll_wait(epfd, events, maxevents, timeout);

-       restore_user_sigmask(sigmask, &sigsaved);
+       signal_detected = restore_user_sigmask(sigmask, &sigsaved);
+
+       if (signal_detected && !error)
+               return -EITNR;

        return error;
 }
@@ -2342,7 +2345,7 @@ COMPAT_SYSCALL_DEFINE6(epoll_pwait, int, epfd,
                        const compat_sigset_t __user *, sigmask,
                        compat_size_t, sigsetsize)
 {
-       long err;
+       long err, signal_detected;
        sigset_t ksigmask, sigsaved;

        /*
@@ -2355,7 +2358,10 @@ COMPAT_SYSCALL_DEFINE6(epoll_pwait, int, epfd,

        err = do_epoll_wait(epfd, events, maxevents, timeout);

-       restore_user_sigmask(sigmask, &sigsaved);
+       signal_detected = restore_user_sigmask(sigmask, &sigsaved);
+
+       if (signal_detected && !err)
+               return -EITNR;

        return err;
 }
diff --git a/kernel/signal.c b/kernel/signal.c
index 3a9e41197d46..c76ab2a52ebf 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2849,11 +2849,11 @@ EXPORT_SYMBOL(set_compat_user_sigmask);
  * This is useful for syscalls such as ppoll, pselect, io_pgetevents and
  * epoll_pwait where a new sigmask is passed in from userland for the syscalls.
  */
-void restore_user_sigmask(const void __user *usigmask, sigset_t *sigsaved)
+int restore_user_sigmask(const void __user *usigmask, sigset_t *sigsaved)
 {

        if (!usigmask)
-               return;
+               return 0;
        /*
         * When signals are pending, do not restore them here.
         * Restoring sigmask here can lead to delivering signals that the above
@@ -2862,7 +2862,7 @@ void restore_user_sigmask(const void __user
*usigmask, sigset_t *sigsaved)
        if (signal_pending(current)) {
                current->saved_sigmask = *sigsaved;
                set_restore_sigmask();
-               return;
+               return 0;
        }

-Deepa
