Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13A06DDB40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 14:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjDKMxj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 08:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjDKMxY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:53:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE663A8F;
        Tue, 11 Apr 2023 05:53:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DF48E1FD6A;
        Tue, 11 Apr 2023 12:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681217601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EkSlnfLVrBuvRIjHTj4YkNGB03MrlcmP9bduCieRg3g=;
        b=ajgGNA5WZlfmxWLIlPe/Fpt1PDYRI4impchyX4YLBiQwzNnLCAlHV9BMmxRWvfKCM5FFn3
        /u7FPMnBH9I30kLtg7c7jl5pJXsA9xlGV25vO6RWpBXBbAJdu/lpXaOrPHxT+3GRwna4T4
        F81VTw+DSswzCM0ouu3Dmz/5JqJuNLI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A7BB713638;
        Tue, 11 Apr 2023 12:53:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QXQoKEFYNWR0IQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 11 Apr 2023 12:53:21 +0000
Date:   Tue, 11 Apr 2023 14:53:20 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mm-unstable RFC 3/5] memcg: calculate root usage from
 global state
Message-ID: <rdjvbr5zuwic27s27xcmguce2wfbqiyeu4bjr5pfxhprlxecui@4wsoogvb4ivp>
References: <20230403220337.443510-1-yosryahmed@google.com>
 <20230403220337.443510-4-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eqj63t727ravqnne"
Content-Disposition: inline
In-Reply-To: <20230403220337.443510-4-yosryahmed@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--eqj63t727ravqnne
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2023 at 10:03:35PM +0000, Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> Instead, approximate the root usage from global state. This is not 100%
> accurate, but the root usage has always been ill-defined anyway.

Technically, this approximation should be closer to truth because global
counters aren't subject to flushing "delay".

>=20
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  mm/memcontrol.c | 24 +++++-------------------
>  1 file changed, 5 insertions(+), 19 deletions(-)

But feel free to add
Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>


--eqj63t727ravqnne
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZDVYOgAKCRAkDQmsBEOq
ua0bAP9/m5FltliE3jipY2X5GBKY+6HwLMPDQ7kZw0YMt1coPwEAhI5ND5ReXLBV
+llW9zWanuFkJ28pU6DrJah5+c1hBQ8=
=0lKn
-----END PGP SIGNATURE-----

--eqj63t727ravqnne--
