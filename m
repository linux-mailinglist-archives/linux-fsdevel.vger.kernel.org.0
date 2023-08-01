Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF37B76B041
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 12:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbjHAKDj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 06:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbjHAKDU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:03:20 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602F7EE;
        Tue,  1 Aug 2023 03:03:19 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fe167d4a18so31975935e9.0;
        Tue, 01 Aug 2023 03:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690884198; x=1691488998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6xzFd6kXeaygrI5Ej8/AL8nxngfv7zWbrLM3nGa6LwE=;
        b=eXsvFh6BK+B4iuEJYMTnBcTL7rHnOTSND3P9MAnpkjJqEpLCdcVuq/3LHC8WhWxlOi
         AYVHc0UleUBBoRaduveJnpBbMfklz/v7bfVQyhDeoiCpwWcDLTvnVdKzWsATvnXRFrIQ
         4sxETc63wfFaT1bcwPenmbK5Cd68zjDF7/mwm/QlGSxaYKSqfPBfKA0mGUHtfQgxDKuN
         bfckck3WXSVwZdpmMoaLqOAU0MAofGr+AO2UcfWw2DAsMdq42RxNJsTnAee8Lvikj6hM
         UobnKUJtXdI2bFxeUV6lKnu0txtKROjJB89U3UM49XZz3hMCMQfPajpd2YztNuqg5bYr
         w4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690884198; x=1691488998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xzFd6kXeaygrI5Ej8/AL8nxngfv7zWbrLM3nGa6LwE=;
        b=FmxKcGxm0PfjF2A3o4YIU4YHqPa2Bb3ZtIwM4LFrKGxKPgIHiGQ0U9QFu0apKbbk7L
         SIzblwYWgbHhCKloBctr2ZAVJrtelCQNpySQ3TpvXQYl7NRvp8xpinHgD7XtS4DyaIm3
         ldCYRbGxCfUgQTyXBc9PjwXicwCu4JaQWsUYS3SxC5l6V07X/Q1b1DlTA5WrfF8pKokD
         DzZpmRZH7Dvrx3Q7GkH0qRn89Xg6ETNC0X1hAo729a+OKdDDytLvfydGvJQQsYZA7BYj
         UHq+GYSNvtUhMqy1CUuEsSSOdARtoq/JwaUAJ/9/cmXKPRoyBV23SjcpHSPxXNdLoKDx
         n+cA==
X-Gm-Message-State: ABy/qLZDBAo9OUQtBN6f2vaJVmGLsCQGz6NhSPLr2IRgTferO15u1Twh
        g+EjizDozUAixlbWO2BBZ8I=
X-Google-Smtp-Source: APBJJlHPT6WT6baqr5uMvSTuUS8XBMuz9v2AzEIRtzwB1vPwVdTIJR+TY0kuPM2KiW9G9XEqBLrTBg==
X-Received: by 2002:a05:600c:214d:b0:3fe:20b6:41b2 with SMTP id v13-20020a05600c214d00b003fe20b641b2mr2182378wml.4.1690884197477;
        Tue, 01 Aug 2023 03:03:17 -0700 (PDT)
Received: from localhost (0x934e1fc8.cust.fastspeed.dk. [147.78.31.200])
        by smtp.gmail.com with ESMTPSA id n1-20020a05600c4f8100b003fe15ac0934sm2670378wmq.1.2023.08.01.03.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 03:03:16 -0700 (PDT)
Date:   Tue, 1 Aug 2023 12:03:15 +0200
From:   Joel Granados <joel.granados@gmail.com>
To:     Simon Horman <horms@kernel.org>
Cc:     mcgrof@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Kees Cook <keescook@chromium.org>,
        "D. Wythe" <alibuda@linux.alibaba.com>, mptcp@lists.linux.dev,
        Jakub Kicinski <kuba@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Paolo Abeni <pabeni@redhat.com>, coreteam@netfilter.org,
        Jan Karcher <jaka@linux.ibm.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Will Deacon <will@kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        bridge@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        Joerg Reuter <jreuter@yaina.de>, Julian Anastasov <ja@ssi.bg>,
        David Ahern <dsahern@kernel.org>,
        netfilter-devel@vger.kernel.org, Wen Gu <guwen@linux.alibaba.com>,
        linux-kernel@vger.kernel.org,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        linux-wpan@vger.kernel.org, lvs-devel@vger.kernel.org,
        Karsten Graul <kgraul@linux.ibm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-sctp@vger.kernel.org, Tony Lu <tonylu@linux.alibaba.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Westphal <fw@strlen.de>, willy@infradead.org,
        Heiko Carstens <hca@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-rdma@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Simon Horman <horms@verge.net.au>,
        Mat Martineau <martineau@kernel.org>, josh@joshtriplett.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Dumazet <edumazet@google.com>, linux-hams@vger.kernel.org,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-s390@vger.kernel.org,
        Xin Long <lucien.xin@gmail.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        netdev@vger.kernel.org, rds-devel@oss.oracle.com
Subject: Re: [PATCH v2 03/14] sysctl: Add ctl_table_size to ctl_table_header
Message-ID: <20230801100315.ymcahsxu6qpw7kct@localhost>
References: <20230731071728.3493794-1-j.granados@samsung.com>
 <20230731071728.3493794-4-j.granados@samsung.com>
 <ZMf9vZpGE98oM9W2@kernel.org>
 <CGME20230731190724eucas1p14cc08261cd20815797958bbebc0fafe7@eucas1p1.samsung.com>
 <ZMgGWm4sT+VqDZ3u@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d62tnfuywe5q6aej"
Content-Disposition: inline
In-Reply-To: <ZMgGWm4sT+VqDZ3u@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--d62tnfuywe5q6aej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 31, 2023 at 09:07:06PM +0200, Simon Horman wrote:
> On Mon, Jul 31, 2023 at 08:30:34PM +0200, Simon Horman wrote:
> > On Mon, Jul 31, 2023 at 09:17:17AM +0200, Joel Granados wrote:
> > > The new ctl_table_size element will hold the size of the ctl_table
> > > arrays contained in the ctl_table_header. This value should eventually
> > > be passed by the callers to the sysctl register infrastructure. And
> > > while this commit introduces the variable, it does not set nor use it
> > > because that requires case by case considerations for each caller.
> > >=20
> > > It provides two important things: (1) A place to put the
> > > result of the ctl_table array calculation when it gets introduced for
> > > each caller. And (2) the size that will be used as the additional
> > > stopping criteria in the list_for_each_table_entry macro (to be added
> > > when all the callers are migrated)
> > >=20
> > > Signed-off-by: Joel Granados <j.granados@samsung.com>
> > > ---
> > >  include/linux/sysctl.h | 14 ++++++++++++--
> > >  1 file changed, 12 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> > > index 59d451f455bf..33252ad58ebe 100644
> > > --- a/include/linux/sysctl.h
> > > +++ b/include/linux/sysctl.h
> > > @@ -159,12 +159,22 @@ struct ctl_node {
> > >  	struct ctl_table_header *header;
> > >  };
> > > =20
> > > -/* struct ctl_table_header is used to maintain dynamic lists of
> > > -   struct ctl_table trees. */
> > > +/**
> > > + * struct ctl_table_header - maintains dynamic lists of struct ctl_t=
able trees
> > > + * @ctl_table: pointer to the first element in ctl_table array
> > > + * @ctl_table_size: number of elements pointed by @ctl_table
> > > + * @used: The entry will never be touched when equal to 0.
> > > + * @count: Upped every time something is added to @inodes and downed=
 every time
> > > + *         something is removed from inodes
> > > + * @nreg: When nreg drops to 0 the ctl_table_header will be unregist=
ered.
> > > + * @rcu: Delays the freeing of the inode. Introduced with "unfuck pr=
oc_sysctl ->d_compare()"
> > > + *
> > > + */
> >=20
> > Hi Joel,
> >=20
> > Please consider also adding kernel doc entries for the other fields of
> > struct ctl_table_header. According to ./scripts/kernel-doc -none
> > they are:
> >=20
> >   unregistering
> >   ctl_table_arg
> >   root
> >   set
> >   parent
> >   node
> >   inodes
>=20
> Sorry, I now realise that I made the same comment on v1.
> And I didn't see your response to that until after I wrote the above.
np. I'll hold off adding this to the set until I get feedback from my
proposal. I do this as I'm unsure about the contents of the docs.


>=20
> >=20
> >=20
> > >  struct ctl_table_header {
> > >  	union {
> > >  		struct {
> > >  			struct ctl_table *ctl_table;
> > > +			int ctl_table_size;
> > >  			int used;
> > >  			int count;
> > >  			int nreg;
> > > --=20
> > > 2.30.2
> > >=20

--=20

Joel Granados

--d62tnfuywe5q6aej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmTI2GIACgkQupfNUreW
QU/jnAv/XiexP2W1Y950obHBDBGWwb2QRwk7qg172MXMjFQl6+imM/lk9f2BbUyv
yHqtlJQeHzRDFmaanGI2f0Cd5i7XkupsNoINecjz4w7t3g4pgPxjYO+KRGJoQxRx
zfGIkM/UKYfW53TJRg0P0b9t7XnQ+yew+ZAEULLKb23ElXZ+hFXMtH8K938NEqxz
ETsCG4rlGIO3QMm0epmk4EaMr34faYtf8fzaY6T3PshcTq+vklW7M/gHjcMkICK5
GZM7Ijb2sU5Xd4d8hkoSpPh8TErgjuNVU2LpzlzjyC25WFM0xpPnKRDB5ENGa4m4
ZWu67LrebJoLjoE0vJUMMfZu9PCmvQp4Wijuc/ImQA4BA8hNwsarFhYlFMPp3Ixn
AC51TcUplS956Laxzjd51ql75jba5ul88ZGiqnkNL+IXKOjceJSKM68lVQELv1Lq
m9Il+S1C7xVBNvDQo9yE5jA7mdju9NyxvL2UXr4sZU7Gmp8qiY5Zw4H6T6dSQy8H
ELxemNee
=dUoN
-----END PGP SIGNATURE-----

--d62tnfuywe5q6aej--
