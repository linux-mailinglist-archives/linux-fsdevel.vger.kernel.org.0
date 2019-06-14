Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D44EC4680E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 21:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfFNTK5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 15:10:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35225 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfFNTK5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 15:10:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id m3so3648697wrv.2;
        Fri, 14 Jun 2019 12:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qrggckRqwzqE+687AEU2OojJ8a7zrArb+JSl8o0Vjw4=;
        b=rayG/z2HRetFZn2HaODu/GrCa4jqHCks19ez5NpHbbndaksHa3GoQiqB06ds312oLG
         Kj2t6SHd4oV7NoDNG3bPwz7at/o2+xze2B9NiPzxiyd+9P5b+N3sGqdIwHVZfTPdv52A
         vspLz4ZxvGgNTtKIsm/rgAM8jCmu/Q+FQowFWQa5NqwcTl+VlV512kfiuY6QMsw8kzgn
         Hm9tdv2O9Og7Loox/ZNmHKfDe+obyLmJ/bfMUY4JRCFchdVzG/fza9fCYjmMVo9jr2Kf
         Rg8a6lSkcUM+1+hvQ8Zzq2SruIObPwTP6YbKL1FG9j/GkFl2UfSpisI/yekUGX85TKIO
         2uOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qrggckRqwzqE+687AEU2OojJ8a7zrArb+JSl8o0Vjw4=;
        b=B1hVwOp/kKrsAehm7z1cyjesTzqpTA2WcbQiC5UgrtQfXoWdczBY0eXp0xWRnkYRs3
         TxzDBE2RJWOshJo6lr/do+HvMX0Olr8mSkbDvgNxOdm9wFyelNn198XOFl7yLiP+jqv+
         GwN+OM7oBcWr0sRxFhQZluBjAzkpF/THxIrQlGs8GqESq4hi5H+eHrOMxtZIxO6Ed6yi
         CDXyCM72anw4zZxS1dPKEGpGwkyADaMAa8fa7pQZp3+xTqcQJMp1iUs/StP1d0sgDfpC
         cy8ILXVzh0MZQ4lTxDzLVkVsgfnGqbPLtIc6ehx7XnrENHx32X1SSiHxUM6fPrY9SB+u
         N1cg==
X-Gm-Message-State: APjAAAWppYY7K7zMxpFsqWB01qNg+l7qc5CEHUhUlqpE1R32n8BJowAU
        8Xhfuj2aU+alOsiTQdydN98+zQDUjbQ=
X-Google-Smtp-Source: APXvYqw3BF4lCoCWCq+ma92ACJPhMyodhOncoLwNRZkplMdgZ50n3/jnqZcxn0EKz3JLitAF4Q3llQ==
X-Received: by 2002:adf:f683:: with SMTP id v3mr5420052wrp.258.1560539455205;
        Fri, 14 Jun 2019 12:10:55 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id g2sm4825176wmh.0.2019.06.14.12.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Jun 2019 12:10:54 -0700 (PDT)
Date:   Fri, 14 Jun 2019 21:10:53 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     util-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Help with reviewing dosfstools patches
Message-ID: <20190614191053.22whtrb5f5uqis64@pali>
References: <20190614102513.4uwsu2wkigg3pimq@pali>
 <ae5097ee-12af-2807-d48c-4274b4fc856d@metux.net>
 <9e81aa56-358a-71e1-edc1-50781062f3a4@metux.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="in23yynysfbxdhp3"
Content-Disposition: inline
In-Reply-To: <9e81aa56-358a-71e1-edc1-50781062f3a4@metux.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--in23yynysfbxdhp3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Friday 14 June 2019 17:45:20 Enrico Weigelt, metux IT consult wrote:
> On 14.06.19 16:20, Enrico Weigelt, metux IT consult wrote:
>=20
> <snip>
>=20
> Currently working through your branches. Smells like they really deserve
> a rebase and signed-off lines.

Every patch/pull request is mean to be based on current upstream
"master" branch.

As some of pull requests were opened long time ago, they are out-of-sync
=66rom upstream "master" branch.

Currently I rebased and force-pushed those changes which had merge
conflict with upstream master branch.

And now on each pull request passed compilation and 'make check'.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--in23yynysfbxdhp3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXQPxPAAKCRCL8Mk9A+RD
UuX5AJ46vqpIet8egkxbo/F0OHqmHeH7kwCgnQQzBB6Nr3uUcwShqXuXpsUIzo8=
=SZLS
-----END PGP SIGNATURE-----

--in23yynysfbxdhp3--
