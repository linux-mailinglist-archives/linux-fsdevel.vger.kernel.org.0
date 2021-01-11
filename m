Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3CC2F2132
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 21:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbhAKUza (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 15:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbhAKUz3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 15:55:29 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55455C061794
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jan 2021 12:54:49 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id v5so260336qtv.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jan 2021 12:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vtXGMnlbBMGaX/s8hVeCkrNkSKIjAn/qCEFU0k0ooT8=;
        b=EvlSyoOL3hgyVnmJEmwffWo7I+fIoUzbLpFjGK35vzgfDSsA0h/jizUBFbTsKCuDQU
         cQoaLgkBCgHOXQ8asd3bR1NxjpSgdNrZVAEmHwTqkm63/VjfjRa5qgWzDTElAm5UpvAd
         kmAD3J9tta8BL1qvpYn3u8f+qOd1xVr4AQ3rRqXvcuvB3oI9wTiYdzu8jtldn2uay6si
         qrsCU3NjOIKoZ7u+TBVG59opc8lZvn4cyMAc9pLrb/cA2PrKCo9ichyutuQdsCWA7s+s
         qJsPYcXhQe9jKvbppzqyw6kdFKzLqP2kB9KzDO78BJ8m8451pqJBHYVncC1lB8LyLIzy
         J8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vtXGMnlbBMGaX/s8hVeCkrNkSKIjAn/qCEFU0k0ooT8=;
        b=lU8m6HRymxYHM1McdwYBr1hz8BKtTWtlGurKO4i1lXNl6gJktxKUP/JFh7WiBtMV7m
         2cdJ/QAeFRa8caGCNVBYD2pERMLeq9BzHh3OMHjiNNxtTs9XbeUPJ5kZ5vyb7Q+GqTQw
         cfrXN6oVa8k7duoN4nIRPWFluAs/1zW/RkZMNxcGZZl5pVjzPv4iL2EDB5ApghA+OZVv
         20oI9ve8w9+sLSZvyvWZ72AGIodS7ABSoZw7Z2+3YOjjsEngF36yQD0TOxso3PvJlo45
         saOEq57oeAf0oUqNnLE1dtWEJuxPQqXr7edX/ETTnNinOeJpXPkny7k2VTt3uzKQtnqd
         Luyw==
X-Gm-Message-State: AOAM530GGC8PcIzJ4/rggFepXpttYalyjDVEhnxAC17NrYOQbv1/qyYh
        6L0ZhHfnTqfNhZcgSSQQ8eEDVQ==
X-Google-Smtp-Source: ABdhPJylOpxh4MwnSETWJhFvB5+XPisiIb3qS1XX5URioaF2uq6hTNggHta6v0m3PMOmSFU3i3FuoQ==
X-Received: by 2002:ac8:720c:: with SMTP id a12mr1532824qtp.42.1610398488016;
        Mon, 11 Jan 2021 12:54:48 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g28sm353981qtm.91.2021.01.11.12.54.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 12:54:47 -0800 (PST)
Subject: Re: [PATCH v11 08/40] btrfs: emulated zoned mode on non-zoned devices
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <e2bcb873196a16b05d5757cd8087900d4f464347.1608608848.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a7a236a1-672b-12bd-02f5-7e12d8d55a5e@toxicpanda.com>
Date:   Mon, 11 Jan 2021 15:54:46 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <e2bcb873196a16b05d5757cd8087900d4f464347.1608608848.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/21/20 10:49 PM, Naohiro Aota wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Emulate zoned btrfs mode on non-zoned devices. This is done by "slicing
> up" the block-device into static sized chunks and fake a conventional zone
> on each of them. The emulated zone size is determined from the size of
> device extent.
> 
> This is mainly aimed at testing parts of the zoned mode, i.e. the zoned
> chunk allocator, on regular block devices.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
