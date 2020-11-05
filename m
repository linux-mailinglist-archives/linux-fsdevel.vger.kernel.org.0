Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190782A776E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Nov 2020 07:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgKEGY5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Nov 2020 01:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgKEGY4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Nov 2020 01:24:56 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85C2C0613CF;
        Wed,  4 Nov 2020 22:24:55 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id x7so406343ili.5;
        Wed, 04 Nov 2020 22:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UU2z2bG3ZGrH0LDsa+Ifq89Jvb+Hxp8tvTSo9po1h2c=;
        b=XNxdWnmS6RfvwTGvaN8g1LyDtDPKs0XYTrTrX+6nA6vZurOr48vtF9lhKa05R5LV+w
         tXMWxG7YRdim4qgQak3gGYMB4g8W82MTqlyab6gQi/ZyzqlPRsKr1a/F5EYinPnyrTB0
         xB1r0lUyL6zRo5jvpnb3mK5CYtLBfdvYNDCNWJkZLftpeby2SksuvJoHcBNLM6xKCCfZ
         oG3wz23/CuhgcKWf5vP+lVDp7wTgGYxCl5Gy51SKPNrcqUeZp2kSEkBGTDhwq9OkZ9FB
         6ATuESyKqSYT5oBb7CbFpkJTHxoV5Y020lNdWEy8zc73wznNFJCCmgqtoAQHkR7cOl6d
         zOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UU2z2bG3ZGrH0LDsa+Ifq89Jvb+Hxp8tvTSo9po1h2c=;
        b=oZHc6eWabzIwX266s9JMrKR1h+y9UK4ypLvZUI93QD57tbTJbhUn77PRo54NRHxOMp
         SeoepqAZzYS3G09EIv/IXlF7Gn2yE8/Xi5fW96OMAUj5KarAqTOKljQw7WmKNafhYYMp
         lVWWirewTEORsllDCDZMO/agf4kdYKa7vECZfdkVl0OyBlemeqoVF284ntpi0y9xeyJH
         Yyfdw7Q76f1bv47p3xcCIRi7IEzTJ1G2EHYpZh8/i0EE3yKUIPlUW2/Z2s+ab/cQighT
         CE59sUCxLrotn3hkqjm4OAEB1qXgBH8md3nIqTxEUGO0uX0bYyyXygzsK3NoBqEHnVi3
         OgWQ==
X-Gm-Message-State: AOAM533ctGqC81LHBf00Jy0wV0GxkGloKYTeX5S2OdgUtXVklH5iFUmG
        DpCNVTdriadHkt+3Mdlg5g+NiTgbkVxDhA==
X-Google-Smtp-Source: ABdhPJx7bPZuNtxWNT+wqJN4zjdgPfKBcoL2Fl1VqCd9KY4cQd6zCx01BWoDPCQGiciZZKTMnl4g7A==
X-Received: by 2002:a92:bacb:: with SMTP id t72mr842662ill.241.1604557495279;
        Wed, 04 Nov 2020 22:24:55 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id g5sm414425ilq.33.2020.11.04.22.24.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Nov 2020 22:24:54 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4204E27C0054;
        Thu,  5 Nov 2020 01:24:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 05 Nov 2020 01:24:50 -0500
X-ME-Sender: <xms:sZqjX_-Cehaex-6HbqWVDmUAt8ON4Sbp4SXw0oS3ZAMMV97XdrEwxw>
    <xme:sZqjX7v85ND4OjuRgOHKqNilG1_KLrFMv4Zvm8PaJPFEHRI_OhlV5nAjiHC0G-eUd
    guA_bbsV10H0lpecg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtiedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoufhushhpvggtthffohhmrghinhculdegledmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepveffveekfeeujeehleffffdtleduleekieehieeugffgkefggefhfedvteeh
    tdehnecuffhomhgrihhnpehshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmpdhgoh
    hordhglhdpkhgvrhhnvghlrdhorhhgnecukfhppeduieejrddvvddtrddvrdduvdeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunh
    domhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeej
    keehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnh
    grmhgv
X-ME-Proxy: <xmx:sZqjX9D1U8rr-lW5_RZRo9jL-h-1DXDzHwtL3JnIj_oZIOwYxCf8jw>
    <xmx:sZqjX7f1O9UUbN5Znof68MpcEJ_wku3YbsEhPXmWsDWGZGAEnht-hQ>
    <xmx:sZqjX0PNQRxe6HMis9sICKrVb_-cIAdzfTlhhCzkdvHtlM73dC3aog>
    <xmx:spqjX1jyK6FYELVH1wgXLdIEvEdvcRtPYPOEqMLz0ulXNCgwxRZDD5D_WZE>
Received: from localhost (unknown [167.220.2.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1438E328038D;
        Thu,  5 Nov 2020 01:24:49 -0500 (EST)
Date:   Thu, 5 Nov 2020 14:23:51 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     syzbot <syzbot+c5e32344981ad9f33750@syzkaller.appspotmail.com>
Cc:     bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        will@kernel.org
Subject: Re: possible deadlock in send_sigurg (2)
Message-ID: <20201105062351.GA2840779@boqun-archlinux>
References: <0000000000009d056805b252e883@google.com>
 <000000000000e1c72705b346f8e6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000e1c72705b346f8e6@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Wed, Nov 04, 2020 at 04:18:08AM -0800, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit e918188611f073063415f40fae568fa4d86d9044
> Author: Boqun Feng <boqun.feng@gmail.com>
> Date:   Fri Aug 7 07:42:20 2020 +0000
> 
>     locking: More accurate annotations for read_lock()
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14142732500000
> start commit:   4ef8451b Merge tag 'perf-tools-for-v5.10-2020-11-03' of gi..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=16142732500000
> console output: https://syzkaller.appspot.com/x/log.txt?x=12142732500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=61033507391c77ff
> dashboard link: https://syzkaller.appspot.com/bug?extid=c5e32344981ad9f33750
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15197862500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13c59f6c500000
> 
> Reported-by: syzbot+c5e32344981ad9f33750@syzkaller.appspotmail.com
> Fixes: e918188611f0 ("locking: More accurate annotations for read_lock()")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Thanks for reporting this, and this is actually a deadlock potential
detected by the newly added recursive read deadlock detection as my
analysis:

	https://lore.kernel.org/lkml/20200910071523.GF7922@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net

Besides, other reports[1][2] are caused by the same problem. I made a
fix for this, please have a try and see if it's get fixed.

Regards,
Boqun

[1]: https://lore.kernel.org/lkml/000000000000d7136005aee14bf9@google.com
[2]: https://lore.kernel.org/lkml/0000000000006e29ed05b3009b04@google.com

----------------------------------------------------->8
From 7fbe730fcff2d7909be034cf6dc8bf0604d0bf14 Mon Sep 17 00:00:00 2001
From: Boqun Feng <boqun.feng@gmail.com>
Date: Thu, 5 Nov 2020 14:02:57 +0800
Subject: [PATCH] fs/fcntl: Fix potential deadlock in send_sig{io, urg}()

Syzbot reports a potential deadlock found by the newly added recursive
read deadlock detection in lockdep:

[...] ========================================================
[...] WARNING: possible irq lock inversion dependency detected
[...] 5.9.0-rc2-syzkaller #0 Not tainted
[...] --------------------------------------------------------
[...] syz-executor.1/10214 just changed the state of lock:
[...] ffff88811f506338 (&f->f_owner.lock){.+..}-{2:2}, at: send_sigurg+0x1d/0x200
[...] but this lock was taken by another, HARDIRQ-safe lock in the past:
[...]  (&dev->event_lock){-...}-{2:2}
[...]
[...]
[...] and interrupts could create inverse lock ordering between them.
[...]
[...]
[...] other info that might help us debug this:
[...] Chain exists of:
[...]   &dev->event_lock --> &new->fa_lock --> &f->f_owner.lock
[...]
[...]  Possible interrupt unsafe locking scenario:
[...]
[...]        CPU0                    CPU1
[...]        ----                    ----
[...]   lock(&f->f_owner.lock);
[...]                                local_irq_disable();
[...]                                lock(&dev->event_lock);
[...]                                lock(&new->fa_lock);
[...]   <Interrupt>
[...]     lock(&dev->event_lock);
[...]
[...]  *** DEADLOCK ***

The corresponding deadlock case is as followed:

	CPU 0		CPU 1		CPU 2
	read_lock(&fown->lock);
			spin_lock_irqsave(&dev->event_lock, ...)
					write_lock_irq(&filp->f_owner.lock); // wait for the lock
			read_lock(&fown-lock); // have to wait until the writer release
					       // due to the fairness
	<interrupted>
	spin_lock_irqsave(&dev->event_lock); // wait for the lock

The lock dependency on CPU 1 happens if there exists a call sequence:

	input_inject_event():
	  spin_lock_irqsave(&dev->event_lock,...);
	  input_handle_event():
	    input_pass_values():
	      input_to_handler():
	        handler->event(): // evdev_event()
	          evdev_pass_values():
	            spin_lock(&client->buffer_lock);
	            __pass_event():
	              kill_fasync():
	                kill_fasync_rcu():
	                  read_lock(&fa->fa_lock);
	                  send_sigio():
	                    read_lock(&fown->lock);

To fix this, make the reader in send_sigurg() and send_sigio() use
read_lock_irqsave() and read_lock_irqrestore().

Reported-by: syzbot+22e87cdf94021b984aa6@syzkaller.appspotmail.com
Reported-by: syzbot+c5e32344981ad9f33750@syzkaller.appspotmail.com
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 fs/fcntl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 19ac5baad50f..05b36b28f2e8 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -781,9 +781,10 @@ void send_sigio(struct fown_struct *fown, int fd, int band)
 {
 	struct task_struct *p;
 	enum pid_type type;
+	unsigned long flags;
 	struct pid *pid;
 	
-	read_lock(&fown->lock);
+	read_lock_irqsave(&fown->lock, flags);
 
 	type = fown->pid_type;
 	pid = fown->pid;
@@ -804,7 +805,7 @@ void send_sigio(struct fown_struct *fown, int fd, int band)
 		read_unlock(&tasklist_lock);
 	}
  out_unlock_fown:
-	read_unlock(&fown->lock);
+	read_unlock_irqrestore(&fown->lock, flags);
 }
 
 static void send_sigurg_to_task(struct task_struct *p,
@@ -819,9 +820,10 @@ int send_sigurg(struct fown_struct *fown)
 	struct task_struct *p;
 	enum pid_type type;
 	struct pid *pid;
+	unsigned long flags;
 	int ret = 0;
 	
-	read_lock(&fown->lock);
+	read_lock_irqsave(&fown->lock, flags);
 
 	type = fown->pid_type;
 	pid = fown->pid;
@@ -844,7 +846,7 @@ int send_sigurg(struct fown_struct *fown)
 		read_unlock(&tasklist_lock);
 	}
  out_unlock_fown:
-	read_unlock(&fown->lock);
+	read_unlock_irqrestore(&fown->lock, flags);
 	return ret;
 }
 
-- 
2.28.0

