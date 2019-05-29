Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD2652E156
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 17:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfE2Plv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 11:41:51 -0400
Received: from sonic303-8.consmr.mail.bf2.yahoo.com ([74.6.131.47]:37560 "EHLO
        sonic303-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbfE2Plu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 11:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559144509; bh=fIF8FHrdxkMOIaxKZ14fK2jsxLnWhP2FKBQ5OFGZvLk=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=VJSAKcoTcK42fOZgEvm/NJt22/xiFB+818scenfqJv6WUv+OaiE6Z5uPGkgEkVUbsqMWRBaboGPF/inRn9pCCNa9Gr30S+o5qmsbR2VVPGZq636/eTUsZX402RIuUAjNzvo6ZMXkkNYAkm5Vkwf+VytR222WrH1L/r5jiiuHo6d2ARxXdrU35TVOujh/xj7LsFwHxqxczF1UHzvVUZthtODimR3YcOdI2RUTs490D8SB389wuqeSvwEA/f0dmndp9hTXyy7Vsr7+ozXll/g7KgvJL372LpsvaK4BSAOzFCTJNmracGluBnICe1CHZaY2XkCc2PGollL5c0wt8pxw2g==
X-YMail-OSG: MsmGAukVM1mBdI3BtiJ8eZ8btC_ZI31E.AscaDvep.YvrbbjmnV_TirFFioysaT
 YlHWtYzGcnGT65jKZgEdItX8Bm.cfPny8tW89N8yIqeCDedQXkIUyfENbWMOmZqek0ZMi3TjhNQs
 tWn28v1LkEqKY0SXZbpO1j67BjPkiQEElY9VFwZIrBhRZeX5ohxXtBdK1xRDA2uZYdnoa2mGEZx6
 zKFihzzYcQwO5mOFA3LFC_dTnk3r_4i7Fx4ILdHTi663PVtW.tCOrsOld438WBMiIm1LJOrybzUM
 jS2I82a2OjVldWsoJVmr9EuOjXJ428zbRAZS_xch0TFrQgqEsvUsJpJybRm1Z5_MRi75aZ4YhpN9
 FsqIl19HmQIbnax1dtulwxZnYbHQ2t3NGN0.s4k8qfu1Mk2XG2FDBC1Hii18qrfyQauoLqz7.9qJ
 BCe5RsahVnLIvGDisC22Rrfqto90DbLdmj9Yt4d53FigKXZVcr4HBB0sxt26ZFg.A81ZzlSrr_EC
 kkLYB28AlSGBzU_9hPfL93C9GNN1suCxrIQRAsrNrqJlhuIGGP6mv6Twgt3e3Oj48gHCU66ZKLzm
 xatT7Cr1eEgrzMQhWT0VXGpp0nYdgBGN6BB3LwsHaYY_uWEObd15Xqy9_vQpTh_7AZDZc8005l8U
 ilwPfztsMovuhWvTvJOR.fiwGwTPBe8fcVdOqcMMph2SHFkSEUVabfOpzzkH.R1zYXXuvkH0BvZC
 17jRzAzGUPjkl5DbRUYZcjr1pwnEqaKqjKFz7dDM0riNJ8RISn1cQhluzFco4Acmbic3eOXRI493
 6JSiH_EeBhpCu7MqsetK2OoZyh_a89Y5ma4J2pXvXqw8djLqseRndmHoKjDsiW65xUNPhMHr7G4R
 pt203vN3KsdICxmASCwOGD5izTjDD9FgyP224SUCWoOhrfPIA0LC5iLoxxUAd5DobIEbOFhkLnTj
 MGp4I16IFhpHY3Mms9zMtkpF6l03jRoDTC1aLVutDj1E2dNU2w8V5ENTR_JOA_4KvnVsuZlDXF4Y
 EQpPZQnvL0vCjYvAmDYIZQ.M2cPtR797SslPc6NBEXErbPAc9b4LFwCWf8iuWR7._Slr6xd55xRn
 ZsUML47cyyApxA7D7YEEeb9ge5kw_6I_w6c.Zq96D6DRJgh_rUgQRlvRywvAIzdE1kbfaN8womuH
 JzziQdbl6Rkv_dvGE5kv7PuKL2_faAT_AbSruW1MOBqjx_xgDwBx0K1_VTUFh1h2PdwqIdcr7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Wed, 29 May 2019 15:41:48 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp415.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 53cac997c7a8b6f08ba08da82c1b2c81;
          Wed, 29 May 2019 15:41:45 +0000 (UTC)
Subject: Re: [RFC][PATCH 0/7] Mount, FS, Block and Keyrings notifications
To:     David Howells <dhowells@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, casey@schaufler-ca.com
References: <20190528235810.GA5776@kroah.com>
 <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
 <31751.1559120984@warthog.procyon.org.uk>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <c3d76089-cd0a-a378-f6e8-2fe6e9a5c254@schaufler-ca.com>
Date:   Wed, 29 May 2019 08:41:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <31751.1559120984@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/29/2019 2:09 AM, David Howells wrote:
> Greg KH <gregkh@linuxfoundation.org> wrote:
>
>>>  (3) Letting users see events they shouldn't be able to see.
>> How are you handling namespaces then?  Are they determined by the
>> namespace of the process that opened the original device handle, or th=
e
>> namespace that made the new syscall for the events to "start flowing"?=

> So far I haven't had to deal directly with namespaces.
>
> mount_notify() requires you to have access to the mountpoint you want t=
o watch
> - and the entire tree rooted there is in one namespace, so your event s=
ources
> are restricted to that namespace.  Further, mount objects don't themsel=
ves
> have any other namespaces, not even a user_ns.
>
> sb_notify() requires you to have access to the superblock you want to w=
atch.
> superblocks aren't directly namespaced as a class, though individual
> superblocks may participate in particular namespaces (ipc, net, etc.). =
 I'm
> thinking some of these should be marked unwatchable (all pseudo superbl=
ocks,
> kernfs-class, proc, for example).
>
> Superblocks, however, do each have a user_ns - but you were allowed to =
access
> the superblock by pathwalk, so you must have some access to the user_ns=
 - I
> think.
>
> KEYCTL_NOTIFY requires you to have View access on the key you're watchi=
ng.
> Currently, keys have no real namespace restrictions, though I have patc=
hes to
> include a namespace tag in the lookup criteria.
>
> block_notify() doesn't require any direct access since you're watching =
a
> global queue and there is no blockdev namespacing.  LSMs are given the =
option
> to filter events, though.  The thought here is that if you can access d=
mesg,
> you should be able to watch for blockdev events.
>
>
> Actually, thinking further on this, restricting access to events is tri=
ckier
> than I thought and than perhaps Casey was suggesting.
>
> Say you're watching a mount object and someone in a different user_ns
> namespace or with a different security label mounts on it.  What govern=
s
> whether you are allowed to see the event?

Conceptually it should be simple, but we have a variety of different
policies in the core OS, never mind what goes on inside the LSMs.
If you want to treat a notification like a signal you would only deliver
it if the process that performed the action that triggered the event
has the same UID as the process receiving the notification. Should you
decide to treat it like an IP packet only the LSMs would filter delivery.=

If there are mode bits on the thing being watched shouldn't you respect
them?

> You're watching the object for changes - and it *has* changed.  Further=
, you
> might be able to see the result of this change by other means (/proc/mo=
unts,
> for instance).
>
> Should you be denied the event based on the security model?

=46rom a subject/object model view there are two objects and one
subject involved. The subject (active entity) is the process that
changes the first object, triggering an event. The watching process
(that will receive the notification) is the second object, because
its state will change (be written to) when the notification is
delivered. For the watching process to receive the notification
the changing process needs write access to the watching process.
The indirection of the notification mechanism isn't relevant.
If the changing process couldn't directly notify the watching process
it shouldn't be able to do it indirectly, either.

> On the other hand, if you're watching a tree of mount objects, it could=
 be
> argued that you should be denied access to events on any mount object y=
ou
> can't reach by pathwalk.
>
> On the third hand, if you can see it in /proc/mounts or by fsinfo(), yo=
u
> should get an event for it.

Right. We've done a pretty good job of muddling the security
landscape by adding spiffy features to make life easier for
particular use cases. /proc is chuck full of examples. Objects
that can be viewed in many different ways make for confusing
security models. Try explaining /proc/234/fd/2 to a security
theory student.

>> How are you handling namespaces then?
> So to go back to the original question.  At the moment they haven't imp=
inged
> directly and I haven't had to deal with them directly.  There are indir=
ect
> namespace restrictions that I get for free just due to pathwalk, for in=
stance.
>
> David

