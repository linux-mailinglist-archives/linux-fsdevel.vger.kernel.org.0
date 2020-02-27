Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C64771715C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 12:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgB0LLC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 06:11:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20188 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728902AbgB0LLB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 06:11:01 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RB9UmW121676
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2020 06:11:01 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ydkfab8xj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2020 06:11:00 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 27 Feb 2020 11:10:58 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 27 Feb 2020 11:10:54 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01RB9uIc43975036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 11:09:56 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AFF954204B;
        Thu, 27 Feb 2020 11:10:53 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8AF142042;
        Thu, 27 Feb 2020 11:10:50 +0000 (GMT)
Received: from dhcp-9-199-158-169.in.ibm.com (unknown [9.199.158.169])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Feb 2020 11:10:50 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org
Cc:     adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, hch@infradead.org, cmaiolino@redhat.com,
        david@fromorbit.com, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv4 6/6] Documentation: Correct the description of FIEMAP_EXTENT_LAST
Date:   Thu, 27 Feb 2020 16:40:27 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1582800839.git.riteshh@linux.ibm.com>
References: <cover.1582800839.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022711-0020-0000-0000-000003AE14F8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022711-0021-0000-0000-0000220633C0
Message-Id: <460a7ad4e20ccf396a0b3b52b7386e276bc5016e.1582800839.git.riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-27_03:2020-02-26,2020-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=662
 suspectscore=3 malwarescore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270090
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently FIEMAP_EXTENT_LAST is not working consistently across
different filesystem's fiemap implementations. So add more information
about how else this flag could set in other implementation.

Also in general, user should not completely rely on this flag as
such since it could return false value for e.g.
when there is a delalloc extent which might get converted during
writeback, immediately after the fiemap calls return.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 Documentation/filesystems/fiemap.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/fiemap.txt b/Documentation/filesystems/fiemap.txt
index f6d9c99103a4..fedfa9b9dde5 100644
--- a/Documentation/filesystems/fiemap.txt
+++ b/Documentation/filesystems/fiemap.txt
@@ -71,8 +71,7 @@ allocated is less than would be required to map the requested range,
 the maximum number of extents that can be mapped in the fm_extent[]
 array will be returned and fm_mapped_extents will be equal to
 fm_extent_count. In that case, the last extent in the array will not
-complete the requested range and will not have the FIEMAP_EXTENT_LAST
-flag set (see the next section on extent flags).
+complete the requested range.
 
 Each extent is described by a single fiemap_extent structure as
 returned in fm_extents.
@@ -96,7 +95,7 @@ block size of the file system.  With the exception of extents flagged as
 FIEMAP_EXTENT_MERGED, adjacent extents will not be merged.
 
 The fe_flags field contains flags which describe the extent returned.
-A special flag, FIEMAP_EXTENT_LAST is always set on the last extent in
+A special flag, FIEMAP_EXTENT_LAST *may be* set on the last extent in
 the file so that the process making fiemap calls can determine when no
 more extents are available, without having to call the ioctl again.
 
@@ -115,8 +114,9 @@ data. Note that the opposite is not true - it would be valid for
 FIEMAP_EXTENT_NOT_ALIGNED to appear alone.
 
 * FIEMAP_EXTENT_LAST
-This is the last extent in the file. A mapping attempt past this
-extent will return nothing.
+This is generally the last extent in the file. A mapping attempt past this
+extent may return nothing. In some implementations this flag is also set on
+the last dataset queried by the user (via fiemap->fm_length).
 
 * FIEMAP_EXTENT_UNKNOWN
 The location of this extent is currently unknown. This may indicate
-- 
2.21.0

