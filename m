Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7222224801
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 08:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfEUGXL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 May 2019 02:23:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36327 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbfEUGXK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 May 2019 02:23:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id s17so17102143wru.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2019 23:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=/X0F6+Y1M8EwDKgr5lTkilasanWcGGf9Uo6k3RZbCKw=;
        b=VwHbUzfo4DJkvfdMV4YIu2Nde66nwtQg6g+dyzYEjTSgSz+mJMekwN6PPBO31+2KVT
         BOtGp0P4zSllC9qMbrug9bRvbAlttCTL/pnfI/7z13XGmZ5WJP7HfZE0PS309aeRJoKe
         d1KZ2ZMzVWt9FzdlYLpPgbivOKkriJmWQn8ALfj+GrGda3nKrsbqrnScXDtV7ZU62Cu/
         Zh3erY3LVaRf5+wDGkaovAcVPlRXCAN58YGxSHFG0xoDHuikpz3zqYWSCy/layAC29YF
         o+A1jfGJTv7BSQXDR87PD5fDirURdbeNBtvvqlGY+VrgCDJ9esO6VoAZG1LcW/a8kWJn
         ozIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=/X0F6+Y1M8EwDKgr5lTkilasanWcGGf9Uo6k3RZbCKw=;
        b=eE/iEHcGzPnSTg+Y44s0VmFGCneZOt1bdunb25ctGWM4XOFky++P91BvDSHVCdmChU
         a8SZBlCtSfokOseWDJNweyCbXx2kRqw0bQ1eatFe9TYQASJPJh8a9eT2vj5YqwLdkyTW
         v6YfHJxuO9kSt4c8iMSyzfSUHIhlsAdlmOLwaYwp5FiBuB2OP99HUevflWlqkfBdJzgo
         6SNGVESzC+XZSZwDo+0ztu5Xgy4issJjQwPrjYAFRhdCupLnSSUPs4La4I7w0cXpWXZ2
         nE8gE32ezXoKWesnL0rlU5qJgVN3/WNqw1ATdMk/fuToiEjgpqBO5MQEs/pqQuZyhrS8
         D+ag==
X-Gm-Message-State: APjAAAVS4XZl/quh4quNOW/NFXXrKzx0COTdI2VSqVkM9hW5u1eyGAFb
        21VfOw2nfbAroSxS8N0l6qV0eA==
X-Google-Smtp-Source: APXvYqxpsV5aiVbr4ZuDEsq9JrXf6GX4gu3XpLbruwNnAOR15W2RwibXjMCak6RDzuHCjNhI+KaCFg==
X-Received: by 2002:a5d:6cae:: with SMTP id a14mr33366716wra.214.1558419788392;
        Mon, 20 May 2019 23:23:08 -0700 (PDT)
Received: from [192.168.0.101] ([88.147.35.136])
        by smtp.gmail.com with ESMTPSA id z1sm5734685wrl.91.2019.05.20.23.23.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 23:23:07 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
Message-Id: <6EB6C9D2-E774-48FA-AC95-BC98D97645D0@linaro.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_8AD55980-F0C1-42FC-843D-9D3AFDD1A996";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: CFQ idling kills I/O performance on ext4 with blkio cgroup
 controller
Date:   Tue, 21 May 2019 08:23:05 +0200
In-Reply-To: <238e14ff-68d1-3b21-a291-28de4f2d77af@csail.mit.edu>
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
 <238e14ff-68d1-3b21-a291-28de4f2d77af@csail.mit.edu>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_8AD55980-F0C1-42FC-843D-9D3AFDD1A996
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> Il giorno 21 mag 2019, alle ore 00:45, Srivatsa S. Bhat =
<srivatsa@csail.mit.edu> ha scritto:
>=20
> On 5/20/19 3:19 AM, Paolo Valente wrote:
>>=20
>>=20
>>> Il giorno 18 mag 2019, alle ore 22:50, Srivatsa S. Bhat =
<srivatsa@csail.mit.edu> ha scritto:
>>>=20
>>> On 5/18/19 11:39 AM, Paolo Valente wrote:
>>>> I've addressed these issues in my last batch of improvements for =
BFQ,
>>>> which landed in the upcoming 5.2. If you give it a try, and still =
see
>>>> the problem, then I'll be glad to reproduce it, and hopefully fix =
it
>>>> for you.
>>>>=20
>>>=20
>>> Hi Paolo,
>>>=20
>>> Thank you for looking into this!
>>>=20
>>> I just tried current mainline at commit 72cf0b07, but unfortunately
>>> didn't see any improvement:
>>>=20
>>> dd if=3D/dev/zero of=3D/root/test.img bs=3D512 count=3D10000 =
oflag=3Ddsync
>>>=20
>>> With mq-deadline, I get:
>>>=20
>>> 5120000 bytes (5.1 MB, 4.9 MiB) copied, 3.90981 s, 1.3 MB/s
>>>=20
>>> With bfq, I get:
>>> 5120000 bytes (5.1 MB, 4.9 MiB) copied, 84.8216 s, 60.4 kB/s
>>>=20
>>=20
>> Hi Srivatsa,
>> thanks for reproducing this on mainline.  I seem to have reproduced a
>> bonsai-tree version of this issue.  Before digging into the block
>> trace, I'd like to ask you for some feedback.
>>=20
>> First, in my test, the total throughput of the disk happens to be
>> about 20 times as high as that enjoyed by dd, regardless of the I/O
>> scheduler.  I guess this massive overhead is normal with dsync, but
>> I'd like know whether it is about the same on your side.  This will
>> help me understand whether I'll actually be analyzing about the same
>> problem as yours.
>>=20
>=20
> Do you mean to say the throughput obtained by dd'ing directly to the
> block device (bypassing the filesystem)?

No no, I mean simply what follows.

1) in one terminal:
[root@localhost tmp]# dd if=3D/dev/zero of=3D/root/test.img bs=3D512 =
count=3D10000 oflag=3Ddsync
10000+0 record dentro
10000+0 record fuori
5120000 bytes (5,1 MB, 4,9 MiB) copied, 14,6892 s, 349 kB/s

2) In a second terminal, while the dd is in progress in the first
terminal:
$ iostat -tmd /dev/sda 3
Linux 5.1.0+ (localhost.localdomain) 	20/05/2019 	_x86_64_	=
(2 CPU)

...
20/05/2019 11:40:17
Device             tps    MB_read/s    MB_wrtn/s    MB_read    MB_wrtn
sda            2288,00         0,00         9,77          0         29

20/05/2019 11:40:20
Device             tps    MB_read/s    MB_wrtn/s    MB_read    MB_wrtn
sda            2325,33         0,00         9,93          0         29

20/05/2019 11:40:23
Device             tps    MB_read/s    MB_wrtn/s    MB_read    MB_wrtn
sda            2351,33         0,00        10,05          0         30
...

As you can see, the overall throughput (~10 MB/s) is more than 20
times as high as the dd throughput (~350 KB/s).  But the dd is the
only source of I/O.

Do you also see such a huge difference?

Thanks,
Paolo

> That does give me a 20x
> speedup with bs=3D512, but much more with a bigger block size =
(achieving
> a max throughput of about 110 MB/s).
>=20
> dd if=3D/dev/zero of=3D/dev/sdc bs=3D512 count=3D10000 conv=3Dfsync
> 10000+0 records in
> 10000+0 records out
> 5120000 bytes (5.1 MB, 4.9 MiB) copied, 0.15257 s, 33.6 MB/s
>=20
> dd if=3D/dev/zero of=3D/dev/sdc bs=3D4k count=3D10000 conv=3Dfsync
> 10000+0 records in
> 10000+0 records out
> 40960000 bytes (41 MB, 39 MiB) copied, 0.395081 s, 104 MB/s
>=20
> I'm testing this on a Toshiba MG03ACA1 (1TB) hard disk.
>=20
>> Second, the commands I used follow.  Do they implement your test case
>> correctly?
>>=20
>> [root@localhost tmp]# mkdir /sys/fs/cgroup/blkio/testgrp
>> [root@localhost tmp]# echo $BASHPID > =
/sys/fs/cgroup/blkio/testgrp/cgroup.procs
>> [root@localhost tmp]# cat /sys/block/sda/queue/scheduler
>> [mq-deadline] bfq none
>> [root@localhost tmp]# dd if=3D/dev/zero of=3D/root/test.img bs=3D512 =
count=3D10000 oflag=3Ddsync
>> 10000+0 record dentro
>> 10000+0 record fuori
>> 5120000 bytes (5,1 MB, 4,9 MiB) copied, 14,6892 s, 349 kB/s
>> [root@localhost tmp]# echo bfq > /sys/block/sda/queue/scheduler
>> [root@localhost tmp]# dd if=3D/dev/zero of=3D/root/test.img bs=3D512 =
count=3D10000 oflag=3Ddsync
>> 10000+0 record dentro
>> 10000+0 record fuori
>> 5120000 bytes (5,1 MB, 4,9 MiB) copied, 20,1953 s, 254 kB/s
>>=20
>=20
> Yes, this is indeed the testcase, although I see a much bigger
> drop in performance with bfq, compared to the results from
> your setup.
>=20
> Regards,
> Srivatsa


--Apple-Mail=_8AD55980-F0C1-42FC-843D-9D3AFDD1A996
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEpYoduex+OneZyvO8OAkCLQGo9oMFAlzjmUkACgkQOAkCLQGo
9oO3FQ/+Jv+JpkDN4rqwR/5YS99ksO/DlU7NJ61C7pK03vuGrei46Qei6u0MSATN
aB8HTp39V50NsnqyWHUdYN2eX8TsK3SXXfYLr1JLh69f/tzcGmtG1+nWab5eBope
8CKi6bREmxs4VPFrsiwflWspuOHxr0cSfTKjVG7vi+IAILRiAep3vcHbfp26Qehx
Z8RCNQhaAgMX15XWl7SnAPOvispB8OkXyZxtKA4VgzZ4mA6IxcBeioW78U9bAUaQ
zFD+Wmplj5U2yWo5MbBYmiRFeYlaLNdgZjAZlpdt/dYlxPuNSJ6oMNCu5QwlBU1G
b01D84AlHyNC/9RQAMf4+WIuFG8OhekGoswddB3B8xgKQp20beD1D4lUuTl6V0Bt
7WAAUT5G8wrzOFjbcnZcOqUEOh7Z2nEj7hstYnp3l35Ou20BJttg7D4G9qmnGnvI
zp49gutGftl1ElB/WT1BavkgIfd8WA7TUs1c4FGKnEC13MtjjGNPsuW6rWjFlLn+
XUlSgKys/O+sEKyeK7jmune5WTXoqxIe9cQg/qi8alFU/qfqAZXsPYrRNVkYDBgd
oLflkGK75Qfwkrkz02kLQ9aHTS5hv+XwXDfDQwmkaH/5ZpUDGNYo+4SJgbWbQwr7
TtVg+9h5g50wQRd8pNRnaQRemEBrSrNYyIOR6l+6PaP0h8MVaJ0=
=6wO1
-----END PGP SIGNATURE-----

--Apple-Mail=_8AD55980-F0C1-42FC-843D-9D3AFDD1A996--
