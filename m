Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5474942BDB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 12:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhJMKs7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 06:48:59 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:43539 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhJMKs7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 06:48:59 -0400
Received: by mail-wr1-f54.google.com with SMTP id r7so6783632wrc.10;
        Wed, 13 Oct 2021 03:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=zUuh0vexfjnhzoeh6jXbO/Hxy/5BYYrdCGCNjt73cGbex9OxpvyVJlk0ZLaRy1x2BP
         sMgxjMwkiervDwnTcOOgVjgm6fHv1lBzX8CXQa4QHN4VHAT8Nl5CEGPAhH0DnSXar4fl
         5N1KXYKmjsD+svfokIzPd3JefhWtndqRZbBRHc3pyjVuUG+CFVPaQ0hTfb1lKWHkKCZX
         x21BSGhrdfEa3qBLntzf7wIFmEYmIE8+gNMOrNhM21vfX061/pGnmAtqu8IiWcDb78lF
         p1kyaKvGwzH2HJ8uoG/6Zqd7ojkIzFECZARuXc7YgQ9x9fVgVbHqyFeLdvsIEerUB9hQ
         sIfA==
X-Gm-Message-State: AOAM531akvZjejMQczP4FnBCB6Eoiv+X2q3ZsJ8YvcC4rWooCuugZQNl
        IbS491jFdgYQprNXjiaoj3Q=
X-Google-Smtp-Source: ABdhPJznl0Cyha9YuoZzj0ui6fzyAaFrBAoonpFx7/+lsuoz2aW/ggguxny9EKM286SHQQCueElklQ==
X-Received: by 2002:a5d:6d8c:: with SMTP id l12mr17578526wrs.80.1634122015071;
        Wed, 13 Oct 2021 03:46:55 -0700 (PDT)
Received: from [192.168.81.70] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p8sm4946239wmg.15.2021.10.13.03.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 03:46:54 -0700 (PDT)
Subject: Re: [PATCH 16/16] nvme-multipath: enable polled I/O
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
 <20211012111226.760968-17-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <aad822e0-137e-a08b-62a8-0a4b69162466@grimberg.me>
Date:   Wed, 13 Oct 2021 13:46:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211012111226.760968-17-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
