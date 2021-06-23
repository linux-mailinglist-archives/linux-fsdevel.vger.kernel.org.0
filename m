Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A4D3B1C9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 16:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhFWOgj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 10:36:39 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:37589 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbhFWOgg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 10:36:36 -0400
Received: by mail-wr1-f44.google.com with SMTP id i94so2921762wri.4;
        Wed, 23 Jun 2021 07:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=t9ttJ2ZrLwy0q/QbIgPH6+Htg9t3ZYSa1V/VtaQWwd8=;
        b=aFhZJbnL3wOBwTJ62+5IgFAc0xIUXsKnBpkRp7h9v07l2BTCH8WqhsqAW068OwHSha
         VvgHKSJN6+hchxWp6y/D9eXHPb/AEds9ebsQPpqxbO/2VTPRKt4dHv7pFUtMkAUdrqoA
         YyWDdbiH06jU+7cHJUkxFnquJhDlfQ3Hv2KKS/rSw1XZjvDwJJVDVSBozmn9rix1Dcd3
         tIl7aotMuRLtCRJiV57oYvSFgm9zlgE96WLmBXaVQOp5zsHLfze6j/ulfcaqX6/tsQpg
         KAyIjRRMNLf5+d4n3VPZ3I3peyJkC7tSHCMhu5YybriUdq4edBSOrvyb5Do2YchPz1Oj
         A0eQ==
X-Gm-Message-State: AOAM530kACEFnO74Mfq6xHtidhrYF8Ir2AL6D8ggUOvX4XOa0tpzgbSJ
        WO3N0p5kVLCFf6wCNOMTRe8=
X-Google-Smtp-Source: ABdhPJyWwqE2gvKTPTT7XT+OMwf74pBOeNBmjae0LqaHNaYDYTEEp/dKPKrY+4kaQbQgzTDg8d8NgA==
X-Received: by 2002:a5d:69c3:: with SMTP id s3mr352230wrw.235.1624458857074;
        Wed, 23 Jun 2021 07:34:17 -0700 (PDT)
Received: from localhost ([137.220.125.106])
        by smtp.gmail.com with ESMTPSA id p15sm105021wmq.43.2021.06.23.07.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 07:34:16 -0700 (PDT)
Message-ID: <930262b2c8cfcdad9d5987956e47ffb467407a41.camel@debian.org>
Subject: Re: [PATCH v3 1/6] block: add disk sequence number
From:   Luca Boccassi <bluca@debian.org>
To:     Hannes Reinecke <hare@suse.de>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Matteo Croce <mcroce@linux.microsoft.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        Javier Gonz??lez <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Matthew Wilcox <willy@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
Date:   Wed, 23 Jun 2021 15:34:14 +0100
In-Reply-To: <f84cab19-fb5c-634b-d1ca-51404907a623@suse.de>
References: <20210623105858.6978-1-mcroce@linux.microsoft.com>
         <20210623105858.6978-2-mcroce@linux.microsoft.com>
         <YNMffBWvs/Fz2ptK@infradead.org>
         <CAFnufp1gdag0rGQ8K4_2oB6_aC+EZgfgwd2eL4-AxpG0mK+_qQ@mail.gmail.com>
         <YNM8T44v5FTViVWM@gardel-login>
         <3be63d9f-d8eb-7657-86dc-8d57187e5940@suse.de>
         <1b55bc67b75e5cf982c0c1e8f45096f2eb6e8590.camel@debian.org>
         <f84cab19-fb5c-634b-d1ca-51404907a623@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-o7/lWMrV0LFXxCA7rbiC"
User-Agent: Evolution 3.30.5-1.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-o7/lWMrV0LFXxCA7rbiC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-06-23 at 16:21 +0200, Hannes Reinecke wrote:
> On 6/23/21 4:07 PM, Luca Boccassi wrote:
> > On Wed, 2021-06-23 at 16:01 +0200, Hannes Reinecke wrote:
> > > On 6/23/21 3:51 PM, Lennart Poettering wrote:
> > > > On Mi, 23.06.21 15:10, Matteo Croce (mcroce@linux.microsoft.com) wr=
ote:
> > > >=20
> > > > > On Wed, Jun 23, 2021 at 1:49 PM Christoph Hellwig <hch@infradead.=
org> wrote:
> > > > > > On Wed, Jun 23, 2021 at 12:58:53PM +0200, Matteo Croce wrote:
> > > > > > > +void inc_diskseq(struct gendisk *disk)
> > > > > > > +{
> > > > > > > +     static atomic64_t diskseq;
> > > > > >=20
> > > > > > Please don't hide file scope variables in functions.
> > > > > >=20
> > > > >=20
> > > > > I just didn't want to clobber that file namespace, as that is the=
 only
> > > > > point where it's used.
> > > > >=20
> > > > > > Can you explain a little more why we need a global sequence cou=
nt vs
> > > > > > a per-disk one here?
> > > > >=20
> > > > > The point of the whole series is to have an unique sequence numbe=
r for
> > > > > all the disks.
> > > > > Events can arrive to the userspace delayed or out-of-order, so th=
is
> > > > > helps to correlate events to the disk.
> > > > > It might seem strange, but there isn't a way to do this yet, so I=
 come
> > > > > up with a global, monotonically incrementing number.
> > > >=20
> > > > To extend on this and given an example why the *global* sequence nu=
mber
> > > > matters:
> > > >=20
> > > > Consider you plug in a USB storage key, and it gets named
> > > > /dev/sda. You unplug it, the kernel structures for that device all
> > > > disappear. Then you plug in a different USB storage key, and since
> > > > it's the only one it will too be called /dev/sda.
> > > >=20
> > > > With the global sequence number we can still distinguish these two
> > > > devices even though otherwise they can look pretty much identical. =
If
> > > > we had per-device counters then this would fall flat because the
> > > > counter would be flushed out when the device disappears and when a =
device
> > > > reappears under the same generic name we couldn't assign it a
> > > > different sequence number than before.
> > > >=20
> > > > Thus: a global instead of local sequence number counter is absolute=
ly
> > > > *key* for the problem this is supposed to solve
> > > >=20
> > > Well ... except that you'll need to keep track of the numbers (otherw=
ise
> > > you wouldn't know if the numbers changed, right?).
> > > And if you keep track of the numbers you probably will have to implem=
ent
> > > an uevent listener to get the events in time.
> > > But if you have an uevent listener you will also get the add/remove
> > > events for these devices.
> > > And if you get add and remove events you can as well implement sequen=
ce
> > > numbers in your application, seeing that you have all information
> > > allowing you to do so.
> > > So why burden the kernel with it?
> > >=20
> > > Cheers,
> > >=20
> > > Hannes
> >=20
> > Hi,
> >=20
> > We need this so that we can reliably correlate events to instances of a
> > device. Events alone cannot solve this problem, because events _are_
> > the problem.
> >=20
> In which sense?
> Yes, events can be delayed (if you list to uevents), but if you listen=
=20
> to kernel events there shouldn't be a delay, right?
>=20
> Cheers,
>=20
> Hannes

Hi,

Userspace programs don't have exclusive usage rights on loopdev, so you
can't reliably know if an uevent correlates to the loop0 you just
added, or to the loop0 someone else added some time earlier. This
series lets us do just that, reliably, without races, and fix long-
standing bugs. Please see Lennart's reply, it has much more details.
Thanks!

--=20
Kind regards,
Luca Boccassi

--=-o7/lWMrV0LFXxCA7rbiC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCSqx93EIPGOymuRKGv37813JB4FAmDTRmYACgkQKGv37813
JB6ENhAA0QXt64CgCUDkJjsx0CBs9KoUiwIaFjycEUhpwNGOwOhWqobaw7vrzdf9
ddXH0JKTvtqVmO/EIHAW1xa+L4IAzlZYvGeSC5K9PFM9SGwPM45q/R7Zb6gliASx
j+uM234I01ZfwMQuogSL4VabUAweIdDZWfWABBno2FlHCzwZx3afAXBIOTaq0E41
K7tbmEVgVlBID7ragZYTPkQOvEUCKdMnRqUr3q6qA8OELHiqgYXbopMhUZrt9col
mwt7yh8LXysjBWDKArw+pzpsWT4E4q+/cY9rdK9znXkWlhlFXBcSamPnwWWjKxuI
GIRgb7PaOKKnAduFVrvr/tvWEx4WAy9OOylKG20lO7dTJ/HONHOfezMRkiqHbLtQ
dleWMKyuUkNtql2vyt9s+Zo8ndORslIDjnOpTflDhsUPPRVwuGf8S3EjCLfS30mt
n0mlC9bASBruslhrXviVbJMcFGyuMpE9jXqNgkvr/uhfhp47ze9ia0eHYxG0V1uV
oKYWrvYhMM9c1IdoMcIBPScvT5MDRXV7QWNeIoUqYa3EBVjnfZ96CKMjYUsjSvRl
ixF6eBvIlVBvs82r0/Hs3ef0qRZ0lysSWn/MYzV5pMXvvmGqAuzSH3UbJ4CuGoIv
2/L2dMrnDIZMcX4qRpq1k4QYiwcA/nCIUX2k6qlrbfe+TLcAhaw=
=aprY
-----END PGP SIGNATURE-----

--=-o7/lWMrV0LFXxCA7rbiC--
