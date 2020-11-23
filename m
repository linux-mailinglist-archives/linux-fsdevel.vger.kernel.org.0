Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57BC82C198A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 00:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgKWXpr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 18:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgKWXpq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 18:45:46 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F9FC0613CF;
        Mon, 23 Nov 2020 15:45:46 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id w24so1153402wmi.0;
        Mon, 23 Nov 2020 15:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cQ900KyYSRva3bIgqg60fU7D0QBGU+Gbv+Sjk3s4+f0=;
        b=i/+UED9xOcvUxwpbwsrpjf6M3HfCQzjGiPW5HRCmWrSCUK5dyXrVR9jkfJSkIMu+su
         20z8pF7jkVSO9ChOZxpwPB4jmtHimSVL4xFNhtCW6/Qc5WfHERD+gHcfWi2XWa/8V0xk
         i1ROzRAA/cgfm/Mr8KORFGaVclra49ftmc5X2klfJqmz1ydieRr0PdQP0gK+M3QkzjgS
         CSt6JQHPxu5HOIZH9F62i+sglOqovsM90/pnYEFegJyBpRUMWGFYsM7brbXZKHSqFCCy
         Og4sOQWZG3LfY+WccAp+c9yEfXYpID97cmnRPdVBqG9Zxw++dCSYPa55tGZv6AE3z9ne
         Pldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cQ900KyYSRva3bIgqg60fU7D0QBGU+Gbv+Sjk3s4+f0=;
        b=VS857HSX2aHKwCS6OPic1eS30+rveb066cKO1BicZKT4mJ8VjYuXe16i10NDBs+xdr
         3/wUnwtvvI683I/3vtSzmbge37sO2QEOQi1cLGp0KxUtYd/4cziqrES+9O/EIjjotCzQ
         RfgNowsZUwXw/WGSlwKLtdX68VgGKZG9r3sMsoqTj7ecRcHYg+NQGX/u1otCM1+A6RGz
         D9P2lXQr9j071fBpUBRsCcTJ3iwRmS0KJ+Sq0qjzdigVG25UGRAp9IUYJ6qp5cVz/bkb
         kbjnGRoADARgU24ujTIqVUy293KoCk6eXwaSL9UxE2eh94ishSJGFVofGcqfv9SdQuJ9
         pcDQ==
X-Gm-Message-State: AOAM533PuPO4fTp6B96cAsKV+GnotywJ3ayXpaj8nE6mGP+L2ZkEKTx/
        f1ZduihXsMis51nwNeKKGPhG3b/nRrYJhXu2
X-Google-Smtp-Source: ABdhPJzeSSY83t+PM8zMzDKCbilPaohyNklNag304tqIX8LZ+qyFFK06jFbR1W1hHKr1OjYdht5QUA==
X-Received: by 2002:a1c:328a:: with SMTP id y132mr1272566wmy.134.1606175144387;
        Mon, 23 Nov 2020 15:45:44 -0800 (PST)
Received: from [192.168.1.42] (host109-152-100-135.range109-152.btcentralplus.com. [109.152.100.135])
        by smtp.gmail.com with ESMTPSA id c187sm1854796wmd.23.2020.11.23.15.45.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 15:45:43 -0800 (PST)
To:     David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201123080506.GA30578@infradead.org>
 <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
 <160596801020.154728.15935034745159191564.stgit@warthog.procyon.org.uk>
 <516984.1606127474@warthog.procyon.org.uk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH 01/29] iov_iter: Switch to using a table of operations
Message-ID: <74f6fb34-c4c2-6a7e-3614-78c34246c6bd@gmail.com>
Date:   Mon, 23 Nov 2020 23:42:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <516984.1606127474@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23/11/2020 10:31, David Howells wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> 
>> Please run performance tests.  I think the indirect calls could totally
>> wreck things like high performance direct I/O, especially using io_uring
>> on x86.
> 
> Here's an initial test using fio and null_blk.  I left null_blk in its default
> configuration and used the following command line:

I'd prefer something along no_sched=1 submit_queues=$(nproc) to reduce overhead.

> 
> fio --ioengine=libaio --direct=1 --gtod_reduce=1 --name=readtest --filename=/dev/nullb0 --bs=4k --iodepth=128 --time_based --runtime=120 --readwrite=randread --iodepth_low=96 --iodepth_batch=16 --numjobs=4

fio is relatively heavy, I'd suggest to try fio/t/io_uring with nullblk

> 
> I borrowed some of the parameters from an email I found online, so I'm not
> sure if they're that useful.
> 
> I tried three different sets of patches: none, just the first (which adds the
> jump table without getting rid of the conditional branches), and all of them.
> 
> I'm not sure which stats are of particular interest here, so I took the two
> summary stats from the output of fio and also added together the "issued rwts:
> total=a,b,c,d" from each test thread (only the first of which is non-zero).
> 
> The CPU is an Intel(R) Core(TM) i3-4170 CPU @ 3.70GHz, so 4 single-thread
> cores, and 16G of RAM.  No virtualisation is involved.
> 
> Unpatched:
> 
>    READ: bw=4109MiB/s (4308MB/s), 1025MiB/s-1029MiB/s (1074MB/s-1079MB/s), io=482GiB (517GB), run=120001-120001msec
>    READ: bw=4097MiB/s (4296MB/s), 1020MiB/s-1029MiB/s (1070MB/s-1079MB/s), io=480GiB (516GB), run=120001-120001msec
>    READ: bw=4113MiB/s (4312MB/s), 1025MiB/s-1031MiB/s (1075MB/s-1082MB/s), io=482GiB (517GB), run=120001-120001msec
>    READ: bw=4125MiB/s (4325MB/s), 1028MiB/s-1033MiB/s (1078MB/s-1084MB/s), io=483GiB (519GB), run=120001-120001msec
> 
>   nullb0: ios=126017326/0, merge=53/0, ticks=3538817/0, in_queue=3538817, util=100.00%
>   nullb0: ios=125655193/0, merge=55/0, ticks=3548157/0, in_queue=3548157, util=100.00%
>   nullb0: ios=126133014/0, merge=58/0, ticks=3545621/0, in_queue=3545621, util=100.00%
>   nullb0: ios=126512562/0, merge=57/0, ticks=3531600/0, in_queue=3531600, util=100.00%
> 
>   sum issued rwts = 126224632
>   sum issued rwts = 125861368
>   sum issued rwts = 126340344
>   sum issued rwts = 126718648
> 
> Just first patch:
> 
>    READ: bw=4106MiB/s (4306MB/s), 1023MiB/s-1030MiB/s (1073MB/s-1080MB/s), io=481GiB (517GB), run=120001-120001msec
>    READ: bw=4126MiB/s (4327MB/s), 1029MiB/s-1034MiB/s (1079MB/s-1084MB/s), io=484GiB (519GB), run=120001-120001msec
>    READ: bw=4109MiB/s (4308MB/s), 1025MiB/s-1029MiB/s (1075MB/s-1079MB/s), io=481GiB (517GB), run=120001-120001msec
>    READ: bw=4097MiB/s (4296MB/s), 1023MiB/s-1025MiB/s (1073MB/s-1074MB/s), io=480GiB (516GB), run=120001-120001msec
> 
>   nullb0: ios=125939152/0, merge=62/0, ticks=3534917/0, in_queue=3534917, util=100.00%
>   nullb0: ios=126554181/0, merge=61/0, ticks=3532067/0, in_queue=3532067, util=100.00%
>   nullb0: ios=126012346/0, merge=54/0, ticks=3530504/0, in_queue=3530504, util=100.00%
>   nullb0: ios=125653775/0, merge=54/0, ticks=3537438/0, in_queue=3537438, util=100.00%
> 
>   sum issued rwts = 126144952
>   sum issued rwts = 126765368
>   sum issued rwts = 126215928
>   sum issued rwts = 125864120
> 
> All patches:
>   nullb0: ios=10477062/0, merge=2/0, ticks=284992/0, in_queue=284992, util=95.87%
>   nullb0: ios=10405246/0, merge=2/0, ticks=291886/0, in_queue=291886, util=99.82%
>   nullb0: ios=10425583/0, merge=1/0, ticks=291699/0, in_queue=291699, util=99.22%
>   nullb0: ios=10438845/0, merge=3/0, ticks=292445/0, in_queue=292445, util=99.31%
> 
>    READ: bw=4118MiB/s (4318MB/s), 1028MiB/s-1032MiB/s (1078MB/s-1082MB/s), io=483GiB (518GB), run=120001-120001msec
>    READ: bw=4109MiB/s (4308MB/s), 1024MiB/s-1030MiB/s (1073MB/s-1080MB/s), io=481GiB (517GB), run=120001-120001msec
>    READ: bw=4108MiB/s (4308MB/s), 1026MiB/s-1029MiB/s (1076MB/s-1079MB/s), io=481GiB (517GB), run=120001-120001msec
>    READ: bw=4112MiB/s (4312MB/s), 1025MiB/s-1031MiB/s (1075MB/s-1081MB/s), io=482GiB (517GB), run=120001-120001msec
> 
>   nullb0: ios=126282410/0, merge=58/0, ticks=3557384/0, in_queue=3557384, util=100.00%
>   nullb0: ios=126004837/0, merge=67/0, ticks=3565235/0, in_queue=3565235, util=100.00%
>   nullb0: ios=125988876/0, merge=59/0, ticks=3563026/0, in_queue=3563026, util=100.00%
>   nullb0: ios=126118279/0, merge=57/0, ticks=3566122/0, in_queue=3566122, util=100.00%
> 
>   sum issued rwts = 126494904
>   sum issued rwts = 126214200
>   sum issued rwts = 126198200
>   sum issued rwts = 126328312
> 
> 
> David
> 

-- 
Pavel Begunkov
