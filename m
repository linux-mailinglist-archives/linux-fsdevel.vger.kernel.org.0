Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED397AFC1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 09:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjI0HdD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 03:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjI0HdC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:33:02 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADFF11D
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 00:33:00 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5331059360fso2361334a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 00:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1695799979; x=1696404779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N6pnQ/nkWf6SlVjQP06zaUKvsstL6MZ5VotIaFF9d2I=;
        b=uRt/ZFptGMXXYi70mRQrFk8G/hEjGXSLfR2cj4d8jUrNA2tYDlwMTHKC2bpR49wzdC
         mrHNZWYwsfiaDEwlIuZDRmxtHIlKrhEJ4ZVConR5WXAwT9aAtRhLeibWbUZD3yOy7+kC
         O8HkrmdJQm2r4oU/uahfC/O+pe9dnMp+CONofJjZunsDW/v8b6yE50NAxgHtVahGrYXU
         UZ3OVEnXNsEIdS6bsJve2EGmjWGAJYNyxmNcWn0X8i3oAhNj0MwYIwq7DN2Il/aV7gWw
         9h08d2oIVZbWNZ4IW2GR3KbtfR8JYk/HXzWQ/ZV+NLle5O265a7t9ASuqEpl7wDIkfVn
         DS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695799979; x=1696404779;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N6pnQ/nkWf6SlVjQP06zaUKvsstL6MZ5VotIaFF9d2I=;
        b=pVG1B4atF0g5dqa7sAqQykukdHZVDCs31bqzhm7Bq0i30RM1sTYJFSomYutyIpx0Pz
         oQJqf5ycuUohtX35FJO/DPuhSnPCThPyJS3ryj/oi16IGsB1VzWLxPXhOzjBkPTWjCHG
         Pqr2SKWhdkiUEq0CWnWcOURkPBfqmKLVpJ5hv3exZiQtxlMpfSTvj6I6pxbRLZdCxvcB
         2BGqk/68uSq8sT2SHcXtnqfnY+2CZJSUZHNfg8bEt0Jh7tFmX2w1J7OdENBBLloNK7uh
         MusKO63XG/Lzx8k7ArEX27yl26sb6g1jyjNAb5lR2Z/q2Wc0rS3ejWZJQWStAfgfKb/O
         ssRQ==
X-Gm-Message-State: AOJu0Yy2BpwC5rxRNPSU7ySP4dDFcP7Ug/ZUJYO6ctlxhZDUV+CrOHyR
        dvuVAVqemzRNw2Vv2r1+GhVIjA==
X-Google-Smtp-Source: AGHT+IGl72HpxcGf5R00MKAx7plEYQqRg+QmVRuv6Lb/FKmepMGYWsDUH1yEvJs+hzYAD7rsBF42tA==
X-Received: by 2002:a05:6402:4409:b0:523:4069:182c with SMTP id y9-20020a056402440900b005234069182cmr1224456eda.2.1695799978682;
        Wed, 27 Sep 2023 00:32:58 -0700 (PDT)
Received: from [172.20.13.88] ([45.147.210.162])
        by smtp.gmail.com with ESMTPSA id w22-20020a056402071600b0052e1783ab25sm7692376edx.70.2023.09.27.00.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 00:32:57 -0700 (PDT)
Message-ID: <ff95e764-9e61-4204-8024-42f15c34f084@kernel.dk>
Date:   Wed, 27 Sep 2023 01:32:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eventfd: move 'eventfd-count' printing out of spinlock
Content-Language: en-US
To:     wenyang.linux@foxmail.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_6E80209FC9C7F45EE61E3FB3E7952A226A07@qq.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <tencent_6E80209FC9C7F45EE61E3FB3E7952A226A07@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/26/23 8:05 AM, wenyang.linux@foxmail.com wrote:
> From: Wen Yang <wenyang.linux@foxmail.com>
> 
> It is better to print debug messages outside of the wqh.lock
> spinlock where possible.

Does it really matter for fdinfo? Your commit message is a bit
light, so I'm having to guess whether this is fixing a real issue
for you, or if it's just a drive-by observation.

-- 
Jens Axboe


