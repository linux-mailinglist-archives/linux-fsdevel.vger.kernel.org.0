Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8732FAC356
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2019 01:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405893AbfIFXlW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 19:41:22 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34301 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405729AbfIFXlW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 19:41:22 -0400
Received: by mail-ot1-f67.google.com with SMTP id c7so7378309otp.1;
        Fri, 06 Sep 2019 16:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=FQLGum8Rtkkv2QnApj0rd0x38FowTh/eID1g5sS6Js9PFcOu3+9D27dSLmZwutF/37
         fMbdd8s1P6z9h+zRBX0cTLsBzMGIlj1JKb68PdFz53t8kGi/h9jY2RQcvDhHBQSsvqp2
         v24y/fQYsNOGs/7B1Zv/YJnJ51Bm3AYzXyzQOeq3eXKiYQjUtSiQm+hrCsrTxY3/vOPd
         cRACSNCIS1byY1sndMlsy3F+RNaRa2eDuJDiWtqo4aRvewPj4sVDy42C/KR62poqLa+4
         uHRxQVim/KlmrrhJfSiDvfqYxbuJAdIhpRl829An2on40+2Ss2dDwAX9/UWBOM1f3fKg
         Nblg==
X-Gm-Message-State: APjAAAV7u5k0LShb91SJBfFU8mIHwRwwDQGYE+UZjEAtkrSxBoO+azYa
        sMikcO2NkBEB7iq0yhTgtdA=
X-Google-Smtp-Source: APXvYqx5bpNcsYa/Orkc3OlNiguFadFwbV07a2BqnWWlxJRpFi+LCN2ZbuUx37mXIymaBHgyc4wtXw==
X-Received: by 2002:a9d:6014:: with SMTP id h20mr1400643otj.306.1567813281712;
        Fri, 06 Sep 2019 16:41:21 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id e18sm2677310otq.27.2019.09.06.16.41.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 16:41:21 -0700 (PDT)
Subject: Re: [PATCH v8 12/13] block: call blk_account_io_start() in
 blk_execute_rq_nowait()
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20190828215429.4572-1-logang@deltatee.com>
 <20190828215429.4572-13-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4fc5c447-c853-23c5-36db-abfb65d47261@grimberg.me>
Date:   Fri, 6 Sep 2019 16:41:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828215429.4572-13-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
