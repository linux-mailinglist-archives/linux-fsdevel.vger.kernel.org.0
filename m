Return-Path: <linux-fsdevel+bounces-40541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8E3A24BF7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2025 23:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A33563A531B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2025 22:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2930F153BF8;
	Sat,  1 Feb 2025 22:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Xdfg0DXp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FD813D502
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Feb 2025 22:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738450617; cv=none; b=kRBFR4o04jZf/nfGUM+WlAX1kTjsG9rbdiXPAtZsAd1yS3nuaptwbxhUuFBVKYKi9e/FHQZfWynJnvByHBZXmOfA07oZAKe/kKtl/Rjpv63VXKf/13t4+fjRtbpbXPUHhe0FShCxJ+FZI0EFQPSTYqbA1DN5RSK2Cc88KmKVW3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738450617; c=relaxed/simple;
	bh=VW+IkI/nqRPUix2rDIsMZ5CV9itcjRxcmeaKcSIKQgI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HPWMfPJbCLRreP+KtalXVo+1RCvwOo2hUeEix7ydwhGCLg6vXrXICV2p1RaHuvTlEe59BpCtcJIXG7Rd7VyrF3k1csp1ayH+/uYjmVz3neD6RxEtw/Xbt+LqkGHoLUshfiu0TilT6E64I8cYivLUYhFiQF3kmdDGJJospBnJxfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Xdfg0DXp; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=gWIpgwd7WtlTAVS67eOfADMnDimWkdslvHIx5fF8hVA=; b=Xdfg0DXpou9/DiHA8/hhz36WRL
	OfaLnI0qh2aRKhtYINFF88OI7xWafKUOXglFMdAZA7gAMFz1U4tIFCewRR1yDwJZ2WYLP/ThSI40u
	a9uybiBQMtT4xoMnAQd5b6Fpf97li4BG/PTKQApX5NOwkENpxsUcrSGUZQG29+CDpYXr1acJSkv9R
	M1f7tstCOjjXeJ8Hh9ExrvYTmp2a9kIEwoGz/Eg2ixhktRnO2IIFLYlj6kntRAOmKps7EGBOIp8np
	+HIAjTY1JK4RuLtDtc94ZNzqjlT9V2flAQWQ88OsqYvZKNLTKAEx2o8ltdebOiveijI4bkvoJNVIz
	9NGBR4fA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1teMPz-00000000SEF-1Px0;
	Sat, 01 Feb 2025 22:56:51 +0000
Date: Sat, 1 Feb 2025 22:56:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [git pull] a couple of misc vfs patches
Message-ID: <20250201225651.GZ1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

A couple of unrelated patches - one is a removal of long-obsolete
include in overlayfs (it used to need fs/internal.h, but the extern
it wanted has been moved back to include/linux/namei.h) and another
introduces convenience helper constructing struct qstr by
a NUL-terminated string.

One trivial conflict in fs/bcachefs/recovery.c - in mainline
bch2_btree_lost_data() goes from returning void to returning int,
in this branch a #define two lines before that point is removed.

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-misc

for you to fetch changes up to c1feab95e0b2e9fce7e4f4b2739baf40d84543af:

  add a string-to-qstr constructor (2025-01-27 19:25:45 -0500)

----------------------------------------------------------------
assorted stuff for this merge window

----------------------------------------------------------------
Al Viro (2):
      fs/overlayfs/namei.c: get rid of include ../internal.h
      add a string-to-qstr constructor

 fs/anon_inodes.c       |  4 ++--
 fs/bcachefs/fsck.c     |  2 +-
 fs/bcachefs/recovery.c |  2 --
 fs/bcachefs/util.h     |  2 --
 fs/erofs/xattr.c       |  2 +-
 fs/file_table.c        |  4 +---
 fs/kernfs/file.c       |  2 +-
 fs/overlayfs/namei.c   |  2 --
 include/linux/dcache.h |  1 +
 mm/secretmem.c         |  3 +--
 net/sunrpc/rpc_pipe.c  | 14 +++++---------
 11 files changed, 13 insertions(+), 25 deletions(-)

