Return-Path: <linux-fsdevel+bounces-7898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C1D82C876
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jan 2024 01:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02671F2271A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jan 2024 00:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0627107A6;
	Sat, 13 Jan 2024 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEOC2OeI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4321DA5F;
	Sat, 13 Jan 2024 00:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EACFC433F1;
	Sat, 13 Jan 2024 00:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705107033;
	bh=pfdjHlc34Ggp8MtnAo8+a9gm20lTD0y1NPMB984TS5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AEOC2OeIgJWORoNggX2s3ubvbGWWUSILtQ10fdulphVoZokeuz3ef5roZFFJGoq+K
	 GsPp/iiyBiQCPF4p3qAotSu9Pi4cbJO1OWN03+m4S+ZUp3N04iYjTOdOP1DhARHuwv
	 PdC7zxWukUThkA0sMlgjSOnytQ5sygutC2IC0bDpE/B6V9vxF+sd6BVBMRxKH9mwak
	 AofUjx/i1nw4/wDjpZB6IPC00vQH4mDn7uGljXYfR3Uc38Syy2YS74xybcM83ypBie
	 SGue5mayN1JVetKMleJMnC2kDih9CDc8wvG+jiykOl5K0btdD4EF44X2SSqCbYDL+l
	 12Uzv8nv76hwQ==
Date: Fri, 12 Jan 2024 16:50:31 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: syzbot <syzbot+8f477ac014ff5b32d81f@syzkaller.appspotmail.com>
Cc: chao@kernel.org, jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [f2fs?] KASAN: slab-use-after-free Read in
 kill_f2fs_super
Message-ID: <20240113005031.GA1147@sol.localdomain>
References: <0000000000006cb174060ec34502@google.com>
 <000000000000ec3dd2060ec8e941@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ec3dd2060ec8e941@google.com>

On Fri, Jan 12, 2024 at 04:32:21PM -0800, syzbot wrote:
> loop0: detected capacity change from 0 to 63271
> F2FS-fs (loop0): Mismatch start address, segment0(512) cp_blkaddr(605)
> F2FS-fs (loop0): Can't find valid F2FS filesystem in 1th superblock
> F2FS-fs (loop0): invalid crc value
> F2FS-fs (loop0): SIT is corrupted node# 0 vs 1
> F2FS-fs (loop0): Failed to initialize F2FS segment manager (-117)
> ==================================================================
> BUG: KASAN: slab-use-after-free in destroy_device_list fs/f2fs/super.c:1606 [inline]
> BUG: KASAN: slab-use-after-free in kill_f2fs_super+0x618/0x690 fs/f2fs/super.c:4932
> Read of size 4 at addr ffff888023bdd77c by task syz-executor275/5046

Sorry, this is my fault.  I'll fix this.

- Eric

