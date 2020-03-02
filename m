Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3578175859
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 11:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgCBKaD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 05:30:03 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:33520 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726654AbgCBKaD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 05:30:03 -0500
Received: from mr4.cc.vt.edu (mr4.cc.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 022AU2fa021049
        for <linux-fsdevel@vger.kernel.org>; Mon, 2 Mar 2020 05:30:02 -0500
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 022ATv0j014287
        for <linux-fsdevel@vger.kernel.org>; Mon, 2 Mar 2020 05:30:02 -0500
Received: by mail-qv1-f70.google.com with SMTP id cn2so8344605qvb.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2020 02:30:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=/VcLffZUTgvTWC8ZFO3N6mDeTTtIIDh0TAgvcx3iXEw=;
        b=JpH93CAnNJtjixDnMN0tm9oBBDWoesntoVBv92afK3vMJZNnwQaVdnP6SF/4VVRxHu
         zL/PFjGKDTzVSA3+k4vt//B7lvQmRplOg9gCD+83yTqf4MX5oUBN8rTnLy3FYljIVAhF
         Tw6vM2JKkH58nnSzsFNdXHsAQ581Wh8IgRqZo5Ggy1MOmBEQBzJ+AoTWM6J1YF5IuSJM
         dg+o1+TyNKy5Ukbx5w+OHGSNc33oxpm4kEtuAAyj6freIWrvuZLg7bRlvtykqDaQ3z2+
         4hwqU5gsn5G3jMP1GOJgcdIzE9Apy04rpET52UvhCrMyUPLF7vkVgQNWE557Cb5cOYOF
         0+Qg==
X-Gm-Message-State: APjAAAWHAlV3CfPCdnEnLvIlYzaMKefiKGWAFq4OUBXIIKduNwvvd7OS
        t5W4BAOpBa+k6vKAxELMKwnDpdSPMsi1e+Vd4tQGQBn030o3ap3gsL+IS+U62tClegEpjFW62Hu
        koqDrtU1/0BzlbYkWB5odBmHOzPiYeE3kHQZh
X-Received: by 2002:a37:4e53:: with SMTP id c80mr14345723qkb.58.1583144996945;
        Mon, 02 Mar 2020 02:29:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqwBh6WXMWHNRoxL92FxaSm7tZWkWljn+/lubfFhH1jeDvkVwJTYHB9DmVs0hkAFcj5IVD9Bog==
X-Received: by 2002:a37:4e53:: with SMTP id c80mr14345713qkb.58.1583144996622;
        Mon, 02 Mar 2020 02:29:56 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id j17sm10248504qth.27.2020.03.02.02.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 02:29:54 -0800 (PST)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Cc:     Mori.Takahiro@ab.MitsubishiElectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: exfat: clean up d_entry rebuilding.
In-Reply-To: <20200302095716.64155-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
References: <20200302095716.64155-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1583144993_2391P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Mon, 02 Mar 2020 05:29:54 -0500
Message-ID: <240472.1583144994@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--==_Exmh_1583144993_2391P
Content-Type: text/plain; charset=us-ascii

On Mon, 02 Mar 2020 18:57:15 +0900, Tetsuhiro Kohada said:
> Clean up d_entry rebuilding in exfat_rename_file() and move_file().
>
> -Replace memcpy of d_entry with structure copy.

Those look OK.

> -Change to use the value already stored in fid.

> -		if (exfat_get_entry_type(epnew) == TYPE_FILE) {

> +		if (fid->type == TYPE_FILE) {

Are you sure this is OK to do? exfat_get_entry_type() does a lot of
mapping between values, using a file_dentry_t->type, while
fid->type is a file_id_t->type. and at first read it's not obvious to me whether
fid->type is guaranteed to have the correct value already.

(The abundant use of 0xNN constants in exfat_get_entry_type()  doesn't
inspire confidence that it's looking at what you think it's looking at...)



--==_Exmh_1583144993_2391P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXlzgIQdmEQWDXROgAQI58g/8DOieHjL/SZ7yeem2t4q7TX4M9CzzWBEA
gCgEpSqWrxEfRPn4OfLS/S6CMQtDPrdv8mDqvmNIRa0S27G+kvvCdOVbIYDnDIHD
uqUmHKhPoUdTH+6k4XXErNBO4hG0NlpFAAVEpyY0x3Yo8zK5a6kW9NroYknqHq0g
/zafLt+WTiwU4InxRznidC4UvQ9Dvi9hMUnEzziYuR/E11ruzpQjfc8gcCkRawh0
F2bgfjwXhAFdyXGhkJdcfeNjXRMgFUPy4a0fVK32uxSo3kfYJYX0cSzSspkCoZm2
bIWbR0pg/Lx/AjH1V5JiTK+EQixeC0ujAXmbzGVT2H16cWSMqnFbmVVjRgSBY0fI
Y/N8HHyLxUx5u87b6B97wvNZiExkDID38Br05uFuOIasOMOMs3fE3mpJ7/J/FRFd
dUXKZJ6+wni8X4kZVHTleUuZVtQK0hSTZBj3wOL7prAn9uJiCP3b7t6MdfCOegV6
VcKJyhLvu6LmByPunjU75UTTmWj3dMGYdYDFEDD+jfHBXMh0AX54rHwy4jO0BwU2
/X+YrqpbOWL8C7+1E//vJq00X+CNyNG98iJ1QJWJV7EOUrUTnnLUa11+DLc9CUtB
R6r7VF469EJ7MfZG8L0keg5eLSNUQL2H9I8FU1id0xrHxJ7HQtH9lz6Dav1+Bnj4
bOOVWDTwOt8=
=DpqH
-----END PGP SIGNATURE-----

--==_Exmh_1583144993_2391P--
