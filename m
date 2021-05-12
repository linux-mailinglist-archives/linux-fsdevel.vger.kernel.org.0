Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD61437EF81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 01:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhELXNH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 19:13:07 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:46992 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239099AbhELV7o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 17:59:44 -0400
Received: by mail-qk1-f170.google.com with SMTP id 76so23795537qkn.13;
        Wed, 12 May 2021 14:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=teFV4zsh+wX5/8Dv6IhnjwJGEPrF2Y8+kPORFaDK0Z6eGCAhlf4xbKnuZLKDOf8Toq
         SX26qdJVvwfs9gPREGBIJQIvn78BkT+nu+dnF0W03J14IzefZEgy0l2PIwkqv7m8GPeB
         KpnUXoWcg+DXyFhx2wPxG4BeIgojzuOCDQoem1HnsBJqwfKf45+iosez08r1Iuaux2bs
         FkKj9FtcGqN38q8Hg37TSN47VG6Kr3UsiIVBLPBo3n/tBjLlqwxBJSufbjOsim71NNen
         AAz7E4uE1vqaVFW+5P+9P07pIFquiCwoJpBPJ4z2PWkzn9gY2sLKfbrEu7aGNveIiX67
         clYw==
X-Gm-Message-State: AOAM530BwmG3k37Wljx8kXiti8Pvawv24fq8PmPkzk5S7yGPzwG3wHa7
        MWtYMhO2SJ0rebY865xtQ4Q=
X-Google-Smtp-Source: ABdhPJzwS0cgNLHyE4FZlTFgrvA54SkjFB9zrbp32LsPaNSlXEy/DVB0N754OeJqsYxVMpsnkgOwbg==
X-Received: by 2002:a37:8c1:: with SMTP id 184mr35663745qki.345.1620856715252;
        Wed, 12 May 2021 14:58:35 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:c65a:d038:3389:f848? ([2600:1700:65a0:78e0:c65a:d038:3389:f848])
        by smtp.gmail.com with ESMTPSA id u6sm977905qkj.117.2021.05.12.14.58.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 14:58:34 -0700 (PDT)
Subject: Re: [PATCH 11/15] block: define 'struct bvec_iter' as packed
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
References: <20210512131545.495160-1-hch@lst.de>
 <20210512131545.495160-12-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c337780b-4499-003a-e6c3-b29e941234db@grimberg.me>
Date:   Wed, 12 May 2021 14:58:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512131545.495160-12-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
