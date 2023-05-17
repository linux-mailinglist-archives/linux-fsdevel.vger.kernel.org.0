Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA8A706420
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 11:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjEQJ2t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 05:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjEQJ2s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 05:28:48 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71B5AB
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 02:28:22 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-53202149ae2so341150a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 02:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684315702; x=1686907702;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g38vCA/9PDzh/FhE2Gebm+Gt7lmHqnbMMiCV4pY5w5k=;
        b=dZENdKVP5JkcM6p+hZzF5uk2n2mkQsvLffN5DULjo+e71A1bA/yylDLfoPSSyiGscI
         6MiVsnDC8Bq6vhrKkBogiuKz2VDf+1cI30toauxQOTyD7BhF9UW0Iih4yXyGMOHiRmZQ
         ASE/dA2AucyP4oS5PtVykkrvIcs+SNkMq70nxlVL2aUmmp+3hL9+D0eAY08sOdyI6f94
         +F23Pab05GQQZf7ENo0EvwzECKGlqhZHq+DPb8zy5/y5HSAkSgXE4A5he3AX3RLyRxrm
         y3rffOp/Ge9L83iwLy18xrguqJ3UnEjNoleyP0jn5hpvBEOoli/Mu9Dr0ba13ns7K01R
         wzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684315702; x=1686907702;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g38vCA/9PDzh/FhE2Gebm+Gt7lmHqnbMMiCV4pY5w5k=;
        b=M2pGKP6OQwEspEuec1W4jYrUoYIqujG9E7zilOkkLUn++2xlvgaFdpoy09gW7Ty06K
         R/A85ZVS8DFv2BWjhV3V299Q1mq/0ziJZhiZx7WCvuem+Ob9dr8lLekXLSDMpPSqheIY
         ddneLk62Udt8AQ0wmr3hVKO9YG2YtSySobquqNq+C4rZi/nD4Sxb8YFxDv5+atrjLCFz
         EOzDWEPa8Xdza/dAU6KpExSyrDzByN1ZKjHaIZulMUuKLZRuqa2m0zNdmPqyhpZD7U+n
         QpByWkpg7gnH3kO78UpX9qljqBnBY8Csie943lNi52Ki1Gos8XCiwyS2uURNaCpAExBN
         T31g==
X-Gm-Message-State: AC+VfDxCxBrfiQIDONx+/D9Lwaxku3AuG4wi8OVUjBdbuwc9fxxPmK4F
        d5+YT3QmMG94M/NHLlfTn1mDsA==
X-Google-Smtp-Source: ACHHUZ70KjiAcbAEevyw6rP9x+pndIs5V0Va5BeV6HXU0+HjtsW3mPkIrH/N8p8hnroEcgYhkozN5Q==
X-Received: by 2002:a05:6a21:3284:b0:100:9a80:2e90 with SMTP id yt4-20020a056a21328400b001009a802e90mr44278647pzb.59.1684315702444;
        Wed, 17 May 2023 02:28:22 -0700 (PDT)
Received: from [10.70.247.178] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d30-20020a631d5e000000b0051baf3f1b3esm14810102pgm.76.2023.05.17.02.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 02:28:22 -0700 (PDT)
Message-ID: <4594ffcc-ca24-e813-1991-20221c772b46@bytedance.com>
Date:   Wed, 17 May 2023 17:28:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v6 0/2] sched/numa: add per-process numa_balancing
Content-Language: en-US
From:   Gang Li <ligang.bdlg@bytedance.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
References: <20230412140701.58337-1-ligang.bdlg@bytedance.com>
 <9ba3577b-0098-86da-ff2e-636cb5a8ae1a@bytedance.com>
 <76534699-e270-b450-c18e-f7c35c325bcf@gmail.com>
 <9befca58-2425-5b4f-2dab-98b3ed4037ac@bytedance.com>
In-Reply-To: <9befca58-2425-5b4f-2dab-98b3ed4037ac@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

Since both 6.4-rc1 merge window and LSFMMBPF are over, could you take
a look now?

Thanks,
Gang Li

On 2023/4/28 15:45, Gang Li wrote:
> Thank you.
> 
> I'll keep an eye on the progress.
> 
> On 2023/4/28 15:40, Bagas Sanjaya wrote:
>> On 4/27/23 12:17, Gang Li wrote:
>>> Hi,
>>>
>>> Looks like there are no objections or comments. Do you have any ideas?
>>>
>>> Can we merge this patch in the next merge window.
>>>
>>
>> We're at 6.4 merge window, so the maintainer focus is to send PR updates
>> to Linus. And this series didn't get applied before this merge window.
>> Wait until 6.4-rc1 is out and reroll.
>>
>> Thanks.
>>
