Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24039326201
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 12:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhBZLai (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Feb 2021 06:30:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21069 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229915AbhBZLae (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Feb 2021 06:30:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614338947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MNF+TMBq2x8AHoskiIxekBDFE4UwjfxLslB/3NnDO7M=;
        b=iuGCpIvM4DbDx6+Isy2YX2pL/06dy/mRrkhC95j0O8SvNV5YALCMBECyo0JRA9goZsHhKD
        RgSLcY7nlwPvLPq7sXAe97Hr6/lqGF9UlG4W/cFn0SOkzZByTm+aBcRYITfW6R+AzXnzgk
        VIhbgoU609CpfZPebA7HDrk6aRwWklc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-340c8waIMeqRZ3CCMEW0Yw-1; Fri, 26 Feb 2021 06:29:05 -0500
X-MC-Unique: 340c8waIMeqRZ3CCMEW0Yw-1
Received: by mail-pg1-f197.google.com with SMTP id l2so5912986pgi.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Feb 2021 03:29:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MNF+TMBq2x8AHoskiIxekBDFE4UwjfxLslB/3NnDO7M=;
        b=crRh+Z0eDNSDdMkF7AaFOx6V0ZwmjJGXWTpXgp2CsJfiwAOfRf2T1qbbLzvGou4wJ+
         XjMdR0rmpG4vUKsr0/aDTARtFPNbQj4UrKXEHLXR3qb/KPP09+/PbuCYq2ABgZkpv1OA
         iXzXCMQzrD8dn238LLHxFA6PHWn8qHM3vbgjBN92az+1xzUIzfkHMy6T/zvmQy+Sys2h
         W4zFkib0++aM4fj7L4U/SYT8gbETAfZROYe/6MUSvKclYHOSK+2Z9XkEIeMwJxMcnpeR
         mBdK2xu8EtvX3NkO/u4rcxXlTtuym3XjwY6/JohB3Npy/iiQwVsU+0tQj7yzULsoM8QR
         Hs4w==
X-Gm-Message-State: AOAM530gkRQjwjy3zYLyR7azP3BllWPKwkADyKqFagR2H+Vzi+gTV7V+
        sqPsgmiUN0xzLRrjaGUM6LMTO35ZIZoUM4wOHsz9N07BUbEmGYStVcCSthwOLUqGEZjhMTDgZIO
        dRN8YJ34rireqXsf13QFmjU1BOw==
X-Received: by 2002:a17:90a:4494:: with SMTP id t20mr3099180pjg.33.1614338944694;
        Fri, 26 Feb 2021 03:29:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxB9lMKA4Z0WhN0N/pdbRDpwUCIpdqq9nm2vvVVRGoe1ktkOBJbB5/YyntJKwbmUjGT+MwCTw==
X-Received: by 2002:a17:90a:4494:: with SMTP id t20mr3099164pjg.33.1614338944471;
        Fri, 26 Feb 2021 03:29:04 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j7sm1889599pji.25.2021.02.26.03.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 03:29:03 -0800 (PST)
Date:   Fri, 26 Feb 2021 19:28:54 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     dsterba@suse.cz
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Neal Gompa <ngompa13@gmail.com>,
        Amy Parker <enbyamy@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Adding LZ4 compression support to Btrfs
Message-ID: <20210226112854.GA1890271@xiangao.remote.csb>
References: <CAE1WUT53F+xPT-Rt83EStGimQXKoU-rE+oYgcib87pjP4Sm0rw@mail.gmail.com>
 <CAEg-Je-Hs3+F9yshrW2MUmDNTaN-y6J-YxeQjneZx=zC5=58JA@mail.gmail.com>
 <20210225132647.GB7604@twin.jikos.cz>
 <YDfxkGkWnLEfsDwZ@gmail.com>
 <20210226093653.GI7604@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210226093653.GI7604@twin.jikos.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 26, 2021 at 10:36:53AM +0100, David Sterba wrote:
> On Thu, Feb 25, 2021 at 10:50:56AM -0800, Eric Biggers wrote:
> > On Thu, Feb 25, 2021 at 02:26:47PM +0100, David Sterba wrote:
> > > 
> > > LZ4 support has been asked for so many times that it has it's own FAQ
> > > entry:
> > > https://btrfs.wiki.kernel.org/index.php/FAQ#Will_btrfs_support_LZ4.3F
> > > 
> > > The decompression speed is not the only thing that should be evaluated,
> > > the way compression works in btrfs (in 4k blocks) does not allow good
> > > compression ratios and overall LZ4 does not do much better than LZO. So
> > > this is not worth the additional costs of compatibility. With ZSTD we
> > > got the high compression and recently there have been added real-time
> > > compression levels that we'll use in btrfs eventually.
> > 
> > When ZSTD support was being added to btrfs, it was claimed that btrfs compresses
> > up to 128KB at a time
> > (https://lore.kernel.org/r/5a7c09dd-3415-0c00-c0f2-a605a0656499@fb.com).
> > So which is it -- 4KB or 128KB?
> 
> Logical extent ranges are sliced to 128K that are submitted to the
> compression routine. Then, the whole range is fed by 4K (or more exactly
> by page sized chunks) to the compression. Depending on the capabilities
> of the compression algorithm, the 4K chunks are either independent or
> can reuse some internal state of the algorithm.
> 
> LZO and LZ4 use some kind of embedded dictionary in the same buffer, and
> references to that dictionary directly. Ie. assuming the whole input
> range to be contiguous. Which is something that's not trivial to achive
> in kernel because of pages that are not contiguous in general.
> 
> Thus, LZO and LZ4 compress 4K at a time, each chunk is independent. This
> results in worse compression ratio because of less data reuse
> possibilities. OTOH this allows decompression in place.

Sorry about the noise before. I misread btrfs LZO implementation.
Yet it sounds that approach has lower CR than compress 128kb as
a while. In principle it can archive decompress in-place (margin
by a whole lzo chunk), yet LZ4/LZO algorithm can have a more
accurate lower inplace margin in math.

> 
> ZLIB and ZSTD can have a separate dictionary and don't need the input
> chunks to be contiguous. This brings some additional overhead like
> copying parts of the input to the dictionary and additional memory for
> themporary structures, but with higher compression ratios.
> 
> IIRC the biggest problem for LZ4 was the cost of setting up each 4K
> chunk, the work memory had to be zeroed. The size of the work memory is
> tunable but trading off compression ratio. Either way it was either too
> slow or too bad.

May I ask why LZ4 needs to zero the work memory (if you mean dest
buffer and LZ4_decompress_safe), just out of curiousity... I didn't
see that restriction before. Thanks!

Thanks,
Gao Xiang

