Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F954D25E4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 02:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiCIBOO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 20:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiCIBMv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:12:51 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC56613D550
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 16:55:24 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id lj8-20020a17090b344800b001bfaa46bca3so622744pjb.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Mar 2022 16:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=TSJygurfY607jvzpaSXbGkChO2r02RRc4zcT8idFGSc=;
        b=cQj5MIXnnya8S4VuATtZHow3Gb7EiUuI/OjHbe4Bsz6nWy6G0t+5bypUdRMHtyDyqv
         0+m047whb+wGAaimM0vhqdm7fHE2tK7e8v4MVMOHyevRhE0Ekma2X7+vVuYJzUQzBxpg
         igFv6lDEkbUr5HIsAwfE81MjZaPPKYxQhxuHQAntNEYj9UfnCRS5/JFQ/UUwM0e4XYOi
         1Y55fztpUG/ZzqjfLMbFkiRI5c6QHvPbIRyAFN9d2XCdb6R/Ud/CQK5iMUGGgkB7eOlR
         7f1UTVAhJCnEsUjpykO6HRnSTzwIP7w6kTV4dHA9oAHljTpNn/dqezd7EXa8/J+2teX2
         lZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=TSJygurfY607jvzpaSXbGkChO2r02RRc4zcT8idFGSc=;
        b=ITOA/3Ynz8/Rtvyqn28a3QfZiJkQDI8+YEe2YF54h9JZMlGjFWQMAciprw6dEughL6
         Jgn+GB5sG7FP1B4c6Sbs4EfHyRINdnb5jHDcF/2kXAjhdzPb6Gb5MFx88mGTJjkigBlU
         E9a4Ty2GR04BIOfV8jnV32oMaw45BigJ1HxuPwLYSdbW6y6JPYdxfyznWFSBMJ4336zD
         LRbcCdf/zRZc7ptHgI2f03AUFWsTQvf7DYbLkdRAco8Dl/VaNHqUcWHwtjlucg4q4HPJ
         pmBMZXEe0swRkRMy/oM8WT7zwIuvV+pAin/JXoEs1cUFzfpsq7JQarlbTI4qNTaPEi/k
         elYA==
X-Gm-Message-State: AOAM533GTjuOyT+QwAvsntHW40YZikXPYVvmCnhhKMORnxvB+ONGLMP5
        uFU8cwhNAfj11BxlDaXBjzO5wg==
X-Google-Smtp-Source: ABdhPJzfqta+y5PFpcb2NM6oBxTMwg6z2yK87C1eg5Zj+O7aeUBAto+BmzlkGOcXJ73dc5f0rNRmPw==
X-Received: by 2002:a17:90a:4682:b0:1bc:236:7e46 with SMTP id z2-20020a17090a468200b001bc02367e46mr7473627pjf.212.1646787324421;
        Tue, 08 Mar 2022 16:55:24 -0800 (PST)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00130900b004f73df40914sm299756pfu.82.2022.03.08.16.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 16:55:23 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20220308060529.736277-2-hch@lst.de>
References: <20220308060529.736277-1-hch@lst.de> <20220308060529.736277-2-hch@lst.de>
Subject: Re: [PATCH 1/2] fs: remove kiocb.ki_hint
Message-Id: <164678732353.405180.15951772868993926898.b4-ty@kernel.dk>
Date:   Tue, 08 Mar 2022 17:55:23 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 8 Mar 2022 07:05:28 +0100, Christoph Hellwig wrote:
> This field is entirely unused now except for a tracepoint in f2fs, so
> remove it.
> 
> 

Applied, thanks!

[1/2] fs: remove kiocb.ki_hint
      commit: 41d36a9f3e5336f5b48c3adba0777b8e217020d7
[2/2] fs: remove fs.f_write_hint
      commit: 7b12e49669c99f63bc12351c57e581f1f14d4adf

Best regards,
-- 
Jens Axboe


