Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2186256D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 19:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbfEURiM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 May 2019 13:38:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36955 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729055AbfEURiM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 May 2019 13:38:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id e15so19598201wrs.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2019 10:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=UBIejNeZ4OdPPtoaGStfeKIEHbPD4bToSGT7uNUVFtY=;
        b=gX+3zlfm5h1bGIS7n1PD7s4Us3+KLjYjZa8/RuKO8eHHGJuBq5R2i3X2hKvsfOS+xH
         ugIDZye4x4ivdSbAISo/gfFKjbNyVfm6zCP2GZKiwYPZJfGNDQRuFtEeZ9ZyXZcTvnlK
         iJUdF/VDDE/1BvbFKBkDuJKqja8KSFwH2TLuuwMAdGruq4PhV+zi4JuS3W6FokQf6KZN
         daB+g08C4HcM58zEIHyPdNhUc2mvyzFAt4kCwmusvgxofEVEhcspubDxn3KnINvanD+1
         o0STYyRa07kkGspwtdUVKdoBZ47sT6FeTFn79lw6qZUlAohRy0mcvpXEND0o8GoOJ55H
         cyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=UBIejNeZ4OdPPtoaGStfeKIEHbPD4bToSGT7uNUVFtY=;
        b=tH93BR25s1q/Xirymvnfj6u5NWROyXxgXGk1XT4coAoXBDyZ8pm9cSxOGFsF8DogrZ
         oPv9EjVY+KTVeUZQanF8Gs1z1dBDpUyWBhKta96VOEqDB9vorwC4YpAcZq3mjSi6RWru
         leriqN0LfXfSS2g1ILFyh9G5xlPJBpLe77MQMKlNTmiNdOoMBbQTCsY0TZ/L4hsoCUPn
         ljIpM69iCy0WoXh4JaAYhCPonEt0eZ3MnL1+gbjhXT2IT0OAK+Xzrlzv0qzw8FXbrTKI
         kgLtF2rh3rpgqFJD2eOd7w1DbTRPC0UpaTKF8Mwq21XxkJPhuy16qGu+HHcPH7kpAIOk
         GeLg==
X-Gm-Message-State: APjAAAVD4S1wkRCOik7Kt6ZFVXPuQxZ4aZFEUXnCHE+JK5RmHNhigcty
        /LEJwFPB7NLC/Ppt1eSlC8X5+Q==
X-Google-Smtp-Source: APXvYqxoIUkmmAn+47o5xihq12Qc0KdVKAoekiQtyUr+kKPDVhAITjqoHHTGnA/syqFWisiSUlZCMA==
X-Received: by 2002:a5d:6812:: with SMTP id w18mr5936080wru.16.1558460289795;
        Tue, 21 May 2019 10:38:09 -0700 (PDT)
Received: from [192.168.0.101] (88-147-35-136.dyn.eolo.it. [88.147.35.136])
        by smtp.gmail.com with ESMTPSA id g2sm23816718wru.37.2019.05.21.10.38.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 10:38:08 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
Message-Id: <FC24E25F-4578-454D-AE2B-8D8D352478D8@linaro.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_7F6A5A1C-69C3-4FEB-A2C3-3069AA8CC731";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: CFQ idling kills I/O performance on ext4 with blkio cgroup
 controller
Date:   Tue, 21 May 2019 19:38:07 +0200
In-Reply-To: <2CB39B34-21EE-4A95-A073-8633CF2D187C@linaro.org>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-ext4@vger.kernel.org, cgroups@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        jmoyer@redhat.com, Theodore Ts'o <tytso@mit.edu>,
        amakhalov@vmware.com, anishs@vmware.com, srivatsab@vmware.com
To:     "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
References: <8d72fcf7-bbb4-2965-1a06-e9fc177a8938@csail.mit.edu>
 <1812E450-14EF-4D5A-8F31-668499E13652@linaro.org>
 <46c6a4be-f567-3621-2e16-0e341762b828@csail.mit.edu>
 <07D11833-8285-49C2-943D-E4C1D23E8859@linaro.org>
 <A0DFE635-EFEC-4670-AD70-5D813E170BEE@linaro.org>
 <5B6570A2-541A-4CF8-98E0-979EA6E3717D@linaro.org>
 <2CB39B34-21EE-4A95-A073-8633CF2D187C@linaro.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_7F6A5A1C-69C3-4FEB-A2C3-3069AA8CC731
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> Il giorno 21 mag 2019, alle ore 18:21, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>=20
>=20
>> Il giorno 21 mag 2019, alle ore 15:20, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>>=20
>>=20
>>=20
>>> Il giorno 21 mag 2019, alle ore 13:25, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>>>=20
>>>=20
>>>=20
>>>> Il giorno 20 mag 2019, alle ore 12:19, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>>>>=20
>>>>=20
>>>>=20
>>>>> Il giorno 18 mag 2019, alle ore 22:50, Srivatsa S. Bhat =
<srivatsa@csail.mit.edu> ha scritto:
>>>>>=20
>>>>> On 5/18/19 11:39 AM, Paolo Valente wrote:
>>>>>> I've addressed these issues in my last batch of improvements for =
BFQ,
>>>>>> which landed in the upcoming 5.2. If you give it a try, and still =
see
>>>>>> the problem, then I'll be glad to reproduce it, and hopefully fix =
it
>>>>>> for you.
>>>>>>=20
>>>>>=20
>>>>> Hi Paolo,
>>>>>=20
>>>>> Thank you for looking into this!
>>>>>=20
>>>>> I just tried current mainline at commit 72cf0b07, but =
unfortunately
>>>>> didn't see any improvement:
>>>>>=20
>>>>> dd if=3D/dev/zero of=3D/root/test.img bs=3D512 count=3D10000 =
oflag=3Ddsync
>>>>>=20
>>>>> With mq-deadline, I get:
>>>>>=20
>>>>> 5120000 bytes (5.1 MB, 4.9 MiB) copied, 3.90981 s, 1.3 MB/s
>>>>>=20
>>>>> With bfq, I get:
>>>>> 5120000 bytes (5.1 MB, 4.9 MiB) copied, 84.8216 s, 60.4 kB/s
>>>>>=20
>>>>=20
>>>> Hi Srivatsa,
>>>> thanks for reproducing this on mainline.  I seem to have reproduced =
a
>>>> bonsai-tree version of this issue.
>>>=20
>>> Hi again Srivatsa,
>>> I've analyzed the trace, and I've found the cause of the loss of
>>> throughput in on my side.  To find out whether it is the same cause =
as
>>> on your side, I've prepared a script that executes your test and =
takes
>>> a trace during the test.  If ok for you, could you please
>>> - change the value for the DEVS parameter in the attached script, if
>>> needed
>>> - execute the script
>>> - send me the trace file that the script will leave in your working
>>> dir
>>>=20
>>=20
>> Sorry, I forgot to add that I also need you to, first, apply the
>> attached patch (it will make BFQ generate the log I need).
>>=20
>=20
> Sorry again :) This time for attaching one more patch.  This is
> basically a blind fix attempt, based on what I see in my VM.
>=20
> So, instead of only sending me a trace, could you please:
> 1) apply this new patch on top of the one I attached in my previous =
email
> 2) repeat your test and report results

One last thing (I swear!): as you can see from my script, I tested the
case low_latency=3D0 so far.  So please, for the moment, do your test
with low_latency=3D0.  You find the whole path to this parameter in,
e.g., my script.

Thanks,
Paolo

> 3) regardless of whether bfq performance improves, take a trace with
>   my script (I've attached a new version that doesn't risk to output =
an
>   annoying error message as the previous one)
>=20
> Thanks,
> Paolo
>=20
> <dsync_test.sh><0001-block-bfq-boost-injection.patch.gz>
>=20
>> Thanks,
>> Paolo
>>=20
>> <0001-block-bfq-add-logs-and-BUG_ONs.patch.gz>
>>=20
>>> Looking forward to your trace,
>>> Paolo
>>>=20
>>> <dsync_test.sh>
>>>> Before digging into the block
>>>> trace, I'd like to ask you for some feedback.
>>>>=20
>>>> First, in my test, the total throughput of the disk happens to be
>>>> about 20 times as high as that enjoyed by dd, regardless of the I/O
>>>> scheduler.  I guess this massive overhead is normal with dsync, but
>>>> I'd like know whether it is about the same on your side. This will
>>>> help me understand whether I'll actually be analyzing about the =
same
>>>> problem as yours.
>>>>=20
>>>> Second, the commands I used follow.  Do they implement your test =
case
>>>> correctly?
>>>>=20
>>>> [root@localhost tmp]# mkdir /sys/fs/cgroup/blkio/testgrp
>>>> [root@localhost tmp]# echo $BASHPID > =
/sys/fs/cgroup/blkio/testgrp/cgroup.procs
>>>> [root@localhost tmp]# cat /sys/block/sda/queue/scheduler
>>>> [mq-deadline] bfq none
>>>> [root@localhost tmp]# dd if=3D/dev/zero of=3D/root/test.img bs=3D512 =
count=3D10000 oflag=3Ddsync
>>>> 10000+0 record dentro
>>>> 10000+0 record fuori
>>>> 5120000 bytes (5,1 MB, 4,9 MiB) copied, 14,6892 s, 349 kB/s
>>>> [root@localhost tmp]# echo bfq > /sys/block/sda/queue/scheduler
>>>> [root@localhost tmp]# dd if=3D/dev/zero of=3D/root/test.img bs=3D512 =
count=3D10000 oflag=3Ddsync
>>>> 10000+0 record dentro
>>>> 10000+0 record fuori
>>>> 5120000 bytes (5,1 MB, 4,9 MiB) copied, 20,1953 s, 254 kB/s
>>>>=20
>>>> Thanks,
>>>> Paolo
>>>>=20
>>>>> Please let me know if any more info about my setup might be =
helpful.
>>>>>=20
>>>>> Thank you!
>>>>>=20
>>>>> Regards,
>>>>> Srivatsa
>>>>> VMware Photon OS
>>>>>=20
>>>>>>=20
>>>>>>> Il giorno 18 mag 2019, alle ore 00:16, Srivatsa S. Bhat =
<srivatsa@csail.mit.edu> ha scritto:
>>>>>>>=20
>>>>>>>=20
>>>>>>> Hi,
>>>>>>>=20
>>>>>>> One of my colleagues noticed upto 10x - 30x drop in I/O =
throughput
>>>>>>> running the following command, with the CFQ I/O scheduler:
>>>>>>>=20
>>>>>>> dd if=3D/dev/zero of=3D/root/test.img bs=3D512 count=3D10000 =
oflags=3Ddsync
>>>>>>>=20
>>>>>>> Throughput with CFQ: 60 KB/s
>>>>>>> Throughput with noop or deadline: 1.5 MB/s - 2 MB/s
>>>>>>>=20
>>>>>>> I spent some time looking into it and found that this is caused =
by the
>>>>>>> undesirable interaction between 4 different components:
>>>>>>>=20
>>>>>>> - blkio cgroup controller enabled
>>>>>>> - ext4 with the jbd2 kthread running in the root blkio cgroup
>>>>>>> - dd running on ext4, in any other blkio cgroup than that of =
jbd2
>>>>>>> - CFQ I/O scheduler with defaults for slice_idle and group_idle
>>>>>>>=20
>>>>>>>=20
>>>>>>> When docker is enabled, systemd creates a blkio cgroup called
>>>>>>> system.slice to run system services (and docker) under it, and a
>>>>>>> separate blkio cgroup called user.slice for user processes. So, =
when
>>>>>>> dd is invoked, it runs under user.slice.
>>>>>>>=20
>>>>>>> The dd command above includes the dsync flag, which performs an
>>>>>>> fdatasync after every write to the output file. Since dd is =
writing to
>>>>>>> a file on ext4, jbd2 will be active, committing transactions
>>>>>>> corresponding to those fdatasync requests from dd. (In other =
words, dd
>>>>>>> depends on jdb2, in order to make forward progress). But jdb2 =
being a
>>>>>>> kernel thread, runs in the root blkio cgroup, as opposed to dd, =
which
>>>>>>> runs under user.slice.
>>>>>>>=20
>>>>>>> Now, if the I/O scheduler in use for the underlying block device =
is
>>>>>>> CFQ, then its inter-queue/inter-group idling takes effect (via =
the
>>>>>>> slice_idle and group_idle parameters, both of which default to =
8ms).
>>>>>>> Therefore, everytime CFQ switches between processing requests =
from dd
>>>>>>> vs jbd2, this 8ms idle time is injected, which slows down the =
overall
>>>>>>> throughput tremendously!
>>>>>>>=20
>>>>>>> To verify this theory, I tried various experiments, and in all =
cases,
>>>>>>> the 4 pre-conditions mentioned above were necessary to reproduce =
this
>>>>>>> performance drop. For example, if I used an XFS filesystem =
(which
>>>>>>> doesn't use a separate kthread like jbd2 for journaling), or if =
I dd'ed
>>>>>>> directly to a block device, I couldn't reproduce the performance
>>>>>>> issue. Similarly, running dd in the root blkio cgroup (where =
jbd2
>>>>>>> runs) also gets full performance; as does using the noop or =
deadline
>>>>>>> I/O schedulers; or even CFQ itself, with slice_idle and =
group_idle set
>>>>>>> to zero.
>>>>>>>=20
>>>>>>> These results were reproduced on a Linux VM (kernel v4.19) on =
ESXi,
>>>>>>> both with virtualized storage as well as with disk pass-through,
>>>>>>> backed by a rotational hard disk in both cases. The same problem =
was
>>>>>>> also seen with the BFQ I/O scheduler in kernel v5.1.
>>>>>>>=20
>>>>>>> Searching for any earlier discussions of this problem, I found =
an old
>>>>>>> thread on LKML that encountered this behavior [1], as well as a =
docker
>>>>>>> github issue [2] with similar symptoms (mentioned later in the
>>>>>>> thread).
>>>>>>>=20
>>>>>>> So, I'm curious to know if this is a well-understood problem and =
if
>>>>>>> anybody has any thoughts on how to fix it.
>>>>>>>=20
>>>>>>> Thank you very much!
>>>>>>>=20
>>>>>>>=20
>>>>>>> [1]. https://lkml.org/lkml/2015/11/19/359
>>>>>>>=20
>>>>>>> [2]. https://github.com/moby/moby/issues/21485
>>>>>>> https://github.com/moby/moby/issues/21485#issuecomment-222941103
>>>>>>>=20
>>>>>>> Regards,
>>>>>>> Srivatsa


--Apple-Mail=_7F6A5A1C-69C3-4FEB-A2C3-3069AA8CC731
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEpYoduex+OneZyvO8OAkCLQGo9oMFAlzkN38ACgkQOAkCLQGo
9oO0Ag//TLUAzWJ0+YY1cjuqGD0AJae9NI5G59AuqEhHOA7ia2LYZOGtw06b9xww
sJ71a/j+9WP2Qvt7kF6QbC14SflpOEOlgW1O7VRauJcO+3rVQThz8CNXVhA6HMom
21XGFEVuHp4rbkG1ad4FiF8jvXB0CdsdfpH6yCs+vlTtRsh4w8mhK21vJXc8VBhB
SFQoUTsh6xejvOqMGCQ4PhusA0YZNyjlCxCZcTcoGAFUOj2IOE5mPjfMkaTVWs4s
2k6G+zU0zqyxqrdxGwmwE0Sej4Mr2+PP0AuuIIMb2WsIs3x/AAsLIJ/sfL2ZJTYe
jQ4uMF9zpFt+ADf2z0yxjO1VoOtBjCj+0inWKR8lt/10Ha0JEt7KEFXI0AUwk+Z0
UGz/ge4cwWlzSBvJ+3OSq1r1iK+oCEn4G0KULRVTUjINT7+DTB0f3rPeBWzzgnhF
S/jQE7uJvtuVoRfb3D2dY4od7ZR225BJ4ndu3HXkImbll6jSMhnLNOLQV9NwFByg
BkBEnWMxhaZ/p/Gnu4nRztHuRbKTGx9QxbJ+gaGScsSK2UnVvD/mNIjvTgjN1bom
GlhgSR60ZRjXeSv9jiBISQQRkOGpmoxkmtNwfMg8iCaypaBOda0dMnVJGto8I/hZ
Y9Rg03+5XTRfVOiRJr87c2mqKuQ3xYXbqJC091uP+W751IQ5T9I=
=SP0T
-----END PGP SIGNATURE-----

--Apple-Mail=_7F6A5A1C-69C3-4FEB-A2C3-3069AA8CC731--
