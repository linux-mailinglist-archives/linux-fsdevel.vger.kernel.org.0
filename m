Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B333936A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 21:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbhE0TvJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 15:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbhE0TvI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 15:51:08 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9288C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 May 2021 12:49:35 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d20so465480pls.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 May 2021 12:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=Fa2Ci6/JrqTRlzpAnS9tC9bmyd0ZSsANmVOxt9bX7A8=;
        b=1hd5xgDuFY7HvexrhVUTHOGhaRkFEc34QFu77UT+HrHwxOVikTLbeERBy2tXD1eZ1q
         jhYRQ6vWJy3wUtH3f7AKhDpBDIGxKcbKo1/cRAJwQJvTySaLCGZanqbhpOIH7p2UdIPh
         n7+Ad5pSO3SdGV3ZN49NYVAH8OJJCq+9OoVJouXITqk1I3kBwg6rqRoV6PzEYIuqC0mL
         l84jecX0/qM6NLhm+lCovmdUmP5M7p0VzOl9lCP4PMqE/aib8WouUMXca29Q0/rbcNJd
         PVx/NN6ofRvIaOsMO6BuHJgKHvRm2W5PxT7Zh9WOVncJY2ZImDE1MUP6dojwdXwOlb+Y
         efzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=Fa2Ci6/JrqTRlzpAnS9tC9bmyd0ZSsANmVOxt9bX7A8=;
        b=iGB/PYXBWFTycH1RywCut4dDadZWjWLsf7Tqg0qw0BcAyRMAGJoXOpAVD9tPX3AOUK
         milwq6kP0BJpvA22H9FL2/epb+295XBeLnTnZwwcqGh9ExLzdfAJpSN2FN/zoskX879M
         8MdZ36n2DMK5rls4SLIVmj5K6sYLgMfEEdGwAMJdcaPO9+KJlYeOP3RAN78pQwuW8X9i
         vkiHrzdiB/P/7jWHM08CXj1SrOQG9uID8MxOoxRfW7SjJzfbn/oXtDU3zZTmSx6Ks9/x
         PP4H0ECmdEWrVl3vrNLp8qYHoWQci0l0jnwJPOKfQ+KSBFoikl6qYixNZvtvEAh4960a
         Immg==
X-Gm-Message-State: AOAM532YzXhT+cLwlM9u0+RJt7MbFialUQhWbVr94LXjEIWR5yzPYt0I
        IR9+agDFPQw4C6YySmZ1zThr6A==
X-Google-Smtp-Source: ABdhPJwnMjHnnK7Xw3J/4cdTVyMf+lp+PjNS2MpTGnBjpryqXjBmwUUwW+Llry0yHDJpxtZTwNcKTA==
X-Received: by 2002:a17:90b:1185:: with SMTP id gk5mr88864pjb.168.1622144975233;
        Thu, 27 May 2021 12:49:35 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id i13sm2545570pgg.30.2021.05.27.12.49.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 May 2021 12:49:34 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <9C696275-1834-4CCE-BAC1-A63835FE5F53@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_B9A69006-4295-4061-8F41-5647465943A5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH V2 3/7] ext4: remove the repeated comment of
 ext4_trim_all_free
Date:   Thu, 27 May 2021 13:49:33 -0600
In-Reply-To: <aeaa8757-b0f9-7e3e-278c-c8de77c1b6fc@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        lishujin@kuaishou.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
To:     Wang Jianchao <jianchao.wan9@gmail.com>
References: <164ffa3b-c4d5-6967-feba-b972995a6dfb@gmail.com>
 <a602a6ba-2073-8384-4c8f-d669ee25c065@gmail.com>
 <49382052-6238-f1fb-40d1-b6b801b39ff7@gmail.com>
 <aeaa8757-b0f9-7e3e-278c-c8de77c1b6fc@gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_B9A69006-4295-4061-8F41-5647465943A5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On May 26, 2021, at 2:43 AM, Wang Jianchao <jianchao.wan9@gmail.com> =
wrote:
>=20
> Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/mballoc.c | 7 +------
> 1 file changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index f984f15..85418cf 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -5741,15 +5741,10 @@ static int ext4_try_to_trim_range(struct =
super_block *sb,
>  * @max:		last group block to examine
>  * @minblocks:		minimum extent block count
>  *
> - * ext4_trim_all_free walks through group's buddy bitmap searching =
for free
> - * extents. When the free block is found, ext4_trim_extent is called =
to TRIM
> - * the extent.
> - *
> - *
>  * ext4_trim_all_free walks through group's block bitmap searching for =
free
>  * extents. When the free extent is found, mark it as used in group =
buddy
>  * bitmap. Then issue a TRIM command on this extent and free the =
extent in
> - * the group buddy bitmap. This is done until whole group is scanned.
> + * the group buddy bitmap.
>  */
> static ext4_grpblk_t
> ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
> --
> 1.8.3.1


Cheers, Andreas






--Apple-Mail=_B9A69006-4295-4061-8F41-5647465943A5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmCv980ACgkQcqXauRfM
H+D1SQ//Tey6D1xM4AoyRkbSV3CNBSGp/s0htiPyL3K7jV7W+zcOvlDiTp+RXEuS
QA1c5KDV3jmFccFwJ0AtZUWLRj5PdU65pppq4Jhuesd0JufGbKaXHJB51u3IUM0j
W0G2dvwWQJYDR/qkygqT1924Lw54gQEabcvqMVySVyxorOqtWoafrarXqJRy/u4+
gTbasiRSQ5+++lx2V9je8FqVmZASwDNMJfJQa4TBylS9Ye3eyCrxZmlUZoT+lm8E
QHeFAveWjsXs4m2y+OnrgCUXYKJe/evcC6xXx+s01uqoKZYeyJmK/pDdGXygBljt
YaXBGyQu5O8ltSqF6YwqKvTVx6/bhV42pYsf4ftr5ZpFN2NpOtoQxHxyVPn5XTtD
meplvoayXWA+kQh4EvCjkswKQVD9z2XkcpcGXGZUJHL7hJdNEgvNa5WSVPgYOILn
oqcIo4xiPKG+EsayM8XAzEaUip0IgkxPYk9s9A3wrZM6dRxC7FhQyrY4i8c1XF9m
QDn4xMqJc60n+nNf5UDxuo3zs2OHWAXapJqGZxMRPSfgyfCLtYPUnF6eWVPdp+Dx
ey8NYsmLKtw4ptH3jb7cMyeX1CnAcFn7jq4bT6N4aoIZWOkOsssXrfcoih0gsngu
6GWRsuDevnNXgiggNa2dqO4T5boM6WWfoeCtm8Ir5fTq4bZVbyw=
=4Vnz
-----END PGP SIGNATURE-----

--Apple-Mail=_B9A69006-4295-4061-8F41-5647465943A5--
