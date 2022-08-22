Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79A759CBA4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 00:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238518AbiHVWm1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 18:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237790AbiHVWm0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 18:42:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3106150716;
        Mon, 22 Aug 2022 15:42:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3D8FC374F3;
        Mon, 22 Aug 2022 22:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661208143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L8tdsVzVyDJM4BV8U6INcBMyETt5VDqLfPWrM+9ANZU=;
        b=Wr3CoLUChRliBIcsKBEP1ARTBdMKIOxqorZDI5PC02cuVv0LuNzxNwZ1mFTqVb+7JBZfoX
        LL26ihunLovvcTYQcNmjUYPDT4M9P9JN52Z6d716ibtdAE1bnPXlUzvKCWl56tXGcZft6y
        NhQsHRd9e09zuZfA90lOARNSJ6/HILI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661208143;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L8tdsVzVyDJM4BV8U6INcBMyETt5VDqLfPWrM+9ANZU=;
        b=qZqaiUA+p1D36amScnShCHJ24rJTyLaa5teureTyNmBQZIY+cXaWtrvpBQYngEYOJIQLbp
        dy+/koo412I3GbAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7967F1332D;
        Mon, 22 Aug 2022 22:42:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0pRhDUwGBGPzJAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 22 Aug 2022 22:42:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        "Trond Myklebust" <trondmy@hammerspace.com>,
        "Dave Chinner" <david@fromorbit.com>
Subject: Re: [PATCH] iversion: update comments with info about atime updates
In-reply-to: <20220822133309.86005-1-jlayton@kernel.org>
References: <20220822133309.86005-1-jlayton@kernel.org>
Date:   Tue, 23 Aug 2022 08:42:15 +1000
Message-id: <166120813594.23264.3095357572943917078@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 22 Aug 2022, Jeff Layton wrote:
> Add an explicit paragraph codifying that atime updates due to reads
> should not be counted against the i_version counter. None of the
> existing subsystems that use the i_version want those counted, and
> there is an easy workaround for those that do.
>=20
> Cc: NeilBrown <neilb@suse.de>
> Cc: Trond Myklebust <trondmy@hammerspace.com>
> Cc: Dave Chinner <david@fromorbit.com>
> Link: https://lore.kernel.org/linux-xfs/166086932784.5425.17134712694961326=
033@noble.neil.brown.name/#t
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  include/linux/iversion.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/iversion.h b/include/linux/iversion.h
> index 3bfebde5a1a6..da6cc1cc520a 100644
> --- a/include/linux/iversion.h
> +++ b/include/linux/iversion.h
> @@ -9,8 +9,8 @@
>   * ---------------------------
>   * The change attribute (i_version) is mandated by NFSv4 and is mostly for
>   * knfsd, but is also used for other purposes (e.g. IMA). The i_version mu=
st
> - * appear different to observers if there was a change to the inode's data=
 or
> - * metadata since it was last queried.
> + * appear different to observers if there was an explicit change to the in=
ode's
> + * data or metadata since it was last queried.

Should rename change the i_version?
It does not explicitly change data or metadata, though it seems to
implicitly change the ctime.

>   *
>   * Observers see the i_version as a 64-bit number that never decreases. If=
 it
>   * remains the same since it was last checked, then nothing has changed in=
 the
> @@ -18,6 +18,12 @@
>   * anything about the nature or magnitude of the changes from the value, o=
nly
>   * that the inode has changed in some fashion.
>   *
> + * Note that atime updates due to reads or similar activity do _not_ repre=
sent
> + * an explicit change to the inode. If the only change is to the atime and=
 it
> + * wasn't set via utimes() or a similar mechanism, then i_version should n=
ot be
> + * incremented. If an observer cares about atime updates, it should plan to
> + * fetch and store them in conjunction with the i_version.
> + *

If an implicit atime update happened to make the atime go backwards
(possible, but not common), the updating i_version should be permitted,
and possibly should be preferred.

NeilBrown


>   * Not all filesystems properly implement the i_version counter. Subsystem=
s that
>   * want to use i_version field on an inode should first check whether the
>   * filesystem sets the SB_I_VERSION flag (usually via the IS_I_VERSION mac=
ro).
> --=20
> 2.37.2
>=20
>=20
