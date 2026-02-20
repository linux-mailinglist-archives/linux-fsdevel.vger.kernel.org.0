Return-Path: <linux-fsdevel+bounces-77758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMBjH/uvl2nO5QIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 01:51:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE9116403C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 01:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C2073037E68
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 00:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462AB15539A;
	Fri, 20 Feb 2026 00:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7WtjQ1y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809D821CC58
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 00:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771548431; cv=pass; b=YoA1EOQnDczXGSvOInmj7RFh/HBVkX0dHQzFyyapj/6yb2BDlNu6FuyJyIBAZ2BHifVT3PHUCQL+o2BhqnH2typ1SVBgtwFE8qp8S/hVU8kEyF3Ip+qagg5sV0jfOHHkS48V54A3BVRTgsTVfb5VF+kk4i1M6Of36x7uAqQhmw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771548431; c=relaxed/simple;
	bh=xTt0BEA591J0c9PAsPbBiOclLC5gI9Gqua7xciXt6k0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFh3tuzb2WWxLjmpHXn5NslIUkBYSGnyVQ/hLkho45m1/JjsvZHY8vsieV2b95VLsJPBLWxJ/STlIxuHr1c5cPem5py4BpRtCjfca2hswBmyLn9W0vjUS64998U312xUfmKhsW+Ruylv59/3Pn0BtYFLrlX7KsuRGzddIvwETqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7WtjQ1y; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-503347dea84so15072081cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 16:47:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771548429; cv=none;
        d=google.com; s=arc-20240605;
        b=eYAnTVCp9yg6WYRkmdEed+JwBFa+iiTAkoO6Zzh3/rqOiYnf5fPONNY3D8K4q22lhx
         H2nZw4ojfqykETFEKjZoHwgeA4M+2/WW7KAdfB6vPb2LOKNI/6xXTkz6V8o43rY3S6Ja
         X/hI+j4icPdUp25idXgUbYzUn90l+9Kh07QDSTTfh06o5F0P5NGR5yPkwyiltP9DNXnH
         8ObSyq3aUPWL2qtcGzXeE0GOv/q9Luacy5eMMFK4EzqLhDWGoWviSOzJ7Nvdv0Fj2KO0
         CLwqroFsHxSuGIzGphbZ/airuu8X4BlFXk5cHkd6Xkl1iQlIfNnyXpqIkwQlmU9o/u5K
         riPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qzyzcE29s5UWFgF3EvqaYj8fmDA9pHKzMIVbNGFxE/w=;
        fh=LdudbleX/dDZ9es7tem4Ze+EEbBRxbX1agad7ao7/sA=;
        b=XdH0a+dm3pA8J1Kvf6LtvF6Uzsl9/vErLnq/Vd7DwjXDuTX9Dycs8HHV8Ybxoq7ioO
         bKS/2Xh0lOgMl+rX/O+yMKBXy4kXPjsKvCWmDid2of5AxvgQKK071H7ASKC1UhJ3YWVI
         zCbGcbH+3xkkw3XnBXrhYIjW/yOz3w90cnZXC/FyEjjB/3ebMHqBIl4R7g6fXdW4ZT4S
         rpxlsr55toGzU1ZWQUpn7c0QQSYuMsbGstbzjdlKHy0lE/QnWhovMYlqU3VcI5Vp1xnN
         +GSMBjUgmZ5SsaidKVjCCMeCwcOH8blCVm5gxo7YLUBv+1dj6KEJ8nZHLG+Vz/CKRDYV
         61qQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771548429; x=1772153229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzyzcE29s5UWFgF3EvqaYj8fmDA9pHKzMIVbNGFxE/w=;
        b=R7WtjQ1yuzLQI9+tfQ0XeBCOSmLUTQd0zCFh/XLDcP3tYNOpm1gYK9VVvFLFi/v7rW
         c/bWgX8U8KtchZFP5ToPdrL3thScz1SenwavPmLO2Gn9AYJRFw7P24hmmlWlge70q7Nx
         evXMLDsrupJRM4y8IUr2V888olky+5cTWtt1nq+UN3C8LzyW3oaopLXTNGGRw/244+Vr
         aPWiC7kF+Lf/EQPZBt47BrY5dVCdqcLus0PVYnU4ny7ipFYiXADGrC5BUR6FxAJioSH5
         a2djpeNWjiB3NL4Cpi3tm7ynPqx+ZTHlZ3PzHASW9jteI1IFN6RotUF/iu6cx5BM5Nhd
         cUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771548429; x=1772153229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qzyzcE29s5UWFgF3EvqaYj8fmDA9pHKzMIVbNGFxE/w=;
        b=qdur2B2zcPyS9N9VN2+ixapzXabWKZ9Nq4eR9s1c0oFmdEUcHLho3kv2NEEJTi5aQP
         DLGQoX1n0g2BwAbV0NDFcmVvuzyv1KEshpvnvkHv6OqsyjraPqrGLz6Eq37LYVSTYWu5
         XnKbD9IsRXwICTdgmA5mmvEtsFcsrXfx419LFzTD4jLFrIaehzASOvjAapoA8jpRjrr1
         AD7YkCLBgemt/Fu9GHHiN+V0LIBIx5dJ4udSaC6p6U0eHJnriqIG97G9EUq/L3px+6qr
         XV8fLfV4hhjjtZk4FRj5m3zYZpaiMsDMIs6+jqRuQSTY69nwS2JXS4qbSCvmwm5p5UII
         9rNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMhw1Rup2uSk4L7W295tsp6FACDqRvj5dvERCpS9PT35CY2GMwvcSjf4dqd+0essulIsAZ8Ya3JMA6tih7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz61HeyAN50eqQoqsvWYCYVQ0UL37/+5VDz5eC+CEvcUbdFUMwx
	1qph/T+yE+SQDO+7c/xXR6TjO6n07aNACVsDv6ENLb3iY918XWbKWS8jDpEvog7ZrSopJMaJCFt
	6PRMG5iwN91Y/rRVPFONMd3qVgDotZgE=
X-Gm-Gg: AZuq6aLH3Zbi3vlOoD1obHfakb7e+7mkgyCHdxk2FD6c7PY2Was0y6jf0RGTuHI5QqX
	l1DfjxSETfS0WsCBHiTOSNCfQ3txtmAwX5tcNsXFVljFd4DhTKrno8QrE+qFf9uqS8hbw/ZwnMg
	Uox9u+kjdTzi0TK1nELhNxqWpVke/IEyMczuqgNWCy0AR/QnPjIGLL/W8xZPdTPSoOKcXs0ieZS
	Xp1yIFEz/lGklQejP3ctTaJDK3v3k24vP2kGW39H/bcyoLw810HMkdwre7CrPDRtJpa7xGWxx+J
	EvL/6w==
X-Received: by 2002:a05:622a:1392:b0:502:f291:615e with SMTP id
 d75a77b69052e-506b40012c4mr255736501cf.52.1771548429056; Thu, 19 Feb 2026
 16:47:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6968a164.050a0220.58bed.0011.GAE@google.com> <699777ce.050a0220.b01bb.0031.GAE@google.com>
In-Reply-To: <699777ce.050a0220.b01bb.0031.GAE@google.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 19 Feb 2026 16:46:58 -0800
X-Gm-Features: AaiRm53qLMVjJECGwYdBMHzFC2E7SY8nFWKsmtIAWKtQ0mVWd43M2D_UQOVJujo
Message-ID: <CAJnrk1bk7jN8SfHny9nVWZZS6tP8bnQbMZHTCuFma6-YuMugAg@mail.gmail.com>
Subject: Re: [syzbot] [iomap?] WARNING in ifs_free
To: syzbot <syzbot+d3a62bea0e61f9d121da@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=65722f41f7edc17e];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,storage.googleapis.com:url,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_FROM(0.00)[bounces-77758-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[linux-fsdevel,d3a62bea0e61f9d121da];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: CAE9116403C
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 12:51=E2=80=AFPM syzbot
<syzbot+d3a62bea0e61f9d121da@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    2b7a25df823d Merge tag 'mm-nonmm-stable-2026-02-18-19-56'=
 ..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D10c2172258000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D65722f41f7edc=
17e
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd3a62bea0e61f9d=
121da
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25=
a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1501dc02580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1357f65258000=
0
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d=
900f083ada3/non_bootable_disk-2b7a25df.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f3a54d09b17c/vmlinu=
x-2b7a25df.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/fb704901bce5/b=
zImage-2b7a25df.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/b778b9903d=
e5/mount_0.gz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+d3a62bea0e61f9d121da@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> ifs_is_fully_uptodate(folio, ifs) !=3D folio_test_uptodate(folio)
> WARNING: fs/iomap/buffered-io.c:256 at ifs_free+0x358/0x420 fs/iomap/buff=
ered-io.c:255, CPU#0: syz-executor/5453
> Modules linked in:
> CPU: 0 UID: 0 PID: 5453 Comm: syz-executor Not tainted syzkaller #0 PREEM=
PT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2 04/01/2014
> RIP: 0010:ifs_free+0x358/0x420 fs/iomap/buffered-io.c:255
> Code: 41 5f 5d e9 7a fb bd ff e8 45 5a 5e ff 90 0f 0b 90 e9 d0 fe ff ff e=
8 37 5a 5e ff 90 0f 0b 90 e9 0a ff ff ff e8 29 5a 5e ff 90 <0f> 0b 90 eb c3=
 44 89 e1 80 e1 07 80 c1 03 38 c1 0f 8c 06 fe ff ff
> RSP: 0018:ffffc9000dfcf688 EFLAGS: 00010293
> RAX: ffffffff82674207 RBX: 0000000000000008 RCX: ffff88801f834900
> RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000000
> RBP: 000000008267bc01 R08: ffffea00010fb747 R09: 1ffffd400021f6e8
> R10: dffffc0000000000 R11: fffff9400021f6e9 R12: ffff888051c7da44
> R13: ffff888051c7da00 R14: ffffea00010fb740 R15: 1ffffd400021f6e9
> FS:  0000555586def500(0000) GS:ffff88808ca5b000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000555586e0aa28 CR3: 00000000591fe000 CR4: 0000000000352ef0
> Call Trace:
>  <TASK>
>  folio_invalidate mm/truncate.c:140 [inline]
>  truncate_cleanup_folio+0xcb/0x190 mm/truncate.c:160
>  truncate_inode_pages_range+0x2ce/0xe30 mm/truncate.c:404
>  ntfs_evict_inode+0x19/0x40 fs/ntfs3/inode.c:1861
>  evict+0x61e/0xb10 fs/inode.c:846
>  dispose_list fs/inode.c:888 [inline]
>  evict_inodes+0x75a/0x7f0 fs/inode.c:942
>  generic_shutdown_super+0xaa/0x2d0 fs/super.c:632
>  kill_block_super+0x44/0x90 fs/super.c:1725
>  ntfs3_kill_sb+0x44/0x1c0 fs/ntfs3/super.c:1889
>  deactivate_locked_super+0xbc/0x130 fs/super.c:476
>  cleanup_mnt+0x437/0x4d0 fs/namespace.c:1312
>  task_work_run+0x1d9/0x270 kernel/task_work.c:233
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
>  exit_to_user_mode_loop+0xed/0x480 kernel/entry/common.c:98
>  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline=
]
>  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [=
inline]
>  syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
>  do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fb0f859d897
> Code: a2 c7 05 5c ee 24 00 00 00 00 00 eb 96 e8 e1 12 00 00 90 31 f6 e9 0=
9 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff=
 ff 77 01 c3 48 c7 c2 e8 ff ff ff f7 d8 64 89 02 b8
> RSP: 002b:00007ffd23732b28 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> RAX: 0000000000000000 RBX: 00007fb0f8631ef0 RCX: 00007fb0f859d897
> RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd23732be0
> RBP: 00007ffd23732be0 R08: 00007ffd23733be0 R09: 00000000ffffffff
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd23733c70
> R13: 00007fb0f8631ef0 R14: 000000000001b126 R15: 00007ffd23733cb0
>  </TASK>
>

I ran the repro locally to see if it's the same issue fixed by [1] but
this is a different unrelated issue.

The folio is uptodate but the ifs uptodate bitmap is not reflected as
fully uptodate. I think this is because ntfs3 handles writes for
compressed files through its own interface that doesn't go through
iomap where it calls folio_mark_uptodate() but the ifs bitmap doesn't
get updated. fuse-blk servers that operate in writethrough mode run
into something like this as well [2].

This doesn't lead to any data corruption issues. Should we get rid of
the  WARN_ON_ONCE(ifs_is_fully_uptodate(folio, ifs) !=3D
folio_test_uptodate(folio))? The alternative is to make a modified
version of the functionality in "iomap_set_range_uptodate()" a public
api callable by subsystems.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20260219003911.344478-1-joannelko=
ong@gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/20251223223018.3295372-2-sashal@k=
ernel.org/

