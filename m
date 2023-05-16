Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EA470534F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 18:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjEPQMv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 12:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjEPQMl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 12:12:41 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3749A5D8;
        Tue, 16 May 2023 09:12:28 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230516161225euoutp019a78b067a088231dac05ff9bfca5c649~fq6z4cFKK1279412794euoutp01Z;
        Tue, 16 May 2023 16:12:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230516161225euoutp019a78b067a088231dac05ff9bfca5c649~fq6z4cFKK1279412794euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684253545;
        bh=dSVaJvnDt08pxsup/21+MU0+7PaWQRdMC5cifWwBHZo=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=SRUJIBvQSaOLdakiCFHkEBPZZwtkeFyD+aurBafWI9aQ680AsgDo+ldOnH+xPLrcD
         oHT/hil8p6Jpc7ZQBiGZQvOjDOeIqdl3igEhVh1EKPt/DkFru8QweyIVITJiNOfJEO
         W55XvHtxKDW7PKYWqpSN2TMvQrZ74S2tKipRDyPA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230516161224eucas1p1e654be8c3b076b82e408638f03b8513c~fq6zlA2m90440504405eucas1p1B;
        Tue, 16 May 2023 16:12:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 13.A1.42423.86BA3646; Tue, 16
        May 2023 17:12:24 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230516161224eucas1p11682e3dda32dd761ab2336fcb823e323~fq6y-2s4I0436804368eucas1p1B;
        Tue, 16 May 2023 16:12:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230516161223eusmtrp10edcad50b679b55b7a1884cdc81e459f~fq6y2U1Qp1042510425eusmtrp1U;
        Tue, 16 May 2023 16:12:23 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-b1-6463ab6833d0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5B.28.14344.76BA3646; Tue, 16
        May 2023 17:12:23 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230516161223eusmtip117960414399a5bbdc79a013918121103~fq6yrjiAl1027010270eusmtip1Q;
        Tue, 16 May 2023 16:12:23 +0000 (GMT)
Received: from localhost (106.210.248.56) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 16 May 2023 17:12:23 +0100
Date:   Tue, 16 May 2023 18:12:21 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/6] parport: Remove register_sysctl_table from
 parport_proc_register
Message-ID: <20230516161221.cojocvsre7uhvz7o@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="xad4rvu4kgoxtnul"
Content-Disposition: inline
In-Reply-To: <20230516143116.hz6rr6kzsviobx35@localhost>
X-Originating-IP: [106.210.248.56]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsWy7djP87oZq5NTDJ6dlbQ4051rsWfvSRaL
        y7vmsFncmPCU0eLA6SnMFst2+jmwecxuuMjisXPWXXaPBZtKPTat6mTz+LxJLoA1issmJTUn
        syy1SN8ugStj9ut1rAUf5SpuH0xqYJwg2cXIwSEhYCLx93xZFyMXh5DACkaJwzsmsUI4Xxgl
        rv19wAThfGaUWNo8GyjDCdbxZn47VGI5o8SsvQvZ4KpubJvODOFsYZR48u4LI0gLi4CqxIMn
        V9lBbDYBHYnzb+4wg9giAhoS+yb0go1iFtjNKPHtwGSwHcIC0RLbrzeC2bwC5hI93zaxQdiC
        EidnPmEBsZkFKiQajkxiB/mCWUBaYvk/DpAwp4CFRGvjLGaIU5Uk2ic+gDq7VuLUlltguyQE
        +jklplz8AJVwkVj36BMThC0s8er4FnYIW0bi9OQeFoiGyYwS+/99YIdwVjNKLGv8CtVhLdFy
        5QlUh6PE6vV32SHhyidx460gxKF8EpPAwQIS5pXoaBOCqFaTWH3vDcsERuVZSF6bheS1WQiv
        QYR1JBbs/sSGIawtsWzha2YI21Zi3br3LAsY2VcxiqeWFuempxYb5qWW6xUn5haX5qXrJefn
        bmIEJq/T/45/2sE499VHvUOMTByMhxhVgJofbVh9gVGKJS8/L1VJhDewLzlFiDclsbIqtSg/
        vqg0J7X4EKM0B4uSOK+27clkIYH0xJLU7NTUgtQimCwTB6dUA5MdX/HxrhauJPkHd5KC/q4V
        W3tf2nLKRH1ZlmP9xbtW2aUuefFkT3ac0g5uzlUXri+LmbG74HSH7tm3MduVbB+wa9UF/F9Q
        48R70f7GJn33tU/EdvSyu82703UueZ3RU/2QVGbtoJhz+02NqmzSHu9btN1dWfWJ1k3e332z
        nfd8jItn5z6sOvNboJFscNgthb3bYqREip/H2pkLKJlyxB//zufGeGpWSnH6FfZTtZJsHR98
        SkV2Lm161m3qYXvz8fsDj5n2qBauFczIqFY7/fiN/ewTQSHvyoSKm7RO3w/I66779P69+LrY
        LxsNHt7KOvnWbVr5un81TppNrsEVm91jp36bUvOiddVxI//ndkosxRmJhlrMRcWJAPSAVL7Z
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsVy+t/xu7rpq5NTDNo+mVqc6c612LP3JIvF
        5V1z2CxuTHjKaHHg9BRmi2U7/RzYPGY3XGTx2DnrLrvHgk2lHptWdbJ5fN4kF8AapWdTlF9a
        kqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfx7e0j9oL3chUN
        19gbGPskuxg5OSQETCTezG9n6mLk4hASWMoocevlUyaIhIzExi9XWSFsYYk/17rYIIo+Mkrs
        fX+dBcLZwiixfulpsA4WAVWJB0+usoPYbAI6Euff3GEGsUUENCT2TegFW8EssJtR4tuByWBj
        hQWiJbZfbwSzeQXMJXq+bWIDsYUE5jNJbL1aDxEXlDg58wkLiM0sUCZxuGcj0AIOIFtaYvk/
        DpAwp4CFRGvjLGaIS5Uk2ic+gLq6VuLz32eMExiFZyGZNAvJpFkIkyDCWhI3/r1kwhDWlli2
        8DUzhG0rsW7de5YFjOyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAiN427GfW3Ywrnz1Ue8Q
        IxMH4yFGFaDORxtWX2CUYsnLz0tVEuEN7EtOEeJNSaysSi3Kjy8qzUktPsRoCgzFicxSosn5
        wNSSVxJvaGZgamhiZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXAFM2mMU+QOeSS
        zZc3ib8+O31R50v4t/Hftsdcx9yYN/u8Z5TcKOV2N1GXNyd7+fPSi1IhoQEcCc9CJ9zI57lj
        XXxG6Zt4krZ3NOvu5cqvLJYlaPsx/mfkEt8rwKMUOffEiR9X1kz6rPrj6O+Hy/84XPZvLejI
        +jPrtOCrWgbu+5YiLR+ury/gm+S+9DVfbghD6r/tR9/v9Lhu+P70++UdRTcezxJ6VCp2dfXh
        dJHFK7a9nr3uxrp3n269OOIh2v3+tjtX7Zka5gNhjXVbz9x5MiXydlA4z9mswNv8D/m+7Ojn
        6xY+f+y33P/rBdKLym77bGJad619cfZ9pcJrSxQPd15z3fnX6XoQV23z/4OPDxQpsRRnJBpq
        MRcVJwIATKGA0HUDAAA=
X-CMS-MailID: 20230516161224eucas1p11682e3dda32dd761ab2336fcb823e323
X-Msg-Generator: CA
X-RootMTR: 20230515071450eucas1p1625a8639e2b0edf47e41126801d4cbb8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230515071450eucas1p1625a8639e2b0edf47e41126801d4cbb8
References: <20230515071446.2277292-1-j.granados@samsung.com>
        <CGME20230515071450eucas1p1625a8639e2b0edf47e41126801d4cbb8@eucas1p1.samsung.com>
        <20230515071446.2277292-3-j.granados@samsung.com>
        <ZGMD4xMRKS8dZJpU@bombadil.infradead.org>
        <20230516143116.hz6rr6kzsviobx35@localhost>
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

--xad4rvu4kgoxtnul
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 16, 2023 at 04:31:16PM +0200, Joel Granados wrote:
> On Mon, May 15, 2023 at 09:17:39PM -0700, Luis Chamberlain wrote:
> > Awesome!
> >=20
> > On Mon, May 15, 2023 at 09:14:42AM +0200, Joel Granados wrote:
> > > +
> > > +	port_name_len =3D strnlen(port->name, PARPORT_NAME_MAX_LEN);
> > > +	/*
> > > +	 * Allocate a buffer for two paths: dev/parport/PORT and dev/parpor=
t/PORT/devices.
> > > +	 * We calculate for the second as that will give us enough for the =
first.
> > > +	 */
> > > +	tmp_path_len =3D PARPORT_BASE_DEVICES_PATH_SIZE + port_name_len;
> > > +	tmp_dir_path =3D kmalloc(tmp_path_len, GFP_KERNEL);
> >=20
> > Any reason why not kzalloc()?
> nope. Will zero it out.
>=20
> >=20
> > > +	if (!tmp_dir_path) {
> > > +		err =3D -ENOMEM;
> > > +		goto exit_free_t;
> > > +	}
> > > =20
> > > -	t->port_dir[0].procname =3D port->name;
> > > +	if (tmp_path_len
> > > +	    <=3D snprintf(tmp_dir_path, tmp_path_len, "dev/parport/%s/devic=
es", port->name)) {
> >=20
> > Since we are clearing up obfuscation code, it would be nicer to
> > make this easier to read and split the snprintf() into one line, capture
> > the error there. And then in a new line do the check. Even if we have to
> > add a new int value here.
> np. Will do something like this:
>=20
> num_chars_sprinted =3D snprintf(....
> if(tmp_path_len <=3D num_chars_sprinted) {
>   err =3D -ENOENT;
>   ...
> }
>=20
> >=20
> > Other than this I'd just ask to extend the commit log to use
> > the before and after of vmlinux (when this module is compiled in with a=
ll
> > the bells and whistles) with ./scripts/bloat-o-meter.
> >=20
> > Ie build before the patch and cp vmlinux to vmlinux.old and then compare
> > with:
> >=20
> > ./scripts/bloat-o-meter vmlinux.old vmlinux
> >=20
> > Can you also describe any testing if any.
> Sure thing. Will add the bloat-o-meter output on the last patch so as to
> gather the results for all the patches.
>=20
> I'll write some testing info on the patches.
>=20
>=20
> >=20
> > With the above changes, feel free to add to all these patches:
> >=20
> > Reviewed-by: Luis Chamberlain
> Ack
>=20
> >=20
> > > +	if (register_sysctl(tmp_dir_path, t->device_dir) =3D=3D NULL)
> >=20
> > BTW, we should be able to remove now replace register_sysctl_base() wit=
h a simple
> > register_sysctl("kernel", foo), and then one for "fs", and one of "vm"
> > on kernel/sysctl.c and just remove:
> >=20
> >   * DECLARE_SYSCTL_BASE() & register_sysctl_base() & __register_sysctl_=
base()
> >   * and then after all this register_sysctl_table() completely
> >=20
> > Let me know if you'd like a stab at it, or if you prefer me to do that.
> I think I can give it a go. Should I just add that to these set of
> patches? or should we create a new patch set?
I'll send the V2 of this patch set without this. Will add it to the
patch set when I finish if it makes sense. Else I'll just create a new
series.

Best

--=20

Joel Granados

--xad4rvu4kgoxtnul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmRjq2MACgkQupfNUreW
QU9rAQv8DIKX8qOK7q31Jp/3mKgPHPSTVWgVhFM51E5QoDUVxfeZRrT6B3lASZLa
eoZDqH14kan8FnkluX4Be/Udtd2s4RIRSSN6MPfpMxqJ4Xu8dwB3oFGLjKznSMKD
ebvfxKtvaIkvwRScs3bET007i8ofSxRBaY+xL//5fH9uXI+qwGUCiv3EnHryXb0Q
A9au6A2CFPVvHvZ8q3VprhBvQh0/iSU5XMgc1+LhOCaffcxNaNA3WuDxZtFteSe6
CPk/J9iKV2qp+M5RHZ8LDU/kpfLqrqY436rC5APYwt0OrcqCcx7APy3IU54LWqTt
dC4SqYkI2I/TuFy8IFCoY2/M4wKKeZnMyC51I15SfpP9m/b8HRxeTInQKHPBqqCx
eFxsIl/ubW/dyiWJyy+sXPH9e00v37ZbamrpBMgpiMYNBYZxitWTuW1BFhOoVZuf
C0VuZeiLiVV6pUZ2hG8YrgKN7sw26S42nsuB8+XroNubW7SQNuxae5t3IzHi1LRL
yM/kS32j
=WpNd
-----END PGP SIGNATURE-----

--xad4rvu4kgoxtnul--
