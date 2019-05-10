Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7003D19816
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2019 07:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfEJFcI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 May 2019 01:32:08 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:19784 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbfEJFcH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 May 2019 01:32:07 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190510053204epoutp04d05917be1b7dd9b3705f52e9565110d8~dO16yU5Fc0693306933epoutp047
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2019 05:32:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190510053204epoutp04d05917be1b7dd9b3705f52e9565110d8~dO16yU5Fc0693306933epoutp047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557466324;
        bh=KakuJdCn1X04cvo+OPpSwDWAoomNlnwTJIRTnYYBv6U=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=r+Hu5PS0BK6fvvWLaanScq6bC0wz55yHmXEn3RDv0VeqcWuENuPw57SSrEnk2kcWc
         Geb1YjRitdP0yUNJxsCkDpwwhYrnpm9lUVoqzvyfUhzrzlXwlMoO4+O67pR2EHible
         FlwphkxiVsi8NQ8eCBjtgCM8lyVOLN+3w4npXCwg=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20190510053203epcas5p13c5af3d4e765a7620fd7b80b356dd51c~dO16f0SwO1510415104epcas5p1J;
        Fri, 10 May 2019 05:32:03 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.68.04067.3DC05DC5; Fri, 10 May 2019 14:32:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20190510053203epcas5p39e4eb4a5996e0461da380399c5322f6c~dO16N2q8S1408014080epcas5p3J;
        Fri, 10 May 2019 05:32:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190510053203epsmtrp266e4f71343665729e467acaaadbad96d~dO16NNTab2509725097epsmtrp2p;
        Fri, 10 May 2019 05:32:03 +0000 (GMT)
X-AuditID: b6c32a4b-78bff70000000fe3-0e-5cd50cd31896
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        50.C3.03692.3DC05DC5; Fri, 10 May 2019 14:32:03 +0900 (KST)
Received: from JOSHIK01 (unknown [107.111.93.135]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20190510053202epsmtip21bdeaf626cdde8d26da59cb5caeab57c~dO15Nik400291002910epsmtip2J;
        Fri, 10 May 2019 05:32:02 +0000 (GMT)
From:   "kanchan" <joshi.k@samsung.com>
To:     <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-ext4@vger.kernel.org>
In-Reply-To: <1556191202-3245-1-git-send-email-joshi.k@samsung.com>
Subject: RE: [PATCH v5 0/7] Extend write-hint framework, and add write-hint
 for Ext4 journal
Date:   Fri, 10 May 2019 11:01:47 +0530
Message-ID: <031601d506f1$b2956d80$17c04880$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJoSeMIlXjPMuci1lQDnd0IsY+e8wLu+qiYpSXTDJA=
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7bCmuu5lnqsxBs/vaFvsvaVtMXPeHTaL
        PXtPslhc3jWHzWL+sqfsDqwem5fUe3zeJBfAFMVlk5Kak1mWWqRvl8CV8WP/B7aCXTIVX/5s
        YW1gvCPWxcjJISFgIrFh7ReWLkYuDiGB3YwSOxauhnI+MUocOX+UEcL5xiix7+JqZpiW478m
        sEEk9jJK9J69AVX1nFHizpYFLCBVbAKqEvd+9IJViQgsY5Q49/kJG0iCU8BZYsPie2CjhAXi
        JBruTmAHsVmAGrZ3NoE18wpYSqw9coYdwhaUODnzCVicWUBbYtnC11BnKEjs/nSUFcQWEbCS
        aOqazAZRIy7x8ugRdpDFEgIb2CT+3emGanCR6Di5hRXCFpZ4dXwLO4QtJfH53V42CLtY4ted
        o8wQzR2MEtcbZrJAJOwlLu75y9TFyAG0QVNi/S59iGV8Er2/n4CFJQR4JTrahCCqFSXuTXoK
        tUpc4uGMJVC2h8TDt5uhoTWNUWLKlsusExgVZiH5cxaSP2ch+WcWwuYFjCyrGCVTC4pz01OL
        TQuM81LL9YoTc4tL89L1kvNzNzGCE4uW9w7GTed8DjEKcDAq8fBa8F+JEWJNLCuuzD3EKMHB
        rCTCW6QDFOJNSaysSi3Kjy8qzUktPsQozcGiJM47ifVqjJBAemJJanZqakFqEUyWiYNTqoGx
        9+g9RclDM3QvrdF+3ybNXTP96qPICbo++WV8bp93C9j5X1PgOPmxx/ynN9Mj5t+75sin1u1p
        2yq2+0YPxy9O14vNyfmyrze//7hm35nd7SL3bUW/BqinXNCveCArIq29yDfv2tmy05Ke4pHv
        st6I2796Nmf3+Q1Mx5Z8nbSIoVnI2Gt+z9swJZbijERDLeai4kQAxrKziygDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsWy7bCSvO5lnqsxBjfPC1nsvaVtMXPeHTaL
        PXtPslhc3jWHzWL+sqfsDqwem5fUe3zeJBfAFMVlk5Kak1mWWqRvl8CVcejdCsaCNpmKr7se
        sDQwLhHrYuTkkBAwkTj+awJbFyMXh5DAbkaJHWsXs0MkxCWar/2AsoUlVv57zg5R9JRR4uWW
        AywgCTYBVYl7P3rBukUEVjFKLD6+G2rUFEaJzSufsoFUcQo4S2xYfI8ZxBYWiJFYP3khWJwF
        qHt7ZxPYJF4BS4m1R86wQ9iCEidnPgGLMwtoS/Q+bGWEsZctfM0McZKCxO5PR1lBbBEBK4mm
        rslsEDXiEi+PHmGfwCg0C8moWUhGzUIyahaSlgWMLKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz
        0vWS83M3MYKjQEtzB+PlJfGHGAU4GJV4eC34r8QIsSaWFVfmHmKU4GBWEuEt0gEK8aYkVlal
        FuXHF5XmpBYfYpTmYFES532adyxSSCA9sSQ1OzW1ILUIJsvEwSnVwOgoemRRXfusT+fm+0SV
        nbmarRxXcqa3P3grY89aO9VL09x15yzXkloRN1V0VVfreuvyHcYLQrSUV3QwXrM1P88RrM+7
        OrBXf6d7mN+t9fyfLr6r8Nm7OIulyFm0W7H+ZlSu4+y5+evYmlui16yeuf7n/6CUGm6nyUkf
        uX3dwr+/e946naH/khJLcUaioRZzUXEiAH7U1ld+AgAA
X-CMS-MailID: 20190510053203epcas5p39e4eb4a5996e0461da380399c5322f6c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20190425112347epcas2p1f7be48b8f0d2203252b8c9dd510c1b61
References: <CGME20190425112347epcas2p1f7be48b8f0d2203252b8c9dd510c1b61@epcas2p1.samsung.com>
        <1556191202-3245-1-git-send-email-joshi.k@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jens & other maintainers,

If this patch-set is in fine shape now, can it please be considered for mer=
ge in near future?

Thanks,

-----Original Message-----
From: Kanchan Joshi =5Bmailto:joshi.k=40samsung.com=5D=20
Sent: Thursday, April 25, 2019 4:50 PM
To: linux-kernel=40vger.kernel.org; linux-block=40vger.kernel.org; linux-nv=
me=40lists.infradead.org; linux-fsdevel=40vger.kernel.org; linux-ext4=40vge=
r.kernel.org
Cc: prakash.v=40samsung.com; anshul=40samsung.com; Kanchan Joshi <joshi.k=
=40samsung.com>
Subject: =5BPATCH v5 0/7=5D Extend write-hint framework, and add write-hint=
 for Ext4 journal

V5 series, towards extending write-hint/streams infrastructure for kernel-c=
omponents, and adding support for sending write-hint with Ext4/JBD2 journal=
.

Here is the history/changelog -

Changes since v4:
- Removed write-hint field from request. bi_write_hint in bio is used for
  merging checks now.
- Modified write-hint-to-stream conversion logic. Now, kernel hints are map=
ped
  to upper range of stream-ids, while user-hints continue to remain mapped =
to
  lower range of stream-ids.

Changes since v3:
- Correction in grouping related changes into patches
- Rectification in commit text at places

Changes since v2:
- Introduce API in block layer so that drivers can register stream info. Ad=
ded
  new limit in request queue for this purpose.
- Block layer does the conversion from write-hint to stream-id.
- Stream feature is not disabled anymore if device reports less streams tha=
n
  a particular number (which was set as 4 earlier).
- Any write-hint beyond reported stream-count turn to 0.
- New macro =22WRITE_LIFE_KERN_MIN=22 can be used as base by kernel mode co=
mponents.

Changes since v1:
- introduce four more hints for in-kernel use, as recommended by Dave chinn=
er
  & Jens axboe. This isolates kernel-mode hints from user-mode ones.
- remove mount-option to specify write-hint, as recommended by Jan kara &
  Dave chinner. Rather, FS always sets write-hint for journal. This gets ig=
nored
  if device does not support stream.
- Removed code-redundancy for write_dirty_buffer (Jan kara's review comment=
)

V4 patch:
https://lkml.org/lkml/2019/4/17/870

V3 patch:
https://marc.info/?l=3Dlinux-block&m=3D155384631909082&w=3D2

V2 patch:
https://patchwork.kernel.org/cover/10754405/

V1 patch:
https://marc.info/?l=3Dlinux-fsdevel&m=3D154444637519020&w=3D2


Kanchan Joshi (7):
  fs: introduce write-hint start point for in-kernel hints
  block: increase stream count for in-kernel use
  block: introduce API to register stream information with block-layer
  block: introduce write-hint to stream-id conversion
  nvme: register stream info with block layer
  fs: introduce APIs to enable passing write-hint with buffer-head
  fs/ext4,jbd2: add support for sending write-hint with journal

 block/blk-core.c            =7C 29 ++++++++++++++++++++++++++++-
 block/blk-merge.c           =7C  4 ++--
 block/blk-settings.c        =7C 12 ++++++++++++
 drivers/nvme/host/core.c    =7C 23 ++++++-----------------
 fs/buffer.c                 =7C 18 ++++++++++++++++--
 fs/ext4/ext4_jbd2.h         =7C  1 +
 fs/ext4/super.c             =7C  2 ++
 fs/jbd2/commit.c            =7C 11 +++++++----
 fs/jbd2/journal.c           =7C  3 ++-
 fs/jbd2/revoke.c            =7C  3 ++-
 include/linux/blkdev.h      =7C  8 ++++++--
 include/linux/buffer_head.h =7C  3 +++
 include/linux/fs.h          =7C  2 ++
 include/linux/jbd2.h        =7C  8 ++++++++
 14 files changed, 97 insertions(+), 30 deletions(-)

--
2.7.4


