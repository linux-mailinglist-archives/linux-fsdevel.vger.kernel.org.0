Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE7814200F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 21:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgASUwh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jan 2020 15:52:37 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40757 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbgASUwh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jan 2020 15:52:37 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so12676364wmi.5;
        Sun, 19 Jan 2020 12:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8rXlIOKhijjg+bcBVKPGzxjcmsxgTu/40XHKeQvV1MQ=;
        b=lGg0aRjnh08uX5vQ5LKr36OaR+x6gjv+XlRJL2U053DIgYyT/24NT3pAh5rOombfyg
         JyvvSmyRBDSneZ6aKQuCWgUhF5U6sT4BGrOMq6FtlhjhgNVGuV2NX0YZ9RAIbpv68Qni
         oAxkm7j1zLoMiQA3IjfIWeY8kIi9YRgkOIdUUwCmoM8T8mWLr/4OI5e+5I2EMOhujv5g
         V8NOQTmzA/TwGl+JATX8iYAeQ6jpbUTgE0gsn0ZGGwVqxB0mQFHIgtIK9KP8qJ+h0eZC
         6FJmaqFrzSqdr+aL0kNC6ah5eQdnjZIkpbM4eMJhGX090TZR0j6aYo1Cde7qTAmP9+AD
         f/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8rXlIOKhijjg+bcBVKPGzxjcmsxgTu/40XHKeQvV1MQ=;
        b=TZ5soQnCcLR0jL8o7dMGDSn5W3fpz1qqazAHCGmaVb19GZW0NIFca1HwlRB0QDgrha
         to4r91kJ3r5d8XstTmAwmoN6CHx0qdDKF5NsT+u+6OW/3iAXCWm0rITes9zy6XMb0p17
         ir+YQDwRjsMkJWi5RhcEZbruZijQFp9VY6/xXhn2O30W4X1aM2a8ubFp+YUVO2P/Smoe
         r1cQl38gjSnIQQ75ZvYHdxHvvnesx5muV+Gq4lZ5cVW6/xaQC+SamRq/MZ+Yy+Jl5ijf
         YLLTST/dt8n/24C0S98zU1NwETwJUGsqpzAN9kuZFGr5Dexs20Xs9DKgV1MD0ZygSEeT
         V0LQ==
X-Gm-Message-State: APjAAAUN3W5iafEJo5BEg+XlcgVTCuOzC7KeRqC4tybxiVqO4k9P+Uze
        3zAXKMw3ialkl2zpMeN4W+E=
X-Google-Smtp-Source: APXvYqytFNLpv+fly1lwFj6s5KKWaiYx6HfHYlRuZmy9ViM/AuP6e23cgdobBIQdCW8xCQcSJUzV4Q==
X-Received: by 2002:a1c:ba89:: with SMTP id k131mr15401275wmf.123.1579467155581;
        Sun, 19 Jan 2020 12:52:35 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id o4sm44374099wrw.97.2020.01.19.12.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 12:52:34 -0800 (PST)
Date:   Sun, 19 Jan 2020 21:52:33 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Namjae Jeon <linkinjeon@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, arnd@arndb.de, namjae.jeon@samsung.com
Subject: Re: [PATCH v11 02/14] exfat: add super block operations
Message-ID: <20200119205233.g2kliii2ywilt6tb@pali>
References: <20200118150348.9972-1-linkinjeon@gmail.com>
 <20200118150348.9972-3-linkinjeon@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7jgbxc5qn73t55m6"
Content-Disposition: inline
In-Reply-To: <20200118150348.9972-3-linkinjeon@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--7jgbxc5qn73t55m6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sunday 19 January 2020 00:03:36 Namjae Jeon wrote:
> +	case Opt_time_offset:
> +		/*
> +		 * GMT+-12 zones may have DST corrections so at least
> +		 * 13 hours difference is needed. Make the limit 24
> +		 * just in case someone invents something unusual.
> +		 */
> +		if (result.int_32 < -24 * 60 || result.int_32 > 24 * 60)
> +			return -EINVAL;
> +		opts->time_offset =3D result.int_32;
> +		break;

"13 hours difference is needed"

This is not truth :-) Every traveller knows that Kiribati has only
standard time and is in GMT+14 time zone.

But limit =C2=B124 is enough, at least for now.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--7jgbxc5qn73t55m6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXiTBjwAKCRCL8Mk9A+RD
UkMuAJ9+XdZ3fap1ybZvyxYXQeQUKLTmeQCfezGKM287Fca2NNfPMGGLMJUD2CE=
=H+vh
-----END PGP SIGNATURE-----

--7jgbxc5qn73t55m6--
