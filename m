Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77BB2A135C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Oct 2020 04:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgJaDkL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 23:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgJaDkL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 23:40:11 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BBCC0613D7
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2020 20:40:11 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u7so1876990pls.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2020 20:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9sLYZttYSBtUq0cUE26BQUvUmDdnFfSX5F3EGLpVeHI=;
        b=Vb9aJfaxCkWdqxgNMRM99nztY7QSpYLScuaXEBOzhT6Wj69pJya8MrwTeR4Ln1zQk2
         KdaksKI336VoSrRG8nkucwS8tpz46PQ+MwlhssJi6CreaFT77MC182G6r2o663mSqglA
         fAowCJgHgcf3BwusFbAN9icWZszwQUjMB8wKrNhrYLm7FT2wIlpmldtej54uGap+ObBg
         Rv/mNPuvp62uqhh6CP3dJSUtt4YNK8803GgpEogODJMl3yRfAEQTw3TT76djKi1TRaEb
         7EOTBQjTxe5/rrBkkPdGQXAZ4NWOtRKZ8v4jrpYO6Tk4BC9NrywCdqz+q7R0A1mbIOwn
         MUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9sLYZttYSBtUq0cUE26BQUvUmDdnFfSX5F3EGLpVeHI=;
        b=DnVcgPIJijJUMdyrAUW6MowHO3Vd9ubvNRqY89gIpLsP7XblAJGIj+YYu0xi3byvcS
         nxZYUjWYCDi9W4LGD21ibRcEPE8NoNH5PTXr97e87IigvudrElFV88/pxAEIzCcCDWax
         uWKLySx8E77c1LHbT17T4dnr1/SlVWMEm1afBkZJNcqGXIhdHCehQ4cdVI3a2lAFx2y0
         ib3cZUMuZIZBEvlZiWuQ3m7m1vW28AEW2veuNszfRdxOs2pnVACcadrb6Qa2GxR0yYfE
         OW3tof1F5eamuh+KuO+m4XbpZMT7zbMMfoXazi68Gw3noZeFD8xpLbJp9wXMSsC895QF
         86fQ==
X-Gm-Message-State: AOAM530aAKv2L2FLEqMLRjUvDzrFOizOKphjevJVUKW57tCGkEMOP9dW
        6aqvCQFkfMeuy564UDuVbeF/wA==
X-Google-Smtp-Source: ABdhPJzhXFWImduSrC3p9w9T2ccj1dZUS2GmpxNoLWNF2CY7hy3HGvVsm8jH+O8R3Pum+E9poL3fNA==
X-Received: by 2002:a17:902:d34a:b029:d3:dcb5:a84c with SMTP id l10-20020a170902d34ab02900d3dcb5a84cmr11375124plk.81.1604115610545;
        Fri, 30 Oct 2020 20:40:10 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id d18sm6450097pgg.41.2020.10.30.20.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 20:40:09 -0700 (PDT)
Subject: Re: [PATCH v9 01/41] block: add bio_add_zone_append_page
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1604065156.git.naohiro.aota@wdc.com>
 <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a7ff7661-0a1d-a528-9b92-7b58b7c11e6b@kernel.dk>
Date:   Fri, 30 Oct 2020 21:40:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 7:51 AM, Naohiro Aota wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Add bio_add_zone_append_page(), a wrapper around bio_add_hw_page() which
> is intended to be used by file systems that directly add pages to a bio
> instead of using bio_iov_iter_get_pages().

Not sure what this is for, since I'm only on one patch in the series...

> +/**
> + * bio_add_zone_append_page - attempt to add page to zone-append bio
> + * @bio: destination bio
> + * @page: page to add
> + * @len: vec entry length
> + * @offset: vec entry offset
> + *
> + * Attempt to add a page to the bio_vec maplist of a bio that will be submitted
> + * for a zone-append request. This can fail for a number of reasons, such as the
> + * bio being full or the target block device is not a zoned block device or
> + * other limitations of the target block device. The target block device must
> + * allow bio's up to PAGE_SIZE, so it is always possible to add a single page
> + * to an empty bio.
> + */

This should include a

Return value:

section, explaining how it returns number of bytes added (and why 0 is thus
a failure case).

> +int bio_add_zone_append_page(struct bio *bio, struct page *page,
> +			     unsigned int len, unsigned int offset)

Should this return unsigned int? If not, how would it work if someone
asked for INT_MAX + 4k.

-- 
Jens Axboe

