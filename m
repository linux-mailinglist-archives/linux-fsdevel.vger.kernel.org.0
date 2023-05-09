Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A626FC40C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 12:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbjEIKgH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 06:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbjEIKgB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 06:36:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6E010A27;
        Tue,  9 May 2023 03:35:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2B0841F45A;
        Tue,  9 May 2023 10:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683628495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z4MbD2ACh3hpHrhSw43Y87lfUQzej8A7wcLhxK8QwrA=;
        b=LCF1CluIkegxLgjO5KHPunJbcrtz1mpYn4LktBxFrmsa1yUrhGvoB/SU6WhCId+SSKFl0I
        Wj60Zs47HrzWF17T1B0WtMKCQ8EPgJ7D0WEPsx3xqk0x+d7b9hDcwBZvUHgpi9uautR5Oh
        Fq1PClRqCUVlbLFwr21WOx0RIshBdbs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F021313581;
        Tue,  9 May 2023 10:34:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id y2TkOc4hWmT1CgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 09 May 2023 10:34:54 +0000
Date:   Tue, 9 May 2023 12:34:53 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Chinner <dchinner@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Jiri Wiesner <jwiesner@suse.de>
Subject: Re: [RFC PATCH 3/3] cgroup: Do not take css_set_lock in
 cgroup_show_path
Message-ID: <6rjdfjltz5kkwzobpeefbqxzj4wbd4jzstdryb6rb67td3x45q@5ujarspzjk3x>
References: <20230502133847.14570-1-mkoutny@suse.com>
 <20230502133847.14570-4-mkoutny@suse.com>
 <ZFUktg4Yxa30jRBX@slm.duckdns.org>
 <ta7bilcvc7lzt5tvs44y5wxqt6i3gdmvzwcr5h2vxhjhshmivk@3mecui76fxvy>
 <ZFVIJlAMyzTh3QTP@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ulul6m7iwj5svxlz"
Content-Disposition: inline
In-Reply-To: <ZFVIJlAMyzTh3QTP@slm.duckdns.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--ulul6m7iwj5svxlz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2023 at 08:17:10AM -1000, Tejun Heo <tj@kernel.org> wrote:
> On Fri, May 05, 2023 at 07:32:40PM +0200, Michal Koutn=FD wrote:
> > On Fri, May 05, 2023 at 05:45:58AM -1000, Tejun Heo <tj@kernel.org> wro=
te:
> > > > There are three relevant nodes for each cgroupfs entry:
> > > >=20
> > > >         R ... cgroup hierarchy root
> > > >         M ... mount root
> > > >         C ... reader's cgroup NS root
> > > >=20
> > > > mountinfo is supposed to show path from C to M.
> > >=20
> > > At least for cgroup2, the path from C to M isn't gonna change once NS=
 is
> > > established, right?
> >=20
> > Right. Although, the argument about M (when C above M or when C and M in
> > different subtrees) implicitly relies on the namespace_sem.
>=20
> I don't follow. Can you please elaborate a bit more?

I wanted to say that even with restriction to cgroup2, the css_set_lock
removal would also rely on namespace_sem.

For a given mountinfo entry the path C--M won't change (no renames).
The question is whether cgroup M will stay around (with the relaxed
locking):

  - C >=3D M (C is below M)=20
    -> C (transitively) pins M

  - C < M (C is above M) or C and M are in two disjoint subtrees (path
    goes through a common ancestor)
    -> M could be released without relation to C (even on cgroup2, with
       the css_set_lock removed) but such a destructive operation on M
       is excluded as long as namespace_sem is held during entry
       rendering.

Does that clarify the trade-off of removing css_set_lock at this spot?

Thanks,
Michal

--ulul6m7iwj5svxlz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTrXXag4J0QvXXBmkMkDQmsBEOquQUCZFohyQAKCRAkDQmsBEOq
uS+lAP0TvpVVVydhEBrTrZvKptICgVmSEmOvO3nyzJIgl+tsiQD/dQDf8sn52aYM
5X1mlDRdvM/4tqdyHD5ZxRmF7hI+PAo=
=d4Sg
-----END PGP SIGNATURE-----

--ulul6m7iwj5svxlz--
