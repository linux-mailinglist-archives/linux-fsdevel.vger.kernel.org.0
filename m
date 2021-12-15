Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A537B47566C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Dec 2021 11:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241691AbhLOKbP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Dec 2021 05:31:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25314 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241683AbhLOKbP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:31:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639564274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VTGLyY6hDvfJisvSsGOM1bt/y1TKbXPdUsXzyZE3JvY=;
        b=TLQgF+6PMm/B11LECsMuIwRH6meWYcWsCYiLO3s1efEb+k1nyKVsuOjgE1hL8wI0GGzf7X
        HAi8t7tcUv/YIR0hJvGS1IadL7Z+OlondwIR/vw5ACExeo6PRmYo9lp+7w5z9fhgh5wEo8
        C8qa9WfX6X0k2lF/frtnZl+fASOIxBs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-0H-PkOtzNP--ID7Hz_26bg-1; Wed, 15 Dec 2021 05:31:11 -0500
X-MC-Unique: 0H-PkOtzNP--ID7Hz_26bg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C57EB760EB;
        Wed, 15 Dec 2021 10:31:08 +0000 (UTC)
Received: from localhost (unknown [10.39.195.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A249674EB5;
        Wed, 15 Dec 2021 10:30:52 +0000 (UTC)
Date:   Wed, 15 Dec 2021 10:30:50 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        device-mapper development <dm-devel@redhat.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 4/5] dax: remove the copy_from_iter and copy_to_iter
 methods
Message-ID: <YbnD2iDmN92Bure9@stefanha-x1.localdomain>
References: <20211209063828.18944-1-hch@lst.de>
 <20211209063828.18944-5-hch@lst.de>
 <YbNhPXBg7G/ridkV@redhat.com>
 <CAPcyv4g4_yFqDeS+pnAZOxcB=Ua+iArK5mqn0iMG4PX6oL=F_A@mail.gmail.com>
 <20211213082318.GB21462@lst.de>
 <YbiosqZoG8e6rDkj@redhat.com>
 <CAPcyv4hFjKsPrPTB4NtLHiY8gyaELz9+45N1OFj3hz+uJ=9JnA@mail.gmail.com>
 <Ybj/azxrUyU4PZEr@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fVCyKoqL/Gzi3K+T"
Content-Disposition: inline
In-Reply-To: <Ybj/azxrUyU4PZEr@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--fVCyKoqL/Gzi3K+T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 14, 2021 at 03:32:43PM -0500, Vivek Goyal wrote:
> On Tue, Dec 14, 2021 at 08:41:30AM -0800, Dan Williams wrote:
> > On Tue, Dec 14, 2021 at 6:23 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Mon, Dec 13, 2021 at 09:23:18AM +0100, Christoph Hellwig wrote:
> > > > On Sun, Dec 12, 2021 at 06:44:26AM -0800, Dan Williams wrote:
> > > > > On Fri, Dec 10, 2021 at 6:17 AM Vivek Goyal <vgoyal@redhat.com> w=
rote:
> > > > > > Going forward, I am wondering should virtiofs use flushcache ve=
rsion as
> > > > > > well. What if host filesystem is using DAX and mapping persiste=
nt memory
> > > > > > pfn directly into qemu address space. I have never tested that.
> > > > > >
> > > > > > Right now we are relying on applications to do fsync/msync on v=
irtiofs
> > > > > > for data persistence.
> > > > >
> > > > > This sounds like it would need coordination with a paravirtualized
> > > > > driver that can indicate whether the host side is pmem or not, li=
ke
> > > > > the virtio_pmem driver. However, if the guest sends any fsync/msy=
nc
> > > > > you would still need to go explicitly cache flush any dirty page
> > > > > because you can't necessarily trust that the guest did that alrea=
dy.
> > > >
> > > > Do we?  The application can't really know what backend it is on, so
> > > > it sounds like the current virtiofs implementation doesn't really, =
does it?
> > >
> > > Agreed that application does not know what backend it is on. So virti=
ofs
> > > just offers regular posix API where applications have to do fsync/msy=
nc
> > > for data persistence. No support for mmap(MAP_SYNC). We don't offer p=
ersistent
> > > memory programming model on virtiofs. That's not the expectation. DAX
> > > is used only to bypass guest page cache.
> > >
> > > With this assumption, I think we might not have to use flushcache ver=
sion
> > > at all even if shared filesystem is on persistent memory on host.
> > >
> > > - We mmap() host files into qemu address space. So any dax store in v=
irtiofs
> > >   should make corresponding pages dirty in page cache on host and when
> > >   and fsync()/msync() comes later, it should flush all the data to PM=
EM.
> > >
> > > - In case of file extending writes, virtiofs falls back to regular
> > >   FUSE_WRITE path (and not use DAX), and in that case host pmem driver
> > >   should make sure writes are flushed to pmem immediately.
> > >
> > > Are there any other path I am missing. If not, looks like we might not
> > > have to use flushcache version in virtiofs at all as long as we are n=
ot
> > > offering guest applications user space flushes and MAP_SYNC support.
> > >
> > > We still might have to use machine check safe variant though as loads
> > > might generate synchronous machine check. What's not clear to me is
> > > that if this MC safe variant should be used only in case of PMEM or
> > > should it be used in case of non-PMEM as well.
> >=20
> > It should be used on any memory address that can throw exception on
> > load, which is any physical address, in paths that can tolerate
> > memcpy() returning an error code, most I/O paths, and can tolerate
> > slower copy performance on older platforms that do not support MC
> > recovery with fast string operations, to date that's only PMEM users.
>=20
> Ok, So basically latest cpus can do fast string operations with MC
> recovery so that using MC safe variant is not a problem.
>=20
> Then there is range of cpus which can do MC recovery but do slower
> versions of memcpy and that's where the issue is.
>=20
> So if we knew that virtiofs dax window is backed by a pmem device
> then we should always use MC safe variant. Even if it means paying
> the price of slow version for the sake of correctness.=20
>=20
> But if we are not using pmem on host, then there is no point in
> using MC safe variant.
>=20
> IOW.
>=20
> 	if (virtiofs_backed_by_pmem) {
> 		use_mc_safe_version
> 	else
> 		use_non_mc_safe_version
> 	}
>=20
> Now question is, how do we know if virtiofs dax window is backed by
> a pmem or not. I checked virtio_pmem driver and that does not seem
> to communicate anything like that. It just communicates start of the
> range and size of range, nothing else.
>=20
> I don't have full handle on stack of modules of virtio_pmem, but my guess
> is it probably is using MC safe version always (because it does not
> know anthing about the backing storage).
>=20
> /me will definitely like to pay penalty of slower memcpy if virtiofs
> device is not backed by a pmem.

Reads from the page cache handle machine checks (filemap_read() ->
raw_copy_to_user()). I think virtiofs should therefore always handle
machine checks when reading from the DAX Window.

Stefan

--fVCyKoqL/Gzi3K+T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmG5w9oACgkQnKSrs4Gr
c8j4SQf/fNuEZjHQ7MgEmyQ7cl+ER5jQ4O1RsP/Y0hXNm9hU5bbbbeRF+BIcSsj7
cmU9GGe6McyCdpHBOjaUPbRJkEmwA3F6Sbr4c8xm8dL21fPP6TNJu/4gLXmI6+KY
kNihoEXb/lWXT8YQcngs3s1pkScfsZaxPnUo6m4E/dMLbxkikpIDqfQI9m6KzSUL
uqODFy0itv0pIKrN+OGweqx+UKBZ3DofuOzUUAGZRae/WENY7fRhVzPH359eDfXO
aDPOB9PFwnNxHYiNpQDgyhoOeG0B6+erdSDHzPcYvOoXWHbsaHKI854Ocg3i1sah
QCfMd4tH3XVaVS1cwnupcnXt9IFNmg==
=ySzP
-----END PGP SIGNATURE-----

--fVCyKoqL/Gzi3K+T--

