Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F3443687B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 18:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhJUQ65 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 12:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbhJUQ64 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:58:56 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA97C0613B9
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 09:56:40 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id n63so1642945oif.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 09:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/hlV407F1l+ROiLc6tM2c93643d0+AHOqhGVvP4z9QY=;
        b=LohioBCl5wGoK963SUABKlFG5Z7gnOJVzhz+v0Es4zjnxy8/hY4q4m62vPBxo1lna8
         VXAmLliqNuivGoaAV8rlJ9MA3lCQpaIIztRIjcRy1gNRbSNPwyydcef/cTaE1MaUr2Sq
         8zPafVhchDKM1Yx2cKy41ug0iSvWSBj6eq7BbxC75pWStXkaZAoswc+QK+ukawpyC8zv
         aVFE36fGm5a93cLtA/haDVo35306888aTI3t836IQsCogAT4xrLIQ4w4p1ZT1SbrmyVY
         HQWLef5rEYt2E8WFoq1LGaFLYu7HITE8Dzz7/G88bby6x9fwyFq3rcrQrSJ968LoWhtD
         5nTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/hlV407F1l+ROiLc6tM2c93643d0+AHOqhGVvP4z9QY=;
        b=q9FzrzACZ2m9u0EuQH1Mcs5Z91WMPwJyblu9Ys+iyIb6eaGvixTWWm264JwGTSC1zp
         cmgT2rcmFkgCNaXGrdmjJeM8vqVyF5JiMb67eqLA7gs2Cz9wZM67yF9LAdbZN5jSbllv
         9E3Acu0bpgkMAEZDiQIoDMM9WLEq5rnBJFwpAisYde9icrxJ/z5WdFP6SF1GpjNRZsjz
         +k7JBEBfTbJulevpxfIc/8Ex8i2Bl1n4Dc2DCEeswfpD4JH24AIcbnqrtEqmkH+B5IO7
         kJWjrYgqF3ijkeKVHvUIKFhQU0mSAVfqYZsgkakk8W933NpNpfzClHmgALwGNYXe7eAZ
         4EJw==
X-Gm-Message-State: AOAM531z2gFPhVd9mKemqaEILHEmXImdTMb6J8KaJnCyB2mNbZEcIGpv
        8BmLclxSUUJ5kmV0db2KOkyWmQ==
X-Google-Smtp-Source: ABdhPJyIl3B3WhG49DdG18eRdUfkGtfJCsFJhehcK1kmRxQlOjFYPLDQjkX18yZ0tq/J/9Yy/uvjzw==
X-Received: by 2002:a05:6808:171b:: with SMTP id bc27mr5719417oib.21.1634835399871;
        Thu, 21 Oct 2021 09:56:39 -0700 (PDT)
Received: from ?IPv6:2600:380:783a:c43c:af64:c142:4db7:63ac? ([2600:380:783a:c43c:af64:c142:4db7:63ac])
        by smtp.gmail.com with ESMTPSA id n107sm396229ota.40.2021.10.21.09.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 09:56:39 -0700 (PDT)
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
Message-ID: <ab08cafb-613f-ce38-4437-8f247c0bc0c2@kernel.dk>
Date:   Thu, 21 Oct 2021 10:56:38 -0600
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

We might consider doing a separate change to just skip status reporting,
and then once a few releases have passed and if nobody has complained,
then we can drop it entirely. If we do it separately, it'd be an easy
revert of just that part if we do run into trouble.

At least for now we'll just have the one argument bundling the two parts
for aio, so there's not a great need to eliminate the status thing on
the USB gadget side. But if it is unused, then it should get removed
regardless.

-- 
Jens Axboe

