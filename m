Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40BF7177C7D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 17:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbgCCQzZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 11:55:25 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38739 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgCCQzZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 11:55:25 -0500
Received: by mail-io1-f66.google.com with SMTP id s24so4350619iog.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2020 08:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8bZht07bPqvyVs51MmKlUDCBipIAwVU9OTwKqsIEvs8=;
        b=SHP4Uw6HvUlPaUs9IYB16AOCis0EH3YzejdOEBRWeds0i79JF0JfXrI0pVYQsMwrDb
         WB+DYvR5cNaV8QmCLEUKpzGPNgdMardTT5O6bIFEIZQCxYHi0w0eiZe7xJ5js40tFMo/
         VDIKRVWKxpVYJPC0cQr15xJYMpuBbyGccD/rBHyvX5L03X0TdVPnXRkifL4nvQARjTzA
         6HBR7dz5832egFWxtqG2opZfTX93h0QynLjTC1oqlHHXYX5/Bx7yRcQPMnTLHW37El18
         GIrCKTVdpnpJ7IAfqLopMlvclCzdIoRAG5Nq6iBhma57TC53If7Jkf5KoAUqYbIn6TSG
         Qj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8bZht07bPqvyVs51MmKlUDCBipIAwVU9OTwKqsIEvs8=;
        b=JRXf6ulcm+nYd7aTsp0gSPV65esrsI4gce4YHwGx690L1N1HkMESoj7df3Be/HaSzW
         eutuC2zEjBR/oXTDOCEb7aWriG/Ea4YJ6n6kK4Znw8t7iXKnetDbSqVTm5zcvkNXU6rk
         ti4A169O3CTnaNieKqqFs9gVDls+fH0Np1O5wmYv5MvTSt+tDc9FOvCJ6I6bltO+n8CK
         SMYwV1kC07q5VUK8LHzeh3E84u40la4afEfGr4KvR0zEk2dXg0ZyFF8iI0JbZSCnK6n0
         z9fRDJ1i9ugLPlXh8pLagh4JW6/2f6ujOOLMpswXT5QJjPbg/XWL56Hqe6tKwqkX/olP
         Gk7w==
X-Gm-Message-State: ANhLgQ2vNhx7/+ymRUHDXGvAivetUAI/C7r5P3b71+QuISUmB0zFn3Im
        01jvPZNaSHU665XnGUuyIfDCcw==
X-Google-Smtp-Source: ADFU+vu3gnbtn1lj+jlLJO4BOpYV3sXet/yFpoqsVX1PFu20YDo94CkBQTfjpkni8ZEFJzh/CMzehg==
X-Received: by 2002:a6b:8b8c:: with SMTP id n134mr2442924iod.58.1583254522700;
        Tue, 03 Mar 2020 08:55:22 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u80sm7993352ili.77.2020.03.03.08.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 08:55:22 -0800 (PST)
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7a05adc8-1ca9-c900-7b24-305f1b3a9b86@kernel.dk>
Date:   Tue, 3 Mar 2020 09:55:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <acb1753c78a019fb0d54ba29077cef144047f70f.camel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/3/20 9:51 AM, Jeff Layton wrote:
> On Tue, 2020-03-03 at 08:44 -0700, Jens Axboe wrote:
>> On 3/3/20 7:24 AM, Greg Kroah-Hartman wrote:
>>> On Tue, Mar 03, 2020 at 03:13:26PM +0100, Jann Horn wrote:
>>>> On Tue, Mar 3, 2020 at 3:10 PM Greg Kroah-Hartman
>>>> <gregkh@linuxfoundation.org> wrote:
>>>>> On Tue, Mar 03, 2020 at 02:43:16PM +0100, Greg Kroah-Hartman wrote:
>>>>>> On Tue, Mar 03, 2020 at 02:34:42PM +0100, Miklos Szeredi wrote:
>>>>>>> On Tue, Mar 3, 2020 at 2:14 PM Greg Kroah-Hartman
>>>>>>> <gregkh@linuxfoundation.org> wrote:
>>>>>>>
>>>>>>>>> Unlimited beers for a 21-line kernel patch?  Sign me up!
>>>>>>>>>
>>>>>>>>> Totally untested, barely compiled patch below.
>>>>>>>>
>>>>>>>> Ok, that didn't even build, let me try this for real now...
>>>>>>>
>>>>>>> Some comments on the interface:
>>>>>>
>>>>>> Ok, hey, let's do this proper :)
>>>>>
>>>>> Alright, how about this patch.
>>>>>
>>>>> Actually tested with some simple sysfs files.
>>>>>
>>>>> If people don't strongly object, I'll add "real" tests to it, hook it up
>>>>> to all arches, write a manpage, and all the fun fluff a new syscall
>>>>> deserves and submit it "for real".
>>>>
>>>> Just FYI, io_uring is moving towards the same kind of thing... IIRC
>>>> you can already use it to batch a bunch of open() calls, then batch a
>>>> bunch of read() calls on all the new fds and close them at the same
>>>> time. And I think they're planning to add support for doing
>>>> open()+read()+close() all in one go, too, except that it's a bit
>>>> complicated because passing forward the file descriptor in a generic
>>>> way is a bit complicated.
>>>
>>> It is complicated, I wouldn't recommend using io_ring for reading a
>>> bunch of procfs or sysfs files, that feels like a ton of overkill with
>>> too much setup/teardown to make it worth while.
>>>
>>> But maybe not, will have to watch and see how it goes.
>>
>> It really isn't, and I too thinks it makes more sense than having a
>> system call just for the explicit purpose of open/read/close. As Jann
>> said, you can't currently do a linked sequence of open/read/close,
>> because the fd passing between them isn't done. But that will come in
>> the future. If the use case is "a bunch of files", then you could
>> trivially do "open bunch", "read bunch", "close bunch" in three separate
>> steps.
>>
>> Curious what the use case is for this that warrants a special system
>> call?
>>
> 
> Agreed. I'd really rather see something more general-purpose than the
> proposed readfile(). At least with NFS and SMB, you can compound
> together fairly arbitrary sorts of operations, and it'd be nice to be
> able to pattern calls into the kernel for those sorts of uses.
> 
> So, NFSv4 has the concept of a current_stateid that is maintained by the
> server. So basically you can do all this (e.g.) in a single compound:
> 
> open <some filehandle get a stateid>
> write <using that stateid>
> close <same stateid>
> 
> It'd be nice to be able to do something similar with io_uring. Make it
> so that when you do an open, you set the "current fd" inside the
> kernel's context, and then be able to issue io_uring requests that
> specify a magic "fd" value that use it.
> 
> That would be a really useful pattern.

For io_uring, you can link requests that you submit into a chain. Each
link in the chain is done in sequence. Which means that you could do:

<open some file><read from that file><close that file>

in a single sequence. The only thing that is missing right now is a way
to have the return of that open propagated to the 'fd' of the read and
close, and it's actually one of the topics to discuss at LSFMM next
month.

One approach would be to use BPF to handle this passing, another
suggestion has been to have the read/close specify some magic 'fd' value
that just means "inherit fd from result of previous". The latter sounds
very close to the stateid you mention above, and the upside here is that
it wouldn't explode the necessary toolchain to need to include BPF.

In other words, this is really close to being reality and practically
feasible.

-- 
Jens Axboe

