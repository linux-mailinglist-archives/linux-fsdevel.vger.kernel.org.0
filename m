Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18386106AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 02:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbiJ1AK3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Oct 2022 20:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbiJ1AK2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Oct 2022 20:10:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE84399E2;
        Thu, 27 Oct 2022 17:10:27 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RMO7DV005927;
        Fri, 28 Oct 2022 00:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=uAk8pfIJ76/2yrFkZVr67deIRBkVUSRheZsGQTQYEng=;
 b=XrpZhYJux/04IUQeXkCJEKXKf8oIE9hZdVf/Fmr1zNLgMVZJmDqdJka2AwoqMoI8x1nY
 Hk1+Fvy+WFEZuOI5ocFXzNalvjssIdidDKy22TWwja6gHt42UE8wKF+NQKOGeylW7yiR
 rSiFJiJzS7iCzLTm1aaJADBL+1GDnRoreivEjlcO5nanlTxxtYBsjuX+Dbgg6aSF9ZL6
 DiiUE+WoXwEN6hH2A73d3oaZgoSRf22IfXX9kIlQA24awlJWvUPdxX2gaRxFUsL1g1xH
 /KVEOq+MyZ+bK6cmirHL+SWIZTc6i16FHQnLFbdIOqMKo9wPfFZVemXJeU0xzJcb5g+M EA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfax7uh77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 00:10:24 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29RLoWmc006786;
        Fri, 28 Oct 2022 00:10:23 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfaghgy1n-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 00:10:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKUZjYy9RtVT42VEH8FHmF/QwgABsy+t5P87O8sKrSLr2rXdhIPO0jndrP4d7hzF3nYmzM2NsQqRnmMYPeQ3myjD/4VsVxiRPNKO3KunykxKh32UU2MeQ4mfbHjrodxCIEC1amtn41LZSpUXenOmbne3cHOBNSVCfXHwjujCReSOZfk9hplHwJTjZkKjYD2GqCRB4kubtMEsE3Hkor2B3RAtLIla2BpUZOuZKpWYgtv5Y5Mq7wv/QJd13zoeLsGNNka5ru/HM9+BwZjzl8FpZwhDBxSoek5q7JDlNb8oHL18Kct+DLL7XFLFipHqd0OWR6WwmEZvbRZyyF8k8JG+GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAk8pfIJ76/2yrFkZVr67deIRBkVUSRheZsGQTQYEng=;
 b=nYvjGczqlgt87QM5ITNaEgZx6T2k2YqOH0wsXk90Xby+c4WqlxKBhYMcZY8KdR7JQE6Lcw5XRyKxFCBXKuxYDPO5scHD2OVY08iMvcGiZQTGsg/ixJI52pH0ATPPNUiU4Rhx1afTuzGEX6CrWJ4TP9DOewHBCGPwX5Oc9l/+J8ja5SScdYqUWgV0i+4Va29qeAXqXrWK3M9rQHZgC9VDIq1HFiS2zyivis3I2/PJ6dfq1Htftg6dyOvE7D9jEy1QZmRHv/mgQj4C/Dqi8a3wjdzFdSk1ounGTnS15OIM98nW6UrfKWMIMIf9AXCja14YOlv18O44N0X/4edH1G9eQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uAk8pfIJ76/2yrFkZVr67deIRBkVUSRheZsGQTQYEng=;
 b=eN0AjG42t7nDVjH2rycmY9n5XfRc+l0V5CdEIwfli4u4pjM5Vv+jmvbL+Phab5b5d3iV0D2Iw309Pv/4ZKmM04Gzh0XxiVjaKdFmYTbtREIzEivWPvhXpwRm3EkjOXUeZXzhUA6MmxtiWFuVJmMhphcQefqCWQS3qtPu9od2dC4=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by BY5PR10MB4130.namprd10.prod.outlook.com (2603:10b6:a03:201::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Fri, 28 Oct
 2022 00:10:21 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24%9]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 00:10:21 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH v3 1/3] fsnotify: Use d_find_any_alias to get dentry associated with inode
Date:   Thu, 27 Oct 2022 17:10:14 -0700
Message-Id: <20221028001016.332663-2-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221028001016.332663-1-stephen.s.brennan@oracle.com>
References: <20221021010310.29521-1-stephen.s.brennan@oracle.com>
 <20221028001016.332663-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:806:a7::10) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|BY5PR10MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: 06abef69-40cc-4006-9928-08dab878cde3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hOPepynYaFh3bM3Y4zBti4imCLZ1il7c/d5YtVHXcZfsQevoeJKFAw/Q2ceYXEbu8x7kF+/LIjJ50F6O+vXl8ClQLorNwA+CLtchVQIh0MTqeOp3T5G1RDVXyW1GpL3nGheQDGVmBVBb7L3gz1yGf1YeBJbOP6Ld8RJGGSvCnSrqKulhNFTp2YQID/1iNX75eMHpxuhGP94V990/4wC39E3tsxgGKzw4ld/GptPu5/uH4yyOUY96QqCZt9WW95/iWVV34OQWs34freXnXx9BXHcmUrRNyayLZ7mISs+ADPUMbtx3DpmwxOQ9GLXD7ZiTXOUbwgGmRNdhTQVdaEZDquAQsIGKX1laSPCb9+5oTKzzEh/bfdb8m0USF8Y8p53Om6L70tkjQkOt3g46/zVZf/KPKK5JUtvg/ynsjQ2ZXoR1n8UaCypK4wzj5iTyIHeZXNxZYRHnIKZqD6RXOv7iyXv7YyPfAFaROwNSslIayOmbYb84yMBpveVdsd+4VqxVgD6ouXyeMAgnf0zPNT98HlVqR4tfrcdRnmOQcs6htu9fVLppZfCbevjtDZRdW3FGaiaqrmVvbKuK/X/8UW3Pqkn9JvObUUFJ35tSxeZ1H2Zh0pkqKHTyu89+45XbyAWCO8C+dyF9FnlJ9HxvrANxUVWcS4vGlQZ8pUbNPo7G2nQjxafUGbrR+18g2Tz3AzeWGxw8Cuzi9KMayVPx3T78LQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199015)(83380400001)(103116003)(36756003)(6486002)(107886003)(6666004)(478600001)(5660300002)(66946007)(4326008)(8676002)(66476007)(8936002)(66556008)(41300700001)(54906003)(6916009)(316002)(6506007)(1076003)(2616005)(38100700002)(186003)(6512007)(26005)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R4GIVdsoJcOm9zRoFzpC7Ev6D3IdrZxLwXTmfWzJ5n+zV55l8+P0RIzvTmrq?=
 =?us-ascii?Q?7uiwXwwibbRNi1AmjNe2NK/3qoN+QRgzFoW8/uaBwUupqzY370wcpgNi2DU0?=
 =?us-ascii?Q?YOia76GcwjHHzFuPV25f+51cYMKGSmfsLmsY9p/PAH9KhIoWCVogo/gUSVKf?=
 =?us-ascii?Q?KN1lT0tdX8mcRTYZLepqQY1pGyh02TxEaVauTvfsiz2kF1xGbYZyWrPURWKn?=
 =?us-ascii?Q?aFoZHk17peaU65ew7JaywI7NK/VNA2ClcyeS+km+0RCEE12HhVqY6krE2QHy?=
 =?us-ascii?Q?W5cArnAq6XmJSo4wYb7nOzhSEfuptkaoMhB2DTO3LM/tlmEZ9M6/D8D3k5OQ?=
 =?us-ascii?Q?glfCx5gy4kCqlcK4CgTONyfoClsnJClc6il+5kyzxfZxzgzhTGLNW0zr5iBy?=
 =?us-ascii?Q?LtjASGcR1Wpq1nVl5JoCf7FIt8RFjIEdW94qykQ2BMj60Q5Zlm93R4qkC6fQ?=
 =?us-ascii?Q?fwPr5cckbDHzGhXuFb4v8B5BeqNRGb/lzsnyc1DRnzBQXPvdLKF2ilo4y42N?=
 =?us-ascii?Q?I+NjiBHdl/KTAeeIdiqBJbYshVx9+s7AgxzkZ4X198dkJuijON6zyftwKUEf?=
 =?us-ascii?Q?2uBVK2EhWCIvN/4uifd3HAmPopQ8hIzXSZoqO2j5/l3BMrNlGy6SsjvBV60a?=
 =?us-ascii?Q?3Pkwim04Y0mpkWRkK4qJqIro+82hsbxtNAbgGAAjQ48ZVmFu7sRfmZnjJaUU?=
 =?us-ascii?Q?//LFQXX3OTwB6JuWxbWHIbczpSRSqu7LdiCUtW1bRGaNjWA9KNADDFifdkEy?=
 =?us-ascii?Q?jdhoNx1La8pKoFX+UhYup8yJPJV9alYTFgASSg/htGp19ihpjMVm+wq8x4Sx?=
 =?us-ascii?Q?CNYgjK26y0OFGauzoTg8rqAIOzFxFcZDlg0bzdGmtUmxdEf/qiDCNGvTcQ31?=
 =?us-ascii?Q?0lw3w9kJwYtJaJyAxJGKfeqaSAcZMW+nzg/GgR+KZVViYnv9EzlOw9wHxRrP?=
 =?us-ascii?Q?TKViXyKE6gcBotr2xdUVlx5FzHY9SAZzhNrYz1Re6hjfHwrp5lNcawEoRv8S?=
 =?us-ascii?Q?oJJqc/pQeM1bpvNyLDq653MaWQiu+hCNQsXOfXlJ5g1BUUbIbPQEhT7aCIzx?=
 =?us-ascii?Q?plyC83KpzV0GxCkpw3t4NGTmjCRyDAz8jcGw/B1YOkQPCYzF0d6Pgt5Zt7Nk?=
 =?us-ascii?Q?Oi4GpuLqdPHOIbwMk/5nLH2/WZgI6hG5ZLdpAcRVowVykfMr9/9+eIZPKSIr?=
 =?us-ascii?Q?E36NhI4c5j0ujrg2lz3ucbvLI3d5sfi1yJS/La/DcE8UgkCHuPWBBRmdusz8?=
 =?us-ascii?Q?B0WYSVF9hRjeShD9wHO0+yrkilZd6UIq3K74eXOs7nAneqkt16H6bM5hn/jF?=
 =?us-ascii?Q?+dzkfMKN6e16tl+gJZAWDVbwzJ11N4OhidN09bBAE3FtE96O6iCTFgG3uO6/?=
 =?us-ascii?Q?BtKBiyt9ls9uZ2dp4ZAg0H4QtIfHZ7R3UwriB2urIwRxqQaUNPFjJRP9UzaE?=
 =?us-ascii?Q?GoXpdApSCqmNlxLSGxQeqWiTxOg3MzkZ5I/LVoy5907fdOzRkkPpy0lzSULH?=
 =?us-ascii?Q?Cmkmf1aK6zuIh6ZJ+5TEKq7JzN1zgaZwqGQNitIlO+aWa5Q8xzP48toqsGdc?=
 =?us-ascii?Q?p+kD8S/QQhduduCPp8VMgcDMLysbkZyOCfwnhNO7C6KWyXFj/K1BBzfwrEN9?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06abef69-40cc-4006-9928-08dab878cde3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 00:10:21.7271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8CrQA9GjshPQSaPBSVkftVrn4LeIpERbOFOF9kiNYxMhfM6eos49UD6vPi0dFvyRDnpZawf2/oZDrtcVIv5BiPWYV3pL6omXcvfXuZSOag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4130
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270138
X-Proofpoint-GUID: ANc5DvF5V0BLuRgOqDpScrOlFyCKTUPs
X-Proofpoint-ORIG-GUID: ANc5DvF5V0BLuRgOqDpScrOlFyCKTUPs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rather than iterating over the inode's i_dentry (requiring holding the
i_lock for the entire duration of the function), we know that there
should be only one item in the list. Use d_find_any_alias() and no
longer hold i_lock.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---

Notes:
    Changes since v2:
    - Add newlines in block comment
    - d_find_any_alias() returns a reference, which I was leaking. Add
      a dput(alias) at the end.
    - Add Amir's R-b

 fs/notify/fsnotify.c | 44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 7974e91ffe13..7939aa911931 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -105,7 +105,7 @@ void fsnotify_sb_delete(struct super_block *sb)
  */
 void __fsnotify_update_child_dentry_flags(struct inode *inode)
 {
-	struct dentry *alias;
+	struct dentry *alias, *child;
 	int watched;
 
 	if (!S_ISDIR(inode->i_mode))
@@ -114,30 +114,28 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
 	/* determine if the children should tell inode about their events */
 	watched = fsnotify_inode_watches_children(inode);
 
-	spin_lock(&inode->i_lock);
-	/* run all of the dentries associated with this inode.  Since this is a
-	 * directory, there damn well better only be one item on this list */
-	hlist_for_each_entry(alias, &inode->i_dentry, d_u.d_alias) {
-		struct dentry *child;
-
-		/* run all of the children of the original inode and fix their
-		 * d_flags to indicate parental interest (their parent is the
-		 * original inode) */
-		spin_lock(&alias->d_lock);
-		list_for_each_entry(child, &alias->d_subdirs, d_child) {
-			if (!child->d_inode)
-				continue;
+	/* Since this is a directory, there damn well better only be one child */
+	alias = d_find_any_alias(inode);
 
-			spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
-			if (watched)
-				child->d_flags |= DCACHE_FSNOTIFY_PARENT_WATCHED;
-			else
-				child->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
-			spin_unlock(&child->d_lock);
-		}
-		spin_unlock(&alias->d_lock);
+	/*
+	 * run all of the children of the original inode and fix their
+	 * d_flags to indicate parental interest (their parent is the
+	 * original inode)
+	 */
+	spin_lock(&alias->d_lock);
+	list_for_each_entry(child, &alias->d_subdirs, d_child) {
+		if (!child->d_inode)
+			continue;
+
+		spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
+		if (watched)
+			child->d_flags |= DCACHE_FSNOTIFY_PARENT_WATCHED;
+		else
+			child->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
+		spin_unlock(&child->d_lock);
 	}
-	spin_unlock(&inode->i_lock);
+	spin_unlock(&alias->d_lock);
+	dput(alias);
 }
 
 /* Are inode/sb/mount interested in parent and name info with this event? */
-- 
2.34.1

