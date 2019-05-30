Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6992FA78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2019 12:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfE3KqD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 May 2019 06:46:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44454 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfE3KqC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 May 2019 06:46:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id w13so3856177wru.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2019 03:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=C4BgjhOQ5WaS5BA3N176Rm/rfCh1eKw3G7OX1NDf330=;
        b=ZHcoAoPWP49Y2hs6v2CQOh3DuFecDqeF+g/Ha0Cx5554RiqUdqSjrUzEZQVawME5Cc
         t+JWaCh6cNprvD3GC4CZfFFbIwJWiKzfGohC55oV4K0Na9RhHK/LLTzKj4xnTd5f2Gaq
         0JUpqCX5DrLWJ666CabaEEq9HV3pSETTY2fM1u0f59YmtuRGzeuPmEfX7Ul8rAQX3yhS
         Ph0H9Zx+IcE06NJeEbMaQwmxzJHsWPOOfQIj1iyCpkACP5B3j6lRRXABD3PpiTQiaHgC
         vFDLvU0hiN5zArHGDOJyjx8412ViMLTh/x389UmROZNRRzaqxLyusdnuWtLi2exM6T65
         4m9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=C4BgjhOQ5WaS5BA3N176Rm/rfCh1eKw3G7OX1NDf330=;
        b=Ik08pN/3yLnsKu6vMjV+FAloDuiDzmnjwbzYQ50dbyCv/m/yengiiDICUHJXMPi3jo
         ezpm3eE3brtJc45i7g3Agkd43qpUE0iw7CNOWUb9culovWGjQ6tqtCNz11XbDZgSEBgA
         1Ves1wiPsq+1kgccb5exoVR6jlHIjd2/7VAfVwTguHd3oo1xG9p7E4cr2K6zz0/uYfrK
         MNEN3QC5+5GBfNAW/oXdlb83MEB8wE+g+DRP7ya2nEpOPkbdH0+PYVpWe0w2fB5Qr1I2
         AwSMCl9l9wkDNVEntW/VXP8R+f+9THMDRx0NaoqX2Dnb9DP/ZaH5jmlvTINy4O71CulD
         i2FQ==
X-Gm-Message-State: APjAAAW7N4uQdwjO8CW6AnuGQK2Aj3jOu75zrasLTy/c95jycnXHpKHu
        Pk4JeThz2fUBTn1f13TnqRZOKA==
X-Google-Smtp-Source: APXvYqw1PXKaN2XzfkxrvWWIUxCH2bCO0CxsjAS2wAGmjr/lS4zV9Vzp6V0DJRzdzI6FdoPQh7Bf9w==
X-Received: by 2002:adf:e408:: with SMTP id g8mr2145454wrm.143.1559213160542;
        Thu, 30 May 2019 03:46:00 -0700 (PDT)
Received: from [192.168.0.101] (84-33-71-35.dyn.eolo.it. [84.33.71.35])
        by smtp.gmail.com with ESMTPSA id j123sm3875449wmb.32.2019.05.30.03.45.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 03:45:59 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
Message-Id: <7B74A790-BD98-412B-ADAB-3B513FB1944E@linaro.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_D5FC080D-8BC9-40E2-AD6D-43794CA895EE";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: CFQ idling kills I/O performance on ext4 with blkio cgroup
 controller
Date:   Thu, 30 May 2019 12:45:57 +0200
In-Reply-To: <0d6e3c02-1952-2177-02d7-10ebeb133940@csail.mit.edu>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-ext4@vger.kernel.org, cgroups@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
        amakhalov@vmware.com, anishs@vmware.com, srivatsab@vmware.com,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
To:     "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
References: <8d72fcf7-bbb4-2965-1a06-e9fc177a8938@csail.mit.edu>
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
 <CA8A23E2-6F22-4444-9A20-E052A94CAA9B@linaro.org>
 <cc148388-3c82-d7c0-f9ff-8c31bb5dc77d@csail.mit.edu>
 <6FE0A98F-1E3D-4EF6-8B38-2C85741924A4@linaro.org>
 <2A58C239-EF3F-422B-8D87-E7A3B500C57C@linaro.org>
 <a04368ba-f1d5-8f2c-1279-a685a137d024@csail.mit.edu>
 <E270AD92-943E-4529-8158-AB480D6D9DF8@linaro.org>
 <5b71028c-72f0-73dd-0cd5-f28ff298a0a3@csail.mit.edu>
 <FFA44D26-75FF-4A8E-A331-495349BE5FFC@linaro.org>
 <0d6e3c02-1952-2177-02d7-10ebeb133940@csail.mit.edu>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_D5FC080D-8BC9-40E2-AD6D-43794CA895EE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> Il giorno 30 mag 2019, alle ore 10:29, Srivatsa S. Bhat =
<srivatsa@csail.mit.edu> ha scritto:
>=20
> On 5/29/19 12:41 AM, Paolo Valente wrote:
>>=20
>>=20
>>> Il giorno 29 mag 2019, alle ore 03:09, Srivatsa S. Bhat =
<srivatsa@csail.mit.edu> ha scritto:
>>>=20
>>> On 5/23/19 11:51 PM, Paolo Valente wrote:
>>>>=20
>>>>> Il giorno 24 mag 2019, alle ore 01:43, Srivatsa S. Bhat =
<srivatsa@csail.mit.edu> ha scritto:
>>>>>=20
>>>>> When trying to run multiple dd tasks simultaneously, I get the =
kernel
>>>>> panic shown below (mainline is fine, without these patches).
>>>>>=20
>>>>=20
>>>> Could you please provide me somehow with a list =
*(bfq_serv_to_charge+0x21) ?
>>>>=20
>>>=20
>>> Hi Paolo,
>>>=20
>>> Sorry for the delay! Here you go:
>>>=20
>>> (gdb) list *(bfq_serv_to_charge+0x21)
>>> 0xffffffff814bad91 is in bfq_serv_to_charge =
(./include/linux/blkdev.h:919).
>>> 914
>>> 915	extern unsigned int blk_rq_err_bytes(const struct request *rq);
>>> 916
>>> 917	static inline unsigned int blk_rq_sectors(const struct request =
*rq)
>>> 918	{
>>> 919		return blk_rq_bytes(rq) >> SECTOR_SHIFT;
>>> 920	}
>>> 921
>>> 922	static inline unsigned int blk_rq_cur_sectors(const struct =
request *rq)
>>> 923	{
>>> (gdb)
>>>=20
>>>=20
>>> For some reason, I've not been able to reproduce this issue after
>>> reporting it here. (Perhaps I got lucky when I hit the kernel panic
>>> a bunch of times last week).
>>>=20
>>> I'll test with your fix applied and see how it goes.
>>>=20
>>=20
>> Great!  the offending line above gives me hope that my fix is =
correct.
>> If no more failures occur, then I'm eager (and a little worried ...)
>> to see how it goes with throughput :)
>>=20
>=20
> Your fix held up well under my testing :)
>=20

Great!

> As for throughput, with low_latency =3D 1, I get around 1.4 MB/s with
> bfq (vs 1.6 MB/s with mq-deadline). This is a huge improvement
> compared to what it was before (70 KB/s).
>=20

That's beautiful news!

So, now we have the best of the two worlds: maximum throughput and
total control on I/O (including minimum latency for interactive and
soft real-time applications).  Besides, no manual configuration
needed.  Of course, this holds unless/until you find other flaws ... ;)

> With tracing on, the throughput is a bit lower (as expected I guess),
> about 1 MB/s, and the corresponding trace file
> (trace-waker-detection-1MBps) is available at:
>=20
> https://www.dropbox.com/s/3roycp1zwk372zo/bfq-traces.tar.gz?dl=3D0
>=20

Thank you for the new trace.  I've analyzed it carefully, and, as I
imagined, this residual 12% throughput loss is due to a couple of
heuristics that occasionally get something wrong.  Most likely, ~12%
is the worst-case loss, and if one repeats the tests, the loss may be
much lower in some runs.

I think it is very hard to eliminate this fluctuation while keeping
full I/O control.  But, who knows, I might have some lucky idea in the
future.

At any rate, since you pointed out that you are interested in
out-of-the-box performance, let me complete the context: in case
low_latency is left set, one gets, in return for this 12% loss,
a) at least 1000% higher responsiveness, e.g., 1000% lower start-up
times of applications under load [1];
b) 500-1000% higher throughput in multi-client server workloads, as I
already pointed out [2].

I'm going to prepare complete patches.  In addition, if ok for you,
I'll report these results on the bug you created.  Then I guess we can
close it.

[1] https://algo.ing.unimo.it/people/paolo/disk_sched/results.php
[2] =
https://www.linaro.org/blog/io-bandwidth-management-for-production-quality=
-services/

> Thank you so much for your tireless efforts in fixing this issue!
>=20

I did enjoy working on this with you: your test case and your support
enabled me to make important improvements.  So, thank you very much
for your collaboration so far,
Paolo


> Regards,
> Srivatsa
> VMware Photon OS


--Apple-Mail=_D5FC080D-8BC9-40E2-AD6D-43794CA895EE
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEpYoduex+OneZyvO8OAkCLQGo9oMFAlzvtGUACgkQOAkCLQGo
9oNVJw//fwlcfMSVaKx721kD5B4qn6aWHMN4d2RzIDbrJh88OKMa9IDy70+NPqXq
dEDMwLetb/KsF3Ox2dEaWt+NTwIW9/AzzdIZSwuwMvuZVR606rmQhqcBfW5uhQuF
WKozLzC5VPIJLowgpYmWSQ+q283Ufsl4R/dGyaXBwYx8qRFarjsKQe+v+ozzzM+8
m8c0nf5K17nwsMVLAk7HizOAUosP+kHkNILsgXV9gu2RpPc1LE3SYHF5ujfnR8lh
3t4PJdH7r1gi4vRcyqVZvW9i15bhgUgQNlJARvgA9EeV5ekQQbY6a/ywds3z8CTV
fSlCJt9xsqqz7cxf4BQUiBud2UTv1NoVCMTYwDJ4AK4r9hffMpy1iyhMyhx9Q8WE
+jOpntWPeMyU8RCnV87pKo3ELzIlMpucCxTvlRAoZBmEltuQn/DvUGv0N0YizeIF
s99H14r4yrNKsQSzna6qyE+FAs+QpUHpXV44IHVZzhyXesxqPtaju/LisYCIilNs
GAVcHW9JIv68KdAMq3t5EX/XXfn/v9/3/8vY1UrhGafcJu9JkJW0Z5UyjzRctRC0
3UmIgpEWz9+mAjPuIboYbmL1uHaUcfxNUwqr38/rEv2rMm0zzd3ipHzzJCIS09NX
OjDXhgG+zqvWE7H8OC7Sqxg8ZUKpKPkhJRi8m0MrZsl7GYaM9Ok=
=sgcb
-----END PGP SIGNATURE-----

--Apple-Mail=_D5FC080D-8BC9-40E2-AD6D-43794CA895EE--
