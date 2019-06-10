Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE8AA3BE8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 23:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389760AbfFJVZg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 17:25:36 -0400
Received: from sonic308-13.consmr.mail.gq1.yahoo.com ([98.137.68.37]:37840
        "EHLO sonic308-13.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728581AbfFJVZg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560201932; bh=I1Yl4YP9K+yur8hXYjcpGdRMsu1sEId+cdNG1Bfiqf4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=PaTvIdPpCsJWz+O6CdwANPRpWQpAwtM/UaqINKUdqxkFszcDCxF5fn/IrpFNWYCq76uuow3yIzbJffQVVMAXRvNdYji/k3q7kBlcPwrXvC9PGmXOLfe8Duw4UtGubIGwNMxRLAS/NPoh+EICUJDrJMgPV2ZDgDWhoMuBlPyMb5Tb557EPoBG3BQMVZhVtCQIsS4xEKINnvMyiTzUHE/5F3UFK0Y+6EqPlK9u4F6G83aJEG9bM6trl7T6yYzF9+1oPWTqEVDfTfawleSO+iqXe9+/VxcdAay95gFpjB9FLoYsKi//ZqSdRmJTN/wnRcM6kIdikkRcqZeucZFYWVauNw==
X-YMail-OSG: rdNANI0VM1ltB1J5mpJdr5JwAiudHi272DxJql6wSvUAqWjK2aNLpXVGUdDVjlU
 mimOdAXsK.stwGnbBa6TEmcM8hH_eWCJv0JFpN65Wt1pRnLd2WOWI_NQZMbZrUyKMHUnSFzaP_Km
 zMWpHwU3HguoJVmXB699Zu9VOQHJM0C.Tfs8.79czaKmaKHkrVjJvXkg2q_fEXi5zwykgm.Evwzc
 Ay0kDRJ7NbA2Kpb.L_y1EtmK2OfjUnWFsK2GdUxUHMM2Vpdk4R_0kGdxICM6lKr0FteG65qNAV7I
 qF0MqOp5JVFXetVR.5W6CfB_Pjxf6nLedDHDP3GM24GdUGxoh20ndYBIjGjC2bM28LBJskB5.1DN
 YeuwqpqG8K2xJWGJkVK4uygNnw_yYPn5GfoVvFp0A6RCT_s8yTqQn71VnQegM4Gx341E0cXj9e8M
 s6x9_yr3WdiB.teJFG8mE9PpgJq1Yg9IUmAmed3oDPiMU5oC06pxWzanvxgcDg5Sf0DlKnOzlvCO
 zGPvA4WsFD7IoZtfrzUUOI61_5pGQEm04pQva7FHS8Zp3gs8zGy3QE1wcNudITDjy54mOhxkOM66
 .PzJqznD3HVGVp.Q3dKcv76ZAtfXeB70QTdTzdqA4vlGzJN2IpZVl7K8CGyQIJU9uw0Lu04Yj7dW
 n3n.jrP.IsQ7.ExNppZ1nVvrotWoCCQ7P1pQjHJAIoijmlz6KV2VOjIqGjsuEVN8JbNay9XSiIT3
 J.hCNYH.Dp89OV39Qj3q1Sqs9yOHEkiq1jTA_Jvlkg8E3ZM1fhN8icFxnRHbv8etalrDTAL1HYrT
 RCGBstc5PkeiPtgzX5TsiFye8xtokqqNoekMD5wUiK01Wb9v.3EK67.kcHXbrfI0HT06ofntsgYm
 nz82T4lAYIPb_zhMdxtW.oncdCyOT5EIKapeY8.z0YNwod_aULiAR97xppZhCYnW.h.dQ2dNW9d.
 aQ6cVX7hz1L9WYHN4lx3wGUch6LnSyaXV1rwQxJhIpnYFH3aaUO2YfvOXqF3X8U4xxybEsbsMdpx
 hO.SURqnUOXFsoxMHNiG7ZnXlH9SvgPxs1T0q3gX774cCrOnnd.CDBaj9mCA8AfFwsVxBBRg02uM
 D.VBjo3DMcY6umAH.AfEQxunx46LsmZgdSa.7gRKcxDrsJJozZILtLlrYlXNBoebgGJHzNIVO5_E
 BYIvX6Y3aQRLUgXzh.2KULVo1Zw4ELC1voLOb0YPe3qWHrCcdYxdoAP8E51sIVHPCwomgKxALjwZ
 KW67S4fb5JJ2uFJmMFddUL__nUwbYWgQVm.65IQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Mon, 10 Jun 2019 21:25:32 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp419.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0f7c880e8f69d2c333cd405c41d2412e;
          Mon, 10 Jun 2019 21:25:29 +0000 (UTC)
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
        Paul Moore <paul@paul-moore.com>
References: <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk>
 <be966d9c-e38d-7a30-8d80-fad5f25ab230@tycho.nsa.gov>
 <0cf7a49d-85f6-fba9-62ec-a378e0b76adf@schaufler-ca.com>
 <CALCETrX5O18q2=dUeC=hEtK2=t5KQpGBy9XveHxFw36OqkbNOg@mail.gmail.com>
 <dac74580-5b48-86e4-8222-cac29a9f541d@schaufler-ca.com>
 <E0925E1F-E5F2-4457-8704-47B6E64FE3F3@amacapital.net>
 <4b7d02b2-2434-8a7c-66cc-7dbebc37efbc@schaufler-ca.com>
 <CALCETrU+PKVbrKQJoXj9x_5y+vTZENMczHqyM_Xb85ca5YDZuA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <25d88489-9850-f092-205e-0a4fc292f41b@schaufler-ca.com>
Date:   Mon, 10 Jun 2019 14:25:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CALCETrU+PKVbrKQJoXj9x_5y+vTZENMczHqyM_Xb85ca5YDZuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/10/2019 12:53 PM, Andy Lutomirski wrote:
> On Mon, Jun 10, 2019 at 12:34 PM Casey Schaufler <casey@schaufler-ca.co=
m> wrote:
>>>>> I think you really need to give an example of a coherent policy tha=
t
>>>>> needs this.
>>>> I keep telling you, and you keep ignoring what I say.
>>>>
>>>>>  As it stands, your analogy seems confusing.
>>>> It's pretty simple. I have given both the abstract
>>>> and examples.
>>> You gave the /dev/null example, which is inapplicable to this patchse=
t.
>> That addressed an explicit objection, and pointed out
>> an exception to a generality you had asserted, which was
>> not true. It's also a red herring regarding the current
>> discussion.
> This argument is pointless.
>
> Please humor me and just give me an example.  If you think you have
> already done so, feel free to repeat yourself.  If you have no
> example, then please just say so.

To repeat the /dev/null example:

Process A and process B both open /dev/null.
A and B can write and read to their hearts content
to/from /dev/null without ever once communicating.
The mutual accessibility of /dev/null in no way implies that
A and B can communicate. If A can set a watch on /dev/null,
and B triggers an event, there still has to be an access
check on the delivery of the event because delivering an event
to A is not an action on /dev/null, but on A.


>
>>>>>  If someone
>>>>> changes the system clock, we don't restrict who is allowed to be
>>>>> notified (via, for example, TFD_TIMER_CANCEL_ON_SET) that the clock=

>>>>> was changed based on who changed the clock.
>>>> That's right. The system clock is not an object that
>>>> unprivileged processes can modify. In fact, it is not
>>>> an object at all. If you care to look, you will see that
>>>> Smack does nothing with the clock.
>>> And this is different from the mount tree how?
>> The mount tree can be modified by unprivileged users.
>> If nothing that unprivileged users can do to the mount
>> tree can trigger a notification you are correct, the
>> mount tree is very like the system clock. Is that the
>> case?
> The mount tree can't be modified by unprivileged users, unless a
> privileged user very carefully configured it as such.

"Unless" means *is* possible. In which case access control is
required. I will admit to being less then expert on the extent
to which mounts can be done without privilege.

>   An unprivileged
> user can create a new userns and a new mount ns, but then they're
> modifying a whole different mount tree.

Within those namespaces you can still have multiple users,
constrained be system access control policy.

>
>>>>>  Similarly, if someone
>>>>> tries to receive a packet on a socket, we check whether they have t=
he
>>>>> right to receive on that socket (from the endpoint in question) and=
,
>>>>> if the sender is local, whether the sender can send to that socket.=

>>>>> We do not check whether the sender can send to the receiver.
>>>> Bzzzt! Smack sure does.
>>> This seems dubious. I=E2=80=99m still trying to get you to explain to=
 a non-Smack person why this makes sense.
>> Process A sends a packet to process B.
>> If A has access to TopSecret data and B is not
>> allowed to see TopSecret data, the delivery should
>> be prevented. Is that nonsensical?
> It makes sense.  As I see it, the way that a sensible policy should do
> this is by making sure that there are no sockets, pipes, etc that
> Process A can write and that Process B can read.

You can't explain UDP controls without doing the access check
on packet delivery. The sendmsg() succeeds when the packet leaves
the sender. There doesn't even have to be a socket bound to the
port. The only opportunity you have for control is on packet
delivery, which is the only point at which you can have the
information required.

> If you really want to prevent a malicious process with TopSecret data
> from sending it to a different process, then you can't use Linux on
> x86 or ARM.  Maybe that will be fixed some day, but you're going to
> need to use an extremely tight sandbox to make this work.

I won't be commenting on that.

>
>>>>> The signal example is inapplicable.
>>>> From a modeling viewpoint the actions are identical.
>>> This seems incorrect to me
>> What would be correct then? Some convoluted combination
>> of system entities that aren't owned or controlled by
>> any mechanism?
>>
> POSIX signal restrictions aren't there to prevent two processes from
> communicating.  They're there to prevent the sender from manipulating
> or crashing the receiver without appropriate privilege.

POSIX signal restrictions have a long history. In the P10031e/2c
debates both communication and manipulation where seriously
considered. I would say both are true.

>>>  and, I think, to most everyone else reading this.
>> That's quite the assertion. You may even be correct.
>>
>>>  Can you explain?
>>>
>>> In SELinux-ese, when you write to a file, the subject is the writer a=
nd the object is the file.  When you send a signal to a process, the obje=
ct is the target process.
>> YES!!!!!!!!!!!!
>>
>> And when a process triggers a notification it is the subject
>> and the watching process is the object!
>>
>> Subject =3D=3D active entity
>> Object  =3D=3D passive entity
>>
>> Triggering an event is, like calling kill(), an action!
>>
> And here is where I disagree with your interpretation.  Triggering an
> event is a side effect of writing to the file.  There are *two*
> security relevant actions, not one, and they are:
>
> First, the write:
>
> Subject =3D=3D the writer
> Action =3D=3D write
> Object =3D=3D the file
>
> Then the event, which could be modeled in a couple of ways:
>
> Subject =3D=3D the file

Files   are   not   subjects. They are passive entities.

> Action =3D=3D notify
> Object =3D=3D the recipient
>
> or
>
> Subject =3D=3D the recipient
> Action =3D=3D watch
> Object =3D=3D the file
>
> By conflating these two actions into one, you've made the modeling
> very hard, and you start running into all these nasty questions like
> "who actually closed this open file"

No, I've made the code more difficult. You can not call
the file a subject. That is just wrong. It's not a valid
model.


