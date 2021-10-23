Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845294383E6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Oct 2021 16:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhJWODr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Oct 2021 10:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhJWODq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Oct 2021 10:03:46 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AFEC061766
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Oct 2021 07:01:27 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id l10-20020a056830154a00b00552b74d629aso8022428otp.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Oct 2021 07:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GKRuYgjCbvOVgpuUacb8YxSFi+RmQ4i5T5oV5f5cqeA=;
        b=B34iaqiy0/nymsgFlq0YNjboFkFPgb2eNGKGB5LSqhx5SAvkkw46MtCnmUiL0kpy91
         Kk5bKhSO4mby88CCeGm6Ixtq3a5FSnKytwSVsm6CCgKcRPjkuABBfLlK8elm7llC2y1T
         M/aMpDm9Tk2ND+Hg04cuTOpvzDYFFBNUWKdXU9Xw8E5HTOWjQbpbexhil20tTVl0UoUQ
         HXbnNVqePLMDULJ1v+y8HRLB5xjQn3DCLhNDnXinpGqF24IiM1NRdqdB32nh1Lw6BCeZ
         QlEhMdFTnPMtLYRqgSBi3f4qt8TUDFFmao4lnQ9rdsV4GmPcWDMOc35KGAA8R+k44CGr
         y6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GKRuYgjCbvOVgpuUacb8YxSFi+RmQ4i5T5oV5f5cqeA=;
        b=ILCcuZWHi/oZqHDJTqQ08DI51Xy4sCGx+7WdkhVZpuwTsN745BL3yttBl1urnaMZjp
         38CDk4UY0Phet9Fsqla6S3kHdjESmyczSESJK1GkVv9c9Meb48Peu4ZfTaeCPfzVG6DZ
         DRRJpbdxX1XL6Duthpqxf5o2bBiUGY+/b1swtDYJ3oGKeu3n2l6us98CQyr1dJ7cSZ9k
         i2uU/jCvAh71Lj69/lTX4TVqdfz1GPlGao+3Yx71UchG8Bf2CJumxQlGJoqU9RQbT8h2
         ZKy2rD7cj7QLyOeSaNEOpeAT3pFNxC5hX+srfsry8c+g6ftIbOpbg7lWbGNeO88nL/WT
         Auvg==
X-Gm-Message-State: AOAM531F418fW4UzmrfbyodwbKOokBRk5Hzc/jTJJ922k0HPva0ZvZPS
        V5jDcQOd8NRPyV/o9O/7aeqxPQ==
X-Google-Smtp-Source: ABdhPJxLHRhLtWtZ3CRZQJCp5+yLa4Xu3IybsZWMpigkUXRnpDSiRgg7OQiFlzXN1rare9EoKjSi/A==
X-Received: by 2002:a9d:3c3:: with SMTP id f61mr4902109otf.196.1634997686271;
        Sat, 23 Oct 2021 07:01:26 -0700 (PDT)
Received: from ?IPv6:2600:380:7c74:6b9d:23e8:d6e3:1c2d:7022? ([2600:380:7c74:6b9d:23e8:d6e3:1c2d:7022])
        by smtp.gmail.com with ESMTPSA id 95sm2286391otr.2.2021.10.23.07.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Oct 2021 07:01:25 -0700 (PDT)
Subject: Re: [PATCH] fs: kill unused ret2 argument from iocb->ki_complete()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     John Keeping <john@metanate.com>, linux-usb@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <ce839d66-1d05-dab8-4540-71b8485fdaf3@kernel.dk>
 <YXBSLweOk1he8DTO@infradead.org>
 <fe54edc2-da83-6dbb-cfb9-ad3a7fbe3780@kernel.dk> <YXBWk8Zzi7yIyTi/@kroah.com>
 <20211021174021.273c82b1.john@metanate.com>
 <e39e7f45-1c1e-a9bb-b413-1dfc21b1b20f@kernel.dk> <YXPRQV1BT2yYYOgN@kroah.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ca6107d5-8e17-3a07-f039-7a06761c616c@kernel.dk>
Date:   Sat, 23 Oct 2021 08:01:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YXPRQV1BT2yYYOgN@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/23/21 3:09 AM, Greg Kroah-Hartman wrote:
> On Fri, Oct 22, 2021 at 09:44:32AM -0600, Jens Axboe wrote:
>> On 10/21/21 10:40 AM, John Keeping wrote:
>>> On Wed, 20 Oct 2021 19:49:07 +0200
>>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>>>
>>>> On Wed, Oct 20, 2021 at 11:35:27AM -0600, Jens Axboe wrote:
>>>>> On 10/20/21 11:30 AM, Christoph Hellwig wrote:  
>>>>>> On Wed, Oct 20, 2021 at 10:49:07AM -0600, Jens Axboe wrote:  
>>>>>>> It's not used for anything, and we're wasting time passing in zeroes
>>>>>>> where we could just ignore it instead. Update all ki_complete users in
>>>>>>> the kernel to drop that last argument.
>>>>>>>
>>>>>>> The exception is the USB gadget code, which passes in non-zero. But
>>>>>>> since nobody every looks at ret2, it's still pointless.  
>>>>>>
>>>>>> Yes, the USB gadget passes non-zero, and aio passes that on to
>>>>>> userspace.  So this is an ABI change.  Does it actually matter?
>>>>>> I don't know, but you could CC the relevant maintainers and list
>>>>>> to try to figure that out.  
>>>>>
>>>>> True, guess it does go out to userspace. Greg, is anyone using
>>>>> it on the userspace side?  
>>>>
>>>> I really do not know (adding linux-usb@vger)  My interactions with the
>>>> gadget code have not been through the aio api, thankfully :)
>>>>
>>>> Odds are it's fine, I think that something had to be passed in there so
>>>> that was chosen?  If the aio code didn't do anything with it, I can't
>>>> see where the gadget code gets it back at anywhere, but I might be
>>>> looking in the wrong place.
>>>>
>>>> Anyone else here know?
>>>
>>> I really doubt anyone uses io_event::res2 with FunctionFS gadgets.  The
>>> examples in tools/usb/ffs-aio-example/ either check just "res" or ignore
>>> the status completely.
>>>
>>> The only other program I can find using aio FunctionFS is adbd which
>>> also checks res and ignores res2 [1].  Other examples I know of just use
>>> synchronous I/O.
>>
>> So is there consensus on the USB side that we can just fill res2 with
>> zero? The single cases that does just do res == res2 puts the error
>> in res anyway, which is what you'd expect.
>>
>> If so, then I do think that'd be cleaner than packing two values into
>> a u64.
> 
> I think yes, we should try that, and if something breaks, be ready to
> provide a fix for it.

I've split the change in two, one that gets rid of the special arguments
on the USB side, and one that then drops it for the whole kernel since
everybody passes 0 at that point. Should make it easy to pinpoint, if
need be.

-- 
Jens Axboe

