Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F644D5CC0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 08:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244902AbiCKHyY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 02:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbiCKHyX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:54:23 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA9EB54EC
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 23:53:20 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id r187-20020a1c2bc4000000b003810e6b192aso4850466wmr.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 23:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xwb70iZvFY3Ug69wBXrwkmTUB5j/QKwDZ/9LSmzVgoE=;
        b=hlivmh7hpdycrkE58yN/AKpN3BjGkgS14lhr/ZALDbCf3CHYm+LsaCW4TsOKhVU9fH
         HoSoWoXsaTDi34bCZVHib4WZ8R5tDpCTgd/milsDKvmXI11ndzsnzTKVfXEUaqmI0iOV
         sMabHJkfpBrKPDNakDSoMOsY5JLdb9UMv2YWR4usVTNOlUk+HW8P8ZvjyZpCFDm880Ew
         1qAjaWym74AqgyniqM1Dv1uQQaNUrCJTZ4pdnVwUduNlFz66yDr6vWOMfP9CQdw7HRSI
         lgD64tVAsh7i2ssmgUEKU8ymxxWcpUQsO/5MJM60ezc08cBzHNLPXdoICP+aKwuSxa4G
         AoUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xwb70iZvFY3Ug69wBXrwkmTUB5j/QKwDZ/9LSmzVgoE=;
        b=wsHeDNAC78f4eIiMB+/zynIUYiPqdh/bGOCra6DCQ6TniSrhTjkN0c/5qQ4F6eiHCl
         mZB7PkMRKGmTcDuC/EshnlNvCo0RpyQxW2qL4W00Jure16Tk7HpibpldZeCub01tUo7w
         Nu2W3ktxkhWBlmn7S4Mp46rLFVGX7lgiWBtLbz4UEmZ+Zhjd0L8iAkKRF1hrrjGSJs51
         OTdIhqlWuE63CuQFqkDJGcmXCHOPzc3bD8r6AvxdyAR5cAke5E3/YN/212ACL4+lp7rs
         Ksk/i0rb2tWrMbCkwoWWYXWgGTLYKPTpLp/paA9yr5muAg5sE+BHgb5Zd3+avYm/lFo5
         TjQg==
X-Gm-Message-State: AOAM532u+1XDsWe5TfSrQfK90nZlCcNewJFj4Vb9EMdq5AH3HUxwG3By
        nqF8N8MJTk4zFM5YQcUkh576IQ==
X-Google-Smtp-Source: ABdhPJy/MRgCRkxNvQp+v2QGs4GsetEVTW4/ulUZAQQ1nVD5qskJ9yUZmwvUd1FbdLzu4s1hs1KL/g==
X-Received: by 2002:a05:600c:3c8b:b0:37f:1546:40c9 with SMTP id bg11-20020a05600c3c8b00b0037f154640c9mr6350055wmb.161.1646985199202;
        Thu, 10 Mar 2022 23:53:19 -0800 (PST)
Received: from localhost (5.186.121.195.cgn.fibianet.dk. [5.186.121.195])
        by smtp.gmail.com with ESMTPSA id e10-20020a056000178a00b0020393321552sm1892851wrg.85.2022.03.10.23.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 23:53:18 -0800 (PST)
Date:   Fri, 11 Mar 2022 08:53:17 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <matias.bjorling@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <keith.busch@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Message-ID: <20220311075317.fjn3mj25dpicnpgi@ArmHalley.local>
References: <69932637edee8e6d31bafa5fd39e19a9790dd4ab.camel@HansenPartnership.com>
 <DD05D9B0-195F-49EF-80DA-1AA0E4FA281F@javigon.com>
 <20220307151556.GB3260574@dhcp-10-100-145-180.wdc.com>
 <8f8255c3-5fa8-310b-9925-1e4e8b105547@opensource.wdc.com>
 <20220311072101.k52rkmsnecolsoel@ArmHalley.localdomain>
 <61c1b49c-cd34-614a-876a-29b796e4ff0d@opensource.wdc.com>
 <Yir9a8HusXWApk5l@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <Yir9a8HusXWApk5l@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10.03.2022 23:42, Christoph Hellwig wrote:
>On Fri, Mar 11, 2022 at 04:39:12PM +0900, Damien Le Moal wrote:
>> > (we need to look into it). F2FS will use the emulation layer for now;
>> > only !PO2 devices will pay the price. We will add a knob in the block
>> > layer so that F2FS can force enable the emulation.
>>
>> No. The FS has no business changing the device.

Ok. Then it can be something the user can set.

>
>And nvme will not support any kind of emulation if that wasn't clear.

How do you propose we meed the request from Damien to support _all_
existing users if we remove the PO2 constraint from the block layer?

The emulation is not the goal, but it seems to be a requirement

