Return-Path: <linux-fsdevel+bounces-41153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DCBA2B9D9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 04:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B02F7A3318
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 03:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5F2187342;
	Fri,  7 Feb 2025 03:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WzQjTxyR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77D2186287
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Feb 2025 03:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738899729; cv=none; b=KSq/+n81Hv5MyntBfGwkbDmMOJTGxfR8uPeh4JVts4P2hEZ4BtMY4NfmUbp+/h6sh6TlSmO46LcGELxe/SoF0iE5RGI3YUUS44dhn/JvcPIMWl9khcpFbRgq17pzTMSd42wmV52TKB5xLqO1xCKIV9hEmVJNJvrtUsjpTQ0hT5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738899729; c=relaxed/simple;
	bh=7oN/H/a2w+7dGQMpc4UFYN5V0qv/VyRZqGxOjPwk8pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2ZvuL3e7Gp8JZZWI4bsjchvUNEF8Z/yVWBfeHXlaFtFzhtL15AJzhagpJOR/dnDXPlRjc4W8POMNRP/Z34Rb1Cg2TKS6HMFe9PolhRKiR9+rbRlixVeOlUk4Hz6xUTl7i3L8EKz3L8JP/hJUwVzef5ci0s72Qs44b8Y0eTX/aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WzQjTxyR; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 6 Feb 2025 22:41:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738899715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=StZ+UKenkov6NFhhanj24b643rsTU6dS/c2q5q/L9UI=;
	b=WzQjTxyRigLrNFr1UYxcK1XqgwkZ+mSHezCZAfuy53gaBwpz6HlP2bBAWF2rzD2ShnjaKd
	5UJ1/7RS4/yPi/xT1t6QIjuy3fqzcgeC6Ajo21rL5ThfxCJVr3lF7ipIn6s/GonW3RLghI
	3A/HTaKlhxbvAh9eYdCmuie+rclAJgI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.14-rc2
Message-ID: <usxj7gse2c53ow2a3fxpoi3ygsvu6shpo3huvecih577iaq3a7@os7sfywxj2vw>
References: <z2eszznjel6knkkvckjxvkp5feo5jhnwvls3rtk7mbt47znvcr@kvo6dhimlghe>
 <6491ceb6-e48b-442b-ac61-7b2b65252d7a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6491ceb6-e48b-442b-ac61-7b2b65252d7a@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 07, 2025 at 12:05:05PM +0900, Akira Yokosawa wrote:
> This caused a new warning in "make htmldocs", which was reported at:

Yep, I missed that, here's an updated pull:

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-02-06.2

for you to fetch changes up to 4be214c26936813b636eed2fac906f585ddbf0f9:

  bcachefs: bch2_bkey_sectors_need_rebalance() now only depends on bch_extent_rebalance (2025-02-06 22:35:11 -0500)

----------------------------------------------------------------
bcachefs fixes for 6.14-rc2

- add a SubmittingPatches to clarify that patches submitted for bcachefs
  do, in fact, need to be tested
- discard path now correctly issues journal flushes when needed, this
  fixes performance issues when the filesystem is nearly full and we're
  bottlenecked on copygc
- fix a bug that could cause the pending rebalance work accounting to be
  off when devices are being onlined/offlined; users should report if
  they are still seeing this
- and a few more trivial ones

----------------------------------------------------------------
Jeongjun Park (2):
      bcachefs: fix incorrect pointer check in __bch2_subvolume_delete()
      bcachefs: fix deadlock in journal_entry_open()

Kent Overstreet (4):
      bcachefs docs: SubmittingPatches.rst
      bcachefs: Fix discard path journal flushing
      bcachefs: Fix rcu imbalance in bch2_fs_btree_key_cache_exit()
      bcachefs: bch2_bkey_sectors_need_rebalance() now only depends on bch_extent_rebalance

 .../filesystems/bcachefs/SubmittingPatches.rst     | 98 ++++++++++++++++++++++
 Documentation/filesystems/bcachefs/index.rst       |  1 +
 MAINTAINERS                                        |  1 +
 fs/bcachefs/alloc_background.c                     | 47 ++++++-----
 fs/bcachefs/alloc_foreground.c                     | 10 ++-
 fs/bcachefs/alloc_types.h                          |  1 +
 fs/bcachefs/btree_key_cache.c                      |  1 -
 fs/bcachefs/buckets_waiting_for_journal.c          | 12 ++-
 fs/bcachefs/buckets_waiting_for_journal.h          |  4 +-
 fs/bcachefs/inode.h                                |  4 +-
 fs/bcachefs/journal.c                              | 18 +++-
 fs/bcachefs/journal.h                              |  1 +
 fs/bcachefs/journal_types.h                        |  1 +
 fs/bcachefs/opts.h                                 | 14 ----
 fs/bcachefs/rebalance.c                            |  8 +-
 fs/bcachefs/rebalance.h                            | 20 +++++
 fs/bcachefs/subvolume.c                            |  7 +-
 fs/bcachefs/super.c                                | 11 +++
 fs/bcachefs/super.h                                |  1 +
 fs/bcachefs/trace.h                                | 14 +++-
 20 files changed, 215 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/filesystems/bcachefs/SubmittingPatches.rst

