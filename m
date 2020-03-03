Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49A81176D98
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 04:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgCCDj3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 22:39:29 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:37400 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726928AbgCCDj3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 22:39:29 -0500
Received: from mr3.cc.vt.edu (mr3.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 0233dR09013829
        for <linux-fsdevel@vger.kernel.org>; Mon, 2 Mar 2020 22:39:27 -0500
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 0233dMDS032729
        for <linux-fsdevel@vger.kernel.org>; Mon, 2 Mar 2020 22:39:27 -0500
Received: by mail-qt1-f198.google.com with SMTP id u22so1365740qtc.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2020 19:39:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=FTbJOMePSTPFZUgojgxvDoh7xnLDmsFnL2EoLai2PSI=;
        b=EDk+Ynuj673hajg/O2+uHzOu5a6ZhgZvjkFv4VoIe8Cxf36+1qd9I2vRXPPVt8Lnog
         Gs/ySA9XxlyyiCFupQJyUBi8dqWhu/xHw0mqcfwmKdSnsL5UfZus3Y8DAUmdnbqAt8PC
         /1543e6kJ/omfmX+z+s67Yr+q5q7qFSSf16V/K9Md0D36cse3emYq3yagXRv4zBDs+d+
         gan0thk5n8dtE6cRRofUJJKWUjtshLMxOiMh85xMbUt2kz3zU42JAztNkG1DciHbtkhS
         K40+AkJc5qGEvxAuw31qHK2kN1ZTJQkSbXOW8IorhUDceCKePMLwF0HWND9GBZt4Um5v
         VMMg==
X-Gm-Message-State: ANhLgQ2ojbJh8aYxXSgQ+MA7aU5fQLNGOcCkvai2QavjG6UVTDmCtgrJ
        gDTLyNNQ8FbJkaLgATZZTNzrlVSe9htjL5q95og/Pz1YwGCFcIcKZ3NRgXB0suWU5SoOAfyDrmY
        R1VnkfKf232AYNZW9ZFUNeL3U0iIBI5Dv8f1D
X-Received: by 2002:a37:a7d2:: with SMTP id q201mr2452449qke.144.1583206762111;
        Mon, 02 Mar 2020 19:39:22 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvwQMeMav5A4bTYMSAhdKnSSxWMCEzktF52MG9KJML2CW3SBd0QJ/NKuQgC8ICg1bjcB7PuLg==
X-Received: by 2002:a37:a7d2:: with SMTP id q201mr2452435qke.144.1583206761795;
        Mon, 02 Mar 2020 19:39:21 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id w13sm4637470qtn.83.2020.03.02.19.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 19:39:20 -0800 (PST)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Cc:     "Mori.Takahiro@ab.MitsubishiElectric.co.jp" 
        <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        "Motai.Hirotaka@aj.MitsubishiElectric.co.jp" 
        <Motai.Hirotaka@aj.MitsubishiElectric.co.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] staging: exfat: clean up d_entry rebuilding.
In-Reply-To: <TY1PR01MB1578983D124E99FB66FB707190E40@TY1PR01MB1578.jpnprd01.prod.outlook.com>
References: <20200302095716.64155-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp> <240472.1583144994@turing-police>
 <TY1PR01MB1578983D124E99FB66FB707190E40@TY1PR01MB1578.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1583206759_2391P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Mon, 02 Mar 2020 22:39:19 -0500
Message-ID: <295313.1583206759@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--==_Exmh_1583206759_2391P
Content-Type: text/plain; charset=us-ascii

On Tue, 03 Mar 2020 03:07:51 +0000, "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" said:

> > Are you sure this is OK to do? exfat_get_entry_type() does a lot of
> > mapping between values, using a file_dentry_t->type, while
> > fid->type is a file_id_t->type.

> The value that vfs sets to the old_dentry of exfat_rename() is the dentry value returned by exfat_lookup(), exfat_create(), and create_dir().
> In each function, the value of dentry->fid is initialized to fid->type at create_file(), ffsLookupFile(), and create_dir().
>
>  * create_file() <- ffsCreateFile() <-exfat_create()
>  * ffsLookupFile() <- exfat_find() <-exfat_lookup()
>  * exfat_mkdir() <- ffsCreateDir() <-create_dir()
>
> > and at first read it's not obvious to
> > me whether type is guaranteed to have the correct value already.
>
> A valid value is set in fid->type for all paths.
> What do you think?

OK, that's the part I was worried about, but I hadn't had enough caffeine
to do that analysis.  Thanks.

Acked-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>


--==_Exmh_1583206759_2391P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXl3RZgdmEQWDXROgAQIYeRAAkZo7uu42LhGq9PsreYrqUXNm0xB/XGj6
NZAvcAtGjsf20gasBoa0nkBE+yxBisOxu2z25nTVC6blNonyQPjBWf8S5iQVb5gd
vmC/yboWHfQHRXhPmOSod8FK1FjrqnAKV/+EBcHvcRcpqR3BJpBN89pckVAuFVKj
N5WJ+Guyaqhm8pNdllTla8uL5TvvpH3BOu9+y7l4vAgkJvkfjM3crScCXAlpxzmY
EBx4NL8RSvUuhcE4PTszpYebplIe8FmfmVGBb2YoOMVchKS72swX0ME7vy2KdaoE
7ZvAggB02ZuqSucoZonDTqrK5jLYcl7xbQBWfuBlQN10mi+wxL66HcKmsehLjjlS
q/qJWiE7cHjSPz+3cIVWqogYazOHF0j8clQGRbTPgo/SDBca/pAVlHOck80HCGTl
5YQWWBehNiqNC5UAODnQz4e0/RmORnecgq62NLaMgjUo6BoxgW5SEJxPJFpriACH
NwjVHB4km/xJwOSulIOIsMki59GoXSyaBtRVPYGV/ZqenE2rCBn9TYY1JKoLtXKQ
OLDnkSmN4VOxBh6RPZWNZ5hKDdbZ0TpyoqmpM+jxm6t2IvGG11ZZcgFWB31ZrD4d
dD1oX7QNpXu6CxAFWzBEk6sIGIdFNGHQ1NdMQYXTF/9Zhis0zufS/tmTtAhtNylk
qgb07J+8a1I=
=keUw
-----END PGP SIGNATURE-----

--==_Exmh_1583206759_2391P--
