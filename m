Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22561E94F1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 May 2020 03:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbgEaB5u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 May 2020 21:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729026AbgEaB5t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 May 2020 21:57:49 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3DCC03E969
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2020 18:57:48 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id q8so1802503pfu.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2020 18:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/WemXoImhsNurvgvrjEvBKKt3N1OcqQaztjA3rpMsOA=;
        b=ofpa0GRSc19UCmmYAeJ1gtOd8ud77uSLXoC08oedhK8bjrfrzl8EngvyEIrG7O6r8a
         NTVckZLNnM1BaFZ2pEkdOq4k3dioXPAbN8oKyUcZvCHIfsnlpd+xxEMoFFqTmiP1D4Ba
         fzj1VEnxhxHiTuHBEmN+aDc9ctAMh2HuAsDSjAYXqgF6WYtQpPcDv6qTsO6dYzk5Ysbj
         1z+ctmnbNik5+6DsIBoZBLd9dL49RSaIuDUOzb1+jg9/8j8p2ZWmyQvabuIvYkIc6GyU
         xeJbaKTZUcxCI9a1YTz0RJLt2oO9CQlhUbLHAILywxh1pmFk8vCRsy6VDrE4MBsCMQMj
         f+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/WemXoImhsNurvgvrjEvBKKt3N1OcqQaztjA3rpMsOA=;
        b=kc7Y+CcUkzJnJ8B7bc3sgwn02Q1kvmp6zA5Akmk/A2nV4Nr64lxWuPQIQWqd05bJxx
         Ih9UK0rpOz+Zp54RoZT8K2KGHk7j/5gGgwjVUff7JMBA3FqZHYATL0CktNs7ck5fDfcM
         8pOed+ZsqkQiCIM9fGU4gUBA0t2iW5xzoEdSiT2wM2TdS2rBW2KSwArlCaAnSufNGGAq
         oS1H3WFRy3HEmirNN1hqfFD+9jp2je9QPwgHSyCOEixpdi9m1ffRQrjQVWhrfKNC90AP
         b+7KJdfOTiIMuHUq4tNdwk7swscYEN3a93Dvf8/c69xCLVQeKrq/Zqsx9hMdxeU/EAgD
         b9pA==
X-Gm-Message-State: AOAM533ei9IIRsudbVduqL5lOAxZNufKSjvUgoXadNrNNTnQAmjP7pq3
        C39lpa5v7pVkLaJ/CjtNwnBCQMne/b1P9A==
X-Google-Smtp-Source: ABdhPJw6sUzC2QmIdh/46N6SW7kJ6geIM+mogd6Zf0NHPly6gKiWjN/PHRTVUbAl2wQ1IE2MhqWBpA==
X-Received: by 2002:a63:f854:: with SMTP id v20mr14543363pgj.0.1590890267589;
        Sat, 30 May 2020 18:57:47 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id k12sm10444543pfg.177.2020.05.30.18.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2020 18:57:46 -0700 (PDT)
Subject: Re: [PATCHSET v5 0/12] Add support for async buffered reads
To:     sedat.dilek@gmail.com
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
References: <20200526195123.29053-1-axboe@kernel.dk>
 <CA+icZUWfX+QmroE6j74C7o-BdfMF5=6PdYrA=5W_JCKddqkJgQ@mail.gmail.com>
 <bab2d6f8-4c65-be21-6a8e-29b76c06807d@kernel.dk>
 <CA+icZUUgazqLRwnbQgFPhCa5vAsAvJhjCGMYs7KYBZgA04mSyw@mail.gmail.com>
 <CA+icZUUwz5TPpT_zS=P4MZBDzzrAcFvZMUce8mJu8M1C7KNO5A@mail.gmail.com>
 <CA+icZUVJT8X3zyafrgbkJppsp4nJEKaLjYNs1kX8H+aY1Y10Qw@mail.gmail.com>
 <CA+icZUWHOYcGUpw4gfT7xP2Twr15YbyXiWA_=Mc+f7NgzZCETw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <230d3380-0269-d113-2c32-6e4fb94b79b8@kernel.dk>
Date:   Sat, 30 May 2020 19:57:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CA+icZUWHOYcGUpw4gfT7xP2Twr15YbyXiWA_=Mc+f7NgzZCETw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/30/20 12:57 PM, Sedat Dilek wrote:
> Here are the numbers with your patchset:
> 
> # cat systemd-analyze-time_5.7.0-rc7-4-amd64-clang_2nd-try.txt
> Startup finished in 7.229s (kernel) + 1min 18.304s (userspace) = 1min 25.534s
> graphical.target reached after 1min 18.286s in userspace

Can you see if this makes a difference?

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index c296463c15eb..ccb895f911b1 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -374,8 +374,7 @@ enum req_flag_bits {
 #define REQ_INTEGRITY		(1ULL << __REQ_INTEGRITY)
 #define REQ_FUA			(1ULL << __REQ_FUA)
 #define REQ_PREFLUSH		(1ULL << __REQ_PREFLUSH)
-#define REQ_RAHEAD		\
-	((1ULL << __REQ_RAHEAD) | (1ULL << __REQ_NOWAIT))
+#define REQ_RAHEAD		(1ULL << __REQ_RAHEAD)
 #define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)
 #define REQ_NOWAIT		(1ULL << __REQ_NOWAIT)
 #define REQ_CGROUP_PUNT		(1ULL << __REQ_CGROUP_PUNT)

-- 
Jens Axboe

