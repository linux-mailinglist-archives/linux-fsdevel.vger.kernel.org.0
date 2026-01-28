Return-Path: <linux-fsdevel+bounces-75792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OE45J7tXeml55QEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 19:38:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F09BBA7D23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 19:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96946304F4C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 18:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B80372B25;
	Wed, 28 Jan 2026 18:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFowL85w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3044B25A2B4
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 18:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769625465; cv=pass; b=sc9B2A/AbKihJ23+QmSy8VWGfTBDIs57LmXCvWph271SyvBFKzZDfNov3GdnG9HrJw26unva+fESSQvwjSK05M0Cf5ppRUbgeru+CDX+IMCHMnlx+PZ2MLB+97rUJk1GxcV+5TuYh0jcjnO0FH/WB/ghu9fZAaOdy9c2iCqshNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769625465; c=relaxed/simple;
	bh=NE1HNtdajw3PZ65AJS6b5v1t/86GYJKPgN3reSGXbqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rpvgB0QykW4+V93YryD4BzGWXrz05Rw+R+CSCG/tKGxhUPpbzl1VbUPcdZP+bcaThS2ZIjqW9qJoWx5igamQJFZCc6XM8uZr/RpMa2+HSy+bEombC+dMRnAadYY0clRDuvWGADm1zd/J25U4BHol/6wFKOoYJWRvAHQxLQE9tT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFowL85w; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b71515d8adso177310eec.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 10:37:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769625462; cv=none;
        d=google.com; s=arc-20240605;
        b=b1F0JMkUAeb2jCvKhMazVgyFgGiN+urUPC6n+SffOr6gXNMTN23LT9iu4KP0h4Q7a1
         1LaanNx+WdLrsyQEQ32Sh+T3LW8F1Bd6KHj8l48CMkg4DD8tdY5gYDwnE/5cGbNxz2xY
         FRjBACDUuYmfgHG/xomP4aYV1iigpsQNoYPa/Y0kNGOuBc7L2IZnou7Pvajqqeleub7l
         MuQEXbDAO5JQr+1wtVBX1TW94Mdp3KBBAv0vM1Ut4e2q8bfjADAgRXMvEj+FeuI7s05b
         4gG643hhiBy95OLZNxNMJYqS+S01mrNYq6Y/4Sw+vsc7FREXWljBxwU9Af+Cmgf+zv1u
         3YSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bSH1dZX6DZLgay+OSBrfqyH+pZ23DhAOVGi8FB7k6gU=;
        fh=sqg9u+lHr5s3NA1vTPh1hF4wg6Nrxv5fA/7aaooFja0=;
        b=JO8vBknC6iS2yCZ9Y5+gPw+jtvP44+tVX/0MEJ+Y/c5yp7HCqjKsTCsU9+OHlGxcm3
         Wc9/8Cj7+kYgeo2+XvNKwyy6H98DX6jyi7pVfMcZWl8ZizazOShCSwE20cVMOtLA8vyu
         80zIsVE07iuJUBV1iiLg0Sv3B6KFUoTEeL2/yho5y2DKZF6CpExORpRb777GnFY5FjGY
         M1lBgS/lNGlEf45qm9o3Nqd3WyXn1hSSHYi7NFQtR5RZ+fMI+vKFiN0WIAqbxlgAHYuQ
         P+0VLq1VAfTBHSSeKcnFIMQLMJVJPsZ8LmKCPCI7+vfN3hHJK88Ekl7GMXbx0u5yDwor
         V06w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769625462; x=1770230262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSH1dZX6DZLgay+OSBrfqyH+pZ23DhAOVGi8FB7k6gU=;
        b=RFowL85wwgApjmhfNAWMtSeVT5k/YrYw0NBwzktu/08BxFVzWCQeEcm16SWaQMzo94
         ApAHfPpAEo5bBNxkJYmkL8D6Hdm9iZfXNkRGpqP1aAWZToE2ODmxV2EW6KifjQyCf4UJ
         ob4f7/K39jTfWEYSMM5Ds0EChQmt7oGPRDa5OdQudszbgVdcvdL86k9xWQn8Iim/wp7M
         WcwdQtLxud5wNR6vgM/rzagHNp4zqJ7qaPPgT0xFXREYLMoAhwNcIVDeCYj0pwpKXSZa
         +vk9jdd7WiRmYiTzVYmNVjZ7DW4x5pvGJEVog9RApwno3AahpvZIDNlrPy535HcRYfAu
         f/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769625462; x=1770230262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bSH1dZX6DZLgay+OSBrfqyH+pZ23DhAOVGi8FB7k6gU=;
        b=nBFayTBfnGpEURh+vmoLw3MC1f2t5vFB3hSJaHkmcDxVTwEmdlMKEByheLTrSyyW9s
         a1pNqUw9yE4rR3H7+3JPUeU0STG0tvQYZWXR01DVaxCT+DifJwK1c3Ox2iGcRkxoB4zl
         DCt/jtTw94jLiz8QuCp6j1w5OgInc9kqMTnVD1y0em6FdSFTULotZyE3+q9En0SIvm4m
         M9q2kh8Wyg8skBPVd7g9sykIUC3UHCswsLxWhQL3Dj3fRjdtsn9nbbEX9HSI127U+pJR
         /FjtUZfMx1eF6ztAzki/AyOMvv4U6z2/cWpQAjBaqhZ4CA0QkKOWHZv5crl6NEA7a+v3
         sskw==
X-Forwarded-Encrypted: i=1; AJvYcCWDx0ZatPNU0XsVbNAdURT2kM0B9R0JwkCadHl8W7v9WApR/E0lzdoLg99lkQ/k03E/ZXzkfgGD6FD8zkLJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2dANDBgZ2T4rp/ZKWW/VBaunzRlDHC+SNcuJeEWE55YR3bthm
	PjED2zeD9nfQzsoV8T0nM/zqBkqlaGWVQildEN3zEIp2xWuhJD5cBH6keEK1c7OC+72msrFOPwp
	VuAUk1bWMWI8a7E7mB/MwPe3YzV4ebBU=
X-Gm-Gg: AZuq6aIHRE1WQGA7GpFuQEwSTmprX9LR8jtL4e21AlMkTM44LlqV+aWi/XxL2eYc3Ny
	nSz3ezLWg/FY//1iCQ1zYfbsHZ+N36KW5jc1uPpOJzD+atqSoau9sJLHAi4s0s2dT9CE69r+bMI
	M0meReMN/1ReWYfuRKAr2T5f4FOkgnxPwdvmkhHRlSs9aTKrkfJkvBZnh2iH6q6I48IEgOqm1/f
	AztQgJVkd+mk8dFqklC8DYV4kbJECXqeLZCUYd0RimczIyLylQI0PUVSuD5hoCjtZuXlRg=
X-Received: by 2002:a05:693c:6201:b0:2b7:9907:6671 with SMTP id
 5a478bee46e88-2b799077116mr2399539eec.7.1769625461977; Wed, 28 Jan 2026
 10:37:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114195524.1025067-2-slava@dubeyko.com> <CAOi1vP8CwX5T_R4gdZ0egg2oxCwFGAvoi6Us2k4=QFKmtqHmjQ@mail.gmail.com>
 <3e4c420c7dd63ac3ecd0c9c21aea4f75784eada4.camel@redhat.com>
In-Reply-To: <3e4c420c7dd63ac3ecd0c9c21aea4f75784eada4.camel@redhat.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 28 Jan 2026 19:37:30 +0100
X-Gm-Features: AZwV_Qgeq9JVOlI_tnf86AnTKoGEwhUJoFh1Z4mKqPsbPv2jSLV3a7azwof74Dw
Message-ID: <CAOi1vP-CAYAKykctYWAQNab7tU93nQQwnobBn3pJw+ZqUJCh7A@mail.gmail.com>
Subject: Re: [PATCH v5] ceph: fix kernel crash in ceph_open()
To: Viacheslav Dubeyko <vdubeyko@redhat.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, pdonnell@redhat.com, 
	linux-fsdevel@vger.kernel.org, amarkuze@redhat.com, khiremat@redhat.com, 
	Pavan.Rallabhandi@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-75792-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idryomov@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F09BBA7D23
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 9:18=E2=80=AFPM Viacheslav Dubeyko <vdubeyko@redhat=
.com> wrote:
>
> On Mon, 2026-01-26 at 13:35 +0100, Ilya Dryomov wrote:
> > On Wed, Jan 14, 2026 at 8:56=E2=80=AFPM Viacheslav Dubeyko <slava@dubey=
ko.com> wrote:
> > >
> > > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > >
> > > The CephFS kernel client has regression starting from 6.18-rc1.
> > >
> > > sudo ./check -g quick
> > > FSTYP         -- ceph
> > > PLATFORM      -- Linux/x86_64 ceph-0005 6.18.0-rc5+ #52 SMP PREEMPT_D=
YNAMIC Fri
> > > Nov 14 11:26:14 PST 2025
> > > MKFS_OPTIONS  -- 192.168.1.213:3300:/scratch
> > > MOUNT_OPTIONS -- -o name=3Dadmin,ms_mode=3Dsecure 192.168.1.213:3300:=
/scratch
> > > /mnt/cephfs/scratch
> > >
> > > Killed
> > >
> > > Nov 14 11:48:10 ceph-0005 kernel: [  154.723902] libceph: mon0
> > > (2)192.168.1.213:3300 session established
> > > Nov 14 11:48:10 ceph-0005 kernel: [  154.727225] libceph: client16761=
6
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.087260] BUG: kernel NULL poi=
nter
> > > dereference, address: 0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.087756] #PF: supervisor read=
 access in
> > > kernel mode
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.088043] #PF: error_code(0x00=
00) - not-
> > > present page
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.088302] PGD 0 P4D 0
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.088688] Oops: Oops: 0000 [#1=
] SMP KASAN
> > > NOPTI
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.090080] CPU: 4 UID: 0 PID: 3=
453 Comm:
> > > xfs_io Not tainted 6.18.0-rc5+ #52 PREEMPT(voluntary)
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.091245] Hardware name: QEMU =
Standard PC
> > > (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.092103] RIP: 0010:strcmp+0x1=
c/0x40
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.092493] Code: 90 90 90 90 90=
 90 90 90
> > > 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 =
83 c0 01 84
> > > d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 f=
f c3 cc cc
> > > cc cc 31
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.094057] RSP: 0018:ffff888153=
6875c0
> > > EFLAGS: 00010246
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.094522] RAX: 000000000000000=
0 RBX:
> > > ffff888116003200 RCX: 0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.095114] RDX: 000000000000006=
3 RSI:
> > > 0000000000000000 RDI: ffff88810126c900
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.095714] RBP: ffff8881536876a=
8 R08:
> > > 0000000000000000 R09: 0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.096297] R10: 000000000000000=
0 R11:
> > > 0000000000000000 R12: dffffc0000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.096889] R13: ffff8881061d000=
0 R14:
> > > 0000000000000000 R15: 0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.097490] FS:  000074a85c08284=
0(0000)
> > > GS:ffff8882401a4000(0000) knlGS:0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.098146] CS:  0010 DS: 0000 E=
S: 0000
> > > CR0: 0000000080050033
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.098630] CR2: 000000000000000=
0 CR3:
> > > 0000000110ebd001 CR4: 0000000000772ef0
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099219] PKRU: 55555554
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099476] Call Trace:
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099686]  <TASK>
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099873]  ?
> > > ceph_mds_check_access+0x348/0x1760
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.100267]  ?
> > > __kasan_check_write+0x14/0x30
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.100671]  ? lockref_get+0xb1/=
0x170
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.100979]  ?
> > > __pfx__raw_spin_lock+0x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.101372]  ceph_open+0x322/0xe=
f0
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.101669]  ? __pfx_ceph_open+0=
x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.101996]  ?
> > > __pfx_apparmor_file_open+0x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.102434]  ?
> > > __ceph_caps_issued_mask_metric+0xd6/0x180
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.102911]  do_dentry_open+0x7b=
f/0x10e0
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103249]  ? __pfx_ceph_open+0=
x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103508]  vfs_open+0x6d/0x450
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103697]  ? may_open+0xec/0x3=
70
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103893]  path_openat+0x2017/=
0x50a0
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104110]  ? __pfx_path_openat=
+0x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104345]  ?
> > > __pfx_stack_trace_save+0x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104599]  ?
> > > stack_depot_save_flags+0x28/0x8f0
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104865]  ? stack_depot_save+=
0xe/0x20
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105063]  do_filp_open+0x1b4/=
0x450
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105253]  ?
> > > __pfx__raw_spin_lock_irqsave+0x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105538]  ? __pfx_do_filp_ope=
n+0x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105748]  ? __link_object+0x1=
3d/0x2b0
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105949]  ?
> > > __pfx__raw_spin_lock+0x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106169]  ?
> > > __check_object_size+0x453/0x600
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106428]  ? _raw_spin_unlock+=
0xe/0x40
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106635]  do_sys_openat2+0xe6=
/0x180
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106827]  ?
> > > __pfx_do_sys_openat2+0x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107052]  __x64_sys_openat+0x=
108/0x240
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107258]  ?
> > > __pfx___x64_sys_openat+0x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107529]  ?
> > > __pfx___handle_mm_fault+0x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107783]  x64_sys_call+0x134f=
/0x2350
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108007]  do_syscall_64+0x82/=
0xd50
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108201]  ?
> > > fpregs_assert_state_consistent+0x5c/0x100
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108467]  ? do_syscall_64+0xb=
a/0xd50
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108626]  ? __kasan_check_rea=
d+0x11/0x20
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108801]  ?
> > > count_memcg_events+0x25b/0x400
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109013]  ? handle_mm_fault+0=
x38b/0x6a0
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109216]  ? __kasan_check_rea=
d+0x11/0x20
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109457]  ?
> > > fpregs_assert_state_consistent+0x5c/0x100
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109724]  ?
> > > irqentry_exit_to_user_mode+0x2e/0x2a0
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109991]  ? irqentry_exit+0x4=
3/0x50
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110180]  ? exc_page_fault+0x=
95/0x100
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110389]
> > > entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110638] RIP: 0033:0x74a85bf1=
45ab
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110821] Code: 25 00 00 41 00=
 3d 00 00
> > > 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf =
9c ff ff ff
> > > b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 54 2=
4 28 64 48
> > > 2b 14 25
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.111724] RSP: 002b:00007ffc77=
d316d0
> > > EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.112080] RAX: ffffffffffffffd=
a RBX:
> > > 0000000000000002 RCX: 000074a85bf145ab
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.112442] RDX: 000000000000000=
0 RSI:
> > > 00007ffc77d32789 RDI: 00000000ffffff9c
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.112790] RBP: 00007ffc77d3278=
9 R08:
> > > 00007ffc77d31980 R09: 0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113125] R10: 000000000000000=
0 R11:
> > > 0000000000000246 R12: 0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113502] R13: 00000000fffffff=
f R14:
> > > 0000000000000180 R15: 0000000000000001
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113838]  </TASK>
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113957] Modules linked in:
> > > intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_=
pmc_core
> > > pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel=
_vsec
> > > kvm_intel kvm joydev irqbypass polyval_clmulni ghash_clmulni_intel ae=
sni_intel
> > > rapl floppy input_leds psmouse i2c_piix4 vga16fb mac_hid i2c_smbus vg=
astate
> > > serio_raw bochs qemu_fw_cfg pata_acpi sch_fq_codel rbd msr parport_pc=
 ppdev lp
> > > parport efi_pstore
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.116339] CR2: 000000000000000=
0
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.116574] ---[ end trace 00000=
00000000000
> > > ]---
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.116826] RIP: 0010:strcmp+0x1=
c/0x40
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.117058] Code: 90 90 90 90 90=
 90 90 90
> > > 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 =
83 c0 01 84
> > > d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 f=
f c3 cc cc
> > > cc cc 31
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.118070] RSP: 0018:ffff888153=
6875c0
> > > EFLAGS: 00010246
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.118362] RAX: 000000000000000=
0 RBX:
> > > ffff888116003200 RCX: 0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.118748] RDX: 000000000000006=
3 RSI:
> > > 0000000000000000 RDI: ffff88810126c900
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.119116] RBP: ffff8881536876a=
8 R08:
> > > 0000000000000000 R09: 0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.119492] R10: 000000000000000=
0 R11:
> > > 0000000000000000 R12: dffffc0000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.119865] R13: ffff8881061d000=
0 R14:
> > > 0000000000000000 R15: 0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.120242] FS:  000074a85c08284=
0(0000)
> > > GS:ffff8882401a4000(0000) knlGS:0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.120704] CS:  0010 DS: 0000 E=
S: 0000
> > > CR0: 0000000080050033
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.121008] CR2: 000000000000000=
0 CR3:
> > > 0000000110ebd001 CR4: 0000000000772ef0
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.121409] PKRU: 55555554
> > >
> > > We have issue here [1] if fs_name =3D=3D NULL:
> > >
> > > const char fs_name =3D mdsc->fsc->mount_options->mds_namespace;
> > >     ...
> > >     if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_name)) =
{
> > >             / fsname mismatch, try next one */
> > >             return 0;
> > >     }
> > >
> > > v2
> > > Patrick Donnelly suggested that: In summary, we should definitely sta=
rt
> > > decoding `fs_name` from the MDSMap and do strict authorizations check=
s
> > > against it. Note that the `--mds_namespace` should only be used for
> > > selecting the file system to mount and nothing else. It's possible
> > > no mds_namespace is specified but the kernel will mount the only
> > > file system that exists which may have name "foo".
> > >
> > > v3
> > > The namespace_equals() logic has been generalized into
> > > __namespace_equals() with the goal of using it in
> > > ceph_mdsc_handle_fsmap() and ceph_mds_auth_match().
> > > The misspelling of CEPH_NAMESPACE_WILDCARD has been corrected.
> > >
> > > v4
> > > The __namespace_equals() now supports wildcard check.
> > >
> > > v5
> > > Patrick Donnelly suggested to add the sanity check of
> > > kstrdup() returned pointer in ceph_mdsmap_decode()
> > > added logic. Also, he suggested much simpler logic of
> > > namespace strings comparison in the form of
> > > ceph_namespace_match() logic.
> > >
> > > This patch reworks ceph_mdsmap_decode() and namespace_equals() with
> > > the goal of supporting the suggested concept. Now struct ceph_mdsmap
> > > contains m_fs_name field that receives copy of extracted FS name
> > > by ceph_extract_encoded_string(). For the case of "old" CephFS file s=
ystems,
> > > it is used "cephfs" name. Also, namespace_equals() method has been
> > > reworked with the goal of proper names comparison.
> > >
> > > [1] https://elixir.bootlin.com/linux/v6.18-rc4/source/fs/ceph/mds_cli=
ent.c#L5666
> > > [2] https://tracker.ceph.com/issues/73886
> > >
> > > Fixes: 22c73d52a6d0 ("ceph: fix multifs mds auth caps issue")
> > > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > > cc: Kotresh Hiremath Ravishankar <khiremat@redhat.com>
> > > cc: Alex Markuze <amarkuze@redhat.com>
> > > cc: Ilya Dryomov <idryomov@gmail.com>
> > > cc: Patrick Donnelly <pdonnell@redhat.com>
> > > cc: Ceph Development <ceph-devel@vger.kernel.org>
> > > ---
> > >  fs/ceph/mds_client.c         | 11 +++++------
> > >  fs/ceph/mdsmap.c             | 24 ++++++++++++++++++------
> > >  fs/ceph/mdsmap.h             |  1 +
> > >  fs/ceph/super.h              | 24 +++++++++++++++++++-----
> > >  include/linux/ceph/ceph_fs.h |  6 ++++++
> > >  5 files changed, 49 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > > index 7e4eab824dae..703c14bc3c95 100644
> > > --- a/fs/ceph/mds_client.c
> > > +++ b/fs/ceph/mds_client.c
> > > @@ -5671,7 +5671,7 @@ static int ceph_mds_auth_match(struct ceph_mds_=
client *mdsc,
> > >         u32 caller_uid =3D from_kuid(&init_user_ns, cred->fsuid);
> > >         u32 caller_gid =3D from_kgid(&init_user_ns, cred->fsgid);
> > >         struct ceph_client *cl =3D mdsc->fsc->client;
> > > -       const char *fs_name =3D mdsc->fsc->mount_options->mds_namespa=
ce;
> > > +       const char *fs_name =3D mdsc->mdsmap->m_fs_name;
> > >         const char *spath =3D mdsc->fsc->mount_options->server_path;
> > >         bool gid_matched =3D false;
> > >         u32 gid, tlen, len;
> > > @@ -5679,7 +5679,8 @@ static int ceph_mds_auth_match(struct ceph_mds_=
client *mdsc,
> > >
> > >         doutc(cl, "fsname check fs_name=3D%s  match.fs_name=3D%s\n",
> > >               fs_name, auth->match.fs_name ? auth->match.fs_name : ""=
);
> > > -       if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_nam=
e)) {
> > > +
> > > +       if (!ceph_namespace_match(auth->match.fs_name, fs_name, NAME_=
MAX)) {
> >
> > Hi Slava,
> >
> > How was this tested?  In particular, do you have a test case covering
> > an MDS auth cap that specifies a particular fs_name (i.e. one where
> > auth->match.fs_name wouldn't be NULL or CEPH_NAMESPACE_WILDCARD)?
> >
> > I'm asking because it looks like ceph_namespace_match() would always
> > declare a mismatch in that scenario due to the fact that NAME_MAX is
> > passed for target_len and
> >
> >     if (strlen(pattern) !=3D target_len)
> >             return false;
> >
> > condition inside of ceph_namespace_match().  This in turn means that
> > ceph_mds_check_access() would disregard the respective cap and might
> > allow access where it's supposed to be denied.
> >
> >
>
> I have run the xfstests (quick group) with the patch applied. I didn't se=
e any
> unusual behavior. If we believe that these tests are not enough, then, ma=
ybe, we
> need to introduce the additional Ceph specialized tests.

I'd expect that the manual steps quoted in commit 22c73d52a6d0 ("ceph:
fix multifs mds auth caps issue") as well the automated tests added in
https://github.com/ceph/ceph/pull/64550 would be run, at the very least.

On top of that I'd recommend devising some ad-hoc test cases for
CEPH_NAMESPACE_WILDCARD and mds_namespace mount option handling as that
has been a recurrent source of problems throughout all postings.

"./check -g quick" barely scratches the surface on any of this...

Thanks,

                Ilya

