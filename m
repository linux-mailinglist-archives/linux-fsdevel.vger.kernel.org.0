Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB775326329
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 14:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhBZNN0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Feb 2021 08:13:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48310 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229845AbhBZNNY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Feb 2021 08:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614345116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hEyf4Hpj/C0F1Nm0aBUbr7uGMQm33ArtLDSy117stZU=;
        b=NJ2+U0nAz9N0x7aQxFX+sDFrG1zCyNJIoM+wlmLbDZo/pZ3FuiyzvXIGvkhyNy6AVO2ScX
        Jxd4WU3SLxh1ly37DaGPBhXzvszDsxtIa26YuiznMWI7eBFIhQrtdbAuigVudBoYKL9ze3
        6xk+uHb2d2yARlHLuYZzmXvEekYOU9o=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-rJRRo1y4P8S5FGl1OEaYtw-1; Fri, 26 Feb 2021 08:11:51 -0500
X-MC-Unique: rJRRo1y4P8S5FGl1OEaYtw-1
Received: by mail-pj1-f71.google.com with SMTP id f5so6759249pjs.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Feb 2021 05:11:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hEyf4Hpj/C0F1Nm0aBUbr7uGMQm33ArtLDSy117stZU=;
        b=bHo+wnES04KH6vApo7EtoOBu65aJukEpoSS6M3o5HRsSaE2Mx4rnexTd0Nq/Hqefgx
         /ZDBYL/WEuP8ndhsqAsr5fgQ8rvXWM8g5KhAG/bPVsm/lEx590vxPh6+EEdfMY1HNtns
         hJJWToLVQY08MT5XysdLvWJgKqPrBF1r5OopnDwpQWtKml5ncKJEpT17Yr0+Zc80a3jt
         lq4aZ5sR7qyWxroPVVuf/EuSPn9xCnO2CnH2iZKqf+54wUXEiOp0IlrlS9FTZVdK5GIP
         lPCVk+qcUN5wGd6f94xcuxTUaIqQRNDp82HaBfe57sPgjx9zkX4hEje/od1majkDV8Br
         muKg==
X-Gm-Message-State: AOAM5339tVVojPCqMnwPyqu8Ih5E3SLC+MT3mwcFyNKAz3LAYLMNcW8g
        Ih3KhaSPODKB6hH/ECVCwBlfYjNwMgJnddolAon8jXdITkrIqAt1hoixKvlcd6Fc+X3O1MEWq11
        jiiLr/j7e7S4blQVwC3KKmHqILg==
X-Received: by 2002:a17:90a:8a05:: with SMTP id w5mr3322390pjn.203.1614345110844;
        Fri, 26 Feb 2021 05:11:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzHofUSr2/ZJvOplOh3Vx9G922eDTTqnwq6KWEeJJfyVjOVE1VQkx6fYBNZDWjNEJG9FOCW5w==
X-Received: by 2002:a17:90a:8a05:: with SMTP id w5mr3322376pjn.203.1614345110578;
        Fri, 26 Feb 2021 05:11:50 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w24sm8852203pgl.19.2021.02.26.05.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 05:11:49 -0800 (PST)
Date:   Fri, 26 Feb 2021 21:11:37 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     dsterba@suse.cz
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Neal Gompa <ngompa13@gmail.com>,
        Amy Parker <enbyamy@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Adding LZ4 compression support to Btrfs
Message-ID: <20210226131137.GA1905816@xiangao.remote.csb>
References: <CAE1WUT53F+xPT-Rt83EStGimQXKoU-rE+oYgcib87pjP4Sm0rw@mail.gmail.com>
 <CAEg-Je-Hs3+F9yshrW2MUmDNTaN-y6J-YxeQjneZx=zC5=58JA@mail.gmail.com>
 <20210225132647.GB7604@twin.jikos.cz>
 <YDfxkGkWnLEfsDwZ@gmail.com>
 <20210226093653.GI7604@twin.jikos.cz>
 <20210226112854.GA1890271@xiangao.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210226112854.GA1890271@xiangao.remote.csb>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 26, 2021 at 07:28:54PM +0800, Gao Xiang wrote:
> On Fri, Feb 26, 2021 at 10:36:53AM +0100, David Sterba wrote:
> > On Thu, Feb 25, 2021 at 10:50:56AM -0800, Eric Biggers wrote:
> > > On Thu, Feb 25, 2021 at 02:26:47PM +0100, David Sterba wrote:
> > > > 
> > > > LZ4 support has been asked for so many times that it has it's own FAQ
> > > > entry:
> > > > https://btrfs.wiki.kernel.org/index.php/FAQ#Will_btrfs_support_LZ4.3F
> > > > 
> > > > The decompression speed is not the only thing that should be evaluated,
> > > > the way compression works in btrfs (in 4k blocks) does not allow good
> > > > compression ratios and overall LZ4 does not do much better than LZO. So
> > > > this is not worth the additional costs of compatibility. With ZSTD we
> > > > got the high compression and recently there have been added real-time
> > > > compression levels that we'll use in btrfs eventually.
> > > 
> > > When ZSTD support was being added to btrfs, it was claimed that btrfs compresses
> > > up to 128KB at a time
> > > (https://lore.kernel.org/r/5a7c09dd-3415-0c00-c0f2-a605a0656499@fb.com).
> > > So which is it -- 4KB or 128KB?
> > 
> > Logical extent ranges are sliced to 128K that are submitted to the
> > compression routine. Then, the whole range is fed by 4K (or more exactly
> > by page sized chunks) to the compression. Depending on the capabilities
> > of the compression algorithm, the 4K chunks are either independent or
> > can reuse some internal state of the algorithm.
> > 
> > LZO and LZ4 use some kind of embedded dictionary in the same buffer, and
> > references to that dictionary directly. Ie. assuming the whole input
> > range to be contiguous. Which is something that's not trivial to achive
> > in kernel because of pages that are not contiguous in general.
> > 
> > Thus, LZO and LZ4 compress 4K at a time, each chunk is independent. This
> > results in worse compression ratio because of less data reuse
> > possibilities. OTOH this allows decompression in place.
> 
> Sorry about the noise before. I misread btrfs LZO implementation.
> Yet it sounds that approach has lower CR than compress 128kb as
> a while. In principle it can archive decompress in-place (margin
> by a whole lzo chunk), yet LZ4/LZO algorithm can have a more
> accurate lower inplace margin in math.
> 
> > 
> > ZLIB and ZSTD can have a separate dictionary and don't need the input
> > chunks to be contiguous. This brings some additional overhead like
> > copying parts of the input to the dictionary and additional memory for
> > themporary structures, but with higher compression ratios.
> > 
> > IIRC the biggest problem for LZ4 was the cost of setting up each 4K
> > chunk, the work memory had to be zeroed. The size of the work memory is
> > tunable but trading off compression ratio. Either way it was either too
> > slow or too bad.
> 
> May I ask why LZ4 needs to zero the work memory (if you mean dest
> buffer and LZ4_decompress_safe), just out of curiousity... I didn't
> see that restriction before. Thanks!

Oh, looking back again, there is a difference between kernel LZ4 code
[1] and lz4 upstream[2] that I didn't notice. If "work memory" above
is that and I understand correctly, no need to zero that memory except
something unique occurs to the kernel implementation itself (Also, it
seems that f2fs compression doesn't zero it when using at least [3],
although I never tried such LZ4 kernel-specific compress interface
before.)

[1] https://github.com/lz4/lz4/blob/dev/lib/lz4.c#L1373
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/lz4/lz4_compress.c#n511
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/f2fs/compress.c#n262

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
> 

