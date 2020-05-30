Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE34C1E9434
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 May 2020 00:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbgE3WOK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 May 2020 18:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729416AbgE3WOI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 May 2020 18:14:08 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB45C08C5CB
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2020 15:14:06 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ci21so3369103pjb.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2020 15:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=8sism75zVT9pduqsvpPRRhWEaW/18m+btjuZdwKkiCw=;
        b=CAKZdEQwT0plXobzxfL58PrCDLJtv4jHFVRDD0w3EALaSlzRVsnW1FMeEpX8DKIdrr
         D3d3Y2C7Ks0liwfyZ0VdsBySPBJD/HpBQL/rEkhGsgOXzGktxLL+yIovSotoqoMX0paI
         KR3TJF41EiQx1tJMId3EV2qrifWb7SPlsi1t5GAzniipnBdE9cV+61Lm329rXhm0qf12
         IvO0S01eGLQsNcoue2mhrladjTUzeDrJXwpRuXEON4617o1hN88MtzS7ANB/B+BBGpHA
         R1XgHVwTUhvoDFM6Dyi4XPHE8ZGNN4SeBVNDiOsmlWbDf35LiSw9pKaI09EGiNRwz4hq
         +jTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=8sism75zVT9pduqsvpPRRhWEaW/18m+btjuZdwKkiCw=;
        b=lrHjWr2a7QRlJFo6w4HhNgczFbL8cgknyjwKy4McTT6Nzd1MJ2JxdLjxEAWwaPXMD/
         AB0W14tLuKhD73QWsXWfLiX4mFtGHUB4V18EcpEt63PWw1zaqxJrQ5YrbvrT78x5915k
         JUO/9HS5KpaS4VwO6gvZ+ga2mgX1q+a8igD8SnXY8iyczOCQBeq0Ib2ac2aJDoVdXDvZ
         7s+owkwel7gLTym1uC32qyLIk0+7b0fGQCZDrCuxy9uk8lhG1ZOsdQ+usyD5pvaVC3gi
         Ww4bF0d71HvHBNa3BXPEtulmxu3eZ2DbCCUcRVxBOqbP+/czUdMr9FXtWxwCje/9p66Y
         +6nQ==
X-Gm-Message-State: AOAM531WgB/y1ZRCbFmRP5JLNaLL+f6RXjkIuersZDcVoCAuoA1syLos
        7c/V7/x5BHTDt2ouOGMudhZ7tQ==
X-Google-Smtp-Source: ABdhPJwzY7gMyB0U3nUlbkYYd3ziIExhobvoRE5Z1j4/rP5DoG3B0FTXaLG3+sL+CuYQfMOYBmrZNw==
X-Received: by 2002:a17:90b:245:: with SMTP id fz5mr3098009pjb.138.1590876845267;
        Sat, 30 May 2020 15:14:05 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id 140sm7528024pfy.95.2020.05.30.15.14.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 May 2020 15:14:04 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <F5AE90A2-1661-4B8E-A884-C3CBAB0F603F@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_83631672-66E3-42A2-A44C-BB2762691B7E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] checkpatch/coding-style: Allow 100 column lines
Date:   Sat, 30 May 2020 16:14:01 -0600
In-Reply-To: <9c360bfa43580ce7726dd3d9d247f1216a690ef0.camel@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
To:     Joe Perches <joe@perches.com>
References: <CAHk-=wj3iGQqjpvc+gf6+C29Jo4COj6OQQFzdY0h5qvYKTdCow@mail.gmail.com>
 <20200528054043.621510-1-hch@lst.de>
 <22778.1590697055@warthog.procyon.org.uk>
 <f89f0f7f-83b4-72c6-7d08-cb6eaeccd443@schaufler-ca.com>
 <3aea7a1c10e94ea2964fa837ae7d8fe2@AcuMS.aculab.com>
 <CAHk-=wjR0H3+2ba0UUWwoYzYBH0GX9yTf5dj2MZyo0xvyzvJnA@mail.gmail.com>
 <9c360bfa43580ce7726dd3d9d247f1216a690ef0.camel@perches.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_83631672-66E3-42A2-A44C-BB2762691B7E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On May 29, 2020, at 5:12 PM, Joe Perches <joe@perches.com> wrote:
>=20
> Change the maximum allowed line length to 100 from 80.

What is the benefit/motivation for changing this?  The vast majority
of files are wrapped at 80 columns, and if some files start being
wrapped at 100 columns they will either display poorly on 80-column
terminals, or a lot of dead space will show in 100-column terminals.

> Miscellanea:
>=20
> o to avoid unnecessary whitespace changes in files,
>  checkpatch will no longer emit a warning about line length
>  when scanning files unless --strict is also used
> o Add a bit to coding-style about alignment to open parenthesis
>=20
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> Documentation/process/coding-style.rst | 25 ++++++++++++++++---------
> scripts/checkpatch.pl                  | 14 +++++++++-----
> 2 files changed, 25 insertions(+), 14 deletions(-)
>=20
> diff --git a/Documentation/process/coding-style.rst =
b/Documentation/process/coding-style.rst
> index acb2f1b36350..55b148e9c6b8 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -84,15 +84,22 @@ Get a decent editor and don't leave whitespace at =
the end of lines.
> Coding style is all about readability and maintainability using =
commonly
> available tools.
>=20
> -The limit on the length of lines is 80 columns and this is a strongly
> -preferred limit.
> -
> -Statements longer than 80 columns will be broken into sensible =
chunks, unless
> -exceeding 80 columns significantly increases readability and does not =
hide
> -information. Descendants are always substantially shorter than the =
parent and
> -are placed substantially to the right. The same applies to function =
headers
> -with a long argument list. However, never break user-visible strings =
such as
> -printk messages, because that breaks the ability to grep for them.
> +The preferred limit on the length of a single line is 80 columns.
> +
> +Statements longer than 80 columns should be broken into sensible =
chunks,
> +unless exceeding 80 columns significantly increases readability and =
does
> +not hide information.
> +
> +Statements may be up to 100 columns when appropriate.
> +
> +Descendants are always substantially shorter than the parent and are
> +are placed substantially to the right.  A very commonly used style
> +is to align descendants to a function open parenthesis.
> +
> +These same rules are applied to function headers with a long argument =
list.
> +
> +However, never break user-visible strings such as printk messages =
because
> +that breaks the ability to grep for them.
>=20
>=20
> 3) Placing Braces and Spaces
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index dd750241958b..5f00df2c3f59 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -53,7 +53,7 @@ my %ignore_type =3D ();
> my @ignore =3D ();
> my $help =3D 0;
> my $configuration_file =3D ".checkpatch.conf";
> -my $max_line_length =3D 80;
> +my $max_line_length =3D 100;
> my $ignore_perl_version =3D 0;
> my $minimum_perl_version =3D 5.10.0;
> my $min_conf_desc_length =3D 4;
> @@ -99,9 +99,11 @@ Options:
>   --types TYPE(,TYPE2...)    show only these comma separated message =
types
>   --ignore TYPE(,TYPE2...)   ignore various comma separated message =
types
>   --show-types               show the specific message type in the =
output
> -  --max-line-length=3Dn        set the maximum line length, if =
exceeded, warn
> +  --max-line-length=3Dn        set the maximum line length, (default =
$max_line_length)
> +                             if exceeded, warn on patches
> +                             requires --strict for use with --file
>   --min-conf-desc-length=3Dn   set the min description length, if =
shorter, warn
> -  --tab-size=3Dn               set the number of spaces for tab =
(default 8)
> +  --tab-size=3Dn               set the number of spaces for tab =
(default $tabsize)
>   --root=3DPATH                PATH to the kernel tree root
>   --no-summary               suppress the per-file summary
>   --mailback                 only produce a report in case of =
warnings/errors
> @@ -3282,8 +3284,10 @@ sub process {
>=20
> 			if ($msg_type ne "" &&
> 			    (show_type("LONG_LINE") || =
show_type($msg_type))) {
> -				WARN($msg_type,
> -				     "line over $max_line_length =
characters\n" . $herecurr);
> +				my $msg_level =3D \&WARN;
> +				$msg_level =3D \&CHK if ($file);
> +				&{$msg_level}($msg_type,
> +					      "line length of $length =
exceeds $max_line_length columns\n" . $herecurr);
> 			}
> 		}
>=20
>=20


Cheers, Andreas






--Apple-Mail=_83631672-66E3-42A2-A44C-BB2762691B7E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl7S2qkACgkQcqXauRfM
H+AkRA//RZmP8frfFpi0pH85h7onJK9vtI9wxpcARaYob2jCUehjiSxeetTlAwJE
+SX1+sZeCoghXelyFESfWG1p65jRiZhWjVMT7pxj5mVAd9leBVjkgwYwbALLiffz
wg/SmDTR7LIGMR/1xqATTzwVDpLO1yj6nwVyAG8WDaMiiya4EEjxPtGaCGJ/Yo+K
GSqY2ix/NKHhwgAdwduOjrY3OSCUziByrwibr8p7qi4jAFs2J+2vE65AqY05RLnZ
vyPuh7h1bGr2tlaapHJn4b2AaWSttJ5Cj3lCBwPDv4yZE2CIY0gcw7d2txWh+hvE
5Q9SBeLVNGs0XddUV6ebvZhtaSWi1qi6OyTyjX9v7vzUPZF7kUtAIp9X3Ewx2PJu
POGu2JkdbN0jzt7Ur+IyoNZY+uzidTlpACTQU/ZlfISuhAnOjgFJfFRTEHI+aD8G
zs2UoawmSLKPnVSDWv8MxYtw7uH5yJw1WL7NVMK55ofBimRXFrgsTwL678A1LWZx
7OLhQUvUtduxff13+DNc03zEkgMv9iyFw8VmzQbxiwG2yWnH93RiuHOzIf1uPOdA
y42Aq0KZIeF7U4yJkPFvZuRyoaKSrjuY7Y8DrGn4MD8qW0S0s64DuiuMrYrNjuCK
0n9NBCorgBVUaroHaek0MUch8N/DvsMt84yttZAoryaBqN9jDZ0=
=qASh
-----END PGP SIGNATURE-----

--Apple-Mail=_83631672-66E3-42A2-A44C-BB2762691B7E--
