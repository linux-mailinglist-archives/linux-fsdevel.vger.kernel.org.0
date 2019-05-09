Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E637A18F08
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 19:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfEIR1e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 13:27:34 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:40086 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfEIR1d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 13:27:33 -0400
Received: by mail-qt1-f176.google.com with SMTP id k24so2681445qtq.7;
        Thu, 09 May 2019 10:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z1iz9vEs0b7fqPsRaIuhZp4UuJFqEjrvwJvAU/xFaT8=;
        b=pP5wTag8CufNIUOJvk18Dimi2Xzw5nyCairIxRvmSrPbZrsk0/kEZZwOJH66hqc+h8
         q2YDSDji3508wVMI7QPuNQC5y1+5LToCoL2BjU21ZBV3A58un/yeE9+qqpbZ099+p3ux
         uIkqzaWNU5mec9eJuNPnhBQ9rKjG+LrFtJQFDHgQUFnK/7+o0kybQqevAHqi1nnJarat
         XAmuHA+TVvDfcARXL2+uInzrBbT5s+x+BWp+NxWLxu/j7hQpY2Y4Y5opPpmW1UC+1+cU
         79LwNOuwaPB83pfOTweqinH8jAsOpTUpYGtenfH0qewBb2n8fhFTYNq7MYa0NB2p6nN0
         9ODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z1iz9vEs0b7fqPsRaIuhZp4UuJFqEjrvwJvAU/xFaT8=;
        b=cdC8I3n6NFQDXrM3NVaXC598QpbDW4JAz3fWOSX1K6C9jSGqM+LyemiIb3Bj0XIAS7
         r7MXG+cf7ORHZKdfKt1DflJ0LbZ18AlV+H3Z5vmaVNPm0KJ9K07VLeNFzjGAjtEBNqe8
         rsmJfrtGEy6Rx7AaFndx5X4jMcpVsmIUIZJUOqSzmLVoyyTh9mTxaOcm+Q6RsTjv/zql
         n+s7KZ5cBKUhHbIjjDRqX3epLI1WLXFVUo/2/ba++y3OHIxqI7ppWLAJVH5TXe+YCntI
         E4waRkJqH17T5uwQeCB8m6MRoNx/FY41buHboH1L6yRr6PID1APOZk+xVmPPKCd4gTbH
         1fng==
X-Gm-Message-State: APjAAAVAJweALvuVAtOaZ7aURnV3nHvk5rAm7/GYRhID0vgpjOdgY1dU
        Hey3PJhcDZl9l7EJ08wf4Yc=
X-Google-Smtp-Source: APXvYqyo0qa/exVlpFP2E22le8plC2k2XMdg4g1KzqUal8QPo4Xfjw3Pc2j/ZlvCSRJPF4SwVEW14Q==
X-Received: by 2002:a0c:b352:: with SMTP id a18mr4665220qvf.139.1557422852376;
        Thu, 09 May 2019 10:27:32 -0700 (PDT)
Received: from localhost.localdomain ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id f129sm1304174qkj.47.2019.05.09.10.27.31
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 10:27:31 -0700 (PDT)
Subject: Re: Testing devices for discard support properly
To:     Bryan Gurney <bgurney@redhat.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        =?UTF-8?B?THVrw6HFoSBDemVybmVy?= <lczerner@redhat.com>
References: <4a484c50-ef29-2db9-d581-557c2ea8f494@gmail.com>
 <20190507220449.GP1454@dread.disaster.area>
 <a409b3d1-960b-84a4-1b8d-1822c305ea18@gmail.com>
 <20190508011407.GQ1454@dread.disaster.area>
 <13b63de0-18bc-eb24-63b4-3c69c6a007b3@gmail.com> <yq1a7fwlvzb.fsf@oracle.com>
 <0a16285c-545a-e94a-c733-bcc3d4556557@gmail.com> <yq15zqkluyl.fsf@oracle.com>
 <99144ff8-4f2c-487d-a366-6294f87beb58@gmail.com>
 <CAHhmqcS19DUptiUeQ7q3pPCiZ6QcAXYxQwaX5nQ1FM38trzWtQ@mail.gmail.com>
From:   Ric Wheeler <ricwheeler@gmail.com>
Message-ID: <ac188221-5d17-bf30-99f1-6a8d152a2f83@gmail.com>
Date:   Thu, 9 May 2019 13:27:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHhmqcS19DUptiUeQ7q3pPCiZ6QcAXYxQwaX5nQ1FM38trzWtQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/9/19 12:02 PM, Bryan Gurney wrote:
> On Wed, May 8, 2019 at 2:12 PM Ric Wheeler <ricwheeler@gmail.com> wrote:
>>
>> (stripped out the html junk, resending)
>>
>> On 5/8/19 1:25 PM, Martin K. Petersen wrote:
>>>>> WRITE SAME also has an ANCHOR flag which provides a use case we
>>>>> currently don't have fallocate plumbing for: Allocating blocks without
>>>>> caring about their contents. I.e. the blocks described by the I/O are
>>>>> locked down to prevent ENOSPC for future writes.
>>>> Thanks for that detail! Sounds like ANCHOR in this case exposes
>>>> whatever data is there (similar I suppose to normal block device
>>>> behavior without discard for unused space)? Seems like it would be
>>>> useful for virtually provisioned devices (enterprise arrays or
>>>> something like dm-thin targets) more than normal SSD's?
>>> It is typically used to pin down important areas to ensure one doesn't
>>> get ENOSPC when writing journal or metadata. However, these are
>>> typically the areas that we deliberately zero to ensure predictable
>>> results. So I think the only case where anchoring makes much sense is on
>>> devices that do zero detection and thus wouldn't actually provision N
>>> blocks full of zeroes.
>>
>> This behavior at the block layer might also be interesting for something
>> like the VDO device (compression/dedup make it near impossible to
>> predict how much space is really there since it is content specific).
>> Might be useful as a way to hint to VDO about how to give users a
>> promise of "at least this much" space? If the content is good for
>> compression or dedup, you would get more, but never see less.
>>
> 
> In the case of VDO, writing zeroed blocks will not consume space, due
> to the zero block elimination in VDO.  However, that also means that
> it won't "reserve" space, either.  The WRITE SAME command with the
> ANCHOR flag is SCSI, so it won't apply to a bio-based device.
> 
> Space savings also results in a write of N blocks having a fair chance
> of the end result ultimately using "less than N" blocks, depending on
> how much space savings can be achieved.  Likewise, a discard of N
> blocks has a chance of reclaiming "less than N" blocks.
> 

Are there other API's that let you allocate a minimum set of physical 
blocks to a VDO device?

Thanks!

Ric


