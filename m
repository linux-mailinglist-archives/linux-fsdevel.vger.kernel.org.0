Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F085242BD8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 12:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhJMKrh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 06:47:37 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:39521 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhJMKrg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 06:47:36 -0400
Received: by mail-wr1-f54.google.com with SMTP id r18so6797046wrg.6;
        Wed, 13 Oct 2021 03:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Fni5EdevqjnDD5RU1XfyO3m3pH6Cah/TlsIiShpo5EDoxk1tqq9+2++1g7M+4hXUUL
         5wYMo9dKRzyfvmlVJK9EKm5tWB94Ks8lb/sdYKoM9R/klF0nYitD35QbXUpNy7J7nxit
         tKvttAx9HGzEijK8jQGzdp0f4aNRjqNwe4bE1zWUKI/WHak1RbIioY8uKpdAgwu3Eg0R
         gXUBaWL3JpDrlg/eyF0qoIadmkSn0nBrSBh/Llfv0P24605XwiHeBA/9zn8LcxDGJsBX
         BgjBfi9YFQPF34UIlPTHI3F6bkmTjeBQD09qgPCkGpdp4IaYxD/ey/YRkoBaeFt0BIZT
         21Hw==
X-Gm-Message-State: AOAM531ZI1X8dNKAnXzCo4GrrZFDGwQHQU8YTxt+cazX7NacybZnC10j
        8VsvegqAGlNT1ezw/0pQ6js=
X-Google-Smtp-Source: ABdhPJwRCPHmlALD4GINu7BfgKMAQX6ORa6ZZNYylVOKoHNRpwvmd/40Xn/R1wZ4sitG8tcwQeg8NQ==
X-Received: by 2002:a1c:21d5:: with SMTP id h204mr11799356wmh.9.1634121932624;
        Wed, 13 Oct 2021 03:45:32 -0700 (PDT)
Received: from [192.168.81.70] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f6sm4660791wmj.28.2021.10.13.03.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 03:45:32 -0700 (PDT)
Subject: Re: [PATCH 11/16] block: rename REQ_HIPRI to REQ_POLLED
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20211012111226.760968-1-hch@lst.de>
 <20211012111226.760968-12-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <04d343e4-4c9a-7ff2-bf55-7c42fb02cc4f@grimberg.me>
Date:   Wed, 13 Oct 2021 13:45:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211012111226.760968-12-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
