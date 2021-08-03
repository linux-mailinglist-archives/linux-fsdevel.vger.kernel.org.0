Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CA83DF7CF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 00:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhHCWan (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 18:30:43 -0400
Received: from mout.gmx.net ([212.227.15.15]:36707 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229611AbhHCWan (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 18:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628029793;
        bh=VveEwFhEVJvR/f/tkOmF9Se0fAJfnMxJr2QcJgUnUxs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=M1qfLh2SJbmIagyvcq+cnaGlKJz64Cke+Qh7c+9cVNXa574IpTdbBUKxceokYemJz
         kpb2X4YfppO9a0uemi0w5lFdu7TK9zPSoPJrbdMS0nArf7sbIobf9Cs5xL2zP0VbtA
         NEpCPv4KRN4g1oZd124PErfItsvcaw5p+HdMAIF4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MKsnP-1mRDGH1W3R-00LIhr; Wed, 04
 Aug 2021 00:29:53 +0200
Subject: Re: A Third perspective on BTRFS nfsd subvol dev/inode number issues.
To:     Josef Bacik <josef@toxicpanda.com>,
        Amir Goldstein <amir73il@gmail.com>, NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <162742546548.32498.10889023150565429936.stgit@noble.brown>
 <YQNG+ivSssWNmY9O@zeniv-ca.linux.org.uk>
 <162762290067.21659.4783063641244045179@noble.neil.brown.name>
 <CAJfpegsR1qvWAKNmdjLfOewUeQy-b6YBK4pcHf7JBExAqqUvvg@mail.gmail.com>
 <162762562934.21659.18227858730706293633@noble.neil.brown.name>
 <CAJfpegtu3NKW9m2jepRrXe4UTuD6_3k0Y6TcCBLSQH7SSC90BA@mail.gmail.com>
 <162763043341.21659.15645923585962859662@noble.neil.brown.name>
 <CAJfpegub4oBZCBXFQqc8J-zUiSW+KaYZLjZaeVm_cGzNVpxj+A@mail.gmail.com>
 <162787790940.32159.14588617595952736785@noble.neil.brown.name>
 <YQeB3ASDyO0wSgL4@zeniv-ca.linux.org.uk>
 <162788285645.32159.12666247391785546590@noble.neil.brown.name>
 <CAOQ4uxgnGWMUvtyJ0MMxMzHFwiyR68FHorDNmLSva0CdpVNNcQ@mail.gmail.com>
 <2337f1ba-ffed-2369-47a0-5ffda2d8b51c@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <beb00e40-1058-d88e-6d06-b0ffddacbb39@gmx.com>
Date:   Wed, 4 Aug 2021 06:29:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <2337f1ba-ffed-2369-47a0-5ffda2d8b51c@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2TuxT3PyCrTEnO/hkRUoOTuzj2XgLWwrnVTW5B6pRr40jcn0WXr
 mQqMkccd72wUN0TWhncxG+kH6P3+A6b91xUcNaK7gVCaa4SJSLbHhqY8Q8+yx778AdNfhqa
 tNbOmWi6ZlfAdyUwKqIYjjaO4ycvBelcSjBwkWrwkbZyNE5s9onDNdhUMkP9YwDGKVfFZ06
 tylcnRrAgbfFvuJNGRWTA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gDT4QhjdgvU=:y6faMYwKxIYgcmY7jehv0O
 mbko+1dYIyxsCrFx67MSaNHG3qGWH2n1RXXlFf3Afa4yD+0vtpQLbKeu+Am3TSJNiqhKOxW/Z
 /7q11mQRLQowCSTNgOLW4Chor8K1XBA0W6iwc2vPSCUZR0a9A2plBkQNbgJ2NZ5udWAOhnAur
 Lmxou383SZ0sVGQ3C2ODI2pR7HMYbJAeMKgKKvc71cPAlb/JLQ8df3MQi97jM13R+kbwYI85J
 o+XUbWWZBuna0yEDq1MmdaxjtbAukWpKCEWx7erxqEyQQstniR0nWZC7Kw9BxdpVGcqU2COAN
 O06IGkpz7Z1bmQIZ0+zCUhhHhDSKNR6weHNdE48Nc5GSMP+aWGndxUxILoDx5eeRIZtFVQ+HB
 ipZHOx3rQcnhY6xrGVO8AYG1MPcUnwALaZ7Y1JcRK7y8XH1X8kIWzbnLbMT0hwB2W+e2QwQie
 H4D9vgWZgfxQfNCWFQS0qQ9avnWEoj//PvuCTjjFAZgGdrMfo/RVE/qqKTcXoQYDp5WVKVJjW
 9WpVEaKtWP5rr56mzhcteFpE9zkWewUbFN7SnJ1TancEjj9Tybry5ZyK1L15zKG08lE3NhgIh
 RfKDhXQu+G9S5q7uqySwVsTEKpp/dGc7nray4PzRtJi0lo3xA5G2NxPZNY75tCATGuBoGNuMl
 THGkfNWmqbY1PIGnJHfPA9LWgSKc2lwgGNfdIPNWMkP+32R0NVr+g8v9v/zlzmLTq+H6Qb2kl
 07DISMVm6yW2+9VvA15/RCaN/OApWDYRjff/Ty8Eoms5maikg/LBqyG3btxkC0aRRFRglufC9
 6IBUqUwnCCZ8vtuHxZFHrUQPonAHCL+T1LMKhP1jWt+nn57gwbZAt++QR2KscP0IbB2K3RaJK
 YDIbc3BAD9u7VaypwgNI+IJZ8encNEiCuxGkl+Dk93qkWfRXNsjRlGv8YsUwexHR5WPAYP2R/
 /6uRjZ6a6EVbo2FZjA7YhPdgo17dly2iYoY4hgMMbdUeMGktvd8gb4uux2O+VfJ8dY0z9AXNI
 PiVna2i+KECUmOed/sp6Wr/NUjA8aFNPYocGhdqQA+0BrJsCev/fwdsvdisHvnTbBJXh8UyHC
 CxrAvpslK1kC33nFBRXmcyKFkDRj9CRlKyBz245/7dogGy0NFza/kqdXg==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/8/2 =E4=B8=8B=E5=8D=889:53, Josef Bacik wrote:
> On 8/2/21 3:54 AM, Amir Goldstein wrote:
>> On Mon, Aug 2, 2021 at 8:41 AM NeilBrown <neilb@suse.de> wrote:
>>>
>>> On Mon, 02 Aug 2021, Al Viro wrote:
>>>> On Mon, Aug 02, 2021 at 02:18:29PM +1000, NeilBrown wrote:
>>>>
>>>>> It think we need to bite-the-bullet and decide that 64bits is not
>>>>> enough, and in fact no number of bits will ever be enough.=C2=A0 ove=
rlayfs
>>>>> makes this clear.
>>>>
>>>> Sure - let's go for broke and use XML.=C2=A0 Oh, wait - it's 8 months=
 too
>>>> early...
>>>>
>>>>> So I think we need to strongly encourage user-space to start using
>>>>> name_to_handle_at() whenever there is a need to test if two things a=
re
>>>>> the same.
>>>>
>>>> ... and forgetting the inconvenient facts, such as that two different
>>>> fhandles may correspond to the same object.
>>>
>>> Can they?=C2=A0 They certainly can if the "connectable" flag is passed=
.
>>> name_to_handle_at() cannot set that flag.
>>> nfsd can, so using name_to_handle_at() on an NFS filesystem isn't quit=
e
>>> perfect.=C2=A0 However it is the best that can be done over NFS.
>>>
>>> Or is there some other situation where two different filehandles can b=
e
>>> reported for the same inode?
>>>
>>> Do you have a better suggestion?
>>>
>>
>> Neil,
>>
>> I think the plan of "changing the world" is not very realistic.
>> Sure, *some* tools can be changed, but all of them?
>>
>> I went back to read your initial cover letter to understand the
>> problem and what I mostly found there was that the view of
>> /proc/x/mountinfo was hiding information that is important for
>> some tools to understand what is going on with btrfs subvols.
>>
>> Well I am not a UNIX history expert, but I suppose that
>> /proc/PID/mountinfo was created because /proc/mounts and
>> /proc/PID/mounts no longer provided tool with all the information
>> about Linux mounts.
>>
>> Maybe it's time for a new interface to query the more advanced
>> sb/mount topology? fsinfo() maybe? With mount2 compatible API for
>> traversing mounts that is not limited to reporting all entries inside
>> a single page. I suppose we could go for some hierarchical view
>> under /proc/PID/mounttree. I don't know - new API is hard.
>>
>> In any case, instead of changing st_dev and st_ino or changing the
>> world to work with file handles, why not add inode generation (and
>> maybe subvol id) to statx().
>> filesystem that care enough will provide this information and tools tha=
t
>> care enough will use it.
>>
>
> Can y'all wait till I'm back from vacation, goddamn ;)
>
> This is what I'm aiming for, I spent some time looking at how many
> places we string parse /proc/<whatever>/mounts and my head hurts.
>
> Btrfs already has a reasonable solution for this, we have UUID's for
> everything.=C2=A0 UUID's aren't a strictly btrfs thing either, all the f=
ile
> systems have some sort of UUID identifier, hell its built into blkid.=C2=
=A0 I
> would love if we could do a better job about letting applications query
> information about where they are.=C2=A0 And we could expose this with th=
e
> relatively common UUID format.=C2=A0 You ask what fs you're in, you get =
the
> FS UUID, and then if you're on Btrfs you get the specific subvolume UUID
> you're in.=C2=A0 That way you could do more fancy things like know if yo=
u've
> wandered into a new file system completely or just a different subvolume=
.

I'm completely on the side of using proper UUID.

But suddenly I find a problem for this, at least we still need something
like st_dev for real volume based snapshot.

One of the problem for real volume based snapshot is, the snapshoted
volume is completely the same filesystem, every binary is the same,
including UUID.

That means, the only way to distinguish such volumes is by st_dev.

For such pure UUID base solution, it's in fact unable to distinguish
them using just UUID.
Unless we have some device UUID to replace the old st_dev.

Thanks,
Qu

>
> We have to keep the st_ino/st_dev thing for backwards compatibility, but
> make it easier to get more info out of the file system.
>
> We could in theory expose just the subvolid also, since that's a nice
> simple u64, but it limits our ability to do new fancy shit in the
> future.=C2=A0 It's not a bad solution, but like I said I think we need t=
o
> take a step back and figure out what problem we're specifically trying
> to solve, and work from there.=C2=A0 Starting from automounts and workin=
g our
> way back is not going very well.=C2=A0 Thanks,
>
> Josef
