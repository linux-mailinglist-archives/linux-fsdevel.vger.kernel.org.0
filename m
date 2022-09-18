Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0015C5BC00D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Sep 2022 23:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiIRV1k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Sep 2022 17:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIRV1j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Sep 2022 17:27:39 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C1E13E11
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Sep 2022 14:27:37 -0700 (PDT)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DD77A3F473
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Sep 2022 21:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1663536455;
        bh=VBMgryLG1fCHHFs6o9PjHyuHeF2daTdVHmXIfMnp98o=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=m4mqwRlFZoDK9lylT/5ofrErQ3nz8jmM72pMkHiMBJRxozfKLdNL7oGOjA1GOZBCY
         hti+BJ1T5L0XEthTwu9FTYbCGvVWTqGE+tcERkUqEHTz/iWjFXphnPPvQSNEPH2evh
         9K2Jr/HZAZaUfsEzu3bLogGvQF2bv/5bCXtVqFCttCyRkI54gltCZWOJ5kG0ESF+wZ
         4fk8LQ4bB8R69zzbA8yYylEb5/WD9HskrISr9IK0eiWLc4yqxUulDjjXYrp1hSEHD2
         xaTx/6bilRuz57A3P68Ckb3aalMTIdKjuZcBuFcekpfJDMALfLsMClzrf9RGWeFO8p
         X8P/nmaBFwd6Q==
Received: by mail-qt1-f198.google.com with SMTP id g21-20020ac87d15000000b0035bb6f08778so14684499qtb.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Sep 2022 14:27:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=VBMgryLG1fCHHFs6o9PjHyuHeF2daTdVHmXIfMnp98o=;
        b=Gq0GWvrE+euNW2xO2qqpR2oRxib70AhH8qNNFdr8n0TLZcexxwCmQRuz9CH46Yhi0N
         yQlL4YcUTxhyTMv2ftAWmggeKsGP66useWmM1+Cip0yWIbTU/Dmv5iqbR7gjd3s9mSDb
         aJeZVGpGtBkHr6S505uBltJuyW5Cydwu+YY3K3ZGLkXtLb17BWBJiWTs70/KvbJMFwaY
         KGMW627IbZHQlWQv7gjl2jjeXYmsKaYvh5raz/PbUnUjSGepjlWBhUVIwYM++79rE3Ez
         G5N0DTuvm3Fk5NFbxk6WkUXLxaSmQBIdJKSU6RTjGKrzQI3+yM4ZZOyeBl0syy0ptQCR
         vTRQ==
X-Gm-Message-State: ACrzQf2no5bYhXcH6oQ2LEG9A/EYvSKAHFcsFvDBcal6lMOey+NG4Mst
        Z5E1JMPG/ib4QnAI6BBVI+2+vJxr6SPWXJnUpPd40BowQYr+nm9Fe4TbaXxqBjNCNOB0Gyttjm3
        ITTp/vJ0ZzwV3rGNTS+2oP6KgWxJ9dVgowmk7Qvn+O3g=
X-Received: by 2002:a05:622a:d4:b0:35c:e40c:7628 with SMTP id p20-20020a05622a00d400b0035ce40c7628mr3206084qtw.428.1663536454729;
        Sun, 18 Sep 2022 14:27:34 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7ZWP/HUcZxev2jAyOxgKhUOEApS0yeqyOB7P5V0WSpE41k3bRq3tXcjqskab12IAiiTuoYYQ==
X-Received: by 2002:a05:622a:d4:b0:35c:e40c:7628 with SMTP id p20-20020a05622a00d400b0035ce40c7628mr3206075qtw.428.1663536454507;
        Sun, 18 Sep 2022 14:27:34 -0700 (PDT)
Received: from [172.20.4.66] ([65.206.117.195])
        by smtp.gmail.com with ESMTPSA id de42-20020a05620a372a00b006b945519488sm11466016qkb.88.2022.09.18.14.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 14:27:34 -0700 (PDT)
Message-ID: <a9588d9e-56a1-666c-9542-35bd0c8f64af@canonical.com>
Date:   Sun, 18 Sep 2022 18:27:31 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] Fix race condition when exec'ing setuid files
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220910211215.140270-1-jorge.merlino@canonical.com>
 <202209131456.76A13BC5E4@keescook>
From:   Jorge Merlino <jorge.merlino@canonical.com>
In-Reply-To: <202209131456.76A13BC5E4@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


El 13/9/22 a las 19:03, Kees Cook escribió:
> Thanks for reporting this and for having a reproducer!
> 
> It looks like this is "failing safe", in the sense that the bug causes
> an exec of a setuid binary to not actually change the euid. Is that an
> accurate understanding here?

Yes, that is correct.

>> This patch sort of fixes this by setting a process flag to the parent
>> process during the time this race is possible. Thus, if a process is
>> forking, it counts an extra user fo the fs_struct as the counter might be
>> incremented before the thread is visible. But this is not great as this
>> could generate the opposite problem as there may be an external process
>> sharing the fs_struct that is masked by some thread that is being counted
>> twice. I submit this patch just as an idea but mainly I want to introduce
>> this issue and see if someone comes up with a better solution.
> 
> I'll want to spend some more time studying this race, but yes, it looks
> like it should get fixed. I'm curious, though, how did you find this
> problem? It seems quite unusual to have a high-load heavily threaded
> process decide to exec.

It was reported to Canonical by a customer. I don't know exactly the 
circumstances where they see this problem occur in production.

Thanks
	Jorge
