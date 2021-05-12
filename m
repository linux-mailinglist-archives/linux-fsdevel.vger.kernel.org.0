Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E5A37EF86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 01:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbhELXNQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 19:13:16 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:41745 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348321AbhELWFb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 18:05:31 -0400
Received: by mail-qt1-f174.google.com with SMTP id t20so14138392qtx.8;
        Wed, 12 May 2021 15:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=rpB+rQaedcNnNgOYWnR0sj5qokQVhD7DUrXgS8QOT7oe2pzHcd4kMVpKhG3oa1N1Fd
         xjtnHac6I6LydC7rReFZXyW/cekcK4ylMDpiBhb2pUdkI5Ytzl/4/lL+Z0gnBogdu8Om
         pwNSulUf+UFEkQMgmcey8alAvNdv+5laWmudsH0mHbnie+0ihCUfEG9msvGLWbQXeTcS
         OUQU32Fi/qnqHfwxw/rs7aCWKqSbtbBQLP6UgnS6AMl7kM4q/KGoRDCLHV7ry9Gha9cC
         HuMi/1uhStFP+GnKIyMK1hP17JHgwHZ9mMrDp2hlbhZmfuAtmKtEyNYnZS8hFWxDG1Bx
         I3cQ==
X-Gm-Message-State: AOAM533RYWlhEeuT2dVQkYXcFiKc39nzn+tH41ar5++/A/cUvzCVYcm0
        idBdqkOBlcVw12nUaa/GxBvdcF9aM9s=
X-Google-Smtp-Source: ABdhPJyXt53pTALC0p54kK3jMJP1pc+IyVs10eF1V/ahm3B87/ojgtWgktP4KHcBnxn8e8FdNHo7wg==
X-Received: by 2002:ac8:5ecc:: with SMTP id s12mr21866716qtx.349.1620857060754;
        Wed, 12 May 2021 15:04:20 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:c65a:d038:3389:f848? ([2600:1700:65a0:78e0:c65a:d038:3389:f848])
        by smtp.gmail.com with ESMTPSA id y13sm1051902qkj.84.2021.05.12.15.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 15:04:20 -0700 (PDT)
Subject: Re: [PATCH 13/15] block: don't allow writing to the poll queue
 attribute
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
 <20210512131545.495160-14-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <19027627-669c-4d72-76c8-bc26777f2b39@grimberg.me>
Date:   Wed, 12 May 2021 15:04:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512131545.495160-14-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
