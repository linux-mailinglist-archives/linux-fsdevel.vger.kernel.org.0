Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3DC52790F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 11:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfEWJTj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 05:19:39 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:55969 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfEWJTj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 05:19:39 -0400
Received: by mail-wm1-f46.google.com with SMTP id x64so4989390wmb.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2019 02:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=752R2EWnvdqWfiqHkJZUDQa+kUi+0Nb6hw+n+jxBCIs=;
        b=eCsrQiWAfJqQDlKFPdfjytj55/UmsbE2kg6DRt+wsbmgjcaPvPO3S8sDV1SobnBzUQ
         JfhpGWWh1B+3JavSkM9vzqzb916ygvEdI8wzWxS8WvS0oXsYdXO6VUtQuQjqZwsx0sVn
         tDBta4pchIXNyGyhthY41jknZCPhIeImo12eiQOHSx63efzq67LXFOnHXJu3hV+vnJ3i
         /nRpKAK0x0iAmgIwnaJqJQLijC1E5czSxnUNq8zTfm99EoEqVmEZl7OnDjuraQOe9JPD
         gEstY4+pcLfO7zS9KiUx/KNLZ0YcKsg4ilRuC8dTcZ/qWlz2IoYHzrxKav2F0AjA7Rba
         n6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=752R2EWnvdqWfiqHkJZUDQa+kUi+0Nb6hw+n+jxBCIs=;
        b=QyH/ojs87N9q+OlSpVu2BOhz+zHqkoiFPhQz0KQoH+8yZmLQ0Rx3Cs71xVd4qghvG9
         IeCMawrkmc0/Y4gwSDSGOtRN2V+zr4vvZpzxTCrz2Tmxdb072D+7tNIl9n7YhDItYw2F
         9gc7rAeuNVawGnn+We3Z8PECVk45tX70iM87NOvArV/EX14WMPlyuCOkUe3DEMQ95/0L
         XArwyHCebHdA5/dQ7A0SyI1paeEG1xha8p7wfjXTjGe3apX6Ek+x1GTietVqflCoyvHl
         LgayJLUFYQfpzKyPeNgBtvBAob3HM7UhYZxA9Vv+5sr4d4UDfLgWvsSPhyj+1XmFKpru
         O1Bg==
X-Gm-Message-State: APjAAAXA3cShc79vncKeUmJ6eHLqPNb0YbrYvLvUWFLg7UFV1uePghu0
        XQfQEELWsUvSDn+FE89Glpecew==
X-Google-Smtp-Source: APXvYqzeT6WAwvxjESd3ETgawhOIQDp+KM0dUYl6uLNBf6+HK1fhSfDukcBdrYl9RgxU0MV223kM3A==
X-Received: by 2002:a1c:2109:: with SMTP id h9mr10982689wmh.68.1558603175570;
        Thu, 23 May 2019 02:19:35 -0700 (PDT)
Received: from [192.168.0.102] (84-33-69-110.dyn.eolo.it. [84.33.69.110])
        by smtp.gmail.com with ESMTPSA id h14sm26488017wrt.11.2019.05.23.02.19.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 02:19:34 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
Message-Id: <6FE0A98F-1E3D-4EF6-8B38-2C85741924A4@linaro.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_6065E5A0-5868-41D1-99D7-84A50782E2C7";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: CFQ idling kills I/O performance on ext4 with blkio cgroup
 controller
Date:   Thu, 23 May 2019 11:19:32 +0200
In-Reply-To: <cc148388-3c82-d7c0-f9ff-8c31bb5dc77d@csail.mit.edu>
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
 <CA8A23E2-6F22-4444-9A20-E052A94CAA9B@linaro.org>
 <cc148388-3c82-d7c0-f9ff-8c31bb5dc77d@csail.mit.edu>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_6065E5A0-5868-41D1-99D7-84A50782E2C7
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_C3800707-4A1A-482E-B2AC-97FE6F293BC6"


--Apple-Mail=_C3800707-4A1A-482E-B2AC-97FE6F293BC6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> Il giorno 23 mag 2019, alle ore 04:30, Srivatsa S. Bhat =
<srivatsa@csail.mit.edu> ha scritto:
>=20
> On 5/22/19 3:54 AM, Paolo Valente wrote:
>>=20
>>=20
>>> Il giorno 22 mag 2019, alle ore 12:01, Srivatsa S. Bhat =
<srivatsa@csail.mit.edu> ha scritto:
>>>=20
>>> On 5/22/19 2:09 AM, Paolo Valente wrote:
>>>>=20
>>>> First, thank you very much for testing my patches, and, above all, =
for
>>>> sharing those huge traces!
>>>>=20
>>>> According to the your traces, the residual 20% lower throughput =
that you
>>>> record is due to the fact that the BFQ injection mechanism takes a =
few
>>>> hundredths of seconds to stabilize, at the beginning of the =
workload.
>>>> During that setup time, the throughput is equal to the dreadful =
~60-90 KB/s
>>>> that you see without this new patch.  After that time, there
>>>> seems to be no loss according to the trace.
>>>>=20
>>>> The problem is that a loss lasting only a few hundredths of seconds =
is
>>>> however not negligible for a write workload that lasts only 3-4
>>>> seconds.  Could you please try writing a larger file?
>>>>=20
>>>=20
>>> I tried running dd for longer (about 100 seconds), but still saw =
around
>>> 1.4 MB/s throughput with BFQ, and between 1.5 MB/s - 1.6 MB/s with
>>> mq-deadline and noop.
>>=20
>> Ok, then now the cause is the periodic reset of the mechanism.
>>=20
>> It would be super easy to fill this gap, by just gearing the =
mechanism
>> toward a very aggressive injection.  The problem is maintaining
>> control.  As you can imagine from the performance gap between CFQ (or
>> BFQ with malfunctioning injection) and BFQ with this fix, it is very
>> hard to succeed in maximizing the throughput while at the same time
>> preserving control on per-group I/O.
>>=20
>=20
> Ah, I see. Just to make sure that this fix doesn't overly optimize for
> total throughput (because of the testcase we've been using) and end up
> causing regressions in per-group I/O control, I ran a test with
> multiple simultaneous dd instances, each writing to a different
> portion of the filesystem (well separated, to induce seeks), and each
> dd task bound to its own blkio cgroup. I saw similar results with and
> without this patch, and the throughput was equally distributed among
> all the dd tasks.
>=20

Thank you very much for pre-testing this change, this let me know in
advance that I shouldn't find issues when I'll test regressions, at
the end of this change phase.

>> On the bright side, you might be interested in one of the benefits
>> that BFQ gives in return for this ~10% loss of throughput, in a
>> scenario that may be important for you (according to affiliation you
>> report): from ~500% to ~1000% higher throughput when you have to =
serve
>> the I/O of multiple VMs, and to guarantee at least no starvation to
>> any VM [1].  The same holds with multiple clients or containers, and
>> in general with any set of entities that may compete for storage.
>>=20
>> [1] =
https://www.linaro.org/blog/io-bandwidth-management-for-production-quality=
-services/
>>=20
>=20
> Great article! :) Thank you for sharing it!

Thanks! I mentioned it just to better put things into context.

>=20
>>> But I'm not too worried about that difference.
>>>=20
>>>> In addition, I wanted to ask you whether you measured BFQ =
throughput
>>>> with traces disabled.  This may make a difference.
>>>>=20
>>>=20
>>> The above result (1.4 MB/s) was obtained with traces disabled.
>>>=20
>>>> After trying writing a larger file, you can try with low_latency =
on.
>>>> On my side, it causes results to become a little unstable across
>>>> repetitions (which is expected).
>>>>=20
>>> With low_latency on, I get between 60 KB/s - 100 KB/s.
>>>=20
>>=20
>> Gosh, full regression.  Fortunately, it is simply meaningless to use
>> low_latency in a scenario where the goal is to guarantee per-group
>> bandwidths.  Low-latency heuristics, to reach their (low-latency)
>> goals, modify the I/O schedule compared to the best schedule for
>> honoring group weights and boosting throughput.  So, as recommended =
in
>> BFQ documentation, just switch low_latency off if you want to control
>> I/O with groups.  It may still make sense to leave low_latency on
>> in some specific case, which I don't want to bother you about.
>>=20
>=20
> My main concern here is about Linux's I/O performance out-of-the-box,
> i.e., with all default settings, which are:
>=20
> - cgroups and blkio enabled (systemd default)
> - blkio non-root cgroups in use (this is the implicit systemd behavior
>  if docker is installed; i.e., it runs tasks under user.slice)
> - I/O scheduler with blkio group sched support: bfq
> - bfq default configuration: low_latency =3D 1
>=20
> If this yields a throughput that is 10x-30x slower than what is
> achievable, I think we should either fix the code (if possible) or
> change the defaults such that they don't lead to this performance
> collapse (perhaps default low_latency to 0 if bfq group scheduling
> is in use?)

Yeah, I thought of this after sending my last email yesterday.  Group
scheduling and low-latency heuristics may simply happen to fight
against each other in personal systems.  Let's proceed this way.  I'll
try first to make the BFQ low-latency mechanism clever enough to not
hinder throughput when groups are in place.  If I make it, then we
will get the best of the two worlds: group isolation and intra-group
low latency; with no configuration change needed.  If I don't make it,
I'll try to think of the best solution to cope with this non-trivial
situation.


>> However, I feel bad with such a low throughput :)  Would you be so
>> kind to provide me with a trace?
>>=20
> Certainly! Short runs of dd resulted in a lot of variation in the
> throughput (between 60 KB/s - 1 MB/s), so I increased dd's runtime
> to get repeatable numbers (~70 KB/s). As a result, the trace file
> (trace-bfq-boost-injection-low-latency-71KBps) is quite large, and
> is available here:
>=20
> https://www.dropbox.com/s/svqfbv0idcg17pn/bfq-traces.tar.gz?dl=3D0
>=20

Thank you very much for your patience and professional help.

> Also, I'm very happy to run additional tests or experiments to help
> track down this issue. So, please don't hesitate to let me know if
> you'd like me to try anything else or get you additional traces etc. =
:)
>=20

Here's to you!  :) I've attached a new small improvement that may
reduce fluctuations (path to apply on top of the others, of course).
Unfortunately, I don't expect this change to boost the throughput
though.

In contrast, I've thought of a solution that might be rather
effective: making BFQ aware (heuristically) of trivial
synchronizations between processes in different groups.  This will
require a little more work and time.


Thanks,
Paolo


--Apple-Mail=_C3800707-4A1A-482E-B2AC-97FE6F293BC6
Content-Disposition: attachment;
	filename*0=0001-block-bfq-re-sample-req-service-times-when-possible.patch.g;
	filename*1=z
Content-Type: application/x-gzip;
	x-unix-mode=0644;
	name="0001-block-bfq-re-sample-req-service-times-when-possible.patch.gz"
Content-Transfer-Encoding: base64

H4sICDVl5lwAAzAwMDEtYmxvY2stYmZxLXJlLXNhbXBsZS1yZXEtc2VydmljZS10aW1lcy13aGVu
LXBvc3NpYmxlLnBhdGNoAJVSyW7bMBA9m18xvQReRJmS5TV1kKJF0ENSBEjaS1EItEjaTGnRJmk7
Bpp/79BygRySQwVCJGd58/hmbpxdA8+FEmPFxjIbCa6qfDoYjBZcVDlXYphPZJFl6GZwZ2t4kBvI
xsDY7LQgZywjNwgzg3tujYUf3Mg6SPi4idd031yvja65s6l1yyvyhQc5g8fVLoF8AHf8iCjZFDI2
GxazgkGPISp52C2eZBVm8PP+0+Pnr79gYWz1O4GF2s7ASer5emMknrbgpdvrSkLQa+nhsJI1bKz3
emEkIQ96WUtBrVJ0cfwPlpRS0tTsY0mqra9WUqQV/IEJ9JoPIzJQGmlUK14vpUhgDLpGPkHb2rd7
nQQDhDQy3tu0Q4jQSgGlSx2A99+CX7xlJboW8hkmqhBMDobDyUSl6XQgWT4qhJiOc1SPjYoisn4b
lyDdd7Cvr4GO2GCYjKF32rMBoM0HHnQFe6tFFL3cbQQ2rtR1bEtp9FqHtg9uV4WTG50cungSCYFW
C7oRwAUI7qjrJTRpqELaePtxw+gtvXqNCHNY8+cytHe1PzUOEwOKmIA1ognpXBLaeiG91gtI4yVo
Be0PsS69clt/5oeJFxfwz4rGUji9lw7mc8g6mNzqd+MfaT7tfHg1UA0nw30o41yVcajK2kOwoKwx
9nBOO1j321guzq33jbkft/cg5sAuSY8APr3fhUZPqGwsG2QCtQ1w4DpEuZR1wOtjHO+dRH7nKNTv
ZDYWS7pGxeaRMVGK0m2xyrfvt7coEgWSpzlLM0L+AlnH/GXpAwAA
--Apple-Mail=_C3800707-4A1A-482E-B2AC-97FE6F293BC6
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii



> Thank you!
> 
> Regards,
> Srivatsa
> VMware Photon OS


--Apple-Mail=_C3800707-4A1A-482E-B2AC-97FE6F293BC6--

--Apple-Mail=_6065E5A0-5868-41D1-99D7-84A50782E2C7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEpYoduex+OneZyvO8OAkCLQGo9oMFAlzmZaQACgkQOAkCLQGo
9oN3UhAAlDsMHiLeEJiAh5CfSMH9i8sBH9nD1rVceX2fj+dKMbLAYkvureuqgTBz
H1eeX7nOZJrI+I/I++peJEVSZxS3UW7p+HW1V937VJUiVqg6mNq8H9K5WTDGuOHb
YghIed8OQbEXAGVecCzkzyhvVJB5+6vT2TCD2evTYYbxpyZULNeQi6VWyk4PusSt
0357KacEOtGOIWntj8tXEX3WpQ5QpqclyPUO4loxbUrTyRIKcMoqIrT8Pk0P0W93
9lszncgvrPG3/Gk58TXwnec8O3M6EsKammr0onPkJVxGeIp+NKNbInPnJxX7jwgl
sa443Ehi1GcNVCNEAFuCtMaHa+freTbtyZwXKxPuQz5TSGYjn9n2WqkzlJoyCHxa
fJ2apbQJg1Tg0pdFDtWCPBkg/7GbzVareNLyNZx0Zm02jGcWBW8tlRqfl6vUFymC
oFllJTir6UlZWktoeKZgBe5yDlNMdSy0q1vjVgczC5dR845cf9OoUb4Z2ra8XWFV
z4Zv3t2aU0+I6cwgzEsfHwGyIY17IjiJcY+vwVYlxGDTqA6mzUAC/VhO5IS3fwLx
ZE5WrGcdYedEro96p61uprxX8DK5BYtSf3t9MnnGoFk8jWF3GzEcpjaiBs+tBqEt
8NCrJeFsarc7VaqbU88MJ2NMCFFmRD6B2JuvA9QEm+aFU3lXxHQ=
=7q6b
-----END PGP SIGNATURE-----

--Apple-Mail=_6065E5A0-5868-41D1-99D7-84A50782E2C7--
