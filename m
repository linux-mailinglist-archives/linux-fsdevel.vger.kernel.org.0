Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9625B033C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 13:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiIGLiO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 07:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiIGLiF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:38:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BAA5F92;
        Wed,  7 Sep 2022 04:38:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EE90333D2D;
        Wed,  7 Sep 2022 11:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662550681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tE1XoLgnrZpzEH6euiwkJypGJJUmLz4xR9DexdFjOJ4=;
        b=LyYRljNgc6/VnQIjrYS3ds20eTshSKH1VN/tPWbBizpjZwVtt/BfaE1/B/uezZe493ox11
        JQp/scL3B/xjpcHU7VQ0kTcADmJQjr2X9rEn6hkfimr+YkfNnuPRQY+ZKgGxgM9HPo9uLp
        VTy6gabBcTuULJAZDGZrxzmWk+vJjGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662550681;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tE1XoLgnrZpzEH6euiwkJypGJJUmLz4xR9DexdFjOJ4=;
        b=vJIO9PbEDGCWsa1EILbbdT5it51xjU0T7ZIZqInKIK1bhQuspB00LHW++WhsaDxfBXS5ax
        QfwLzY4/7oC7fWDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 861BC13486;
        Wed,  7 Sep 2022 11:37:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WsufDpKCGGMmaAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 07 Sep 2022 11:37:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
In-reply-to: <20220907111606.18831-1-jlayton@kernel.org>
References: <20220907111606.18831-1-jlayton@kernel.org>
Date:   Wed, 07 Sep 2022 21:37:33 +1000
Message-id: <166255065346.30452.6121947305075322036@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 07 Sep 2022, Jeff Layton wrote:
> I'm proposing to expose the inode change attribute via statx [1]. Document
> what this value means and what an observer can infer from it changing.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> [1]: https://lore.kernel.org/linux-nfs/20220826214703.134870-1-jlayton@kern=
el.org/T/#t
> ---
>  man2/statx.2 |  8 ++++++++
>  man7/inode.7 | 39 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>=20
> v4: add paragraph pointing out the lack of atomicity wrt other changes
>=20
> I think these patches are racing with another change to add DIO
> alignment info to statx. I imagine this will go in after that, so this
> will probably need to be respun to account for contextual differences.
>=20
> What I'm mostly interested in here is getting the sematics and
> description of the i_version counter nailed down.
>=20
> diff --git a/man2/statx.2 b/man2/statx.2
> index 0d1b4591f74c..d98d5148a442 100644
> --- a/man2/statx.2
> +++ b/man2/statx.2
> @@ -62,6 +62,7 @@ struct statx {
>      __u32 stx_dev_major;   /* Major ID */
>      __u32 stx_dev_minor;   /* Minor ID */
>      __u64 stx_mnt_id;      /* Mount ID */
> +    __u64 stx_ino_version; /* Inode change attribute */
>  };
>  .EE
>  .in
> @@ -247,6 +248,7 @@ STATX_BTIME	Want stx_btime
>  STATX_ALL	The same as STATX_BASIC_STATS | STATX_BTIME.
>  	It is deprecated and should not be used.
>  STATX_MNT_ID	Want stx_mnt_id (since Linux 5.8)
> +STATX_INO_VERSION	Want stx_ino_version (DRAFT)
>  .TE
>  .in
>  .PP
> @@ -407,10 +409,16 @@ This is the same number reported by
>  .BR name_to_handle_at (2)
>  and corresponds to the number in the first field in one of the records in
>  .IR /proc/self/mountinfo .
> +.TP
> +.I stx_ino_version
> +The inode version, also known as the inode change attribute. See
> +.BR inode (7)
> +for details.
>  .PP
>  For further information on the above fields, see
>  .BR inode (7).
>  .\"
> +.TP
>  .SS File attributes
>  The
>  .I stx_attributes
> diff --git a/man7/inode.7 b/man7/inode.7
> index 9b255a890720..8e83836594d8 100644
> --- a/man7/inode.7
> +++ b/man7/inode.7
> @@ -184,6 +184,12 @@ Last status change timestamp (ctime)
>  This is the file's last status change timestamp.
>  It is changed by writing or by setting inode information
>  (i.e., owner, group, link count, mode, etc.).
> +.TP
> +Inode version (i_version)
> +(not returned in the \fIstat\fP structure); \fIstatx.stx_ino_version\fP
> +.IP
> +This is the inode change counter. See the discussion of
> +\fBthe inode version counter\fP, below.
>  .PP
>  The timestamp fields report time measured with a zero point at the
>  .IR Epoch ,
> @@ -424,6 +430,39 @@ on a directory means that a file
>  in that directory can be renamed or deleted only by the owner
>  of the file, by the owner of the directory, and by a privileged
>  process.
> +.SS The inode version counter
> +.PP
> +The
> +.I statx.stx_ino_version
> +field is the inode change counter. Any operation that would result in a
> +change to \fIstatx.stx_ctime\fP must result in an increase to this value.
> +The value must increase even in the case where the ctime change is not
> +evident due to coarse timestamp granularity.
> +.PP
> +An observer cannot infer anything from amount of increase about the
> +nature or magnitude of the change. If the returned value is different
> +from the last time it was checked, then something has made an explicit
> +data and/or metadata change to the inode.
> +.PP
> +The change to \fIstatx.stx_ino_version\fP is not atomic with respect to the
> +other changes in the inode. On a write, for instance, the i_version it usu=
ally
> +incremented before the data is copied into the pagecache. Therefore it is
> +possible to see a new i_version value while a read still shows the old dat=
a.

Doesn't that make the value useless?  Surely the change number must
change no sooner than the change itself is visible, otherwise stale data
could be cached indefinitely.

If currently implementations behave this way, surely they are broken.

NeilBrown
