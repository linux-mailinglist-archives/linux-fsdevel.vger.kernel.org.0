Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5751D5058
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 16:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgEOOZI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 10:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726221AbgEOOZB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 10:25:01 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C015C05BD0A
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2020 07:25:01 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id f4so1017191pgi.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2020 07:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rKuzsBx4cSJvriSVGbzt79618OPfv8Eok+sl7EaCGvk=;
        b=WVFYeKIqdMj/Srr/1bTEErA+epgu+DH+A/WDQyM9gqFzEDwvVElUrZIWg3Hz7hF8B/
         N6OFUChnBSxKwDrv2ZcBMpYlw/D3nMEVVhOu+wnoFz8bTp7xKEM0g0vZ1Y/L1yaD7dv6
         YF3ko6LQF1QF5smUIgJS9wu9x0iOXq4Dtw4z+cJfcJeFkFikqtN3ghM1YCL4kuCvU1nb
         HTaUZgljc/QHWyB22xy44i3YN+G9yBlMYil+1NnfMt5IQgwQL7Vx/lajWvOm21jX+tHP
         nwgYhzGlUOWwqvfzqys0GLa0+3gzCn05ZKHiOwbIUK4Yvmcn6ejcUUTq1h5T4ToXnMPE
         DY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rKuzsBx4cSJvriSVGbzt79618OPfv8Eok+sl7EaCGvk=;
        b=M0nSg06HkoLjpE9/614ZkSvZUTNJWe0Qwbkk8jffbCTG81xUSUTIyPbDhBSJ348ksR
         U9zijpBE0CPrjaLhEW+sbYhDGO4TCRMxCHsV5lhu2PPO+trEwQk77F04wvCr0813teAA
         R/8RzSJM8gFs8PG6o9UEestU/4j8IRmSQi5dTPCX8+FXN7UgEMY3Br2j2fQWX0R5/e5j
         hD2VDAC6cxrl3FbZkdrRGWSsgq9tzQ0lbnumwkWgPxOj+hIyga1ERlC1Fv69A2WXW88l
         TZJYNEhHiww1K71p/WmipSp+bFPxZmXAmZCMw8ppDLFesyg3z/ckwBs/0FlJQJ5XPa0g
         FgMw==
X-Gm-Message-State: AOAM53358X97h4BejWg2nrCG9FUXQGUGbpXpE28pVR/IGrtp9FvbxWYJ
        IAbagUu9ayoTEAkrli42B8QESBYhIps=
X-Google-Smtp-Source: ABdhPJyBtrljQApl8ZHuJbXFW2dv6fiVrkv63Op/bK/6nAFNHesQEkrdhwsL4yZ3suq6ubX8WngyDQ==
X-Received: by 2002:a63:5320:: with SMTP id h32mr3443963pgb.28.1589552700514;
        Fri, 15 May 2020 07:25:00 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21d6::1089? ([2620:10d:c090:400::5:7df0])
        by smtp.gmail.com with ESMTPSA id n16sm2152078pfq.61.2020.05.15.07.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 07:24:59 -0700 (PDT)
Subject: Re: [PATCH 0/2] io_uring: add a CQ ring flag to enable/disable
 eventfd notification
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20200515105414.68683-1-sgarzare@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <eaab5cc7-0297-a8f8-f7a9-e00bcf12b678@kernel.dk>
Date:   Fri, 15 May 2020 08:24:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515105414.68683-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/15/20 4:54 AM, Stefano Garzarella wrote:
> The first patch adds the new 'cq_flags' field for the CQ ring. It
> should be written by the application and read by the kernel.
> 
> The second patch adds a new IORING_CQ_NEED_WAKEUP flag that can be
> used by the application to enable/disable eventfd notifications.
> 
> I'm not sure the name is the best one, an alternative could be
> IORING_CQ_NEED_EVENT.
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
> 
> I also extended liburing API and added a test case here:
> https://github.com/stefano-garzarella/liburing/tree/eventfd-disable

Don't mind the feature, and I think the patches look fine. But the name
is really horrible, I'd have no idea what that flag does without looking
at the code or a man page. Why not call it IORING_CQ_EVENTFD_ENABLED or
something like that? Or maybe IORING_CQ_EVENTFD_DISABLED, and then you
don't have to muck with the default value either. The app would set the
flag to disable eventfd, temporarily, and clear it again when it wants
notifications again.

-- 
Jens Axboe

