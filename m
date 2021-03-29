Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A5534D915
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Mar 2021 22:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhC2Uhz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Mar 2021 16:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhC2Uhm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Mar 2021 16:37:42 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33BCC061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Mar 2021 13:37:41 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so8298600pjb.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Mar 2021 13:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yHw9sshxoYuACLrTjqNN6yy+mznnvpE/1N42vZsEoUs=;
        b=h5F9vdRjQ4LioJG8eD9OmaooCXnroWwcI7ACooozOP9Cf8J3AjghvHTR9E/XFPxuJO
         xRZGLs0FI0RIexkC89/kGGBdQA5Khpvf+3BBT9uZpZBywUoWwfRjyyKtuWLMiNDz/S+v
         b7k/sPntQJy4rp2SazSrLRsHdeJ8gtvCrirojjQ8QO+HUlZGOJdTx8dgfpHEanUc9L4g
         QrBjx6c5m1MGZu6/cv+aVsgW6pDbaZgMDaReujs921UUMPPAGuJBWbFNAvGim1XfY/5n
         nLsH5+NmfIwiwmdzxlYtFXaHp+VJc3ok21R7bs085bQKNmZiUltWtf9HIYpm7IFu1nf7
         NuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yHw9sshxoYuACLrTjqNN6yy+mznnvpE/1N42vZsEoUs=;
        b=W8M6cwSC1dms7fXSIriLXnZZoCYfF2Ky2UnHFhfS3uTtfuC0hVVLEbn4353W999MCk
         rW4s4kwdJd4+TyxzByLc2u8p97/JjBigUo0lTlRnn6SO2L500CLDAfueHfY6Ah1umQH+
         U34/h2nIYDr9pRMSZT6sZ+zAwBckZgt7r3AvyDHhwHe3HoIMio2tAm5IC0lLnYxSr/Es
         uOU5FbPnE3ey02PHWEaFpIGIZSlaHuL8z+7qzQNBY0HzRwCzFHRq2NIIQLUj57N1w3gf
         wu7znmMuTLE+LrrNjYuKhcfYeL+1RXP4H3Nfdbqtu7VzzQVmHEAT1g6pIKXj5IppJ4WH
         A+pQ==
X-Gm-Message-State: AOAM530dakhFmPy+MmEkKpx0E33KnN6p7I/XEN3sCpxfTMyiDLBG4Yv5
        u4OGKSrGDyFINXHGbNNCcHI01Q==
X-Google-Smtp-Source: ABdhPJzJTU9hNPRCb3LW8F5vA4F04gPYzY16Ecx9WfPIlEfDFKSb/4CUxWGqJp8gvey7vWpPt4dlew==
X-Received: by 2002:a17:90a:f489:: with SMTP id bx9mr876313pjb.80.1617050261376;
        Mon, 29 Mar 2021 13:37:41 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id o3sm422731pjm.30.2021.03.29.13.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 13:37:40 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] io_uring: add mkdirat support
To:     Dmitry Kadashev <dkadashev@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
References: <20210202082353.2152271-1-dkadashev@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <81aae948-940e-8fd3-7ac8-5b37692a931b@kernel.dk>
Date:   Mon, 29 Mar 2021 14:37:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210202082353.2152271-1-dkadashev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/2/21 1:23 AM, Dmitry Kadashev wrote:
> This adds mkdirat support to io_uring and is heavily based on recently
> added renameat() / unlinkat() support.
> 
> The first patch is preparation with no functional changes, makes
> do_mkdirat accept struct filename pointer rather than the user string.
> 
> The second one leverages that to implement mkdirat in io_uring.
> 
> Based on for-5.11/io_uring.

Can you check if it still applies against for-5.13/io_uring? Both the
vfs and io_uring bits.

It'd be nice to get this moving forward, there's no reason why this
should keep getting stalled.

-- 
Jens Axboe

