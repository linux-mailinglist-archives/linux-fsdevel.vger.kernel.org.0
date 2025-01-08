Return-Path: <linux-fsdevel+bounces-38679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3D1A066FC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 22:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8FD188A8AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 21:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4DF204C23;
	Wed,  8 Jan 2025 21:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CZN9f/Wv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C096A1DE895;
	Wed,  8 Jan 2025 21:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736370635; cv=none; b=o2UEyeHMpRt5Bp1MQxOs2p205E7JCp1G+YkE7Z3kgl/NlfYNg2I4UfjZ8knBnRd0o4avSqB2sDo0SET2WqDod9ioG326vv7SxcF7UWha9h2Q/d2/863MuAFqxPFnvY/f9Pg8tw1DBZMO0ZHkhcuL4walb4dQrr60LiI98pb/Xew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736370635; c=relaxed/simple;
	bh=F8n7cc4Vwt/9MjqzfNdPndxuVgACUFFn0m6jL1eVyPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WqKopoLRmyweLokJmR5k/Af26j9gLgY7c1QiQrrQCWego7a1jmllicTKIbP4H/8wY1Tq+1QkYU2TrmrE3M8HRXZqfiwSPQvDV9XZQ4oPXNBWvVSom928a08LC0DsEPAA7xBjarJ72JpcD3sUcE9elv0M32dLGCZYmAX+MlVQN0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CZN9f/Wv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=CKW/yOskOtSSl6vIB/TxBvV3Sm9GQvwL6+JZhA4PW2M=; b=CZN9f/WvicOGT/3z0krFB2VzzK
	ON86UapiD2qzfacKSUwGXyrAg7j61mlNG7gJctJW8nIxq9hLrpnOL9RlnGd5b24fmzsLFW6veftyb
	4Daw4eKlESfkvE9QL5IS9kGYLOUuZ0LzptJ4N8z1YCOwMaMn5veGV1P6ip7DdlyIm8uFBICDTQ+4p
	TEEhA61/RiIzcMa3+0xBFpMqH4dtwHwnb7S/3olDjFNieYE3nsJy1AQj5sTEE93aBLzLISxg7EfWl
	o7Tj/MOCqNLgZOR/3vCh0gotxhgzk6ZfG1pPfPVPp6Wd4ZprsesksWN9gpDRFbM5o/Uws5PsBRiQB
	8wV2nM1w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tVdJt-00000002qqd-28CK;
	Wed, 08 Jan 2025 21:10:29 +0000
Date: Wed, 8 Jan 2025 21:10:29 +0000
From: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: State Of The Page (January 2025)
Message-ID: <Z37pxbkHPbLYnDKn@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

As the calendar turns, I'd like to lay out some goals for the coming year.
I think we can accomplish a big goal this year; transitioning from the
Ottawa interpretation of struct folio to the New York interpretation.

The tension between the two interpretations of folio go back to the
initial discussions.  The Ottawa interpretation is simply "A folio is
a non-tail page".  The New York interpretation is "A folio is its own
data structure which refers to one or more pages".  We agreed to start
with the Ottawa interpretation and later transition to the New York
interpretation once we were sufficiently far through the conversion
process, and I think that time has come.

We've made some mistakes (and deliberately done some things which won't
work any more).  That's OK; it's just software and we can change it.
The biggest change that I think will affect users is that it will no
longer be the case that all pages are part of a folio.  Some pages will
belong to a slab or a ptdesc or some other memdesc.  Some pages will be
"bare" and not belong to any memdesc.

For example, page_folio() is going to return NULL if the page does
not belong to a folio.  Some APIs will redirect silently; for example,
calling put_page() on a page belonging to a folio will decrement the
folio's refcount, not the page's refcount.  Calling compound_head()
will only work on "bare" pages; calling it on a page which belongs to
a folio/slab/... will be a BUG().

I think it's a reasonable goal to shrink struct page to (approximately):

struct page {
    unsigned long flags;
    union {
        struct list_head buddy_list;
        struct list_head pcp_list;
        struct {
            unsigned long memdesc;
            int _refcount;
        };
    };
    union {
        unsigned long private;
        struct {
            int _folio_mapcount;
        };
    };
};

This is just 32 bytes [1] which halves the size of memmap.  In order to
get to this point, we have some projects that need to be finished.

1. Remove accesses to page->index.  This project is almost complete.

2. Remove accesses to page->lru. This is really a set of many small
projects.  Some tactics can be shared between different projects, but
this really requires looking into each usage and figuring out how to
replace it.  Page migration looks particularly tricky.

3. Remove accesses to page->mapping.  In a filesystem, this is
converting to folios.  I have a plan for movable_ops (but not a plan for
its use of ->lru, so more thought needed)

4. Remove use of &folio->page.  Sometimes this is using folio_page(folio,
0) (eg bio_add_folio()) sometimes this is pushing folios into the called
function (eg block_commit_write()).

5. Remove bh->b_page as it's also effectively a cast between page & folio.
I have a git branch which finishes this project and need to send out the
patches.

6. Split the pagepool bump allocator out of struct page, as has been
done for, eg, slab and ptdesc.

7. Fix memcg_data so that slabs, folios and bare pages are each accounted
appropriately.  I've started working on this but need to reassess.


Once all these projects are completed, we can allocate folio, bump, ptdesc,
slab, zsdesc, etc separately and point to them from struct page.  Then
we can shrink struct page to the above definition.

[1] On 64-bit systems.  Just 16 bytes on 32-bit systems!  Except we
probably need to include 'virtual' to continue to support kmap() and
_last_cpupid, so maybe it ends up being 24 bytes on 32-bit and then we
just round it up to 32 so it's a power of two ...

