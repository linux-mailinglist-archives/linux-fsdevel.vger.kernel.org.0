Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A733A5F5806
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Oct 2022 18:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbiJEQJ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Oct 2022 12:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiJEQJ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Oct 2022 12:09:56 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCA0DEDD
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Oct 2022 09:09:53 -0700 (PDT)
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 60222420E4
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Oct 2022 16:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1664986191;
        bh=PhK3UR0JyIjrSTsOR0Bx6DOtf6gXMKKOB8Sonx5tiz4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=KchP5C3B/bSKyJExP3sQY/+S3VLkVw11Iy1MS1l0s9C/0A19/gyUC5XDRyYTROTAz
         qQ4oIcF0B3SBc3vQIl1u/VFtYIsXEq+zD57UEsyJXNDXQgMPrQQvHE+yjO1Ji/5/v/
         m0ucjs9B5g0xbf25vIx/SEsPOdHEFnPaOcawh2oX9wh+c/lKcf7Danr+Jl0Uvy7ZIM
         eaiI7clqrjE2MCgeJDRmAA2thNtubCmAcu7ryMUAzr02ecvDbMkIskQ4as4/vBW40N
         FVDwj16GupFiFCUfgtxNj2GoIyBkZsTgbgiSv68IsfoxKvNShMZfln1tGwCoF4nOGC
         CYjS4fJ2Y/8yg==
Received: by mail-oo1-f70.google.com with SMTP id y9-20020a4a6249000000b004767d77977bso9105375oog.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Oct 2022 09:09:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=PhK3UR0JyIjrSTsOR0Bx6DOtf6gXMKKOB8Sonx5tiz4=;
        b=enEqG8w67f1nJHiksnI/WWm35OHsS5TaT4xp1DS0pydhDOR8IXxYe4ZzCM6OwCACQn
         SLxEZ4hkmsD/mtlhiMPqhUGovft6bwYzNcWoKktmM86xGvpvkyNMIZnfuxsy+GuW6CK2
         roQMdn5pzjSy3D7xIJYCNvS80lg8q/LJ3UI35hHBDEChlDW7wtQZUWhUokRu9cDGw9lz
         1NTBpgWi/MC2MvJYre7VpunBFuIOwoUJDI9RkrXN8mw+VbkIUzE+jfOh/ZMqF3qg6Fal
         ZS85qDQiI39wyfUGCJUGuWrx4OqsHSVYxQHyf4OBTqPsGJfnlMq70krGVKs0VpJRjhjd
         kG8g==
X-Gm-Message-State: ACrzQf2o567x1kJlI6iUKWZZqjCEYh84kmuldTf1sNo9UAXQ7KDkfxLI
        fLFAKhTkb6fotlwJCdnXvzo7Nuu91N36pmlr3/q9sKqMlrvmYF5yNqhqgoT+eTpyjDcobwv49Rf
        pWC5r6wRpQzZVlyv0X6pXrKGItmQ9jsMBEP3Gi0MMouQ=
X-Received: by 2002:a05:6808:1294:b0:350:cdc5:894d with SMTP id a20-20020a056808129400b00350cdc5894dmr253454oiw.276.1664986188328;
        Wed, 05 Oct 2022 09:09:48 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5MMtPrl9VEi5ZyUWupTz5cDWAGQ1Rk91r1Y7Dr1gY3o6ldI48HygppwdflsAJr2bj7WCgsPA==
X-Received: by 2002:a05:6808:1294:b0:350:cdc5:894d with SMTP id a20-20020a056808129400b00350cdc5894dmr253430oiw.276.1664986188087;
        Wed, 05 Oct 2022 09:09:48 -0700 (PDT)
Received: from ?IPV6:2001:67c:1562:8007::aac:4084? ([2001:67c:1562:8007::aac:4084])
        by smtp.gmail.com with ESMTPSA id p6-20020a544606000000b00342ece494ffsm4421468oip.46.2022.10.05.09.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 09:09:47 -0700 (PDT)
Message-ID: <c9ca551b-070b-dcee-b4b4-b7fbfc33ab5d@canonical.com>
Date:   Wed, 5 Oct 2022 13:09:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] Fix race condition when exec'ing setuid files
Content-Language: es-UY, en-US
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
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13/9/22 19:03, Kees Cook wrote:
> I'll want to spend some more time studying this race, but yes, it looks
> like it should get fixed. I'm curious, though, how did you find this
> problem? It seems quite unusual to have a high-load heavily threaded
> process decide to exec.

I just got a response from our customer regarding the situation where 
this race condition occurs:


Our application is a Rust-based CLI tool that acts as a frontend to 
cloud-based testing infrastructure. In one mode of operation it uploads 
a large number of test artifacts to cloud storage, spawns compute 
instances, and then starts a VPN connection to those instances. The 
application creates the VPN connection by executing another setuid-root 
tool as a subprocess. We see that this subprocess sometimes fails to 
setuid. The "high-load heavily threaded" aspect comes from the fact that 
we're using the Tokio runtime. Each upload to cloud storage is a 
separate Tokio task (i.e. "green thread") and these are scheduled onto 
"N" OS-level threads, where N = nproc. In a large run we may upload a 
couple thousand artifacts but limit to 50 concurrent uploads. Once these 
artifact uploads complete, we typically spawn the setuid subprocess 
within 1-2 seconds.

Have you been able to look at this issue?

Thanks
	Jorge
