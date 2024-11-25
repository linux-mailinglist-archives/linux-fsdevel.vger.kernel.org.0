Return-Path: <linux-fsdevel+bounces-35769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 593C59D8384
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 11:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62C0D166369
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 10:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C58F192D8F;
	Mon, 25 Nov 2024 10:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gu4e2ZEH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BC71925AD;
	Mon, 25 Nov 2024 10:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732530977; cv=none; b=dqFTlIPLtCAJvB/4bcscsnUqRdcCr3tZc0cnU78Js6ksK1XylwtycAe9xsYMG0Dkc0ksE91n14AGvdwKgqkaF0/3rJhg+YDKBGxgZqp6a+Rl15Pb94LliTUW5L5PwQgk43w0P3sd/cVfwja8Eou0iXA1KRP+p/lZIXdCLDFbawU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732530977; c=relaxed/simple;
	bh=pQ30I//Q8MhoyQChWZx6olp6k08jb2qYE2/53OJqNp4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HjP0Wr98/jQcVmngQwS9xj537vB+749HADIDN710DEaoNaCc2lUOdOfFj0oraCz4Q3tqeICCy8MpXIdbvrQWwBj3zJ50IOCnwFtTJxll/hx9OlweKpjSuwXyn6w0qeoaeuFoQdBs8a64i8xsish6TBb9jP6nkDnzXhhbDBUWtnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gu4e2ZEH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A9CC4CECE;
	Mon, 25 Nov 2024 10:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732530977;
	bh=pQ30I//Q8MhoyQChWZx6olp6k08jb2qYE2/53OJqNp4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gu4e2ZEHI5INsEA6BpUfSuVtcVONDREvgmB5vZpRyz6gFYhGWI3NltDS83/FuxNPG
	 QBTHWjx6E1Fe89KoJ7ZyFICdgQ1SmwySW6PpZMFpSY+tMV0CSkdWoG3dmrZnz6JdH8
	 GA5rhW1wKusoWnn3NHejn299Ka8NtIci5JsHTpriumBozxT2ZjpnUFjZYlvmRdO4no
	 jwhB2bNzkaEWyZ7VxHy4ILdqSjhEGzwLDp7qZWNNHogExQdYAwWWWUuFKeY1b+2Br7
	 UyOeH5awLoYiN4ppyF/oTjfHWtajuyz8dKrqIQExDCV8l0gPuFege7a753diypR6U2
	 AJ0TIt/+Sk+MQ==
Date: Mon, 25 Nov 2024 11:36:13 +0100
From: Alejandro Colomar <alx@kernel.org>
To: john.g.garry@oracle.com
Cc: asml.silence@gmail.com, dalias@libc.org, jannh@google.com,
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] vfs: add RWF_NOAPPEND flag for pwritev2
Message-ID: <Z0RTHYtaqEoffNrG@devuan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BIqSCtq9xTJsXH4C"
Content-Disposition: inline
In-Reply-To: <f20a786f-156a-4772-8633-66518bd09a02@oracle.com>


--BIqSCtq9xTJsXH4C
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 Nov 2024 11:36:13 +0100
From: Alejandro Colomar <alx@kernel.org>
To: john.g.garry@oracle.com
Cc: asml.silence@gmail.com, dalias@libc.org, jannh@google.com,
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] vfs: add RWF_NOAPPEND flag for pwritev2

Hi,

Here's a gentle ping, as John reminded me that there's no documentation
for this in the manual pages.  Would anyone want to send a patch?

Have a lovely day!
Alex


--=20
<https://www.alejandro-colomar.es/>

--BIqSCtq9xTJsXH4C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmdEUx0ACgkQnowa+77/
2zL5cw//R5DtbUf+l6spRMZegXP9dbwI+679UF4ot29j3Kzc1sHQhAVx7+JEiNNp
8Hk20V9GEl42mc8zC6yu8CGMKkqkSv9zeugYX3OevkJ8LbeyuHOM61dSg97ixG30
LJVtkEZlqH4e1x/xPVhDKxA/ogDU2tCX2rUngjvK4/TZJHWcE95YkyrVwAjleoKa
FRHk6QI5iWxdDVKtNvhn1CZeRpteV8ByYB2H2NOSK9J5QDr98DLvZ6M17e+cMjFr
4k6t1hrSmWMB/BnqCZMqH5l8Sgs4Zhjp1HMtCyxT+Cnt4H8SQa1ufj9uHJQPzyGu
wV+0HKLi3h9U7rq3qHY5ogRx7mU5nFcLMguk9DbiJ/4331WciTVy4cQ8/csTtZbz
OlfeWnpkmkBMLgBHX4Z6DkXgO3jZhN1x+v0ZRIp6pOLGYNe/UhTN8jdQi44WWEyi
s0N1+M5+CC8xozb/puzj022uCLGtrXpnDjfWmRy16pT+Kj/ieHhJzvkKVGDO9zRP
Y5gyxYSR7nDJ11TgNN/uLWCl/hJREfMDajogr1psUVARW5PVixF6Wo9yTYny/mgs
qaS/dSwCKyhZatO99HJA+20ti8yEpTHVAtZXijssHWuOT0MEMPrkN9vlxOpX1EeY
lD/pu1f/H0WIb0qG33hhYhgcE2zKBA/VMXHUgxA3vAFbbdUiW3g=
=hk8n
-----END PGP SIGNATURE-----

--BIqSCtq9xTJsXH4C--

