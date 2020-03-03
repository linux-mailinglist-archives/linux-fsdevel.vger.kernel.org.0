Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63A6D1782D1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 20:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbgCCTHo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 14:07:44 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:46002 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730355AbgCCTHn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 14:07:43 -0500
Received: by mail-il1-f193.google.com with SMTP id p8so3740840iln.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2020 11:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zXPZ9A67qwmOg7igLgXKoR5AdobcYJckvv+S7pUuvQY=;
        b=RVsmivnszCvULa3sdd8ZiSiDR7on5w6WX87+33rE5AEVBNk6MRJYP3fph1RK0dq+3I
         PVYA/XQHyd3jA2zktgFe/M7Qbb9zXtDddA2swswtnomhrCjOq1d8+gEwvnEPYDJRJ8Hy
         8JAFgDr6sr5vVhYetEB6vikYsVX0y6X8imD4xpPqEEwM385D86VL2YFIrkdROv3op8EI
         RqLYvEXKZ5EdLAqOCJMvPwKWvxqm+EHR8AN9xZ4V9RbQ5lXzgOPH/ZZupOsi6NUuxu6R
         R9EXa1SrOzS+QluyNBtjXUjtrkegqlVnnacCTudR/qKi8MBDZ6BVjtCMR61tFgIG1n3/
         iXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zXPZ9A67qwmOg7igLgXKoR5AdobcYJckvv+S7pUuvQY=;
        b=rQjWuP6UZ/S5nAIQP65vF9DSHqE41cri7go3IDEUskS2CyIftEvI1XKbca/6A/MHGE
         Q9/0SGSOaK+4mY+ife6rPpFW6XNYPIvIqTSWMFitqJRH/BZIo4EM2RtidFYG3H8DaBFJ
         VfXad0mFiupPE47yJoYb38hxuCOAu7frj2SOPnXR5tZZNS9Zf6bh+EwoVnOKzleeJI2W
         ovNoOzElpWrtFa5SuK9ljdObFFniD6tPXJCqUQXkSArj27QMwIJdYGN6z9IkIBV8Pwe+
         2QK6yslXqvLW2Eb+PTAm96QEzsEpsxvYJ4Pn4kdvgXTMQL3t69yLP5uJOPxM/oUGLTmt
         W0cw==
X-Gm-Message-State: ANhLgQ1Dprgz3S5RGmXManlU546LeV9/VPaDOYiuOHGyPPC/Wm68c3Wg
        EBnC+nuC39vGXnwvYK1VWqo3hA==
X-Google-Smtp-Source: ADFU+vuQjHxyW/mK7WjwkVP659P3n5h/bmVjdQMY9rkFbwUjk2zxIIY5IPzahRooNGOex1K/NE8Z9g==
X-Received: by 2002:a92:7e9d:: with SMTP id q29mr6105954ill.29.1583262460436;
        Tue, 03 Mar 2020 11:07:40 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id j78sm5446799ili.37.2020.03.03.11.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 11:07:39 -0800 (PST)
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5394c5c4-aeb8-97d5-8347-e763a1abd9ed@kernel.dk>
Date:   Tue, 3 Mar 2020 12:07:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <dbb06c63c17c23fcacdd99e8b2266804ee39ffe5.camel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/3/20 12:02 PM, Jeff Layton wrote:
> On Tue, 2020-03-03 at 09:55 -0700, Jens Axboe wrote:
>> On 3/3/20 9:51 AM, Jeff Layton wrote:
>>> On Tue, 2020-03-03 at 08:44 -0700, Jens Axboe wrote:
>>>> On 3/3/20 7:24 AM, Greg Kroah-Hartman wrote:
>>>>> On Tue, Mar 03, 2020 at 03:13:26PM +0100, Jann Horn wrote:
>>>>>> On Tue, Mar 3, 2020 at 3:10 PM Greg Kroah-Hartman
>>>>>> <gregkh@linuxfoundation.org> wrote:
>>>>>>> On Tue, Mar 03, 2020 at 02:43:16PM +0100, Greg Kroah-Hartman wrote:
>>>>>>>> On Tue, Mar 03, 2020 at 02:34:42PM +0100, Miklos Szeredi wrote:
>>>>>>>>> On Tue, Mar 3, 2020 at 2:14 PM Greg Kroah-Hartman
>>>>>>>>> <gregkh@linuxfoundation.org> wrote:
>>>>>>>>>
>>>>>>>>>>> Unlimited beers for a 21-line kernel patch?  Sign me up!
>>>>>>>>>>>
>>>>>>>>>>> Totally untested, barely compiled patch below.
>>>>>>>>>>
>>>>>>>>>> Ok, that didn't even build, let me try this for real now...
>>>>>>>>>
>>>>>>>>> Some comments on the interface:
>>>>>>>>
>>>>>>>> Ok, hey, let's do this proper :)
>>>>>>>
>>>>>>> Alright, how about this patch.
>>>>>>>
>>>>>>> Actually tested with some simple sysfs files.
>>>>>>>
>>>>>>> If people don't strongly object, I'll add "real" tests to it, hook it up
>>>>>>> to all arches, write a manpage, and all the fun fluff a new syscall
>>>>>>> deserves and submit it "for real".
>>>>>>
>>>>>> Just FYI, io_uring is moving towards the same kind of thing... IIRC
>>>>>> you can already use it to batch a bunch of open() calls, then batch a
>>>>>> bunch of read() calls on all the new fds and close them at the same
>>>>>> time. And I think they're planning to add support for doing
>>>>>> open()+read()+close() all in one go, too, except that it's a bit
>>>>>> complicated because passing forward the file descriptor in a generic
>>>>>> way is a bit complicated.
>>>>>
>>>>> It is complicated, I wouldn't recommend using io_ring for reading a
>>>>> bunch of procfs or sysfs files, that feels like a ton of overkill with
>>>>> too much setup/teardown to make it worth while.
>>>>>
>>>>> But maybe not, will have to watch and see how it goes.
>>>>
>>>> It really isn't, and I too thinks it makes more sense than having a
>>>> system call just for the explicit purpose of open/read/close. As Jann
>>>> said, you can't currently do a linked sequence of open/read/close,
>>>> because the fd passing between them isn't done. But that will come in
>>>> the future. If the use case is "a bunch of files", then you could
>>>> trivially do "open bunch", "read bunch", "close bunch" in three separate
>>>> steps.
>>>>
>>>> Curious what the use case is for this that warrants a special system
>>>> call?
>>>>
>>>
>>> Agreed. I'd really rather see something more general-purpose than the
>>> proposed readfile(). At least with NFS and SMB, you can compound
>>> together fairly arbitrary sorts of operations, and it'd be nice to be
>>> able to pattern calls into the kernel for those sorts of uses.
>>>
>>> So, NFSv4 has the concept of a current_stateid that is maintained by the
>>> server. So basically you can do all this (e.g.) in a single compound:
>>>
>>> open <some filehandle get a stateid>
>>> write <using that stateid>
>>> close <same stateid>
>>>
>>> It'd be nice to be able to do something similar with io_uring. Make it
>>> so that when you do an open, you set the "current fd" inside the
>>> kernel's context, and then be able to issue io_uring requests that
>>> specify a magic "fd" value that use it.
>>>
>>> That would be a really useful pattern.
>>
>> For io_uring, you can link requests that you submit into a chain. Each
>> link in the chain is done in sequence. Which means that you could do:
>>
>> <open some file><read from that file><close that file>
>>
>> in a single sequence. The only thing that is missing right now is a way
>> to have the return of that open propagated to the 'fd' of the read and
>> close, and it's actually one of the topics to discuss at LSFMM next
>> month.
>>
>> One approach would be to use BPF to handle this passing, another
>> suggestion has been to have the read/close specify some magic 'fd' value
>> that just means "inherit fd from result of previous". The latter sounds
>> very close to the stateid you mention above, and the upside here is that
>> it wouldn't explode the necessary toolchain to need to include BPF.
>>
>> In other words, this is really close to being reality and practically
>> feasible.
>>
> 
> Excellent.
> 
> Yes, the latter is exactly what I had in mind for this. I suspect that
> that would cover a large fraction of the potential use-cases for this.
> 
> Basically, all you'd need to do is keep a pointer to struct file in the
> internal state for the chain. Then, allow userland to specify some magic
> fd value for subsequent chained operations that says to use that instead
> of consulting the fdtable. Maybe use -4096 (-MAX_ERRNO - 1)?

Yeah I think that'd be a suitable way to signal that.

> That would cover the smb or nfs server sort of use cases, I think. For
> the sysfs cases, I guess you'd need to dispatch several chains, but that
> doesn't sound _too_ onerous.

The magic fd would be per-chain, so doing multiple chains wouldn't
really matter at all.

Let me try and hack this up, should be pretty trivial.

> In fact, with that you should even be able to emulate the proposed
> readlink syscall in a userland library.

Exactly

-- 
Jens Axboe

