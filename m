Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D128F1308B3
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jan 2020 16:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgAEPYv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jan 2020 10:24:51 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33039 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgAEPYv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jan 2020 10:24:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id b6so47010085wrq.0;
        Sun, 05 Jan 2020 07:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4F9+RY0yU9fqVfTSeicS1qBjnlshzGXW5AwJXhtTU9s=;
        b=E18QoDhneNFDiyLfRMo2yBdct25MXHmDNVcq2fDINCHw6wdWiuCwG7Fv8YCu+z373m
         zQ0FfWrp+Pc9Y1Pkrj7Z50QO9TsZbIuGTm9O3adSW70qeoX0YL42SCMioOeJW0XvdCOD
         6oF7MIufHhxF7babum0iXZvAvBgRi+hJoo3X21mDv5ZhQU9LWbPDWu6vRRC/m39b7jMh
         clQpzSaNQy7e1yZs8CPlaO5vkHlQMebiFfWEoWB4o46Vfh/FaqO/1XiWV0p6v+3+ckn5
         a+7sIydrU7OmEsPMG7N3PWu556IRjBt6Hd+dMJR+7fdCYP4NylzAkjI5lpZ7bJYHNSco
         cfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4F9+RY0yU9fqVfTSeicS1qBjnlshzGXW5AwJXhtTU9s=;
        b=FiYj31QT1J5ORY/F+lX7eJ5zOl8Q7KeWkFn9je/T5fpv4J7xLzNIJ+r55J90dzdAEY
         EriFbWmIRu2PQeChv1kqG8I9YGoohHvorXwfhpvFGilJsRhUWVXq/cIGneP2cdS0wrpn
         Xuje9NpNWAKafQW1yqDl0KLLIuDZeX19ejlTdufd1clk5lMQZR7D3ySmBtiAKt0/vYre
         H3Art0Mu3Ze36va81QfYx+CBa8CHAl4KOxFK5NGvckP/hll/MXgfobuIYNJyNBQW9+mo
         bPULZEorG+qGTiUlSQGGnCWoctGjxDnrjNDqQVjG3AhYP6RSES0fBWUG5zhUVBokLnoR
         bHyQ==
X-Gm-Message-State: APjAAAUCXRtc5TefkW41cyWl5DS/Y3mmQLmm6WJphlkK47c0Rqizrqju
        Vo2pF+utkC/bQc331pUh7lQ=
X-Google-Smtp-Source: APXvYqyPCZVCPY70gGbJCHHm6NLKtjwZr+Uvzi/p6xXC+Nn1md5VrLUxOH8Ai8YZjCCIOzJSC15Wtg==
X-Received: by 2002:adf:f78e:: with SMTP id q14mr98169159wrp.186.1578237889014;
        Sun, 05 Jan 2020 07:24:49 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id h66sm20616568wme.41.2020.01.05.07.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 07:24:47 -0800 (PST)
Date:   Sun, 5 Jan 2020 16:24:47 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com
Subject: Re: [PATCH v9 10/13] exfat: add nls operations
Message-ID: <20200105152447.jo27m7jgskyu2dos@pali>
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
 <CGME20200102082407epcas1p4cf10cd3d0ca2903707ab01b1cc523a05@epcas1p4.samsung.com>
 <20200102082036.29643-11-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="f2e4tgqxncq2o4tg"
Content-Disposition: inline
In-Reply-To: <20200102082036.29643-11-namjae.jeon@samsung.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--f2e4tgqxncq2o4tg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 02 January 2020 16:20:33 Namjae Jeon wrote:
> This adds the implementation of nls operations for exfat.
>=20
> Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> ---
>  fs/exfat/nls.c | 809 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 809 insertions(+)
>  create mode 100644 fs/exfat/nls.c
>=20
> diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
> new file mode 100644
> index 000000000000..af52328e28ff
> --- /dev/null
> +++ b/fs/exfat/nls.c

=2E..

> +int exfat_nls_cmp_uniname(struct super_block *sb, unsigned short *a,
> +		unsigned short *b)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < MAX_NAME_LENGTH; i++, a++, b++) {
> +		if (exfat_nls_upper(sb, *a) !=3D exfat_nls_upper(sb, *b))
> +			return 1;
> +		if (*a =3D=3D 0x0)
> +			return 0;
> +	}
> +	return 0;
> +}

Hello, this function returns wrong result when second string (b) is
longer then first string (a).

Also it is a best practise to first check for end-of-string and then
access/work with i-th element of string.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--f2e4tgqxncq2o4tg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXhH/vAAKCRCL8Mk9A+RD
Uqv7AJwIkABv+Bpvw7Z2sHDERYMAUNrI1QCeO5I7iyE5/RVgyXEYwonl4aM0vDQ=
=BcPO
-----END PGP SIGNATURE-----

--f2e4tgqxncq2o4tg--
