Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B3B6230F2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Nov 2022 18:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiKIRC2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 12:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiKIRBN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:01:13 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D212E24F12;
        Wed,  9 Nov 2022 08:59:35 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id v17so28091765edc.8;
        Wed, 09 Nov 2022 08:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X6qC3u7TJCJ9WDjpawDLknUJdFq/gXX99rp9XUruyx4=;
        b=RaIY/b1BcdnSf71S65QtqaF9vC+Ze5b9z5MN8vdB70KjGn6145Bq+mPgBFV1ZwUZG4
         gMyTQ4oM5ctg8UPCNzdZxqfwtlaGG4aQljI2d+2cQQDjTpIimdM6UkrB7Y+GfF4xD8Ha
         LT/7oXVoBiiqhpglRiXp+Tee3pTRkZqnBxHpP/HQg5twfq63hruMXDErjrYlVLE5jRMs
         wSV1IgFdhJiHRPPHv/nu1LRIYvUnUG+t2rRD3U3gdKiw6ER6ohlZxYHemB3TIhSuBRmZ
         vTpPuji5CPlP7dkB020qnV9OQMbFOXwhrjQxU5IasODsjiYNY2/4DQ0YIGFq5rpL9G5Q
         NTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6qC3u7TJCJ9WDjpawDLknUJdFq/gXX99rp9XUruyx4=;
        b=F7V1YD+mGIOgFk/3yFZIN92jyBx5U2PK3USozVNX2Wp/nr12dcNywxSmErGfqazeRa
         WPb0HPa65IRXIT/D2b7OpPE7BjGEAxY/tWbTUnp18h16xOaWf/T4l/JY18gJfoJXY7RV
         IusdOyhEXb10pK/6rLmEX0YHAZ9jzuPrzbbl26MXClsLuQEYGV5GBpMDHs5ocKnReF++
         xrN98/4M6sfT5mL91mur0k/1querjI4mOoM65Ov401Bh3q+LSrqgOGC+iGCtJ6jqQU4F
         iiHzSV9fqJFjP13WMiw84ZzW6cRr6sN2vGBbi5KiCbMzjwm/Jsn0sllcw4wa2WoFTnC3
         wcnA==
X-Gm-Message-State: ACrzQf20yyF1L8ZazeRXuvPWe0U0Wl0JjxmDVQVakr7OnHxU+CHliKnA
        H3baK7wOKK/G6fCCTWah7g==
X-Google-Smtp-Source: AMsMyM4FY5pa6wC/HNfGW1du6dUafsGlho/DlEOMXq1QxFkTr/XMBmamE1DYuzbjWYmMqGT4hSkdmw==
X-Received: by 2002:aa7:cf0b:0:b0:461:2271:8559 with SMTP id a11-20020aa7cf0b000000b0046122718559mr60860684edy.92.1668013174332;
        Wed, 09 Nov 2022 08:59:34 -0800 (PST)
Received: from p183 ([46.53.251.133])
        by smtp.gmail.com with ESMTPSA id n20-20020a05640204d400b004588ef795easm7245157edw.34.2022.11.09.08.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 08:59:33 -0800 (PST)
Date:   Wed, 9 Nov 2022 19:59:31 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Punit Agrawal <punit.agrawal@bytedance.com>
Cc:     akpm@linux-foundation.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: proc: Fix proc-empty-vm build error on non
 x86_64
Message-ID: <Y2vcc00tszEg7Ljz@p183>
References: <20221109110621.1791999-1-punit.agrawal@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221109110621.1791999-1-punit.agrawal@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 09, 2022 at 11:06:21AM +0000, Punit Agrawal wrote:
> The proc-empty-vm test is implemented for x86_64 and fails to build
> for other architectures. Rather then emitting a compiler error it
> would be preferable to only build the test on supported architectures.

Ehh, can you just port it to whatever arch you're using?
What's the address space on arm/arm64?

	#ifdef __amd64__
                munmap(NULL, ((size_t)1 << 47) - 4096);
	#else
	#error "implement 'unmap everything'"
	#endif

This program is almost arch-independent.

> +TEST_GEN_PROGS_x86_64 += proc-empty-vm
