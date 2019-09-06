Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC2DAC348
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2019 01:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405685AbfIFXj2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 19:39:28 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35331 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405574AbfIFXj1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 19:39:27 -0400
Received: by mail-oi1-f195.google.com with SMTP id a127so6437558oii.2;
        Fri, 06 Sep 2019 16:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=JMvBnK+cLXVBO4cHzKE/exeU/Zu5bkCpWSUCJc88uhGJ+6mNgwwqEIoGkHw8KX3oVG
         DSZ6r8fV2eeMsYrb+iz2T2Q2/FGglQp5Y93Bas106yBhpFtkTapqW42pZgrWVJkJn5uf
         u5xWjZJt7AbXtTCl8SP8N4HX1NreEa4yZooIf6kTlaeJsbBw3V294Ik+B2giNPn8SPxM
         RDxhT4gdOWBasorPMxq33smvqtSIuPABPQp0YCKTlxrCs0+Ye60Fq9OL8dbmeJY4x6xh
         IY+SUQVe3nW/r494LgLPJqar8RdoTTh90lrgfZsMS5B4UXaKV8Beo+Jt3dLVYbV6Gjfw
         oV3g==
X-Gm-Message-State: APjAAAW2BTKYX/fZjGlDHNaCgnfk87Htyh1zKx+a5BiZDqlblV9K+pdv
        rVDSEIDBT9BXNg5T2ffc2XM=
X-Google-Smtp-Source: APXvYqzNcwbq2IAArQ0RYZjyEopuCwa0cV1pBH/IT6x1kbP8REq8/oh7oBCjIR1FCIqKwTDHxjAqzw==
X-Received: by 2002:aca:4715:: with SMTP id u21mr9545906oia.106.1567813166612;
        Fri, 06 Sep 2019 16:39:26 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id k2sm2330413oih.38.2019.09.06.16.39.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 16:39:25 -0700 (PDT)
Subject: Re: [PATCH v8 09/13] nvmet-tcp: don't check data_len in
 nvmet_tcp_map_data()
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20190828215429.4572-1-logang@deltatee.com>
 <20190828215429.4572-10-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <85d9b571-4b02-54c0-a42a-744f87316f6d@grimberg.me>
Date:   Fri, 6 Sep 2019 16:39:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828215429.4572-10-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
