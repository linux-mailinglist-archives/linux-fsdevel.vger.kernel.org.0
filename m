Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1101937EE97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 00:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346646AbhELVyB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 17:54:01 -0400
Received: from mail-qv1-f47.google.com ([209.85.219.47]:43524 "EHLO
        mail-qv1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345739AbhELVny (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 17:43:54 -0400
Received: by mail-qv1-f47.google.com with SMTP id v18so2739662qvx.10;
        Wed, 12 May 2021 14:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=kayPXPu78XNcbu5cKQfIDzRckMy6PDltHyfZmhF7etxDnfYutovRHvz7avHvFH0S6P
         gWDak1c3hftC8g4o6uB1bfW1KgFECfHq4XMN8tCJqbRfrjWze7Z0qfvtWCdut+d7kO34
         zLhSInBELI2HqSHBJ2wXyVSlMsemlSuSuIx79hH85k72El3zDJ0iD8Mo10H17BRkOXeS
         bczTbM7drvwRqtQImL2s7mIv52XL1Ya6ntiVwP2btLO2EQFuD4kBZuN0j+cwEUIwUgxI
         v02gVdnRFNwzHoj2bU0O24znwjPULzJTNBam5iA2i/dEiuwU0epAWehd9AFQbjmWwpjC
         I+yQ==
X-Gm-Message-State: AOAM5339eCeuK/4JwHeqgHx4WtMLfswBgq6AdolqAaE4nnt/nCxGbPI4
        AW8arVzzzuUAKXNWFKzpXr4=
X-Google-Smtp-Source: ABdhPJyQfuitcMrAy159D1EWSmAvwixoWGUhMcEbMkPwnZu1KEiGdYKWQ1QjgHqpg1FJYlvEW8gmvw==
X-Received: by 2002:a0c:a909:: with SMTP id y9mr37501332qva.20.1620855761936;
        Wed, 12 May 2021 14:42:41 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:c65a:d038:3389:f848? ([2600:1700:65a0:78e0:c65a:d038:3389:f848])
        by smtp.gmail.com with ESMTPSA id d21sm877778qtp.74.2021.05.12.14.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 14:42:41 -0700 (PDT)
Subject: Re: [PATCH 06/15] blk-mq: remove blk_qc_t_to_tag and
 blk_qc_t_is_internal
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
 <20210512131545.495160-7-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9f8a7bf6-366f-bcb2-f5d0-fb9bbf6678d7@grimberg.me>
Date:   Wed, 12 May 2021 14:42:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512131545.495160-7-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
