Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5275F6D86D3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 21:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbjDET1C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 15:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjDET1B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:27:01 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1E676A5
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 12:26:49 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-325f7b5cbacso110925ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Apr 2023 12:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680722808; x=1683314808;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n59PVxeA8v6KuiaZWIPb37+LcHproCfZdb7LlIMhepA=;
        b=Ywyo6M4Bjgt/QBo1dGoD3xA9Ke0ZSOq7tTwrHT5P1JJxemUwG5auFsjBurgydgE1qa
         kh2WcxbWgVYPXMCISvHi04PgVGouV3v77Le1XmBlhyRl2W3zFQYzsk7KksFAtrHFt9B8
         69cFS0qBf9rcIJbgGeQ6fVqM+XuqfKBEUx1aA0OqZ68CDPqvo9ybHzv0lPP142RSMlFH
         NMb5SgQe77IM82FtAwNsMVVpb7izzfjGbxcTNH488SVRugnQJJxivZmjH2z9DLNb3rgp
         debAiAZosKTDeNQcmKurVBI3qpm767LMmuSZawEYt15HX/6LxydahM6IXfSMMn+T3PPy
         twVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680722808; x=1683314808;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n59PVxeA8v6KuiaZWIPb37+LcHproCfZdb7LlIMhepA=;
        b=KZi6q8hi5kelI0LspEVWfvm9mQXgZ3sxFuTLmgg5xJyT7Xl1jOIaUyNo928TWg9miV
         Gxp/rKlH5UIHq4/mjGtqtFtK8fR0QcnyrJdPNtuwP1nTEaR3Y+VSHStWmc21KEa4//A9
         gG83R6zvBLQa8XCGC6RmasoFOfui/b8UvRqhkaB4Fh5RKJFrKk4N49gPif+dIRfvf8GK
         IObx27R3wqeYSP9yqtcfAPOpoqfdnAue3D8GRubTVgysKyBIo812lyJTq+ZipXPMvGh+
         ATalaEHr07JR70U5KdFKw4P0kk8CkrtopxPQCs+i65k8xfP5kTMcEhOy+Sr1y/lkgq5y
         N+nQ==
X-Gm-Message-State: AAQBX9csYXoErF1H2mW30x+LheoDlztl/8Mk/ZlgFVTZFwWdgSB9yMp9
        9ed/ThJmFzIP/+JISubQihxFCg==
X-Google-Smtp-Source: AKy350bLcIfDKcygslTJ6wLw+SRHKqnTOAGJg1gUEMI2g5pIL1ba92H5jZa+c/TD4aw/dTJG4rTm6Q==
X-Received: by 2002:a05:6e02:52a:b0:326:1d0a:cce6 with SMTP id h10-20020a056e02052a00b003261d0acce6mr1480142ils.0.1680722808661;
        Wed, 05 Apr 2023 12:26:48 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t15-20020a6b090f000000b007456ab7c670sm4187494ioi.41.2023.04.05.12.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 12:26:48 -0700 (PDT)
Message-ID: <43fd324c-585c-d85b-230c-5b086e1aaa2c@kernel.dk>
Date:   Wed, 5 Apr 2023 13:26:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RESEND PATCH v2] eventfd: use
 wait_event_interruptible_locked_irq() helper
Content-Language: en-US
To:     wenyang.linux@foxmail.com, Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Eric Biggers <ebiggers@google.com>, Christoph Hellwig <hch@lst.de>,
        Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>, Fu Wei <wefu@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Michal Nazarewicz <m.nazarewicz@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_16F9553E8354D950D704214D6EA407315F0A@qq.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <tencent_16F9553E8354D950D704214D6EA407315F0A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/5/23 1:20 PM, wenyang.linux@foxmail.com wrote:
> From: Wen Yang <wenyang.linux@foxmail.com>
> 
> wait_event_interruptible_locked_irq was introduced by commit 22c43c81a51e
> ("wait_event_interruptible_locked() interface"), but older code such as
> eventfd_{write,read} still uses the open code implementation.
> Inspired by commit 8120a8aadb20
> ("fs/timerfd.c: make use of wait_event_interruptible_locked_irq()"), this
> patch replaces the open code implementation with a single macro call.
> 
> No functional change intended.

Looks pretty reasonable to me. How did you test it?

-- 
Jens Axboe


