Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A374CB707
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 07:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiCCGas (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 01:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiCCGan (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 01:30:43 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E31169203
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Mar 2022 22:29:53 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id w4so2729030edc.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Mar 2022 22:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=t+LdfiGc6xI1mxdllyfF2ZD3X/NRnVLnjV3jDQq86Bk=;
        b=MWwHgRM1qcypVtr9iaHn+QejxGQMYgqgvOKQmg2InAE6qwP+yugvlWIoPZRU6/mYm8
         3DZGBjFZnECQvcZX0ZX9bwwT65gpSlVdQJW7c0C0usnt24CMuYsEjYQyoVasGwpg42OM
         v7U1aDSizg/M4J4w1TjlZnVevbMxPP8ReSw0Nm4O/eJ5Cnsg87PqHFh8pfdO3mel9gAw
         S6Kx3a2FFNFzEr/i4KCz3OQeNYveUeqyzn1dsgFD8nIuRp365LGHGj273OrYAvAmksNW
         YEJzOXY0otI6YCnGIvJ/Holj4f+17CSg2STx0ehi45fu625+VfHQTt3aefnp9OxFLMya
         t1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=t+LdfiGc6xI1mxdllyfF2ZD3X/NRnVLnjV3jDQq86Bk=;
        b=s1L2HDBm4FM2t7m/lcWQpWh+ZZsndnq5hZhZuCvYhKi5F0fi96VHX+6EBKfGowH2AG
         pi3/ptkz4GgGB1R76HrucOfQquUyLxdKp675Ay/jcRm4BU3AXOhKylKo2luSV7BtVqET
         fPyPj9yH4hPAx91g5Y34sv8y3HQSLm/C5VXP9IQ7TnoBVtfJLE5apelPsQKgFYM+ib7n
         0dlr4dr7y6luLdJ6lCxDuCUsJ2jOP+2n+zQ9EyCj20uXhylcmduDMHcTq+gZKW/f4izE
         q1t0q1Orz4azgHadrl1tzfESCRT3vbZPT8BORcQF1juC04G++j7E1orFCYauviEmMopw
         4SNQ==
X-Gm-Message-State: AOAM532ACctbNEKpIH2S/tJshe1LkJ4/hCIgMEIQLxegTpp0uxqp6hPq
        Ra9EyM95VqiybmFkTfarkqc2VA==
X-Google-Smtp-Source: ABdhPJy9Lfxb8IR7ZsYIVTkW0AlK9XZsF31uQVMa5xHfCfSXBtQ6lYJ+joBWcOkT15MtSCevGD4hNQ==
X-Received: by 2002:a05:6402:1cc1:b0:413:2cfb:b6ca with SMTP id ds1-20020a0564021cc100b004132cfbb6camr32897825edb.265.1646288992145;
        Wed, 02 Mar 2022 22:29:52 -0800 (PST)
Received: from localhost (5.186.121.195.cgn.fibianet.dk. [5.186.121.195])
        by smtp.gmail.com with ESMTPSA id gj18-20020a170907741200b006da82539c83sm364669ejc.73.2022.03.02.22.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 22:29:51 -0800 (PST)
From:   "Javier =?utf-8?B?R29uesOhbGV6?=" <javier@javigon.com>
X-Google-Original-From: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
Date:   Thu, 3 Mar 2022 07:29:50 +0100
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
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
Message-ID: <20220303062950.srhm5bn3mcjlwbca@ArmHalley.localdomain>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
 <B3F227F7-4BF0-4735-9D0F-786B68871963@javigon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B3F227F7-4BF0-4735-9D0F-786B68871963@javigon.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03.03.2022 06:32, Javier González wrote:
>
>> On 3 Mar 2022, at 04.24, Luis Chamberlain <mcgrof@kernel.org> wrote:
>>
>> ﻿Thinking proactively about LSFMM, regarding just Zone storage..
>>
>> I'd like to propose a BoF for Zoned Storage. The point of it is
>> to address the existing point points we have and take advantage of
>> having folks in the room we can likely settle on things faster which
>> otherwise would take years.
>>
>> I'll throw at least one topic out:
>>
>>  * Raw access for zone append for microbenchmarks:
>>      - are we really happy with the status quo?
>>    - if not what outlets do we have?
>>
>> I think the nvme passthrogh stuff deserves it's own shared
>> discussion though and should not make it part of the BoF.
>>
>>  Luis
>
>Thanks for proposing this, Luis.
>
>I’d like to join this discussion too.
>
>Thanks,
>Javier

Let me expand a bit on this. There is one topic that I would like to
cover in this session:

   - PO2 zone sizes
       In the past weeks we have been talking to Damien and Matias around
       the constraint that we currently have for PO2 zone sizes. While
       this has not been an issue for SMR HDDs, the gap that ZNS
       introduces between zone capacity and zone size causes holes in the
       address space. This unmapped LBA space has been the topic of
       discussion with several ZNS adopters.

       One of the things to note here is that even if the zone size is a
       PO2, the zone capacity is typically not. This means that even when
       we can use shifts to move around zones, the actual data placement
       algorithms need to deal with arbitrary sizes. So at the end of the
       day applications that use a contiguous address space - like in a
       conventional block device -, will have to deal with this.

       Since chunk_sectors is no longer required to be a PO2, we have
       started the work in removing this constraint. We are working in 2
       phases:

         1. Add an emulation layer in NVMe driver to simulate PO2 devices
	when the HW presents a zone_capacity = zone_size. This is a
	product of one of Damien's early concerns about supporting
	existing applications and FSs that work under the PO2
	assumption. We will post these patches in the next few days.

         2. Remove the PO2 constraint from the block layer and add
	support for arbitrary zone support in btrfs. This will allow the
	raw block device to be present for arbitrary zone sizes (and
	capacities) and btrfs will be able to use it natively.

	For completeness, F2FS works natively in PO2 zone sizes, so we
	will not do work here for now, as the changes will not bring any
	benefit. For F2FS, the emulation layer will help use devices
	that do not have PO2 zone sizes.

      We are working towards having at least a RFC of (2) before LSF/MM.
      Since this is a topic that involves several parties across the
      stack, I believe that a F2F conversation will help laying the path
      forward.

Thanks,
Javier

