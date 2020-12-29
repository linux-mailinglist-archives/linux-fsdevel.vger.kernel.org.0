Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92352E753F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Dec 2020 00:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgL2XsM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Dec 2020 18:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgL2XsM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Dec 2020 18:48:12 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B98C061799
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Dec 2020 15:47:32 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id w6so8782653pfu.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Dec 2020 15:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+3b8AdRBIqhWAbHJd9MKSPNeTg0fP65SdBmoyfUBMYg=;
        b=LOWL6Dv/YDfwgO3gm7k/Ha/1/B99cixiWTPNt5zmPqOtGudX3B84OkiYJ2eqpazjW+
         IUk8J5y74d/F2jrb6kaSCg62aNDYqZTCE5yYeAxG8Cch5dSa1uY3N/Vm0KYNAx8KqDu0
         sD13n89GAed7RR/Bf+OSJ8NozA6xCZ0PHh2JESitG9MV7P7JaXslHGMA1KRNOWPnxTFy
         XSoHOvK5yO5G9s+Xi0dC19N69lwHpf5M/kbSkDT/WGbqwiwYcsjIQYaMs4n0VFUb7EA2
         35/aRBLbPNFMBN9OnvEpbxXrUOFQ4MUFfzxVEzOeMzGc+XZ2IbDhpvO8hI3iGB9Dw+kj
         bk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+3b8AdRBIqhWAbHJd9MKSPNeTg0fP65SdBmoyfUBMYg=;
        b=OaQfVjZIk4M6fAdymU35RZj1QP6Iv6nQrwmB5QGK17k+NjqyZFuWu6Ki595FJGte/c
         ONjWeLSxgC6/O9ZFU0shs/5poyXJqc+M3PGWO+6QqTnxNkNwYRlTLxk9gtCjn97yngNm
         No0eK+Q/JX+1DrdsqbT29nlBRQ7NeczkJ40Iff50WvCLGgK5HnyefXL5jPryUPfZVJc7
         x5fgQ4BkhUKU9rqwfz+3Nc5UdkyK3rTfDo9x2Y3e0hMxx6AS/f69zIZZN1865V6Ma8ht
         LYH+3wn2XFy7ZFzxLdHYnm5mG7Bpa9kS3PI5EDKieIU3k1Dv/a51JUokDP9otzkZq1If
         /W1g==
X-Gm-Message-State: AOAM530iI9GMbCUkmB1rdekyA+D4w1lg7PVoYbhIjhyxm0jCp0nN5bAZ
        LbJcJ85IrYJgM7rH+kIK8clI6w==
X-Google-Smtp-Source: ABdhPJw5d9F0tV2Vowzh8aEgRK+TarMawaqPnaU+0pRVws/TCofMSmohcSXCPeG0Gyls3rJKg70taw==
X-Received: by 2002:a62:19ca:0:b029:19d:cd0d:af83 with SMTP id 193-20020a6219ca0000b029019dcd0daf83mr47506004pfz.51.1609285651753;
        Tue, 29 Dec 2020 15:47:31 -0800 (PST)
Received: from ?IPv6:2603:8001:2900:d1ce:8f91:de2a:ac8a:800e? (2603-8001-2900-d1ce-8f91-de2a-ac8a-800e.res6.spectrum.com. [2603:8001:2900:d1ce:8f91:de2a:ac8a:800e])
        by smtp.gmail.com with ESMTPSA id gz5sm4485940pjb.15.2020.12.29.15.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Dec 2020 15:47:31 -0800 (PST)
Subject: Re: [PATCH] fs: block_dev.c: fix kernel-doc warnings from struct
 block_device changes
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20201229034706.30399-1-rdunlap@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <75e962dc-a95f-7ca7-c145-6a83f11d6271@kernel.dk>
Date:   Tue, 29 Dec 2020 16:47:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201229034706.30399-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/28/20 8:47 PM, Randy Dunlap wrote:
> Fix new kernel-doc warnings in fs/block_dev.c:
> 
> ../fs/block_dev.c:1066: warning: Excess function parameter 'whole' description in 'bd_abort_claiming'
> ../fs/block_dev.c:1837: warning: Function parameter or member 'dev' not described in 'lookup_bdev'

Applied, thanks.

-- 
Jens Axboe

