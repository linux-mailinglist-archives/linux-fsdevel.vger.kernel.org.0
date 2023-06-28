Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C57174146A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 17:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjF1O7P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 10:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjF1O7F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:59:05 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C24619B4
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 07:59:02 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-7748ca56133so54075539f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 07:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687964341; x=1690556341;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+DBcZOcowzmfypUkfb1rmBpcpS3jwC4LRlJcZCk1X2M=;
        b=sxwm/rAfdjYBd1iR+fy9XkSNZ0bxUbOwYBOhbW3qdF1Bkjc4FSY5TKAJbLItoBMPzv
         YyNC2p46Kua+0sM4NJkqjaj+aXTii6hZGauw2EGZnH2M+ZNxWiDJcVBL1MYgn0F05qkL
         K6S80OL9NoVFDkucuRXBgPP7NJFnd3uUoLY2pIOET7vLOSjaqlWBadSszbwNf2f/9tFS
         msZx67Lf6QVINHzUOw3nyRjwid4rzUIeuZ9efVVHlfc6PP9y10kjDctwHVjhvmrs3I3z
         bEzmXnf2cYaBp7VVWMfaXkyg0Px1BpAL9emH80eDpcjSk/CnuRLS7+ot3JF+4PJX601P
         80Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687964341; x=1690556341;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+DBcZOcowzmfypUkfb1rmBpcpS3jwC4LRlJcZCk1X2M=;
        b=WGFfaBb3By7b45+gi4HmGE/laWNm9+03ozUVuv3OboO3vht+u3B5XnGLFqPpUpEKDf
         Zj2OEXrgoXTYBEYZEupC4HyOdssgAxTgEF/T3FjJfxgSQ09my5CZD3Q8iFa/0iJbuarD
         6ffNVybFVQ6oYMb2XCXgliqrJBCorzUja8dT+sizYDkQwW7MT1f3RZxoufbpnOS2re2M
         XgMfQEoX4oCmLjEJlHLzWi1FA9HKfpXIyXunnLP5F8FUE+zPUPYxRDGvIPKVY1cKvO5Q
         AcwkgI/PAchIEV8NmMzGVOyhiSTnuiGg+7oPlWbcHxQMdZcV7CJs4uGv8XKAr9zfObaH
         2afw==
X-Gm-Message-State: AC+VfDwDjXXhTdD7+EHLG9/iR8t76Dx854YwYKbanlSqNW6gB5QV8JWm
        /cIvik1A799i+ocnCskKvnE4pQ==
X-Google-Smtp-Source: ACHHUZ7c3gA4gbulMYBdPHlhp32kH30wOBlw+Mtq3EpIVOOqDNZ44A9iVQXP6v38X3SLXj8okEPKyw==
X-Received: by 2002:a5d:9da6:0:b0:783:617c:a8f0 with SMTP id ay38-20020a5d9da6000000b00783617ca8f0mr12889819iob.2.1687964341333;
        Wed, 28 Jun 2023 07:59:01 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y14-20020a02a38e000000b004290f6c15bfsm2412188jak.145.2023.06.28.07.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 07:59:00 -0700 (PDT)
Message-ID: <66eef649-fe8c-4a17-e8fa-1f38f699dd83@kernel.dk>
Date:   Wed, 28 Jun 2023 08:58:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [GIT PULL] bcachefs
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>
Cc:     Dave Chinner <david@fromorbit.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <aeb2690c-4f0a-003d-ba8b-fe06cd4142d1@kernel.dk>
 <20230627000635.43azxbkd2uf3tu6b@moria.home.lan>
 <91e9064b-84e3-1712-0395-b017c7c4a964@kernel.dk>
 <20230627020525.2vqnt2pxhtgiddyv@moria.home.lan>
 <b92ea170-d531-00f3-ca7a-613c05dcbf5f@kernel.dk>
 <23922545-917a-06bd-ec92-ff6aa66118e2@kernel.dk>
 <20230627201524.ool73bps2lre2tsz@moria.home.lan>
 <ZJtdEgbt+Wa8UHij@dread.disaster.area>
 <3337524d-347c-900a-a1c7-5774cd731af0@kernel.dk>
 <e5df59c7-eadd-4c1a-9499-5a98ef719216@t-8ch.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <e5df59c7-eadd-4c1a-9499-5a98ef719216@t-8ch.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/28/23 8:48 AM, Thomas Weißschuh wrote:
> On 2023-06-28 08:40:27-0600, Jens Axboe wrote:
>> On 6/27/23 4:05?PM, Dave Chinner wrote:
>> [..]
> 
>>> There should be no reason to need to specify the filesystem type for
>>> filesystems that blkid recognises. from common/config:
>>>
>>>         # Autodetect fs type based on what's on $TEST_DEV unless it's been set
>>>         # externally
>>>         if [ -z "$FSTYP" ] && [ ! -z "$TEST_DEV" ]; then
>>>                 FSTYP=`blkid -c /dev/null -s TYPE -o value $TEST_DEV`
>>>         fi
>>>         FSTYP=${FSTYP:=xfs}
>>>         export FSTYP
>>
>> Gotcha, yep it's because blkid fails to figure it out.
> 
> This needs blkid/util-linux version 2.39 which is fairly new.
> If it doesn't work with that, it's a bug.

Got it, looks like I have 2.38.1 here.

-- 
Jens Axboe


