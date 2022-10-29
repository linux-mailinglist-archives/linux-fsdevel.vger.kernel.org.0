Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB03611FBB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Oct 2022 05:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbiJ2DZk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 23:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ2DZg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 23:25:36 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EFD5D122;
        Fri, 28 Oct 2022 20:25:29 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id e4so6334868pfl.2;
        Fri, 28 Oct 2022 20:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ym7+3wgnpkb5rI+Z0N+jDokscndpKC7Wmfv3ziFEPwk=;
        b=p7+qu4KZjazhGhiUE88p+HmaLJz5fOq8D5pD/W1qQMlgrhY1lUb6VZbiCtAWkSLZoR
         a7nR60wW6SBLqyDDVtP9OM49/a4gljlwzNUShjs0rgpaI6FMikxBnrolnZTVWBhSr694
         YhgrgzXsKavE6zolD+qfmg++tskGwbGxEi57/YjLz1ml9+Vr29s+ZaYRM65kDKh+5XqL
         vbmUATyB+iStxe/ZEdVYhJUgIfRsSZHscCNvDh/vsoHafyqSiEMHvf5yoi7eU5u6Tzmc
         05c1HwM4BzlsKMdhNOsE1FnkQQn2xTE03BXYlVL583FtEqrvzEYBHXO54p/8U4bIKsxr
         eMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ym7+3wgnpkb5rI+Z0N+jDokscndpKC7Wmfv3ziFEPwk=;
        b=xcvVC4kFYEyUUOw2qAtENgtPe6X1ZwUM9yWgejN+uiq+JU8OXdIUTPL1pE0XTb2P8Z
         DKOtjq5KWo0zEJsnfjj4kKmwSkYaUDzO4xZ6umaTdAAIckx8YCWlEMjCVY9caBKWvNOS
         /vX4kfZ2OWbtBiUyqGCPYHC4xZv8+DEk/HhR6cgCfBUA8uzUjTp3oD0I+al/Ob9LQpT5
         RyaHTchKbyMdYy6xH+6aIe+CUZWIvkfy00dVcnYilmxmeJ+jdkuZHpweKC8QLKuENrr1
         bz7OnSRUXENGARqDyj+VC9ngTwSE/6D4zr4WySFYUdhCFzeZ2wYAUSNWiY5rCEisHhL2
         d40A==
X-Gm-Message-State: ACrzQf0mG/dJovyA/lnlmFO1YXsSXKb5o4DW8Wjt4W+A4Z5QloOO065e
        R9cY0S4POcGV+dBgcSb6zew=
X-Google-Smtp-Source: AMsMyM6xCcZOaySccFbFsxoMKXAQenNlbtbw8/sFiZp36feDmO6NqN1UPWQBOgxWFSIDTGPZPQ/QQA==
X-Received: by 2002:a62:fb14:0:b0:56b:de9f:10ba with SMTP id x20-20020a62fb14000000b0056bde9f10bamr2520142pfm.30.1667013929244;
        Fri, 28 Oct 2022 20:25:29 -0700 (PDT)
Received: from localhost ([58.84.24.234])
        by smtp.gmail.com with ESMTPSA id a198-20020a621acf000000b0056b9ec7e2desm189028pfa.125.2022.10.28.20.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 20:25:28 -0700 (PDT)
Date:   Sat, 29 Oct 2022 08:55:24 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFC 2/2] iomap: Support subpage size dirty tracking to improve
 write performance
Message-ID: <20221029032524.gfkuqtylr5uhg2oe@riteshh-domain>
References: <cover.1666928993.git.ritesh.list@gmail.com>
 <886076cfa6f547d22765c522177d33cf621013d2.1666928993.git.ritesh.list@gmail.com>
 <Y1wK3x7IketHl+DQ@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1wK3x7IketHl+DQ@magnolia>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/10/28 10:01AM, Darrick J. Wong wrote:
> On Fri, Oct 28, 2022 at 10:00:33AM +0530, Ritesh Harjani (IBM) wrote:
> > On a 64k pagesize platforms (specially Power and/or aarch64) with 4k
> > filesystem blocksize, this patch should improve the performance by doing
> > only the subpage dirty data write.
> > 
> > This should also reduce the write amplification since we can now track
> > subpage dirty status within state bitmaps. Earlier we had to
> > write the entire 64k page even if only a part of it (e.g. 4k) was
> > updated.
> > 
> > Performance testing of below fio workload reveals ~16x performance
> > improvement on nvme with XFS (4k blocksize) on Power (64K pagesize)
> > FIO reported write bw scores improved from around ~28 MBps to ~452 MBps.
> > 
> > <test_randwrite.fio>
> > [global]
> > 	ioengine=psync
> > 	rw=randwrite
> > 	overwrite=1
> > 	pre_read=1
> > 	direct=0
> > 	bs=4k
> > 	size=1G
> > 	dir=./
> > 	numjobs=8
> > 	fdatasync=1
> > 	runtime=60
> > 	iodepth=64
> > 	group_reporting=1
> > 
> > [fio-run]
> > 
> > Reported-by: Aravinda Herle <araherle@in.ibm.com>
> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > ---
> >  fs/iomap/buffered-io.c | 53 ++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 51 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 255f9f92668c..31ee80a996b2 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -58,7 +58,7 @@ iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
> >  	else
> >  		gfp = GFP_NOFS | __GFP_NOFAIL;
> >  
> > -	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(nr_blocks)),
> > +	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(2 * nr_blocks)),
> >  		      gfp);
> >  	if (iop) {
> >  		spin_lock_init(&iop->state_lock);
> > @@ -168,6 +168,48 @@ static void iomap_set_range_uptodate(struct folio *folio,
> >  		folio_mark_uptodate(folio);
> >  }
> >  
> > +static void iomap_iop_set_range_dirty(struct folio *folio,
> > +		struct iomap_page *iop, size_t off, size_t len)
> > +{
> > +	struct inode *inode = folio->mapping->host;
> > +	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
> > +	unsigned first = (off >> inode->i_blkbits) + nr_blocks;
> > +	unsigned last = ((off + len - 1) >> inode->i_blkbits) + nr_blocks;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&iop->state_lock, flags);
> > +	bitmap_set(iop->state, first, last - first + 1);
> > +	spin_unlock_irqrestore(&iop->state_lock, flags);
> > +}
> > +
> > +static void iomap_set_range_dirty(struct folio *folio,
> > +		struct iomap_page *iop, size_t off, size_t len)
> > +{
> > +	if (iop)
> > +		iomap_iop_set_range_dirty(folio, iop, off, len);
> > +}
> > +
> > +static void iomap_iop_clear_range_dirty(struct folio *folio,
> > +		struct iomap_page *iop, size_t off, size_t len)
> > +{
> > +	struct inode *inode = folio->mapping->host;
> > +	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
> > +	unsigned first = (off >> inode->i_blkbits) + nr_blocks;
> > +	unsigned last = ((off + len - 1) >> inode->i_blkbits) + nr_blocks;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&iop->state_lock, flags);
> > +	bitmap_clear(iop->state, first, last - first + 1);
> > +	spin_unlock_irqrestore(&iop->state_lock, flags);
> > +}
> > +
> > +static void iomap_clear_range_dirty(struct folio *folio,
> > +		struct iomap_page *iop, size_t off, size_t len)
> > +{
> > +	if (iop)
> > +		iomap_iop_clear_range_dirty(folio, iop, off, len);
> > +}
> > +
> >  static void iomap_finish_folio_read(struct folio *folio, size_t offset,
> >  		size_t len, int error)
> >  {
> > @@ -665,6 +707,7 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
> >  	if (unlikely(copied < len && !folio_test_uptodate(folio)))
> >  		return 0;
> >  	iomap_set_range_uptodate(folio, iop, offset_in_folio(folio, pos), len);
> > +	iomap_set_range_dirty(folio, iop, offset_in_folio(folio, pos), len);
> >  	filemap_dirty_folio(inode->i_mapping, folio);
> >  	return copied;
> >  }
> > @@ -979,6 +1022,8 @@ static loff_t iomap_folio_mkwrite_iter(struct iomap_iter *iter,
> >  		block_commit_write(&folio->page, 0, length);
> >  	} else {
> >  		WARN_ON_ONCE(!folio_test_uptodate(folio));
> > +		iomap_set_range_dirty(folio, to_iomap_page(folio),
> > +				offset_in_folio(folio, iter->pos), length);
> >  		folio_mark_dirty(folio);
> >  	}
> >  
> > @@ -1354,7 +1399,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> >  	 * invalid, grab a new one.
> >  	 */
> >  	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
> > -		if (iop && !test_bit(i, iop->state))
> > +		if (iop && (!test_bit(i, iop->state) ||
> > +			    !test_bit(i + nblocks, iop->state)))
> 
> Hmm.  So I /think/ these two test_bit()s mean that we skip any folio
> sub-block if it's either notuptodate or not dirty?
> 
> I /think/ we only need to check the dirty status, right?  Like willy
> said? :)

Yes. Agreed.

> 
> That said... somewhere we probably ought to check the consistency of the
> two bits to ensure that they're not (dirty && !uptodate), given our
> horrible history of getting things wrong with page and bufferhead state
> bits.
> 
> Admittedly I'm not thrilled at the reintroduction of page and iop dirty
> state that are updated in separate places, but OTOH the write
> amplification here is demonstrably horrifying as you point out so it's
> clearly necessary.

On a 64K pagesize platform the performance of such workloads that I meantion is
also quiet bad. 


> 
> Maybe we need a debugging function that will check the page and iop
> state, and call it every time we go in and out of critical iomap
> functions (write, writeback, dropping pages, etc)

I will try and review each of the paths once again to ensure the consistency. 
What I see is, we only mark the iop->state dirty bits before dirtying the page
in iomap buffered-io paths. This happens at two places,
1. __iomap_write_end() where we call filemap_dirty_folio(). We mark iop state
   dirty bits before calling filemap_dirty_folio()
2. iomap_folio_mkwrite_iter(). Here again before calling folio_mark_dirty(), we
   set the dirty state bits. This is the iomap_page_mkwrite path.

But, I would still like to review each of these and other paths as well.

-ritesh


> 
> --D
> 
> >  			continue;
> >  
> >  		error = wpc->ops->map_blocks(wpc, inode, pos);
> > @@ -1397,6 +1443,9 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> >  		}
> >  	}
> >  
> > +	iomap_clear_range_dirty(folio, iop,
> > +				offset_in_folio(folio, folio_pos(folio)),
> > +				end_pos - folio_pos(folio));
> >  	folio_start_writeback(folio);
> >  	folio_unlock(folio);
> >  
> > -- 
> > 2.37.3
> > 
