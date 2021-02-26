Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE2E326A3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 23:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhBZWvX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Feb 2021 17:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhBZWvS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Feb 2021 17:51:18 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6481C061786
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Feb 2021 14:50:37 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id h22so10614379otr.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Feb 2021 14:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FVaorLf6cYpgwAX1Zd+PAdGIFbAbkDLp5X5cbNNtpWI=;
        b=d+4DXdNi3Hsf1qtaCslXgCnjYIRyaDj8f8bfyqMMcqVJbpzwWO09DmL46UwpdtZrjJ
         vcMov54SHAgxr2pMUT7pNRPLf9LT6hVWeCjlE3DJGEkOUgVLsLQ0SP+hdAOhy7M+xAfW
         THkJAqyMf7xPoBkpiM4msxG/kbe+4b/eToH4MbYYFMqe1L2jOL2VLLU4GdyLytwdt/hu
         4riO33xmrmts6mZL91cgEy4lKDN28cLKiK50M7H5I6X902Bf0JYk4O2nmylmQHjOTIfo
         UQaBHH15nGuSDwPf1rrfHfSd9hEHLRjj1AIe0Lr1b8/LRU4I238+07wZLNOsoV6TKEsm
         veSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FVaorLf6cYpgwAX1Zd+PAdGIFbAbkDLp5X5cbNNtpWI=;
        b=f/AwdnPgKb/jnrCZYVDf15YzE1r9SjpscErne4t7Me2i+0OMLrOA1wltXFk5EMsXBo
         BZvPK3FE8wauwAsBLnCA9Piq4gcP9IGFztfMbGgyTPfC7tHJldlwZvdUs7Sn/3fRoSmi
         YGyGQy6fQW6RdERqosld2f2CnF4hYNucDVRsrpT5x38x5cDeTgY5oafM2hHtZ6O7pwh5
         rBsPi8f8AeLnQbYG1/Qv5wX6lzuVjL/1G4iFiYz7J0xb3S+aQz6ScUN2yS6JvcJoYeZN
         1OeQxtNdQt4vmXYfzwsTWZI/yroaNflXJ9dFxKDmb+s32kNipbqP0DwMEwgT7XqnGsBI
         O9EA==
X-Gm-Message-State: AOAM531Sp6GOn0nBpMBjZpJNPZhM7EGMUiyeIO0YJKS5IOLQwI8PQ62J
        8x7+Dh4o+R5rVSEaqMmPF1QT8Q==
X-Google-Smtp-Source: ABdhPJxkfATb74vHEI7DysbxiEX6T4pY/s82kdocO+CCdgFkE47lbzUNeVp/UlhM7T2U92yE9ArjiA==
X-Received: by 2002:a9d:2945:: with SMTP id d63mr4076467otb.70.1614379837232;
        Fri, 26 Feb 2021 14:50:37 -0800 (PST)
Received: from [192.168.1.30] ([207.135.233.147])
        by smtp.gmail.com with ESMTPSA id r205sm1949094oib.15.2021.02.26.14.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 14:50:36 -0800 (PST)
Subject: Re: [PATCH v2] block: Add bio_max_segs
To:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20210129043857.2236940-1-willy@infradead.org>
 <20210226203819.GH2723601@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <307e1cef-0932-b7f2-4d65-42983e3e0d1b@kernel.dk>
Date:   Fri, 26 Feb 2021 15:50:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210226203819.GH2723601@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/26/21 1:38 PM, Matthew Wilcox wrote:
> 
> This seems to have missed the merge window ;-(

It ain't over yet, and I haven't shipped my final bits for 5.12 for
block yet... I'll queue it up.

-- 
Jens Axboe

