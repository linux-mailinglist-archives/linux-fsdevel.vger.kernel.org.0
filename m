Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B83C4FC1ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 18:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348553AbiDKQL7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 12:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348495AbiDKQK5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:10:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE1C2B272;
        Mon, 11 Apr 2022 09:08:28 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23BFHY0X031505;
        Mon, 11 Apr 2022 16:07:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=YhE3xCRhDl83CgVHZp6Hx3ndO5DT70PDuQLRUUmNerM=;
 b=lU4//b9Y5dFRjiQVuU2JpgVrsjzDs3FZRS83Sd7dWsXAxeE/vz4W6FH8drjQ7BDM/vBz
 sk/sFZtKnbZ7anoa7Vx5115NkuqUmDrPIcqdTO7FwvfHN7sWb2tuN+SXukUQ4PhrofCP
 g87mv/qYm99fL/cHHnGFzEncbhGO6OYx7Uj4OXkMi5+6xnZDi4ip61ADNe3k/2d2DPfw
 66AgvjeQvPq7c/b2MeVo84ESs2vugm2mvo3HOFHU7uTlUqleK2JdmUEydPMJBmMPm4kZ
 it+WQCreAM9anrA30qSlV941bQvlU+y9npM3OhGyqbdfu/XGZsl5nTnbN8/zKH6HVha5 iw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb1rs47eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 16:07:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23BG19vj032959;
        Mon, 11 Apr 2022 16:07:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k1kf0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 16:07:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFyHxS4Qa83gV5nyMUm0EKa20BOFGLK/QtQVN2QKIrDqaNMyBrr9z5M8u3qP9/3bQdwrvs5hIa87NI7wNDfg7IehJAZCw8na7ucLI978dsBtn0hYNNF7sJW4lOhBJHBE6hG5oV1ZMHkf0mo5IofDFX5yNiXA99zOd63Bdo1XUDWid0PmNAd/7W1a5HeO72bC8jzTESdMprkfCzdHSrC3+/wmacM5TcvvGiCxLo/VptjZs7JkAvXSzVOhwlR9BZIE/kIi8AcsTYiQS8EJLehe62a0AKu8cItgVMqJLb/dkdaEOH2B86bqtkTMov1CN739hp5FVf0DkUBp57R1bWArlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhE3xCRhDl83CgVHZp6Hx3ndO5DT70PDuQLRUUmNerM=;
 b=ezRjpT5k7J/+JQE+1u+a6tne5wTRZGxK4ZnKNXNvo+rsw9zB7oR2vcRLInuK8txUgt405vs6Jg8hLBLJ3VhGWDCH2jIRY9IfUKkhZNrCDLxYBiQxuqoTtEjCbxjDaK2q9ZAORJWyVbVe991WHbhwV5GXpliN6RcYo4Va4nLJHKnBQsu/P385CjSM/2p6HJjXh826+8uqvEt8avotjMqcHDxN83ao1aEyk/0dNS+sI8V5JATnUEZ+51Y/zOGcGys6/n3fvEnHqpb5iZrYcOtdT4jCngkL3AHo8cWIZawzsaoARxaiDtmOMEAuEOs9cRLkWqa35AtcpzgXeCtFRopqWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhE3xCRhDl83CgVHZp6Hx3ndO5DT70PDuQLRUUmNerM=;
 b=bAYxneiOLjftNDE+q9A21shHrqVjLDtafago3n6I5ZB0bgHzgo7B3CzU+p8LQtUVaNnm9o74pNHqEgGxEan7G4EO2E4Nn8YR32mWYpJQRNnAUVV6gHqiOLc+Nq1XLLdal8pUA6cz4PAKGZeYtKhXsZJUbY/+oGqdSxiAhR/el7Y=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by CO1PR10MB4564.namprd10.prod.outlook.com (2603:10b6:303:6f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 16:07:37 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 16:07:37 +0000
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
Subject: [PATCH v1 12/14] mm/mshare: Add a proc file with mshare alignment/size information
Date:   Mon, 11 Apr 2022 10:05:56 -0600
Message-Id: <65c4e9a0d4e47e11e1ee4b9a11aec9b3ecc77067.1649370874.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1649370874.git.khalid.aziz@oracle.com>
References: <cover.1649370874.git.khalid.aziz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0013.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::20) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e00e369c-451d-4dfd-4a07-08da1bd56584
X-MS-TrafficTypeDiagnostic: CO1PR10MB4564:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB456430AEB9488E34DC403FD686EA9@CO1PR10MB4564.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TChp19bMds3Iu5f6Nlx8e4gwjALzWvyaGirXvAV3Et03UFHlDnkrqA54P9jAILQgxI3yBR4iU9gKEtMnJqpe4GA38PKizQQgB+fyfZC+g8FKPyTq8uqAq+ndgdST86OGCxRSncAzejVt0ugGbcvAqLayN2RRLP+VbC7q4x86x+rDAaPnN31aT2LVFsCkAGFZIYbrjT5rd1Bnqfc/p/kOafB+zVcvvksXVRE/+mmhkxj4TtyK8sEfybHGIQEnZ+3DL5ha3YMf5IfJJGyIKKHcGE/WJm+3NHtbD5pvevjAChkbfIJw3lSBYF+Fnsjy3rL5rRs8lunWz+yAzn1WNtmWg8G1egRnbI/7JRJwobl6jyMPbUINGlI3OA0h8dAzep9+q9Bd+33ytRyXUJMS7Wk/Id5X2PKWBA6ciBraL8RKFA4KQUqm2ksTLaiP6mXOrtIfJVoD+lDag76sQ6/WxenqaSZIhc1naWViM1zTxXkdgHg63yUv7GkBg/cdPatXSfOnNpp8WIbTpeD0fx0PTgFlDddjdpmz5Dp8c1bS20frNp50V9v3hDRgCoUSHm4L1SP5PzzU+7oMwIkw3Mr6D5kNeTu9eIw88ykAfh06D9RsuUuq3QAykJq44QONKWlL7Ckevij+LmNKCZSEm8O/ZK4CrzxDAKnQHu71e0BkIHlIdgtJxjjUC9LoYmgjctDJCW7+vOeD3lDmo6loXZzHJ6cYFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(5660300002)(38350700002)(38100700002)(508600001)(8936002)(6506007)(44832011)(7416002)(4326008)(8676002)(6666004)(66946007)(66476007)(6486002)(66556008)(26005)(186003)(2616005)(86362001)(83380400001)(2906002)(6512007)(52116002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VZZWkTx3VKG6fwpYRqf/I+owTPQkDMAXlKb70Z44eQb0O96YrQCAnn/aKJKs?=
 =?us-ascii?Q?J9qrEiJig3bEJPApVrKL4owXFxOWpeAhVREPmW9vvsTmHHNtyPVNcd2oMX+q?=
 =?us-ascii?Q?FGYC8596LKc91E/82Mv0EaVds1g7lB35Lx33Ptq7Fm1g8BJg4ric63v6dBtY?=
 =?us-ascii?Q?vOL2eOKxO9doGFj93JUandqd521/Eib9r3+omBYbkd8CpDWs+Ilfp4hh6CBl?=
 =?us-ascii?Q?oF69CvYWbaxFebzMzHvZvcJhxtHUlloirSk2H2pV2XRsBfyuwreQ99Yk4B3E?=
 =?us-ascii?Q?jbObY2XtCZsyo5YF9NoWcMYFLYmWlFKn/QExgYZRYr/+z8V79zlpRTrEPNLX?=
 =?us-ascii?Q?3/+BeOxJlAIXe9We1AQPLkP+c+Sd0+wU9I++QFnezjd4Zuktpsor9y4nNnrM?=
 =?us-ascii?Q?7R4Z6IWxXTlDhHj9KLcb11BEDnq1Kn7A0hPFDHhVtFWxb9nNxiRCTtCPJj7h?=
 =?us-ascii?Q?WOaAaJt5Snt19gBHd1d76wch4Os4Hu0W2GeuvVEhQ+6gPaLPBbwbGlf6ElDN?=
 =?us-ascii?Q?zPnPZVMjgbvuTwOrpaLM1WH5h3Aj6H8mTSqPwYx79fjXqpaSGrYKNu4w5afV?=
 =?us-ascii?Q?tESRxteze/sxa2+jPtlKrHOi+7/yk6piCeeLLjQbkh/dDV9ZS1KIZk9NyYWA?=
 =?us-ascii?Q?7tHt5I70MGf2IHyqszfjm5jrr7kr+HQaMU4j6oyXEvSC4ztCn44Ye1nulm1I?=
 =?us-ascii?Q?PQupvaKGVh7nPT7s2le316ziu9WeKCs7aD9/b7HvssKoPM+mWk5ZEGGyHsdM?=
 =?us-ascii?Q?a5TlzByHjMwbl6vgyegprsNlfQP5p06rALcJtq8y1vZ8wgLbS3+5r+JrcVJl?=
 =?us-ascii?Q?/i/rX7TTbHGUo9G8jCAEIRY8Lt/gDJiAQU7FruVFeTJvjvXF6OaswtxgTUZT?=
 =?us-ascii?Q?z/8maknvWy4qOGYP4Ov/mlB7I3jGp6JYoNFugl+e0sr9XxbZsP4951tz7n3l?=
 =?us-ascii?Q?IbOiC3R5Bp2R/Nsuf/AK8R375MSR2HCjOf3EmUX1XdY7PRB5k5FTg6tfkjfC?=
 =?us-ascii?Q?pmx48KtY6GFgPZs6zKvqs4Zon+fRi/NTgmSzmeo2t1GM/nHYZkCljuXAFU05?=
 =?us-ascii?Q?EryxXl1Cv8FMnJ5ATaW/2IxSkP8PKQGMHxHrLowZ7i6+AymPBm0TBrm0lskk?=
 =?us-ascii?Q?3oOW0JuUPPuj7Yj3lcYNAbHxbHRBdEN9ESJ7dJWpVsXk07T1gpI+RFg2t3qU?=
 =?us-ascii?Q?VPQW1qwfLSDHdcaEFqionc5rEP3dOrqx8JHv5OPsywe+8yO3ymLLiVN8YooS?=
 =?us-ascii?Q?a0pOPZuf3eIXyZ2mCaI2Tmh1SNSAcX/DRmW12NGycqp5icZX4fpkSaG5iHJl?=
 =?us-ascii?Q?fpr2/XO8n7kbynaer5ERlEg2EhrdF4pSXLujm6CtVB6mThstTea1NbYoRniJ?=
 =?us-ascii?Q?rEYyDyz8jXBUaH8EflNgT9Iw6hU5UX4lLK67+wHd1cnTuMBdXVOtLW8hE8sh?=
 =?us-ascii?Q?fCf7/dci2lLzZXFoEI9iuRPQzT9JBW73CNALXdG+YUwLhB8sXhPxabfUkvZ5?=
 =?us-ascii?Q?EjgCoqOue4f+EAabarxPKE28JhQYks8F7o6kO/vdyiBM+nFyCvphneMo9HD2?=
 =?us-ascii?Q?ArM+FnHMD0oylN8X7/PhiVQzNq9hT/FkyleHxum66k5TYep3Zdd7gXMeDvsT?=
 =?us-ascii?Q?BHBNUDDXj2UQO8xDY9RuKLZGl/5F+FJhPxJMJ/F/bIT/MSQE0C+//s+KrvSp?=
 =?us-ascii?Q?Oi57SIfhY0OepuB8mTpQgmnkgj8UbZEwqzfwdsRXZbiPkimS316Qh8oFzYRT?=
 =?us-ascii?Q?Oiit/PJhoBIfMfo1SPVAjUTsQpXe5fU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e00e369c-451d-4dfd-4a07-08da1bd56584
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 16:07:37.4155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFU741it2gVPfcqJ8IhQwxqaMZlAxC8mmLworuO4L2YR/CzAMalzWunxfb8LMb+PyabyKAE+mnguEud3efhYAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4564
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-11_06:2022-04-11,2022-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204110089
X-Proofpoint-ORIG-GUID: GJQXmsXjeuDAPM8lp_RkaEDhC3gnOKUz
X-Proofpoint-GUID: GJQXmsXjeuDAPM8lp_RkaEDhC3gnOKUz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

mshare regions are subject to size and alignment requirement. This
alignment boundary can be different on different architectures and
userspace needs a way to know what the requirement is. Add a file
/proc/sys/vm//mshare_size that can be read by userspace to get
the alignment and size requirement.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
v1:
	- Provide a way for userspace to determine alignment and
	  size retriction (based upon feedback from Dave Hansen)

 include/linux/mm.h | 1 +
 kernel/sysctl.c    | 7 +++++++
 mm/mshare.c        | 3 +++
 3 files changed, 11 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 821ed7ee7b41..d9456d424202 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3339,6 +3339,7 @@ unsigned long wp_shared_mapping_range(struct address_space *mapping,
 #endif
 
 extern int sysctl_nr_trim_pages;
+extern ulong sysctl_mshare_size;
 
 #ifdef CONFIG_PRINTK
 void mem_dump_obj(void *object);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 730ab56d9e92..66697ba5da88 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2810,6 +2810,13 @@ static struct ctl_table vm_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif
+	{
+		.procname	= "mshare_size",
+		.data		= &sysctl_mshare_size,
+		.maxlen		= sizeof(sysctl_mshare_size),
+		.mode		= 0444,
+		.proc_handler	= proc_doulongvec_minmax,
+	},
 	{ }
 };
 
diff --git a/mm/mshare.c b/mm/mshare.c
index ec23d1db79b2..88c7cefc933d 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -28,6 +28,8 @@ struct mshare_data {
 	refcount_t refcnt;
 };
 
+ulong sysctl_mshare_size;
+
 static struct super_block *msharefs_sb;
 
 /* Returns holding the host mm's lock for read.  Caller must release. */
@@ -573,6 +575,7 @@ mshare_init(void)
 	if (ret)
 		sysfs_remove_mount_point(fs_kobj, "mshare");
 
+	sysctl_mshare_size = PGDIR_SIZE;
 	return ret;
 }
 
-- 
2.32.0

