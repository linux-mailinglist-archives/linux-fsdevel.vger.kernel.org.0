Return-Path: <linux-fsdevel+bounces-70336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B5FC97759
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 14:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F303A556B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 12:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2847C30DEC8;
	Mon,  1 Dec 2025 12:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcXBY5ao"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F57F30CDB5
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764593844; cv=none; b=MlMiKnkRl4TtZyEKbH3qgEhI6jv1yT3FIlv2Qm8Nt61C554K+9Cz1JtZXvQ76U/+mEu/yybdOtQYldXpXthOMv41XYUsLSES3T3STCPQhMI6AibKt4TR0SA1IsdLrxexbgIGIqjOsYnDbwDtYkf6k2ORXwjcj8HxVb0jDJbM0Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764593844; c=relaxed/simple;
	bh=TsyQfImewlZzvXxIN3fvW8AalCnSLUSdNmzOAGRgttA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCpx/SfjR4k9sr+sfGIRyegoYQgFg9+Ep0mLlUFhdJh65NkXuDk8rv8h5icoK942hXeVJbh0KR99LGCmAa/gwgfpsfeh7HqAeUZSsdGm6W9B9KVvEfR8PYsX2D6xsJcMG6YeXnZWIzKIVyPfhcb4xrchm+T67qDCB1nMHdzcpjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcXBY5ao; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b72b495aa81so534895266b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 04:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764593841; x=1765198641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rRplsCJcv+FAE90457EMSSOT+eZy+in9RL4M+DLen00=;
        b=AcXBY5aozxDNG1+R5NkXcpeYguOLOI2kR1HxqCQ61ZIeaPhuxEep1YvLiSYQoBZv+A
         1I0AmmVDIjA26MjJdd3zZz9vUS4W0aaheqAgSahczmm2d2h/IoyxtJoQU8YZv2Yxvnmf
         wtmAlItMcPS+FAAUoVC4rzzR7auQhPGs/1k4v9l1OTA0Oxw1QJbuUYzBrXqbtgcQ+L8P
         j6sqecCd8ox4i5PfKhdKSwZRrjClhGqy+DgburlbUGNQOCDdtIRNlR44hGcd71wAPxLg
         052d2BvQSXh0OpM+s8FEb6/0wxcYYRBMHf1/eN/bgUjBd2MueEfj2IU1SU8GSSvlkHUj
         j/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764593841; x=1765198641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRplsCJcv+FAE90457EMSSOT+eZy+in9RL4M+DLen00=;
        b=IWE++JBmyy5W6Vr5EIcgGrkZgRj390kEsP4C5fNeOJnmImEJmmmKryV9T8qqyfXugr
         qg0PCVR6bkTl/pZ5gvYoYnJBZOPuy6t5vrXwfB1YPoTP6sN66uiOE7osNET6MbtN/+5o
         DKozKTHkLVd9kpzj9X9XWDXcWhYwgIg6nVEjpcbbKOPUG7YWU6fqB2JOu86WK4G1LMyn
         KepKxhD4eqDavLMpfBgg6P1UEvprCOox58+WqvhRLMWcZGIxLcd1Oc7ZiZ83HDOOWJUF
         Tx3XQ6YU+D56tBT75n71fKPQYUvyFTkFO2M3lLBqQuLJEi+A+DMeFHOGvZhCTsM9fT9h
         bgjA==
X-Forwarded-Encrypted: i=1; AJvYcCWK6fHmAxHnYX6YObHbbBzY0yTSd1USGOGWmoO41DZCJB7FTYpffgJV2legY4s0xHzG/lZCpf+XQd6aiqjl@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1E9MOZw8I8q0W6e7rtrKBhTeh1UcrLZClsS357oZ8RTz85CUg
	08i1rgmfaZmxoIMsFvvd1hALt9IUB70j9FUOvUI/lpNvFupYjIHJjnXK
X-Gm-Gg: ASbGncvcjnXVUCmNHetkLDoBpyrjKlrHxKbIajUzqEiCVNb6NWA1vL/YudpCkkH8tpV
	+HfYDmtRTrYMSMWpQRPkYKiLrG8AFaTlFgXYUf+rG8RREqViqqRl2u7VCfletSj5hRK0S+3VgsI
	9MaFE6CZpWAwZ3dDYAp6rZsdbwgPbTILhOWvbjOn/tFuVeb+ushfc2oltaY2Ts6/R/PV6Uc6cXP
	OzZiFCTfAYOlY0SAPVuZvR/G6Gg8aXM8za6qnKNWiOePqZkWIe3hcHuOWKBfRGv9XQXxgfu6aD5
	oj+OWn4mRw1scfEJTW3n8IVsEFN4MU1UHprfTpLk7yW4vgJVXgNgHs0eXwFOTDsbOtZhCY3OrlF
	nXHWLyw1fo00Ch+lkhWxn2Lv/3jBsZE4rr+E3qB1ae+SeF/WY2ZtnIWf64CGSLHebXSLnA/GdO6
	rRO+pKValVVJ6r7qkILeEeWDkoqy79gJwQ3mo5B/SlZb42W4aa/JPfvg5i
X-Google-Smtp-Source: AGHT+IGQSKV7XDsxhHghW9C1Z08jO3+IEbxQRZnUdRk1hGLZaVxLC75FqNlmkaP6Die0iVj/0iVlxg==
X-Received: by 2002:a17:907:7e8f:b0:b72:134a:48c8 with SMTP id a640c23a62f3a-b76c53bff9emr2746108066b.14.1764593840461;
        Mon, 01 Dec 2025 04:57:20 -0800 (PST)
Received: from f (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f59a6a67sm1198587566b.34.2025.12.01.04.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 04:57:19 -0800 (PST)
Date: Mon, 1 Dec 2025 13:57:11 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: syzbot <syzbot+984a5c208d87765b2ee7@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] kernel BUG in sctp_getsockopt_peeloff_common
Message-ID: <cenhvze4xmjyddtovfr36c767ttt2dgbprtr4zef6n7wrkgrze@mnzax7kfeegk>
References: <692d66d3.a70a0220.2ea503.00b2.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <692d66d3.a70a0220.2ea503.00b2.GAE@google.com>

On Mon, Dec 01, 2025 at 01:58:43AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7d31f578f323 Add linux-next specific files for 20251128
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=156402b4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6336d8e94a7c517d
> dashboard link: https://syzkaller.appspot.com/bug?extid=984a5c208d87765b2ee7
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a2322c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a3c512580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6b49d8ad90de/disk-7d31f578.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/dbe2d4988ca7/vmlinux-7d31f578.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/fc0448ab2411/bzImage-7d31f578.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+984a5c208d87765b2ee7@syzkaller.appspotmail.com
> 
> R10: 0000200000000340 R11: 0000000000000246 R12: 0000000000000002
> R13: 00007f49009e5fa0 R14: 00007f49009e5fa0 R15: 0000000000000005
>  </TASK>
> VFS_BUG_ON_INODE(inode_state_read_once(inode) & I_CLEAR) encountered for inode ffff88805d116e00
> fs sockfs mode 140777 opflags 0xc flags 0x0 state 0x300 count 0
> ------------[ cut here ]------------
> kernel BUG at fs/inode.c:1971!
> Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
> CPU: 0 UID: 0 PID: 5997 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> RIP: 0010:iput+0xfc9/0x1030 fs/inode.c:1971
> Code: 8b 7c 24 18 48 c7 c6 e0 f2 79 8b e8 51 f8 e6 fe 90 0f 0b e8 a9 6f 80 ff 48 8b 7c 24 18 48 c7 c6 80 f2 79 8b e8 38 f8 e6 fe 90 <0f> 0b 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c cd fb ff ff 4c 89 ef
> RSP: 0018:ffffc90003987b18 EFLAGS: 00010282
> RAX: 000000000000009f RBX: dffffc0000000000 RCX: e99d72d115a78d00
> RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> RBP: 1ffffffff1ed7c72 R08: ffffc900039877c7 R09: 1ffff92000730ef8
> R10: dffffc0000000000 R11: fffff52000730ef9 R12: 1ffff1100ba22e00
> R13: ffff88805d117000 R14: 0000000000000200 R15: 1ffffffff1f02c74
> FS:  000055557d588500(0000) GS:ffff888125e4f000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000200000000200 CR3: 0000000074b6e000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  sctp_getsockopt_peeloff_common+0x6b7/0x8a0 net/sctp/socket.c:5733
>  sctp_getsockopt_peeloff_flags+0x102/0x140 net/sctp/socket.c:5779
>  sctp_getsockopt+0x3a5/0xb90 net/sctp/socket.c:8111
>  do_sock_getsockopt+0x2b4/0x3d0 net/socket.c:2389
>  __sys_getsockopt net/socket.c:2418 [inline]
>  __do_sys_getsockopt net/socket.c:2425 [inline]
>  __se_sys_getsockopt net/socket.c:2422 [inline]
>  __x64_sys_getsockopt+0x1a5/0x250 net/socket.c:2422
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f490078f749


The inode is I_FREEING | I_CLEAR.

I suspect this is botched error handling in the recent conversion to
FD_PREPARE machinery.

#syz test

diff --git b/net/sctp/socket.c a/net/sctp/socket.c
index 1e59ac734f91..ed8293a34240 100644
--- b/net/sctp/socket.c
+++ a/net/sctp/socket.c
@@ -5664,45 +5664,47 @@ static int sctp_do_peeloff(struct sock *sk, sctp_assoc_t id,
 	return err;
 }
 
-static int sctp_getsockopt_peeloff_common(struct sock *sk,
-					  sctp_peeloff_arg_t *peeloff, int len,
-					  char __user *optval,
-					  int __user *optlen, unsigned flags)
+static int sctp_getsockopt_peeloff_common(struct sock *sk, sctp_peeloff_arg_t *peeloff,
+					  struct file **newfile, unsigned flags)
 {
 	struct socket *newsock;
 	int retval;
 
 	retval = sctp_do_peeloff(sk, peeloff->associd, &newsock);
 	if (retval < 0)
-		return retval;
+		goto out;
 
-	FD_PREPARE(fdf, flags & SOCK_CLOEXEC, sock_alloc_file(newsock, 0, NULL));
-	if (fdf.err) {
+	/* Map the socket to an unused fd that can be returned to the user.  */
+	retval = get_unused_fd_flags(flags & SOCK_CLOEXEC);
+	if (retval < 0) {
 		sock_release(newsock);
-		return fdf.err;
+		goto out;
 	}
 
-	pr_debug("%s: sk:%p, newsk:%p, sd:%d\n", __func__, sk, newsock->sk,
-		 fd_prepare_fd(fdf));
-
-	if (flags & SOCK_NONBLOCK)
-		fd_prepare_file(fdf)->f_flags |= O_NONBLOCK;
+	*newfile = sock_alloc_file(newsock, 0, NULL);
+	if (IS_ERR(*newfile)) {
+		put_unused_fd(retval);
+		retval = PTR_ERR(*newfile);
+		*newfile = NULL;
+		return retval;
+	}
 
-	/* Return the fd mapped to the new socket.  */
-	if (put_user(len, optlen))
-		return -EFAULT;
+	pr_debug("%s: sk:%p, newsk:%p, sd:%d\n", __func__, sk, newsock->sk,
+		 retval);
 
-	peeloff->sd = fd_prepare_fd(fdf);
-	if (copy_to_user(optval, peeloff, len))
-		return -EFAULT;
+	peeloff->sd = retval;
 
-	return fd_publish(fdf);
+	if (flags & SOCK_NONBLOCK)
+		(*newfile)->f_flags |= O_NONBLOCK;
+out:
+	return retval;
 }
 
-static int sctp_getsockopt_peeloff(struct sock *sk, int len,
-				   char __user *optval, int __user *optlen)
+static int sctp_getsockopt_peeloff(struct sock *sk, int len, char __user *optval, int __user *optlen)
 {
 	sctp_peeloff_arg_t peeloff;
+	struct file *newfile = NULL;
+	int retval = 0;
 
 	if (len < sizeof(sctp_peeloff_arg_t))
 		return -EINVAL;
@@ -5710,13 +5712,33 @@ static int sctp_getsockopt_peeloff(struct sock *sk, int len,
 	if (copy_from_user(&peeloff, optval, len))
 		return -EFAULT;
 
-	return sctp_getsockopt_peeloff_common(sk, &peeloff, len, optval, optlen, 0);
+	retval = sctp_getsockopt_peeloff_common(sk, &peeloff, &newfile, 0);
+	if (retval < 0)
+		goto out;
+
+	/* Return the fd mapped to the new socket.  */
+	if (put_user(len, optlen)) {
+		fput(newfile);
+		put_unused_fd(retval);
+		return -EFAULT;
+	}
+
+	if (copy_to_user(optval, &peeloff, len)) {
+		fput(newfile);
+		put_unused_fd(retval);
+		return -EFAULT;
+	}
+	fd_install(retval, newfile);
+out:
+	return retval;
 }
 
 static int sctp_getsockopt_peeloff_flags(struct sock *sk, int len,
 					 char __user *optval, int __user *optlen)
 {
 	sctp_peeloff_flags_arg_t peeloff;
+	struct file *newfile = NULL;
+	int retval = 0;
 
 	if (len < sizeof(sctp_peeloff_flags_arg_t))
 		return -EINVAL;
@@ -5724,8 +5746,26 @@ static int sctp_getsockopt_peeloff_flags(struct sock *sk, int len,
 	if (copy_from_user(&peeloff, optval, len))
 		return -EFAULT;
 
-	return sctp_getsockopt_peeloff_common(sk, &peeloff.p_arg, len, optval,
-					      optlen, peeloff.flags);
+	retval = sctp_getsockopt_peeloff_common(sk, &peeloff.p_arg,
+						&newfile, peeloff.flags);
+	if (retval < 0)
+		goto out;
+
+	/* Return the fd mapped to the new socket.  */
+	if (put_user(len, optlen)) {
+		fput(newfile);
+		put_unused_fd(retval);
+		return -EFAULT;
+	}
+
+	if (copy_to_user(optval, &peeloff, len)) {
+		fput(newfile);
+		put_unused_fd(retval);
+		return -EFAULT;
+	}
+	fd_install(retval, newfile);
+out:
+	return retval;
 }
 
 /* 7.1.13 Peer Address Parameters (SCTP_PEER_ADDR_PARAMS)

