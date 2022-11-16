Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F79462AFE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 01:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbiKPAK7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 19:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKPAK7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 19:10:59 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694ED2A716
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Nov 2022 16:10:58 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id c2so14895054plz.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Nov 2022 16:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rD/RoHfyEVT+SdG0X/B7iu3/BEAtoC054FO09SaHPUM=;
        b=J9/xSM0XEioLbGpgDvTlTfAO+wvEzOuT9B+ffrzh4yOeJmd6IO5uNeubjHHgcpzMQn
         L7GHJe1a7x4fVqfUaShD3u0+cNXAiCaVBkQElLwO14bM0F6tC4SBdbdvnWDU/3+HfuSS
         srt7KHvhAMwkamFH4Q1YqkX8UgR3iaOLp/hwO7brMr/B1bV0YxCpoOircPWHc7HhhIKB
         WXYC0Hz/iWNYJfYtxxMk6TI6F/7LXAv4O/3p+c+einOmPAUrAdUufroV52acch40cczv
         DQAaH6AAeEFalflQQC53fC3CYbVX0FoAeCIAUO/kRXm436L1Z4hjby/RN8Wuig9fy/G5
         VtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rD/RoHfyEVT+SdG0X/B7iu3/BEAtoC054FO09SaHPUM=;
        b=TAd6btbQMWMYb40ZW4zL46uvm6JPdqfgqWvL/XwFzhrJYx3AJ5SLbGJS7cg6yE29JM
         DmNksDbkkaRZ8487aJldxOQl1j4Mp4vrX7gKgasNwo58WzI8D77pwqFoalGCRAMkYHEq
         EWldg/vGpwG8LdF+AfZe68T1/tnJxY+d8TLqwdUuBWfCL70muyVumQuBGgxhADfxq20D
         I6pNvf6Jwi0eE0dprzo08KS20Ch1BIetp0R/pdO63UMaNuQH94iQxL42lWq/6GJcEw+H
         eyXTOL+qu9TF9N71JqY91PF0hgGzMt4h/RZ9O8x6BonP45hTv+UnQV1m5kd8k2NkgplN
         Rkxg==
X-Gm-Message-State: ANoB5pnJCVTplYJ3orqfnjiRp7p3M3uW9A8MtlrWPIzEaIlyOuJTMHsh
        6UIBTrcCjvqBZNMJu8M8Rp5IhQ==
X-Google-Smtp-Source: AA0mqf73DdXQXS2w87TsSXf0A7sXLMiMFeStSpJUGScVZwiTAEWFsHzhK74pTokSwLZAOOFCNSZp3g==
X-Received: by 2002:a17:902:c3ca:b0:17f:b05:bbc4 with SMTP id j10-20020a170902c3ca00b0017f0b05bbc4mr6318913plj.41.1668557457951;
        Tue, 15 Nov 2022 16:10:57 -0800 (PST)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id g75-20020a62524e000000b0056164b52bd8sm9417299pfb.32.2022.11.15.16.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 16:10:57 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ov60z-00EhIc-W4; Wed, 16 Nov 2022 11:10:54 +1100
Date:   Wed, 16 Nov 2022 11:10:53 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 8/9] xfs: use iomap_valid method to detect stale cached
 iomaps
Message-ID: <20221116001053.GZ3600936@dread.disaster.area>
References: <20221115013043.360610-1-david@fromorbit.com>
 <20221115013043.360610-9-david@fromorbit.com>
 <Y3NSrSxq/nC4u8ws@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3NSrSxq/nC4u8ws@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 15, 2022 at 12:49:49AM -0800, Christoph Hellwig wrote:
> On Tue, Nov 15, 2022 at 12:30:42PM +1100, Dave Chinner wrote:
> > +/*
> > + * Check that the iomap passed to us is still valid for the given offset and
> > + * length.
> > + */
> > +static bool
> > +xfs_iomap_valid(
> > +	struct inode		*inode,
> > +	const struct iomap	*iomap)
> > +{
> > +	struct xfs_inode	*ip = XFS_I(inode);
> > +	u64			cookie = 0;
> > +
> > +	if (iomap->flags & IOMAP_F_XATTR) {
> > +		cookie = READ_ONCE(ip->i_af.if_seq);
> > +	} else {
> > +		if ((iomap->flags & IOMAP_F_SHARED) && ip->i_cowfp)
> > +			cookie = (u64)READ_ONCE(ip->i_cowfp->if_seq) << 32;
> > +		cookie |= READ_ONCE(ip->i_df.if_seq);
> > +	}
> > +	return cookie == iomap->validity_cookie;
> 
> How can this be called with IOMAP_F_XATTR set?

It can't be. *Yet*.

However: ->iomap_begin can be called to map an attribute fork, and
->iomap_valid *could* be called on the attr iomap that is returned.
At which point, the iomap needs to be self-describing and the
validation cookie needs to hold the attr fork sequence number for
everything to work.

Failing to handle/validate attr iomaps correctly would clearly be an
XFS implementation bug and making it work correctly is trivial and
costs nothing. Hence making it work is a no-brainer - leaving it as
a landmine for someone else to trip over in future is a poor outcome
for everyone.

> Also the code seems to duplicate xfs_iomap_inode_sequence, so
> we just call that:
> 
> 	return cookie == xfs_iomap_inode_sequence(XFS_I(inode), iomap->flags);

Yup, will fix.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
