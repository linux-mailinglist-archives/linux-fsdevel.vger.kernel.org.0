Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6860623811
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Nov 2022 01:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbiKJAU1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 19:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbiKJAUZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 19:20:25 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E005B19295
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Nov 2022 16:20:24 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id o13so282832ilc.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Nov 2022 16:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PdFYulGACxTBTojRfxds21KOSZfXv6ZXKjdlh8F/TT0=;
        b=hadAKdEVVNddopV6y5uk8jfY0cQtgbWzOomvYvbVMEWHi5XVN5jJ/j8FAG6X8mD0Cc
         zgHbVLE59CupdvJApSx7YHPWOJ9s/INF5RwtTIwN7wmcXSKuHYo44OoweecAj8l1pUdX
         ejaKIg/DVDL8sHAGYBfrVIiWqOGSw3usaLCr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PdFYulGACxTBTojRfxds21KOSZfXv6ZXKjdlh8F/TT0=;
        b=TOzL7WhAV5A4pNHLW74ffX2r5Ky3hVErJcri33DU4SefOesg1PSZ4bWvi3JReQXgZf
         XkGeEbPFCJl1Y9w4Mk5tW73jyFIgXYRWgqaGObkfuuILKfIlm3aFhcz/rDHgUg9vGUFA
         jNizpcWVuJggWJ3xyAA2Qc7IZkEm9bvVL+MyMpq0N3KFsovJluq6CGY8Yp/q9F2PeLCO
         Fu0oTnTCFhsqUi2Lwh/F7OTmUCsW6aCPvHwgiimKwUZc5iDWubRkUtfmV4dylA1NI4dK
         4ahhUjUaRkXmZkbgzPxaWg4N4uywGzuIRARc/E8Vtv2Ne9l6mhLyvWMooqA1L19UqjBD
         9EtA==
X-Gm-Message-State: ANoB5pmaoGAFezPDqgn8uTfO2N2WBq5O6mgk94xEZNpQxioiQv0ENzhy
        xBF0y+dDFOo7tmiQVxb4quRpbA==
X-Google-Smtp-Source: AA0mqf5Zpjji+6OnLlbCTaIgGmkb3Kcg0jyt5KohGqkNBJdcb0bRILv5GeRr4eeV/cBGlrNV/CxOZw==
X-Received: by 2002:a05:6e02:1b02:b0:302:161:8c82 with SMTP id i2-20020a056e021b0200b0030201618c82mr12627340ilv.296.1668039624289;
        Wed, 09 Nov 2022 16:20:24 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id r20-20020a02b114000000b00363781b551csm5291449jah.146.2022.11.09.16.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 16:20:23 -0800 (PST)
Message-ID: <6b6cd1e2-3ab7-eede-e04b-738bbcbb5760@linuxfoundation.org>
Date:   Wed, 9 Nov 2022 17:20:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] selftests: proc: Fix proc-empty-vm build error on
 non x86_64
Content-Language: en-US
To:     Punit Agrawal <punit.agrawal@bytedance.com>,
        akpm@linux-foundation.org, shuah@kernel.org
Cc:     adobriyan@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221109221104.1797802-1-punit.agrawal@bytedance.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221109221104.1797802-1-punit.agrawal@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/9/22 15:11, Punit Agrawal wrote:
> The proc-empty-vm test is implemented for x86_64 and fails to build
> for other architectures. Rather then emitting a compiler error it
> would be preferable to only build the test on supported architectures.
> 
> Mark proc-empty-vm as a test for x86_64 and customise the Makefile to
> build it only when building for this target architecture.
> 
> Fixes: 5bc73bb3451b ("proc: test how it holds up with mapping'less process")
> Signed-off-by: Punit Agrawal <punit.agrawal@bytedance.com>
> ---
> v1 -> v2
> * Fixed missing compilation on x86_64
> 
> Previous version
> * https://lore.kernel.org/all/20221109110621.1791999-1-punit.agrawal@bytedance.com/
> 
> tools/testing/selftests/proc/Makefile | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
> index cd95369254c0..743aaa0cdd52 100644
> --- a/tools/testing/selftests/proc/Makefile
> +++ b/tools/testing/selftests/proc/Makefile
> @@ -1,14 +1,16 @@
>   # SPDX-License-Identifier: GPL-2.0-only
> +
> +# When ARCH not overridden for crosscompiling, lookup machine
> +ARCH ?= $(shell uname -m 2>/dev/null || echo not)
> +
>   CFLAGS += -Wall -O2 -Wno-unused-function
>   CFLAGS += -D_GNU_SOURCE
>   LDFLAGS += -pthread
>   
> -TEST_GEN_PROGS :=
>   TEST_GEN_PROGS += fd-001-lookup
>   TEST_GEN_PROGS += fd-002-posix-eq
>   TEST_GEN_PROGS += fd-003-kthread
>   TEST_GEN_PROGS += proc-loadavg-001
> -TEST_GEN_PROGS += proc-empty-vm
>   TEST_GEN_PROGS += proc-pid-vm
>   TEST_GEN_PROGS += proc-self-map-files-001
>   TEST_GEN_PROGS += proc-self-map-files-002
> @@ -26,4 +28,8 @@ TEST_GEN_PROGS += thread-self
>   TEST_GEN_PROGS += proc-multiple-procfs
>   TEST_GEN_PROGS += proc-fsconfig-hidepid
>   
> +TEST_GEN_PROGS_x86_64 += proc-empty-vm

Why do you need this? You already have conditional compiles.
Conditionally add proc-empty-vm to TEST_GEN_PROGS like other
tests do.

> +
> +TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(ARCH))
> +
>   include ../lib.mk

Same question Andrews asked you. What does it take to get this
to work on other architectures. proc and vm tests should be
arch. agnostic as a rule unless it is absolutely necessary to
have them acrh. aware.

thanks,
-- Shuah

thanks,
-- Shuah
