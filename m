Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 758EB26281
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 12:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbfEVKyO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 06:54:14 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:37273 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbfEVKyN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 06:54:13 -0400
Received: by mail-wm1-f51.google.com with SMTP id 7so1709256wmo.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2019 03:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=CNhkQEJls3nT3iMkh1/CUssdVTSurGv5Rigbx0wo7U4=;
        b=Oru7bhxHELgGgoBi4ETh1p8HocPNWexprBV9cag2KIgoyMzmaiNQwjb/C9rBPs3ZAI
         1P+sgXAq+LJ7ARtyNTI4NCxWWJc6H0XdbdS3gzpWGbzWqv2mLRxF3XBKnfPksvNy4bmf
         Z2N4R5yg3IW6OCechLbsRxdHCdJwHtT86JuAGc5439Udl1VwIBq11R8j6O3p7r2AEC/L
         y1v3u8BSe0ElkJjp4CXNQJbH5m1IP5ENonLLsP0JZ/gAU5M5ED3KOUsrtv1TabKpJpZO
         8pKF7hu2w25OO7PxveAEep+kbBQOfRiYMA7x6Nz3poDzw9PJimXfPoy8tpcYkqHNm+8K
         Mrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=CNhkQEJls3nT3iMkh1/CUssdVTSurGv5Rigbx0wo7U4=;
        b=kHrOZBrNoEIMj7icotep8paxLih9Cx6zwVZ4pRdayyNmhmA8yOODMoImr9eN5PymmD
         X73GPlTZ2vGtiqlHQg9Y/3YUO9ODocDpgR9+t80dPKFl4W7vR5IORd9MyOjOcH0G2Zm4
         xd0uVN7b4OZaA47bK9vniYIauRPODAeCyrwVesPe+afD5RuKpUlnNyiwrEGQyVClnBal
         3Bl2UZnrDMwAbcxGHv4OvycOC6jC7j1uOBY2DtApuXYcMzEyGwUSCEGpa5c0NptsuIZa
         M5/JJegGa4qZC7Xexnh5hPkhnMbMy8vKI65q73ViBBRyCaS0ZENykRrKAg/k2gSwSPoo
         47QA==
X-Gm-Message-State: APjAAAUMTUBXtaiCkpJWFAXwtq5DrTXTEHa7R4S1HQhvHiOq/mpmfN8G
        b444E4IQf6JYqmVHQn7kDBzWUQ==
X-Google-Smtp-Source: APXvYqxxWhUiT/XYL68wetT0/Xm1tLz2ltHVCg3kd/rCLbdKFVY5j4a0s9Q2rPyucIGz4zDbxnBm5Q==
X-Received: by 2002:a7b:c458:: with SMTP id l24mr6858233wmi.53.1558522451312;
        Wed, 22 May 2019 03:54:11 -0700 (PDT)
Received: from [192.168.0.100] (88-147-40-42.dyn.eolo.it. [88.147.40.42])
        by smtp.gmail.com with ESMTPSA id w9sm5480053wmg.7.2019.05.22.03.54.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 03:54:10 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
Message-Id: <CA8A23E2-6F22-4444-9A20-E052A94CAA9B@linaro.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_53A52072-8428-4910-8FA8-7AAC6D010D2E";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: CFQ idling kills I/O performance on ext4 with blkio cgroup
 controller
Date:   Wed, 22 May 2019 12:54:07 +0200
In-Reply-To: <01d55216-5718-767a-e1e6-aadc67b632f4@csail.mit.edu>
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
 <FC24E25F-4578-454D-AE2B-8D8D352478D8@linaro.org>
 <0e3fdf31-70d9-26eb-7b42-2795d4b03722@csail.mit.edu>
 <F5E29C98-6CC4-43B8-994D-0B5354EECBF3@linaro.org>
 <686D6469-9DE7-4738-B92A-002144C3E63E@linaro.org>
 <01d55216-5718-767a-e1e6-aadc67b632f4@csail.mit.edu>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_53A52072-8428-4910-8FA8-7AAC6D010D2E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> Il giorno 22 mag 2019, alle ore 12:01, Srivatsa S. Bhat =
<srivatsa@csail.mit.edu> ha scritto:
>=20
> On 5/22/19 2:09 AM, Paolo Valente wrote:
>>=20
>> First, thank you very much for testing my patches, and, above all, =
for
>> sharing those huge traces!
>>=20
>> According to the your traces, the residual 20% lower throughput that =
you
>> record is due to the fact that the BFQ injection mechanism takes a =
few
>> hundredths of seconds to stabilize, at the beginning of the workload.
>> During that setup time, the throughput is equal to the dreadful =
~60-90 KB/s
>> that you see without this new patch.  After that time, there
>> seems to be no loss according to the trace.
>>=20
>> The problem is that a loss lasting only a few hundredths of seconds =
is
>> however not negligible for a write workload that lasts only 3-4
>> seconds.  Could you please try writing a larger file?
>>=20
>=20
> I tried running dd for longer (about 100 seconds), but still saw =
around
> 1.4 MB/s throughput with BFQ, and between 1.5 MB/s - 1.6 MB/s with
> mq-deadline and noop.

Ok, then now the cause is the periodic reset of the mechanism.

It would be super easy to fill this gap, by just gearing the mechanism
toward a very aggressive injection.  The problem is maintaining
control.  As you can imagine from the performance gap between CFQ (or
BFQ with malfunctioning injection) and BFQ with this fix, it is very
hard to succeed in maximizing the throughput while at the same time
preserving control on per-group I/O.

On the bright side, you might be interested in one of the benefits
that BFQ gives in return for this ~10% loss of throughput, in a
scenario that may be important for you (according to affiliation you
report): from ~500% to ~1000% higher throughput when you have to serve
the I/O of multiple VMs, and to guarantee at least no starvation to
any VM [1].  The same holds with multiple clients or containers, and
in general with any set of entities that may compete for storage.

[1] =
https://www.linaro.org/blog/io-bandwidth-management-for-production-quality=
-services/

> But I'm not too worried about that difference.
>=20
>> In addition, I wanted to ask you whether you measured BFQ throughput
>> with traces disabled.  This may make a difference.
>>=20
>=20
> The above result (1.4 MB/s) was obtained with traces disabled.
>=20
>> After trying writing a larger file, you can try with low_latency on.
>> On my side, it causes results to become a little unstable across
>> repetitions (which is expected).
>>=20
> With low_latency on, I get between 60 KB/s - 100 KB/s.
>=20

Gosh, full regression.  Fortunately, it is simply meaningless to use
low_latency in a scenario where the goal is to guarantee per-group
bandwidths.  Low-latency heuristics, to reach their (low-latency)
goals, modify the I/O schedule compared to the best schedule for
honoring group weights and boosting throughput.  So, as recommended in
BFQ documentation, just switch low_latency off if you want to control
I/O with groups.  It may still make sense to leave low_latency on
in some specific case, which I don't want to bother you about.

However, I feel bad with such a low throughput :)  Would you be so
kind to provide me with a trace?

Thanks,
Paolo

> Regards,
> Srivatsa
> VMware Photon OS


--Apple-Mail=_53A52072-8428-4910-8FA8-7AAC6D010D2E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEpYoduex+OneZyvO8OAkCLQGo9oMFAlzlKk8ACgkQOAkCLQGo
9oM6/A//WCuWEiR1JltuM5aklvJR+eYW/8xLJ3rbu8+0GrZIuuF1iPSXcB9p5yBP
Wv3z5VUoumSlsb9aQlq6M0TPc5htnj00mIIuKaOAXZOhLNjTCvIEaSm1K8CtAW2B
03MrWYTQw50jvR6OxpKtU0SKcMQQLPweiJPdTjy4tWUGgYoswDXFg+en8HNgSLv4
sNGJQ8NrBQHU13P2WBm/j0ikPdKUfrM5yt6SdP7fDiYxemuMCecvUHMQOqhS7bua
bgzZ9Y0DJfNtkELmGxsrNgTehctLCc7AEaViSzQVZxLs+FPa7pFIv30D8Nt8Hx3b
e9x2zS/LXryo/Nx5NFgeMCISd1FbU2+eVqNmJhnjdCzDFiMUEM4GaQ7MbDNKZ1sO
6ud0S49AOKvX4AXp5W+lufgRhQIw6OmIopPcXmzhUI3NZ9AqK430a5PwMjaUMn67
PL9RYaLBU3p/POExsr5beMhc7Z6yGPtWF/tTFZuzQx0j3SXNoLjolpHLc3T0R/06
eC8iUx+IUhkcOKrlmq2p1cLHpqzCVX8wPa/2xxcDveg5MiKo/U8dxQ5xmGEa8sSs
nuZKPU7SJKeXae0UtOB3H74NIJU0joKCKhRherD7zYiJdx9RwSAv40Vbbhnq1DBo
XI57SYyx53LQmwIKLdHXOgE0EKCnxBzPxZIK3CQIuSR8bzYRe8o=
=WeX3
-----END PGP SIGNATURE-----

--Apple-Mail=_53A52072-8428-4910-8FA8-7AAC6D010D2E--
