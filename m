Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15AA73B1DAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 17:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhFWPhJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 11:37:09 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:42881 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWPhI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 11:37:08 -0400
Received: by mail-wr1-f43.google.com with SMTP id j1so3134198wrn.9;
        Wed, 23 Jun 2021 08:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=ueYLv5nLA5m/ch9hOCe6RtvzN0ZpwJGvYz9XF9zrIHI=;
        b=QLrNN81rsqdHQHAOIzirm1TnNDxwY1VFAbd9IzqBJ9OBR7XgVKakaKtLu1l9Vok22U
         GpkRJXrLiCWJJ3ISQcqbELYnosyszXl15O/esjo14I7cF0DjMPZsZE3oR40yKcWccmXs
         jFTK8MMU+wa2M7FEvFLvy2nmcvVjmHhyS5w1Lh4ew6+zjIxBxw71Z2r1xLVSO3J0cxfG
         JFQRCe6opyVDm59QjFFHCeGQP0U5GWFE72e3wE+Ut+HL/ACUQXjqNNlMTvaARfRD06hE
         IeQ/lsklGgTtpk/nkaVd1eeFls3P84WkQV1ZTA6femhv6/60Z87Y63V+UdesDF5B6Iy6
         wPdw==
X-Gm-Message-State: AOAM531UQnvlOtuo3szZTQFWJgKKL7fhFqa0Jr66dtmgoMYZrxSKzJbY
        WPkqNrZY4DA9hMBtGv4ReaI=
X-Google-Smtp-Source: ABdhPJwveizYytFM63ffpYlgxz3m0k/Ae3ubo7hU8BB6arwFs/cq8Fmvsdo3hESjFHnqddCHOQawvg==
X-Received: by 2002:adf:f706:: with SMTP id r6mr725255wrp.280.1624462489975;
        Wed, 23 Jun 2021 08:34:49 -0700 (PDT)
Received: from localhost ([137.220.125.106])
        by smtp.gmail.com with ESMTPSA id p8sm6312514wmi.46.2021.06.23.08.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 08:34:48 -0700 (PDT)
Message-ID: <5f95e9835aa751b699f7d196121e3974697661f4.camel@debian.org>
Subject: Re: [PATCH v3 1/6] block: add disk sequence number
From:   Luca Boccassi <bluca@debian.org>
To:     Hannes Reinecke <hare@suse.de>,
        Lennart Poettering <mzxreary@0pointer.de>
Cc:     Matteo Croce <mcroce@linux.microsoft.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tejun Heo <tj@kernel.org>,
        Javier Gonz??lez <javier@javigon.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Matthew Wilcox <willy@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>
Date:   Wed, 23 Jun 2021 16:34:47 +0100
In-Reply-To: <adeedcd2-15a7-0655-3b3c-85eec719ed37@suse.de>
References: <20210623105858.6978-1-mcroce@linux.microsoft.com>
         <20210623105858.6978-2-mcroce@linux.microsoft.com>
         <YNMffBWvs/Fz2ptK@infradead.org>
         <CAFnufp1gdag0rGQ8K4_2oB6_aC+EZgfgwd2eL4-AxpG0mK+_qQ@mail.gmail.com>
         <YNM8T44v5FTViVWM@gardel-login>
         <3be63d9f-d8eb-7657-86dc-8d57187e5940@suse.de>
         <YNNBOyUiztf2wxDu@gardel-login>
         <adeedcd2-15a7-0655-3b3c-85eec719ed37@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-ElLXLc/LDOyeO5Wy5bf1"
User-Agent: Evolution 3.30.5-1.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-ElLXLc/LDOyeO5Wy5bf1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-06-23 at 17:02 +0200, Hannes Reinecke wrote:
> On 6/23/21 4:12 PM, Lennart Poettering wrote:
> > On Mi, 23.06.21 16:01, Hannes Reinecke (hare@suse.de) wrote:
> >=20
> > > > Thus: a global instead of local sequence number counter is absolute=
ly
> > > > *key* for the problem this is supposed to solve
> > > >=20
> > > Well ... except that you'll need to keep track of the numbers (otherw=
ise you
> > > wouldn't know if the numbers changed, right?).
> > > And if you keep track of the numbers you probably will have to implem=
ent an
> > > uevent listener to get the events in time.
> >=20
> > Hmm? This is backwards. The goal here is to be able to safely match up
> > uevents to specific uses of a block device, given that block device
> > names are agressively recycled.
> >=20
> > you imply it was easy to know which device use a uevent belongs
> > to. But that's the problem: it is not possible to do so safely. if i
> > see a uevent for a block device "loop0" I cannot tell if it was from
> > my own use of the device or for some previous user of it.
> >=20
> > And that's what we'd like to see fixed: i.e. we query the block device
> > for the seqeno now used and then we can use that to filter the uevents
> > and ignore the ones that do not carry the same sequence number as we
> > got assigned for our user.
> >=20
>=20
> It is notoriously tricky to monitor the intended use-case for kernel=20
> devices, precisely because we do _not_ attach any additional information=
=20
> to it.
> I have send a proposal for LSF to implement block-namespaces, the prime=
=20
> use-case of which is indeed attaching cgroup/namespace information to=20
> block devices such that we _can_ match (block) devices to specific contex=
ts.

Having namespaces for block devices would be an awesome feature, very
much looking forward to have that, as it solves a number of other
issues we have.
And while it could maybe be used in some instances of this particular
problem, unfortunately I don't think it can solve all of them - in some
real cases, we have to work in the root namespace as we are setting
things up for it.

> Which I rather prefer than adding sequence numbers to block devices;=20
> incidentally you could solve the same problem by _not_ reusing numbers=
=20
> aggressively but rather allocate the next free one after the most=20
> recently allocated one.
> Will give you much the same thing without having to burden others with it=
.

If I understood this right, you are proposing to move the
monothonically increasing sequence id to the device name, rather than
as internal metadata? So that, eg, loop0 gets used exactly once and
never again, and so on? Wouldn't that be a much more visible and
disruptive change, potentially backward incompatible and breaking
userspace left and right?

> The better alternative here would be to extend the loop ioctl to pass in=
=20
> an UUID when allocating the device.
> That way you can easily figure out whether the loop device has been=20
> modified.

A UUID solves the problem we are currently talking about. But a
monothonically increasing sequence number has additional great
properties compared to a UUID, that we very much want to make use of
(again these are all _real_ use cases), and were described  in detail
here:

https://lore.kernel.org/linux-fsdevel/20210315201331.GA2577561@casper.infra=
dead.org/t/#m3b1ffdffcc70a7c3ef4d7f13d0c2d5b9e4dde35a

> But in the end, it's the loop driver and I'm not particular bothered=20
> with it. I am, though, if you need to touch all drivers just to support=
=20
> one particular use-case in one particular device driver.
>=20
> Incidentally, we don't have this problem in SCSI as we _can_ identify=20
> devices here. So in the end we couldn't care less on which /dev/sdX=20
> device it ends up.
> And I guess that's what we should attempt for loop devices, too.

Sorry, I'm not sure what you mean here by "touch all drivers"? This
series changes only drivers/block/loop.c, no other device drivers code
is touched?

--=20
Kind regards,
Luca Boccassi

--=-ElLXLc/LDOyeO5Wy5bf1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCSqx93EIPGOymuRKGv37813JB4FAmDTVJcACgkQKGv37813
JB5/JBAAllM8bwVm3gOpA4BZDcQXp5SNxFZCgqiUBOCgXYJy2kOnsWEN3DVxojuk
LTdPBttBWxj1hkMRs/YdrhF588navYLaFwvVyNK64dqw1vjdee68Als/KRd16A3R
v0FGFR/ycOtMfkVOhhinovrf+WFgax6XjmqGzW6uU5PEWexqMEsMUbUsG33AolUg
kygSTVS6rBizWyy+swqr0WOEoZg2d1PDN4nuC8tpDuxlsvVseeEjYoxvUuNHkaqb
MebrCCtZYZXd10LBQ8MLVkM7bvK7cCe1YrclAjI0wEvMQzXjXyHrz28KLMgLOwcX
lOa8uqAvFJX4LSN7nQIePGO7+ys1l05/pI5ZlgH8oc8BgpM9jXE3mcAKdYAmbgaD
62AV4a6NU1jMp8IKmWcoErssEdy+jqcueqPBxCP66xJ9G64tO9ZLbIFb6uo5EGUT
CezkEUQvj9OCKI63QblaVKX6qXWNkacKAP1RtiOC4S57Wm0/RoJ0TFpEvRNOb87M
PwgQ/OYryFIlrBDVvpCQQjOwW31rTMf6KGqWct2EfXsTQJZw8/s8AtAqRfC3Pk4i
l8e29s6PhsRjeB8uIjoaljF4VdeVLePpVMhw9uYPChEoh4oLBy7UX7YIVNFf1xTo
dx8wQRd1W8dCzq9l9k3oUTftWJeYgmsBwvCNmrrjcIxtUNX4c3Y=
=dzQ+
-----END PGP SIGNATURE-----

--=-ElLXLc/LDOyeO5Wy5bf1--
