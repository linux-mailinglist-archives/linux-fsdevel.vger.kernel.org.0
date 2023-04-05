Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A1D6D876E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 21:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjDETzC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 15:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbjDETzC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:55:02 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE0119B
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 12:54:59 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7589c3519bfso1522939f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Apr 2023 12:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680724498; x=1683316498;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VQhohcoSfZ+TXrTocJ4dFpG6ihZhTRmLCl7ysvHMbVU=;
        b=FhKhafVmcp7gRPH9mLZ6WMv1WP6cwFfcSTpdwK1fJgcTI7MMQ2QM2IA9Dg60YmBtmh
         oP7SIiv5orRC+LEgE6uEWQrjd30KMJj2TFfuOhMbnh0FpPtNwyV7LSVHj4/QGPP4FHC1
         XM1wc7q1S5aJaN0A/e+ZOHgIecq4UhvgtlPpCXSPBTunwhXxW7qQh391dlff3lWI6upj
         vqgDpTNl3QbmlNJ51Hlt/LLkJYKNOJ1OhdXbGIHV9IvSS2tR/bK4YSs26/T8LHY8XZR6
         1hdaUFQZN+dDV/gqj+3Eoz/y29mQw3sxvVyaJFwzgMxoJYjk1QJUCF94oWvs8UHzpWHh
         FcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680724498; x=1683316498;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQhohcoSfZ+TXrTocJ4dFpG6ihZhTRmLCl7ysvHMbVU=;
        b=vjoK16mUaQOpQeAJMA+Tnx0cYJGcfnduiF+cwXegEXeIwuL4ybbx9R6eijJa3mFcpz
         7UMAyQcEhvHyf+pn7sg2NUtSVGCRYncc0sZBk9aWZXZkEPfxXsmjZ3BgrpMpzipQctmw
         MaDGz5vOTH6TmqXC7gtOxVbGjgbdi4M1usB7WjxFmMbzg5BtmozbbHu2iW/clKOBfLei
         q0ZpUbyY7RfQWQ7axsRjRgUfNJFVNqqr88UNHDQfrd6pjfTYh4UqPf8bwRIvjya29C5M
         huJ8D6dbJFpeeBKnDrQPVDSXHVeBt8T9qjQ1EAQMpQhMNSv3QUljgogIAmuCGwuGY1Dl
         7w+w==
X-Gm-Message-State: AAQBX9dxPUrnSEL/sNPAsKc1LeWg4VaWb117iT1FHVXl00yInq927JIq
        +jhKJQYWOebk3eR3ueS94p744g==
X-Google-Smtp-Source: AKy350YUu/y57XeMmrwciQfeApPTgA/J9vVl+orfxC6zXtuDbf6ys2L0P8ouilkvuX4zyCz+OzcdCA==
X-Received: by 2002:a05:6e02:bee:b0:319:5431:5d5b with SMTP id d14-20020a056e020bee00b0031954315d5bmr1537610ilu.1.1680724498566;
        Wed, 05 Apr 2023 12:54:58 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id z3-20020a029383000000b004062e2fdf23sm4140975jah.74.2023.04.05.12.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 12:54:58 -0700 (PDT)
Message-ID: <f539e49e-d831-2ab1-6344-f37f909895ea@kernel.dk>
Date:   Wed, 5 Apr 2023 13:54:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RESEND PATCH v2] eventfd: use
 wait_event_interruptible_locked_irq() helper
Content-Language: en-US
To:     Wen Yang <wenyang.linux@foxmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Eric Biggers <ebiggers@google.com>, Christoph Hellwig <hch@lst.de>,
        Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>, Fu Wei <wefu@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Michal Nazarewicz <m.nazarewicz@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
References: <tencent_16F9553E8354D950D704214D6EA407315F0A@qq.com>
 <43fd324c-585c-d85b-230c-5b086e1aaa2c@kernel.dk>
 <tencent_1A9532B54AD0FB644D7A28B39C5FF9B34506@qq.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <tencent_1A9532B54AD0FB644D7A28B39C5FF9B34506@qq.com>
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

On 4/5/23 1:40 PM, Wen Yang wrote:
> 
> 在 2023/4/6 03:26, Jens Axboe 写道:
>> On 4/5/23 1:20 PM, wenyang.linux@foxmail.com wrote:
>>> From: Wen Yang <wenyang.linux@foxmail.com>
>>>
>>> wait_event_interruptible_locked_irq was introduced by commit 22c43c81a51e
>>> ("wait_event_interruptible_locked() interface"), but older code such as
>>> eventfd_{write,read} still uses the open code implementation.
>>> Inspired by commit 8120a8aadb20
>>> ("fs/timerfd.c: make use of wait_event_interruptible_locked_irq()"), this
>>> patch replaces the open code implementation with a single macro call.
>>>
>>> No functional change intended.
>> Looks pretty reasonable to me. How did you test it?
>>
> Thanks.
> 
> We have verified it in some local testing environments, and the intel-lab-lkp has also tested it more than a month, as follows:
> 
> https://github.com/intel-lab-lkp/linux/tree/wenyang-linux-foxmail-com/eventfd-use-wait_event_interruptible_locked_irq-helper/20230217-023039

Nice, you can add my:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

to it as well. Adding Christian as well, as I guess this should go
through his/al/vfs tree.

-- 
Jens Axboe


