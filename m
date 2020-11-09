Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433042AC33D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 19:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbgKISH6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 13:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729807AbgKISH5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:07:57 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6759EC0613D3
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2020 10:07:57 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id v11so6252159qtq.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2020 10:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7NGOsjZERbiE5w2MHC1mFU2jxp4Wb+n3njEEiJYjdrs=;
        b=O4/l9OEaWnaVVx9mA/+hODfmoKgGQIEUNKB0HmUGrD+LhRciIQAcMV79vjoQi/4L15
         CDVLebLFqwtrXUj2MValkzQKsvuvZ+bIj/HDHunVOXdD5rmqC2zDcm6G2ntA+MvXnqhC
         vTEl8uxCxkWixlkEepU/54lrdZYMGD0U3koL7aiUg0SUzZXfN7ZexvE/u58j8exqrb0L
         /O1jcvVnjraSt/kGOG4mDP8TkZHx3MoMGZRLY1X+es3rUicc6WotFmSs08rTBby/Yuep
         Z7z6vRhPWjHEqJ+TL+UexVhcPZExA43AO0zs4xR+XnsHWVoRk8SDKKD+pe0DirmCEgT1
         wWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7NGOsjZERbiE5w2MHC1mFU2jxp4Wb+n3njEEiJYjdrs=;
        b=JXiaMTvrJ/9LTflAUOFyo0hrRQ+EXY6lkm6A4Z57iaOh9dmbXjM3gFfyND+xSohkRj
         OH4JKjiWQCOmH+5u7Z2GrkFAI2P8nqI7eU7hphG07z8+tzeIvFL1osaASa9yXgo6VNgX
         v9zxSkFmhbKE90016+CN8xRadPVZ2Kda2Czi7JaGZHfOfQgVFn/YsWlMpUJojsk/HHr5
         MrRXnCWzDefb9E6aSj7IFJRzXfxzOl+I3MG+v0dkw5PLMFa0hrGL9Xwjl1dLoZcNbvVs
         cVElIGXcyaEXhjv8AoBBFPIAzBa5KMw4LvDU1Ve23OPBbWDUFfQIBkR24EfFenVaicUM
         Equg==
X-Gm-Message-State: AOAM533A8/AB5bFD0UVufgFr1K7smordxZc1dIIBCgrGgrzWtQVYPf7z
        b+ME032vEo1oQEZJYu8orqong4VqoxocAygDVb4=
X-Google-Smtp-Source: ABdhPJz1XdtisV/lRv5ASDEyKBu7yVqtI15E3NOcCNcW+bkgomAeHWz+gX9FyFOWQktTiYmlqxOYiw==
X-Received: by 2002:aed:3147:: with SMTP id 65mr14719130qtg.295.1604945276157;
        Mon, 09 Nov 2020 10:07:56 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z2sm6588768qkl.22.2020.11.09.10.07.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 10:07:55 -0800 (PST)
Subject: Re: cleanup updating the size of block devices
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20201106190337.1973127-1-hch@lst.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7ddd60ce-f588-028f-7e47-2df4d52e22d5@toxicpanda.com>
Date:   Mon, 9 Nov 2020 13:07:53 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201106190337.1973127-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/6/20 2:03 PM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series builds on top of the work that went into the last merge window,
> and make sure we have a single coherent interfac for updating the size of a
> block device.
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

for the nbd bits, thanks,

Josef
