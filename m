Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA0C3151CE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 15:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhBIOiK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 09:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbhBIOhh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:37:37 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBD3C061788
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Feb 2021 06:36:57 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id n14so18986775iog.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Feb 2021 06:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sssg8KmxqU8VRCtUYxA1o0jiJ/Ogsm8bVP7G94M7KA0=;
        b=UIHkK2HX+tLzNxL/ptPBHZMx3SYQKMFY8aCJoIddkhUF+01JXmbyRIAm9Cj7z7EFOt
         zVlxYCfeJoKJsGHbu5qgASUHnp8OucPDl6pmn0biWRmIxvKS+eVcs2Afd3XNE1HQ8baH
         aXINBYnNDwMK7ecaeErOQI6tqLZ4ZLPfsjr6gI8xt+Ox+xI//batqG8ntnmYqOLYbNrQ
         +wYh/8+CTsMaEpiNLRAxJEbW2suGZZnfQ81XAWh95eGe7QTHXSKuEF9PkxFI+ml3Vm3l
         r4SDOkyFqJ6cvyGPKm5j1akkXa74YxMLgLxv9DEk3OgWe6NlGN+O5LXFEyFj78njoPFW
         N3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sssg8KmxqU8VRCtUYxA1o0jiJ/Ogsm8bVP7G94M7KA0=;
        b=auNnmL6sKtkWGOeBOiHk5i0bozJHy6DJC6DKvQOkAxty7Hv9bUVgr3dNMKyMZIwiUl
         2kDMpmjMGz7oF9TNbDnePVYeTD918iJIqmjDWWquOL1Kiz31MG7xLNwvp64Y9nEUrHgl
         b0fMiH//Pek1F9wgwnzlrqPZd62bDLmvld9R1+g6PkofE+LgvtMNWunok/364BhZ3caL
         R8+pDfB6pad8FfUvvWAWQGQwG08felcWXlhIvjM+HqKGLcAQtD24UyEX7PYhLhKdGlgS
         HsCN5eEFTjp4S48cJpqwgIFxDhmMXlbdQadC4KoCjNQkgDNYTH+ebt2zu2UTLljWR1Hf
         M8hw==
X-Gm-Message-State: AOAM533DLY8Fvci5nhAs1CVMCl3ProQsDearaaI0ISGut0m5nr8KT81n
        eK20q1igB/A3+2u3WU4MXvsvVA==
X-Google-Smtp-Source: ABdhPJxxTqGhtJcMSiPJCMIu1CELREH8sJLFd1lS8Ok90jVMZpbOZMwdhLOq+c8W6+hvFo+i4hylZw==
X-Received: by 2002:a05:6638:12d3:: with SMTP id v19mr23275574jas.42.1612881416549;
        Tue, 09 Feb 2021 06:36:56 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 14sm10659330ioe.3.2021.02.09.06.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 06:36:56 -0800 (PST)
Subject: Re: [PATCH] fs/io_uring.c: fix typo in comment
To:     zangchunxin@bytedance.com, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210209024224.84122-1-zangchunxin@bytedance.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <04e4ac54-c38a-2160-d152-000c0147a274@kernel.dk>
Date:   Tue, 9 Feb 2021 07:36:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210209024224.84122-1-zangchunxin@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/8/21 7:42 PM, zangchunxin@bytedance.com wrote:
> From: Chunxin Zang <zangchunxin@bytedance.com>
> 
> Change "sane" to "same" in a comment in io_uring.c

It's supposed to say 'sane'.

-- 
Jens Axboe

