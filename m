Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 386E6EDCF1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 11:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbfKDKyJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 05:54:09 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:39396 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726364AbfKDKyJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:54:09 -0500
Received: from mr3.cc.vt.edu (mr3.cc.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xA4As3IS006960
        for <linux-fsdevel@vger.kernel.org>; Mon, 4 Nov 2019 05:54:03 -0500
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xA4ArwZN013009
        for <linux-fsdevel@vger.kernel.org>; Mon, 4 Nov 2019 05:54:03 -0500
Received: by mail-qt1-f197.google.com with SMTP id v23so18264161qth.20
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Nov 2019 02:54:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=O4sSEohI+9ePFu7NIh17h34X06dA5Ss7wezIrk0/sMM=;
        b=d9F5VdJCAh4foC234Yl0UM+hz/9mkbPP2XfMixqJ5TAGimgRcIOVqaq2NzIAfHy9ej
         6sVLyLZ2fZ1aMz2Xyu+KWeza9KntiVEvDUi+ciRqvIERXUS7qMiySmwTYVVPzbqttPsy
         fxBWE63NA9/Lr123jWpLcXEoBfxfJmSZDlaD/wrAPl5UC/yO4enjRxdXzUFLj87UROrg
         OJ9qgdwGalR5XTeZ6nHAgsgn30WaYMLz5EbjMF3yoKlOJKkC7cikfoXBHoHbA2NDHAHd
         wviJaHbJ+0UjJTKNehnMy5PWIGSg0GIpZnJCzVHGJZlR7rXzA+Td1+RFpksRb9fZwqUZ
         WRUQ==
X-Gm-Message-State: APjAAAV73/IkXdVrObyQcIvRs9XqynFzBrinXweQZR4rwENv83NdSu0g
        AGLOn9xoL0mA4jJbh9Xg3tAKrZIz2Taq7EL0JRdZyuRtsxzaovWqaszmsQnv8GjW1HfHvE/kSX9
        jOkcZBkJhqOM4U6+q/fhR/5obuy8sLlLOG+Li
X-Received: by 2002:ad4:5349:: with SMTP id v9mr19958004qvs.55.1572864837952;
        Mon, 04 Nov 2019 02:53:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqwstpqpeboZZUEmIXv+bMXs6fTpFWmQmyQJOF4uLfKs2q0utFPvv23/qq1PCoH4UlOCj6735g==
X-Received: by 2002:ad4:5349:: with SMTP id v9mr19957995qvs.55.1572864837661;
        Mon, 04 Nov 2019 02:53:57 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id l124sm193608qkf.122.2019.11.04.02.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 02:53:56 -0800 (PST)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/10] staging: exfat: Clean up return codes - FFS_SUCCESS
In-Reply-To: <20191104100413.GC10409@kadam>
References: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu> <20191104014510.102356-8-Valdis.Kletnieks@vt.edu>
 <20191104100413.GC10409@kadam>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1572864835_14215P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Mon, 04 Nov 2019 05:53:55 -0500
Message-ID: <128761.1572864835@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--==_Exmh_1572864835_14215P
Content-Type: text/plain; charset=us-ascii

On Mon, 04 Nov 2019 13:04:14 +0300, Dan Carpenter said:
> On Sun, Nov 03, 2019 at 08:45:03PM -0500, Valdis Kletnieks wrote:
> > -	if (sector_read(sb, sec, &bp->buf_bh, 1) != FFS_SUCCESS) {
> > +	if (sector_read(sb, sec, &bp->buf_bh, 1) != 0) {
>
> It's better to just remove the "!= 0" double negative.  != 0 should be
> used when we are talking about the number zero as in "cnt != 0" and for
> "strcmp(foo, bar) != 0" where it means that "foo != bar".

"Fix up ==0 and !=0" is indeed on the to-do list.

This patch converted 82 uses of FFS_SUCCESS, of which 33 had the != idiom in
use.  Meanwhile, overall there's 53 '!= 0' and 95 '== 0' uses.

In other words, even if I fixed all of those that were involved in this patch,
there would *still* be more patching to do.





--==_Exmh_1572864835_14215P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXcADQgdmEQWDXROgAQKAchAAtemIJM4rEnk/fzHoPM8wtbMrApsfS8oQ
xZk0xQ6DGVGwCR67LvNuy3qU5sgSXDuI6+0Egf/63qzQdyZ4C87x49m0p3J6dctU
wFwVlDwlr49ZbCcHDWD/lI7B3cc+1iwxAcMYVXQGMsF4dNckVLzHXjP7PEq0eMnP
xZKkGxU9pvJLpiuCckiJTda+qG9xPJDh9BqsT6L3XQD/yN8ajurYPVkv1FXRiiBY
Xzxw1Vd3vM8lxLyE2KtSB2VVlWGxK8HC9fw49p1RkKpcdXLBYPnf9dy7umSpTM4U
7nPYVj/MMvis4pDb7dRDBicSqgoQd+Np3dz0bHRvHCmq5i3zrxhaYuCaJ+RreRXi
3i4nanOeI43RZ5qfUkUZJm2AthINcNCRLysmprSherVa7jvCr7QJXtkizJgVeYou
Kx/ND16wpQe96G8TzyQXHQx1Ki+0jnjkQLOp1xZ+I4/Zua8KPqrKXafIfzBhQSOx
5FJCXe07qrjJUAfKR/oVTtlzqOQl6tbRNIjClPiJRwfocpEaZi5XBi8Og3cfEi44
+RR9euNuePOCK4wpTOn9u5GBlCIy8IpRdOfMaU3Amh1uzo3rS8cU7fRQYfovmySI
Js1wW1Jc4vdXm6Zx9ijVxxECcK/DfjxGKSTeCqt3Hlo3JxbBX2Q7jvGm4fu066bq
/etC95DRebU=
=E3XH
-----END PGP SIGNATURE-----

--==_Exmh_1572864835_14215P--
