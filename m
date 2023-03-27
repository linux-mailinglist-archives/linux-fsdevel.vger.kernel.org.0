Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3960B6CADF7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 20:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjC0Swa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 14:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbjC0Sw3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:52:29 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C9E10FA
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 11:52:28 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id x6so5129988ile.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 11:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679943148; x=1682535148;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KfVAYvTnDMhvvujg+8qd3kN6rA/s9HQUMH91n74h9Go=;
        b=Z+pvuB4CIkT3DSB7mJtO/qOVGZJ5p0Tjd0L64D+th9yEHOPgFLVHlcjahPvEHTqQgk
         DXqL8IjV/9vjUiRbUq6cjatebDhAOBLIAt0nsgqEox5KVeLuVl2p+RihBXS/pXgUBcAC
         lUu26DpyO72/gfxN2uzaVNSkAHSrmAl24np0d8jXKa0Uj9+6RkAbMqBXPDWJw3ncG0z7
         Y6IjOBgmlpTDcJJrEOlX2kmU1zTcNJQ6GZNff/tqleq4Dw2xeSyboMAwudM2Xpl8FJCC
         a9cn1vN0tJb7pOWzvXCm4iu6DNbRZVQ1L4TOEkKNkNBzRhlYaDvuYyIQTha+iAsLAjQf
         rZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679943148; x=1682535148;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KfVAYvTnDMhvvujg+8qd3kN6rA/s9HQUMH91n74h9Go=;
        b=XDGEKEzTujqJrFha7Gc0p2wAJu8/hxvzXvWyOVE2uCs2u9gTF4ZZiSYDbRv03MG1m6
         aKkCatpscdRHCf+PDAlBVfZf3gm5jUdXJoSobPMX9JRWWYXgaW39MKQtXxZJgzUj0NUt
         wHDfLAje69VDDmqADZCpez6Yfd+StHHV7hLWxUX+oOau6a6qsRoK5rTu6qedTGKtL4SJ
         lnHxBHM2iNPs2tgZa2GAxUftjdcW8QSi8eYxPWQn8tSud200nuQhMdI4vAPoRV+DpzgJ
         YYf+xCOllOx/IqFTwD3z6LE1oY5Yxa88DhRDMUAnCWnpkA7SMzOfSl2ML/scXWBmzpwh
         zFIg==
X-Gm-Message-State: AAQBX9fT9G3ghtbXa1mz5n2XZaPY05nAmi+OI0A2buOlwbmJvshVdeKR
        ZmkurMSkQS7sMgzvJSv839SSow==
X-Google-Smtp-Source: AKy350bFQ638BtJtsslhQx+h4aE5Nq1i4hdU+RxlCmaBLrEz9XVCiHlknhbbX3TaqZClit6gzFf8ug==
X-Received: by 2002:a05:6e02:2207:b0:313:fb1b:2f86 with SMTP id j7-20020a056e02220700b00313fb1b2f86mr8917371ilf.0.1679943147695;
        Mon, 27 Mar 2023 11:52:27 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v9-20020a92c6c9000000b0032489df6d8asm6474022ilm.54.2023.03.27.11.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 11:52:27 -0700 (PDT)
Message-ID: <65c20342-b6ed-59c8-3aef-1d6f6d8bfdf2@kernel.dk>
Date:   Mon, 27 Mar 2023 12:52:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCHSET 0/2] Turn single segment imports into ITER_UBUF
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        brauner@kernel.org
References: <20230324204443.45950-1-axboe@kernel.dk>
 <20230325044654.GC3390869@ZenIV>
 <1ef65695-4e66-ebb8-3be8-454a1ca8f648@kernel.dk>
 <20230327184254.GH3390869@ZenIV>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230327184254.GH3390869@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/27/23 12:42?PM, Al Viro wrote:
> On Mon, Mar 27, 2023 at 12:01:08PM -0600, Jens Axboe wrote:
>> On 3/24/23 10:46?PM, Al Viro wrote:
>>> On Fri, Mar 24, 2023 at 02:44:41PM -0600, Jens Axboe wrote:
>>>> Hi,
>>>>
>>>> We've been doing a few conversions of ITER_IOVEC to ITER_UBUF in select
>>>> spots, as the latter is cheaper to iterate and hence saves some cycles.
>>>> I recently experimented [1] with io_uring converting single segment READV
>>>> and WRITEV into non-vectored variants, as we can save some cycles through
>>>> that as well.
>>>>
>>>> But there's really no reason why we can't just do this further down,
>>>> enabling it for everyone. It's quite common to use vectored reads or
>>>> writes even with a single segment, unfortunately, even for cases where
>>>> there's no specific reason to do so. From a bit of non-scientific
>>>> testing on a vm on my laptop, I see about 60% of the import_iovec()
>>>> calls being for a single segment.
>>>>
>>>> I initially was worried that we'd have callers assuming an ITER_IOVEC
>>>> iter after a call import_iovec() or import_single_range(), but an audit
>>>> of the kernel code actually looks sane in that regard. Of the ones that
>>>> do call it, I ran the ltp test cases and they all still pass.
>>>
>>> Which tree was that audit on?  Mainline?  Some branch in block.git?
>>
>> It was just master in -git. But looks like I did miss two spots, I've
>> updated the series here and will send out a v2:
>>
>> https://git.kernel.dk/cgit/linux-block/log/?h=iter-ubuf
> 
> Just to make sure - head's at 4d0ba2f0250d?

Correct!

> One obvious comment (just about the problems you've dealt with in that
> branch; I'll go over that tree and look for other sources of trouble,
> will post tonight):
>
> all 3 callers of iov_iter_iovec() in there are accompanied by the identical
> chunks that deal with ITER_UBUF case; it would make more sense to teach
> iov_iter_iovec() to handle that.  loop_rw_iter() would turn into
> 	if (!iov_iter_is_bvec(iter)) {
> 		iovec = iov_iter_iovec(iter);
> 	} else {
> 		iovec.iov_base = u64_to_user_ptr(rw->addr);
> 		iovec.iov_len = rw->len;
> 	}
> and process_madvise() and do_loop_readv_writev() patches simply go away.
> 
> Again, I'm _not_ saying there's no other problems left, just that these are
> better dealt with that way.
> 
> Something like
> 
> static inline struct iovec iov_iter_iovec(const struct iov_iter *iter)
> {
> 	if (WARN_ON(!iter->user_backed))
> 		return (struct iovec) {
> 			.iov_base = NULL,
> 			.iov_len = 0
> 		};
> 	else if (iov_iter_is_ubuf(iter))
> 		return (struct iovec) {
> 			.iov_base = iter->ubuf + iter->iov_offset,
> 			.iov_len = iter->count
> 		}; 
> 	else
> 		return (struct iovec) {
> 			.iov_base = iter->iov->iov_base + iter->iov_offset,
> 			.iov_len = min(iter->count,
> 				       iter->iov->iov_len - iter->iov_offset),
> 		};
> }
> 
> and no need to duplicate that logics in all callers.  Or get rid of
> those elses, seeing that each alternative is a plain return - matter
> of taste...

That's a great idea. Two questions - do we want to make that
WARN_ON_ONCE()? And then do we want to include a WARN_ON_ONCE for a
non-supported type? Doesn't seem like high risk as they've all been used
with ITER_IOVEC until now, though.

-- 
Jens Axboe

