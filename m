Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96FDFCF3B1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 09:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbfJHH14 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 03:27:56 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:22856 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729740AbfJHH14 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:27:56 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 76756A356C;
        Tue,  8 Oct 2019 09:27:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id 78L-dV7OvKB7; Tue,  8 Oct 2019 09:27:48 +0200 (CEST)
Date:   Tue, 8 Oct 2019 18:27:37 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "christian@brauner.io" <christian@brauner.io>,
        "aubrey.li@linux.intel.com" <aubrey.li@linux.intel.com>,
        Mingfangsen <mingfangsen@huawei.com>,
        "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] proc:fix confusing macro arg name
Message-ID: <20191008072737.hkt53lf4hdx6bola@yavin.dot.cyphar.com>
References: <165631b964b644dfa933653def533e41@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xvn3q4ilxem2qqbc"
Content-Disposition: inline
In-Reply-To: <165631b964b644dfa933653def533e41@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--xvn3q4ilxem2qqbc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-08, linmiaohe <linmiaohe@huawei.com> wrote:
> Add suitable additional cc's as Andrew Morton suggested.
> Get cc list from get_maintainer script:
> [root@localhost mm]# ./scripts/get_maintainer.pl 0001-proc-fix-confusing-=
macro-arg-name.patch=20
> Alexey Dobriyan <adobriyan@gmail.com> (reviewer:PROC FILESYSTEM)
> linux-kernel@vger.kernel.org (open list:PROC FILESYSTEM)
> linux-fsdevel@vger.kernel.org (open list:PROC FILESYSTEM)
>=20
> ------------------------------------------------------
> From: Miaohe Lin <linmiaohe@huawei.com>
> Subject: fix confusing macro arg name
>=20
> state_size and ops are in the wrong position, fix it.
>=20
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Looks reasonable.

Acked-by: Aleksa Sarai <cyphar@cyphar.com>

> ---
>=20
>  include/linux/proc_fs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h index a705=
aa2d03f9..0640be56dcbd 100644
> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h
> @@ -58,8 +58,8 @@ extern int remove_proc_subtree(const char *, struct pro=
c_dir_entry *);  struct proc_dir_entry *proc_create_net_data(const char *na=
me, umode_t mode,
>  		struct proc_dir_entry *parent, const struct seq_operations *ops,
>  		unsigned int state_size, void *data);
> -#define proc_create_net(name, mode, parent, state_size, ops) \
> -	proc_create_net_data(name, mode, parent, state_size, ops, NULL)
> +#define proc_create_net(name, mode, parent, ops, state_size) \
> +	proc_create_net_data(name, mode, parent, ops, state_size, NULL)
>  struct proc_dir_entry *proc_create_net_single(const char *name, umode_t =
mode,
>  		struct proc_dir_entry *parent,
>  		int (*show)(struct seq_file *, void *), void *data);
> --
> 2.21.GIT
>=20


--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--xvn3q4ilxem2qqbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXZw6ZgAKCRCdlLljIbnQ
EiEGAQDG9zRJQF5jUEsy8iMlB83kVXNRjV/eaNv4FlZQxbdtbQD+JM6uYaDbPpOs
EWiAKUr9k7mf2zBxaLqEzL8/eqYJxQA=
=QSng
-----END PGP SIGNATURE-----

--xvn3q4ilxem2qqbc--
