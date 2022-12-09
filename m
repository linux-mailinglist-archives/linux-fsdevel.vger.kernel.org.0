Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C312F647CC2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Dec 2022 05:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiLIDkn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Dec 2022 22:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiLIDkl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Dec 2022 22:40:41 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B43529375;
        Thu,  8 Dec 2022 19:40:35 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id k7so3571414pll.6;
        Thu, 08 Dec 2022 19:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hpzq7q0AtVmt+5quybT/3fAvERrq3OOIi4p4YNPtaTc=;
        b=DojONSdiNcdZpkybGACZ9c+pNuMYFdOoIfqCLTuXwL3AJtQapVO5ajfeIx95oiEwt4
         a+WdpVdwfodiz/WJvEWpa3fPAKctr6uy+ZGU0dqhcylGZHs4oPeaSHi63eHfHDMyk+8m
         sQKRaNfCwaM4pEhyB4KWzZnqIgw7iQCg3k/w07NaTYv2LWtUUSy8XhwBo2eovm8XllTf
         xGd1o8YJrFYRQYUxHc86ft/YrgHO5a9kiu/sNhyfX/CmhoAiFBPTOJBga4lWqeSuj97h
         JD5WIKuV5fHmbxqBCpsS8lfkk7Hsz+ZCX2VGOiGj7I/oF/lxO0b3gCTEoBCpf0EUp+Ch
         H9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hpzq7q0AtVmt+5quybT/3fAvERrq3OOIi4p4YNPtaTc=;
        b=SOzT6QXjoiNuy2AQVmPhm5bpOwoL0B+GMT3v1a3kDfO5heNzPp501GLCgT2iUz/H4Q
         ttfPOS64WUNrxrUhep0qtIkwGZhhkG/PUpZ3vVyhRQ5fFivbaZ1lhMdFEPB9bQetajr0
         4xw++WClYQ6ovTPyLgXJf6NSq/alO28C0TvTBFn1WFxqAeqqjg3HLMmQbznkO9kzjOHl
         Ss0T8ycC7FtdaD+oT5Bs4T4tGw2lCznvAPlgvlOTt3uYDipCr8dVb6wIDRsKilCjhv+S
         jRvdJ1Vsp77kxwDVIHcm2OCZ4tassYO0qouFfIqo/+wJwDz61V7m94ChWe40jJdxhW0I
         bvnA==
X-Gm-Message-State: ANoB5pl9J1D/FU+w6WQsgu0nA7NR8i5JLjggiGBfc57Lsm4yqsicG6es
        ZrgsZzU7fl+7Nbh48+RUH3hWkAOdTMI=
X-Google-Smtp-Source: AA0mqf7fgDEj8Aqmbw0AkJYqClY4HWkPzSDZXGf405cNj0lXff6xOP9SNWNlV+JRZVZmcB1zTZgXoA==
X-Received: by 2002:a17:90b:b04:b0:219:70fd:d8c0 with SMTP id bf4-20020a17090b0b0400b0021970fdd8c0mr4241899pjb.11.1670557234757;
        Thu, 08 Dec 2022 19:40:34 -0800 (PST)
Received: from [192.168.43.80] (subs32-116-206-28-21.three.co.id. [116.206.28.21])
        by smtp.gmail.com with ESMTPSA id q34-20020a17090a752500b00200461cfa99sm316334pjk.11.2022.12.08.19.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 19:40:34 -0800 (PST)
Message-ID: <ed94e67b-a42b-26de-39a1-70a31828aaea@gmail.com>
Date:   Fri, 9 Dec 2022 10:40:30 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH linux-next v2] docs: proc.rst: add softnet_stat to
 /proc/net
Content-Language: en-US
To:     yang.yang29@zte.com.cn, corbet@lwn.net, kuba@kernel.org
Cc:     davem@davemloft.net, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <202212071923184146141@zte.com.cn>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <202212071923184146141@zte.com.cn>
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

On 12/7/22 18:23, yang.yang29@zte.com.cn wrote:
> From: Yang Yang <yang.yang29@zte.com.cn>
> 
> /proc/net/softnet_stat exists for a long time, but proc.rst miss it.
"..., however it isn't described in /proc/net table of proc.rst
documentation."
> Softnet_stat shows some statistics of struct softnet_data of online
"softnet_stat" (programming language keywords and variable/const name
should always using proper capitalization, i.e. lowercase)
> CPUs. Struct softnet_data manages incoming and output packets
> on per-CPU queues. Notice that fastroute and cpu_collision in
> softnet_stat are obsoleted, their value is always 0.
> 
"Note that ... are obsolete and ..."

For patch subject: "... /proc/net table".

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

