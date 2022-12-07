Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A326A64561C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Dec 2022 10:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiLGJKe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Dec 2022 04:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiLGJKc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Dec 2022 04:10:32 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6602CE2E;
        Wed,  7 Dec 2022 01:10:31 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id q15so15942854pja.0;
        Wed, 07 Dec 2022 01:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pmV/ylB/SbTzN29Fyk+GXH3nZHECjvwCeA1ibmHfhMQ=;
        b=GfvTCv0FdA4O9e1udwwfLH8ZsR8VFMej6NTVJLhLfW3zw+bXTLcB8NcoPbMaoPk+N0
         OqF7sYIVDaokwQsZxHgRw91fvIBI2aRD9FlcbG7CStYEyPt2zYk5oreS3Ke2WPoSia9n
         D8yanAevyPbdG4fiYlH/HnmupHkvWF2SiF0mfKBMAeVS/DAZjW1xACxuBIWBc3M+l6zJ
         gDeZ2RnRXKjz7/VCJYfMcrWIZjEJjOSXYds3vwXuET112w8F4ULoNfl/zjVf06mPMase
         Co6UWt2BJ1elePOIAFgmD0sltcThMzgkVmiIbWltQPZjXJolCCyHdeho8CWWybvhbe/y
         BDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pmV/ylB/SbTzN29Fyk+GXH3nZHECjvwCeA1ibmHfhMQ=;
        b=ygtycNIGkcwhz/e+YQGkmnm3G2XpI19P4A3zLBuEz1A6P/PSlxkwq/nk5xJk/niWly
         trQWEuJLFtwoMO/y64nx4lhC5qEnzP1i/LEFdM0WeWNY2/CTObuJV+710Zmzc3vOPBl5
         UmnZw1oJbne+HaTDDNed0+YRM/g0DYXGGEy41cI0Gk4HgXWH5gEzz8AZkru2OtCi/Rwo
         gY45ZGComrpS9RIZEbY+dup3B9t3OEpELhwsdJvqglfi556QvG07KMA5woVsSFTqprsx
         V73XvOeRHw/E2THYOoZZ+UxjfehU9z3ieaEALH/bHjmdqbsc42ysLhhjHbtMLqWhYWaD
         +YRQ==
X-Gm-Message-State: ANoB5pnQzAMdflM14navKFlZbL/zIVecm/HWkX6RXqvffsMYEGSU5kBd
        kX654b8kjx1Fy1v2h5ImUCA=
X-Google-Smtp-Source: AA0mqf596k22JlatRZtn9FsoaYCarP4PAd5xF+A9spjaycNFK6EmW9R8bwkQkRwWAsr6tc5Yym8p4g==
X-Received: by 2002:a17:902:d88c:b0:186:a7f1:8d2b with SMTP id b12-20020a170902d88c00b00186a7f18d2bmr75853185plz.137.1670404231051;
        Wed, 07 Dec 2022 01:10:31 -0800 (PST)
Received: from [192.168.43.80] (subs03-180-214-233-90.three.co.id. [180.214.233.90])
        by smtp.gmail.com with ESMTPSA id a2-20020a17090abe0200b0020ae09e9724sm734543pjs.53.2022.12.07.01.10.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 01:10:30 -0800 (PST)
Message-ID: <35cb3dad-7bae-7713-3bad-b151fa6831dd@gmail.com>
Date:   Wed, 7 Dec 2022 16:10:25 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eC1uZXh0XcKgZG9jczogcHJvYy5yc3Q6IGFk?=
 =?UTF-8?B?ZMKgc29mdG5ldF9zdGF0?=
To:     yang.yang29@zte.com.cn, corbet@lwn.net, kuba@kernel.org
Cc:     davem@davemloft.net, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <202212071423496852423@zte.com.cn>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <202212071423496852423@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/7/22 13:23, yang.yang29@zte.com.cn wrote:
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index e224b6d5b642..9d5fd9424e8b 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -1284,6 +1284,7 @@ support this. Table 1-9 lists the files and their meaning.
>   rt_cache      Routing cache
>   snmp          SNMP data
>   sockstat      Socket statistics
> + softnet_stat  Per-CPU incoming packets queues statistics of online CPUs
>   tcp           TCP  sockets
>   udp           UDP sockets
>   unix          UNIX domain sockets

Add softnet_stat to what table? I have to read the actual documentation
and found that you mean /proc/net table. Please mention that in patch
subject.

Regardless, this patch is from ZTE people, for which they have a
reputation for ignoring critical code reviews and "atypical" email
setup that needs to be fixed (try searching for `tc:"zte.com.cn" AND
f:"gregkh@linuxfoundation.org"` on LKML for details). If you can
receive this email, please hit "Reply all", "Group Reply" or similar.
Remember don't top-post, reply inline with appropriate context instead.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

