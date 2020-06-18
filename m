Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF37E1FEDAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 10:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgFRIcE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 04:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbgFRIcC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 04:32:02 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D425EC0613ED
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 01:32:01 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t13so2660205wrs.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 01:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mBaOTic59RjsjLgo2G8JEZ2HjlmP5tRj9DOckjIFG3U=;
        b=VeZchB1Zk+81qlHhjvzg9LHD2TBm3ByGBy0IW8ORikdh0NwKJNt9P+kqDslvMSk8SW
         nw6/o4F3Qx8D4bVOI2IfZ8m1HhI57HG0Hg2hsWb4vVk65rZ6pzUgW4hpY/6HTTXzKFdC
         NMqgGuUBaGfuv0iTTGMcyXJYvYBSsw79YzG0M47LU23y2Akz4LEVPk1bFN9SVP9Ah+Qq
         xv5s2DSDOEC1vdjyoTIdHq3HLLEG6tnDZdPLqGpNCtH1KfYSZsnsmu65lt61g5qsxtk9
         tNk90RsdiXSIUxAFNTAEUhx/jhs/r0f5LxK0bU6VAb6V8yPKshxlErMCndviPPQOs6c+
         LH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mBaOTic59RjsjLgo2G8JEZ2HjlmP5tRj9DOckjIFG3U=;
        b=J1lxHDPoViY8c6GDJYB1BpvLUiHib8AcYvP28NkHemUkQ3m7tvm2w68wNaMngfJ2Km
         c04legANO4e2SIKvzPr3FVpb44Ua0uNE+ILUy5glSE5omO4RsBqtRMd/Cx0uReCZhXu8
         +MHZJf1nPbsXMw+DDo9NC/YGQ8FE+0Icvh2QQlaEg/YETe+MCSXFSnrCtb4h1lTcwh5O
         CJjB9yadVqgPKCAKrGlxWq2WRbG+RaJlNxFKcu/7aYlNV7Fccal0+gI53SEWnCxe3Hrj
         XN7uD49ISPwHo6vp0FQ/2wu4kHKQAWpVNiVDHo15Oh4OSInCc6xVsZkPzReSTKDQ9HwB
         tz2Q==
X-Gm-Message-State: AOAM531TWHjnnbLwK92Ed75zwyrLUNrbhoacBtbpZ3Ung0f+ML4KEB/7
        +cR9WtwqEvW9Wxb/9Oam52N24Q==
X-Google-Smtp-Source: ABdhPJxf+HN7+JKdkPYOEHori7/i1a/eK+R6a+pu586zPO/RkLdukssOlIov8whQrf/rt2dWqJEzYw==
X-Received: by 2002:adf:a306:: with SMTP id c6mr3397910wrb.122.1592469120621;
        Thu, 18 Jun 2020 01:32:00 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id t14sm2653507wrb.94.2020.06.18.01.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 01:32:00 -0700 (PDT)
Subject: Re: [PATCH 0/3] zone-append support in aio and io-uring
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc:     Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, bcrl@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aio@kvack.org, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, selvakuma.s1@samsung.com,
        nj.shetty@samsung.com, Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <keith.busch@wdc.com>,
        Christoph Hellwig <hch@lst.de>
References: <CGME20200617172653epcas5p488de50090415eb802e62acc0e23d8812@epcas5p4.samsung.com>
 <1592414619-5646-1-git-send-email-joshi.k@samsung.com>
 <f503c488-fa00-4fe2-1ceb-7093ea429e45@lightnvm.io>
 <20200618082740.i4sfoi54aed6sxnk@mpHalley.local>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <f9b820af-2b23-7bb4-f651-e6e1b3002ebf@lightnvm.io>
Date:   Thu, 18 Jun 2020 10:32:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200618082740.i4sfoi54aed6sxnk@mpHalley.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 18/06/2020 10.27, Javier González wrote:
> On 18.06.2020 10:04, Matias Bjørling wrote:
>> On 17/06/2020 19.23, Kanchan Joshi wrote:
>>> This patchset enables issuing zone-append using aio and io-uring 
>>> direct-io interface.
>>>
>>> For aio, this introduces opcode IOCB_CMD_ZONE_APPEND. Application 
>>> uses start LBA
>>> of the zone to issue append. On completion 'res2' field is used to 
>>> return
>>> zone-relative offset.
>>>
>>> For io-uring, this introduces three opcodes: 
>>> IORING_OP_ZONE_APPEND/APPENDV/APPENDV_FIXED.
>>> Since io_uring does not have aio-like res2, cqe->flags are 
>>> repurposed to return zone-relative offset
>>
>> Please provide a pointers to applications that are updated and ready 
>> to take advantage of zone append.
>
> Good point. We are posting a RFC with fio support for append. We wanted
> to start the conversation here before.
>
> We can post a fork for improve the reviews in V2.

Christoph's response points that it is not exactly clear how this 
matches with the POSIX API.

fio support is great - but I was thinking along the lines of 
applications that not only benchmark performance. fio should be part of 
the supported applications, but should not be the sole reason the API is 
added.


