Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E780407030
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 19:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhIJRFT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 13:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbhIJRFS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 13:05:18 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38402C061756
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 10:04:05 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id q3so3207906iot.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 10:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dPY57pXXmLuXq/8ojNnsVtZFnOXIRJbcHBZHaFHpN64=;
        b=WYPbcGdEBib4+HH53NpvxdNL24M6lJ3go0CU95GfbFk5EXT6+cIY4+MzC+bPdVGfDf
         syrAGKLsZN7XO9qRBdZLFm0vdaMQvanEAfcWKlDJazkkewm+kBiM08xHInfBsFvsmbk4
         n/zBYu0Kg3P/zTD09e4JRcqlcnxeF3KbbvlFdeOwIOVvst5gR8uyF1sz/HlgIyU9n84q
         s9HCxoWoJKvOEht4NE0mogamM4bMFbok95A3QYLnB881358CFV6BUJmtKaJ7VXHJzs/9
         NM3XSxHdfxs2lmtY/fFgbdIHFJuqDfkGOb4Z8g8E0zGKgBji3h2T2jLLHwu65C7REfMx
         RDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dPY57pXXmLuXq/8ojNnsVtZFnOXIRJbcHBZHaFHpN64=;
        b=6ZzKCx2WD/jg/4ZAxnVM6CCgT/I85yXePZE7NHHlGsGDE0I5tmdyGQ8s9WC0p1kvcQ
         sFsgFjVoct2TLDLYTrgfPJf87oc3u08L8kfV6QzRjHtR7laLo9gk20g1+YLkleMSHhGi
         bq4SokFjxycfsvKvOXZD9ZYKD9YzUgjlNpIaqIqjPKSrvf7eSBbFFENyEBfEeyR8xNY9
         YL0G0ebh36VpnmXW8mB0XyR7p1QNrfPImDlNkMg32NwH+6vrViEw0/8u/i/1U4qC5+Au
         AuSVARXtXPOjTNDPmJ2u0S7arF1FGYY/KQDtWcfK4u/d1XE5/9WfkzQrNmX2/EP7qj7r
         RybA==
X-Gm-Message-State: AOAM531YZ4v4TAlknlIIan9R9IFCy6d0f0umnkAUJLSn1N8VtPtaHqDD
        QFuClRVzMGMY4NuGiYOw086n4jdU8WGOZostM48=
X-Google-Smtp-Source: ABdhPJzBJ+M8lfXu3IJXPBiaK7NxnMVjsYwFzN5NLU1UrSoK2hzCUdTefIsj5Ik1pikQTxq9HpPG6Q==
X-Received: by 2002:a6b:8f4e:: with SMTP id r75mr8063556iod.172.1631293443925;
        Fri, 10 Sep 2021 10:04:03 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id h1sm2611455iow.12.2021.09.10.10.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 10:04:03 -0700 (PDT)
Subject: Re: [git pull] iov_iter fixes
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <YTrJsrXPbu1jXKDZ@zeniv-ca.linux.org.uk>
 <b8786a7e-5616-ce83-c2f2-53a4754bf5a4@kernel.dk>
 <YTrM130S32ymVhXT@zeniv-ca.linux.org.uk>
 <9ae5f07f-f4c5-69eb-bcb1-8bcbc15cbd09@kernel.dk>
 <YTrQuvqvJHd9IObe@zeniv-ca.linux.org.uk>
 <f02eae7c-f636-c057-4140-2e688393f79d@kernel.dk>
 <YTrSqvkaWWn61Mzi@zeniv-ca.linux.org.uk>
 <9855f69b-e67e-f7d9-88b8-8941666ab02f@kernel.dk>
 <4b26d8cd-c3fa-8536-a295-850ecf052ecd@kernel.dk>
 <1a61c333-680d-71a0-3849-5bfef555a49f@kernel.dk>
 <YTuOPAFvGpayTBpp@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <345a0b26-0c60-db7c-231f-3ea713147b1b@kernel.dk>
Date:   Fri, 10 Sep 2021 11:04:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YTuOPAFvGpayTBpp@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/10/21 10:56 AM, Al Viro wrote:
> On Fri, Sep 10, 2021 at 10:06:25AM -0600, Jens Axboe wrote:
> 
>> Looks something like this. Not super pretty in terms of needing a define
>> for this, and maybe I'm missing something, but ideally we'd want it as
>> an anonymous struct that's defined inside iov_iter. Anyway, gets the
>> point across. Alternatively, since we're down to just a few members now,
>> we just duplicate them in each struct...
>>
>> Would be split into two patches, one for the iov_state addition and
>> the save/restore helpers, and then one switching io_uring to use them.
>> Figured we'd need some agreement on this first...
> 
>> +#define IOV_ITER_STATE					\
>> +	size_t iov_offset;				\
>> +	size_t count;					\
>> +	union {						\
>> +		unsigned long nr_segs;			\
>> +		struct {				\
>> +			unsigned int head;		\
>> +			unsigned int start_head;	\
>> +		};					\
>> +		loff_t xarray_start;			\
>> +	};						\
>> +
>> +struct iov_iter_state {
>> +	IOV_ITER_STATE;
>> +};
>> +
>>  struct iov_iter {
>>  	u8 iter_type;
>>  	bool data_source;
>> -	size_t iov_offset;
>> -	size_t count;
>>  	union {
>>  		const struct iovec *iov;
>>  		const struct kvec *kvec;
>> @@ -40,12 +54,10 @@ struct iov_iter {
>>  		struct pipe_inode_info *pipe;
>>  	};
>>  	union {
>> -		unsigned long nr_segs;
>> +		struct iov_iter_state state;
>>  		struct {
>> -			unsigned int head;
>> -			unsigned int start_head;
>> +			IOV_ITER_STATE;
>>  		};
>> -		loff_t xarray_start;
>>  	};
>>  	size_t truncated;
>>  };
> 
> No.  This is impossible to read *and* wrong for flavours other than
> iovec anyway.
> 
> Rules:
> 	count is flavour-independent
> 	iovec: iov, nr_segs, iov_offset.  nr_segs + iov is constant
> 	kvec: kvec, nr_segs, iov_offset.  nr_segs + kvec is constant
> 	bvec: bvec, nr_segs, iov_offset.  nr_segs + bvec is constant
> 	xarray: xarray, xarray_start, iov_offset.  xarray and xarray_start are constant.
> 	pipe: pipe, head, start_head, iov_offset.  pipe and start_head are constant,
> 						   iov_offset can be derived from the rest.
> 	discard: nothing.
> 
> What's more, for pipe (output-only) the situation is much trickier and
> there this "reset + advance" won't work at all.  Simply not applicable.
> 
> What's the point of all those contortions, anyway?  You only need it for
> iovec case; don't mix doing that and turning it into flavour-independent
> primitive.

Yes that's a good point, BVEC as well fwiw. But those two are very
similar.

> Especially since you turn around and access the fields of that sucker
> (->count, that is) directly in your code.  Keep it simple and readable,
> please.  We'll sort the sane flavour-independent API later.  And get
> rid of ->truncate, while we are at it.

Alright, so how about I just make the state a bit dumber and only work
for iovec/bvec. That gets rid of the weirdo macro. Add a WARN_ON_ONCE()
for using restore on anything that isn't an IOVEC/BVEC.

Sound reasonable?

-- 
Jens Axboe

