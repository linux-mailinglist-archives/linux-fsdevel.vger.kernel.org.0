Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABD67050C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 16:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbjEPOb1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 10:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbjEPObZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 10:31:25 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35521727;
        Tue, 16 May 2023 07:31:21 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230516143119euoutp01c2487c314502257a37dc9084dfe79d22~fpijMSiLx0110101101euoutp01t;
        Tue, 16 May 2023 14:31:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230516143119euoutp01c2487c314502257a37dc9084dfe79d22~fpijMSiLx0110101101euoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684247479;
        bh=0jWr2Dk4g7IBKzDywUXFicQqinCfPh1ocFLg2FlASq0=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=kfBPAKCQ1Ti1RsjJtkUVJ0wEt1M9CwzSfezfqwl1dU9mO2QXKh/r9rHm+qurkLT5/
         eDMBwQCjs/D6ttrPKCClvi7/JEQpJtDOm7BUrliWIiXbzXX2MmdGMWMooeN2sVXcSS
         4UzqsEEeXInD7yyVcZP55xr/P+mBA749JcmRS8ic=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230516143119eucas1p235a941c390aaaaea5d62e6bb4c710304~fpijDKawu0555805558eucas1p29;
        Tue, 16 May 2023 14:31:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id EB.A5.37758.7B393646; Tue, 16
        May 2023 15:31:19 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230516143119eucas1p198b62ad14d80a91355a88da64591e588~fpiiw3e010142301423eucas1p1h;
        Tue, 16 May 2023 14:31:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230516143119eusmtrp1445182269b94d646523e928c895cb849~fpiiv_xTx1051810518eusmtrp1J;
        Tue, 16 May 2023 14:31:19 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-74-646393b7a474
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5E.3B.14344.7B393646; Tue, 16
        May 2023 15:31:19 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230516143119eusmtip1d4a3a6dbb198ef314068c94a85e7b040~fpiimQg_H0042000420eusmtip1K;
        Tue, 16 May 2023 14:31:19 +0000 (GMT)
Received: from localhost (106.210.248.56) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 16 May 2023 15:31:18 +0100
Date:   Tue, 16 May 2023 16:31:16 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/6] parport: Remove register_sysctl_table from
 parport_proc_register
Message-ID: <20230516143116.hz6rr6kzsviobx35@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="x6ojqk2yiejklprz"
Content-Disposition: inline
In-Reply-To: <ZGMD4xMRKS8dZJpU@bombadil.infradead.org>
X-Originating-IP: [106.210.248.56]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7djP87rbJyenGNxco2pxpjvXYs/ekywW
        l3fNYbO4MeEpo8WB01OYLZbt9HNg85jdcJHFY+esu+weCzaVemxa1cnm8XmTXABrFJdNSmpO
        Zllqkb5dAlfG/qMrmAomyVTM2LuJrYFxpngXIyeHhICJxK/NbcxdjFwcQgIrGCUO3XvFCOF8
        YZTY8WE2C4TzmVGirfcdM0zL7Emf2SESyxkljn45ygaSAKua9kEBIrGFUeJ200awBIuAqsSM
        7SfButkEdCTOv7kDZosIaEjsm9DLBNLALLCbUeLbgcmsIAlhgWiJ7dcbwWxeAXOJ7zc72CFs
        QYmTM5+wgNjMAhUSz3ecBRrEAWRLSyz/xwES5hQwk3j14RILxKVKEu0TH7BC2LUSp7bcAtsl
        IdDOKfHx3Fuod1wkfi2byA5hC0u8Or4FypaROD25hwWiYTKjxP5/H9ghnNWMEssavzJBVFlL
        tFx5AtXhKLF6/V12kIskBPgkbrwVhDiUT2LStunMEGFeiY42IYhqNYnV996wTGBUnoXktVlI
        XpuF8BpEWEdiwe5PbBjC2hLLFr5mhrBtJdate8+ygJF9FaN4amlxbnpqsXFearlecWJucWle
        ul5yfu4mRmD6Ov3v+NcdjCtefdQ7xMjEwXiIUQWo+dGG1RcYpVjy8vNSlUR4A/uSU4R4UxIr
        q1KL8uOLSnNSiw8xSnOwKInzatueTBYSSE8sSc1OTS1ILYLJMnFwSjUwNXAu3/1vV+5Gm/h3
        AR/E3z2SOf8+l7N3WrdX+E5W/WnGl36svDXJOPzh9hnb+e1nbGKd4Hfu0Tb3sx/rPt2tmVhX
        Le17Lv2ho/Iyww7W/0uPrNjblntz7va1/lP2npD59qO9hJc1R3zS82tyEqwuawKm5xkH1N5k
        yDCVr725c5aOTOzkCXGfHmYdiQ+dMXF71W+jqCWWf7JF3+/cbL2DX2JFU4slS0bg2QVpucJC
        /cI1kX5PZitsYnH4tulOSVLU5Q1Hmw8WflmV/Gun6Z2bAhsKw6ROrmJder2KxfrNvC+VXqd+
        WDpFClnFNtU0+/Gbuq+7fv3ri0J7ZTmurSkpjt92f3x1Kff/zjnp05Kq3ZRYijMSDbWYi4oT
        ATrSgLbaAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsVy+t/xu7rbJyenGFyeJGhxpjvXYs/ekywW
        l3fNYbO4MeEpo8WB01OYLZbt9HNg85jdcJHFY+esu+weCzaVemxa1cnm8XmTXABrlJ5NUX5p
        SapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7GnTfn2QsmyFR8
        fOnfwDhdvIuRk0NCwERi9qTP7F2MXBxCAksZJbY3n2ODSMhIbPxylRXCFpb4c62LDaLoI6PE
        57vTGSGcLYwSLZu3gFWxCKhKzNh+khnEZhPQkTj/5g6YLSKgIbFvQi8TSAOzwG5GiW8HJoM1
        CAtES2y/3ghm8wqYS3y/2cEOt2Lt201MEAlBiZMzn7CA2MwCZRJn5n8DKuIAsqUllv/jAAlz
        CphJvPpwiQXiVCWJ9okPoM6ulfj89xnjBEbhWUgmzUIyaRbCJIiwlsSNfy+ZMIS1JZYtfM0M
        YdtKrFv3nmUBI/sqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwBjeduznlh2MK1991DvEyMTB
        eIhRBajz0YbVFxilWPLy81KVRHgD+5JThHhTEiurUovy44tKc1KLDzGaAoNxIrOUaHI+MLnk
        lcQbmhmYGpqYWRqYWpoZK4nzehZ0JAoJpCeWpGanphakFsH0MXFwSjUwzbm55Fn6f7HdN5cH
        uSrJHXdgEtbUO96scidV9XBO5Tl9vWsvSqa1yeUpteV9bDl0enmkTMgX6/PFMZ2LUq9ttm1P
        7Kpe5+fIfld//cu313/67phleDa4+NfVQ5xvxXl2bl7edzTOnueIak+BG/+KrNQ8t/SAmXtE
        ouP/RcnLx5y/a2FuFP7i01NZs2tLv8tJG69Zv6HgxXQl53P+C/pUMjxF3ja4/vRex9j3Kv3l
        vB9HPtjY7lacbdIb4zenQGWSdr3ixulfbh3RYLVtnN2tJFZd+PmNu9Wx93NNRfQr0lXnb9VY
        /mC3eqdteuB3ln/czza/yVpy9a3TLM4H7u4yqy7zSVSaGu2Ij9X44BOgxFKckWioxVxUnAgA
        OE+EKXYDAAA=
X-CMS-MailID: 20230516143119eucas1p198b62ad14d80a91355a88da64591e588
X-Msg-Generator: CA
X-RootMTR: 20230515071450eucas1p1625a8639e2b0edf47e41126801d4cbb8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230515071450eucas1p1625a8639e2b0edf47e41126801d4cbb8
References: <20230515071446.2277292-1-j.granados@samsung.com>
        <CGME20230515071450eucas1p1625a8639e2b0edf47e41126801d4cbb8@eucas1p1.samsung.com>
        <20230515071446.2277292-3-j.granados@samsung.com>
        <ZGMD4xMRKS8dZJpU@bombadil.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--x6ojqk2yiejklprz
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2023 at 09:17:39PM -0700, Luis Chamberlain wrote:
> Awesome!
>=20
> On Mon, May 15, 2023 at 09:14:42AM +0200, Joel Granados wrote:
> > +
> > +	port_name_len =3D strnlen(port->name, PARPORT_NAME_MAX_LEN);
> > +	/*
> > +	 * Allocate a buffer for two paths: dev/parport/PORT and dev/parport/=
PORT/devices.
> > +	 * We calculate for the second as that will give us enough for the fi=
rst.
> > +	 */
> > +	tmp_path_len =3D PARPORT_BASE_DEVICES_PATH_SIZE + port_name_len;
> > +	tmp_dir_path =3D kmalloc(tmp_path_len, GFP_KERNEL);
>=20
> Any reason why not kzalloc()?
nope. Will zero it out.

>=20
> > +	if (!tmp_dir_path) {
> > +		err =3D -ENOMEM;
> > +		goto exit_free_t;
> > +	}
> > =20
> > -	t->port_dir[0].procname =3D port->name;
> > +	if (tmp_path_len
> > +	    <=3D snprintf(tmp_dir_path, tmp_path_len, "dev/parport/%s/devices=
", port->name)) {
>=20
> Since we are clearing up obfuscation code, it would be nicer to
> make this easier to read and split the snprintf() into one line, capture
> the error there. And then in a new line do the check. Even if we have to
> add a new int value here.
np. Will do something like this:

num_chars_sprinted =3D snprintf(....
if(tmp_path_len <=3D num_chars_sprinted) {
  err =3D -ENOENT;
  ...
}

>=20
> Other than this I'd just ask to extend the commit log to use
> the before and after of vmlinux (when this module is compiled in with all
> the bells and whistles) with ./scripts/bloat-o-meter.
>=20
> Ie build before the patch and cp vmlinux to vmlinux.old and then compare
> with:
>=20
> ./scripts/bloat-o-meter vmlinux.old vmlinux
>=20
> Can you also describe any testing if any.
Sure thing. Will add the bloat-o-meter output on the last patch so as to
gather the results for all the patches.

I'll write some testing info on the patches.


>=20
> With the above changes, feel free to add to all these patches:
>=20
> Reviewed-by: Luis Chamberlain
Ack

>=20
> > +	if (register_sysctl(tmp_dir_path, t->device_dir) =3D=3D NULL)
>=20
> BTW, we should be able to remove now replace register_sysctl_base() with =
a simple
> register_sysctl("kernel", foo), and then one for "fs", and one of "vm"
> on kernel/sysctl.c and just remove:
>=20
>   * DECLARE_SYSCTL_BASE() & register_sysctl_base() & __register_sysctl_ba=
se()
>   * and then after all this register_sysctl_table() completely
>=20
> Let me know if you'd like a stab at it, or if you prefer me to do that.
I think I can give it a go. Should I just add that to these set of
patches? or should we create a new patch set?

>=20
>   Luis
>=20
>=20

best
--=20

Joel Granados

--x6ojqk2yiejklprz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmRjk7MACgkQupfNUreW
QU80NAv+Mak2DpbfQidcYHU5/HEB1Etsk/IurnIbyXBSiVWDePITIeqLsGRw7jRx
aSW0AdMA5VMFcxveb1lgbeT7hnus8WGuWAPgoYzXawZjKqDh1jD2B0MmLhTx6lpt
v2CQ5pOqQgMTsKjAycWrdjJ7DIzqgz5866nG1K9OSsYadGNx5WX2zdsjc5Ad4Cx4
/dl37lwMVt/VahqJV3VexCmgcsRG1/E6HGVCQcT779xel7pm7q9pMIrYZCXJMtaO
DTgcrdG7HDDVb8PxPuDiBsFuBIBdw/BracGeU/AS0PoQ3Fql/G8nXucWLmlP7k/n
8RDZ0NQSUVALfwtRBukPFhlu/vGTSDiCbyM0NCW/iH9qqabHUKK/tVkfniN1IbKg
OIIi9yH6qbxdxEQso5fZckf4CCz78tdY58YS+FU6nLB0ouGycK5CDUw0KFyz07FC
WcssTGI7K5ksezyoYti0ecNlmmsX5j+bn0EwCbQ6x2J3U2YfyT2NUMwjTbIFvyMZ
iqrgaXtN
=cjwp
-----END PGP SIGNATURE-----

--x6ojqk2yiejklprz--
