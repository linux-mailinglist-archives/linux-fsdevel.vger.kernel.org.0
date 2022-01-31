Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352874A4A3F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 16:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238668AbiAaPRP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 10:17:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42228 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231818AbiAaPRO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:17:14 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VDWGKQ028528;
        Mon, 31 Jan 2022 15:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=reBDMmGA0Xz4e1icmQ/D5gOkApfNiGa7he3g9WfRYa8=;
 b=MHP9l+VelKcTzDFnOIlKh+J+SFtYLk+H/mYTRJnvFWUGPFO/kZxhUkV6RrafJ6oq3U4I
 le9rO3iUa6Pc8KmzQQjZ8LEftIxVJcB/u9/OMf8ZG9fgxL+OeQ/Ggl6BCZuwz08xKPWO
 LOfYHqMV3hZzpW1Ad4gpIHM+59TW8b41YhnwpM3Nayts2NKDnjEAd+lUTpv0Yzupo2l7
 K0svO4aHQbZ5g9PkCCjra/EiOLxmrEjzGKGe3QZxwJct760UeMuJuK2yN41UClvIh0Fm
 WCriK2cU3P7BU6qmBW1TybCpeN50dfLuQbAHws8pb9xon1SefCViZzWtlTDlyimZ03KJ HA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dxgr6af0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 15:17:10 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20VDpBMi018214;
        Mon, 31 Jan 2022 15:17:10 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dxgr6aey1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 15:17:10 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20VFCDTr009222;
        Mon, 31 Jan 2022 15:17:08 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3dvw79csvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 15:17:08 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20VFH6mg43974922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 15:17:06 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14AF1AE058;
        Mon, 31 Jan 2022 15:17:06 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A0ADAE057;
        Mon, 31 Jan 2022 15:17:05 +0000 (GMT)
Received: from localhost (unknown [9.43.5.245])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 31 Jan 2022 15:17:05 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 0/6] ext4: fast_commit fixes and some minor cleanups
Date:   Mon, 31 Jan 2022 20:46:49 +0530
Message-Id: <cover.1643637037.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NmAkxQmcW7uIzAiAEaGqDahzW1txPhf2
X-Proofpoint-ORIG-GUID: QQsiCwijM5mhp7unt12oMSwddXrUFFcn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_06,2022-01-31_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=633 suspectscore=0
 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310099
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Please find this small patch series which fixes one of the issue (causing data
abort exception) identified with fast_commit and flex_bg.

Although I have given -g quick, log group a run and didn't see any surprise
there. But a careful review in Patch-1 & Patch-6 will surely help! :)

Will shortly send out the fstest patch, which could trigger this.

Patch details
==============

Patch-1: Fixes a data abort which could happen during recovery with flex_bg
feature. This might be even needed to cc to stable, right?

Patch-[2-5]: Minor cleanups

Patch[6]: Good to have to avoid any accidental set/clear of critical FS Metadata

Ritesh Harjani (6):
  ext4: Fixes ext4_mb_mark_bb() with flex_bg with fast_commit
  ext4: Implement ext4_group_block_valid() as common function
  ext4: Use in_range() for range checking in ext4_fc_replay_check_excluded
  ext4: No need to test for block bitmap bits in ext4_mb_mark_bb()
  ext4: Refactor ext4_free_blocks() to pull out ext4_mb_clear_bb()
  ext4: Add extra check in ext4_mb_mark_bb() to prevent against possible corruption

 fs/ext4/block_validity.c |  31 ++++++
 fs/ext4/ext4.h           |   3 +
 fs/ext4/fast_commit.c    |   4 +-
 fs/ext4/mballoc.c        | 235 +++++++++++++++++++++++----------------
 4 files changed, 176 insertions(+), 97 deletions(-)

--
2.31.1

