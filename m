Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 033A9178413
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 21:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731850AbgCCUdH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 15:33:07 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:45221 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731830AbgCCUdG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 15:33:06 -0500
Received: by mail-io1-f66.google.com with SMTP id w9so5109896iob.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2020 12:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NA2tNK/EVxzQPmbB3xl2CeQSQTv5FvhMkwiaUXLKu8k=;
        b=DpN9m2XxTJTaWFWLrmhMZf7V1GCIm2YxJek3ns+5tzeuum4/wfQwH9U2ZVWZLuJq//
         G2CG7cMZ0uQKq6uaHP8VVNjvib+G3RVyvjy7kH1kMoIqA6mVWk7oMvVIx0cQScQFHTeP
         RoxPHN++33ZpZYk7akbvYSAPI67SVi6AJikPSC380seGBqZGGSBROhHh1amdaWEiTHv/
         zGWD9tdG/3wh5hGmAJH+XrjB6dYRvmmltVccjFxf1BEHVmkM1qx9gkGowI4f9RceBYG1
         M1a6y9e1ip8ePcFbBhriMn4ip7GfqEce3g3YiwuI1ECwwRU+ZQnZJLtO8KOh8C43TIEv
         nStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NA2tNK/EVxzQPmbB3xl2CeQSQTv5FvhMkwiaUXLKu8k=;
        b=Y1mZ9H0V06H/7KbbwEJDXDU9WCmNxn9WV1t/BEhsmUnczfWWCJTndKWr91U9NuwGve
         q9LVhDLAV0jKlzx3/QxU7tcGqp70Nyfgs7FQWaFGnVUVvZiwcUShS+Cw6+E3hb/sD28S
         FWakkzogcpQql7kptkEyLxuN5uyMOoirpToO+Xx1jhjsUouYpWUwmvAGrxHROQRz2weX
         EBShL9e6lEB6YeaLAxG9J6llejm24/uwmJDhWmmLz4APVsVUl29res1e9+mBcwCBW0C5
         9eB+edTtYLV81iEfpIpftUVhFh7af0vXUdEsGVE9fp+vgi512EIJFOTpzam8DSJh/KB+
         zbrw==
X-Gm-Message-State: ANhLgQ1uH3RX7+PilOTd34Tp/E0Vm76uY4S9WiV0hYFpPKAKhiTy0SfF
        8swEG3mGpkUOjm4SRffYgvpEpQ==
X-Google-Smtp-Source: ADFU+vtoGIx3gKdYMLKlNybMcolvbKZ8/DjRo+oIeqMeZA+KrGcg/iqJ1ptT8MMywh+gWnklsTi+dQ==
X-Received: by 2002:a6b:710c:: with SMTP id q12mr5643228iog.167.1583267584182;
        Tue, 03 Mar 2020 12:33:04 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f9sm756927ioc.70.2020.03.03.12.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 12:33:03 -0800 (PST)
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver
 #17]
To:     Jeff Layton <jlayton@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Karel Zak <kzak@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <1509948.1583226773@warthog.procyon.org.uk>
 <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
 <20200303113814.rsqhljkch6tgorpu@ws.net.home>
 <20200303130347.GA2302029@kroah.com> <20200303131434.GA2373427@kroah.com>
 <CAJfpegt0aQVvoDeBXOu2xZh+atZQ+q5uQ_JRxe46E8cZ7sHRwg@mail.gmail.com>
 <20200303134316.GA2509660@kroah.com> <20200303141030.GA2811@kroah.com>
 <CAG48ez3Z2V8J7dpO6t8nw7O2cMJ6z8vwLZXLAoKGH3OnCb-7JQ@mail.gmail.com>
 <20200303142407.GA47158@kroah.com>
 <030888a2-db3e-919d-d8ef-79dcc10779f9@kernel.dk>
 <acb1753c78a019fb0d54ba29077cef144047f70f.camel@kernel.org>
 <7a05adc8-1ca9-c900-7b24-305f1b3a9b86@kernel.dk>
 <dbb06c63c17c23fcacdd99e8b2266804ee39ffe5.camel@kernel.org>
 <dc84aa00-e570-8833-cf9f-d1001c52dd7a@kernel.dk>
 <cb2a7273a4cac7bac5f5b323e1958242b98e605e.camel@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f3e36d79-a324-678d-ae19-eaee14eaefbd@kernel.dk>
Date:   Tue, 3 Mar 2020 13:33:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cb2a7273a4cac7bac5f5b323e1958242b98e605e.camel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/3/20 12:43 PM, Jeff Layton wrote:
> On Tue, 2020-03-03 at 12:23 -0700, Jens Axboe wrote:
>> On 3/3/20 12:02 PM, Jeff Layton wrote:
>>> Basically, all you'd need to do is keep a pointer to struct file in the
>>> internal state for the chain. Then, allow userland to specify some magic
>>> fd value for subsequent chained operations that says to use that instead
>>> of consulting the fdtable. Maybe use -4096 (-MAX_ERRNO - 1)?
>>
>> BTW, I think we need two magics here. One that says "result from
>> previous is fd for next", and one that says "fd from previous is fd for
>> next". The former allows inheritance from open -> read, the latter from
>> read -> write.
>>
> 
> Do we? I suspect that in almost all of the cases, all we'd care about is
> the last open. Also if you have unrelated operations in there you still
> have to chain the fd through somehow to the next op which is a bit hard
> to do with that scheme.
> 
> I'd just have a single magic carveout that means "use the result of last
> open call done in this chain". If you do a second open (or pipe, or...),
> then that would put the old struct file pointer and drop a new one in
> there.
> 
> If we really do want to enable multiple opens in a single chain though,
> then we might want to rethink this and consider some sort of slot table
> for storing open fds.

I think the one magic can work, you just have to define your chain
appropriately for the case where you have multiple opens. That's true
for the two magic approach as well, of course, I don't want a stack of
open fds, just "last open" should suffice.

I don't like the implicit close, if your op opens an fd, something
should close it again. You pass it back to the application in any case
for io_uring, so the app can just close it. Which means that your chain
should just include a close for whatever fd you open, unless you plan on
using it in the application aftwards.

-- 
Jens Axboe

