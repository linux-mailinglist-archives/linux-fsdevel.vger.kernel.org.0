Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D585B107FA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 14:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfEAMnW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 08:43:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43946 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbfEAMnW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 08:43:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id t22so5251103pgi.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 May 2019 05:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=kAWzTRrdQQn0qB9WvEEBykXGzB1SmroEGLap8Zwt/1o=;
        b=dzt4LVcMRuFRz8l0Da+88RygX+vIW/dOAQeGl+J91ns8q7w+Ee8YXFS+BrXhPuKxUI
         EhOKEWQZfCLb+DXI8lqNmY4Mq3RHN2RSapcf6KDZr4driq2nJzMosH8Fm2yuKIF31ehy
         SRrSD+BGY9H6UwGQWuK9s+FqEu5h+2X+8PdPgvGVXrh4Hc1A0pLr1V+WaIDGLBimgfsi
         LGpwiSEN5XS6QqVl/We1UVxyuSET5D1FHfDRU4iEI07tSoCSSATijGI4Pn4VI0lSrTGd
         VmqXXSRA6QBYN1NtYrXeo9iJ7EjEkxnkgpagEBye89vJQstnCtILX98lXqcNpKukMj02
         24tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kAWzTRrdQQn0qB9WvEEBykXGzB1SmroEGLap8Zwt/1o=;
        b=h72GohyL7EEOm609uPnSlB2uG8+waNfOouZaFmotfoHas9RGHpFqMJZ5sQFzbmkV3G
         zJisUvIVjxtxmIvL+hXW9cRqHe33gFfb5JDTZ/vp7ykKRjLN4S5QO0a2Lig7MaOgN2f1
         I67BWYqtITWNRl5MKCGnrDUyo6sTvuU96yQSM6ewVPYvGRPhB+UCwY0NbQgazoALTsX9
         IuzCdHVdc2NmOEAHRbUE/lchFFHOIRhueqFhhA9JMkooiJMAaSE+DgMaq8ee6KTkqA5y
         hTQ5yXD9zzaKUp0Vpl1ZKXm/CLo3Sp5oGv1dOMvNrg0pCSIohWmW1HpVoov8iYRlAc/+
         69lw==
X-Gm-Message-State: APjAAAWxlQSOe9hKrgUcbd+vE5oVny5G+7h2JWfF8+fT0depw2C99ByL
        dTOjp9E8qD+0M9fCU/+LC1J87MX1nJJpVA==
X-Google-Smtp-Source: APXvYqwYrYbpsn35wp/hZRoyJ374/7VO7aJBmeBJ0DNcETxhReKmX/Xc5wSuV3tsCKoq/Sr1zB3cAg==
X-Received: by 2002:a62:2ad5:: with SMTP id q204mr77227243pfq.259.1556714600995;
        Wed, 01 May 2019 05:43:20 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id c8sm6783930pfr.16.2019.05.01.05.43.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 05:43:19 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] [io_uring] require RWF_HIPRI for iopoll reads and
 writes
To:     =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20190501115223.13296-1-source@stbuehler.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <628e59c6-716f-5af3-c1dc-bf5cb9003105@kernel.dk>
Date:   Wed, 1 May 2019 06:43:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501115223.13296-1-source@stbuehler.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/1/19 5:52 AM, Stefan Bühler wrote:
> This makes the mapping RWF_HIPRI <-> IOCB_HIPRI <-> iopoll more
> consistent; it also allows supporting iopoll operations without
> IORING_SETUP_IOPOLL in the future.

I don't want to make this change now. Additionally, it's never
going to be possible to support polled IO mixed with non-polled
IO on an io_uring instance, as that makes the wait part of IO
impossible to support without adding tracking of requests.

As we can never mix them, it doesn't make a lot of sense to
request RWF_HIPRI for polled IO.

-- 
Jens Axboe

