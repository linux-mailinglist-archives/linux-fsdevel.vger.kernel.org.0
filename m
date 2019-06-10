Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70A1D3BB88
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 20:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388765AbfFJSCK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 14:02:10 -0400
Received: from sonic310-27.consmr.mail.gq1.yahoo.com ([98.137.69.153]:34831
        "EHLO sonic310-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388702AbfFJSCF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 14:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560189722; bh=lV+tKKEczHX6zGPstrNJV80uFtmTE/wxVIUJrQEbmH0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=jAIDOBGn5rpDZZMe7xse85jH8CUvXy0nHjBp1hJBValxbx2cH1pOOCoSTAHPozHxS7THO9e6OjcqOh+E1RxHzOjwtO5xzRpdV1uQB+fya2R4nAHbncxwB+z/4b6mlXjS4DqTfXo0yES0NvNZkLQgz8aZeYaWhRzprAvRNAzuZJawcNgCvsACDlYGfUEwORLkPGz1AfSMd+xQ7sP9BC7g6T95dx+d4t4tvWS+ruBd2ssJrJ0YR8WFpCYIbIRkYDoM7Qi5Z+uUppMw2fOKMf6yh2rBIWnSg55GbfsrANXuNup165P+mFRzROZWLnxBxO4m7TjPygD/bnmUz0nEnmCh2w==
X-YMail-OSG: YY7k8K4VM1muuAdr0dv28MUyFLe0PmLulP_.B.WR8ASDqyPEi8YrWXjGXIdfDgT
 1B4M_LuN2cHnE4uBA2AL7Bn88sIu3nYzmL9PTr1TFH6FlVyjdeWzp0a5OSAYmEEBxAGza45IQWXi
 V3q_ELvD.3H4SXhuDTdEIX5OpzP9LMbtk9baG86rmNKHT6JPi6sIsCNc0QWIR2JHk7xzOpTZvYqC
 mjSqWD0LiDWmIWNjhXquNOhZmmNS8Jm5VbK4Hgam8kSh2IyEGZvIudamjAjr1zZ7M.ipnUuVq73r
 CUBr_1Kgj4a2vS2Km0n4i1hNrN8cpj9pHvz2QVEFVqPqVB1FTry6sS92zx4zJWqsZWk1gMAQx32P
 lwkLf.r0w4RsUyMqcctYiB86BqA6N9C9o8lqWYLyfH4TLXqQ6Ie8mdNhrJuMsNI1IhJ5_VyU2bGD
 ALtJbxiMwlCEs03JHQz._V_r17Lu1zi94zjhMzuxRYE_7PhCp3OEItJ8Mfk4_1bCpTLL8h9CIP2V
 gtnYSFMO_z7Nq9nNvbX7WlpZl.eRz.hifXROfhrTQdlqG7EZ48Yuv7Bn4KC4KFXWMwtiP9TclD86
 lYQq5SmY_Q6VtJUn.w0uWK3HyHglnSj2ltfLptoyVFUq38xy8kj.Fs1FJE2fYkjX3z7yEbbcRPmv
 R9.vMatdaHClqOvFxXcaCI8yarsNZ3zbAdNT5XMuMDKmNtejnCJVbKTb63H9UN8s5hBp50cVk7aC
 EQXRbxJitfUKQ09c0jBoR6FQs3k2fkV.y3BBoIF9dz1qhQxCyecDj107Wlz5k76MCEdMiYZBLSyG
 Iz_OKv5ot00yLOcv8bW.xTQVL3bnpM374ZuJLPhUjL8N925B_6bpRSxL_lCSnmKPkC8sssiA53JG
 xt7h6xPSDRltfd9YdJZIkPm9JPzefAICp84JL5mkIiFrU4fAKNrMxRALM9AL4wBCify0Vo0CfWHm
 cnuNMyLt.O5bGh7KegfFV95U6KsRPsxNYeVkwBEOpTrlUJXi6RcKrdOvQg34LxfLEpPlzWU5gwmO
 pvBjqNxncgv1OOm3.dI6uiAyoHO5W.g1QUI3vuCZ2dhFSxRf.5GkN.7IhT2tRo4q1whX3qlVyN8Y
 IN.FkcByf8a9Dy3cUzW5ERivTy8h9qYM7500Nr9pGvw_ai0rr9U17ar6KhgGprku8enNW8EPMWbu
 sKiA8JoIDI8OBKqW5AyqRPLViCbKOc_06bS6zVBWojJL9mnCgcMAYToTmhve2CBnMp2iZN_zrNAN
 ceDN5LE8LXbsUxBExMQMZLT2AEUKVdvnkh_ha
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Mon, 10 Jun 2019 18:02:02 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp429.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID fb4873ed39895ada10e7258b0b9ef7c7;
          Mon, 10 Jun 2019 18:01:59 +0000 (UTC)
Subject: Re: [RFC][PATCH 00/13] Mount, FS, Block and Keyrings notifications
 [ver #4]
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        USB list <linux-usb@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        raven@themaw.net, Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>, casey@schaufler-ca.com
References: <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk>
 <be966d9c-e38d-7a30-8d80-fad5f25ab230@tycho.nsa.gov>
 <0cf7a49d-85f6-fba9-62ec-a378e0b76adf@schaufler-ca.com>
 <CALCETrX5O18q2=dUeC=hEtK2=t5KQpGBy9XveHxFw36OqkbNOg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <dac74580-5b48-86e4-8222-cac29a9f541d@schaufler-ca.com>
Date:   Mon, 10 Jun 2019 11:01:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CALCETrX5O18q2=dUeC=hEtK2=t5KQpGBy9XveHxFw36OqkbNOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/10/2019 9:42 AM, Andy Lutomirski wrote:
> On Mon, Jun 10, 2019 at 9:34 AM Casey Schaufler <casey@schaufler-ca.com=
> wrote:
>> On 6/10/2019 8:21 AM, Stephen Smalley wrote:
>>> On 6/7/19 10:17 AM, David Howells wrote:
>>>> Hi Al,
>>>>
>>>> Here's a set of patches to add a general variable-length notificatio=
n queue
>>>> concept and to add sources of events for:
>>>>
>>>>   (1) Mount topology events, such as mounting, unmounting, mount exp=
iry,
>>>>       mount reconfiguration.
>>>>
>>>>   (2) Superblock events, such as R/W<->R/O changes, quota overrun an=
d I/O
>>>>       errors (not complete yet).
>>>>
>>>>   (3) Key/keyring events, such as creating, linking and removal of k=
eys.
>>>>
>>>>   (4) General device events (single common queue) including:
>>>>
>>>>       - Block layer events, such as device errors
>>>>
>>>>       - USB subsystem events, such as device/bus attach/remove, devi=
ce
>>>>         reset, device errors.
>>>>
>>>> One of the reasons for this is so that we can remove the issue of pr=
ocesses
>>>> having to repeatedly and regularly scan /proc/mounts, which has prov=
en to
>>>> be a system performance problem.  To further aid this, the fsinfo() =
syscall
>>>> on which this patch series depends, provides a way to access superbl=
ock and
>>>> mount information in binary form without the need to parse /proc/mou=
nts.
>>>>
>>>>
>>>> LSM support is included, but controversial:
>>>>
>>>>   (1) The creds of the process that did the fput() that reduced the =
refcount
>>>>       to zero are cached in the file struct.
>>>>
>>>>   (2) __fput() overrides the current creds with the creds from (1) w=
hilst
>>>>       doing the cleanup, thereby making sure that the creds seen by =
the
>>>>       destruction notification generated by mntput() appears to come=
 from
>>>>       the last fputter.
>>>>
>>>>   (3) security_post_notification() is called for each queue that we =
might
>>>>       want to post a notification into, thereby allowing the LSM to =
prevent
>>>>       covert communications.
>>>>
>>>>   (?) Do I need to add security_set_watch(), say, to rule on whether=
 a watch
>>>>       may be set in the first place?  I might need to add a variant =
per
>>>>       watch-type.
>>>>
>>>>   (?) Do I really need to keep track of the process creds in which a=
n
>>>>       implicit object destruction happened?  For example, imagine yo=
u create
>>>>       an fd with fsopen()/fsmount().  It is marked to dissolve the m=
ount it
>>>>       refers to on close unless move_mount() clears that flag.  Now,=
 imagine
>>>>       someone looking at that fd through procfs at the same time as =
you exit
>>>>       due to an error.  The LSM sees the destruction notification co=
me from
>>>>       the looker if they happen to do their fput() after yours.
>>> I remain unconvinced that (1), (2), (3), and the final (?) above are =
a good idea.
>>>
>>> For SELinux, I would expect that one would implement a collection of =
per watch-type WATCH permission checks on the target object (or to some w=
ell-defined object label like the kernel SID if there is no object) that =
allow receipt of all notifications of that watch-type for objects related=
 to the target object, where "related to" is defined per watch-type.
>>>
>>> I wouldn't expect SELinux to implement security_post_notification() a=
t all.  I can't see how one can construct a meaningful, stable policy for=
 it.  I'd argue that the triggering process is not posting the notificati=
on; the kernel is posting the notification and the watcher has been autho=
rized to receive it.
>> I cannot agree. There is an explicit action by a subject that results
>> in information being delivered to an object. Just like a signal or a
>> UDP packet delivery. Smack handles this kind of thing just fine. The
>> internal mechanism that results in the access is irrelevant from
>> this viewpoint. I can understand how a mechanism like SELinux that
>> works on finer granularity might view it differently.
> I think you really need to give an example of a coherent policy that
> needs this.

I keep telling you, and you keep ignoring what I say.

>   As it stands, your analogy seems confusing.

It's pretty simple. I have given both the abstract
and examples.

>   If someone
> changes the system clock, we don't restrict who is allowed to be
> notified (via, for example, TFD_TIMER_CANCEL_ON_SET) that the clock
> was changed based on who changed the clock.

That's right. The system clock is not an object that
unprivileged processes can modify. In fact, it is not
an object at all. If you care to look, you will see that
Smack does nothing with the clock.

>   Similarly, if someone
> tries to receive a packet on a socket, we check whether they have the
> right to receive on that socket (from the endpoint in question) and,
> if the sender is local, whether the sender can send to that socket.
> We do not check whether the sender can send to the receiver.

Bzzzt! Smack sure does.

> The signal example is inapplicable.

=46rom a modeling viewpoint the actions are identical.

>   Sending a signal to a process is
> an explicit action done to that process, and it can easily adversely
> affect the target.  Of course it requires permission.
>
> --Andy

