Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8D572BC2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 11:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbjFLJZq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 05:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbjFLJZG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:25:06 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABD75275;
        Mon, 12 Jun 2023 02:18:58 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-543b599054dso2163821a12.1;
        Mon, 12 Jun 2023 02:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686561538; x=1689153538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=56hYYf8/niJPL9eic7EYj8DJ8VSbwm4l2B7afO9y+nA=;
        b=pX7usVRf1w2EJ16eK6V5WoNtJG3nNgNXKur0oo/SQ6Zo5pkdLRKPmd35TDVq6ADRZj
         r0ysItIxRLl4Aa2cW6VOm1dhK+f9/L0XlV3v8ftrQlN7H/TITlD/f0p2wVGwL82yp1Cd
         cYjS/zZcSpx4CqBE46VM79wDMawXb3jAId1pKXtgT1oJI1j1WoLKiDEnwmMCc9PUHjOv
         n8dnqsOj1ff3H+5spBHXkIpTqnwJ3PWYsMHfT0DmkiIUYSJYVswwkYA5vQ8r+sGhs9pC
         DoOgxLuFUXhw1npLWsSG+I7FDNxCmmBQQWyeCoBVm5DCKGPddUHhzl7bmF8bStcOUlYO
         4D0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686561538; x=1689153538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=56hYYf8/niJPL9eic7EYj8DJ8VSbwm4l2B7afO9y+nA=;
        b=iia9uRmQt6OCoZ9Jr4jiFmDrbZGF4pz+ZKkqh7yRm0HwAnTgy8aIA4YcMZdbdBXRtF
         sZwXNeIOYceGZxVYUgAjRH1MoqDxCQ61Psx+AJVGzRPDXkyPuYvmvBEGv4K5p2SCo9UT
         JVztepQ1Q7UEjhKt6Egi5YT8mbPHdoOmtn/3SBdveTaRdi+akoWBriItwihV+A9GmGuY
         W9xSnvVybjHhoBF1U19cmz4CjC11gVJk6lfsICh5jK3El6k0R8BT2QuT0q972GpSd18f
         Ww3J47k6X+rYMgMGSl8AaBS5wT/RtlHDZY9NQXp/YTR3jYjHJ/rxmZDD0WVMe7roQH9G
         B+5g==
X-Gm-Message-State: AC+VfDxV19MDVQNYtdQR7MddmcuhsgpdORzu9sEC4V05OYj83+qoZXzR
        FHZHyiErNhhU4sBOpQvHdKVto6W5O7E=
X-Google-Smtp-Source: ACHHUZ6RsPMRf2bOn3Qf0yt2Mb/O1rCwADRjRgIxl4eHPwbFUO8J8bwYvTjsDN0Vx0J/liLeu6vOww==
X-Received: by 2002:a17:90a:357:b0:252:7372:460c with SMTP id 23-20020a17090a035700b002527372460cmr10169953pjf.4.1686561537668;
        Mon, 12 Jun 2023 02:18:57 -0700 (PDT)
Received: from [192.168.0.103] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a194300b0025b83c6227asm6274016pjh.3.2023.06.12.02.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 02:18:57 -0700 (PDT)
Message-ID: <6ffd4b42-f106-6030-d6b8-30e2db1e1019@gmail.com>
Date:   Mon, 12 Jun 2023 16:18:49 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] fs: Fix comment typo
To:     Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mao Zhu <zhumao001@208suo.com>
References: <20230611123314.5282-1-dengshaomin@cdjrlc.com>
 <ZIXEHHvkJVlmE_c4@debian.me> <87edmhok1h.fsf@meer.lwn.net>
 <20230612-kabarett-vinylplatte-6e3843cd76a3@brauner>
 <20230612-daran-erhitzen-b839f13a6134@brauner>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230612-daran-erhitzen-b839f13a6134@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/12/23 15:34, Christian Brauner wrote:
>> Patch picked up and missing sender SOB added.
> 
> I've been informed that I may not be allowed to do that.
> So dropping the sender SOB for now following willy's argument.

OK, thanks for resolving!

-- 
An old man doll... just what I always wanted! - Clara

