Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18AC62CE2E8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 00:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbgLCXru (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 18:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbgLCXru (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 18:47:50 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15CBC061A4F;
        Thu,  3 Dec 2020 15:47:09 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id i2so3614343wrs.4;
        Thu, 03 Dec 2020 15:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+7WsziAA7t+RcMzHCvy59+gqSJGaC4QjJaMv7bGkDCA=;
        b=X2QFT6vi+5YRuVLmAp4MRMsEFx7zMgBzA/lvd4l3xwMd4sfetIeLsJ/P4Q6SJxt74b
         oQ6vFg+oGWelT9NDbNgFTthuU13zCSNOgi3CBoRUbsfGm2+3PcabtgsWqkPhqg79Uc7J
         NtpqYlgX040L9S/OzLkU8zii3NVRK7TkaAa8177iB78ouaxA458BGYUK6PFA+9CoBqF5
         E+fiRJpfY4of+6f83UiCh3/KuqVMVObQrA5nUbZW1OtfeI49jv6nvt7F/0+YGeIsDkr1
         iJ3/TOPM4eJAA6X78GYIs/TrzF5/T6T49MlQb40By/DegQP7q6R6cYtFJIlV4wQYqz/8
         g0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+7WsziAA7t+RcMzHCvy59+gqSJGaC4QjJaMv7bGkDCA=;
        b=VIQwut/v68VtMWHFtu5N7fIGmKlurG2fENElahWY5JNV+xNks9ZhExzPPB0ju0kcIy
         KCSrE76Oz4vpGIQAmpvqkG+TwhKa5edF8ZZ1DGoU9lRROh65jlXpE9jrHPPzpJV7GLym
         mq1AsvgEEe3WhLEiR06uXCzg6d8kTQ4McRGTRnXFbkELdhzpec5pV/tsMxx0jW1uZsD7
         Wt3P5R2DjpHec82cektzKhHxy171rilAAqHlrsmEAqk1JJ/8Opvfzfe/rkSvxiT4YDgG
         iJMVua3JB1xtpDbmpO+XP29McmEe6u4Mb0eEl4f700GytKnsMDYmB7ieIcWXxvmmFJ77
         VH9Q==
X-Gm-Message-State: AOAM531x4OLFsgzcTGmuPYis5g9qCUd5I5LQDJxWfdCyjGNGxEqLp5Jp
        gZbMAv6DNM2NaayBsTynR35nLfktZ16l9Q==
X-Google-Smtp-Source: ABdhPJxVoAtGF9D/MHGtFkJHYLGFStzCam8lWseyZSN4FQLW4Zx6QMPMespzA3scyhs8EiLJuGawbA==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr1700726wrs.226.1607039228058;
        Thu, 03 Dec 2020 15:47:08 -0800 (PST)
Received: from [192.168.1.59] (host109-152-100-189.range109-152.btcentralplus.com. [109.152.100.189])
        by smtp.gmail.com with ESMTPSA id f18sm1227575wru.42.2020.12.03.15.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 15:47:07 -0800 (PST)
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20201201120652.487077-1-ming.lei@redhat.com>
 <20201201125251.GA11935@casper.infradead.org>
 <20201201125936.GA25111@infradead.org>
 <fdbfe981-0251-9641-6ed8-db034c0f0148@gmail.com>
 <20201201133226.GA26472@infradead.org> <20201203223607.GB53708@cmpxchg.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH] block: add bio_iov_iter_nvecs for figuring out nr_vecs
Message-ID: <78544774-520f-ce07-d397-399f7ed8b5c4@gmail.com>
Date:   Thu, 3 Dec 2020 23:43:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20201203223607.GB53708@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/12/2020 22:36, Johannes Weiner wrote:
> On Tue, Dec 01, 2020 at 01:32:26PM +0000, Christoph Hellwig wrote:
>> On Tue, Dec 01, 2020 at 01:17:49PM +0000, Pavel Begunkov wrote:
>>> I was thinking about memcpy bvec instead of iterating as a first step,
>>> and then try to reuse passed in bvec.
>>>
>>> A thing that doesn't play nice with that is setting BIO_WORKINGSET in
>>> __bio_add_page(), which requires to iterate all pages anyway. I have no
>>> clue what it is, so rather to ask if we can optimise it out somehow?
>>> Apart from pre-computing for specific cases...
>>>
>>> E.g. can pages of a single bvec segment be both in and out of a working
>>> set? (i.e. PageWorkingset(page)).
>>
>> Adding Johannes for the PageWorkingset logic, which keeps confusing me
>> everytime I look at it.  I think it is intended to deal with pages
>> being swapped out and in, and doesn't make much sense to look at in
>> any form for direct I/O, but as said I'm rather confused by this code.
> 
> Correct, it's only interesting for pages under LRU management - page
> cache and swap pages. It should not matter for direct IO.
> 
> The VM uses the page flag to tell the difference between cold faults
> (empty cache startup e.g.), and thrashing pages which are being read
> back not long after they have been reclaimed. This influences reclaim
> behavior, but can also indicate a general lack of memory.
> 
> The BIO_WORKINGSET flag is for the latter. To calculate the time
> wasted by a lack of memory (memory pressure), we measure the total
> time processes wait for thrashing pages. Usually that time is
> dominated by waiting for in-flight io to complete and pages to become
> uptodate. These waits are annotated on the page cache side.
> 
> However, in some cases, the IO submission path itself can block for
> extended periods - if the device is congested or submissions are
> throttled due to cgroup policy. To capture those waits, the bio is
> flagged when it's for thrashing pages, and then submit_bio() will
> report submission time of that bio as a thrashing-related delay.

TIL, thanks Johannes

> 
> [ Obviously, in theory bios could have a mix of thrashing and
>   non-thrashing pages, and the submission stall could have occurred
>   even without the thrashing pages. But in practice we have locality,
>   where groups of pages tend to be accessed/reclaimed/refaulted
>   together. The assumption that the whole bio is due to thrashing when
>   we see the first thrashing page is a workable simplification. ]
Great, then the last piece left before hacking this up is killing off
mutating bio_for_each_segment_all(). But don't think anyone will be sad
for it.

-- 
Pavel Begunkov
