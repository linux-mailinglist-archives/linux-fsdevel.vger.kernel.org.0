Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 481B3DE060
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Oct 2019 22:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfJTUSh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Oct 2019 16:18:37 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:44491 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfJTUSh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Oct 2019 16:18:37 -0400
Received: by mail-pf1-f175.google.com with SMTP id q21so6985722pfn.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Oct 2019 13:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=ES+o7Frwb3t7bEmHSxzK0qthknjQUAiT2r+1h83CRD4=;
        b=1GkG/i/nFwbnM0cCUa4n5bnPKtl8/xwCezkZKl6Y4y4JH6BQLTYxnFh9uaOs3yay5i
         6lM0lerQ/elslMrv0z8hzhZxxQRMYQ3Dj0uBrIyR0Iyxm18FQDfyC3c78RF4ILDOEh5w
         F6P1zalRmQbU7yvgVhdx5J3FlS5D2r/IxLQGI1Hj7gXi1fyoOQDfC4Viy/P1OM5qk4CE
         0Axui66pu0WWfFkXtTxalSNSo8doXB4yMSrtbVOKoad83Xdn4IYJqL9rQigq2SjrRXv8
         Dz21KqdrcT7Bb58klZqVtq8GE9LRpS3AyoWmSgiaUFLG2O2vTTZXbT5QrPXlUMSFFFxe
         s4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=ES+o7Frwb3t7bEmHSxzK0qthknjQUAiT2r+1h83CRD4=;
        b=B7xKDX1Cw3sqoea4oKKdc5U1v83ycbkZiF8COmnRFbQ2HY7L9LIWL58euGXxEjVdsn
         ny049zbCeY+bQNh1RlucjwRzUccs/5L4bMXfo3XV5p7IksC/g8hFt5WdCVFSDzULSv/f
         VgE650qCk0lu9JDgpTTfUV8bjNl5l90NTaEnO4ZKjSgbCb/4xQFKRJYvuDwLOxWYYFbD
         AdDO/VEkCq1fxmxsYL0CCgrTmTRtyint5kGjDk340/dZ09aMPdn2E1kTDcQvGujDxf3y
         FUVPW4Uemhd3bgYg09508ylyEdT8/0YJnicu/1TybP0S7vPbWFcHipT6n0r+MpdrHJF4
         FxmA==
X-Gm-Message-State: APjAAAWedjPth9VMjKaHTj/f0Rd6mSI4GS2eFwGOq4symRGMeXCAbiRr
        XXDTkOjNL3dXJxIpZZXZDyXkSg==
X-Google-Smtp-Source: APXvYqy9Mfxb1YDX7yeZuitaE39oU36R5WMgC3QPuXD4227KuiKiwzrMMabh528+vT0q4c/XPkXp5A==
X-Received: by 2002:a62:3203:: with SMTP id y3mr18672359pfy.91.1571602715890;
        Sun, 20 Oct 2019 13:18:35 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id 199sm15407791pfv.152.2019.10.20.13.18.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Oct 2019 13:18:35 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <6F46FB6C-D1E3-4BB8-B150-B229801EE13B@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_35E7AAEA-558E-4C69-AED7-98BFD0780248";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [Project Quota]file owner could change its project ID?
Date:   Sun, 20 Oct 2019 14:19:19 -0600
In-Reply-To: <20191017121251.GB25548@mit.edu>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Wang Shilong <wangshilong1991@gmail.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Li Xi <lixi@ddn.com>, Wang Shilong <wshilong@ddn.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
References: <CAP9B-QmQ-mbWgJwEWrVOMabsgnPwyJsxSQbMkWuFk81-M4dRPQ@mail.gmail.com>
 <20191013164124.GR13108@magnolia>
 <CAP9B-Q=SfhnA6iO7h1TWAoSOfZ+BvT7d8=OE4176FZ3GXiU-xw@mail.gmail.com>
 <20191016213700.GH13108@magnolia>
 <648712FB-0ECE-41F4-B6B8-98BD3168B2A4@dilger.ca>
 <20191017121251.GB25548@mit.edu>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_35E7AAEA-558E-4C69-AED7-98BFD0780248
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Oct 17, 2019, at 6:12 AM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> 
> On Wed, Oct 16, 2019 at 06:28:08PM -0600, Andreas Dilger wrote:
>> I don't think that this is really "directory quotas" in the end, since it
>> isn't changing the semantics that the same projid could exist in multiple
>> directory trees.  The real difference is the ability to enforce existing
>> project quota limits for regular users outside of a container.  Basically,
>> it is the same as regular users not being able to change the UID of their
>> files to dump quota to some other user.
>> 
>> So rather than rename this "dirquota", it would be better to have a
>> an option like "projid_enforce" or "projid_restrict", or maybe some
>> more flexibility to allow only users in specific groups to change the
>> projid like "projid_admin=<gid>" so that e.g. "staff" or "admin" groups
>> can still change it (in addition to root) but not regular users.  To
>> restrict it to root only, leave "projid_admin=0" and the default (to
>> keep the same "everyone can change projid" behavior) would be -1?
> 
> I'm not sure how common the need for restsrictive quota enforcement is
> really going to be.  Can someone convince me this is actually going to
> be a common use case?

Project quota (i.e. quota tracking that doesn't automatically also convey
permission to access a file or directory) is one of the most requested
features from our users.  This is useful for e.g. university or industry
research groups with multiple grad students/researchers under a single
principal professor/project that controls the funding.

> We could also solve the problem by adding an LSM hook called when
> there is an attempt to set the project ID, and for people who really
> want this, they can create a stackable LSM which enforces whatever
> behavior they want.

So, rather than add a few-line change that decides whether the user
is allowed to change the projid for a file, we would instead add *more*
lines to add a hook, then have to write and load an LSM that is called
each time?  That seems backward to me.

> If we think this going to be an speciality request, this might be the
> better way to go.

I don't see how this is more "speciality" than regular quota enforcement?
Just like we impose limits on users and groups, it makes sense to impose
a limit on a project, instead of just tracking it and then having to add
extra machinery to impose the limit externally.

Cheers, Andreas






--Apple-Mail=_35E7AAEA-558E-4C69-AED7-98BFD0780248
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl2swUcACgkQcqXauRfM
H+C6bg/+IVKN6zxruxANDmRxjkhbz1DsHpy8bRcW2p+EfZXh4Q/VjLaqoak01fgP
xIlYX2phbBiJP1peTeMcw2N6CEWPJzVMJEM8ncW+NN7c2aFj+IJOU5HWgzw3E/TO
8Iku9a2iYb8P1SQ91sY+7uFknr7N0pLoMgPqlwBKF5SrPUMClIbuIW2UlVNFdBIp
ktRATf95Ieo2K9NpESNNtQWY0yBIuoKU/Vdd6PTq9Pra7gm/xwPBdmaOs/FQQ4dr
WhEGfEtKV6hFCy04zt1YkrHuTQe2ykV2/XKIGseVPkuNpKyzg3lS1OWhZZE8ek1V
iR/LvqbehVp+8RjLrka+YYxGCsKdi6uWJQNsaT/nbJFwroKmEuNu23WWguzXKDIf
eUq1lDn2VoFl2S8Kts4WXpSyxg7aSg8eVFZKq1sZaANo6Zzk+QgE82IJft0/mc+o
3g3DqeDMYmObhiL0JNR8FIfX6JNKJOolmT3AK4O4tZi4abOGaa0TjNqLWwfh7ted
az6VX3/I0it/P+t63i1wNN7sFVKvKFRfsF0VVcvvm52uYNag22yub0Ub3E2HAAi1
1r2YAPYwhV5xYF7t7Gaj4vzFWJCcFMKABHfR2t4mAJQ4gN2X9jvxvBMO1eopQiGe
9Z1FXKPTFb33RpbWftbv6wxn6fHMMGbKulV9qjOpxHoFhZXSgXE=
=Xz2h
-----END PGP SIGNATURE-----

--Apple-Mail=_35E7AAEA-558E-4C69-AED7-98BFD0780248--
