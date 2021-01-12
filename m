Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC992F393F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 19:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405344AbhALSvw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 13:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbhALSvv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 13:51:51 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD0EC061575
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 10:51:11 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id x18so1887514pln.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 10:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=jwDUMG4BDwtkjKCfx8pA65u580qvrwCaIPtk3Y8ItLQ=;
        b=D1Rngjrb3LUnyMG8JdR20Ets0jZss6q7ARfCNDySerYlxXsb87TyHJM9jDKcUNYqTe
         I9rlrRVqxoeNOhcT6rRhbdKU7hoXBIBHlgwigOdY+Hp4q0JtNOCocy3vyCRWyHIK+DbW
         sI5yvoeGlHvSpXQ96g4FNHAMAd02kwXRkO9E7CfQHR1gjRyqleWPkQiE+viGiTuA2DXE
         /eDf7QRtrqUN+DYPG7NeUKKQR1kv+9KWC1qdYAFpPEpWHOdI/wt5WDM4FDuZSSAx7HWh
         Dr02UExOlhOJoA5r+j7aoBFbtZPQWl/tkPBRAl9WVKvja3ZMgsQctlYekYvRMxVVZBaK
         S7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=jwDUMG4BDwtkjKCfx8pA65u580qvrwCaIPtk3Y8ItLQ=;
        b=rWNarTMG1HzIGaWam8K96GfiLEvggoFac75+/dv0C/R5jTYmudGp7q9HytLyNLJRcG
         SZgNgPvfrVBz9QQNpm/dv1enEz51P2O7L0xe7M2pCr7wMSxVz5xPKQqoIj3CUCvgYDiL
         Thn+K2HWr7y/n20KWUGUWWtq8xDq8XvQZ5UokUnxNYGfEN+ZWvbLmYG2Sb1eXgp2xgH3
         qSNRzepTBBXv48vkc+bOEKFU4aM7OQux6vHLzJc5xghuwinWXQ99Af4TfY3wPlVtXLOf
         9agT6eG3d7B6Vcwv1st/BZj/Ny6aLi+rW7yQ2ydExiB1IrxYlZb7sPXtje2TpyLjLyJd
         sLrg==
X-Gm-Message-State: AOAM533oLtNmPxikHcKYcbCP3CxMuwIeXFZLOZgtVByYd0Qyw7H3Xkv9
        JUWd77PVb73UcC7b9BIdPCzfZA==
X-Google-Smtp-Source: ABdhPJwUVpeMz64khBbzgbJo42H3YjSS8MRHzeXxb+inQgHD+G5+FrutcdGHJ0yvdM6BUHca3/LrFg==
X-Received: by 2002:a17:90a:c396:: with SMTP id h22mr564062pjt.84.1610477470988;
        Tue, 12 Jan 2021 10:51:10 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id b125sm3896128pfg.165.2021.01.12.10.51.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jan 2021 10:51:10 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <1C33DEE4-8BE9-4BF3-A589-E11532382B36@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_B1E9DB15-6634-4823-95B4-E91F40111E15";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: fallocate(FALLOC_FL_ZERO_RANGE_BUT_REALLY) to avoid unwritten
 extents?
Date:   Tue, 12 Jan 2021 11:51:07 -0700
In-Reply-To: <20210112184339.GA1238746@infradead.org>
Cc:     Avi Kivity <avi@scylladb.com>, Andres Freund <andres@anarazel.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
To:     Christoph Hellwig <hch@infradead.org>
References: <20201230062819.yinrrp6uwfegsqo3@alap3.anarazel.de>
 <20210104181958.GE6908@magnolia>
 <20210104191058.sryksqjnjjnn5raa@alap3.anarazel.de>
 <f6f75f11-5d5b-ae63-d584-4b6f09ff401e@scylladb.com>
 <20210112181600.GA1228497@infradead.org>
 <C8811877-48A9-4199-9F28-20F5B071AE36@dilger.ca>
 <20210112184339.GA1238746@infradead.org>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_B1E9DB15-6634-4823-95B4-E91F40111E15
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jan 12, 2021, at 11:43 AM, Christoph Hellwig <hch@infradead.org> =
wrote:
>=20
> On Tue, Jan 12, 2021 at 11:39:58AM -0700, Andreas Dilger wrote:
>>> XFS already has a XFS_IOC_ALLOCSP64 that is defined to actually
>>> allocate written extents.  It does not currently use
>>> blkdev_issue_zeroout, but could be changed pretty trivially to do =
so.
>>>=20
>>>> But note it will need to be plumbed down to md and dm to be =
generally
>>>> useful.
>>>=20
>>> DM and MD already support mddev_check_write_zeroes, at least for the
>>> usual targets.
>>=20
>> Similarly, ext4 also has EXT4_GET_BLOCKS_CREATE_ZERO that can =
allocate zero
>> filled extents rather than unwritten extents (without clobbering =
existing
>> data like FALLOC_FL_ZERO_RANGE does), and just needs a flag from =
fallocate()
>> to trigger it.  This is plumbed down to blkdev_issue_zeroout() as =
well.
>=20
> XFS_IOC_ALLOCSP64 actually is an ioctl that has been around since 1995
> on IRIX (as an fcntl).

I'm not against adding XFS_IOC_ALLOCSP64 to ext4, if applications are =
actually
using that.

It also makes sense to me that there also be an fallocate() mode for =
allocating
zeroed blocks (which was the original request), since fallocate() is =
already
doing very similar things and is the central interface for managing =
block
allocation instead of having a filesystem-specific ioctl() to do this.

Cheers, Andreas






--Apple-Mail=_B1E9DB15-6634-4823-95B4-E91F40111E15
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl/975wACgkQcqXauRfM
H+BruxAAmI4YBd36T8vUfDYrZnmu8DwDgBzYxTkN75N3juxfevosnpWgH8yGGXPA
QD1k+mG0jPlidO1J766sBdGV8CHL4Q2ZYfiUA2C8z9yTfgi2uDcXmhYmG7rQWQcV
tHZ3PcgW/u5TKpvicrtQKbdXt2teZPjUvIaR7B/6vr5SE+4gR/BsdmfdNKp4mCBQ
0KWJyGXrTOeUwg+Ezaq6xPCRh4+2ToUcUA6ryKn3nIvBZ7ppuDSpTrix+ZZLLE/H
++xbZWfCmIcZIrHR7rSitYV/CYZASMPffmFNJo76PYGLJ5l8HYU5GBI/rZ/VbjSd
b6eO34V4+7DyEzgPv+iMX3G+BlHxUTJrNmKCuPlpbEtj6rPMkN3AUhfsKq0pqseW
sSxECwRhNz27c4AfYOr13PVhPLRTMoaMhSWuRxpNGOssqYVBP1W184eOSPV3M6lh
hEFsR7fopFWACc2jyp8XFWpvnDr3ScVRcVyzUB9FO6/AyaftvfugPhBH5j+X9pb1
SkBIofHYYEYZDeMcnr4TjcMKrT5Pyc7oYR4wHjr1a52Aa0qUk+e3szxzK8zxa4uT
qZLf7hmB1E2elCyZ67QoLcV4uYGVcpL4oVYMMzIzHixM0mRNadMQHDoEvT80Nmmq
3Blf2NjzZh1l8GYzLA6GCFrtlZMkmzopFNNhbUnfOH7w6V8Dfr0=
=eOkz
-----END PGP SIGNATURE-----

--Apple-Mail=_B1E9DB15-6634-4823-95B4-E91F40111E15--
