Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00DF22CB24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 18:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgGXQee (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 12:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbgGXQee (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 12:34:34 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9E0C0619E5
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 09:34:33 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e8so5520726pgc.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 09:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KxUVJu2tVsXuL6ozXtsDLOIo+4JxBbyht8pFne+rsMU=;
        b=K7XpyhQvrenGn2Xu15vi76JcRUT9sC1liRgYcCIGd9iGI1u0NGrLkxgPuwufFBfvx0
         I/C3wBLb9TCtHH5QjgJVmj4daBGbHavWk+DVx/3IjdtnfdkCBBhocCDJT5Rxnu8BvzeN
         mCqzqbB59MjQsoiZzBtZ15Q/yIgmPozIOIx1SlN02Pg/DvEWOqWCyl5hsjbzqBE6K5Db
         Fa6O+23rfJS3D1mMkhzPo+FLntzB0TbISxoiWU2HQcOpkERblpEAgh2EsVdLGDpvvtLV
         JkZBYmpwFdV+YU9UiXZtLLkqDrlg4J1mnyx8QF6UgHCGszO1D6Kjxn3qln+FBsCEJ+pl
         LyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KxUVJu2tVsXuL6ozXtsDLOIo+4JxBbyht8pFne+rsMU=;
        b=BRFXh3bH3Iih2tGOOInkGNUzIhUKlt4x1Azb4nfvUITwvqfTS9Bd0rKRzFejq/Qczl
         3B0+sK/CslHTjI4mCVx51csNwr40L4rsxG45qs8GtAJECce4pAa7NevmdHHz4wTCcxSh
         Mf4q5ixC/KNqc60LJywfq89IADk9xwLz8Ajt5Xq372B+tmH50toQqnQ5sqQMvTj4UYxi
         boqnHyDgBcSeRE4lXlaezocKXDZ8ASqJxF1Sb6hsjGSr0uzvYeNj04vpD6tVXfjHnLyE
         2kUhpi3Gsq441bveIW1AlCdTRAxNICDYJWHEil5qPmXjM+Js7330XdGWGWeKVLXR3J94
         b8FQ==
X-Gm-Message-State: AOAM531ge2pPIt+ufJCtbx8mwC970D8b1yF/9gmZSwO8FkQxuNa0YA18
        +/iUJAuzH2W6YE3FPPYavFBRRQ==
X-Google-Smtp-Source: ABdhPJy4sWKBDhVsVVTB4Rz+Di1yRjyZBmXNP884n02aTr/meZ8zL6S9UB8hgZlBhiOPmt1234c8iw==
X-Received: by 2002:aa7:970a:: with SMTP id a10mr10129338pfg.319.1595608473248;
        Fri, 24 Jul 2020 09:34:33 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id y6sm6486959pji.2.2020.07.24.09.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 09:34:32 -0700 (PDT)
Subject: Re: [PATCH v4 1/6] fs: introduce FMODE_ZONE_APPEND and
 IOCB_ZONE_APPEND
To:     Kanchan Joshi <joshi.k@samsung.com>, viro@zeniv.linux.org.uk,
        bcrl@kvack.org
Cc:     willy@infradead.org, hch@infradead.org, Damien.LeMoal@wdc.com,
        asml.silence@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org,
        io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, Selvakumar S <selvakuma.s1@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
References: <1595605762-17010-1-git-send-email-joshi.k@samsung.com>
 <CGME20200724155258epcas5p1a75b926950a18cd1e6c8e7a047e6c589@epcas5p1.samsung.com>
 <1595605762-17010-2-git-send-email-joshi.k@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <733bb8bb-cd4f-bee7-516d-359c565d11d3@kernel.dk>
Date:   Fri, 24 Jul 2020 10:34:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595605762-17010-2-git-send-email-joshi.k@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/24/20 9:49 AM, Kanchan Joshi wrote:
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 6c4ab4d..ef13df4 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -175,6 +175,9 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
>  /* File does not contribute to nr_files count */
>  #define FMODE_NOACCOUNT		((__force fmode_t)0x20000000)
>  
> +/* File can support zone-append */
> +#define FMODE_ZONE_APPEND	((__force fmode_t)0x40000000)

This conflicts with the async buffered read support in linux-next that
has been queued up for a long time.

> @@ -315,6 +318,7 @@ enum rw_hint {
>  #define IOCB_SYNC		(1 << 5)
>  #define IOCB_WRITE		(1 << 6)
>  #define IOCB_NOWAIT		(1 << 7)
> +#define IOCB_ZONE_APPEND	(1 << 8)

Ditto this one, and that also clashes with mainline. The next available
bit would be 10, IOCB_WAITQ and IOCB_NOIO are 8 and 9.


-- 
Jens Axboe

