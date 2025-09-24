Return-Path: <linux-fsdevel+bounces-62544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20639B9864B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 08:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 249983AAECB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 06:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11322512FF;
	Wed, 24 Sep 2025 06:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="R2SbdLP4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A801E24A074;
	Wed, 24 Sep 2025 06:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758695498; cv=none; b=U69tnPnoQTF5wxcqFUZXSF3qD3Nl0lSYNIGQLYMm0hyo2S6RPcb7YGprrKUXYo/WbVbHHxd/JbkL48flMTawJfN+t1iGpfrdF04w9ExivALLZadeaoUnDs2Z+g1TWGNrGXQybMz4pS1MitO2FIjLjh/FqdYQ7ikNmB0JxCyuGvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758695498; c=relaxed/simple;
	bh=065T29l6sjd3b5Uv5coNCNiFSOMe4aVbBTlbV3uJd5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gl/w5sJoFCtcgmja2bzypXuFYFJaqK7t/DUY8h9U1+aYQ6imEfLQeR5RdO1757CqIpRk8QVtUuqFFenWB1hUqrojyPD9SQeTgdnRQpDkphsJCfkRRSUn+cGDzC97iCLoGisVvxPd2nS7R8+7VrALZqP6CPmYHvnOJaXDL5A24Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=R2SbdLP4; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cWn771Ms3z9sxW;
	Wed, 24 Sep 2025 08:31:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1758695491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TElU+ZNhdFO4OM5I/I4tMdutu6h8Mmuod86kJlXVN94=;
	b=R2SbdLP4oUuWvc05x/jHTrie05dNkqn1kQtWvOOLyxh09R04y5FgxL3EcE/LGwR3Ses2rJ
	bGeJXMUr1hqhGClk8cXcLK8Hoi/7A8rdK15LC8f2db54bJT4xrCJ2rSmvJLrvMdmrp6/Q4
	OPBP3DylrCsS9/yd4sn22LiiSsH4nq0iBAUeM9+2NOiD2bq2NB31fn8Bmgkb5SbBWJ1EoD
	xGkO1VyFMe+zM0f9ZevoexoaYbrV7euyVGn1IJyvBj+bhADta/6sBswxlDwJLlku7D0+Bh
	YW9N/HLr+DPhuM91AocMcd3CkHBsWIrbi78pbT95lx/PAFyvtXcf4OoE3ejc9Q==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Wed, 24 Sep 2025 16:31:15 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 09/10] man/man2/open_tree{,_attr}.2: document new
 open_tree_attr() API
Message-ID: <2025-09-24-unsafe-movable-perms-actress-zoAIgs@cyphar.com>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-9-1261201ab562@cyphar.com>
 <vc2xa2tuqqnkuoyg4hrgt6akt23ap6hxho5qs5hfcbc5nsaosv@idi6hwvyo7r5>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="odo7mxn4h7kg45xd"
Content-Disposition: inline
In-Reply-To: <vc2xa2tuqqnkuoyg4hrgt6akt23ap6hxho5qs5hfcbc5nsaosv@idi6hwvyo7r5>
X-Rspamd-Queue-Id: 4cWn771Ms3z9sxW


--odo7mxn4h7kg45xd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 09/10] man/man2/open_tree{,_attr}.2: document new
 open_tree_attr() API
MIME-Version: 1.0

On 2025-09-21, Alejandro Colomar <alx@kernel.org> wrote:
> On Fri, Sep 19, 2025 at 11:59:50AM +1000, Aleksa Sarai wrote:
> > diff --git a/man/man2/open_tree.2 b/man/man2/open_tree.2
> > index 7f85df08b43c7b48a9d021dbbeb2c60092a2b2d4..60de4313a9d5be4ef3ff121=
7051f252506a2ade9 100644
> > --- a/man/man2/open_tree.2
> > +++ b/man/man2/open_tree.2
> > @@ -15,7 +15,19 @@ .SH SYNOPSIS
> >  .B #include <sys/mount.h>
> >  .P
> >  .BI "int open_tree(int " dirfd ", const char *" path ", unsigned int "=
 flags );
> > +.P
> > +.BR "#include <sys/syscall.h>" "    /* Definition of " SYS_* " constan=
ts */"
> > +.P
> > +.BI "int syscall(SYS_open_tree_attr, int " dirfd ", const char *" path=
 ,
> > +.BI "            unsigned int " flags ", struct mount_attr *_Nullable =
" attr ", \
> > +size_t " size );
>=20
> Do we maybe want to move this to its own separate page?
>=20
> The separate page could perfectly contain the same exact text you're
> adding here; you don't need to repeat open_tree() descriptions.
>=20
> In general, I feel that while this improves discoverability of related
> functions, it produces more complex pages.

I tried it and I don't think it is a better experience as a reader when
split into two pages because of the huge overlap between the two
syscalls.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--odo7mxn4h7kg45xd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaNOQMxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG/3XAD/fPRWeq5U+NvquaA3xaZ0
NGVff7W89/OjhtJxCUUBD1sA/3N9ZORTu+A5NOOuW+fd2HL62ekuHN5aNDrUAi/6
D9UN
=lPKS
-----END PGP SIGNATURE-----

--odo7mxn4h7kg45xd--

