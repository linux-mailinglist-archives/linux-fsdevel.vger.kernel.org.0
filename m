Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48938E3878
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 18:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436661AbfJXQpP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 12:45:15 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:36110 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2393979AbfJXQpK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:45:10 -0400
Received: from mr5.cc.vt.edu (mr5.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:72:232:758b])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9OGj9Md006608
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 12:45:09 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9OGj4x1002563
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 12:45:09 -0400
Received: by mail-qt1-f200.google.com with SMTP id q54so23245333qtk.15
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 09:45:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=1k/OHruc2b54fj2ZTH33R/zhw5wiURkFRV48Xs6l6kQ=;
        b=Z7cLT1zuw8nyu6CusnvmNBy7oDfnLPuYwZr8KNfmiRgK9NT+xFvCYsD7mcyVcXS0tS
         av4Pw6DNusvXye6khCLOOVn81Bd5NFhnjOemiE7ou81WalmMRX5yqyn+X5DX00LosB9e
         2Tr91HZOy0oSydMd2G0n0F1LnthogDKSSzjzf/HHwX4eEcwi7kmWfQCptZLS+NmSXFgw
         tGe0WcXPn7D8KXY2g6h0sN2VC2k4yNvlZK9m2lgJ/f4WDSuJBwM8GzMvBdFGSd5xJFJu
         vkIuOgw6xQcv03BKe6VF1il1NKDEKf1hcwGRv67yFSCldC4vv2uI+HQJzgJzUvcB5Bay
         h7nw==
X-Gm-Message-State: APjAAAWY4mU6fkWsmS5ZX9zAyVubHIWai2GoKMC/hA8pQdBIfDbzLBeH
        S+9VKDD1/DSfkhDApdCd/S/1gjGr9gnSp0rK0PzqkjG2AVzQqhjhpdi/j/c+6eK5lPCVIy5Onjc
        IDawG2qp89KbcN+3j13RJzJUKkPyJTqaLwoov
X-Received: by 2002:ae9:e8c3:: with SMTP id a186mr14144563qkg.97.1571935503639;
        Thu, 24 Oct 2019 09:45:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzPmugAIBdJbLw5E7Sxj5nx/GCPtHQUdyKIKhqTlpoBsI7n1U229JrkQCk9r/OOO0i4y5A1bg==
X-Received: by 2002:ae9:e8c3:: with SMTP id a186mr14144530qkg.97.1571935503279;
        Thu, 24 Oct 2019 09:45:03 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id y10sm14239753qkb.55.2019.10.24.09.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 09:45:02 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/15] staging: exfat: Clean up return codes
In-Reply-To: <db3315695d3ea493e05f63f3b21fb3a1482293fd.camel@perches.com>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
 <db3315695d3ea493e05f63f3b21fb3a1482293fd.camel@perches.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1571935500_59326P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 24 Oct 2019 12:45:01 -0400
Message-ID: <1116230.1571935501@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--==_Exmh_1571935500_59326P
Content-Type: text/plain; charset=us-ascii

On Thu, 24 Oct 2019 09:23:24 -0700, Joe Perches said:

> All well and good, but does converting the error code from
> positive to negative have any impact on any of the code
> paths that use these return values?
>
> 	if (error > 0)
> vs
> 	if (error < 0)

I was keeping an eye open for that, and didn't see any.

An interesting case is the FFS_EOF patch, which fixes an actual bug. If you did
a read for length 0, it would return FFS_EOF (==15) - which would be
interpreted as the number of bytes returned by read().


--==_Exmh_1571935500_59326P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXbHVCwdmEQWDXROgAQK2bxAAoiL4k5jX4a3hoTsKKCckfkYTxrHif6dM
u+mgSh7iFo0wQZvdt+Fyihcy2gPDWR6cEbnuEkgRE5PVyHzGjSJjsLPVB6Vwwyf3
78crIJ+HlIHyr/mjZD3RPs9Nqaev77jojfXupvn83aqcIFtAZ10olVXkNq0ZGWiR
O5x2dfxxH4c8sfDDi+UjBrzNblARpPn59pBT6Ae4CMNJ+Skwe/NIQv8wQrmgMnlQ
dbvbGr8bERy0tbenq4fKIvU8T8cmjaBH1ddceUsdxlTGygKJlSKi2DQuMj180IDd
jN7tcZSPzXnHuyrr6Hy1cwyFnvgj+vMC6hv4Ifl2QUhnUXkBVURa2a2jVXvdnSna
B3dZxniAKAB1xhG/0FNAqBpRFx5hAL5X06LrsgEVTjBzacnq6T0oqp0NSiuzL1UA
8qsZvcHAd6SFhpPtt9PMXcRkCSrjcoGK9Ne9d98HwAShS7tnX5AxyFbKdKBQLZjV
FV7/KmS3O56tmQm4zFblgIAsBk8VjWZyo2roimEWZWTN66TjfUZ/66F0tPFIsHXb
WQRs59YLkRqjzZPxJCTfO3hmjcfUt2je9dkQ8aHeI6NX/r9IFb/V9X/lzyFOsL+1
26Oxy8YWftofOBz/9lwMORSbQa+2Q4bujhaRcHYccKDtkDHps710UJIy4BeJjLps
CjuTWTdQoWc=
=xOuK
-----END PGP SIGNATURE-----

--==_Exmh_1571935500_59326P--
