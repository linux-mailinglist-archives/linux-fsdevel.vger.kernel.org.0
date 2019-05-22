Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 799F926020
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 11:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfEVJJc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 05:09:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35625 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728744AbfEVJJc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 05:09:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id q15so1358619wmj.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2019 02:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=Fs6G449Jswk/hH7c/uX6tzFFhtWXUq58A/0uXZEuWts=;
        b=IiDefu5bqQEPWNEoq67LbPmJCSQoTwMZJxGkSqwRJ+Exp/XLQT5ktDPQpue90UV2VM
         cwEl8DUj55krmLv7r9mUW/DR7BPIWxxJFg4I9eMMNZwBTjd+5HOtk7Otov9tMfse3Eb0
         USrMI0mQORY3d1nVFZQTsqKVl+dRrTlUpDOaRZUMIPw81XSVNUqorUm1cJS/ecmDIbyr
         kotvYGe77OXjbOIocNFZhNGfDjH5AEeY6Y22+R2lX5ffdDXhWdqyz1rkSiPuh3BuMIzY
         TNdxCYTEIt7jM4zryq+udmPxM6TmxUZ7Cb5jSN6y738c1C4Zyf10ECyEMjF05J5b8KNX
         5khQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=Fs6G449Jswk/hH7c/uX6tzFFhtWXUq58A/0uXZEuWts=;
        b=fevaxjxD/yC/kF/T+UKxMKyiu+Imp5jYf+BeHWJ3ltnTrkZ5kuEe0k9jd45XEnQpmr
         83sW2ab/NVC2W1qTKEeQHI1VF6xbX2jbhbdYkHGRN96ehHXtiiMLq98mThL/iSUvLwBZ
         OAfXnGFB5v6Vr+EwVT7MwNgNGKdKpJ8v1bpHg4msxQYrhrB6z4Avt0kf7qqgWKaeMN6u
         SVIJKJL+d05dkFLV5E4oFixE+WOhQEgoIqhs5DwXm931fxiSwIpLcu69h6BPVCLqp8S2
         +tsPSwPcczmfIWNWK99VOFbVvBnFEBAT0PWK2C4wx0kn/MU5hW64DZwdN12+dJdnNUfI
         5EDw==
X-Gm-Message-State: APjAAAWg1zCe0Eq2EN57+s63nKINuVnW71w9I5FZjRZWx7s0PXOD7yq+
        bGUke9OE/h9a1LrD2buFiapuCA==
X-Google-Smtp-Source: APXvYqwsdLWKTXlecXjTTY5sTEfZl/5WfZLsQZ++SMUSfStJ/qLyrQyz4ydIavTKGPfGzldSqDDplw==
X-Received: by 2002:a1c:dc86:: with SMTP id t128mr6259490wmg.64.1558516169471;
        Wed, 22 May 2019 02:09:29 -0700 (PDT)
Received: from [192.168.0.100] (88-147-40-42.dyn.eolo.it. [88.147.40.42])
        by smtp.gmail.com with ESMTPSA id u7sm13503722wmg.25.2019.05.22.02.09.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 02:09:28 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
Message-Id: <686D6469-9DE7-4738-B92A-002144C3E63E@linaro.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_3DB989E2-874B-47C2-B6CC-3F154F79180F";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: CFQ idling kills I/O performance on ext4 with blkio cgroup
 controller
Date:   Wed, 22 May 2019 11:09:26 +0200
In-Reply-To: <F5E29C98-6CC4-43B8-994D-0B5354EECBF3@linaro.org>
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
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_3DB989E2-874B-47C2-B6CC-3F154F79180F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> Il giorno 22 mag 2019, alle ore 10:05, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>=20
>=20
>> Il giorno 22 mag 2019, alle ore 00:51, Srivatsa S. Bhat =
<srivatsa@csail.mit.edu> ha scritto:
>>=20
>> [ Resending this mail with a dropbox link to the traces (instead
>> of a file attachment), since it didn't go through the last time. ]
>>=20
>> On 5/21/19 10:38 AM, Paolo Valente wrote:
>>>=20
>>>> So, instead of only sending me a trace, could you please:
>>>> 1) apply this new patch on top of the one I attached in my previous =
email
>>>> 2) repeat your test and report results
>>>=20
>>> One last thing (I swear!): as you can see from my script, I tested =
the
>>> case low_latency=3D0 so far.  So please, for the moment, do your =
test
>>> with low_latency=3D0.  You find the whole path to this parameter in,
>>> e.g., my script.
>>>=20
>> No problem! :) Thank you for sharing patches for me to test!
>>=20
>> I have good news :) Your patch improves the throughput significantly
>> when low_latency =3D 0.
>>=20
>> Without any patch:
>>=20
>> dd if=3D/dev/zero of=3D/root/test.img bs=3D512 count=3D10000 =
oflag=3Ddsync
>> 10000+0 records in
>> 10000+0 records out
>> 5120000 bytes (5.1 MB, 4.9 MiB) copied, 58.0915 s, 88.1 kB/s
>>=20
>>=20
>> With both patches applied:
>>=20
>> dd if=3D/dev/zero of=3D/root/test0.img bs=3D512 count=3D10000 =
oflag=3Ddsync
>> 10000+0 records in
>> 10000+0 records out
>> 5120000 bytes (5.1 MB, 4.9 MiB) copied, 3.87487 s, 1.3 MB/s
>>=20
>> The performance is still not as good as mq-deadline (which achieves
>> 1.6 MB/s), but this is a huge improvement for BFQ nonetheless!
>>=20
>> A tarball with the trace output from the 2 scenarios you requested,
>> one with only the debug patch applied =
(trace-bfq-add-logs-and-BUG_ONs),
>> and another with both patches applied (trace-bfq-boost-injection) is
>> available here:
>>=20
>> https://www.dropbox.com/s/pdf07vi7afido7e/bfq-traces.tar.gz?dl=3D0
>>=20
>=20
> Hi Srivatsa,
> I've seen the bugzilla you've created.  I'm a little confused on how
> to better proceed.  Shall we move this discussion to the bugzilla, or
> should we continue this discussion here, where it has started, and
> then update the bugzilla?
>=20

Ok, I've received some feedback on this point, and I'll continue the
discussion here.  Then I'll report back on the bugzilla.

First, thank you very much for testing my patches, and, above all, for
sharing those huge traces!

According to the your traces, the residual 20% lower throughput that you
record is due to the fact that the BFQ injection mechanism takes a few
hundredths of seconds to stabilize, at the beginning of the workload.
During that setup time, the throughput is equal to the dreadful ~60-90 =
KB/s
that you see without this new patch.  After that time, there
seems to be no loss according to the trace.

The problem is that a loss lasting only a few hundredths of seconds is
however not negligible for a write workload that lasts only 3-4
seconds.  Could you please try writing a larger file?

In addition, I wanted to ask you whether you measured BFQ throughput
with traces disabled.  This may make a difference.

After trying writing a larger file, you can try with low_latency on.
On my side, it causes results to become a little unstable across
repetitions (which is expected).

Thanks,
Paolo


> Let me know,
> Paolo
>=20
>> Thank you!
>>=20
>> Regards,
>> Srivatsa
>> VMware Photon OS


--Apple-Mail=_3DB989E2-874B-47C2-B6CC-3F154F79180F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEpYoduex+OneZyvO8OAkCLQGo9oMFAlzlEcYACgkQOAkCLQGo
9oNJ3Q//Sg7XcjVaaf3n1snyQH02p5UlfydhClnm/MruZLDVt8oB0HJMiP23IUwC
m3LhFiSCOgV2+knSjwbk3jtUR2tnvkBVcko/G2luqxPxJrq7v5GjSfEb/hLjgwpB
U7ufv14kR2EbE5C+2Qz9/JMsco9EOnGpCr3hO6/iWYkGBScu79iqoIH3wUuRdpg2
m1SkP/NWcrtc4kydA09RHjQTeSFNLZeO9PLjAVR6tkUGEmwopqqE+toWYiqBtScs
1Bf+eoQqAIxDr2OA98HpvUN6hYQxsDTNNbNn04wRLb+fK2BChcDDkM5MaJ/09YpK
s4DXMjs+ifvLi3PTTbAscjujOLDnsWaAmmY/rufox97lXPxxt6UySkdENFUBFLNd
bWvWMAb438p0Pz3hwNrU/tZh+nGYvqQT11oXq1Dlrks6kXS+iEfuZms34vz9tGfr
r8XlqfImvkUSn4NI7YocIyqg76Rf2t5VGr59mR+7cN58y/vBbkPr7FkjXl/1LfGm
bQsHL+D+NHb7NXgX91Jp97bKIX0yHnXdxrGZsjCH27C/HOzhtrncBzjcU2TPMEw+
T9JmOJf8G2vXfR5G5voKot2wX1qZ9Nnpd9T5U0rHd4ami2oiOv0BV1rAkbjaH5Qd
RcWZyGaSRBpzHuQQPi/jG18YzPbNt6szIflujQfdX38sPRcTXyk=
=qTPQ
-----END PGP SIGNATURE-----

--Apple-Mail=_3DB989E2-874B-47C2-B6CC-3F154F79180F--
