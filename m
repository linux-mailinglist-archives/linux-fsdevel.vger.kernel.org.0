Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E378D2F3AF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 20:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406895AbhALTos (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 14:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406885AbhALTos (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:44:48 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2D9C061575
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 11:44:07 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id d11so1453431qvo.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 11:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S7kyGJuaqh3nsKbgPVeZcdNNL/RUUli9x85iatkyjWw=;
        b=YWWLiYsaWdqMBHLslnppBYu4HA5yNg9LWOxt7Cq1rp8jBdQYdygOkzIhi/bDvLWcGI
         9XluZ25HAYnBBpOvFtvHxnIuraDnk3p0OGQ9DJHy3AazTzK3c7Wmc+kp1VDNflyrUiXN
         1sU/GxHSmUnssh97n/6A6XGrIsoP0iWZiNXBlhTLzI+8jJ5pSk1mU+55Mk+Yo+xtzqBR
         Ko7hcMDdy8Wd1JaJzI4wKeKGx6DWM/5F+suP77FRWqdJ9j+5fc49y1+EPFMkvd9yr2Ib
         9Ya6P7p0TggFutikUZOdH6Kck28MX+7nnq25uqdkZMln0sYWd0WUKFD+UYVZeMX3eALa
         x6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S7kyGJuaqh3nsKbgPVeZcdNNL/RUUli9x85iatkyjWw=;
        b=BoaQ1VhKShsMjaQx/R57pseUGctXpGs7QC2Wu8dDyU9Ib04JLOdWX1P/3eEND+hK1/
         Z1Iz7wRX7+kfgxFLQEV0Y83ggpLv70BkhPUyr28U+MlzO2++zxb4QWqrcYbjIrBhiZai
         kAE6svsDI6ZvzXGXFvqJ+TudfB1687ZHb9fEHvG4ZIBWOl1g6KmIsGydQXXX0HiR93JG
         ZqgWqz+LiTDJUN7iyFcV6KgTtaerxtgogOWeGGiVI8rj2r9k8xl/is4ByzOxlRQJHiAN
         IyIjX6T/D8NGi1iJ4qGC1rwE+3NYid40rHzFIyB6ISj1Ys2q9nQ+uN5fBZBheSCewtPE
         yH6A==
X-Gm-Message-State: AOAM531wgnaC0WGmh5m3mgQyfie2OqAZ3ZkAt24wLafLKDpMP6yT3aKM
        71eMzuF/Esw0FuojuDU+4uEsxw==
X-Google-Smtp-Source: ABdhPJziHz6YTO6Gn19OjG2QhDkR+E5hyy1TeENXj6mA+JgrO9I4LIJv26Am8uzWXks/HRYqys6TGA==
X-Received: by 2002:a0c:f14c:: with SMTP id y12mr640216qvl.23.1610480646931;
        Tue, 12 Jan 2021 11:44:06 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o21sm1991691qko.9.2021.01.12.11.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 11:44:06 -0800 (PST)
Subject: Re: [PATCH v11 37/40] btrfs: split alloc_log_tree()
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <24e3b5fbc3897a7ab6881750a8ac28d70d91595d.1608608848.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c4439340-e798-986e-eca8-6e6cad2a11a4@toxicpanda.com>
Date:   Tue, 12 Jan 2021 14:44:05 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <24e3b5fbc3897a7ab6881750a8ac28d70d91595d.1608608848.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/21/20 10:49 PM, Naohiro Aota wrote:
> This is a preparation for the next patch. This commit split
> alloc_log_tree() to allocating tree structure part (remains in
> alloc_log_tree()) and allocating tree node part (moved in
> btrfs_alloc_log_tree_node()). The latter part is also exported to be used
> in the next patch.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
