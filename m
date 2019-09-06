Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2055BAC315
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2019 01:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392935AbfIFXdb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 19:33:31 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35843 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392874AbfIFXdb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 19:33:31 -0400
Received: by mail-ot1-f68.google.com with SMTP id 67so7352044oto.3;
        Fri, 06 Sep 2019 16:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=jdesAfIeqYR/VZVBFIv9KOmq7Ibhq3CC0pLqIHgiUA9qioYXELpFeWTaKtAFfT5nS2
         Bsq4SMztUC28ZmyxFJiHYZs/hGBAJ1vbZXpckvQQkPRE1/kioo0M2Ln0EHlSk1ZQIwKe
         eSriNg1g02CP0PAkTGWECTXYsOh2lEMEDM84Mom1SkaMhVuFgAHC+A+JWlHr0t8Ek5RY
         dS5Z+VR9bKpW1BPR4wnFFhGyGNidBcscEfeo1ZUeB6zmKrnNna3cDmxPoeSO08+Q6HWh
         o4T+5zmnwRS8CIxgJHmMvfnsMqBH9VLo1TOgoHXqfVr/B3O0cSAKZxUzpB3Rl8omyTFq
         RSDQ==
X-Gm-Message-State: APjAAAVQOGgJSwGkqDIu0cYKcqrukhGtGrkFeXNwpCKiS8KIuxnRhxKV
        NFHIZwgIWSY6BedKeHiZYuU=
X-Google-Smtp-Source: APXvYqyerfyqDjBSkqBV5awpri+gcw1eOii1hkXi4+t7I8BPKUfhltTsqe2asvXehkt1m+lTJphnMw==
X-Received: by 2002:a9d:6acb:: with SMTP id m11mr9725890otq.40.1567812810260;
        Fri, 06 Sep 2019 16:33:30 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id z33sm2710525otb.75.2019.09.06.16.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 16:33:29 -0700 (PDT)
Subject: Re: [PATCH v8 01/13] nvme-core: introduce nvme_ctrl_get_by_path()
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20190828215429.4572-1-logang@deltatee.com>
 <20190828215429.4572-2-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f67b6e12-8d88-6dab-1211-64595ea58421@grimberg.me>
Date:   Fri, 6 Sep 2019 16:33:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828215429.4572-2-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
