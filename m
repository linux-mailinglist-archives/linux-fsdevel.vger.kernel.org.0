Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15E7BB4642
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 06:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbfIQETq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 00:19:46 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:51886 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728275AbfIQETp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 00:19:45 -0400
Received: from mr3.cc.vt.edu (mr3.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x8H4Ji0X025195
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2019 00:19:44 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x8H4Jdsw010893
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2019 00:19:44 -0400
Received: by mail-qt1-f199.google.com with SMTP id f15so2386908qth.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2019 21:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=4Uxy06CS4wSQ81eCVHfxRv9J152NHpquq1sd63pwycc=;
        b=L1ksvrNPmgFOqyOEcm145gpnAEMQ0dmmcATMa0Fk5MFMrAufIxVqLqGwAwdQbvZ351
         Sn2GFL3JrniBfYizEy6c89bjpx+v+VyAmtblZ4LW6RDX0DU9RQa3sAU4LIMxiE1E020t
         RRgWs54F6p6P/uATgtCyPdZjIgbmx277dNEg4CVZMRuWzpWZ9hKh/KPMa4YWPTqvZ6mf
         trmN070at0ykw+7s8URq/dyKZ5BUzyq/xB1sWCjHY+omLWI2ZiBBmxXLJVeI5+HW2QVP
         iKlmkL4PauZwRtrHCXjpOXgsvAaQP0O4nQq+8evwnQWrV+zhclmcfn+adb077VuO20G0
         4UXQ==
X-Gm-Message-State: APjAAAWn/RXFUsRG+QYVaZGqMwZ3AOtdh3jul7gY3TkB0MUymmKv7n6y
        VQCCraUPtQibLpxpMc4aDjmWs1IsrX2jGWcXMBxrXGrEvfzesbt7d3R3TUGtHFnhO46jVpJUl/+
        tvNe1E0KVBNngOucF/QA9arI6c9XSd2GivDUV
X-Received: by 2002:a37:3c4:: with SMTP id 187mr1709433qkd.424.1568693979356;
        Mon, 16 Sep 2019 21:19:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyTkGscHLC5Mm8Ddz+ZkfN1sf+b4s6OeZaJW4YViOQb7XVGM3mlSEzQ7WpdH90fRajQlmWSQw==
X-Received: by 2002:a37:3c4:: with SMTP id 187mr1709417qkd.424.1568693979095;
        Mon, 16 Sep 2019 21:19:39 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id 33sm680373qtr.62.2019.09.16.21.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 21:19:37 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     "Namjae Jeon" <namjae.jeon@samsung.com>
Cc:     "'Greg KH'" <gregkh@linuxfoundation.org>,
        alexander.levin@microsoft.com, devel@driverdev.osuosl.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sergey.senozhatsky@gmail.com, "Namjae Jeon" <linkinjeon@gmail.com>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to
In-Reply-To: <003701d56d04$470def50$d529cdf0$@samsung.com>
References: <CGME20190917025738epcas1p1f1dd21ca50df2392b0f84f0340d82bcd@epcas1p1.samsung.com> <003601d56d03$aa04fa00$fe0eee00$@samsung.com>
 <003701d56d04$470def50$d529cdf0$@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1568693976_2440P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Tue, 17 Sep 2019 00:19:36 -0400
Message-ID: <8998.1568693976@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--==_Exmh_1568693976_2440P
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Sep 2019 12:02:01 +0900, =22Namjae Jeon=22 said:
> We are excited to see this happening and would like to state that we ap=
preciate time and
> effort which people put into upstreaming exfat. Thank you=21

The hard part - getting Microsoft to OK merging an exfat driver - is done=
.

All we need now is to get a driver cleaned up. :)

> However, if possible, can we step back a little bit and re-consider it?=
 We would prefer to
> see upstream the code which we are currently using in our products - sd=
fat - as
> this can be mutually benefitial from various points of view.

I'm working off a somewhat cleaned up copy of Samsung's original driver,
because that's what I had knowledge of.  If the sdfat driver is closer to=
 being
mergeable, I'd not object if that got merged instead.

But here's the problem... Samsung has their internal sdfat code, Park Yu =
Hyung
has what appears to be a fork of that code from some point (and it's uncl=
ear ,
and it's unclear which one has had more bugfixes and cleanups to get it t=
o
somewhere near mainline mergeable.

Can you provide a pointer to what Samsung is *currently* using? We probab=
ly
need to stop and actually look at the code bases and see what's in the be=
st
shape currently.


--==_Exmh_1568693976_2440P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXYBe1wdmEQWDXROgAQIoqRAAm8jm/cfHwLtmt/GjplQFdaIBNROwXTcR
OTCa7aqyK0BzgwO9cDqRMwbGEDaN3ywuY6N9YqPsmhZfvZi57390XSXohlsbURw4
Q1ejw0aOlcKdzmSJJCm6/WMGE+DDLXTyDLowzTNXz39RfRx0y4bGu0JKiFr2QJh8
NaB1XRYo1BurpgyiwuWIqI+jrAEa1VvuSDSWSO/EL8BbJbxGbxJPnmjBkkLSpJlW
BnCTqr7ABrKSibxTGOeoDf/yX3Ce04HU11XBPoHNHqR8f1iUHZaCP6IhBUoxofAM
is3h8PZ/6e1YiME83PHpK4vllzcChhdVk9mxcMxMEpIzsIPLN70jQDhZ3z1G7iC2
eYRtkmBtBhdpDQt6CIQYwEffJB2X9yrfLNIhB5tw+IH94Eh4TgHiPFqxtEHlVSaT
WFHhyN954V+PAWL1brma3rxdY+xOK+IEOnY5DM5bW/c+YeJAIrur2c4iZLVHSRTH
kO0bFYOZ41WPThEJnyzzbtMz9HX0WdR+4A5QqIHnoqnmaTKviMAiMeAlor3rlrjk
RzfSfJUJ7oxOQVPpxCIB0/YJ+HtHXR9nEgKHvdCMmyCfb6/Pq2dqJrqQu9YbUPoW
NlRunOynwSQ5ipVKHwmwGTWyjeprRDzfMUObln77rUI03K8Vtap1he0fmjXlZTFl
x0yeZPkfRJk=
=mJjz
-----END PGP SIGNATURE-----

--==_Exmh_1568693976_2440P--
