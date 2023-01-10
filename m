Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABBD66368F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 02:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjAJBJu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 20:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjAJBJt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 20:09:49 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB8613CD2
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jan 2023 17:09:48 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id v23so10640797pju.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Jan 2023 17:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d6MijzBZB5rlx1R58nq0Sv7teK8nGEA82eTxDtWCKsE=;
        b=Bn4yejJ7fm69v3cYkvQR6/XZ0ITpifW6lvLuH+6LO/RNIKd6RVLus29e3eNTTUYgPb
         BhxS6AHI3lZE0WKKMqt0CS7vGXTLZB0fo63MFYyY8HBV68B62Y7LcdFA/1oUdIBP6AId
         MhbA8lbdcfi9yjrqtzdnjy3FvUsTOOuCY1/MLUI9KzzIJWFAQcXbcGZV/tkLNJeTVaDR
         GTlLW6X9HGj5gR68MlI+Ml1FDNcAgg83bb4DK4mQY8nMRJmQ5oVonvjIj1/ktoC9V5V3
         K/B+XasBfZgXYKxE20Y8HVpB5cLiNjShSwyzTYelpX2QgmUAsQI7PDJTl4cK1SRlpf/8
         k4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d6MijzBZB5rlx1R58nq0Sv7teK8nGEA82eTxDtWCKsE=;
        b=Hq8motyq96bPuXD0qbyacYmPFG7S3U1UlKw685BcXuISf8E8v61uEDOKz/vPMzFeyu
         ax1ISG1ho/xtpJo/y8n/MLPDfS3BRsunw9QSD6Drvd2n7/OHGYmzjvsqFZanHvsL4wzl
         DWMDBnBt+/Vk9LHfsNxaLsRECeBdVxT6+IFdvcN7ew+fr/SYP3q/6NVsLYUBqo427ADW
         AfvBDkSMP/3M4sJheKfaboib0xOPCxEnPotNloudgg9dHz9JrWKAIm1DTG/XI+DOUHyH
         sBjVrkd9uCvWboGi2CKs0AHX/yapl9iKQVCh9rf1L655HciMq1XVswO4/54QvI5Z1y61
         WwRA==
X-Gm-Message-State: AFqh2kpsVBL6uQcM1KrRHc45Nwwa+fKT5lFJuNR5Edpn5GTqSm/FqEML
        /Bztvx/HZE1VCAcso3/dlL4XMQ==
X-Google-Smtp-Source: AMrXdXt/eG8JeXT+AOt5cuhRRWuhgub2urGxlAeT04df4poSCCuXhbRnkGeiLsicq4wsrvmtXpkYkg==
X-Received: by 2002:a17:903:3311:b0:189:d0fa:230f with SMTP id jk17-20020a170903331100b00189d0fa230fmr17111254plb.4.1673312988310;
        Mon, 09 Jan 2023 17:09:48 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u18-20020a170903125200b00189adf6770fsm6733097plh.233.2023.01.09.17.09.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 17:09:47 -0800 (PST)
Message-ID: <e4a972f4-50fd-4c0e-1b44-dc702fd9c445@kernel.dk>
Date:   Mon, 9 Jan 2023 18:09:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [External] [LSF/MM/BPF BoF] Session for Zoned Storage 2023
Content-Language: en-US
To:     "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        lsf-pc@lists.linux-foundation.org
References: <F6BF25E2-FF26-48F2-8378-3CB36E362313@dubeyko.com>
 <Y7h0F0w06cNM89hO@bombadil.infradead.org>
 <4CC4F55E-17B3-47E2-A8C5-9098CCEB65D6@dubeyko.com>
 <CGME20230107015641eucas1p13c2b37b5ca7a5b64eb520b79316d5186@eucas1p1.samsung.com>
 <5DF10459-88F3-48DA-AEB2-5B436549A194@bytedance.com>
 <20230109153315.waqfokse4srv6xlz@mpHalley-2.localdomain>
 <AF3750AD-1B66-4F8A-936F-A14EC17DAC16@bytedance.com>
 <04cc803e-0246-bf8a-c083-f556a373ae4f@opensource.wdc.com>
 <ca30360e-ab51-6282-bd3c-208399e5a552@kernel.dk>
 <E2BA234A-D3D3-440B-BBDB-230B772B2D01@bytedance.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <E2BA234A-D3D3-440B-BBDB-230B772B2D01@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/9/23 4:20?PM, Viacheslav A.Dubeyko wrote:
> 
> 
>> On Jan 9, 2023, at 3:00 PM, Jens Axboe <axboe@kernel.dk> wrote:
>>
>>>> My point here that we could summarize:
>>>> (1) what features already implemented and supported,
>>>> (2) what features are under implementation and what is progress,
>>>> (3) what features need to be implemented yet.
>>>>
>>>> Have we implemented everything already? :)
>>>
>>> Standards are full of features that are not useful in a general purpose
>>> system. So we likely never will implement everything. We never did for
>>> SCSI and ATA and never will either.
>> Indeed, and that's a very important point. Some people read specs and
>> find things that aren't in the Linux driver (any spec, not a specific
>> one), and think they need to be added. No. We only add them if they make
>> sense, both in terms of use cases, but also as long as they can get
>> implemented cleanly. Parts of basically any spec is garbage and don't
>> necessarily fit within the given subsystem either.
>>
>> The above would make me worried about patches coming from anyone with
>> that mindset.
>>
> 
> OK. We already have discussion about garbage in spec. :)
> So, what would we like finally implement and what never makes sense to do?
> Should we identify really important stuff for implementation?

Well if you did have that discussion, then it seemed you got nothing
from it. Because asking that kind of question is EXACTLY what I'm saying
is the opposite of what should be done. If there's a demand for a
feature, then it can be looked at and ultimately implemented if it makes
sense. You're still talking about proactively finding features and
implementing them "just in case they are needed", which is very much the
opposite and wrong approach, and how any kind of software ends up being
bloated, slow, and buggy/useless.

-- 
Jens Axboe

