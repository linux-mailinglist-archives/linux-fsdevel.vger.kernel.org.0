Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07B442BD67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 12:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhJMKol (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 06:44:41 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:40452 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhJMKok (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 06:44:40 -0400
Received: by mail-wr1-f41.google.com with SMTP id i12so6738395wrb.7;
        Wed, 13 Oct 2021 03:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=CN2xPeuM1DUfWs5L0fOb8Zn7dfVI4tp9EWfsjBUmjbEjclPZBe2vfnj8nAsWi5+z18
         tSq9Voa7GM7+qhwLSX0ASN/0tvT+gLDdutuurYzcOIFcXt2PCQsCbrLojlbTjMn8UN/Y
         67KuW4XkFxYjcJ8YWEpcBF0TLwtSPWdEKm+yxXYimQOEt/8zXhxJgo5RTFkdh0DMk5tY
         BaA/q3gQFNxECfDtJm4UClFdsbNxZeAE/opeEvQAjaIpLwUl3Zl6rmXAFEf6p2nOBjXe
         i9jerQATh7FDC1mtMY7BamQe1CdQgmLrae0IGERE/UcUVUfTYlQENmDkhj1REztilOJI
         ov/g==
X-Gm-Message-State: AOAM531Ab6dye0hMETntKPv+3H8wQzRl1S7jpDeJXzFg8gi82HzwSSPb
        gguhDQkMOiqBcjEtRmPK9d8=
X-Google-Smtp-Source: ABdhPJwhddV2ARk+BQaQwerHwByTeVEqS3Jo4y42CH75AflfLtX/RHBKsxIbFnW8daF0bFirDwYJUw==
X-Received: by 2002:a5d:6982:: with SMTP id g2mr38987849wru.51.1634121756664;
        Wed, 13 Oct 2021 03:42:36 -0700 (PDT)
Received: from [192.168.81.70] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n1sm4998471wmi.30.2021.10.13.03.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 03:42:36 -0700 (PDT)
Subject: Re: [PATCH 01/16] direct-io: remove blk_poll support
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20211012111226.760968-1-hch@lst.de>
 <20211012111226.760968-2-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <40d102dd-4d0d-c56b-0872-e996e5a1265b@grimberg.me>
Date:   Wed, 13 Oct 2021 13:42:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211012111226.760968-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
