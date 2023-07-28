Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C3F7662C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 06:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjG1EHE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 00:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbjG1EHC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 00:07:02 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0082130F4;
        Thu, 27 Jul 2023 21:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690517197;
        bh=pcQAPdGAc64rGs8Q8YF3FyAN7z68cqGb6vBQ20gSNTI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fOjoj7qiHnPnlKdFgMZ+0gjqSWwmQqBEsnK2mYYKFdMO+cw9BklEUfYPvFRD6T3b3
         ortaIruVUodPqY/i+KyqWiW+7hgJ2N2zoMJw0SqQ/PhvCnZLb3PygByx6TlW4+LkRY
         liOERS6BIc/IIVAqn2aOhykurU+X0zSzdCQo5E72KRv3W+vxSR4T5GVGBS6tYg2LF3
         4bqTEwaCnOOpOg0YaeBaJ9JpgUCz1NNzFmn0QLfDB4LvSCWpcZqH8J4R2hzNocThv/
         zoMCg261d6hRqzR2ROTI9jwjFsZjOsf7fPWvvXSZ1S9KJpcEhObhfCYaangjx7/MwM
         ruR5mrhx3yibw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RBvG45TP8z4wqW;
        Fri, 28 Jul 2023 14:06:36 +1000 (AEST)
Date:   Fri, 28 Jul 2023 14:06:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     akpm@linux-foundation.org, adobriyan@gmail.com,
        mhiramat@kernel.org, arnd@kernel.org, ndesaulniers@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH RFC bootconfig] 1/2] fs/proc: Add /proc/cmdline_load for
 boot loader arguments
Message-ID: <20230728140635.2ea3e82d@canb.auug.org.au>
In-Reply-To: <20230728033701.817094-1-paulmck@kernel.org>
References: <197cba95-3989-4d2f-a9f1-8b192ad08c49@paulmck-laptop>
        <20230728033701.817094-1-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EBviVOK.OrMU/Lj0QJSW_zt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/EBviVOK.OrMU/Lj0QJSW_zt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paul,

Just a couple of nits:

On Thu, 27 Jul 2023 20:37:00 -0700 "Paul E. McKenney" <paulmck@kernel.org> =
wrote:
>
> [ sfr: Apply kernel test robot feedback. ]

This was a fix for my own build testing (I am not a bot (yet) :-)).

> diff --git a/include/linux/init.h b/include/linux/init.h
> index 266c3e1640d4..29e75bbe7984 100644
> --- a/include/linux/init.h
> +++ b/include/linux/init.h
> @@ -112,6 +112,7 @@
>  #define __REFCONST       .section       ".ref.rodata", "a"
> =20
>  #ifndef __ASSEMBLY__
> +

Please remove this added blank line.

--=20
Cheers,
Stephen Rothwell

--Sig_/EBviVOK.OrMU/Lj0QJSW_zt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTDPssACgkQAVBC80lX
0Gwf5AgAi37ZIN9HLZU6bU+R+FwyrYNDr2cZ/NJ4Dp+VxCJzDpg5+kjYsWoX6IA2
KDI8vz2oIDpB8HuQpTDQqMYRLMgM2JKo9tC5stoMX0xGgm2s8OQZBAQALVXbJRS2
0EJMMcuANvLzL0lYw1L0IpMyFVKPx1JbXXkCtl/M7d43OgBwihtDbb9isvsbVQ7n
/Rc4LUqcfXNpjOgUPlchY89RTUUHuXMkT5evqvD6psh/h7sSt8BflvTQXopm6rWU
ArQM6/36EYYb5Bza5yao0y2hUlh6OIrSOvoydGUirwQeEhcA4OPYzX+qCtQZrhn1
txkRvf76hsFpsJ/29oJMqSn6AcZ9bA==
=ggdP
-----END PGP SIGNATURE-----

--Sig_/EBviVOK.OrMU/Lj0QJSW_zt--
