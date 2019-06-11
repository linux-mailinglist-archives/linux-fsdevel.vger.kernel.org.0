Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 975153CEC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 16:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389183AbfFKOcp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 10:32:45 -0400
Received: from upbd19pa09.eemsg.mail.mil ([214.24.27.84]:55673 "EHLO
        UPBD19PA09.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387551AbfFKOcp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:32:45 -0400
X-EEMSG-check-017: 202016600|UPBD19PA09_EEMSG_MP9.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPBD19PA09.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 11 Jun 2019 14:32:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1560263555; x=1591799555;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=eFTXXk3T4XgQDmNF1yXHpOrZQWkja9D5zGYogAuEtx0=;
  b=Oi6ccJo9Rkd2wqPHbWC2qBQCbbtC2ot//QXTAZXb1bPpBRwWN11ZMlru
   Q7Cq5hNn7ie9IAukGDMoyNYhB9O5i434CMicqBoZfmzzaOXilguPORtsY
   jC04qafCTnkvXgmjS/AXrmCZ2swugNINESYy7jrbXCEloZXIQN3sVRf1E
   MzZ5u5tlfuhrtoaqxUhJdy0B5TtcEy2g3d1C8mNj4FENsEMEwoQ1qhF7/
   jET+2DJghFXv8vE6rSIariFVSwhQQrfnm2W6admaFIayX3Ofwoi2JDrYz
   uRIB21Lth7yHxOWFp9pyOXsG2ouOu8OyGd2lJlrscgkX1DfWikPVuWKe5
   g==;
X-IronPort-AV: E=Sophos;i="5.63,579,1557187200"; 
   d="scan'208";a="28815970"
IronPort-PHdr: =?us-ascii?q?9a23=3AMV5BwhMuYaH4IEzx4jMl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0K/v4r8bcNUDSrc9gkEXOFd2Cra4d0qyP7v2rBD1IyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfK5+IA+roQjRtsQajotvJ6IswR?=
 =?us-ascii?q?bVv3VEfPhby3l1LlyJhRb84cmw/J9n8ytOvv8q6tBNX6bncakmVLJUFDspPX?=
 =?us-ascii?q?w7683trhnDUBCA5mAAXWUMkxpHGBbK4RfnVZrsqCT6t+592C6HPc3qSL0/RD?=
 =?us-ascii?q?qv47t3RBLulSwKLCAy/n3JhcNsjaJbuBOhqAJ5w47Ie4GeKf5ycrrAcd8GWW?=
 =?us-ascii?q?ZNW8BcWCJbAoO4coABEewPM+hFpIX5vlcDox+zCQyqCejyyDFHm2X20LUn3e?=
 =?us-ascii?q?o/HwHI3A8uEdwAv3vbrtr6KKgcXPupzKTL1zjPc+9a1Dn/5YXObxsvoeuMXb?=
 =?us-ascii?q?V1ccfJ1EcvCx3Kjk2QqYP7OTOey/kDs22B4OpkUeKglW4moBx2rzi028gskZ?=
 =?us-ascii?q?LEhp4Vy1/Y9SV5x5w5JdujSEFhe9KkH5xQtz+DOoZwX8gsQHlotT4nxrAJtp?=
 =?us-ascii?q?O3ZigHxIk9yxLBZPGLbZKE7g/lWe2MOzl3nmhld6i6hxuq9EigzfDzWdes3V?=
 =?us-ascii?q?ZRqypFjsHMtncQ1xzP8sSHSuVy/kOm2TuXywDc8PtEIUEplarAMZIh3r4xmY?=
 =?us-ascii?q?YTsUTEBCP2nln5jLSKeUk+/+io6uDnbq3npp+aKYB0lhnzPrkhl8GwG+g1Mh?=
 =?us-ascii?q?UCU3KF9emzyrHv51D1TK1PjvIsk6nZtJ7aJd4cpq68GwJVyZss6w2kAje60N?=
 =?us-ascii?q?UXgXkHLFVfdBKBlIjmIUvCIP//Dfehm1isiitkx+jaPr39BZXANnzDkKr9fb?=
 =?us-ascii?q?Z68ENT0g8zwspD6J1OErEBIe7zVVX1tNDCCB82LRC0yf79CNphzoMeRX6PAq?=
 =?us-ascii?q?iBPazOq1CI/fwgIumXaY8OpDn9K+Iq5+PgjX89h1AdZ7Cl0ocNZ3yiAvtmJE?=
 =?us-ascii?q?CZa2L2gtgdCWcKohY+TOvyhV2GTD5Te3GyUrk/5j4lEoKmC5nMRoS3jLyGxi?=
 =?us-ascii?q?e7EYVcZnpaBVCUDXfoa4KEVu8RZyKSJc9gnCILVbylS486zhyurhH1xKdnLu?=
 =?us-ascii?q?XO5i0Ur47s1N9w5+fLjxE96SR0D9iB02GKV2x0gGIIRyUx3K1koE1y1FGD0a?=
 =?us-ascii?q?lmg/BCEdxT5vVJUho1NJLGyOx6Ed/yVhjcfteKUFymWMmpASktTtItxN8De0?=
 =?us-ascii?q?J9G9SkjhDe0CumGqIVl6eQC5Ev7KLc0Gb+J9xnx3bFyqYhlV8mTdVLNWG8ga?=
 =?us-ascii?q?5/7QfTDZbTk0qFj6aqabgc3CnV+WeHzGqOulxYUQFpXaXeQ38QelbWrc745k?=
 =?us-ascii?q?PeT76iELEnMgxcxs6fLqtFdMbkjUtJRPj9ItTSeWGxlHmqBRaO2LyMaJDme2?=
 =?us-ascii?q?IH3CXSEEIEiRwc/W6aNQgiASesu23eDCZwGlLgYEPs8fJzqHe6Tk8y0gGLYE?=
 =?us-ascii?q?Nh172o+h4TmPOTUe8T3rMDuCcnsTl0G0y9393OAdqauwVhZLlcYc864Fpfz2?=
 =?us-ascii?q?LWrRJ9MYKmL615ml4ecxp4v0b02BR5EIlAl9YlrG8yxgpoNa2YyE9Bdy+f3Z?=
 =?us-ascii?q?3oPr3XK2/y/A2gaqLP1FHey8uZ9bkR6Psmr1Xupx+pFkU8/HV9ydVV0GWT5o?=
 =?us-ascii?q?/MDAUMVZL9SEE39wJ1p7vCeCky+5vU1WFwMamzqjLC39MpBO04yhevZttQKr?=
 =?us-ascii?q?uEFA7pHs0ECMihNvYql0Kqbh0aJuBS8rA7P8e8e/uBwq6rM/5qnCi6gmRf/I?=
 =?us-ascii?q?B9zkWM+jJ4Su7J2ZYF3v6Z0hKcWDf4i1eursP3lJtaZTEdAGW/0zLoBI1Paa?=
 =?us-ascii?q?1oe4YEF2OuL9ewxtVkiJ7nQ2RY+0K7B1MaxM+pfgKfb1/j0gxQz0QXoHqnmS?=
 =?us-ascii?q?SjzzFvjTEpobSQ3DbUz+ThahUHIGhLS3dmjVv2Joi0ld8aVlCybwc1jBul+V?=
 =?us-ascii?q?r6x69DqaR7LmnTR1pIfifvI2FhTKSwrLyCbNBL6J4zryVXX/qzYUqARr7+vR?=
 =?us-ascii?q?QaySXjEHVaxDwhcDGqoJr5lQRgiG2BNHZzsGbZecZoyBfH/tPcWPpR0yEeRC?=
 =?us-ascii?q?ZilDnXAkGwP9yu/dWTjZfMrPqyWH6mVp1WImHXytapsieqrUl3HRq6nuqomd?=
 =?us-ascii?q?yvRQwnzSjT3txjXizQrQr1Zs/t2rjsdapMd1JlFRfH4MpzB496n5F40JoZwn?=
 =?us-ascii?q?ULro6e/XMan2P+K5BQ0OT1a39bFhARxNuA2xTowE1uKDqywov9UniMip96a8?=
 =?us-ascii?q?KSfnId2iV76dtDTqiT8uoXzmNOvlOkoFeJMrBGlTAHxK5rsSVLjg=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CmAwB0uv9c/wHyM5BmHAEBAQQBAQcEAQGBZYFiBSqBO?=
 =?us-ascii?q?wEyKIQVknNMAQEBAQEBBoEQJYlRjySBZwkBAQEBAQEBAQE0AQIBAYRAAoJ+I?=
 =?us-ascii?q?zgTAQMBAQEEAQEBAQMBAWwogjopAYJnAQIDIw8BBT8CEAsOCgICJgICVwYBD?=
 =?us-ascii?q?AYCAQGCUww/gXcUqQqBMYVHgy2BRoEMKItdF3iBB4E4DIIqBy4+hAiDRoJYB?=
 =?us-ascii?q?I15mk1qCYISghuRJAYbgiWCH4RehAeGAoN1jRaYTCGBWCsIAhgIIQ+DJ5BuI?=
 =?us-ascii?q?wMwgQYBAY8IAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 11 Jun 2019 14:32:32 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x5BEWUaX007043;
        Tue, 11 Jun 2019 10:32:30 -0400
Subject: Re: [RFC][PATCH 00/13] Mount, FS, Block and Keyrings notifications
 [ver #4]
To:     Andy Lutomirski <luto@amacapital.net>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
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
 <25d88489-9850-f092-205e-0a4fc292f41b@schaufler-ca.com>
 <97BA9EB5-4E62-4E3A-BD97-CEC34F16FCFF@amacapital.net>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <cf3f4865-b6d7-7303-0212-960439e0c119@tycho.nsa.gov>
Date:   Tue, 11 Jun 2019 10:32:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <97BA9EB5-4E62-4E3A-BD97-CEC34F16FCFF@amacapital.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/10/19 8:13 PM, Andy Lutomirski wrote:
> 
> 
>> On Jun 10, 2019, at 2:25 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>
>>> On 6/10/2019 12:53 PM, Andy Lutomirski wrote:
>>> On Mon, Jun 10, 2019 at 12:34 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>>>> I think you really need to give an example of a coherent policy that
>>>>>>> needs this.
>>>>>> I keep telling you, and you keep ignoring what I say.
>>>>>>
>>>>>>> As it stands, your analogy seems confusing.
>>>>>> It's pretty simple. I have given both the abstract
>>>>>> and examples.
>>>>> You gave the /dev/null example, which is inapplicable to this patchset.
>>>> That addressed an explicit objection, and pointed out
>>>> an exception to a generality you had asserted, which was
>>>> not true. It's also a red herring regarding the current
>>>> discussion.
>>> This argument is pointless.
>>>
>>> Please humor me and just give me an example.  If you think you have
>>> already done so, feel free to repeat yourself.  If you have no
>>> example, then please just say so.
>>
>> To repeat the /dev/null example:
>>
>> Process A and process B both open /dev/null.
>> A and B can write and read to their hearts content
>> to/from /dev/null without ever once communicating.
>> The mutual accessibility of /dev/null in no way implies that
>> A and B can communicate. If A can set a watch on /dev/null,
>> and B triggers an event, there still has to be an access
>> check on the delivery of the event because delivering an event
>> to A is not an action on /dev/null, but on A.
>>
> 
> At discussed, this is an irrelevant straw man. This patch series does not produce events when this happens. I’m looking for a relevant example, please.
>>
>>
>>>   An unprivileged
>>> user can create a new userns and a new mount ns, but then they're
>>> modifying a whole different mount tree.
>>
>> Within those namespaces you can still have multiple users,
>> constrained be system access control policy.
> 
> And the one doing the mounting will be constrained by MAC and DAC policy, as always.  The namespace creator is, from the perspective of those processes, admin.
> 
>>
>>>
>>>>>>> Similarly, if someone
>>>>>>> tries to receive a packet on a socket, we check whether they have the
>>>>>>> right to receive on that socket (from the endpoint in question) and,
>>>>>>> if the sender is local, whether the sender can send to that socket.
>>>>>>> We do not check whether the sender can send to the receiver.
>>>>>> Bzzzt! Smack sure does.
>>>>> This seems dubious. I’m still trying to get you to explain to a non-Smack person why this makes sense.
>>>> Process A sends a packet to process B.
>>>> If A has access to TopSecret data and B is not
>>>> allowed to see TopSecret data, the delivery should
>>>> be prevented. Is that nonsensical?
>>> It makes sense.  As I see it, the way that a sensible policy should do
>>> this is by making sure that there are no sockets, pipes, etc that
>>> Process A can write and that Process B can read.
>>
>> You can't explain UDP controls without doing the access check
>> on packet delivery. The sendmsg() succeeds when the packet leaves
>> the sender. There doesn't even have to be a socket bound to the
>> port. The only opportunity you have for control is on packet
>> delivery, which is the only point at which you can have the
>> information required.
> 
> Huh?  You sendmsg() from an address to an address.  My point is that, for most purposes, that’s all the information that’s needed.
> 
>>
>>> If you really want to prevent a malicious process with TopSecret data
>>> from sending it to a different process, then you can't use Linux on
>>> x86 or ARM.  Maybe that will be fixed some day, but you're going to
>>> need to use an extremely tight sandbox to make this work.
>>
>> I won't be commenting on that.
> 
> Then why is preventing this is an absolute requirement? It’s unattainable.
> 
>>
>>>
>>>>>>> The signal example is inapplicable.
>>>>>>  From a modeling viewpoint the actions are identical.
>>>>> This seems incorrect to me
>>>> What would be correct then? Some convoluted combination
>>>> of system entities that aren't owned or controlled by
>>>> any mechanism?
>>>>
>>> POSIX signal restrictions aren't there to prevent two processes from
>>> communicating.  They're there to prevent the sender from manipulating
>>> or crashing the receiver without appropriate privilege.
>>
>> POSIX signal restrictions have a long history. In the P10031e/2c
>> debates both communication and manipulation where seriously
>> considered. I would say both are true.
>>
>>>>> and, I think, to most everyone else reading this.
>>>> That's quite the assertion. You may even be correct.
>>>>
>>>>> Can you explain?
>>>>>
>>>>> In SELinux-ese, when you write to a file, the subject is the writer and the object is the file.  When you send a signal to a process, the object is the target process.
>>>> YES!!!!!!!!!!!!
>>>>
>>>> And when a process triggers a notification it is the subject
>>>> and the watching process is the object!
>>>>
>>>> Subject == active entity
>>>> Object  == passive entity
>>>>
>>>> Triggering an event is, like calling kill(), an action!
>>>>
>>> And here is where I disagree with your interpretation.  Triggering an
>>> event is a side effect of writing to the file.  There are *two*
>>> security relevant actions, not one, and they are:
>>>
>>> First, the write:
>>>
>>> Subject == the writer
>>> Action == write
>>> Object == the file
>>>
>>> Then the event, which could be modeled in a couple of ways:
>>>
>>> Subject == the file
>>
>> Files   are   not   subjects. They are passive entities.
>>
>>> Action == notify
>>> Object == the recipient
> 
> Great. Then use the variant below.
> 
>>>
>>> or
>>>
>>> Subject == the recipient
>>> Action == watch
>>> Object == the file
>>>
>>> By conflating these two actions into one, you've made the modeling
>>> very hard, and you start running into all these nasty questions like
>>> "who actually closed this open file"
>>
>> No, I've made the code more difficult.
>> You can not call
>> the file a subject. That is just wrong. It's not a valid
>> model.
> 
> You’ve ignored the “Action == watch” variant. Do you care to comment?

While I agree with this model in general, I will note two caveats when 
trying to apply this to watches/notifications:

1) The object on which the notification was triggered and the object on 
which the watch was placed are not necessarily the same and access to 
one might not imply access to the other,

2) If notifications can be triggered by read-like operations (as in 
fanotify, for example), then a "read" can be turned into a "write" flow 
through a notification.

Whether or not these caveats are applicable to the notifications in this 
series I am not clear.
