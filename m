Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81AB92602A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 11:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfEVJM7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 05:12:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37099 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbfEVJM7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 05:12:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id e15so1395147wrs.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2019 02:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=rE8Wct0UxfEhY9tt7Rg+uVL4FI68TDcokTaqF5xHzQs=;
        b=V8o6Ep+QR0eP6MpPvEQrnJLjZBxuAuNyjG5P+obSCbdPfNcV7GlxKOxPXZH723EgHx
         gu3AHnqiE3fBRkTPcZMXbtxsTd1d+9OjAunY8+oWoqySlXfukrGZBl7A42oRbvdXO3lQ
         lrEj5NXoCJhA0R94mQrV1ESLTZkoc2Cv/xIiF4bNW7M+L6Mf/pOoCFsF5TPe9JajpWqp
         uFjj3rKSwQ1RerocltqB1Cexxr0KdDiPkdpx3BpAdGq6FPXdTyKRwI5Z4iF6k684XFVa
         0cSE0F/CM0+zIs+jPxRmYYUgkeIKiiMNpm3QVgVHAZaGd28fK5Sa6QyYnSmvjJhe1aaV
         gOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=rE8Wct0UxfEhY9tt7Rg+uVL4FI68TDcokTaqF5xHzQs=;
        b=NIqu8XE6CdxXRC9/GreI/+FPEkj859MRLtvtjWih97TzbRCYAbwZ9BNiCd1zs0T45k
         kuzsxnZxXt6KMBpg6Tc66jhdbU18pwgfj3TRFtwnhqCQmoCVNo0uS14C3Nc4cOepZgm5
         zWExt8lP5xoJq0+Bgwz4jNXdtdUAhUtQ1ayfuWj4B8zD2mh++4x7pLNVXl/MCRQbUjq8
         we4BCKMddsCTOwHtKodILtYzHh7+PWrDFXwlToKp6gwxOo7xdgm7uNL2rfSZu35tv4am
         VEKQ3ejDAS/oskc+ZOUj4bjhATwkgH9Pguiyc9d2LeMEam6iMLbqkNAuKeyKgTzisJUi
         nl/A==
X-Gm-Message-State: APjAAAW0vV8X8Faf4Vl4Vp6TFbGDXuBZMfBB8vf6fLzUAF+xGTn0Qvlt
        R0dfavbDXQovxDSyn/OTRN+uFg==
X-Google-Smtp-Source: APXvYqwvtxGG8jH6YwkZapBXJ/fgPv1poDp8G6YLsqJwnzUuyhinC6N/0tUvGOku1MTZYsEkVHp6yw==
X-Received: by 2002:adf:f208:: with SMTP id p8mr33137611wro.160.1558516377240;
        Wed, 22 May 2019 02:12:57 -0700 (PDT)
Received: from [192.168.0.100] (88-147-40-42.dyn.eolo.it. [88.147.40.42])
        by smtp.gmail.com with ESMTPSA id w3sm11277147wrv.25.2019.05.22.02.12.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 02:12:56 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
Message-Id: <9E95BE27-2167-430F-9C7F-6D4A0E255FF3@linaro.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_4DC1C4F9-FFD5-4309-8346-630474A6C16C";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: CFQ idling kills I/O performance on ext4 with blkio cgroup
 controller
Date:   Wed, 22 May 2019 11:12:55 +0200
In-Reply-To: <f4b11315-144c-c67d-5143-50b5be950ede@csail.mit.edu>
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
 <f4b11315-144c-c67d-5143-50b5be950ede@csail.mit.edu>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_4DC1C4F9-FFD5-4309-8346-630474A6C16C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> Il giorno 22 mag 2019, alle ore 11:02, Srivatsa S. Bhat =
<srivatsa@csail.mit.edu> ha scritto:
>=20
> On 5/22/19 1:05 AM, Paolo Valente wrote:
>>=20
>>=20
>>> Il giorno 22 mag 2019, alle ore 00:51, Srivatsa S. Bhat =
<srivatsa@csail.mit.edu> ha scritto:
>>>=20
>>> [ Resending this mail with a dropbox link to the traces (instead
>>> of a file attachment), since it didn't go through the last time. ]
>>>=20
>>> On 5/21/19 10:38 AM, Paolo Valente wrote:
>>>>=20
>>>>> So, instead of only sending me a trace, could you please:
>>>>> 1) apply this new patch on top of the one I attached in my =
previous email
>>>>> 2) repeat your test and report results
>>>>=20
>>>> One last thing (I swear!): as you can see from my script, I tested =
the
>>>> case low_latency=3D0 so far.  So please, for the moment, do your =
test
>>>> with low_latency=3D0.  You find the whole path to this parameter =
in,
>>>> e.g., my script.
>>>>=20
>>> No problem! :) Thank you for sharing patches for me to test!
>>>=20
>>> I have good news :) Your patch improves the throughput significantly
>>> when low_latency =3D 0.
>>>=20
>>> Without any patch:
>>>=20
>>> dd if=3D/dev/zero of=3D/root/test.img bs=3D512 count=3D10000 =
oflag=3Ddsync
>>> 10000+0 records in
>>> 10000+0 records out
>>> 5120000 bytes (5.1 MB, 4.9 MiB) copied, 58.0915 s, 88.1 kB/s
>>>=20
>>>=20
>>> With both patches applied:
>>>=20
>>> dd if=3D/dev/zero of=3D/root/test0.img bs=3D512 count=3D10000 =
oflag=3Ddsync
>>> 10000+0 records in
>>> 10000+0 records out
>>> 5120000 bytes (5.1 MB, 4.9 MiB) copied, 3.87487 s, 1.3 MB/s
>>>=20
>>> The performance is still not as good as mq-deadline (which achieves
>>> 1.6 MB/s), but this is a huge improvement for BFQ nonetheless!
>>>=20
>>> A tarball with the trace output from the 2 scenarios you requested,
>>> one with only the debug patch applied =
(trace-bfq-add-logs-and-BUG_ONs),
>>> and another with both patches applied (trace-bfq-boost-injection) is
>>> available here:
>>>=20
>>> https://www.dropbox.com/s/pdf07vi7afido7e/bfq-traces.tar.gz?dl=3D0
>>>=20
>>=20
>> Hi Srivatsa,
>> I've seen the bugzilla you've created.  I'm a little confused on how
>> to better proceed.  Shall we move this discussion to the bugzilla, or
>> should we continue this discussion here, where it has started, and
>> then update the bugzilla?
>>=20
>=20
> Let's continue here on LKML itself.

Just done :)

> The only reason I created the
> bugzilla entry is to attach the tarball of the traces, assuming
> that it would allow me to upload a 20 MB file (since email attachment
> didn't work). But bugzilla's file restriction is much smaller than
> that, so it didn't work out either, and I resorted to using dropbox.
> So we don't need the bugzilla entry anymore; I might as well close it
> to avoid confusion.
>=20

No no, don't close it: it can reach people that don't use LKML.  We
just have to remember to report back at the end of this.  BTW, I also
think that the bug is incorrectly filed against 5.1, while all these
tests and results concern 5.2-rcX.

Thanks,
Paolo

> Regards,
> Srivatsa
> VMware Photon OS


--Apple-Mail=_4DC1C4F9-FFD5-4309-8346-630474A6C16C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEpYoduex+OneZyvO8OAkCLQGo9oMFAlzlEpcACgkQOAkCLQGo
9oPdEw//WxVy6NXqpJ3PDhtxBUM+Q1PcVKlaTaCBteRnbxyptYxJJuedsDp9j1O1
yU2XB75LNHy4NFLIVAqvdtSbmGpSl16XgFEq3t4/f5dGd066RhiV8f4APnQuqXHm
MlwYjL6BdqYzP7MUCA7xBM0eNztJmHMpisG/ox1fpk4/YrJm0N9y0LHSxazPOaao
dsRUqa97+tT3znMqFgTwGkfsYUZcuKc+nyQuZaFUwwKww8SqJYVTSXtcE+BIsngu
tyw52Ty26br/9An4BXGXiDOXzB45s+AsvpJK+kntxB9BqSLnvCTNAWqPSJyvoHgn
8DJvTjqHk53JsGuEs0kie3mGVB7VbDQ2ljRYhbYx11pVYKSxvS0ykmMKMd64Vyyb
/VbB7q8t3cfpCU1YPsWUPjeiZIBkQNqlYsdhA1AclUMMEAo5k7nVZEG1tlvZrL9t
D4sY5nOxd5shFqEb5wwxlMvmoLh7VP3bkxfuDetg/fKBT5HvsNcYrgX7EgumrM7j
O+5KsvvhH/JbAXg70sicLqBZZGeXWf9s7lPO3JdVkoTXy2VaaQuFGocTN2tzMYhx
5058wdhCYh8wnEJ3L+13JQv/P88WNiYkCzMJglsp7MKOFGWv7gzcyARTqkuhjm4h
x5nNzFvvG6VWQi1LIWCMEthAWWoo+F2QDvHi71g890jQLrE0Ibg=
=EX0B
-----END PGP SIGNATURE-----

--Apple-Mail=_4DC1C4F9-FFD5-4309-8346-630474A6C16C--
