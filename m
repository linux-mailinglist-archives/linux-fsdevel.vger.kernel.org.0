Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CA668E18A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 20:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjBGTy0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Feb 2023 14:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjBGTyV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Feb 2023 14:54:21 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79154489
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Feb 2023 11:53:55 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id g15-20020a9d6b0f000000b0068db1940216so759613otp.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Feb 2023 11:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28kssE+X4f6+3ObgjhuEgRRQMz4WzQjRAHKIxZExi8Q=;
        b=QARfA7CyPoltKRkJOuLmj4menndu407PNr5C9I6QnnMsCcLn85s7TnBJ9Kodec6L28
         RlshmUW8MPjgIoFsNUzUwaH//7/vr/Y7meivHXxryjIRAdbhfD10a81ZVqo6T9ywjQuJ
         dzUS3TIVDfp9EHA5ktceV6icjgAmGnK30WqqCQH7n2XbytCanuATjroyK3NqBKZOC1j/
         nSYrb1Y7ZrP6EKCvpFDMH3l32gR0I8UM6aHOeuYp2ELIIlTjjeukhK5l0+uVL0fcLNh2
         Z45cezK9PhmXfPxJsH8HZObk05Q5pF6u98dvXj+Wlqu8MxsLJL40Vd2a4qL7GNB52II+
         us5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28kssE+X4f6+3ObgjhuEgRRQMz4WzQjRAHKIxZExi8Q=;
        b=USg9uVxUlS1nGK068mS/CUDq5Y8uEOxnJD4mV0vjSnY/mqgJHTVuRfmyx9IcCGD6ND
         VVuZFq7MdrDr/F/O0I18h7vty4t4bQKS358X9b413Udf/SeZDxDM899WVBoU0AT6W89Q
         YAQdCld9ObYA5We/YvxzYWyMLGfNjui0wu/lrOEp4ak1mkRxaDT2Z+Mjkodh+xLgpm16
         v/EhVlkl1aU11H9bBfm7RmPE/nxsc0uKRaknKuA1PnB8/9DUvn8r5mcIncSiBR69axTB
         lIEfWL4tPHSjte8PNVf2LvVCvBUVPT1BBU8aFAfOle8yt/nQzwEd8NiQYDv0qVT9kicV
         jGAg==
X-Gm-Message-State: AO0yUKWygsS9znI9zPqTsDO9NQKYgMNaaqYKL1d/tYwCOBoCPpQcwHSX
        fmKPRtYPGzOIO/S/nkhfs4o8vQ==
X-Google-Smtp-Source: AK7set90WEnb7U/kWFwYeV3Fz9oDeIeYcwpjvd0DiSnOhOkgqbVdQ6BklLQuUBDKPCRIP/4roHKGNA==
X-Received: by 2002:a9d:664f:0:b0:68b:b4e1:2286 with SMTP id q15-20020a9d664f000000b0068bb4e12286mr1639852otm.28.1675799634982;
        Tue, 07 Feb 2023 11:53:54 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id x9-20020a056830114900b0068d49f4d8dfsm6924564otq.63.2023.02.07.11.53.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2023 11:53:54 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [External] [LSF/MM/BPF TOPIC]: File system data placement for
 zoned block devices
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
In-Reply-To: <20230206134148.GD6704@gsv>
Date:   Tue, 7 Feb 2023 11:53:41 -0800
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Dennis Maisenbacher <dennis.maisenbacher@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        =?utf-8?Q?J=C3=B8rgen_Hansen?= <Jorgen.Hansen@wdc.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "javier@javigon.com" <javier@javigon.com>,
        "hch@lst.de" <hch@lst.de>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        "guokuankuan@bytedance.com" <guokuankuan@bytedance.com>,
        "j.granados@samsung.com" <j.granados@samsung.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4130BE54-D7E4-4E8F-B6A3-844B815841AC@bytedance.com>
References: <20230206134148.GD6704@gsv>
To:     Hans Holmberg <hans.holmberg@wdc.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Feb 6, 2023, at 5:41 AM, Hans Holmberg <hans.holmberg@wdc.com> =
wrote:
>=20
> Write amplification induced by garbage collection negatively impacts
> both the performance and the life time for storage devices.
>=20
> With zoned storage now standardized for SMR hard drives
> and flash(both NVME and UFS) we have an interface that allows
> us to reduce this overhead by adapting file systems to do
> better data placement.
>=20

I would love to join this discussion. I agree it=E2=80=99s very =
important topic and there is
room for significant improvement here.

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

Yes, it=E2=80=99s true. This is why I am trying to eliminate GC activity =
in SSDFS file system. :)

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

Yeah, but F2FS requires conventional zone anyway because of in-place =
update area.
I am not sure that F2FS can switch on pure append-only mode.

>=20
> There is still work to be done
> ------------------------------
>=20

It=E2=80=99s definitely true statement. :)

> I've spent a fair amount of time benchmarking btrfs and f2fs
> on top of zoned block devices along with xfs, ext4 and other
> file systems using the conventional block interface
> and at least for modern applicationsm, doing log-structured
> flash-friendly writes, much can be improved.=20
>=20
> A good example of a flash-friendly workload is RocksDB [6]
> which both does append-only writes and has a good prediction model
> for the life time of its files (due to its lsm-tree based data =
structures)
>=20
> For RocksDB workloads, the cost of garbage collection can be reduced
> by 3x if near-optimal data placement is done (at 80% capacity usage).
> This is based on comparing ZenFS[2], a zoned storage file system =
plugin
> for RocksDB, with f2fs, xfs, ext4 and btrfs.
>=20
> I see no good reason why linux kernel file systems (at least f2fs & =
btrfs)
> could not play as nice with these workload as ZenFS does, by just =
allocating
> file data blocks in a better way.
>=20

I think it=E2=80=99s not easy point. It could require the painful =
on-disk layout modifications.

> In addition to ZenFS we also have flex-alloc [5].
> There are probably more data placement schemes for zoned storage out =
there.
>=20
> I think wee need to implement a scheme that is general-purpose enough
> for in-kernel file systems to cover a wide range of use cases and =
workloads.
>=20

Yeah, it=E2=80=99s great idea. But it could be really tough to =
implement. Especially, because
every file system has very special on-disk layout and architectural =
philosophy. So, to have
a general-purpose scheme sounds very exciting but it could be really =
tough to find a =E2=80=9Cglobal=E2=80=9D
optimum that will serve perfectly all file systems. But it could be =
worth to try. :)=20

> I brought this up at LPC last year[4], but we did not have much time
> for discussions.
>=20
> What is missing
> ---------------
>=20
> Data needs to be allocated to zones in a way that minimizes the need =
for
> reclaim. Best-effort placement decision making could be implemented to =
place
> files of similar life times into the same zones.
>=20
> To do this, file systems would have to utilize some sort of hint to
> separate data into different life-time-buckets and map those to
> different zones.
>=20
> There is a user ABI for hints available - the write-life-time hint =
interface
> that was introduced for streams [3]. F2FS is the only user of this =
currently.
>=20
> BTRFS and other file systems with zoned support could make use of it =
too,
> but it is limited to four, relative, life time values which I'm afraid =
would be too limiting when multiple users share a disk.
>=20
> Maybe the life time hints could be combined with process id to =
separate
> different workloads better, maybe we need something else. F2FS =
supports
> cold/hot data separation based on file extension, which is another =
solution.
>=20

It=E2=80=99s tricky, I assume. So, it looks like a good discussion. As =
far as I can see, such policy
can be implemented above any particular file system.

File extension is not stable basis because file could not have extension =
at all,
extension can be wrong, or not representative at all. And to check =
extension on
file system level sounds like breaking the file system philosophy.

Write-life-time hints sounds tricky too, from my point of view. Not =
every application
can properly define the lifetime of data. Also, file system=E2=80=99s =
allocation policy/model is
heavily defines distribution of data on the volume. And it is really =
tough to follow
the policy of distribution of logical blocks among streams with =
different lifetime.

> This is the first thing I'd like to discuss.
>=20
> The second thing I'd like to discuss is testing and benchmarking, =
which
> is probably even more important and something that should be put into
> place first.
>=20
> Testing/benchmarking
> --------------------
>=20
> I think any improvements must be measurable, preferably without having =
to
> run live production application workloads.
>=20
> Benchmarking and testing is generally hard to get right, and =
particularily hard
> when it comes to testing and benchmarking reclaim/garbage collection,
> so it would make sense to share the effort.
>=20
> We should be able to use fio to model a bunch of application workloads
> that would benefit from data placement (lsm-tree based key-value =
database
> stores (e.g rocksdb, terarkdb), stream processing apps like Apache =
kafka)) ..=20
>=20
> Once we have a set of benchmarks that we collectively care about, I =
think we
> can work towards generic data placement methods with some level of
> confidence that it will actually work in practice.
>=20
> Creating a repository with a bunch of reclaim/gc stress tests and =
benchmarks
> would be beneficial not only for kernel file systems but also for =
user-space
> and distributed file systems such as ceph.
>=20

Yeah, simulation of aged volume (that requires GC activity) is pretty =
complicated task.

Thanks,
Slava.

