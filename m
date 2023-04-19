Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8FE6E78BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 13:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbjDSLiS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 07:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjDSLiR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:38:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708CB4231;
        Wed, 19 Apr 2023 04:38:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 26D8021996;
        Wed, 19 Apr 2023 11:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681904293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CawZP8F8+xYMOVFHt2q5TqVfXamwgFnKSbMRqGDkkis=;
        b=GL5fAGiWO2P5IiS5km6lqEZciICNE40kwVeLHDhHCVOZVt8jDUYanFIa1YaVUirxyzdxNF
        AemECDuu3TqA6SneZwBNJ3xttSlMUd3KMgmbg2ZfxFhIB73Azy1a5wAUPUd/zTbVMBZYbe
        ROOnf24qNyDC+lbl2/LAR9jU4dAfhI8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E0F4613580;
        Wed, 19 Apr 2023 11:38:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jWkQNqTSP2TZXAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 19 Apr 2023 11:38:12 +0000
Date:   Wed, 19 Apr 2023 13:38:11 +0200
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
Subject: Re: [PATCH mm-unstable RFC 1/5] writeback: move wb_over_bg_thresh()
 call outside lock section
Message-ID: <7woe6ljcarqsr6uep7uns7bc3hm6xqog6ufk4rhwfo4vxixczw@tdjkdhx2euok>
References: <20230403220337.443510-1-yosryahmed@google.com>
 <20230403220337.443510-2-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="um3hlfownhi7iyh5"
Content-Disposition: inline
In-Reply-To: <20230403220337.443510-2-yosryahmed@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--um3hlfownhi7iyh5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2023 at 10:03:33PM +0000, Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> wb_over_bg_thresh() calls mem_cgroup_wb_stats() which invokes an rstat
> flush, which can be expensive on large systems. Currently,
> wb_writeback() calls wb_over_bg_thresh() within a lock section, so we
> have to make the rstat flush atomically. On systems with a lot of
> cpus/cgroups, this can cause us to disable irqs for a long time,
> potentially causing problems.
>=20
> Move the call to wb_over_bg_thresh() outside the lock section in
> preparation to make the rstat flush in mem_cgroup_wb_stats() non-atomic.
> The list_empty(&wb->work_list) should be okay outside the lock section
> of wb->list_lock as it is protected by a separate lock (wb->work_lock),
> and wb_over_bg_thresh() doesn't seem like it is modifying any of the b_*
> lists the wb->list_lock is protecting. Also, the loop seems to be
> already releasing and reacquring the lock, so this refactoring looks
> safe.
>=20
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  fs/fs-writeback.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 195dc23e0d831..012357bc8daa3 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2021,7 +2021,6 @@ static long wb_writeback(struct bdi_writeback *wb,
>  	struct blk_plug plug;
> =20
>  	blk_start_plug(&plug);
> -	spin_lock(&wb->list_lock);
>  	for (;;) {
>  		/*
>  		 * Stop writeback when nr_pages has been consumed
> @@ -2046,6 +2045,9 @@ static long wb_writeback(struct bdi_writeback *wb,
>  		if (work->for_background && !wb_over_bg_thresh(wb))
>  			break;
> =20
> +
> +		spin_lock(&wb->list_lock);
> +
>  		/*
>  		 * Kupdate and background works are special and we want to
>  		 * include all inodes that need writing. Livelock avoidance is
> @@ -2075,13 +2077,19 @@ static long wb_writeback(struct bdi_writeback *wb,
>  		 * mean the overall work is done. So we keep looping as long
>  		 * as made some progress on cleaning pages or inodes.
>  		 */
> -		if (progress)
> +		if (progress) {
> +			spin_unlock(&wb->list_lock);
>  			continue;
> +		}
> +

This would release wb->list_lock temporarily with progress but that's
already not held continuously due to writeback_sb_inodes().
Holding the lock could even be shortened by taking it later after
trace_writeback_start().

Altogether, the change looks OK,
Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>


--um3hlfownhi7iyh5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZD/SoAAKCRAkDQmsBEOq
ud9HAQDjyg6QsqLgZUGry6hNbONC5QVd0E2+HvxdLRrVBbVMTwD/dXaHa+QsVZiZ
ADTParKHoShcH9b0N7u/scBSdpKHhgM=
=xwT4
-----END PGP SIGNATURE-----

--um3hlfownhi7iyh5--
