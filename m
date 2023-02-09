Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF8269046A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 11:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjBIKGB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 05:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjBIKF6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 05:05:58 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F052CFF6
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Feb 2023 02:05:56 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id dr8so4686780ejc.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Feb 2023 02:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXUR6ViKuVKeKokhIgoINkwTS0ncG7g5XMGc7ceGRBw=;
        b=tCLtVCgPdSwU1SOkOowMjfJBEOxuYdCkuEe6XnOygKQcvrxvTpWGK4xK25BcNwraxl
         bjBbDkTXmqLBfKGaJxtnI0BMiAXLCeFm48hc+YZZnjKNbhuUgTFIgLKfO5SsO/unsFxx
         kOvwgjahOykhijOMTwSU8hsxQOmgauFTC/d7M443SJ1TPVu5omkWmAcc07jq/psAVIqY
         r0HOii276GIqdRj/HpDyA3EeBJibCUkC+3YRPTghZPm9FlL8sjUTguOGt9xBhrspQYWf
         uTBAKVz578EWXx9uQdAtBkJ4bHPAW5UKmmouwGNkJnqfMI0bsbgp+Ndg3cs+puaQg8f0
         mi6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXUR6ViKuVKeKokhIgoINkwTS0ncG7g5XMGc7ceGRBw=;
        b=miXmhU6jDsWAs+1j7hsS1+yAaGD9iQInAINgz53cay79rEIfOPwu+pUBO2hG1hUW3l
         jvIGQY1rpT5sR4pgMXD3GQYc2uL+413Dzl6SqtV8kYkj+AfqmjDyxbKUayg1+eeEfMU9
         wYzgwE8Bbj2E04hPuKSe9ZbVM7KEODQRFRoYb7l8bDNg0kFdq65FgwH0XfSizzF5w1rk
         oOp/Qt12YVjP0YAVxUZri/IdYMq91nxw3YobAplSa3hKJftBUXSLaTnIZA2kwhgHs/KR
         p/Iak1MhFM1Gnxu3ZJze5GJ7TJgeUR8CmSxkUXhjw1CT4B50oJ3vZGq9gtY0u1sJv4nx
         bABg==
X-Gm-Message-State: AO0yUKU1garjr1LAGh6twrMGmIVhuKebnN3yD6ZtOdOBe8ipARy3SUNa
        00kTkOm+SNLXqPU9SUNTsX8bfqJ1lOfwTJCyOh/9wg==
X-Google-Smtp-Source: AK7set+32AW5r6G6h2KUBmvW+gK7FIfbFLuT8cT4QgkUNgOdrjWpKMbzgGSHAf2t1HDY3Ht6hpKymlJQSQgL9CMmOdA=
X-Received: by 2002:a17:906:6957:b0:886:73de:3efc with SMTP id
 c23-20020a170906695700b0088673de3efcmr2716345ejs.87.1675937155175; Thu, 09
 Feb 2023 02:05:55 -0800 (PST)
MIME-Version: 1.0
References: <CGME20230206134200uscas1p20382220d7fc10c899b4c79e01d94cf0b@uscas1p2.samsung.com>
 <20230206134148.GD6704@gsv> <20230208171321.GA408056@bgt-140510-bm01>
In-Reply-To: <20230208171321.GA408056@bgt-140510-bm01>
From:   Hans Holmberg <hans@owltronix.com>
Date:   Thu, 9 Feb 2023 11:05:44 +0100
Message-ID: <CANr-nt0wVphKW1LXhmw3CgtJ5qRKYWkTy=Xg9Ey-39OnwvxnHA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC]: File system data placement for zoned block devices
To:     Adam Manzanares <a.manzanares@samsung.com>
Cc:     Hans Holmberg <Hans.Holmberg@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Dennis Maisenbacher <dennis.maisenbacher@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        =?UTF-8?Q?J=C3=B8rgen_Hansen?= <Jorgen.Hansen@wdc.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "javier@javigon.com" <javier@javigon.com>,
        "hch@lst.de" <hch@lst.de>,
        "guokuankuan@bytedance.com" <guokuankuan@bytedance.com>,
        "viacheslav.dubeyko@bytedance.com" <viacheslav.dubeyko@bytedance.com>,
        "j.granados@samsung.com" <j.granados@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 8, 2023 at 6:13 PM Adam Manzanares <a.manzanares@samsung.com> w=
rote:
>
> On Mon, Feb 06, 2023 at 01:41:49PM +0000, Hans Holmberg wrote:
> > Write amplification induced by garbage collection negatively impacts
> > both the performance and the life time for storage devices.
> >
> > With zoned storage now standardized for SMR hard drives
> > and flash(both NVME and UFS) we have an interface that allows
> > us to reduce this overhead by adapting file systems to do
> > better data placement.
>
> I would be interested in this discussion as well. Data placement on stora=
ge
> media seems like a topic that is not going to go away any time soon. Inte=
rfaces
> that are not tied to particular HW implementations seem like a longer ter=
m
> approach to the issue.
>
> >
> > Background
> > ----------
> >
> > Zoned block devices enables the host to reduce the cost of
> > reclaim/garbage collection/cleaning by exposing the media erase
> > units as zones.
> >
> > By filling up zones with data from files that will
> > have roughly the same life span, garbage collection I/O
> > can be minimized, reducing write amplification.
> > Less disk I/O per user write.
> >
> > Reduced amounts of garbage collection I/O improves
> > user max read and write throughput and tail latencies, see [1].
> >
> > Migrating out still-valid data to erase and reclaim unused
> > capacity in e.g. NAND blocks has a significant performance
> > cost. Unnecessarily moving data around also means that there
> > will be more erase cycles per user write, reducing the life
> > time of the media.
> >
> > Current state
> > -------------
> >
> > To enable the performance benefits of zoned block devices
> > a file system needs to:
> >
> > 1) Comply with the write restrictions associated to the
> > zoned device model.
> >
> > 2) Make active choices when allocating file data into zones
> > to minimize GC.
> >
> > Out of the upstream file systems, btrfs and f2fs supports
> > the zoned block device model. F2fs supports active data placement
> > by separating cold from hot data which helps in reducing gc,
> > but there is room for improvement.
> >
> >
> > There is still work to be done
> > ------------------------------
> >
> > I've spent a fair amount of time benchmarking btrfs and f2fs
> > on top of zoned block devices along with xfs, ext4 and other
> > file systems using the conventional block interface
> > and at least for modern applicationsm, doing log-structured
> > flash-friendly writes, much can be improved.
> >
> > A good example of a flash-friendly workload is RocksDB [6]
> > which both does append-only writes and has a good prediction model
> > for the life time of its files (due to its lsm-tree based data structur=
es)
> >
> > For RocksDB workloads, the cost of garbage collection can be reduced
> > by 3x if near-optimal data placement is done (at 80% capacity usage).
> > This is based on comparing ZenFS[2], a zoned storage file system plugin
> > for RocksDB, with f2fs, xfs, ext4 and btrfs.
> >
> > I see no good reason why linux kernel file systems (at least f2fs & btr=
fs)
> > could not play as nice with these workload as ZenFS does, by just alloc=
ating
> > file data blocks in a better way.
> >
>
> For RocksDB one thing I have struggled with is the fact that RocksDB appe=
ars
> to me as a lightweight FS user. We expect much more from kernel FS than w=
hat
> RocksDB expects. There are multiple user space FS that are compatible wit=
h
> RocksDB. How far should the kernel go to accomodate this use case?
>
> > In addition to ZenFS we also have flex-alloc [5].
> > There are probably more data placement schemes for zoned storage out th=
ere.
> >
> > I think we need to implement a scheme that is general-purpose enough
> > for in-kernel file systems to cover a wide range of use cases and workl=
oads.
>
> This is the key point of the work IMO. I would hope to hear more use case=
s and
> make sure that the demand comes from potential users of the API.
>
> >
> > I brought this up at LPC last year[4], but we did not have much time
> > for discussions.
> >
> > What is missing
> > ---------------
> >
> > Data needs to be allocated to zones in a way that minimizes the need fo=
r
> > reclaim. Best-effort placement decision making could be implemented to =
place
> > files of similar life times into the same zones.
> >
> > To do this, file systems would have to utilize some sort of hint to
> > separate data into different life-time-buckets and map those to
> > different zones.
> >
> > There is a user ABI for hints available - the write-life-time hint inte=
rface
> > that was introduced for streams [3]. F2FS is the only user of this curr=
ently.
> >
> > BTRFS and other file systems with zoned support could make use of it to=
o,
> > but it is limited to four, relative, life time values which I'm afraid =
would be too limiting when multiple users share a disk.
> >
>
> I noticed F2FS uses only two of the four values ATM. I would like to hear=
 more
> from F2FS users who use these hints as to what the impact of using the hi=
nts is.
>
> > Maybe the life time hints could be combined with process id to separate
> > different workloads better, maybe we need something else. F2FS supports
> > cold/hot data separation based on file extension, which is another solu=
tion.
> >
> > This is the first thing I'd like to discuss.
> >
> > The second thing I'd like to discuss is testing and benchmarking, which
> > is probably even more important and something that should be put into
> > place first.
> >
> > Testing/benchmarking
> > --------------------
> >
> > I think any improvements must be measurable, preferably without having =
to
> > run live production application workloads.
> >
> > Benchmarking and testing is generally hard to get right, and particular=
ily hard
> > when it comes to testing and benchmarking reclaim/garbage collection,
> > so it would make sense to share the effort.
> >
> > We should be able to use fio to model a bunch of application workloads
> > that would benefit from data placement (lsm-tree based key-value databa=
se
> > stores (e.g rocksdb, terarkdb), stream processing apps like Apache kafk=
a)) ..
>
> Should we just skip fio and run benchmarks on top of rocksDB and kafka? I=
 was
> looking at mmtests recently and noticed that it goes and downloads mm rel=
evant
> applications and runs benchmarks on the chose benchmarks.

It takes a significant amount of time and trouble to build, run and underst=
and
benchmarks for these applications. Modeling the workloads using fio
minimizes the set-up work and would enable more developers to actually
run these things. The workload definitions could also help developers
understanding what sort of IO that these use cases generate.

There is already one mixed-lifetime benchmark in fsperf [7], more
could probably be added.
I'm looking into adding a lsm-tree workload.

Full, automated, application benchmarks(db_bech, sysbench, ..) would
be great to have as well of course.

[7] https://github.com/josefbacik/fsperf/blob/master/frag_tests/mixed-lifet=
imes.fio

Cheers,
Hans

>
> >
> > Once we have a set of benchmarks that we collectively care about, I thi=
nk we
> > can work towards generic data placement methods with some level of
> > confidence that it will actually work in practice.
> >
> > Creating a repository with a bunch of reclaim/gc stress tests and bench=
marks
> > would be beneficial not only for kernel file systems but also for user-=
space
> > and distributed file systems such as ceph.
>
> This would be very valuable. Ideally with input from consumers of the dat=
a
> placement APIS.
>
> >
> > Thanks,
> > Hans
> >
> > [1] https://urldefense.com/v3/__https://www.usenix.org/system/files/atc=
21-bjorling.pdf__;!!EwVzqGoTKBqv-0DWAJBm!WC4RGRyZ9YioNTLW94o29OSHK5LD8GlXL_=
2VKMGS7Z5e0cojtPDKfqU0iETvqHpyuKD6UpBapa6jkGmbktirD4LbAEY$
> > [2] https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=
=3D462cf2bb-27a7e781-462d79f4-74fe4860008a-ab419c0ae2c7fb34&q=3D1&e=3D66a35=
d4b-398f-4758-82c5-79f023ada0b4&u=3Dhttps*3A*2F*2Fgithub.com*2Fwesterndigit=
alcorporation*2Fzenfs__;JSUlJSU!!EwVzqGoTKBqv-0DWAJBm!WC4RGRyZ9YioNTLW94o29=
OSHK5LD8GlXL_2VKMGS7Z5e0cojtPDKfqU0iETvqHpyuKD6UpBapa6jkGmbktirB3JeheY$
> > [3] https://urldefense.com/v3/__https://lwn.net/Articles/726477/__;!!Ew=
VzqGoTKBqv-0DWAJBm!WC4RGRyZ9YioNTLW94o29OSHK5LD8GlXL_2VKMGS7Z5e0cojtPDKfqU0=
iETvqHpyuKD6UpBapa6jkGmbktirPUCJNUc$
> > [4] https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=
=3D7eb17e0e-1f3a6b34-7eb0f541-74fe4860008a-0e46d2a09227c132&q=3D1&e=3D66a35=
d4b-398f-4758-82c5-79f023ada0b4&u=3Dhttps*3A*2F*2Flpc.events*2Fevent*2F16*2=
Fcontributions*2F1231*2F__;JSUlJSUlJSU!!EwVzqGoTKBqv-0DWAJBm!WC4RGRyZ9YioNT=
LW94o29OSHK5LD8GlXL_2VKMGS7Z5e0cojtPDKfqU0iETvqHpyuKD6UpBapa6jkGmbktirgbmZX=
I0$
> > [5] https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=
=3D19cdffac-7846ea96-19cc74e3-74fe4860008a-1121f5b082abfbe3&q=3D1&e=3D66a35=
d4b-398f-4758-82c5-79f023ada0b4&u=3Dhttps*3A*2F*2Fgithub.com*2FOpenMPDK*2FF=
lexAlloc__;JSUlJSU!!EwVzqGoTKBqv-0DWAJBm!WC4RGRyZ9YioNTLW94o29OSHK5LD8GlXL_=
2VKMGS7Z5e0cojtPDKfqU0iETvqHpyuKD6UpBapa6jkGmbktirL2CmpSE$
> > [6] https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=
=3D6ed08255-0f5b976f-6ed1091a-74fe4860008a-2a012b612f36b36a&q=3D1&e=3D66a35=
d4b-398f-4758-82c5-79f023ada0b4&u=3Dhttps*3A*2F*2Fgithub.com*2Ffacebook*2Fr=
ocksdb__;JSUlJSU!!EwVzqGoTKBqv-0DWAJBm!WC4RGRyZ9YioNTLW94o29OSHK5LD8GlXL_2V=
KMGS7Z5e0cojtPDKfqU0iETvqHpyuKD6UpBapa6jkGmbktirJuN380k$
