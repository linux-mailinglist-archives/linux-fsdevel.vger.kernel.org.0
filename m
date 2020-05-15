Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15FD1D549C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 17:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgEOP0Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 11:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726188AbgEOP0X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 11:26:23 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A90CC061A0C
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2020 08:26:23 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ms17so1057248pjb.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2020 08:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LliiKcH82187Ei8bkdTXbelsSpYlSsXvGYR9ZJz3ZGg=;
        b=QnAl9q4FMT3RTcx21fu1lA2YNiX3reW05bHM+U4uBWvV+e3p1ldsSdmS5NxA4xgmmR
         bkHlfm6VmW6X6uSUHlo7ae9rQE6OXXFbuqvNov4mBhD+xqQ7+Kc4CV9umMQ7v+00VZkO
         Kz+EVA8TAzKzrehCfU6F8hW76gHm/fDBLCCK+d6VCvj1ZTXIuQ/tsqXLbSzm3cobI0k0
         KzTaVThkrZm3XuoOnkUHJEaqAm1DYkr2ajRkTX2++BgfwlQ/Nad/4A4FAss9RXxMSlbd
         encOs1fUurYyiRJvfuM61PQ1cWTdERBfEIYOv1Nc3SuCnYxxywPmq5pjWJEKKSSWBHmP
         ac8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LliiKcH82187Ei8bkdTXbelsSpYlSsXvGYR9ZJz3ZGg=;
        b=JKX7agM3a8DnRdu/7hgxCUSXUURxSZlwJqUjgiZGppOELdo/hOAAcQkOO8qyqI197G
         /lPIv4idwgegr3RGrkD1jdfHccuaqVrZ60TxxQvcZ+0ZJq4upi4p9W3CJ1r0nF3paZcl
         +IhykghA0U0eGD6HqstB8rshNhhOkZ0DoOOQqUFomFyKuKqzhsH/+Xa8rX69cM1voE2k
         viKGbHJ7aLVLxvElHpWJgw2eR4BEfxqTKqatTm4E7iVwjxOHB0YVZSNJCFWq/oh0M5Um
         2xAnfsf+UgmahSMNmidk2l/Ut3HdVM+PhmL/RuLD1CxbvkZoaRsCh976VMXUCOX+GTBl
         TlUg==
X-Gm-Message-State: AOAM531KjnQ5FQ7gSK6NWhXrcS83Lz6Om5/WZxie3iOLD2k39j76q3Mg
        fMHTQXdznEFIoI7ICC17jsq9Aw==
X-Google-Smtp-Source: ABdhPJxUPrXABjDzIPXp+x/8r/5wxyI+DEBaiWyfzWvYHWm4zV72ZTN0iUWez+vYQdK762O6l+fF5Q==
X-Received: by 2002:a17:90b:4d0d:: with SMTP id mw13mr3875034pjb.218.1589556382711;
        Fri, 15 May 2020 08:26:22 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:aca2:b1c9:3206:e390? ([2605:e000:100e:8c61:aca2:b1c9:3206:e390])
        by smtp.gmail.com with ESMTPSA id z66sm2200459pfz.141.2020.05.15.08.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 08:26:21 -0700 (PDT)
Subject: Re: [PATCH 0/2] io_uring: add a CQ ring flag to enable/disable
 eventfd notification
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20200515105414.68683-1-sgarzare@redhat.com>
 <eaab5cc7-0297-a8f8-f7a9-e00bcf12b678@kernel.dk>
 <20200515143419.f3uggj7h3nyolfqb@steredhat>
 <a7ac101d-0f5d-2ab2-b36b-b40607d65878@kernel.dk>
 <20200515152418.oi6btvogplmuezfn@steredhat>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b297e61f-3647-54f2-b9a6-21707158fed9@kernel.dk>
Date:   Fri, 15 May 2020 09:26:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515152418.oi6btvogplmuezfn@steredhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/15/20 9:24 AM, Stefano Garzarella wrote:
> On Fri, May 15, 2020 at 09:13:33AM -0600, Jens Axboe wrote:
>> On 5/15/20 8:34 AM, Stefano Garzarella wrote:
>>> On Fri, May 15, 2020 at 08:24:58AM -0600, Jens Axboe wrote:
>>>> On 5/15/20 4:54 AM, Stefano Garzarella wrote:
>>>>> The first patch adds the new 'cq_flags' field for the CQ ring. It
>>>>> should be written by the application and read by the kernel.
>>>>>
>>>>> The second patch adds a new IORING_CQ_NEED_WAKEUP flag that can be
>>>>> used by the application to enable/disable eventfd notifications.
>>>>>
>>>>> I'm not sure the name is the best one, an alternative could be
>>>>> IORING_CQ_NEED_EVENT.
>>>>>
>>>>> This feature can be useful if the application are using eventfd to be
>>>>> notified when requests are completed, but they don't want a notification
>>>>> for every request.
>>>>> Of course the application can already remove the eventfd from the event
>>>>> loop, but as soon as it adds the eventfd again, it will be notified,
>>>>> even if it has already handled all the completed requests.
>>>>>
>>>>> The most important use case is when the registered eventfd is used to
>>>>> notify a KVM guest through irqfd and we want a mechanism to
>>>>> enable/disable interrupts.
>>>>>
>>>>> I also extended liburing API and added a test case here:
>>>>> https://github.com/stefano-garzarella/liburing/tree/eventfd-disable
>>>>
>>>> Don't mind the feature, and I think the patches look fine. But the name
>>>> is really horrible, I'd have no idea what that flag does without looking
>>>> at the code or a man page. Why not call it IORING_CQ_EVENTFD_ENABLED or
>>>> something like that? Or maybe IORING_CQ_EVENTFD_DISABLED, and then you
>>>> don't have to muck with the default value either. The app would set the
>>>> flag to disable eventfd, temporarily, and clear it again when it wants
>>>> notifications again.
>>>
>>> You're clearly right! :-) The name was horrible.
>>
>> Sometimes you go down that path on naming and just can't think of
>> the right one. I think we've all been there.
> 
> :-)
> 
>>
>>> I agree that IORING_CQ_EVENTFD_DISABLED should be the best.
>>> I'll send a v2 changing the name and removing the default value.
>>
>> Great thanks, and please do queue a pull for the liburing side too.
> 
> For the liburing side do you prefer a PR on github or posting the
> patches on io-uring@vger.kernel.org with 'liburing' tag?

Either one is fine. I tend to prefer patches, but that's mostly because
various contributors on the liburing side don't have the same kind of
patch writing etiquette that we do on the kernel side. Hence they need
massaging in terms of commit messages, and patches are then easier. But
for you, just do what you prefer. I never use the github merge features,
always do it manually myself anyway.

-- 
Jens Axboe

