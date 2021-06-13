Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CC63A5A66
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Jun 2021 22:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbhFMUoK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Jun 2021 16:44:10 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:35673 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbhFMUoJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Jun 2021 16:44:09 -0400
Received: by mail-qk1-f179.google.com with SMTP id g19so3826725qkk.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Jun 2021 13:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QvykIJqEAp8HJMZf5kyxahPhLMNb6L7kGzsfP7iecYc=;
        b=V3aSJ2iPqSTAV7wJfWDo07tkq49CcIjeHxh0Ph/05GIpo+UsMok4fHPnoeAjFpM4zP
         UpRCbqdPv+1/NbaFeQT1zDCP347+DiT6OWf5Vv/g2QQiDay/ITPyS21jUe+CYvkKQuiW
         dqQ2b1EIfEgg91l6i26udI9XtJj1jx1okjbzTV19nvwOYtnpkjJs9mOfpSugMuGTH5CK
         nos8r5vB1KKm5bIJkw5K5l7aYTQoNuMV51LkYh4zVTJeDZT6x/blTy2Cru/ad6AUWLvr
         DRhIRlbpOqfREOAcaWlk6YM92bpnHd7GsBGHwNSsATsQ4BNxKz7TRFWAbzB+rcJqt8la
         zXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QvykIJqEAp8HJMZf5kyxahPhLMNb6L7kGzsfP7iecYc=;
        b=BBbORWUVt/bYBv8497d723UJymF3kJOQNvuqOs2J6/C7fy9O7QeiDVcckOndvWPMV7
         qhEVqxIuJ6UsSVgUC8q26ASRTcCvlMhnTUupY1eRuibSG3ek/BwehYElNzMYjTlcd3mV
         1RKJ5KkLiQ6zJ3pFc9bNwyAORM0y9rLZGqSYN3kfgdIkyqElM7oLEeCG1MPQ2TiTQRAw
         RnYYWRBW2G9rWhz5SBKx50a2G77BM/zKHqCxbCeurV/guADS9wUtTeLrOZEtYV7jzZmL
         6njUsNcuasPl1ZTXlDKiWzWXsrl2vpVkXNAR+bjXa32+dZynwAaxBEQ0UKY4SAnBGpKg
         SOSg==
X-Gm-Message-State: AOAM531l78xtqriftawhqZq389RlFqz+3tJcVkTPJ8qCanAsK5/zmmuQ
        yie+eC6wQgdzTKq4QJlg/ArPWA==
X-Google-Smtp-Source: ABdhPJxNb0++Phs0BLDYDMHft/xFHGX7Nktb07m0tN492Eg1H5XGwecr+wHe0iGPlu6KVv9y8jPUjg==
X-Received: by 2002:ae9:ef03:: with SMTP id d3mr6667524qkg.391.1623616867799;
        Sun, 13 Jun 2021 13:41:07 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:42f0:6600:6d23:ba39:5608:8e4d])
        by smtp.gmail.com with ESMTPSA id s133sm8792135qke.97.2021.06.13.13.41.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jun 2021 13:41:07 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: [LSF/MM/BPF TOPIC] SSDFS: LFS file system without GC operations +
 NAND flash devices lifetime prolongation
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <55d3434d-6837-3a56-32b7-7354e73eb258@gmail.com>
Date:   Sun, 13 Jun 2021 13:41:04 -0700
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org, Ric Wheeler <ricwheeler@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8FFB4717-DECC-49CE-AB91-209A885BA1AA@dubeyko.com>
References: <55d3434d-6837-3a56-32b7-7354e73eb258@gmail.com>
To:     lsf-pc@lists.linux-foundation.org
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I would like to discuss SSDFS file system [1] architecture. The =
architecture of file system has ben designed to be the LFS file system =
that can: (1) exclude the GC overhead, (2) prolong NAND flash devices =
lifetime, (3) achieve a good performance balance even if the NAND flash =
device's lifetime  is a priority. I wrote a paper [5] that contains =
analysis of possible approaches to prolong NAND flash device's lifetime =
and deeper explanation of SSDFS file system architecture.

The fundamental concepts of SSDFS:

[LOGICAL SEGMENT] Logical segment is always located at the same position =
of the volume. And file system volume can be imagined like a sequence of =
logical segments on the fixed positions. As a result, every logical =
block can be described by logical extent {segment_id, =
block_index_inside_segment, length}. It means that metadata information =
about position of logical block on the volume never needs to be updated =
because it will always live at the same logical segment even after =
update (COW policy). This concept completely excludes block mapping =
metadata structure updates that could result in decreasing the write =
amplification factor. Because, COW policy requires frequent updates of =
block mapping metadata structure.

[LOGICAL ERASE BLOCK] Initially, logical segment is an empty container =
that is capable to contain one or several erase blocks. Logical erase =
block can be mapped into any =E2=80=9Cphysical=E2=80=9D erase block. =
=E2=80=9CPhysical=E2=80=9D erase block means a contiguous sequence of =
LBAs are aligned on erase block size. There is mapping table that =
manages the association of logical erase blocks (LEB) into =
=E2=80=9Cphysical=E2=80=9D erase blocks (PEB). The goal of LEB and =
mapping table is to implement the logical extent concept. The goal to =
have several LEBs into one segment is to improve performance of I/O =
operations. Because, PEBs in the segment can be located into different =
NAND dies on the device and can be accessed through different device=E2=80=
=99s channels.

[SEGMENT TYPE] There are several segment types on the volume =
(superblock, mapping  table, segment bitmap, b-tree node, user data). =
The goal of various segment types is to make PEB=E2=80=99s =
=E2=80=9Ctemperature=E2=80=9D more predictable and to compact/aggregate =
several pieces of data into one NAND page. For example, several small =
files, several compressed logical blocks, or several compressed b-tree =
nodes can be aggregated into one NAND page. It means that several pieces =
of data can be aggregated into one write/read (I/O) request and it is =
the way to decrease the write amplification factor. To make PEB=E2=80=99s =
=E2=80=9Ctemperature" more predictable implies that aggregation of the =
same type of data into one segment can make more stable/predictable =
average number of update/read I/O requests for the same segment type. As =
a result, it could decrease GC activity and to decrease the write =
amplification factor.

[LOG] Log is the central part of techniques to manage the write =
amplification factor. Every PEB contains one log or sequence of logs. =
The goal of log is to aggregate several pieces of data into one NAND =
page to decrease the write amplification factor. For example, several =
small files or several compressed logical blocks can be aggregated into =
one NAND page. An offset transaction table is the metadata structure =
that converts the logical block ID (LBA) into the offset inside of the =
log where a piece of data is stored. Log is split on several areas =
(diff-on-write area, journal area, main area) with the goal to store the =
data of different nature. For example, main area could store not =
compressed logical block, journal area could aggregate small files or =
compressed logical blocks into one NAND page, and diff-on-wrtite area =
could aggregate small updates of different logical blocks into one NAND =
page. The different area types have goal to distinguish =
=E2=80=9Ctemperature=E2=80=9D of data and to average the =
=E2=80=9Ctemperature=E2=80=9D of area. For example, diff-on-write area =
could be more hot than journal area. As a result, it is possible to =
expect that, for example, diff-on-write area could be completely =
invalidated by regular updates of some logical blocks without necessity =
to use any GC activity.

[MIGRATION SCHEME] Migration scheme is the central technique to =
implement the logical extent concept and to exclude the necessity in GC =
activity. If some PEB is exhausted by logs (no free space) then it needs =
to start the migration for this PEB. Because it is used compression and =
compaction schemes for the metadata and user data then real data volume =
is using only portion of the PEB=E2=80=99s space. It means that it is =
possible to reserve another PEB in mapping table with the goal to =
associate two PEBs for migration process (exhausted PEB is the source =
and clean PEB is the destination). Every update of some logical block =
results in storing new state in the destination PEB and invalidation of =
logical block in the exhausted one. Generally speaking, it means that =
regular I/O operations are capable to completely invalidate the =
exhausted PEB for the case of =E2=80=9Chot" data. Finally, invalidated =
PEB can be erased and to marked as clean and available for new write =
operations. Another important point that even after migration the =
logical block is still living in the same segment. And it doesn=E2=80=99t =
need to update metadata in block mapping metadata structure because =
logical extent has actual state. The offset translation table are =
keeping the actual position of logical block in the PEB space.

[MIGRATION STIMULATION] However, not every PEB can migrate completely =
under pressure of regular I/O operations (for example, in the case of =
=E2=80=9Cwarm=E2=80=9D or =E2=80=9Ccold=E2=80=9D data). So, SSDFS is =
using the migration stimulation technique as complementary to migration =
scheme. It means that if some LEB is under migration then a flush thread =
is checking the opportunity to add some additional content into the log =
under commit. If flush thread has received a request to commit some log =
then it has the content of updated logical blocks that have been =
requested to be updated. However, it is possible that available content =
cannot fill a whole NAND page completely (for example, it can use only 2 =
KB). And if there are some valid logical blocks in the exhausted PEB =
then it is possible to compress and to add the content of such logical =
block into the log under commit. Finally, every log commit can be =
resulted by migration additional logical blocks from exhausted PEB into =
new one. As a result, regular update (I/O) operations can completely =
invalidate the exhausted PEB without the necessity in GC activity at =
all. The important point here that compaction technique can decrease the =
amount of write requests. And exclusion of GC activity results in =
decreasing of I/O operations are initiated by GC. It is possible to =
state that migration scheme and migration stimulation techniques are =
capable to significantly decrease the write amplification factor.

[GC] SSDFS has several GC threads but the goal of these threads is to =
check the state of segments, to stimulate the slow migration process, =
and to destroy already not in use the in-core segment objects. There is =
segment bitmap metadata structure that is tracking the state of segments =
(clean, using, used, pre-dirty, dirty). Every GC thread is dedicated to =
check the segments in similar state (for example, pre-dirty). Sometimes, =
PEB migration process could start and then to be stuck for some time =
because of absence of update requests for this particular PEB under =
migration. The goal of GC threads is to find such PEBs and to stimulate =
migration of valid blocks from exhausted PEB to clean one. But the =
number of GC initiated I/O requests could be pretty negligible because =
GC selects the segments that have no consumers right now. Migration =
scheme and migration stimulation could manage around 90% of the all =
necessary migration and cleaning operations.

[COLD DATA] SSDFS never moves the PEBs with cold data. It means that if =
some PEB with data is not under migration and doesn=E2=80=99t receive =
the update requests then SSDFS leaves such PEBs untouched. Because, FTL =
could manage error-correction and moving erase blocks with cold data in =
the background inside of NAND flash device. Such technique could be =
considered like another approach to decrease the write amplification =
factor.

[B-TREE] Migration scheme and logical extent concept provide the way to =
use the b-trees. The inodes tree, dentries trees, and extents trees are =
implemented as b-trees. And this is important technique to decrease the =
write amplification factor. First of all, b-tree provides the way to =
exclude the metadata reservation because it is possible to add the =
metadata space on b-tree=E2=80=99s node basis. Additionally, SSDFS is =
using three type of nodes: (1) leaf node, (2) hybrid node, (3) index =
node. The hybrid node includes as metadata records as index records that =
are the metadata about another nodes in the tree. So, the hybrid node is =
the way to decrease the number of nodes for the case of small b-trees. =
As a result, it can decrease the write amplification factor and decrease =
the NAND flash wearing that could result in prolongation of NAND flash =
device lifetime.=20

[PURE LFS] SSDFS is pure LFS file system without any in-place update =
areas. It follows COW policy in any areas of the volume. Even =
superblocks are stored into dedicated segment as a sequence. Moreover, =
every header of the log contains copy of superblock that can be =
considered like a reliability technique. It is possible to use two =
different techniques of placing superblock segments on the volume. These =
segments could live in designated set of segments or could be =
distributed through the space of the volume. However, the designated set =
of segments could guarantee the predictable mount time and to decrease =
the read disturbance.

[INLINE TECHNIQUES] SSDFS is trying to use inline techniques as much as =
possible. For example, small inodes tree can be kept in the superblock =
at first. Small dentries and extents tree can be kept in the inode as =
inline metadata. Small file=E2=80=99s content can be stored into inode =
as inline data. It means that it doesn=E2=80=99t need to allocate =
dedicated logical block for small metadata or user data. So, such inline =
techniques are able to combine several metadata (and user data) pieces =
into one I/O request and to decrease write amplification factor.

[MINIMUM RESERVATIONS] There are two metadata structures (mapping table =
and segment bitmap) that require reservation on the volume. These =
metadata structures=E2=80=99 size is defined by volume size and erase =
block, segment sizes. So, as a result, these metadata structures =
describe the current state of the volume. But the rest metadata (inodes =
tree, dentries trees, xattr trees, and so on) are represented by b-trees =
and it doesn=E2=80=99t need to be reserved beforehand. So, it can be =
allocated by nodes in the case when old ones are exhausted. Finally, =
NAND flash device doesn=E2=80=99t need to keep the reserved metadata =
space that, currently, contains nothing. As a result, FTL doesn=E2=80=99t =
need to manage this NAND pages and it could decrease NAND flash wearing. =
So, it could be considered like technique to prolong NAND flash =
device=E2=80=99s lifetime.

[MULTI-THREADED ARCHITECTURE] SSDFS is based on multi-threaded approach. =
It means that there are dedicated threads for some tasks. For example, =
there is special thread that is sending TRIM or erase operation requests =
for invalidated PEBs in the background. Another dedicated thread is =
doing the extents trees invalidation in the background. Also, there are =
several GC threads (in the background) that are tracking the necessity =
to stimulate migration in segments and to destroy the in-core segment =
objects in the case of absence of consumers of these segments. But this =
technique is directed to manage the performance mostly.=20

Thanks,
Slava.

[1] www.ssdfs.org
[2] SSDFS tools: https://github.com/dubeyko/ssdfs-tools.git
[3] SSDFS driver: https://github.com/dubeyko/ssdfs-driver.git
[4] SSDFS Linux kernel: https://github.com/dubeyko/linux.git
[5] https://arxiv.org/abs/1907.11825

