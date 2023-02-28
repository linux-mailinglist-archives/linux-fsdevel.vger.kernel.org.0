Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A73C6A5A76
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 14:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjB1N75 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 08:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjB1N74 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:59:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB2A1D93B
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 05:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677592749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yS2o7XZfIYuMoZTUmOUrhn8hRbT+X4gFkNVs7rGce/k=;
        b=QddlUT8H5b3f5tVWsCglnxYIOZRG4hDH/+iCAYHHE2Xg5GGizym1fbukEH18VLmpz0G3OE
        0zR+24SsWB4o3gZL2BeCkLIfHbS/nj6glfx9rgk9l4zZSUW6LkeCGODK3tTiC6ZywFFk2l
        xA6msN9asac6hc+yM79LbGhuySkguxc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21--gJQ9S0rOeqOPMpxsALabA-1; Tue, 28 Feb 2023 08:59:04 -0500
X-MC-Unique: -gJQ9S0rOeqOPMpxsALabA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32D87857D07;
        Tue, 28 Feb 2023 13:59:04 +0000 (UTC)
Received: from localhost (unknown [10.39.193.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 39167C15BAD;
        Tue, 28 Feb 2023 13:59:02 +0000 (UTC)
Date:   Tue, 28 Feb 2023 08:59:01 -0500
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
Cc:     Viacheslav Dubeyko <slava@dubeyko.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Luka Perkov <luka.perkov@sartura.hr>, bruno.banelli@sartura.hr
Subject: Re: [External] [RFC PATCH 00/76] SSDFS: flash-friendly LFS file
 system for ZNS SSD
Message-ID: <Y/4Ipfn7YkPoTjo2@fedora>
References: <Y/y182cYxNo3zJmb@fedora>
 <0237BC64-C920-4A63-B676-B2E972A5AF49@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zpFIYzVA9dg9nld7"
Content-Disposition: inline
In-Reply-To: <0237BC64-C920-4A63-B676-B2E972A5AF49@bytedance.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--zpFIYzVA9dg9nld7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2023 at 02:59:08PM -0800, Viacheslav A.Dubeyko wrote:
> > On Feb 27, 2023, at 5:53 AM, Stefan Hajnoczi <stefanha@redhat.com> wrot=
e:
> > These comparisions include file systems that don't support zoned devices
> > natively, maybe that's why IOPS comparisons cannot be made?
> >=20
>=20
> Performance comparison can be made for conventional SSD devices.
> Of course, ZNS SSD has some peculiarities (limited number of open/active
> zones, zone size, write pointer, strict append-only mode) and it requires
> fair comparison. Because, these peculiarities/restrictions can as help as
> make life more difficult. However, even if we can compare file systems for
> the same type of storage device, then various configuration options
> (logical block size, erase block size, segment size, and so on) or partic=
ular
> workload can significantly change a file system behavior. It=E2=80=99s al=
ways not so
> easy statement that this file system faster than another one.

I incorrectly assumed ssdfs was only for zoned devices.

>=20
> >> (3) decrease the write amplification factor compared with:
> >>    1.3x - 116x (ext4),
> >>    14x - 42x (xfs),
> >>    6x - 9x (btrfs),
> >>    1.5x - 50x (f2fs),
> >>    1.2x - 20x (nilfs2);
> >> (4) prolong SSD lifetime compared with:
> >=20
> > Is this measuring how many times blocks are erased? I guess this
> > measurement includes the background I/O from ssdfs migration and moving?
> >=20
>=20
> So, first of all, I need to explain the testing methodology. Testing incl=
uded:
> (1) create file (empty, 64 bytes, 16K, 100K), (2) update file, (3) delete=
 file.
> Every particular test-case is executed as multiple mount/unmount operatio=
ns
> sequence. For example, total number of file creation operations were 1000=
 and
> 10000, but one mount cycle included 10, 100, or 1000 file creation, file =
update,
> or file delete operations. Finally, file system must flush all dirty meta=
data and
> user data during unmount operation.
>=20
> The blktrace tool registers LBAs and size for every I/O request. These da=
ta are
> the basis for estimation how many erase blocks have been involved into
> operations. SSDFS volumes have been created by using 128KB, 512KB, and
> 8MB erase block sizes. So, I used these erase block sizes for estimation.
> Generally speaking, we can estimate the total number of erase blocks that
> were involved into file system operations for particular use-case by mean=
s of
> calculation of number of bytes of all I/O requests and division on erase =
block size.
> If file system uses in-place updates, then it is possible to estimate how=
 many times
> the same erase block (we know LBA numbers) has been completely re-written.
> For example, if erase block (starting from LBA #32) received 1310720 byte=
s of
> write I/O requests, then erase block of 128KB in size has been re-written=
 10x times.
> So, it means that FTL needs to store all these data into 10 X 128KB erase=
 blocks
> in the background or execute around 9 erase operation to keep the actual =
state
> of data into one 128KB erase block. So, this is the estimation of FTL GC =
responsibility.
>=20
> However, if we would like to estimate the total number of erase operation=
, then
> we need to take into account:
>=20
> E total =3D E(FTL GC) + E(TRIM) + E(FS GC) + E(read disturbance) + E(rete=
ntion)
>=20
> The estimation of erase operation on the basis of retention issue is tric=
ky and
> it shows negligibly small number for such short testing. So, we can ignor=
e it.
> However, retention issue is important factor of decreasing SSD lifetime.
> I executed the estimation of this factor and I made comparison for various
> file systems. But this factor is deeply depends on time, workload, and
> payload size. So, it=E2=80=99s really hard to share any stable and reason=
able numbers
> for this factor. Especially, it heavily depends on FTL implementation.
>=20
> It is possible to make estimation of read disturbance but, again, it heav=
ily
> depends on NAND flash type, organization, and FTL algorithms. Also, this
> estimation shows really small numbers that can be ignored for short testi=
ng.
> I=E2=80=99ve made this estimation and I can see that, currently, SSDFS ha=
s read-intensive
> nature because of offset translation table distribution policy. I am test=
ing the fix
> and I have hope to remove this issue.
>=20
> SSDFS has efficient TRIM/erase policy. So, I can see TRIM/erase operations
> even for such =E2=80=9Cshort" test-cases. As far as I can see, no other f=
ile system issues
> discard operations for the same test-cases. I included TRIM/erase operati=
ons
> into the calculation of total number of erase operations.
>=20
> Estimation of GC operations on FS side (F2FS, NILFS2) is the most specula=
tive one.
> I=E2=80=99ve made estimation of number of erase operations that FS GC can=
 generate.
> However, as far as I can see, even without taking into account the FS GC =
erase
> operations, SSDFS looks better compared with F2FS and NILFS2.
> I need to add here that SSDFS uses migration scheme and doesn=E2=80=99t n=
eed
> in classical GC. But even for such =E2=80=9Cshort=E2=80=9D test-cases mig=
ration scheme shows
> really efficient TRIM/erase policy.=20
>=20
> So, write amplification factor was estimated on the basis of write I/O re=
quests
> comparison. And SSD lifetime prolongation has been estimated and compared
> by using the model that I explained above. I hope I explained it's clear =
enough.
> Feel free to ask additional questions if I missed something.
>=20
> The measurement includes all operations (foreground and background) that
> file system initiates because of using mount/unmount model. However, migr=
ation
> scheme requires additional explanation. Generally speaking, migration sch=
eme
> doesn=E2=80=99t generate additional I/O requests. Oppositely, migration s=
cheme decreases
> number of I/O requests. It could be tricky to follow. SSDFS uses compress=
ion,
> delta-encoding, compaction scheme, and migration stimulation. It means th=
at
> reqular file system=E2=80=99s update operations are the main vehicle of m=
igration scheme.
> Let imagine that application updates 4KB logical block. It means that SSD=
FS
> tries to compress (or delta-encode) this piece of data. Let compression g=
ives us
> 1KB compressed piece of data (4KB uncompressed size). It means that we can
> place 1KB into 4KB memory page and we have 3KB free space. So, migration
> logic checks that exhausted (completely full) old erase block that receiv=
ed update
> operation has another valid block(s). If we have such valid logical block=
s, then
> we can compress this logical blocks and store it into free space of 4K me=
mory page.
> So, we can finally store 4 compressed logical blocks (1KB in size each), =
for example,
> into 4KB memory page. It means that SSDFS issues one I/O request for 4 lo=
gical
> blocks instead of 4 ones. I simplify the explanation, but idea remains th=
e same.
> I hope I clarified the point. Feel free to ask additional questions if I =
missed something.

Thanks for these explanations, that clarifies things!

Stefan

--zpFIYzVA9dg9nld7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmP+CKUACgkQnKSrs4Gr
c8j0jQf/SpvyGvKtjtTthp1HudkX22Ms4WhzPt5sA+TW9Mpu9Yn5xRpKRRvDMF4b
+Gg+XkPJBmi4JGE7dT2wrhMTFuxML6f5rj/2nR0NhRa+/KePvLK1NKhqzWyZlcw0
vUswVFq+YrOxTdQYcMIKVyKUPLrjrc38MViKYGHxDbtZfiVks+U2Zz9d4xFK0Arv
BFuU/fsUu9LDmqRVl5IVvVsO4F9B1UWkxlwe8q8qscleuHvXKseaQ2U5Qw5GZO6R
on1/X2qGGm9lJeSJSQvtDDMsmz3djZYZRwYBOhVozHcHkHTpLUw5nv2O+xa0Zgu9
6nJUn8Jja7GSj5B4JujWSDC2p9VTwQ==
=GR2e
-----END PGP SIGNATURE-----

--zpFIYzVA9dg9nld7--

