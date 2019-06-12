Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 650B642E6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 20:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfFLSOq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 14:14:46 -0400
Received: from sonic309-22.consmr.mail.bf2.yahoo.com ([74.6.129.196]:46426
        "EHLO sonic309-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726660AbfFLSOo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 14:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560363281; bh=xIF1XHVgS31oW5M5zK0EqGkjdhl54UMxsg7idDaz8ik=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=aLd0A6CZHfDugx9DtN3ricVSnlmVqdR2p8Kwr2MTVebdGsBkpUCszSmtm2gJZSE1JHzGOqK+EOhMfQBLjYa1jrsFipmpOvYGWBJWRlIjh7lksfhi7C0vzcsUcrsMrTSQuXHkBW8hDT1SzTT7K893zLayGt/hKBkYbU5gqOFH12m85+llfgiaYktxaAc+rxXZqla0/c+IptW8EquhbvDWC2+haMreihiUyZEBjuD7+Mn8tfie78sxKHFP9iOVEcBQyKN7vHhoa6ec6ppcp7rrzgl/KUnDO5g1EeXQ8lA6P5zX69Bf+1auBZwnR2BgzEPLsV1N5L7uC3AiK4JoZaByag==
X-YMail-OSG: Xl318kMVM1lYWYMfF8RkKKue51mSK02d_ZqzkgEhZfk_znF8gGMYBiMqLWvWjPf
 0SDQQK4Kc9UlbO7v4Lq9ZlKNpNYwL5uCm8jqBVDYd1TLYV24FUXz1VlihyKLXn7DH3xmcSWaTzPD
 czhc_y2Bzw4vFZ2VrKPL4DcJ25Ae5n6bPrbd8KIRyzikMQnSR1Qf.wSmbFeAAMyvVu0VoE4WR46t
 p1oWaPe5fQLPDbqwYvLyIc6xlS6vXv2Icg1hoEcf5d2S_85WB5Q40msob4CUXocGU9x0hDEQz2hF
 NyA2pNEryZHrvijtIduoIbn6BD61VBPOTIsSxHPmmauAh6jWiwd8.QPVgxgI4VtYX5ySEhigIFPG
 Jn6fVlCbgoHNBbToKL8rUhvm.kjd1r75kqPqsOKhH45.h9AbH0TSwEu754XcAxUUNq3UhPbnGyye
 8rnpl_Qtz2RAUH_APQzqrYHRQSStDzYOglK3VNY.s1FqU2wi7JZCDe_ARBFJKe9H4G33EnCPbSB9
 DhPHri8cVRln2V05tC3N24rX3ln4LvsbMb5B1bKhrVxvOIrFDbCfKPFzliVs3RYmr8Vhufzs6oKB
 8QpCkZpTyoyAoUMZsHCNpbD0FWUWjHrHLhshbgJrzxPqJDXZMd9IjixAeOAoyk909EdjPyFaktkC
 BraqxDezBU8n2fdIafQbM2_V1Aw2NlYhpJk_uy8a.uIy4FyxzcPC3qhYJPD_kxtsCiZqlz3Gb8xg
 SekjPKUVxiviwmeXgyIjBHodT7HEu1BPwervIVdeWco8Tcbz1V_wlZEigdfGMPse.R1U0_mYdFqi
 BJbmvbcQIeH5QFWwyDTeW7Q20jr5KOgL1N6hCtik7eH3pma4VHZB98d.mqesPvJYVQU7qYGhKitu
 wXmAVIucpUAUSiVeZNLAARtIN17iOMMSAvbkmF7xKo1CyhdVJuKZUKFCDA9VBbvDP6z1WCAZZZye
 PKEYUk_NAK55ahr_7njAE7MmwNQXd1FnU.21PqYo7ENAy6GVrQVGuhy96eTw5BNeDtGpsmMcnu1S
 ob5SFWowUOknCHJUIMiA3ifJTAjRsEgYNEHDdRJAOiahGYL7evsCZwq3fDSxyEBgscFiUi4Rfdjr
 AEMoamGkIjrJj5_l22Nzo_OI3273656M5mF9nmifOTtceOcioI6Q28ISUlcr.MJmie4M2ZR5q.6w
 Pu4ExRtMRNOnurhhDPqa92QJ0ZNki7ynA9Q9gQsXPseY67XslaXxRqhHCQI6elKZGZm6ZkHUtRmX
 yayT.TRuYJqJTdZp7kble
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Wed, 12 Jun 2019 18:14:41 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp405.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 90667aa732a85c97b8d2b127900fddb3;
          Wed, 12 Jun 2019 18:14:39 +0000 (UTC)
Subject: Re: What do LSMs *actually* need for checks on notifications?
To:     David Howells <dhowells@redhat.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Andy Lutomirski <luto@kernel.org>, viro@zeniv.linux.org.uk,
        linux-usb@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        casey@schaufler-ca.com
References: <9c41cd56-af21-f17d-ab54-66615802f30e@schaufler-ca.com>
 <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk>
 <31009.1560262869@warthog.procyon.org.uk>
 <14576.1560361278@warthog.procyon.org.uk>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <0483c310-87c0-17b6-632e-d57b2274a32f@schaufler-ca.com>
Date:   Wed, 12 Jun 2019 11:14:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <14576.1560361278@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/12/2019 10:41 AM, David Howells wrote:
> Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>>>  (4) The security attributes of the object on which the watch was set=
 (uid,
>>>      gid, mode, labels).
>> Smack needs this to set a watch on the named object (file, key, ...).
>> I am going to say that if you can't access an object you can't watch i=
t.
> So for the things I've so far defined:
>
>  (*) Keys/keyrings require View permission, but it could be Read permis=
sion
>      instead - though that may get disabled if the key type does not su=
pport
>      KEYCTL_READ.

View is good enough.

>  (*) Mount/superblock watches - I've made these require execute permiss=
ion on
>      the specified directory.  Could be read permission instead.

Execute is good enough.

>  (*) Device events (block/usb) don't require any permissions, but curre=
ntly
>      only deliver hardware notifications.

How do you specify what device you want to watch?
Don't you have to access a /dev/something?

"currently" makes me nervous.

>> I think that read access is sufficient provided that no one else can
>> see what watches I've created.
> You can't find out what watches exist.

Not even your own?


>>> At the moment, when post_one_notification() wants to write a notifica=
tion
>>> into a queue, it calls security_post_notification() to ask if it shou=
ld be
>>> allowed to do so.  This is passed (1) and (3) above plus the notifica=
tion
>>> record.
>> Is "current" (2)? Smack needs (2) for the event delivery access check.=

> (2) was current_cred() when watch_sb(), KEYCTL_NOTIFY, etc. was called,=
 but
> isn't necessarily current_cred() at the point post_one_notification() i=
s
> called.  The latter is called at the point the event is generated and
> current_cred() is the creds of whatever thread that is called in (which=
 may be
> a work_queue thread if it got deferred).
>
> At the moment, I'm storing the creds of whoever opened the queue (ie. (=
1)) and
> using that, but I could cache the creds of whoever created each watch
> (ie. (2)) and pass that to post_one_notification() instead.
>
> However, it should be noted that (1) is the creds of the buffer owner.

How are buffers shared? Who besides the buffer creator can use it?

>>>  (e) All the points at which we walk over an object in a chain from (=
c) to
>>>      find the watch on which we can effect (d) (eg. we walk rootwards=
 from a
>>>      mountpoint to find watches on a branch in the mount topology).
>> Smack does not require anything beyond existing checks.
> I'm glad to hear that, as this might be sufficiently impractical as to =
render
> it unusable with Smack.  Calling i_op->permissions() a lot would suck.
>
>>>  (y) What checks should be done on object destruction after final put=
 and
>>>      what contexts need to be supplied?
>> Classically there is no such thing as filesystem object deletion.
>> By making it possible to set a watch on that you've inadvertently
>> added a security relevant action to the security model. :o
> That wasn't my original intention - I intended fsmount(2) to mount dire=
ctly as
> mount(2) does, but Al had other ideas.
>
> Now fsmount(2) produces a file descriptor referring to a new mount obje=
ct that
> can be mounted into by move_mount(2) before being spliced into the moun=
t
> topology by move_mount(2).  However, if the fd is closed before the las=
t step,
> close() will destroy the mount subtree attached to it (kind of quasi-un=
mount).
>
> That wouldn't be a problem, except that the fd from fsmount(2) can be u=
sed
> anywhere an O_PATH fd can be used - including watch_mount(2), fchdir(2)=
, ...
> Further, FMODE_NEED_UNMOUNT gets cleared if the mount is spliced in at =
least
> once.
>
> Okay, having tried it you don't get an unmount event (since there's no =
actual
> unmount), but you do get an event to say that your watch got deleted (i=
f the
> directory on which the watch was placed got removed from the system).
>
> So...  does the "your watch got deleted" message need checking?  In my
> opinion, it shouldn't get discarded because then the watcher doesn't kn=
ow
> their watch went away.

Can you glean information from the watch being deleted?
I wouldn't think so, and it seems like a one-time event
from the system, so I don't think an access check would
be required.

>
> David

