Return-Path: <linux-fsdevel+bounces-78821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fshpEnPeomkV7gQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 13:24:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8041A1C2ED1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 13:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DBD930579F5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 12:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F5C42E011;
	Sat, 28 Feb 2026 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="gXWm8Zoo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC61D421EE9;
	Sat, 28 Feb 2026 12:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772281449; cv=pass; b=IeKrkyi6ghCkgcWnnTm1yyTCXtHyw5c833MFZvkXWnZiYbtHAaFKvL4ofnb1MUykbJnjkxdmjvoXN7YBRree8rfHzrVPCdS8EgyqhdfMnSw2/CHtBEeWfnewko5OTlNh8jupNeeG+W1050kH0NROHKgT6E+iHkxuw12qpL3mMys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772281449; c=relaxed/simple;
	bh=6dS/OIgCfyCZ+kHtaLUUQtXd8Z0I10Jf8yVK3BnC+MI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q3EKXpx6DnpPKck9FyNIMhLVY2R+SnPlhPkR5MnpurRPPPCr2U5n5ia1U3FYDdRe/wGHUL8fj+SjgT6j3FooIrK9Js/EWFmjbhIV1NPAM1CWUrNFD9Jl5fFaf5CYnbRZujiZJfZjpgRQZNJpQ67ndcODW1tGiHp6OeOH2q18X8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=gXWm8Zoo; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1772281395; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=S5dgthWOjMRoWopu0CGOWX+Pd0aGgcGTIs92IUJWtZR+qx4+Qxlty58F3GGtlnVvWnf/Oli8lWFf3ppeC39UYSaoAAmdTt2XJGGd4LUv5o7MmC5jpoyz21pALNM0C07YyzhRLrEvx/sCLJ94tZt5elxGxNgoo7skBkTKVmLhu4I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772281395; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dathoMQYQLLUmWgAm2lFK+0XfU5hhMcL0hHArASgeAs=; 
	b=L2wA+i0FV+/OhbIukZAnvqUfhZ0uHOTHJwJt1ueVA1aVSLgthsQpDbUFrUD0PofUazi4r/2YKqXRM2cVo9eF8eyqmzVDMTkad7rYyT8K/nYPtvCCoOnyPhGDXRqQAeEHzrsLqGhYSIBqlXQ2nRE4tHduxf4BcrNLvsQF3iQ2l80=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772281395;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=dathoMQYQLLUmWgAm2lFK+0XfU5hhMcL0hHArASgeAs=;
	b=gXWm8Zoojmb8YhaRThmkgejBrvLFj5h4TRC1XQ0DvNNCgCjhG90lxR4NrUHaPkNG
	ZVSVgaNwdvYdpPEzfY/s0FkdwNpdWyl2WjrHCJ9jRZMZ2fhfHRIADJzv2dlYXeuh/vE
	fLcsXnrn1fVnrsFrKqHwHOnZs9831/ypbeWEdsbs=
Received: by mx.zohomail.com with SMTPS id 17722813923651004.4712770875861;
	Sat, 28 Feb 2026 04:23:12 -0800 (PST)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: janak@mpiricsoftware.com,
	janak@mpiric.us,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH v5 0/2] hfsplus: prevent b-tree allocator corruption
Date: Sat, 28 Feb 2026 17:53:03 +0530
Message-Id: <20260228122305.1406308-1-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mpiricsoftware.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mpiricsoftware.com:s=mpiric];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[mpiricsoftware.com,mpiric.us,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78821-lists,linux-fsdevel=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shardul.b@mpiricsoftware.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mpiricsoftware.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mpiricsoftware.com:mid,mpiricsoftware.com:dkim]
X-Rspamd-Queue-Id: 8041A1C2ED1
X-Rspamd-Action: no action

Hi all,

This series addresses a Syzkaller-reported vulnerability where fuzzed
HFS+ images mark the B-tree Header Node (Node 0) as free in the
allocation bitmap. This violates a core filesystem invariant and
leads to allocator corruption and kernel panics.

To fix this safely and cleanly, the series is split into two parts:

Patch 1 introduces a unified API for B-tree map record access
(struct hfs_bmap_ctx, hfs_bmap_test_bit, and hfs_bmap_clear_bit) and
refactors the boilerplate kmap_local_page() logic out of
hfs_bmap_alloc() and hfs_bmap_free().
Patch 2 utilizes this new API to perform a mount-time validation of
Node 0, forcing a safe read-only mount if structural or bit-level
corruption is detected.

Note on Allocator Optimization: Following discussions in v4, there is
a recognized opportunity to optimize hfs_bmap_alloc() from a first-fit
to a next-fit allocator by caching an in-core allocation hint (roving
pointer) and bounding the scan with tree->node_count. To keep the
scope of this series strictly aligned with the Syzkaller corruption
fix, that architectural optimization is deferred to a separate,
follow-up patchset/thread.

Link: https://lore.kernel.org/all/20260226091235.927749-1-shardul.b@mpiricsoftware.com/

v5:
 - API Encapsulation: Introduced struct hfs_bmap_ctx to cleanly bundle
   offset, length, and page index state instead of passing multiple
   pointers, addressing reviewer feedback.

 - Bit-Level Helpers: Added hfs_bmap_test_bit() and hfs_bmap_clear_bit()
   to safely encapsulate mapping/unmapping for single-bit accesses
   (like the mount-time check and node freeing).

 - Performance Retention: Retained the page-level mapping approach for
   the linear scan inside hfs_bmap_alloc() to prevent the severe
   performance regression of mapping/unmapping on a per-byte basis,
   while refactoring it to use the new ctx struct.

 - Hexagon Overflow Fix: Fixed a 0-day Kernel Test Robot warning on
   architectures with 256KB page sizes by upgrading the offset variables
   in the new struct hfs_bmap_ctx to unsigned int, preventing 16-bit shift
   overflows.
   Link: https://lore.kernel.org/all/202602270310.eBmeD8VX-lkp@intel.com/

 - Map Record Spanning: Added a byte_offset parameter to the page mapper
   to correctly handle large map records that span across multiple 4KB
   pages.

 - Loop Mask Revert: Reverted the 0x80 bitmask in the alloc() inner loop
   back to its original state (and dropped the HFSPLUS_BTREE_NODE0_BIT
   macro), as it represents a generic sliding mask, not specifically
   Node 0.

 - String Array Cleanup: Replaced the verbose switch(id) block in the
   mount validation with a clean static array of constant strings for
   the CNID names, per reviewer feedback.

v4:
 - Split the changes into a 2-patch series (Refactoring + Bug Fix).
 - Extracted map node traversal into a generic helper (hfs_bmap_get_map_page)
   as per Slava's feedback, replacing manual offset/page management.
 - Added node-type validation (HFS_NODE_HEADER vs HFS_NODE_MAP) inside the
   helper to defend against structurally corrupted linkages.
 - Replaced hardcoded values with named macros (HFSPLUS_BTREE_NODE0_BIT, etc).
 - Handled invalid map offsets/lengths as corruption, continuing the mount
   as SB_RDONLY instead of failing it completely to preserve data recovery.

v3:
  - Moved validation logic inline into hfs_btree_open() to allow
    reporting the specific corrupted tree ID.
  - Replaced custom offset calculations with existing hfs_bnode_find()
    and hfs_brec_lenoff() infrastructure to handle node sizes and
    page boundaries correctly.
  - Removed temporary 'btree_bitmap_corrupted' superblock flag; setup
    SB_RDONLY directly upon detection.
  - Moved logging to hfs_btree_open() to include the specific tree ID in
    the warning message
  - Used explicit bitwise check (&) instead of test_bit() to ensure
    portability. test_bit() bit-numbering is architecture-dependent
    (e.g., bit 0 vs bit 7 can swap meanings on BE vs LE), whereas
    masking 0x80 consistently targets the MSB required by the HFS+
    on-disk format.

v2:
  - Fix compiler warning about comparing u16 bitmap_off with PAGE_SIZE which
can exceed u16 maximum on some architectures
  - Cast bitmap_off to unsigned int for the PAGE_SIZE comparison to avoid
tautological constant-out-of-range comparison warning.
  - Link: https://lore.kernel.org/oe-kbuild-all/202601251011.kJUhBF3P-lkp@intel.com/

Shardul Bankar (2):
  hfsplus: refactor b-tree map page access and add node-type validation
  hfsplus: validate b-tree node 0 bitmap at mount time

 fs/hfsplus/btree.c         | 222 +++++++++++++++++++++++++++++--------
 include/linux/hfs_common.h |   2 +
 2 files changed, 177 insertions(+), 47 deletions(-)

-- 
2.34.1


