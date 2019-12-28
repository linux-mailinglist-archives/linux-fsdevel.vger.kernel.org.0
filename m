Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B59312BDCC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2019 15:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfL1Ogz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Dec 2019 09:36:55 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44480 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfL1Ogz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Dec 2019 09:36:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id q10so28670318wrm.11;
        Sat, 28 Dec 2019 06:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LNkv+TomXCKc0rG8jhN2QmjVTjiqndW43S3ATK1GH1s=;
        b=AWjxboquR+qvc9NDnBy1kiU1wvQe5dt8myS1qxp1DbROokn9qRDyEdsnw37Jz8JDLq
         9GbteCa43mpjBJV2uF4SebdQIxzh9NP+Tq6hURcuArG1v4Txj4ccJXknKZP3bI1ffHA5
         vp1U0vmp7sUi4gpfXHCILRvPZaTOtjIl2iN2qhm3GQSLIwF3a6+QPyaUToH5cwYIE3mV
         DGSZ35H32sFtO7UNZBITnCNsVqxG7A8RdmJNCh5akqfTlUT4MUOvEbh5uH6ee9lngJNX
         V/zZgMudgPhjsreuCDFJitONaew99sUE1EDDBNguA7uG8dkRYEa+qdEo5TQrfNnSM8lX
         RADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LNkv+TomXCKc0rG8jhN2QmjVTjiqndW43S3ATK1GH1s=;
        b=rVx4H1DM/q9JjWrcEawEp6ETfnuKy7utG0RItXERw/xzDBAcZM4g5gbeuBr3MdaOSh
         PecT4vwdCbmIs5YBSpZgOWeT+/6YXI5Pnb1goBeJf7BR5vXlehudDboFFWPdW6qn5d4r
         RTBCvaa+IL0dHf3GDt3EQQOKOU65YB3dN5Fdjzb1ziHVStsCfKbdAk7cOkpH0mqd2mnj
         TKeSNnpR9auHMyykm0J5woHJQLq5PZvc8QTbHmF75J4asYV60EgxjE588vsO8cVzQdiX
         HxWZa+BgVD6yHrJWjVkVxL6GkmVpie247tyzQo4b73bWfF8cFAfi9QaAFB7bD42+ATMv
         nB/g==
X-Gm-Message-State: APjAAAVW78A0UO73KnC7VXUhGK+xdgrUZX+aipXVQTnwX23+6EYVqA4f
        /VTD7gF2a1U6NSwvEwHVaS4=
X-Google-Smtp-Source: APXvYqzinO5afvtRfZ6z9qo7C+TFRfMsYRKvHAx6Q9Q0GnVI2Qcl7JiNMqCOWS/AtWWrKzPjuUgGtA==
X-Received: by 2002:adf:806e:: with SMTP id 101mr58775959wrk.300.1577543813347;
        Sat, 28 Dec 2019 06:36:53 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id i8sm38398382wro.47.2019.12.28.06.36.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Dec 2019 06:36:52 -0800 (PST)
Date:   Sat, 28 Dec 2019 15:36:51 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Eric Sandeen <sandeen@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        David Sterba <dsterba@suse.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL
Message-ID: <20191228143651.bjb4sjirn2q3xup4@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="colws2dljlnl6i4c"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--colws2dljlnl6i4c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I see that you have introduced in commit 62750d0 two new IOCTLs for
filesyetems: FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL.

I would like to ask, are these two new ioctls mean to be generic way for
userspace to get or set fs label independently of which filesystem is
used? Or are they only for btrfs?

Because I was not able to find any documentation for it, what is format
of passed buffer... null-term string? fixed-length? and in which
encoding? utf-8? latin1? utf-16? or filesystem dependent?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--colws2dljlnl6i4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXgdofwAKCRCL8Mk9A+RD
UhOtAJ4uYIiEZ7JuYou8B7poIoLlwRfYkgCfZaBuMUSd5Qrwzse09H6T52ZtAVE=
=BiJm
-----END PGP SIGNATURE-----

--colws2dljlnl6i4c--
