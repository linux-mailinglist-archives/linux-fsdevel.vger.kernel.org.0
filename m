Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E916F24DD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 13:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfEULZg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 May 2019 07:25:36 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:33921 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfEULZg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 May 2019 07:25:36 -0400
Received: by mail-wm1-f51.google.com with SMTP id j187so2091964wma.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2019 04:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=YVtUbiCVJuU9zLov0dx/GMIqSmYQFkP8m1oHN78Ed+w=;
        b=YtyiBo0xzYWRm93dnXC1IOV1GGSPpuvt9/OD3LMwwWMcRfV50EiOJiKCX/9WJm/kpf
         jtWkwA4GZn5exV5WuPSaJ9z3RBLGplJE51W941Uzybtdl/7Thd1s7O/zGw/OjXAqI7F2
         SpwOPx3hxFeDCJqlYct+QNpDPoVLA/aOfuqgsx4NjGRzE+dxIijbcQrh5qd6bMon+PQg
         E5Srqz+pnSj71+OpqKAdG6E/DmzH+EG+LovsYtduwyaqSRI9E0qYi97m55bLI0W2uxNc
         1jimuBBRLEz+Ru4sRymbE7KAzIya8pAhfUD/Yhkp6MtMu4aT/8s9XKg7QJsahPI9X/r5
         +h7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=YVtUbiCVJuU9zLov0dx/GMIqSmYQFkP8m1oHN78Ed+w=;
        b=Hhy+qJknIfPoDfRR9TgwEQe3haLCWrN/arUugZwFMycqy938iTSPQaQ1Gto4Fb0oym
         hqVMeOJIoGlOu2G2viMkwg8FnfQ+kXb4OBdK+F9J+kuoyPcDEKAVicSNV29Sjs/vHMcO
         F/z3yel1rRX/jrXL4dhH+6s0HeRj1abkQAjcRLSXccbntqGxW+M/KwHFo4ejp2/xN3ya
         EDgNB/7u/GpbvWsjt947+SWvsFlQ5RUo8FwSTiUPnrUdJ+y+rNiWMVB3q0r6u/q4GFPI
         O1jLfoGP2mirM98fVemx4Lu5k6w9oMwsNG4Wh2D8jcPSOAVqkSXLz42hHy5zRX4jpRNq
         zkgw==
X-Gm-Message-State: APjAAAVN54MB06YMQVyPXdReAALZmiiI0nSvuimMtPdbfC9kylX6mZ82
        FvIgBps5Zhd46fiHOZIQ742RXA==
X-Google-Smtp-Source: APXvYqzydcEHp+GclU0FJyV63jFC/+K9SjhJch4Wz/JeBBvppx3akP3bwgwHxANEsWHR86K0mYQk4w==
X-Received: by 2002:a7b:c001:: with SMTP id c1mr3268291wmb.49.1558437932197;
        Tue, 21 May 2019 04:25:32 -0700 (PDT)
Received: from [192.168.0.101] ([88.147.35.136])
        by smtp.gmail.com with ESMTPSA id 20sm3717068wmj.36.2019.05.21.04.25.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 04:25:31 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
Message-Id: <A0DFE635-EFEC-4670-AD70-5D813E170BEE@linaro.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_D52538F2-72FE-4CD4-B761-CCE9B24F2A35";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: CFQ idling kills I/O performance on ext4 with blkio cgroup
 controller
Date:   Tue, 21 May 2019 13:25:29 +0200
In-Reply-To: <07D11833-8285-49C2-943D-E4C1D23E8859@linaro.org>
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
 <07D11833-8285-49C2-943D-E4C1D23E8859@linaro.org>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_D52538F2-72FE-4CD4-B761-CCE9B24F2A35
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_21B10740-0BE7-4709-B8E2-677D365FE8FA"


--Apple-Mail=_21B10740-0BE7-4709-B8E2-677D365FE8FA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> Il giorno 20 mag 2019, alle ore 12:19, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>=20
>=20
>> Il giorno 18 mag 2019, alle ore 22:50, Srivatsa S. Bhat =
<srivatsa@csail.mit.edu> ha scritto:
>>=20
>> On 5/18/19 11:39 AM, Paolo Valente wrote:
>>> I've addressed these issues in my last batch of improvements for =
BFQ,
>>> which landed in the upcoming 5.2. If you give it a try, and still =
see
>>> the problem, then I'll be glad to reproduce it, and hopefully fix it
>>> for you.
>>>=20
>>=20
>> Hi Paolo,
>>=20
>> Thank you for looking into this!
>>=20
>> I just tried current mainline at commit 72cf0b07, but unfortunately
>> didn't see any improvement:
>>=20
>> dd if=3D/dev/zero of=3D/root/test.img bs=3D512 count=3D10000 =
oflag=3Ddsync
>>=20
>> With mq-deadline, I get:
>>=20
>> 5120000 bytes (5.1 MB, 4.9 MiB) copied, 3.90981 s, 1.3 MB/s
>>=20
>> With bfq, I get:
>> 5120000 bytes (5.1 MB, 4.9 MiB) copied, 84.8216 s, 60.4 kB/s
>>=20
>=20
> Hi Srivatsa,
> thanks for reproducing this on mainline.  I seem to have reproduced a
> bonsai-tree version of this issue.

Hi again Srivatsa,
I've analyzed the trace, and I've found the cause of the loss of
throughput in on my side.  To find out whether it is the same cause as
on your side, I've prepared a script that executes your test and takes
a trace during the test.  If ok for you, could you please
- change the value for the DEVS parameter in the attached script, if
  needed
- execute the script
- send me the trace file that the script will leave in your working
dir

Looking forward to your trace,
Paolo


--Apple-Mail=_21B10740-0BE7-4709-B8E2-677D365FE8FA
Content-Disposition: attachment;
	filename=dsync_test.sh
Content-Type: application/octet-stream;
	x-unix-mode=0744;
	name="dsync_test.sh"
Content-Transfer-Encoding: 7bit

#!/bin/bash

DEVS=sda # please set this parameter to the dev name for your test drive

SCHED=bfq
TRACE=1

function init_tracing {
	if [ "$TRACE" == "1" ] ; then
		if [ ! -d /sys/kernel/debug/tracing ] ; then
			mount -t debugfs none /sys/kernel/debug
		fi
		echo nop > /sys/kernel/debug/tracing/current_tracer
		echo 500000 > /sys/kernel/debug/tracing/buffer_size_kb
		echo "${SCHED}*" "__${SCHED}*" >\
			/sys/kernel/debug/tracing/set_ftrace_filter
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

--Apple-Mail=_21B10740-0BE7-4709-B8E2-677D365FE8FA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


>  Before digging into the block
> trace, I'd like to ask you for some feedback.
>=20
> First, in my test, the total throughput of the disk happens to be
> about 20 times as high as that enjoyed by dd, regardless of the I/O
> scheduler.  I guess this massive overhead is normal with dsync, but
> I'd like know whether it is about the same on your side.  This will
> help me understand whether I'll actually be analyzing about the same
> problem as yours.
>=20
> Second, the commands I used follow.  Do they implement your test case
> correctly?
>=20
> [root@localhost tmp]# mkdir /sys/fs/cgroup/blkio/testgrp
> [root@localhost tmp]# echo $BASHPID > =
/sys/fs/cgroup/blkio/testgrp/cgroup.procs
> [root@localhost tmp]# cat /sys/block/sda/queue/scheduler
> [mq-deadline] bfq none
> [root@localhost tmp]# dd if=3D/dev/zero of=3D/root/test.img bs=3D512 =
count=3D10000 oflag=3Ddsync
> 10000+0 record dentro
> 10000+0 record fuori
> 5120000 bytes (5,1 MB, 4,9 MiB) copied, 14,6892 s, 349 kB/s
> [root@localhost tmp]# echo bfq > /sys/block/sda/queue/scheduler
> [root@localhost tmp]# dd if=3D/dev/zero of=3D/root/test.img bs=3D512 =
count=3D10000 oflag=3Ddsync
> 10000+0 record dentro
> 10000+0 record fuori
> 5120000 bytes (5,1 MB, 4,9 MiB) copied, 20,1953 s, 254 kB/s
>=20
> Thanks,
> Paolo
>=20
>> Please let me know if any more info about my setup might be helpful.
>>=20
>> Thank you!
>>=20
>> Regards,
>> Srivatsa
>> VMware Photon OS
>>=20
>>>=20
>>>> Il giorno 18 mag 2019, alle ore 00:16, Srivatsa S. Bhat =
<srivatsa@csail.mit.edu> ha scritto:
>>>>=20
>>>>=20
>>>> Hi,
>>>>=20
>>>> One of my colleagues noticed upto 10x - 30x drop in I/O throughput
>>>> running the following command, with the CFQ I/O scheduler:
>>>>=20
>>>> dd if=3D/dev/zero of=3D/root/test.img bs=3D512 count=3D10000 =
oflags=3Ddsync
>>>>=20
>>>> Throughput with CFQ: 60 KB/s
>>>> Throughput with noop or deadline: 1.5 MB/s - 2 MB/s
>>>>=20
>>>> I spent some time looking into it and found that this is caused by =
the
>>>> undesirable interaction between 4 different components:
>>>>=20
>>>> - blkio cgroup controller enabled
>>>> - ext4 with the jbd2 kthread running in the root blkio cgroup
>>>> - dd running on ext4, in any other blkio cgroup than that of jbd2
>>>> - CFQ I/O scheduler with defaults for slice_idle and group_idle
>>>>=20
>>>>=20
>>>> When docker is enabled, systemd creates a blkio cgroup called
>>>> system.slice to run system services (and docker) under it, and a
>>>> separate blkio cgroup called user.slice for user processes. So, =
when
>>>> dd is invoked, it runs under user.slice.
>>>>=20
>>>> The dd command above includes the dsync flag, which performs an
>>>> fdatasync after every write to the output file. Since dd is writing =
to
>>>> a file on ext4, jbd2 will be active, committing transactions
>>>> corresponding to those fdatasync requests from dd. (In other words, =
dd
>>>> depends on jdb2, in order to make forward progress). But jdb2 being =
a
>>>> kernel thread, runs in the root blkio cgroup, as opposed to dd, =
which
>>>> runs under user.slice.
>>>>=20
>>>> Now, if the I/O scheduler in use for the underlying block device is
>>>> CFQ, then its inter-queue/inter-group idling takes effect (via the
>>>> slice_idle and group_idle parameters, both of which default to =
8ms).
>>>> Therefore, everytime CFQ switches between processing requests from =
dd
>>>> vs jbd2, this 8ms idle time is injected, which slows down the =
overall
>>>> throughput tremendously!
>>>>=20
>>>> To verify this theory, I tried various experiments, and in all =
cases,
>>>> the 4 pre-conditions mentioned above were necessary to reproduce =
this
>>>> performance drop. For example, if I used an XFS filesystem (which
>>>> doesn't use a separate kthread like jbd2 for journaling), or if I =
dd'ed
>>>> directly to a block device, I couldn't reproduce the performance
>>>> issue. Similarly, running dd in the root blkio cgroup (where jbd2
>>>> runs) also gets full performance; as does using the noop or =
deadline
>>>> I/O schedulers; or even CFQ itself, with slice_idle and group_idle =
set
>>>> to zero.
>>>>=20
>>>> These results were reproduced on a Linux VM (kernel v4.19) on ESXi,
>>>> both with virtualized storage as well as with disk pass-through,
>>>> backed by a rotational hard disk in both cases. The same problem =
was
>>>> also seen with the BFQ I/O scheduler in kernel v5.1.
>>>>=20
>>>> Searching for any earlier discussions of this problem, I found an =
old
>>>> thread on LKML that encountered this behavior [1], as well as a =
docker
>>>> github issue [2] with similar symptoms (mentioned later in the
>>>> thread).
>>>>=20
>>>> So, I'm curious to know if this is a well-understood problem and if
>>>> anybody has any thoughts on how to fix it.
>>>>=20
>>>> Thank you very much!
>>>>=20
>>>>=20
>>>> [1]. https://lkml.org/lkml/2015/11/19/359
>>>>=20
>>>> [2]. https://github.com/moby/moby/issues/21485
>>>>   https://github.com/moby/moby/issues/21485#issuecomment-222941103
>>>>=20
>>>> Regards,
>>>> Srivatsa


--Apple-Mail=_21B10740-0BE7-4709-B8E2-677D365FE8FA--

--Apple-Mail=_D52538F2-72FE-4CD4-B761-CCE9B24F2A35
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEpYoduex+OneZyvO8OAkCLQGo9oMFAlzj4CkACgkQOAkCLQGo
9oNhnw/9FknbSsZTxjcEVqr8AsffId7OcCZ7Rw6q+INMQwaQfs9+omWFzm7hrm3R
STwhoKDQimEHtpszFDoR1egchU/yKWD62iom+vYoyln+EaSSuFAgxx9wIJlT3G+U
cJH5ydhQZUNaWN1k4KUH1rKGhTeeOIK/7SqQWYLBLZwbethCP/SxG/3LKbbefPE2
oWH+tlkl3kEsklEIVEZdQuJsy9EtTY6IiKjJwFSaDD54++25n0jfq2fNwqqZRNzS
pNmX7pv8QpfutBkICbSgBrfZNiiZl4mhEl1pkKmUF48+C+R+kM8dBpaC8sHlq7rG
wV/ek3yHfauMeSMUuZpTeMO2sPpdfausH+/snmAftQeMqC6T+e3DtSfY9+NkBvAK
orMQa+BZUbzjfqmXR/M910/orEGkFvuyyOJKQjt2MaUMTJCrf+1/+y9x42ambCTo
cPJNv9jcG5G2J8jSX6KUpfwspB/o0ZU+gCszyYehk7lHIYvZQDk11u9+bM4nktpK
uUEHVUx3zOq251DxNG5P0dAZq7H66CMJCz8S25q6UJJsejN8YnSBUTLg2FVyrGaw
KTWp5TaVeD40RmfWmpz/kSAxDKCSkCcdH3G1j+6SxiFibMfDE0+0ejenqCY5uH8v
VPG7HR838Vz4U6qih4GERPZLXI2Oi3rFT8931fRuapT6+gNcVIY=
=lQSt
-----END PGP SIGNATURE-----

--Apple-Mail=_D52538F2-72FE-4CD4-B761-CCE9B24F2A35--
