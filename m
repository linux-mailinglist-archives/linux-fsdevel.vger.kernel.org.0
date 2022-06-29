Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F23560CD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 00:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiF2W6Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 18:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiF2W5r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 18:57:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D92403D3;
        Wed, 29 Jun 2022 15:56:34 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TM4FJA014302;
        Wed, 29 Jun 2022 22:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=UUyy2UnSoeAmxHvzrhBw95NPqAyaew2eKBtTWDsLqc0=;
 b=A91PQj05ozlTfpxdn2XYcV2izF0V6QdJ/+j0my2ml1xOfnhrxwRiK3dPgdq+q0SzepKz
 RAgy8UxNEMX5kA6iqe6VDjvKeJwxUSfJ8WipdFYCdIZoZv0kwy7xbhPV76DP6nlXExPF
 oB5ez0XxCgetiUeaXI1F5N9wG+yngqcCT28JpZwaTqExe0d1soSjwfTit9bvch7jKEkc
 qDPUrxRZZOjLCUjD0fOdPDcjq+wkkuy8apMf4l9e+X8IE3+EvnFTI1FRBChOGtmDvyF3
 YjdbCSR0GySIcsrCsLwM6cZyLaOFxhmZsDmVbjNJ6E+zkG51zJ4LAEUWGLCsv7U2iARN fA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwsysjgua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 22:54:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25TMew6v004169;
        Wed, 29 Jun 2022 22:54:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt9h64u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 22:54:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Db7KhGa5F6hDVJ4nt2ILjspU0hMff4S9ywTZiEhjup0DUvfpyw1rvy00NepBT7dV0n8AYB2ONPd9SpTKnfn5PBP/GgrGgcarJcHvpIRb/kkNEcRq1sFCBuSCx3TD3DQuJVvKul+QHUffCJOmaW0tDxse2aRDr8uq9Bg3fgjMqdc4mJEX6mr2CuvExFHWljFvfLecS8NrP+FewAAMUbMDbxG/yQ+DEW12p7atKVwOCQ+62yIB998Fl00oPQf7h3VY87e8NiUoieBd6Vv7OyQEO38u4yGJmf2HV0AT0AoO8NOUUy3EYmE4gF6bq+vCbNhf7nkBzUauJ1H+xYq+cWAjKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUyy2UnSoeAmxHvzrhBw95NPqAyaew2eKBtTWDsLqc0=;
 b=n7Yeb65LsBaqp1efKubW6CtmikMecQ2JjvHEnwj1bL4PqNjl7p2HWQdeG1EZ1Lflkn5TdsoE66PorB3gT6L5TDHYW2SvpyvFIGLb5ZpJQ+no7uiVEkv98dsG4F9wh1Y2IIKYbqK8u4wXCaBlZwwJO71OTZQbx1kaUO10cTUtR3jqVYx333G4xN4Gig//3wCEr2rQDMOW9/XocSfAp01z9p0ef2CiYM68irPk6frBs48/ZG3DgaBTwQOs6t0e8iH9n9rHEfZurZLq0nDVnNSVXcuWJ9P0QGvoVj26hGkV8bXHBJ1fgeB/6smNvSw7uQoo8hTKDlLMa/2I8Y96and5Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUyy2UnSoeAmxHvzrhBw95NPqAyaew2eKBtTWDsLqc0=;
 b=Vu5igyju866BzOpx/y7N8s5pL7OAzJ6LJMJIFCO3SaXuqzVd5Ghd3Pq8Tzel91hpjHhBtIg10d62mTAao3TWeaRO1+2f63wO6+5GHurt2qLjrgheyNse+GLXg9wfw9ek3LiZY7SCU9ZK6oB7bIoKPs6UNPl1o68dxRq72Q214B0=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by DM5PR10MB1834.namprd10.prod.outlook.com (2603:10b6:3:10b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 22:54:20 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2%3]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 22:54:20 +0000
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     akpm@linux-foundation.org, willy@infradead.org
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, aneesh.kumar@linux.ibm.com,
        arnd@arndb.de, 21cnbao@gmail.com, corbet@lwn.net,
        dave.hansen@linux.intel.com, david@redhat.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        keescook@chromium.org, kirill@shutemov.name, kucharsk@gmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, luto@kernel.org, markhemm@googlemail.com,
        pcc@google.com, rppt@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, surenb@google.com, tst@schoebel-theuer.de,
        yzaikin@google.com
Subject: [PATCH v2 2/9] mm/mshare: pre-populate msharefs with information file
Date:   Wed, 29 Jun 2022 16:53:53 -0600
Message-Id: <34e2eabbef5916c784dc16856ce25b3967f9b405.1656531090.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1656531090.git.khalid.aziz@oracle.com>
References: <cover.1656531090.git.khalid.aziz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P222CA0021.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::6) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2720452f-73cb-4c53-324d-08da5a224d7d
X-MS-TrafficTypeDiagnostic: DM5PR10MB1834:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5XFvvZaIXM6W7MqqZp5GqDmGpKoTnRNc8kSJD20JrDZjxkeCmtKSl0+yj+UiQGvJ23JjAdtubQXb7qjfjo9vCKWxl7ui/9KjQS9SFdRXM5GFQXyHcoZ0desuUWyd1GZgZbQKvTG040DPiu0ISqxPdIRIEbzwZDtjCLIBHNhH8R4QSpzdFPJA/Der/4zXO/cjqJmc/jenH3FObNyG25NP2fCyxkZaXhu1O6s7HbZzPpRnOfY7G7hF5EwWrWWHmcZUQJHMrYT0mjPj1el/w0zcJsI4O+ljFT3c86240M6Z2Fl2Hu0Z227+bURV6eisqDZnmPeao3q1VWRPsCSsua3/CzH4WdBh64CSygkVPUDUh4rKC/WpHIWtR/TdG+wjEKdFq91RNvmLlfJE52WpNkeJYWwlrHpxPddrtpr+b2nNd6KGtInw/wx0pZ8aLJ6yJ1YPo181siXdd2Yg7ZIyjWl1N9uJ2mnJbWOlwcNNjIegZxSjQ9Mg+Ss3Ay/lu1KhfeT7B4v5ELxVcIdLiv+rkbuW8+m9bKBaETBTYEMNe+AWJSU1PMm6q9DUPt4FQjrHo2FFcCMrNuTw/TqvxFbXqKxb9U4mKntdG5x5w+zUtaVrci3M7Qs9mj9+StaNBMCuSe6oSOt+ePfDj6bxD0xz7uTij9vtzHjLw74YczzBluLHhkaykmxY1y902dciAKOgaeJbLphFA0ck3uTxLSrBFOhKeOsDNw0iqynu+rg66Apmtqg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(39860400002)(366004)(396003)(6666004)(52116002)(41300700001)(186003)(6506007)(8676002)(66556008)(2616005)(6512007)(66476007)(38100700002)(83380400001)(44832011)(7416002)(8936002)(316002)(36756003)(2906002)(86362001)(66946007)(6486002)(5660300002)(478600001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?akrGa3boN0r/xq56he74ZZF7u3KT1zArnHw4se9uH8zHkjBANeruFG4959tK?=
 =?us-ascii?Q?tA918y7b3dWHyMwvEIcX1rccGC00Gm4heLtoW4fLlD49kIRhpeW7ZOTU3V3Z?=
 =?us-ascii?Q?08dthBVjD40qzynKs76dHrqitO7aUID9kDQupjYVbl66POZbyOIjXaeFdm8H?=
 =?us-ascii?Q?B548sNLLfV95xZbSDSZ8iOu1jPlWzRYlQAWUcOo1EYffQMNaJEw3KvfpmBrp?=
 =?us-ascii?Q?HdQinh0g876ZDWy5aFah2ODBMB7iTu6kBS6vRmseVRhdv/CAPki10UeYedXK?=
 =?us-ascii?Q?i/ZT03L6CdtL74eQmHe+aNDstK4fTxvLVhbQwRNjisDXLs2LJQUdbUzK/xEx?=
 =?us-ascii?Q?u6zy5s0WKID1BrW8KAJpOx5qCboyVZZOy4Xbx+q/SESoeLVVEX7pgZZ2z8RO?=
 =?us-ascii?Q?qWen6kcAz7TiCbHav4EEjJ1P9L4xSl7y2Oq3gOtZHgSDupXyRh/XQv/A42Ng?=
 =?us-ascii?Q?XnpCr8ssSQchZadfabKy9VjgLrGZ06RrGrnG32j9Qv7bBiMTsSuzhhn9myRp?=
 =?us-ascii?Q?EMnC+UU4TTb/zWDZBq4hnzPo16XZvMfRgdfEJyBFaGO5tp+6RHRL63WUfyeY?=
 =?us-ascii?Q?wdSSWY7gdihd9Uq4w65lPCpdHzkICAfoMENMpqflkT4TQLusHcOhtTwlH5ZB?=
 =?us-ascii?Q?Z9+rFY5iwtQuS0+sAgKNZ8Q2NXrapq7SA/rAixJfLccVkjW8RdbsOL38lwFj?=
 =?us-ascii?Q?eqG+zqoAoxtHW4GKljFhQHOxe6uf6Sw7iZUcO+w4CYT7qS+meukS/l9c/8wy?=
 =?us-ascii?Q?xTcoCSoCBxE20AUaI3M0oc4IHHx2XwZ/ehowENzcusRIAKu6tNO3Y4lyv4Ae?=
 =?us-ascii?Q?XOBI7HHNkDLTz9prchr0RvSDimxv1B56xOWIrm/BkRYPavfoEJC4quegLXsu?=
 =?us-ascii?Q?jsoICj9aWWHfcph7mIJo9oIS0+KCEjYALJWkn6YjIMoRQErBioOoHxdfGGTr?=
 =?us-ascii?Q?oVbx1EEg5OqxHTlhV//GTh5cJU3nd0xff8/Ca4742Momqgbt6CwdqH70ZMEy?=
 =?us-ascii?Q?037fqb7IEKi6ETccNhXUux+pdGmrROWICx9GLE7XO7u3uzaoJQAl/RfTb+05?=
 =?us-ascii?Q?kJIaJ4RHmnLzRvrJOXLyu7Oc7Q/goQH29f0Vl6KezpgVOhYup+73zfpL7okG?=
 =?us-ascii?Q?DI1K36AUWu5MbsXiEMkLSlc8bSDcEsxxzTcDHq2wVh/1P+zuyrM6fW+APpGU?=
 =?us-ascii?Q?qFoePs0vwUpKYPeo3AKz8e4jgLFrISs4ryeEqEjHJfAkf8KgS/Lelr1FQ0z+?=
 =?us-ascii?Q?Jq2C0Fv94MHPfXJxF6teWwDLHW+AlH7H5eofHrl2f2MUEnDDp2TgIOlkMLCu?=
 =?us-ascii?Q?4B5vH769+gmhckN/KS1dgH3YVcFyjej3SrLzNeNFOfB6x0p1+3mXA8G/z78Q?=
 =?us-ascii?Q?az6ioDiENszUJwamhzS2Tve1UBD439HYK7JoqNqEsLtpczkXAqTEf8s/tFTC?=
 =?us-ascii?Q?ZNOhxhKKsE1weeKJmdYRn/VQ9lnNDyjoseQRomfFzBBZlIOCRM1fg1weDOy2?=
 =?us-ascii?Q?v4aKkG+moy2qDIxYOwE5TjSJhAdPwN64kb9Y4/NHSBCe+vpN/or90zCdvhGw?=
 =?us-ascii?Q?kcGaMGRg8VMxJ61B1Iu/BKW7BL819ALJOdXd37CCWwy0tgFkXvr8NWYSCWmt?=
 =?us-ascii?Q?02dCt6WozGGW/V+jmXOJjtJjrO9Xis2NvmK2PhqhdYz4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2720452f-73cb-4c53-324d-08da5a224d7d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 22:54:20.3659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VmrJJePnnSOdWqTEbgM9HKHm1VObuukW3C/v3z8XOBpWzOcb8Kcz4AJ3UMeyvIt7HIuE3liKx8RZHknsBrwPFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1834
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-29_22:2022-06-28,2022-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206290078
X-Proofpoint-ORIG-GUID: N4kPiss-LAaX1bqhjHQBgZKNtf9rR_3B
X-Proofpoint-GUID: N4kPiss-LAaX1bqhjHQBgZKNtf9rR_3B
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Users of mshare feature to share page tables need to know the size
and alignment requirement for shared regions. Pre-populate msharefs
with a file, mshare_info, that provides this information.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 mm/mshare.c | 62 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 14 deletions(-)

diff --git a/mm/mshare.c b/mm/mshare.c
index c8fab3869bab..3e448e11c742 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -25,8 +25,8 @@
 static struct super_block *msharefs_sb;
 
 static const struct file_operations msharefs_file_operations = {
-	.open	= simple_open,
-	.llseek	= no_llseek,
+	.open		= simple_open,
+	.llseek		= no_llseek,
 };
 
 static int
@@ -42,23 +42,52 @@ msharefs_d_hash(const struct dentry *dentry, struct qstr *qstr)
 	return 0;
 }
 
+static void
+mshare_evict_inode(struct inode *inode)
+{
+	clear_inode(inode);
+}
+
 static const struct dentry_operations msharefs_d_ops = {
 	.d_hash = msharefs_d_hash,
 };
 
+static ssize_t
+mshare_info_read(struct file *file, char __user *buf, size_t nbytes,
+		loff_t *ppos)
+{
+	char s[80];
+
+	sprintf(s, "%ld", PGDIR_SIZE);
+	return simple_read_from_buffer(buf, nbytes, ppos, s, strlen(s));
+}
+
+static const struct file_operations mshare_info_ops = {
+	.read   = mshare_info_read,
+	.llseek	= noop_llseek,
+};
+
+static const struct super_operations mshare_s_ops = {
+	.statfs	     = simple_statfs,
+	.evict_inode = mshare_evict_inode,
+};
+
 static int
 msharefs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
-	static const struct tree_descr empty_descr = {""};
+	static const struct tree_descr mshare_files[] = {
+		[2] = { "mshare_info", &mshare_info_ops, 0444},
+		{""},
+	};
 	int err;
 
-	sb->s_d_op = &msharefs_d_ops;
-	err = simple_fill_super(sb, MSHARE_MAGIC, &empty_descr);
-	if (err)
-		return err;
-
-	msharefs_sb = sb;
-	return 0;
+	err = simple_fill_super(sb, MSHARE_MAGIC, mshare_files);
+	if (!err) {
+		msharefs_sb = sb;
+		sb->s_d_op = &msharefs_d_ops;
+		sb->s_op = &mshare_s_ops;
+	}
+	return err;
 }
 
 static int
@@ -84,20 +113,25 @@ static struct file_system_type mshare_fs = {
 	.kill_sb		= kill_litter_super,
 };
 
-static int
+static int __init
 mshare_init(void)
 {
 	int ret = 0;
 
 	ret = sysfs_create_mount_point(fs_kobj, "mshare");
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = register_filesystem(&mshare_fs);
-	if (ret)
+	if (ret) {
 		sysfs_remove_mount_point(fs_kobj, "mshare");
+		goto out;
+	}
+
+	return 0;
 
+out:
 	return ret;
 }
 
-fs_initcall(mshare_init);
+core_initcall(mshare_init);
-- 
2.32.0

