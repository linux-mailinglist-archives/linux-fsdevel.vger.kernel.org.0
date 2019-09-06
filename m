Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCDCAC34C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2019 01:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405712AbfIFXj7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 19:39:59 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41719 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404078AbfIFXj7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 19:39:59 -0400
Received: by mail-oi1-f193.google.com with SMTP id h4so6403686oih.8;
        Fri, 06 Sep 2019 16:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=r+iGujZWvBpMcryll0XtsWTKmJLoMk+Q04fnsuUtPd6Cst1pxYEl4CCAIqCF67GGPx
         wIMUP6IpHn0kEs6vhC8vJRlFQ2xy7IpvxjMYk3D3lUaVJSnoXC2IqzxflfHZ1P3XjSUt
         W9lD4ghFLS33rZQbvXDGa8GapQhSq6RcIJpVMPba3gc3FTouh13HvLaUPRnDxxwluXiF
         y+pUP0GE15YZxtNZfJ6yijjriFV8r+oj1tnBgVTvfNDx6ScP/TeF9BfALebk9s5kBHCZ
         ruST3vpJoKFmXKMcXHFKhw8Keeq/JjU04k1mpSO6f/hy4RujLbFF6w1eBfBbMkD3pxYu
         nUwA==
X-Gm-Message-State: APjAAAXq3UKlkXUJcRVyzTa9O5+Noe08vbbw5B/AGwyz7xhs+n/wsbIS
        KEU2EahzctMtUTh6aMjkk+4=
X-Google-Smtp-Source: APXvYqxEU689XOtYDKDRF9cRaK4h05GjP3FBRAs0hA+fbfVVxP9MW+gEKrw2JkiUuQKfDpJCZ51mGQ==
X-Received: by 2002:aca:50ca:: with SMTP id e193mr9618385oib.110.1567813198428;
        Fri, 06 Sep 2019 16:39:58 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id v2sm2202856oic.49.2019.09.06.16.39.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 16:39:57 -0700 (PDT)
Subject: Re: [PATCH v8 10/13] nvmet-configfs: introduce passthru configfs
 interface
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20190828215429.4572-1-logang@deltatee.com>
 <20190828215429.4572-11-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7ac28537-d8e0-5263-b10e-ff9b708d6313@grimberg.me>
Date:   Fri, 6 Sep 2019 16:39:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828215429.4572-11-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
