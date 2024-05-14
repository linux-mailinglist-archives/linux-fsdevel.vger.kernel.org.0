Return-Path: <linux-fsdevel+bounces-19466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725A08C5B1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 20:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB011B22431
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 18:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A64180A6E;
	Tue, 14 May 2024 18:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rFYgIUrd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EABA144D3E
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2024 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715711720; cv=none; b=o6qohcGXYs4l+4+fjEA8sJLgXgANLizST4MlMUK9vfRP2+lQ/NXLUf6w7V+H/koaEUEFVr9KNEC363HU1+JKO9VAOJtFq4bLHeM3XLVNfsB/DMjmd5qxiCQ9WG67AelwlMX+XjNgLIGTOohih+FKCxDqe4iVStvVKsVrb6S68yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715711720; c=relaxed/simple;
	bh=GnVp+Tx3kq7+4GBUeIQTAZopdJpxckL9lOpdMSHvNj4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EUdKWOWIKNEJuI4GTkbkanO3wWoOEgBPxwUx745u6xXyM9LjRxHSMIp5ZGTzd6Kq90nYzwCoAp78Dt2crHLKXL8amAqToTvHy+PAWqwS9PfWCQXlYnT5+5zlxS5tkwy5yBB54auPEwtgs8ZzKNtTdAwxEc2UlQGQlJPCuPVDWwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rFYgIUrd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=wLcJjnnKDYXRplZTZpbSmHLQuBfqC+5T6+PeWrMaAQk=; b=rFYgIUrdzkZr7chUXtioB+TOp1
	AD+Rk1xYpTXDxAS0r7j1CcXABf09/RaYZnZoJ930MkXHEN/h5S+vNws2bytL3dM6kykTp+98wmfa3
	AzuHNvXg8puIwxF7no+N0rl24vgRaXKMXs/GYpvAw6KMwa3oKrT+ihFaMgxkcKlnM+JeDsfYucVmu
	eAS60l9Z7x36jyitavDGwAtzOa70H71ri4fBOwungdCGeEYgiczKvTdd9qjpTktVFXnChERMGWICY
	3aqS0ZoMnbOJidQRrPTrzJZ6kdLdCqiuVfkKz79JpGhraH5hsM30o+RxcD+MzcluT/rErIyzvKiC+
	IE9oZQ/g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6wzb-00000009LvE-20vJ;
	Tue, 14 May 2024 18:35:15 +0000
Date: Tue, 14 May 2024 19:35:15 +0100
From: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: page-flags.rst
Message-ID: <ZkOu4yXP-sGGtwc4@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

As encouraged by my lively audience / collaborators, here is the
typos-and-all result of the LSFMM session which just finished.

Please don't respond to point out the typos; trust that I will fix them.


==========
Page flags
==========

Struct page includes a 'flags' word.  Despite its name, various other
things are also stored in this word, including the page's node, zone,
section, and last_cpupid.  See include/linux/page-flags-layout.h for
details.

Locked
======

This flag is per-folio.  If you attempt to lock a page, you will lock
the entire folio.  The folio lock is used for many purposes.  In the page
cache, folios are locked before reads are started and unlocked once the
read has completed.  The folio is also locked before writeback starts;
see the writeback flag for more detail.  The truncation path takes the
folio lock, and folios are also locked while being inserted into page
tables in order to prevent races between truncation and page fault.

... more detail here please ...

Writeback
=========

Per-folio
This is kind of a lock
We downgrade to it having taken the lock flag
Rekeased after wrut4back completes, but lock flag may be released any time after writeback flag set.  Deopends on filesystem whether needs to do more between
We can wait for writeback to complete by waiting on this flag
Folio put to tail of LRU for faster reclaim

Can prevent tearing write is filesystem needs stable folios
Truncate will wait for flag to clear


Referenced
==========

Per-folio flag.  At least one page table entry has a accessed bit set for this folio
We set this during scan.  Also set during buffered IO.  Referenced first time, Accessed second time.
Used during reclaim to determine dispotition (activate, reclaim, etc)

Uptodate
========

Every byte of the folio contents is at least as new as the contents of disk
implicit write bbarrier


Dirty
=====
  Also set during buffered IO.  Referenced first time, Accessed second time.
  Used during reclaim to determine dispotition (activate, reclaim, etc)
At least one byte of the folio contents is newer than on disk and the writeback flag is not yet set
folios may be both dirty and not uptodate
lazyfree pages can drop the dirty bit
dirty flag clear for file folios when we start writeback
set dirty flag when removed from swapcache
if already dirty, folios can be mapped writable without notifying filesystem
complicated interfaces to set easy to get wrong
redirty_for_writeback



LRU
===

FOlio has been added to the LRU and is no longer in percpu folio_batch


Head
====

This folio is a large folio.  It is not set on order-0 folios.


Waiters
=======

Page has waiters, check its waitqueue.
Only used by core code.  Don't touch.

Active
======

On the active LRU list.
Can be set in advance to tell kernel to put it on the right list

Workingset
==========

Set on folios in pagecache once readahead pages actually accessed
Set on LRU pages that were activated have been deactivated, treat refault as thrashing
refault handler also sets it on folios that were hot before reclaimed
used by PSI computation

Owner_Priv_1
============

Owner use. If pagecache, fs may use

Used as Checked flag by many filesystems.
Used as SwapBacked flag by swap code.

Arch_1
======

Many different uses depending on architecture.  Oftern used as a "dcache clean" or, comfusingly as "dcache dirty".  Check with your architecture.

s390 uses it for basically everything.

Historicalkly was used on a per page basis.  Think we've eliminated all per-page uses now so should only be set on folios.

Reserved
========



Private
=======

If pagecache, has fs-private data

Private_2
=========

If pagecache, has fs aux data

Mapped_to_disk
==============

Has blocks allocated on-disk

Reclaim
=======

To be reclaimed asap

Swap_backed
===========

Page is backed by RAM/swap

Unevictable
===========

Page is "unevictable"

Mlocked
=======

Page is vma mlocked

Uncached
========

Page has been mapped as uncached

HWPoison
========

hardware poisoned page. Don't touch

Young
=====

Idle
====

Arch 2
======

Arch 3
======

Readahead
=========

Aliases with Reclaim as they are usually never set on the same folio, and
if they are the consequences are a minor performance loss.

Anon_Exclusive
==============

Aliases with Mapped_To_Disk as that flag can never be set on anonymous folios.

Isolated
========

Shared with Reclaim flag, only valid for folios with LRU flag clear.

Reported
========

Only valid for buddy pages. Used to track pages that are reported

Has_HWPoisoned
==============

Large_Rmappable
===============



