Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582C22CD4EE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 12:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgLCLwy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 06:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgLCLwy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 06:52:54 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C07C061A4D;
        Thu,  3 Dec 2020 03:52:13 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id e25so3636954wme.0;
        Thu, 03 Dec 2020 03:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NrJuxO+zxsdVklZnzVW7lpTFYuTXn6Q5RMj3hLGz6oI=;
        b=dwy3mPksTqlL4bUx9JTLM42GlVv5S7/pqqk1/uINo0Az1n6VxV2DffSIg1+Yy1w8f1
         zeKsfoMHJqXK3/wbu4GJAilmCmOIJh9jiOjpIIMjqzO9ZYjHuiR6olCBeN8cGIMDK+sU
         7GAbisZmcWuVCQ+LN0Jn2669LogPgav0hHqbPM3Oj3F2dK2WLe6Zbskj0sPtVggdG/9F
         syxKVnN3alq/Gwg5Jsrx5AgK78TSJ0x0XqwxWmc9FFVOMpYEYnXuybsdCa3BGqjqldJp
         6b88gPgBmru/uHRO5wvxgpFQPxE8EuBArevqnP3m3z3v90YgbjKVDJ4vXTW68KLJPRO3
         JMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=NrJuxO+zxsdVklZnzVW7lpTFYuTXn6Q5RMj3hLGz6oI=;
        b=ZhJEJZM1ELzVRsEz42FQHciGFA83xN5G4qQmobnFJj2v6ff6ZMRpUMWh5sXQMK9tGW
         w93AGW1QI5znRRrsuVYiHOou7/8d+BVn+60Lo9x0eQu9uqS2GY3Dx+7WVrvxWozQ9qAn
         Nt6Nkz+SmSTwEWZU5L+j1v296qvtsqnEATa7ZxDRu/w+hc273qIFiyQoDW2EOL0ZYhNk
         EuixSHGzkKBpf8RANKghRDhiGqGQ4KH02JJsaQSuBw91hLpJ+gh8wgKgmN7NL86cCF2m
         2G4R2EyomIAvGCOu1QolT0CLxbNeg5uKoFWv8+cVeCo/fuhXsHZ8qHuZeZFXy000rSo7
         q5Cw==
X-Gm-Message-State: AOAM530XWK6qPT1GHmJndMdUhUh0TF3ECSSmZ9zIXI5dlGMHMoql01OO
        O0f/BBE9whPuo3V6zz78U+N/R2SMGzUsZg==
X-Google-Smtp-Source: ABdhPJzVEenasrMphn/6JLHsgAIuJXY/+dCpRE8fcfvCSV7Oew9dr3rI5+ds/sh8HHEaUm8dVRT9pQ==
X-Received: by 2002:a1c:1d08:: with SMTP id d8mr2929702wmd.159.1606996332112;
        Thu, 03 Dec 2020 03:52:12 -0800 (PST)
Received: from [192.168.1.59] (host109-152-100-189.range109-152.btcentralplus.com. [109.152.100.189])
        by smtp.gmail.com with ESMTPSA id p19sm1644425wrg.18.2020.12.03.03.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 03:52:11 -0800 (PST)
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <21b78c2f256e513b9eb3f22c7c1f55fc88992600.1606957658.git.asml.silence@gmail.com>
 <20201203091406.GA6189@infradead.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH] iov_iter: optimise bvec iov_iter_advance()
Message-ID: <eb02fa7f-956e-ce7e-6a56-82318b2c6d2e@gmail.com>
Date:   Thu, 3 Dec 2020 11:48:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20201203091406.GA6189@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/12/2020 09:14, Christoph Hellwig wrote:
>> @@ -1077,6 +1077,20 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
>>  		i->count -= size;
>>  		return;
>>  	}
>> +	if (iov_iter_is_bvec(i)) {
>> +		struct bvec_iter bi;
>> +
>> +		bi.bi_size = i->count;
>> +		bi.bi_bvec_done = i->iov_offset;
>> +		bi.bi_idx = 0;
>> +		bvec_iter_advance(i->bvec, &bi, size);
>> +
>> +		i->bvec += bi.bi_idx;
>> +		i->nr_segs -= bi.bi_idx;
>> +		i->count = bi.bi_size;
>> +		i->iov_offset = bi.bi_bvec_done;
>> +		return;
>> +	}
>>  	iterate_and_advance(i, size, v, 0, 0, 0)
> 
> I like the idea, but whu not avoid the on-stack bvec_iter and just
> open code this entirely using a new helper?  E.g.

It's inlined and the on-stack iter is completely optimised out. Frankly,
I'd rather not open-code bvec_iter_advance(), at least for this chunk to
be findable from bvec.h, e.g. grep bvec_iter and bvec_for_each. Though,
I don't like myself that preamble/postamble.

> 
> static void bio_iov_iter_advance(struct iov_iter *i, size_t bytes)
> {
> 	unsigned int cnt;
> 
> 	i->count -= bytes;
> 
> 	bytes += i->iov_offset;
> 	for (cnt = 0; bytes && bytes >= i->bvec[cnt].bv_len; cnt++)
> 		bytes -= i->bvec[cnt].bv_len;
> 	i->iov_offset = bytes;
> 
> 	i->bvec += cnt;
> 	i->nr_segs -= cnt;
> }
> 

-- 
Pavel Begunkov
