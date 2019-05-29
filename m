Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02E192E3DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 19:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfE2Rqf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 13:46:35 -0400
Received: from sonic303-8.consmr.mail.bf2.yahoo.com ([74.6.131.47]:38931 "EHLO
        sonic303-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726808AbfE2Rqc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 13:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559151989; bh=CbTHMjH+ST+XZigj3rLVDQnXul1VH3bCZnpgyA114MY=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=QII37T1ZObtAVd8ttqra1vIxwLasAcJBJ5ma2pBpn/gWHzZPOrZpV+GDQXwdjt6tLs9N6jTXpLXKfEi1qKsqoc6tnK10TAom5AB4ysQEaV/Cc0ftHzZ6EHCg/38kwRLly+uuXpitKlxNa1KiUMAOEJsDxPdmA4jP9NCesBkAXoV8/+DFhDJKkcbuDMYPrE1BXUd7WjNa+YWHhW3d3k6obatB3B6RiBi1S2ekpVcergzMNZQENaLaBBEhYwf+EyS4DXi0OYZU/irLmDUYO5iX8/bSYgJS2VywwKmvC4iaOpGurkowe57wQ4a3DCW6IVzRttk/Ms47S0OubtvHBS1pzw==
X-YMail-OSG: Q2edbnMVM1nLWyT5kl2or1wKa7meZJQTF_.kj5teyboAvJoCEOlVHAZa4MoOp0P
 gi0uZAqwya30MhZmvJksN0fy1HyQuJtF2tMklDKir50ajN573m8UCIv8aDJfeEBgx8yczB_NLhQa
 ppMDfGmI2l9Bp_V6qvGtMCeR8kGhe.UMbtphUmTKiKBq2H5eXQ.ijU2EdHJQyk8l52wLhqKsmQf7
 3y7P_qc5DGi4tAR0HBhZLHFH5cGEtxfeW3CPRfD7_nxJmiv8kGmuPixWnmiD.6CEErJiQ92Yfc9j
 jTAlgZu_aU6cSzr_DeWMYdVWm7pV7TWzWTR6BVvT40M.AR_lHODFeLkRaXse_Dk3i4WcUO96HhAA
 K1.hgRWY0vkMQrLAw6Uf4oBmb4Dfh6PfQ_m3IXQtkSlPEaxFSdboSBqkvVlDD8LnMgDWj6yOW5qW
 MDMUDqvSdytafWcpwkBvVSHlatRIj8s2OEu9mmypITfxv78fCvMOMi7isrHOaJBkACOb0__aEp8.
 PDon7A08WUPOlpgw3hSSiQThTA1oqdshNZ4OeUfqLQN.4LQd9nfGgPL2yWYyHzb9YYy4h2iTjyNp
 W0FN2peTkSNFgUrn.xhXc1yH5uSZlQDJ_sYBIAKRatPnMNUERN48KhII7.8iUhx3COZQhuT3w_nS
 xXYd1kEXEcKDeMKb3tDTILGQ9dequD3rpMPQrcHvMIQqZsjFMf2VwjIidtX0jJxWAMsdtzIH8jE2
 d3WtsC0JchmLTC7yd.OgJ4BGdvZygeN2lMi6gF__UpcKPWzH84RMtpxa1SYwje2wmHtCCGIEXrFP
 sOMa8_4KvQosZGH2D4rhEr2TRjeDwhUqCJp46zTEu9e2Qj0JEDQHuGojaRFB1cdl2aDt91fougGu
 Fvr7s7q3IizFMLEJ8pFSyqeD5wu6Zkyo7.resXCXhfEn0KYsGbr3c23tHVVD1iL0THukM2RAxXw2
 uAYu2gddhcZNWpk4idR24JB.jlGcpgibnFMn3HSjdJ0YfUV5Xel8RAp8X4Ps9OhvwJL9uGTydtkI
 h_jKsNHYqN1rXcYqwAsj9x0eFBlOhtVcrId6PyXBps9dWX9u6k6YrOKky6rslqaI3t3Sb1klzPi_
 NYh7kgx3_K3SrGIJt2j3aVfCevB0Omhe584m0ruXaYRK1fo9nV_4_aC93LbecPZZLAQ1HaTO3E5q
 Kk1Z2TcmuwYGrJiJRlVNENMqeQ5oKxQm3QsH1cDYjXyt_FftVlpUhyF9iPtSa9YMyWdfSBent0H5
 hitHjPoES8mPwWntKf_ARZzC3zHg-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Wed, 29 May 2019 17:46:29 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp422.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 14a0212f313aaa80beda292114a9fd96;
          Wed, 29 May 2019 17:46:25 +0000 (UTC)
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
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <058f227c-71ab-a6f4-00bf-b8782b3b2956@schaufler-ca.com>
Date:   Wed, 29 May 2019 10:46:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <4552118F-BE9B-4905-BF0F-A53DC13D5A82@amacapital.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/29/2019 10:13 AM, Andy Lutomirski wrote:
>
>> On May 29, 2019, at 8:53 AM, Casey Schaufler <casey@schaufler-ca.com> =
wrote:
>>
>>> On 5/29/2019 4:00 AM, David Howells wrote:
>>> Jann Horn <jannh@google.com> wrote:
>>>
>>>>> +void post_mount_notification(struct mount *changed,
>>>>> +                            struct mount_notification *notify)
>>>>> +{
>>>>> +       const struct cred *cred =3D current_cred();
>>>> This current_cred() looks bogus to me. Can't mount topology changes
>>>> come from all sorts of places? For example, umount_mnt() from
>>>> umount_tree() from dissolve_on_fput() from __fput(), which could
>>>> happen pretty much anywhere depending on where the last reference ge=
ts
>>>> dropped?
>>> IIRC, that's what Casey argued is the right thing to do from a securi=
ty PoV.
>>> Casey?
>> You need to identify the credential of the subject that triggered
>> the event. If it isn't current_cred(), the cred needs to be passed
>> in to post_mount_notification(), or derived by some other means.
> Taking a step back, why do we care who triggered the event?  It seems t=
o me that we should care whether the event happened and whether the *rece=
iver* is permitted to know that.

There are two filesystems, "dot" and "dash". I am not allowed
to communicate with Fred on the system, and all precautions have
been taken to ensure I cannot. Fred asks for notifications on
all mount activity. I perform actions that result in notifications
on "dot" and "dash". Fred receives notifications and interprets
them using Morse code. This is not OK. If Wilma, who *is* allowed
to communicate with Fred, does the same actions, he should be
allowed to get the messages via Morse.

The event is information. The information is generated as a
result of my or Wilma's action. Fred is passive in this access.
Fred is not "reading" the event. The event is being written to
Fred. My process is the subject, and Fred's the object.

Other security modelers may disagree. The models they produce
are going to be *very* complicated and will introduce agents and
intermediate objects to justify Fred's reception of an event as
a read operation.

> (And receiver means whoever subscribed, presumably, not whoever called =
read() or mmap().)

The receiver is the process that gets the event. There may
be more than one receiver, and the receivers may have different
credentials. Each needs to be checked separately.

Isn't this starting to sound like the discussions on kdbus?
I'm not sure if that deserves a :) or a :( but probably one of the two.


