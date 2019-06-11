Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 877743D21B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 18:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391286AbfFKQW6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 12:22:58 -0400
Received: from sonic314-26.consmr.mail.ne1.yahoo.com ([66.163.189.152]:32785
        "EHLO sonic314-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405444AbfFKQW5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 12:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560270174; bh=apc4Fo0+veY52B1Qizn/6BnH8QD+lHxZsEhsdPjZou4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=CiI0glvBHl0000qda+QQa8Z6AumjbbilqW5O5LrVO1cB1d3ad55aGZGMjZL5i68McXVlgi7rXOw4QzWjPp63CNpdyZUTa87lPgk1KR7RjKzDoNOXMkM03lTSLEoHI/oLE2tYhJQ9qOpgfXug7jj5y2Fc0Cdu+/5q4+tWcjZDrVTLH8h5A4xqJD8IakZKVCe41JNFnpqg0hX3+gCg/QfRsIViQ+bZXvc4or+r2atmOloNEBaopsMWZ1c0B72CfmZGp03vn5faSe5DRmQEMjWB5zuTdmkKMHEzd7IaCZGsmkGaT6Cxgi/dqL1rHQoodc3Q22QabXkwrv8DKsSkh+JNcA==
X-YMail-OSG: u59wP2cVM1kRzBmTzHGO41iF3i24SYEQDgx2CmzOyqoxIGvgn6j.W.mB0AzWJ8H
 M3d1f4GksdinoY6dByskH766M1Dj4qP02Zv1yGDTgsC9MJu8GTqdP_uklS_zACuSZ_nYWKeeGGQK
 JTCULXFWg5Gy3rcODWLUy2SolxvUBdye9TMTwCI1Vtjo39EMWnt.9fHAh7ZqX.jm_1Ey1GPc39Us
 lL7j_fI39dlO7WsRoZLFmgJOqAGmQGkfihTAo.jauGocr52aEOdyKy8I3YE1_5xX8N8RIivg0zcM
 _JIgU840_4PYptYeTccihSmSaMx8jWu_7h4tyTfF0ESq6FA3nRa3gS8Tu6AyL7GhP.i1nNWHH5Qw
 0tsdGPIiRxbELuCIOy3B2AkFA8efGPnOXMqIEvh78PuC6V9UDfM7TL8N40IknEYZUO6LxWMi11q2
 M0VqI.qwFbkKuQqLoZeWWpPv.JWiKvOOBzO3lqnry5t9cH9IgXEOAZ4.YBowqb8fkh7dcvOm4Lcn
 wME3BHr434fNYq734Z3mb6UrdTairE7tR9obGChnjovirG5vM.zbULG9XAihGkznugVYexB88Wjs
 2O7G93TSpIBH8CulPx.s0RcLt5JDQ_6LzVocmXkshoHU5Hlk8t7_grKWW.QOGOcnX2FbV78mTra1
 7xwXqFwkWk_b1SVhcIiJqj1invbMmIjY1KhbQAWKUMD1n9usg2VcOYwCiZkzK8qQcxe.7ntPEUeD
 OKwNgNZ_vWs3nopYNID.8EWYZj.hwrBgMBoLY6C4sPNgLPinqrgVF79W.JmCtzIo99U4zhTz3fNg
 3M1hOHsKzw3B7OoXZCvTDgZbJm210adlW5lF0htD39KhvxilzZLNbcYgfpWTXYsRgX1bVc.m1Cny
 M6l0aINZ58R.vlQp14jgAu1LQKAHLrIM3Av4pP6acUfsPLUN3zKnhvOUe7nO0.aqzwYRU_ogNW5U
 q0CzRFSRN9uG8FVVJJDELHLEQjVruUOpzo99oaMATMn2BTXfaVqVd2jy0KjHYx.BPEE.vl_H3dNs
 bj_u15yvbbJbjpY3FLTw6jSREJoPFVxsUcIFwlhP5Z9lxIxLqjnbs7FiE8cmUUemk0rGJkfBWqMR
 NxIT2QwVkbGIKYjItoXb9vZ3KPX17oPKtbaEaQEaJxCso98f5Ix5PdwyPTUbFySmVrHzG03L7ja6
 PqcZVGbdOLZ2FZyEnNzKjv5tRNAIcWt7HAPlUKjFhXZ8cgyNrApDWSPJh5MuSreJD0glAayaAZWQ
 VQ5QsZQzj0AIhqR8snw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Tue, 11 Jun 2019 16:22:54 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp402.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8b7547272b6a849d9e3f57a9223ff0ec;
          Tue, 11 Jun 2019 16:22:50 +0000 (UTC)
Subject: Re: What do LSMs *actually* need for checks on notifications?
To:     David Howells <dhowells@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Andy Lutomirski <luto@kernel.org>
Cc:     viro@zeniv.linux.org.uk, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        casey@schaufler-ca.com
References: <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk>
 <31009.1560262869@warthog.procyon.org.uk>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <9c41cd56-af21-f17d-ab54-66615802f30e@schaufler-ca.com>
Date:   Tue, 11 Jun 2019 09:22:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <31009.1560262869@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/11/2019 7:21 AM, David Howells wrote:
> To see if we can try and make progress on this, can we try and come at =
this
> from another angle: what do LSMs *actually* need to do this?  And I gra=
nt that
> each LSM might require different things.
>
> -~-
>
> [A] There are a bunch of things available, some of which may be coincid=
ent,
> depending on the context:
>
>  (1) The creds of the process that created a watch_queue (ie. opened
>      /dev/watch_queue).

Smack needs this for the filesystem access required to open /dev/watch_qu=
eue.

>  (2) The creds of the process that set a watch (ie. called watch_sb,
>      KEYCTL_NOTIFY, ...);

Smack needs this to set a watch on any named object (file, key, ...).
Smack needs this as the object information for event delivery.

>  (3) The creds of the process that tripped the event (which might be th=
e
>      system).

Smack needs this as the subject information for the event delivery.

>  (4) The security attributes of the object on which the watch was set (=
uid,
>      gid, mode, labels).

Smack needs this to set a watch on the named object (file, key, ...).
I am going to say that if you can't access an object you can't watch it.
I think that read access is sufficient provided that no one else can
see what watches I've created.
=C2=A0

>  (5) The security attributes of the object on which the event was tripp=
ed.

Smack does not need these for the event mechanism as that object isn't
involved in the event delivery, except as may be required by (4).

>  (6) The security attributes of all the objects between the object in (=
5) and
>      the object in (4), assuming we work from (5) towards (4) if the tw=
o
>      aren't coincident (WATCH_INFO_RECURSIVE).

Smack needs these only as they would apply to (4).

> At the moment, when post_one_notification() wants to write a notificati=
on into
> a queue, it calls security_post_notification() to ask if it should be a=
llowed
> to do so.  This is passed (1) and (3) above plus the notification recor=
d.

Is "current" (2)? Smack needs (2) for the event delivery access check.

> [B] There are a number of places I can usefully potentially add hooks:
>
>  (a) The point at which a watch queue is created (ie. /dev/watch_queue =
is
>      opened).

Smack would not need a new check as the filesystem checks should suffice.=


>  (b) The point at which a watch is set (ie. watch_sb).

Smack would need a check to ensure the watcher has access
in cases where what is being watched is an object.

>  (c) The point at which a notification is generated (ie. an automount p=
oint is
>      tripped).

Smack does not require an explicit check here.

>  (d) The point at which a notification is delivered (ie. we write the m=
essage
>      into the queue).

Smack requires a check here. (2) as the object and (3) as the subject.

>  (e) All the points at which we walk over an object in a chain from (c)=
 to
>      find the watch on which we can effect (d) (eg. we walk rootwards f=
rom a
>      mountpoint to find watches on a branch in the mount topology).

Smack does not require anything beyond existing checks.

> [C] Problems that need to be resolved:
>
>  (x) Do I need to put a security pointer in struct watch for the active=
 LSM to
>      fill in?  If so, I presume this would need passing to
>      security_post_notification().

Smack does not need this.

>  (y) What checks should be done on object destruction after final put a=
nd what
>      contexts need to be supplied?

Classically there is no such thing as filesystem object deletion.
By making it possible to set a watch on that you've inadvertently
added a security relevant action to the security model. :o

>      This one is made all the harder because the creds that are in forc=
e when
>      close(), exit(), exec(), dup2(), etc. close a file descriptor migh=
t need
>      to be propagated to deferred-fput, which must in turn propagate th=
em to
>      af_unix-cleanup, and thence back to deferred-fput and thence to im=
plicit
>      unmount (dissolve_on_fput()[*]).
>
>      [*] Though it should be noted that if this happens, the subtree ca=
nnot be
>      	 attached to the root of a namespace.
>
>      Further, if several processes are sharing a file object, it's not
>      predictable as to which process the final notification will come f=
rom.

How about we don't add filesystem object deletion to the security model?

If what you really care about is removal of last filesystem reference
(last unlink) this shouldn't be any harder than any other watched change
(e.g. chmod) to the object.

If, on the other hand, you really want to watch for the last inode
reference and actual destruction of the thing I will suggest an
argument based on the model itself. If all of the directory entries
are unlinked the object no longer exists in the filesystem namespace.
If all of the fd's are closed (by whatever mechanism, we don't really
care) it no longer exists in any process space. At that point it has
no names, and is no longer a named object. No process (subject) deletes
it. They can't. They don't have access to it without a name. The
deletion is a system event, like setting the clock. There is no policy
that says when or even if the destruction occurs.

If and when the system gets around to cleaning up what has become
nothing more than system resources any outstanding watches can be
triggered using the system credential.

>  (z) Do intermediate objects, say in a mount topology notification, act=
ually
>      need to be checked against the watcher's creds?  For a mount topol=
ogy
>      notification, would this require calling inode_permission() for ea=
ch
>      intervening directory?

Smack would not require this. Paths are an illusion.

>      Doing that might be impractical as it would probably have to be do=
ne
>      outside of of the RCU read lock and the filesystem ->permission() =
hooks
>      might want to sleep (to touch disk or talk to a server).
>
> David

