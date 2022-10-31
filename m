Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE99613BDC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 18:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbiJaRFG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 13:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiJaRFF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:05:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDE512629;
        Mon, 31 Oct 2022 10:05:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FBF8B81983;
        Mon, 31 Oct 2022 17:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E13C433D6;
        Mon, 31 Oct 2022 17:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667235901;
        bh=hocz5dD/D+nvZgNOgwXWn4lVR3wa+hVcKMzopU9nkXQ=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=k2btem8A6FPMZ13Dr631WfPiNJdO8SFmEonQQevNhzEm4VeGCaU/O+1FFqmk1PCnE
         Qo1Pa0/uL8JnANLcKvuQYPbFU7fdcMNDlKiz40lgodw/MLf2Ym68IH7//PYvOm6MvU
         d96XqdMz2gTP9m7ksP68y41NxuEgO/HDt3XNIU8hJEOHyYhRZS4A7P8eKNPVd0g53z
         GaCW2dYhgibIc3fTC/N8Qw4VaNniMANNPczAohRdqUh0Qru2DICnZEgKWvSByPnDrv
         nEUxc3adJxhIBHCtYuQTZe10L+jWHtmcApa8Ujail6nHKqnYP/56xzIC20sqcwF3BU
         dje/KZ/q5VCPw==
Message-ID: <c6828277e5fb0e25988dd6b73176d7d613b22f19.camel@kernel.org>
Subject: Re: [PATCH 2] MAINTAINERS: NFSD should be responsible for
 fs/exportfs
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Mon, 31 Oct 2022 13:05:00 -0400
In-Reply-To: <166722486403.129894.8530131246045193767.stgit@klimt.1015granger.net>
References: <166722486403.129894.8530131246045193767.stgit@klimt.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-10-31 at 10:01 -0400, Chuck Lever wrote:
> We recently received a patch for fs/exportfs/expfs.c, but there
> isn't a subsystem maintainer listed for fs/exportfs:
>=20
> Christian Brauner <brauner@kernel.org> (commit_signer:2/2=3D100%,authored=
:1/2=3D50%,added_lines:3/6=3D50%,removed_lines:2/6=3D33%)
> Al Viro <viro@zeniv.linux.org.uk> (commit_signer:1/2=3D50%,authored:1/2=
=3D50%,added_lines:3/6=3D50%,removed_lines:4/6=3D67%)
> Miklos Szeredi <mszeredi@redhat.com> (commit_signer:1/2=3D50%)
> Amir Goldstein <amir73il@gmail.com> (commit_signer:1/2=3D50%)
> linux-kernel@vger.kernel.org (open list)
>=20
> Neil says:
> > Looking at recent commits, patches come in through multiple
> > different trees.
> > nfsd certainly has an interest in expfs.c.  The only other user is
> > name_to_handle/open_by_handle API.
> > I see it as primarily nfsd functionality which is useful enough to
> > be exported directly to user-space.
> > (It was created by me when I was nfsd maintainer - does that
> > count?)
>=20
> Suggested-by: Neil Brown <neilb@suse.de>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  MAINTAINERS |    1 +
>  1 file changed, 1 insertion(+)
>=20
> The patch description in v1 was truncated. Here's a refresh.
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 379945f82a64..61fb45cfc825 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11129,6 +11129,7 @@ L:	linux-nfs@vger.kernel.org
>  S:	Supported
>  W:	http://nfs.sourceforge.net/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
> +F:	fs/exportfs/
>  F:	fs/lockd/
>  F:	fs/nfs_common/
>  F:	fs/nfsd/
>=20
>=20

Acked-by: Jeff Layton <jlayton@kernel.org>
