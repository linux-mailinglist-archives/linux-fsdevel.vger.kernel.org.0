Return-Path: <linux-fsdevel+bounces-27561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B21F962631
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 13:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31B51F24E67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 11:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6070172BDC;
	Wed, 28 Aug 2024 11:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="mJLhydL7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B04B16D9BA;
	Wed, 28 Aug 2024 11:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724845095; cv=none; b=tFGD7awYtbvMvlrquhvJPVXJUuuxXPfZM02s79P6BR63UXn9gHrs7HW/NsDHZwsTP27J0UiVn6XhK49JQ/EmMs28i8eCLhJW3BiEzjnFIScfG+4ODhe5IrohhYhD9kGjV/RUCNiQZ51veVafpDGOWddSyxf87oKBp9iK4v6Z0/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724845095; c=relaxed/simple;
	bh=E31P5Kg44PX5FddtsdpCqwEt5trkfZRkPjofUJ7lGjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwNQtunbkDsJSQct7g2iHqBIsWT87v+OhsVWRYQQGvXeI2BBybqsMSb4F+HFaMxQHKMNEN2ZIy5Vli8cZqwKOjbGMdMntrXGSi1p1jgHPPpSVtqe02eLV7SLiCgTsRY2GkzreIVZn7OylwnRpGPtjb2NQZvqi2gvcuyb2iNn7yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=mJLhydL7; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Wv2Tr0lJSz9smc;
	Wed, 28 Aug 2024 13:38:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1724845088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M9H3cmWIhxcYHesHqGjL9yLjjaE0Sjuz4VP0wEL0R1w=;
	b=mJLhydL76GrRuW737D6RbtsIACkQniYpae63FPhyPs9Pee+QHLNrfzj/Dn6gSl2+qVcAck
	MVhc292Hk0qoYqRGPD9zpnjIJaX8d5O1yrEGSsYMHhB1+EF4LynKehX/Qv4NwsOAORThkP
	k5bWZcHdv0PyZBZcaqlBvqgtANUpntIsXofOCzDNTvyXHhr67zhJgWGQGo5atd0XckJdjA
	rR8WlNWo6KNpCx03tSIETgCaJaWlHH6X25OSelFFa9ulW6U63lsK1ZpkkPI1xPEYndn84+
	YFzGD2FOYgW6xaGMmQg8fuRa8gQKRsMbN/YCojlBlhbfJL6rkfQG9gO0UIpgVg==
Date: Wed, 28 Aug 2024 11:38:02 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Marc Dionne <marc.dionne@auristor.com>
Subject: Re: [PATCH 1/9] mm: Fix missing folio invalidation calls during
 truncation
Message-ID: <20240828113802.xw5wzlq2hxrquclb@quentin>
References: <20240823200819.532106-1-dhowells@redhat.com>
 <20240823200819.532106-2-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823200819.532106-2-dhowells@redhat.com>

On Fri, Aug 23, 2024 at 09:08:09PM +0100, David Howells wrote:
> When AS_RELEASE_ALWAYS is set on a mapping, the ->release_folio() and
> ->invalidate_folio() calls should be invoked even if PG_private and
> PG_private_2 aren't set.  This is used by netfslib to keep track of the
Should we update the comment in pagemap? 

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 55b254d951da..18dd6174e6cc 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -204,7 +204,8 @@ enum mapping_flags {
        AS_EXITING      = 4,    /* final truncate in progress */
        /* writeback related tags are not used */
        AS_NO_WRITEBACK_TAGS = 5,
-       AS_RELEASE_ALWAYS = 6,  /* Call ->release_folio(), even if no private data */
+       AS_RELEASE_ALWAYS = 6,  /* Call ->release_folio() and ->invalidate_folio,
+                                  even if no private data */
        AS_STABLE_WRITES = 7,   /* must wait for writeback before modifying
                                   folio contents */
        AS_INACCESSIBLE = 8,    /* Do not attempt direct R/W access to the mapping */

> point above which reads can be skipped in favour of just zeroing pagecache
> locally.
> 
> There are a couple of places in truncation in which invalidation is only
> called when folio_has_private() is true.  Fix these to check
> folio_needs_release() instead.
> 
> Without this, the generic/075 and generic/112 xfstests (both fsx-based
> tests) fail with minimum folio size patches applied[1].
> 
> Fixes: b4fa966f03b7 ("mm, netfs, fscache: stop read optimisation when folio removed from pagecache")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> cc: Pankaj Raghav <p.raghav@samsung.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: linux-afs@lists.infradead.org
> cc: netfs@lists.linux.dev
> cc: linux-mm@kvack.org
> cc: linux-fsdevel@vger.kernel.org
> Link: https://lore.kernel.org/r/20240815090849.972355-1-kernel@pankajraghav.com/ [1]
> ---
>  mm/truncate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 4d61fbdd4b2f..0668cd340a46 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -157,7 +157,7 @@ static void truncate_cleanup_folio(struct folio *folio)
>  	if (folio_mapped(folio))
>  		unmap_mapping_folio(folio);
>  
> -	if (folio_has_private(folio))
> +	if (folio_needs_release(folio))
>  		folio_invalidate(folio, 0, folio_size(folio));
>  
>  	/*
> @@ -219,7 +219,7 @@ bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_t end)
>  	if (!mapping_inaccessible(folio->mapping))
>  		folio_zero_range(folio, offset, length);
>  
> -	if (folio_has_private(folio))
> +	if (folio_needs_release(folio))
>  		folio_invalidate(folio, offset, length);
>  	if (!folio_test_large(folio))
>  		return true;
> 

-- 
Pankaj Raghav

