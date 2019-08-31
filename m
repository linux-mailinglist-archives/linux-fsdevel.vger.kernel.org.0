Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 687ADA44D1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2019 16:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbfHaOvU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Aug 2019 10:51:20 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:45530 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727905AbfHaOvU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Aug 2019 10:51:20 -0400
Received: from mr1.cc.vt.edu (mail.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x7VEpI9T020028
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Aug 2019 10:51:18 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x7VEpDHl012486
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Aug 2019 10:51:18 -0400
Received: by mail-qt1-f199.google.com with SMTP id e32so10492731qtc.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Aug 2019 07:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=5EjZxYJscYNuvNb6edlHZxPzUbBbDiEEcqsYXybnt08=;
        b=MIAf7uJBDjtgZeI8K7MqociMqCRVIYNTL1VilhDoLzdoKJWpxfhoFVcea8X6/xDu14
         NtaOaq3JXbkR0Zndh4QrgPt8jWm1qD/LAw200F3ywhMnJnUxMDQSbJd01fB85v0APnrw
         Szv3B5HIix8d6sbq7wy4cqvUuNzH4p0UcqV2JziNG2Jh0dLITU4T6Bi8z4T2z2pZ4y+g
         Gi7Ur0eC45EDc/g2ydaKrEJmRdCkYtTblxgcOLKIYFV8L62JQKPQULGQ2a7xy8vSKB/6
         TmjUBWBEbQf2C2IG9p8jOn/0ibhDyRdmdRfIKOyiBIkXf1xG1Kr3bZj2k2m7J6lMx8mO
         +nlw==
X-Gm-Message-State: APjAAAWBw/Oud37k46KbGEEkjgXkZu9pTeE5sf5j9MHTg1YsWW0HATXC
        ixRm82sdyB2wtXc4K9y34nnJoIdFLRJT0IUjUwPjE6YhFCwp6x8HSWA8B9rl58n9RY2DAb84ttz
        +dnzqJIRdpjur7YaqvTCLf8sJ+hcjXX6Hn7+T
X-Received: by 2002:a0c:80c3:: with SMTP id 61mr13126694qvb.33.1567263073244;
        Sat, 31 Aug 2019 07:51:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz1sUnNBvWbHzdh4FZf1lLowdBAXcm0Q4dIK5l8oWBSHpvQUvtg8jWOSrFA+cHyuD+ZWHE6ng==
X-Received: by 2002:a0c:80c3:: with SMTP id 61mr13126676qvb.33.1567263072932;
        Sat, 31 Aug 2019 07:51:12 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4340::ba0])
        by smtp.gmail.com with ESMTPSA id q5sm1703965qte.38.2019.08.31.07.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 07:51:11 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/staging/exfat - by default, prohibit mount of fat/vfat
In-Reply-To: <CAHp75Vc34bHCdsnd+FgzVgs7jjPeHsL6Np7VfEe7hnJ49xW3-A@mail.gmail.com>
References: <245727.1567183359@turing-police> <20190830164503.GA12978@infradead.org> <267691.1567212516@turing-police> <20190831064616.GA13286@infradead.org> <295233.1567247121@turing-police>
 <CAHp75Vc34bHCdsnd+FgzVgs7jjPeHsL6Np7VfEe7hnJ49xW3-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1567263070_4251P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sat, 31 Aug 2019 10:51:10 -0400
Message-ID: <306635.1567263070@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--==_Exmh_1567263070_4251P
Content-Type: text/plain; charset=us-ascii

On Sat, 31 Aug 2019 17:24:47 +0300, Andy Shevchenko said:

> Side note:
>
> % git shortlog -n --no-merges -- fs/ext4 | grep '^[^ ]'
>
> kinda faster and groups by name.

Thanks... I rarely do statistical analyses of this sort of thing, so 'git
shortlog' isn't on my list of most-used git subcommands...

--==_Exmh_1567263070_4251P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXWqJXQdmEQWDXROgAQKNjQ//VjH/tc4UUBMHJAAXtv9h79t7Ew5hPyFh
DBosfIIbeVgQpGBTTxu7Fb8BhwDm6wv6VtJbaJ1MyAJorJv1Vw25Nn7C+O4S51ee
YTcfaL1vbTuU7mSRWF6+3WIeOXO2kSsk07CKZARzWCdS+0ZrCNDvTkU9WzAb1hy3
xhcPTZOnSveIi7iVdgUps5Dp1g9PYsTYwoAdyPTLcGGi9M0hgvLgHnBv+U35Z9XV
Kj+l/vIIZqBkHqdX7Y65tfQDP1Btp/WWAkiUAtu8gSZGVEIQQMnQ0G4ntHsOBIl7
3qd2e6WxJnx9CZHtMXoamRaVE1+hyiuPXLbcl1+sqekLOaQT/1YPzAiZ/Mt34M3L
ayoyVEE6/P0sRsstYpc1PD3DqcGXXTJl+/gvONuwzNLqG0lNvNRUAtfIsqBlUDaf
pNwTNuKez72RuOnBiLx/egdcBcXl7yDbaioX4EWg0YDSdtomGtT16YwWL3BqURwt
kfEp/XXMmWHgIauXP5gx//dECGO9j/sD8iEHTqhuF4HcJVnTmAe/8Z2jRjpxe2iR
ZaVA4K5luzllriFTu0O/YYdXqH1L5kygashj6Oui40+x/PPw2LROd/ANCRhYhVED
muWQeELqhkTon3uwBECzyyHtKqj2TT1tSrABTq1B6YkSqMC2kP4QXL1ZolIl/y1t
fEpIDwa+Y7A=
=wbkw
-----END PGP SIGNATURE-----

--==_Exmh_1567263070_4251P--
