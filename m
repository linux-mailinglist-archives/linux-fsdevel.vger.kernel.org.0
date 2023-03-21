Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AB96C37D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 18:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjCURKw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Mar 2023 13:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjCURKt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:10:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6785372F;
        Tue, 21 Mar 2023 10:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A0DBB818D3;
        Tue, 21 Mar 2023 17:09:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E23C433EF;
        Tue, 21 Mar 2023 17:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679418590;
        bh=kdWqS/e+sKonowSJQi5knjG8RtTeulUae8t8lT/tj94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZgP/zney0RxkfxiYC0h0uNFKINgVFhMRkTFoDjmxpyVIimrPvegj7UxYkRjG86RG+
         4Ucse6+U0toZ5epVETfe6mlwEKHyODjgRn4liysLMficvDLpDgLKk8tCVPGQyAdDoZ
         2rSFOupBs0aOwgaD4YASFB01x1OOq/07EQ4C1x70DfUhlljbEvwY0Iyq9Ydeu+rr/f
         DbHXuTXspAQXbNC7puuXYHlLpml2S+TGs3YxeKPyzaNsyECIkhqKNboa1u/IxoCpGH
         Ag+47bafIxmFwW21pA+alZjwI8ddcy/NfkKhpUel7FxEEL6h8mE4vmmsI9JCDm9+3x
         XH1d2qvmIN0dg==
Date:   Tue, 21 Mar 2023 17:09:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     syzbot <syzbot+9f06ddd18bf059dff2ad@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, ckeepax@opensource.cirrus.com,
        jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, shaggy@kernel.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Subject: Re: [syzbot] [jfs?] KASAN: invalid-free in sys_mount
Message-ID: <2d0114ce-a811-47e9-9a76-8c7a80f1faed@sirena.org.uk>
References: <000000000000698e5d05f76c0adf@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UhOUWIYICTHnIC7N"
Content-Disposition: inline
In-Reply-To: <000000000000698e5d05f76c0adf@google.com>
X-Cookie: Will it improve my CASH FLOW?
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--UhOUWIYICTHnIC7N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 21, 2023 at 10:04:46AM -0700, syzbot wrote:

> The issue was bisected to:
>=20
> commit a0b6e4048228829485a43247c12c7774531728c4
> Author: Charles Keepax <ckeepax@opensource.cirrus.com>
> Date:   Thu Jun 23 12:52:28 2022 +0000
>=20
>     ASoC: cx20442: Remove now redundant non_legacy_dai_naming flag

> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D12756e1cc8=
0000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D11756e1cc8=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D16756e1cc80000

This does not seem especially credible for the backtrace provided:

>  slab_free mm/slub.c:3787 [inline]
>  __kmem_cache_free+0xaf/0x2d0 mm/slub.c:3800
>  __do_sys_mount fs/namespace.c:3596 [inline]
>  __se_sys_mount fs/namespace.c:3571 [inline]
>  __x64_sys_mount+0x212/0x300 fs/namespace.c:3571
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd

which is nowhere near ASoC, let alone that specific driver.

--UhOUWIYICTHnIC7N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQZ5NcACgkQJNaLcl1U
h9BJBgf/WJnuTPyzPxNZcVE/Y2Nn4WhuqOMTenRwekqMToG4fEK99ITA1NYnWBRy
ixCUajNCuBvf2X6YmjYiNsf79Nio8JVdamUSEpDV5mHq0zpN4B6txrZCSm1FFXL9
nrHe02bAEoaYdrLAS8/mYGQRckp8A7cJYEZnzeC1wo43Mk3qbFrnuezKi52VRUNv
2wGPCVCXAlp7yEDfTObNGAAOg6m6009JBioTcQq9IeCog99a7oFYud7kQhvFebA8
K7PDgAbUAY+WD9bE0ba/Xg3P6xjpq7KpEW+SIck1UpsrKpLJlK54kP9eXgMzwhRx
fPddOZeXHclJfKKPwlcYKI6yoZeDsw==
=uJQW
-----END PGP SIGNATURE-----

--UhOUWIYICTHnIC7N--
