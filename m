Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25A8618B7B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 23:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiKCW2v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 18:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiKCW22 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:28:28 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4444B22BF1;
        Thu,  3 Nov 2022 15:28:14 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q1so2866738pgl.11;
        Thu, 03 Nov 2022 15:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=04TfsshirPxCNoji6KR6vQQ5/+Nqz1IUHQcJvZJx5NI=;
        b=i5grfA60bPrUFTlgsPlduW3hAvcmtFixLYcSxpxknTbqWlzA5eSDZo2QxGbmEUX4Ez
         PFC90kceZfOYR3I9pFhRCfv942PHFd9bUJonaLnIBlhLHWOGJXBFiGYfo6vJUukVtx/7
         soCCVDQxzU6Aa5VrIKCIba0AAxBy8QcPqjem6y+c0iOC2pXque67sr+L4UHpFitkorkA
         KMkKnCOU4SFkyF64UZjc/aMbE0utm6aLXgpH+aZ18gtX0Gatb6OKO9Qq/MuBrV4+6ZLy
         XXGAcHiwHa5E1MOTVLelV8aravzzQvF3MR4c2sDr0OACn3OsrYzVSuuzdbXfd6Ax3gqr
         R5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04TfsshirPxCNoji6KR6vQQ5/+Nqz1IUHQcJvZJx5NI=;
        b=rhkIcEs5FvgsvfOqKveINjIkfCy0ZKaTM9AACsu7dyrjTWwn4tmF/x/2S6GvIWxuGq
         SyNJFWg07vDRYy2K52GtL2+nUHkVD7co+jKv1qY3+7kd5pBTC+P09TGy3BNf5HQy4Iba
         fF+Damje4uPVVCccC0k9Ov2DyUeqr5ciMHuAGr6PtBNV+yC6XFDLbgT+Z/jI4bd/gzEm
         CEoyu42Sqgf7U/ShO6808g97ASyv7EOCafuF20Jlc/+BCp8ok527n5v5+YHPCQpbqlWP
         f2jF3IAyYxbXmDieTR9N4eVhvnkTCZkNg3Ei2IV3U9cOenuRZUz1kDjUC+lZjFQYE47x
         hQxQ==
X-Gm-Message-State: ACrzQf3XMHNLEQ0vJIWmNQsk5FSdw4+E0Pz9kW71Jja/E+dz54PbKu/u
        W74WHPlcF8/DQiePUYmAXyU=
X-Google-Smtp-Source: AMsMyM7hE1bfSjSUUen+m8TVmotDYU/np98yLJV1t++FadjOyzDId3GOm6PXy0DRJG1AjfsRAwszyw==
X-Received: by 2002:a05:6a00:1a4d:b0:563:a7c4:f521 with SMTP id h13-20020a056a001a4d00b00563a7c4f521mr32742358pfv.61.1667514488876;
        Thu, 03 Nov 2022 15:28:08 -0700 (PDT)
Received: from fedora ([2601:644:8002:1c20::8080])
        by smtp.gmail.com with ESMTPSA id j16-20020a170902da9000b00186b86ed450sm1169376plx.156.2022.11.03.15.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 15:28:08 -0700 (PDT)
Date:   Thu, 3 Nov 2022 15:28:05 -0700
From:   Vishal Moola <vishal.moola@gmail.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 04/23] page-writeback: Convert write_cache_pages() to use
 filemap_get_folios_tag()
Message-ID: <Y2RAdUtJrOJmYU4L@fedora>
References: <20220901220138.182896-1-vishal.moola@gmail.com>
 <20220901220138.182896-5-vishal.moola@gmail.com>
 <20221018210152.GH2703033@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018210152.GH2703033@dread.disaster.area>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 19, 2022 at 08:01:52AM +1100, Dave Chinner wrote:
> On Thu, Sep 01, 2022 at 03:01:19PM -0700, Vishal Moola (Oracle) wrote:
> > Converted function to use folios throughout. This is in preparation for
> > the removal of find_get_pages_range_tag().
> > 
> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > ---
> >  mm/page-writeback.c | 44 +++++++++++++++++++++++---------------------
> >  1 file changed, 23 insertions(+), 21 deletions(-)
> > 
> > diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> > index 032a7bf8d259..087165357a5a 100644
> > --- a/mm/page-writeback.c
> > +++ b/mm/page-writeback.c
> > @@ -2285,15 +2285,15 @@ int write_cache_pages(struct address_space *mapping,
> >  	int ret = 0;
> >  	int done = 0;
> >  	int error;
> > -	struct pagevec pvec;
> > -	int nr_pages;
> > +	struct folio_batch fbatch;
> > +	int nr_folios;
> >  	pgoff_t index;
> >  	pgoff_t end;		/* Inclusive */
> >  	pgoff_t done_index;
> >  	int range_whole = 0;
> >  	xa_mark_t tag;
> >  
> > -	pagevec_init(&pvec);
> > +	folio_batch_init(&fbatch);
> >  	if (wbc->range_cyclic) {
> >  		index = mapping->writeback_index; /* prev offset */
> >  		end = -1;
> > @@ -2313,17 +2313,18 @@ int write_cache_pages(struct address_space *mapping,
> >  	while (!done && (index <= end)) {
> >  		int i;
> >  
> > -		nr_pages = pagevec_lookup_range_tag(&pvec, mapping, &index, end,
> > -				tag);
> > -		if (nr_pages == 0)
> > +		nr_folios = filemap_get_folios_tag(mapping, &index, end,
> > +				tag, &fbatch);
> 
> This can find and return dirty multi-page folios if the filesystem
> enables them in the mapping at instantiation time, right?

Yup, it will.

> > +
> > +		if (nr_folios == 0)
> >  			break;
> >  
> > -		for (i = 0; i < nr_pages; i++) {
> > -			struct page *page = pvec.pages[i];
> > +		for (i = 0; i < nr_folios; i++) {
> > +			struct folio *folio = fbatch.folios[i];
> >  
> > -			done_index = page->index;
> > +			done_index = folio->index;
> >  
> > -			lock_page(page);
> > +			folio_lock(folio);
> >  
> >  			/*
> >  			 * Page truncated or invalidated. We can freely skip it
> > @@ -2333,30 +2334,30 @@ int write_cache_pages(struct address_space *mapping,
> >  			 * even if there is now a new, dirty page at the same
> >  			 * pagecache address.
> >  			 */
> > -			if (unlikely(page->mapping != mapping)) {
> > +			if (unlikely(folio->mapping != mapping)) {
> >  continue_unlock:
> > -				unlock_page(page);
> > +				folio_unlock(folio);
> >  				continue;
> >  			}
> >  
> > -			if (!PageDirty(page)) {
> > +			if (!folio_test_dirty(folio)) {
> >  				/* someone wrote it for us */
> >  				goto continue_unlock;
> >  			}
> >  
> > -			if (PageWriteback(page)) {
> > +			if (folio_test_writeback(folio)) {
> >  				if (wbc->sync_mode != WB_SYNC_NONE)
> > -					wait_on_page_writeback(page);
> > +					folio_wait_writeback(folio);
> >  				else
> >  					goto continue_unlock;
> >  			}
> >  
> > -			BUG_ON(PageWriteback(page));
> > -			if (!clear_page_dirty_for_io(page))
> > +			BUG_ON(folio_test_writeback(folio));
> > +			if (!folio_clear_dirty_for_io(folio))
> >  				goto continue_unlock;
> >  
> >  			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
> > -			error = (*writepage)(page, wbc, data);
> > +			error = writepage(&folio->page, wbc, data);
> 
> Yet, IIUC, this treats all folios as if they are single page folios.
> i.e. it passes the head page of a multi-page folio to a callback
> that will treat it as a single PAGE_SIZE page, because that's all
> the writepage callbacks are currently expected to be passed...
> 
> So won't this break writeback of dirty multipage folios?

Yes, it appears it would. But it wouldn't because its already 'broken'.

The current find_get_pages_range_tag() actually has the exact same
issue. The current code to fill up the pages array is:

		pages[ret] = &folio->page;
		if (++ret == nr_pages) {
			*index = folio->index + folio_nr_pages(folio);
			goto out;

which behaves the same way as the issue you pointed out (both break
large folios). When I spoke to Matthew about this earlier, we decided
to go ahead with replacing the function and leave it up to the callers
to fix/handle large folios when the filesystem gets to it.

Its not great to leave it 'broken' but its something that isn't - or at
least shouldn't be - creating any problems at present. And I believe Matthew
has plans to address them at some point before they actually become problems?
