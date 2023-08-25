Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0092787DA0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 04:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbjHYC10 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 22:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237155AbjHYC1O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:27:14 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FAB1BEB
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Aug 2023 19:27:12 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-56e280cc606so91331eaf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Aug 2023 19:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692930432; x=1693535232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZDEovgEmKOIQDALDeermRh4RlyhMG7psKbXKGwv5XpU=;
        b=H1ofHetsigB9ITNuPNCwwRQhdoolRpPpL1USl04RVMouZvbi1jFS1XXRhP6naK4c3l
         sjbi9eVGH3v2aNk6tiw0+HQJUn0HAWnY2YPiJu2XH59GDOPcKhbgrdOLQcumKonXuAWf
         Zk+KGmA/eDcnSX1B2LLUbP3L86vsTv4EhKJnMZobNnzGzRAGBzbQNqTwHfjGFkTdPVYm
         MZXb10n71JVtOv5OX8ijEt8g3HHBVn9nV0Txxbi50pEmnb1R/oINPY9fGfuwbqdzr+kX
         VQK00VpAPmfLCQx/rcerD7AFur4TEk4qj2dkz6qBOiAcFDLmDnVjT2fngT6XCOcefRjQ
         4/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692930432; x=1693535232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDEovgEmKOIQDALDeermRh4RlyhMG7psKbXKGwv5XpU=;
        b=ju32xAcIJxgGj5LvRb/dDzZ0tX/rSuCA6r/mTURZKfh7S9JlyO3v7Ra26sfT9RZUHx
         Lsb/Ej8yyURKnl59YBqypPM6Xcp1ipdiEyhTQUvtRfBklj1u+VAKKMT5QjnxRQ46gTHT
         OdjXiyTl7ydZ1X7rfB67KOmJS+zNIDwmoXbQD1WHipHbw0q+t+I3/BqJyBNnfKirPd/b
         qWIemF0HkO7y8jkj1RZY4TSuUXMnxisyvg8AveisXze/slhI3QhjGkEhqqsIMTjEry3e
         h3dvPO1et6iNk7WJMbtSfJNhKA0J087KxE36yhMcm3jh7mWuNLjE2gEYrtCsXHjn1b+P
         wpHA==
X-Gm-Message-State: AOJu0YzRNtQrJ7GjIt60Hfxr+deNcmxWdIMVfaQnDhMRYKQOnqa2JdpN
        2X8anWB3hh2CEcnBASa9mDV1L2fvGcrnQywscu4=
X-Google-Smtp-Source: AGHT+IFNC8lq9/gjLIia+s0ADvLuTnAbrMoFJtaLZAMhJ4TTbZvJ4qT11YMzEk3HlxACB8iuAORjHQ==
X-Received: by 2002:a05:6808:1599:b0:3a8:7446:7aba with SMTP id t25-20020a056808159900b003a874467abamr8023430oiw.5.1692930431838;
        Thu, 24 Aug 2023 19:27:11 -0700 (PDT)
Received: from [10.70.252.135] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id w4-20020a637b04000000b0055fd10306a2sm335950pgc.75.2023.08.24.19.27.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 19:27:11 -0700 (PDT)
Message-ID: <a7f13bb5-4344-e3db-1b2f-7edfbe6dae94@bytedance.com>
Date:   Fri, 25 Aug 2023 10:27:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v5 27/45] vmw_balloon: dynamically allocate the
 vmw-balloon shrinker
Content-Language: en-US
To:     Nadav Amit <namit@vmware.com>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "tkhai@ya.ru" <tkhai@ya.ru>, "vbabka@suse.cz" <vbabka@suse.cz>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "cel@kernel.org" <cel@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "yujie.liu@intel.com" <yujie.liu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Muchun Song <muchun.song@linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Pv-drivers <Pv-drivers@vmware.com>, Arnd Bergmann <arnd@arndb.de>
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
 <20230824034304.37411-28-zhengqi.arch@bytedance.com>
 <2E63E088-10D8-4343-BB78-27D2ABFB95E7@vmware.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <2E63E088-10D8-4343-BB78-27D2ABFB95E7@vmware.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Nadav,

On 2023/8/24 23:28, Nadav Amit wrote:
> 
> 
>> On Aug 23, 2023, at 8:42 PM, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>
>> In preparation for implementing lockless slab shrink, use new APIs to
>> dynamically allocate the vmw-balloon shrinker, so that it can be freed
>> asynchronously via RCU. Then it doesn't need to wait for RCU read-side
>> critical section when releasing the struct vmballoon.
>>
>> And we can simply exit vmballoon_init() when registering the shrinker
>> fails. So the shrinker_registered indication is redundant, just remove it.
> 
> ...
> 
> Ugh. We should have already moved to OOM notifier instead...
> 
>> static void vmballoon_unregister_shrinker(struct vmballoon *b)
>> {
>> -	if (b->shrinker_registered)
>> -		unregister_shrinker(&b->shrinker);
>> -	b->shrinker_registered = false;
>> +	shrinker_free(b->shrinker);
>> }
> 
> If the patch goes through another iteration, please add:
> 
> 	b->shrinker = NULL;
> 
> Not that this is a real issue, but I prefer it so in order to more easily
> identify UAF if the function is called elsewhere.

OK, will add it.

> 
> Otherwise, LGTM. Thanks.

Thanks for your review!

Qi

> 
