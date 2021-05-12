Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D17C37EE98
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 00:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347565AbhELVyX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 17:54:23 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:40826 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346661AbhELVoQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 17:44:16 -0400
Received: by mail-qk1-f180.google.com with SMTP id f18so1908373qko.7;
        Wed, 12 May 2021 14:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=o1jEnQAI1niWkNH9z7VH3QIFYxIbytLPFkJbhZE9z5PcTj093cVqD1m+POeBtzuu57
         xJRLaeaT7G7LtEErT5CSyHQgjcelV9U0M4vQWnm5nxWR0hzLlM1sTOPqCYiQ0xiEJkYJ
         h0iK146hXq32SxeLAt0SHSyAxwkGV6oGHZwA/1DGLWP4pEEzEBL6hHC6WWIBd0rlW+n9
         EHYvUmsKTVNdaQZsHB4bVePS4Cex8xdnLXIzmiqQRudAWSHvGcR3jwsVcYnkT5AWTxdL
         Jso/Gm5DOvgDiKBanHyWk2yiUFLxVtTe5gzYgrOtoyOYyTDdZ/Jx8gNBuxipgNmGQfSZ
         t2Mw==
X-Gm-Message-State: AOAM532Sk9Ok6aYmLonjHaUjYvstBvcotQUZo5soBeYPxiHoXG22GG8E
        SnDzmluDi0KLBAPJtMGBbXQ=
X-Google-Smtp-Source: ABdhPJxHg6k8rV7EcmCHMksmgDbuJ4bvztCFiTBTf+jeuEkuvXgT9EZ1bU2CW3wZIEtVpGmthvm32w==
X-Received: by 2002:a05:620a:b1b:: with SMTP id t27mr28617638qkg.42.1620855782980;
        Wed, 12 May 2021 14:43:02 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:c65a:d038:3389:f848? ([2600:1700:65a0:78e0:c65a:d038:3389:f848])
        by smtp.gmail.com with ESMTPSA id g185sm1021532qkf.62.2021.05.12.14.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 14:43:02 -0700 (PDT)
Subject: Re: [PATCH 07/15] blk-mq: remove blk_qc_t_valid
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
 <20210512131545.495160-8-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0dd86996-1274-b1a8-571f-4d5b9f71c2ed@grimberg.me>
Date:   Wed, 12 May 2021 14:43:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512131545.495160-8-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
