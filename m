Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D246C159DE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 01:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgBLAVS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 19:21:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:40864 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727985AbgBLAVS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 19:21:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2EA60AFF4;
        Wed, 12 Feb 2020 00:21:16 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Allison Collins <allison.henderson@oracle.com>,
        Dave Chinner <david@fromorbit.com>
Date:   Wed, 12 Feb 2020 11:21:06 +1100
Cc:     Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] FS Maintainers Don't Scale
In-Reply-To: <fc430471-54d2-bb44-d084-a37e7ff9ef50@oracle.com>
References: <20200131052520.GC6869@magnolia> <CAOQ4uxh=4DrH_dL3TULcFa+pGk0YhS=TobuGk_+Z0oRWvw63rg@mail.gmail.com> <8983ceaa-1fda-f9cc-73c9-8764d010d3e2@oracle.com> <20200202214620.GA20628@dread.disaster.area> <fc430471-54d2-bb44-d084-a37e7ff9ef50@oracle.com>
Message-ID: <87sgjg7j0t.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 09 2020, Allison Collins wrote:

> Well, I can see the response is meant to be encouraging, and you are=20
> right that everyone needs to give to receive :-)
>
> I have thought a lot about this, and I do have some opinions about it=20
> how the process is described to work vs how it ends up working though.=20
> There has quite been a few times I get conflicting reviews from multiple=
=20
> reviewers. I suspect either because reviewers are not seeing each others=
=20
> reviews, or because it is difficult for people to recall or even find=20
> discussions on prior revisions.  And so at times, I find myself puzzling=
=20
> a bit trying to extrapolate what the community as a whole really wants.

The "community as a whole" is not a person and does not have a coherent
opinion.  You will never please everyone and as you've suggested below,
it can be hard to tell how strongly people really hold the opinions they
reveal.

You need to give up trying to please "the community", but instead develop
your own sense of taste that aligns with the concrete practice of the
community, and then please yourself.

Then when someone criticizes your code, you need to decide for yourself
whether it is a useful criticism or not.  This might involve hunting
through the existing body of code to see what patterns are most common.
The end result is that either you defend your code, or you change your
opinion (both can be quite appropriate).  If you change your opinion,
then you probably change your code too.

Your goal isn't to ensure everyone is happy, only to ensure that no-one
is justifiably angry.

NeilBrown

>
> For example: a reviewer may propose a minor change, perhaps a style=20
> change, and as long as it's not terrible I assume this is just how=20
> people are used to seeing things implemented.  So I amend it, and in the=
=20
> next revision someone expresses that they dislike it and makes a=20
> different proposition.  Generally I'll mention that this change was=20
> requested, but if anyone feels particularly strongly about it, to please=
=20
> chime in.  Most of the time I don't hear anything, I suspect because=20
> either the first reviewer isn't around, or they don't have time to=20
> revisit it?  Maybe they weren't strongly opinionated about it to begin=20
> with?  It could have been they were feeling pressure to generate=20
> reviews, or maybe an employer is measuring their engagement?  In any=20
> case, if it goes around a third time, I'll usually start including links=
=20
> to prior reviews to try and get people on the same page, but most of the=
=20
> time I've found the result is that it just falls silent.
>
> At this point though it feels unclear to me if everyone is happy?  Did=20
> we have a constructive review?  Maybe it's not a very big deal and I=20
> should just move on.  And in many scenarios like the one above, the=20
> exact outcome appears to be of little concern to people in the greater=20
> scheme of things.  But this pattern does not always scale well in all=20
> cases.  Complex issues that persist over time generally do so because no=
=20
> one yet has a clear idea of what a correct solution even looks like, or=20
> perhaps cannot agree on one.  In my experience, getting people to come=20
> together on a common goal requires a sort of exploratory coding effort.=20
> Like a prototype that people can look at, learn from, share ideas, and=20
> then adapt the model from there.  But for that to work, they need to=20
> have been engaged with the history of it.  They need the common=20
> experience of seeing what has worked and what hasn't.  It helps people=20
> to let go of theories that have not performed well in practice, and=20
> shift to alternate approaches that have.  In a way, reviewers that have=20
> been historically more involved with a particular effort start to become=
=20
> a little integral to it as its reviewers.  Which I *think* is what=20
> Darrick may be eluding to in his initial proposition.  People request=20
> for certain reviewers, or perhaps the reviewers can volunteer to be sort=
=20
> of assigned to it in an effort to provide more constructive reviews.  In=
=20
> this way, reviewers allocate their efforts where they are most=20
> effective, and in doing so better distribute the work load as well.  Did=
=20
> I get that about right?  Thoughts?
>
> Allison

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl5DRPIACgkQOeye3VZi
gblS/w/9G22cXKdF3gAdoK7fIqVMQh+iHtqwgRsIC7TjyJYBcUTz2yUy/5Io+pc6
4hpYZu571QOF2rOBgUjS3MnWWfi+vpiBcV6LQm14ulvAFTKkdKYTCZx/3UV3acjX
xaInjDJ5LIrluvO2H3SW9NZ/SP5BhFpRoCIE29X9+Skjw2KtLJRvz1JbM3ab7Lpv
k0ZciQn9UIbB8B3bDI0LzqYGcj6F8euWClHWbi5ky+hVdxpMB5N6cFI027b6aMGZ
g1tje4SiHxTy5Y3w4eLaS9q+71NnP4meIc1MDtYAa1Ue5Jrel7Bp3wxl2wMMWj8r
gjEWzLyx9Jm7Yi85XDAqjk7mIC1pnHt3flEAvyk954cfE4DrSyDlA/pExJDmDiX5
rMgssFzTb0F+xVbq/NLgP+CD4n86gi+ZxAmk+rVRAVN2VtZOYKzNK7f3a5nrLzCI
bKoKnqGusPBRjalsF7ArVlrMvpefD5xWH4i9rkDXGVF0L2MDdmzL3z2R5vt5hnMy
xHzkyyFd9FnD3R4zWJuQq9wT5S1RaPk87vRiR8PMQYb7xZaJCYSw7+LSj1NcY98J
VJkKtdV09AAs4rWj55eQeiS7OhsNfju5l0DklkXL5a61xhHxRqDqF+xUWhA/4l3U
AthJTMTHomkB8NrKJGlRZE75p2bCCrzmmsp8rjt7lejcgGnkBsE=
=NQr4
-----END PGP SIGNATURE-----
--=-=-=--
