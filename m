Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A719011D0B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 16:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfLLPQf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 10:16:35 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:33218 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbfLLPQe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:16:34 -0500
Received: by mail-il1-f193.google.com with SMTP id r81so2359072ilk.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2019 07:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S2IaLsSZMoS2iQfRkFl9MVKkcxOmVcFNJa06N345a9A=;
        b=U+GQQ9IU6WDb1z0lMW6bRpe3PfhJU5N0hhzEz2NInl6eqkeCCwwadfHTrVVcMtgCG8
         SWNhsU2awW8yN8FT2AZlQ06W9LsO4n/Y2fjfsDH8dMFebQ6ehP9Aqp+sL5eZnwMlhN0k
         qK/o0oL75IKFmcxL7gJ9+bhOmPbs2JgCeTzLDIB7abpWaLDsBkc9h74JdU/FQ4bz/r2p
         xqRxXPIqd//1XfhygNW4hmFfj6FtORcBj5EjQPsUliNYllnQ28vp3Qqlk7K986pcDUoT
         7b/tLgCY55mN1YxowRKimh25PcA07on4CPjloIBTnec63nu6Eb9ovbTkCqMhnYkDpHE7
         qK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S2IaLsSZMoS2iQfRkFl9MVKkcxOmVcFNJa06N345a9A=;
        b=Rh974/8e/oUrecg9yUrn7InkDBAGK1xBZz6T9v2tcMkUAcC5zyo609r3wgtTzchmTS
         k2iBGyRKfXXps4i62exmC0AM7eUuY2EvMXaa2k1/yNlJANz42ETTik+fFC2ToVJuiyTM
         9z5TUvQx+2rcyCekaN1/Mzfh5g4zUX73qC23xS8P2jh/SnPC1DlfegSXdnA2i8/yJEcB
         rb+kNSzSvwCiuSaKfz+Qvj6ZyooU8YfLu3XrEm5YKDGM7iUmc5OWNer9cUAvbK5T8nJ3
         sXzaY6h+QZa07/nE5R2nyLAhLFIeXA3PET1PJXKtUwnZxCkcyKHNViTcMpz5h0Dq+7G9
         HYvA==
X-Gm-Message-State: APjAAAViffEStlfRs4rqz9qtAcMTUyl4rq08Dryh4J6wx5Nwkns1sNRr
        zhY2CunL7CLFwFGd7InAJcfPlA==
X-Google-Smtp-Source: APXvYqy8qMluD3XclDKt268iMim0qse+WZejtV1y2XG1sVXEedlm3slnz5l5GnSsxOptfJFM7Y0n7Q==
X-Received: by 2002:a92:8919:: with SMTP id n25mr8078407ild.156.1576163793574;
        Thu, 12 Dec 2019 07:16:33 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d12sm1788477iln.63.2019.12.12.07.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 07:16:32 -0800 (PST)
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, willy@infradead.org, clm@fb.com,
        torvalds@linux-foundation.org, david@fromorbit.com
References: <20191211152943.2933-1-axboe@kernel.dk>
 <63049728.ylUViGSH3C@merkaba>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7bf74660-874e-6fd7-7a41-f908ccab694e@kernel.dk>
Date:   Thu, 12 Dec 2019 08:16:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <63049728.ylUViGSH3C@merkaba>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/12/19 3:44 AM, Martin Steigerwald wrote:
> Hi Jens.
> 
> Jens Axboe - 11.12.19, 16:29:38 CET:
>> Recently someone asked me how io_uring buffered IO compares to mmaped
>> IO in terms of performance. So I ran some tests with buffered IO, and
>> found the experience to be somewhat painful. The test case is pretty
>> basic, random reads over a dataset that's 10x the size of RAM.
>> Performance starts out fine, and then the page cache fills up and we
>> hit a throughput cliff. CPU usage of the IO threads go up, and we have
>> kswapd spending 100% of a core trying to keep up. Seeing that, I was
>> reminded of the many complaints I here about buffered IO, and the
>> fact that most of the folks complaining will ultimately bite the
>> bullet and move to O_DIRECT to just get the kernel out of the way.
>>
>> But I don't think it needs to be like that. Switching to O_DIRECT
>> isn't always easily doable. The buffers have different life times,
>> size and alignment constraints, etc. On top of that, mixing buffered
>> and O_DIRECT can be painful.
>>
>> Seems to me that we have an opportunity to provide something that sits
>> somewhere in between buffered and O_DIRECT, and this is where
>> RWF_UNCACHED enters the picture. If this flag is set on IO, we get
>> the following behavior:
>>
>> - If the data is in cache, it remains in cache and the copy (in or
>> out) is served to/from that.
>>
>> - If the data is NOT in cache, we add it while performing the IO. When
>> the IO is done, we remove it again.
>>
>> With this, I can do 100% smooth buffered reads or writes without
>> pushing the kernel to the state where kswapd is sweating bullets. In
>> fact it doesn't even register.
> 
> A question from a user or Linux Performance trainer perspective:
> 
> How does this compare with posix_fadvise() with POSIX_FADV_DONTNEED that 
> for example the nocache¹ command is using? Excerpt from manpage 
> posix_fadvice(2):
> 
>        POSIX_FADV_DONTNEED
>               The specified data will not be accessed  in  the  near
>               future.
> 
>               POSIX_FADV_DONTNEED  attempts to free cached pages as‐
>               sociated with the specified region.  This  is  useful,
>               for  example,  while streaming large files.  A program
>               may periodically request the  kernel  to  free  cached
>               data  that  has already been used, so that more useful
>               cached pages are not discarded instead.
> 
> [1] packaged in Debian as nocache or available herehttps://github.com/
> Feh/nocache
> 
> In any way, would be nice to have some option in rsync… I still did not 
> change my backup script to call rsync via nocache.

I don't know the nocache tool, but I'm guessing it just does the writes
(or reads) and then uses FADV_DONTNEED to drop behind those pages?
That's fine for slower use cases, it won't work very well for fast IO.
The write side currently works pretty much like that internally, whereas
the read side doesn't use the page cache at all.

-- 
Jens Axboe

