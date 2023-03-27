Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD086CAE04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 20:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjC0S7N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 14:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjC0S7M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:59:12 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91B01BE1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 11:59:10 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id o12so4323740iow.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 11:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679943550; x=1682535550;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vOWVBHIx0ykg+zGatEPFHotgTXR6dQmDx4OQFYS51bs=;
        b=5h83kfcdEKwgccnSRtPhjdATwq/Qw5KC1latM+X8bVHiz9KaoSWOd/HTXAfy/vE4yX
         TqDPRh7t/LInc+1F2EtUNqhUFsAsQDsKfeCYUBmhJ+m2DCsqkei736RjElMuS6NYz1lb
         39VWF5S0pNqRVTlEkPSxWQjvjleX42Wp1b2ulIZ4HA4L1GfdRYVgzXK/1/e5hVv/aNWB
         hFv4PYGLK0BPXTekyR04O3irvdmb4n1EQSMHJM+VWHmZYaEakSibCdGgUVjDL+tnaNwi
         lrwyNG++AQTjGQgOBpSElm+cGoTQyNhYlh7LVpNF54OGyMU4kH+tPeTdI77uYxT1VX6h
         b+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679943550; x=1682535550;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vOWVBHIx0ykg+zGatEPFHotgTXR6dQmDx4OQFYS51bs=;
        b=De2w//TNuZWd8A+nlEorWNOKeEHCjpu9BG50cnc1oZ3mdWcDWlNmnFPxp6fknAZ9kR
         5BUi8zVszas1UFSyooanuO61TfDpTv9GfbMGEcDhWupxocCf2obFq36iRnFMN+zENg6i
         m+baIdGsurb18hRgQTfIYeNIdold9qukIaIyd2eHXvJ4RcLK+Q+ttc+vzDW7pGZMYBGv
         UI9OcRy4EKjGSDeOCGUZ5+QX07N/gS7TyuCSvk9m1c/UIVbV9I1r7ZxvGgP/t+ZDci0i
         /IQ0yV848A1nYcBRC2A0SmXqkrx0yr7cKCEbkax8xfpyqhhqwc0hmfYj0kyxXgRUcFm4
         Vr1g==
X-Gm-Message-State: AO0yUKXEimVcGrrcWBmUVVU0eqclKeURulsL1rKyaXXCJi+UBDWFvIlo
        sZwcw3uC8Xwr7yNPxNPtz10ZWF0RAa9lhR973OXqHw==
X-Google-Smtp-Source: AK7set/Y1XAduP3uW8tzn3JZfZ0xX216LWVbmOMHhvpPBKNwfXQxluc1S55bojFOpxqOuS0dwwAnng==
X-Received: by 2002:a5d:9d96:0:b0:757:f2a2:affa with SMTP id ay22-20020a5d9d96000000b00757f2a2affamr8284076iob.1.1679943550129;
        Mon, 27 Mar 2023 11:59:10 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id k18-20020a6b4012000000b00734ac8a5ef7sm8220431ioa.25.2023.03.27.11.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 11:59:09 -0700 (PDT)
Message-ID: <c975dbcf-1332-5bb5-3375-04280407a897@kernel.dk>
Date:   Mon, 27 Mar 2023 12:59:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCHSET 0/2] Turn single segment imports into ITER_UBUF
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        brauner@kernel.org
References: <20230324204443.45950-1-axboe@kernel.dk>
 <20230325044654.GC3390869@ZenIV>
 <1ef65695-4e66-ebb8-3be8-454a1ca8f648@kernel.dk>
 <20230327184254.GH3390869@ZenIV>
 <65c20342-b6ed-59c8-3aef-1d6f6d8bfdf2@kernel.dk>
In-Reply-To: <65c20342-b6ed-59c8-3aef-1d6f6d8bfdf2@kernel.dk>
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

On 3/27/23 12:52?PM, Jens Axboe wrote:
> On 3/27/23 12:42?PM, Al Viro wrote:
>> On Mon, Mar 27, 2023 at 12:01:08PM -0600, Jens Axboe wrote:
>>> On 3/24/23 10:46?PM, Al Viro wrote:
>>>> On Fri, Mar 24, 2023 at 02:44:41PM -0600, Jens Axboe wrote:
>>>>> Hi,
>>>>>
>>>>> We've been doing a few conversions of ITER_IOVEC to ITER_UBUF in select
>>>>> spots, as the latter is cheaper to iterate and hence saves some cycles.
>>>>> I recently experimented [1] with io_uring converting single segment READV
>>>>> and WRITEV into non-vectored variants, as we can save some cycles through
>>>>> that as well.
>>>>>
>>>>> But there's really no reason why we can't just do this further down,
>>>>> enabling it for everyone. It's quite common to use vectored reads or
>>>>> writes even with a single segment, unfortunately, even for cases where
>>>>> there's no specific reason to do so. From a bit of non-scientific
>>>>> testing on a vm on my laptop, I see about 60% of the import_iovec()
>>>>> calls being for a single segment.
>>>>>
>>>>> I initially was worried that we'd have callers assuming an ITER_IOVEC
>>>>> iter after a call import_iovec() or import_single_range(), but an audit
>>>>> of the kernel code actually looks sane in that regard. Of the ones that
>>>>> do call it, I ran the ltp test cases and they all still pass.
>>>>
>>>> Which tree was that audit on?  Mainline?  Some branch in block.git?
>>>
>>> It was just master in -git. But looks like I did miss two spots, I've
>>> updated the series here and will send out a v2:
>>>
>>> https://git.kernel.dk/cgit/linux-block/log/?h=iter-ubuf
>>
>> Just to make sure - head's at 4d0ba2f0250d?
> 
> Correct!
> 
>> One obvious comment (just about the problems you've dealt with in that
>> branch; I'll go over that tree and look for other sources of trouble,
>> will post tonight):
>>
>> all 3 callers of iov_iter_iovec() in there are accompanied by the identical
>> chunks that deal with ITER_UBUF case; it would make more sense to teach
>> iov_iter_iovec() to handle that.  loop_rw_iter() would turn into
>> 	if (!iov_iter_is_bvec(iter)) {
>> 		iovec = iov_iter_iovec(iter);
>> 	} else {
>> 		iovec.iov_base = u64_to_user_ptr(rw->addr);
>> 		iovec.iov_len = rw->len;
>> 	}
>> and process_madvise() and do_loop_readv_writev() patches simply go away.
>>
>> Again, I'm _not_ saying there's no other problems left, just that these are
>> better dealt with that way.
>>
>> Something like
>>
>> static inline struct iovec iov_iter_iovec(const struct iov_iter *iter)
>> {
>> 	if (WARN_ON(!iter->user_backed))
>> 		return (struct iovec) {
>> 			.iov_base = NULL,
>> 			.iov_len = 0
>> 		};
>> 	else if (iov_iter_is_ubuf(iter))
>> 		return (struct iovec) {
>> 			.iov_base = iter->ubuf + iter->iov_offset,
>> 			.iov_len = iter->count
>> 		}; 
>> 	else
>> 		return (struct iovec) {
>> 			.iov_base = iter->iov->iov_base + iter->iov_offset,
>> 			.iov_len = min(iter->count,
>> 				       iter->iov->iov_len - iter->iov_offset),
>> 		};
>> }
>>
>> and no need to duplicate that logics in all callers.  Or get rid of
>> those elses, seeing that each alternative is a plain return - matter
>> of taste...
> 
> That's a great idea. Two questions - do we want to make that
> WARN_ON_ONCE()? And then do we want to include a WARN_ON_ONCE for a
> non-supported type? Doesn't seem like high risk as they've all been used
> with ITER_IOVEC until now, though.

Scratch that last one, user_backed should double as that as well. At
least currently, where ITER_UBUF and ITER_IOVEC are the only two
iterators that hold user backed memory.

-- 
Jens Axboe

