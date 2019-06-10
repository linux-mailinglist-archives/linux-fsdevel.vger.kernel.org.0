Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB84E3BBC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 20:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387872AbfFJSWS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 14:22:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33825 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387500AbfFJSWR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 14:22:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id q15so3279120pgr.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jun 2019 11:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QY6i0yhlosYKBzQSKH6aCBy2mSO5xg+k21z4/T/g/QU=;
        b=CWrMCQpEHfiGDH0/APPguYvej1X08PVZNfvMJvyD21ZEb3eivAPQzuJ8tMNj9FYVca
         jql6TF1mR9e/BXtgpx/0lzJODxMFkITGUR41xdyHsLIfqch+LeMsbWN6NTv+5wuIWO5w
         k/dR+pBTAAG82Or6u+B72UnwccZfrBi5DcRsbNOYJG2T8j+OXK5OPjgqSIL9e2LlYKMm
         E6jBgwWnOtQ1n28ITAzOc9zWCcVIXOkz/DmXY2lcbUsRKz5yMVS59ue8TFiNaZ72DAS/
         mey4HI5P1ReXAsJ8bNndgX98pMZXNuvfQyLKjH8LS31IW3AfyzhvNold+rai1GTNyc8r
         ysHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QY6i0yhlosYKBzQSKH6aCBy2mSO5xg+k21z4/T/g/QU=;
        b=sMnhT9NYe7lhaJqH5p2yS9cxIBOMV6v1uU9fO8X4FpO+TP2Tb6Cv7e3VeQd8phQMqJ
         HnU2uxEynMadx5taxb9fR1XdAwaH2Nk6BJN9uiHCizU9z+GCk4UPmGJh8FWyQ3tY5afY
         6R9fOvHSZPie1vjjTVCQ/sKnnohM2R1v1nc+wVTo2BF48QT6o19VTfbDJLqxXSkYQsfG
         fuvbV33EmEs3GNiOEYPrlc9cjsRkUHBykjKqhR4/j6u6anzvEID3J4NdywMQVe6DNgth
         /t/2VHGvoBQNXJnMfPbxpwbDukBKINuq6vQtpXQ+wGBFcWTm0gEFe5zijM0Lpvad1VFn
         szDA==
X-Gm-Message-State: APjAAAU7+idV4hJ7ixlUDG5BHAKx2Zt+3e5hpXB1EQEKJwW6L9qZCn9i
        E0oj2yZPnchwHH6nyauKE4TR1Q==
X-Google-Smtp-Source: APXvYqxGA1nZyul0VfHAaNroAGuQ2k9Yaas0jtGOC35rwVfjQ8fqFhDRbECVetl1ZMn+hm+FtIhQTw==
X-Received: by 2002:a17:90a:a410:: with SMTP id y16mr22740984pjp.62.1560190936876;
        Mon, 10 Jun 2019 11:22:16 -0700 (PDT)
Received: from ?IPv6:2600:1010:b007:4b59:4135:ea27:71a0:a536? ([2600:1010:b007:4b59:4135:ea27:71a0:a536])
        by smtp.gmail.com with ESMTPSA id d35sm10598703pgm.31.2019.06.10.11.22.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 11:22:15 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC][PATCH 00/13] Mount, FS, Block and Keyrings notifications [ver #4]
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <dac74580-5b48-86e4-8222-cac29a9f541d@schaufler-ca.com>
Date:   Mon, 10 Jun 2019 11:22:13 -0700
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <E0925E1F-E5F2-4457-8704-47B6E64FE3F3@amacapital.net>
References: <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk> <be966d9c-e38d-7a30-8d80-fad5f25ab230@tycho.nsa.gov> <0cf7a49d-85f6-fba9-62ec-a378e0b76adf@schaufler-ca.com> <CALCETrX5O18q2=dUeC=hEtK2=t5KQpGBy9XveHxFw36OqkbNOg@mail.gmail.com> <dac74580-5b48-86e4-8222-cac29a9f541d@schaufler-ca.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> On Jun 10, 2019, at 11:01 AM, Casey Schaufler <casey@schaufler-ca.com> wro=
te:
>=20
>> On 6/10/2019 9:42 AM, Andy Lutomirski wrote:
>>> On Mon, Jun 10, 2019 at 9:34 AM Casey Schaufler <casey@schaufler-ca.com>=
 wrote:
>>>> On 6/10/2019 8:21 AM, Stephen Smalley wrote:
>>>>> On 6/7/19 10:17 AM, David Howells wrote:
>>>>> Hi Al,
>>>>>=20
>>>>> Here's a set of patches to add a general variable-length notification q=
ueue
>>>>> concept and to add sources of events for:
>>>>>=20
>>>>>  (1) Mount topology events, such as mounting, unmounting, mount expiry=
,
>>>>>      mount reconfiguration.
>>>>>=20
>>>>>  (2) Superblock events, such as R/W<->R/O changes, quota overrun and I=
/O
>>>>>      errors (not complete yet).
>>>>>=20
>>>>>  (3) Key/keyring events, such as creating, linking and removal of keys=
.
>>>>>=20
>>>>>  (4) General device events (single common queue) including:
>>>>>=20
>>>>>      - Block layer events, such as device errors
>>>>>=20
>>>>>      - USB subsystem events, such as device/bus attach/remove, device
>>>>>        reset, device errors.
>>>>>=20
>>>>> One of the reasons for this is so that we can remove the issue of proc=
esses
>>>>> having to repeatedly and regularly scan /proc/mounts, which has proven=
 to
>>>>> be a system performance problem.  To further aid this, the fsinfo() sy=
scall
>>>>> on which this patch series depends, provides a way to access superbloc=
k and
>>>>> mount information in binary form without the need to parse /proc/mount=
s.
>>>>>=20
>>>>>=20
>>>>> LSM support is included, but controversial:
>>>>>=20
>>>>>  (1) The creds of the process that did the fput() that reduced the ref=
count
>>>>>      to zero are cached in the file struct.
>>>>>=20
>>>>>  (2) __fput() overrides the current creds with the creds from (1) whil=
st
>>>>>      doing the cleanup, thereby making sure that the creds seen by the=

>>>>>      destruction notification generated by mntput() appears to come fr=
om
>>>>>      the last fputter.
>>>>>=20
>>>>>  (3) security_post_notification() is called for each queue that we mig=
ht
>>>>>      want to post a notification into, thereby allowing the LSM to pre=
vent
>>>>>      covert communications.
>>>>>=20
>>>>>  (?) Do I need to add security_set_watch(), say, to rule on whether a w=
atch
>>>>>      may be set in the first place?  I might need to add a variant per=

>>>>>      watch-type.
>>>>>=20
>>>>>  (?) Do I really need to keep track of the process creds in which an
>>>>>      implicit object destruction happened?  For example, imagine you c=
reate
>>>>>      an fd with fsopen()/fsmount().  It is marked to dissolve the moun=
t it
>>>>>      refers to on close unless move_mount() clears that flag.  Now, im=
agine
>>>>>      someone looking at that fd through procfs at the same time as you=
 exit
>>>>>      due to an error.  The LSM sees the destruction notification come f=
rom
>>>>>      the looker if they happen to do their fput() after yours.
>>>> I remain unconvinced that (1), (2), (3), and the final (?) above are a g=
ood idea.
>>>>=20
>>>> For SELinux, I would expect that one would implement a collection of pe=
r watch-type WATCH permission checks on the target object (or to some well-d=
efined object label like the kernel SID if there is no object) that allow re=
ceipt of all notifications of that watch-type for objects related to the tar=
get object, where "related to" is defined per watch-type.
>>>>=20
>>>> I wouldn't expect SELinux to implement security_post_notification() at a=
ll.  I can't see how one can construct a meaningful, stable policy for it.  I=
'd argue that the triggering process is not posting the notification; the ke=
rnel is posting the notification and the watcher has been authorized to rece=
ive it.
>>> I cannot agree. There is an explicit action by a subject that results
>>> in information being delivered to an object. Just like a signal or a
>>> UDP packet delivery. Smack handles this kind of thing just fine. The
>>> internal mechanism that results in the access is irrelevant from
>>> this viewpoint. I can understand how a mechanism like SELinux that
>>> works on finer granularity might view it differently.
>> I think you really need to give an example of a coherent policy that
>> needs this.
>=20
> I keep telling you, and you keep ignoring what I say.
>=20
>>  As it stands, your analogy seems confusing.
>=20
> It's pretty simple. I have given both the abstract
> and examples.

You gave the /dev/null example, which is inapplicable to this patchset.

>=20
>>  If someone
>> changes the system clock, we don't restrict who is allowed to be
>> notified (via, for example, TFD_TIMER_CANCEL_ON_SET) that the clock
>> was changed based on who changed the clock.
>=20
> That's right. The system clock is not an object that
> unprivileged processes can modify. In fact, it is not
> an object at all. If you care to look, you will see that
> Smack does nothing with the clock.

And this is different from the mount tree how?

>=20
>>  Similarly, if someone
>> tries to receive a packet on a socket, we check whether they have the
>> right to receive on that socket (from the endpoint in question) and,
>> if the sender is local, whether the sender can send to that socket.
>> We do not check whether the sender can send to the receiver.
>=20
> Bzzzt! Smack sure does.

This seems dubious. I=E2=80=99m still trying to get you to explain to a non-=
Smack person why this makes sense.

>=20
>> The signal example is inapplicable.
>=20
> =46rom a modeling viewpoint the actions are identical.

This seems incorrect to me and, I think, to most everyone else reading this.=
 Can you explain?

In SELinux-ese, when you write to a file, the subject is the writer and the o=
bject is the file.  When you send a signal to a process, the object is the t=
arget process.=
