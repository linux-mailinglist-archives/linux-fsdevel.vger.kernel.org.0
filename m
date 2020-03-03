Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1FB177AD2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 16:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbgCCPor (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 10:44:47 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:37526 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728787AbgCCPor (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 10:44:47 -0500
Received: by mail-io1-f68.google.com with SMTP id c17so4081410ioc.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2020 07:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZG+Z5PlJjVm8PVRrvVFjKYG60wCcDQJcM/cIXR7GgWs=;
        b=Lz3S0tthIYaC3IENsF36JWiCsuLYH86LS7/c5LNNFUEJdwftjJ3tcQmCn4mVtCUG+o
         XseDzhB4vzz/3J+8RSvuHvNBmm78EbXQEYUrGpskbzlT0lU51zA5VhjKVW5EOc0mrWso
         QKzxShqhorVF33vtLXFwI7HEZoQD6SVTfR//8ia1gWa4HyuJ78V1DbQi8ljs30PCwUbL
         5urcNDkfNkyj+1/5qRoCUz1PYUOcI0v1EQRD4tP5gftHukoNMnV8YNXLdD4VL64vaRFr
         IiTgTTZWvn3m3Iyr38KQDBs8ijMhd/Xl4ltF3hqoGqwJ3s0YIl5rWElbuumej2uE3WFV
         aqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZG+Z5PlJjVm8PVRrvVFjKYG60wCcDQJcM/cIXR7GgWs=;
        b=Gl8EPx8EFEewA6Ku/1GzJNSP0jx6P8PgS2TYL1T3H6fgL76a+HNUXUd3Dc9PfKql45
         B0yu7b4D6E207/6HI2dT8vlj5FFLd/5YCCVH23vPkLMg4Pr9FfOSdVcJlS5u71IQKkqk
         FfmwMpNyCrqRmbKgNVK4wmxWThfneZwHEuOQ62uEsVYCoSYJSXW2VwK1gPeXF6oqaK+A
         5DcmHZrkkG7ew/QFKg4QL5/Yn/UpDc3g3Ifv/Lxu0J0okuv9ATEzlnAlzokjbKZoX1cL
         TSU5xQOY78Z0Mh7/keK6cin0Ex76wsS7qSq4wSJBTkkL+kN6A4GeFd21RDISa1au8xUy
         uG6Q==
X-Gm-Message-State: ANhLgQ3bmhwqEwU9ex12kUrFqALWuGvPuHchXYPWBLUmWgMwGBpZn5hf
        lt6Ps4ydGQyadw28JOisoW3tCw==
X-Google-Smtp-Source: ADFU+vtxG3oWgwLPSPn/IZ0T3hF+eib4xFsRFf/5PavaMAyfTas5IKEm4Hjr+94AF9p8J0X/cfg78w==
X-Received: by 2002:a5e:c207:: with SMTP id v7mr4350463iop.88.1583250286473;
        Tue, 03 Mar 2020 07:44:46 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e65sm8011244ilg.2.2020.03.03.07.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 07:44:45 -0800 (PST)
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver
 #17]
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <030888a2-db3e-919d-d8ef-79dcc10779f9@kernel.dk>
Date:   Tue, 3 Mar 2020 08:44:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303142407.GA47158@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/3/20 7:24 AM, Greg Kroah-Hartman wrote:
> On Tue, Mar 03, 2020 at 03:13:26PM +0100, Jann Horn wrote:
>> On Tue, Mar 3, 2020 at 3:10 PM Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>>
>>> On Tue, Mar 03, 2020 at 02:43:16PM +0100, Greg Kroah-Hartman wrote:
>>>> On Tue, Mar 03, 2020 at 02:34:42PM +0100, Miklos Szeredi wrote:
>>>>> On Tue, Mar 3, 2020 at 2:14 PM Greg Kroah-Hartman
>>>>> <gregkh@linuxfoundation.org> wrote:
>>>>>
>>>>>>> Unlimited beers for a 21-line kernel patch?  Sign me up!
>>>>>>>
>>>>>>> Totally untested, barely compiled patch below.
>>>>>>
>>>>>> Ok, that didn't even build, let me try this for real now...
>>>>>
>>>>> Some comments on the interface:
>>>>
>>>> Ok, hey, let's do this proper :)
>>>
>>> Alright, how about this patch.
>>>
>>> Actually tested with some simple sysfs files.
>>>
>>> If people don't strongly object, I'll add "real" tests to it, hook it up
>>> to all arches, write a manpage, and all the fun fluff a new syscall
>>> deserves and submit it "for real".
>>
>> Just FYI, io_uring is moving towards the same kind of thing... IIRC
>> you can already use it to batch a bunch of open() calls, then batch a
>> bunch of read() calls on all the new fds and close them at the same
>> time. And I think they're planning to add support for doing
>> open()+read()+close() all in one go, too, except that it's a bit
>> complicated because passing forward the file descriptor in a generic
>> way is a bit complicated.
> 
> It is complicated, I wouldn't recommend using io_ring for reading a
> bunch of procfs or sysfs files, that feels like a ton of overkill with
> too much setup/teardown to make it worth while.
> 
> But maybe not, will have to watch and see how it goes.

It really isn't, and I too thinks it makes more sense than having a
system call just for the explicit purpose of open/read/close. As Jann
said, you can't currently do a linked sequence of open/read/close,
because the fd passing between them isn't done. But that will come in
the future. If the use case is "a bunch of files", then you could
trivially do "open bunch", "read bunch", "close bunch" in three separate
steps.

Curious what the use case is for this that warrants a special system
call?

-- 
Jens Axboe

