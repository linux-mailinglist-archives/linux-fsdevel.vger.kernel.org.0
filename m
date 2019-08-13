Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 080248B666
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 13:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfHMLKN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Aug 2019 07:10:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40491 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfHMLKN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Aug 2019 07:10:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so51087053pgj.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2019 04:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZLqa55gYvXGeXqo1YYvYjADgFmD5JUGSVTiuNpnKm8Q=;
        b=vwqt+GCyo77O5mvVmy9w8+Udxsx4UzIxzl1IdzIdwtaMiC+HcZu9qq+55XY3a63Xli
         nkMMa7PYI3kBDVD+dRwZqhhuKn7IpEC72qZxUZHG/d0mmVNp7JgV4W3H3t2sAByZ/VG7
         3KVZtGTiWoN1OWDC3xYAtED4aculC5vWG/O4Ci0hGMPUxICRiQyOk4ATBW2i+gaf2JWI
         Hz1oR2/0BWdiRqGJhclg18uv7IGNDbL38VmIlu8M40gkbvNc2fjksGAQuGM9Mp9ie6oU
         rQQMJWCjT1IjYc4V7PsMtKQh00A5TkOuphgb+rtWQf8+nF/VzTnjeO1RHGzzuzG78uxL
         Zt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZLqa55gYvXGeXqo1YYvYjADgFmD5JUGSVTiuNpnKm8Q=;
        b=X20R0k7sWVGrgQZ+faa+NGOjd/9IRPQZd675zXacb264UOrlYvig07qS+tDjxGliBK
         W8/F/T+Kx0kOhhcMqcBZec18WiC0SZEFa08fNxbFR0/NMRuOQAUQw+9ZB/G2EgUNQG6B
         hwocYwBD3zYY7PHyi44O2WFtrx2Ru2MqS/lnERMyoXW8BoqnA1V8ptDbJ19OQ49km/Od
         LoNw1SihFv7aQRphUkSHVHIkh+TtOyqIdCfp6nOsL3C2k+8heB8G73zcPqykuYyjWVyt
         zi96oy8F2O81N+BGLGBROXpl0SZ/uOE3lRTl6Wud66A86B1o7n4AJr9auSUScs2JXOYw
         xC1g==
X-Gm-Message-State: APjAAAXEy6ntI4CmBmJhbIUz1DchN+ADF1yCkAWT17WAr7dW3yiRDbws
        TqMAPWZgaM7jGCV8mxSOyist
X-Google-Smtp-Source: APXvYqyJyKpeO3LZeObpVaMc7OaWwPCueUK8NHmjWAsJpCEHP93f9d/uEmHPlKjQJX4V9sT5raVBFA==
X-Received: by 2002:a65:6102:: with SMTP id z2mr33855081pgu.391.1565694612705;
        Tue, 13 Aug 2019 04:10:12 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id c199sm3677579pfb.28.2019.08.13.04.10.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 04:10:12 -0700 (PDT)
Date:   Tue, 13 Aug 2019 21:10:06 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     RITESH HARJANI <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, tytso@mit.edu
Subject: Re: [PATCH 0/5] ext4: direct IO via iomap infrastructure
Message-ID: <20190813111004.GA12682@poseidon.bobrowski.net>
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
 <20190812173150.AF04F5204F@d06av21.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812173150.AF04F5204F@d06av21.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 12, 2019 at 11:01:50PM +0530, RITESH HARJANI wrote:
> > This patch series converts the ext4 direct IO code paths to make use of the
> > iomap infrastructure and removes the old buffer_head direct-io based
> > implementation. The result is that ext4 is converted to the newer framework
> > and that it may _possibly_ gain a performance boost for O_SYNC | O_DIRECT IO.
> > 
> > These changes have been tested using xfstests in both DAX and non-DAX modes
> > using various configurations i.e. 4k, dioread_nolock, dax.
> 
> I had some minor review comments posted on Patch-4.
> But the rest of the patch series looks good to me.

Thanks for the review, much appreciated! Also, apologies about any
delayed response to your queries, I predominantly do all this work in
my personal time.

> I will also do some basic testing of xfstests which I did for my patches and
> will revert back.

Sounds good!

> One query, could you please help answering below for my understanding :-
> 
> I was under the assumption that we need to maintain
> ext4_test_inode_state(inode, EXT4_STATE_DIO_UNWRITTEN) or
> atomic_read(&EXT4_I(inode)->i_unwritten))
> in case of non-AIO directIO or AIO directIO case as well (when we may
> allocate unwritten extents),
> to protect with some kind of race with other parts of code(maybe
> truncate/bufferedIO/fallocate not sure?) which may call for
> ext4_can_extents_be_merged()
> to check if extents can be merged or not.
> 
> Is it not the case?
> Now that directIO code has no way of specifying that this inode has
> unwritten extent, will it not race with any other path, where this info was
> necessary (like
> in above func ext4_can_extents_be_merged())?

Ah yes, I was under the same assumption when reviewing the code
initially and one of my first solutions was to also use this dynamic
'state' flag in the ->end_io() handler. But, I fell flat on my face as
that deemed to be problematic... This is because there can be multiple
direct IOs to unwritten extents against the same inode, so you cannot
possibly get away with tracking them using this single inode flag. So,
hence the reason why we drop using EXT4_STATE_DIO_UNWRITTEN and use
IOMAP_DIO_UNWRITTEN instead in the ->end_io() handler, which tracks
whether _this_ particular IO has an underlying unwritten extent.

