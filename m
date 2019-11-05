Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCA71EF24C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 01:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbfKEAzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 19:55:03 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:50890 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729925AbfKEAzA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 19:55:00 -0500
Received: from mr5.cc.vt.edu (mr5.cc.vt.edu [IPv6:2607:b400:92:8400:0:72:232:758b])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xA50sw46017165
        for <linux-fsdevel@vger.kernel.org>; Mon, 4 Nov 2019 19:54:58 -0500
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xA50srmX026868
        for <linux-fsdevel@vger.kernel.org>; Mon, 4 Nov 2019 19:54:58 -0500
Received: by mail-qk1-f197.google.com with SMTP id q125so1945698qka.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Nov 2019 16:54:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=f2xKui4jCV1oC4mz8c3C4oOoH3JHAT+nc4LWmlpw1MY=;
        b=TVZyItYpd7OTqWyrCe8cek62161Heba/X+kmXSpy3D2Ybc8jYzxoTJavZFA5DA9Xdn
         vHg9V/PCEaXxis3vEK85hIc5VVKybbr5B3OQO99OBjBUItalcmIAx7SbDEaMAcltZVEk
         wJ+R326ktS7VuRNhQ5NMMYyBx03jgZe7X7VqCQy0FXNSsPtaLQtY/ZNTe1z5BxH8WvP8
         GK5kcn3bikb5ofyE6u7Lub02HvQ0GoqhnX+TRsUz8r7PVgI3lDbxzbb/A35VcUTzeeIs
         Oc/ihI3+lz9G/7DUocxTs02x+acvufOWvhWt7W0HNE594urei6ne3s4kX/spCE1Wcx9E
         iHNg==
X-Gm-Message-State: APjAAAXX+BVPvPtAddWiTwgU2MNZ+hzPVTQY2K1S5U7uOKoRGdK5Ihj6
        fsRhFrLl10q/GfL7OesyHThvw519MTUMovcJab+3A/Riad0KzZcWqGAtR0Ba4qgHKMdoiX76xhm
        tNuMoof4qX2Yi41wUXpmY0An4AllOYO/Y1suE
X-Received: by 2002:a37:a7c6:: with SMTP id q189mr18281716qke.469.1572915293232;
        Mon, 04 Nov 2019 16:54:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqyrX9VI+c8WOT6M7oWIp4pyDtJDt5bkVm4lsJ+Pto7z9dB2TfD2fE/LTt42veVX3e6Xy+Pgiw==
X-Received: by 2002:a37:a7c6:: with SMTP id q189mr18281700qke.469.1572915292941;
        Mon, 04 Nov 2019 16:54:52 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id q17sm14389538qtq.58.2019.11.04.16.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 16:54:51 -0800 (PST)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-xfs@vger.kernel.org,
        Jan Kara <jack@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 10/10] errno.h: Provide EFSCORRUPTED for everybody
In-Reply-To: <20191105003306.GA22791@infradead.org>
References: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu> <20191104014510.102356-11-Valdis.Kletnieks@vt.edu>
 <20191105003306.GA22791@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1572915290_14215P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Mon, 04 Nov 2019 19:54:50 -0500
Message-ID: <183873.1572915290@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--==_Exmh_1572915290_14215P
Content-Type: text/plain; charset=us-ascii

On Mon, 04 Nov 2019 16:33:06 -0800, Christoph Hellwig said:
> On Sun, Nov 03, 2019 at 08:45:06PM -0500, Valdis Kletnieks wrote:
> > There's currently 6 filesystems that have the same #define. Move it
> > into errno.h so it's defined in just one place.
>
> And 4 out of 6 also define EFSBADCRC, so please lift that as well.

Will do so in a separate patch shortly.


--==_Exmh_1572915290_14215P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXcDIWQdmEQWDXROgAQLCeRAAuaK/m71WLPW3IHgW8r5L9+3+x+9uaM3q
1xF50a4RrgesQOcgCjLxlCHEj7RzckAn1cAh8KCEfckr5crfRHSqOkSop9jE5A4X
BG71oLoyeYpSB1euVq/wxyUk7pk23uB3YfoPY3GD/zNUUxinrXRcc5AIBake1wfX
1tuIjSwBgO6HILMF7PKK+ETFDGBDXKUfzep/1ooWpKYzqbMyLkrd5iYQy5a9Fy3r
wbIOv0vg1dyMa3rcpFO6XKieD3yZkPO42lYIu6Te1wFnykmkCpgkMaOGP9/HWIPP
vkm2vDMS7gbWWYgbs2k0IsKKKTjhO+sapW3QbYNnxYEBgwYaIfaKhJGpqWQ6qoqR
Lr2OQWp/xv+g6bKr23kdXM+Iz8i6m38gl0LPwCa0K5I1WHSbelWoRniJ41jRcVeW
GPr6Hu+CZxD0nYigQV7AXFnlk2E8X525kiTffPz+KtMpUS8VzaSCMkc7GQMMdPbI
bZD328DLengZVicm271CUIiVhHvRD8tzw/6Z3UyM9lxCCjtkpFQI+ERMPATGTT/D
hwZmJzEj5esJYzs+PyEDt/d7pA0kzpW0XObEjX7apDgMWXWk7WmczJPPJENH6lVw
ULNeg4s+MlG6qt3eiC8+DPM6MxQtyen9NaE90UtCHunhRxt6tZSzbGSuHRYVWCdQ
9OgZEz7s3DI=
=W6JA
-----END PGP SIGNATURE-----

--==_Exmh_1572915290_14215P--
