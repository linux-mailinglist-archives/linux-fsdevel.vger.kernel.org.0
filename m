Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24DFF2E98F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2019 01:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfE2X4z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 19:56:55 -0400
Received: from sonic305-9.consmr.mail.bf2.yahoo.com ([74.6.133.48]:37708 "EHLO
        sonic305-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726428AbfE2X4z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 19:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559174212; bh=aXNvbCL9CgLpyiwMXk+9kSv/VwIr+hk+tW0kB/4ZuWM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Vtwj4hE30D/hMre72EdOBscRUBPsCt48nlJn3dzlfTrGh5ND2G8mQTE5KWK4bN1BlroZIBIWXwDJyzztZ89GyZgeKl5+hkpgPpJp9cyeTZC7Wrf/KNhv+Jy0CQxs9JgyTWtPZN/TCkPp6elkf6bQ+2Kk1+If87rpAmECdViOF3DT76ICeZNa8N5nzAVukmMS5CkkB8fJNklpatgvacKI3hi3aKyYDTEj96V7YBoLxxQmHA3jz0t9UP+GhR/oWKr88itc2l1v9FBF3Y2tpmBwQ69S0HWYBdZLDdJyEolpPBaZAwvRl0sAJRPyuFxxboEfV/zSXFs3aWxlZajuZhBqIA==
X-YMail-OSG: lLkia2oVM1nhhMHX7jD_9U_HdHfGpeYEmz02VjVOYiulnTHSWXD.XpHHOB9xySS
 I7n2ASbYJXrqvSPImosTI1ZBeR.W3O1kvIVAmiutvuu.nj5fTGPIIzHRzSR0.jPDQMzv5dkyns.s
 CPrDsUiQerL8MAmPvzwJL1d._pxmN00q6A.tkdlnskkN3F1v.y07PHqfDja48y.Vnypks8VySNFY
 im18dlNj.n95C_GjmbUqvKu9yDbG61KkSLUx.35bbUIIMyYX7hl8qDrV3amqmOo2n5yjrj2MfkPo
 2XazyLxuOLnJ8p1shmsKZCZDR8LkzW6xUWi8aLjcPSSu.XS8X5RkHuRVv1WByFmQOw.jbVWpeGxF
 ehRRTG.iTJrpdAofrLQb40LjL00N3pxM3RbGCrHlom0UP6iNQvWpf_rKcHF.mGCQMGZQSH4oHK_R
 U4zHaLTf2JPrLZ3UUnTVNvMbEgW9VjnQFRI7zYF9d.Auw0pAOrLwgPNCSryeSJNlbKEniWa3Qp4S
 U831B1qFDvGhHTms_qnO8D_qVQsr.QptF15PP56.wamhmtIxysMRbpJOXlzgl2kt7ONlDPem.m_1
 sdCG07Ar_N2c7qq867n8uyOPcq0IUebi2j.fmBncU.IP8clW367I3SVdjfvHTZY2RDqQDln1FHzg
 QkVrDHM5X1x.vEjo1EosHm5ep5XDX8l7m4OJgJABzN7gVkb24H0JSRX06DhVBR3zQRK7aMsT8gyu
 M6Titk.NqCdSg9LDTDNRjlKduPynwH9kk0bd9pi1d4Mn5SfoCU3q4KDPgHaFjS1vArzgT.zKE320
 GMXdsPp2xl.30tr64pIpZH.1_XkpBK7zYCiVCub.iDWwO6juBTeWjEEpN8jmtulkxibee.TXy_jT
 Q.d82D7dATuZ7XIyIkJEADGwxSWwQlevd7gSLC_PqPp_H2XIA2WcoFfxWn7Lz5OL48V.b1ajDPuO
 jJktjck_1__2SmZHLEizwRRu5LG4Gr4CWftYaQ57i.69CBYzfFbvKmJDWuCLmHoXZLTF0I9mmoyK
 cr0qwo47aC1GTtxAE4R3KDvihqMp28yabM9rvhu8UjefD4k0J2VF2c8rLv8rtKHZK9tqgBfthFQk
 d3AJN3JQDXT1aSl4hjfIVdE4Gm1.dV.ttXnM3EeNnevOxzHcgrkRlPgiF4xkXrQvE0PF19MMNurs
 _wSpkEJyY0byYAg5GZ3tZR4q6.1YL3dWWgHWsbbeBFrjUausp3ahr1CiyeKCHsVJ0qnqaTN8eXjt
 yO67H8YSoa2Z.m692Itca8qnHwvk9bgVK
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Wed, 29 May 2019 23:56:52 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp429.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ae0153f1394f9169644b35f1cd7f33ef;
          Wed, 29 May 2019 23:56:49 +0000 (UTC)
Subject: Re: [PATCH 3/7] vfs: Add a mount-notification facility
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     David Howells <dhowells@redhat.com>, Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        casey@schaufler-ca.com
References: <CAG48ez2rRh2_Kq_EGJs5k-ZBNffGs_Q=vkQdinorBgo58tbGpg@mail.gmail.com>
 <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
 <155905933492.7587.6968545866041839538.stgit@warthog.procyon.org.uk>
 <14347.1559127657@warthog.procyon.org.uk>
 <312a138c-e5b2-4bfb-b50b-40c82c55773f@schaufler-ca.com>
 <4552118F-BE9B-4905-BF0F-A53DC13D5A82@amacapital.net>
 <058f227c-71ab-a6f4-00bf-b8782b3b2956@schaufler-ca.com>
 <2FF92095-E5B1-4811-A7F8-B7D4C32F86DD@amacapital.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <35a3b0f9-f227-2cd7-eb87-9b3d5816c67d@schaufler-ca.com>
Date:   Wed, 29 May 2019 16:56:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <2FF92095-E5B1-4811-A7F8-B7D4C32F86DD@amacapital.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/29/2019 4:12 PM, Andy Lutomirski wrote:
>
>> On May 29, 2019, at 10:46 AM, Casey Schaufler <casey@schaufler-ca.com>=
 wrote:
>>
>>> On 5/29/2019 10:13 AM, Andy Lutomirski wrote:
>>>
>>>>> On May 29, 2019, at 8:53 AM, Casey Schaufler <casey@schaufler-ca.co=
m> wrote:
>>>>>
>>>>> On 5/29/2019 4:00 AM, David Howells wrote:
>>>>> Jann Horn <jannh@google.com> wrote:
>>>>>
>>>>>>> +void post_mount_notification(struct mount *changed,
>>>>>>> +                            struct mount_notification *notify)
>>>>>>> +{
>>>>>>> +       const struct cred *cred =3D current_cred();
>>>>>> This current_cred() looks bogus to me. Can't mount topology change=
s
>>>>>> come from all sorts of places? For example, umount_mnt() from
>>>>>> umount_tree() from dissolve_on_fput() from __fput(), which could
>>>>>> happen pretty much anywhere depending on where the last reference =
gets
>>>>>> dropped?
>>>>> IIRC, that's what Casey argued is the right thing to do from a secu=
rity PoV.
>>>>> Casey?
>>>> You need to identify the credential of the subject that triggered
>>>> the event. If it isn't current_cred(), the cred needs to be passed
>>>> in to post_mount_notification(), or derived by some other means.
>>> Taking a step back, why do we care who triggered the event?  It seems=
 to me that we should care whether the event happened and whether the *re=
ceiver* is permitted to know that.
>> There are two filesystems, "dot" and "dash". I am not allowed
>> to communicate with Fred on the system, and all precautions have
>> been taken to ensure I cannot. Fred asks for notifications on
>> all mount activity. I perform actions that result in notifications
>> on "dot" and "dash". Fred receives notifications and interprets
>> them using Morse code. This is not OK. If Wilma, who *is* allowed
>> to communicate with Fred, does the same actions, he should be
>> allowed to get the messages via Morse.
> Under this scenario, Fred should not be allowed to enable these watches=
=2E If you give yourself and Fred unconstrained access to the same FS, th=
en can communicate.

How are you going to determine at the time Fred tries to enable the watch=
es
that I am going to do something that will trigger them? I'm not saying it=
 isn't
possible, I'm curious how you would propose doing it. If you deny Fred th=
e ability
to set watches because it is possible for me to trigger them, he can't us=
e them
to get information from Wilma, either.

>
>> Other security modelers may disagree. The models they produce
>> are going to be *very* complicated and will introduce agents and
>> intermediate objects to justify Fred's reception of an event as
>> a read operation.
> I disagree. They=E2=80=99ll model the watch as something to prevent if =
they want to restrict communication.

Sorry, but that isn't sufficiently detailed to be meaningful.

>>> (And receiver means whoever subscribed, presumably, not whoever calle=
d read() or mmap().)
>> The receiver is the process that gets the event. There may
>> be more than one receiver, and the receivers may have different
>> credentials. Each needs to be checked separately.
> I think it=E2=80=99s a bit crazy to have the same event queue with two =
readers who read different things.

Look at killpg(3).

The process that creates the event has to be involved in the
access decision. Otherwise you have an uncontrolled data channel.
When the receiver reads the event queue it knows nothing about the
sender, and hence cannot make the decision unless the credential of
the sender is kept with the event message, and used when the
receiver tries to access it. I don't think that wold work well with
the mechanism as designed.
=C2=A0


