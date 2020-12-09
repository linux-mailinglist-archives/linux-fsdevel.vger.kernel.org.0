Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08DFA2D473E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 17:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbgLIQye (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 11:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbgLIQyc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 11:54:32 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B11C061793
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Dec 2020 08:53:52 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id r17so2179420ilo.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Dec 2020 08:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pFrCVN6Gn+ZyEFuOYf0G1cqZKi+SMHYMwyy/Z9Ayq2A=;
        b=mZRI3YhmR5R/0CaDyOv1WOHWk21Oa2uAoEJRpiBgsKRS0Zq3ZP8tqXNE+iPO/vaIJk
         cdzM5Vqe1Rek8FTcSpl1QA8bG4SF5tsBZaRhkwd5p+HHSSQdQn1hz40UZJjEQAtWWQxh
         D4oVNrgDtlELXrT1dpfLc5G5JLX/LpNpdlnKg+K2jt3p1wHM69QXKoC3qOVhVj0atwe8
         LhOXGAddX6vUSoVOzPE1bcTaxJzAJwoQdvbNgqBWwFIH3TANWny1QJkqpftz4LKhBHOS
         bl5NHaV+I+kXTjwuVwR1b845uYTbfWleV4nVveGywUaRoEqpvaXUOZEf4roZ+SbWYPPF
         9ydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pFrCVN6Gn+ZyEFuOYf0G1cqZKi+SMHYMwyy/Z9Ayq2A=;
        b=tn53POK5f5rr7CKVT8Q0SWAvoGE38pG87Z6q8SFrJwEOCeEl6uHlr0EGbmCa0vfyVp
         LqdCWD3gEOfN/rZnAVFbv/J4hYobJjF2GxkO8aKYwIsChe3CWQCovR225xM7IBRBF6tg
         gE8CqXXVUJ5o3ecS/92rjWT7lTeT5g10L8SlJ4drwqYW57Tqjz/mTz1+fJA1B4dWXLHP
         EONewToLZyNyW7vLGgX/nTsbsWsRO/K7pjOCUOw8mG5sumLhELC5EmbFj+ZncWHJJGFE
         fnrorbB3ZdpemKWjui9Bxo8nZb4v2hMI29RNPrgl510HMtFedV7Sg5rLjd6fyQj8ODWP
         3zsA==
X-Gm-Message-State: AOAM5303pnufCe5AiAdPYxVEuxXqmHsgXbKpGpgbviuMLlp35jdgfLNk
        eEHolDpxuOtFbMTtvoSoVfoscGdbB3vYfQ==
X-Google-Smtp-Source: ABdhPJzbPYzKTjLVZ7r5OyKSMssKQp99fwx2+5ZR2KRfl0z16NRiaF3hFXMPafTr4IwB2IkW3ePnxQ==
X-Received: by 2002:a92:d44f:: with SMTP id r15mr4160637ilm.237.1607532831277;
        Wed, 09 Dec 2020 08:53:51 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e25sm943626iom.40.2020.12.09.08.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 08:53:50 -0800 (PST)
Subject: Re: [RFC 0/2] nocopy bvec for direct IO
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <cover.1607477897.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b165cd42-be79-69ed-ae06-a3f3ff633c62@kernel.dk>
Date:   Wed, 9 Dec 2020 09:53:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1607477897.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/8/20 7:19 PM, Pavel Begunkov wrote:
> The idea is to avoid copying, merging, etc. bvec from iterator to bio
> in direct I/O and use the one we've already got. Hook it up for io_uring.
> Had an eye on it for a long, and it also was brought up by Matthew
> just recently. Let me know if I forgot or misplaced some tags.
> 
> A benchmark got me 430KIOPS vs 540KIOPS, or +25% on bare metal. And perf
> shows that bio_iov_iter_get_pages() was taking ~20%. The test is pretty
> silly, but still imposing. I'll redo it closer to reality for next
> iteration, anyway need to double check some cases.
> 
> If same applied to iomap, common chunck can be moved from block_dev
> into bio_iov_iter_get_pages(), but if there any benefit for filesystems,
> they should explicitly opt in with ITER_BVEC_FLAG_FIXED.

Ran this on a real device, and I get a 10% bump in performance with it.
That's pretty amazing! So please do pursue this one and pull it to
completion.

-- 
Jens Axboe

