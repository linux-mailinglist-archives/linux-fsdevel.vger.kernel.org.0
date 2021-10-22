Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B393437A3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 17:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbhJVPrF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 11:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbhJVPqw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 11:46:52 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9865EC061766
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Oct 2021 08:44:34 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id y15-20020a9d460f000000b0055337e17a55so4842732ote.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Oct 2021 08:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CS9bwv4RhWvgp6bzDq9Y51ywxUUUbMgvQSyQV32vjZk=;
        b=3RFG9N6FryiO0pNLTmVART5FavopPVk66VO9gOqpHxbXEVRM33Km0olXApFaJBUo3L
         tFDk20rwO1M09Ds4NLJSs+ZiPGY7i430Afvi7QU0Akvr4XUjndo9x5n/c15/gAJAi5wB
         cADgzBw/Y+v4Fop55oBcDZQ7fVnx/5X46lA/WZaiQggwkvx6qZ8BOzMfrFeGeokvjgzy
         OGbwqRpJ+p2+OCglLO2iTcSVvuzNhTivn5GH4kBAvqawVyPy3ioblwZM7CNNrq4+uMrT
         UXSeI6cDlTdxTbQdpx++vYtuTYd/yn0wUXV/Y9pGqcvSD8DYKWxSnxCdBA31kQVM1w4a
         UnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CS9bwv4RhWvgp6bzDq9Y51ywxUUUbMgvQSyQV32vjZk=;
        b=mbgUKJgBaNsVyWSBtQ0g1obEvHtI9832P5/dLtAZMRLSng4zxPR+H7Oyw6tm6msnj7
         TMMN8UaDU6wWIjBOPPqRRJRfD2HkrP8XpWpSOBcg9kXsKY7vjLKkIrBAVVbiQoCu+N1y
         ZWdP+Yvy7WY+SEuHYwFGmtXptphQB281eh3I48QmYuyMLEQm9+Sawd5sqdsYCundU/07
         UJKT2m98Nqs41tueqNe0dnMCAb8xsJYuLC+wF32jZG1+WT4FE3YiK+C5xeqZX491Y/xc
         PIxDcxZ9d/kwTsuA3mjPl5x92nYCtQOkaWnv+A52Xv6czGGz+oUHA31IJzqG97M8xAPQ
         q6og==
X-Gm-Message-State: AOAM53041NP1nDGY6VflkplK8J7wki7zjk589VZlFvH0IMv347oAyVua
        dEbw9XrXzxT1tDkwYf5zNAivjw==
X-Google-Smtp-Source: ABdhPJyMhg6iLkwlQsWO18bFfzjZJg7qQx8VD2PVUMHo7ycvtSdAM7VZLoLoELtcmcxBr6I10JcFqw==
X-Received: by 2002:a05:6830:3155:: with SMTP id c21mr554048ots.104.1634917473930;
        Fri, 22 Oct 2021 08:44:33 -0700 (PDT)
Received: from [172.20.15.86] (rrcs-24-173-18-66.sw.biz.rr.com. [24.173.18.66])
        by smtp.gmail.com with ESMTPSA id be2sm1959250oib.1.2021.10.22.08.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 08:44:33 -0700 (PDT)
Subject: Re: [PATCH] fs: kill unused ret2 argument from iocb->ki_complete()
To:     John Keeping <john@metanate.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <ce839d66-1d05-dab8-4540-71b8485fdaf3@kernel.dk>
 <YXBSLweOk1he8DTO@infradead.org>
 <fe54edc2-da83-6dbb-cfb9-ad3a7fbe3780@kernel.dk> <YXBWk8Zzi7yIyTi/@kroah.com>
 <20211021174021.273c82b1.john@metanate.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e39e7f45-1c1e-a9bb-b413-1dfc21b1b20f@kernel.dk>
Date:   Fri, 22 Oct 2021 09:44:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211021174021.273c82b1.john@metanate.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/21/21 10:40 AM, John Keeping wrote:
> On Wed, 20 Oct 2021 19:49:07 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
>> On Wed, Oct 20, 2021 at 11:35:27AM -0600, Jens Axboe wrote:
>>> On 10/20/21 11:30 AM, Christoph Hellwig wrote:  
>>>> On Wed, Oct 20, 2021 at 10:49:07AM -0600, Jens Axboe wrote:  
>>>>> It's not used for anything, and we're wasting time passing in zeroes
>>>>> where we could just ignore it instead. Update all ki_complete users in
>>>>> the kernel to drop that last argument.
>>>>>
>>>>> The exception is the USB gadget code, which passes in non-zero. But
>>>>> since nobody every looks at ret2, it's still pointless.  
>>>>
>>>> Yes, the USB gadget passes non-zero, and aio passes that on to
>>>> userspace.  So this is an ABI change.  Does it actually matter?
>>>> I don't know, but you could CC the relevant maintainers and list
>>>> to try to figure that out.  
>>>
>>> True, guess it does go out to userspace. Greg, is anyone using
>>> it on the userspace side?  
>>
>> I really do not know (adding linux-usb@vger)  My interactions with the
>> gadget code have not been through the aio api, thankfully :)
>>
>> Odds are it's fine, I think that something had to be passed in there so
>> that was chosen?  If the aio code didn't do anything with it, I can't
>> see where the gadget code gets it back at anywhere, but I might be
>> looking in the wrong place.
>>
>> Anyone else here know?
> 
> I really doubt anyone uses io_event::res2 with FunctionFS gadgets.  The
> examples in tools/usb/ffs-aio-example/ either check just "res" or ignore
> the status completely.
> 
> The only other program I can find using aio FunctionFS is adbd which
> also checks res and ignores res2 [1].  Other examples I know of just use
> synchronous I/O.

So is there consensus on the USB side that we can just fill res2 with
zero? The single cases that does just do res == res2 puts the error
in res anyway, which is what you'd expect.

If so, then I do think that'd be cleaner than packing two values into
a u64.

-- 
Jens Axboe

