Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92542696ED5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 22:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjBNVFU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 16:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBNVFT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:05:19 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFCE109
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 13:05:15 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230214210511euoutp01fa2d672924de618b84f0d1358187729c~DzNc2xpRa1070910709euoutp01T;
        Tue, 14 Feb 2023 21:05:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230214210511euoutp01fa2d672924de618b84f0d1358187729c~DzNc2xpRa1070910709euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676408711;
        bh=zfOXJZDssYSqU7mbgPCy5M7HrPeEH8NY42m/LZlrITg=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=konuYeqQyvVh9cwdj8nkuC4yiNY2hHpSb3lUXPS3fqPTMOlJekKLjD01EAZaXq7Pe
         pBvIYrWy0WzpKMdlaoDolbXerTKUeriPd8ob0lmlIAtoF5OhD+cU1FWVOAmT4mzMn7
         cfJGaqK4FlsuZNuQE9zDIsioZkh6oZYEYw7k3fs8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230214210510eucas1p1c0634bf437d02ebd3a7cc1022d41701d~DzNb_H2KF1696416964eucas1p1R;
        Tue, 14 Feb 2023 21:05:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 89.0B.13597.587FBE36; Tue, 14
        Feb 2023 21:05:09 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230214210509eucas1p1536bedbc8dd0e6d1872eb255ccc5b395~DzNbYd2lW1696516965eucas1p1A;
        Tue, 14 Feb 2023 21:05:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230214210509eusmtrp24830c50bb2a6fddaff97b38d6b21ba8f~DzNbXvUTj0571805718eusmtrp2U;
        Tue, 14 Feb 2023 21:05:09 +0000 (GMT)
X-AuditID: cbfec7f4-207ff7000000351d-06-63ebf785e7fa
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A3.C4.00518.587FBE36; Tue, 14
        Feb 2023 21:05:09 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230214210509eusmtip1dc50e1eeb15de3fa5414cce79d91b764~DzNbFYnf-2229022290eusmtip1e;
        Tue, 14 Feb 2023 21:05:09 +0000 (GMT)
Received: from localhost (106.210.248.29) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 14 Feb 2023 21:05:07 +0000
Date:   Tue, 14 Feb 2023 22:05:06 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     Hans Holmberg <hans@owltronix.com>
CC:     Adam Manzanares <a.manzanares@samsung.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Dennis Maisenbacher <dennis.maisenbacher@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        =?utf-8?Q?J=C3=B8rgen?= Hansen <Jorgen.Hansen@wdc.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "javier@javigon.com" <javier@javigon.com>,
        "hch@lst.de" <hch@lst.de>,
        "guokuankuan@bytedance.com" <guokuankuan@bytedance.com>,
        "viacheslav.dubeyko@bytedance.com" <viacheslav.dubeyko@bytedance.com>
Subject: Re: [LSF/MM/BPF TOPIC]: File system data placement for zoned block
 devices
Message-ID: <20230214210506.c3ck6ab2hi2rldsf@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="ybf3t4ljvnodfwet"
Content-Disposition: inline
In-Reply-To: <CANr-nt0wVphKW1LXhmw3CgtJ5qRKYWkTy=Xg9Ey-39OnwvxnHA@mail.gmail.com>
X-Originating-IP: [106.210.248.29]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2VSfVCTdRz397zxbPXow7DjF3a9zKBODBPifLySyOvqKbsu7+ZxWWdOeGAE
        G2sPEIae0w7cRoeTE3bMOAgLjOFY4yXcsJQabKjlHYjQPImXBcmwAoflBeb2s8u7/vt8Py/f
        l9/9aFxmpOLoXE2hoNMo8+WUlOjq++uHZ8puzWY+e611M1c7+Cfgyg4vYlyDJ4BzB8cOYpw5
        6Ini6qptJPelzYNxU21WnDOev4RxS6ZrGFdpnsS5v8c3cj1nfARnLg/h3Ig5ALij/e0kZ3AE
        QXo0v+xtpfiPG64SvLPFSPHuUT3Ff+dsJHlz+1ckv+B8lD98tgJ7i94pfSFLyM8tFnQb0nZL
        VcFFN6m9kVUyUS/TgyqFCUhoyD4HHSO3o0xASsvYkwDOfnsOoOImgKZvXBgqFgD0uH2kCdCR
        iCG4E/HNALqaTES4VcRk+fwVJHQAaJh0EOEAwcZDvf/tsIdi18Mfg1fxMF7NJsCLM4bIAJzt
        peDtahcVFmLYHXA88DsWxgy7CZqujJIIR0Nf7VRkGM6WQPtwJRbuj7NrYPMyHaYl7HZ4KoTs
        kJVDj/84hvB+ONDxU2QWZBclcPDrfgIJL0PvdNu9QAy83t8RhfAj8M7p+nvhPHj6mAtHWAut
        vmoKPcTzsPJCPqJfgt6hcQLRK+HIXDTaciWs6rLgiGagoVyG3Amw+1AnMIO11vvust53l/W/
        uxC9Hja456n/0Ymw6bNZHOEt0G7/jWgAUS0gVigS1TmCmKwRPkwSlWqxSJOTlFmgdoK7P/T8
        cv/NbtB8/Y+kXoDRoBc8eTc84bBdAnGEpkAjyFczMYGZTBmTpdz7kaAreE9XlC+IvWANTchj
        mcQtvkwZm6MsFPIEQSvo/lUxWhKnx1ZkjbGzLRc6gXfMb9Tu9fkH+uzqonqZdTM5FP+zt718
        NOXMWVVp25GtVT3DheekCvqLGn86yR9I+8B9qGdJsapsk2cPWUf3JaQmV7yRF1Bxu25YOkce
        LO+K7bvzsCVD/CX0TsXSVO2quZrLNmUHue71o7svz4zHH784bBkW7TxISnt3bUHoSHujjQ5k
        n4hL0SoOPPbJa1NPMAvTG+TpxU/deuDN5IHW9/cxJywTJRVw2lScnZixi06tevrTk9sen6vZ
        rshovNLUsye37iHx1balBaa50Fi6Q72idN/W7nmWkb2Yun9s/vsU/bZsRyXuTB6UiKdcv4Za
        VKFjdUOT87ScEFXKjetwnaj8B5ApG9IcBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsVy+t/xu7qt318nG3Qc4LeYefkHo0Vr+zcm
        iwVHnzJbNN5vZLKY8OYou8XcqatZLVauPspk8WT9LGaLztMXmCz+dt1jsuib8JjZ4s9DQ4s9
        e0+yWExo+8pscWPCU0aLicc3s1p0bHjD6CDo8e/EGjaP5gV3WDw2repk89h9s4HN4/CmRawe
        EzZvZPX4vEnOo/1AN1MAR5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6d
        TUpqTmZZapG+XYJexu9Zx5kK3qRUzJhd2MA4IaSLkYNDQsBEouNNVBcjJ4eQwFJGicmrakFs
        CQEZiU9XPrJD2MISf651sXUxcgHVfGSUmLZkAztEwxZGiaW3tEDmsAioSjTcjgQJswnoSJx/
        c4cZxBYRUJM4+6KDCcRmFjjEJvFjtRWILSwQKvHw6QewOK+AuUTX9ZusEPPfMUr8XniNDSIh
        KHFy5hMWkPnMAmUSy05KQ5jSEsv/cYBUcAoESqz9CtIKcqaSxNHbs5kg7FqJz3+fMU5gFJ6F
        ZNAshEGzEAbNArtNS+LGv5dMGMLaEssWvmaGsG0l1q17z7KAkX0Vo0hqaXFuem6xkV5xYm5x
        aV66XnJ+7iZGYBLZduznlh2MK1991DvEyMTBeIhRBajz0YbVFxilWPLy81KVRHiFn75IFuJN
        SaysSi3Kjy8qzUktPsRoCgzCicxSosn5wPSWVxJvaGZgamhiZmlgamlmrCTO61nQkSgkkJ5Y
        kpqdmlqQWgTTx8TBKdXAFBBhvHnyzDscjaHP5Fc7nuRed36u7xfZQpPkOVGBbF8XXMq+v0e5
        +K/27zXZlnFN051zajJs1e5+cQraXbwn6sHlsD3pyT+U/Gf4qvFk+LPrtHQ5tSb93ZJxQeC/
        muRmnq+v3NvPdaVf5Lrw6wPTirqIU51aTbfimmaVJHmGlVg5eq2XLwoTb/9ZIrmqQyI96Mbm
        nW0Htq56Fj/NVyQnQExNIVBf+PbPA08vBCzhzZiZpFSx7cSXe/qXk1Tj9HKn5m3vED7xycbE
        f8un8jqjxKNpMS8XreCdUfDn7BvlPeUi/gGMPUx1M6ZrPnK8l2vy/dbGC0VvU37J7K0t/Vex
        Lm5mbnTdBcXHZekK+YeUWIozEg21mIuKEwH/udOFtwMAAA==
X-CMS-MailID: 20230214210509eucas1p1536bedbc8dd0e6d1872eb255ccc5b395
X-Msg-Generator: CA
X-RootMTR: 20230206134200uscas1p20382220d7fc10c899b4c79e01d94cf0b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230206134200uscas1p20382220d7fc10c899b4c79e01d94cf0b
References: <CGME20230206134200uscas1p20382220d7fc10c899b4c79e01d94cf0b@uscas1p2.samsung.com>
        <20230206134148.GD6704@gsv> <20230208171321.GA408056@bgt-140510-bm01>
        <CANr-nt0wVphKW1LXhmw3CgtJ5qRKYWkTy=Xg9Ey-39OnwvxnHA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--ybf3t4ljvnodfwet
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09, 2023 at 11:05:44AM +0100, Hans Holmberg wrote:
> On Wed, Feb 8, 2023 at 6:13 PM Adam Manzanares <a.manzanares@samsung.com>=
 wrote:
> >
> > On Mon, Feb 06, 2023 at 01:41:49PM +0000, Hans Holmberg wrote:
> > > Write amplification induced by garbage collection negatively impacts
> > > both the performance and the life time for storage devices.
> > >
> > > With zoned storage now standardized for SMR hard drives
> > > and flash(both NVME and UFS) we have an interface that allows
> > > us to reduce this overhead by adapting file systems to do
> > > better data placement.
> >
> > I would be interested in this discussion as well. Data placement on sto=
rage
> > media seems like a topic that is not going to go away any time soon. In=
terfaces
> > that are not tied to particular HW implementations seem like a longer t=
erm
> > approach to the issue.
> >
> > >
> > > Background
> > > ----------
> > >
> > > Zoned block devices enables the host to reduce the cost of
> > > reclaim/garbage collection/cleaning by exposing the media erase
> > > units as zones.
> > >
> > > By filling up zones with data from files that will
> > > have roughly the same life span, garbage collection I/O
> > > can be minimized, reducing write amplification.
> > > Less disk I/O per user write.
> > >
> > > Reduced amounts of garbage collection I/O improves
> > > user max read and write throughput and tail latencies, see [1].
> > >
> > > Migrating out still-valid data to erase and reclaim unused
> > > capacity in e.g. NAND blocks has a significant performance
> > > cost. Unnecessarily moving data around also means that there
> > > will be more erase cycles per user write, reducing the life
> > > time of the media.
> > >
> > > Current state
> > > -------------
> > >
> > > To enable the performance benefits of zoned block devices
> > > a file system needs to:
> > >
> > > 1) Comply with the write restrictions associated to the
> > > zoned device model.
> > >
> > > 2) Make active choices when allocating file data into zones
> > > to minimize GC.
> > >
> > > Out of the upstream file systems, btrfs and f2fs supports
> > > the zoned block device model. F2fs supports active data placement
> > > by separating cold from hot data which helps in reducing gc,
> > > but there is room for improvement.
> > >
> > >
> > > There is still work to be done
> > > ------------------------------
> > >
> > > I've spent a fair amount of time benchmarking btrfs and f2fs
> > > on top of zoned block devices along with xfs, ext4 and other
> > > file systems using the conventional block interface
> > > and at least for modern applicationsm, doing log-structured
> > > flash-friendly writes, much can be improved.
> > >
> > > A good example of a flash-friendly workload is RocksDB [6]
> > > which both does append-only writes and has a good prediction model
> > > for the life time of its files (due to its lsm-tree based data struct=
ures)
> > >
> > > For RocksDB workloads, the cost of garbage collection can be reduced
> > > by 3x if near-optimal data placement is done (at 80% capacity usage).
> > > This is based on comparing ZenFS[2], a zoned storage file system plug=
in
> > > for RocksDB, with f2fs, xfs, ext4 and btrfs.
> > >
> > > I see no good reason why linux kernel file systems (at least f2fs & b=
trfs)
> > > could not play as nice with these workload as ZenFS does, by just all=
ocating
> > > file data blocks in a better way.
> > >
> >
> > For RocksDB one thing I have struggled with is the fact that RocksDB ap=
pears
> > to me as a lightweight FS user. We expect much more from kernel FS than=
 what
> > RocksDB expects. There are multiple user space FS that are compatible w=
ith
> > RocksDB. How far should the kernel go to accomodate this use case?
> >
> > > In addition to ZenFS we also have flex-alloc [5].
> > > There are probably more data placement schemes for zoned storage out =
there.
> > >
> > > I think we need to implement a scheme that is general-purpose enough
> > > for in-kernel file systems to cover a wide range of use cases and wor=
kloads.
> >
> > This is the key point of the work IMO. I would hope to hear more use ca=
ses and
> > make sure that the demand comes from potential users of the API.
> >
> > >
> > > I brought this up at LPC last year[4], but we did not have much time
> > > for discussions.
> > >
> > > What is missing
> > > ---------------
> > >
> > > Data needs to be allocated to zones in a way that minimizes the need =
for
> > > reclaim. Best-effort placement decision making could be implemented t=
o place
> > > files of similar life times into the same zones.
> > >
> > > To do this, file systems would have to utilize some sort of hint to
> > > separate data into different life-time-buckets and map those to
> > > different zones.
> > >
> > > There is a user ABI for hints available - the write-life-time hint in=
terface
> > > that was introduced for streams [3]. F2FS is the only user of this cu=
rrently.
> > >
> > > BTRFS and other file systems with zoned support could make use of it =
too,
> > > but it is limited to four, relative, life time values which I'm afrai=
d would be too limiting when multiple users share a disk.
> > >
> >
> > I noticed F2FS uses only two of the four values ATM. I would like to he=
ar more
> > from F2FS users who use these hints as to what the impact of using the =
hints is.
> >
> > > Maybe the life time hints could be combined with process id to separa=
te
> > > different workloads better, maybe we need something else. F2FS suppor=
ts
> > > cold/hot data separation based on file extension, which is another so=
lution.
> > >
> > > This is the first thing I'd like to discuss.
> > >
> > > The second thing I'd like to discuss is testing and benchmarking, whi=
ch
> > > is probably even more important and something that should be put into
> > > place first.
> > >
> > > Testing/benchmarking
> > > --------------------
> > >
> > > I think any improvements must be measurable, preferably without havin=
g to
> > > run live production application workloads.
> > >
> > > Benchmarking and testing is generally hard to get right, and particul=
arily hard
> > > when it comes to testing and benchmarking reclaim/garbage collection,
> > > so it would make sense to share the effort.
> > >
> > > We should be able to use fio to model a bunch of application workloads
> > > that would benefit from data placement (lsm-tree based key-value data=
base
> > > stores (e.g rocksdb, terarkdb), stream processing apps like Apache ka=
fka)) ..
> >
> > Should we just skip fio and run benchmarks on top of rocksDB and kafka?=
 I was
> > looking at mmtests recently and noticed that it goes and downloads mm r=
elevant
> > applications and runs benchmarks on the chose benchmarks.
>=20
> It takes a significant amount of time and trouble to build, run and under=
stand
> benchmarks for these applications. Modeling the workloads using fio
> minimizes the set-up work and would enable more developers to actually
> run these things. The workload definitions could also help developers
> understanding what sort of IO that these use cases generate.
>=20
> There is already one mixed-lifetime benchmark in fsperf [7], more
> could probably be added.
> I'm looking into adding a lsm-tree workload.
>=20
> Full, automated, application benchmarks(db_bech, sysbench, ..) would
> be great to have as well of course.

I think the two compliment each other. Fio has a very nice property
which is that you control practically every IO parameter imaginable. So
it can be used to test specific things. However there is always the
question of how will it behave out in the "real world" and things like
sysbench, db_bench/rocksdb, kafka give insight into this behavior.


>=20
> [7] https://protect2.fireeye.com/v1/url?k=3Dacdf3830-cd542d06-acdeb37f-74=
fe485cbff1-62060b9a67391c4c&q=3D1&e=3De339ca4d-d944-42e6-a67e-5032677c1b43&=
u=3Dhttps%3A%2F%2Fgithub.com%2Fjosefbacik%2Ffsperf%2Fblob%2Fmaster%2Ffrag_t=
ests%2Fmixed-lifetimes.fio
>=20
> Cheers,
> Hans
>=20
> >
> > >
> > > Once we have a set of benchmarks that we collectively care about, I t=
hink we
> > > can work towards generic data placement methods with some level of
> > > confidence that it will actually work in practice.
> > >
> > > Creating a repository with a bunch of reclaim/gc stress tests and ben=
chmarks
> > > would be beneficial not only for kernel file systems but also for use=
r-space
> > > and distributed file systems such as ceph.
> >
> > This would be very valuable. Ideally with input from consumers of the d=
ata
> > placement APIS.
> >
> > >
> > > Thanks,
> > > Hans
> > >
> > > [1] https://protect2.fireeye.com/v1/url?k=3D8170ab1e-e0fbbe28-8171205=
1-74fe485cbff1-d6a2c52f6b47b21e&q=3D1&e=3De339ca4d-d944-42e6-a67e-5032677c1=
b43&u=3Dhttps%3A%2F%2Furldefense.com%2Fv3%2F__https%3A%2F%2Fwww.usenix.org%=
2Fsystem%2Ffiles%2Fatc21-bjorling.pdf__%3B%21%21EwVzqGoTKBqv-0DWAJBm%21WC4R=
GRyZ9YioNTLW94o29OSHK5LD8GlXL_2VKMGS7Z5e0cojtPDKfqU0iETvqHpyuKD6UpBapa6jkGm=
bktirD4LbAEY%24
> > > [2] https://protect2.fireeye.com/v1/url?k=3D2a19dfab-4b92ca9d-2a1854e=
4-74fe485cbff1-02d1dbdd0e5b5b42&q=3D1&e=3De339ca4d-d944-42e6-a67e-5032677c1=
b43&u=3Dhttps%3A%2F%2Furldefense.com%2Fv3%2F__https%3A%2F%2Fprotect2.fireey=
e.com%2Fv1%2Furl%3Fk%3D462cf2bb-27a7e781-462d79f4-74fe4860008a-ab419c0ae2c7=
fb34%26q%3D1%26e%3D66a35d4b-398f-4758-82c5-79f023ada0b4%26u%3Dhttps%2A3A%2A=
2F%2A2Fgithub.com%2A2Fwesterndigitalcorporation%2A2Fzenfs__%3BJSUlJSU%21%21=
EwVzqGoTKBqv-0DWAJBm%21WC4RGRyZ9YioNTLW94o29OSHK5LD8GlXL_2VKMGS7Z5e0cojtPDK=
fqU0iETvqHpyuKD6UpBapa6jkGmbktirB3JeheY%24
> > > [3] https://protect2.fireeye.com/v1/url?k=3D911bc000-f090d536-911a4b4=
f-74fe485cbff1-2c11d212d3307ae7&q=3D1&e=3De339ca4d-d944-42e6-a67e-5032677c1=
b43&u=3Dhttps%3A%2F%2Furldefense.com%2Fv3%2F__https%3A%2F%2Flwn.net%2FArtic=
les%2F726477%2F__%3B%21%21EwVzqGoTKBqv-0DWAJBm%21WC4RGRyZ9YioNTLW94o29OSHK5=
LD8GlXL_2VKMGS7Z5e0cojtPDKfqU0iETvqHpyuKD6UpBapa6jkGmbktirPUCJNUc%24
> > > [4] https://protect2.fireeye.com/v1/url?k=3D5ebef0e0-3f35e5d6-5ebf7ba=
f-74fe485cbff1-384c47aa42ce281c&q=3D1&e=3De339ca4d-d944-42e6-a67e-5032677c1=
b43&u=3Dhttps%3A%2F%2Furldefense.com%2Fv3%2F__https%3A%2F%2Fprotect2.fireey=
e.com%2Fv1%2Furl%3Fk%3D7eb17e0e-1f3a6b34-7eb0f541-74fe4860008a-0e46d2a09227=
c132%26q%3D1%26e%3D66a35d4b-398f-4758-82c5-79f023ada0b4%26u%3Dhttps%2A3A%2A=
2F%2A2Flpc.events%2A2Fevent%2A2F16%2A2Fcontributions%2A2F1231%2A2F__%3BJSUl=
JSUlJSU%21%21EwVzqGoTKBqv-0DWAJBm%21WC4RGRyZ9YioNTLW94o29OSHK5LD8GlXL_2VKMG=
S7Z5e0cojtPDKfqU0iETvqHpyuKD6UpBapa6jkGmbktirgbmZXI0%24
> > > [5] https://protect2.fireeye.com/v1/url?k=3D44834f5c-25085a6a-4482c41=
3-74fe485cbff1-5f05627461a4cdbe&q=3D1&e=3De339ca4d-d944-42e6-a67e-5032677c1=
b43&u=3Dhttps%3A%2F%2Furldefense.com%2Fv3%2F__https%3A%2F%2Fprotect2.fireey=
e.com%2Fv1%2Furl%3Fk%3D19cdffac-7846ea96-19cc74e3-74fe4860008a-1121f5b082ab=
fbe3%26q%3D1%26e%3D66a35d4b-398f-4758-82c5-79f023ada0b4%26u%3Dhttps%2A3A%2A=
2F%2A2Fgithub.com%2A2FOpenMPDK%2A2FFlexAlloc__%3BJSUlJSU%21%21EwVzqGoTKBqv-=
0DWAJBm%21WC4RGRyZ9YioNTLW94o29OSHK5LD8GlXL_2VKMGS7Z5e0cojtPDKfqU0iETvqHpyu=
KD6UpBapa6jkGmbktirL2CmpSE%24
> > > [6] https://protect2.fireeye.com/v1/url?k=3D8ee14fdd-ef6a5aeb-8ee0c49=
2-74fe485cbff1-53c0852325edc09a&q=3D1&e=3De339ca4d-d944-42e6-a67e-5032677c1=
b43&u=3Dhttps%3A%2F%2Furldefense.com%2Fv3%2F__https%3A%2F%2Fprotect2.fireey=
e.com%2Fv1%2Furl%3Fk%3D6ed08255-0f5b976f-6ed1091a-74fe4860008a-2a012b612f36=
b36a%26q%3D1%26e%3D66a35d4b-398f-4758-82c5-79f023ada0b4%26u%3Dhttps%2A3A%2A=
2F%2A2Fgithub.com%2A2Ffacebook%2A2Frocksdb__%3BJSUlJSU%21%21EwVzqGoTKBqv-0D=
WAJBm%21WC4RGRyZ9YioNTLW94o29OSHK5LD8GlXL_2VKMGS7Z5e0cojtPDKfqU0iETvqHpyuKD=
6UpBapa6jkGmbktirJuN380k%24

--ybf3t4ljvnodfwet
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmPr938ACgkQupfNUreW
QU/DcAv+JcSWgI4EK6mCxvcjR2s8IhDrxL2am60PGB1AabHDXXUCWaWtTu/mRkey
X1fUFZgCqWKbQJzrk6/7vZpIMDUck1iAFilfVsynFIl5mbQh2Y0tJjrKeuIAp3AG
AqtsflQN40PAhY0z3UH1asbQsuQUx/ztkzkB5Ef79bY34iRQFWCrOVTcLkQwzN7H
JBBIekUJULddyP95sMWz7VhjmijYXsj40AwchiVa+Mg7W4hpLunqD+pfa5uXkTzC
XJQPavZ1JVUlUHiu2/+P4a8tHmjuPXEpNNds4YGFQEYeuBefENWMFZa0q9sWXbQm
Rjf861L5B+RnuXo0VbORx8YJu0bNgLyCKDiffp36luEzh+KkqufWxdYo58w+wlt1
UeK6W+t6Fya/9BIHT3i7XBGL1IMa83G9rnVC3WY5pcGfmYA97VVnv4SiYoR52EKB
RDgZwRjkiRE3Eiagn8VisTUQk2D4SaC2KBSdm+kJO8K5pu+Bnx+EGKKvv0lTw3VF
cTBpvK66
=RIzd
-----END PGP SIGNATURE-----

--ybf3t4ljvnodfwet--
