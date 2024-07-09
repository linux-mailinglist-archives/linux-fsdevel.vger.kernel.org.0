Return-Path: <linux-fsdevel+bounces-23373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 469ED92B619
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 13:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5BBA1F21F96
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 11:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0E11581E9;
	Tue,  9 Jul 2024 11:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="dTFTeER9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91798155303;
	Tue,  9 Jul 2024 11:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523080; cv=none; b=b6yUlT2IfmyTWca4DNpLZHTIoWRskEtn8WxhAgVnjSn4u4lrerZm4KX9mXharfMFFqOL0a0LKKpYgajUTSs1av0UtlGVKpXQFmMXFqr8Ae+uEF3+8cZf+SX4MeWPauFDVzSTVHHujOyYjSMEVx19qeSSbXTTpsKuTNPV/7sDIE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523080; c=relaxed/simple;
	bh=cmO6uIAvQ2Sq3nmcAqsTEzeL4AhO0S7xyhI8XsAuWjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCErzp7F1JoBPsg+2L6HFXs3vr5faR4eSNHkRIjPeeX05KzNqa8tCy+7SmiIFKTU7Apa632WIqrjEw/335IB/MF2LKxc12OzH43YtjxI3KuldRkv6h/o4UXAekJLGQhycXnWRam/0yjDHCeo+nsYmABRpxaeCaxxufz0nLnkqdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=dTFTeER9; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WJJ6512cMz9sSR;
	Tue,  9 Jul 2024 13:04:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1720523069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2YMROL98ACsOZCbRP94pX8oI7L1VGneWeIslewdStiI=;
	b=dTFTeER9w1KiAWkewX1ODbkftF6ZHwV8ad2JP5xNGR+iy2JGrpfxqmdNhgVgqrtvjijb9J
	h5VJ4RU/9Klt1lI/rMOjn2DLibhblgzmojwoV8Lcml49hXbcmbJwt48TP8KfkT6sG3JbmY
	TjBJVZeNw+y5zamFqscYZ0U04kX2i94Q/EfpM+2GPg9ENXUryRj8znydhKV6BNAr+KKXNg
	T8PcGTtiIBfCrpE83jb4hJ6V2O6o9hmHGCHsrqh0foW1HZt3S7YrPuhNJOqVjm5f7XZTl5
	B0ND5YGqJiKpE5kqQ26urle6qM8b1Hy8sL992+1mM1yJ5aYiovOG/1MZAAHdqQ==
Date: Tue, 9 Jul 2024 11:04:23 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Zi Yan <ziy@nvidia.com>
Cc: david@fromorbit.com, willy@infradead.org, chandan.babu@oracle.com,
	djwong@kernel.org, brauner@kernel.org, akpm@linux-foundation.org,
	yang@os.amperecomputing.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH v9 04/10] mm: split a folio in minimum folio order chunks
Message-ID: <20240709110423.wdteahoeufrt22jk@quentin>
References: <20240704112320.82104-1-kernel@pankajraghav.com>
 <20240704112320.82104-5-kernel@pankajraghav.com>
 <D2K7HHAVJDR9.8PR2HQZ00FXA@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D2K7HHAVJDR9.8PR2HQZ00FXA@nvidia.com>

> 
> This should be
> 
> 		if (!folio->mapping) {
> 			if (folio_test_pmd_mappable(folio))
> 				count_vm_event(THP_SPLIT_PAGE_FAILED);
> 			return -EBUSY;
> 		}
> 
> Otherwise, a non PMD mappable folio with no mapping will fall through
> and cause NULL pointer dereference in mapping_min_folio_order().

Ah, of course. I thought I was being "smart" here to avoid another
nesting. Instead of triple nested ifs, I guess this is better:

int split_folio_to_list(struct folio *folio, struct list_head *list)
{
       unsigned int min_order = 0;

       if (folio_test_anon(folio))
               goto out;

       if (!folio->mapping) {
               if (folio_test_pmd_mappable(folio))
                       count_vm_event(THP_SPLIT_PAGE_FAILED);
               return -EBUSY;
       }

       min_order = mapping_min_folio_order(folio->mapping);
out:
       return split_huge_page_to_list_to_order(&folio->page, list,
                                                       min_order);
}

Let me know what you think!

> 
> > +		min_order = mapping_min_folio_order(folio->mapping);
> > +	}
> > +
> > +	return split_huge_page_to_list_to_order(&folio->page, list, min_order);
> > +}
> > +
> >  void __folio_undo_large_rmappable(struct folio *folio)
> >  {
> >  	struct deferred_split *ds_queue;
> 
> 
> -- 
> Best Regards,
> Yan, Zi
> 



