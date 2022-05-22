Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E040530543
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 20:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344657AbiEVSs1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 14:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237466AbiEVSsY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 14:48:24 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E1B13F95
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 11:48:22 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ob14-20020a17090b390e00b001dff2a43f8cso4758377pjb.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 11:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=h5L77nF2UOJAwW2O6EbrdQ3WVSJX6qCap5f74X7TE6w=;
        b=nH10B7SwKDCmN6xKdcuG0Ni0KhVLVMJwBZxUuqMca43FgtoQ7SeBbbANis7jj8Jh1l
         weynB2QLQiH2842tTfPLqarOjwo+5eNVdZiG+masoD9K50RriZ5lzS/xLW3AYNXm80TR
         /W7zgrqKBa0lN3j7OMWoH/qxwi9+H7RodnYlQ0P16UtR4Ggdn1Q2XEpbAmQ13gdgyJIA
         R/ZepuM9qw0O+d97K0chz5XmlN51UCs5jeg/4YQ2UmsC6F3gnFeJOgQcqiWyB6dJU0au
         H0cj/N6zLCY+QbLK4/OAZYwyRrWqfhkT+OHnwlvAF8zWVrtCNdF7KCxYojG56lks6PLX
         q1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h5L77nF2UOJAwW2O6EbrdQ3WVSJX6qCap5f74X7TE6w=;
        b=Lt9w8ERCpQ8eW8huSYSRY318DwMF723dTDONEkqRcacoU6aJqufKP8l/yDs4FQFewf
         20OgTNsT02kiJbo6i5kxO1D5y8BZc4lI2hJ00yOCniaqK73SMSOvQHlVt2W7Nuz1YVGf
         BcwAyCuOCkVBTNNvmpCSg2pRAUmWdmBtjMXoToRG1FVnzZ8Sqz4UAbIu19QseKju5+Ao
         taBcXJ6yNlLLyj6S7v1p3HHgIPikkoP7F5Ks5wDt8PpzSpLoQA24EQIYNrVJtKiAxYTJ
         QHTHhxGmRp0orJxrApe7JH73r4zkaSxqBizyD8pTP5BY3QXnmFKKDqnqKnaiYMUWdvG9
         G6YQ==
X-Gm-Message-State: AOAM533GKjsEkAEr5WSM/QQiM5EmcrSjfxA0CdPZc+gxwkN+sOcrN/40
        +pa3Z975Fp5unGOCW/PBQHWwqQ==
X-Google-Smtp-Source: ABdhPJxW690kHYKe3Yvp5ILJJwRUl8QZSufZZTOq0lMOSsYU6uG6czO3lire9oz9Bq7BTB+68sj6hw==
X-Received: by 2002:a17:902:a705:b0:156:9cc5:1d6f with SMTP id w5-20020a170902a70500b001569cc51d6fmr19494551plq.66.1653245302467;
        Sun, 22 May 2022 11:48:22 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z18-20020aa785d2000000b005183c6a21c8sm5490665pfn.165.2022.05.22.11.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 11:48:21 -0700 (PDT)
Message-ID: <737a889f-93b9-039f-7708-c15a21fbca2a@kernel.dk>
Date:   Sun, 22 May 2022 12:48:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
References: <Yoobb6GZPbNe7s0/@casper.infradead.org>
 <20220522114540.GA20469@lst.de>
 <e563d92f-7236-fbde-14ee-1010740a0983@kernel.dk>
 <YooxLS8Lrt6ErwIM@zeniv-ca.linux.org.uk>
 <96aa35fc-3ff7-a3a1-05b5-9fae5c9c1067@kernel.dk>
 <Yoo1q1+ZRrjBP2y3@zeniv-ca.linux.org.uk>
 <e2bb980b-42e8-27dc-cb6b-51dfb90d7e0a@kernel.dk>
 <7abc2e36-f2f3-e89c-f549-9edd6633b4a1@kernel.dk>
 <YoqAM1RnN/er6GDP@zeniv-ca.linux.org.uk>
 <41f4fba6-3ab2-32a6-28d9-8c3313e92fa5@kernel.dk>
 <YoqDTV9sa4k9b9nb@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YoqDTV9sa4k9b9nb@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/22/22 12:39 PM, Al Viro wrote:
> On Sun, May 22, 2022 at 12:29:16PM -0600, Jens Axboe wrote:
>> It was sent out as a discussion point, it's not a submission and it's by
>> no means complete (as mentioned!). If you're working on this, I'd be
>> happy to drop it, it's not like I really enjoy the iov_iter code... And
>> it sounds like you are?
> 
> *snort*
> 
> Yes, I am working on it.  As for enjoying that thing...  I'm not fond of

OK great, I'll abandon this sandbox. Let me know when you have something
to test, and I can compare some numbers between non-iter, iter,
iter-with-ubuf.

> forests of macros, to put it mildly.  Even in the trimmed form it still
> stinks, and places like copy_page_to_iter for iovec are still fucking
> awful wrt misguided microoptimization attempts - mine, at that, so I've
> nobody else to curse ;-/

And it's not even clear which ones won't work with the generic variants,
and which ones are just an optimization. I suspect a lot of the icache
bloat from this just makes things worse...

-- 
Jens Axboe

