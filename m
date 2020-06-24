Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15DC22076FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 17:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404297AbgFXPOP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 11:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404067AbgFXPOO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:14:14 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372A1C061795
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2020 08:14:14 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d66so1289336pfd.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2020 08:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ps+DmDWICz6+D3WRaFwXTobME9VB1u3KQwLSIO91+tk=;
        b=xZIbVshrwWWLxcKIigRdYSM0mQ0nKCs67DOMUGGIQlBMb9rEUc90OCVJt+JA5t2ukE
         o3JKzqQ1VL8Dj8JuTc2eZxA5lvSq3W7ZDZl5QV/P7N2p0EoVUqX+kksHwolzClLiXyLL
         Ys3Ei+a+iCP+ma0Nae31UP5NF3YaLXZj0FSrIpaNqGSa60QGrKZt1OlHUYMAqB8k/6d/
         LbJVQGwTtW7y/Kl6NUbHJFXXOShX7hHl6pCAw4OD5Hm/2kgzz34+Nb4adlSYLKuBxTSW
         VMO4MQ1jZM4E57/tK07JCxoYBCU3cCPRO7EXy4EcFSCd7FePtBbLmw7TP8ogZVX7fUVX
         /4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ps+DmDWICz6+D3WRaFwXTobME9VB1u3KQwLSIO91+tk=;
        b=Pod46jRt/Kcnl2yo7671r4vl0KpWZxPT7bHmqsXPKyW0ANMABtNXRV+GQ2XxlhwI25
         lnQ414n8aQkcAsg7+j0wSFT9QO71W1q+blnSs5cXm17ho+39qQLXCPfsHUHlkiNWaCAW
         0vjp5HcA+NEjWt2KpUYFd/h0U0MfORjDuImlrOrfHMgFOzAUmz7p2vZaZEUNtHWmTsI/
         jpmcJo7Y90rkX31039GM/+ppQEYRTt9Q13X8IPXLx57rvx5a5DXTkIL7BJJPC+7ZR/ld
         CxcdCxfPhratfeX30yUl1OfMMscAtm/rUFAgpN9KfNH7/ud2Izm++RhvhFY7ftMkJqBT
         gP7Q==
X-Gm-Message-State: AOAM530lZTYtLDLOPPaBXZWxpl7c8rKnrH8ts1Xgg9SJ84RfDJj/sI85
        +PqRFqsCGl+snjrTJnPobJlcGCqPYHk=
X-Google-Smtp-Source: ABdhPJzYL1CFUVfnzLvI6QU88euYu/ZksQ0VBb3mRMhCLNIUkamn41/nsnDt2BfAPm0YWMGKFGGbaw==
X-Received: by 2002:a63:f50b:: with SMTP id w11mr22012876pgh.157.1593011653721;
        Wed, 24 Jun 2020 08:14:13 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id b191sm17710007pga.13.2020.06.24.08.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 08:14:13 -0700 (PDT)
Subject: Re: move block bits out of fs.h
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200620071644.463185-1-hch@lst.de>
 <c2fba635-b2ce-a2b5-772b-4bfcb9b43453@kernel.dk>
 <20200624151211.GA17344@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <216bcea4-a38d-8a64-bc0f-be61b2f26e79@kernel.dk>
Date:   Wed, 24 Jun 2020 09:14:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624151211.GA17344@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/24/20 9:12 AM, Christoph Hellwig wrote:
> On Wed, Jun 24, 2020 at 09:09:42AM -0600, Jens Axboe wrote:
>> Applied for 5.9 - I kept this in a separate topic branch, fwiw. There's the
>> potential for some annoying issues with this, so would rather have it in
>> a branch we can modify easily, if we need to.
> 
> Hmm, I have a bunch of things building on top of this pending, so that
> branch split will be interesting to handle.

We can stuff it in for-5.9/block, but then I'd rather just rebase that
on 5.8-rc2 now since it's still early days. If we don't, we already
have conflicts...

-- 
Jens Axboe

