Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB845EF04B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 10:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbiI2IW3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 04:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbiI2IWZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:22:25 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DBA124C24;
        Thu, 29 Sep 2022 01:22:25 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id w20so621756ply.12;
        Thu, 29 Sep 2022 01:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=RuIrMviIxVvS3xeIfQu+kXUhRDbAHSuN3Gwon2iQMXI=;
        b=dN3YoFgkXp50HEqth7Mmm9UVSUtqK+WFB4NLyWWK+ERJH8o3Jn0Lob1Ez3sTOuEHOh
         5Lnv7KWx8GfpiPMuiU40xVeq5ShaNSGr+lLTr3IUd9X2G6evmP3tAPNt0KKXqR/+lDl6
         XQesZIfOk59URQrzaHaLdw2QlnDRtVVM2Ch0HIFKQXGjNHlK5OKkmpZsDUYCAh2XBZSh
         yEAzvyBuX4wOUzIBMR61xh2QSVvRlNnzHfg9ORsOdz6ix3ODMBR6+VBeeOOqSSD8k/MO
         2p4oqZIlaCc1krnUSGHgv031ZFUCFS4ZsuJrR8DAYYboy7g2Nti51dahkJ/yRRCyF4MZ
         5rkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=RuIrMviIxVvS3xeIfQu+kXUhRDbAHSuN3Gwon2iQMXI=;
        b=JzfzMEQn6pTQ1Z++WIUFWKUPHp7fCMUvKRCTZ7XNUpJ1sp+6rEfKO5cnKt+pwm3N/p
         UX7bjaVlEPtJem5RL7J8s2N9vVl3Pu/IySPKuHqCEwCNHYpZS+PtmAXiBGbJ/wntvPZj
         CEmVb1kXgZe+RiUPe6IH4F/+kmmeuKpDSYzYo0nKHm8N94AxaLiwZu5ZzFqR6DNlCYTL
         FRMLYcYtkoORdDaG16Suvdrt2Mqab6VXT2UG10UFGG/EFDFt9rl1peEUNOn31hnsbdxz
         bxvbOelXNWrjipVJ7zO6RyxBTdQo9Td7AwwS4lbSxkdNE7YVkGqDX/tR8prvz5V40caq
         K24w==
X-Gm-Message-State: ACrzQf1lcvV5cBXJxznz96p2lZ1hgEVXyMviIJOkVDLf7nGXlQjXZ6Dz
        2ydtwaCQj6oFhNYQqoEW+cg=
X-Google-Smtp-Source: AMsMyM5PDzGb20ORN84QWdThcVRmACePMOr/RPUTYr5OrW0HNh/xCIX51CDqhWhq2NtBBMB0kB+rGA==
X-Received: by 2002:a17:902:d3c6:b0:178:37e0:2e72 with SMTP id w6-20020a170902d3c600b0017837e02e72mr2346393plb.28.1664439744580;
        Thu, 29 Sep 2022 01:22:24 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-28.three.co.id. [180.214.232.28])
        by smtp.gmail.com with ESMTPSA id o13-20020a635d4d000000b004296719538esm4937209pgm.40.2022.09.29.01.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 01:22:24 -0700 (PDT)
Message-ID: <04a81c49-7a91-cb52-e321-e4df71815ef1@gmail.com>
Date:   Thu, 29 Sep 2022 15:22:17 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4] sched/numa: add per-process numa_balancing
Content-Language: en-US
To:     Gang Li <ligang.bdlg@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20220929064359.46932-1-ligang.bdlg@bytedance.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220929064359.46932-1-ligang.bdlg@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/29/22 13:43, Gang Li wrote:
> This patch add a new api PR_NUMA_BALANCING in prctl.
> 

Use imperative mood instead fir patch description, hence better say
"Add PR_NUMA_BALANCING to prctl".

-- 
An old man doll... just what I always wanted! - Clara
