Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440E5259D88
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 19:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgIARqG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 13:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbgIARqE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 13:46:04 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28F1C06124F
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Sep 2020 10:46:02 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id f2so1792286qkh.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Sep 2020 10:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cSy4+2RDeeEJIAWSQYiuQheGRdiGJb8NlbxFbBqq2AM=;
        b=cXlpMLt/MZjGGJxxIXI3dRVI4uswoqGbuubaqPQro5E+Vxlidjbo5VD4YxUte9yV9n
         JGggD9c+n5hNtPF04P2fLwYCnLrn2PjcBNJ2TPdvwxby+LqAdjuTStUJWwXWsv7+VmVM
         5mRh+XQTeS1ZkGcYpcS2I2jsA3aNfqqxESdch/Lfa1suLKFyKj7pL/q/CaFoZCr613vh
         nMtVSMocVtIEc52WDjqw2OvCz5cwb6gn8KIGuZiEbNTm8mwhjITdAQNlXSR/HEbhcE/I
         OWouCb9f0F3A8GvtPJWlYO2AuTtiExzS5h17AM3EKMSVIiqlJsvrIIghN+G9eZ0GdcD3
         223Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cSy4+2RDeeEJIAWSQYiuQheGRdiGJb8NlbxFbBqq2AM=;
        b=Chxd2iXmruFHIyiMhPuEl+TBQRFRHZr8fZlnbIY1yIM44AmzvBw8ACFlG92RAIbk6Z
         V3vXBG+riXLci8GE+8AmSjfnFCCwu/fc+OyQ2oPfGqw9N+wo2lXg3urXEt4LH7A5E7/B
         ibuZw88XzvRGh04F8pXTHGcSTeyfayhEoCApeOOckGrcDDvNwiyO8xwts/W2ECCDCccM
         WtSC3xFN5pA1jvluUHzA9n0XjsmLHewNSrmODiEFE/rrVYAhH57cZ7rHFadpORKEk+4i
         KCWyVVkQimipdg6kjSw++swgl9DQCYMnir31mBrdYwinWGCU8F2SXZ2EBUivb3JzHxda
         +xCg==
X-Gm-Message-State: AOAM532NhLX6NQQFuEpYUY1sxYP5Nv8jlGjS7NFPivHpx/EioLc6viBH
        wT8ih2sWyyjn54DVPppqID3D8eZkkdbU3RTVenA=
X-Google-Smtp-Source: ABdhPJzuyOEEW4u0szMWmuV8qaZb9/osteZ8Kxw8co7ysE17hCNMDWr3cE6A6fD+O8okSgr6GveAkA==
X-Received: by 2002:a37:2d07:: with SMTP id t7mr2973895qkh.255.1598982360401;
        Tue, 01 Sep 2020 10:46:00 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w20sm2217486qki.108.2020.09.01.10.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 10:45:59 -0700 (PDT)
Subject: Re: remove revalidate_disk()
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Dan Williams <dan.j.williams@intel.com>, dm-devel@redhat.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        nbd@other.debian.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200901155748.2884-1-hch@lst.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b89fe35d-cdf9-e652-2016-599d67bdc5eb@toxicpanda.com>
Date:   Tue, 1 Sep 2020 13:45:58 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200901155748.2884-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/1/20 11:57 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series removes the revalidate_disk() function, which has been a
> really odd duck in the last years.  The prime reason why most people
> use it is because it propagates a size change from the gendisk to
> the block_device structure.  But it also calls into the rather ill
> defined ->revalidate_disk method which is rather useless for the
> callers.  So this adds a new helper to just propagate the size, and
> cleans up all kinds of mess around this area.  Follow on patches
> will eventuall kill of ->revalidate_disk entirely, but ther are a lot
> more patches needed for that.
> 

I applied and built everything on Jens's for-next, patch #2 was fuzzy but it 
applied.

I checked through everything, the only thing that was strange to me is not 
calling revalidate_disk_size() in nvdimm, but since it's during attach you point 
out it doesn't matter.  You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

To the series, thanks,

Josef
