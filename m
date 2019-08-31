Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFBAA440C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2019 12:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfHaKbz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Aug 2019 06:31:55 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:39216 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727404AbfHaKby (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Aug 2019 06:31:54 -0400
Received: from mr3.cc.vt.edu (mr3.cc.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x7VAVr1b022178
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Aug 2019 06:31:53 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x7VAVm4A024982
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Aug 2019 06:31:53 -0400
Received: by mail-qk1-f199.google.com with SMTP id k68so10058631qkb.19
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Aug 2019 03:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=IDGw4t+jkka64Wht6d3CAXrxONGQFYzW5tFrvF9rQ80=;
        b=oB2jBOhdRavntYtw/av7+RE3oex+UTO2i54QNfqXvqBVM8E5ucN3TAh36ZixIEq04u
         VsBQW/WCVaXYkEMDXy/lM6lrY1PcFQoE68k61xAU4Hvs1LoYJPMfK+cTuDjvdilRI3cZ
         4ASp5z/q+AcQCV4t3TIlLdLzpqmke4R0CWDqRM+SP0cjgC9HZ4e0IzorRmDtenNFf0Ct
         4QQwVZFPpVUr4ZWnkqi1h1Pt7UZN+4pP3wad1mGIv2uscFDf+ulQy3YPIYv4EdMHsyWl
         Z9l0s0VfNM3Jahk80MG3b3j5HXDT+TmbSPPoaAE3PjA+uaE05pP3/aIezoFBaVzgx41g
         C8rQ==
X-Gm-Message-State: APjAAAUEi7umFDTSgBm6j+xCXfxlTrs1XYBHmDbnZORkR4IVtpHF/FtX
        O5+Qh9mmdt3fHab3FaDNBMKDsVgV0Z1yM4eNAWS9WvZM60WkT8ktVmFErpwR9rgM1827aWHtYdc
        kTWOsuqbEvyjPchJlB9If8ksUUiOai+YV8a1i
X-Received: by 2002:a37:8c04:: with SMTP id o4mr19360120qkd.163.1567247508227;
        Sat, 31 Aug 2019 03:31:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwY45aL6/n6Q+yi+UlWzypyRQEmcFtucMm/svMFPIxtNeXRyUsVRUo0F9jcenYO+qbRIHxMog==
X-Received: by 2002:a37:8c04:: with SMTP id o4mr19360098qkd.163.1567247508020;
        Sat, 31 Aug 2019 03:31:48 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4340::ba0])
        by smtp.gmail.com with ESMTPSA id 22sm4217243qkc.90.2019.08.31.03.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 03:31:46 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Dave Chinner <david@fromorbit.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        devel@driverdev.osuosl.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
In-Reply-To: <20190830215410.GD7777@dread.disaster.area>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org> <20190828170022.GA7873@kroah.com> <20190829062340.GB3047@infradead.org> <20190829063955.GA30193@kroah.com> <20190829094136.GA28643@infradead.org> <20190829095019.GA13557@kroah.com> <20190829103749.GA13661@infradead.org> <20190829111810.GA23393@kroah.com>
 <20190830215410.GD7777@dread.disaster.area>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1567247505_4251P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sat, 31 Aug 2019 06:31:45 -0400
Message-ID: <295503.1567247505@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--==_Exmh_1567247505_4251P
Content-Type: text/plain; charset=us-ascii

On Sat, 31 Aug 2019 07:54:10 +1000, Dave Chinner said:

> The correct place for new filesystem review is where all the
> experienced filesystem developers hang out - that's linux-fsdevel,
> not the driver staging tree.

So far everything's been cc'ed to linux-fsdevel, which has been spending
more time discussing unlikely() usage in a different filesystem.



--==_Exmh_1567247505_4251P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXWpMkAdmEQWDXROgAQJ88g/+L8aZBmGh/szeaXflnEcMn79pb3NyBxih
+ZtyT6+w4tFSdaj5tNw2bqM+p/gNl7wEdZj0UsBmCZaogZi95/ZfawiJ/Fr/Ck5g
YAa6JJCa8KJfl5TwC3ojDmHSc92/zqivcB4DY58rjLkeHe6b0RkouQZVLGsLtGYY
3VsID8G7CKOVkBzGLOyv6xHpjcOg125ulCd+eoQw5Z2GHL7/50JDvy2TpAYlxut8
kGK07Fs2pwQMxDBMbxTS51qSGu51ZscURPt6jUGpqSEa1a/1x/y5fuILeoxyy9HO
hSrqc3lXnvbL7+0mXIqg7cm62kJ72GmGoE6mNwuG6Z9q0T7uK/0rT0Ffnnopf/b0
2cZz4+xTMJVeS3cZQttHVN9XNgq2DajdoDLNWFgTiPABIdRsaBeUrGRIzwbeTYRH
xESRCtZpePDBDWvu7q/IyuQoQJHWq7oqEHOTE0SJ4cZvycEnsf1AN6oN4ES3Umqs
ZQmPwjtm7vu10SsJPEYoxZQPau5qq/vPr9lF0pMW8J9fUH4Ro45wD2sSgllVBqQj
2PF59qNEfMzwuUiX8+Snb/cKChD6wzpMuz18+m1wEZGzuvybpdZITp2HofmRbovD
Dr+BttOImxJB7tpyJKtoRkr5A0Zf4pxk1RambfMqxtUtsJSr7JxCiH24nthjR0gG
ONk8TCj1hSg=
=xo/v
-----END PGP SIGNATURE-----

--==_Exmh_1567247505_4251P--
