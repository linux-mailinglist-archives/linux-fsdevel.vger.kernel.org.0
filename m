Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255DD7A3E60
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 00:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbjIQWFh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Sep 2023 18:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239032AbjIQWFa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Sep 2023 18:05:30 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACF6127
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Sep 2023 15:05:24 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68fbbb953cfso3425129b3a.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Sep 2023 15:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1694988324; x=1695593124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fDmEsXyaSf8yAoYrZgi7k3PEY6Z2DsRWqnUB0JhWW88=;
        b=Smpr7Rjydv62lnJAkepHNktljfFK9w0gZ+sgLl+Q1Q/OEInSYO+tMEgjyElogjKNFK
         bQbAc/s2unRw9Fe+CV571NXOk6h6wkm6KB/iFr1TX36jmr5/XS84BrFyKXpLpYpuUpt5
         JcXDEm5XzDYGOvgEZqJGg60gNe9gNJJDmchi2Bjx1A3QH0UQh1mbrrPP4sEUHqOj7tvj
         P6WyuqV4Ggd6rhp5d/KPxfqxDFDMNthBo6dTslfoRrsVsfkT9Nury9PO2zJZbDQo6wAO
         isDwEYv58LSLo/ZxS6HfTlVbMzteqI84z1K5FpKYqk75vgVMox386PKoWhm0G8/voZjR
         ONog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694988324; x=1695593124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDmEsXyaSf8yAoYrZgi7k3PEY6Z2DsRWqnUB0JhWW88=;
        b=nFapI79i8fQQ5Tmx1k25neC2UIWlMagOOaREDeZeVhHC8RvaSMcJODJqN/Ci5+YPCA
         GCleQzACEWvt9zI/FxkAe6dEea9d22Z6S3vf7UmPh3dl2YDcvXbIbhiQQfMmv1z3tDar
         R+GOx0RonzxS/BPyUqstHl6IQsAAy8aK14t+NjpV1jkdYMI0ADJu+XJN8Wg9T/1i98HO
         vVlKR0tNjQgq+Qixj+zj6Y42KLcWGKCnpXyqEJnWsY356Vn5Udph7gq4MGeTxemd/OLM
         JrGqfnIl4FTyZS8MgZuX0sokWTIV/Guctj2g6ioiOrvMmaFJE69NLlk7FkLBNBAPjThH
         fwKw==
X-Gm-Message-State: AOJu0YzHQ9d5za+X1tlnDhd10X+Lj28j9B95xN5AVMkJNW2mttwhJBpB
        GyN7eeAdhQmJbRv24TsMm/O/fw==
X-Google-Smtp-Source: AGHT+IGriyOaU60Vb7Rit7epiVgY+WyPy27El2SWay4AblxK+YycjfKHg8vCZzD3aFqma8BOKSbIJw==
X-Received: by 2002:a05:6a00:2283:b0:68f:ea5d:1f70 with SMTP id f3-20020a056a00228300b0068fea5d1f70mr10470850pfe.14.1694988323991;
        Sun, 17 Sep 2023 15:05:23 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id d23-20020aa78157000000b00690188b124esm6249509pfn.174.2023.09.17.15.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 15:05:23 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qhztI-0025Sj-0n;
        Mon, 18 Sep 2023 08:05:20 +1000
Date:   Mon, 18 Sep 2023 08:05:20 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Pankaj Raghav <kernel@pankajraghav.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        p.raghav@samsung.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, djwong@kernel.org, linux-mm@kvack.org,
        chandan.babu@oracle.com, mcgrof@kernel.org, gost.dev@samsung.com
Subject: Re: [RFC 00/23] Enable block size > page size in XFS
Message-ID: <ZQd4IPeVI+o6M38W@dread.disaster.area>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915183848.1018717-1-kernel@pankajraghav.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 08:38:25PM +0200, Pankaj Raghav wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> There has been efforts over the last 16 years to enable enable Large
> Block Sizes (LBS), that is block sizes in filesystems where bs > page
> size [1] [2]. Through these efforts we have learned that one of the
> main blockers to supporting bs > ps in fiesystems has been a way to
> allocate pages that are at least the filesystem block size on the page
> cache where bs > ps [3]. Another blocker was changed in filesystems due to
> buffer-heads. Thanks to these previous efforts, the surgery by Matthew
> Willcox in the page cache for adopting xarray's multi-index support, and
> iomap support, it makes supporting bs > ps in XFS possible with only a few
> line change to XFS. Most of changes are to the page cache to support minimum
> order folio support for the target block size on the filesystem.
> 
> A new motivation for LBS today is to support high-capacity (large amount
> of Terabytes) QLC SSDs where the internal Indirection Unit (IU) are
> typically greater than 4k [4] to help reduce DRAM and so in turn cost
> and space. In practice this then allows different architectures to use a
> base page size of 4k while still enabling support for block sizes
> aligned to the larger IUs by relying on high order folios on the page
> cache when needed. It also enables to take advantage of these same
> drive's support for larger atomics than 4k with buffered IO support in
> Linux. As described this year at LSFMM, supporting large atomics greater
> than 4k enables databases to remove the need to rely on their own
> journaling, so they can disable double buffered writes [5], which is a
> feature different cloud providers are already innovating and enabling
> customers for through custom storage solutions.
> 
> This series still needs some polishing and fixing some crashes, but it is
> mainly targeted to get initial feedback from the community, enable initial
> experimentation, hence the RFC. It's being posted now given the results from
> our testing are proving much better results than expected and we hope to
> polish this up together with the community. After all, this has been a 16
> year old effort and none of this could have been possible without that effort.
> 
> Implementation:
> 
> This series only adds the notion of a minimum order of a folio in the
> page cache that was initially proposed by Willy. The minimum folio order
> requirement is set during inode creation. The minimum order will
> typically correspond to the filesystem block size. The page cache will
> in turn respect the minimum folio order requirement while allocating a
> folio. This series mainly changes the page cache's filemap, readahead, and
> truncation code to allocate and align the folios to the minimum order set for the
> filesystem's inode's respective address space mapping.
> 
> Only XFS was enabled and tested as a part of this series as it has
> supported block sizes up to 64k and sector sizes up to 32k for years.
> The only thing missing was the page cache magic to enable bs > ps. However any filesystem
> that doesn't depend on buffer-heads and support larger block sizes
> already should be able to leverage this effort to also support LBS,
> bs > ps.
> 
> This also paves the way for supporting block devices where their logical
> block size > page size in the future by leveraging iomap's address space
> operation added to the block device cache by Christoph Hellwig [6]. We
> have work to enable support for this, enabling LBAs > 4k on NVME,  and
> at the same time allow coexistence with buffer-heads on the same block
> device so to enable support allow for a drive to use filesystem's to
> switch between filesystem's which may depend on buffer-heads or need the
> iomap address space operations for the block device cache. Patches for
> this will be posted shortly after this patch series.

Do you have a git tree branch that I can pull this from
somewhere?

As it is, I'd really prefer stuff that adds significant XFS
functionality that we need to test to be based on a current Linus
TOT kernel so that we can test it without being impacted by all
the random unrelated breakages that regularly happen in linux-next
kernels....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
