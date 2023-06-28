Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5687413F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 16:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjF1Okj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 10:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjF1Okd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:40:33 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E0C2118
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 07:40:31 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-345ac638074so3820475ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 07:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687963230; x=1690555230;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gw+1SzCqOzLBAsCHPofcZWnW/1XnEKR52ONcAb/VwIU=;
        b=nMvogRKjodPYqMEKzS1+45qiQ1ts6quMm+6EBnJOqhU0hfN8kaUd8jx/fMWbr+GZ52
         nbR2svkXJ8qCfmRdRfaWCGF+x6DZmh7IFMkcC/xwNTZMov8F0qz0dFJ28i8B076zXjm7
         JkCBYXsfYhytvZ51G1ch0A84X1/Dw56tQB50WUdQqlZOp42caRwZje9sNVjdDJczbCTb
         iKHLJzdfg+mrshlTq3DoTtEF1fSOwFGZ/gcD5XWxCUWZpxRKXgMlKfdBW4AUzg79TYqo
         rs2Wl0BsyQDOQmwp6PkcE+/6ldYlAG6NIG0bA523SM+Hfoo8CIZWfz5iMFOxArBiJPvk
         7NTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687963230; x=1690555230;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gw+1SzCqOzLBAsCHPofcZWnW/1XnEKR52ONcAb/VwIU=;
        b=lrSKbsL9etsnc1uq7cXKOHMx7K26tOEbc+jveh1z5MKpreBc9NiA7wwdAloP1IIEiN
         t6kkj4VkSHigPaLTAx3goXXHYJB+zwpapNRDvk2nFHvL7JDVJpkx8KnJTWPizt8KnMjY
         Xzd2AxqO7w2w2ZQsUF41GMWxM8OiW+AIfj+1moOyZByykqm/zOWYyJ6qXaLs5knKz9rD
         8bqszb+YNfgoIFJ68UZ4M5cD8mitXPDqbyZVbHol0/JjDY7VyO4MI+9NxUFsvqd+ummt
         77NrsqWVAjkxuQ8cO73uCLvzBF/rfTaCMWWQTtvvywW4NSDZ/19vi71skBLZ/U+oVFsX
         5szw==
X-Gm-Message-State: AC+VfDxIeKpSlkj0lcf0XKldbEjzuKtMrenc1FNlA+4l3jCea/gPQJaG
        NoetZwmpLGkGXcEfxiayC9734A==
X-Google-Smtp-Source: ACHHUZ4+2SAm8EoLrcc2AtB8NSlinSM93X0+AZ5q0LtuDQS3X5xb6WUFpx//qOrq7G76Q1FXgqMeoQ==
X-Received: by 2002:a6b:1495:0:b0:780:d65c:d78f with SMTP id 143-20020a6b1495000000b00780d65cd78fmr16017374iou.2.1687963230425;
        Wed, 28 Jun 2023 07:40:30 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ed21-20020a056638291500b0042af158d05fsm436706jab.114.2023.06.28.07.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 07:40:29 -0700 (PDT)
Message-ID: <3337524d-347c-900a-a1c7-5774cd731af0@kernel.dk>
Date:   Wed, 28 Jun 2023 08:40:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [GIT PULL] bcachefs
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>,
        Kent Overstreet <kent.overstreet@linux.dev>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <aeb2690c-4f0a-003d-ba8b-fe06cd4142d1@kernel.dk>
 <20230627000635.43azxbkd2uf3tu6b@moria.home.lan>
 <91e9064b-84e3-1712-0395-b017c7c4a964@kernel.dk>
 <20230627020525.2vqnt2pxhtgiddyv@moria.home.lan>
 <b92ea170-d531-00f3-ca7a-613c05dcbf5f@kernel.dk>
 <23922545-917a-06bd-ec92-ff6aa66118e2@kernel.dk>
 <20230627201524.ool73bps2lre2tsz@moria.home.lan>
 <ZJtdEgbt+Wa8UHij@dread.disaster.area>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZJtdEgbt+Wa8UHij@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/27/23 4:05?PM, Dave Chinner wrote:
> On Tue, Jun 27, 2023 at 04:15:24PM -0400, Kent Overstreet wrote:
>> On Tue, Jun 27, 2023 at 11:16:01AM -0600, Jens Axboe wrote:
>>> On 6/26/23 8:59?PM, Jens Axboe wrote:
>>>> On 6/26/23 8:05?PM, Kent Overstreet wrote:
>>>>> On Mon, Jun 26, 2023 at 07:13:54PM -0600, Jens Axboe wrote:
>>>>>> Doesn't reproduce for me with XFS. The above ktest doesn't work for me
>>>>>> either:
>>>>>
>>>>> It just popped for me on xfs, but it took half an hour or so of looping
>>>>> vs. 30 seconds on bcachefs.
>>>>
>>>> OK, I'll try and leave it running overnight and see if I can get it to
>>>> trigger.
>>>
>>> I did manage to reproduce it, and also managed to get bcachefs to run
>>> the test. But I had to add:
>>>
>>> diff --git a/check b/check
>>> index 5f9f1a6bec88..6d74bd4933bd 100755
>>> --- a/check
>>> +++ b/check
>>> @@ -283,7 +283,7 @@ while [ $# -gt 0 ]; do
>>>  	case "$1" in
>>>  	-\? | -h | --help) usage ;;
>>>  
>>> -	-nfs|-afs|-glusterfs|-cifs|-9p|-fuse|-virtiofs|-pvfs2|-tmpfs|-ubifs)
>>> +	-nfs|-afs|-glusterfs|-cifs|-9p|-fuse|-virtiofs|-pvfs2|-tmpfs|-ubifs|-bcachefs)
>>>  		FSTYP="${1:1}"
>>>  		;;
>>>  	-overlay)
>>
>> I wonder if this is due to an upstream fstests change I haven't seen
>> yet, I'll have a look.
> 
> Run mkfs.bcachefs on the testdir first. fstests tries to probe the
> filesystem type to test if $FSTYP is not set. If it doesn't find a
> filesystem or it is unsupported, it will use the default (i.e. XFS).

I did format both test and scratch first with bcachefs, so guessing
something is going wrong with figuring out what filesystem is on the
device and then it defaults to XFS. I didn't spend too much time on that
bit, figured it was easier to just force bcachefs for my purpose.

> There should be no reason to need to specify the filesystem type for
> filesystems that blkid recognises. from common/config:
> 
>         # Autodetect fs type based on what's on $TEST_DEV unless it's been set
>         # externally
>         if [ -z "$FSTYP" ] && [ ! -z "$TEST_DEV" ]; then
>                 FSTYP=`blkid -c /dev/null -s TYPE -o value $TEST_DEV`
>         fi
>         FSTYP=${FSTYP:=xfs}
>         export FSTYP

Gotcha, yep it's because blkid fails to figure it out.

-- 
Jens Axboe

