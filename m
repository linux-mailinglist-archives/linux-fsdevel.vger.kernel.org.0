Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407276E78D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 13:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjDSLoo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 07:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjDSLoo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:44:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA62D4231;
        Wed, 19 Apr 2023 04:44:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 569231FD8A;
        Wed, 19 Apr 2023 11:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681904681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0zDQDkGE+9vuGnAAMyp+Znl0fdBKE7XNVtwBU2+M3G8=;
        b=L1c1XBQWg0zfnc1ZlLr5NC2ZiL4OhHV8ZPPfGePt2lWqMqOCK7PpdvtAzWjM1IVSJ97UKS
        Ow/DimNzfFpB3GccFVDp/mCqgwckdUZZOTZXxYoO7o+ihnvHX1hWCrLjJCl3kipob72hGB
        tpDNhcDAMCvOMANT0sPJo0dIDzJIJmQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C85613580;
        Wed, 19 Apr 2023 11:44:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KhLRBCnUP2S/ZAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 19 Apr 2023 11:44:41 +0000
Date:   Wed, 19 Apr 2023 13:44:39 +0200
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
Subject: Re: [PATCH mm-unstable RFC 2/5] memcg: flush stats non-atomically in
 mem_cgroup_wb_stats()
Message-ID: <cqc5gdh4yfh3m3inpm455rgsd55hh543biogpoip6mufr6axh5@z5w6rljgvvpb>
References: <20230403220337.443510-1-yosryahmed@google.com>
 <20230403220337.443510-3-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4c7lxtjmc74hxkg5"
Content-Disposition: inline
In-Reply-To: <20230403220337.443510-3-yosryahmed@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--4c7lxtjmc74hxkg5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2023 at 10:03:34PM +0000, Yosry Ahmed <yosryahmed@google.co=
m> wrote:
>  mm/memcontrol.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--4c7lxtjmc74hxkg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZD/UIwAKCRAkDQmsBEOq
ubusAQDpyzbgmh2mOJdPSwZsaNGY368cPzgmuzn5NvkS1ukAewD+NuwrN3Kx3JM9
MfK4fKoWXWwu5X0+LDN+fUY8dakRawo=
=ztJP
-----END PGP SIGNATURE-----

--4c7lxtjmc74hxkg5--
