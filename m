Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47D6616FF7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 22:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiKBVk2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 17:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiKBVkW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:40:22 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFFAFAD7
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Nov 2022 14:40:20 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso3423023pjc.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Nov 2022 14:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r6cpUmcjc3yS6LKlZ5L7qtiM4efqe5+GngyDtniaIWE=;
        b=8TM4dIsqn8lSq64rPGQ8GSZEO8HSK+Y6ZzDiSnVl6i00Q/4aBHonM1FAreSBVewnaW
         FyTITfIeO7md+kq5sS9IK4DLyDeAoebhttXptV/ulaZVWNZAqhP2u4Kx1I+RPYDvGVoZ
         EWPC93zwf+hV9K0lFPC++X8+d8ss4r60UNvShw76YY8aBXfhCXdu3hgyePT8ZJw44/CX
         d8VWom44IQYBMwDHNhnPsYr1aSGIUUypFFEj4FsGbmvfjU3DPn2Vdpj/IhS4tzVbslgv
         ZaBbAhbZgAEkP131XR1JvYqru16C5m6dyaiXL4oBzYaMS+nLmHH+IMaUHHx8yndSKtuk
         bLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6cpUmcjc3yS6LKlZ5L7qtiM4efqe5+GngyDtniaIWE=;
        b=lMjnSWI+Iv2by/Owd8AtzBfag3cGzhn4BCgWke32T+MBv9dLDL87LZ7/eo6swb/t5d
         qr9l0hJ4koVvX4zHRw2YXS3pu1jdrV/WDaKv+TDlNObg7jbRKUZxSAIcK6S/caKEujdi
         i3obit3CknZsO4KDArPYeO1WoMzKlvxlpzrNf4RvZ4VWCMeXDXf7M1clZSc5JPDuuy3k
         1+u6ZbR5jUMlvP5xFl21EXdHZ+mWB4bUo3e4sgRkJDV0iadSpoYdQY9tytiEHJ0bQcFa
         gUsnEpveKuMRRgLrD9q7lZKtyX24Ci82KImg67rwE3/3RURuLZJ08kel8kfSzoVIEwxM
         lyWQ==
X-Gm-Message-State: ACrzQf3NAaz9gBo42nzKBZcm63pFholM6hOb0ryr2kP1I2LYTr5qmaMB
        182U1ZXbDeUqE+BQx5tIGCllTA==
X-Google-Smtp-Source: AMsMyM7yN2XUDLbWjS2JZ2naaR2dYngtJzjTZqM7aa5eze3Z/O6R73iOnVwO7Yy0lFhuepjucoWivQ==
X-Received: by 2002:a17:902:e5c8:b0:187:3593:a841 with SMTP id u8-20020a170902e5c800b001873593a841mr11869459plf.150.1667425171901;
        Wed, 02 Nov 2022 14:39:31 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id k28-20020aa7999c000000b0056bfebfa6e4sm8827303pfh.190.2022.11.02.14.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 14:39:31 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oqLSJ-009Wvp-FI; Thu, 03 Nov 2022 08:39:27 +1100
Date:   Thu, 3 Nov 2022 08:39:27 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 6/7] xfs: use iomap_valid method to detect stale cached
 iomaps
Message-ID: <20221102213927.GB3600936@dread.disaster.area>
References: <20221101003412.3842572-1-david@fromorbit.com>
 <20221101003412.3842572-7-david@fromorbit.com>
 <Y2ItNSakpecwC9Va@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2ItNSakpecwC9Va@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 02, 2022 at 01:41:25AM -0700, Christoph Hellwig wrote:
> > +	*((int *)&iomap->private) = sequence;
> 
> > +static bool
> > +xfs_buffered_write_iomap_valid(
> > +	struct inode		*inode,
> > +	const struct iomap	*iomap)
> > +{
> > +	int			seq = *((int *)&iomap->private);
> 
> I really hate this stuffing of the sequence into the private pointer.

Oh, I'm no fan of it either. It was this or work out how to support
sequence numbers/cookies directly in iomaps...

> The iomap structure isn't so size constrained that we have to do that,
> so we can just add a sequence number field directly to it.  I don't
> think that is a layering violation, as the concept of a sequence
> numebr is pretty generic and we'll probably need it for all file systems
> eventually.

*nod*

This was the least of my worries trying to get this code to work. I
didn't have to think about it this way, so it was one less thing to
worry about.

My concerns with putting it into the iomap is that different
filesystems will have different mechanisms for detecting stale
iomaps. THe way we do it with a generation counter is pretty coarse
as any change to the extent map will invalidate the iomap regardless
of whether they overlap or not.

If, in future, we want something more complex and finer grained
(e.g. an iext tree cursor) to allow us to determine if the
change to the extent tree actually modified the extent backing the
iomap, then we are going to need an opaque cookie of some kind, not
a u32 or a u32*.

> > +
> > +	if (seq != READ_ONCE(XFS_I(inode)->i_df.if_seq))
> > +		return false;
> 
> Which makes me wonder if we could do away with the callback entirely
> by adding an option sequence number pointer to the iomap_iter.  If set
> the core code compares it against iomap->seq and we get rid of the
> per-folio indirect call, and boilerplate code that would need to be
> implemented in every file system.

I'm not convinced that this is the right way to proceed.

The writeback code also has cached iomap validity checks via a
callback.  The checks in xfs_imap_valid() require more than just a
single sequence number check - there are two sequence numbers, one
of which is conditionally checked when the inode may have COW
operations occurring.

Hence I don't think that encoding a single u32 into the iomap is
generic enough even for the current "check the cached iomap is not
stale" use cases we have. I'd really like to move towards a common
mechanism for both the write and writeback paths.

I didn't have the brain capacity to think all this through at the
time, so I just stuffed the sequence number in the private field and
moved on to the next part of the problem.

Indeed, I haven't even checked if the read path might be susceptible
to stale cached iomaps yet....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
