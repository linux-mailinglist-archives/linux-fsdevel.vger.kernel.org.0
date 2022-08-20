Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960F259AC87
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 10:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344265AbiHTISW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Aug 2022 04:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344076AbiHTISU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Aug 2022 04:18:20 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529AD2A7
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Aug 2022 01:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=H3iQuGpulYLrPVXcWItrYymNuR20
        LcEh8kLqsygp7Xs=; b=2RoZqc4c/b40/C2JsuYl5sTjER1je4ipZivAOAmcDNRW
        i9W3/wm2hZ/1/mYc0vGRlJNiEybQ7grRrl2Ny+6BF6t/FoN13wp6nVmV31q+pKcN
        Kldmw5dtPagyVk/0XngBwJ+veqMvCwQD0WDgcYzZVkqrgllbVpOvhdV6UxWpslo=
Received: (qmail 403734 invoked from network); 20 Aug 2022 10:18:08 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Aug 2022 10:18:08 +0200
X-UD-Smtp-Session: l3s3148p1@MxzD2qfmTt0gAwDNfy09AOVJm2UNvjsf
Date:   Sat, 20 Aug 2022 10:18:07 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/14] vboxsf: move from strlcpy with unused retval to
 strscpy
Message-ID: <YwCYv9esPb200L3k@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220818210123.7637-1-wsa+renesas@sang-engineering.com>
 <0d44fb03-0481-2f0d-eeb5-63cbddeffc62@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qppcLu0zUe02zHv3"
Content-Disposition: inline
In-Reply-To: <0d44fb03-0481-2f0d-eeb5-63cbddeffc62@redhat.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--qppcLu0zUe02zHv3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Note you send this one twice. Since I'm not sure which one
> will end up getting merged, I'm going to just reply to both...

Ouch, yes, I sent out all subfolders in fs/ twice. Will fix my scripts,
I am sorry for the noise!


--qppcLu0zUe02zHv3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmMAmLsACgkQFA3kzBSg
KbaBCg//eSai8OmScogCqSq/DQzg+DHk2k4TUDMYCLtbN98DK/RMYf0uSJQNzO5m
SfeyioGtgLONKXMmZOTRZCbiGVodSvUKQS1pPVB9pJbOniSUHJk7CHz8C6ov3WOx
i36pUn41i/zG4lZ+NQTi3FVmR9AFYX9Frdy6egwGrC9Y/DvaE/8pimV5s1YXM+84
nqxNLjhWgdZpENOixYPuCTX19gRw6M+u5hyYCZYe0iq1uapVI/p/fO4D2vfxCYxD
PBEPJzKmtXBqiP2ydRnAiNNK6QfMgs7q8prgYMHW/6bde3GY1Rt/mIhMl2kIH1sE
0Apbpl8iSeAkpNB066vUE5ML6QCgArg2eqeu3OtopdY9E8yftOhukJIK9kVthFiz
7f9tRr2nSG0N12aNijgtYFOV3t+i+cm1VeXW/ghBYpxiaJTSXmdrbzNzfLxPgB4a
kzVnQe+Y5CF2Fl8z4AuQaQ3+HO9NPvaRL49FErCYO0139nGUXt3ZDfzQx1RBOhYz
N1CKTAOyeesLWOLI+FjejoL0jmmT7hTrEa46Xg7kyxvUgjFSN8Wu9MuC9AnvnjIs
HLnclxDLnrriYWZkAreXvpPzV8XjnjJCSwWKRTPNtVLKKdBPpfEtPD904D15WqIg
HiIVv8bVriTuwPvLPg6NcKE0Mq9EyfwQe+u1pAdh7N4UK+Ivoec=
=I1oR
-----END PGP SIGNATURE-----

--qppcLu0zUe02zHv3--
