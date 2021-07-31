Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9433DC27E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jul 2021 03:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbhGaBnG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 21:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhGaBnF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 21:43:05 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A05C06175F;
        Fri, 30 Jul 2021 18:42:59 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so16877275pjh.3;
        Fri, 30 Jul 2021 18:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NCLQ2EpIWRi/3cdwqWHD40lI3XLsYo+pZWmyqw0GrF8=;
        b=NzY27VmMPkJE9lL01BS0/Hp2QxIDd8aTOjn998cE3QHOD6TYH3eZJn4nC++QWCX4F6
         +lCjHyvs/wBkU+Nnv7W5geB9qcQhmSCJZwlsgYfX4K6dNmqjPUpm9OwLB8H291fWgGJj
         nzycWMFS/BoQdk4VUN/EBbpyPpxHg5sPBedo9nDq9NTVDcZzu04eUlbJr+P8uFJXMgn5
         J6fJSbpxLRBfdZGWEkJ1zi+jkIb/asd9gt9vHKMWLcvltvflKVS5Es6SGsFI3m4fRzBc
         EAjjsZv0zbChtxSpCYCzbxJnehKdiWGffmx81sOdyRi4Cd5k8cgFQ/3Y97BiRE49hMla
         BmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NCLQ2EpIWRi/3cdwqWHD40lI3XLsYo+pZWmyqw0GrF8=;
        b=oi9Bo+U/LbBhB9fYahPGq5wqCOXymvIyb1kO8UtSsv+tv60ae5QwOFCjIrUrjQpXIg
         66SsfhtifXk5D44BAL35vukgn3aZv8/VKqS/rQ/wpF2822yBMj7gyVbAHiJWBeDKQ6Jn
         RV/NU+34ZXigDyCbh3UMR2C7d60xle+I015pCCrHS5s/baUCJDf0Jkvg/Nn+eiUzgpqu
         0048lhAbJdtoMC3LVuGajPy5YFmIOhZfPc/AQxYo2Q1lQWgu25IH8ffjC0SJlRE8z1dM
         O0ydl8tOmaeruyN4w/GWVmDQgCYHno30Ip3YtSwk6J3igr4hRAZY5gnW3hwVBSDyumMD
         sYzA==
X-Gm-Message-State: AOAM530MhZhk8EZSsxjjwv6tjGMF0ILSSo9fk7IrMKrnSSvuqZys6uFX
        EKa4fH4ZxKQmpkZw/1E9MVU=
X-Google-Smtp-Source: ABdhPJwzE0FrlGJJst5PjaIlCQDf9EoHIrVaX4ApDD9JzK0jRUAI7CTff8gcNd/aPi6mSXHWziSYWA==
X-Received: by 2002:a17:902:7085:b029:114:eb3f:fe29 with SMTP id z5-20020a1709027085b0290114eb3ffe29mr5082714plk.40.1627695778784;
        Fri, 30 Jul 2021 18:42:58 -0700 (PDT)
Received: from localhost.localdomain ([1.145.37.91])
        by smtp.gmail.com with ESMTPSA id m24sm4099647pgv.24.2021.07.30.18.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 18:42:58 -0700 (PDT)
Date:   Sat, 31 Jul 2021 11:42:52 +1000
From:   "G. Branden Robinson" <g.branden.robinson@gmail.com>
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Glibc <libc-alpha@sourceware.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH v2] mount_setattr.2: New manual page documenting the
 mount_setattr() system call
Message-ID: <20210731014251.whqfubv3hzu3mssw@localhost.localdomain>
References: <20210730094121.3252024-1-brauner@kernel.org>
 <9ba8d98e-dee9-1d8d-0777-bb5496103e24@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sp3u4puormuxs4vs"
Content-Disposition: inline
In-Reply-To: <9ba8d98e-dee9-1d8d-0777-bb5496103e24@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--sp3u4puormuxs4vs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi, Alex!

At 2021-07-30T20:15:43+0200, Alejandro Colomar (man-pages) wrote:
> > +With each extension that changes the size of
> > +.I struct mount_attr
> > +the kernel will expose a define of the form
> > +.B MOUNT_ATTR_SIZE_VER<number> .
>=20
> s/.B/.BR/

I would say this is, properly considered, an instance of the notorious
three-font problem.  "number" should be in italics, and the angle
brackets are certainly neither literal nor variable, but are injected to
get around the most dreaded markup problem in man(7).

But it need not be dreaded anymore.

There are two ways to address this; both require *roff escape sequences.

My preference is to use \c, the output line continuation escape
sequence.  (Ingo Schwarze, OpenBSD committer and mandoc(1) maintainer,
has the opposite preference, for \f escapes).

I recommend:

=2EBI MOUNT_ATTR_SIZE_VER number\c
\&.

(The non-printing input break, \& can be seen in several contexts; here,
it prevents the period from being interpreted specially the beginning of
the line, marking it a "control line" like the macro call immediately
previous.)

The period will be set in the roman style.  This problem and its
workarounds are documented in groff_man_style(7)[1].

> > +The effect of this change will be a mount or mount tree that is read-o=
nly,
> > +blocks the execution of setuid binaries but does allow to execute prog=
rams and
>=20
> I'm not sure about this:
>=20
> I've checked other pages that mention setuid, and I've seen different
> things.
> But none of them use setuid as an English word.
> Maybe have a look at similar pages and try to use a similar syntax.
>=20
> grep -rni setuid man?

It's common in technical literature to introduce specialized terminology
and subsequently apply it attributively.

Personally, I would style "setuid" in italics in the above example; that
is how I would expect to see it in a printed manual.

Even more explicitly, one could write

	execution of
	.IR setuid -using
	binaries,

While I'm here I will note that there should be a comma as noted above,
and the seemingly ineradicable Denglish construction of following the
verb "allow" with an infinitive should be recast.

My suggestion:

	but allows execution of programs and access to device nodes.

> > +access to devices nodes.
> > +In the new mount api the access time values are an enum starting from =
0.
> > +Even though they are an enum in contrast to the other mount flags such=
 as
> > +.BR MOUNT_ATTR_NOEXEC
>=20
> s/.BR/.B/

Alex (and others), if you have access to groff from its Git HEAD, you
might be interested in trying my experimental CHECKSTYLE feature.  You
use it by setting a register by that name when calling groff.  Roughly
speaking, increasing the value turns up the linting.

groff -man -rCHECKSTYLE=3Dn

where n is:
	1	Emits a warning if the argument count is wrong to TH or
		the six font style alternation macros.
	2	As 1, plus it complains of usage of deprecated macros
		(AT, UC, DT, PD).  And some day I'll be adding OP to
		that list.
	3	As 2, plus it complains of blank lines or lines with
		leading spaces.

Setting 1 has saved me from goofs prior to committing man page changes
many times already in its short life.  Setting 2 reminds me every day
that I need to fix up groff(7).  I don't usually provoke setting 3, but
it has proven its worth at least once.

The above is the most documentation this feature has yet seen, and I'd
appreciate feedback.

> > +.IP \(bu
> > +The mount must be a detached/anonymous mount,
> > +i.e. it must have been created by calling

"i.e." should be followed by a comma, just like "e.g.", as they
substitute for the English phrases "that is" and "for example",
respectively.

And, yes, I'd semantically line break after that comma, too.  ;-)

> > +.BR open_tree (2)
> > +with the
> > +.I OPEN_TREE_CLONE
> > +flag and it must not already have been visible in the filesystem.
> > +.RE
> > +.IP
>=20
> .IP here doesn't mean anything, if I'm not mistaken.

It certainly _should_--it should cause the insertion of vertical space.
(It would also cause a break, but .RE already did that.)

The interaction of .IP and .RS/.RE is tricky and can probably be blamed,
back in 2017, for irritating me to the point that I became a groff
developer.  I've documented it as extensively as I am able in
groff_man_style(7)[1].

> We don't want to format the ending period, as discussed in the linked
> thread.  Consider using .IR as explained there.  Maybe nonbreaking spaces=
 at
> some points of this sequence are also necessary.
>=20
> Nonbreaking spaces are \~
>=20
> You can see a discussion about nonbreaking spaces (of yesterday) here:
> <https://lore.kernel.org/linux-man/90d6fcc8-70e6-5c44-5703-1c2bf2ad6913@g=
mail.com/T/#u>

Thanks for reminding me--I need to get back to you with a suggested
patch.  I am so bad at preparing patches for the man-pages project.  :(

> > +.RE
> > +.RE
> > +.IP
>=20
> Another unused .IP?
>=20
> What did you mean?

Here's another point to consider.  Maybe he wants to preserve the
indentation amount "cached" by the last IP macro with such an argument.

   Horizontal and vertical spacing
       The indent argument accepted by .RS, .IP, .TP, and the deprecated
       .HP  is a number plus an optional scaling indicator.  If no scal=E2=
=80=90
       ing indicator is given, the man package assumes =E2=80=9Cn=E2=80=9D.=
  An indenta=E2=80=90
       tion  specified in a call to .IP, .TP, or the deprecated .HP per=E2=
=80=90
       sists until (1) another of these macros is  called  with  an  ex=E2=
=80=90
       plicit indent argument, or (2) .SH, .SS, or .P or its synonyms is
       called; these clear the indentation  entirely.   Relative  insets
       created  by  .RS move the left margin and persist until .RS, .RE,
       .SH, or .SS is called.

I realize the above text is pretty dense.  These matters were almost
undocumented in groff 1.22.3 and for many years before that.

> > +                exit_log("%m - Failed top open %s\n", optarg);
>=20
>=20
> Use \e to write the escape sequence in groff.  See groff_man(7):
>=20
>        \e     Widely used in man pages to  represent  a  backslash
>               output  glyph.  It works reliably as long as the .ec
>               request is not used, which should  never  happen  in
>               man pages, and it is slightly more portable than the
>               more exact =E2=80=98\(rs=E2=80=99  (=E2=80=9Creverse  solid=
us=E2=80=9D)  escape  se=E2=80=90
>               quence.
>=20
> \n is interpreted by groff(1) and not translated verbatim into the
> output.

Yes.  It interpolates a register named '"', in this case (which is a
valid roff identifier).  That's probably not defined, so groff will
define it automatically, assign zero to it, and then interpolated it. So
you'd end up with %s0.

I think it bears restating that code examples in man pages, whether set
with the .EX/.EE macros or otherwise, are not "literal" or
"preformatted" regions[1].  .EX does two things only: it disables
filling (which also necessarily disables automatic breaking, automatic
hyphenation, and adjustment), and it changes the font family for
typesetter devices (to Courier).  The escape character remains a
backslash and it remains fully armed and operational, as Emperor
Palpatine might say.

Regards,
Branden

[1] https://www.man7.org/linux/man-pages/man7/groff_man_style.7.html
[2] Long ago, in the 1970s, there was an ".li" (for "literal") request
    in Unix troff.  It was taken out even before Version 7 Unix was
    published.)


--sp3u4puormuxs4vs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEh3PWHWjjDgcrENwa0Z6cfXEmbc4FAmEEqpIACgkQ0Z6cfXEm
bc6/rg/+JrxkxoPplQGH/TjEazptNbG04Kt6n541bhVQNKSqefBpZuMHmCDPOMmV
3kBPYZouI5ROUpyX2ajfazANVRkC2+mmqm7l6XTQUK+mSPN+zOY4XIquOX55Nauu
pIaNu/a17t0oS2rES5rEDUV8AeQdR+YMPMv2U55cKikr3v7CbZ76L2u4R9/uJDzf
LAYbC9UVXiEiXTzL8clnENK4vOPrO7Lm2ZssVLf+++fRDL+zlw44rPFL2C7slxEo
1CnAsJe7Tt7tHYf2aQzX+wWzifmZ3hoMHFViXJp8/y536hBO6xj9zeJnFdMhFohw
Sab3KaDDrgq8qIYTQ885H/JDhWGZsBRuOShYGOTsBC4nxzzvYT2kviaDa6NfuBtt
mI5WM2NLYNGKxMWY5QzWo+bzPA0gGfFmupBZ4Js4GThFxPncwdCdJ9L54GdnHIvu
eb30+LvlTf3E38Zx1ppBx/I+R315GE5XvfnibK1wKMNRag49B/eN/iUl58B1SF7Q
uEeP8riYBeXZJnQBtnj2pwhnoOj4Bby41R0YYTV2PRfXVuvYoA1CjhA2ZmZ9dtNZ
m4q0j74/IZ0yGd/zwqERRv0e+FLihpXxHPkIiLDP3YN6HB79HZNFZAWZ1IVa/p67
tcapZSJUxT4DvV+XBiBODwu7M+QS0CdlseTFxquxKhrii3K+nbY=
=g3z5
-----END PGP SIGNATURE-----

--sp3u4puormuxs4vs--
