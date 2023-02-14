Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7606696EDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 22:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjBNVIL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 16:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBNVIK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 16:08:10 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0EB22006
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 13:08:07 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230214210805euoutp020d6e4eae268b4ed1a6a0f4305b6433d1~DzP-JyK-e0075600756euoutp02e;
        Tue, 14 Feb 2023 21:08:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230214210805euoutp020d6e4eae268b4ed1a6a0f4305b6433d1~DzP-JyK-e0075600756euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676408885;
        bh=WZNUPR7cC4v6C2Z/xc3cX+nvjVjhRqTB4yIi8HI+SMM=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=SUodAQTDQ8reWDJtE+ve/Nk26Fp+rhZORCSdynZuZAVTAfCk9AE9Von9a6TPhElDy
         M4s4+R4K+DG6ysiRaAxUlVTN1WHMvjy/Oh4BFhtfmfRGV/VUtOznVjU/2BmaCIJG54
         0zGrf4Vu6/jXeZlfdncUi3cn2flWbykvkJ3PZYMQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230214210803eucas1p21749bcd4aea5a4b2d3fe31e1170b7a05~DzP9oDR8J1287012870eucas1p2O;
        Tue, 14 Feb 2023 21:08:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 98.04.61197.338FBE36; Tue, 14
        Feb 2023 21:08:03 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230214210803eucas1p1f155660ea78fed878f13a864fd49fd96~DzP9NTc-O0280202802eucas1p11;
        Tue, 14 Feb 2023 21:08:03 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230214210803eusmtrp1e809c944aea3cfd447575c7699a992d9~DzP9MhNRq1590815908eusmtrp1h;
        Tue, 14 Feb 2023 21:08:03 +0000 (GMT)
X-AuditID: cbfec7f5-7dbff7000000ef0d-79-63ebf83328e1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1C.C4.00518.238FBE36; Tue, 14
        Feb 2023 21:08:03 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230214210802eusmtip2f78e854adfa941ad997054add12d1853~DzP88cYLv2094220942eusmtip2j;
        Tue, 14 Feb 2023 21:08:02 +0000 (GMT)
Received: from localhost (106.210.248.29) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 14 Feb 2023 21:08:02 +0000
Date:   Tue, 14 Feb 2023 22:08:00 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     Hans Holmberg <Hans.Holmberg@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "Dennis Maisenbacher" <dennis.maisenbacher@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        =?utf-8?Q?J=C3=B8rgen?= Hansen <Jorgen.Hansen@wdc.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "javier@javigon.com" <javier@javigon.com>,
        "hch@lst.de" <hch@lst.de>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        "guokuankuan@bytedance.com" <guokuankuan@bytedance.com>,
        "viacheslav.dubeyko@bytedance.com" <viacheslav.dubeyko@bytedance.com>
Subject: Re: [LSF/MM/BPF TOPIC]: File system data placement for zoned block
 devices
Message-ID: <20230214210800.mfrok5hfb4hdkph2@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="4hcy2rlkcc7q46sf"
Content-Disposition: inline
In-Reply-To: <20230206134148.GD6704@gsv>
X-Originating-IP: [106.210.248.29]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZduzneV3jH6+TDfYtULSYefkHo0Vr+zcm
        iwVHnzJbNN5vZLKY8OYou8XK1UeZLJ6sn8Vs0Xn6ApPF3657TBZ9Ex4zW/x5aGixZ+9JFosJ
        bV+ZLW5MeMpoMfH4ZlaLjg1vGB0EPP6dWMPm0bzgDovHplWdbB67bzaweUzYvJHV4/MmOY/2
        A91MAexRXDYpqTmZZalF+nYJXBk9uy+wFRy2rji3xaSB8bVhFyMnh4SAiUTHor1sXYxcHEIC
        Kxglnq5pZYFwvjBK9M3+xwjhfGaUePLtORtMy5vvLUwQieWMEjNe9bLCVW0+2c4O4WxhlFi5
        7zwjSAuLgKrE0e2vwNrZBHQkzr+5wwxiiwhoSsxeuBRsB7PACjaJ68t/sIMkhAVCJR4+/cAE
        YvMKmEtcn3iPEcIWlDg58wkLiM0sUCGx8PRLoEEcQLa0xPJ/HCBhTgENiYkdXYwQpypJHL09
        mwnCrpU4teUW2NkSAs84JbZ9mw+VcJGY8uAEC4QtLPHq+BZ2CFtG4vTkHqh4tsTOKbuYIewC
        iVknp7KB7JUQsJboO5MDEXaUmPf8KQtEmE/ixltBiCv5JCZtm84MEeaV6GgTgqhWk9jRtJVx
        AqPyLCR/zULy1yyEvyDCOhILdn9iwxDWlli28DUzhG0rsW7de5YFjOyrGMVTS4tz01OLjfNS
        y/WKE3OLS/PS9ZLzczcxApPm6X/Hv+5gXPHqo94hRiYOxkOMKkDNjzasvsAoxZKXn5eqJMIr
        /PRFshBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFebduTyUIC6YklqdmpqQWpRTBZJg5OqQamlUd2
        rf0lGlUQErl2WeeB0ydLJ+y47KX0Pb9G69OB9sflG473zH8u9ct8HnP4lbcdrFcsOcV7jKdt
        8tnuy2E9r/ao1nvvnbZcjy5/3Go3ma17+pqjvxcv7g2f/PL1rjZ91ukHxEoCa5TufTVJy561
        duqzODbPdzNS/jNtYJKSmP259faHp6K8n9zU5oTf/+T1ujI9XOihRmHcHtOzzD+ib65Jiez4
        vOFn3e+Xps0fbfIm/y47Z7B36ReX9S9nXnaVZk/w75gr85O1OffpO6PA07fieBa8Uo5LvvJL
        VqNrj9fNZYosbVeF1avX/DVr3PrglaXeA/4w+f8fC7wvv/X9cqwoZN2O++pfchKYT1p571Vi
        Kc5INNRiLipOBAD9aW4CFQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsVy+t/xe7rGP14nG+x/z2gx8/IPRovW9m9M
        FguOPmW2aLzfyGQx4c1RdouVq48yWTxZP4vZovP0BSaLv133mCz6Jjxmtvjz0NBiz96TLBYT
        2r4yW9yY8JTRYuLxzawWHRveMDoIePw7sYbNo3nBHRaPTas62Tx232xg85iweSOrx+dNch7t
        B7qZAtij9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S
        9DLm9fQyFxy0rni7tpWxgfGlYRcjJ4eEgInEm+8tTF2MXBxCAksZJXb09zFCJGQkPl35yA5h
        C0v8udbFBlH0kVHi7ZJDUM4WRonHmxexgFSxCKhKHN3+ig3EZhPQkTj/5g4ziC0ioCkxe+FS
        RpAGZoEVbBLXl/8AGyssECrx8OkHJhCbV8Bc4vrEe2CrhQSqJc7famGGiAtKnJz5BGwBs0CZ
        xJTt24HqOYBsaYnl/zhAwpwCGhITO7qgrlaSOHp7NhOEXSvx+e8zxgmMwrOQTJqFZNIshEkQ
        YS2JG/9eYgprSyxb+JoZwraVWLfuPcsCRvZVjCKppcW56bnFRnrFibnFpXnpesn5uZsYgelj
        27GfW3Ywrnz1Ue8QIxMH4yFGFaDORxtWX2CUYsnLz0tVEuEVfvoiWYg3JbGyKrUoP76oNCe1
        +BCjKTAUJzJLiSbnAxNbXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2ampBahFMHxMH
        p1QDE4dy9ZObQYVrTeWKeL/Ntq2U+1kncvP9MTlfKR6NSR9UWmI17k76yNOxu/VS4qy0UzGd
        q3JvRi02V7Y79Tt/o/9ZD43MuUk7dwuYfG4815iSJiW10UA78Yyga+1Fl8dSjSYPjlxJPKV9
        Olq4g0n7VsaavbFz9h79ZLHMxW3KnpxoQfZr8xqfzuIKDP//t0OA47+10d9DJ42kGnqYt3bs
        3NfBz5S65cb1qwtvTP627GG0S3zBYWuni+0XJC/7X9iarvszXO7rI22HI3mpV5kuBSb9/PXj
        hIO94refWYxFLyyfC5oIT1gmv+6oi9LkkOqMKvEHdczFp07VN5YFCMpbHTggcOX3E/6qD1eS
        Ta+0K7EUZyQaajEXFScCADN7hZm0AwAA
X-CMS-MailID: 20230214210803eucas1p1f155660ea78fed878f13a864fd49fd96
X-Msg-Generator: CA
X-RootMTR: 20230206134200eucas1p16e5dc58fa12f678352735fc4b401dd75
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230206134200eucas1p16e5dc58fa12f678352735fc4b401dd75
References: <CGME20230206134200eucas1p16e5dc58fa12f678352735fc4b401dd75@eucas1p1.samsung.com>
        <20230206134148.GD6704@gsv>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--4hcy2rlkcc7q46sf
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 06, 2023 at 01:41:49PM +0000, Hans Holmberg wrote:
> Write amplification induced by garbage collection negatively impacts
> both the performance and the life time for storage devices.
>=20
> With zoned storage now standardized for SMR hard drives
> and flash(both NVME and UFS) we have an interface that allows
> us to reduce this overhead by adapting file systems to do
> better data placement.
I'm also very interested in discussions related to data placements. I am
interested in this discussion.

>=20
> Background
> ----------
>=20
> Zoned block devices enables the host to reduce the cost of
> reclaim/garbage collection/cleaning by exposing the media erase
> units as zones.
>=20
> By filling up zones with data from files that will
> have roughly the same life span, garbage collection I/O
> can be minimized, reducing write amplification.
> Less disk I/O per user write.
>=20
> Reduced amounts of garbage collection I/O improves
> user max read and write throughput and tail latencies, see [1].
>=20
> Migrating out still-valid data to erase and reclaim unused
> capacity in e.g. NAND blocks has a significant performance
> cost. Unnecessarily moving data around also means that there
> will be more erase cycles per user write, reducing the life
> time of the media.
>=20
> Current state
> -------------
>=20
> To enable the performance benefits of zoned block devices
> a file system needs to:
>=20
> 1) Comply with the write restrictions associated to the
> zoned device model.=20
>=20
> 2) Make active choices when allocating file data into zones
> to minimize GC.
>=20
> Out of the upstream file systems, btrfs and f2fs supports
> the zoned block device model. F2fs supports active data placement
> by separating cold from hot data which helps in reducing gc,
> but there is room for improvement.
>=20
>=20
> There is still work to be done
> ------------------------------
>=20
> I've spent a fair amount of time benchmarking btrfs and f2fs
> on top of zoned block devices along with xfs, ext4 and other
> file systems using the conventional block interface
> and at least for modern applicationsm, doing log-structured
> flash-friendly writes, much can be improved.=20
>=20
> A good example of a flash-friendly workload is RocksDB [6]
> which both does append-only writes and has a good prediction model
> for the life time of its files (due to its lsm-tree based data structures)
>=20
> For RocksDB workloads, the cost of garbage collection can be reduced
> by 3x if near-optimal data placement is done (at 80% capacity usage).
> This is based on comparing ZenFS[2], a zoned storage file system plugin
> for RocksDB, with f2fs, xfs, ext4 and btrfs.
>=20
> I see no good reason why linux kernel file systems (at least f2fs & btrfs)
> could not play as nice with these workload as ZenFS does, by just allocat=
ing
> file data blocks in a better way.
>=20
> In addition to ZenFS we also have flex-alloc [5].
> There are probably more data placement schemes for zoned storage out ther=
e.
>=20
> I think wee need to implement a scheme that is general-purpose enough
> for in-kernel file systems to cover a wide range of use cases and workloa=
ds.
>=20
> I brought this up at LPC last year[4], but we did not have much time
> for discussions.
>=20
> What is missing
> ---------------
>=20
> Data needs to be allocated to zones in a way that minimizes the need for
> reclaim. Best-effort placement decision making could be implemented to pl=
ace
> files of similar life times into the same zones.
>=20
> To do this, file systems would have to utilize some sort of hint to
> separate data into different life-time-buckets and map those to
> different zones.
>=20
> There is a user ABI for hints available - the write-life-time hint interf=
ace
> that was introduced for streams [3]. F2FS is the only user of this curren=
tly.
>=20
> BTRFS and other file systems with zoned support could make use of it too,
> but it is limited to four, relative, life time values which I'm afraid wo=
uld be too limiting when multiple users share a disk.
>=20
> Maybe the life time hints could be combined with process id to separate
> different workloads better, maybe we need something else. F2FS supports
> cold/hot data separation based on file extension, which is another soluti=
on.
>=20
> This is the first thing I'd like to discuss.
>=20
> The second thing I'd like to discuss is testing and benchmarking, which
> is probably even more important and something that should be put into
> place first.
>=20
> Testing/benchmarking
> --------------------
>=20
> I think any improvements must be measurable, preferably without having to
> run live production application workloads.
>=20
> Benchmarking and testing is generally hard to get right, and particularil=
y hard
> when it comes to testing and benchmarking reclaim/garbage collection,
> so it would make sense to share the effort.
>=20
> We should be able to use fio to model a bunch of application workloads
> that would benefit from data placement (lsm-tree based key-value database
> stores (e.g rocksdb, terarkdb), stream processing apps like Apache kafka)=
) ..=20
>=20
> Once we have a set of benchmarks that we collectively care about, I think=
 we
> can work towards generic data placement methods with some level of
> confidence that it will actually work in practice.
>=20
> Creating a repository with a bunch of reclaim/gc stress tests and benchma=
rks
> would be beneficial not only for kernel file systems but also for user-sp=
ace
> and distributed file systems such as ceph.
>=20
> Thanks,
> Hans
>=20
> [1] https://www.usenix.org/system/files/atc21-bjorling.pdf
> [2] https://protect2.fireeye.com/v1/url?k=3Ddce9fbc5-8372c2a0-dce8708a-00=
0babff32e3-302a3cb629dc78ae&q=3D1&e=3D3a8688d2-8cbb-40fb-9107-11a07c4e64ea&=
u=3Dhttps%3A%2F%2Fgithub.com%2Fwesterndigitalcorporation%2Fzenfs
> [3] https://lwn.net/Articles/726477/
> [4] https://protect2.fireeye.com/v1/url?k=3D911c6738-ce875e5d-911dec77-00=
0babff32e3-7bd289693aa18731&q=3D1&e=3D3a8688d2-8cbb-40fb-9107-11a07c4e64ea&=
u=3Dhttps%3A%2F%2Flpc.events%2Fevent%2F16%2Fcontributions%2F1231%2F
> [5] https://protect2.fireeye.com/v1/url?k=3De4102d1c-bb8b1479-e411a653-00=
0babff32e3-d07ddeaede7547d7&q=3D1&e=3D3a8688d2-8cbb-40fb-9107-11a07c4e64ea&=
u=3Dhttps%3A%2F%2Fgithub.com%2FOpenMPDK%2FFlexAlloc
> [6] https://protect2.fireeye.com/v1/url?k=3D1f7befc6-40e0d6a3-1f7a6489-00=
0babff32e3-a7f3b118578d6c39&q=3D1&e=3D3a8688d2-8cbb-40fb-9107-11a07c4e64ea&=
u=3Dhttps%3A%2F%2Fgithub.com%2Ffacebook%2Frocksdb

--4hcy2rlkcc7q46sf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmPr+DAACgkQupfNUreW
QU/WCwv9GfvyzUxZUICqfDStntYoEi++p6xOMeoqKgmAB+V9E3FWJWFMucMjbnEa
naDdbiFrPWzDB7cHNyXYmuAB41A2sEzHeyKprO2bQ2JBXIAI5wt35BGgOIaP7l7Y
sIJAGbMS7enszPFszo7LDbit1fsO/TjvrItXfpFSG+3Ll9+BI6+Y97izeupWRu02
d1AZnKsdi9bsBJQso/Qehi9WjClSERa4tLMasfj5ZYJokWrnspppM3DoRo60xO3O
aygOi3P2yP0g+XtOfEClBRF+aoLNj1Zoac2HTvWekOC3+rWN3kXkuNC/PTnVzZ3n
HWDXtuMbJI7vk1tqDdyKkiYVcMDinAwY2ANcQ4xb/j1VHA8TwnVdlhmtuPP96Ky4
s0xb4X2aRhRbvQAhIjwtN56uBVKoQoUCp0PBHhixANb5v/QEI+XjeNJZ9cf/rhR+
k/vLMfBXoODaWOjBNPGEVeZb2CgO0o4D0zHdxgPWjuwQU6pTsXyXhZ3NIEi11Ulx
FTn6V1bk
=OGA7
-----END PGP SIGNATURE-----

--4hcy2rlkcc7q46sf--
