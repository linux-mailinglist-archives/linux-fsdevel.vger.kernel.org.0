Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB47446CE7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Nov 2021 08:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbhKFHpb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Nov 2021 03:45:31 -0400
Received: from mout.web.de ([212.227.15.3]:45047 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232984AbhKFHpa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Nov 2021 03:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1636184519;
        bh=35PqTHwkplKaAMFgJ59LBZT6nBoDV7pVOc0kXy1wcE4=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=hVUNW1tQiNx771U8H6Zl+ST9Xd6253El3iM4FMbShqjJayQ9/TGU2fvbEtXHB3lwN
         4yxU10Iz6Q537A4Xg/OeTEshNimxYSO/D1mpcmcV53oKx1MJwdxevUpM/HAaSJgpdm
         B8yz+5Ej4tJUBokPgXJnbbLkHNoMMkrd7olTzKg8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from gecko ([46.223.150.38]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mt8gP-1mULqo15JZ-00t62y; Sat, 06
 Nov 2021 08:41:59 +0100
Date:   Sat, 6 Nov 2021 07:41:46 +0000
From:   Lukas Straub <lukasstraub2@web.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [dm-devel] [PATCH 0/6] dax poison recovery with
 RWF_RECOVERY_DATA flag
Message-ID: <20211106074146.04fc36a3@gecko>
In-Reply-To: <CAPcyv4hK18DetEf9+NcDqM5y07Vp-=nhysHJ3JSnKbS-ET2ppw@mail.gmail.com>
References: <20211021001059.438843-1-jane.chu@oracle.com>
        <YXFPfEGjoUaajjL4@infradead.org>
        <e89a2b17-3f03-a43e-e0b9-5d2693c3b089@oracle.com>
        <YXJN4s1HC/Y+KKg1@infradead.org>
        <2102a2e6-c543-2557-28a2-8b0bdc470855@oracle.com>
        <YXj2lwrxRxHdr4hb@infradead.org>
        <CAPcyv4hK18DetEf9+NcDqM5y07Vp-=nhysHJ3JSnKbS-ET2ppw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bO7uynQmFI27w4fHadpypym";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Provags-ID: V03:K1:cgcmyG78PhSL4Zie9BD7YaHQeP9628H6KkHtTzOyZ3i+4wJ78J8
 CVAakX/Hc4C9zy9aH/Eq8qbaCUlHAY2KwCknO/3N/XooBP+bO/4K17nL8q0WJP1pkOkqsCP
 jh9EK9kbxryW4SXw8vfZDLkigyiu/hBiE6JIywmP5F8tybHoYhl44p35REdmELfp6rsLju9
 sVkrHjhk2SSXrVs4bD1Nw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3jg3S52G6Ls=:KZ/BQIYeNXHQyZaVHYZNDB
 B5o/Z0BjkCtnLyzMtrG+NcmAszVdyyAosulkAUdu4Do4gsSJh9lRjWn/3tRcyuZ4FmRHwBes1
 VeFyVj4IyV6zUVQWOQRQwpzdRy98RuAm7s6JQhvihtoi+CQoUZBWqk9Q1Ypyo/A+GR5n8MC3T
 4grzXiMQnLzTrzJQ4JMlLVunwJUWhxPyCJox8+IcPldKZS1c2U20kH6YIyI6MhSsfu/hw8U9h
 3VSNvOQ/cxlFmILkzI4fD5NL9t2DizamADv/OaO92O+r6CikqJt0wnpVYJEgHxkME9XTf9cO4
 9Z21nom30FlZobIA01gNwtd2GL5sSeHRR0s1BG2D5exluAEKff7oSPddtNHlsrORpgGcxAXBT
 uB50bLam07jDZJ4w4bFr4b8ohC+dCOW31pv/nIX/Bk1inW3S4A8uLw2nkxAaap0mwzwBZCeWe
 ZomO1a3f3L92XqLahjS+3Q12ilZJGqSPX/10zrRIOtNwsyBIIfOUUF3Ef6cQ1iOdY5esxGsEl
 u8pA+SuekdzaQkBIchREbIBECK3MkXVsQYkC93IH3eabXffZjWh4HfpvDD7zz6V7Hud2BZcyz
 y5n0EA4zLgYm1Yw/V3sIqKuA+bZbS9FIYRmgPqOxe2HF8WFmh3fVVysfjJ4SGC4+Pyko2Cf5E
 Js5FG/rqlGtSTm9U2608S7B8whCVz/Xqjwjd/F4AiO7Guea//5+zTOb1FDg2x8wZRuSxsLLo6
 V7ZxBC7AqYTo0dM9JqPqbs/6ufYYLw0vsn8A5ho+7yFbp3fD1xtmnSORDw31NQb0CTgKDc2wk
 Hg0RKjtVQdSOg+TdbAequyhsmRK/t5bpjebHiUTGgqDY1e2vU4HcLFOqCvk7clZRmNHtgG+1l
 tyia4dsjvzGaruXdyzGPKhRG9n2y3iiud/TBrSRYXQjEeYBKy3iv7jmxCvep2rdJFvaZ2n6eQ
 iCOljTjv4fx1RcM0C035/k53amXizMqMlWt7jbQvxOv02mIsqg1/dR25V6SkvKR2z+/Kk6T7P
 sS+D0fkkgGKiTt4nPP5+2lRGUjccZTomgJWrVczSnR2AZQAhLOxvNRkbzRMD/l7pDrHSfHfGB
 Gbf7+NMYq2J8R8=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/bO7uynQmFI27w4fHadpypym
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Nov 2021 09:03:55 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Tue, Oct 26, 2021 at 11:50 PM Christoph Hellwig <hch@infradead.org> wr=
ote:
> >
> > On Fri, Oct 22, 2021 at 08:52:55PM +0000, Jane Chu wrote: =20
> > > Thanks - I try to be honest.  As far as I can tell, the argument
> > > about the flag is a philosophical argument between two views.
> > > One view assumes design based on perfect hardware, and media error
> > > belongs to the category of brokenness. Another view sees media
> > > error as a build-in hardware component and make design to include
> > > dealing with such errors. =20
> >
> > No, I don't think so.  Bit errors do happen in all media, which is
> > why devices are built to handle them.  It is just the Intel-style
> > pmem interface to handle them which is completely broken. =20
>=20
> No, any media can report checksum / parity errors. NVME also seems to
> do a poor job with multi-bit ECC errors consumed from DRAM. There is
> nothing "pmem" or "Intel" specific here.
>=20
> > > errors in mind from start.  I guess I'm trying to articulate why
> > > it is acceptable to include the RWF_DATA_RECOVERY flag to the
> > > existing RWF_ flags. - this way, pwritev2 remain fast on fast path,
> > > and its slow path (w/ error clearing) is faster than other alternativ=
e.
> > > Other alternative being 1 system call to clear the poison, and
> > > another system call to run the fast pwrite for recovery, what
> > > happens if something happened in between? =20
> >
> > Well, my point is doing recovery from bit errors is by definition not
> > the fast path.  Which is why I'd rather keep it away from the pmem
> > read/write fast path, which also happens to be the (much more important)
> > non-pmem read/write path. =20
>=20
> I would expect this interface to be useful outside of pmem as a
> "failfast" or "try harder to recover" flag for reading over media
> errors.

Yeah, I think this flag could also be useful for non-raid btrfs.

If you have an extend that is shared between multiple snapshots and
it's data is corrupted (without the disk returning an i/o error), btrfs
won't be able to fix the corruption without raid and will always return
an i/o error when accessing the affected range (due to checksum
mismatch).

Of course you could just overwrite the range in the file with good
data, but that would only fix the file you are operating on, snapshots
will still reference the corrupted data.

With this flag, a read could just return the corrupted data without i/o
error and a write could write directly to the on-disk data to fixup the
corruption everywhere. btrfs could also check that the newly written
data actually matches the checksum.
However, in this btrfs usecase the process still needs to be
CAP_SYS_ADMIN or similar, since it's easy to create collisions for
crc32 and so an attacker could write to a file that he has no
permissions for, if that file shares an extend with one where he has
write permissions.

Regards,
Lukas Straub
--=20


--Sig_/bO7uynQmFI27w4fHadpypym
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmGGMboACgkQNasLKJxd
slh+lRAAmqlkYqSnahrbcMNcIf/3kQ4uICysOb5Of52uTw3AE5Zg5scO4Znz1I4i
C9VdaWeKGFRS80+qPZG4yl7RKXhJncImtTa58DIZH600g2Y9ZKezU/n3fT3Ucqt0
Qer/iVBgFfx7Gg4W5ecdAGoA9yvyftTlKrPYwjB2NJxEBx+jlJW7uFpFeNUCn8KE
mi06wFpQE2AgvXzLwkemXopL1IX/MNJLZlnayfRuaUuC98WCbhNdUfHb57NyJge9
iaHXtYeIoq8F8z/nCiV5lxjSbxXmG3Kjf/7/GhomNfKe4inPSNdg0+Z2rPpyXQ9s
Svfo62cr0hpLQXe8rrtd6gGQ/Ya58xpc3Ty8+n5uvJbDqE+OXWbJJn/K2q/sEZS4
RNMqhIj781hbQ3jjTOfZhgEkUDw3H3RZziGSPLWUvYLN2YSxtzi97x/ECPZ6ZMEa
HlamKMVDk6jOcbYGcn4wJw9QME8AWfezsOD32bE96iLO3zSFPAf1kv3k+rPZNDIB
OviD9ZIz8gunPk/Zb9rycvLyKgkMF1iGo7sCl9PQiPnEb/xuCfsRQut2DD3YQLFO
b9sbSP7ETTQ5YeTTm3SKl1X+6PBl4Jdhm7KhPEwhGJzuh3UQqHbrEns1EIlmDXhE
GVpiyzVzqx65VlNc78VMwO6qyrWuqf0VKV5EObIFQ5v0oXjKXgw=
=PyLM
-----END PGP SIGNATURE-----

--Sig_/bO7uynQmFI27w4fHadpypym--
