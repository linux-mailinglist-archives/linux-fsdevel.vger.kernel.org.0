Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60C970B51F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 08:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjEVGee (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 02:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjEVGeW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 02:34:22 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2EC188;
        Sun, 21 May 2023 23:34:14 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230522063410euoutp019b368661815530accefd203c2e81023f~hY5p-c3Af1083710837euoutp01Z;
        Mon, 22 May 2023 06:34:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230522063410euoutp019b368661815530accefd203c2e81023f~hY5p-c3Af1083710837euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684737250;
        bh=KnF8noKk/ZcrNGPeWbWiMDRWkVS1dSU31ce5tJXoOmw=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=pj/XReemqXeaapTg21UBwaSRGPN4HspEYIKhs3eCVsmH5Mf3rkiUSNPFwjgDQJwVA
         sqvcWH+CjhMGtH7vfNi3Qb/W3bzh9HdiY/vA0APhktcWbsOU/v/OmAcxMhF3O7W/Ys
         3sOvrKzp8XHazoV/PlEfgfQ4FqbOIHTYeC+WAZzw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230522063410eucas1p16bd6b3637efd3da8eaab1df2afa84622~hY5potqow1788417884eucas1p1V;
        Mon, 22 May 2023 06:34:10 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 7C.EE.42423.2EC0B646; Mon, 22
        May 2023 07:34:10 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230522063410eucas1p26c46d01301c9e035fae0072d66db3db9~hY5pSkDZv2266122661eucas1p2y;
        Mon, 22 May 2023 06:34:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230522063410eusmtrp10b2a0ea34acff2a91f1886274120a205~hY5pR9qYC0506405064eusmtrp1L;
        Mon, 22 May 2023 06:34:10 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-89-646b0ce22d6d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 52.77.10549.1EC0B646; Mon, 22
        May 2023 07:34:09 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230522063409eusmtip17a2a920bef69ce63c1b9afde82758f31~hY5pE_USh1490514905eusmtip1T;
        Mon, 22 May 2023 06:34:09 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 22 May 2023 07:34:09 +0100
Date:   Mon, 22 May 2023 08:34:07 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        <linux-kernel@vger.kernel.org>, Iurii Zaikin <yzaikin@google.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 0/2] sysctl: Remove register_sysctl_table from sources
Message-ID: <20230522063407.odxv5dgerz33xpzf@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="cmlxrudf5ov7susn"
Content-Disposition: inline
In-Reply-To: <ZGbCOjS1n6zV9ZGV@bombadil.infradead.org>
X-Originating-IP: [106.110.32.133]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCKsWRmVeSWpSXmKPExsWy7djP87qPeLJTDKZ9F7N4ffgTo8WZ7lyL
        PXtPslhc3jWHzeLGhKeMFgdOT2G2OP/3OKvFsp1+DhwesxsusnjsnHWX3WPBplKPTas62Tw+
        b5Lz2PTkLVMAWxSXTUpqTmZZapG+XQJXxqYn+9gKfmtV7P3fydbAuFepi5GTQ0LARGLmj8Us
        XYxcHEICKxgltlxfwg7hfGGUuPjsPhOE85lR4trvJYwwLVMX90JVLWeU6PszlxkkAVb1caE3
        RGILo0TP9xtMIAkWAVWJhV1XwbrZBHQkzr+5A9YgIqAhsW9CL9gKZoGJTBL/vxwHKuLgEBbw
        klh9xQSkhlfAXOLkrslsELagxMmZT1hAbGaBCol7E2aClTMLSEss/8cBEuYUMJNY+7yPFeJQ
        JYmvb3qh7FqJU1tuga2SEFjMKfHhyF4miISLxI0l+6GKhCVeHd/CDmHLSJye3MMC0TCZUWL/
        vw/sEM5qRolljV+huq0lWq48YQe5QkLAUWL3PB8Ik0/ixltBiDv5JCZtm84MEeaV6GgTgmhU
        k1h97w3LBEblWUg+m4Xks1kIn0GEdSQW7P7EhiGsLbFs4WtmCNtWYt269ywLGNlXMYqnlhbn
        pqcWG+allusVJ+YWl+al6yXn525iBCa20/+Of9rBOPfVR71DjEwcjIcYVYCaH21YfYFRiiUv
        Py9VSYQ3sC85RYg3JbGyKrUoP76oNCe1+BCjNAeLkjivtu3JZCGB9MSS1OzU1ILUIpgsEwen
        VAMT+2TVV9zx11+tuCD7b2flNdlwfTPPrnOfLB2ql29t/p4c8k95p8AmiQ+GXxKU3r87czs7
        ZoGU/edlVzwavQ+2tHff/fL5ZWBcZ03na7+Ytemvsn33BZ6Mm35/Voe43+Gk31cVxN0FJD+v
        W26fojH10Uq2P+GX2fdP/bm+LrdD+9nSO9qHLP177nA2hKWn3f70eNWEJK9/e5aFaStzKBT5
        mBx6d3Kz5JZPsj9933A/lvjI8fnokZ/29spMFs82LliVet/qj9XU9crFSw+06IhMXGN8/WjN
        6+/71pbzPi7ymLpti0jkJG3ODR1r8jIOF0UzvDHSOq2XtOl1yTX2mV4RWvstmjobprGumubr
        skS2VomlOCPRUIu5qDgRAJ0NEnrnAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsVy+t/xu7oPebJTDJ6tsbZ4ffgTo8WZ7lyL
        PXtPslhc3jWHzeLGhKeMFgdOT2G2OP/3OKvFsp1+DhwesxsusnjsnHWX3WPBplKPTas62Tw+
        b5Lz2PTkLVMAW5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZ
        apG+XYJexvKei2wFP7Uqdv1+yNjAuFupi5GTQ0LARGLq4l72LkYuDiGBpYwSRy+sZYFIyEhs
        /HKVFcIWlvhzrYsNxBYS+MgosWC3CUTDFkaJcy3nGEESLAKqEgu7roLZbAI6Euff3GEGsUUE
        NCT2TehlAmlgFuhnkjj2Zi2Qw8EhLOAlsfqKCUgNr4C5xMldk9kghr5klPgx9zkLREJQ4uTM
        J2A2s0CZxOSb09lBepkFpCWW/+MACXMKmEmsfd4HdaiSxNc3vVB2rcTnv88YJzAKz0IyaRaS
        SbMQJkGEtSRu/HvJhCGsLbFs4WtmCNtWYt269ywLGNlXMYqklhbnpucWG+oVJ+YWl+al6yXn
        525iBMb3tmM/N+9gnPfqo94hRiYOxkOMKkCdjzasvsAoxZKXn5eqJMIb2JecIsSbklhZlVqU
        H19UmpNafIjRFBiKE5mlRJPzgYknryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUg
        tQimj4mDU6qBabHm8RrNzvkm60q437g9k0xcq8u/NX/3o7qrxRcdXp+c++hszZPQi48vpRtt
        d72x3fzmxXn9yZsKeI7mp2V+e6fZyxrso5zJrnn8AGeHZ4S/bc+2q9NEHnMeeL6KR0rhXcyr
        QDnm0ofdV2/cUw5bIxTXMKnltBRHtYDX5t0a9pck3msYm1nfkPh26ub/16r5f/aZ3pXdFpJs
        mb32pZlEuOSv6D0ad99l5//cZJT3IVzA4m3Qvx7undN4ap8u814Wkf4tI/p3/9K182JmRvG7
        rj7czx3h+Ka7hcnBXIC1raNZqPmi/N0sR0atJ6pn3l9L3XPy8uR38VU3rjz7c/lgaPeHoshv
        dwLLvCstmgT7lFiKMxINtZiLihMBKAKwSoQDAAA=
X-CMS-MailID: 20230522063410eucas1p26c46d01301c9e035fae0072d66db3db9
X-Msg-Generator: CA
X-RootMTR: 20230518160715eucas1p174602d770f0d46e0294b7dba8d6d36dc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230518160715eucas1p174602d770f0d46e0294b7dba8d6d36dc
References: <CGME20230518160715eucas1p174602d770f0d46e0294b7dba8d6d36dc@eucas1p1.samsung.com>
        <20230518160705.3888592-1-j.granados@samsung.com>
        <ZGaOtM0TqmwOkdd6@bombadil.infradead.org>
        <ZGbCOjS1n6zV9ZGV@bombadil.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--cmlxrudf5ov7susn
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2023 at 05:26:34PM -0700, Luis Chamberlain wrote:
> On Thu, May 18, 2023 at 01:46:44PM -0700, Luis Chamberlain wrote:
> > On Thu, May 18, 2023 at 06:07:03PM +0200, Joel Granados wrote:
> > > This is part of the general push to deprecate register_sysctl_paths a=
nd
> > > register_sysctl_table. This patchset completely removes register_sysc=
tl_table
> > > and replaces it with register_sysctl effectively transitioning 5 base=
 paths
> > > ("kernel", "vm", "fs", "dev" and "debug") to the new call. Besides re=
moving the
> > > actuall function, I also removed it from the checks done in check-sys=
ctl-docs.
> > >=20
> > > Testing for this change was done in the same way as with previous sys=
ctl
> > > replacement patches: I made sure that the result of `find /proc/sys/ =
| sha1sum`
> > > was the same before and after the patchset.
> > >=20
> > > Have pushed this through 0-day. Waiting on results..
> > >=20
> > > Feedback greatly appreciated.
> >=20
> > Thanks so much! I merged this to sysctl-testing as build tests are ongo=
ing. But
> > I incorporated these minor changes to your first patch as register_sysc=
tl_init()
> > is more obvious about when we cannot care about the return value.

nice! thx.

> >=20
> > If the build tests come through I'll push to sysctl-next.
> >=20
>=20
> I also had to apply this (yay more nuking):
Indeed. I just saw the results of 0-day and there was a warning
regarding these functions. Thx again.

best
joel
>=20
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 7bc7d3c3a215..8873812d22f3 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -1466,19 +1466,6 @@ void __init __register_sysctl_init(const char *pat=
h, struct ctl_table *table,
>  	kmemleak_not_leak(hdr);
>  }
> =20
> -static char *append_path(const char *path, char *pos, const char *name)
> -{
> -	int namelen;
> -	namelen =3D strlen(name);
> -	if (((pos - path) + namelen + 2) >=3D PATH_MAX)
> -		return NULL;
> -	memcpy(pos, name, namelen);
> -	pos[namelen] =3D '/';
> -	pos[namelen + 1] =3D '\0';
> -	pos +=3D namelen + 1;
> -	return pos;
> -}
> -
>  static int count_subheaders(struct ctl_table *table)
>  {
>  	int has_files =3D 0;
> @@ -1498,82 +1485,6 @@ static int count_subheaders(struct ctl_table *tabl=
e)
>  	return nr_subheaders + has_files;
>  }
> =20
> -static int register_leaf_sysctl_tables(const char *path, char *pos,
> -	struct ctl_table_header ***subheader, struct ctl_table_set *set,
> -	struct ctl_table *table)
> -{
> -	struct ctl_table *ctl_table_arg =3D NULL;
> -	struct ctl_table *entry, *files;
> -	int nr_files =3D 0;
> -	int nr_dirs =3D 0;
> -	int err =3D -ENOMEM;
> -
> -	list_for_each_table_entry(entry, table) {
> -		if (entry->child)
> -			nr_dirs++;
> -		else
> -			nr_files++;
> -	}
> -
> -	files =3D table;
> -	/* If there are mixed files and directories we need a new table */
> -	if (nr_dirs && nr_files) {
> -		struct ctl_table *new;
> -		files =3D kcalloc(nr_files + 1, sizeof(struct ctl_table),
> -				GFP_KERNEL);
> -		if (!files)
> -			goto out;
> -
> -		ctl_table_arg =3D files;
> -		new =3D files;
> -
> -		list_for_each_table_entry(entry, table) {
> -			if (entry->child)
> -				continue;
> -			*new =3D *entry;
> -			new++;
> -		}
> -	}
> -
> -	/* Register everything except a directory full of subdirectories */
> -	if (nr_files || !nr_dirs) {
> -		struct ctl_table_header *header;
> -		header =3D __register_sysctl_table(set, path, files);
> -		if (!header) {
> -			kfree(ctl_table_arg);
> -			goto out;
> -		}
> -
> -		/* Remember if we need to free the file table */
> -		header->ctl_table_arg =3D ctl_table_arg;
> -		**subheader =3D header;
> -		(*subheader)++;
> -	}
> -
> -	/* Recurse into the subdirectories. */
> -	list_for_each_table_entry(entry, table) {
> -		char *child_pos;
> -
> -		if (!entry->child)
> -			continue;
> -
> -		err =3D -ENAMETOOLONG;
> -		child_pos =3D append_path(path, pos, entry->procname);
> -		if (!child_pos)
> -			goto out;
> -
> -		err =3D register_leaf_sysctl_tables(path, child_pos, subheader,
> -						  set, entry->child);
> -		pos[0] =3D '\0';
> -		if (err)
> -			goto out;
> -	}
> -	err =3D 0;
> -out:
> -	/* On failure our caller will unregister all registered subheaders */
> -	return err;
> -}
> -
>  static void put_links(struct ctl_table_header *header)
>  {
>  	struct ctl_table_set *root_set =3D &sysctl_table_root.default_set;

--=20

Joel Granados

--cmlxrudf5ov7susn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmRrDN8ACgkQupfNUreW
QU/5ogwAj4l63622mPJ2orX+1ZvGF/vpb6dZqXA7t+y/S+EzQNLgi/hLLkd3WRAk
MiYaP1PgYuK7D10LBXQFJR6c7HSEBWWy6dTSlWK/zsE7KGLqbCb/llc70uImqDqF
wzPt0uFXPf0jGAx7PvYv8L0s6LNRQBrKk0IiKDX6POEJEwDtfyeTiexQtQv3KQsk
6hsYIZ676PdBJFgl7FnArcCQ4jbxNoAR5LQQavdFcBXJafNuxiTjA8QT4j3E6RQq
57S/7/nrnYVufhLUXOrLPIuRbbtApdVWDgfN6HUVb8RHo0H9IraDDBfN3z66ViqU
JGQ2SfTZwuQLtqwYfG6GUXkqhSbRPTB2wBiyGnoqHWOr6Z2yxo3hr0oyfy6bwaYF
TfBTE+dFwusMES1TlCU0EV6lgzjSNEFy/crBlRxiWGQ/uawZziYi5Ypjv7w6ItSg
tAuH2erOfunkOlB/Nl6JM5kIwnzNbvMUGmZrWEHGezViiRj59J6KfJqX5MEAi8Qw
HV392qYI
=Wbmi
-----END PGP SIGNATURE-----

--cmlxrudf5ov7susn--
