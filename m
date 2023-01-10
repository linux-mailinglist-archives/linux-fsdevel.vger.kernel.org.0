Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AF96636E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 02:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbjAJBuR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 20:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237234AbjAJBuO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 20:50:14 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E17E020
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jan 2023 17:50:13 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id jn22so11585723plb.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Jan 2023 17:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tyv8+Pn1vu+82OVxcvG0igzn00GRq+MSjEWLLPkF+Rc=;
        b=oePbeJxm1AQPwaQkd0+KXPEzdtKfJltivnIPrVBVLrBVySJRjSRl69dW2crsZpCWpX
         OnnYTRjkQNZmkrnUs0L0bkNEQECHalfcMhFtUJK8SZmLhVolZva0ltT5hE3RTD5OT1VD
         oIQaEsHySRTGzw+5sF8dxLxTkv7YEMKJ+rHiZ9icSUD9JeGxNQYpD0YmnbsmBqmld23K
         qtB32ZAfmQboEffk3fpzD3fP1wQR7d1HavQ0yvPb3M0DpaHT05L+Pn/Tv9F1xkaFP7AS
         2t63JYfB09V/1KVxLoiqIAbXXlMzW6D1ffKm/yCsaNOT37tuQCN3NoYeUMvsDNVB6PIj
         b80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tyv8+Pn1vu+82OVxcvG0igzn00GRq+MSjEWLLPkF+Rc=;
        b=s9+4osCxMk8dLSF0UP0NxkRO5py8lu8zq5algKzMmj9QsUDU1psrFwaEFF8dcZUYBs
         s0dBENrl/MJRUng3YNjWSm+VVYRY6biq1w7jEMNIfp9Qlh0ws4y2HLQq9S1XfVKrt0k+
         1IzaZt0EVkTinygItceRx1SoaosD8KaqzrltCKdWMCuuxBkTzRSsfkZ0WfKudy5u1c2l
         BucxEHLqkOJuHim8v8aDoxRcXRpd7bqoHvUSbHwXiS6EZrQJ4YRNtnFdU9TxfvC3iL/r
         uCEoHqdwUdBL04aR7lC4PiFYKIDQ8xxGcUHfubrYt7iQIevh4Iv1i3YcfhGTC8MU1wbl
         2wnQ==
X-Gm-Message-State: AFqh2kpN2I4w6LRKbIXwH6KkL0kjFqe/jDCs8Jmt1xG+s+K23szkFUd+
        BCn/72J6RxutoR3a7pP/gnrMMg==
X-Google-Smtp-Source: AMrXdXskv6xre3HkiaS5sbvlcrD7p5Htk+8l2cuuNZuAHeNuTH+c9ZncC1iuBsvBdASsA6nVMssE3Q==
X-Received: by 2002:a05:6a21:e30e:b0:b5:f6de:e28c with SMTP id cb14-20020a056a21e30e00b000b5f6dee28cmr822877pzc.6.1673315412696;
        Mon, 09 Jan 2023 17:50:12 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j17-20020a635511000000b00478b930f970sm5645276pgb.66.2023.01.09.17.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 17:50:11 -0800 (PST)
Message-ID: <007cb2a5-f9c0-a75e-9e4c-198e0ae11d05@kernel.dk>
Date:   Mon, 9 Jan 2023 18:50:10 -0700
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
 <e4a972f4-50fd-4c0e-1b44-dc702fd9c445@kernel.dk>
 <B512D508-4460-44B8-9067-84F78BA43E0E@bytedance.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <B512D508-4460-44B8-9067-84F78BA43E0E@bytedance.com>
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

On 1/9/23 6:39?PM, Viacheslav A.Dubeyko wrote:
> 
> 
>> On Jan 9, 2023, at 5:09 PM, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 1/9/23 4:20?PM, Viacheslav A.Dubeyko wrote:
>>>
>>>
>>>> On Jan 9, 2023, at 3:00 PM, Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>>>> My point here that we could summarize:
>>>>>> (1) what features already implemented and supported,
>>>>>> (2) what features are under implementation and what is progress,
>>>>>> (3) what features need to be implemented yet.
>>>>>>
>>>>>> Have we implemented everything already? :)
>>>>>
>>>>> Standards are full of features that are not useful in a general purpose
>>>>> system. So we likely never will implement everything. We never did for
>>>>> SCSI and ATA and never will either.
>>>> Indeed, and that's a very important point. Some people read specs and
>>>> find things that aren't in the Linux driver (any spec, not a specific
>>>> one), and think they need to be added. No. We only add them if they make
>>>> sense, both in terms of use cases, but also as long as they can get
>>>> implemented cleanly. Parts of basically any spec is garbage and don't
>>>> necessarily fit within the given subsystem either.
>>>>
>>>> The above would make me worried about patches coming from anyone with
>>>> that mindset.
>>>>
>>>
>>> OK. We already have discussion about garbage in spec. :)
>>> So, what would we like finally implement and what never makes sense to do?
>>> Should we identify really important stuff for implementation?
>>
>> Well if you did have that discussion, then it seemed you got nothing
>> from it. Because asking that kind of question is EXACTLY what I'm saying
>> is the opposite of what should be done. If there's a demand for a
>> feature, then it can be looked at and ultimately implemented if it makes
>> sense. You're still talking about proactively finding features and
>> implementing them "just in case they are needed", which is very much the
>> opposite and wrong approach, and how any kind of software ends up being
>> bloated, slow, and buggy/useless.
>>
> 
> I simply tried to suggest some space for this discussion and nothing
> more. If all important features have been implemented already and
> nobody would like to discuss new feature(s), then we can simply
> exclude this topic from the list.

If something is missing and there's a bof/session, then someone will
bring it up. Fishing for things to implement is not a good idea.

-- 
Jens Axboe

