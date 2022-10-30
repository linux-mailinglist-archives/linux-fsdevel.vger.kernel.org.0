Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724CF61271D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Oct 2022 04:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJ3D2K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Oct 2022 23:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJ3D2J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Oct 2022 23:28:09 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD734623F;
        Sat, 29 Oct 2022 20:28:03 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id b5so8054013pgb.6;
        Sat, 29 Oct 2022 20:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Im/oTH6fjjG6MBr1L90PWf26vc/9KZEkOHPqg9MDh4=;
        b=Ote8JrKAWQEuzIo/Vrx+45Fxp0p4kKb2iutmhjZQSMJfroofnXCHtDm3s0jcj8XFp9
         8+wBnhFb/SrD2fhx/ERFDYBf52UKr21UTl2vIxjKBexg80WQVrr86JMS+ATKjz39sFG1
         RugnS4sPIc/du9hsLLOn3Cs51cEuBusJyIZ7/06iOQr63CP1a5kAANcV4DpM0IwvXHDN
         vvd7g5S5P7LtqbBd1JE7zJPFK8rQwdNr+m4mhMGXCdKsxbg6+Pm4xyWT2YM+SJJltf2H
         YxLePFeI/WoQj8mzOVTTDTyYLU1XrPd69lUM1zGny0dB1lEIDzMRO5UB6xoPd6+UpzBC
         MtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Im/oTH6fjjG6MBr1L90PWf26vc/9KZEkOHPqg9MDh4=;
        b=040Y79LIyFsuqyn0ff7Dtm9IoafLWtya/Jek60qahNaSH+ux7Ihi4cgwW57BdX98gh
         tbH+x2n67Y/hvtQDicM+UmGYNH4rRTXKvTU9x6zZN+tAjEfhrZMCUVY6W4yWIrYr7ee0
         nI+mVb5g18CEQbECwElfF/dj/Y4eEz7mElpiCaUaRpTX/roD4ptME+GxnZpLo1b7YPvx
         NYfaC3fxOngUhy08a2SUMGKMt7hI6zBq1pDjmqe+Jhk6/BRdOQCDWFbMI15hKF2OCNWJ
         gUk3+DeEU5HLlQJp5UJ/op8qkga9AnQCdqbkYeHI6I26i80R/xsMGwpXRxHBi6quUENT
         GS9g==
X-Gm-Message-State: ACrzQf3RXv1QInms5WwjyEdRsbqx3wPdEaMdtxo/KeozflmuAFLluRP8
        zQpi5wL5d0WkFO5uQUJtbQc=
X-Google-Smtp-Source: AMsMyM6YCUS5BdM1iIUI5btktI59Wxxj7R0mmbHtWspUUtZWS5kelEMQISlshqO0ZfN5NvcEqmMBYQ==
X-Received: by 2002:a05:6a00:10cf:b0:528:48c3:79e0 with SMTP id d15-20020a056a0010cf00b0052848c379e0mr7303620pfu.18.1667100482550;
        Sat, 29 Oct 2022 20:28:02 -0700 (PDT)
Received: from localhost ([58.84.24.234])
        by smtp.gmail.com with ESMTPSA id y93-20020a17090a53e600b002139459e121sm1680180pjh.27.2022.10.29.20.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 20:28:02 -0700 (PDT)
Date:   Sun, 30 Oct 2022 08:57:58 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFC 2/2] iomap: Support subpage size dirty tracking to improve
 write performance
Message-ID: <20221030032758.wpryf2rer7uppq7x@riteshh-domain>
References: <cover.1666928993.git.ritesh.list@gmail.com>
 <886076cfa6f547d22765c522177d33cf621013d2.1666928993.git.ritesh.list@gmail.com>
 <20221028210422.GC3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028210422.GC3600936@dread.disaster.area>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/10/29 08:04AM, Dave Chinner wrote:
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
> 
> To me, this is a fundamental architecture change in the way iomap
> interfaces with the page cache and filesystems. Folio based dirty
> tracking is top down, whilst filesystem block based dirty tracking
> *needs* to be bottom up.
> 
> The bottom up approach is what bufferheads do, and it requires a
> much bigger change that just adding dirty region tracking to the
> iomap write and writeback paths.
> 
> That is, moving to tracking dirty regions on a filesystem block
> boundary brings back all the coherency problems we had with
> trying to keep bufferhead dirty state coherent with page dirty
> state. This was one of the major simplifications that the iomap
> infrastructure brought to the table - all the dirty tracking is done

Sure, but then with simplified iomap design these optimization in the 
workload that I mentioned are also lost :(

> by the page cache, and the filesystem has nothing to do with it at
> all....
> 
> IF we are going to change this, then there needs to be clear rules
> on how iomap dirty state is kept coherent with the folio dirty
> state, and there need to be checks placed everywhere to ensure that
> the rules are followed and enforced.

Sure.

> 
> So what are the rules? If the folio is dirty, it must have at least one
> dirty region? If the folio is clean, can it have dirty regions?
> 
> What happens to the dirty regions when truncate zeros part of a page
> beyond EOF? If the iomap regions are clean, do they need to be
> dirtied? If the regions are dirtied, do they need to be cleaned?
> Does this hold for all trailing filesystem blocks in the (multipage)
> folio, of just the one that spans the new EOF?
> 
> What happens with direct extent manipulation like fallocate()
> operations? These invalidate the parts of the page cache over the
> range we are punching, shifting, etc, without interacting directly
> with iomap, so do we now have to ensure that the sub-folio dirty
> regions are also invalidated correctly? i.e. do functions like
> xfs_flush_unmap_range() need to become iomap infrastructure so that
> they can update sub-folio dirty ranges correctly?
> 
> What about the
> folio_mark_dirty()/filemap_dirty_folio()/.folio_dirty()
> infrastructure? iomap currently treats this as top down, so it
> doesn't actually call back into iomap to mark filesystem blocks
> dirty. This would need to be rearchitected to match
> block_dirty_folio() where the bufferheads on the page are marked
> dirty before the folio is marked dirty by external operations....

Sure thanks for clearly listing out all of the paths. 
Let me carefully review these paths to check on, how does adding a state 
bitmap to iomap_page for dirty tracking is handled in every case which you 
mentioned above. I would like to ensure, that we have reviewed all the 
paths and functionally + theoritically this approach at least works fine.
(Mainly I wanted to go over the truncate & fallocate paths that you listed above).


> 
> The easy part of this problem is tracking dirty state on a
> filesystem block boundaries. The *hard part* maintaining coherency
> with the page cache, and none of that has been done yet. I'd prefer
> that we deal with this problem once and for all at the page cache
> level because multi-page folios mean even when the filesystem block
> is the same as PAGE_SIZE, we have this sub-folio block granularity
> tracking issue.
> 
> As it is, we already have the capability for the mapping tree to
> have multiple indexes pointing to the same folio - perhaps it's time
> to start thinking about using filesystem blocks as the mapping tree
> index rather than PAGE_SIZE chunks, so that the page cache can then
> track dirty state on filesystem block boundaries natively and
> this whole problem goes away. We have to solve this sub-folio dirty
> tracking problem for multi-page folios anyway, so it seems to me
> that we should solve the sub-page block size dirty tracking problem
> the same way....
> 
> Cheers,
> 
> Dave.

Thanks a lot Dave for your review comments. You have listed out few other
points which I am not commenting on yet, since I would like to review those 
carefully. I am currently on travel and will be back in a few days. 
Once I am back, let me study this area more based on your comments and will 
get back to you on those points as well.

-ritesh

> -- 
> Dave Chinner
> david@fromorbit.com
