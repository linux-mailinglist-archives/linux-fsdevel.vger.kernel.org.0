Return-Path: <linux-fsdevel+bounces-27942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68995964DA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 20:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97E21F26522
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 18:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113131B86DB;
	Thu, 29 Aug 2024 18:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+gb0RgV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F48A198E75;
	Thu, 29 Aug 2024 18:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724956005; cv=none; b=n7X9mYgYYycwTAUqpe9s0le66TMrANX7P78WlK5DV69f7b0m2hvS+eYSLmX/JHsg+v1isPAMIiVv/sjmUl/nVZJiMpf5Fm/3zFEep+GXqtw4RpTJXUtQmTEa6vOZokjAeaHBTy4uU8rClGRoZkpDxODxd709zokpwxRFxbKXLgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724956005; c=relaxed/simple;
	bh=L9EEgqKSchDJV3gXROgGNAGZ6Mys47TvQpcxKwUKgRU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c3JRCp7M+cECkVKwludVv5AqA2OZ1s1FXeD0dhnoYEazj3ZNvFlibN9GLxe8TJMSI7yzN4sGNdTzmga5SAFR6iqmjaw7OfsGmxTllkavlg7EpdIJG2cXXEpBaXwi8qon40huqCKe7olM1thiFUZ9vYZIlfRf8YsVrxvIbc2wrD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+gb0RgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1E8C4CEC1;
	Thu, 29 Aug 2024 18:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724956004;
	bh=L9EEgqKSchDJV3gXROgGNAGZ6Mys47TvQpcxKwUKgRU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=t+gb0RgVSGiHMK29yKFBkXjev1wM4sUaBGvE6j/jh6WTwe+h2p/ODsOylyeR23Pc+
	 wrWqD0h4NGs+n7Ab029D4QENKImih+nUthPGqV4OI+4GL6nZatqoyCH4yebcI6+IzG
	 6sBbctCOaAi7eeh/xih7CuXmUq5UwaqbABwT/zznFx6Emxo9IuqUvSXH3NAI4Wt1TX
	 NO0ZXt8w3batzKkWBdolbbaPjfMnnU6gq86MXHLNMS47MLPkVMOiSDaLlNkSJOdSQr
	 JNzF8m3ZkpjarEPXPzq4EDgdtaTc/W88Y8hcqLyTuz7cvfCXWa10DbigF4yovX0fcP
	 Q9pFLU+37nawA==
Message-ID: <14302177e5fd485a9f72879e7c5366ffc31f4e1d.camel@kernel.org>
Subject: Re: [PATCH v3 08/13] nfs_common: make nfs4.h include generated
 nfs4_1.h
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai
 Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Trond Myklebust
 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Olga Kornievskaia
 <okorniev@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jonathan Corbet
 <corbet@lwn.net>, Tom Haynes <loghyr@gmail.com>,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Date: Thu, 29 Aug 2024 14:26:42 -0400
In-Reply-To: <ZtCQLVAaotGRxLN2@tissot.1015granger.net>
References: <20240829-delstid-v3-0-271c60806c5d@kernel.org>
	 <20240829-delstid-v3-8-271c60806c5d@kernel.org>
	 <ZtCQLVAaotGRxLN2@tissot.1015granger.net>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-29 at 11:13 -0400, Chuck Lever wrote:
> On Thu, Aug 29, 2024 at 09:26:46AM -0400, Jeff Layton wrote:
> > Long term, we'd like to move to autogenerating a lot of our XDR code.
> > Both the client and server include include/linux/nfs4.h. That file is
> > hand-rolled and some of the symbols in it conflict with the
> > autogenerated symbols from the spec.
> >=20
> > Move nfs4_1.x to Documentation/sunrpc/xdr.
>=20
> I can change 2/2 in the xdrgen series to land this file under
> Documentation/sunrpc/xdr.
>=20

Thanks, and also thanks for making the timestamp handling functions
public too.

>=20
> > Create a new include/linux/sunrpc/xdrgen directory in which we can
> > keep autogenerated header files.
>=20
> I think the header files will have different content for the client
> and server. For example, the server-side header has function
> declarations for the procedure argument and result XDR functions,
> the client doesn't (because those functions are all static on the
> client side).
>=20
> Not sure we're ready for this level of sharing between client and
> server.
>=20

Does that matter though? Sure the client might be exposed to some
server encoding/decoding functions, but it doesn't have to use them.
The constant and type definitions are the same between the client and
server. I think there is value in having a single source for that, like
we have today with nfs4.h.

If we do decide that it's a problem, we can just split things up
further:

1. one header file with constant, struct and type definitions
2. one with server-side encode/decode prototypes that includes #1
3. one with client-side encode/decode prototypes that includes #1

include/linux/nfs4.h could still include #1 as well, but the client and
server could include the appropriate headers instead of or in addition
to it.


> > Move the new, generated nfs4xdr_gen.h file to nfs4_1.h in
> > that directory.
>=20
> I'd rather keep the current file name to indicate that it's
> generated code.
>=20

I figured the "xdrgen" directory name would convey that. This naming
also makes it clearer that it's generated from nfs4_1.x. That said, I'm
not too particular here. Can you lay out how you think we ought to
arrange things?

>=20
> > Have include/linux/nfs4.h include the newly renamed file
> > and then remove conflicting definitions from it and nfs_xdr.h.
> >=20
> > For now, the .x file from which we're generating the header is fairly
> > small and just covers the delstid draft, but we can expand that in the
> > future and just remove conflicting definitions as we go.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  {fs/nfsd =3D> Documentation/sunrpc/xdr}/nfs4_1.x                | 0
> >  MAINTAINERS                                                   | 1 +
> >  fs/nfsd/nfs4xdr_gen.c                                         | 2 +-
> >  include/linux/nfs4.h                                          | 7 +---=
---
> >  include/linux/nfs_xdr.h                                       | 5 ----=
-
> >  fs/nfsd/nfs4xdr_gen.h =3D> include/linux/sunrpc/xdrgen/nfs4_1.h | 6 ++=
+---
> >  6 files changed, 6 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4_1.x b/Documentation/sunrpc/xdr/nfs4_1.x
> > similarity index 100%
> > rename from fs/nfsd/nfs4_1.x
> > rename to Documentation/sunrpc/xdr/nfs4_1.x
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a70b7c9c3533..e85114273238 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12175,6 +12175,7 @@ S:	Supported
> >  B:	https://bugzilla.kernel.org
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
> >  F:	Documentation/filesystems/nfs/
> > +F:	Documentation/sunrpc/xdr/
> >  F:	fs/lockd/
> >  F:	fs/nfs_common/
> >  F:	fs/nfsd/
> > diff --git a/fs/nfsd/nfs4xdr_gen.c b/fs/nfsd/nfs4xdr_gen.c
> > index 6833d0ad35a8..00e803781c87 100644
> > --- a/fs/nfsd/nfs4xdr_gen.c
> > +++ b/fs/nfsd/nfs4xdr_gen.c
> > @@ -2,7 +2,7 @@
> >  // Generated by xdrgen. Manual edits will be lost.
> >  // XDR specification modification time: Wed Aug 28 09:57:28 2024
> > =20
> > -#include "nfs4xdr_gen.h"
> > +#include <linux/sunrpc/xdrgen/nfs4_1.h>
>=20
> Please don't hand-edit these files. That makes it impossible to just
> run the xdrgen tool and get a new version, which is the real goal.
>=20
> If you need different generated content, change the tool to generate
> what you need (or feel free to ask me to get out my whittling
> knife).
>=20
>=20

No problem. This part is a Q&D hack job to get everything working with
minimal changes. Changing the tool to generate the right thing would be
a better long-term solution (once we settle on where these files will
go, etc.)
=20
> >  static bool __maybe_unused
> >  xdrgen_decode_int64_t(struct xdr_stream *xdr, int64_t *ptr)
> > diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
> > index 8d7430d9f218..b90719244775 100644
> > --- a/include/linux/nfs4.h
> > +++ b/include/linux/nfs4.h
> > @@ -17,6 +17,7 @@
> >  #include <linux/uidgid.h>
> >  #include <uapi/linux/nfs4.h>
> >  #include <linux/sunrpc/msg_prot.h>
> > +#include <linux/sunrpc/xdrgen/nfs4_1.h>
> > =20
> >  enum nfs4_acl_whotype {
> >  	NFS4_ACL_WHO_NAMED =3D 0,
> > @@ -512,12 +513,6 @@ enum {
> >  	FATTR4_XATTR_SUPPORT		=3D 82,
> >  };
> > =20
> > -enum {
> > -	FATTR4_TIME_DELEG_ACCESS	=3D 84,
> > -	FATTR4_TIME_DELEG_MODIFY	=3D 85,
> > -	FATTR4_OPEN_ARGUMENTS		=3D 86,
> > -};
> > -
> >  /*
> >   * The following internal definitions enable processing the above
> >   * attribute bits within 32-bit word boundaries.
> > diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> > index 45623af3e7b8..d3fe47baf110 100644
> > --- a/include/linux/nfs_xdr.h
> > +++ b/include/linux/nfs_xdr.h
> > @@ -1315,11 +1315,6 @@ struct nfs4_fsid_present_res {
> > =20
> >  #endif /* CONFIG_NFS_V4 */
> > =20
> > -struct nfstime4 {
> > -	u64	seconds;
> > -	u32	nseconds;
> > -};
> > -
> >  #ifdef CONFIG_NFS_V4_1
> > =20
> >  struct pnfs_commit_bucket {
> > diff --git a/fs/nfsd/nfs4xdr_gen.h b/include/linux/sunrpc/xdrgen/nfs4_1=
.h
> > similarity index 96%
> > rename from fs/nfsd/nfs4xdr_gen.h
> > rename to include/linux/sunrpc/xdrgen/nfs4_1.h
> > index 5465db4fb32b..5faee67281b8 100644
> > --- a/fs/nfsd/nfs4xdr_gen.h
> > +++ b/include/linux/sunrpc/xdrgen/nfs4_1.h
> > @@ -2,8 +2,8 @@
> >  /* Generated by xdrgen. Manual edits will be lost. */
> >  /* XDR specification modification time: Wed Aug 28 09:57:28 2024 */
> > =20
> > -#ifndef _LINUX_NFS4_XDRGEN_H
> > -#define _LINUX_NFS4_XDRGEN_H
> > +#ifndef _LINUX_XDRGEN_NFS4_H
> > +#define _LINUX_XDRGEN_NFS4_H
>=20
> Ditto. Resist The Urge (tm).
>=20
>=20
> >  #include <linux/types.h>
> >  #include <linux/sunrpc/svc.h>
> > @@ -103,4 +103,4 @@ enum { FATTR4_TIME_DELEG_MODIFY =3D 85 };
> > =20
> >  enum { OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS =3D 0x100000 };
> > =20
> > -#endif /* _LINUX_NFS4_XDRGEN_H */
> > +#endif /* _LINUX_XDRGEN_NFS4_H */
> >=20
> > --=20
> > 2.46.0
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

