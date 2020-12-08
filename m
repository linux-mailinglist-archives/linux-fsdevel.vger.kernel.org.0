Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B123D2D2135
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 03:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgLHC6I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 21:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbgLHC6I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 21:58:08 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D103EC061749;
        Mon,  7 Dec 2020 18:57:21 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id x6so10818898wro.11;
        Mon, 07 Dec 2020 18:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MrcdCi41hMF4srKgEVE/pFzL2V7vfur0DFeYxwK9Ur4=;
        b=WHj/q4Y40gM/sYw627XdxUttqjAzOjyWoNkVzYIEAzuvqIB2cBP1M+todbOuv6qHDS
         xCUJ0uM9J5dUR4FiA0txRKDravXG+CZzUbTBZ81DVBcfeIHX24iNaHZY1Fh1dzq6tWKP
         Fk8RGa+4rT+c/hlQXFJlz3klohwYtG5L747u45TL+w3wIyuV1WmvLyvBpjJwU7ehwAPy
         2lTyLXwjOpmxFfEDYzuOXp8zBGT8UHmsRD2XgzN534MS4ghQ2kWHxhG6LWx8PvLV+ipV
         e6Ba0asrVnaiv+DMBHkpbM1M+/1PnXspK6ByG+8muPiRqZS/8fFzwJ9ESjW4IovQCLs/
         w5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MrcdCi41hMF4srKgEVE/pFzL2V7vfur0DFeYxwK9Ur4=;
        b=hpDZMSyXtDr4bWRgWc/pduN+YWEhI8ikQU04hd3ma2c1tiqW7j07lej4XduG+/RG7l
         7QZ4lN8fcfjXMmXnIkovTy5S7I26IxbUL8GsITBhrTIVgoKOHfrc/clrmlU1P4DKW/0q
         buGTljGldsI1ONuYFGa6Lt+TxnsLRt79BiW7KDGf+mRZJMGyGZi/QGTwrXKplWKcvX60
         1MVJRLM6ws/qcG7AJeoqiuNcQAOUWUna8FCO9nmOev7PxnV2bU8E/xdaqp94321zqrOO
         Q5rdSjBq3avzBAkO+iogd3xZtxmB8leEv916s3Y8CAlxdEAqLKTRDH21FkdTOBL+PtzY
         Um2A==
X-Gm-Message-State: AOAM53108Xa0TxWznmsNwZA6gyChpBDWDQtoN+CePk1xQsMJhpOFAEQ3
        1mTox2BpjCBsWKiF6WaT/AfjUyhxuwtvFA==
X-Google-Smtp-Source: ABdhPJzkpHf+0eEKMlZ682XD8sxITfdvwiGu2L2RLgn+522xc8lRFVftQAknVAUXhp37ia3VU3rdaw==
X-Received: by 2002:a5d:4112:: with SMTP id l18mr10187804wrp.116.1607396240422;
        Mon, 07 Dec 2020 18:57:20 -0800 (PST)
Received: from [192.168.8.113] ([185.69.145.78])
        by smtp.gmail.com with ESMTPSA id f16sm17957521wrp.66.2020.12.07.18.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 18:57:19 -0800 (PST)
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
References: <20201201120652.487077-1-ming.lei@redhat.com>
 <3eb1020d-c336-dbe6-d75e-70c388464e6e@gmail.com>
 <20201208015030.GC1059392@T590>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH] block: add bio_iov_iter_nvecs for figuring out nr_vecs
Message-ID: <e51dfc77-9bff-936c-2de3-c03daf908397@gmail.com>
Date:   Tue, 8 Dec 2020 02:54:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20201208015030.GC1059392@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08/12/2020 01:50, Ming Lei wrote:
> On Mon, Dec 07, 2020 at 06:07:39PM +0000, Pavel Begunkov wrote:
>> On 01/12/2020 12:06, Ming Lei wrote:
>>> Pavel reported that iov_iter_npages is a bit heavy in case of bvec
>>> iter.
>>>
>>> Turns out it isn't necessary to iterate every page in the bvec iter,
>>> and we call iov_iter_npages() just for figuring out how many bio
>>> vecs need to be allocated. And we can simply map each vector in bvec iter
>>> to bio's vec, so just return iter->nr_segs from bio_iov_iter_nvecs() for
>>> bvec iter.
>>>
>>> Also rename local variable 'nr_pages' as 'nr_vecs' which exactly matches its
>>> real usage.
>>>
>>> This patch is based on Mathew's post:
>>
>> Tried this, the system didn't boot + discovered a filesystem blowned after
>> booting with a stable kernel. That's on top of 4498a8536c816 ("block: use
>> an xarray for disk->part_tbl"), which works fine. Ideas?
> 
> I guess it is caused by Christoph's "store a pointer to the block_device in struct bio (again)"
> which has been reverted in for-5.11/block.
> 
> I'd suggest to run your test against the latest for-5.11/block one more time.

Ah, now it works, thanks for the idea
Unfortunately, I haven't got any logs, it died pretty early

-- 
Pavel Begunkov
