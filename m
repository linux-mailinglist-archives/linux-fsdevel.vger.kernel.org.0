Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA4737EE8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 00:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240245AbhELVw0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 17:52:26 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:45987 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345134AbhELU7s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 16:59:48 -0400
Received: by mail-oi1-f170.google.com with SMTP id n184so23479899oia.12;
        Wed, 12 May 2021 13:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=qO/6ug2dOyxGE83h71DCfO5Vbw2wWSH4ozsNTcs98oKkpIS0iYnhvpKw/jdPRHOCjs
         Zm4CYG0kiWQh+rkXaCXfMDe+i/GY8NEN17DCax65/6Nn1Dbq4EyJ83/jntPFXvzTz5+/
         8FwJY48ufp16ozSqW5L/XM7k82jPdtvxwXIWhA5LIMxFgl8Pb6eZGfnJuRavHYcBzOFB
         d+8CRXCnyfL1RBHEr4YavEyAEsJILRa2FI8VWUj4oLFfafTvNRvB2ehM82cLq+UbJ2f5
         5rgPrbj4QXQOLf2eRcr9PzejoLCFWU82UmW4DX3NNkQ/58OC2JpBYFnvyxTs8VeJB4GO
         3MVw==
X-Gm-Message-State: AOAM532Tm14bWff2aoiV0FX/snDFUGwAIXs7GQBTI7j5aFngbsJG9w3T
        WyCk8X3D6erDJh3pU/h70KU=
X-Google-Smtp-Source: ABdhPJxIt33KmeXNXDucfoZBOm9x/wAiZEW2osKajoIJW1cYbUKVk4S5avEIuomHeoZsyKU0Jwknrg==
X-Received: by 2002:aca:5c44:: with SMTP id q65mr26899108oib.12.1620853102255;
        Wed, 12 May 2021 13:58:22 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:c65a:d038:3389:f848? ([2600:1700:65a0:78e0:c65a:d038:3389:f848])
        by smtp.gmail.com with ESMTPSA id w6sm203220otj.5.2021.05.12.13.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 13:58:21 -0700 (PDT)
Subject: Re: [PATCH 04/15] blk-mq: factor out a blk_qc_to_hctx helper
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
 <20210512131545.495160-5-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <030d24a1-de26-e71d-2b44-bc213abf5219@grimberg.me>
Date:   Wed, 12 May 2021 13:58:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512131545.495160-5-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
