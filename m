Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8A33A21D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 03:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhFJBWo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Jun 2021 21:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFJBWo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Jun 2021 21:22:44 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD9FC061574;
        Wed,  9 Jun 2021 18:20:40 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id g12so13856238qvx.12;
        Wed, 09 Jun 2021 18:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rdv0XyzMKXIBvWW4vM5wittWacdm2kSMsiOZU/lgLnc=;
        b=Clki2Lp9G3R0o5AL0jTiabTeUaA75I/ij+Th+Ed6Ln993tk0JaYMF/caLt45ULngHk
         8oNJWJhM3ZZJh0uXEw6LpB24lPUOEX3GDNjDnoIR/gjm4iUTXPg7VWQMfYy//ZqyrIzG
         qGwukCuMn4zKBzRokQDgjozIIf0AYwIdmDW8k0gej3kpRapPXAynBptmTAaGD6pP11yJ
         CE7XDyMc+/zsMneY6AQK7M0cSn8qNHnb+ckpXtgpW7TH00WWgXxtER/EUVnRcWJDgj12
         MsseKbVp3P5qnEUsFfRDX63VcDocjPXYpxTDPzY+XpESZjnPWkDxHtUQIt/ZIc4P/JDF
         chuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rdv0XyzMKXIBvWW4vM5wittWacdm2kSMsiOZU/lgLnc=;
        b=AbQUmh4IrLTtUB2ehEfj65D8EX5RZYbexUPqzWnKGIa1uln69X22k3Da2we4V+lKPc
         ynH2/Yg8AcJdCx3KQkfeKxijRuTehNUHCfk4e7C6PiXhWLcn1B/Q1dlzDaMkRebG70VG
         /xRyDjxZ5qZFy4mLE+PgW/knTfaQx1UNiUyB8csGo/a4ktiKJNij1IJLfz2uOswpseUb
         PYMLCeQxN0IzP5cJACeNZkHZTIWEdfbJEr1N5QuMmd8TZdYeH/QJNVGwHfqJfgTRbJ2N
         cKtz1Qdgb3t6q6VZG2zexE4dFn6Vj1HRfKfKf2YaH/3c3NT9hO89s9hTVxRhv2OjBM/V
         ssKg==
X-Gm-Message-State: AOAM533kT12rIiwWyguQUmW+bDe31t1MWWWIQbHMt8xE9QwZXmlt08hh
        V5LrkGA7NOlqgC+oHVno16j5w2AXgWGyOW8k
X-Google-Smtp-Source: ABdhPJxz6hs6toC3nEKf0jsgJLQwugyWO38tIPofbES+tAmI7rQueBjhcuYfae3m3pO9wWh8i3BA9g==
X-Received: by 2002:a05:6214:1909:: with SMTP id er9mr2883941qvb.13.1623288039002;
        Wed, 09 Jun 2021 18:20:39 -0700 (PDT)
Received: from localhost.localdomain (pool-173-48-195-35.bstnma.fios.verizon.net. [173.48.195.35])
        by smtp.gmail.com with ESMTPSA id m3sm1274168qkh.135.2021.06.09.18.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 18:20:38 -0700 (PDT)
Subject: Re: [LSF/MM/BPF TOPIC] durability vs performance for flash devices
 (especially embedded!)
To:     Bart Van Assche <bvanassche@acm.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     lsf-pc@lists.linux-foundation.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org
References: <55d3434d-6837-3a56-32b7-7354e73eb258@gmail.com>
 <0e1ed05f-4e83-7c84-dee6-ac0160be8f5c@acm.org>
 <YMEItMNXG2bHgJE+@casper.infradead.org>
 <e9eaf87d-5c04-8974-4f0f-0fc9bac9a3b1@acm.org>
From:   Ric Wheeler <ricwheeler@gmail.com>
Message-ID: <e191c791-4646-bf47-0435-5b0d665eca89@gmail.com>
Date:   Wed, 9 Jun 2021 21:20:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <e9eaf87d-5c04-8974-4f0f-0fc9bac9a3b1@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/9/21 2:47 PM, Bart Van Assche wrote:
> On 6/9/21 11:30 AM, Matthew Wilcox wrote:
>> maybe you should read the paper.
>>
>> " Thiscomparison demonstrates that using F2FS, a flash-friendly file
>> sys-tem, does not mitigate the wear-out problem, except inasmuch asit
>> inadvertently rate limitsallI/O to the device"
> It seems like my email was not clear enough? What I tried to make clear
> is that I think that there is no way to solve the flash wear issue with
> the traditional block interface. I think that F2FS in combination with
> the zone interface is an effective solution.
>
> What is also relevant in this context is that the "Flash drive lifespan
> is a problem" paper was published in 2017. I think that the first
> commercial SSDs with a zone interface became available at a later time
> (summer of 2020?).
>
> Bart.

Just to address the zone interface support, it unfortunately takes a very long 
time to make it down into the world of embedded parts (emmc is super common and 
very primitive for example). UFS parts are in higher end devices, have not had a 
chance to look at what they offer.

Ric


