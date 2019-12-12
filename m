Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 371EE11D928
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 23:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731257AbfLLWPi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 17:15:38 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36600 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731199AbfLLWPh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 17:15:37 -0500
Received: by mail-pl1-f193.google.com with SMTP id d15so185865pll.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2019 14:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y5oT9uWtY0LeQYVivfgqNjCA9SpoRNFmIvY21McRdiQ=;
        b=wsU6P+eGgFAPh2UXy913mTpywcdlCws2X+H53i+IG5zcE96sWW7rNeLsv1WyKaZz5L
         qrASayNaoInK194CB5qqkkVvHfL5ccYL80KewoESrHyqY1P1Xc41Uf8mqjwr17sSFNJj
         kxQYg94vo9gyl/9M42tS2R77CXLFQpzW37MfbLumD0vWwh3ATPMEpq5Gek38um9PwFkp
         IYtrqbxhkgKVS6Sn6oo72BEoFUs6t5WkKgb4GuKSX6xZyoeQHld57dMsa5fy3wKZ++Ob
         6RB+8/IXZi+euSOGMMOgHi6VrzlX2vrr1pATmjI7S0LrKA0dy/TSO/03MN9XRdmOopME
         yJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y5oT9uWtY0LeQYVivfgqNjCA9SpoRNFmIvY21McRdiQ=;
        b=ph00VQLwMBdkGhVBKWN1Xh+PCrBgygYfZGkJzAPRRwvi9Ha/p0WU/gQLKEeZWt8A71
         JwQFn0lozvbrJJOa8IVyRIpxlXQoU3K0j+DxamD3yd9w9++4/akUeMDUm+Y+cA3/HfLB
         1WK/0w88qw6y1yoFfh8Y381ZQRNURIs47hOIZvwQdPwMLfGq5bnXVCwFo1V2SWjd61O3
         UpAkFmDCggdGm6pmS4HR4XuhvHS4mRc6yzSG0u+y74xkTZ8Fog0pLzF/g4VWFQv2fNr2
         ig3Jl+QoZtVytFClzaGYpx6W9DPs2A8lXiM3ArDvrEA/B9+1jb5XeWyCNDx3oNex5OgZ
         S0MQ==
X-Gm-Message-State: APjAAAX+/RsmIj8rjPSn+TMJnXFBje04l/Wlf5mC42o5BZcGdgbsNfBq
        3nO+qkE6EamxCcREijB0z91FcA==
X-Google-Smtp-Source: APXvYqz1otoGGvMZpzx90SoE/R6gEpiVj/8VFSGUpjMUZqD8uBZ74Uk+1vPN8q8O9/LDHyCDLgmZMg==
X-Received: by 2002:a17:902:fe09:: with SMTP id g9mr11632167plj.162.1576188936703;
        Thu, 12 Dec 2019 14:15:36 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id l66sm7878610pga.30.2019.12.12.14.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 14:15:35 -0800 (PST)
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, willy@infradead.org, clm@fb.com,
        torvalds@linux-foundation.org, david@fromorbit.com
References: <20191211152943.2933-1-axboe@kernel.dk>
 <63049728.ylUViGSH3C@merkaba>
 <7bf74660-874e-6fd7-7a41-f908ccab694e@kernel.dk> <2091494.0NDvsO6yje@merkaba>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <05adab5c-1405-f4a3-b14f-3242fa5ce8fc@kernel.dk>
Date:   Thu, 12 Dec 2019 15:15:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <2091494.0NDvsO6yje@merkaba>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/12/19 2:45 PM, Martin Steigerwald wrote:
> Jens Axboe - 12.12.19, 16:16:31 CET:
>> On 12/12/19 3:44 AM, Martin Steigerwald wrote:
>>> Jens Axboe - 11.12.19, 16:29:38 CET:
>>>> Recently someone asked me how io_uring buffered IO compares to
>>>> mmaped
>>>> IO in terms of performance. So I ran some tests with buffered IO,
>>>> and
>>>> found the experience to be somewhat painful. The test case is
>>>> pretty
>>>> basic, random reads over a dataset that's 10x the size of RAM.
>>>> Performance starts out fine, and then the page cache fills up and
>>>> we
>>>> hit a throughput cliff. CPU usage of the IO threads go up, and we
>>>> have kswapd spending 100% of a core trying to keep up. Seeing
>>>> that, I was reminded of the many complaints I here about buffered
>>>> IO, and the fact that most of the folks complaining will
>>>> ultimately bite the bullet and move to O_DIRECT to just get the
>>>> kernel out of the way.
>>>>
>>>> But I don't think it needs to be like that. Switching to O_DIRECT
>>>> isn't always easily doable. The buffers have different life times,
>>>> size and alignment constraints, etc. On top of that, mixing
>>>> buffered
>>>> and O_DIRECT can be painful.
>>>>
>>>> Seems to me that we have an opportunity to provide something that
>>>> sits somewhere in between buffered and O_DIRECT, and this is where
>>>> RWF_UNCACHED enters the picture. If this flag is set on IO, we get
>>>> the following behavior:
>>>>
>>>> - If the data is in cache, it remains in cache and the copy (in or
>>>> out) is served to/from that.
>>>>
>>>> - If the data is NOT in cache, we add it while performing the IO.
>>>> When the IO is done, we remove it again.
>>>>
>>>> With this, I can do 100% smooth buffered reads or writes without
>>>> pushing the kernel to the state where kswapd is sweating bullets.
>>>> In
>>>> fact it doesn't even register.
>>>
>>> A question from a user or Linux Performance trainer perspective:
>>>
>>> How does this compare with posix_fadvise() with POSIX_FADV_DONTNEED
>>> that for example the nocache¹ command is using? Excerpt from
>>> manpage> 
>>> posix_fadvice(2):
>>>        POSIX_FADV_DONTNEED
>>>        
>>>               The specified data will not be accessed  in  the  near
>>>               future.
>>>               
>>>               POSIX_FADV_DONTNEED  attempts to free cached pages as‐
>>>               sociated with the specified region.  This  is  useful,
>>>               for  example,  while streaming large files.  A program
>>>               may periodically request the  kernel  to  free  cached
>>>               data  that  has already been used, so that more useful
>>>               cached pages are not discarded instead.
>>>
>>> [1] packaged in Debian as nocache or available
>>> herehttps://github.com/ Feh/nocache
>>>
>>> In any way, would be nice to have some option in rsync… I still did
>>> not change my backup script to call rsync via nocache.
>>
>> I don't know the nocache tool, but I'm guessing it just does the
>> writes (or reads) and then uses FADV_DONTNEED to drop behind those
>> pages? That's fine for slower use cases, it won't work very well for
>> fast IO. The write side currently works pretty much like that
>> internally, whereas the read side doesn't use the page cache at all.
> 
> Yes, it does that. And yeah I saw you changed the read site to bypass 
> the cache entirely.
> 
> Also as I understand it this is for asynchronous using io uring 
> primarily?

Or preadv2/pwritev2, they also allow passing in RWF_* flags.

-- 
Jens Axboe

