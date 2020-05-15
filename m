Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0493A1D58DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 20:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgEOSRp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 14:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgEOSRo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 14:17:44 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2169C05BD0A
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2020 11:17:44 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id v63so1344742pfb.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2020 11:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MQ4wGQK4HJGpPKqcajR0zrY/G28luDq8Vm3rkva5Veo=;
        b=jJ5NV32vjYnf+3B7EVOMNSKt9CGk8/ztEwZ2/IVShnsOnn/YWf8Cq8Fj4XyjEETFIb
         Nx0qznk0qoM/d4NCwVziqX4rjqqObXVtOvuhBD7hlzlT1rU/XBWwF2ge7dygEptfG3v6
         9DoSyk6Zbfu8dnH9RRSpyj4JrZs1S6oXxslawre6YaO7PRsps8TPeCTiy2mya5G2c4JD
         j9ov85cQkfzEqMl6XYLQCdl+pXPwBPtfEFMntvPKMWpY6Nzehs82l5OIiteXt+U0dT5I
         x8i51CIRAdxut7syKCkQ56RqDnHRoBkWDmVm3e2/ku8fJPNdo/XepaiMr9nUG+GvvK46
         oGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MQ4wGQK4HJGpPKqcajR0zrY/G28luDq8Vm3rkva5Veo=;
        b=prk/7e9tU4AC0kXickttiCZGG+R32dgBJWR5FGYyNzYUawhf+hGcF6Rsxa7WQXdEGG
         xh7tnyWBrIKkumUx4tEfDh7+/LR0xYrfWbS4U2Z7pr0NwezKUPzioyQjdF3RYKxojDze
         lPi2iQVtp8NHTu953C3qNKxABlAY1fyWHFCx2j0DZUnrXsuSpBFehUO/PNl8/hDs4EmH
         0CAKbb9l6zlfwAHOUIIdklury6aYDmil1h6zrZyHYdZsfGK0dTPXvA96cEzwaDWCCaXG
         +/05UzxmxFF3rXhNg30VKcX4FZ3mjEMDnTkn56B1nVgK7aJ9Kg9IGb9zomjilRK9dAAX
         kOCA==
X-Gm-Message-State: AOAM532efKlYh4lr4oKqETlJwMFvUPXVq1iob9Q7kb6gd3Su28NoUQaw
        mvz1uDeCSiYMJLp5dVeD8iMzN4LeGf8=
X-Google-Smtp-Source: ABdhPJybZEgEYF7mYlhjvAx8IHoZRB9VyNA3vi8oa52PVgAXc4IbNdmrC5fX4dmuFbgJ0HHW5lppsg==
X-Received: by 2002:a63:381:: with SMTP id 123mr4273198pgd.240.1589566663443;
        Fri, 15 May 2020 11:17:43 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:adf1:7e34:eff4:95bb? ([2605:e000:100e:8c61:adf1:7e34:eff4:95bb])
        by smtp.gmail.com with ESMTPSA id w126sm2516181pfb.117.2020.05.15.11.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 11:17:42 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] io_uring: add a CQ ring flag to enable/disable
 eventfd notification
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200515163805.235098-1-sgarzare@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5795fd28-ee65-e610-5472-d1493902f2cd@kernel.dk>
Date:   Fri, 15 May 2020 12:17:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515163805.235098-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/15/20 10:38 AM, Stefano Garzarella wrote:
> v1 -> v2:
>  - changed the flag name and behaviour from IORING_CQ_NEED_EVENT to
>    IORING_CQ_EVENTFD_DISABLED [Jens]
> 
> The first patch adds the new 'cq_flags' field for the CQ ring. It
> should be written by the application and read by the kernel.
> 
> The second patch adds a new IORING_CQ_EVENTFD_DISABLED flag that can be
> used by the application to disable/enable eventfd notifications.
> 
> This feature can be useful if the application are using eventfd to be
> notified when requests are completed, but they don't want a notification
> for every request.
> Of course the application can already remove the eventfd from the event
> loop, but as soon as it adds the eventfd again, it will be notified,
> even if it has already handled all the completed requests.
> 
> The most important use case is when the registered eventfd is used to
> notify a KVM guest through irqfd and we want a mechanism to
> enable/disable interrupts.

Thanks, applied.

-- 
Jens Axboe

