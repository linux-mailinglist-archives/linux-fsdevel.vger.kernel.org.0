Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB10C703DB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 21:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243228AbjEOT1G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 15:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244816AbjEOT0h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 15:26:37 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44749100DC;
        Mon, 15 May 2023 12:26:34 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230515192631euoutp0244bec1aaec114b56b24caea5accec525~fZ7ACyghJ2118921189euoutp02F;
        Mon, 15 May 2023 19:26:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230515192631euoutp0244bec1aaec114b56b24caea5accec525~fZ7ACyghJ2118921189euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684178791;
        bh=MZizuEmpa6HEDzwMlyOy37v0ca5o+HLnRNi8YYY2vus=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=B6PJ1M/2S2P3sPzF8dYDoySsvbQp5QvWVce1Zqfo56VmijiNUEKi/3IwpvxyYVRyB
         vBAZKzePyJysVwVFchZSNTauTkoJvzB2DgPbNkr7r1ByM7/1CjOscr7P+z3UXOFe4w
         yG2QN4TkXs++M2iZCGV3e2kWFsJXhHDAvW+sUChU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230515192630eucas1p10027f3d06c4c536807790ef34e9f738a~fZ6-pRY3I0033900339eucas1p1h;
        Mon, 15 May 2023 19:26:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 84.33.42423.66782646; Mon, 15
        May 2023 20:26:30 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230515192630eucas1p2c9bf0ffa8ddc2d0bcf9a9818c6ecd6a8~fZ6-V46-G0354903549eucas1p2U;
        Mon, 15 May 2023 19:26:30 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230515192630eusmtrp233b104dc992b6c4bd29ad2018d157335~fZ6-VYhXt0400204002eusmtrp2m;
        Mon, 15 May 2023 19:26:30 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-83-646287660dda
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DE.67.10549.66782646; Mon, 15
        May 2023 20:26:30 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230515192630eusmtip2b07e828d712e36c1ab24dce8b3e6534e~fZ6-HYOrf0896408964eusmtip2F;
        Mon, 15 May 2023 19:26:30 +0000 (GMT)
Received: from localhost (106.210.248.56) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 15 May 2023 20:26:29 +0100
Date:   Mon, 15 May 2023 21:10:19 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 3/6] parport: Remove register_sysctl_table from
 parport_device_proc_register
Message-ID: <20230515191019.cggga6c7yhnjzj4a@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="wytu3hi3jl3xaskq"
Content-Disposition: inline
In-Reply-To: <20230515071446.2277292-4-j.granados@samsung.com>
X-Originating-IP: [106.210.248.56]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsWy7djPc7pp7UkpBhfX6Vmc6c612LP3JIvF
        5V1z2CxuTHjKaHHg9BRmi2U7/RzYPGY3XGTx2DnrLrvHgk2lHptWdbJ5fN4kF8AaxWWTkpqT
        WZZapG+XwJWx+8g+9oIXKhUT9yxnb2DcJdfFyMkhIWAiMelfLzOILSSwglFiz+WYLkYuIPsL
        o8St5xeYIJzPjBKv91xk7WLkAOu49lkVIr6cUeLi54MIRWen3WGHcLYwSvzt2c0CMpdFQFXi
        78x+RhCbTUBH4vybO2D7RATEJU6c3swI0sAssJtR4tuByawgCWGBJImZ67cxgdi8AuYSa59M
        ZoewBSVOznwCNpRZoEJiybcudpCTmAWkJZb/4wAJcwrYSVyaOJ0N4jclifaJD1gh7FqJU1tu
        gV0qITCZU+LTn1PMEAkXiZNn7jBB2MISr45vYYewZST+75wP08Aosf/fB3YIZzWjxLLGr1Ad
        1hItV55AdThK/P7zjAkSSHwSN94KQhzKJzFp23RmiDCvREebEES1msTqe29YJjAqz0Ly2iwk
        r81CeA0irCOxYPcnNgxhbYllC18zQ9i2EuvWvWdZwMi+ilE8tbQ4Nz212DAvtVyvODG3uDQv
        XS85P3cTIzB5nf53/NMOxrmvPuodYmTiYDzEqALU/GjD6guMUix5+XmpSiK87TPjU4R4UxIr
        q1KL8uOLSnNSiw8xSnOwKInzatueTBYSSE8sSc1OTS1ILYLJMnFwSjUwhRkZMq7mmBQmW/1c
        5Vrbca9oVT3ZDzbp2s214nebp3/hlo6Q9K3QMhdW1Fsgkc27P3f3jUKtn5lrBY7MsmdRTjnh
        /0d3llPK42Mf9HeF9c9TP3SjUSL7sOjjvtKay/0bE7qM5O3LtQo/1z18sXLn5si37WsnHlA/
        ntFV8iT8Rsr0JY639x30jZq4On76wqRuq2q5+0vPTJaMPb26UrLo1yKzdN6K9So3QgT/vnjy
        NbpM8t+lyoshzeenKa/39lmbtSHjZ+q/RGGOVTc+WR3/UjjFN3bRnCXSNxl5bsz2WjTD6WW6
        aujW79//7G9Y9vBwgdPXI+zLV3VfFLzP7a6zVLSx8j777Rfmdx03bijSVmIpzkg01GIuKk4E
        AJqqlA7ZAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsVy+t/xe7pp7UkpBsdWSlmc6c612LP3JIvF
        5V1z2CxuTHjKaHHg9BRmi2U7/RzYPGY3XGTx2DnrLrvHgk2lHptWdbJ5fN4kF8AapWdTlF9a
        kqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJexZfU39oJnKhW3
        um4wNzDukOti5OCQEDCRuPZZtYuRi0NIYCmjxMTLi1m6GDmB4jISG79cZYWwhSX+XOtigyj6
        yCjRs20dO4SzhVHi44mrzCBVLAKqEn9n9jOC2GwCOhLn39wBi4sIiEucOL2ZEaSBWWA3o8S3
        A5PBxgoLJEnMXL+NCcTmFTCXWPtkMjuILSRQKHHn+Sw2iLigxMmZT8BOYhYok7jTCBLnALKl
        JZb/4wAJcwrYSVyaOJ0N4lIlifaJD6CurpX4/PcZ4wRG4VlIJs1CMmkWwiSIsJbEjX8vmTCE
        tSWWLXzNDGHbSqxb955lASP7KkaR1NLi3PTcYkO94sTc4tK8dL3k/NxNjMAI3nbs5+YdjPNe
        fdQ7xMjEwXiIUQWo89GG1RcYpVjy8vNSlUR422fGpwjxpiRWVqUW5ccXleakFh9iNAWG4kRm
        KdHkfGBqySuJNzQzMDU0MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRqYIqwdtuV
        299YsOO+s+a6G1tfrlr1hlFnesm6R5FfZ5i+6Jqw8WZFwzvPuqDbV+p2XQqTXKv0fcK8pvqS
        dwXKv/aYG7xQk3+TZ7qv4uwn5S028kVf/5xO+HvrxhGBo66HG+YdNywpcHqvns6UynPZ5spi
        x7Oa7uF3Dys8Oxtq0H4sdfGK5c9/9b7OfFBg/z/7deuq+M4lrt8CvQ8InVnPc2GvrNn/kLk8
        7/h2KvUULDgW/c9HUEGh83nt9g8HE9cHpE9hmrqD4aAvO0PoPh6Hos/1a/hiDdoLbI+oxxkb
        6Dbv2l3Us/anxmrHS1P1/kv7MHfd55h5QFUzZMP1gol8U/44/v9emtVzQe+r5fMX6oeUWIoz
        Eg21mIuKEwHNb5cidQMAAA==
X-CMS-MailID: 20230515192630eucas1p2c9bf0ffa8ddc2d0bcf9a9818c6ecd6a8
X-Msg-Generator: CA
X-RootMTR: 20230515192630eucas1p2c9bf0ffa8ddc2d0bcf9a9818c6ecd6a8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230515192630eucas1p2c9bf0ffa8ddc2d0bcf9a9818c6ecd6a8
References: <20230515071446.2277292-1-j.granados@samsung.com>
        <20230515071446.2277292-4-j.granados@samsung.com>
        <CGME20230515192630eucas1p2c9bf0ffa8ddc2d0bcf9a9818c6ecd6a8@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--wytu3hi3jl3xaskq
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2023 at 09:14:43AM +0200, Joel Granados wrote:
> This is part of the general push to deprecate register_sysctl_paths and
> register_sysctl_table. We use a temp allocation to include both port and
> device name in proc. Allocated mem is freed at the end. The unused
> parport_device_sysctl_template struct elements that are not used are
> removed.
>=20
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> ---
>  drivers/parport/procfs.c | 57 +++++++++++++++++++++++-----------------
>  1 file changed, 33 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
> index 53ae5cb98190..902547eb045c 100644
> --- a/drivers/parport/procfs.c
> +++ b/drivers/parport/procfs.c
> @@ -384,6 +384,7 @@ parport_device_sysctl_template =3D {
>  			.extra1		=3D (void*) &parport_min_timeslice_value,
>  			.extra2		=3D (void*) &parport_max_timeslice_value
>  		},
> +		{}
>  	},
>  	{
>  		{
> @@ -394,22 +395,6 @@ parport_device_sysctl_template =3D {
>  			.child		=3D NULL
>  		},
>  		{}
> -	},
> -	{
> -		PARPORT_DEVICES_ROOT_DIR,
> -		{}
> -	},
> -	{
> -		PARPORT_PORT_DIR(NULL),
> -		{}
> -	},
> -	{
> -		PARPORT_PARPORT_DIR(NULL),
> -		{}
> -	},
> -	{
> -		PARPORT_DEV_DIR(NULL),
> -		{}
>  	}
>  };
> =20
> @@ -547,30 +532,54 @@ int parport_proc_unregister(struct parport *port)
> =20
>  int parport_device_proc_register(struct pardevice *device)
>  {
> +	int err =3D 0;
>  	struct parport_device_sysctl_table *t;
>  	struct parport * port =3D device->port;
> +	size_t port_name_len, device_name_len, tmp_dir_path_len;
> +	char *tmp_dir_path;
>  =09
>  	t =3D kmemdup(&parport_device_sysctl_template, sizeof(*t), GFP_KERNEL);
>  	if (t =3D=3D NULL)
>  		return -ENOMEM;
> =20
> -	t->dev_dir[0].child =3D t->parport_dir;
> -	t->parport_dir[0].child =3D t->port_dir;
> -	t->port_dir[0].procname =3D port->name;
> -	t->port_dir[0].child =3D t->devices_root_dir;
> -	t->devices_root_dir[0].child =3D t->device_dir;
> +	port_name_len =3D strnlen(port->name, PARPORT_NAME_MAX_LEN);
> +	device_name_len =3D strnlen(device->name, PATH_MAX);
> +
> +	/* Allocate a buffer for two paths: dev/parport/PORT/devices/DEVICE. */
> +	tmp_dir_path_len =3D PARPORT_BASE_DEVICES_PATH_SIZE + port_name_len + d=
evice_name_len;
> +	tmp_dir_path =3D kmalloc(tmp_dir_path_len, GFP_KERNEL);
> +	if (!tmp_dir_path) {
> +		err =3D -ENOMEM;
> +		goto exit_free_t;
> +	}
> +
> +	if (tmp_dir_path_len
> +	    <=3D snprintf(tmp_dir_path, tmp_dir_path_len, "dev/parport/%s/devic=
es/%s",
> +			port->name, device->name)) {
> +		err =3D -ENOENT;
> +		goto exit_free_path;
> +	}
> =20
> -	t->device_dir[0].procname =3D device->name;
> -	t->device_dir[0].child =3D t->vars;
>  	t->vars[0].data =3D &device->timeslice;
> =20
> -	t->sysctl_header =3D register_sysctl_table(t->dev_dir);
> +	t->sysctl_header =3D register_sysctl(tmp_dir_path, t->vars);
>  	if (t->sysctl_header =3D=3D NULL) {
>  		kfree(t);
>  		t =3D NULL;
In the paprport_proc_register there is the same logic where we do not
return error code on error. Additionally, noone checks the return values
of parport_proc_register nor parport_device_proc_register. Should we
just change these to void and be done with it? Or is it better to change
parport/share.c to take care of the error codes?

I realized this after some comments from 0-day.

Best


>  	}
>  	device->sysctl_table =3D t;
> +
> +	kfree(tmp_dir_path);
>  	return 0;
> +
> +exit_free_path:
> +	kfree(tmp_dir_path);
> +
> +exit_free_t:
> +	kfree(t);
> +	t =3D NULL;
> +
> +	return err;
>  }
> =20
>  int parport_device_proc_unregister(struct pardevice *device)
> --=20
> 2.30.2
>=20

--=20

Joel Granados

--wytu3hi3jl3xaskq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmRig4wACgkQupfNUreW
QU+5qAv/XUSUpZ7GDIyi+UcJXFhuAnY7M/KsHwYQTxZVoFVqp/KB2Xi26TYWbXSZ
MHGPBo0gfFm3wxXNqUoY8hGBRHOUJ33o6yzNYj4rs8WP1ncaySX7fk+9pAD1s+SN
QqETROf1xU0wiFZHOM75/aazrMFFjPLl7iiT0Jz/g7qE8MsnBqYB/2cp848jMgqw
8P7c30PP3YldPeWSgBISG9fQpfRkYrJzdnMg9NHpFFdLS8cHRXS8hhmXnoCozt6L
NkBj+jZ8B+v49XFrbu0Sdkdn4y4OFxJ3ca6OUlz1nM+cvzX5Z5xuPBiG4s5C92u9
ZFdLd7gkrz4kVmiSZ4bPlwHUBElNTvGAHzuXmDcUvVJm9DnbUUYq7eu6sHqFlBtn
mY2o6Nilem4m+dvdU+ukg+dzEGEzc0GS5FAomhWz1snpTKGe7cavN2ItZvfUjaq4
z2pw10ojjpeyVAjUGvb/UjPmLdG5LI8tIM1aUuF9Xvip1VxsfZ2y8ovEHwnXxe2d
dtBBkUUz
=1gYL
-----END PGP SIGNATURE-----

--wytu3hi3jl3xaskq--
