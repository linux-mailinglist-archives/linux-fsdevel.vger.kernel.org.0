Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D20232E2D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 19:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfE2RE5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 13:04:57 -0400
Received: from sonic303-8.consmr.mail.bf2.yahoo.com ([74.6.131.47]:33325 "EHLO
        sonic303-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725917AbfE2RE5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 13:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559149495; bh=69qvQzXWECR+GHkmC3NT5N0sgy7z9vk5McUZDG/bT6A=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=IVQ2lEfx6kiFcpbfRAHBZUQeoA7WitSq7TYjCYYY9zBCVVjn8Y7gu7txNTX7QrAKCDoSMrSymNBAu7mR13F3wgt+JaZTyASUs6wYiJy3FqNukoJuHyWy5ZW66wq+Mh8QScdtUPwWy0TSoiqVyNKmwpfGur2V9NC8OZ4pTQou+rIDO134tRu5WOdFF3JD1hEtjmpS1u/iY22r0wdQCWX3KqmSP4KQpYfKVyigACAo7iuUeub6zqCutw2cDXyGMPZ8G8si7dMAnbckXvEF83M7YwQXn6UIcpwnSNDJP8XPSdFJeamCv2Iu919KaUoLEAKzW7dxVMObS5q7fNmUTirRrA==
X-YMail-OSG: p_insxUVM1k.IJgmtaqDPxrVOYeGQbCVG4Q2zBsgLVBM5S3bCzacINbSHqvXrYA
 Tqqthqx516mJuwWvdjaP4K6mP6tCKiHdvMRd6Wub6fIOk31Qiph6T86a8pRrrYsvdV6RymULvFBC
 .u40aRA4DQhssL5tD0nMQ2Zt4_Pr0Gs6zFOYm6Ktw7Qj.1F4NCoLfFpKuuzw518fmXuNWFTkyhtb
 HTSpISeoOq4hu.HxiKcYk1KLVx1bypno3TRkRhu7gGIQib6VCsPJBhcUXMXxkZjGVHxHI6vZRoSI
 lgRAVcMvZARiGbwDY3oxcKdS11KLYuJSMYOS00DDtoDWkxLbsDDs_JDgxaJ29lZUJewm9NgCgQDN
 arjV0O9dMPiiqrRxkyByXlRvNAhntqO2MMFtFAoraUPIVMEuSut28FDcrNI8_f1XwxZdlyFAOIIL
 K7Wode2d4nSQfC9lYMtM4ZPJz4Iettu.eWSDtEIQe0GD.4zRvp2PGu9mXzsmzdjZ7y_CxUiJkG3U
 H5SMJB7tRzgnBJcORz4IKk1iSsoMiBQXbC99cKGiEipxJu8d8PghU2TzFY3jShJajP.f._EGwQRR
 L7OTfmfTKtSsG8rOq8r4iPaHkuBl7X9FrByThc6A_mZCB0ehApAOwTT91ZTSudnf8YmlhTIxkrKc
 nyPydNQF8ippS8T0WO8u_3sChhLEqSj1WPuPGaxni13wj5t8rXHpAeKqsTWDEQLEWMbpbzlUVmJp
 hyEQtRzkZOB5mjf8jEi7earFs0Vp7GRDGJmX9hnmke6WTslI6mgOgWEK7jyNXZmA.4EgV8gwzn7v
 6D0XAHGZE38ciRB76cciyFPprN3cJ_dVF68Yc32SW4qE.Xq8mqcOZ0gDMgSHnvpSYz124rTtCz9W
 FEmwVwVYwij6b9pcX2UhKZiZBFV96tce2mngLh29gK4bDPcqBo4Fnl8.VvVyj7W.FNZPZv.0vuvR
 EwmoeklRN5Rpq_p6gc41pTWRMJLrwp.cxJOJJfxeHATS6o7dYJtafpPrcTGVdPM9mCw9GSebVY1h
 TuqSPD3u_A004EVM91JDFu_saJVldYIN02TS2ib68fwpwpPmJHkG6xthHYhCjO7te6gIiE.ogThN
 QKLNTIb8JlYDwLikiQACu0EBN_8VNKCWIr2Qkn2hO6N8IcaE288DCSglQOxCKMsI3oBBA8JB6ZXd
 9l04hTFauxWhWwA1XxaUCqXu6XiKaKuYQL6CdJrqEv60XyeFvjUEas4k3wc9tOXhK.ww3riWiBFa
 wW3yBMqMVitbxOjpLVSWTGcOQ5mUx
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Wed, 29 May 2019 17:04:55 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp423.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d7b9ddca251f26edd5d38f2fa16e0b7e;
          Wed, 29 May 2019 17:04:53 +0000 (UTC)
Subject: Re: [PATCH 3/7] vfs: Add a mount-notification facility
To:     Jann Horn <jannh@google.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, casey@schaufler-ca.com
References: <CAG48ez2rRh2_Kq_EGJs5k-ZBNffGs_Q=vkQdinorBgo58tbGpg@mail.gmail.com>
 <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
 <155905933492.7587.6968545866041839538.stgit@warthog.procyon.org.uk>
 <14347.1559127657@warthog.procyon.org.uk>
 <312a138c-e5b2-4bfb-b50b-40c82c55773f@schaufler-ca.com>
 <CAG48ez2KMrTBFzO9p8GvduXruz+FNLPyhc2YivHePsgViEoT1g@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <c95dd6cd-5530-6b70-68f6-4038edd72352@schaufler-ca.com>
Date:   Wed, 29 May 2019 10:04:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez2KMrTBFzO9p8GvduXruz+FNLPyhc2YivHePsgViEoT1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/29/2019 9:12 AM, Jann Horn wrote:
> On Wed, May 29, 2019 at 5:53 PM Casey Schaufler <casey@schaufler-ca.com=
> wrote:
>> On 5/29/2019 4:00 AM, David Howells wrote:
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
>>
>>> Maybe I should pass in NULL creds in the case that an event is being =
generated
>>> because an object is being destroyed due to the last usage[*] being r=
emoved.
>> You should pass the cred of the process that removed the
>> last usage. If the last usage was removed by something like
>> the power being turned off on a disk drive a system cred
>> should be used. Someone or something caused the event. It can
>> be important who it was.
> The kernel's normal security model means that you should be able to
> e.g. accept FDs that random processes send you and perform
> read()/write() calls on them without acting as a subject in any
> security checks; let alone close().

Passed file descriptors are an anomaly in the security model
that (in this developer's opinion) should have never been
included. More than one of the "B" level UNIX systems disabled
them outright.=20

>  If you send a file descriptor over
> a unix domain socket and the unix domain socket is garbage collected,
> for example, I think the close() will just come from some random,
> completely unrelated task that happens to trigger the garbage
> collector?

I never said this was going to be easy or pleasant.
Who destroyed the UDS? It didn't just spontaneously become
garbage. Well, not on modern Linux filesystems, anyway.=20

> Also, I think if someone does I/O via io_uring, I think the caller's
> credentials for read/write operations will probably just be normal
> kernel creds?
>
> Here the checks probably aren't all that important, but in other
> places, when people try to use an LSM as the primary line of defense,
> checks that don't align with the kernel's normal security model might
> lead to a bunch of problems.

The kernel does not have a "normal security model". It has a
collection of disparate and almost but not quite contradictory
models for the various objects and mechanisms it implements.
It already has a bunch of problems, we're just used to them.

I can only send a signal to a process with the same UID. Why doesn't
a process have mode bits so that I could get signals from my group?

Why do IPC object have creator bits, while files don't?

Why can I send a file descriptor over a UDS, but not a message queue?

Why can't I set the mode bits on a symlink?

What can go wrong if I don't map groups into a user namespace?

LSMs (SELinux and Smack, which are classic mandatory access control
systems in particular) are more consistent, but still have to deal with
some of these differences. A symlink gets a Smack label, for example.

The point being that it's very easy to add new mechanisms that do
wonderful things but that introduce unforeseen ways to bypass one
or more of the existing protections.


