Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3D2C2689D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 18:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbfEVQtT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 12:49:19 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:37813 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729447AbfEVQtT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 12:49:19 -0400
Received: by mail-io1-f41.google.com with SMTP id u2so2430217ioc.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2019 09:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wqvHroNFT1gOZ3Zyfegi5iTs0FDqPzcDe+bySanTD08=;
        b=siFv7ttoTiOxI6+mmiqV7/jCQeh/O2EKIYpvFXjM4NG0V6qxKScpoH6sK3u8Pw6CXw
         fCRol220RSti6/HNpj6rKNU2LGPaRBaqzVV5iltmtmhLteXx3rlEDnyR+Lw7vtQQtHpf
         0Sf6M1IM8GzG1vtn3oNDiRhsKyZb7eBtyh8BOiHYFVdpz6vxJvGgYJMp8GwB/qLN7NtH
         1TsGd52Ngmi/GAxsypK88dz+dH3uLtn4Vp3Uq3ra+weLG1S3X1nHF2sUBR9cM8mE1Y4Y
         ebIISwGu4zIGSRkSZWSf4JaiTpqLZsqvN3UJiW9R+oDE/twCEKi5ZzJ28xG3Jq3fxRQ7
         T/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wqvHroNFT1gOZ3Zyfegi5iTs0FDqPzcDe+bySanTD08=;
        b=adYa/CL+wsg+3THgKoP/IRYuFIFDNuwMqFUddsHHkxYafShNCL9eCS+XSNDTNngN6y
         hLcTSvTIhI/fwWnvAJ3Wt1XAhuS3rZ542+2qgwENTs0Kjv4RCOVIzxaD/K+6zHozdDR0
         oXAvex6dO1W0fnQy9QZX1LByBfKs9JrQsfo4ZhH6YqgNqhUdbimt1fC9pQS+Y0NK26X0
         VGI/wZ9GPOm95SfMkICzvj0w6ESstkYJeGIbNKN4ZVjYNzSj/HRDRLWIQBrefWzGwMMf
         +WiyO/APJV8za1mn5ts0lU7bxP1ovFgRcEVmgg4MaMQ4uelHmzPEOwvr7daYWYFIr8CF
         4smg==
X-Gm-Message-State: APjAAAWzEz3fdTtbYV2xxZss9JfDY7vp+1B2o7bui+jl2wJfNLhvTqAh
        GNrNxuo0F1MC/vsHPli7irsXkg==
X-Google-Smtp-Source: APXvYqz/YVQtZHP5dO+j+VRPGz0FoxW8zh1HmC4KgQTZbl3raYGN+D++sYjHCHYrCYlcLMp12gUgnA==
X-Received: by 2002:a6b:18a:: with SMTP id 132mr11602379iob.225.1558543758403;
        Wed, 22 May 2019 09:49:18 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w139sm3512487ita.43.2019.05.22.09.49.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 09:49:17 -0700 (PDT)
Subject: Re: [PATCHSET 0/3] io_uring: support for linked SQEs
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        viro@zeniv.linux.org.uk
References: <20190517214131.5925-1-axboe@kernel.dk>
 <20190522163405.GA27743@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <96221d93-9428-cf68-8837-2f2b40e0c89e@kernel.dk>
Date:   Wed, 22 May 2019 10:49:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522163405.GA27743@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/22/19 10:34 AM, Christoph Hellwig wrote:
> This just apparead in your for-linus tree.  I don't think queueing
> up unreviewed features after -rc1 is acceptable..

I'm not pushing it for 5.2, nor was it my intent. I think I messed
up the branching, those bits will end up in for-5.3/io_uring.

-- 
Jens Axboe

