Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4FB67839C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 18:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjAWRuK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 12:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjAWRuI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:50:08 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8707312F2B
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 09:50:07 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso9186770wmq.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 09:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myY3gxRB0dEYaWId+MJCySxkYLOcOWzrmpY6Vy2xum4=;
        b=PtDpujp4ygu8h01wt2lLeXXTMMtJ4hKLNeRfM7gZhHHdR/8/ktol7oKTCtKK3ejjul
         4W77y0z4Qs7nnL65RsgM5BapdtyMxpQHUMtLt449+fOQ0fajQ8r+HxGa4vzV+cmjd2z1
         KZfSt7eRW/cAzkSXETZkbIXxoHSy0OgirnBxmVEzlBYfp87iMDP0/yUryVSgWI4wfqvr
         19mmM1wVt9PeQCIxaxQkAXUyLQPFAHe6IHfZm7wqU60Rtrvz82/KXh2L3oqcNy4knoPi
         /H2iOYJOoV1inuvlr8s67r6/N2ynYmpgS5Atoei/sz6yqQxgwU4X7TvNlTeN+B6PdGUO
         ViBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=myY3gxRB0dEYaWId+MJCySxkYLOcOWzrmpY6Vy2xum4=;
        b=4LAo8z4TYRXQZcbvRA6f6TfhJMdMh5t79o1lay45p1zuFRdXj3GmpI+shYc2umjdJE
         M5lGEY64mA3vNCuu97EGxRc7JlWcBnRWwMgyPXv6Bf6xP5T1xF7RmjVYxqebUZXmvHnW
         aywU/DlhJZl48VxvRc+wMrl4EASb3ieWxa1+GEeZLLkHIaZs/xeqvt3IdTHfxYRsb1wJ
         pyD1uug+XDeJpV4hfMmQy7Sg9Quo3pOpsxfdulRkmJesv9ekEiUbPDgJNgjjGuF+Tyr9
         LtGUs5ensKzdcBpjluSHW3LD3Sl8oFLGWvidY0R7+IcWoe+2ngkRdsDUw1/qh9ftqYYF
         /FxA==
X-Gm-Message-State: AFqh2krfF5QQOkR8h8bE/JkYe+cGa4JgchbDoHkOtgCbm6sKzu6vMS68
        lEKL2zO5a4gZrz6DvWqR5iPrPZAhvag=
X-Google-Smtp-Source: AMrXdXsYjXg6dn6K84z1ln8ZYb+KR+mVfBSnctLIYxxd7QqNzwSZxMqYGO5F2Nu7GOFYKafWTqlQUg==
X-Received: by 2002:a05:600c:540c:b0:3cf:7704:50ce with SMTP id he12-20020a05600c540c00b003cf770450cemr23730810wmb.38.1674496205986;
        Mon, 23 Jan 2023 09:50:05 -0800 (PST)
Received: from suse.localnet (host-79-36-37-176.retail.telecomitalia.it. [79.36.37.176])
        by smtp.gmail.com with ESMTPSA id r6-20020a05600c458600b003da286f8332sm11528119wmo.18.2023.01.23.09.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 09:50:05 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] memcpy_from_folio()
Date:   Mon, 23 Jan 2023 18:50:04 +0100
Message-ID: <3660839.MHq7AAxBmi@suse>
In-Reply-To: <Y80t49tQtWO5N22J@casper.infradead.org>
References: <Y8qr8c3+SJLGWhUo@casper.infradead.org>
 <63cb9105105ce_bd04c29434@iweiny-mobl.notmuch>
 <Y80t49tQtWO5N22J@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On domenica 22 gennaio 2023 13:36:51 CET Matthew Wilcox wrote:
> On Fri, Jan 20, 2023 at 11:15:17PM -0800, Ira Weiny wrote:
> > Matthew Wilcox wrote:
> > > I think I have a good folio replacement for memcpy_from_page().  One of
> > > the annoying things about dealing with multi-page folios is that you
> > > can't kmap the entire folio, yet on systems without highmem, you don't
> > > need to.  It's also somewhat annoying in the caller to keep track
> > > of n/len/offset/pos/...
> > > 
> > > I think this is probably the best option.  We could have a loop that
> > > kmaps each page in the folio, but that seems like excessive complexity.
> > 
> > Why?  IMO better to contain the complexity of highmem systems into any
> > memcpy_[to,from]_folio() calls then spread them around the kernel.
> 
> Sure, but look at the conversion that I posted.  It's actually simpler
> than using the memcpy_from_page() API.
> 
> > > I'm happy to have highmem systems be less efficient, since they are
> > > anyway.  Another potential area of concern is that folios can be quite
> > > large and maybe having preemption disabled while we copy 2MB of data
> > > might be a bad thing.  If so, the API is fine with limiting the amount
> > > of data we copy, we just need to find out that it is a problem and
> > > decide what the correct limit is, if it's not folio_size().
> > 
> > Why not map the pages only when needed?  I agree that keeping preemption
> > disabled for a long time is a bad thing.  But kmap_local_page does not
> > disable preemption, only migration.
> 
> Some of the scheduler people aren't terribly happy about even disabling
> migration for a long time.  Is "copying 2MB of data" a long time?  If I've
> done my sums correctly, my current laptop has 2x 16 bit LP-DDR4-4267
> DIMMs installed.  That works out to 17GB/s and so copying 2MB of data
> will take 118us.  Probably OK for even the most demanding workload.
> 
> > Regardless any looping on the maps is going to only be on highmem systems
> > and we can map the pages only if/when needed.  Synchronization of the 
folio
> > should be handled by the caller.  So it is fine to all allow migration
> > during memcpy_from_folio().
> > 
> > So why not loop through the pages only when needed?
> 
> So you're proposing re-enabling migration after calling
> kmap_local_folio()?  I don't really understand.
> 
> > >  fs/ext4/verity.c           |   16 +++++++---------
> > >  include/linux/highmem.h    |   29 +++++++++++++++++++++++++++++
> > >  include/linux/page-flags.h |    1 +
> > >  3 files changed, 37 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
> > > index e4da1704438e..afe847c967a4 100644
> > > --- a/fs/ext4/verity.c
> > > +++ b/fs/ext4/verity.c
> > > @@ -42,18 +42,16 @@ static int pagecache_read(struct inode *inode, void
> > > *buf, size_t count,> > 
> > >  			  loff_t pos)
> > >  
> > >  {
> > >  
> > >  	while (count) {
> > > 
> > > -		size_t n = min_t(size_t, count,
> > > -				 PAGE_SIZE - offset_in_page(pos));
> > > -		struct page *page;
> > > +		struct folio *folio;
> > > +		size_t n;
> > > 
> > > -		page = read_mapping_page(inode->i_mapping, pos >> 
PAGE_SHIFT,
> > > +		folio = read_mapping_folio(inode->i_mapping, pos >> 
PAGE_SHIFT,
> > > 
> > >  					 NULL);
> > 
> > Is this an issue with how many pages get read into the page
> > cache?  I went off on a tangent thinking this read the entire folio into
> > the cache.  But I see now I was wrong.  If this is operating page by page
> > why change this function at all?
> 
> The folio may (indeed _should_) be already present in the cache, otherwise
> the cache isn't doing a very good job.  If read_mapping_folio() ends up
> having to allocate the folio, today it only allocates a single page folio.
> But if somebody else allocated it through the readahead code, and the
> filesystem supports multi-page folios, then it will be larger than a
> single page.  All callers must be prepared to handle a multi-page folio.
> 
> > > -		if (IS_ERR(page))
> > > -			return PTR_ERR(page);
> > > -
> > > -		memcpy_from_page(buf, page, offset_in_page(pos), n);
> > > +		if (IS_ERR(folio))
> > > +			return PTR_ERR(folio);
> > > 
> > > -		put_page(page);
> > > +		n = memcpy_from_file_folio(buf, folio, pos, count);
> > > +		folio_put(folio);
> > > 
> > >  		buf += n;
> > >  		pos += n;
> > > 
> > > diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> > > index 9fa462561e05..9917357b9e8f 100644
> > > --- a/include/linux/highmem.h
> > > +++ b/include/linux/highmem.h
> > > @@ -414,6 +414,35 @@ static inline void memzero_page(struct page *page,
> > > size_t offset, size_t len)> > 
> > >  	kunmap_local(addr);
> > >  
> > >  }
> > > 
> > > +/**
> > > + * memcpy_from_file_folio - Copy some bytes from a file folio.
> > > + * @to: The destination buffer.
> > > + * @folio: The folio to copy from.
> > > + * @pos: The position in the file.
> > > + * @len: The maximum number of bytes to copy.
> > > + *
> > > + * Copy up to @len bytes from this folio.  This may be limited by
> > > PAGE_SIZE
> > 
> > I have a problem with 'may be limited'.  How is the caller to know this?
> 
> ... from the return value?
> 
> > Won't this propagate a lot of checks in the caller?  Effectively replacing
> > one complexity in the callers for another?
> 
> Look at the caller I converted!  It _reduces_ the amount of checks in
> the caller.
> 
> > > + * if the folio comes from HIGHMEM, and by the size of the folio.
> > > + *
> > > + * Return: The number of bytes copied from the folio.
> > > + */
> > > +static inline size_t memcpy_from_file_folio(char *to, struct folio
> > > *folio,
> > > +		loff_t pos, size_t len)
> > > +{
> > > +	size_t offset = offset_in_folio(folio, pos);
> > > +	char *from = kmap_local_folio(folio, offset);
> > > +
> > > +	if (folio_test_highmem(folio))
> > > +		len = min(len, PAGE_SIZE - offset);
> > > +	else
> > > +		len = min(len, folio_size(folio) - offset);
> > > +
> > > +	memcpy(to, from, len);
> > 
> > Do we need flush_dcache_page() for the pages?
> 
> Why?  memcpy_from_page() doesn't have one.
> 
> > I gave this an attempt today before I realized read_mapping_folio() only
> > reads a single page.  :-(
> > 
> > How does memcpy_from_file_folio() work beyond a single page?  And in that
> > case what is the point?  The more I think about this the more confused I
> > get.
> 
> In the highmem case, we map a single page and so cannot go beyond a
> single page.  If the folio wasn't allocated from highmem, we're just
> using its address directly, so we can access the whole folio.
> 
> Hope I've cleared up your confusions.

As you know I'm not a memory management expert, instead I'm just a user of 
these APIs. However, since I have been Cc'ed, I have read Matthew's RFC and 
the dialogue that follows. 

FWIW, I think I understand and I like this proposal. Therefore, I also hope to 
see it become a "real" patch.

Fabio 



