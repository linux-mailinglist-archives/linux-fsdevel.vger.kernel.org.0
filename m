Return-Path: <linux-fsdevel+bounces-26354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 229679581F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 11:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54C5D1C23D58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 09:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFAE18C32E;
	Tue, 20 Aug 2024 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="1TpC3XNR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BEF18991B;
	Tue, 20 Aug 2024 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724145498; cv=none; b=hTlko+BQpGReLGDEQ6aduQb1XrMo0t5S0OCoA9FaRXgTJGSTngZeaMfxDssCeAho5B40YBFKvBrcSnuevMuRM2QVcf4FV1nttJLdKcjhVbF0K+ro5kh0mj5ROmKoMMyljtM++hZP3eD/7ETqwvfY4Gl4pReFlKdvevAMCQ8HMCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724145498; c=relaxed/simple;
	bh=bW0QWsueAOcspiCecWtg2SVyi4gHSZ6HSezrXT5+Pyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjfpbO33iONiwsFAfXLXC+x0eo4wlyu4wl7qOyGFw7GiHXq6FTnAr2T1BwT9SfTsGOJjmykcTNCn1UECipRNMg869QXdL/cAbjIkFhcNzRl5CvO7Itw/byV7tSYiHXvOpiE1ZhNgwW6FRyoNm7GzBAll+5p1w/ubjoqWj37eQ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=1TpC3XNR; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Wp3lz2FtCz9sbL;
	Tue, 20 Aug 2024 11:18:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1724145487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f+ICdms72HfoF4mAv99/z3Z6CJn/38fKcvyPjiB+emU=;
	b=1TpC3XNRabaGO7N5sW4gKUNX5AldqRHL0F+Q59ySDOOMW11dpqYvmdHXKrjFzE9+kEuAZc
	xD7L+OQgpO1UWy0xxTYs0ehlCqmrkOSejl8Sm3hgg0pwypovKKLdlPC/yO9YEUWCttiG55
	585Ut50eLrkQdYnUR3ZqzFFJnbXHKWs/A4N4A1YpvDJWifoBUhRebkRmuajq9lQ5LZSKH3
	Btk12vH/oJvaKJsnGa20r52My7EROT0wIyldnP6WuodgZr9oQp+zzd5CpdUeCOABlVJ6Fk
	olyyXoEJURraAgRQFMmi/973uUUnaxScwem2gEIjqq1nD6LuiZXVyiVaIwY4Cg==
Date: Tue, 20 Aug 2024 09:17:59 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: David Howells <dhowells@redhat.com>
Cc: brauner@kernel.org, akpm@linux-foundation.org, chandan.babu@oracle.com,
	linux-fsdevel@vger.kernel.org, djwong@kernel.org, hare@suse.de,
	gost.dev@samsung.com, linux-xfs@vger.kernel.org, hch@lst.de,
	david@fromorbit.com, Zi Yan <ziy@nvidia.com>,
	yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, willy@infradead.org, john.g.garry@oracle.com,
	cl@os.amperecomputing.com, p.raghav@samsung.com, mcgrof@kernel.org,
	ryan.roberts@arm.com
Subject: Re: [PATCH v12 00/10] enable bs > ps in XFS
Message-ID: <20240820091759.vogo5uxaldvik2u2@quentin>
References: <20240819163938.qtsloyko67cqrmb6@quentin>
 <20240818165124.7jrop5sgtv5pjd3g@quentin>
 <20240815090849.972355-1-kernel@pankajraghav.com>
 <2924797.1723836663@warthog.procyon.org.uk>
 <3402933.1724068015@warthog.procyon.org.uk>
 <3458347.1724092844@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3458347.1724092844@warthog.procyon.org.uk>

On Mon, Aug 19, 2024 at 07:40:44PM +0100, David Howells wrote:
> Pankaj Raghav (Samsung) <kernel@pankajraghav.com> wrote:
> 
> > I tried this code on XFS, and it is working as expected (I am getting
> > xxxx).
> 
> XFS doesn't try to use mapping_set_release_always().

Thanks David for digging deep. It is indeed a bug in this patchset
(PATCH 1). I think I overlooked the way we MASK the folio order bits
when we changed it sometime back. 

But still I don't know why AS_RELEASE_ALWAYS is being cleared because it
is in BIT 6, and existing bug should not affect BIT 6.

The following triggers an ASSERT failure.

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 0fcf235e5023..35961d73d54a 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -88,9 +88,13 @@ xfs_inode_alloc(
 
        /* VFS doesn't initialise i_mode! */
        VFS_I(ip)->i_mode = 0;
+       mapping_set_unevictable(VFS_I(ip)->i_mapping);
        mapping_set_folio_min_order(VFS_I(ip)->i_mapping,
                                    M_IGEO(mp)->min_folio_order);
 
+       ASSERT(mapping_unevictable(VFS_I(ip)->i_mapping) == 1);
+
+       mapping_clear_unevictable(VFS_I(ip)->i_mapping);
        XFS_STATS_INC(mp, vn_active);
        ASSERT(atomic_read(&ip->i_pincount) == 0);
        ASSERT(ip->i_ino == 0);

The patch that fixes this is:

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 61a7649d86e5..5e245b8dcfd6 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -217,6 +217,7 @@ enum mapping_flags {
 #define AS_FOLIO_ORDER_MASK     ((1u << AS_FOLIO_ORDER_BITS) - 1)
 #define AS_FOLIO_ORDER_MIN_MASK (AS_FOLIO_ORDER_MASK << AS_FOLIO_ORDER_MIN)
 #define AS_FOLIO_ORDER_MAX_MASK (AS_FOLIO_ORDER_MASK << AS_FOLIO_ORDER_MAX)
+#define AS_FOLIO_ORDER_MIN_MAX_MASK (AS_FOLIO_ORDER_MIN_MASK | AS_FOLIO_ORDER_MAX_MASK)
 
 /**
  * mapping_set_error - record a writeback error in the address_space
@@ -418,7 +419,7 @@ static inline void mapping_set_folio_order_range(struct address_space *mapping,
        if (max < min)
                max = min;
 
-       mapping->flags = (mapping->flags & ~AS_FOLIO_ORDER_MASK) |
+       mapping->flags = (mapping->flags & ~AS_FOLIO_ORDER_MIN_MAX_MASK) |
                (min << AS_FOLIO_ORDER_MIN) | (max << AS_FOLIO_ORDER_MAX);
 }
 
Could you try this patch and see if it fixes it by any chance?

--
Pankaj

