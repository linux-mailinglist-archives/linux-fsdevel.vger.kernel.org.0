Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D5437EE8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 00:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239039AbhELVwj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 17:52:39 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:41675 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389542AbhELVBC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 17:01:02 -0400
Received: by mail-ot1-f42.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so15473942oth.8;
        Wed, 12 May 2021 13:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Go7H7PwMWkBae4rrluCRBAjjPsYYEb0+NNdtXUfQr0s=;
        b=rhUglgTVjLBtL9a8ksmET+cG8TPZXqmSG/3662HcZf1DSi0Ohdyjkg2mGjDOBN98Vs
         ycmonx3R5NGVtci73trbH7KXvKaifETRPYTwZe0rnCMDfOcPlhLH946Yesgq81WAzFhl
         Dgm09EcEHNwwDulG6Veowkl9PY8Sl5cUOrzinpCh8I3Wzkn1Ns7Sflc0yq+bOarbooOS
         Md6YJ3AguqiInENOnNGUjWrkZ9IEofBZlH9W+8SHSYTgRFsRc8PWbC4oLQrYy9hC5PfG
         sSsX/sqqcytB9j9QNdcFBzNdZwzpRP0Hpd2j3MG+IFDx/1stqRO+n8eAV4GvvP1ekYwm
         J9iA==
X-Gm-Message-State: AOAM5320IPjEl+PwHBJrv2P4c9W10reNLurkxXuIZhJIMvpwgXKDMFwo
        k/cF20mP2rzk68GLq0uGqls=
X-Google-Smtp-Source: ABdhPJwdgMe449USIr0N4Nta7Zk4lE57U8wQlyC8Xiflsdm4iW+ee9eDNncvOMiyal7GUqVTv/k+HA==
X-Received: by 2002:a9d:625a:: with SMTP id i26mr2062767otk.326.1620853191148;
        Wed, 12 May 2021 13:59:51 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:c65a:d038:3389:f848? ([2600:1700:65a0:78e0:c65a:d038:3389:f848])
        by smtp.gmail.com with ESMTPSA id e20sm237794oot.11.2021.05.12.13.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 13:59:50 -0700 (PDT)
Subject: Re: [PATCH 05/15] blk-mq: factor out a "classic" poll helper
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
 <20210512131545.495160-6-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b35e93ec-d9b4-89bb-9358-b76044e91f5b@grimberg.me>
Date:   Wed, 12 May 2021 13:59:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512131545.495160-6-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A bit convoluted diff, but looks ok,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
