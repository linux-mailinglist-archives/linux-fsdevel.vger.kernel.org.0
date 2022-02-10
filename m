Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAE94B1690
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 20:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbiBJTwP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 14:52:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbiBJTwO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:52:14 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622A45F4D
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Feb 2022 11:52:14 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id b22so5970879qkk.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Feb 2022 11:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=MXxOAsQ6XI4ryPHNoJ4eXb3zK1gyAxL6PSEYnSJMkV4=;
        b=xyHPEuMD3wLCqAsOqMxt3Ka/TLPunjJCfRdKh4Cpqyyz8gF4q7A2zZqTpd3uQxViyE
         NexWV9sNMQzT15m/fs6PCSAva0IBaSIINJZ7cWWhAkuSuDdUISAhBRGTk0s3/vA5H4gs
         0BaeBaKtOCrCAFF/A3m17BXpcTrFq19g0p7RUUXu57hnWg6bXl9I051mVuFhYrzvXlzY
         c1HBYgiwy2XsmPTMD+2POyEkDWJlNy0BdxMCaQTJ6gm3qMiMQbq1jDAQ5Oa8vo7Rmu8n
         l4b9KB5FvdXkbG6kZxXj03sWMgBZ481HoJk8fye27hoPu64Heo6bsM5i/wXOb/aaYcqK
         bkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=MXxOAsQ6XI4ryPHNoJ4eXb3zK1gyAxL6PSEYnSJMkV4=;
        b=uuwa0yDdGgTRXqEqO1PYe7PLk8regmyTB6abfimNtOu8uPNHXzSk7nLpHzd5Tsd45V
         3jWNXO/YYwZUCbnXjg5c7FdRgu58Un/GQeI+H95bA2HzKXJKwEyqOJRt4mefuoy8byq7
         8n+syVei+kIxulNMpAStGxgz/29Ac3Lqbv0gCze3/p72XCwQlozoW4FE4yg587b099bt
         3riAQqzvXX+wtQXoS3McT3lIG2iDQ65N3X4Aa7gfv5+O37Wj8uv/w+x7G7XxzYWr+9+q
         V7g/u5/SH4YRl/wLqdnvsmpko+3kMn7Kr8NX8P13gqhuIhoRRGdUofHhnQXf1LhCTOSv
         OXpw==
X-Gm-Message-State: AOAM531hsuR+FebI/6uXR5ucQJAQAGP9tESGqAqeP/GiCZTUJ6ir1fCt
        0OkkoUEnpTTsSmYGdlSZUoTu1Q==
X-Google-Smtp-Source: ABdhPJx4dOL0XrRQsX8bxPVBsbNWw43+oSfX+W6UwE0uGq/tnHt1p0wuSXLfJq+6XYQymzTQX2Sn1g==
X-Received: by 2002:a37:9c45:: with SMTP id f66mr4546650qke.379.1644522733384;
        Thu, 10 Feb 2022 11:52:13 -0800 (PST)
Received: from smtpclient.apple ([2600:1700:42f0:6600:cd8a:8634:7b18:da1e])
        by smtp.gmail.com with ESMTPSA id p70sm10101059qka.62.2022.02.10.11.52.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Feb 2022 11:52:13 -0800 (PST)
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: [LSF/MM/BPF TOPIC] SSDFS: flash-friendly file system with highly
 minimized GC activity, diff-on-write, and deduplication
Message-Id: <5E14B452-8B0D-4418-82C6-0159943E1C75@bytedance.com>
Date:   Thu, 10 Feb 2022 11:52:11 -0800
Cc:     Viacheslav Dubeyko <slava@dubeyko.com>,
        Cong Wang <cong.wang@bytedance.com>,
        linux-fsdevel@vger.kernel.org
To:     lsf-pc@lists.linux-foundation.org
X-Mailer: Apple Mail (2.3693.40.0.1.81)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I would like to discuss SSDFS file system [1] architecture and to share =
the current status. The architecture of file system has been designed to =
be the LFS file system that can: (1) exclude the GC overhead, (2) =
prolong NAND flash devices lifetime, (3) achieve a good performance =
balance even if the NAND flash device's lifetime is a priority. I wrote =
a paper [5] that contains explanation of approaches to prolong NAND =
flash device's lifetime and SSDFS file system architecture at whole.

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

