Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B1F5A6596
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 15:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiH3NwQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 09:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiH3Nvz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:51:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CDE4BA52;
        Tue, 30 Aug 2022 06:50:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42EBAB81C07;
        Tue, 30 Aug 2022 13:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB94FC433D6;
        Tue, 30 Aug 2022 13:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661867405;
        bh=l7ELeaRTVCV4lo7/FQ0h0/nHSZnx9Fi3ScrPGF9gzvs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aWStCZCicrMebcTCOFe7sxaeIJUPqBAwUaEf0+CLgJ2SV1vBL9kIWVDHMZrU6a+FW
         b9wM+EAjmMpBpn68zTuq/Oc0sLAIkrPOV+QuNAE61dO12HJ9cNoU5YwvQCyrQwHtJ7
         d5miBia6XH86fk/Zk+SFdI0Ce87PENiBZeWTSL60/FGV0QGbue6pCsXGB9n4quAWcI
         diZUKu5+Q0tiqX/QvnQ7X1MLf6ovVGhsyD0xQoz0v6rDTjBxAj4y0SRS20V1pvAcCa
         QcGZgRLg2BYoUiNkCzqa/HtZVKnjjHnLKkcfSm7HbwD3G/MyLvhdJELzoBaofQajzk
         T7OMDrGENU0IQ==
Message-ID: <a07686e7e1d1ef15720194be2abe5681f6a6c78e.camel@kernel.org>
Subject: Re: [PATCH v3 1/7] iversion: update comments with info about atime
 updates
From:   Jeff Layton <jlayton@kernel.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     NeilBrown <neilb@suse.de>, Dave Chinner <david@fromorbit.com>,
        tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        trondmy@hammerspace.com, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, jack@suse.cz, brauner@kernel.org,
        linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ceph@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Colin Walters <walters@verbum.org>
Date:   Tue, 30 Aug 2022 09:50:02 -0400
In-Reply-To: <20220830132443.GA26330@fieldses.org>
References: <20220826214703.134870-1-jlayton@kernel.org>
         <20220826214703.134870-2-jlayton@kernel.org>
         <20220829075651.GS3600936@dread.disaster.area>
         <549776abfaddcc936c6de7800b6d8249d97d9f28.camel@kernel.org>
         <166181389550.27490.8200873228292034867@noble.neil.brown.name>
         <f5c42c0d87dfa45188c2109ccf9baeb7a42aa27e.camel@kernel.org>
         <20220830132443.GA26330@fieldses.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-08-30 at 09:24 -0400, J. Bruce Fields wrote:
> On Tue, Aug 30, 2022 at 07:40:02AM -0400, Jeff Layton wrote:
> > Yes, saying only that it must be different is intentional. What we
> > really want is for consumers to treat this as an opaque value for the
> > most part [1]. Therefore an implementation based on hashing would
> > conform to the spec, I'd think, as long as all of the relevant info is
> > part of the hash.
>=20
> It'd conform, but it might not be as useful as an increasing value.
>=20
> E.g. a client can use that to work out which of a series of reordered
> write replies is the most recent, and I seem to recall that can prevent
> unnecessary invalidations in some cases.
>=20

That's a good point; the linux client does this. That said, NFSv4 has a
way for the server to advertise its change attribute behavior [1]
(though nfsd hasn't implemented this yet). We don't have a good way to
do that in userland for now.

This is another place where fsinfo() would have been nice to have. I
think until we have something like that, we'd want to keep our promises
to userland to a minimum.

[1]: https://www.rfc-editor.org/rfc/rfc7862.html#section-12.2.3 . I
guess I should look at plumbing this in for IS_I_VERSION inodes...

--=20
Jeff Layton <jlayton@kernel.org>



