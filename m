Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9600611C16
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 23:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJ1VE3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 17:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ1VE2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 17:04:28 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA4C326
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Oct 2022 14:04:27 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q71so5843009pgq.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Oct 2022 14:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t8gVBAAQNTa1UUGNyaVi8QdtM1gfYatSxYmPX/eG+f8=;
        b=fAemIDXylENS9+k3cOPLVDWC2tiF3ewXKO65OSR+O7WeKvgguPh5PuZwDlPP+sjxSg
         w6D/s1WTWbTiVMCK6FIO/mzNh11PX+LfhGwpGkFYMe8+wu1epWsq5S/jfCY09ZuCOhqC
         MFgUvd1eRpHlITWZDb4dwO91m7fEhhr/Oj2Fhjg675FWllM1CR236tLrPLY7sPrN+7yt
         5LPxHnK+0L4piWsUKspPwGJ4eSxgcTWT9HRxSc+c5vAiGD6tLLPHkKjxusy/xE2vt0Aw
         FjPG8QFoYLgo2wDuVnrRmzselnIrlVfbMZCAeMTm44ylvyNqhH0hK+kOIBrZblgQc8eO
         HuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8gVBAAQNTa1UUGNyaVi8QdtM1gfYatSxYmPX/eG+f8=;
        b=k9YCUQARxWA9OnVzRkVRhoeAmQEvMBIdOrmNVCsgz27skOSTM/EM/lMt8sf++HGBYJ
         /ymiaY6arrI7if0X+QaYfZ+51w0WsPkp9+v6HJG57xHSgLeIz8mbOojctXi/HhX3tVjJ
         VmAwTb270ouWtMOQ6++CzHCphISKaIhs8WbziZkEOzwTt10GLC8Ih/8k0IZHWeSGWLDU
         qbkPlosDBRVEBTmWEIiqtB1WmRFuaJoB+Wbzd3teH1b0PsFVlQCbuqxIdybpVAXLPae1
         FJwzWtpedCM/P/qjPLhSusE+KwXl65p5O6Al/G2LsOpDuMmiJR82VVmkWFvx1mqkZBQg
         V3Ww==
X-Gm-Message-State: ACrzQf3qHSSUj2joFVVf1W8AdEC/Vn2n1b6k6CVjIR8SIbkTpDXmxJXV
        g27K7MZ9awZC+4fiwjratpbD7g==
X-Google-Smtp-Source: AMsMyM6EFybQ0U5a5Yy1OMoItgCFEVdH7LEQW2MIAVprbfZ8LPNStKA7hFgNOMoMWZCaJJeDVPyTQA==
X-Received: by 2002:a05:6a00:13aa:b0:56b:c782:107f with SMTP id t42-20020a056a0013aa00b0056bc782107fmr990982pfg.43.1666991066509;
        Fri, 28 Oct 2022 14:04:26 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id bd13-20020a656e0d000000b0043c9da02729sm3097359pgb.6.2022.10.28.14.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 14:04:25 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ooWWc-007Y9a-G7; Sat, 29 Oct 2022 08:04:22 +1100
Date:   Sat, 29 Oct 2022 08:04:22 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFC 2/2] iomap: Support subpage size dirty tracking to improve
 write performance
Message-ID: <20221028210422.GC3600936@dread.disaster.area>
References: <cover.1666928993.git.ritesh.list@gmail.com>
 <886076cfa6f547d22765c522177d33cf621013d2.1666928993.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <886076cfa6f547d22765c522177d33cf621013d2.1666928993.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 28, 2022 at 10:00:33AM +0530, Ritesh Harjani (IBM) wrote:
> On a 64k pagesize platforms (specially Power and/or aarch64) with 4k
> filesystem blocksize, this patch should improve the performance by doing
> only the subpage dirty data write.
> 
> This should also reduce the write amplification since we can now track
> subpage dirty status within state bitmaps. Earlier we had to
> write the entire 64k page even if only a part of it (e.g. 4k) was
> updated.
> 
> Performance testing of below fio workload reveals ~16x performance
> improvement on nvme with XFS (4k blocksize) on Power (64K pagesize)
> FIO reported write bw scores improved from around ~28 MBps to ~452 MBps.
> 
> <test_randwrite.fio>
> [global]
> 	ioengine=psync
> 	rw=randwrite
> 	overwrite=1
> 	pre_read=1
> 	direct=0
> 	bs=4k
> 	size=1G
> 	dir=./
> 	numjobs=8
> 	fdatasync=1
> 	runtime=60
> 	iodepth=64
> 	group_reporting=1
> 
> [fio-run]
> 
> Reported-by: Aravinda Herle <araherle@in.ibm.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

To me, this is a fundamental architecture change in the way iomap
interfaces with the page cache and filesystems. Folio based dirty
tracking is top down, whilst filesystem block based dirty tracking
*needs* to be bottom up.

The bottom up approach is what bufferheads do, and it requires a
much bigger change that just adding dirty region tracking to the
iomap write and writeback paths.

That is, moving to tracking dirty regions on a filesystem block
boundary brings back all the coherency problems we had with
trying to keep bufferhead dirty state coherent with page dirty
state. This was one of the major simplifications that the iomap
infrastructure brought to the table - all the dirty tracking is done
by the page cache, and the filesystem has nothing to do with it at
all....

IF we are going to change this, then there needs to be clear rules
on how iomap dirty state is kept coherent with the folio dirty
state, and there need to be checks placed everywhere to ensure that
the rules are followed and enforced.

So what are the rules? If the folio is dirty, it must have at least one
dirty region? If the folio is clean, can it have dirty regions?

What happens to the dirty regions when truncate zeros part of a page
beyond EOF? If the iomap regions are clean, do they need to be
dirtied? If the regions are dirtied, do they need to be cleaned?
Does this hold for all trailing filesystem blocks in the (multipage)
folio, of just the one that spans the new EOF?

What happens with direct extent manipulation like fallocate()
operations? These invalidate the parts of the page cache over the
range we are punching, shifting, etc, without interacting directly
with iomap, so do we now have to ensure that the sub-folio dirty
regions are also invalidated correctly? i.e. do functions like
xfs_flush_unmap_range() need to become iomap infrastructure so that
they can update sub-folio dirty ranges correctly?

What about the
folio_mark_dirty()/filemap_dirty_folio()/.folio_dirty()
infrastructure? iomap currently treats this as top down, so it
doesn't actually call back into iomap to mark filesystem blocks
dirty. This would need to be rearchitected to match
block_dirty_folio() where the bufferheads on the page are marked
dirty before the folio is marked dirty by external operations....

The easy part of this problem is tracking dirty state on a
filesystem block boundaries. The *hard part* maintaining coherency
with the page cache, and none of that has been done yet. I'd prefer
that we deal with this problem once and for all at the page cache
level because multi-page folios mean even when the filesystem block
is the same as PAGE_SIZE, we have this sub-folio block granularity
tracking issue.

As it is, we already have the capability for the mapping tree to
have multiple indexes pointing to the same folio - perhaps it's time
to start thinking about using filesystem blocks as the mapping tree
index rather than PAGE_SIZE chunks, so that the page cache can then
track dirty state on filesystem block boundaries natively and
this whole problem goes away. We have to solve this sub-folio dirty
tracking problem for multi-page folios anyway, so it seems to me
that we should solve the sub-page block size dirty tracking problem
the same way....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
