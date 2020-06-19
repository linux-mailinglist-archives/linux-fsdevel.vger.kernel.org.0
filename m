Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30E2200B20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 16:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733071AbgFSOPI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 10:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733060AbgFSOPE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:15:04 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A040C0613F0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2020 07:15:04 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p3so1854624pgh.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2020 07:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vKgaeJnyg9cLq81+E0+J+QD8Om9Rb9c3m9dc4xG9lHc=;
        b=d1Z7NBN/J4rcYQozroSRSec7V4c8J8uQC7Sagh9+3gHV4/EUGZjouMvG8jmc1IERbT
         KeSibIf9YZQpn3XPSo3FsVPSQaInICZH8MzKT3/o9y7ADIsXYfXi7S8q2iG0/OqCUS2x
         xzhP8+m1g2l8uPg2MY1CJ9tnWZE+b71fSw0yzq4gsDq3oGThXsuqRq/+X6JVmBwUxVR8
         XIncsGKi0j3r8UBMdHnElslFfoK/euFbUagqpNTJ0/epDTJxZ9ttSTTUJetKEtxHDmkT
         AL4Biv192ULTPLTQYQxQs4X6brZMECUR7nzq5Uze2Fmi2xrsmvgCbtgWbxgIFSm9VJpL
         CCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vKgaeJnyg9cLq81+E0+J+QD8Om9Rb9c3m9dc4xG9lHc=;
        b=lRjMVUmf1kM53FltmyG0WDMN+QlX2Bf+kVqbS3SxEo35nqS53umjsmkIau8eqhnM3X
         nmYgBLYfbW0aQA+ZkEf8DOrEka8jUQ6I2595+6NzSdB+7NIoqeWJxi6xFa6JVozDEHJK
         IIY3RyJ/Ka2COzIIK20zttEhOn3TYlKeDvgapTloTerLCVhTbUuHwKL7/9MD2RA4s8Pz
         Aap4ju8WOXnln5v7MTKgf6Vf4r+DDQx5fmTezofW/82rO/8a2jX28trcoMbENY3MsNpy
         RQkOFTXKonY7K0/1rdqrFfTtt6AvF+otqQkYrAeJLdp7U9EwDSPH0wE1eswhM1asy+an
         D0iQ==
X-Gm-Message-State: AOAM53253A5Witu9ASXB5gKDg3NcfrhUQs+BXhOiYOSCdcGu+855T49L
        yBK5tk5maFPJtx5uihcXvKwcNg==
X-Google-Smtp-Source: ABdhPJxJ5rUdZQlZ85uNdWYu0aORrSm4Hs/gqNUu5fZPN0AfOVDyqgnm2fFHhgtfgfuyb46iF3hR1Q==
X-Received: by 2002:a63:7987:: with SMTP id u129mr3109208pgc.353.1592576103577;
        Fri, 19 Jun 2020 07:15:03 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id f29sm2504625pga.59.2020.06.19.07.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 07:15:03 -0700 (PDT)
Subject: Re: [PATCH 3/3] io_uring: add support for zone-append
To:     "javier.gonz@samsung.com" <javier@javigon.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Kanchan Joshi <joshi.k@samsung.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "bcrl@kvack.org" <bcrl@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>,
        "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "selvakuma.s1@samsung.com" <selvakuma.s1@samsung.com>,
        "nj.shetty@samsung.com" <nj.shetty@samsung.com>
References: <1592414619-5646-1-git-send-email-joshi.k@samsung.com>
 <CGME20200617172713epcas5p352f2907a12bd4ee3c97be1c7d8e1569e@epcas5p3.samsung.com>
 <1592414619-5646-4-git-send-email-joshi.k@samsung.com>
 <CY4PR04MB37510E916B6F243D189B4EB0E79B0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200618083529.ciifu4chr4vrv2j5@mpHalley.local>
 <CY4PR04MB3751D5D6AFB0DA7B8A2DFF61E79B0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200618091113.eu2xdp6zmdooy5d2@mpHalley.local>
 <20200619094149.uaorbger326s6yzz@mpHalley.local>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <31f1c27e-4a3d-a411-3d3b-f88a2d92ce7b@kernel.dk>
Date:   Fri, 19 Jun 2020 08:15:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200619094149.uaorbger326s6yzz@mpHalley.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/19/20 3:41 AM, javier.gonz@samsung.com wrote:
> Jens,
> 
> Would you have time to answer a question below in this thread?
> 
> On 18.06.2020 11:11, javier.gonz@samsung.com wrote:
>> On 18.06.2020 08:47, Damien Le Moal wrote:
>>> On 2020/06/18 17:35, javier.gonz@samsung.com wrote:
>>>> On 18.06.2020 07:39, Damien Le Moal wrote:
>>>>> On 2020/06/18 2:27, Kanchan Joshi wrote:
>>>>>> From: Selvakumar S <selvakuma.s1@samsung.com>
>>>>>>
>>>>>> Introduce three new opcodes for zone-append -
>>>>>>
>>>>>>   IORING_OP_ZONE_APPEND     : non-vectord, similiar to IORING_OP_WRITE
>>>>>>   IORING_OP_ZONE_APPENDV    : vectored, similar to IORING_OP_WRITEV
>>>>>>   IORING_OP_ZONE_APPEND_FIXED : append using fixed-buffers
>>>>>>
>>>>>> Repurpose cqe->flags to return zone-relative offset.
>>>>>>
>>>>>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
>>>>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>>>>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>>>>>> Signed-off-by: Javier Gonzalez <javier.gonz@samsung.com>
>>>>>> ---
>>>>>> fs/io_uring.c                 | 72 +++++++++++++++++++++++++++++++++++++++++--
>>>>>> include/uapi/linux/io_uring.h |  8 ++++-
>>>>>> 2 files changed, 77 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>>>>> index 155f3d8..c14c873 100644
>>>>>> --- a/fs/io_uring.c
>>>>>> +++ b/fs/io_uring.c
>>>>>> @@ -649,6 +649,10 @@ struct io_kiocb {
>>>>>> 	unsigned long		fsize;
>>>>>> 	u64			user_data;
>>>>>> 	u32			result;
>>>>>> +#ifdef CONFIG_BLK_DEV_ZONED
>>>>>> +	/* zone-relative offset for append, in bytes */
>>>>>> +	u32			append_offset;
>>>>>
>>>>> this can overflow. u64 is needed.
>>>>
>>>> We chose to do it this way to start with because struct io_uring_cqe
>>>> only has space for u32 when we reuse the flags.
>>>>
>>>> We can of course create a new cqe structure, but that will come with
>>>> larger changes to io_uring for supporting append.
>>>>
>>>> Do you believe this is a better approach?
>>>
>>> The problem is that zone size are 32 bits in the kernel, as a number
>>> of sectors.  So any device that has a zone size smaller or equal to
>>> 2^31 512B sectors can be accepted. Using a zone relative offset in
>>> bytes for returning zone append result is OK-ish, but to match the
>>> kernel supported range of possible zone size, you need 31+9 bits...
>>> 32 does not cut it.
>>
>> Agree. Our initial assumption was that u32 would cover current zone size
>> requirements, but if this is a no-go, we will take the longer path.
> 
> Converting to u64 will require a new version of io_uring_cqe, where we
> extend at least 32 bits. I believe this will need a whole new allocation
> and probably ioctl().
> 
> Is this an acceptable change for you? We will of course add support for
> liburing when we agree on the right way to do this.

If you need 64-bit of return value, then it's not going to work. Even
with the existing patches, reusing cqe->flags isn't going to fly, as
it would conflict with eg doing zone append writes with automatic
buffer selection.

We're not changing the io_uring_cqe. It's important to keep it lean, and
any other request type is generally fine with 64-bit tag + 32-bit result
(and 32-bit flags on the side) for completions.

Only viable alternative I see would be to provide an area to store this
information, and pass in a pointer to this at submission time through
the sqe. One issue I do see with that is if we only have this
information available at completion time, then we'd need some async punt
to copy it to user space... Generally not ideal.

A hackier approach would be to play some tricks with cqe->res and
cqe->flags, setting aside a flag to denote an extension of cqe->res.
That would mean excluding zone append (etc) from using buffer selection,
which probably isn't a huge deal. It'd be more problematic for any other
future flags. But if you just need 40 bits, then it could certainly
work. Rigth now, if cqe->flags & 1 is set, then (cqe->flags >> 16) is
the buffer ID. You could define IORING_CQE_F_ZONE_FOO to be bit 1, so
that:

	uint64_t val = cqe->res; // assuming non-error here

	if (cqe->flags & IORING_CQE_F_ZONE_FOO)
		val |= (cqe->flags >> 16) << 32ULL;

and hence use the upper 16 bits of cqe->flags for the upper bits of your
(then) 48-bit total value.

-- 
Jens Axboe

