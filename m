Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF2C5B3AEB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 16:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbiIIOnj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 10:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiIIOng (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:43:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FEB11778F;
        Fri,  9 Sep 2022 07:43:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 363A462007;
        Fri,  9 Sep 2022 14:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632D3C433D6;
        Fri,  9 Sep 2022 14:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662734614;
        bh=jXc+YOCMq9/xoEX+tOTlV/SGQTrctfHXTzVY7GoW6yk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=pKuSQ0WXtewALbm9bIXUwgShYUzZZMekwIFtT4+gNj6B05+lcXkzpq14+Z9vS8bVb
         orpamrV1hkAfBdiskqjjn6BFBh2cRJ9yo7gYVwIRXk1prXydRTGRhDVTMaZ0lN7LSW
         6ecPmO7JBma7FXKXz1rA0nIPZy3kcE0311QzuB/Qxk3gL7srP6cZF/hA0pPsdrVjak
         8pH4mu2zIEqtK8pTAEYqV6BLqmYnpHxyufyORlaTGoYHDoRpahAv52GnEzcgHBT+mP
         UQ+qf8rkZVNGDzMU2INyxkvrI1DefJ0Xzr+tul0HsZ22/cMdXrgI/lftE8ogTLllp2
         RCqqdZPlrSPfA==
Message-ID: <8b556c2dadb717a25ab47f02f70cfaaa6c6074c7.camel@kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
From:   Jeff Layton <jlayton@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>, Jan Kara <jack@suse.cz>,
        NeilBrown <neilb@suse.de>, adilger.kernel@dilger.ca,
        djwong@kernel.org, david@fromorbit.com, trondmy@hammerspace.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, brauner@kernel.org,
        fweimer@redhat.com, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Date:   Fri, 09 Sep 2022 10:43:30 -0400
In-Reply-To: <YxtEHIkfX0nQQC0n@mit.edu>
References: <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>
         <20220907135153.qvgibskeuz427abw@quack3>
         <166259786233.30452.5417306132987966849@noble.neil.brown.name>
         <20220908083326.3xsanzk7hy3ff4qs@quack3> <YxoIjV50xXKiLdL9@mit.edu>
         <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>
         <20220908155605.GD8951@fieldses.org>
         <9e06c506fd6b3e3118da0ec24276e85ea3ee45a1.camel@kernel.org>
         <YxstWiu34TfJ6muW@mit.edu>
         <6173b33e43ac8b0e4377b5d65fec7231608f71f7.camel@kernel.org>
         <YxtEHIkfX0nQQC0n@mit.edu>
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

On Fri, 2022-09-09 at 09:48 -0400, Theodore Ts'o wrote:
> On Fri, Sep 09, 2022 at 08:47:17AM -0400, Jeff Layton wrote:
> >=20
> > i_version only changes now if someone has queried it since it was last
> > changed. That makes a huge difference in performance. We can try to
> > optimize it further, but it probably wouldn't move the needle much unde=
r
> > real workloads.
>=20
> Good point.  And to be clear, from NFS's perspective, you only need to
> have i_version bumped if there is a user-visible change to the
> file. --- with an explicit exception here of the FIEMAP system call,
> since in the case of a delayed allocation, FIEMAP might change from
> reporting:
>=20
>  ext:     logical_offset:        physical_offset: length:   expected: fla=
gs:
>    0:        0..       0:          0..         0:      0:             las=
t,unknown_loc,delalloc,eof
>=20
> to this:
>=20
>  ext:     logical_offset:        physical_offset: length:   expected: fla=
gs:
>    0:        0..       0:  190087172.. 190087172:      1:             las=
t,eof
>=20
> after a sync(2) or fsync(2) call, or after time passes.
>=20

In general, we want to bump i_version if the ctime changes. I'm guessing
that we don't change ctime on a delalloc? If it's not visible to NFS,
then NFS won't care about it.  We can't project FIEMAP info across the
wire at this time, so we'd probably like to avoid seeing an i_version
bump in due to delalloc.

> > Great! That's what I was hoping for with ext4. Would you be willing to
> > pick up these two patches for v6.1?
> >=20
> > https://lore.kernel.org/linux-ext4/20220908172448.208585-3-jlayton@kern=
el.org/T/#u
> > https://lore.kernel.org/linux-ext4/20220908172448.208585-4-jlayton@kern=
el.org/T/#u
>=20
> I think you mean:
>=20
> https://lore.kernel.org/linux-ext4/20220908172448.208585-2-jlayton@kernel=
.org/T/#u
> https://lore.kernel.org/linux-ext4/20220908172448.208585-3-jlayton@kernel=
.org/T/#u
>=20
> Right?
>=20
> BTW, sorry for not responding to these patches earlier; between
> preparing for the various Linux conferences in Dublin next week, and
> being in Zurich and meeting with colleagues at $WORK all of this week,
> I'm a bit behind on my patch reviews.
>=20

No worries. As long as they're on your radar, that's fine.

Thanks!
--=20
Jeff Layton <jlayton@kernel.org>
