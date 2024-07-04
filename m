Return-Path: <linux-fsdevel+bounces-23166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1780F927E89
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 23:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86E71B22EC2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 21:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6908F143862;
	Thu,  4 Jul 2024 21:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="e2Ryhnwc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43B7C2ED;
	Thu,  4 Jul 2024 21:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720128527; cv=none; b=BihEFH8n0rFbjHOB8p9nZqe1OVOjEL5AsdK9MJKer83nkoBXkVVqdt9RwqbZ94uhjNqdf9ymduME7f8rbC7AhKjhThpTDqW6f974oqwFcStDC79iXGHw7baBffyh5fn0eSPLEGr4AQ3/WBMVB9sgYooHtF1OT7kP40K75wi/u+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720128527; c=relaxed/simple;
	bh=2qj+dUg+yyWMiMbBXBUwi14q3KfTSmV7ohWQBkf4O/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRpZ9A5u8rWhIRla/1s61/P4NR0q0jXGIApBC+Jn6FRLRVTqYqje7JTtldlnvmjQHP3o54o8FrHqe1CjO/d4D3ZKOTQPBIFdFovxgebl+dthjJapXNivDAZApGgoGgD4xFTxRbjGIPyJGfa8snifrSDlJv9Ezfw/eTqzk0yIyAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=e2Ryhnwc; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WFVBX0DWkz9sST;
	Thu,  4 Jul 2024 23:28:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1720128516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LCjoDPUbBuAc5cYe3hsTKSsm/SW417S4g2RIPjxg9Qs=;
	b=e2RyhnwcEB/2WIfuol6lyKxOGyvhqnPGS21glSV6Cjyg8Uli24x7nPVYoWmgChLIpXzt11
	bRMLi8MpZDZ0HD50MBBL7rm06NW6MBiq8+8uLOxZ1tmQMou8vDRgTjPutIw2Pn9/567LYg
	jVOAhGtXQa4M0/OZg47XF0gfDctcl87am4R2jjeJC23a2/Hr7o5oY4wIG3Ft8pp7WGcs2q
	8Pis0O1xGuojt3wg9lSdy7Y9NGxiutrAVgRURv1rKSJr74bQGZc6gsssIzQnGOnOTyc/tk
	nBedjImbJdAf0W4JefXXg/uAa420yBC9BL1SAi5895iJp2Zn9Lyf9LnsF5wDoQ==
Date: Thu, 4 Jul 2024 21:28:30 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>, david@fromorbit.com,
	chandan.babu@oracle.com, djwong@kernel.org, brauner@kernel.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com, linux-mm@kvack.org,
	john.g.garry@oracle.com, linux-fsdevel@vger.kernel.org,
	hare@suse.de, p.raghav@samsung.com, mcgrof@kernel.org,
	gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 01/10] fs: Allow fine-grained control of folio sizes
Message-ID: <20240704212830.xtakuw57wonas42u@quentin>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-2-kernel@pankajraghav.com>
 <cb644a36-67a7-4692-b002-413e70ac864a@arm.com>
 <Zoa9rQbEUam467-q@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zoa9rQbEUam467-q@casper.infradead.org>

On Thu, Jul 04, 2024 at 04:20:13PM +0100, Matthew Wilcox wrote:
> On Thu, Jul 04, 2024 at 01:23:20PM +0100, Ryan Roberts wrote:
> > > -	AS_LARGE_FOLIO_SUPPORT = 6,
> > 
> > nit: this removed enum is still referenced in a comment further down the file.
Good catch.
> 
> Thanks.  Pankaj, let me know if you want me to send you a patch or if
> you'll do it directly.
Yes, I will fold the changes.
> 
> > > +static inline void mapping_set_folio_order_range(struct address_space *mapping,
> > > +						 unsigned int min,
> > > +						 unsigned int max)
> > > +{
> > > +	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> > > +		return;
> > > +
> > > +	if (min > MAX_PAGECACHE_ORDER)
> > > +		min = MAX_PAGECACHE_ORDER;
> > > +	if (max > MAX_PAGECACHE_ORDER)
> > > +		max = MAX_PAGECACHE_ORDER;
> > > +	if (max < min)
> > > +		max = min;
> > 
> > It seems strange to silently clamp these? Presumably for the bs>ps usecase,
> > whatever values are passed in are a hard requirement? So wouldn't want them to
> > be silently reduced. (Especially given the recent change to reduce the size of
> > MAX_PAGECACHE_ORDER to less then PMD size in some cases).
> 
> Hm, yes.  We should probably make this return an errno.  Including
> returning an errno for !IS_ENABLED() and min > 0.
> 

Something like this? (I also need to change the xfs_icache.c to
use this return value in the last patch)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 14e1415f7dcf..04916720f807 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -390,28 +390,27 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
  * Context: This should not be called while the inode is active as it
  * is non-atomic.
  */
-static inline void mapping_set_folio_order_range(struct address_space *mapping,
+static inline int mapping_set_folio_order_range(struct address_space *mapping,
                                                 unsigned int min,
                                                 unsigned int max)
 {
        if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
-               return;
+               return -EINVAL;
 
-       if (min > MAX_PAGECACHE_ORDER)
-               min = MAX_PAGECACHE_ORDER;
-       if (max > MAX_PAGECACHE_ORDER)
-               max = MAX_PAGECACHE_ORDER;
+       if (min > MAX_PAGECACHE_ORDER || max > MAX_PAGECACHE_ORDER)
+               return -EINVAL;
        if (max < min)
                max = min;
 
        mapping->flags = (mapping->flags & ~AS_FOLIO_ORDER_MASK) |
                (min << AS_FOLIO_ORDER_MIN) | (max << AS_FOLIO_ORDER_MAX);
+       return 0;
 }
 
-static inline void mapping_set_folio_min_order(struct address_space *mapping,
+static inline int mapping_set_folio_min_order(struct address_space *mapping,
                                               unsigned int min)
 {
-       mapping_set_folio_order_range(mapping, min, MAX_PAGECACHE_ORDER);
+       return mapping_set_folio_order_range(mapping, min, MAX_PAGECACHE_ORDER);
 }
 
 
@@ -428,6 +427,10 @@ static inline void mapping_set_folio_min_order(struct address_space *mapping,
  */
 static inline void mapping_set_large_folios(struct address_space *mapping)
 {
+       /*
+        * The return value can be safely ignored because this range
+        * will always be supported by the page cache.
+        */
        mapping_set_folio_order_range(mapping, 0, MAX_PAGECACHE_ORDER);
 }

 --
 Pankaj

