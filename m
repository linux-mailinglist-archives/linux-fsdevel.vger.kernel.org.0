Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1581FED28
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 10:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgFRIFZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 04:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728308AbgFRIEg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 04:04:36 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932D3C0613ED
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 01:04:34 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q2so2563341wrv.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 01:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ypYuYJigIb8VHCUtNcGOn99vAHuAHCA9hokHiE2bncc=;
        b=H9uCyCXnVKd0UETnW1mP2ouZ0DUuu32PQNmdlcfrlGc6dBYA1ssCtS5Og4ICZS1l3I
         BvkHo8b5cVnsKeMvyTo+6I+/jFfm0gyl71MZ8PtJfBR9wuswZ7K6fGKZzEH+NHLhgW2T
         5Ehk1R4JTzGYy9trrQMRYcUeQ1UtMzHLL818OqTdBL5OpuMRiUEbCsUHUFN8BkJglFIP
         Rx7ucKs9q6j3PA1UFObnV46cmjSciUYjjaBELY5hjxPur2qhUWGPZfldonjbpRO4sLbJ
         Z45f0M+9d3OqaVz73ZDhBilGF4kzEKXSurss/hCfzLuEeybyqttBkYHEzKy0DF+7qoyR
         PCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ypYuYJigIb8VHCUtNcGOn99vAHuAHCA9hokHiE2bncc=;
        b=b4gFi+wQis+Jy2ip1xB83UXi+5KxPX1wkZ3vVhwI+bCLA/qRCsnsoJryYUlmulvHYm
         EN3Wy37Y61XtkMAhDkcALxhSrb5TrFoVBFw/KttzpGAwjX/aRJO6KjsGQ5GRfoLXq+eN
         7d0gWfcDEqbmgWTK6DvIhGB9AON5cKLxtI1nk6e/0k0FqwL2ArhUNWiIzFbSaRVBiueQ
         j6ejFQzkEWn5WRh/OJJGrekkKj39Ep2Ut94T/Q/RuIztSL/aez3q21x5Y5J5ImZ2QwJ2
         aDEG1IxgCQHodsc+mekI4T321aV74hlR3SRXpvBAOgYntgeaWMOmkhMObQxFa9qdzUu+
         nonw==
X-Gm-Message-State: AOAM531Zx7vWGQQ8RDUhTJ4L41MQnHrKyxjFJxFzqxGnh24faEQcRbO4
        6+YHa1Zrod1MOY94T4NLiReOBg==
X-Google-Smtp-Source: ABdhPJy9kYbtxsS9p1Gqu9ZzDkGKhTVRMt8ZrKgQyjdOb0qD5wXvXTGOpcc9v04//KMjqkivzoMq0A==
X-Received: by 2002:adf:db47:: with SMTP id f7mr3375855wrj.101.1592467473275;
        Thu, 18 Jun 2020 01:04:33 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id l17sm2439436wmi.3.2020.06.18.01.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 01:04:32 -0700 (PDT)
Subject: Re: [PATCH 0/3] zone-append support in aio and io-uring
To:     Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, bcrl@kvack.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aio@kvack.org, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, selvakuma.s1@samsung.com,
        nj.shetty@samsung.com, javier.gonz@samsung.com,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <keith.busch@wdc.com>,
        Christoph Hellwig <hch@lst.de>
References: <CGME20200617172653epcas5p488de50090415eb802e62acc0e23d8812@epcas5p4.samsung.com>
 <1592414619-5646-1-git-send-email-joshi.k@samsung.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <f503c488-fa00-4fe2-1ceb-7093ea429e45@lightnvm.io>
Date:   Thu, 18 Jun 2020 10:04:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592414619-5646-1-git-send-email-joshi.k@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 17/06/2020 19.23, Kanchan Joshi wrote:
> This patchset enables issuing zone-append using aio and io-uring direct-io interface.
>
> For aio, this introduces opcode IOCB_CMD_ZONE_APPEND. Application uses start LBA
> of the zone to issue append. On completion 'res2' field is used to return
> zone-relative offset.
>
> For io-uring, this introduces three opcodes: IORING_OP_ZONE_APPEND/APPENDV/APPENDV_FIXED.
> Since io_uring does not have aio-like res2, cqe->flags are repurposed to return zone-relative offset

Please provide a pointers to applications that are updated and ready to 
take advantage of zone append.

I do not believe it's beneficial at this point to change the libaio API, 
applications that would want to use this API, should anyway switch to 
use io_uring.

Please also note that applications and libraries that want to take 
advantage of zone append, can already use the zonefs file-system, as it 
will use the zone append command when applicable.

> Kanchan Joshi (1):
>    aio: add support for zone-append
>
> Selvakumar S (2):
>    fs,block: Introduce IOCB_ZONE_APPEND and direct-io handling
>    io_uring: add support for zone-append
>
>   fs/aio.c                      |  8 +++++
>   fs/block_dev.c                | 19 +++++++++++-
>   fs/io_uring.c                 | 72 +++++++++++++++++++++++++++++++++++++++++--
>   include/linux/fs.h            |  1 +
>   include/uapi/linux/aio_abi.h  |  1 +
>   include/uapi/linux/io_uring.h |  8 ++++-
>   6 files changed, 105 insertions(+), 4 deletions(-)
>

