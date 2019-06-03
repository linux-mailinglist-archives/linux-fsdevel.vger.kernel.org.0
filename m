Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6AB33970
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2019 22:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfFCUB3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jun 2019 16:01:29 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:46920 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfFCUB3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jun 2019 16:01:29 -0400
Received: by mail-qt1-f180.google.com with SMTP id z19so10942520qtz.13;
        Mon, 03 Jun 2019 13:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ILvqKIDYjCxpgvxSit+XD9upXbgaLs7jZQpNNmN0CxQ=;
        b=UNULN3rtXJXcbUTgupNaj5V1fFWSy3czIsK194k0yNRU9ol6q4gGpSKok9cpORmfUT
         WuSEUWmFF5pRMVuZwSfp+qNftgiM0eaqxEJqdqumBf0fCZgaoGbd4OE1/paTJl9aGFbH
         oZRBG4MapPyeE6F52asfuFg/JubfndXr9FMBdW8q2ZvaskwXPmiYn0r2MsmCSJKBIvh7
         1qyGjH3FcgY0NtNa+T31QFP73fvpyiBY1OFjSV6l1Ba9VsfkkduE/5CZC8ssA4KccuU4
         Fp6+7uL97TlUOOJGw1euGrCBRbn5rl9fOZ7KFAsBKi2NgJ6nsNzdjYytOVcc7y8Ojsdb
         3sNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ILvqKIDYjCxpgvxSit+XD9upXbgaLs7jZQpNNmN0CxQ=;
        b=BpDPfTQGGNxPFB2goR4Ga7IgNPf6iRmDShIvzQmgaMx5CPB8wIyGr/fb7Z7yhhlXZj
         S+fz+i2OLKdhMQMW82g8Zo/IPSzYcQFXBb6JZKzKxWxivi4gFiFfCHofImasHtI9OQtG
         1GHxFxHdzkptuLWe8vT+kzK+ENHOOgdLve5LsGyO9JGmLmeX0lJSWkezyj8BVgyyjFOE
         z56wD8pKJo4+KrutXvn3D6DA7ogW2hnL7/cmWRtZLNWuAJhvPcvU4HGaredcLimVjECE
         DQlrVTouHMzXVas5VglA4dl1dBAQXl1u6S+NRn7ljegl9HmduFSLIRoS0W5YdpvubJze
         STXg==
X-Gm-Message-State: APjAAAU7Yx6xlTsS60Cb17wzCDMa8pxzlm7pRML24+FrdQcKA8jaizlx
        oxST9UBfCf7EytsgWU0suDs=
X-Google-Smtp-Source: APXvYqwexNv5DEE4kk1/zdn1iKoFyrU9uwHTZXhBDi3xqD7WU1kcLMxjAXn6lbqxh8ZzvRf7VzT+RQ==
X-Received: by 2002:ac8:2906:: with SMTP id y6mr4628190qty.138.1559592087503;
        Mon, 03 Jun 2019 13:01:27 -0700 (PDT)
Received: from localhost.localdomain ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id z12sm678711qkf.20.2019.06.03.13.01.25
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 13:01:26 -0700 (PDT)
Subject: Re: Testing devices for discard support properly
To:     Chris Mason <clm@fb.com>, Bryan Gurney <bgurney@redhat.com>
Cc:     Lukas Czerner <lczerner@redhat.com>, Jan Tulak <jtulak@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Dennis Zhou <dennisz@fb.com>
References: <4a484c50-ef29-2db9-d581-557c2ea8f494@gmail.com>
 <20190507071021.wtm25mxx2as6babr@work>
 <CACj3i71HdW0ys_YujGFJkobMmZAZtEPo7B2tgZjEY8oP_T9T6g@mail.gmail.com>
 <20190507094015.hb76w3rjzx7shxjp@work>
 <09953ba7-e4f2-36e9-33b7-0ddbbb848257@gmail.com>
 <CAHhmqcT_yabMDY+dZoBAUA28f6tkPe0uH+xtRUS51gvv4p2vuQ@mail.gmail.com>
 <5a02e30d-cb46-a2ab-554f-b8ef4807bd97@gmail.com>
 <CAHhmqcQw69S3Fn=Nej7MezCOZ3_ZNi64p+PFLSV+b91e1gTjZA@mail.gmail.com>
 <31794121-DEDA-4269-8B72-50EB4D0BCABE@fb.com>
From:   Ric Wheeler <ricwheeler@gmail.com>
Message-ID: <73f96019-dd58-07ca-ecaf-42519025ed6d@gmail.com>
Date:   Mon, 3 Jun 2019 16:01:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <31794121-DEDA-4269-8B72-50EB4D0BCABE@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 5/7/19 5:24 PM, Chris Mason wrote:
> On 7 May 2019, at 16:09, Bryan Gurney wrote:
> 
>> I found an example in my trace of the "two bands of latency" behavior.
>> Consider these three segments of trace data during the writes:
>>
> 
> [ ... ]
> 
>> There's an average latency of 14 milliseconds for these 128 kilobyte
>> writes.  At 0.218288794 seconds, we can see a sudden appearance of 1.7
>> millisecond latency times, much lower than the average.
>>
>> Then we see an alternation of 1.7 millisecond completions and 14
>> millisecond completions, with these two "latency groups" increasing,
>> up to about 14 milliseconds and 25 milliseconds at 0.241287187 seconds
>> into the trace.
>>
>> At 0.317351888 seconds, we see the pattern start again, with a sudden
>> appearance of 1.89 millisecond latency write completions, among 14.7
>> millisecond latency write completions.
>>
>> If you graph it, it looks like a "triangle wave" pulse, with a
>> duration of about 23 milliseconds, that repeats after about 100
>> milliseconds.  In a way, it's like a "heartbeat".  This wouldn't be as
>> easy to detect with a simple "average" or "percentile" reading.
>>
>> This was during a simple sequential write at a queue depth of 32, but
>> what happens with a write after a discard in the same region of
>> sectors?  This behavior could change, depending on different drive
>> models, and/or drive controller algorithms.
>>
> 
> I think these are all really interesting, and definitely support the
> idea of a series of tests we do to make sure a drive implements discard
> in the general ways that we expect.
> 
> But with that said, I think a more important discussion as filesystem
> developers is how we protect the rest of the filesystem from high
> latencies caused by discards.  For reads and writes, we've been doing
> this for a long time.  IO schedulers have all kinds of checks and
> balances for REQ_META or REQ_SYNC, and we throttle dirty pages and
> readahead and dance around request batching etc etc.
> 
> But for discards, we just open the floodgates and hope it works out.  At
> some point we're going to have to figure out how to queue and throttle
> discards as well as we do reads/writes.  That's kind of tricky because
> the FS needs to coordinate when we're allowed to discard something and
> needs to know when the discard is done, and we all have different
> schemes for keeping track.
> 
> -chris
> 

Trying to summarize my thoughts here after weeks of other stuff.

We really have two (intertwined) questions:

* does issuing a discard on a device do anything useful - restore 
flagging performance, enhance the life space of the device, etc?

* what is the performance impact of doing a discard & does it vary based 
on the size of the region? (Can we use it to discard a whole device, do 
it for small discards, etc)

To answer the first question, we need a test that can verify that 
without discards (mount with nodiscard), we see a decline in 
performance. For example, multiple overwrites of the entire surface of 
the device (2 -3 full device writes) to make sure all of the spare 
capacity has been consumed, run the target workload we want to measure, 
then do discards of the whole space and run that same target workload.

If the discard does something useful, we should see better performance 
in that second test run.

If discard does not do anything useful, we are "done" with that device - 
no real need to measure performance of a useless mechanism. (Punting on 
the device longevity stuff here, seems like that should be left to the 
hardware vendors).

To answer the second question, we need to measure the performance of the 
discard implementation.

We still have to work to get any device into a well known state - do 
multiple, full device writes without discards. 2-3 passes should do it.

Then run our specific discard test workload - measure the performance of 
large discards (cap the size by the max permitted by the device) and 
small, single page discards. Important to capture min/max/average times 
of the discard. I think it would be best to do this on the block device 
to avoid any file system layer performance impact of deleting 
files/tweaking extents/etc.

Probably easiest to do separate tests for interesting discard sizes 
(each time, doing the full device writes to get back to a known state 
ahead of the test).

This is not meant to be a comprehensive tests/validation, but I think 
that doing the above would be a way to get a good sense of the 
effectiveness and performance of the device mechanism.

Make sense? Did I leave something out?

Ric
