Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157AB4D5C2A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 08:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239912AbiCKHWJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 02:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240482AbiCKHWI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:22:08 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6F71B50D0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 23:21:04 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id y8so4742184edl.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Mar 2022 23:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xxhp4yvv1NYzlCG2nbenZ7fmxUPYEax/VW2j48oKhC4=;
        b=8IjNkbIJLzJBdeigItXIpSw3vBzZtd1ZOkzljugpGxEwuMHdpd+Ysy74U1aLyQdI3g
         7V1EapqpfmpyCpIgl+sfQMq3bBTcD86xlQhm0EGCMQQxGyBf0jgxAfDXOPJFb55nhkAF
         3spxDGmpmA9jY7tO6S0kS/jqHm9jM5rYQ3S02jqYrGNCvsdVdFQRbirUAj5TZ8/VYYQu
         4d6UvMBV5FDT06hc++VoJu83Fsp4XvVjNoHwXz4ZgBSloVVL1rp2UGKq7IcnOC1A/WDi
         hhdJSBH23df2NN4kN8Bgcq1FwTGGM7ALBTFQ0uMxUr4rAsAhLk/sofBbm2lOSZWo6/DM
         Yk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xxhp4yvv1NYzlCG2nbenZ7fmxUPYEax/VW2j48oKhC4=;
        b=y6qg2KRcJGZHScItex5WAVmaIeHU5lX7vtQspXU2crkipffqr/3GpOUVXWQqxodl4X
         jlJgrUmPvuY8rxtZ8NbHJoXE8TlZLA+RhTMEBWzgiHJ97qfnRf9uF1Btjj1k+yRRcfGU
         t+I+tEd4ATpIjnC8R/MqN6ujTIhYfRRf6q13PHoZYt9Diyjp/D/vUMBGa8vg6O2ayqp8
         GaY1+YoAfQVNWaeoKamI0KEgfdJkNA1IUpQmSxq2nTe54Yyq42+vi45IQ+eJPIPC9a+q
         Bjh8C28i/WOTAAOSjja2ueIckPl9DB3F8zOmTRhH0vl3GW250AQw91MbrPbH6/CSaZBx
         2SGQ==
X-Gm-Message-State: AOAM533SHF6D+2gm4I2CKsUygoxhwU4MoMQdY7vPrlBeleS3Es6KDhra
        tx07XLOemDUHLupYgRFkdaziwQ==
X-Google-Smtp-Source: ABdhPJyGfjZPO2Bs08SMjAxkpX+enCVOynhPWP7u3bGPt8Wxuo6KO1AsMGR6G6fZSrxLdaI0G+VNfA==
X-Received: by 2002:a05:6402:5179:b0:415:d7f3:c270 with SMTP id d25-20020a056402517900b00415d7f3c270mr7555835ede.259.1646983263289;
        Thu, 10 Mar 2022 23:21:03 -0800 (PST)
Received: from localhost (5.186.121.195.cgn.fibianet.dk. [5.186.121.195])
        by smtp.gmail.com with ESMTPSA id c17-20020a05640227d100b00416bbe8ca69sm1432354ede.89.2022.03.10.23.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 23:21:02 -0800 (PST)
Date:   Fri, 11 Mar 2022 08:21:01 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Keith Busch <kbusch@kernel.org>,
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
Message-ID: <20220311072101.k52rkmsnecolsoel@ArmHalley.localdomain>
References: <69932637edee8e6d31bafa5fd39e19a9790dd4ab.camel@HansenPartnership.com>
 <DD05D9B0-195F-49EF-80DA-1AA0E4FA281F@javigon.com>
 <20220307151556.GB3260574@dhcp-10-100-145-180.wdc.com>
 <8f8255c3-5fa8-310b-9925-1e4e8b105547@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f8255c3-5fa8-310b-9925-1e4e8b105547@opensource.wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08.03.2022 05:42, Damien Le Moal wrote:
>On 3/8/22 00:15, Keith Busch wrote:
>> On Mon, Mar 07, 2022 at 03:35:12PM +0100, Javier González wrote:
>>> As I mentioned in the last reply to to Dave, the main concern for me
>>> at the moment is supporting arbitrary zone sizes in the kernel. If we
>>> can agree on a path towards that, we can definitely commit to focus on
>>> ZoneFS and implement support for it on the different places we
>>> maintain in user-space.
>>
>> FWIW, the block layer doesn't require pow2 chunk_sectors anymore, so it
>> looks like that requirement for zone sizes can be relaxed, too.
>
>As long as:
>1) Userspace does not break (really not sure about that one...)
>2) No performance regression: the overhead of using multiplications &
>divisions for sector to zone conversions must be acceptable for ZNS (it
>will not matter for SMR HDDs)

Good. The emulation patches we sent should cover this.

>All in kernel users of zoned devices will need some patching (zonefs,
>btrfs, f2fs). Some will not work anymore (e.g. f2fs) and others will
>need different constraints (btrfs needs 64K aligned zones). Not all
>zoned devices will be usable anymore, and I am not sure if this
>degradation in the support provided is acceptable.

We will do the work for btrfs (already have a prototype) and for zonefs
(we need to look into it). F2FS will use the emulation layer for now;
only !PO2 devices will pay the price. We will add a knob in the block
layer so that F2FS can force enable the emulation.
