Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E480625573
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 18:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbfEUQV5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 May 2019 12:21:57 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:42735 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfEUQV5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 May 2019 12:21:57 -0400
Received: by mail-wr1-f51.google.com with SMTP id l2so19317670wrb.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2019 09:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=X6jdBU6BWbHlLqeVdcMLZJlrgdM1TwHp5j/3UtFM64o=;
        b=r/w21dC0csQeCxFtwKWl4zkQhquNVEx1jGiSA498WuH9rbmQGIw6kP445Gny7VqUeW
         J4FrO6zrcKDM2JSb9nDXKfGgvvPg2mzvtBpHxuta+ZvGD7KOYOVnDAmM2s2uAuZJaJDE
         b9Ixt8LqIlR4yKkFqT1M8eBc4LHrpPNB4ZLD7KfUVsiNXMbD1WKaiyWvEierXYKd+dNn
         /b4qo/elsFOq1j5WXsVP9ogL7Z059zWlhyBDQ+vEgzqxa2+bGc6enMP54uiY2mb3FNcX
         s5FwKXHI5haMUOAOSUmwhaJffDITItfTSBQVzIMmbj9lRRoS5PDUqahzS882uGJ8b9hZ
         kcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=X6jdBU6BWbHlLqeVdcMLZJlrgdM1TwHp5j/3UtFM64o=;
        b=lDMzL8wpxZvqpNxo9eBc13YlZN1kJIGGjAHxAD+VqnzwOXbHOGL7MG9chXRp3NpDV0
         fYg95KE5YwO/KmRfh19xggjei72+PUXYSRYXuHIrZ2Hejk4E4J97NFgs9k+v7vU9TfQp
         +KzxtBuJKUDgcmhzSc+QQ4xvuH5QRe3AMrU50IwWINs+M9F/XyrKDhJbszVhziESg3Gp
         Ffwxft1K453B0dCYhOtq62k2IOd8M7HfvPGP8Qxo01XVLBYNmeYsAMKHimL3Jej7CsSs
         n2yajHIy2pFZrHd2Q4tMQWpFD0aacExObKIbhcVNo+LuLDz5qBG6wlrOpv4jzwZ3d8dy
         ZH7Q==
X-Gm-Message-State: APjAAAXIfZystbZdMVe89D9q3GiCj7uJ9Xb6ZgE5J61ejylplJ4DH3/X
        11CSW8gvTcG+eoPfWGfgVF+L66QIlCA=
X-Google-Smtp-Source: APXvYqxWBad4HgL7admuUa12ZaqWYiUvaWjFm8vRAEiVO1XM8bu7LFbHIV31KnEAG9FUilKIE9hU3g==
X-Received: by 2002:adf:f38a:: with SMTP id m10mr3969501wro.81.1558455714847;
        Tue, 21 May 2019 09:21:54 -0700 (PDT)
Received: from [192.168.0.101] (88-147-35-136.dyn.eolo.it. [88.147.35.136])
        by smtp.gmail.com with ESMTPSA id z8sm22644175wrh.48.2019.05.21.09.21.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 09:21:53 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
Message-Id: <2CB39B34-21EE-4A95-A073-8633CF2D187C@linaro.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_608522D7-0F7D-4DBD-81EA-41A5B6AD7229";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: CFQ idling kills I/O performance on ext4 with blkio cgroup
 controller
Date:   Tue, 21 May 2019 18:21:48 +0200
In-Reply-To: <5B6570A2-541A-4CF8-98E0-979EA6E3717D@linaro.org>
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
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_608522D7-0F7D-4DBD-81EA-41A5B6AD7229
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_19306D8E-630F-4723-A54B-681928BEBAD8"


--Apple-Mail=_19306D8E-630F-4723-A54B-681928BEBAD8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> Il giorno 21 mag 2019, alle ore 15:20, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>=20
>=20
>> Il giorno 21 mag 2019, alle ore 13:25, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>>=20
>>=20
>>=20
>>> Il giorno 20 mag 2019, alle ore 12:19, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>>>=20
>>>=20
>>>=20
>>>> Il giorno 18 mag 2019, alle ore 22:50, Srivatsa S. Bhat =
<srivatsa@csail.mit.edu> ha scritto:
>>>>=20
>>>> On 5/18/19 11:39 AM, Paolo Valente wrote:
>>>>> I've addressed these issues in my last batch of improvements for =
BFQ,
>>>>> which landed in the upcoming 5.2. If you give it a try, and still =
see
>>>>> the problem, then I'll be glad to reproduce it, and hopefully fix =
it
>>>>> for you.
>>>>>=20
>>>>=20
>>>> Hi Paolo,
>>>>=20
>>>> Thank you for looking into this!
>>>>=20
>>>> I just tried current mainline at commit 72cf0b07, but unfortunately
>>>> didn't see any improvement:
>>>>=20
>>>> dd if=3D/dev/zero of=3D/root/test.img bs=3D512 count=3D10000 =
oflag=3Ddsync
>>>>=20
>>>> With mq-deadline, I get:
>>>>=20
>>>> 5120000 bytes (5.1 MB, 4.9 MiB) copied, 3.90981 s, 1.3 MB/s
>>>>=20
>>>> With bfq, I get:
>>>> 5120000 bytes (5.1 MB, 4.9 MiB) copied, 84.8216 s, 60.4 kB/s
>>>>=20
>>>=20
>>> Hi Srivatsa,
>>> thanks for reproducing this on mainline.  I seem to have reproduced =
a
>>> bonsai-tree version of this issue.
>>=20
>> Hi again Srivatsa,
>> I've analyzed the trace, and I've found the cause of the loss of
>> throughput in on my side.  To find out whether it is the same cause =
as
>> on your side, I've prepared a script that executes your test and =
takes
>> a trace during the test.  If ok for you, could you please
>> - change the value for the DEVS parameter in the attached script, if
>> needed
>> - execute the script
>> - send me the trace file that the script will leave in your working
>> dir
>>=20
>=20
> Sorry, I forgot to add that I also need you to, first, apply the
> attached patch (it will make BFQ generate the log I need).
>=20

Sorry again :) This time for attaching one more patch.  This is
basically a blind fix attempt, based on what I see in my VM.

So, instead of only sending me a trace, could you please:
1) apply this new patch on top of the one I attached in my previous =
email
2) repeat your test and report results
3) regardless of whether bfq performance improves, take a trace with
   my script (I've attached a new version that doesn't risk to output an
   annoying error message as the previous one)

Thanks,
Paolo


--Apple-Mail=_19306D8E-630F-4723-A54B-681928BEBAD8
Content-Disposition: attachment;
	filename=dsync_test.sh
Content-Type: application/octet-stream;
	x-unix-mode=0744;
	name="dsync_test.sh"
Content-Transfer-Encoding: 7bit

#!/bin/bash

DEVS=sda # please set this parameter to the dev name for your test drive

TRACE=1

function init_tracing {
	if [ "$TRACE" == "1" ] ; then
		if [ ! -d /sys/kernel/debug/tracing ] ; then
			mount -t debugfs none /sys/kernel/debug
		fi
		echo nop > /sys/kernel/debug/tracing/current_tracer
		echo 500000 > /sys/kernel/debug/tracing/buffer_size_kb
		echo blk > /sys/kernel/debug/tracing/current_tracer
	fi
}

function set_tracing {
	if [ "$TRACE" == "1" ] ; then
	    if [[ -e /sys/kernel/debug/tracing/tracing_enabled && \
		$(cat /sys/kernel/debug/tracing/tracing_enabled) -ne $1 ]]; then
			echo "echo $1 > /sys/kernel/debug/tracing/tracing_enabled"
			echo $1 > /sys/kernel/debug/tracing/tracing_enabled
		fi
		dev=$(echo $DEVS | awk '{ print $1 }')
		if [[ -e /sys/block/$dev/trace/enable && \
			  $(cat /sys/block/$dev/trace/enable) -ne $1 ]]; then
		    echo "echo $1 > /sys/block/$dev/trace/enable"
		    echo $1 > /sys/block/$dev/trace/enable
		fi

		if [ "$1" == 0 ]; then
		    for cpu_path in /sys/kernel/debug/tracing/per_cpu/cpu?
		    do
			stat_file=$cpu_path/stats
			OVER=$(grep "overrun" $stat_file | \
			    grep -v "overrun: 0")
			if [ "$OVER" != "" ]; then
			    cpu=$(basename $cpu_path)
			    echo $OVER on $cpu, please increase buffer size!
			fi
		    done
		fi
	fi
}

init_tracing

mkdir /sys/fs/cgroup/blkio/testgrp
echo $BASHPID > /sys/fs/cgroup/blkio/testgrp/cgroup.procs
echo > /sys/kernel/debug/tracing/trace
set_tracing 1 
echo bfq > /sys/block/sda/queue/scheduler
cat /sys/block/sda/queue/scheduler
echo 0 > /sys/block/sda/queue/iosched/low_latency
dd if=/dev/zero of=/root/test.img bs=512 count=5000 oflag=dsync
set_tracing 0
echo 1 > /sys/block/sda/queue/iosched/low_latency
cp /sys/kernel/debug/tracing/trace .
echo $BASHPID > /sys/fs/cgroup/blkio/cgroup.procs 
rmdir /sys/fs/cgroup/blkio/testgrp

--Apple-Mail=_19306D8E-630F-4723-A54B-681928BEBAD8
Content-Disposition: attachment;
	filename=0001-block-bfq-boost-injection.patch.gz
Content-Type: application/x-gzip;
	x-unix-mode=0644;
	name="0001-block-bfq-boost-injection.patch.gz"
Content-Transfer-Encoding: base64

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
Leu/S3bHquEfAAA=
--Apple-Mail=_19306D8E-630F-4723-A54B-681928BEBAD8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> Thanks,
> Paolo
>=20
> <0001-block-bfq-add-logs-and-BUG_ONs.patch.gz>
>=20
>> Looking forward to your trace,
>> Paolo
>>=20
>> <dsync_test.sh>
>>> Before digging into the block
>>> trace, I'd like to ask you for some feedback.
>>>=20
>>> First, in my test, the total throughput of the disk happens to be
>>> about 20 times as high as that enjoyed by dd, regardless of the I/O
>>> scheduler.  I guess this massive overhead is normal with dsync, but
>>> I'd like know whether it is about the same on your side. This will
>>> help me understand whether I'll actually be analyzing about the same
>>> problem as yours.
>>>=20
>>> Second, the commands I used follow.  Do they implement your test =
case
>>> correctly?
>>>=20
>>> [root@localhost tmp]# mkdir /sys/fs/cgroup/blkio/testgrp
>>> [root@localhost tmp]# echo $BASHPID > =
/sys/fs/cgroup/blkio/testgrp/cgroup.procs
>>> [root@localhost tmp]# cat /sys/block/sda/queue/scheduler
>>> [mq-deadline] bfq none
>>> [root@localhost tmp]# dd if=3D/dev/zero of=3D/root/test.img bs=3D512 =
count=3D10000 oflag=3Ddsync
>>> 10000+0 record dentro
>>> 10000+0 record fuori
>>> 5120000 bytes (5,1 MB, 4,9 MiB) copied, 14,6892 s, 349 kB/s
>>> [root@localhost tmp]# echo bfq > /sys/block/sda/queue/scheduler
>>> [root@localhost tmp]# dd if=3D/dev/zero of=3D/root/test.img bs=3D512 =
count=3D10000 oflag=3Ddsync
>>> 10000+0 record dentro
>>> 10000+0 record fuori
>>> 5120000 bytes (5,1 MB, 4,9 MiB) copied, 20,1953 s, 254 kB/s
>>>=20
>>> Thanks,
>>> Paolo
>>>=20
>>>> Please let me know if any more info about my setup might be =
helpful.
>>>>=20
>>>> Thank you!
>>>>=20
>>>> Regards,
>>>> Srivatsa
>>>> VMware Photon OS
>>>>=20
>>>>>=20
>>>>>> Il giorno 18 mag 2019, alle ore 00:16, Srivatsa S. Bhat =
<srivatsa@csail.mit.edu> ha scritto:
>>>>>>=20
>>>>>>=20
>>>>>> Hi,
>>>>>>=20
>>>>>> One of my colleagues noticed upto 10x - 30x drop in I/O =
throughput
>>>>>> running the following command, with the CFQ I/O scheduler:
>>>>>>=20
>>>>>> dd if=3D/dev/zero of=3D/root/test.img bs=3D512 count=3D10000 =
oflags=3Ddsync
>>>>>>=20
>>>>>> Throughput with CFQ: 60 KB/s
>>>>>> Throughput with noop or deadline: 1.5 MB/s - 2 MB/s
>>>>>>=20
>>>>>> I spent some time looking into it and found that this is caused =
by the
>>>>>> undesirable interaction between 4 different components:
>>>>>>=20
>>>>>> - blkio cgroup controller enabled
>>>>>> - ext4 with the jbd2 kthread running in the root blkio cgroup
>>>>>> - dd running on ext4, in any other blkio cgroup than that of jbd2
>>>>>> - CFQ I/O scheduler with defaults for slice_idle and group_idle
>>>>>>=20
>>>>>>=20
>>>>>> When docker is enabled, systemd creates a blkio cgroup called
>>>>>> system.slice to run system services (and docker) under it, and a
>>>>>> separate blkio cgroup called user.slice for user processes. So, =
when
>>>>>> dd is invoked, it runs under user.slice.
>>>>>>=20
>>>>>> The dd command above includes the dsync flag, which performs an
>>>>>> fdatasync after every write to the output file. Since dd is =
writing to
>>>>>> a file on ext4, jbd2 will be active, committing transactions
>>>>>> corresponding to those fdatasync requests from dd. (In other =
words, dd
>>>>>> depends on jdb2, in order to make forward progress). But jdb2 =
being a
>>>>>> kernel thread, runs in the root blkio cgroup, as opposed to dd, =
which
>>>>>> runs under user.slice.
>>>>>>=20
>>>>>> Now, if the I/O scheduler in use for the underlying block device =
is
>>>>>> CFQ, then its inter-queue/inter-group idling takes effect (via =
the
>>>>>> slice_idle and group_idle parameters, both of which default to =
8ms).
>>>>>> Therefore, everytime CFQ switches between processing requests =
from dd
>>>>>> vs jbd2, this 8ms idle time is injected, which slows down the =
overall
>>>>>> throughput tremendously!
>>>>>>=20
>>>>>> To verify this theory, I tried various experiments, and in all =
cases,
>>>>>> the 4 pre-conditions mentioned above were necessary to reproduce =
this
>>>>>> performance drop. For example, if I used an XFS filesystem (which
>>>>>> doesn't use a separate kthread like jbd2 for journaling), or if I =
dd'ed
>>>>>> directly to a block device, I couldn't reproduce the performance
>>>>>> issue. Similarly, running dd in the root blkio cgroup (where jbd2
>>>>>> runs) also gets full performance; as does using the noop or =
deadline
>>>>>> I/O schedulers; or even CFQ itself, with slice_idle and =
group_idle set
>>>>>> to zero.
>>>>>>=20
>>>>>> These results were reproduced on a Linux VM (kernel v4.19) on =
ESXi,
>>>>>> both with virtualized storage as well as with disk pass-through,
>>>>>> backed by a rotational hard disk in both cases. The same problem =
was
>>>>>> also seen with the BFQ I/O scheduler in kernel v5.1.
>>>>>>=20
>>>>>> Searching for any earlier discussions of this problem, I found an =
old
>>>>>> thread on LKML that encountered this behavior [1], as well as a =
docker
>>>>>> github issue [2] with similar symptoms (mentioned later in the
>>>>>> thread).
>>>>>>=20
>>>>>> So, I'm curious to know if this is a well-understood problem and =
if
>>>>>> anybody has any thoughts on how to fix it.
>>>>>>=20
>>>>>> Thank you very much!
>>>>>>=20
>>>>>>=20
>>>>>> [1]. https://lkml.org/lkml/2015/11/19/359
>>>>>>=20
>>>>>> [2]. https://github.com/moby/moby/issues/21485
>>>>>> https://github.com/moby/moby/issues/21485#issuecomment-222941103
>>>>>>=20
>>>>>> Regards,
>>>>>> Srivatsa


--Apple-Mail=_19306D8E-630F-4723-A54B-681928BEBAD8--

--Apple-Mail=_608522D7-0F7D-4DBD-81EA-41A5B6AD7229
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEpYoduex+OneZyvO8OAkCLQGo9oMFAlzkJZwACgkQOAkCLQGo
9oOCdhAAlILYtAIpU+zvV62s9XLJyeDTWKGBDjDmrXrhvR0LHYpXA9h5wULmbtuN
sa8O5yXeWvlzBE0iZQrB4ABFv+20nIXSLYienwXQpg/CusHAwwlgk1KYVCPrYgTC
E4Rrt1bJbMAvL2T2sEUsvsnzO0lInhRB+iBXzJ4Muv4fkbkw99ODjNjDhfTCU6nX
1zqBYf3x3EhGniQ+Zi9yX4BMQUZOfymWMCW/28rM5y8AqrubrPh9aCNZNgdqTRAY
cqPYpKG6X0OthlzdM3QrvntGS8JcedtNACfS26eXXbBjKcqnJvY/+1Mq9xEAs4yL
/JRyr53ArDM0I3/1Ti/bHQnOc8sodc9Pb2LbP3QcA6MoJLOsOsvucsHGz+3Lis87
hTc0EAOoK5eoj75FI4rXLqOzzMIiAQU4R2Woyvmo8PLx4PUPsl2RNAigPktCdfV1
jr/UoVRwpSp0dZErKptq5LWNehlODU86eGH9QWRnv1d/sTu7mmEz3aAF7/mWvCWP
VW7ZJWw4vhszxM7bj8wp+56+3ONRMpfosjgT/GvqiEvJSBrHFkYNnWpRhaDOC732
nbxjIY3Xhk7YchGCHYghRBOavBHVn+2Vaq8zYBwWvjUMDWNIv23r+JSqpAbDekUH
Nh+I7wMgxr6LmtVSKDJeFRebXZLaIxseiZZys+QDr2LgyELCBGk=
=iRRe
-----END PGP SIGNATURE-----

--Apple-Mail=_608522D7-0F7D-4DBD-81EA-41A5B6AD7229--
