Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6443549DA57
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 06:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbiA0FvP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 00:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiA0FvP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 00:51:15 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE46C06161C;
        Wed, 26 Jan 2022 21:51:14 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JkqTC6jd6z4xcW;
        Thu, 27 Jan 2022 16:51:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643262672;
        bh=IT/5oeVf+5eLV6UP5nfiGX/ZILAl3ow5U5CT3rHdSv8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iSnQv1K8TDsJhD2o4WngHRECCgfa2jJ1prXHCjp5z8H+b3LvwOeKOJGBD7fpDq4ga
         0UzagLisDfofmkxJ3F+f+jD6MxldO/yXFGPi0lnHObd+GlC/gbFUEqFIoHKHueYTfw
         uVDYQnpoh2x76Xv7Vr2frc1GMaeOPy6rrdgMOSid5DeY7rBS4DpTn2tiYldNcgVzbO
         DgxmXVatbzCgt9linNyObOeClNgmgodnPA8ZLH2tzZggKFvXOuI2I668BCGUWugZb2
         sVbheFJcSEgUmkJdMzduewDZnVQVLWhqoLwbNF9iLaAwd1P/QJEZ9cLGBzJt7kfy5b
         fBqnhU51/6O1g==
Date:   Thu, 27 Jan 2022 16:51:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     akpm@linux-foundation.org
Cc:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org
Subject: Re: mmotm 2022-01-26-21-04 uploaded
Message-ID: <20220127165110.55e88e44@canb.auug.org.au>
In-Reply-To: <20220127050456.M1eh-ltbc%akpm@linux-foundation.org>
References: <20220127050456.M1eh-ltbc%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yh9HQnnZ0L3mZQiAfJzkJxB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/yh9HQnnZ0L3mZQiAfJzkJxB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Wed, 26 Jan 2022 21:04:56 -0800 akpm@linux-foundation.org wrote:
>
> * docs-sysctl-kernel-add-missing-bit-to-panic_print.patch
> * panic-add-option-to-dump-all-cpus-backtraces-in-panic_print.patch
> * panic-allow-printing-extra-panic-information-on-kdump.patch


> * sysctl-documentation-fix-table-format-warning.patch

Just wondering why this patch isn't up just after the above patches
(instead of being in the post-next section)?

--=20
Cheers,
Stephen Rothwell

--Sig_/yh9HQnnZ0L3mZQiAfJzkJxB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHyMs4ACgkQAVBC80lX
0GzQXgf/ddidSmsqbc+sCcVI3RHLKW6OH0UQ3mWuVlihhKP4No3GXq/ly85xR3hw
oWGG03tzKRZHTIArg6/VLpIvl/+xaX6ZCO2TiYib0Pd+ckX5acDNWHB3tEc8tewP
oYDUvxdu4sllfeoCry1JJ+ukusohUjiZSA+gRcn2HP/5CsOPcRzW2Aut5FTWYeOD
l/rNa4AdhfGpa0SC58eUGhr+7Lilak4x/QHey/hQ9dMqZmoP3whge5R0L0TH4kT8
oeASJQQBQf0CnrYrXNips9wSJh3HR5ezt9dsdD3tiOBEiEAFYvP8aclNW9c9N2eF
caVFu0SOQAys91FIitCFjtE3HiUESw==
=RmY0
-----END PGP SIGNATURE-----

--Sig_/yh9HQnnZ0L3mZQiAfJzkJxB--
