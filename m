Return-Path: <linux-fsdevel+bounces-58218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BD4B2B41A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 00:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCBFA4E334A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 22:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF0727D780;
	Mon, 18 Aug 2025 22:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="W/Iy0Kot"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from r3-20.sinamail.sina.com.cn (r3-20.sinamail.sina.com.cn [202.108.3.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AFB27B4FB
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 22:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755556065; cv=none; b=ZU6MnC6JrqfUo+4AQWp1KO0Jed6G/IPAsa70OA5Qg7itL/VZJsPxhvRC4cWy/aftoNLoygwki+ZpTi8HaGPyI1dxkp7P8TVYuAMTdXTpqsGRXfjH9ffYreikVCFPd9myrgFXSUmcgYyDU/Ny4cRmUCcwctzjR6U1YjknWuRfGdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755556065; c=relaxed/simple;
	bh=bCPONr1Qtyz3N9oBKepPASZ0r46Hj8tztRncVRsnHLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mII+MpWOpURehz+41nfQk+Ue9vlWLKt4zkBy9l9jMkwHeF9+t5u4CxauMkJl8CMSshdOa0++N5+zD6CbfJAs0huIVl2HQ0uz/QCQTBOxjA4dWVlJaKk2Rn54df9K+Bk/pAtwBaBBwXth7ouifm8qIgCynDSsiO2oDE9w7eHIoRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=W/Iy0Kot; arc=none smtp.client-ip=202.108.3.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1755556060;
	bh=7EghuakxsNW7L1YjQWnc7VCdy2bkOsiSmmq/lmW3TeQ=;
	h=From:Subject:Date:Message-ID;
	b=W/Iy0KotJzIlSZkh5yJObmdJjGX8E7b0DUVgx7x3pvJVivxD1ZgtFxMezsozbdRXb
	 iQnS0g1wxTy9KBKvz/9XuEsx34NuOT5XQXOWl2A9g0+4KfFw5fXo+jU8LXw2CNolZJ
	 XqZy70NIAnAvSVUGAUUuHAmI25N3n9qbzUDIB7Bg=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68A3A8D000003CC2; Mon, 19 Aug 2025 06:27:30 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2472084456675
X-SMAIL-UIID: 3C82A0469A79420784FCC32ED3925293-20250819-062730-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+1ec0f904ba50d06110b1@syzkaller.appspotmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	edumazet@google.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in sys_umount (3)
Date: Tue, 19 Aug 2025 06:27:17 +0800
Message-ID: <20250818222718.5061-1-hdanton@sina.com>
In-Reply-To: <20250818182616.GB222315@ZenIV>
References: <67555b72.050a0220.2477f.0026.GAE@google.com> <68a2f584.050a0220.e29e5.009d.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 18 Aug 2025 19:26:16 +0100 Al Viro wrote:
> On Mon, Aug 18, 2025 at 02:42:28AM -0700, syzbot wrote:
> > syzbot has found a reproducer for the following issue on:
> > 
> > HEAD commit:    8f5ae30d69d7 Linux 6.17-rc1
> > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1321eba2580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5ac3d8b8abfcb
> > dashboard link: https://syzkaller.appspot.com/bug?extid=1ec0f904ba50d06110b1
> > compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> > userspace arch: arm64
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10cba442580000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a1eba2580000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/18a2e4bd0c4a/disk-8f5ae30d.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/3b5395881b25/vmlinux-8f5ae30d.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/e875f4e3b7ff/Image-8f5ae30d.gz.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/43186d9e448c/mount_0.gz
> >   fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=174ba442580000)
> > 
> > The issue was bisected to:
> > 
> > commit d15121be7485655129101f3960ae6add40204463
> > Author: Paolo Abeni <pabeni@redhat.com>
> > Date:   Mon May 8 06:17:44 2023 +0000
> > 
> >     Revert "softirq: Let ksoftirqd do its job"
> 
> Would be interesting to see how it behaves on 

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git  fixes

