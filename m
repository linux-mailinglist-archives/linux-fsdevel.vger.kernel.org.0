Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5607419D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 22:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjF1Up4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 16:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjF1Upy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:45:54 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678961FEF
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 13:45:53 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-656bc570a05so39153b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 13:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687985153; x=1690577153;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ciE7wPwGlLP5hh+CkZMsNJNeE41TUQznpNx6pNMaRRI=;
        b=E1ETyBIgQsGQgasljZx9V29BYsEXMwpSWRjjIQXeh+TalfY4vVLpFNoLg6c3WWUtTZ
         M2kitqzDzK45TCpowZ+9lO56+k7pU5hJApEzZzpzcmIWjCHjIgxl5rGnQBYDLlLwsaPE
         aI3nqoAk2L9MbjxW0dsiqVDu7v3EFW/hRjUXPa6raIhcPsuqNR7hAWM7HMrSLZ2mGncG
         fzoJdURHwgB68706aWlsoJDgVIuqWHY6neyf+jaL8T7M1fdaAfFYaZB5OMgn0AUtjEcT
         CGQ0L+SW1HeMWmijcXBkPbUtbdGjCrN4jxmfNY9zKVa8HG6UVBBk4Bovbc1YcXdnDCjP
         aDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687985153; x=1690577153;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ciE7wPwGlLP5hh+CkZMsNJNeE41TUQznpNx6pNMaRRI=;
        b=auGPWxOIvvOgMWN1DFTRCxN9oIG6NJh6mDZntYeqkTaX3dOmWhhdmMyD+Lkg8+8Q3+
         /J2y1wbfSWHz1vY2L4Xv0UUdlzjgnbMDK0H8VJjNrCC9mEyqKHbie57H1SQqBg8byBPJ
         YiXeQwLeQ5cRf/XvloKgYe/Kh/qaulcgKB8YmWaDi2K4r0bhLMTrt+UC3ZCc2v/8rhnz
         xp5dTUnrRd0hD3r0+lbppxMM3pmkm47Q8wLr57QhVYdATZOW22idACkMI3KEXu4C50R/
         lFgZfDpYZtuagigfhe7y0ZndQm/SHxxYQY4fznpnekQ2Ls16MvvoDG3MfTvZlkDHczWX
         imqA==
X-Gm-Message-State: AC+VfDza7ayvVt2paab+7t9VfMc5scn/X+Intb6jbj7TelqU3KVX/eco
        x7H+P3I3VZIi8FGCaXo0m6hCGA==
X-Google-Smtp-Source: ACHHUZ4zwfZP2vsUiZhQHuwV2D8ZtQX+vlXo+Oj1VMMNxaq6QHHTrapOwQMa8suOS6gRG90Hy1EAJw==
X-Received: by 2002:a05:6a00:4091:b0:67f:8ef5:2643 with SMTP id bw17-20020a056a00409100b0067f8ef52643mr5194179pfb.2.1687985152898;
        Wed, 28 Jun 2023 13:45:52 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id f19-20020aa782d3000000b0062dba4e4706sm7332690pfn.191.2023.06.28.13.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 13:45:52 -0700 (PDT)
Message-ID: <18a38d3e-0b23-ba92-199a-e63c44b18da9@kernel.dk>
Date:   Wed, 28 Jun 2023 14:45:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [GIT PULL] bcachefs
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20230627000635.43azxbkd2uf3tu6b@moria.home.lan>
 <91e9064b-84e3-1712-0395-b017c7c4a964@kernel.dk>
 <20230627020525.2vqnt2pxhtgiddyv@moria.home.lan>
 <b92ea170-d531-00f3-ca7a-613c05dcbf5f@kernel.dk>
 <23922545-917a-06bd-ec92-ff6aa66118e2@kernel.dk>
 <20230627201524.ool73bps2lre2tsz@moria.home.lan>
 <c06a9e0b-8f3e-4e47-53d0-b4854a98cc44@kernel.dk>
 <20230628040114.oz46icbsjpa4egpp@moria.home.lan>
 <b02657af-5bbb-b46b-cea0-ee89f385f3c1@kernel.dk>
 <03308df9-7a6f-4e55-40c8-6f57c5b67fe6@kernel.dk>
 <20230628175608.hap54mrx54owdkyg@moria.home.lan>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230628175608.hap54mrx54owdkyg@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/28/23 11:56?AM, Kent Overstreet wrote:
> On Wed, Jun 28, 2023 at 09:22:15AM -0600, Jens Axboe wrote:
>> On 6/28/23 8:58?AM, Jens Axboe wrote:
>>> I should have something later today, don't feel like I fully understand
>>> all of it just yet.
>>
>> Might indeed be delayed_fput, just the flush is a bit broken in that it
>> races with the worker doing the flush. In any case, with testing that, I
>> hit this before I got an umount failure on loop 6 of generic/388:
>>
>> fsck from util-linux 2.38.1
>> recovering from clean shutdown, journal seq 14642
>> journal read done, replaying entries 14642-14642
>> checking allocations
>> starting journal replay, 0 keys
>> checking need_discard and freespace btrees
>> checking lrus
>> checking backpointers to alloc keys
>> checking backpointers to extents
>> backpointer for missing extent
>>   u64s 9 type backpointer 0:7950303232:0 len 0 ver 0: bucket=0:15164:0 btree=extents l=0 offset=0:0 len=88 pos=1342182431:5745:U32_MAX, not fixing
> 
> Known bug, but it's gotten difficult to reproduce - if generic/388 ends
> up being a better reproducer for this that'll be nice

Seems to reproduce in anywhere from 1..4 iterations for me.

-- 
Jens Axboe

