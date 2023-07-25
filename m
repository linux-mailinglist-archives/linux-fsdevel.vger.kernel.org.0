Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C30761AF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 16:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjGYOHW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 10:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjGYOHV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:07:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36BE1BD6;
        Tue, 25 Jul 2023 07:07:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 99DDC22235;
        Tue, 25 Jul 2023 14:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690294038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J8/twdbVnVALjyy6alnaVgEL7SCtymIvo2fO0lAEw1A=;
        b=qtdc/DbznROvVm5FX3MMqXZU8IO/sm1dnPWwStcgf8XhwngPg/8F36cKRQCxhatKSPIlfZ
        +CDxXTnNzaFH/1RRe2u/5bP+Smx254C82UsNjI329f/rkl9GaBWT0AsChmjpADwDrINbLo
        F78flZYtWWIeNSgv/oDehdNdvzioFhk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5CD5713487;
        Tue, 25 Jul 2023 14:07:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eFfHFRbXv2RvdgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 25 Jul 2023 14:07:18 +0000
Date:   Tue, 25 Jul 2023 16:07:17 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, kernel-team@cloudflare.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] kernfs: attach uuid for every kernfs and report it in
 fsid
Message-ID: <jy7ktvlb4tkg6pl2vll6u4gozfji7giddyseypj4w2d2ue4gvn@4tw7dmjy4hfv>
References: <20230710183338.58531-1-ivan@cloudflare.com>
 <2023071039-negate-stalemate-6987@gregkh>
 <CABWYdi39+TJd1qV3nWs_eYc7XMC0RvxG22ihfq7rzuPaNvn1cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ajxxoxppngon7fy"
Content-Disposition: inline
In-Reply-To: <CABWYdi39+TJd1qV3nWs_eYc7XMC0RvxG22ihfq7rzuPaNvn1cQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--7ajxxoxppngon7fy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Mon, Jul 10, 2023 at 02:21:10PM -0700, Ivan Babrou <ivan@cloudflare.com>=
 wrote:
> I want to monitor cgroup changes, so that I can have an up to date map
> of inode -> cgroup path, so that I can resolve the value returned from
> bpf_get_current_cgroup_id() into something that a human can easily
> grasp (think system.slice/nginx.service).

Have you considered cgroup_path_from_kernfs_id()?

> Currently I do a full sweep to build a map, which doesn't work if a
> cgroup is short lived, as it just disappears before I can resolve it.
> Unfortunately, systemd recycles cgroups on restart, changing inode
> number, so this is a very real issue.

So, a historical map of cgroup id -> path is also useful for you, right?
(IOW, cgroup_path_from_kernfs_id() is possible but it'd inflate log
buffer size if full paths were stored instead of ids.)

(I think a similar map would be beneficial for SCM_CGROUP [1] idea too.)


> There's also this old wiki page from systemd:
>=20
> * https://freedesktop.org/wiki/Software/systemd/Optimizations

The page also states:

> Last edited Sat 18 May 2013 08:20:38 AM UTC

Emptiness notifications via release_agent are so 2016 :-), unified
hiearchy has more convenient API [2], this is FTR.


My 0.02=E2=82=AC,
Michal

[1] https://uapi-group.org/kernel-features/
[2] https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html?#un-p=
opulated-notification


--7ajxxoxppngon7fy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZL/XEgAKCRAGvrMr/1gc
jnObAQCJ3C0hDVOfZEzkb1UOgnA4h3h266lsMaQDV8ICV1nHDQEAwyoY1QBjJ5E0
NgxyIDgfAir+2Th7xhf/1vF56yIvUA4=
=a7jr
-----END PGP SIGNATURE-----

--7ajxxoxppngon7fy--
