Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5BE537EE87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 00:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240165AbhELVwN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 17:52:13 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:36642 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386454AbhELUz5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 16:55:57 -0400
Received: by mail-qk1-f172.google.com with SMTP id c20so12649907qkm.3;
        Wed, 12 May 2021 13:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=LZAhKZRJzEs0GYh23U+HdYiA4FqSPNp3glE+7LQD5v6xe8xskRT6hpVzNQ1so2oMrV
         AJBjj7jTgBi3MT2usKi+ELizCkUSQ62yUHGweQ8tEyk2NXZVzwTUEN//dBEexDWaB9IL
         kvw1zZoTAQq2JSXLUMsPJ7+slGr6DyrDVD9qlB7cyDCPpbX6N1chevmY5s91Elv7hHjY
         6LwGejZaiGOAMWWLwcs7hlLUggV/LJb/m2bjxw78TlRMSFkfwI/QiC/6hBHeniYYGJRJ
         +TWSpcS2jdwdjpWpOhxZMP2S528w+DaN/JldhRYoSQRafqxWkCLW7gZhgUzCrXbeDf5s
         lmbw==
X-Gm-Message-State: AOAM53178tvjWlrwyVAXxonAwCwvQ/7LRKyehtfA8hEeUtjqjkChVg6W
        WAIB3Z0MslKLwE2zMX8YjzzyoAmV3NI=
X-Google-Smtp-Source: ABdhPJw3ba7TDy9IXhuSNfnoRNLweJN6Sxi95AmyabzWqR4IojtKhY12rFTIDEHLbQim/UIuTomsBg==
X-Received: by 2002:ae9:edcf:: with SMTP id c198mr26913097qkg.54.1620852880078;
        Wed, 12 May 2021 13:54:40 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:c65a:d038:3389:f848? ([2600:1700:65a0:78e0:c65a:d038:3389:f848])
        by smtp.gmail.com with ESMTPSA id l16sm964832qkg.91.2021.05.12.13.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 13:54:39 -0700 (PDT)
Subject: Re: [PATCH 02/15] block: don't try to poll multi-bio I/Os in
 __blkdev_direct_IO
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20210512131545.495160-1-hch@lst.de>
 <20210512131545.495160-3-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ad73f9ea-bc57-2a9c-5c32-547d188c7a1e@grimberg.me>
Date:   Wed, 12 May 2021 13:54:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512131545.495160-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
