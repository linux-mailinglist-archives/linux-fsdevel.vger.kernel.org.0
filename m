Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4FBE153864
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 19:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgBESnq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 13:43:46 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44968 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgBESnq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 13:43:46 -0500
Received: by mail-qt1-f194.google.com with SMTP id w8so2356097qts.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Feb 2020 10:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wUGSc9NsfhLrJXw9g/4Cpl0NU6/CjpbaN2Q3d5tWnZs=;
        b=PKnya2jDW985US1MTRKHQm6dmuXL/UZOcOd1v0E1TTq5EoyCwgDdlMqsrSUWEkewea
         apf9GjnTSZVUJRmkrNUtAxr0pvjBBn23k9VtcuRN6lgPo5OPfBzQimfebe+K/cgh1qpk
         ZuCSOcZ1VWhWabaUtwk9/ioupfoDxXRwPcc1DL8DTv+q8jkj0lSUCOznWLvp7S9SN2Ut
         5gRBdphsxNcNcUOkFDJFCKe3cmPexCsg2j6SFNx6KegTgFeCBen6j8/AP1NvAGOteU0n
         0xu6GmAUjVrlGtakoMLpibu6pqgKYcp0ENDw9mkh2P0bl/FiC7/D7pXUKrWDYwZUpyyQ
         l8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wUGSc9NsfhLrJXw9g/4Cpl0NU6/CjpbaN2Q3d5tWnZs=;
        b=tHEjTVXqgD1A7TjjStrHAAUSEh7B5xilFjAVLsyUP66zrpDwSjQXt8fmhqtZ70RREk
         N1V8xWCxEWIGyUoNBIeSJs+7vMTdFhy/sYq22IiU8/3Rd9q9EY1cbOS36s/kyCwsfq85
         81SK/2VWV//SwC3CchW+MixswXjywVIWha+qqfxHMMs3QCXNzmZ4aQJmqwunetdCXia+
         dQvwm9GcwB/KcuieETHLuKVVIF3rBcF2fHZBFQuWQ4Mw6aWKPy4SwsBlA539WF/lBXSW
         sv+e7lbEy2M8eo9FWS20b6slEXeVQIxe918RxvqIKgDpGOaYpc48E1os8qI/TLbpz3qf
         s/1w==
X-Gm-Message-State: APjAAAX7sM2KpidSKdCTtVGhklX74PJ8YrK1kVgyMmB4J7tt+VLtqCBQ
        +BXw2n7wVQZwDpQtBKDveQrUQw==
X-Google-Smtp-Source: APXvYqwQzpvt9yeTkF8L2SKyrbhpdQshqja8XbcgDwPH/vQuEzBmocOOuFllhyb3PAnFDLyK5Sa1VA==
X-Received: by 2002:ac8:4a95:: with SMTP id l21mr35222430qtq.353.1580928225322;
        Wed, 05 Feb 2020 10:43:45 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id n20sm243053qkk.54.2020.02.05.10.43.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Feb 2020 10:43:44 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1izPeK-0003sV-A7; Wed, 05 Feb 2020 14:43:44 -0400
Date:   Wed, 5 Feb 2020 14:43:44 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 8/8] xarray: Don't clear marks in xas_store()
Message-ID: <20200205184344.GB28298@ziepe.ca>
References: <20200204142514.15826-1-jack@suse.cz>
 <20200204142514.15826-9-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204142514.15826-9-jack@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 04, 2020 at 03:25:14PM +0100, Jan Kara wrote:
> When storing NULL in xarray, xas_store() has been clearing all marks
> because it could otherwise confuse xas_for_each_marked(). That is
> however no longer true and no current user relies on this behavior.
> Furthermore it seems as a cleaner API to not do clearing behind caller's
> back in case we store NULL.
> 
> This provides a nice boost to truncate numbers due to saving unnecessary
> tag initialization when clearing shadow entries. Sample benchmark
> showing time to truncate 128 files 1GB each on machine with 64GB of RAM
> (so about half of entries are shadow entries):
> 
>          AVG      STDDEV
> Vanilla  4.825s   0.036
> Patched  4.516s   0.014
> 
> So we can see about 6% reduction in overall truncate time.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
>  lib/xarray.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/lib/xarray.c b/lib/xarray.c
> index 4e32497c51bd..f165e83652f1 100644
> +++ b/lib/xarray.c
> @@ -799,17 +799,8 @@ void *xas_store(struct xa_state *xas, void *entry)
>  		if (xas->xa_sibs)
>  			xas_squash_marks(xas);
>  	}
> -	if (!entry)
> -		xas_init_marks(xas);
>  
>  	for (;;) {
> -		/*
> -		 * Must clear the marks before setting the entry to NULL,
> -		 * otherwise xas_for_each_marked may find a NULL entry and
> -		 * stop early.  rcu_assign_pointer contains a release barrier
> -		 * so the mark clearing will appear to happen before the
> -		 * entry is set to NULL.
> -		 */
>  		rcu_assign_pointer(*slot, entry);

The above removed comment doesn't sound right (the release is paired
with READ_ONCE, which is only an acquire for data dependent accesses),
is this a reflection of the original bug in this thread?

How is RCU mark reading used anyhow?

There is no guarenteed ordering of the mark and the value, so nothing
iterating under RCU over marks can rely on the marks being accurate.

Are the algorithms using this tolerant of that, or provide some kind
of external locking?

This series looks good to me, and does seem to be an improvement.

Actually the clearing of marks by xa_store(, NULL) is creating a very
subtle bug in drivers/infiniband/core/device.c :( Can you add a Fixes
line too:

ib_set_client_data() is assuming the marks for the entry will not
change, but if the caller passed in NULL they get wrongly reset, and
three call sites pass in NULL:
 drivers/infiniband/ulp/srpt/ib_srpt.c
 net/rds/ib.c
 net/smc/smc_ib.c
Fixes: 0df91bb67334 ("RDMA/devices: Use xarray to store the client_data")

Thanks,
Jason
