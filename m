Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC88591B01
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Aug 2022 16:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239638AbiHMOdu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Aug 2022 10:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239622AbiHMOdl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Aug 2022 10:33:41 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539252E9E9
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Aug 2022 07:33:39 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d10so3000972plr.6
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Aug 2022 07:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=oGDoPSwTJYgAdoMJ+kZiCfF7XxCQIGieO3gROB11DDE=;
        b=vJvtbTGJnRgtMQsWTZ6Qbypd0syVkchXxLMs3E+W9PXyfBih2lXOlPnaWXrHLT4IAP
         dZ5jiwghUqSyif9LIIIQp0nIxGZP+vUrDCrDcJK87PbvEE/sjJUXMtEiRIeDWaK+cX28
         RBYQdnKYlgHCdgPTxHdQSgBRknQvKQKldI9OM0ZAXGe3Z7r12YnFY6nLQ1HmJMyq2Nf7
         GCiDJv/z+15ClQutb8rSDc4w4pB1mbyP/pHtMR1g0SgHLyJ/y4xEIDbYDgEzeSZ2aHFv
         YVMXZcSUvAa5ZE+mCDaa3XfWEFPSC5zOvSAaBMRHJuwX7shWuzO3B5UE2rtm7n4qZ+E3
         Vntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=oGDoPSwTJYgAdoMJ+kZiCfF7XxCQIGieO3gROB11DDE=;
        b=Nw8FyYCPGchLGTcD+mUG49WEqNhjvh3OWdxdjtljx7JEIRn4K584glOepEU/Mi8TLZ
         ySWwZHoKnGAQFUWMstqh6G3VuDJjbsYH6hH4ohN3pVz29kfT8KK8lUnIS319QRgntAG/
         qMZyKbgooA42uBbi95vYLG5z1RK+G4QWTP/l/G1LZTilYtGFXWOHLBlWj/03Jy46rw1W
         WI2+AzyZnKXLpiYX0FOWlmU8ieIHRnQ6RU+w7T/ciIplebUu+kGtCpFpoL613w8KsnGj
         Mll+eqdRAGbkub26hMXI5G9M43TLyBfP0DpdgLFUcMgbECiK2rSdl4SO9wrJZSSM5A9K
         dYVw==
X-Gm-Message-State: ACgBeo00OamnHsCPa3y780eog3RDkmyeHbgovQMURLB83REhgrxMnObI
        LebBpI5P06t96s6cVHIQZqJxiw==
X-Google-Smtp-Source: AA6agR4pF+ulVNiCuFvbDcaHxBzt9kni8JCk8vWLmWDXeDM7CFJeSOAwesj0iY8kMuQey+M02srN9A==
X-Received: by 2002:a17:902:ea03:b0:170:a235:b72b with SMTP id s3-20020a170902ea0300b00170a235b72bmr8833259plg.13.1660401218763;
        Sat, 13 Aug 2022 07:33:38 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902e54400b0016dbaf3ff2esm3800879plf.22.2022.08.13.07.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Aug 2022 07:33:38 -0700 (PDT)
Message-ID: <f93b320a-15ed-0673-e91d-b59964106663@kernel.dk>
Date:   Sat, 13 Aug 2022 08:33:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] fs: don't randomized kiocb fields
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@fb.com>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220812225633.3287847-1-kbusch@fb.com>
 <YvdZ6X4Bf6A1uisS@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YvdZ6X4Bf6A1uisS@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/13/22 1:59 AM, Christoph Hellwig wrote:
> s/randomized/randomize/
> 
> in the subject?

I did notice that one and made the edit yesterday.

-- 
Jens Axboe

