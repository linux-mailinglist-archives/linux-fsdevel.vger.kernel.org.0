Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289F4490864
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 13:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239631AbiAQMMS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 07:12:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11664 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239566AbiAQMMP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:12:15 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20HBvDxI020655;
        Mon, 17 Jan 2022 12:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=V95raB8ppO8Fusvf2gtVByfjplbM9EUlj7+fnCjiQcc=;
 b=cI/Cl+Gh1nHQW/vlASDKS80dtYt79gEjlh3b7rT3FVEOSL0esnrBiR1O2QCp2Pk2MB27
 wEP9OyalnauluejijKhu6kJeI+jjD7DT3MKOdQlDDwSnI9t1hQ4tFxNw/3j2J7fQF992
 71nis0b2Jgc7ngoTcGyr845fVIa2HFHhnMcY7gnjr4zC5U15pJIm0qXwknQCOoQbcAIO
 m97VqDgwQ1Broad5hf6/ZZVC38huNrmx9CgCDZw9b5DOfZfolawpl+EeO4G/tzEWET0K
 xCkALOO3iSP0vhpUwc8TWRoy+1jhLoG6vkeGIESx6dhxqHEtAJAGl/akU2iPKwX/0mHi dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dn81p0a3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 12:12:06 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20HBwa8d024625;
        Mon, 17 Jan 2022 12:12:05 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dn81p0a2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 12:12:05 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20HC8mi9005672;
        Mon, 17 Jan 2022 12:12:03 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 3dknw92xjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jan 2022 12:12:03 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20HCC1gr36634954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jan 2022 12:12:01 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E5544C052;
        Mon, 17 Jan 2022 12:12:01 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C0614C050;
        Mon, 17 Jan 2022 12:12:00 +0000 (GMT)
Received: from localhost (unknown [9.43.45.117])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Jan 2022 12:12:00 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, tytso@mit.edu,
        Eric Whitney <enwlinux@gmail.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: [PATCHv2 1/5] ext4: Fix error handling in ext4_restore_inline_data()
Date:   Mon, 17 Jan 2022 17:41:47 +0530
Message-Id: <9f4cd7dfd54fa58ff27270881823d94ddf78dd07.1642416995.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1642416995.git.riteshh@linux.ibm.com>
References: <cover.1642416995.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SHN62bA0ceGNe9yNseOOE-FN03yf6EiB
X-Proofpoint-GUID: l_LVHawzBRviS5QmPRIGasB9agPjOUKf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-17_05,2022-01-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201170077
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While running "./check -I 200 generic/475" it sometimes gives below
kernel BUG(). Ideally we should not call ext4_write_inline_data() if
ext4_create_inline_data() has failed.

<log snip>
[73131.453234] kernel BUG at fs/ext4/inline.c:223!

<code snip>
 212 static void ext4_write_inline_data(struct inode *inode, struct ext4_iloc *iloc,
 213                                    void *buffer, loff_t pos, unsigned int len)
 214 {
<...>
 223         BUG_ON(!EXT4_I(inode)->i_inline_off);
 224         BUG_ON(pos + len > EXT4_I(inode)->i_inline_size);

This patch handles the error and prints out a emergency msg saying potential
data loss for the given inode (since we couldn't restore the original
inline_data due to some previous error).

[ 9571.070313] EXT4-fs (dm-0): error restoring inline_data for inode -- potential data loss! (inode 1703982, error -30)

Reported-by: Eric Whitney <enwlinux@gmail.com>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inline.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 39a1ab129fdc..d091133a4b46 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1133,7 +1133,15 @@ static void ext4_restore_inline_data(handle_t *handle, struct inode *inode,
 				     struct ext4_iloc *iloc,
 				     void *buf, int inline_size)
 {
-	ext4_create_inline_data(handle, inode, inline_size);
+	int ret;
+
+	ret = ext4_create_inline_data(handle, inode, inline_size);
+	if (ret) {
+		ext4_msg(inode->i_sb, KERN_EMERG,
+			"error restoring inline_data for inode -- potential data loss! (inode %lu, error %d)",
+			inode->i_ino, ret);
+		return;
+	}
 	ext4_write_inline_data(inode, iloc, buf, 0, inline_size);
 	ext4_set_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
 }
-- 
2.31.1

