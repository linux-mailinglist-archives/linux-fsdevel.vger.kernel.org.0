Return-Path: <linux-fsdevel+bounces-75465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEwuJBpmd2nCfQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 14:03:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1853F888D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 14:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DCA1304C96C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 13:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEBE337B99;
	Mon, 26 Jan 2026 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jqp7Bx+m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812EC3375AE
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769432516; cv=pass; b=FFw3cfszpt2FcKRPMHZaen6XG0hnTrk2Thfd36iy8CaIkWaLrxjM0wJDLvutxIT92+NjJVk3VvIQ/tzGwZMb0jsAM4355WoyC45gWgrTPpjbzwbO2O17P+sVrn8Tt6pWZR9Ikn/qus9LUcFm3+TFS9fyh3UhqhAF4oQp5+Nymxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769432516; c=relaxed/simple;
	bh=qaCLsbWGIDsR3Grsx/hSZLgYnuinRIZL+p1IvL8ow30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bYm4UVc4tXSObjvOprsp0q2ymVtW1SkifCmibOUvSVLlSJc29k9Sg+CMqwH16tKGh0h7AZ87xaLYkG2iK7A03SxXLHk6JcjLKOYJcyQwcLFLzoTfQb7w69qNxFbGfN9K6fi6Y5ziP4RVd+U/CD7Z+Vcp1AbpTAQUXR6YHsIISYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jqp7Bx+m; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1233b953bebso11198710c88.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 05:01:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769432513; cv=none;
        d=google.com; s=arc-20240605;
        b=R1qlErrDa1BJjNWpGFgmYxfsHjMg0MTnVwYaIPPpM860Vm91xc1fz7e2bd+KJbTHHh
         Ia6halupSBREDWAqeHoNKcd14k514iqHMK41at8hwDgWyQ1+rwdgO0LkCQbEHbFaQoBo
         XWmuoBP1uAfvkYPdxCpbsombr9DN9hPNHupGN2WhCos0E5Pxvd8zMiSOluCoR84+TyMC
         UjLkVkjzld0n/j1Q0WHHiXhloC+7nkq4DeBqBSMrVb7OK2prb/W9bRApW8rwQnJNrxIy
         vYxV/kQoYOW+bkbW6JC3ah2R3acSEuJjyn6QhcvCi56p7JJI1XsntibEX30A0khehYnO
         VCvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QsFKvRjjX/maDWrKTfcneVC8SSbrRGlFogp/w/fEBLw=;
        fh=qvKH3rd+ufcYrjSruTwu2FdS8HkcG6taxaO+WVauUs8=;
        b=C8Eq3iec1j2EXRd0ieGpqWKaiUDcuVlRaN+RjwCa3rmRytVfmaqV3GgflmV6kgV5rM
         x3aIuCJzboH7bDdCexvCPJCQLu2xlSYWaizJL8UdqNiFcYC0cXI8L+CZSN9BqHE56MiG
         IHXP93pUlO2A4D9Fpzll3UTGoNR1TYJwDVitXlLEtiXmAf3t32XrxEtPSmjt/CSNAO/K
         rTHbITA1mneO4ZyMwaW8um0CQChzjIU4S6myQGovpAwBK2cUTRLe3cOhYS+Zsk/tZzTz
         wblVkYUsG+Og5tBs5WDNBodDhK/LxHBl6Ebp6yCa5xIIefWY9yx+d8MjqAHIRwG7axnH
         j4rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769432513; x=1770037313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QsFKvRjjX/maDWrKTfcneVC8SSbrRGlFogp/w/fEBLw=;
        b=Jqp7Bx+m6UcJx/eA5tcBC069iWv5W9RlGcM+uOmhEuWcVubz80/A4BlLEYjS55UKSU
         H1pSxvMU7MBkohuMlJPg7QY4tVs3bMdhaL0iUK/uHjA+ZFa6JbDna2cO8viQ2nlHvkmz
         +whwNsXmdnYG9BOfUGCpZPOGjICSRkI8fVzVEqwuxoG/p0ZBswqqzDP6mqAiRM0Eg+DC
         jp55XA6jzWmBv1u4CPPA8L2Rcul8txZt1T6wGW5GtB5peapwWYujuaVXK5xgQsyZsgmo
         /+orcBV6xFJRXWvRTRWTVsydO9c0Pm35tzlAL45Zlzmx8q/C+NC1YrS87DQaBFG3HfQm
         zRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769432513; x=1770037313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QsFKvRjjX/maDWrKTfcneVC8SSbrRGlFogp/w/fEBLw=;
        b=ktxlqpHOq8Bj0pFqxSaZ91zEw1mpMGUvXuzZaauLxtoDRdcBLtuT9FzHHlYMZ2h4vJ
         yKTM/tB5cop18O/9j5kiPPTrGPdo9LiLOkkSqqwGLRfM1fax5ogRkRhQp6Q0KfJmPpNe
         9ZiKQQ/44JJBLZcaXNHrsLlDY7m3Jxp8ZNjCLLs++bkVjIWPkUyNpZb7nOG7xQ0R9BN0
         mT0mKAyz/BkxSefjwW1YhOZ1P2Th6JQNrcq22mNltvQtiU9R295vTi9UGbepYM/Qa/7N
         DYaLKaFwxNGIbXqr3lFCnwXsnJPAFr5kDVB976wlTN5PLwc9C68so4ZzIC+jM73Eigrn
         sKVw==
X-Forwarded-Encrypted: i=1; AJvYcCVTPWurMOI86qi5oNyhYQbNwoOZh2QYA3/1/LiNouXFwOamHENzcuRu0/wBH5tvkoWJvn21koi3JaJxBIfT@vger.kernel.org
X-Gm-Message-State: AOJu0YxUis7BBDX1fhXft3xIvSd7wZDiy1S4B8q+Mlsq8wkZeIhSC/0/
	2YpnFrJ5CGhpthMybkaLo3so3aFigJaDEaHPEpFCzIJqxiAPuy/PiDoJYsRaZ4i5IZmeUB5sKj6
	QlIB6PxNdUWsUkIEjqkOC5tVG2ZIEwQo=
X-Gm-Gg: AZuq6aK3AcOMyc3NwJe92wlPfD+o9LrjERipRNLD5zscDA4CH9PxiQWyX0/iVC+QW8/
	RPgpXSFgksaeOgabG20muy6d12TeHYeGhEfGjlWby7bk7HE3OFLMi8fwyE3pf+9AWcy3Z5lLgnx
	87XXTsDau5GNY28RFP7+J9LAEjfUDPbGGJRuNz+dl47XtuKIutQxnYYvAsYgz07n04LKMAU2whZ
	Syuh29VlCG80wQl3xXPv/fyjZ0XNczkhdJIsmJ3jdX02WJvC9Xvjhqsy3iZ9Pg+k55+ufo=
X-Received: by 2002:a05:7022:2206:b0:11d:f462:78ac with SMTP id
 a92af1059eb24-1248ec8d53bmr1963808c88.28.1769432513183; Mon, 26 Jan 2026
 05:01:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114195524.1025067-2-slava@dubeyko.com> <CA+2bHPb66HKDZ2DX7TvzvfjW_Ym1TBeVNcPn9w_tnwytje85Nw@mail.gmail.com>
In-Reply-To: <CA+2bHPb66HKDZ2DX7TvzvfjW_Ym1TBeVNcPn9w_tnwytje85Nw@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 26 Jan 2026 14:01:40 +0100
X-Gm-Features: AZwV_Qhigqt9gFiGrF6N86oyG27EJ4EOimooalRQ645GK-SeIam8ucuWxU2zaIY
Message-ID: <CAOi1vP-G_0vPyMOyx6HvJX7VwN8_9FCe9V4Vg9zvg8gbbJNNHw@mail.gmail.com>
Subject: Re: [PATCH v5] ceph: fix kernel crash in ceph_open()
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, amarkuze@redhat.com, Slava.Dubeyko@ibm.com, 
	vdubeyko@redhat.com, khiremat@redhat.com, Pavan.Rallabhandi@ibm.com
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
	TAGGED_FROM(0.00)[bounces-75465-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ceph.com:url,dubeyko.com:email,bootlin.com:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1853F888D9
X-Rspamd-Action: no action

On Wed, Jan 14, 2026 at 10:27=E2=80=AFPM Patrick Donnelly <pdonnell@redhat.=
com> wrote:
>
> Reviewed-by: Patrick Donnelly <pdonnell@ibm.com>
>
> On Wed, Jan 14, 2026 at 2:56=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko=
.com> wrote:
> >
> > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> >
> > The CephFS kernel client has regression starting from 6.18-rc1.
> >
> > sudo ./check -g quick
> > FSTYP         -- ceph
> > PLATFORM      -- Linux/x86_64 ceph-0005 6.18.0-rc5+ #52 SMP PREEMPT_DYN=
AMIC Fri
> > Nov 14 11:26:14 PST 2025
> > MKFS_OPTIONS  -- 192.168.1.213:3300:/scratch
> > MOUNT_OPTIONS -- -o name=3Dadmin,ms_mode=3Dsecure 192.168.1.213:3300:/s=
cratch
> > /mnt/cephfs/scratch
> >
> > Killed
> >
> > Nov 14 11:48:10 ceph-0005 kernel: [  154.723902] libceph: mon0
> > (2)192.168.1.213:3300 session established
> > Nov 14 11:48:10 ceph-0005 kernel: [  154.727225] libceph: client167616
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.087260] BUG: kernel NULL point=
er
> > dereference, address: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.087756] #PF: supervisor read a=
ccess in
> > kernel mode
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.088043] #PF: error_code(0x0000=
) - not-
> > present page
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.088302] PGD 0 P4D 0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.088688] Oops: Oops: 0000 [#1] =
SMP KASAN
> > NOPTI
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.090080] CPU: 4 UID: 0 PID: 345=
3 Comm:
> > xfs_io Not tainted 6.18.0-rc5+ #52 PREEMPT(voluntary)
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.091245] Hardware name: QEMU St=
andard PC
> > (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.092103] RIP: 0010:strcmp+0x1c/=
0x40
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.092493] Code: 90 90 90 90 90 9=
0 90 90
> > 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83=
 c0 01 84
> > d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff =
c3 cc cc
> > cc cc 31
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.094057] RSP: 0018:ffff88815368=
75c0
> > EFLAGS: 00010246
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.094522] RAX: 0000000000000000 =
RBX:
> > ffff888116003200 RCX: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.095114] RDX: 0000000000000063 =
RSI:
> > 0000000000000000 RDI: ffff88810126c900
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.095714] RBP: ffff8881536876a8 =
R08:
> > 0000000000000000 R09: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.096297] R10: 0000000000000000 =
R11:
> > 0000000000000000 R12: dffffc0000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.096889] R13: ffff8881061d0000 =
R14:
> > 0000000000000000 R15: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.097490] FS:  000074a85c082840(=
0000)
> > GS:ffff8882401a4000(0000) knlGS:0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.098146] CS:  0010 DS: 0000 ES:=
 0000
> > CR0: 0000000080050033
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.098630] CR2: 0000000000000000 =
CR3:
> > 0000000110ebd001 CR4: 0000000000772ef0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.099219] PKRU: 55555554
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.099476] Call Trace:
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.099686]  <TASK>
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.099873]  ?
> > ceph_mds_check_access+0x348/0x1760
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.100267]  ?
> > __kasan_check_write+0x14/0x30
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.100671]  ? lockref_get+0xb1/0x=
170
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.100979]  ?
> > __pfx__raw_spin_lock+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.101372]  ceph_open+0x322/0xef0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.101669]  ? __pfx_ceph_open+0x1=
0/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.101996]  ?
> > __pfx_apparmor_file_open+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.102434]  ?
> > __ceph_caps_issued_mask_metric+0xd6/0x180
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.102911]  do_dentry_open+0x7bf/=
0x10e0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.103249]  ? __pfx_ceph_open+0x1=
0/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.103508]  vfs_open+0x6d/0x450
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.103697]  ? may_open+0xec/0x370
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.103893]  path_openat+0x2017/0x=
50a0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.104110]  ? __pfx_path_openat+0=
x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.104345]  ?
> > __pfx_stack_trace_save+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.104599]  ?
> > stack_depot_save_flags+0x28/0x8f0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.104865]  ? stack_depot_save+0x=
e/0x20
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105063]  do_filp_open+0x1b4/0x=
450
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105253]  ?
> > __pfx__raw_spin_lock_irqsave+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105538]  ? __pfx_do_filp_open+=
0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105748]  ? __link_object+0x13d=
/0x2b0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105949]  ?
> > __pfx__raw_spin_lock+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.106169]  ?
> > __check_object_size+0x453/0x600
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.106428]  ? _raw_spin_unlock+0x=
e/0x40
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.106635]  do_sys_openat2+0xe6/0=
x180
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.106827]  ?
> > __pfx_do_sys_openat2+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.107052]  __x64_sys_openat+0x10=
8/0x240
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.107258]  ?
> > __pfx___x64_sys_openat+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.107529]  ?
> > __pfx___handle_mm_fault+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.107783]  x64_sys_call+0x134f/0=
x2350
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108007]  do_syscall_64+0x82/0x=
d50
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108201]  ?
> > fpregs_assert_state_consistent+0x5c/0x100
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108467]  ? do_syscall_64+0xba/=
0xd50
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108626]  ? __kasan_check_read+=
0x11/0x20
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108801]  ?
> > count_memcg_events+0x25b/0x400
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109013]  ? handle_mm_fault+0x3=
8b/0x6a0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109216]  ? __kasan_check_read+=
0x11/0x20
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109457]  ?
> > fpregs_assert_state_consistent+0x5c/0x100
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109724]  ?
> > irqentry_exit_to_user_mode+0x2e/0x2a0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109991]  ? irqentry_exit+0x43/=
0x50
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.110180]  ? exc_page_fault+0x95=
/0x100
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.110389]
> > entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.110638] RIP: 0033:0x74a85bf145=
ab
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.110821] Code: 25 00 00 41 00 3=
d 00 00
> > 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c=
 ff ff ff
> > b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 54 24 =
28 64 48
> > 2b 14 25
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.111724] RSP: 002b:00007ffc77d3=
16d0
> > EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.112080] RAX: ffffffffffffffda =
RBX:
> > 0000000000000002 RCX: 000074a85bf145ab
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.112442] RDX: 0000000000000000 =
RSI:
> > 00007ffc77d32789 RDI: 00000000ffffff9c
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.112790] RBP: 00007ffc77d32789 =
R08:
> > 00007ffc77d31980 R09: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.113125] R10: 0000000000000000 =
R11:
> > 0000000000000246 R12: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.113502] R13: 00000000ffffffff =
R14:
> > 0000000000000180 R15: 0000000000000001
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.113838]  </TASK>
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.113957] Modules linked in:
> > intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pm=
c_core
> > pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_v=
sec
> > kvm_intel kvm joydev irqbypass polyval_clmulni ghash_clmulni_intel aesn=
i_intel
> > rapl floppy input_leds psmouse i2c_piix4 vga16fb mac_hid i2c_smbus vgas=
tate
> > serio_raw bochs qemu_fw_cfg pata_acpi sch_fq_codel rbd msr parport_pc p=
pdev lp
> > parport efi_pstore
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.116339] CR2: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.116574] ---[ end trace 0000000=
000000000
> > ]---
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.116826] RIP: 0010:strcmp+0x1c/=
0x40
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.117058] Code: 90 90 90 90 90 9=
0 90 90
> > 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83=
 c0 01 84
> > d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff =
c3 cc cc
> > cc cc 31
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.118070] RSP: 0018:ffff88815368=
75c0
> > EFLAGS: 00010246
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.118362] RAX: 0000000000000000 =
RBX:
> > ffff888116003200 RCX: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.118748] RDX: 0000000000000063 =
RSI:
> > 0000000000000000 RDI: ffff88810126c900
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.119116] RBP: ffff8881536876a8 =
R08:
> > 0000000000000000 R09: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.119492] R10: 0000000000000000 =
R11:
> > 0000000000000000 R12: dffffc0000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.119865] R13: ffff8881061d0000 =
R14:
> > 0000000000000000 R15: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.120242] FS:  000074a85c082840(=
0000)
> > GS:ffff8882401a4000(0000) knlGS:0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.120704] CS:  0010 DS: 0000 ES:=
 0000
> > CR0: 0000000080050033
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.121008] CR2: 0000000000000000 =
CR3:
> > 0000000110ebd001 CR4: 0000000000772ef0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.121409] PKRU: 55555554
> >
> > We have issue here [1] if fs_name =3D=3D NULL:
> >
> > const char fs_name =3D mdsc->fsc->mount_options->mds_namespace;
> >     ...
> >     if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_name)) {
> >             / fsname mismatch, try next one */
> >             return 0;
> >     }
> >
> > v2
> > Patrick Donnelly suggested that: In summary, we should definitely start
> > decoding `fs_name` from the MDSMap and do strict authorizations checks
> > against it. Note that the `--mds_namespace` should only be used for
> > selecting the file system to mount and nothing else. It's possible
> > no mds_namespace is specified but the kernel will mount the only
> > file system that exists which may have name "foo".
> >
> > v3
> > The namespace_equals() logic has been generalized into
> > __namespace_equals() with the goal of using it in
> > ceph_mdsc_handle_fsmap() and ceph_mds_auth_match().
> > The misspelling of CEPH_NAMESPACE_WILDCARD has been corrected.
> >
> > v4
> > The __namespace_equals() now supports wildcard check.
> >
> > v5
> > Patrick Donnelly suggested to add the sanity check of
> > kstrdup() returned pointer in ceph_mdsmap_decode()
> > added logic. Also, he suggested much simpler logic of
> > namespace strings comparison in the form of
> > ceph_namespace_match() logic.
> >
> > This patch reworks ceph_mdsmap_decode() and namespace_equals() with
> > the goal of supporting the suggested concept. Now struct ceph_mdsmap
> > contains m_fs_name field that receives copy of extracted FS name
> > by ceph_extract_encoded_string(). For the case of "old" CephFS file sys=
tems,
> > it is used "cephfs" name. Also, namespace_equals() method has been
> > reworked with the goal of proper names comparison.
> >
> > [1] https://elixir.bootlin.com/linux/v6.18-rc4/source/fs/ceph/mds_clien=
t.c#L5666
> > [2] https://tracker.ceph.com/issues/73886
> >
> > Fixes: 22c73d52a6d0 ("ceph: fix multifs mds auth caps issue")
> > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > cc: Kotresh Hiremath Ravishankar <khiremat@redhat.com>
> > cc: Alex Markuze <amarkuze@redhat.com>
> > cc: Ilya Dryomov <idryomov@gmail.com>
> > cc: Patrick Donnelly <pdonnell@redhat.com>
> > cc: Ceph Development <ceph-devel@vger.kernel.org>
> > ---
> >  fs/ceph/mds_client.c         | 11 +++++------
> >  fs/ceph/mdsmap.c             | 24 ++++++++++++++++++------
> >  fs/ceph/mdsmap.h             |  1 +
> >  fs/ceph/super.h              | 24 +++++++++++++++++++-----
> >  include/linux/ceph/ceph_fs.h |  6 ++++++
> >  5 files changed, 49 insertions(+), 17 deletions(-)
> >
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 7e4eab824dae..703c14bc3c95 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -5671,7 +5671,7 @@ static int ceph_mds_auth_match(struct ceph_mds_cl=
ient *mdsc,
> >         u32 caller_uid =3D from_kuid(&init_user_ns, cred->fsuid);
> >         u32 caller_gid =3D from_kgid(&init_user_ns, cred->fsgid);
> >         struct ceph_client *cl =3D mdsc->fsc->client;
> > -       const char *fs_name =3D mdsc->fsc->mount_options->mds_namespace=
;
> > +       const char *fs_name =3D mdsc->mdsmap->m_fs_name;
> >         const char *spath =3D mdsc->fsc->mount_options->server_path;
> >         bool gid_matched =3D false;
> >         u32 gid, tlen, len;
> > @@ -5679,7 +5679,8 @@ static int ceph_mds_auth_match(struct ceph_mds_cl=
ient *mdsc,
> >
> >         doutc(cl, "fsname check fs_name=3D%s  match.fs_name=3D%s\n",
> >               fs_name, auth->match.fs_name ? auth->match.fs_name : "");
> > -       if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_name)=
) {
> > +
> > +       if (!ceph_namespace_match(auth->match.fs_name, fs_name, NAME_MA=
X)) {
> >                 /* fsname mismatch, try next one */
> >                 return 0;
> >         }
> > @@ -6122,7 +6123,6 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_clien=
t *mdsc, struct ceph_msg *msg)
> >  {
> >         struct ceph_fs_client *fsc =3D mdsc->fsc;
> >         struct ceph_client *cl =3D fsc->client;
> > -       const char *mds_namespace =3D fsc->mount_options->mds_namespace=
;
> >         void *p =3D msg->front.iov_base;
> >         void *end =3D p + msg->front.iov_len;
> >         u32 epoch;
> > @@ -6157,9 +6157,8 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_clien=
t *mdsc, struct ceph_msg *msg)
> >                 namelen =3D ceph_decode_32(&info_p);
> >                 ceph_decode_need(&info_p, info_end, namelen, bad);
> >
> > -               if (mds_namespace &&
> > -                   strlen(mds_namespace) =3D=3D namelen &&
> > -                   !strncmp(mds_namespace, (char *)info_p, namelen)) {
> > +               if (namespace_equals(fsc->mount_options,
> > +                                    (char *)info_p, namelen)) {
> >                         mount_fscid =3D fscid;
> >                         break;
> >                 }
> > diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
> > index 2c7b151a7c95..f0c0ed202184 100644
> > --- a/fs/ceph/mdsmap.c
> > +++ b/fs/ceph/mdsmap.c
> > @@ -353,22 +353,33 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct cep=
h_mds_client *mdsc, void **p,
> >                 __decode_and_drop_type(p, end, u8, bad_ext);
> >         }
> >         if (mdsmap_ev >=3D 8) {
> > -               u32 fsname_len;
> > +               size_t fsname_len;
> > +
> >                 /* enabled */
> >                 ceph_decode_8_safe(p, end, m->m_enabled, bad_ext);
> > +
> >                 /* fs_name */
> > -               ceph_decode_32_safe(p, end, fsname_len, bad_ext);
> > +               m->m_fs_name =3D ceph_extract_encoded_string(p, end,
> > +                                                          &fsname_len,
> > +                                                          GFP_NOFS);
> > +               if (IS_ERR(m->m_fs_name)) {
> > +                       m->m_fs_name =3D NULL;
> > +                       goto nomem;
> > +               }
> >
> >                 /* validate fsname against mds_namespace */
> > -               if (!namespace_equals(mdsc->fsc->mount_options, *p,
> > +               if (!namespace_equals(mdsc->fsc->mount_options, m->m_fs=
_name,
> >                                       fsname_len)) {
> >                         pr_warn_client(cl, "fsname %*pE doesn't match m=
ds_namespace %s\n",
> > -                                      (int)fsname_len, (char *)*p,
> > +                                      (int)fsname_len, m->m_fs_name,
> >                                        mdsc->fsc->mount_options->mds_na=
mespace);
> >                         goto bad;
> >                 }
> > -               /* skip fsname after validation */
> > -               ceph_decode_skip_n(p, end, fsname_len, bad);
> > +       } else {
> > +               m->m_enabled =3D false;
> > +               m->m_fs_name =3D kstrdup(CEPH_OLD_FS_NAME, GFP_NOFS);
> > +               if (!m->m_fs_name)
> > +                       goto nomem;
> >         }
> >         /* damaged */
> >         if (mdsmap_ev >=3D 9) {
> > @@ -430,6 +441,7 @@ void ceph_mdsmap_destroy(struct ceph_mdsmap *m)
> >                 kfree(m->m_info);
> >         }
> >         kfree(m->m_data_pg_pools);
> > +       kfree(m->m_fs_name);
> >         kfree(m);
> >  }
> >
> > diff --git a/fs/ceph/mdsmap.h b/fs/ceph/mdsmap.h
> > index 1f2171dd01bf..d48d07c3516d 100644
> > --- a/fs/ceph/mdsmap.h
> > +++ b/fs/ceph/mdsmap.h
> > @@ -45,6 +45,7 @@ struct ceph_mdsmap {
> >         bool m_enabled;
> >         bool m_damaged;
> >         int m_num_laggy;
> > +       char *m_fs_name;
> >  };
> >
> >  static inline struct ceph_entity_addr *
> > diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> > index a1f781c46b41..c8def96a129f 100644
> > --- a/fs/ceph/super.h
> > +++ b/fs/ceph/super.h
> > @@ -104,18 +104,32 @@ struct ceph_mount_options {
> >         struct fscrypt_dummy_policy dummy_enc_policy;
> >  };
> >
> > +#define CEPH_NAMESPACE_WILDCARD                "*"
> > +
> > +static inline bool ceph_namespace_match(const char *pattern,
> > +                                       const char *target,
> > +                                       size_t target_len)
> > +{
> > +       if (!pattern || !pattern[0] ||
> > +           !strcmp(pattern, CEPH_NAMESPACE_WILDCARD))
> > +               return true;
> > +
> > +       if (strlen(pattern) !=3D target_len)
> > +               return false;
> > +
> > +       return !strncmp(pattern, target, target_len);
> > +}
> > +
> >  /*
> >   * Check if the mds namespace in ceph_mount_options matches
> >   * the passed in namespace string. First time match (when
> >   * ->mds_namespace is NULL) is treated specially, since
> >   * ->mds_namespace needs to be initialized by the caller.
> >   */
> > -static inline int namespace_equals(struct ceph_mount_options *fsopt,
> > -                                  const char *namespace, size_t len)
> > +static inline bool namespace_equals(struct ceph_mount_options *fsopt,
> > +                                   const char *namespace, size_t len)
> >  {
> > -       return !(fsopt->mds_namespace &&
> > -                (strlen(fsopt->mds_namespace) !=3D len ||
> > -                 strncmp(fsopt->mds_namespace, namespace, len)));
> > +       return ceph_namespace_match(fsopt->mds_namespace, namespace, le=
n);

Hi Patrick,

Has your

    > > I think we agreed that the "*" wildcard should have _no_ special
    > > meaning as a glob for fsopt->mds_namespace?
    >
    > Frankly speaking, I don't quite follow to your point. What do
you mean here? :)

    --mds_namespace=3D* is invalid.

    vs.

    And mds auth cap: mds 'allow rw fsname=3D*'  IS valid.

stance [1] changed?  I want to double check because I see your
Reviewed-by, but this patch _does_ apply the special meaning to "*" for
fsopt->mds_namespace by virtue of having namespace_equals() just
forward to ceph_namespace_match() which is used for the MDS auth cap.
As a result, all checks (including the one in ceph_mdsc_handle_fsmap()
which is responsible for filtering filesystems on mount) do the MDS
auth cap thing and "-o mds_namespace=3D*" would mount the filesystem that
happens to be first on the list instead of failing with ENOENT.

[1] https://lore.kernel.org/ceph-devel/CA+2bHPYqT8iMJrSDiO=3Dm-dAvmWd3j+co6=
Sq0gZ+421p8KYMEnQ@mail.gmail.com/

Thanks,

                Ilya

