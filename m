Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B523FD040
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 02:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243244AbhIAAPf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Aug 2021 20:15:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:28702 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243593AbhIAAOn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Aug 2021 20:14:43 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17VNaoSr019802;
        Wed, 1 Sep 2021 00:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=62YTA0ttGvq22kPIiBaz+LSbFDAMnJ6zoOcOhvW3BDM=;
 b=H1ur/3KCkAgP5ZvQIZcyrChR/VzC5rDKbmCVPBhbp7bNzDVypxapbwwVAvWJlkIcrLAY
 pXBTviZqnSafJjqEUAmNLNvkNw8Ca8sWlX7pIlig6ctbHmdqAgGo0/9+DEQaN2T9ksUS
 B6QKbTaGo9ncfQ2vqWRYuWeNLhoOsxUohTle9HQVD0B97UxJ66WtFGmEWZl38MdyQJgz
 mk69tpWIkFmPNbTgvEyFl2CgwIdddIozk46EckGrTF6H2wxhMX4yUDtUTin8zbaQV+8l
 JQsGqa1E/iZ3YVw5npxY5vQTjfnsS32kJutKZK6Bk7htQcxMIU0GC4LjHijC82VCfc/L hA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=62YTA0ttGvq22kPIiBaz+LSbFDAMnJ6zoOcOhvW3BDM=;
 b=TLC8qPwmkp24pbxEWlj111wbpf2hnoL51C5yp1AuU3RSizkIUsMXcM+gDtDLGOQKZk9A
 +uMVO1aId8Bv05UyshCH4QXU+Ez7doHXrx+R5/cCe3HEbM+crEtQjiiQ7n2FwjdZl4kA
 180/wd6KifhQYqI6Th8PDOc9zGirgrmufu41cSsxVv1b1STkyNW9/0YUQdQVeSDRue4A
 9o274K83J1bpyme0mD7KUiU5PVf3BCNVdQ913P7Zjy4t2s6fxGcaesauCMqFceujW776
 NOcbkZXCSRuXQKxlEtD9q95N1S6fDyMDvK8FtTVOq8Ieq3/XjxcqHO839ofT4VdxvhnD gA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3asf2mjpff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 00:13:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18106L7v179912;
        Wed, 1 Sep 2021 00:13:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by userp3030.oracle.com with ESMTP id 3arpf5c82d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 00:13:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzXrqjamF/buFD0Zoj50PLqCt9BeodykLXB+SJl2UDO6oA+ApO+58mYRGqEWb6+y9a80hUTNnGGZWgOz9akbb/52T99okKh6iadP+/0jh/U3sAKv9VkkNg8df37kCjA3DKy/kuvEvCkmj1+V0rSvhGDo0vmNWXZsCYU7bU+O6U+LIr4mjcMMed7+0NRGYySD19mYnMKu0V2E8V2QjnTrJ/6VvoD9ScWqjzWG8p39b0WEC9b0ffTp82zuR1hpV5sw0y1whuQzb+CIh2obg19eyTTIv3Hf7URdJJVWzYRoVNakLb6qLTnOe5PGcM7zozoKJPe4G6aJHHSpl4RAJapNbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62YTA0ttGvq22kPIiBaz+LSbFDAMnJ6zoOcOhvW3BDM=;
 b=ebSdyaYIsHjQ40JkWN7bfS1PxE9hrG1uQ9Rh0CJAoVw7hA+4x7x/JbgzmwSsTJFJmmLPLT1gTR6fMY0h7+ysvK8uXIE6spsukqLYucM1NQfYJGDGbmAwoMkl5xiEsGC+aHrlp0JSf7rQebe6zAooH3KIB7izLq+G1AhQmpeVt14Vfk/ktH3vB3lOv306jJwVpeEBoAwcUuei+VKsFiJn1iBYaCtJeO/bGR7trJB2qk+b4g6P3xTWPZDwpuR3FqEvqFacqLgKprEZZUh0BjGbwsxNwV0K9lsuiuVfuJNmnh76kDHJFVNVIRBK9kMZV01w9hACRrDqHrjci56hkbRnsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62YTA0ttGvq22kPIiBaz+LSbFDAMnJ6zoOcOhvW3BDM=;
 b=nvEBLUPGBJZqLjnd9g6H7p73g2pa6qXliZ/FuINoUjEqRTBXCD2eUb/ShkGO71GtluITNg7YGlySl9oGxjQxAeXnM/fXpKbEg7v8KeE9RZZDLzyRlctUnW/0K4A4kQTFu+jG/gtnKtmcjpvmBrMjT7QNqxiD9KHlfC1MkWnj1yw=
Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=oracle.com;
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH0PR10MB4955.namprd10.prod.outlook.com (2603:10b6:610:c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Wed, 1 Sep
 2021 00:13:43 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027%7]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 00:13:43 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Dmitry Kadashev <dkadashev@gmail.com>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] namei: Fix use after free in kern_path_locked
Date:   Tue, 31 Aug 2021 17:13:41 -0700
Message-Id: <20210901001341.79887-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0161.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::16) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (148.87.23.11) by SJ0PR13CA0161.namprd13.prod.outlook.com (2603:10b6:a03:2c7::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.10 via Frontend Transport; Wed, 1 Sep 2021 00:13:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dd2e87f-1492-4920-10d8-08d96cdd5b9d
X-MS-TrafficTypeDiagnostic: CH0PR10MB4955:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB4955DF2E1B6B9C943A63F482DBCD9@CH0PR10MB4955.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F+u1dlyj3R40bfatzXZ/sA8l2vYKOkhmvQaPX7DY9oTmOYlMdw21LUBwNbJ1?=
 =?us-ascii?Q?pf1PVgOd97SPeYs3qGNNcTXcOy/cvoxDcer9+N2bWcv81e4UGASE4efHmJRF?=
 =?us-ascii?Q?2c8MawEkhNGqdWkmMwkwAtlz4Cbjcezj2v6nCtOYgzTSzv0U2gycCX6xhPob?=
 =?us-ascii?Q?Vogq4QhsH8A4duF1P0jtE4Bcx3cdM37WXVUPe3HZbzKUWC6TxpWE+U44b9+P?=
 =?us-ascii?Q?aaxHCFqs6h6B5eZCSEVisbJIqi5W2+xY9bcWvuplAZbgzzERccCnOe6+Ocab?=
 =?us-ascii?Q?cFcO/ElgEn/IIrYzExPi2lgoLSKq4uRrr+EGFgw8rgJ47VgD4FzSfZaay2xE?=
 =?us-ascii?Q?NJltAYKLnZWExDzdfD9csx3M+DSN939FMGOdjJJ3z+18WWcrWmTtG42bpQer?=
 =?us-ascii?Q?tOzqpG56oqAu6dm+zn3Vgk/u7pmWMCHcyFhRYD7i0W/MNkPZyVN4Z2tcLeT3?=
 =?us-ascii?Q?MZA0raRKAmx39VctB2JrK7j3OYHOkaWzsD5fAkwLu2YbLCiElJrMPWOKktd1?=
 =?us-ascii?Q?MiwuxbBiKqb70qPymEsQoX+d/62WRoZpW98jWD7+EfRnL7+JXwoDovNN0AAo?=
 =?us-ascii?Q?BeNf+oBaCJTXEhKYc0DqNPXPJQ0b4TvQS7cKje+HHefLoTT6zhF6sdBXkY/N?=
 =?us-ascii?Q?qtltoaIez2Az66REahNm7JWm8afWWa9I7ck36iVKI+JMG1L0KqmbW/7AvTBw?=
 =?us-ascii?Q?Rsi5nx8ve5Xa0C3aV4iwyV/djzZPfCgXwb57DprSy1gyaDOtiBm6DOaF1xMC?=
 =?us-ascii?Q?g5TCT7p6ZqLTtNWiJFKeC0MCFnTcLkiKfeJmRo0Ii+8UpY00Bq4d6YsqO/7J?=
 =?us-ascii?Q?K0OMpElzFxIvT0eXfYk2VTFojnQTNtCTXer8uGbDsvdVQKX4rGlyJVIqLNBP?=
 =?us-ascii?Q?89LdqHddQSKajmC/4l7sewUfsXKP2e/r4MUJAPUngfo4Wc+pdgs1ab+hSZ6b?=
 =?us-ascii?Q?H48l1Wk7pQSn/I5v9OsEpS60HnTpjbpIuKFeTU7Tam4DVlZYZFmRLHE8y6j3?=
 =?us-ascii?Q?8vrCCk1H4rdcJ7B8oKl1EzmQIPznA/97L7t/rkf23uQMSuc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(39860400002)(346002)(396003)(376002)(136003)(366004)(38100700002)(38350700002)(83380400001)(52116002)(956004)(316002)(1076003)(6486002)(2616005)(110136005)(26005)(8676002)(6496006)(66556008)(66946007)(36756003)(66476007)(86362001)(103116003)(5660300002)(8936002)(186003)(4326008)(478600001)(2906002)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BhD5mT04watbGFKOICHu5HJYAszLm6BAznbVmiOmjEIQ+O5//BheDH/xX+1c?=
 =?us-ascii?Q?T/X5L7MKzQjVQ53BL7H7U6gMuzZ4TF5/r6y1CGnno2+SpThxQ/aFIot17Lq4?=
 =?us-ascii?Q?L1avgJ/xrcg/phxagxU/tdPbV+cZEc4FUsmzwCuxqJdB6yoAWMV8RpVbu3Iw?=
 =?us-ascii?Q?sMw9vXJP2koTvq3cy/XABIIWonWZ0+blfFgb5TKzbo7o114Kc58agF9NodDU?=
 =?us-ascii?Q?erIGqN50NjCZ05alTP3PePoqFcZUgUQL12k26YOZUQEtSM+nG/csoZeuPQPp?=
 =?us-ascii?Q?W6eAZbK+MeLJDWKJOu9dmnYYp87MNWOvu3MMMYjQkR0LkR5NsZgZRPwvv/t3?=
 =?us-ascii?Q?iq1rc+6RtNdQiDZlFzM5TYqi8QPV0meTPGQkgy6kPX0aY3vsFkW5CykYPP9b?=
 =?us-ascii?Q?BkGN4wkVzNh2ovm2eNvDD3cTiVm8ap8o9ve957P8O3zBXtCvi/jyVRwPeJYz?=
 =?us-ascii?Q?ssGdAGY6lV/FcIvU6cLyaoUkUSfsXuT/Pz4hxhdWVwYyZ97hSXk4F6ZOVcbe?=
 =?us-ascii?Q?qka2HlIL7PVlB4q7DjFOoNJnFDGtnJCLsHWHXv2dFxYtfnOdSE4fe43DL1Sr?=
 =?us-ascii?Q?Vpa+7RejwcaWiKkGcTZ3eq2RWzy+jcUvSAh7U5EWXAyBwVtAWnSiTmCuKuuf?=
 =?us-ascii?Q?cgOGsLpwqGYhXFZf/Iah2H+J/hRBlXjPvuMYAQiYsePtXXFoUk0rBJsWhDBf?=
 =?us-ascii?Q?nqX086uQVNbztp0CjyZIHK7XCLJgGrW9C5mhLYi4G8PUWsfGyuPi8ukvWz7I?=
 =?us-ascii?Q?ukj6LFmnHFKmWti0RWPsFDz5bdaqlCb57PQt8Dv1hXDr2olRWyvUinsk9klo?=
 =?us-ascii?Q?grNsZOzEicXV5COqHv4HJ3uCeHN8BUZerJWYxQKdXSC9oTW0RY2/LT8SWGJC?=
 =?us-ascii?Q?tp/+4ygqhl/eM1j8xUYF8RqqBbp2Cwv8tFSfZ60s4gGze0GtLcVXM5qlYIpn?=
 =?us-ascii?Q?leIrizFAbU4JB/ENzOIvjL7tVtyXUwnLmX0H8ufz/4VHTzrMA6pSuaXYLlDW?=
 =?us-ascii?Q?w3EZuwCcdeGNwAMLGC8WYeN4rNs7NRNUcC2TlCKEJyufp5F0KiHLimR5FjOy?=
 =?us-ascii?Q?GMUiIm+ooKiaQ9zb/MiJxlmehAdak3thTy63+vVOK1LEeap8o8nohhDo52Ot?=
 =?us-ascii?Q?lj2fPzNDMBiN6FjkY5ejZHZplg3ETN21cV/lKpHj28lPRUWrUT26TfhyaWIS?=
 =?us-ascii?Q?DRgGnbEco5Rz7f7ZjPWG4m8FO+2nEX31wjYZyEWQMSEHaBazIuNimo+ap3V6?=
 =?us-ascii?Q?VI1XIl+RY5i5Ox26QXLuq0FLf0c0jA/sM0paOMifM3NFLdod/ip0XjXO+CnH?=
 =?us-ascii?Q?UeO6xMXD3YuPkUIbWhD84E5h?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd2e87f-1492-4920-10d8-08d96cdd5b9d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 00:13:43.1562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ox1hypHzh5ECYHT11BpyKNVlpBhW6Wfwv7OVvAh87oWxI81SGbI0STPR6OBNNuUPUMigCywOoYTZ1lByC8vgPFTzl2x9aYJSrCN8/QIHc8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4955
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10093 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108310133
X-Proofpoint-GUID: UUb1zLl70pB0zZ8eeNbITv2T_Hk5S-aL
X-Proofpoint-ORIG-GUID: UUb1zLl70pB0zZ8eeNbITv2T_Hk5S-aL
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In 0ee50b47532a ("namei: change filename_parentat() calling
conventions"), filename_parentat() was made to always put the struct
filename before returning, and kern_path_locked() was migrated to this
calling convention. However, kern_path_locked() uses the "last"
parameter to lookup and potentially create a new dentry. The last
parameter contains the last component of the path and points within the
filename, which was recently freed at the end of filename_parentat().
Thus, when kern_path_locked() calls __lookup_hash(), it is using the
filename after it has already been freed.

To avoid this, switch back to __filename_parentat() and place a putname
at the end of the function, once all uses are completed.

Fixes: 0ee50b47532a ("namei: change filename_parentat() calling conventions")
Reported-by: syzbot+fb0d60a179096e8c2731@syzkaller.appspotmail.com
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 fs/namei.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index d049d3972695..a0122f0016a3 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2551,17 +2551,22 @@ static int filename_parentat(int dfd, struct filename *name,
 /* does lookup, returns the object with parent locked */
 struct dentry *kern_path_locked(const char *name, struct path *path)
 {
+	struct filename *filename;
 	struct dentry *d;
 	struct qstr last;
 	int type, error;
 
-	error = filename_parentat(AT_FDCWD, getname_kernel(name), 0, path,
+	filename = getname_kernel(name);
+	error = __filename_parentat(AT_FDCWD, filename, 0, path,
 				    &last, &type);
-	if (error)
-		return ERR_PTR(error);
+	if (error) {
+		d = ERR_PTR(error);
+		goto out;
+	}
 	if (unlikely(type != LAST_NORM)) {
 		path_put(path);
-		return ERR_PTR(-EINVAL);
+		d = ERR_PTR(-EINVAL);
+		goto out;
 	}
 	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
 	d = __lookup_hash(&last, path->dentry, 0);
@@ -2569,6 +2574,8 @@ struct dentry *kern_path_locked(const char *name, struct path *path)
 		inode_unlock(path->dentry->d_inode);
 		path_put(path);
 	}
+out:
+	putname(filename);
 	return d;
 }
 
-- 
2.30.2

