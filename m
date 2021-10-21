Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5543A436465
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 16:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhJUOiD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 10:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhJUOiC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 10:38:02 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B06C0613B9
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 07:35:46 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id n63so1102852oif.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 07:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nYizJ/nuHwnjXaUlZmhnL7XHcjukCYe58+uBV+TNUy0=;
        b=dXL+Dez8Df/+OmQhuQ2fBPJ0e/poY80CtbtBu6UwvKYX+w3HSUl0FtArgV6P2EMvrW
         8ZGPuU1dWbaIeJCpL2tL7Nq9wovOmzZtrVNlp0nnMGnevX+FGBQQYYdhQhJD19AyGAll
         S6uexlYkXy7k2X41zKaLNX0uc3xuaMBrndnx0HcFRDaS2LNQ1+gzcjvKuDMXHIUnZ03S
         XPpzAoGZLKcbvm1tkKGVxbwHyRUiAuwu7IqfQ/9Z96H1otdsJ2Fej6NX5hFG5GuhSYGy
         RfFskthZctAvDgEf/QrTJXTZTTn5AAiFxlskwdvFtdOyp4uy8+Dj9zfhjwWxtwP6siWD
         A2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nYizJ/nuHwnjXaUlZmhnL7XHcjukCYe58+uBV+TNUy0=;
        b=UQgFKmYoKlilEGdMZIjAUQ14lrtbKGrSlDkH2DexymqhU54fcAz0zTBgc5MTZZyt+t
         GwJXU0ogCDDQv0uJPL69+AIG9d2WqKWxa/ozppc1ofbAzaUkkHPIVPipvNPGAI5c5K39
         L6uEb0Nb4pazq5KUcDrNdbfl4BgBAuCZRlShKUzzn2DPQgczUT/EPDMNA9c6Qh3lmWWq
         M4vmIWHof+/TbeqNmQy1uzdZtmjkqa/u9FzGrOwspldeyGnaz2CnnPxrQfUu2AlmOLa2
         xNu32Y9rzPHlsBuX+ghMVonNjznnrzqvXeuCMdpSJ0ltx24vhEJWOtl+/G9toll/lpah
         awsA==
X-Gm-Message-State: AOAM5339YLPUhWzdRXwmrKeqRgd907sXzVdZG+lw55wp+QVHbPxbA6fE
        MTFcLWwEd//kPXBTkGjx1hGPkCiufiMm2Ded
X-Google-Smtp-Source: ABdhPJxWqA09KwjQoOuT19z0e5ihfYskg5XFT15ttw6yi8pWO9OO7fg1NnzWrh1819t+8NgtGboBlw==
X-Received: by 2002:a05:6808:221e:: with SMTP id bd30mr4767332oib.115.1634826946186;
        Thu, 21 Oct 2021 07:35:46 -0700 (PDT)
Received: from ?IPv6:2600:380:783a:c43c:af64:c142:4db7:63ac? ([2600:380:783a:c43c:af64:c142:4db7:63ac])
        by smtp.gmail.com with ESMTPSA id w20sm1069864otj.23.2021.10.21.07.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 07:35:45 -0700 (PDT)
Subject: Re: [PATCH 1/2] fs: bdev: fix conflicting comment from lookup_bdev
From:   Jens Axboe <axboe@kernel.dk>
To:     Jackie Liu <liu.yun@linux.dev>, hch@lst.de
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
References: <20211021071344.1600362-1-liu.yun@linux.dev>
 <163482627258.38562.7953994214106016215.b4-ty@kernel.dk>
Message-ID: <2f3adf35-28d4-9fe3-0541-8aa580cda6f4@kernel.dk>
Date:   Thu, 21 Oct 2021 08:35:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <163482627258.38562.7953994214106016215.b4-ty@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/21/21 8:24 AM, Jens Axboe wrote:
> On Thu, 21 Oct 2021 15:13:43 +0800, Jackie Liu wrote:
>> From: Jackie Liu <liuyun01@kylinos.cn>
>>
>> We switched to directly use dev_t to get block device, lookup changed the
>> meaning of use, now we fix this conflicting comment.
>>
>>
> 
> Applied, thanks!
> 
> [1/2] fs: bdev: fix conflicting comment from lookup_bdev
>       commit: 057178cf518e699695a4b614a7a08c350b1fdcfd
> [2/2] scsi: bsg: fix errno when scsi_bsg_register_queue fails
>       commit: e85c8915cf374af76efdc03a53a20fdec9d8eb5a

Eh, I only applied 1/2. The other can go through the SCSI tree.

-- 
Jens Axboe

