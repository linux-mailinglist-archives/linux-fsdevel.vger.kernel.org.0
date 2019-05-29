Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 688F52E675
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 22:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfE2UuK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 16:50:10 -0400
Received: from sonic305-9.consmr.mail.bf2.yahoo.com ([74.6.133.48]:39465 "EHLO
        sonic305-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726189AbfE2UuK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 16:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559163007; bh=0j4xWCjJSnnfEX9Oj7YQAfIa1sBCj93Pr5M4xfg2mlA=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=UeB2wysZt491MoyYpbYlEdorrkMRYQnizhhklaFpC/ReZJatWO15BNtLjGSiUdV7+HFXNefPv78Ou2RgGWao74iBtNjgCoDZUMOfMeMNVpgvqZkp3nDL5dRV6lhw7VjtInUkoB+cGNp6z3ky5jR2x+TLn+EDxJuzSmQhlzpsa6QcEMf5NqME6SlQkdtJjZESIzxBnuIXla1BXpTusBYMoGx5Eh1TCBPYPDalu4qpG6eAXz3jAx7kdoDLlFXhIHPyHJl70f4jKhWZJI1ec7lTnzvFh2qHMOziCUSLSCxsZOTX4HhwUcSg9mwquQO2A/K7PpNsVyzr8mltoIyz4FxsXA==
X-YMail-OSG: eFyQxLcVM1k7kWv5Gd_huV9Gj8nF9xAxCEMUU3i8UfCODhmNZ_vIt3UzS6.rs3f
 k9Z.9BlYo4jwQk.sWAlT1PDYZ.hby823xjPkDnRSdz1w2EFRpxQ63IVgBP0GsSzkM7GEHsLUZ1bm
 3LEb5Xz6nS4AsahO.6L9gdqif3iuoWpeQle9w5pzBPenhw8aBC_5K4RGTrMcsLfzMAQ4.Nu5ccAJ
 vl3vkBWIcaLFjDJRtRRicE52hBeCPYzB79t_Jb2AOcku4sGThNglxA3JTR5GFWiF4bOdPy11T2lk
 vruv8aRAQgNWB0_vvtLpLS1Cv6pw_q0bjtDzdV5zt.tSdtync7IF935CPVNPbo6dOFKInZ2RL5ht
 Sk7Z._KQ0AK7uqw3oOvHKaG2xZLPTpOFvYyaNZkucUHt1XrZajUhPDcuVAcTlZaEMMiTQaHXwISE
 DVid_UIxBWGlTfJ7P5WH2v.3GM_d47Gbe410WbgSJHfsFSnh_lYHhJEzdZI5MTMtGHsPrRiW.FSc
 lZeaHXPZe1ODUNHNIyt.dDaXsNGijvv2Dtq9DIOaZ91GRxLJjEEEN0awaOdTX9wLDmQWALdcLo4v
 Uy9jjRVxd2PTrBOIpGcAHs_fjXpyPhK647RmTTc3OrbqCXQ30F9a424WYemWeCpN4qW.FGQplf4N
 o9WkWQi1rls8VpSuj1OBJrQ_aSj4N8wa7VRujcrY9CD6Ird8EMY7hH8nQyIoD_JYLubY626tsilD
 T6sUPPzIeaVJMI6ziRVdBGIK3EcK7c0eoM0TlNvWKOVzIuecqtbk7eK4Z_lkpNOBfT2EFPsiI_3C
 WnnYtDYVOHgL08EKzDSS7jcQObzvswlUfss5Nau40DUI2a5AK7ZU9vLB5HBwCVhn6Xa.aqXmnkkN
 wpMDQqc0TQDe8U1KYP6anQ9H7RsvQy60lV51ATgoQeA3t6CRqtuUyZ9_i04_p_iQUGTxGqxQ5Tfw
 .q1S.CgQPWDJ3IrbSQm3UW2sYOWmMqb5NIixySoL76gu27QJ4L3HSPkLdqII.1hMlYALkhTHRcJI
 toPD4vHydi_SEETw3AG8G8jbBBmVLQN7Wc_vnwFXWnTCGT5YCt.7O.qf_8szAEU4_O8L72ntgu0B
 dK9YxuDNS6ADXgq0Kb5y_yEmLv.llcHOKK1qbtKiAOEzibrxpYFEp7yyQqkmZ9psbejPQbHqNtmM
 LUCXrb9CQfqJD025tAzJpR_lE85_vgqdhUGuawW_X.tiUGT5ZZpsQ1dQ6QRdoRivdRC5sExOtwIp
 y0DGs_TA5RAkTlKou0nGKrY.Ax92BevVl
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Wed, 29 May 2019 20:50:07 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp422.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a8ff822a29296d665b1079c6eff5b23d;
          Wed, 29 May 2019 20:50:02 +0000 (UTC)
Subject: Re: [PATCH 3/7] vfs: Add a mount-notification facility
To:     Jann Horn <jannh@google.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        David Howells <dhowells@redhat.com>,
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
 <CAG48ez2S+i2wxpWXVGpEAprgY9gtjxyejLfbZtrqu5YOkQ81Nw@mail.gmail.com>
 <0cd823ca-4733-19ef-c13e-ed5ac8c63a0f@schaufler-ca.com>
 <CAG48ez0X7rKw-qfZm9i+8OLq7YccBRtV3aF-7hkQsfWaiTbuXg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <1f09b97e-9533-dc27-2524-ca0a4c9d4664@schaufler-ca.com>
Date:   Wed, 29 May 2019 13:50:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez0X7rKw-qfZm9i+8OLq7YccBRtV3aF-7hkQsfWaiTbuXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/29/2019 12:47 PM, Jann Horn wrote:
> On Wed, May 29, 2019 at 9:28 PM Casey Schaufler <casey@schaufler-ca.com=
> wrote:
>> On 5/29/2019 11:11 AM, Jann Horn wrote:
>>> On Wed, May 29, 2019 at 7:46 PM Casey Schaufler <casey@schaufler-ca.c=
om> wrote:
>>>> On 5/29/2019 10:13 AM, Andy Lutomirski wrote:
>>>>>> On May 29, 2019, at 8:53 AM, Casey Schaufler <casey@schaufler-ca.c=
om> wrote:
>>>>>>> On 5/29/2019 4:00 AM, David Howells wrote:
>>>>>>> Jann Horn <jannh@google.com> wrote:
>>>>>>>
>>>>>>>>> +void post_mount_notification(struct mount *changed,
>>>>>>>>> +                            struct mount_notification *notify)=

>>>>>>>>> +{
>>>>>>>>> +       const struct cred *cred =3D current_cred();
>>>>>>>> This current_cred() looks bogus to me. Can't mount topology chan=
ges
>>>>>>>> come from all sorts of places? For example, umount_mnt() from
>>>>>>>> umount_tree() from dissolve_on_fput() from __fput(), which could=

>>>>>>>> happen pretty much anywhere depending on where the last referenc=
e gets
>>>>>>>> dropped?
>>>>>>> IIRC, that's what Casey argued is the right thing to do from a se=
curity PoV.
>>>>>>> Casey?
>>>>>> You need to identify the credential of the subject that triggered
>>>>>> the event. If it isn't current_cred(), the cred needs to be passed=

>>>>>> in to post_mount_notification(), or derived by some other means.
>>>>> Taking a step back, why do we care who triggered the event?  It see=
ms to me that we should care whether the event happened and whether the *=
receiver* is permitted to know that.
>>>> There are two filesystems, "dot" and "dash". I am not allowed
>>>> to communicate with Fred on the system, and all precautions have
>>>> been taken to ensure I cannot. Fred asks for notifications on
>>>> all mount activity. I perform actions that result in notifications
>>>> on "dot" and "dash". Fred receives notifications and interprets
>>>> them using Morse code. This is not OK. If Wilma, who *is* allowed
>>>> to communicate with Fred, does the same actions, he should be
>>>> allowed to get the messages via Morse.
>>> In other words, a classic covert channel. You can't really prevent tw=
o
>>> cooperating processes from communicating through a covert channel on =
a
>>> modern computer.
>> That doesn't give you permission to design them in.
>> Plus, the LSMs that implement mandatory access controls
>> are going to want to intervene. No unclassified user
>> should see notifications caused by Top Secret users.
> But that's probably because they're worried about *side* channels, not
> covert channels?

The security evaluators from the 1990's considered any channel
with greater than 1 bit/second bandwidth a show-stopper. That was
true for covert and side channels. Further, if you knew that a
mechanism had a channel, as this one does, and you didn't fix it,
you didn't get your certificate. If you know about a problem
during the design/implementation phase it's really inexcusable not
to fix it before "completing" the code.

> Talking about this in the context of (small) side channels: The
> notification types introduced in this patch are mostly things that a
> user would be able to observe anyway if they polled /proc/self/mounts,
> right?

It's supposed to be a general mechanism. Of course it would
be simpler if is was restricted to things you can get at via
/proc/self.

>  It might make sense to align access controls based on that - if
> you don't want it to be possible to observe events happening on some
> mount points through this API, you should probably lock down
> /proc/*/mounts equivalently, by introducing an LSM hook for "is @cred
> allowed to see @mnt" or something like that - and if you want to
> compare two cred structures, you could record the cred structure that
> is responsible for the creation of the mount point, or something like
> that.

I'm not going to argue against that.

> For some of the other patches, I guess things get more tricky because
> the notification exposes new information that wasn't really available
> before.

We have to look not just at the information being available,
but the mechanism used. Being able to look at information about
a process in /proc doesn't mean I should be able to look at it
using ptrace(). Access control isn't done on data, it's done on
objects. That I can get information by looking in one object provides
no assurance that I can get it through a different object containing
the same information. This happens in /dev all over the place. A
file with hard links may be accessible by one path but not another.

>
>>>  You can transmit information through the scheduler,
>>> through hyperthread resource sharing, through CPU data caches, throug=
h
>>> disk contention, through page cache state, through RAM contention, an=
d
>>> probably dozens of other ways that I can't think of right now.
>> Yeah, and there's been a lot of activity to reduce those,
>> which are hard to exploit, as opposed to this, which would
>> be trivial and obvious.
>>
>>> There
>>> have been plenty of papers that demonstrated things like an SSH
>>> connection between two virtual machines without network access runnin=
g
>>> on the same physical host (<https://gruss.cc/files/hello.pdf>),
>>> communication between a VM and a browser running on the host system,
>>> and so on.
>> So you're saying we shouldn't have mode bits on files because
>> spectre/meltdown makes them pointless?
> spectre/meltdown are vulnerabilities that are being mitigated.
> Microarchitectural covert channels are an accepted fact and I haven't
> heard of anyone seriously considering trying to get rid of them all.

