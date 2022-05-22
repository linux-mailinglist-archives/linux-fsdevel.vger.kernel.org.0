Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3176F5305BB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 22:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346241AbiEVUDl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 16:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiEVUDk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 16:03:40 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF5025EAE
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 13:03:38 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id z7-20020a17090abd8700b001df78c7c209so15727907pjr.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 13:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=25SwQ4O+CJ6vqPPdLLqhvrQXcXrwqkUQVahcpEjf60Q=;
        b=LoU0mMH4i7XKShkqzEkm+c8GvvxHedY0JnBE4T1wRzt2CnrcEHsvElYXWKi/ymkJuz
         HrwHefT8VOu1rjNp7xb0W7pFZqDPCkIu6K+LIBOetQmPQFvKa1xPEpLWCRXU2rT5tscE
         WUry6mpAQgCcpaFSuKkR1/v1bMwYDkLbvKUq9gY8X0hvoyRjsJO/L9y3eY43roDGQmMm
         wu7FAaBT7mFS4AkOjwURSbWUo86lpzRV0C2XTj9Rm8A7aScnmaWbqD2ECA6ebg44o3JS
         n71HftbE/xUtHjWe9/k2KUxAXknxWujrNmbFLTUBYQaHWxlqRvLiFcc/qbWB5yIAEZbF
         5VxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=25SwQ4O+CJ6vqPPdLLqhvrQXcXrwqkUQVahcpEjf60Q=;
        b=qajThRXUtpp7Bu5EQkda4ivH0trPFWWM78vak36sSVLwbNyodQXeHkRLjJxdx6KohA
         /5patNyPLbdZxWEc1Y4OcIEPRO4yjqvW3hXCHRcStaOXpayuAVXKwGdMCwZV0fvIE1Vj
         qbFoiirr2yW40gsnSKnGiFj0Fx+CUiy0e1mTGM7rrwoGH0tkkg17XA2HEjWj9OkZ83b2
         EETKEHHYJ8yz/kPdrYomUcOfr+BeJsHTxb5Pdi0JTHG2Al9c31AwLL2xu3MKO6IV1VL/
         BhHGIyNUbaRYChC3pC7UDU8KqciHKgBe/UDmAVlUDanXM5etzDAJKYRhgARfyQMfPaFx
         thrA==
X-Gm-Message-State: AOAM533nQOXMcHciKv5tuiswfLicowqvuBWWcnopaZFVsYnlQoxMzi9P
        7N4X7SWpAN4IsFVtasxqapA/WhP6seRnAQ==
X-Google-Smtp-Source: ABdhPJyEn5RV14HudkdwXQOpILMCNHf1L6OtH9dFzlvXEV3U/B1o9J1V6zuZ8s9mWFQeZTajcTbr8g==
X-Received: by 2002:a17:902:f647:b0:161:67af:6bf0 with SMTP id m7-20020a170902f64700b0016167af6bf0mr18995505plg.100.1653249817802;
        Sun, 22 May 2022 13:03:37 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b184-20020a621bc1000000b0051826824d90sm5720016pfb.177.2022.05.22.13.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 13:03:36 -0700 (PDT)
Message-ID: <1b2cb369-2247-8c10-bd6e-405a8167f795@kernel.dk>
Date:   Sun, 22 May 2022 14:03:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
References: <e563d92f-7236-fbde-14ee-1010740a0983@kernel.dk>
 <YooxLS8Lrt6ErwIM@zeniv-ca.linux.org.uk>
 <96aa35fc-3ff7-a3a1-05b5-9fae5c9c1067@kernel.dk>
 <Yoo1q1+ZRrjBP2y3@zeniv-ca.linux.org.uk>
 <e2bb980b-42e8-27dc-cb6b-51dfb90d7e0a@kernel.dk>
 <7abc2e36-f2f3-e89c-f549-9edd6633b4a1@kernel.dk>
 <YoqAM1RnN/er6GDP@zeniv-ca.linux.org.uk>
 <41f4fba6-3ab2-32a6-28d9-8c3313e92fa5@kernel.dk>
 <YoqDTV9sa4k9b9nb@zeniv-ca.linux.org.uk>
 <737a889f-93b9-039f-7708-c15a21fbca2a@kernel.dk>
 <YoqJROtrPpXWv948@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YoqJROtrPpXWv948@zeniv-ca.linux.org.uk>
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

On 5/22/22 1:04 PM, Al Viro wrote:
> On Sun, May 22, 2022 at 12:48:20PM -0600, Jens Axboe wrote:
>> On 5/22/22 12:39 PM, Al Viro wrote:
>>> On Sun, May 22, 2022 at 12:29:16PM -0600, Jens Axboe wrote:
>>>> It was sent out as a discussion point, it's not a submission and it's by
>>>> no means complete (as mentioned!). If you're working on this, I'd be
>>>> happy to drop it, it's not like I really enjoy the iov_iter code... And
>>>> it sounds like you are?
>>>
>>> *snort*
>>>
>>> Yes, I am working on it.  As for enjoying that thing...  I'm not fond of
>>
>> OK great, I'll abandon this sandbox. Let me know when you have something
>> to test, and I can compare some numbers between non-iter, iter,
>> iter-with-ubuf.
>>
>>> forests of macros, to put it mildly.  Even in the trimmed form it still
>>> stinks, and places like copy_page_to_iter for iovec are still fucking
>>> awful wrt misguided microoptimization attempts - mine, at that, so I've
>>> nobody else to curse ;-/
>>
>> And it's not even clear which ones won't work with the generic variants,
>> and which ones are just an optimization. I suspect a lot of the icache
>> bloat from this just makes things worse...
> 
> ???
> 
> copy_page_{from,to}_iter() iovec side is needed not for the sake of
> optimizations - if you look at the generic variant, you'll see that it's
> basically "kmap_local_page + copy_{to,from}_iter() for the contents +
> kunmap_local_page", which obviously relies upon the copy_{to,from}_iter()
> being non-blocking.  So iovec part of it genuinely needs to differ from
> the generic variant; it's just that on top of that it had been (badly)
> microoptimized.  So were iterators, but that got at least somewhat cleaned

Right, I'm saying it's not _immediately_ clear which cases are what when
reading the code.

> up a while ago.  And no, turning that into indirect calls ended up with
> arseloads of overhead, more's the pity...

It's a shame, since indirect calls make for nicer code, but it's always
been slower and these days even more so.

> Anyway, at the moment I have something that builds; hadn't tried to
> boot it yet.

Nice!

-- 
Jens Axboe

