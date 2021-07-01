Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC3A3B952B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jul 2021 19:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhGARGO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jul 2021 13:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhGARGO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jul 2021 13:06:14 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BB4C061764
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jul 2021 10:03:43 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id g13-20020a4ac4cd0000b029024c717ed8aeso1741686ooq.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Jul 2021 10:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zSv+GHdAokYpQGK8nxdK92ewIXmEkT7WAphnSIkQIV4=;
        b=P476woN2KrKArUT9PNczWqnwAR6+vGFDCD8QxZ33YkJQZACICstnYXjabV2DMCHAxj
         JwxhlEDAM3h9WprWiyoRbpEsIyd+yF88r4fZtRZXd2/3h0oN7pPgn88oda0YyX5FiMwt
         ysC5iKd7fYA7Eb4xXiA6tI0O1Pb/VjRNOJO0lnsHD4Spsq0+YActDeqPZKDGjyw7NEFV
         OQqGyZ+s9yVaTGw+hvHwZG9OS+z+RlnHq3bKeNaFZzuPsdgGB7D218WdACJgoUyLqzbe
         mQ5xv8y5jQZc+ayfh0SOOyir8wrjSwjYX0iuFMlA9KNIA+yRfd61RoiFlMeQJLWMrHuc
         +Jkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zSv+GHdAokYpQGK8nxdK92ewIXmEkT7WAphnSIkQIV4=;
        b=UcNCY5MHSftj1oM+tFFmJnMImZa593+TsqHcjeiCU3IFfMkqUngx4wE6aMaco/j0g0
         zvOZvU6yS+ePQZqb7OZk+UXj6svd0VAsmzeI/hVppz77omz1a/44O/9h9a96uuvBDd53
         8s8tqWcL0Q/DC1KCiknc/QeNgUZyvSEgQCugeYDXhaml7zScJwO8nE1+S/Z8EA2o9UX9
         XLVnzLypvlg7A0yBqhsuIPqLL7nO8bWIcTXJ5njO+35DW1YGTr2Ht4vljNa9Xs6Qc0ht
         iXNpHXA3gCIbRWa2x/QFaHsbkJpijdk8Db//xdMNaaO+odDq68a2qp8SY6Ohmbkvbt2Z
         8WFQ==
X-Gm-Message-State: AOAM530NnfdXf2pm9i5v0MGEayDiCrwPvT9GWigWsx19WvYpDc/o/p2Y
        9673PeTHPZP+yi/nK4M1cBF4FA==
X-Google-Smtp-Source: ABdhPJzafnMRTUFROSIdXg8fjyYMpDVsfCj5WHVLdk2Jh/wEhyDAnDWZODXBDVfg0toUUeB7LwozOw==
X-Received: by 2002:a4a:6c0c:: with SMTP id q12mr698931ooc.81.1625159023154;
        Thu, 01 Jul 2021 10:03:43 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:42f0:6600:4d57:e39e:c32f:13d2])
        by smtp.gmail.com with ESMTPSA id l10sm57404oti.9.2021.07.01.10.03.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jul 2021 10:03:42 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v2 0/3] hfs: fix various errors
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20210701030756.58760-1-desmondcheongzx@gmail.com>
Date:   Thu, 1 Jul 2021 10:03:40 -0700
Cc:     gustavoars@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <ECFAAAB7-2FAE-4049-9B20-081F5E6613B7@dubeyko.com>
References: <20210701030756.58760-1-desmondcheongzx@gmail.com>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 30, 2021, at 8:07 PM, Desmond Cheong Zhi Xi =
<desmondcheongzx@gmail.com> wrote:
>=20
> Hi,
>=20
> This series ultimately aims to address a lockdep warning in =
hfs_find_init reported by Syzbot:
> =
https://syzkaller.appspot.com/bug?id=3Df007ef1d7a31a469e3be7aeb0fde0769b18=
585db
>=20
> The work done for this led to the discovery of another bug, and the =
Syzkaller repro test also reveals an invalid memory access error after =
clearing the lockdep warning. Hence, this series is broken up into three =
patches:
>=20
> 1. Add a missing call to hfs_find_exit for an error path in =
hfs_fill_super
>=20
> 2. Fix memory mapping in hfs_bnode_read by fixing calls to kmap
>=20
> 3. Add lock nesting notation to tell lockdep that the observed locking =
hierarchy is safe
>=20
> v1 -> v2:
> Patch 1: Consolidated calls to hfs_find_exit on error paths in =
hfs_fill_super, as suggested by Viacheslav Dubeyko.
> Patch 2: Added safety checks, clarified code, and switched from =
kmap/kunmap to kmap_atomic/kunmap_atomic, as suggested by Viacheslav =
Dubeyko.
>=20
> Desmond Cheong Zhi Xi (3):
>  hfs: add missing clean-up in hfs_fill_super
>  hfs: fix high memory mapping in hfs_bnode_read
>  hfs: add lock nesting notation to hfs_find_init
>=20
> fs/hfs/bfind.c | 14 +++++++++++++-
> fs/hfs/bnode.c | 25 ++++++++++++++++++++-----
> fs/hfs/btree.h |  7 +++++++
> fs/hfs/super.c | 10 +++++-----
> 4 files changed, 45 insertions(+), 11 deletions(-)
>=20
> --=20
> 2.25.1
>=20

Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.=
