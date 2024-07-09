Return-Path: <linux-fsdevel+bounces-23427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DAE92C291
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 19:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B01280E74
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 17:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE1F17B024;
	Tue,  9 Jul 2024 17:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="xRzT21ty"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9DD1B86CC;
	Tue,  9 Jul 2024 17:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720546401; cv=none; b=VJCNzRlIvgS5MH9oBQlg0E3ZIuzyJ0F5XVFBrsUhoEaMBa9RPZuPbMEEOZJ83NCzinuh5ZIp8X+6FioCf+A5icMvOFCpo4epJMf7PL75OoNEUFNn4vafW5ioyMskJTlRHx5kSu1r6XAMlHccuks7248ZKxpB2+sl8OAFEzxeKV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720546401; c=relaxed/simple;
	bh=ZM+OBPrcg7vNs0vpgUX3mtKe5N2ys9P0YoCnGWxTrzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lu00rVRXZQm3XG213G5ES0G9zuiAOjqmLMW5wriLcqZYFN9sUc349Tm5bDv2j1lGpn50wY/Xu5abNcIQxz4SsEjgZ0L3B7ZxvvcUR1t42rmTPJLfPHo9G5k7CS8fxv75T17hkxkf+fc5TPbFxpJgZrr3Cv9pCfSBzR+MB2lUfns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=xRzT21ty; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WJSkZ1hfCz9sRn;
	Tue,  9 Jul 2024 19:33:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1720546390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=otfm4nHuOCKVaItEE8eENwKYWnrlA+AT8ngghD3F3L4=;
	b=xRzT21tyRcASI0eQu22uFyLR34eYoEgDyWGw9mNDmWbUU19vbgvCF4NPSvzMJzm0KASsE0
	ngMaRu29aTevKrpoLqeVn4XSTNLiSWOpWiVDnTdpQvAs8N0qnENPWdqrjFx+bBE1R4sirp
	42fC/aYNhDAIPdFPmGs7exdty1NNYomPB8ldxGbraDzcFsVhbzIiyBlePiWqB4OZ7jB73E
	gvf7QptuHX+XhEuI/PsWozith2J81Uy/MfiLt8LdX8ia8QmeXkpWSsrDJbbzotn3mqU8bi
	RZKMiDy5yoqjN3fh8qJel/vrug1AjhLq5C2ci3aoPElDMDtlPN7eHvKQMqv4Ow==
Date: Tue, 9 Jul 2024 17:33:05 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: david@fromorbit.com, ryan.roberts@arm.com, djwong@kernel.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de, Zi Yan <zi.yan@sent.com>,
	akpm@linux-foundation.org, chandan.babu@oracle.com
Subject: Re: [PATCH v8 01/10] fs: Allow fine-grained control of folio sizes
Message-ID: <20240709173305.gb3ffmlja72ypgsd@quentin>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-2-kernel@pankajraghav.com>
 <20240709162907.gsd5nf33teoss5ir@quentin>
 <Zo1neJYABzuMEvTO@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo1neJYABzuMEvTO@casper.infradead.org>

On Tue, Jul 09, 2024 at 05:38:16PM +0100, Matthew Wilcox wrote:
> On Tue, Jul 09, 2024 at 04:29:07PM +0000, Pankaj Raghav (Samsung) wrote:
> > +++ b/include/linux/pagemap.h
> > @@ -394,13 +394,24 @@ static inline void mapping_set_folio_order_range(struct address_space *mapping,
> >                                                  unsigned int min,
> >                                                  unsigned int max)
> >  {
> > -       if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> > +       if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> > +               VM_WARN_ONCE(1, 
> > +       "THP needs to be enabled to support mapping folio order range");
> >                 return;
> > +       }
> 
> No.  Filesystems call mapping_set_folio_order_range() without it being
> conditional on CONFIG_TRANSPARENT_HUGEPAGE.  Usually that takes the
> form of an unconditional call to mapping_set_large_folios().

Ah, you are right.

Actually thinking more about it, we don't need VM_WARN_ONCE on
CONFIG_THP IS_ENABLED, because if we go the route where a FS will
call something like `mapping_max_folio_order_supported()` during mount
time, that will already return `0` as the maximum order that will be
supported.

So just something like this should be enough:
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 14e1415f7dcf..ef6b13854385 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -397,10 +397,18 @@ static inline void mapping_set_folio_order_range(struct address_space *mapping,
        if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
                return;
 
-       if (min > MAX_PAGECACHE_ORDER)
+       if (min > MAX_PAGECACHE_ORDER) {
+               VM_WARN_ONCE(1, 
+       "min order > MAX_PAGECACHE_ORDER. Setting min_order to MAX_PAGECACHE_ORDER");
                min = MAX_PAGECACHE_ORDER;
-       if (max > MAX_PAGECACHE_ORDER)
+       }
+
+       if (max > MAX_PAGECACHE_ORDER) {
+               VM_WARN_ONCE(1, 
+       "max order > MAX_PAGECACHE_ORDER. Setting max_order to MAX_PAGECACHE_ORDER");
                max = MAX_PAGECACHE_ORDER;
+       }
+
        if (max < min)
                max = min;

If we have a helper such as mapping_max_folio_order_supported() that
could be invoked by FSs to see what page cache could support.

And FSs that call mapping_set_large_folios() as an optimization will not
see these random WARNINGS because we call this function with the actual
min and max range.

Let me know what you think.

--
Pankaj

