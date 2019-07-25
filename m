Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 401D175967
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 23:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfGYVQO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 17:16:14 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35315 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfGYVQO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 17:16:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id u14so23383859pfn.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2019 14:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=bhC4e3admbOzYmGrcN4oFgwKI6Wn4sdHTAoRFihNQE0=;
        b=1SAhat64PbY6KHcExLCsKEef8DxUvSHk1Bo0Eq+uHaEsT/wxfp7URRpimiZV1bNMEt
         xrAWOI7rkUz7TOmeJK+7NK35NR9Qp03JoeuhgRcBnMQ/zDYoV3tid2xiz6JX9gCv4hwm
         AigeWNKZLnsUe0CY2E6fnhJ+q+qgHhEcDrzCZb4BK9uz8/WV0qYsBAPsYnr4bYRetHlO
         6aR99FyqNimlesckirp7nxviutkDxJIH0DufT6WVYo6PaxAixh5F8rAic2zbJXzWBdLO
         xQ2frM4w0fBZvwM3CseCRvlQrZeYq1Tjcl1V+eKD8wZ1wzEa/XFmqP7Uk2lC+BOFAil1
         VJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=bhC4e3admbOzYmGrcN4oFgwKI6Wn4sdHTAoRFihNQE0=;
        b=CZEp5LvVBNYbj0VYaxiD1XpuglqY+nlBlnlZPP3dtpgIyG/Zb6XPECUNjgeCv2n9QS
         HtIOidynN93PnTueYUpynvr1KJKe2IwNNoLd40xy7w1Bon6SqC4FVBenpIF2u4e0De/G
         yQ0hQn0IScqDl2U1X8cxROgjZrDryx8qJQUSEEbKQc4VwnKl4w7JladCJwUNV2pmBEna
         DqjhCUB+NmlsVoRT03tJpzAmota7fLu0e3lILQl5gi12+aQZMK/aTGfYljEwbypJefrw
         i9n8vHkNfTyszV7rxvlaDKgfD/TnIqusYnTdwVpS3UCk3V/sGObzeD02CE83UwR/wz3T
         M3pw==
X-Gm-Message-State: APjAAAXneaLAmkKNpUPjvYv77/dTJpojzO4OR9DOypDJMnArezQnVJiG
        VSk3/meFhfzbETv6svqQtS7h9hexyRQ=
X-Google-Smtp-Source: APXvYqwNu2chnXPziksH7iPaGWziZhQQfIP7hDob3QOMYt+K5yVpEqJO4DQQg3zHzrzIxKqRqZeTAg==
X-Received: by 2002:a17:90a:3590:: with SMTP id r16mr95560441pjb.44.1564089373404;
        Thu, 25 Jul 2019 14:16:13 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id z4sm40116652pgp.80.2019.07.25.14.16.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 14:16:12 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <028BF9CD-2E43-47DF-9373-A2D6EA7A3CF5@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_7D235CBA-60A1-49A6-B812-08865E719A4F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] mbcache: Speed up cache entry creation
Date:   Thu, 25 Jul 2019 15:16:04 -0600
In-Reply-To: <20190724040118.GA31214@sultan-box.localdomain>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
References: <20190723053549.14465-1-sultan@kerneltoast.com>
 <5EDDA127-031C-4F16-9B9B-8DBC94C7E471@dilger.ca>
 <20190724040118.GA31214@sultan-box.localdomain>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_7D235CBA-60A1-49A6-B812-08865E719A4F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jul 23, 2019, at 10:01 PM, Sultan Alsawaf <sultan@kerneltoast.com> =
wrote:
>=20
> On Tue, Jul 23, 2019 at 10:56:05AM -0600, Andreas Dilger wrote:
>> Do you have any kind of performance metrics that show this is an =
actual
>> improvement in performance?  This would be either macro-level =
benchmarks
>> (e.g. fio, but this seems unlikely to show any benefit), or =
micro-level
>> measurements (e.g. flame graph) that show a net reduction in CPU =
cycles,
>> lock contention, etc. in this part of the code.
>=20
> Hi Andreas,
>=20
> Here are some basic micro-benchmark results:
>=20
> Before:
> [    3.162896] mb_cache_entry_create: AVG cycles: 75
> [    3.054701] mb_cache_entry_create: AVG cycles: 78
> [    3.152321] mb_cache_entry_create: AVG cycles: 77
>=20
> After:
> [    3.043380] mb_cache_entry_create: AVG cycles: 68
> [    3.194321] mb_cache_entry_create: AVG cycles: 71
> [    3.038100] mb_cache_entry_create: AVG cycles: 69

This information should be included in the patch description, since that
allows making a decision on whether the patch is worthwhile to land or =
not.

> The performance difference is probably more drastic when free memory =
is low,
> since an unnecessary call to kmem_cache_alloc() can result in a long =
wait for
> pages to be freed.

Cheers, Andreas






--Apple-Mail=_7D235CBA-60A1-49A6-B812-08865E719A4F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl06HBUACgkQcqXauRfM
H+BTaxAAmAY56dH5kUnhb2CvlFHBG3O3aJdXZd77YAuX2cm3kAfgJ6C8moViAvI5
3X/FcF5nUpZGWxgahTtv7FIDYXjfYrPlcyL/kFWjzWVrGexWAAFieYsuyGKc5k5s
N5LrFnM4XtKv82FulX92etwArsP0U/LhUaoxS/+o6LioisyuY50LYvjYFnLbqKcj
ODd51+sjCSoc10n+v+aWZN7Wi/bMemTa6kKifUKI3hskiOshQtpb14Bvxrq57Dsc
H1xRLE9bwT3aM0y9wY0xK0nsBP2igS+AsL5X+sIlY25J+JzSSDcwIpzZ18BtBOod
JqSwvjpILUdS9hJXS8SkE7GKUNNPDh3zQKeFlcNzInF1P7/ghJcjy4CQZlY3lQsK
WbvHV/pIjPFhgZxzo/iDgg2gpliEF9XxAikIxD13eiq/HKpoog1vZD4lpa+hg8mo
nIW4XJfhZ/IBl1AMIr0LzgWyWUnZL9KrFJ9hBAtNNgBFNC8tRc+W8hGtbNG7mvQB
SiDo1oka0fU2B1CyR/8I92nLesnVggwyWJZFKvLFFLoGJ1O1AjAsuD2N9DZS7Tlm
U9U8Ripl4nspIsy0UZ6vdVs+sUqnZnV3ryHfVh+khkx3GyWVNjQtevBgnf4DKaG4
JHvLWHMQQ1Drwdrf0exkitnXrDU6LEfsxo2MI6RTWNk5O4hufPI=
=3yFi
-----END PGP SIGNATURE-----

--Apple-Mail=_7D235CBA-60A1-49A6-B812-08865E719A4F--
