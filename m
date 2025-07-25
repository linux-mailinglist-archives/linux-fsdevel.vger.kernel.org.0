Return-Path: <linux-fsdevel+bounces-56006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C87B116C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 04:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D245658303A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 02:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3731C238C11;
	Fri, 25 Jul 2025 02:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nwE4Owgb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9773B1C84D0
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Jul 2025 02:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753412329; cv=none; b=GPcxLXTS3N0j6XwKPxmbC8EC5c2W107to9potPfyFWOiRocYA8kplm689b2sqAR/ca6RlQvbAucGuLZYwmBHewVQKPwazxIT+omsRLL3OB/BotnXMrbl27+BhVZ4HFUankGaW7qXX+44IdybtBv5BmUAl5bZoEIsX+iH4+ECRCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753412329; c=relaxed/simple;
	bh=5hmSVXfcBrSwWilRT6Y76WJ68lJDcIquV8yQPv2yMVc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VD3EszugEL6acsdedlQ8zZsaU6cnAMuTy+I6OOg06XOwR8X62odl/O670NbnlapOHO9KinKEObHk5PhyjhoDUUYCbVi/vBbGLVP1mvfbaqBt852UTaoAehSjbihF6+QLkPS99EGgV39rQM9v6p+xdFLisSFRt5pprKTE6DWDIf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nwE4Owgb; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 24 Jul 2025 22:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753412314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=0eV7xZZ5652Fw7OIAdA9A+XLG9YgVdh72tYcpKUS7Ss=;
	b=nwE4Owgby0lnFovCVRRt63mIce5q9gAmgVaJDOqCa8NYRiIhJgXmqJNA/LrlDOMFMIMHsh
	Ls3BJgn0tPSfj7XpEVEOIaRyxSM0z+eSy1dupUzAEfJ0JEB2AiBF6WOnR9VLxys0F+OxnV
	8TMXHwF1xM4ngFgH59jBT3TRjO3ix1Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.16
Message-ID: <q57tgxvd47i7xbqwaeznpwqoa2zmccg73s3glzqj5egpv4n7tl@4frslbhlovgr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT


The following changes since commit 89edfcf710875feedc4264a6c9c4e7fb55486422:

  bcachefs: Fix bch2_maybe_casefold() when CONFIG_UTF8=n (2025-07-16 17:32:33 -0400)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-07-24

for you to fetch changes up to c37495fe3531647db4ae5787a80699ae1438d7cf:

  bcachefs: Add missing snapshots_seen_add_inorder() (2025-07-24 22:56:37 -0400)

----------------------------------------------------------------
bcachefs fixes for v6.16

User reported fixes:

- Fix btree node scan on encrypted filesystems by not using btree node
  header fields encrypted

- Fix a race in btree write buffer flush; this caused EROs primarily
  during fsck for some people

----------------------------------------------------------------
Kent Overstreet (3):
      bcachefs: btree_node_scan: don't re-read before initializing found_btree_node
      bcachefs: Fix write buffer flushing from open journal entry
      bcachefs: Add missing snapshots_seen_add_inorder()

 fs/bcachefs/btree_node_scan.c | 16 ++++++++--------
 fs/bcachefs/fsck.c            | 11 ++++++-----
 fs/bcachefs/journal.c         |  1 +
 3 files changed, 15 insertions(+), 13 deletions(-)

