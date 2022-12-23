Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EE7654E49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Dec 2022 10:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbiLWJYx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Dec 2022 04:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbiLWJYu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:24:50 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF4D36D75;
        Fri, 23 Dec 2022 01:24:48 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 65so2955999pfx.9;
        Fri, 23 Dec 2022 01:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=orXscDtt29LqpDRe6wK6B/AU7SCWY/jfRNSdBz0C1y4=;
        b=DjSst1Lek0ia3PAbJusa8L5QlcZnlLDEVd7VD1TBFPLpRf8spVFbwnF1AbFS2swoZI
         ah5ls7vaB/L5/dksk+qMl2p1CZ4m9XJuW3RgekEGqt5c/8MxEU8d5S4aUoY01tl7em+m
         LHiXf5Bnm328HBTJhg8YLQ9TRjOytLYiConI+j+jTZx0pz3m4hOnVyKBqNL341t9mTd1
         IHlPBVXhl56NT1zQe3ElCdT57H3+IvgIN59Tdcsm6eTQvFYnlyFOAYnTdaBtpF1533Hx
         VJVSLQD0oEf0CiXuPznHqNU6I73v4WBuCFdAtdtp49dSmsJtn4N9SdaFZoSalsQ3f/7u
         1Wpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=orXscDtt29LqpDRe6wK6B/AU7SCWY/jfRNSdBz0C1y4=;
        b=4Rka7NADcBZt4LXElFR29rjgC+RmDx+umEezQlYGdMtAkkN+13Miu/mdC6sAQCzU26
         U1gpMomu5dSj9XOGUr4nzH1EHyLi0dHPs8b9zmRnKKoTtNIb2AIX1RLy6kyRVox8K+qc
         WiHovB9P7aw64HnAYJkWwJhq1uqu3aYR33pjjpKCdRhpRI+d1xcd7sQO1OtoDFW4BSUn
         q2YCtA8ub/x2Tay+jHjpsa7POnLT73HguzpmiEQEn7eegVfv1ekl1l09b1HVjntxaZLN
         U8eKLgA7MIJ6qu9bk5zyhKz+ra9wsOg0fm3EgPdbLA66s9HBimPuIyuRDHmBY7hdErjD
         7pig==
X-Gm-Message-State: AFqh2krqcCNJlNqCYhIKgS1ti/nRwhZuLxaBwtZoPvnyPl+nUvonf6Yo
        lksjvXGy8M2lfltjSL5ZODM=
X-Google-Smtp-Source: AMrXdXt/1M/o4TumvC8WjfGzap2s/M5TpoCv6P/Y4R33giSQBOoqkWeuw4HNb6z2XeTMOXICsP8JHg==
X-Received: by 2002:aa7:914e:0:b0:574:35fd:379e with SMTP id 14-20020aa7914e000000b0057435fd379emr10666022pfi.2.1671787488104;
        Fri, 23 Dec 2022 01:24:48 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-5.three.co.id. [180.214.232.5])
        by smtp.gmail.com with ESMTPSA id w3-20020aa79543000000b00576e4c7b9ecsm2042927pfq.214.2022.12.23.01.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 01:24:47 -0800 (PST)
Message-ID: <04c86814-b7bc-0943-2142-96eb16fb534b@gmail.com>
Date:   Fri, 23 Dec 2022 16:24:43 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH RESEND linux-next v3] docs: proc.rst: add softnet_stat to
 /proc/net table
To:     yang.yang29@zte.com.cn, corbet@lwn.net, kuba@kernel.org
Cc:     davem@davemloft.net, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <202212231104299193047@zte.com.cn>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <202212231104299193047@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/23/22 10:04, yang.yang29@zte.com.cn wrote:
> From: Yang Yang <yang.yang29@zte.com.cn>
> 
> /proc/net/softnet_stat exists for a long time, but proc.rst miss it.
> Softnet_stat shows some statistics of struct softnet_data of online
> CPUs. Struct softnet_data manages incoming and output packets
> on per-CPU queues. Note that fastroute and cpu_collision in
> softnet_stat are obsolete and their value is always 0.
> 

Thanks for pinging me by resending! Indeed I always forget to review
this due to busy time.

Anyway, LGTM.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara

