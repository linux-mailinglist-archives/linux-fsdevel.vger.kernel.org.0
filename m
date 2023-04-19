Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E446E797A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 14:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjDSMQt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 08:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjDSMQs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:16:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652FD7D83
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 05:16:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01A4763E68
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 12:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E713C433EF;
        Wed, 19 Apr 2023 12:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681906606;
        bh=3N2GD/i2aDPV+NKqROCavNsu6YrLSonitDJssFoKS9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fb+KJreoQpMPIR93rP5IoEn5LleZWYqZyVDgAyLCrXOLKGustU3740RX2Gf2UDcct
         +diBPPEmBZ1qdtJRf/A91i/YqWSNqIr0Otzd+KJVbTs41oc220SBdZtpG+KIScRvwn
         ERsyc+aS5TheY6rQ4tsucGlz5lARPo5r7h1/5xfYEi0e6qBRPtz0YoO2bxmclO4RV1
         XviAWb8N++aJx7ZHSoEvq1RvT+pTC9qZwK0iIP3DQD6A/WfYExOyHRImFHY/rG8edu
         718oUkvKOl7kuG84PAZn/dVJihkpkyhjhJ6vQW4G8GWjY7OdDKgAIRdRLnRNlTA1ml
         Cd8tf/Nh/YoPg==
Date:   Wed, 19 Apr 2023 13:16:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, tytso@mit.edu,
        akpm@linux-foundation.org, sfr@canb.auug.org.au, hch@lst.de,
        Eric Biggers <ebiggers@kernel.org>,
        syzbot+d1ae544e6e9dc29bcba5@syzkaller.appspotmail.com,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v2] ext4: Handle error pointers being returned from
 __filemap_get_folio
Message-ID: <5d9419e0-a6f1-4840-a066-0eaeba82bdd9@sirena.org.uk>
References: <20230419120923.3152939-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R2jxZyJhX2odx8/H"
Content-Disposition: inline
In-Reply-To: <20230419120923.3152939-1-willy@infradead.org>
X-Cookie: This is your fortune.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--R2jxZyJhX2odx8/H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 19, 2023 at 01:09:23PM +0100, Matthew Wilcox (Oracle) wrote:
> Commit "mm: return an ERR_PTR from __filemap_get_folio" changed from
> returning NULL to returning an ERR_PTR().  This cannot be fixed in either
> the ext4 tree or the mm tree, so this patch should be applied as part
> of merging the two trees.

I'll pick that up for today.

--R2jxZyJhX2odx8/H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQ/26gACgkQJNaLcl1U
h9DzHQf/e+nB5S5B3vphDxy7NUYxtvgq8wxJziKfd+SvVoS33v2zLQavwNHXA/fL
pyiTJ+pTQ+oG73xFxKqnVJ7AzjzJDjfOcoGo/auMDwjFx9Gq8rvBtqfCSwjdIg9F
nJ3TlkaDLdDzcchzBQdYIPyjZkpl4NdAhUmIsx+JVupYH7AJd03pCqxRgJepipY3
7buJoYBRdmG1iMjDcgROIrWSS+mahBbeOXBBG1sook3fggEnHCwcKbdoYClEGwsP
+xkkwpF/Dhf/V2yM6m91t9HTCCrbe6mNzW77NkyN+wIBuyAWXRB4u2PdKcIn7GP0
BjhoXEj02cizlSPllOtsURfPgNaAmA==
=nhz3
-----END PGP SIGNATURE-----

--R2jxZyJhX2odx8/H--
