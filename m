Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D663006B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 16:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbhAVPHz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 10:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbhAVPD5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:03:57 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE5FC06178B
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 07:03:12 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id r77so5155877qka.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 07:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bEULd0MKBDbTk70H7ub3+A+aQ5E4jMhqsEiMlpco6Vg=;
        b=O1DoMC+g269qFMIVkQeoIBtWmx33AfhajGHIIwd86ouRUNIfMr+ivC4GhY67mbLfu8
         mlsJwVmfml+4Iuheh88L6DaqxfUWxaYCGfbyxgi5Vj8LQPL4sz60reb/Xl60kfM3D0Cn
         1l/h/gtTVlkmt5pcJyF0QhwioFtDk2Ekn+62bwuWJvcT1D/juiPZxvA0s9SSZLJdf1l9
         OSqRR8frdwom59ozvz9w33iQPo9gogJrRj3yC1MTRoUTpLM+v1IlfOs5291IaF7p7DTP
         pOgiTRVvruwWiswCScXuz7BIPZtCn5uEMXrlQ9jilPL3fyEn81FelW1CS+F96xXqCLpP
         SQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bEULd0MKBDbTk70H7ub3+A+aQ5E4jMhqsEiMlpco6Vg=;
        b=QH7MnCW2/IkajtaKos5cX6EubEpB2Uv1BSVMxOnNnlR9I7QLpW1ubYAii+3y3Qm0/+
         UyPNRrOgtOjM6O84FrZmwPZvdPEcmEHSe9iXuzj3AzwqUVufu5CduDreiGNrQAKVGMng
         eQ85iZlCQO5gSWjIoRd8tuphEFt6H7Ii4FcwLwhwvdNuzC3ZuC+yPhalSeCTVbrBnrLr
         ua2+CqrsLwKrgHf424iAvbTcLhXrIHhGMOGx69CXKdPdc9pmWAgIKuO+pi8zSkXD+Rk+
         JOX6L9/clE6rlxdB1s5XarwBJNBQ/UFevvJPBILF8Yzl1I7Tj5KyO92ioHs0uk1+dmxY
         G4nw==
X-Gm-Message-State: AOAM5305oHBaqWv59ru4wQzCS2qgz2/lEgnxsrf4YIhB2lCL8hjnDAhP
        nugCScsLJyBST2hbgitMEht5Qw==
X-Google-Smtp-Source: ABdhPJwQMlYNnE17WJTVF5u/3z7MGG42e615zzUrkhsxD1gB5ND9BKv6rhj7q9NviUn6LvcR8hGGYQ==
X-Received: by 2002:a05:620a:a19:: with SMTP id i25mr5171535qka.157.1611327791827;
        Fri, 22 Jan 2021 07:03:11 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h6sm5697085qtx.39.2021.01.22.07.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 07:03:09 -0800 (PST)
Subject: Re: [PATCH v13 08/42] btrfs: allow zoned mode on non-zoned block
 devices
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
 <6764c8d232325868e47ded876af398053e674f50.1611295439.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <6f22665c-2f29-6437-25fb-2cea9f5ec733@toxicpanda.com>
Date:   Fri, 22 Jan 2021 10:03:06 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <6764c8d232325868e47ded876af398053e674f50.1611295439.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/22/21 1:21 AM, Naohiro Aota wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Run zoned btrfs mode on non-zoned devices. This is done by "slicing
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

