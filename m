Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C65112BE13
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2019 17:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfL1Qw6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Dec 2019 11:52:58 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39491 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfL1Qw6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Dec 2019 11:52:58 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so28885379wrt.6
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Dec 2019 08:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jqn6gE8idEKrfaA7e/iYrZ+3i1hZnHomVo19iC7LczI=;
        b=M6wS3dLdplsZ0H49Ev3qEiOcNCUao96Ei8qfl0p7ZTSsbFPcaAAHaSbRUfe5J4x/An
         6ecFI+tH3lf3XtGfSdbIElsY3Qp/NjGM+gv/7YVdmCvx/rSHJipocAzByjFP9IT0iayI
         hLKjiSLf4Xcw7dvr6GoaGHxGQSpVfJOTvGb4KakawR1uSysWInjlwW3dcPuPY2v8Bk9B
         5zux0PvVnsueI1suUAyeD1HtdnVpai2ZZfqVyr/0ipV8ktMFcDDiMOTKl8SKDkpuezPo
         udJaTmVE7Xt+vl8KDXkXZAYdNCihgb9Su2Tjn2hRqPImoVhZskshpWMD/mxUyWAgfmWK
         txIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jqn6gE8idEKrfaA7e/iYrZ+3i1hZnHomVo19iC7LczI=;
        b=S1WNF1tj4x/4fbpsRC5q8m0VEbLR4VDIu7N9gfn2yoK8gfcq92nje4ER67lrgef6cp
         YfvvTU4IPbhIewFg1k44UE9qrFh0JksArU7ZwUrgiASWSLsb8mXegtFafnEAuaMZZtxW
         jDl9TXgOoCfytqo+dX8JLTPcP/24WVDbfpQvXvuvuZd0Z0xH8fxQlqZgyTWWlyodZuGw
         jo6rmeq75+CQKDWs4rIsooU6/9huYUfcBv5K5J70cQ14sX9dWN3dZYu6Yl5ALRpaQPhO
         k1HxGwjsF/tmGc/MuNMMHgnl/CQIlFGu0UvEv6hqxCSM1GQCf6OS9WvySzvYT6sUjcxe
         4Asg==
X-Gm-Message-State: APjAAAV2wozZH2Uk0dXa6XR/9QExHV22BeCZC4guxXjmj5OQdwC+dBSn
        KnaIDy0f7r+S3JeSoS1nQ1m8+L3x
X-Google-Smtp-Source: APXvYqzdW2ftCklHxf6Ib3bBrUZOHoEjmc3pKnUrKGwZVrrN+Cc8id+fGTEdPccGd9X8oMrbdRR7CA==
X-Received: by 2002:a5d:5592:: with SMTP id i18mr53013364wrv.55.1577551976088;
        Sat, 28 Dec 2019 08:52:56 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id g18sm14675555wmh.48.2019.12.28.08.52.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Dec 2019 08:52:55 -0800 (PST)
Date:   Sat, 28 Dec 2019 17:52:54 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Subject: [ANNOUNCE] udftools 2.2
Message-ID: <20191228165254.rhgwcpwe6qljqrxq@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="v5r6jfljvqdccp6r"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--v5r6jfljvqdccp6r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello! I would like to announce a new version of udftools 2.2.

You can download it from release page:
https://github.com/pali/udftools/releases/tag/2.2

The most visible change in this release is for udflabel tool which gain
full support for UDF 2.50 and 2.60 filesystem revisions. So it can
change filesystem label on existing UDF 2.50/2.60 filesystems.

Note that this release does not contain udffsck yet.

For those who do not know, udftools project contains standard Linux
userspace tools for UDF filesystem, like mkudffs (mkfs.udf), udfinfo,
udflabel, cdrwtool and pktsetup. And UDF is a filesystem which is
natively supported in R/W mode by Windows, Linux and MacOSX kernels.

Project homepage with code hosting and bugtracker is at:
https://github.com/pali/udftools

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--v5r6jfljvqdccp6r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXgeIYQAKCRCL8Mk9A+RD
UtUqAJ0UOa58nm0xiHuZtVnCuLcvjpX3IgCgnpWAyKqiZkJ0t250CowY3TOhxYc=
=p2V7
-----END PGP SIGNATURE-----

--v5r6jfljvqdccp6r--
