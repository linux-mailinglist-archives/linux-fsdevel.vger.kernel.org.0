Return-Path: <linux-fsdevel+bounces-65517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 171CBC0672A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 15:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28B004E6AF8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C261531BCB6;
	Fri, 24 Oct 2025 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ap3FCyEK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D47C19C546;
	Fri, 24 Oct 2025 13:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761311925; cv=none; b=i1BW+BMpONCQUqn/fLcpgIRK+VKQ8oKVCKkwyhpw1U6gI6QAWyoIhoe0lUBR8yp2SIPo4xPpGGhoA7FXzfqmq6FfF+AHx3Qk0TKiWsNAzn8SPwRuFYYamLAZg6cVt7IH10CqPPmt2CrN7y+muFzaDeQKKeFsAz3mQ+j57Naa+zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761311925; c=relaxed/simple;
	bh=vImAAcOdyR7m2dcr4BvB07svTo8HUve8pu05bW+Z0LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNfV+nnddbZMNpEYYW0TAapHDg7So+z+X4QjHvSxOEtO+BLZ358qm2/mTYsQK90bvwSKXcMDzRErSOTUGqDzZtjMjl+zIFuDpltLhaIAMUv0AfkRmnLHNqPhecm1OrdrUQ0dE/5EMqLqrunQnabhXcBXE6tZFfmX0U5TjrUQ9/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ap3FCyEK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B37C4CEF5;
	Fri, 24 Oct 2025 13:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761311924;
	bh=vImAAcOdyR7m2dcr4BvB07svTo8HUve8pu05bW+Z0LU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ap3FCyEKlaPhsQvDZ3vl7y1ziDzs9Fhjf4gIeVlD5rh239CiQLHisW3l60JarLJdb
	 YHmdOKi7Cir91+s++S0fO+Vf3z41Un33JrFhYLUAvzoK+BhZWHBuxf4axzm+kgTxws
	 EF/XFSrMnt5SpkAz6gH9lw3aCddDYEbqQSuLhDUQ2DgYxk2QcU206SBeQJSMJFu26X
	 MBRQLZ7VTjxbPK06uf37wrjt7sl2weMwMbbrClXh0woRN6UJQTF2u5fW7oKk7LenCc
	 T1pY1xvh3wO3WOh0cbKqw+g9+eZv20YfWW3iELmAEW+EN6ED6wX7j28WuQT3srAk+T
	 sZsq0fb2QKW1w==
Date: Fri, 24 Oct 2025 15:18:37 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
	Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sysctl: fix kernel-doc format warning
Message-ID: <v7wxokakvlnewgifh3xp672surr4hncsapyfc3tj7mwod6sev6@ixqd7qjsrusk>
References: <20251017070802.1639215-1-rdunlap@infradead.org>
 <kyn7q3tjjxg45am326ykx4hbnqzffl2nkt77vl65qxa4p3kpz2@ysgkf3j3ch4m>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ztwvjylmiin7c47e"
Content-Disposition: inline
In-Reply-To: <kyn7q3tjjxg45am326ykx4hbnqzffl2nkt77vl65qxa4p3kpz2@ysgkf3j3ch4m>


--ztwvjylmiin7c47e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 03:03:17PM +0200, Joel Granados wrote:
> On Fri, Oct 17, 2025 at 12:08:02AM -0700, Randy Dunlap wrote:
> > Describe the "type" struct member using '@type' to avoid a kernel-doc
> > warning:
=2E..
> >  	/**
> > -	 * enum type - Enumeration to differentiate between ctl target types
> > +	 * @type: Enumeration to differentiate between ctl target types
> >  	 * @SYSCTL_TABLE_TYPE_DEFAULT: ctl target with no special considerati=
ons
> >  	 * @SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY: Used to identify a permanent=
ly
> >  	 *                                       empty directory target to se=
rve
>=20
> Yes! I'll push it through with a little tweek by putting it together
> with the general documentation for the ctl_table_header. That is the way
> it is supposed to be (according to Documentation/doc-guide/kernel-doc.rst)
>=20
> Best
> --=20
>=20
> Joel Granados

Going to look something like this

sysctl: fix kernel-doc format warning

Describe the "type" struct member using '@type' and move it together
with the rest of the doc for ctl_table_header to avoid a kernel-doc
warning:

Warning: include/linux/sysctl.h:178 Incorrect use of kernel-doc format:
 * enum type - Enumeration to differentiate between ctl target types

Fixes: 2f2665c13af4 ("sysctl: replace child with an enumeration")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Joel Granados <joel.granados@kernel.org>

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 92e9146b1104..f59d5677ee09 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -156,7 +156,12 @@ struct ctl_node {
  * @nreg: When nreg drops to 0 the ctl_table_header will be unregistered.
  * @rcu: Delays the freeing of the inode. Introduced with "unfuck proc_sys=
ctl ->d_compare()"
  *
+ * @type: Enumeration to differentiate between ctl target types
+ * @type.SYSCTL_TABLE_TYPE_DEFAULT: ctl target with no special considerati=
ons
+ * @type.SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY: Identifies a permanently emp=
ty dir
+ *                                            target to serve as a mount p=
oint
  */
+
 struct ctl_table_header {
        union {
                struct {
@@ -175,13 +180,6 @@ struct ctl_table_header {
        struct ctl_dir *parent;
        struct ctl_node *node;
        struct hlist_head inodes; /* head for proc_inode->sysctl_inodes */
-       /**
-        * enum type - Enumeration to differentiate between ctl target types
-        * @SYSCTL_TABLE_TYPE_DEFAULT: ctl target with no special considera=
tions
-        * @SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY: Used to identify a permane=
ntly
-        *                                       empty directory target to =
serve
-        *                                       as mount point.
-        */
        enum {
                SYSCTL_TABLE_TYPE_DEFAULT,
                SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY,
~



Best
--=20

Joel Granados

--ztwvjylmiin7c47e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmj7fJ0ACgkQupfNUreW
QU9Kygv9Hx1LQGMN++tNdm0WIAyhz4zv+mRYukc/KmatkMfbvBlRRGzfvcJXeNLx
bSl7gsD2XVR6gBYdvMPS2JLQnG7LO420un9GG5bIgrqbkmDIeE4W02vvl1U4jNRa
D+juUXZw3lcOFzrV0+Z6zwzu3Xi7XIFp7evqBS5TTOn6p0ENse5vc/FUgN5ai/70
KX/0BQEWo7rqMI8yCMCiS0MrPcxEoBHcWhMlblNuFlAgPALk1rcKrKQEpEJysFwt
9agRTIRlprbvibMFR1dHpwA8YwWFY+dQSp2FhFwlthqSXpPRsPD0BnYnIdRMMkPg
NUACCoDIDrKw0CCVNRpPW5qBbaP9VyrexZwBmsCXXRQ0oQgYIPywhDdbf2ys6laJ
ezH5LSLre7LxNNcDFunNkrXlUWjU+n71J2pTHKjKI+Ay5yltQnIWrsiPokdIoBxF
tPQVpIRxPEyOSiOCgfsyXenBKuw1PsKVygeH7jIzYN0crCWT4H+goXWovzCAKhOM
dup4OT6u
=nuR/
-----END PGP SIGNATURE-----

--ztwvjylmiin7c47e--

