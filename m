Return-Path: <linux-fsdevel+bounces-77815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFgeDxermGn5KgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 19:42:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C815A16A274
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 19:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DDE130804FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 18:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AEF36681F;
	Fri, 20 Feb 2026 18:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ee4LIvT7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A58536681B
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 18:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771612893; cv=pass; b=RUTkD9SVwrYW6WnQvfjsSUt1EJ7ikBjWdlvkHLt4t8oBF/Ns8vf0ngCRVlO55jJXsMgCfw5c6m+247yMUbPuSoxXGq3mm3eSPXYFtZ1/NP2k/tMjbDPo2o8NsIU1gqV/jOFps/ozTiX5zt4uxiO0Oe9iYi8AXvQft5mEv9lRNd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771612893; c=relaxed/simple;
	bh=jGWN+2KRz9O+H0665WvpQ52Kq/1J8TPaBwHG/SF4ULQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQaWAcf4e56ueRf0FAwKMoTFi2hocESn0H/DEZsWtRgw4y6oTFH84qqLOLnpNZWL4+X4rQ5UaprKAKuyVm6bC0FA0lYpXzwyJziwFiyjIVQdHqR8SLbwbQXet6IlNk8QwOJMrgAKljg0FL1Rg4uEE9u2rdRG4MCCciq2KbiFpbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ee4LIvT7; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48318d08ec2so4215e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 10:41:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771612888; cv=none;
        d=google.com; s=arc-20240605;
        b=BADpfNksWQ5bHYV1MvVfE4zTLQuDDqp7a/J/JhEYq7lI4+QAcC0cW3RaHKBlj2+dzo
         yNS4SPe5xHtfNu/nd2FOrKneyJmI2V2GKU51Q6yqymtdhGe+LYp7A5GHL5zxV4HMkuzK
         uzYfjpQXAx6tFyalQJ5zYTlHIJigSavWonVoXa8uizR060tA/Txig+g50AxhTIx4JhF0
         S9Fgk+48oVMrAXUi+u1A6yHNPTS4emVnEDJu/PXbgr8c1g0mvS9/P8L/WzUHPDREn5FP
         dMQjVcgw4yP707+BvDu/34jf1scEF8EcNm1zlomiFdnNChh2ZYEgfPSbALgrebBlDWbU
         lDgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9zD91sZr4vtMf1I/t0ZYhRV7PHrn122EkGjmR8qVtO4=;
        fh=V9bdn+EU2z4XLwqgohI7BOUCXilL/vb4NgSEngSvTmQ=;
        b=X0s9GC1drHSwSq8yySqQkXsO5CELM1dTMxR1m083VHBIKSTokUpdLshJx/MS9ugE9v
         4wTOUiqTr11uFYJurGptyb9n8ta/cCPNZUXuE1Cj/X2S/4k6d03AISv+Ddrt+kfdDqgl
         nLOxb0RHic/hgaTs2xyTRi33Xd8tullsKQbz6cV0u7J0Qjy7nI+1m6w+jJweU/n08whi
         pMTuhA8Lt3zmwERxmBgfEflfDG7OY5WT3Qk+IwM+jRz2e3yt/UByHYnU4PB+Ysv2f6m4
         bU9ErAcnT/SILARVPx6Z/e1Bnh3jvdNlNVz5qMOkvgYRojIN7S6BSKEuzl/ntWJpjpCa
         wHuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771612888; x=1772217688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zD91sZr4vtMf1I/t0ZYhRV7PHrn122EkGjmR8qVtO4=;
        b=Ee4LIvT70RK3IL0VC7Xg/fpcY+vO7dwu3hNsTLwBiEV8lzX00OGSFKJsMLrgdSC4iJ
         jkiJ9wCErBPg3oXaA6vpyGAR9oMOadMC0/jXwFU0+arVhn0deqlmNKLodfTfbvwRTChM
         Oc/SzrShLyj20LxdX3UShdCUw3A+pdr2K2l8kOX3eqd3COZa8gnqrlhDDh5d9359DKYg
         BsqL4TdK57e1ImHvKeSlY+82nXmBV1CGyKrrc0ppHeb6kwhY6SISP2OkMITl2Iabl4C9
         BkrCyoXiuBkO3DZp+cf9/1WmbAEFqsg7IM85QbjKjr5kFVfhzlSxBRXyjOeOMdiQyB70
         LQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771612888; x=1772217688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9zD91sZr4vtMf1I/t0ZYhRV7PHrn122EkGjmR8qVtO4=;
        b=RfTYT46NUooMfNLLmyHm5eFWaqiw4LecwOxBpYOBzORZQOi3ABw+dGD+jJTmNaQtjw
         lEznVMYoDUOoCTjRIcTQ7V5UszzevFDc0dCaQs9PEOZpfoTJRk7pTqIyfAsCarmNAbDt
         FDcFdq6+aaNzGTQyltaIgDaaBqfaMUvpjUVjCWYv/6hbplZ5xrn7yy/gprRHrFN2X2ci
         WglCI6rXGkqJOqmIjvsJYQJrMTgof7Ql4qmPI9mLRNy+3rNz1urZagoINPPs4ixdZAmV
         QUbCbqnQPxr7tiswHtI08zCErEaZNfm9KTvcq8ydsZN0gSUgAU0f2J+AscLxJjECHPfc
         iQmw==
X-Forwarded-Encrypted: i=1; AJvYcCWTnY2knZ6j2A9rL/IWpIxBbwg4ELFH80mbUbluWi3xrOpeSGHXw0Fb/fZdw/aMkjWsdP5hHfE7a8+kUKO7@vger.kernel.org
X-Gm-Message-State: AOJu0YwMQrs//ctB506o+oLRA2H4MadKslXd05ckrGTZ2DB3exX7197h
	3vMUuS0xJtaCMKWLXkADFU/uG5LmIScnHMGapiq6wU0eYvjEoXXnH9IgyG1O7cObihipuSZQ9Ah
	Q/K9utLCe3bDJMa8+viYqGqzvo1WwZTdRmfQF7UWe
X-Gm-Gg: AZuq6aLIKzYoQtRRvWx1OmWBIJf4mL1UluBiEOa4dVWfZkHSJ+LMSM4mvEvoATKvlXp
	LuLo7hMbxDIEHSXUNl4u4idWXLwjYARyDR6ez7qQTkRkWIx6JhkmReo0M/6xIMeAZVw4F9JQNnH
	Z1vbhNdZ6n9LIB0dVIQUkZRlR33SFuI/1emrweCH+ucL7T3tI7VDQkY9DX1RZR/47Z/Zd9NXgt5
	NC1MkyuGj1W/OrELSVBG/T551yVdX+rY4dvyhL/zQeGHtjmr3hs2FBqPtpyTi2Hu1nRGHqUetRX
	RK39n01c2Z+DbaMwgRhvpp7JEW8yu+w64azadw==
X-Received: by 2002:a7b:ce83:0:b0:47b:e29f:c63f with SMTP id
 5b1f17b1804b1-483a9c94b7amr15895e9.11.1771612887389; Fri, 20 Feb 2026
 10:41:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220055449.3073-1-tjmercier@google.com> <699833fc.050a0220.b01bb.0039.GAE@google.com>
In-Reply-To: <699833fc.050a0220.b01bb.0039.GAE@google.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 20 Feb 2026 10:41:15 -0800
X-Gm-Features: AaiRm52d4kAFkoYx2iC9CeE49X0_4sKfZ3IqpWEI6kL-ps7PY6q2ag5O0FgCNOg
Message-ID: <CABdmKX3jMS5ha2s5FMpnAMW0c9+Wmpmyc+8=D-24KyhVjBJvYg@mail.gmail.com>
Subject: Re: [syzbot ci] Re: kernfs: Add inotify IN_DELETE_SELF, IN_IGNORED support
To: syzbot ci <syzbot+cif2121bcf05a8d84e@syzkaller.appspotmail.com>
Cc: amir73il@gmail.com, cgroups@vger.kernel.org, driver-core@lists.linux.dev, 
	gregkh@linuxfoundation.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	shuah@kernel.org, tj@kernel.org, syzbot@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77815-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.linux.dev,linuxfoundation.org,suse.cz,kernel.org,googlegroups.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel,cif2121bcf05a8d84e];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,googlesource.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: C815A16A274
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 2:14=E2=80=AFAM syzbot ci
<syzbot+cif2121bcf05a8d84e@syzkaller.appspotmail.com> wrote:
>
> syzbot ci has tested the following series
>
> [v4] kernfs: Add inotify IN_DELETE_SELF, IN_IGNORED support
> https://lore.kernel.org/all/20260220055449.3073-1-tjmercier@google.com
> * [PATCH v4 1/3] kernfs: Don't set_nlink for directories being removed
> * [PATCH v4 2/3] kernfs: Send IN_DELETE_SELF and IN_IGNORED
> * [PATCH v4 3/3] selftests: memcg: Add tests for IN_DELETE_SELF and IN_IG=
NORED
>
> and found the following issue:
> possible deadlock in __kernfs_remove
>
> Full report is available here:
> https://ci.syzbot.org/series/4b44d5c2-c2eb-4425-a19a-f9963b64f74f
>
> ***
>
> possible deadlock in __kernfs_remove
>
> tree:      bpf-next
> URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/b=
pf-next.git
> base:      ba268514ea14b44570030e8ed2aef92a38679e85
> arch:      amd64
> compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~e=
xp1~20251221153213.50), Debian LLD 21.1.8
> config:    https://ci.syzbot.org/builds/45ab774f-e8d7-4def-8279-888a5cb2d=
01e/config
> syz repro: https://ci.syzbot.org/findings/b74cbc6a-1cef-4ae9-be46-dd9e8b2=
9b648/syz_repro
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> syzkaller #0 Not tainted
> ------------------------------------------------------
> kworker/u8:1/13 is trying to acquire lock:
> ffff88816ef2b878 (kn->active#5){++++}-{0:0}, at: __kernfs_remove+0x47e/0x=
8c0 fs/kernfs/dir.c:1533
>
> but task is already holding lock:
> ffff8881012e8ab8 (&root->kernfs_supers_rwsem){++++}-{4:4}, at: kernfs_rem=
ove_by_name_ns+0x3f/0x140 fs/kernfs/dir.c:1745
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #2 (&root->kernfs_supers_rwsem){++++}-{4:4}:
>        down_read+0x47/0x2e0 kernel/locking/rwsem.c:1537
>        kernfs_remove_by_name_ns+0x3f/0x140 fs/kernfs/dir.c:1745
>        acpi_unbind_one+0x2d8/0x3b0 drivers/acpi/glue.c:337
>        device_platform_notify_remove drivers/base/core.c:2386 [inline]
>        device_del+0x547/0x8f0 drivers/base/core.c:3881
>        serdev_controller_add+0x46f/0x640 drivers/tty/serdev/core.c:785
>        serdev_tty_port_register+0x159/0x260 drivers/tty/serdev/serdev-tty=
port.c:291
>        tty_port_register_device_attr_serdev+0xe7/0x170 drivers/tty/tty_po=
rt.c:187
>        serial_core_add_one_port drivers/tty/serial/serial_core.c:3107 [in=
line]
>        serial_core_register_port+0x103a/0x28b0 drivers/tty/serial/serial_=
core.c:3305
>        serial8250_register_8250_port+0x1658/0x1fd0 drivers/tty/serial/825=
0/8250_core.c:822
>        serial_pnp_probe+0x568/0x7f0 drivers/tty/serial/8250/8250_pnp.c:48=
0
>        pnp_device_probe+0x30b/0x4c0 drivers/pnp/driver.c:111
>        call_driver_probe drivers/base/dd.c:-1 [inline]
>        really_probe+0x267/0xaf0 drivers/base/dd.c:661
>        __driver_probe_device+0x18c/0x320 drivers/base/dd.c:803
>        driver_probe_device+0x4f/0x240 drivers/base/dd.c:833
>        __driver_attach+0x3e7/0x710 drivers/base/dd.c:1227
>        bus_for_each_dev+0x23b/0x2c0 drivers/base/bus.c:383
>        bus_add_driver+0x345/0x670 drivers/base/bus.c:715
>        driver_register+0x23a/0x320 drivers/base/driver.c:249
>        serial8250_init+0x8f/0x160 drivers/tty/serial/8250/8250_platform.c=
:317
>        do_one_initcall+0x250/0x840 init/main.c:1378
>        do_initcall_level+0x104/0x190 init/main.c:1440
>        do_initcalls+0x59/0xa0 init/main.c:1456
>        kernel_init_freeable+0x2a6/0x3d0 init/main.c:1688
>        kernel_init+0x1d/0x1d0 init/main.c:1578
>        ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
>
> -> #1 (&device->physical_node_lock){+.+.}-{4:4}:
>        __mutex_lock_common kernel/locking/mutex.c:614 [inline]
>        __mutex_lock+0x19f/0x1300 kernel/locking/mutex.c:776
>        acpi_get_first_physical_node drivers/acpi/bus.c:691 [inline]
>        acpi_primary_dev_companion drivers/acpi/bus.c:710 [inline]
>        acpi_companion_match+0x8a/0x120 drivers/acpi/bus.c:764
>        acpi_device_uevent_modalias+0x1a/0x30 drivers/acpi/device_sysfs.c:=
280
>        platform_uevent+0x3c/0xb0 drivers/base/platform.c:1411
>        dev_uevent+0x446/0x8a0 drivers/base/core.c:2692
>        kobject_uevent_env+0x477/0x9e0 lib/kobject_uevent.c:573
>        kobject_synth_uevent+0x585/0xbd0 lib/kobject_uevent.c:207
>        uevent_store+0x26/0x70 drivers/base/core.c:2773
>        kernfs_fop_write_iter+0x3af/0x540 fs/kernfs/file.c:352
>        new_sync_write fs/read_write.c:593 [inline]
>        vfs_write+0x61d/0xb90 fs/read_write.c:686
>        ksys_write+0x150/0x270 fs/read_write.c:738
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> -> #0 (kn->active#5){++++}-{0:0}:
>        check_prev_add kernel/locking/lockdep.c:3165 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3284 [inline]
>        validate_chain kernel/locking/lockdep.c:3908 [inline]
>        __lock_acquire+0x15a5/0x2cf0 kernel/locking/lockdep.c:5237
>        lock_acquire+0x106/0x330 kernel/locking/lockdep.c:5868
>        kernfs_drain+0x27c/0x5f0 fs/kernfs/dir.c:511
>        __kernfs_remove+0x47e/0x8c0 fs/kernfs/dir.c:1533
>        kernfs_remove_by_name_ns+0xc0/0x140 fs/kernfs/dir.c:1751
>        sysfs_remove_file include/linux/sysfs.h:780 [inline]
>        device_remove_file drivers/base/core.c:3071 [inline]
>        device_del+0x506/0x8f0 drivers/base/core.c:3876
>        device_unregister+0x21/0xf0 drivers/base/core.c:3919
>        mac80211_hwsim_del_radio+0x2dc/0x490 drivers/net/wireless/virtual/=
mac80211_hwsim.c:5918
>        hwsim_exit_net+0xede/0xfa0 drivers/net/wireless/virtual/mac80211_h=
wsim.c:6807
>        ops_exit_list net/core/net_namespace.c:199 [inline]
>        ops_undo_list+0x49f/0x940 net/core/net_namespace.c:252
>        cleanup_net+0x4df/0x7b0 net/core/net_namespace.c:696
>        process_one_work kernel/workqueue.c:3257 [inline]
>        process_scheduled_works+0xaec/0x17a0 kernel/workqueue.c:3340
>        worker_thread+0xda6/0x1360 kernel/workqueue.c:3421
>        kthread+0x726/0x8b0 kernel/kthread.c:463
>        ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
>
> other info that might help us debug this:
>
> Chain exists of:
>   kn->active#5 --> &device->physical_node_lock --> &root->kernfs_supers_r=
wsem
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   rlock(&root->kernfs_supers_rwsem);
>                                lock(&device->physical_node_lock);
>                                lock(&root->kernfs_supers_rwsem);
>   lock(kn->active#5);
>
>  *** DEADLOCK ***
>
> 4 locks held by kworker/u8:1/13:
>  #0: ffff888100ef7948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one=
_work kernel/workqueue.c:3232 [inline]
>  #0: ffff888100ef7948 ((wq_completion)netns){+.+.}-{0:0}, at: process_sch=
eduled_works+0x9d4/0x17a0 kernel/workqueue.c:3340
>  #1: ffffc90000127bc0 (net_cleanup_work){+.+.}-{0:0}, at: process_one_wor=
k kernel/workqueue.c:3233 [inline]
>  #1: ffffc90000127bc0 (net_cleanup_work){+.+.}-{0:0}, at: process_schedul=
ed_works+0xa0f/0x17a0 kernel/workqueue.c:3340
>  #2: ffffffff8f99d2d0 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xf=
e/0x7b0 net/core/net_namespace.c:670
>  #3: ffff8881012e8ab8 (&root->kernfs_supers_rwsem){++++}-{4:4}, at: kernf=
s_remove_by_name_ns+0x3f/0x140 fs/kernfs/dir.c:1745
>
> stack backtrace:
> CPU: 0 UID: 0 PID: 13 Comm: kworker/u8:1 Not tainted syzkaller #0 PREEMPT=
(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.=
16.2-1 04/01/2014
> Workqueue: netns cleanup_net
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>  print_circular_bug+0x2e1/0x300 kernel/locking/lockdep.c:2043
>  check_noncircular+0x12e/0x150 kernel/locking/lockdep.c:2175
>  check_prev_add kernel/locking/lockdep.c:3165 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3284 [inline]
>  validate_chain kernel/locking/lockdep.c:3908 [inline]
>  __lock_acquire+0x15a5/0x2cf0 kernel/locking/lockdep.c:5237
>  lock_acquire+0x106/0x330 kernel/locking/lockdep.c:5868
>  kernfs_drain+0x27c/0x5f0 fs/kernfs/dir.c:511
>  __kernfs_remove+0x47e/0x8c0 fs/kernfs/dir.c:1533
>  kernfs_remove_by_name_ns+0xc0/0x140 fs/kernfs/dir.c:1751
>  sysfs_remove_file include/linux/sysfs.h:780 [inline]
>  device_remove_file drivers/base/core.c:3071 [inline]
>  device_del+0x506/0x8f0 drivers/base/core.c:3876
>  device_unregister+0x21/0xf0 drivers/base/core.c:3919
>  mac80211_hwsim_del_radio+0x2dc/0x490 drivers/net/wireless/virtual/mac802=
11_hwsim.c:5918
>  hwsim_exit_net+0xede/0xfa0 drivers/net/wireless/virtual/mac80211_hwsim.c=
:6807
>  ops_exit_list net/core/net_namespace.c:199 [inline]
>  ops_undo_list+0x49f/0x940 net/core/net_namespace.c:252
>  cleanup_net+0x4df/0x7b0 net/core/net_namespace.c:696
>  process_one_work kernel/workqueue.c:3257 [inline]
>  process_scheduled_works+0xaec/0x17a0 kernel/workqueue.c:3340
>  worker_thread+0xda6/0x1360 kernel/workqueue.c:3421
>  kthread+0x726/0x8b0 kernel/kthread.c:463
>  ret_from_fork+0x51b/0xa40 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
>  </TASK>
> hsr_slave_0: left promiscuous mode
> hsr_slave_1: left promiscuous mode
> batman_adv: batadv0: Interface deactivated: batadv_slave_0
> batman_adv: batadv0: Removing interface: batadv_slave_0
> batman_adv: batadv0: Interface deactivated: batadv_slave_1
> batman_adv: batadv0: Removing interface: batadv_slave_1
> veth1_macvtap: left promiscuous mode
> veth0_macvtap: left promiscuous mode
> veth1_vlan: left promiscuous mode
> veth0_vlan: left promiscuous mode
> team0 (unregistering): Port device team_slave_1 removed
> team0 (unregistering): Port device team_slave_0 removed
> netdevsim netdevsim2 netdevsim0: set [1, 0] type 2 family 0 port 6081 - 0
> netdevsim netdevsim2 netdevsim1: set [1, 0] type 2 family 0 port 6081 - 0
> netdevsim netdevsim2 netdevsim2: set [1, 0] type 2 family 0 port 6081 - 0
> netdevsim netdevsim2 netdevsim3: set [1, 0] type 2 family 0 port 6081 - 0
>
>
> ***
>
> If these findings have caused you to resend the series or submit a
> separate fix, please add the following tag to your commit message:
>   Tested-by: syzbot@syzkaller.appspotmail.com
>
> ---
> This report is generated by a bot. It may contain errors.
> syzbot ci engineers can be reached at syzkaller@googlegroups.com.

Hm, I can see two ways to fix this.

The first is to drop the acpi_dev->physical_node_lock mutex in
acpi_unbind_one before calling sysfs_remove_link. This keeps the node
ID reserved while the sysfs files are still being removed, so that we
don't get any sysfs filename collisions (which are based on the node
ID). This seems like a good optimization to do anyway:

+++ b/drivers/acpi/glue.c
@@ -329,18 +329,22 @@ int acpi_unbind_one(struct device *dev)
        list_for_each_entry(entry, &acpi_dev->physical_node_list, node)
                if (entry->dev =3D=3D dev) {
                        char physnode_name[PHYSICAL_NODE_NAME_SIZE];

-                       list_del(&entry->node);
-                       acpi_dev->physical_node_count--;
+                       entry->dev =3D NULL;
+                       mutex_unlock(&acpi_dev->physical_node_lock);

                        acpi_physnode_link_name(physnode_name, entry->node_=
id);
                        sysfs_remove_link(&acpi_dev->dev.kobj, physnode_nam=
e);
                        sysfs_remove_link(&dev->kobj, "firmware_node");
                        ACPI_COMPANION_SET(dev, NULL);
                        /* Drop references taken by acpi_bind_one(). */
                        put_device(dev);
                        acpi_dev_put(acpi_dev);
+
+                       mutex_lock(&acpi_dev->physical_node_lock);
+                       list_del(&entry->node);
+                       acpi_dev->physical_node_count--;
                        kfree(entry);
                        break;
                }


The second is to drop the kernfs_supers_rwsem for the kernfs_drain,
similar to how the kernfs_rwsem is dropped there. I don't think
kernfs_supers_rwsem is usually heavily contended, but it's probably a
good idea to avoid holding it while potentially sleeping in
kernfs_drain. Since the kernfs_supers_rwsem is only held for
kernfs_drain in __kernfs_remove (but not kernfs_show) that means:

+++ b/fs/kernfs/dir.c
@@ -486,7 +486,7 @@ void kernfs_put_active(struct kernfs_node *kn)
  * removers may invoke this function concurrently on @kn and all will
  * return after draining is complete.
  */
-static void kernfs_drain(struct kernfs_node *kn)
+static void kernfs_drain(struct kernfs_node *kn, bool drop_supers)
        __releases(&kernfs_root(kn)->kernfs_rwsem)
        __acquires(&kernfs_root(kn)->kernfs_rwsem)
 {
@@ -506,6 +506,8 @@ static void kernfs_drain(struct kernfs_node *kn)
                return;

        up_write(&root->kernfs_rwsem);
+       if (drop_supers)
+               up_read(&root->kernfs_supers_rwsem);

        if (kernfs_lockdep(kn)) {
                rwsem_acquire(&kn->dep_map, 0, 0, _RET_IP_);
@@ -524,6 +526,8 @@ static void kernfs_drain(struct kernfs_node *kn)
        if (kernfs_should_drain_open_files(kn))
                kernfs_drain_open_files(kn);

+       if (drop_supers)
+               down_read(&root->kernfs_supers_rwsem);
        down_write(&root->kernfs_rwsem);
 }

@@ -1465,7 +1469,7 @@ void kernfs_show(struct kernfs_node *kn, bool show)
                kn->flags |=3D KERNFS_HIDDEN;
                if (kernfs_active(kn))
                        atomic_add(KN_DEACTIVATED_BIAS, &kn->active);
-               kernfs_drain(kn);
+               kernfs_drain(kn, false);
        }

        up_write(&root->kernfs_rwsem);
@@ -1530,7 +1534,7 @@ static void __kernfs_remove(struct kernfs_node *kn)
                 */
                kernfs_get(pos);

-               kernfs_drain(pos);
+               kernfs_drain(pos, true);
                parent =3D kernfs_parent(pos);
                /*
                 * kernfs_unlink_sibling() succeeds once per node.  Use it

