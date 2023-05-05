Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D3D6F83FE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 15:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjEEN2I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 09:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjEEN2C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 09:28:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E883821556;
        Fri,  5 May 2023 06:27:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57B2063E26;
        Fri,  5 May 2023 13:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6EEC433EF;
        Fri,  5 May 2023 13:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683293266;
        bh=d3kRte1MpgDiOaz1OXedDsZaqaH5ZvGBYD4hjy22AkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u8WpmSAAFXJs7+8TpPQvf/O5iKrp/Vfn82gzylXfJXwE/6EkmdpifEeL9tatQ6CB7
         BiiwpfuGISYRSD78J2kLUj1pr0k8Kv2i0jFCLoG65EMS7TD+MF5yw3BaHTSWJiUWP1
         J10CN7gSIOJR2kr4/onVEKEB9TG7jCmlUybZFBHfxH9OEeE73HaUdPCaQLTgsb49eW
         8vUudK8ug1FUifsUMSnYo62E42bGPXJeKIJlnoWET2oXYxVzmSeGBlfqkgQbWl9IGW
         dZEy+qV1dejT62cudqwkX5deWxvealp3hCBnn+9BVUCJ8dNjp0Hj/CtVl7ebvPo7gx
         fXtIwYhxdEZOQ==
Date:   Fri, 5 May 2023 22:27:44 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     syzbot <syzbot+630f83b42d801d922b8b@syzkaller.appspotmail.com>,
        davem@davemloft.net, edumazet@google.com, groeck@chromium.org,
        jiri@resnulli.us, kuba@kernel.org, linmq006@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [net?] WARNING in print_bfs_bug (2)
Message-ID: <ZFUEUH6ZEE/2/Ds4@finisterre.sirena.org.uk>
References: <000000000000e5ee7305f0f975e8@google.com>
 <000000000000db8c6605fa8178df@google.com>
 <ZFHLu13XQZpOn/8T@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oGYsn4n4gVx7MRWk"
Content-Disposition: inline
In-Reply-To: <ZFHLu13XQZpOn/8T@google.com>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--oGYsn4n4gVx7MRWk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 03, 2023 at 10:49:31AM +0800, Tzung-Bi Shih wrote:
> On Sat, Apr 29, 2023 at 03:54:28PM -0700, syzbot wrote:
> > syzbot has bisected this issue to:
> >=20
> > commit 0a034d93ee929a9ea89f3fa5f1d8492435b9ee6e
> > Author: Miaoqian Lin <linmq006@gmail.com>
> > Date:   Fri Jun 3 13:10:43 2022 +0000
> >=20
> >     ASoC: cros_ec_codec: Fix refcount leak in cros_ec_codec_platform_pr=
obe
> >=20
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D13d40608=
280000
> > start commit:   042334a8d424 atlantic:hw_atl2:hw_atl2_utils_fw: Remove =
unn..
> > git tree:       net-next
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D10340608=
280000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D17d40608280=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D7205cdba522=
fe4bc
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D630f83b42d801=
d922b8b
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D147328f82=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1665151c280=
000
> >=20
> > Reported-by: syzbot+630f83b42d801d922b8b@syzkaller.appspotmail.com
> > Fixes: 0a034d93ee92 ("ASoC: cros_ec_codec: Fix refcount leak in cros_ec=
_codec_platform_probe")

> I failed to see the connection between the oops and commit 0a034d93ee92.

syzbot seems to generate a *lot* of false positives, this looks like one
of them so it's probably safe to ignore the bisection.

--oGYsn4n4gVx7MRWk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRVBE8ACgkQJNaLcl1U
h9B0lQf/VKJ282l9taOsX67wWq9qpLyTG1VV2PxzyVSvwFyPzlHz6D538HlDniR/
WjZ0OApHXvNki/qSjBNj6NVuOKcRyeRI8hKpsKOWZSgNLQ09uJAA2U2rwAj6cFwC
liYUms5wvLj5HP+y/CjSHaspgvYt4kZoT8lCZdzc1C7F+3t0WawaA71JSgndgW6F
+IYz1aBVkZefRgjb+Od7uOiRHlg8WpIEtE43eYWFgdypBK1Xn3ptBzzR6I+PK8E5
96c1nf87TzaBxgYquUa4Gc19pciF3rsITBgPA3o//Cmvw7KKwjx/Vi1MbdnIjIlQ
XSwlRT8oJJgalw4jnXEipIqHa7Hkng==
=0d//
-----END PGP SIGNATURE-----

--oGYsn4n4gVx7MRWk--
