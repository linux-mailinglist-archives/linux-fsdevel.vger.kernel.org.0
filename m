Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD6F2312F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 12:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbfETKUA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 06:20:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46656 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728819AbfETKT5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 06:19:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id r7so13884958wrr.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2019 03:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=NwlnnO8ESeSxRw5I4cSTLQD2eWjIGGdF4E5YUL4sVio=;
        b=fAeOqnI2tkRWtCPWlJF7KOL2rZ6fIISdVjNIqB3Lv7Bxh9XfXkfPmpxvPqEkR4X54I
         aFuP6tqomqaxs9D49vDgbyzY7OpGuYSdY0CGjUoCDGqsw0p+TRLAPtIgZyehV+DwB5tI
         Bdj3K4ZYQuz+wThYUbsCAurjUcCpUIQfG+4KhbwkriHMYfVbJVZjpRcHQftlaejPYI+8
         WZFnR+zW4uwmMal5Dl2kI3OUy2OVPKH9Y60RU2o6htHTKnwvOPHx/dulutbwccFAPS9T
         9ct51ALpTxHBpEogLDVOc+PY4PajGm90K1Fd/aHl+pGbH0TL1aGLvyztnZ2EJUntDwt7
         BaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=NwlnnO8ESeSxRw5I4cSTLQD2eWjIGGdF4E5YUL4sVio=;
        b=ZbcEA8ntWeQsCWrHVgvmZXyJamjWjJCxP3V5+aBqlBG6ETmeT4KfwD8LQNZQixt1IW
         QJkQnDA/EKhJZdZT/4UA797+RhbPdW5hCyu+Ab8cd+E7XTs6lz/RBjdow0r6rfQW3stJ
         Q6g6tw8ysocP+Ji8rOqsBYD4c6eCiaB/UNn639E4DRfyKxWMH0RJamFjbcKEBy1IxoWN
         0VroevD89tHXHUz9l8huZyjYxyKiqiNysTfGU4f8+aFhIe2hpffOV8qkn/0+gCWJGHK2
         se+PQGEd11oI7XSW7N5+TbgWarwW8+aXZxlLhEK4xz8cISQNU76qLBabNYAebLmrW8lJ
         JY5Q==
X-Gm-Message-State: APjAAAXzcBshja3dgdwQTw1G0c0qvw8Fq0g4P78s8wDu39/x10EBiCr1
        vmWjv4M/as0M8V3sRpAa2j/f+Q==
X-Google-Smtp-Source: APXvYqx52K77ouRWnzbrZV/5ooOeTACW32zdewSNSqifd0mODVN3MQr613HERnftnokuquE4p6GB+w==
X-Received: by 2002:adf:9c0a:: with SMTP id f10mr4504745wrc.248.1558347594134;
        Mon, 20 May 2019 03:19:54 -0700 (PDT)
Received: from [192.168.0.100] ([88.147.73.106])
        by smtp.gmail.com with ESMTPSA id s11sm31793721wrb.71.2019.05.20.03.19.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 03:19:52 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
Message-Id: <07D11833-8285-49C2-943D-E4C1D23E8859@linaro.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_0E3633DD-4248-4655-9843-6C90BDFC002D";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: CFQ idling kills I/O performance on ext4 with blkio cgroup
 controller
Date:   Mon, 20 May 2019 12:19:50 +0200
In-Reply-To: <46c6a4be-f567-3621-2e16-0e341762b828@csail.mit.edu>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-ext4@vger.kernel.org, cgroups@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        jmoyer@redhat.com, tytso@mit.edu, amakhalov@vmware.com,
        anishs@vmware.com, srivatsab@vmware.com
To:     "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
References: <8d72fcf7-bbb4-2965-1a06-e9fc177a8938@csail.mit.edu>
 <1812E450-14EF-4D5A-8F31-668499E13652@linaro.org>
 <46c6a4be-f567-3621-2e16-0e341762b828@csail.mit.edu>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_0E3633DD-4248-4655-9843-6C90BDFC002D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> Il giorno 18 mag 2019, alle ore 22:50, Srivatsa S. Bhat =
<srivatsa@csail.mit.edu> ha scritto:
>=20
> On 5/18/19 11:39 AM, Paolo Valente wrote:
>> I've addressed these issues in my last batch of improvements for BFQ,
>> which landed in the upcoming 5.2. If you give it a try, and still see
>> the problem, then I'll be glad to reproduce it, and hopefully fix it
>> for you.
>>=20
>=20
> Hi Paolo,
>=20
> Thank you for looking into this!
>=20
> I just tried current mainline at commit 72cf0b07, but unfortunately
> didn't see any improvement:
>=20
> dd if=3D/dev/zero of=3D/root/test.img bs=3D512 count=3D10000 =
oflag=3Ddsync
>=20
> With mq-deadline, I get:
>=20
> 5120000 bytes (5.1 MB, 4.9 MiB) copied, 3.90981 s, 1.3 MB/s
>=20
> With bfq, I get:
> 5120000 bytes (5.1 MB, 4.9 MiB) copied, 84.8216 s, 60.4 kB/s
>=20

Hi Srivatsa,
thanks for reproducing this on mainline.  I seem to have reproduced a
bonsai-tree version of this issue.  Before digging into the block
trace, I'd like to ask you for some feedback.

First, in my test, the total throughput of the disk happens to be
about 20 times as high as that enjoyed by dd, regardless of the I/O
scheduler.  I guess this massive overhead is normal with dsync, but
I'd like know whether it is about the same on your side.  This will
help me understand whether I'll actually be analyzing about the same
problem as yours.

Second, the commands I used follow.  Do they implement your test case
correctly?

[root@localhost tmp]# mkdir /sys/fs/cgroup/blkio/testgrp
[root@localhost tmp]# echo $BASHPID > =
/sys/fs/cgroup/blkio/testgrp/cgroup.procs
[root@localhost tmp]# cat /sys/block/sda/queue/scheduler
[mq-deadline] bfq none
[root@localhost tmp]# dd if=3D/dev/zero of=3D/root/test.img bs=3D512 =
count=3D10000 oflag=3Ddsync
10000+0 record dentro
10000+0 record fuori
5120000 bytes (5,1 MB, 4,9 MiB) copied, 14,6892 s, 349 kB/s
[root@localhost tmp]# echo bfq > /sys/block/sda/queue/scheduler
[root@localhost tmp]# dd if=3D/dev/zero of=3D/root/test.img bs=3D512 =
count=3D10000 oflag=3Ddsync
10000+0 record dentro
10000+0 record fuori
5120000 bytes (5,1 MB, 4,9 MiB) copied, 20,1953 s, 254 kB/s

Thanks,
Paolo

> Please let me know if any more info about my setup might be helpful.
>=20
> Thank you!
>=20
> Regards,
> Srivatsa
> VMware Photon OS
>=20
>>=20
>>> Il giorno 18 mag 2019, alle ore 00:16, Srivatsa S. Bhat =
<srivatsa@csail.mit.edu> ha scritto:
>>>=20
>>>=20
>>> Hi,
>>>=20
>>> One of my colleagues noticed upto 10x - 30x drop in I/O throughput
>>> running the following command, with the CFQ I/O scheduler:
>>>=20
>>> dd if=3D/dev/zero of=3D/root/test.img bs=3D512 count=3D10000 =
oflags=3Ddsync
>>>=20
>>> Throughput with CFQ: 60 KB/s
>>> Throughput with noop or deadline: 1.5 MB/s - 2 MB/s
>>>=20
>>> I spent some time looking into it and found that this is caused by =
the
>>> undesirable interaction between 4 different components:
>>>=20
>>> - blkio cgroup controller enabled
>>> - ext4 with the jbd2 kthread running in the root blkio cgroup
>>> - dd running on ext4, in any other blkio cgroup than that of jbd2
>>> - CFQ I/O scheduler with defaults for slice_idle and group_idle
>>>=20
>>>=20
>>> When docker is enabled, systemd creates a blkio cgroup called
>>> system.slice to run system services (and docker) under it, and a
>>> separate blkio cgroup called user.slice for user processes. So, when
>>> dd is invoked, it runs under user.slice.
>>>=20
>>> The dd command above includes the dsync flag, which performs an
>>> fdatasync after every write to the output file. Since dd is writing =
to
>>> a file on ext4, jbd2 will be active, committing transactions
>>> corresponding to those fdatasync requests from dd. (In other words, =
dd
>>> depends on jdb2, in order to make forward progress). But jdb2 being =
a
>>> kernel thread, runs in the root blkio cgroup, as opposed to dd, =
which
>>> runs under user.slice.
>>>=20
>>> Now, if the I/O scheduler in use for the underlying block device is
>>> CFQ, then its inter-queue/inter-group idling takes effect (via the
>>> slice_idle and group_idle parameters, both of which default to 8ms).
>>> Therefore, everytime CFQ switches between processing requests from =
dd
>>> vs jbd2, this 8ms idle time is injected, which slows down the =
overall
>>> throughput tremendously!
>>>=20
>>> To verify this theory, I tried various experiments, and in all =
cases,
>>> the 4 pre-conditions mentioned above were necessary to reproduce =
this
>>> performance drop. For example, if I used an XFS filesystem (which
>>> doesn't use a separate kthread like jbd2 for journaling), or if I =
dd'ed
>>> directly to a block device, I couldn't reproduce the performance
>>> issue. Similarly, running dd in the root blkio cgroup (where jbd2
>>> runs) also gets full performance; as does using the noop or deadline
>>> I/O schedulers; or even CFQ itself, with slice_idle and group_idle =
set
>>> to zero.
>>>=20
>>> These results were reproduced on a Linux VM (kernel v4.19) on ESXi,
>>> both with virtualized storage as well as with disk pass-through,
>>> backed by a rotational hard disk in both cases. The same problem was
>>> also seen with the BFQ I/O scheduler in kernel v5.1.
>>>=20
>>> Searching for any earlier discussions of this problem, I found an =
old
>>> thread on LKML that encountered this behavior [1], as well as a =
docker
>>> github issue [2] with similar symptoms (mentioned later in the
>>> thread).
>>>=20
>>> So, I'm curious to know if this is a well-understood problem and if
>>> anybody has any thoughts on how to fix it.
>>>=20
>>> Thank you very much!
>>>=20
>>>=20
>>> [1]. https://lkml.org/lkml/2015/11/19/359
>>>=20
>>> [2]. https://github.com/moby/moby/issues/21485
>>>    https://github.com/moby/moby/issues/21485#issuecomment-222941103
>>>=20
>>> Regards,
>>> Srivatsa
>>=20
>=20


--Apple-Mail=_0E3633DD-4248-4655-9843-6C90BDFC002D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEpYoduex+OneZyvO8OAkCLQGo9oMFAlzif0YACgkQOAkCLQGo
9oM5xQ//dvsiY41qM7W/y79e3ViCl5oabT79tXKDHAGnXMLPWIScoMuI0CpONuBA
hRvnLCO8Wvwl8aXbJzfVnv0J5XkBCiRlIEBf2XXvhgXWjwSOIRtLXoKfnyZ26h1Z
GGrC8q4pY+s/2d8wUanLHlOo+ExsJoU+5xWzL9Wx45XafzaG88aOl/yCb8mGgw2S
/kkSWIVGMn930yRgGqr4b+dNqivNg2euqSRpjfhRNm0hCkM7q2r1En2Xyef5eEeP
3d1SO+qQo6kIylYEtu8Y6foZZfqlBQLWUV/oCdaQ0Os77Z1cqfjIxUOLkkEU+QKi
gHSXwCoM/S1pOL74o7TkDbWoL4MpyK9AaatNSULRxE1yWDYF2dd/31Tc/ZLcutYE
VYG0SWUXx2diM5ccCWVedHEHhs9VVxUP4ftipt6tAzdsyT0RCxTwQPapn4NToMUj
3DlFpM8DUdYNuiVrQhpr3/+gB0OJ64XC3bgQM80rzFO2AWuGmydlUc6Tle8AqNNG
qAHUZ25+VOBwPrOptJOH249yWYrSgT0FHqWEppNmCi0JyVLjbOJuLT06/IT7q2AW
Ob5N/G2PxFiXuCDLeJlC7UIl8Ua7Sg5v+MmJVDgL0qDUctZvJHNZZdMbeedk1ZHH
XH0SX/3JDNrmO2XdjIrzAWSdQX3Ev1Yv2jOkHnMAs6Na+1H+vf4=
=lPeU
-----END PGP SIGNATURE-----

--Apple-Mail=_0E3633DD-4248-4655-9843-6C90BDFC002D--
