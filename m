Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0100E3BCE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 21:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389232AbfFJTeM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 15:34:12 -0400
Received: from sonic316-12.consmr.mail.gq1.yahoo.com ([98.137.69.36]:39449
        "EHLO sonic316-12.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388900AbfFJTeF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 15:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560195243; bh=b+qTXmr9rDlJOaZB+XwzJeE/PCmE3g/ZgFKqe2gvHfw=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=kEYBBdybysk7joQu6DpUNu26Q5TURGWUAeqLm+WKQkjtcUJQVzWIFNoCGrZhA+T3MfrcUUmEoEiMW67lnrN2lQWktXattVngUkorQQ4daCQfGvii1vb0K/AlYMYxw1SMP9SSEN33wvm8Bb6+RAfREM/RZLMkw5ZpOdcNoM7/Q/LceHWR8qOFTnZmA7JMgjqYxLlaWmL5SEdPV+0BNrWU/TcslRQjjUxpqL8pXvHbavyQ3EVYc2hyLVgJSKL6qhOiyJ5GCZYYsu3idBCDcE8iitLpqidINYx1qRX9atrfa5nodD052cJViiQjvaEOwbNlzb811m8flw6dV5StWBSPfQ==
X-YMail-OSG: EgispDUVM1k2Ec8k5D3DgupgeiQjsBopsJHhR2PPi4X1vaabmsZfhXTFwQLiE9w
 hCL6.TTfh_rf0Hyj_y5o4gJc4hmelBDI_abnAiZWSqsnDMsfImgAdshkQjoP8YaGGHQivVggnZke
 b2iKMjMcGqMaqMp.1i.L56rEr_K4i7PKgsmICHq9BmdLM88ia1wuoCiantpXZTganAkRnh1q2p5U
 uH3Zg8ra96hpc7pWxadmhHV7shB10ciLlXuOpMjOFYy8eat_0SCXBBs6k3_6wWc1MZIqGU38nOqT
 FkUveJh0KWyrGgiwt7ZYMp00vDk.pp3nHMXXylBEptT11e0_u2GFaHEuw6R7J0tuFdp_1tW1wq8e
 .vTW9dfMdUGRhlwkVpDNeulMlUxMxRPC3c7zVX0wwdKujUdTEtQsgrmovsgs9k3CqEzoVJlSAdyg
 tbnWfS8n9u6J0Psz9mWwrhI1YN1J231kez2RuwVZXeOHiRphv5pF5pRaZWCnzIFrfr2m4z8uIh8I
 z4gMI8He9QjkEyFl.QFb_WfVVRq2aDGbolQWTOEtAH52KxIpcV2DmhT73jXIBgVlltjnlEeZQN5C
 WDfzKQLdHrpqCArEgmxIolCZ9WfBBxTAReoYbYHiTmRRu5BfCMEK8viuN2AJf3zhU0sL7c2GK0.z
 OCJjAf1Z68g3dEN4pnsViusaQPExWxRWxP.DskJDrIx0jhgvNwQOQN5q8zvUC8hhY29Q1FNp7lFr
 o.F7Ma7g_6xZcHgDmIeq9pt0kw9a7qYjg3u3XO7apzaKkcfiwM0vOa9gAIelBqRX9qccb2hdEgG8
 Yv10ZpudsEiEl0tdJzQG6eMFfV.7TvK4_YLWMNYrbAGzRqTp3CjXDk7L6SJtLevven7bBi93osY8
 cZTHtroH7jS_CF24BbuVdeieIiWe8hMN2U5Fo0UdHWXRYhEse6YnRB5XFgpgm3ptjhtqWTI2T0Ik
 wPJzJnaHLIiOUB9hkrRTGEETqoZaH5dtKyL81iorHYDMRXrGUhMxqD5tnP3sbrzx35Q8FRcCc6kd
 rliwjpMhFVuSShg7TfiV7UAMuWGkHMR0RUxoh3KcFe60O_f6vk5Bzzn6ckgKF0P8U8k_cqqBE1Cz
 Bx6P17Tu0jpe5D4yyZyW9B6neyacg0q0vy5zwmxlPBVHYtIkSnTeI7Pxl7HOS6Bt4FhjzfK.IvCu
 RLyDmjF9990U22gnzhcIqaDZeYeHnLGvSX639z4IefrXikLkmPfs7Jk.4.UTUtg6Vx3I4bcPRYJw
 2li2XZixyPKYlkKaLtajAErIS.f4DofvJKzM-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Mon, 10 Jun 2019 19:34:03 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp431.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 769197f7c94510a94874fd97b31f197d;
          Mon, 10 Jun 2019 19:34:00 +0000 (UTC)
Subject: Re: [RFC][PATCH 00/13] Mount, FS, Block and Keyrings notifications
 [ver #4]
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
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
 <dac74580-5b48-86e4-8222-cac29a9f541d@schaufler-ca.com>
 <E0925E1F-E5F2-4457-8704-47B6E64FE3F3@amacapital.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <4b7d02b2-2434-8a7c-66cc-7dbebc37efbc@schaufler-ca.com>
Date:   Mon, 10 Jun 2019 12:33:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <E0925E1F-E5F2-4457-8704-47B6E64FE3F3@amacapital.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/10/2019 11:22 AM, Andy Lutomirski wrote:
>> On Jun 10, 2019, at 11:01 AM, Casey Schaufler <casey@schaufler-ca.com>=
 wrote:
>>
>>> On 6/10/2019 9:42 AM, Andy Lutomirski wrote:
>>>> On Mon, Jun 10, 2019 at 9:34 AM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
>>>>> On 6/10/2019 8:21 AM, Stephen Smalley wrote:
>>>>>> On 6/7/19 10:17 AM, David Howells wrote:
>>>>>> Hi Al,
>>>>>>
>>>>>> Here's a set of patches to add a general variable-length notificat=
ion queue
>>>>>> concept and to add sources of events for:
>>>>>>
>>>>>>  (1) Mount topology events, such as mounting, unmounting, mount ex=
piry,
>>>>>>      mount reconfiguration.
>>>>>>
>>>>>>  (2) Superblock events, such as R/W<->R/O changes, quota overrun a=
nd I/O
>>>>>>      errors (not complete yet).
>>>>>>
>>>>>>  (3) Key/keyring events, such as creating, linking and removal of =
keys.
>>>>>>
>>>>>>  (4) General device events (single common queue) including:
>>>>>>
>>>>>>      - Block layer events, such as device errors
>>>>>>
>>>>>>      - USB subsystem events, such as device/bus attach/remove, dev=
ice
>>>>>>        reset, device errors.
>>>>>>
>>>>>> One of the reasons for this is so that we can remove the issue of =
processes
>>>>>> having to repeatedly and regularly scan /proc/mounts, which has pr=
oven to
>>>>>> be a system performance problem.  To further aid this, the fsinfo(=
) syscall
>>>>>> on which this patch series depends, provides a way to access super=
block and
>>>>>> mount information in binary form without the need to parse /proc/m=
ounts.
>>>>>>
>>>>>>
>>>>>> LSM support is included, but controversial:
>>>>>>
>>>>>>  (1) The creds of the process that did the fput() that reduced the=
 refcount
>>>>>>      to zero are cached in the file struct.
>>>>>>
>>>>>>  (2) __fput() overrides the current creds with the creds from (1) =
whilst
>>>>>>      doing the cleanup, thereby making sure that the creds seen by=
 the
>>>>>>      destruction notification generated by mntput() appears to com=
e from
>>>>>>      the last fputter.
>>>>>>
>>>>>>  (3) security_post_notification() is called for each queue that we=
 might
>>>>>>      want to post a notification into, thereby allowing the LSM to=
 prevent
>>>>>>      covert communications.
>>>>>>
>>>>>>  (?) Do I need to add security_set_watch(), say, to rule on whethe=
r a watch
>>>>>>      may be set in the first place?  I might need to add a variant=
 per
>>>>>>      watch-type.
>>>>>>
>>>>>>  (?) Do I really need to keep track of the process creds in which =
an
>>>>>>      implicit object destruction happened?  For example, imagine y=
ou create
>>>>>>      an fd with fsopen()/fsmount().  It is marked to dissolve the =
mount it
>>>>>>      refers to on close unless move_mount() clears that flag.  Now=
, imagine
>>>>>>      someone looking at that fd through procfs at the same time as=
 you exit
>>>>>>      due to an error.  The LSM sees the destruction notification c=
ome from
>>>>>>      the looker if they happen to do their fput() after yours.
>>>>> I remain unconvinced that (1), (2), (3), and the final (?) above ar=
e a good idea.
>>>>>
>>>>> For SELinux, I would expect that one would implement a collection o=
f per watch-type WATCH permission checks on the target object (or to some=
 well-defined object label like the kernel SID if there is no object) tha=
t allow receipt of all notifications of that watch-type for objects relat=
ed to the target object, where "related to" is defined per watch-type.
>>>>>
>>>>> I wouldn't expect SELinux to implement security_post_notification()=
 at all.  I can't see how one can construct a meaningful, stable policy f=
or it.  I'd argue that the triggering process is not posting the notifica=
tion; the kernel is posting the notification and the watcher has been aut=
horized to receive it.
>>>> I cannot agree. There is an explicit action by a subject that result=
s
>>>> in information being delivered to an object. Just like a signal or a=

>>>> UDP packet delivery. Smack handles this kind of thing just fine. The=

>>>> internal mechanism that results in the access is irrelevant from
>>>> this viewpoint. I can understand how a mechanism like SELinux that
>>>> works on finer granularity might view it differently.
>>> I think you really need to give an example of a coherent policy that
>>> needs this.
>> I keep telling you, and you keep ignoring what I say.
>>
>>>  As it stands, your analogy seems confusing.
>> It's pretty simple. I have given both the abstract
>> and examples.
> You gave the /dev/null example, which is inapplicable to this patchset.=


That addressed an explicit objection, and pointed out
an exception to a generality you had asserted, which was
not true. It's also a red herring regarding the current
discussion.

>>>  If someone
>>> changes the system clock, we don't restrict who is allowed to be
>>> notified (via, for example, TFD_TIMER_CANCEL_ON_SET) that the clock
>>> was changed based on who changed the clock.
>> That's right. The system clock is not an object that
>> unprivileged processes can modify. In fact, it is not
>> an object at all. If you care to look, you will see that
>> Smack does nothing with the clock.
> And this is different from the mount tree how?

The mount tree can be modified by unprivileged users.
If nothing that unprivileged users can do to the mount
tree can trigger a notification you are correct, the
mount tree is very like the system clock. Is that the
case?=20

>>>  Similarly, if someone
>>> tries to receive a packet on a socket, we check whether they have the=

>>> right to receive on that socket (from the endpoint in question) and,
>>> if the sender is local, whether the sender can send to that socket.
>>> We do not check whether the sender can send to the receiver.
>> Bzzzt! Smack sure does.
> This seems dubious. I=E2=80=99m still trying to get you to explain to a=
 non-Smack person why this makes sense.

Process A sends a packet to process B.
If A has access to TopSecret data and B is not
allowed to see TopSecret data, the delivery should
be prevented. Is that nonsensical?

>>> The signal example is inapplicable.
>> From a modeling viewpoint the actions are identical.
> This seems incorrect to me

What would be correct then? Some convoluted combination
of system entities that aren't owned or controlled by
any mechanism?=20

>  and, I think, to most everyone else reading this.

That's quite the assertion. You may even be correct.

>  Can you explain?
>
> In SELinux-ese, when you write to a file, the subject is the writer and=
 the object is the file.  When you send a signal to a process, the object=
 is the target process.

YES!!!!!!!!!!!!

And when a process triggers a notification it is the subject
and the watching process is the object!

Subject =3D=3D active entity
Object  =3D=3D passive entity

Triggering an event is, like calling kill(), an action!


