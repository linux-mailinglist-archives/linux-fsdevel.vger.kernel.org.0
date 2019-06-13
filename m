Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEB9B445B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 18:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbfFMQpy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 12:45:54 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:33765 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730322AbfFMFqU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 01:46:20 -0400
Received: by mail-wr1-f54.google.com with SMTP id n9so19316740wru.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jun 2019 22:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=+KC+G8mdsFHRq3fTO8qSFdNuM/o8bUU5Ws1W0tY9nMQ=;
        b=fcMHhd8SlQkGpmu4B4nnHAcWQF7KwY2oVV3mNcGcuZAm4mu6blLKC7FPW5p4xwO0k4
         ElkPvnrtllGvpBASvZHiwuIorqIrmYPY1qDm4otU9sYAlokfFwYlR4PR2pE8qjSxJ2bv
         Cc+n3yEeKCFqbEXJLo7edU2gB4dYlbZHfUPcT4pMQ8U0cZqodb/v5NPuEnuAp7VrL9N0
         bZEESFOJmsJ97ksQTSUutEBELnFtWGZo8oAQ+JLQxVoFeSB81OPPH9JWwTl3JqqBruas
         4CREGmjevp7mkIo8lNxjmg3TZAzNDJaThvyulLFtw+2h+imVMSsk2+eDbUEoGTrUF22T
         NjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=+KC+G8mdsFHRq3fTO8qSFdNuM/o8bUU5Ws1W0tY9nMQ=;
        b=Ld711A0D4A92vT/DBEJBukX0TED+25kx5UiDbZo6ydM/92f3q+/BdbheL3j30AgwUt
         +AdXu7sjrowA0A7DwCS1FMH/jjVbbCMOQHVF2kc1qV+3Hhy4q02PqNaTCJEeHGLZ9ga2
         +pObqdnzA9IaaZ4TXTcHTKt0AO+7BICL7F0ohxgy/2MWzL9J0RCThg7IUP0tRh7jKG3A
         RqIJaKe+l9d+mRypWx/g+QEpBx/SxWyD9oFnj+evEe50O23w3uoSAPEotWqz6RXbD7A5
         bU7HmmF4UP5Dp09GekrQCHsRRr5Zvlmh6RXUY073G+v14Xyqv+bvcTmyWDIlG6CDy3uQ
         96pQ==
X-Gm-Message-State: APjAAAUjYE0x6HtT6/OyxhAGn6Bk24ESQmfcvhHeKR7PFVr4QQSh2OD0
        iyJaRBU97Lp3Un1NlGoUmXfGTA==
X-Google-Smtp-Source: APXvYqw/aYOTu9cU/Ok5QkUUC38n3D+JffJJRYpP42j/6jsR85bV4Vha18mx5IR6w74L0iQ1L9eZ9A==
X-Received: by 2002:adf:ebc6:: with SMTP id v6mr14275239wrn.222.1560404777633;
        Wed, 12 Jun 2019 22:46:17 -0700 (PDT)
Received: from [192.168.0.102] (88-147-71-233.dyn.eolo.it. [88.147.71.233])
        by smtp.gmail.com with ESMTPSA id z14sm3164273wre.96.2019.06.12.22.46.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 22:46:16 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
Message-Id: <43486E4F-2237-4E40-BDFE-07CFCCFFFA25@linaro.org>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_C82715EC-E52D-48BB-975D-458C5D643A93";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: CFQ idling kills I/O performance on ext4 with blkio cgroup
 controller
Date:   Thu, 13 Jun 2019 07:46:12 +0200
In-Reply-To: <7c5e9d11-4a3d-7df4-c1e6-7c95919522ab@csail.mit.edu>
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
 <7B74A790-BD98-412B-ADAB-3B513FB1944E@linaro.org>
 <6a6f4aa4-fc95-f132-55b2-224ff52bd2d8@csail.mit.edu>
 <7c5e9d11-4a3d-7df4-c1e6-7c95919522ab@csail.mit.edu>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_C82715EC-E52D-48BB-975D-458C5D643A93
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> Il giorno 12 giu 2019, alle ore 00:34, Srivatsa S. Bhat =
<srivatsa@csail.mit.edu> ha scritto:
>=20
> On 6/2/19 12:04 AM, Srivatsa S. Bhat wrote:
>> On 5/30/19 3:45 AM, Paolo Valente wrote:
>>>=20
> [...]
>>> At any rate, since you pointed out that you are interested in
>>> out-of-the-box performance, let me complete the context: in case
>>> low_latency is left set, one gets, in return for this 12% loss,
>>> a) at least 1000% higher responsiveness, e.g., 1000% lower start-up
>>> times of applications under load [1];
>>> b) 500-1000% higher throughput in multi-client server workloads, as =
I
>>> already pointed out [2].
>>>=20
>>=20
>> I'm very happy that you could solve the problem without having to
>> compromise on any of the performance characteristics/features of BFQ!
>>=20
>>=20
>>> I'm going to prepare complete patches.  In addition, if ok for you,
>>> I'll report these results on the bug you created.  Then I guess we =
can
>>> close it.
>>>=20
>>=20
>> Sounds great!
>>=20
>=20
> Hi Paolo,
>=20

Hi

> Hope you are doing great!
>=20

Sort of, thanks :)

> I was wondering if you got a chance to post these patches to LKML for
> review and inclusion... (No hurry, of course!)
>=20


I'm having troubles testing these new patches on 5.2-rc4.  As it
happened with the first release candidates for 5.1, the CPU of my test
machine (Intel Core i7-2760QM@2.40GHz) is so slowed down that results
are heavily distorted with every I/O scheduler.

Unfortunately, I'm not competent enough to spot the cause of this
regression in a feasible amount of time.  I hope it'll go away with
next release candidates, or I'll test on 5.1.

> Also, since your fixes address the performance issues in BFQ, do you
> have any thoughts on whether they can be adapted to CFQ as well, to
> benefit the older stable kernels that still support CFQ?
>=20

I have implanted my fixes on the existing throughput-boosting
infrastructure of BFQ.  CFQ doesn't have such an infrastructure.

If you need I/O control with older kernels, you may want to check my
version of BFQ for legacy block, named bfq-sq and available in this
repo:
https://github.com/Algodev-github/bfq-mq/

I'm willing to provide you with any information or help if needed.

Thanks,
Paolo


> Thank you!
>=20
> Regards,
> Srivatsa
> VMware Photon OS


--Apple-Mail=_C82715EC-E52D-48BB-975D-458C5D643A93
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEpYoduex+OneZyvO8OAkCLQGo9oMFAl0B4yQACgkQOAkCLQGo
9oNOVg/+KTDsN0F9V0g74Et2TxDdqnhABWgQ3HrajfUnRzmLdMR0Tx0C0YUBZM5t
S3xp4ofC2oP3HItm6gJ+z+Pw/6K+C5k8cd09zRh9W9wkw4dLGXTuotakmMupTpyT
XTymYIUfHt72H42arlX0dxtoPkhMMRuP7PXKtvbLun4dLiErjGh03Lvs139EQvyJ
L65pJTeoIaTT7r+MlblZkmaVRpqG/XF8yRzRNg5/pSbkvPhegZsJC7pMMdjwLsK8
1skizw2Nt1G24RqGSuofRti9lCDPKLSND2t4xBUZ1BWN93f9Nz3Zm8m9ylWiCNGE
c0G3RpRTknqxbYtkPUr71MJZ63Hl2d5F/02XUkZGkSo7EtOoMKiKCg6VzzIq24JP
gxL/lMoVO27+JM9DWBUBvdWxkOHtvD1JRAaGX9VWqTi7ksUFDlFHOF83Udyj5HBz
PJS2TL5dQ+X+l3G7nD3YHJCwSD2+DC1rZPQhj75BGu1CBnGXaEHtEMn3CfmVVQpL
H0pVqIyF7lnJJu+vEYuea73RfnfSi4FU+MpFFYFCG6fElqUik9X7IzCQRcB6ianK
vqNbdqMwq9BeFgwm3f09fKzc6JdkBu0YApmPJp9mxeYkvQLJYLxGlyYnUU7ottDL
4QlYZevYyTv9G+O8HM/l8PuET7+X66xi8Dlj5oGnURXNmRLh64g=
=PUTU
-----END PGP SIGNATURE-----

--Apple-Mail=_C82715EC-E52D-48BB-975D-458C5D643A93--
