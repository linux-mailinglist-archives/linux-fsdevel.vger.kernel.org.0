Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463776F1290
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Apr 2023 09:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345630AbjD1HlS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Apr 2023 03:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345627AbjD1Hk4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:40:56 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AEB4EFE;
        Fri, 28 Apr 2023 00:40:32 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-51f3289d306so7240349a12.3;
        Fri, 28 Apr 2023 00:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682667630; x=1685259630;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HQJdKPKslCNqX5d4NvUVK/rsaGeog42boMcd62MXp9g=;
        b=BNhSXrcAy9HbytSZlDmVmEPixLSouKeOrmSaWlh4udMdo7zKhBSSychEuWCBDVox9p
         dv0WEvj76m0uAVTTUlAG+ys+kvWzpxGiL+qT9OSOiv8MepJWJzKFvxSv7XX+1cowaOPt
         /PTsToqzG6aKbLCTUSlZGB7geA0vA7F6u4r1QXH3ZPoztSwr57AzYJkB+Z+jtyPsy0u9
         7IN9tnsR5l0gkK9QWik3CFNsamdFu0vvedl4WlJyFqMXTHy2lUOX7+souCtvI89jGSEy
         pZfSq6rjx7jQyRxBwHzFZsY7m5Bziphru/6xG4trlzmg4P4Vma63aTN2whbyi0vrRukt
         lUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682667630; x=1685259630;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HQJdKPKslCNqX5d4NvUVK/rsaGeog42boMcd62MXp9g=;
        b=CXTkl+jg/AjlIa61evyLr9pXtit+xwsbtRNXOgH3bcUSwwDeP097SMWUEEiUEsSmqA
         Mv5yw5C/jHJOKw7GKcM4sdppxbwKsJH8Vv4qS4K3A0cpFhHrRkHMzBb9241u2UYjEyTC
         FTFh/VgkLq1Rww1vvTAC1NPuva4aP2fcF2mkR4VwuCejDLRKdxawrQS1KUGyceXQSo4a
         GqTYUn6mKs9CZMy9Ps4v19hHLxWagr6U76UzjwBfxOKQ3ZRCHPFRpEDWerIt2nRHvDwr
         5szwLs3QbSXcXvkH7zDilJM7NFmzjVWWJDTMEFrZxLGaIjmclR42ru6W304/hNkS5bwe
         /Gsg==
X-Gm-Message-State: AC+VfDzAFGfUoF4zrnjbEIHaxEMhhP/n2mQ1x+Stf1GWhvidJgBLFIZC
        9+ytZRQhqYU+wSQXh58qclY=
X-Google-Smtp-Source: ACHHUZ5ZsZCrdvfsuzwjX4nr4EG/o56xKBS8FhrEQ0oSldwRr9t4T3Jy5JvtwMXUc5QUg3KiqDFQPA==
X-Received: by 2002:a17:90a:14c5:b0:24b:2fc1:8a9c with SMTP id k63-20020a17090a14c500b0024b2fc18a9cmr4479704pja.11.1682667630537;
        Fri, 28 Apr 2023 00:40:30 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-82.three.co.id. [180.214.232.82])
        by smtp.gmail.com with ESMTPSA id j8-20020a17090276c800b001a686578b3dsm12668874plt.307.2023.04.28.00.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 00:40:29 -0700 (PDT)
Message-ID: <76534699-e270-b450-c18e-f7c35c325bcf@gmail.com>
Date:   Fri, 28 Apr 2023 14:40:24 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 0/2] sched/numa: add per-process numa_balancing
Content-Language: en-US
To:     Gang Li <ligang.bdlg@bytedance.com>,
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
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <9ba3577b-0098-86da-ff2e-636cb5a8ae1a@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/27/23 12:17, Gang Li wrote:
> Hi,
> 
> Looks like there are no objections or comments. Do you have any ideas?
> 
> Can we merge this patch in the next merge window.
> 

We're at 6.4 merge window, so the maintainer focus is to send PR updates
to Linus. And this series didn't get applied before this merge window.
Wait until 6.4-rc1 is out and reroll.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

