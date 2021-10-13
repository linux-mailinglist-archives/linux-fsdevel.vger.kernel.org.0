Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB1C42BD8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 12:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhJMKrZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 06:47:25 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:41963 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhJMKrY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 06:47:24 -0400
Received: by mail-wr1-f47.google.com with SMTP id t2so6780166wrb.8;
        Wed, 13 Oct 2021 03:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=cWS60C2qhUZm9berIFn+upJ5HfQy0WyiGsdyGsM6W6e19XTKM9/t8dx6jVQ3U+kYth
         k7P7wCD4pqV4MxSDczpwfV5FmqLQbAAGudPd729sDPg65oxTKznpBGNbxED5Pdv3Klu9
         q0AsfJQAddUJ31qQSQqGORj6L0gZkZ318b+YLT9CS/QR1QJXB1wDoJ+sYVGJLEuyTVyX
         C3pSERBEjXRhOAIVb8hkONA5D3E1hjtvTtjZNeuFQegjQsUzLJvPsA3RVmBEZRWirXs8
         ChxdHXtsDWVXrTmijGiwEVb11nMdXxq4s8sIN8smIwFNEUVjaVZkVRRTu644q/R0Mn65
         VSbg==
X-Gm-Message-State: AOAM530V+WjHcO+BLekO/TSqn0qgGANl1CnVZIT6Jt9rCvvRG/cAmwJ1
        zQ99OlKVhfdIzd155AKNEUA=
X-Google-Smtp-Source: ABdhPJzFGLQQR+jCHOC/JN9A5sELSOjwRWhKAofThGBfU5bCj3NNbGzvUwR+owUYLDkIWq3WKwyGew==
X-Received: by 2002:a7b:c841:: with SMTP id c1mr12124684wml.40.1634121919984;
        Wed, 13 Oct 2021 03:45:19 -0700 (PDT)
Received: from [192.168.81.70] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id 73sm5210720wmb.40.2021.10.13.03.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 03:45:18 -0700 (PDT)
Subject: Re: [PATCH 10/16] io_uring: don't sleep when polling for I/O
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
 <20211012111226.760968-11-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f26eae8f-266b-e173-6e9b-b4f01517a603@grimberg.me>
Date:   Wed, 13 Oct 2021 13:45:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211012111226.760968-11-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
