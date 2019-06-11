Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7C743C080
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 02:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390725AbfFKA11 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 20:27:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35842 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389362AbfFKA10 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 20:27:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id a3so5899927pgb.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jun 2019 17:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=VM2dk3phoXMJWUmg4OkGbUsCUxKTv/qfJ7B/YkcH/jc=;
        b=zYcM1bjwlBj/VZ68drx0nOd348CC8iakrVB6vDS+gJ7EnC22G0Gh88OpERBZMgOxFb
         Ivn3P5x0NGHsY6n9ZwVcZ9+DkalHqli6FeDqy0tXEYqIPBV0K/GCO8vLZugKuT2lTtwD
         hogTBTI88gW2RP7sY2VkC6QBGYVmfPW/Xblyq0TKoqpjTmAdJc19Kg+wXSgsVIgJiK68
         TF1BEHQDiqVnYzgMC4rWD0NN1JH5T+orsD/EZPhiTRWl185RGHxhqVaMXN3a2sw23/ck
         Loz04gUYjWWAQPhsjWh7cOJnDF71aXELbLgIeg20wyqufu5gFwncvNVs3a1n1mcZbyDn
         xHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=VM2dk3phoXMJWUmg4OkGbUsCUxKTv/qfJ7B/YkcH/jc=;
        b=bDOBSz3C0PC8Cqk/BbjsQNVBdo+Mu+jaDpVkpXxeylY1VRLpcHAprmkLnNaUcySmgz
         Hl2yJnHcHh9ESfrFC+Ex/XsFsm9BIF4CYb4m086UTkW5l1yTcDMW/jBJa65uFaRz53OJ
         Z+6kbIOjzcfJHU6lAyJm50hsUeKkYlwxXIs4U/LZUyRGnkagQr+c+hkvBKXEeJiZsneX
         Vwr8NfS7zyO1t3CvcQelVPm2rl+MxjXuanmOYhkqKmbEASz2CHeODKX6uQP745yPFwIe
         DV+855w55hSLAY7/NOcMGHbJMfLH2MVbDA5K8S/Ck0HJDCM5uTsrrPJGvplMF+QiTdE9
         o2vg==
X-Gm-Message-State: APjAAAVepKFgKrh8QxiDXgfHsFdfLrKwv+8G76ILw2MDKTg6E8Ghb/iP
        XiHzn8P/GsBdYwmhe8Eg2Ez69Q==
X-Google-Smtp-Source: APXvYqzwt2kqHvu9OTRvm5vLnspi9CzNyFEQTcK84714NO8Z1PTwNct/Ne+Bo6TCz7ewEYKeUwxoHQ==
X-Received: by 2002:a62:1ec3:: with SMTP id e186mr78012544pfe.197.1560212845477;
        Mon, 10 Jun 2019 17:27:25 -0700 (PDT)
Received: from ?IPv6:2600:1010:b02c:114f:fc47:b6b2:14a5:bb80? ([2600:1010:b02c:114f:fc47:b6b2:14a5:bb80])
        by smtp.gmail.com with ESMTPSA id u5sm11410506pgp.19.2019.06.10.17.27.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 17:27:23 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC][PATCH 00/13] Mount, FS, Block and Keyrings notifications [ver #4]
Date:   Mon, 10 Jun 2019 17:13:51 -0700
Message-Id: <97BA9EB5-4E62-4E3A-BD97-CEC34F16FCFF@amacapital.net>
References: <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk> <be966d9c-e38d-7a30-8d80-fad5f25ab230@tycho.nsa.gov> <0cf7a49d-85f6-fba9-62ec-a378e0b76adf@schaufler-ca.com> <CALCETrX5O18q2=dUeC=hEtK2=t5KQpGBy9XveHxFw36OqkbNOg@mail.gmail.com> <dac74580-5b48-86e4-8222-cac29a9f541d@schaufler-ca.com> <E0925E1F-E5F2-4457-8704-47B6E64FE3F3@amacapital.net> <4b7d02b2-2434-8a7c-66cc-7dbebc37efbc@schaufler-ca.com> <CALCETrU+PKVbrKQJoXj9x_5y+vTZENMczHqyM_Xb85ca5YDZuA@mail.gmail.com> <25d88489-9850-f092-205e-0a4fc292f41b@schaufler-ca.com>
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
        Paul Moore <paul@paul-moore.com>
In-Reply-To: <25d88489-9850-f092-205e-0a4fc292f41b@schaufler-ca.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
X-Mailer: iPhone Mail (16F203)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 10, 2019, at 2:25 PM, Casey Schaufler <casey@schaufler-ca.com> wrot=
e:
>=20
>> On 6/10/2019 12:53 PM, Andy Lutomirski wrote:
>> On Mon, Jun 10, 2019 at 12:34 PM Casey Schaufler <casey@schaufler-ca.com>=
 wrote:
>>>>>> I think you really need to give an example of a coherent policy that
>>>>>> needs this.
>>>>> I keep telling you, and you keep ignoring what I say.
>>>>>=20
>>>>>> As it stands, your analogy seems confusing.
>>>>> It's pretty simple. I have given both the abstract
>>>>> and examples.
>>>> You gave the /dev/null example, which is inapplicable to this patchset.=

>>> That addressed an explicit objection, and pointed out
>>> an exception to a generality you had asserted, which was
>>> not true. It's also a red herring regarding the current
>>> discussion.
>> This argument is pointless.
>>=20
>> Please humor me and just give me an example.  If you think you have
>> already done so, feel free to repeat yourself.  If you have no
>> example, then please just say so.
>=20
> To repeat the /dev/null example:
>=20
> Process A and process B both open /dev/null.
> A and B can write and read to their hearts content
> to/from /dev/null without ever once communicating.
> The mutual accessibility of /dev/null in no way implies that
> A and B can communicate. If A can set a watch on /dev/null,
> and B triggers an event, there still has to be an access
> check on the delivery of the event because delivering an event
> to A is not an action on /dev/null, but on A.
>=20

At discussed, this is an irrelevant straw man. This patch series does not pr=
oduce events when this happens. I=E2=80=99m looking for a relevant example, p=
lease.
>=20
>=20
>>  An unprivileged
>> user can create a new userns and a new mount ns, but then they're
>> modifying a whole different mount tree.
>=20
> Within those namespaces you can still have multiple users,
> constrained be system access control policy.

And the one doing the mounting will be constrained by MAC and DAC policy, as=
 always.  The namespace creator is, from the perspective of those processes,=
 admin.

>=20
>>=20
>>>>>> Similarly, if someone
>>>>>> tries to receive a packet on a socket, we check whether they have the=

>>>>>> right to receive on that socket (from the endpoint in question) and,
>>>>>> if the sender is local, whether the sender can send to that socket.
>>>>>> We do not check whether the sender can send to the receiver.
>>>>> Bzzzt! Smack sure does.
>>>> This seems dubious. I=E2=80=99m still trying to get you to explain to a=
 non-Smack person why this makes sense.
>>> Process A sends a packet to process B.
>>> If A has access to TopSecret data and B is not
>>> allowed to see TopSecret data, the delivery should
>>> be prevented. Is that nonsensical?
>> It makes sense.  As I see it, the way that a sensible policy should do
>> this is by making sure that there are no sockets, pipes, etc that
>> Process A can write and that Process B can read.
>=20
> You can't explain UDP controls without doing the access check
> on packet delivery. The sendmsg() succeeds when the packet leaves
> the sender. There doesn't even have to be a socket bound to the
> port. The only opportunity you have for control is on packet
> delivery, which is the only point at which you can have the
> information required.

Huh?  You sendmsg() from an address to an address.  My point is that, for mo=
st purposes, that=E2=80=99s all the information that=E2=80=99s needed.

>=20
>> If you really want to prevent a malicious process with TopSecret data
>> from sending it to a different process, then you can't use Linux on
>> x86 or ARM.  Maybe that will be fixed some day, but you're going to
>> need to use an extremely tight sandbox to make this work.
>=20
> I won't be commenting on that.

Then why is preventing this is an absolute requirement? It=E2=80=99s unattai=
nable.

>=20
>>=20
>>>>>> The signal example is inapplicable.
>>>>> =46rom a modeling viewpoint the actions are identical.
>>>> This seems incorrect to me
>>> What would be correct then? Some convoluted combination
>>> of system entities that aren't owned or controlled by
>>> any mechanism?
>>>=20
>> POSIX signal restrictions aren't there to prevent two processes from
>> communicating.  They're there to prevent the sender from manipulating
>> or crashing the receiver without appropriate privilege.
>=20
> POSIX signal restrictions have a long history. In the P10031e/2c
> debates both communication and manipulation where seriously
> considered. I would say both are true.
>=20
>>>> and, I think, to most everyone else reading this.
>>> That's quite the assertion. You may even be correct.
>>>=20
>>>> Can you explain?
>>>>=20
>>>> In SELinux-ese, when you write to a file, the subject is the writer and=
 the object is the file.  When you send a signal to a process, the object is=
 the target process.
>>> YES!!!!!!!!!!!!
>>>=20
>>> And when a process triggers a notification it is the subject
>>> and the watching process is the object!
>>>=20
>>> Subject =3D=3D active entity
>>> Object  =3D=3D passive entity
>>>=20
>>> Triggering an event is, like calling kill(), an action!
>>>=20
>> And here is where I disagree with your interpretation.  Triggering an
>> event is a side effect of writing to the file.  There are *two*
>> security relevant actions, not one, and they are:
>>=20
>> First, the write:
>>=20
>> Subject =3D=3D the writer
>> Action =3D=3D write
>> Object =3D=3D the file
>>=20
>> Then the event, which could be modeled in a couple of ways:
>>=20
>> Subject =3D=3D the file
>=20
> Files   are   not   subjects. They are passive entities.
>=20
>> Action =3D=3D notify
>> Object =3D=3D the recipient

Great. Then use the variant below.

>>=20
>> or
>>=20
>> Subject =3D=3D the recipient
>> Action =3D=3D watch
>> Object =3D=3D the file
>>=20
>> By conflating these two actions into one, you've made the modeling
>> very hard, and you start running into all these nasty questions like
>> "who actually closed this open file"
>=20
> No, I've made the code more difficult.
> You can not call
> the file a subject. That is just wrong. It's not a valid
> model.

You=E2=80=99ve ignored the =E2=80=9CAction =3D=3D watch=E2=80=9D variant. Do=
 you care to comment?
