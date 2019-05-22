Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F209625EFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 10:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfEVIFw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 04:05:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40887 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728747AbfEVIFv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 04:05:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id f10so1135270wre.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2019 01:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=5IBIrmvVf6ccQNtdeu2yWc9LBHhhxGRdGfBVh0+028w=;
        b=nWl3XtfGIqveSLzPdyEuAYRuA8O7EYCM0ZtEgQ98DXJsA2zQzynY9G9rSYeseu7ci5
         5KOe7ue5VJv9/oJvslVlbwxovozJmUJVdfdiAwatZRNHOLWB605HT9Bht1bQhsJFoZ0h
         O8Ew1carVKdmMVmYPwgVk523ad6Oonl8yVKfoZj1tw1DeQRbFyLA1HoOYSfd/eKsgKzQ
         7RWbiLmAIak6Lu72/j5jH1NFhinktak81lGqNLQYBCAZxVHvcKAU457C1n52KVEAOBGV
         B+iC9uipo0uWSS+ouPP7hYuVIetP/gSu/agvrI0QXpzU1JYl9nLLdXzXZEJDmP0Av+gV
         LGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=5IBIrmvVf6ccQNtdeu2yWc9LBHhhxGRdGfBVh0+028w=;
        b=DUrABx9UhYEqTiY1MZBXpevn2N+0MlxL8EFRtYa/cbblDNIJN8y3ooYHtisB2I0tG8
         kqh1UowLbzLEy/485f6fwEwWK69vpyj7DF5+DK8zcSg3rzaRoBl+dCgjtqHa4bGEUXd5
         qL48s7huXKkK9CBk4aiCAt9B6PipECx1v7G2Vo5mRloSBHDTuLsPcv/GVsP6nHQkEKu/
         mEmQZ9cFuLoyE59s+i7xeTiI49eM96f2Ev3Bt6F83vNdT82xkr5DxiHyoDiHEleCVl16
         6Pta5MyepghKTdGRTWRtFN96eebSkkYI1Rf9OdhMeqxYw1NFgrVcTzEZ41MfniW787IP
         ukLQ==
X-Gm-Message-State: APjAAAXIueiz6OKTiD25ETpDYgaN7R8Rr3yEkZAdqLykF6EcQIykPPa4
        ufUflG01d0+v80u0JQsr1/LDtw==
X-Google-Smtp-Source: APXvYqyp3cwbjBT2OIymk4j5HSd2Mnu+CvGqClw/DIwkORgLNVvAuawEHWU5ZpivC/01GynCrEiJXQ==
X-Received: by 2002:adf:f9c3:: with SMTP id w3mr6562625wrr.271.1558512349291;
        Wed, 22 May 2019 01:05:49 -0700 (PDT)
Received: from [192.168.0.100] (88-147-40-42.dyn.eolo.it. [88.147.40.42])
        by smtp.gmail.com with ESMTPSA id 34sm42104331wre.32.2019.05.22.01.05.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 01:05:48 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
Message-Id: <F5E29C98-6CC4-43B8-994D-0B5354EECBF3@linaro.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_D125924D-1FFE-4DC1-9485-B31EC5A3E5A7";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: CFQ idling kills I/O performance on ext4 with blkio cgroup
 controller
Date:   Wed, 22 May 2019 10:05:46 +0200
In-Reply-To: <0e3fdf31-70d9-26eb-7b42-2795d4b03722@csail.mit.edu>
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
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_D125924D-1FFE-4DC1-9485-B31EC5A3E5A7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> Il giorno 22 mag 2019, alle ore 00:51, Srivatsa S. Bhat =
<srivatsa@csail.mit.edu> ha scritto:
>=20
> [ Resending this mail with a dropbox link to the traces (instead
> of a file attachment), since it didn't go through the last time. ]
>=20
> On 5/21/19 10:38 AM, Paolo Valente wrote:
>>=20
>>> So, instead of only sending me a trace, could you please:
>>> 1) apply this new patch on top of the one I attached in my previous =
email
>>> 2) repeat your test and report results
>>=20
>> One last thing (I swear!): as you can see from my script, I tested =
the
>> case low_latency=3D0 so far.  So please, for the moment, do your test
>> with low_latency=3D0.  You find the whole path to this parameter in,
>> e.g., my script.
>>=20
> No problem! :) Thank you for sharing patches for me to test!
>=20
> I have good news :) Your patch improves the throughput significantly
> when low_latency =3D 0.
>=20
> Without any patch:
>=20
> dd if=3D/dev/zero of=3D/root/test.img bs=3D512 count=3D10000 =
oflag=3Ddsync
> 10000+0 records in
> 10000+0 records out
> 5120000 bytes (5.1 MB, 4.9 MiB) copied, 58.0915 s, 88.1 kB/s
>=20
>=20
> With both patches applied:
>=20
> dd if=3D/dev/zero of=3D/root/test0.img bs=3D512 count=3D10000 =
oflag=3Ddsync
> 10000+0 records in
> 10000+0 records out
> 5120000 bytes (5.1 MB, 4.9 MiB) copied, 3.87487 s, 1.3 MB/s
>=20
> The performance is still not as good as mq-deadline (which achieves
> 1.6 MB/s), but this is a huge improvement for BFQ nonetheless!
>=20
> A tarball with the trace output from the 2 scenarios you requested,
> one with only the debug patch applied =
(trace-bfq-add-logs-and-BUG_ONs),
> and another with both patches applied (trace-bfq-boost-injection) is
> available here:
>=20
> https://www.dropbox.com/s/pdf07vi7afido7e/bfq-traces.tar.gz?dl=3D0
>=20

Hi Srivatsa,
I've seen the bugzilla you've created.  I'm a little confused on how
to better proceed.  Shall we move this discussion to the bugzilla, or
should we continue this discussion here, where it has started, and
then update the bugzilla?

Let me know,
Paolo

> Thank you!
>=20
> Regards,
> Srivatsa
> VMware Photon OS


--Apple-Mail=_D125924D-1FFE-4DC1-9485-B31EC5A3E5A7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEpYoduex+OneZyvO8OAkCLQGo9oMFAlzlAtoACgkQOAkCLQGo
9oMOew//baPEoy03FXyfpwRm+aDYCXZracwMcV8EWCYLxsc9h+OSDu7YSL3VY+ld
2SyrH2br9GjVHPnM218Moh1g2pTGr9C2BtEzWT72DnGFmZqEYFOS3+KJ6D4FEK/l
6qOtaYyYZDABc5D+wW1B+wouBFeDFH/V4QWpIgyAjKPHi+rTeerEFNzNmsx2SngT
mn+AG8kUfecpNhThxEEJxPZN0Edso3t6vet2vsJ7FEmpxD+AW4V6h5oxRBMMlzks
JeDs0/gvOV0wiRSAwlmQSecNSssSLLSeouHlLu3+ara3YxdNstDjBd7ODXiabUdX
4NPn9U5baJ8XsC4s6ukMOm1Bc7Q97ZFS4cM5b9FoqTYgWuwL32vbHFPffe/0Ld2g
hJcXoI7HmDyGvH4jAvlSQ4hDDkuLRjf0450Y75onK8uq/g6r0VhGXgntHl+ghMvI
ykkrXo8cPp9Ii4MiOAbH4FaVj1/1yinJdiIbR7bCdj3kODB8wzLunSAB3GDVTqYr
qqFfl6MYNxJi6mUpERhdFa8JsohkU9f/PK+hYh4HYjZNveV1YcSJfcuoCu2t1/yA
04KNr+WG1JFQrrXe+iqXtu5EMD/K6QlH9iBXabq8V/JJ1TR/X3WXo2iPRhDfpKc7
+kRGBjEtU+WJvdECyd4AfTpVuKBK8tUewLIBr7WchCBggJ/4sFg=
=q2Kr
-----END PGP SIGNATURE-----

--Apple-Mail=_D125924D-1FFE-4DC1-9485-B31EC5A3E5A7--
