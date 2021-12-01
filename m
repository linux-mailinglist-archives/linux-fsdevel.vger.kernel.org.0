Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C194656E3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 21:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352792AbhLAUKx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 15:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352897AbhLAUJW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:09:22 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35744C061758
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Dec 2021 12:05:59 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso2626124pjb.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Dec 2021 12:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=YqGL/+NlAr5HOI0FCD7CMM945v0VXz8eCsi4vQU4U0w=;
        b=DhvhSyC4AbePLWUv5flh7Ab4w1Rq/W6ecFjHwlU0v7y+4R9nFD4czAYLDBJJnLI3kg
         38aT4/sfSI90NjL4hh32k0vVlHvvwE33BuvVpxUdr2VBxYkUWaa7xsjBrrio10yBjjtl
         pYAyAqKV/it+I9CagY3rcC/M/CRd6HUXmNvzAN7GdYj2L23RUBw0zQ+gyvFYVop6Zhd5
         BOVZTKmTguSfUbTOkHvzh42Ld6ZgO6XnfpX+iQ/+8dMohm/XKBtSSDtahP2/ExAUsL1d
         FIf0XSzIgkR+PBF9YcHfPGQPDvob8lvETrDVPF4eAggk3/oIS51AGMeW9z1V/z7nbi4N
         11wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=YqGL/+NlAr5HOI0FCD7CMM945v0VXz8eCsi4vQU4U0w=;
        b=tIIOuRA4ySDVsSMagVZCRR8d/pdcP3MWZynTqCTceYxhvbnjPuINB0rz0A2FH7dLK8
         BM+8ohFzL4uxxAdEOvQs1l1YvbDekcTWipnxUxxhT/nPfjUhag5DwLeozWskyfdPrU9F
         xJDNW6wXIRXuW9d3u1ZeaTjGWOpWPfOkeJk/eVwgNzAZGbAhawJzUP7/VpuJb7IkVEbs
         qnPj98JvI2uDxdVFKdZEKxp/KqD01hzFCYgeYH/Gzog7GywlAEl/bZtbDFWD2tV0mDEh
         DttKQGbD0cmUNJVAQvLfMmSZM2eHq4pvq+okHjSqg5Lmjvny17XYtOK3WVXTFqmh4OiN
         rmHw==
X-Gm-Message-State: AOAM530k7kesJRwYVGLMm/Y4q9rdfxMEDg1KzXt46etrSrEZ3DzigLCV
        F6DPcFkrZ3V+lJ8mm5dDLxzrGmRJK1kQAufM
X-Google-Smtp-Source: ABdhPJyFsi+ZKysJZ8JQMQ/QF2DBt3G3P1j8ZEw2yj27QI5mTjGEzKryBeqrgxWllpKe8vy3plSEBQ==
X-Received: by 2002:a17:902:dac9:b0:141:e931:3b49 with SMTP id q9-20020a170902dac900b00141e9313b49mr10044872plx.45.1638389158657;
        Wed, 01 Dec 2021 12:05:58 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id o15sm452640pgk.7.2021.12.01.12.05.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 12:05:57 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <A581A60C-E377-48BE-9D9E-DCD5155ED8BD@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_8F836A3F-6FBB-4F9D-AF7A-415034A9D50E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v1 0/5] io_uring: add xattr support
Date:   Wed, 1 Dec 2021 13:05:54 -0700
In-Reply-To: <20211201195239.mlgb4qwj2hk2d3tv@ps29521.dreamhostps.com>
Cc:     Stefan Metzmacher <metze@samba.org>, Stefan Roesch <shr@fb.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
To:     Clay Harris <bugs@claycon.org>
References: <20211129221257.2536146-1-shr@fb.com>
 <20211130010836.jqp5nuemrse43aca@ps29521.dreamhostps.com>
 <2ba45a80-ce7a-a105-49e5-5507b4453e05@fb.com>
 <56e1aa77-c4c1-2c37-9fc0-96cf0dc0f289@samba.org>
 <20211201195239.mlgb4qwj2hk2d3tv@ps29521.dreamhostps.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_8F836A3F-6FBB-4F9D-AF7A-415034A9D50E
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Dec 1, 2021, at 12:52 PM, Clay Harris <bugs@claycon.org> wrote:
> 
> On Wed, Dec 01 2021 at 13:19:03 +0100, Stefan Metzmacher quoth thus:
>> 
>> What's with lsetxattr and lgetxattr, why are they missing.
> Do any filesystems even support xattrs on symbolic links?

Yes, ext4 does.  There are definitely security xattrs on symlinks that
need to be accessed and changed.

Cheers, Andreas






--Apple-Mail=_8F836A3F-6FBB-4F9D-AF7A-415034A9D50E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmGn1aIACgkQcqXauRfM
H+DyDxAAs+pnT9OwQ4bim+Ub6a0syOzUDOgpiMOlo2bk1uXeGXFtZ6HfSHFO8Vkc
NpR427YkaQXv0r3ivC0HHOWJgafL93EEhdoiXTLPlyGpcwadLdFiZ952PivJoWBo
ICh0gu6Tq0zyjZo2ESwYkGmt2SHf1FHGC8BoenoGFztLC0Qjve5Qt7JL5kJjoTrg
h/S9sJZ1JoZNexocJeJl1zeEyG82viETZRysC4aiOEFJOfGPGOPEZvOn4naJEXKJ
XmBsBQabYEVTiIs/sd0JZCaMsFbj2fbIIc2t269or6FyDzNvx8q2lsnvSDptA1UB
TpwsR3lxX6Ya3UbtoAbj6pSn01KckzIfvW2yKQ2Z+8jxKlf+qZsaoWz45EtehHYO
LVIH7AGkl3K8OlwDDSn94Uk87e9gvknEi7teK1Kvs1CrEkPGGyy0uUujqb6PQplD
TjwwnuAODTVRUdEpiqRrx2PJL6rXauYxBt2BH59oGt1PBSO5bO5CvNT4JqcejL+0
i4rNXYLXgQrbjKnbsjS2LFK3vdoxfWnYJAvXNwoAFm7KPMXzQok0PnX3oLQVDloS
gaec+moaKaafiNxN5LuhW0dPGAWK/VNnF/Vhe/WoSZyWz9fb9TZcLHmkqc3nJXxl
vjfKlY22qX0uR8PDo2Attb6RMhEvuAqW9g+dO/XYisNapVdpk0c=
=2pf7
-----END PGP SIGNATURE-----

--Apple-Mail=_8F836A3F-6FBB-4F9D-AF7A-415034A9D50E--
