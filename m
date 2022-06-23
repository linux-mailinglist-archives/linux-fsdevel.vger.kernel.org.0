Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9135586B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 20:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbiFWSQg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 14:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236649AbiFWSPG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 14:15:06 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885329B756;
        Thu, 23 Jun 2022 10:21:28 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id CAD8B5C0103;
        Thu, 23 Jun 2022 13:21:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 23 Jun 2022 13:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1656004887; x=1656091287; bh=FX/ka6nSMiO/vMSKfECar88nTceZSI/k9aK
        Sav3k/Uo=; b=D1AWMswjcNz1dLqFMcx/gqh51OiV5RdK5vZJSE2OUHEnkd3Nbkb
        HMbOlKz3VBC4i05HaPyyOs9wl+dQawFjypG//vgHoTutBHh2NkdG8RBfeMJTLYKZ
        HqJuPSk9C0RqzTkwVf/3LGrVJQ3eBS0xGQhiEM9upwZjTvgKYFEWoQYzJKkdYdgQ
        xxuSQFc5Xb0LN2Z3geG7Cw+G2MJcja3RkinCwVPlungbtr0avExkDcvtHWEf6O3+
        ZFnWHGkEazwq9LG3o5PWGy7OywMz2tzRK9FzHKgGEuU7N1X8fWuVe8ERJTVh6ubv
        lddAP7kwk6iNKaxeEzopiRFPBnYftjHMKnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656004887; x=
        1656091287; bh=FX/ka6nSMiO/vMSKfECar88nTceZSI/k9aKSav3k/Uo=; b=h
        h7KulrimoyGDBKs1h5x9OSrIh39YOOgRJicJDIpkCz0LwoQwSr/uz1qctlqzGzr5
        BDmxqiv3EyAyq+dZAhM/N0PGZ8hhRqDnKmw8LOAlpfCxAPNtzUjRSva7UHpk7etN
        8HpxwQPT/ghQoh1xBzV0EnjQugM0/f/K8U02pCLYUshLdgy1UpnmsKAsGA6DTI85
        M59fgsw1AoJLHE33v812PLrA+MDmTiOOJ5kiPqL3JkkKeM6cB9G68+s4V7ACa/0+
        fWQ4Z9NUJYutq62njhMl/0B3o49Q3CjyKLcB+R8EJAjfhmWYma7ORIX/IQX921sN
        0i8h07cAAArOPdrHMqm6g==
X-ME-Sender: <xms:F6G0YrsF001j0dAxLj8Kxip7yu2n0oqwJ-AWEsJJT1fxgyY6kYyS-w>
    <xme:F6G0YseOWXTe0d2NizUg6gTSkZJf3s3g-B63RpYlWWT-aFSFXVGbBEcXaKXfDdTOp
    CBZq7DcgEoGltYLU4Y>
X-ME-Received: <xmr:F6G0YuzsPCn6l7IacHI-ybMnbTb2LVOHmurk-M0m_bQJsqavsXmE6fyc_qdWFbL_Qlh_X6zeFOpqXB0Ssz62EQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefjedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpeffhffvvefukfggtggu
    sehttdertddttddvnecuhfhrohhmpefvhigthhhoucetnhguvghrshgvnhcuoehthigthh
    hosehthigthhhordhpihiiiigrqeenucggtffrrghtthgvrhhnpeevhedttdfgffeghfff
    iefgheevhedvgefhvedtueetjeeklefgheffteelieelkeenucffohhmrghinhepghhith
    hhuhgsrdgtohhmpdhsohhurhgtvghfohhrghgvrdhnvghtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthihtghhohesthihtghhohdrphhiii
    iirg
X-ME-Proxy: <xmx:F6G0YqNUQKL7r9qPaBTYONTH1XRUMHUK4YpJM0I1ZjXHfvs6TG8qQA>
    <xmx:F6G0Yr8_9n3LQHtZ1RKcsQl3vOmdEQ2l63wm4FEKGx8rpxs_X49gfw>
    <xmx:F6G0YqVaGcaolFY0bEdEKOxUYz9v1SwTaMM5BNRLwj45RhVlZF41dQ>
    <xmx:F6G0YnaIy7BN78dCVGTIqbg90s_y1uVTXgYAmMn3FLtLiiBBskdrZg>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jun 2022 13:21:26 -0400 (EDT)
Date:   Thu, 23 Jun 2022 11:21:25 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: strange interaction between fuse + pidns
Message-ID: <YrShFXRLtRt6T/j+@risky>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

I'm seeing some weird interactions with fuse and the pid namespace. I have a
small reproducer here: https://github.com/tych0/kernel-utils/tree/master/fuse2

fuse has the concept of "forcing" a request, which means (among other
things) that it does an unkillable wait in request_wait_answer(). fuse
flushes files when they are closed with this unkillable wait:

$ sudo cat /proc/1544574/stack
[<0>] request_wait_answer+0x12f/0x210
[<0>] fuse_simple_request+0x109/0x2c0
[<0>] fuse_flush+0x16f/0x1b0
[<0>] filp_close+0x27/0x70
[<0>] put_files_struct+0x6b/0xc0
[<0>] do_exit+0x360/0xb80
[<0>] do_group_exit+0x3a/0xa0
[<0>] get_signal+0x140/0x870
[<0>] arch_do_signal_or_restart+0xae/0x7c0
[<0>] exit_to_user_mode_prepare+0x10f/0x1c0
[<0>] syscall_exit_to_user_mode+0x26/0x40
[<0>] do_syscall_64+0x46/0xb0
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae

Generally, this is OK, since the fuse_dev_release() -> fuse_abort_conn()
wakes up this code when a fuse dev goes away (i.e. a fuse daemon is killed
or unmounted or whatever). However, there's a problem when the fuse daemon
itself spawns a thread that does a flush: since the thread has a copy of
the fd table with an fd pointing to the same fuse device, the reference
count isn't decremented to zero in fuse_dev_release(), and the task hangs
forever.

Tasks can be aborted via fusectl's abort file, so all is not lost. However,
this does wreak havoc in containers which mounted a fuse filesystem with
this state. If the init pid exits (or crashes), the kernel tries to clean
up the pidns:

$ sudo cat /proc/1528591/stack
[<0>] do_wait+0x156/0x2f0
[<0>] kernel_wait4+0x8d/0x140
[<0>] zap_pid_ns_processes+0x104/0x180
[<0>] do_exit+0xa41/0xb80
[<0>] do_group_exit+0x3a/0xa0
[<0>] __x64_sys_exit_group+0x14/0x20
[<0>] do_syscall_64+0x37/0xb0
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae

but hangs forever. This unkillable wait seems unfortunate, so I tried the
obvious thing of changing it to a killable wait:

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 0e537e580dc1..c604dfcaec26 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -297,7 +297,6 @@ void fuse_request_end(struct fuse_req *req)
 		spin_unlock(&fiq->lock);
 	}
 	WARN_ON(test_bit(FR_PENDING, &req->flags));
-	WARN_ON(test_bit(FR_SENT, &req->flags));
 	if (test_bit(FR_BACKGROUND, &req->flags)) {
 		spin_lock(&fc->bg_lock);
 		clear_bit(FR_BACKGROUND, &req->flags);
@@ -381,30 +380,33 @@ static void request_wait_answer(struct fuse_req *req)
 			queue_interrupt(req);
 	}
 
-	if (!test_bit(FR_FORCE, &req->flags)) {
-		/* Only fatal signals may interrupt this */
-		err = wait_event_killable(req->waitq,
-					test_bit(FR_FINISHED, &req->flags));
-		if (!err)
-			return;
+	/* Only fatal signals may interrupt this */
+	err = wait_event_killable(req->waitq,
+				test_bit(FR_FINISHED, &req->flags));
+	if (!err)
+		return;
 
-		spin_lock(&fiq->lock);
-		/* Request is not yet in userspace, bail out */
-		if (test_bit(FR_PENDING, &req->flags)) {
-			list_del(&req->list);
-			spin_unlock(&fiq->lock);
-			__fuse_put_request(req);
-			req->out.h.error = -EINTR;
-			return;
-		}
+	spin_lock(&fiq->lock);
+	/* Request is not yet in userspace, bail out */
+	if (test_bit(FR_PENDING, &req->flags)) {
+		list_del(&req->list);
 		spin_unlock(&fiq->lock);
+		__fuse_put_request(req);
+		req->out.h.error = -EINTR;
+		return;
 	}
+	spin_unlock(&fiq->lock);
 
 	/*
-	 * Either request is already in userspace, or it was forced.
-	 * Wait it out.
+	 * Womp womp. We sent a request to userspace and now we're getting
+	 * killed.
 	 */
-	wait_event(req->waitq, test_bit(FR_FINISHED, &req->flags));
+	set_bit(FR_INTERRUPTED, &req->flags);
+	/* matches barrier in fuse_dev_do_read() */
+	smp_mb__after_atomic();
+	/* request *must* be FR_SENT here, because we ignored FR_PENDING before */
+	WARN_ON(!test_bit(FR_SENT, &req->flags));
+	queue_interrupt(req);
 }
 
 static void __fuse_request_send(struct fuse_req *req)

avaialble as a full patch here:
https://github.com/tych0/linux/commit/81b9ff4c8c1af24f6544945da808dbf69a1293f7

but now things are even weirder. Tasks are stuck at the killable wait, but with
a SIGKILL pending for the thread group.

root@(none):/# cat /proc/187/stack
[<0>] fuse_simple_request+0x8d9/0x10f0 [fuse]
[<0>] fuse_flush+0x42f/0x630 [fuse]
[<0>] filp_close+0x96/0x120
[<0>] put_files_struct+0x15c/0x2c0
[<0>] do_exit+0xa00/0x2450
[<0>] do_group_exit+0xb2/0x2a0
[<0>] __x64_sys_exit_group+0x35/0x40
[<0>] do_syscall_64+0x40/0x90
[<0>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
root@(none):/# cat /proc/187/status
Name:   main
Umask:  0022
State:  S (sleeping)
Tgid:   187
Ngid:   0
Pid:    187
PPid:   185
TracerPid:      0
Uid:    0       0       0       0
Gid:    0       0       0       0
FDSize: 0
Groups:
NStgid: 187     3
NSpid:  187     3
NSpgid: 171     0
NSsid:  160     0
Threads:        1
SigQ:   0/6706
SigPnd: 0000000000000000
ShdPnd: 0000000000000100
SigBlk: 0000000000000000
SigIgn: 0000000180004002
SigCgt: 0000000000000000
CapInh: 0000000000000000
CapPrm: 000001ffffffffff
CapEff: 000001ffffffffff
CapBnd: 000001ffffffffff
CapAmb: 0000000000000000
NoNewPrivs:     0
Seccomp:        0
Seccomp_filters:        0
Speculation_Store_Bypass:       thread vulnerable
SpeculationIndirectBranch:      conditional enabled
Cpus_allowed:   f
Cpus_allowed_list:      0-3
Mems_allowed:   00000000,00000001
Mems_allowed_list:      0
voluntary_ctxt_switches:        6
nonvoluntary_ctxt_switches:     1

Any ideas what's going on here? It also seems I'm not the first person to
wonder about this:
https://sourceforge.net/p/fuse/mailman/fuse-devel/thread/CAMp4zn9zTA_A2GJiYo5AD9V5HpeXbzzMP%3DnF0WtwbxRbV3koNA%40mail.gmail.com/#msg36598753

Thanks,

Tycho
