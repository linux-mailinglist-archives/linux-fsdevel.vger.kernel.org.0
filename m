Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 503C465F5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 20:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfGKSPZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 14:15:25 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51148 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbfGKSPZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 14:15:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id v15so6589872wml.0;
        Thu, 11 Jul 2019 11:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yQkaPaFqtu5Vwqq2B1yXM1aLGyI4UH2fua3Rv3nhL60=;
        b=Fkl7nLLLGFluk00TRyVMuvE7WjHkyIslwNSUjBM47ClN+r3zH0Ry2GOAER4d1pG/2q
         NhwHQIf7ngJbuqmQ2CS9pCgbRo+AN91+shXZH9r64S33zkmRzeBVEwp1iroJyCaGouF8
         KJzFEsi8GY69LvQ+K5sWC0RjEIpodaKud711Ltn1z2a9+bCd+XkxCaUFrXAcJ+djCbpq
         4asMfULPIbD23yrR/HCBCpLU5B7X2A75qXT/ZD2Rljl6J0mQhkLc2Usyh9pQW37gO8ZQ
         PqqC5iQ5BWufZyhMyoABoJPDsAbzPp5Lf6Ao/5EXEDISqFoMjXIrJdyKdRLz8HfS9rcc
         W4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yQkaPaFqtu5Vwqq2B1yXM1aLGyI4UH2fua3Rv3nhL60=;
        b=fQm1KPYMxcStgvgKAmqLjVwW35z4C7sYu7VMCQB0k/f+tJMDElwzHwiWQAiMCdhlzL
         ajbPtZP8FKturWilfkJfWUpGnxlHhQ72RmagmQOFftg4rN0Udz8ZIgSt3Nq36KsYWpaK
         zBDLezu4rfcuWJHmzGkyL4tCKP6Fo0miUfpmNdGte4hrRdPMEbPqaxyYPH+fHgig6AQG
         iesC5RTmCyZJqhro65HtyiIpj33Knv9ovbMcZ3UdyFl3WyPXCfqiOP7cVDFhUianeQgF
         VIzZcY5bZz/0xwuo89xG4kfmU89iR6oQJnaIsIeOmi8eWtnyFTsp+8XCh5WLCJJGEQs3
         HvGg==
X-Gm-Message-State: APjAAAUaFWwRpC4AaPxabmoBFlYZtWpLtonKM48z8N46n5q5IuNi9DLJ
        751gbegHDJHsu58BuU7+bQY=
X-Google-Smtp-Source: APXvYqy2dJdF2ACX/ArP79y0Jb+Lo5aq1OiW9Afdd5uu+BkFBh455H/bo3ERS2JgKKADQ22v38RvZA==
X-Received: by 2002:a05:600c:23cd:: with SMTP id p13mr4907101wmb.86.1562868923508;
        Thu, 11 Jul 2019 11:15:23 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id m7sm4912732wrx.65.2019.07.11.11.15.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Jul 2019 11:15:22 -0700 (PDT)
Date:   Thu, 11 Jul 2019 20:15:21 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     "Steven J. Magnani" <steve.magnani@digidescorp.com>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Steven J . Magnani" <steve@digidescorp.com>
Subject: Re: [PATCH v2 1/2] udf: refactor VRS descriptor identification
Message-ID: <20190711181521.fqsbatc2oslo2v5t@pali>
References: <20190711133852.16887-1-steve@digidescorp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nojv32dy3vchg6to"
Content-Disposition: inline
In-Reply-To: <20190711133852.16887-1-steve@digidescorp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--nojv32dy3vchg6to
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 11 July 2019 08:38:51 Steven J. Magnani wrote:
> --- a/fs/udf/super.c	2019-07-10 18:57:41.192852154 -0500
> +++ b/fs/udf/super.c	2019-07-10 20:47:50.438352500 -0500
> @@ -685,16 +685,62 @@ out_unlock:
>  	return error;
>  }
> =20
> -/* Check Volume Structure Descriptors (ECMA 167 2/9.1) */
> -/* We also check any "CD-ROM Volume Descriptor Set" (ECMA 167 2/8.3.1) */
> -static loff_t udf_check_vsd(struct super_block *sb)
> +static int identify_vsd(const struct volStructDesc *vsd)
> +{
> +	int vsd_id =3D 0;
> +
> +	if (!strncmp(vsd->stdIdent, VSD_STD_ID_CD001, VSD_STD_ID_LEN)) {

Hi! You probably want to use memcmp() instead of strncmp().

> +		switch (vsd->structType) {
> +		case 0:
> +			udf_debug("ISO9660 Boot Record found\n");
> +			break;
> +		case 1:
> +			udf_debug("ISO9660 Primary Volume Descriptor found\n");
> +			break;
> +		case 2:
> +			udf_debug("ISO9660 Supplementary Volume Descriptor found\n");
> +			break;
> +		case 3:
> +			udf_debug("ISO9660 Volume Partition Descriptor found\n");
> +			break;
> +		case 255:
> +			udf_debug("ISO9660 Volume Descriptor Set Terminator found\n");
> +			break;
> +		default:
> +			udf_debug("ISO9660 VRS (%u) found\n", vsd->structType);
> +			break;
> +		}
> +	} else if (!strncmp(vsd->stdIdent, VSD_STD_ID_BEA01, VSD_STD_ID_LEN))
> +		vsd_id =3D 1;
> +	else if (!strncmp(vsd->stdIdent, VSD_STD_ID_NSR02, VSD_STD_ID_LEN))
> +		vsd_id =3D 2;
> +	else if (!strncmp(vsd->stdIdent, VSD_STD_ID_NSR03, VSD_STD_ID_LEN))
> +		vsd_id =3D 3;
> +	else if (!strncmp(vsd->stdIdent, VSD_STD_ID_BOOT2, VSD_STD_ID_LEN))
> +		; /* vsd_id =3D 0 */
> +	else if (!strncmp(vsd->stdIdent, VSD_STD_ID_CDW02, VSD_STD_ID_LEN))
> +		; /* vsd_id =3D 0 */
> +	else {
> +		/* TEA01 or invalid id : end of volume recognition area */
> +		vsd_id =3D 255;
> +	}
> +
> +	return vsd_id;
> +}

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nojv32dy3vchg6to
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXSd8tgAKCRCL8Mk9A+RD
UhgPAJ0e4S2pEojXmH4baP810E+hg378nwCdGOrEC1P87wwYjg5mz4qZo0J3xpk=
=WbFq
-----END PGP SIGNATURE-----

--nojv32dy3vchg6to--
