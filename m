Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C57422E547
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 21:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfE2T2b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 15:28:31 -0400
Received: from sonic303-9.consmr.mail.bf2.yahoo.com ([74.6.131.48]:35410 "EHLO
        sonic303-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726301AbfE2T2a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 15:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559158109; bh=mI+Y3hPhiC0AjeTQKSfn/UgtuD2JICmuTNIyjczfjMc=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=EBjrIrzI0PtNHRps2hfdUIniaSCpbHLu+YHkCrjzySUuvtpBtqMee1I5SbDSd7506warYWf+ys4lq2Z7D4ckfTqUoR04QyuLu90wknJStYmn9J1S76wsYIKOHCC7ezowM0jYxZKcXr/v/HTrSoepZOMJjIRbVnX2iRUELYfGsHzDEMkL94VOp/xhv+WOZYkR4IRGC0NUD9ClrRhG4UhLAj/JFtlPAzVS/f0tNO545X2Ubuer6Uwylg35tMrgf6xDnygw2KhkMbV5s9Qd5874Pv/ApeaihxMJxMmIcrb6xQV7iiXTfYWaYnL276UkbiUVkgHeDXxrXn/oxQjm3dnFdw==
X-YMail-OSG: E1xQI4kVM1mU1DGvCYW_K7FyyCIrU6eY9zU5h_nAZlvdgyUfhm4yvWd0IzZ3g2h
 k8QQmFFU509FEtAfwHYp1RJXbi0fvm2fvPYf_rLxAyav7IvXcjy1TqdEC4OSlMtXxVeGcPydOkAq
 KEEb5i_5grgQJ5oaXnVMiJc3PXBx2u0F1vVv.bE_pZQ32m3SGSGaPJcgs41CBBS.dS1F5u.3o0NR
 vAgr9bGLD4pqZp0oOrPoNN9wwGL3LEwIopGAlhg.KOCKN1B.S29uAZ1F8M1jT1vCCwXuPYLlLQq4
 0UR2TJsZDBuPBGJlx51zZuc92IYF9l8r1Zbb8bvtqoAGfXEZLdHtD2HY6L4igjZupe4qYothHOtt
 619yqHSpH.Dd5QWgxZWucGXcOwaFW_0EbjoJxpZP_KezARU0vpbQVrmfwuu0Asb1.uLbEpxGl3ei
 moWRRzuQnY4BfjKDCzVGk5Qt7YFmrTZ9PAxAanK7dcMnd.WJoXz.97z3FySkO.LU.pRiXPIVzVNu
 9C4FHSYTxqwUtMlPvLmULgOL.7GFSQzMyAiWRNo6pRgsw82AI6bq0IoTmjm.JSX7pp.OyYWN_vlS
 1U_n7TWgMb7PkJtEpsUuAS4IkHEIfxOyx7HOnpM1RJuoBCLxrbYudGNba8z9nTDI8yx3_Lf7mLaS
 KqW3fh1JTQM47XS4GdGiAwlwBEAn_A3hVEU_n4CozgTO0dU8NRnbphUdvau7hXP7_CtooflRd2yb
 oH9YSoxN2Q7WZYfa83hT8tqvnkKwK6VFVnv8sjVGvL6VJFhKxn9stQwxpU9aLdpyFEXovK4ik7g5
 Az3eXBfP0xro1K.Y4Eflilyiw2M4MgKYt6AV45S_zq_bmCFeY91GjWhAYbDyWoF8hUmlvIwpRp6O
 IWJ6x74bnQuw9evHm9BIiYp4keE8tgNGr7eP8tIFkk.6DZaFfS1wVNuZOlXHw_CqpUzQDuVwZERq
 I1hVD4IJP6ZJVtFI31Bb4iNbOIkpVkWEpGkN38iDN8BkN9DMDUj2Mzjiep.1U1.2gBLtYLFxVZMY
 JD519XfeFN0tyMWIJ75NKmbYcnDSbZfMpXn4BbPkPlhsuc1R1X2n_vQSgiDdu9.O4K4yo7OSeIaT
 RgXLx73CYdV.E3f3Kdw_DRdKlPwb6gaOThcKXko2OOwnzlTkdLcNUbjUBHuSEuEWKn7MvZSTWIGJ
 vWEd8sMeXBqExu0u5PAnJU53YiKCGrLSpjz55ObzqmX.rkg8yKMBnRiJbq4VLsSW2hJ7ae0snivO
 EdguXMUV2c9Ar.zcDKkr0p_RavXQ6Og--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Wed, 29 May 2019 19:28:29 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp412.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f20890b94c6caabe18125460db352644;
          Wed, 29 May 2019 19:28:25 +0000 (UTC)
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
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <0cd823ca-4733-19ef-c13e-ed5ac8c63a0f@schaufler-ca.com>
Date:   Wed, 29 May 2019 12:28:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez2S+i2wxpWXVGpEAprgY9gtjxyejLfbZtrqu5YOkQ81Nw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/29/2019 11:11 AM, Jann Horn wrote:
> On Wed, May 29, 2019 at 7:46 PM Casey Schaufler <casey@schaufler-ca.com=
> wrote:
>> On 5/29/2019 10:13 AM, Andy Lutomirski wrote:
>>>> On May 29, 2019, at 8:53 AM, Casey Schaufler <casey@schaufler-ca.com=
> wrote:
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
> In other words, a classic covert channel. You can't really prevent two
> cooperating processes from communicating through a covert channel on a
> modern computer.

That doesn't give you permission to design them in.
Plus, the LSMs that implement mandatory access controls
are going to want to intervene. No unclassified user
should see notifications caused by Top Secret users.

>  You can transmit information through the scheduler,
> through hyperthread resource sharing, through CPU data caches, through
> disk contention, through page cache state, through RAM contention, and
> probably dozens of other ways that I can't think of right now.

Yeah, and there's been a lot of activity to reduce those,
which are hard to exploit, as opposed to this, which would
be trivial and obvious.

> There
> have been plenty of papers that demonstrated things like an SSH
> connection between two virtual machines without network access running
> on the same physical host (<https://gruss.cc/files/hello.pdf>),
> communication between a VM and a browser running on the host system,
> and so on.

So you're saying we shouldn't have mode bits on files because
spectre/meltdown makes them pointless?


