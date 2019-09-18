Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 871B3B6E52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 22:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731835AbfIRUqx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 16:46:53 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:38670 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727165AbfIRUqx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 16:46:53 -0400
Received: from mr6.cc.vt.edu (mr6.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x8IKkpnZ015199
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2019 16:46:51 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x8IKkk9v021017
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2019 16:46:51 -0400
Received: by mail-qt1-f198.google.com with SMTP id e13so1409454qto.18
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2019 13:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=sj1Be5bh36NPSKpH99IRc3lxyYGd2Gu2Ngf5QRmZxUQ=;
        b=qCKne8hIg49efkw4gi9mDF6NEoCwZttraFoN08ljUvpiFEWFa7gr7i7UmMFkrjdoTe
         6SGwYw2sNaMIgQiRkwAcgHf9z/Sn3Xo2O4iFRiv9HMmbnlAhsq047yZvcRUf8t6UsyTN
         byYDh5vWIirHb9tfCHc9ydRgMxODR8beWJmyIwDVpGsbgIV/FDj0W1BfclB0iJXQz22/
         zpfq9ZvcFMOzKPVLkvE0yAf9fQcPUiBom9FSB3QtjBSs2lnTTS+pFjLd12crhKIvuOeH
         N4y55BrqjxbRLZEs9pJoQoTjzXo3BE3f6NUPsxURiVKdfVzoK49MiO/ek6OYE9gTYTj0
         Rkmg==
X-Gm-Message-State: APjAAAWboX9pljss1+GDHS7A6xPqZ0WGdtrnUU32OmY3QnGuOQR4Xuj1
        Nz2UVbjYxzkECUQoGRLSzW8wDH+Iw9qoqIvJ7U9r1gWqnJh7+JV9aNWqWSW6t875QcOx4M5tQCM
        /iqRX03dGElY2iLxnM7roge+D/Sqh+baHVnK4
X-Received: by 2002:a05:620a:1006:: with SMTP id z6mr5929156qkj.319.1568839606152;
        Wed, 18 Sep 2019 13:46:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzN519XpVFShhPUhoMA/uSLKMiNhSJjhYtOC4Omz0W4d+P7MVfJeueZ8N3TjGMgAuGk/d7jtQ==
X-Received: by 2002:a05:620a:1006:: with SMTP id z6mr5929138qkj.319.1568839605913;
        Wed, 18 Sep 2019 13:46:45 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id l7sm3962855qke.67.2019.09.18.13.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 13:46:44 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Ju Hyung Park <qkrwngud825@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Namjae Jeon <namjae.jeon@samsung.com>, sj1557.seo@samsung.com,
        devel@driverdev.osuosl.org, linkinjeon@gmail.com,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, alexander.levin@microsoft.com,
        sergey.senozhatsky@gmail.com, linux-fsdevel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] staging: exfat: rebase to sdFAT v2.2.0
In-Reply-To: <CAD14+f1yP7qps9mpF1T9Xf7E5Osthzj7tH35VcWPr3TmxdkMTQ@mail.gmail.com>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org> <20190918195920.25210-1-qkrwngud825@gmail.com> <20190918201318.GB2025570@kroah.com> <CAD14+f0YeAPxmLbxB5gpJbNyjE1YiDyicBXeodwKN4Wvm_qJwA@mail.gmail.com> <20190918202629.GA2026850@kroah.com>
 <CAD14+f1yP7qps9mpF1T9Xf7E5Osthzj7tH35VcWPr3TmxdkMTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1568839602_2440P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Wed, 18 Sep 2019 16:46:43 -0400
Message-ID: <110019.1568839603@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--==_Exmh_1568839602_2440P
Content-Type: text/plain; charset=us-ascii

On Thu, 19 Sep 2019 05:31:21 +0900, Ju Hyung Park said:

> We should probably ask Valdis on what happened there.
>
> Even the old exFAT v1.2.24 from Galaxy S7 is using "either version 2
> of the License, or (at your option) any later version".
> You can go check it yourself by searching "G930F" from
> http://opensource.samsung.com.
>
> I'm guessing he probably used "GPL-2.0" during his clean-up.

My  screw-up.

Original had:

/*
 *  Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
 *
 *  This program is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU General Public License
 *  as published by the Free Software Foundation; either version 2
 *  of the License, or (at your option) any later version.

So yes, I dorked up the SPDX tags, as I didn't realize GPL-2.0-or-later
was an actual thing for those...

--==_Exmh_1568839602_2440P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXYKXsgdmEQWDXROgAQIC3RAAq0TrBUiC6gE5oEzKfG//YUj0gtHCuodf
bPRfKrVM5QXCbdSFd4duU0Zfiiy7Zh87J4TVwruHVI4FFqLetNvlR6MqwkLlyYyV
SEAAoVo4iS+t1ysAaRfP6Vv0XhFHy6GqbtGaecARwtaUwOfnx0tIdafJSW3/NC9a
ejVyewuIdWD97inw2avmYtqr97HOJM5Nm7egWJ65ED2W9hjeVidMbPTLnAmuPu7a
+h2zt9HKF/siYYu004Bd5ySAdnI7SiaZ7BZ5vA/G6OVG0tc48exAlJHN7wgtaxw2
20REUNG+Ypt5sYT3xF6D6Puo1MbaF7qBZ5kG0YdKXtkIvRsMvREWlPjU7Tyq1gfD
4m8vhsO1jv5mb0iH5tNphOX8vwAGpiDgCVNazbHPQ2ZM6pyfnJE1LQ5XA8ssCMf/
2F4UVgi+eUL6RnbvO9nfqotEWGEJXT2vUTYbk5mhAbpGkiNQh0hX4raSjNiaM1ae
NJo0WYZjsMomikMMQ/Qy3OJBxsJtM4J7QzUxg//JX7/psUrC+78JjVYMOQBs1g4W
1oyfEmua+BTflDy9Axx5UMLKruDAecGRX79k7yBmeYBxJg26osh1wML0+0sSQ5RW
33NQeGKDCGXdnzUKIPoeNLzz11s/xBnrXs7d8sCbsP76new0henxcuWOVjcOLElF
dGD0xbaj5jM=
=wQUB
-----END PGP SIGNATURE-----

--==_Exmh_1568839602_2440P--
