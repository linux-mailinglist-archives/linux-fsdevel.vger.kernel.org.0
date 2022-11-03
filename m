Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A520161736E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 01:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiKCAi7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 20:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiKCAi6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 20:38:58 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8EDAE4E
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Nov 2022 17:38:57 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l6so190337pjj.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Nov 2022 17:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/NMrgPnhiyfhVCy/KK4H6Qz92NzbYOKlxNXPYlc1uO0=;
        b=Yl2xp+lNAIAvgU8qrpbcc/jRnWyN4AS+5z9n5w+hwJlJ3PkNUne3ya2Mn7eaPK+7II
         VkN/sBda0fqTOM53b9hNxFa5zMTuBzjOi7RG1hKRZrhkVcyLuAKt340bYG4lJWilEmP1
         CxMfIJJKGrqY7+SFddZkFFgf4kjutvUZsPP48EuI4L5kQiD2UtgozNXSZ1+MxtRLREif
         A6xqjx0v1+GKzskKdqXNOo/WomRnrLLJC+o8XirIvdHWhsAD6tzp4hf3clG+7CLiGFpc
         y0oBtPR43bGDne5nzJGMBs2ehkpx0PhNEoY7brD6qYqqFndQCqPeQ2gD6rNUOzlwVcYO
         qhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NMrgPnhiyfhVCy/KK4H6Qz92NzbYOKlxNXPYlc1uO0=;
        b=fhHUbyACn73+R3//lGJwDBcGtw7csF2gPzaMtUcJJ51wBG3+SKbqiIXDsgNbPN5O4C
         n7fZE16giJeiUQ2vjHk/TsI4WwNGS6Le/937DOBGI89c/rKg2q4D2M/r/Jd4X3N7R2+6
         e1Ri2fD9f7LZAMSOsQ/uTF4vSKBTipy5o62FcylU9XNZPDUT9UhwTKDW5hC6Za2QSKhZ
         L9RdR7Rp4R8r9OhSBobpbE3ikZXQM/pvj9aCw5LdUyuYiwthgbOVdyhXHgix2h3IgG/Q
         vx7FEdTnZW0EuB7QW7CTiEFL5AsEJQJA9xlqchUOaHL31PlIB2qWlRnJX5FXbCy64U47
         ItCQ==
X-Gm-Message-State: ACrzQf30eFgvZX2zOqWECZP9G564PkItA8ST8pVGTkEHLuLQ1h5WgS/o
        GSNVvTZiXtBLy57hK8+5MML9+w==
X-Google-Smtp-Source: AMsMyM6bm5rrJQWJ5TrDTGa4Xhlw0EYV8NdmuAixqIjFP1KgKz06/1f1lDchJk5yF8WWiY44CCkLvg==
X-Received: by 2002:a17:90b:33c3:b0:213:f5be:c3ad with SMTP id lk3-20020a17090b33c300b00213f5bec3admr15560506pjb.123.1667435937275;
        Wed, 02 Nov 2022 17:38:57 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id ev16-20020a17090aead000b0020b2082e0acsm2065256pjb.0.2022.11.02.17.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 17:38:56 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oqOFx-009ZzD-TT; Thu, 03 Nov 2022 11:38:53 +1100
Date:   Thu, 3 Nov 2022 11:38:53 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Aravinda Herle <araherle@in.ibm.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [RFC 2/2] iomap: Support subpage size dirty tracking to improve
 write performance
Message-ID: <20221103003853.GE3600936@dread.disaster.area>
References: <cover.1666928993.git.ritesh.list@gmail.com>
 <886076cfa6f547d22765c522177d33cf621013d2.1666928993.git.ritesh.list@gmail.com>
 <20221028210422.GC3600936@dread.disaster.area>
 <Y19EXLfn8APg3adO@casper.infradead.org>
 <20221031070853.GL3600936@dread.disaster.area>
 <Y1+jBDLHovtsXbyF@casper.infradead.org>
 <Y2IxFlfLwPtloYc+@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2IxFlfLwPtloYc+@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 02, 2022 at 01:57:58AM -0700, Christoph Hellwig wrote:
> On Mon, Oct 31, 2022 at 10:27:16AM +0000, Matthew Wilcox wrote:
> > > Byte range granularity is probably overkill for block based
> > > filesystems - all we need is a couple of extra bits per block to be
> > > stored in the mapping tree alongside the folio....
> > 
> > I think it's overkill for network filesystems too.  By sending a
> > sector-misaligned write to the server, you force the server to do a R-M-W
> > before it commits the write to storage.  Assuming that the file has fallen
> > out of the server's cache, and a sufficiently busy server probably doesn't
> > have the memory capacity for the working set of all of its clients.
> 
> That really depends on your server.  For NFS there's definitively
> servers that can deal with unaligned writes fairly well because they
> just log the data in non volatile memory.  That being said I'm not sure
> it really is worth to optimize the Linux pagecache for that particular
> use case.
> 
> > Anyway, Dave's plan for dirty tracking (as I understand the current
> > iteration) is to not store it linked from folio->private at all, but to
> > store it in a per-file tree of writes.  Then we wouldn't walk the page
> > cache looking for dirty folios, but walk the tree of writes choosing
> > which ones to write back and delete from the tree.  I don't know how
> > this will perform in practice, but it'll be generic enough to work for
> > any filesystem.
> 
> Yes, this would be generic.  But having multiple tracking trees might
> not be super optimal - it always reminds me of the btrfs I/O code that
> is lost in a maze of trees and performs rather suboptimal.

Yep, that's kinda what I'm trying to see if we can avoid....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
