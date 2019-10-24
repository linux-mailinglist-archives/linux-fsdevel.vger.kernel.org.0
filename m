Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B740E38A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 18:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439906AbfJXQqW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 12:46:22 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:47244 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2439903AbfJXQqW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:46:22 -0400
Received: from mr3.cc.vt.edu (mr3.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9OGkKYp023699
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 12:46:20 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9OGkFcr032537
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 12:46:20 -0400
Received: by mail-qt1-f200.google.com with SMTP id n34so12717126qta.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 09:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=EsIPMrPy/NQRL+kAPu6vRsFGMxp34/kqcwgNBhAoed4=;
        b=LUY3WCxodRjznf7qsW/UG63nYpU14iqg0/LHLfAfM8gi9G67bbEFmyVj1zd2mZ+7Mz
         /czYxXS68ViLzEhG2JsMo5mvceOK5Zd/rNTAnKMEvEZGhpfFUZbAH8+wWNL4gptmlqHE
         InlVjOiJyBw9yRbxGJO+82IXQ8CEO4euHDGWYpZAvBvK+XwPRAx38JjjBY6tu2CcM0ur
         Z1/D+2bszo4N86v4D0fiu9ZF95d5T8s+Ae2ecUvbEONTg7NVh0kC20HeiAG6KOCB1G38
         SoVFDklelk3t3YhVg1vHYBOn0Bj0RK7hjP4NM0Cj1NRtEsc6KRiFAayJHk3PsaElqPQm
         uyiw==
X-Gm-Message-State: APjAAAXkwbwMqpX04ym2F5a+iIjuMdcrCLTTm+PqtiULZZcWD5HmqnSl
        B53AxYKdn7WdHn8AnPJ4Fh1xVH8DE+8xfmYmMtiCpwyN3kKLXCSjMAOWUbMJIOoX38PjXJ71/yA
        OGBANKV/m5/bZpImb1ANQqooTbihbMhIJu7dH
X-Received: by 2002:aed:241c:: with SMTP id r28mr2210118qtc.148.1571935575564;
        Thu, 24 Oct 2019 09:46:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxwOx2g9Rq1d1Pyls0CB0utL2xABAepZupau/TdbqZ6xqsFeKRv/w6rIr8Gn2U/r+gM8+T5hg==
X-Received: by 2002:aed:241c:: with SMTP id r28mr2210083qtc.148.1571935575248;
        Thu, 24 Oct 2019 09:46:15 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id c21sm11331089qkg.4.2019.10.24.09.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 09:46:13 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/15] staging: exfat: Clean up return codes - FFS_SUCCESS
In-Reply-To: <5c7a7fe972469296d367dba504f0b6c8063a7d55.camel@perches.com>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu> <20191024155327.1095907-16-Valdis.Kletnieks@vt.edu>
 <5c7a7fe972469296d367dba504f0b6c8063a7d55.camel@perches.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1571935572_59326P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 24 Oct 2019 12:46:12 -0400
Message-ID: <1116783.1571935572@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--==_Exmh_1571935572_59326P
Content-Type: text/plain; charset=us-ascii

On Thu, 24 Oct 2019 09:29:00 -0700, Joe Perches said:

> > -	if (sector_read(sb, sec, &bp->buf_bh, 1) != FFS_SUCCESS) {
> > +	if (sector_read(sb, sec, &bp->buf_bh, 1) != 0) {
>
> Probably nicer to just drop the != 0

Again, that's on the to-do list.

--==_Exmh_1571935572_59326P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXbHVUgdmEQWDXROgAQLooBAAjVK/FBta4kL6kv8k49RtGTrWLd5FD8zr
OtoLLQLewcYlbmpWjneJPKZpTjg+nsOF0cHELzEXKkIzCmg5YAnlG2w8OOlEW6AO
jTdhUTY9rrFOKuQeZmzalltqYjVHCMOie+oD8xGNXT1bSj5DTKarJfHwFGD3yPss
nJBhADhUm1L/n1aviplbSsm7BFjrFbqWjtMLKW3+qOLeA+OpEQMAf877I+3CYNPS
k7evBj/qN9sVgvPM0w86nff0mo5s+fYNak6V22KrnX39z+7zb+DA5NjR3Bd1u930
gr/ZdVPOuepeoZnNvDIR/bj6NMqsPhkP/YE8QYr1jHAE7ZPc3ADaDVP0mPV6ekIC
DymnE7CGhz0fBAQwaOnEeylkQilfx9XPGYedPPA9/QjbA3R2n3Vgtesa74QP505a
UuEtf0YeQde+46a0t7M1KIix1MGnAMYrB7zlqwyaCMeEQQZ0laHPRUkLQEMxd32T
WT0m0n6/pL6aXAuvPkoAzsQB1bFPsrf/Bz6Gx58ZRlk0303MAD0Lr8oVGpaEV5rT
AMdJ8TM8CdvvkASuC6fzHHpsf68YfXaIq0uvQtu/bvYi7TMtlYuOVowuCYWvZEtf
i01HkSLHyBUbGj+hzgoDjXafMFt9q7nKtrgsYT6tFForrf3FGIKHWVetwGbaKJY0
i0VtHsFXSMA=
=hBtD
-----END PGP SIGNATURE-----

--==_Exmh_1571935572_59326P--
