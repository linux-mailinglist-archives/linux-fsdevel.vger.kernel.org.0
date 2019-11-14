Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEE2FCA7A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 17:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfKNQEb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 11:04:31 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45802 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfKNQEb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 11:04:31 -0500
Received: by mail-ed1-f68.google.com with SMTP id b5so5423332eds.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2019 08:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xNluNzljo4oepL4eZ8DPTsyRKvc1XCTxfiF0OmWAKuY=;
        b=Esr0xHJyKwsCSFfK2dSh39lIrC+UowbEfHdn1RRhETWy7jyLFImcDzmM4RwGtMmYso
         L5gdOH36H8nV/Ss+wOIZKja7qhiZNTncTaXGmOzFnDmSOX/SYYxIcUxpo2faSsr5xQPV
         PoZ+RI5ihOn+rAf7Kk7g72a/E48DC0zjG8YXhY3UEZHiXkfSK9ceiMuk3J5jDElwGIty
         BW6tFyvFKTQh4UUhSreyfgEgId8MvRWgpMXGpwJVpm/3Fhbe1gpsHJxyk8EmPIbmA6Ei
         ojtlhBS/a1+uQD2QRKQUtzqxKdYRoQobiBvcI6SmDXi+5tDfpEm1a+OWF+ONOCe9MK62
         0LNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xNluNzljo4oepL4eZ8DPTsyRKvc1XCTxfiF0OmWAKuY=;
        b=cm9sM9wtxSy2okHk/RKSC3LEvTJ5TIPs9cPYgfIKeRtRDSwCHPyRNfFO+mSZPUhHv3
         i+jVj8Vs6LB5c2b/PTHB5YUoF5LaYLBHvrdcnPdnAiqF/MqaxYd1D/VwMVKKfWqyhlRX
         9sGRSLa6z0BhHI9ZaYJyx6Md0pJ3fRZPyc1ZPS8YBXbFJ5z0iYu26crAg3ksEcLm5LnQ
         yfyqwyPiyD3grliKAwes7thwypg2ii564e4BtM66FuOGK9okE128cC6hcOyoBivE0T9I
         DFcepyqPgn0uxophVy/WmIGo2UqnzuQte0igm2HPMvW/gJ2uIweN1GZFLjAY06M01evk
         PL0g==
X-Gm-Message-State: APjAAAW7DCsZ8zzjHfdZI/oL6V+8rLVcBZsVahdgZvNp0T9ElzSMGBtd
        vYdoMuHCC22yD5h8O0suZAMeOg==
X-Google-Smtp-Source: APXvYqy6BcN1CKU46ZcMSS1jgPINC77AiCVHw4B74ghE0zkqUlu1EYFzGA+K4vs2mSG46f22PC7auA==
X-Received: by 2002:aa7:d147:: with SMTP id r7mr2111229edo.198.1573747469083;
        Thu, 14 Nov 2019 08:04:29 -0800 (PST)
Received: from [10.68.217.182] ([217.70.210.43])
        by smtp.googlemail.com with ESMTPSA id z69sm399121ede.88.2019.11.14.08.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 08:04:28 -0800 (PST)
Subject: Re: Please add the zuf tree to linux-next
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Boaz Harrosh <boaz@plexistor.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
References: <1b192a85-e1da-0925-ef26-178b93d0aa45@plexistor.com>
 <20191024023606.GA1884@infradead.org>
 <20191029160733.298c6539@canb.auug.org.au>
 <514e220d-3f93-7ce3-27cd-49240b498114@plexistor.com>
 <CAJfpegtT-nX7H_-5xpkP+fp8LfdVGbSTfnNf-c=a_EfOd3R5tA@mail.gmail.com>
From:   Boaz Harrosh <boaz@plexistor.com>
Message-ID: <e723e3cc-210a-4d6d-af86-b3a9c94cb379@plexistor.com>
Date:   Thu, 14 Nov 2019 18:04:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAJfpegtT-nX7H_-5xpkP+fp8LfdVGbSTfnNf-c=a_EfOd3R5tA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14/11/2019 16:56, Miklos Szeredi wrote:
> On Thu, Nov 14, 2019 at 3:02 PM Boaz Harrosh <boaz@plexistor.com> wrote:
> 
>> At the last LSF. Steven from Red-Hat asked me to talk with Miklos about the fuse vs zufs.
>> We had a long talk where I have explained to him in detail How we do the mounting, how
>> Kernel owns the multy-devices. How we do the PMEM API and our IO API in general. How
>> we do pigi-back operations to minimize latencies. How we do DAX and mmap. At the end of the
>> talk he said to me that he understands how this is very different from FUSE and he wished
>> me "good luck".
>>
>> Miklos - you have seen both projects; do you think that All these new subsystems from ZUFS
>> can have a comfortable place under FUSE, including the new IO API?
> 
> It is quite true that ZUFS includes a lot of innovative ideas to
> improve the performance of a certain class of userspace filesystems.
> I think most, if not all of those ideas could be applied to the fuse
> implementation as well, 

This is not so:

- The way we do the mount is very different. It is not the Server that does
  The mount but the Kernel. So auto bind mount works (same device different dir)
- The way zuf owns the devices in the Kernel, and supports multi-devices.
  And has support for pmem devices as well as what we call t2 (regular) block
  devices. And the all API for transfer between them. (The all md.* thing).
  Proper locking of devices.
- The way we are true zero-copy both pmem and t2.
- The way we are DAX both pwrite and mmap.
- The way we are NUMA aware both Kernel and Server.
- The way we use shared memory pools that are deep in the protocol between
  Server and Kernel for zero copy of meta-data as well as protocol buffers.
- The way we do pigy-back of operations to save round-trips.
- The way we use cookies in Kernel of all Server objects so there are no
  i_ino hash tables or look-ups.
- The way we use a single Server with loadable FS modules. That the ZUSD comes
  with the distro and only the FS-pluging comes from Vendor. So Kernel=Server API
  is in sync.
- The way ZUFS supports root filesystem.
- The way ZUFS supports VM-FS to SHARE same p-memory as HOST-FS
- The way we do Zero-copy IO, both pmem and bdevs

> but I can understand why this hasn't been
> done.  Fuse is in serious need of a cleanup, which I've started to do,
> but it's not there yet...
> 

This will not be wise. It will be a complete FULL zuf code drop into the
current fuse code base (fuse is BTW bigger then zuf). I think this is the
Last thing fuse needs.

I know for a fact that the code of fuse+zuf will be bigger and slower than
those two Separate.

zufs is built from the ground up, built on all those subsystems as
building blocks. Putting all these things into fuse will actually be like
putting a pyramid on its head.

> One of the major issues that I brought up when originally reviewing
> ZUFS (but forgot to discuss at LSF) is about the userspace API.  I
> think it would make sense to reuse FUSE protocol definition and extend
> it where needed.   That does not mean ZUFS would need to be 100%
> backward compatible with FUSE, it would just mean that we'd have a
> common userspace API and each implementation could implement a subset
> of features.

This is easy to say. But believe me it is not possible. The shared structures
are maybe 20% and not 80% as the theory might feel about it. The projects are
really structured differently.

I have looked at it long and hard, Many times. I do not know how to this.
If I knew how I would.

These codes and systems do very different things. It will need tones of
if()s and operation changes. Sometimes you do a copy/paste of ext4 into
ffs2 and so on. Because the combination is not always the best and the
easiest.

> I think this would be an immediate and significant
> boon for ZUFS, since it would give it an already existing user/tester
> base that it otherwise needs to build up.  It would also allow
> filesystem implementation to be more easily switchable between the
> kernel frameworks in case that's necessary.
> 

Thanks Miklos for your input. I have looked at this problems many times.
This is not something that is interesting for me. Because these two projects
come to solve different things.

And it is not so easy to do as it sounds. There are fundamental difference
between the projects. For example in fuse main() belongs to the FS. That needs
to supply its own mount application. In ZUFS we do the regular Kernel's /sbin/mount.
Also ZUS User-mode server has a huge facility for allocating pages, mlocking,
per-cpu counters per-cpu variables, NUMA memory management. Thread management.
The API with zuf is very very particular about tons of things. Involving threads
and special files and mmap calls, and shared memory with Kernel. This will not be so
easily interchangeable.

> Thanks,
> Miklos
> 

Sometimes a fresh new code is much easier more maintainable and faster / more capable
then a do-it-all blob of code.
I am not sure if you actually looked at the code both Kernel and Server. This is not so easy
as it sounds. Even after a deep fuse cleanup.

Yes perhaps we could share some core code, like what sits in zuf-core.c and the relay object
but not more then that.

Thanks
Boaz
