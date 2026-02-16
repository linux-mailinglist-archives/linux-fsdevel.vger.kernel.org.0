Return-Path: <linux-fsdevel+bounces-77269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLr7A3jvkmkQ0QEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 11:20:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BAE14248F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 11:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E5653011BD1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 10:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000672FF67F;
	Mon, 16 Feb 2026 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Sxh5+6EB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA63B1E5B63;
	Mon, 16 Feb 2026 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771237232; cv=none; b=mnqwxdwe3KliQonQnDqorl/HDtRENr9+8Qj23O+Xkt7ed+BhUeWYL3qPGHIU8+AZI7k2qRBuLUobH2u50kAyHPruUqrlTbXgaKzYeL2/gQFUp2+BW+lvwjBd65suSgE/CXFOp4eCwSGYQo+138PWaeIJO9h0FbmzQbmw6UMKyUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771237232; c=relaxed/simple;
	bh=2wJYqdrku91INi+RENeja+Ho6307U8SKV7Yg6uybzZc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eT0S+JQSUM3U0TXlobH0C1aS72znpzlfVz05fgmaB+Jvj2WBmZUgodg9H8g8Qm8a1QZsn3uIc5+S+qONQISB/XuDxHapbwC2CiDrK0Sw37GiAWJdnrg4khwZcelPse/raMWfBExDP6ChC5Nz8OQ43ue4yo4ATqLF5eAnrdPnC8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Sxh5+6EB; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=uqxbITcBJRg/pYyUN4ghazHmNmpgFjID40ichB9M96g=; b=Sxh5+6EBBPh4VwaHWDl3AMIWKR
	NEjFc9mrzowi+TWrxeIA93Zu9N1M39mom4BUvrK+0eLCs7gykwJsUK823s2USDNWX7ZEf7VXdIAVf
	js1cJTt2cdqfDLIfDUJmn1vNni5x39sED6QiGW/YtGApejiynWCJ2yQYbt8gvKFddjsEUBSoIYSaK
	t6TK+eQSlf+C1fnBGqoYy0ML9OepyuL+VXOz9XmPG1MX33qBFLdAVjkFTd5MQcudwcX0UFthLOMgC
	rfM8n21JhiUegBPCfkgD+hArfg7ZecCDrDuhnGN7ljAuRHOo2B5UqrYvo3vecHGPR0bV3tHTo3V0E
	+2HWaHVA==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vrviE-001FeY-41; Mon, 16 Feb 2026 11:20:18 +0100
From: Luis Henriques <luis@igalia.com>
To: syzbot <syzbot+fdebb2dc960aa56c600a@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  miklos@szeredi.hu,  syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fuse?] KMSAN: uninit-value in fuse_dentry_revalidate (2)
In-Reply-To: <69917e0d.050a0220.340abe.02e2.GAE@google.com> (syzbot's message
	of "Sun, 15 Feb 2026 00:04:29 -0800")
References: <69917e0d.050a0220.340abe.02e2.GAE@google.com>
Date: Mon, 16 Feb 2026 10:20:12 +0000
Message-ID: <87a4x99ehv.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=50148b563a4d5941];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77269-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlegroups.com:email,goo.gl:url,storage.googleapis.com:url,syzkaller.appspot.com:url,wotan.olymp:mid];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luis@igalia.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	TAGGED_RCPT(0.00)[linux-fsdevel,fdebb2dc960aa56c600a];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 67BAE14248F
X-Rspamd-Action: no action

On Sun, Feb 15 2026, syzbot wrote:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    770aaedb461a Merge tag 'bootconfig-v7.0' of git://git.ker=
n..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D158f7e5a580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D50148b563a4d5=
941
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dfdebb2dc960aa56=
c600a
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25=
a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D138f7e5a580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13a5c15a580000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/24ba89b61208/dis=
k-770aaedb.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b38352aa3489/vmlinu=
x-770aaedb.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c388a7a46371/b=
zImage-770aaedb.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+fdebb2dc960aa56c600a@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in fuse_dentry_revalidate+0x150/0x13d0 fs/fuse/d=
ir.c:394

This seems to point here:

	if (entry->d_time < atomic_read(&fc->epoch))
		goto invalid;

which means that the following initialisation is missing:

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index f25ee47822ad..2ce306e35be3 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -481,6 +481,7 @@ static int fuse_dentry_init(struct dentry *dentry)
 	fd->dentry =3D dentry;
 	RB_CLEAR_NODE(&fd->node);
 	dentry->d_fsdata =3D fd;
+	dentry->d_time =3D 0;
=20
 	return 0;
 }

Or maybe should that be done in __d_alloc() instead?

Cheers,
--=20
Lu=C3=ADs

>  fuse_dentry_revalidate+0x150/0x13d0 fs/fuse/dir.c:394
>  d_revalidate fs/namei.c:1030 [inline]
>  lookup_open fs/namei.c:4405 [inline]
>  open_last_lookups fs/namei.c:4583 [inline]
>  path_openat+0x1614/0x64c0 fs/namei.c:4827
>  do_file_open+0x2aa/0x680 fs/namei.c:4859
>  do_sys_openat2+0x163/0x380 fs/open.c:1366
>  do_sys_open fs/open.c:1372 [inline]
>  __do_sys_openat fs/open.c:1388 [inline]
>  __se_sys_openat fs/open.c:1383 [inline]
>  __x64_sys_openat+0x240/0x300 fs/open.c:1383
>  x64_sys_call+0x2445/0x3ea0 arch/x86/include/generated/asm/syscalls_64.h:=
258
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x134/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Uninit was created at:
>  slab_post_alloc_hook mm/slub.c:4466 [inline]
>  slab_alloc_node mm/slub.c:4788 [inline]
>  kmem_cache_alloc_lru_noprof+0x382/0x1280 mm/slub.c:4807
>  __d_alloc+0x55/0xa00 fs/dcache.c:1740
>  d_alloc_parallel+0x99/0x2740 fs/dcache.c:2604
>  lookup_open fs/namei.c:4398 [inline]
>  open_last_lookups fs/namei.c:4583 [inline]
>  path_openat+0x135f/0x64c0 fs/namei.c:4827
>  do_file_open+0x2aa/0x680 fs/namei.c:4859
>  do_sys_openat2+0x163/0x380 fs/open.c:1366
>  do_sys_open fs/open.c:1372 [inline]
>  __do_sys_openat fs/open.c:1388 [inline]
>  __se_sys_openat fs/open.c:1383 [inline]
>  __x64_sys_openat+0x240/0x300 fs/open.c:1383
>  x64_sys_call+0x2445/0x3ea0 arch/x86/include/generated/asm/syscalls_64.h:=
258
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x134/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> CPU: 1 UID: 0 PID: 6074 Comm: syz.0.20 Not tainted syzkaller #0 PREEMPT(f=
ull)=20
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 02/12/2026
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>


