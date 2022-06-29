Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A157560CC9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 00:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiF2W4h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 18:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiF2Wz4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 18:55:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2802324F13;
        Wed, 29 Jun 2022 15:55:13 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TM4Svw028200;
        Wed, 29 Jun 2022 22:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=a4STy/GfsGc/ZrNgepOwrwUODitWUZgj0GBodIVjd3A=;
 b=e2tINxXp8b6YGqn2X2uDpaMR51vAE/HnR8SskHgXE1DKuAsL5xs6sx/Vp5DQPgvmtfBp
 m5D856/82kivXPBeYhfWP6JtP3RhHN4KN7bFerOdATfryWyN1/4c2+acbQH9+FDnWrmw
 gvj6YoyAOURSgWVL8crdtK2zp9VLLrUmjmEdaDtLEgZ8ajSK9vE2o9E2kJmkvBXbq52O
 KEAdhrDABvyFK9tHQzsrB5lKbsIC7I0KsVAfQ+2ljExqJkn7ttSI0yIq7IM7ZXuGJueE
 vd9dEYDTZlH/qrNLcHWUvzOVt6kH4VLMH816ow7qRbHhRiO9ED7rXoMTIwe9DNs0SAh8 PA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwtwuan8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 22:54:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25TMexST033563;
        Wed, 29 Jun 2022 22:54:33 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt3wyyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 22:54:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MV7LA15ylf975m5zBm4SGbpC7jE85yfkdjdmjqs2BcNxINKGSEMz/0l3NgQczvsf3a9R3+TS4upucPYXz5WtAAmameCs7l31dX/b05mOlj/bH6/IEjSUsIGn13hnV7RAQNN3sIKC6s36lJzox2hsT4+i5k9KWVbZYZ50ckB+MV/41/GUIpPG6hRDraKYGBVmbKiXhIry4BRdK6i+B6e8pcfQBn3O2BkV5D2wNxFIm1mJ3hjJjR8woyLYB0TP4pzmqNWcezp0jSLbVssSAJ5aQQtslnlLQ+ep8cGH0K1MiXDLNaXejpHaaQmlTW4S4KbSY3f/ED8FRHI7Y+kd41lpsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4STy/GfsGc/ZrNgepOwrwUODitWUZgj0GBodIVjd3A=;
 b=lajiIvk8AOOymSSasRH3znvTQuyEWdHovxm5Gmdg4psKHsQsc3y/AWRrnaL5SypvD/eE8BuCHhfkPFvyxRRryaj10HP7rkRY1KWXeeZoAd6GqTGqjWzDUHTcqv3jkrD9schGWCSGWti45rmylp5H1pSRQduHg+g8rcLPayQ5H5+6UM9RT/xXh78MBZCt5XvsKlZIoJI7TefEw+S190bjgpixOl+9B4GLmeKy+xan5/EHkkq5lqb3ji+2a3yL337HUdaN052zqvZMAmpVufYoeRVAknu6dy7dVAOPKYnStlycPx1gdffx9kkj8gpWNKWzms4P3075BIl8MkpeKTmKxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4STy/GfsGc/ZrNgepOwrwUODitWUZgj0GBodIVjd3A=;
 b=n10SHuwVgrgN5d1bsLUIv2taqnZGuwEPZQOsQPVazuo+IPDyIWsl1QMF/gNGJLo2owld+kvc7iYK6RF+uqVg2qJCDHNHmjraMsvdUNMa/QrvLNekt2/Xi1OnSzrT79yEFC0hNTKr0Pv/OBtoELQ91orGOpzRCpF51ktkw8IyfGM=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by DM5PR10MB1834.namprd10.prod.outlook.com (2603:10b6:3:10b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 22:54:31 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::28d2:e82b:afa1:bbc2%3]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 22:54:31 +0000
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
Subject: [PATCH v2 7/9] mm/mshare: Add unlink and munmap support
Date:   Wed, 29 Jun 2022 16:53:58 -0600
Message-Id: <1b0a0e8c9558766f13a64ae93092eb8c9ea7965d.1656531090.git.khalid.aziz@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 80ccaab6-be60-4ccb-f6a4-08da5a2253cf
X-MS-TrafficTypeDiagnostic: DM5PR10MB1834:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 16nJnksxX8Btz2xXqSYHBldFoDfFCwsuhkTt4Ap0elC6uJF4LADtw78AQWMQwgjW8ktbL0fxqLy4zfo7ghoRFeUjwWjAAFYdeQHjmvBpR+SWBDwO5laIrq70pmYBEx3Z6hfgGqivW3XnWaX71ctWuIHb+I8vKrF4tjUv0vGtqH0YSc4oxtzLaCtvnhDax3UYmWIf/f5MzmHsMLVld4hsr72pwK2SMBKWSMuIrp/zKnh5i/YcvO/d1h5gkyIfR8pTyzwIfW/hfDRtSAvbwuSEo/1LHsbSJWMRYQbjpTaJ95riS3woRQSeT5lCCWupXljnN3Ys4XBs31djmkVUuTTsJ2O/2T3VU56Cdz9KKC8RfkD01WcrHRqfE7snhbRUWtFyVD5VUMrgLc/iqQDuPVHZvAVzRg3kdu//dRE2pxNk1sEpWccSD8O/SyGoThvAXjKWbl7fkKFRA0Mq1LvY+v4JXsG+Qu+ixIZ+o0+MY9alTQc8kzc7Y/o83MrhZ5oFMqKljQN128WJ+IrxVbJwThj4TAQPTXI1O0TnvDEF1dHjNwOXYSqiakw3XzqXI4cGVsxPtkesVV4mJStKo7K+OKhoc6IerjovIRLsdjrVALu9G5WJcNknY3tsQ8IGRTt3gFOAKF80jt5eIauy/1bnq6z8Cnx/mgQo2bvA6LGXNoOLYZvCzM9zoD0oHv7GBHOrlKb+CdDD3x3i97RMliSnFpitDYnG1XPVDlEBatpyWkWgXkM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(39860400002)(366004)(396003)(6666004)(52116002)(41300700001)(186003)(6506007)(8676002)(66556008)(2616005)(6512007)(66476007)(38100700002)(83380400001)(44832011)(7416002)(8936002)(316002)(36756003)(2906002)(86362001)(66946007)(6486002)(5660300002)(478600001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QEFs8qikYrylmBiwI4ctrXRKdAGqyBlDG4WUZm3QsFiY/mtaSNc/JKRWD3Z5?=
 =?us-ascii?Q?nX6BejqyN3luWiHhlGqMv8hjA6AwOzzjf1BYDfUvk72r/grGEmaSmTdXbgLU?=
 =?us-ascii?Q?CHRDoOMtXwG5Yls0zQWmabwHxMXExLps4sUXKnzZNewoz2TCDlXHDRO+92mc?=
 =?us-ascii?Q?/HAl/BuKUkm/WqVW7SAce06Ua7QOEGGNPKY5hytJTIi65O00zwy2VG75hb5Y?=
 =?us-ascii?Q?rEYnhRAZflTr5D7MrZoxzQCLAKORU2HIQV+6axkD6PHu1WbfR10+eLrQpvvX?=
 =?us-ascii?Q?vmbc7O4XLQMpbaCIHw+GiCFDuhxYFGPRoIyZG5oIHOsnmwXRe73+gX0xqoPf?=
 =?us-ascii?Q?ji+0piZnsAzxkZ4t7QhYAwebcfCCrMmtlXMNznZfHAleQqmHE0I/gWgZI+Q1?=
 =?us-ascii?Q?pgpLhVBs59ilB8X2pPH1+lxKlyv8gZpZ5bW2a1JqGiZJhR7ETrrnWVLIyj1H?=
 =?us-ascii?Q?43BjydLjSQAoYIsaULg+/UHWs2xynx3NCDKm4M2+Ko7HoQuZy3BXhAmV3wcb?=
 =?us-ascii?Q?sOhFCFkOcyZE2yr2tDDZ6cmtnJvpBpZdmkOSMhq0ZVGl/KkBpJeBicGJ0Mb6?=
 =?us-ascii?Q?MtN2HHcjQJpRZPhNQU5tOAHfMscCsMltoj3YGM1d+M9ydVaOLRF3BhOIHWme?=
 =?us-ascii?Q?0iy2LlR+5SLfk7/vj91HcLV3Xtq0Iut6KvKIvL3xDh9B2p5KH+1EkQeURkBC?=
 =?us-ascii?Q?pBmBqa3fxUb+S7G2P/8T94e2/Cjw5zUIkRPQwS7ZwIDUGDUZTwPQZHZ8NKUh?=
 =?us-ascii?Q?aqGvqiSPZl21pHCKaMqi0/wRAPLF707nA1eASAHK1fQhqr7q7nuZfVIFFlQv?=
 =?us-ascii?Q?frP/sxoZPuPpBqSC3McDqBf+B1UwRJlrXQJ45UfjPiGcw0LsgRQguBDbvkZY?=
 =?us-ascii?Q?NjFJ7bXTvgBoRAA+ySZbHr2bZiS225OkcXQY/7M8YY5lKj8oRoJHSDMNUH/f?=
 =?us-ascii?Q?ksyYAUrEyRBv6evxZGoSx3Cl0uNn2Q+0cKomjNmkbuFEar/lao99V4LNTZmT?=
 =?us-ascii?Q?zFFSTuaTzB9aWGCoASXFnNvFqnKfzgt+YK6fjymIxij8pH7IimqnWPdNFEW1?=
 =?us-ascii?Q?XJDX+ajOCJnOTOd3kXdSkBPq6R2rquJrc+vHii+DZIyruuU6xD5HbC/U2bRP?=
 =?us-ascii?Q?969V4okSYNktPPLbbTqX6y23or9h8ed6rFky2rgETWquETI7HF6y/jLSNVzk?=
 =?us-ascii?Q?TrNuHYLnXq5oFrrJ68JxRddxj/4OVFj5TGvlchb2UQmJgfTJKev9T4UJZlen?=
 =?us-ascii?Q?1x0rvgm5JHI5PlZEpO+JrdQaBriPuZWBfUq9CjdrjSFfIsdaXy4zgdvNnh6D?=
 =?us-ascii?Q?Bc2kh+1Wp56fcyTYNYxExZrhCj/c//71mlqaTOwgymVyhoVAVJNWD6jltn0d?=
 =?us-ascii?Q?0ocdj62R0G+ZVygLciX0a52onmf1LVW/ZulLG+9RtLOF4vF4ANuRV80X8bQD?=
 =?us-ascii?Q?je12b+5JNloNENjeQ3tZz36guZ23LcxDGGDnX5YuMr+1K66Ma+6z5zsXhy0Z?=
 =?us-ascii?Q?9Sc180ly2B+Zf8aqF54o1CDsthh+lQlOSHT6bGKBAUhhJ8ovbGMENQEXDw+v?=
 =?us-ascii?Q?Y8DtG47xDTfHsuOTy+9yE1oA168824zCMwJQYQVs60Hnhatsk02QXYQ0yASC?=
 =?us-ascii?Q?mZhrDbbwBtTCiyAlaUI1vBRd+SrugUoo70/IQN0LIbtOszql/ljSLlr+WR/k?=
 =?us-ascii?Q?mEXZaA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ccaab6-be60-4ccb-f6a4-08da5a2253cf
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 22:54:31.0372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7M2bYWm8z8vp+FXX19gRULJuzpsNvjKHI6COPgkaB/smSuWvfzF4tno3IfecwSru3evAfxSqjYy96dpHniWT0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1834
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-29_22:2022-06-28,2022-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206290078
X-Proofpoint-ORIG-GUID: UvVb3F1D3dDET9EL-jKWdHk-zyao54z2
X-Proofpoint-GUID: UvVb3F1D3dDET9EL-jKWdHk-zyao54z2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Number of mappings of an mshare region should be tracked so it can
be removed when there are no more references to it and associated
file has been deleted. This add code to support the unlink operation
for associated file, remove the mshare region on file deletion if
refcount goes to zero, add munmap operation to maintain refcount
to mshare region and remove it on last munmap if file has been
deleted.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 mm/mshare.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/mm/mshare.c b/mm/mshare.c
index 088a6cab1e93..90ce0564a138 100644
--- a/mm/mshare.c
+++ b/mm/mshare.c
@@ -29,6 +29,7 @@ static struct super_block *msharefs_sb;
 struct mshare_data {
 	struct mm_struct *mm;
 	refcount_t refcnt;
+	int deleted;
 	struct mshare_info *minfo;
 };
 
@@ -48,6 +49,7 @@ msharefs_read(struct kiocb *iocb, struct iov_iter *iov)
 	size_t ret;
 	struct mshare_info m_info;
 
+	mmap_read_lock(info->mm);
 	if (info->minfo != NULL) {
 		m_info.start = info->minfo->start;
 		m_info.size = info->minfo->size;
@@ -55,18 +57,42 @@ msharefs_read(struct kiocb *iocb, struct iov_iter *iov)
 		m_info.start = 0;
 		m_info.size = 0;
 	}
+	mmap_read_unlock(info->mm);
 	ret = copy_to_iter(&m_info, sizeof(m_info), iov);
 	if (!ret)
 		return -EFAULT;
 	return ret;
 }
 
+static void
+msharefs_close(struct vm_area_struct *vma)
+{
+	struct mshare_data *info = vma->vm_private_data;
+
+	if (refcount_dec_and_test(&info->refcnt)) {
+		mmap_read_lock(info->mm);
+		if (info->deleted) {
+			mmap_read_unlock(info->mm);
+			mmput(info->mm);
+			kfree(info->minfo);
+			kfree(info);
+		} else {
+			mmap_read_unlock(info->mm);
+		}
+	}
+}
+
+static const struct vm_operations_struct msharefs_vm_ops = {
+	.close	= msharefs_close,
+};
+
 static int
 msharefs_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct mshare_data *info = file->private_data;
 	struct mm_struct *mm = info->mm;
 
+	mmap_write_lock(mm);
 	/*
 	 * If this mshare region has been set up once already, bail out
 	 */
@@ -80,10 +106,14 @@ msharefs_mmap(struct file *file, struct vm_area_struct *vma)
 	mm->task_size = vma->vm_end - vma->vm_start;
 	if (!mm->task_size)
 		mm->task_size--;
+	mmap_write_unlock(mm);
 	info->minfo->start = mm->mmap_base;
 	info->minfo->size = mm->task_size;
+	info->deleted = 0;
+	refcount_inc(&info->refcnt);
 	vma->vm_flags |= VM_SHARED_PT;
 	vma->vm_private_data = info;
+	vma->vm_ops = &msharefs_vm_ops;
 	return 0;
 }
 
@@ -240,6 +270,38 @@ msharefs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	return ret;
 }
 
+static int
+msharefs_unlink(struct inode *dir, struct dentry *dentry)
+{
+	struct inode *inode = d_inode(dentry);
+	struct mshare_data *info = inode->i_private;
+
+	/*
+	 * Unmap the mshare region if it is still mapped in
+	 */
+	vm_munmap(info->minfo->start, info->minfo->size);
+
+	/*
+	 * Mark msharefs file for deletion so it can not be opened
+	 * and used for mshare mappings any more
+	 */
+	simple_unlink(dir, dentry);
+	mmap_write_lock(info->mm);
+	info->deleted = 1;
+	mmap_write_unlock(info->mm);
+
+	/*
+	 * Is this the last reference? If so, delete mshare region and
+	 * remove the file
+	 */
+	if (!refcount_dec_and_test(&info->refcnt)) {
+		mmput(info->mm);
+		kfree(info->minfo);
+		kfree(info);
+	}
+	return 0;
+}
+
 static const struct inode_operations msharefs_file_inode_ops = {
 	.setattr	= simple_setattr,
 	.getattr	= simple_getattr,
@@ -248,7 +310,7 @@ static const struct inode_operations msharefs_dir_inode_ops = {
 	.create		= msharefs_create,
 	.lookup		= simple_lookup,
 	.link		= simple_link,
-	.unlink		= simple_unlink,
+	.unlink		= msharefs_unlink,
 	.mkdir		= msharefs_mkdir,
 	.rmdir		= simple_rmdir,
 	.mknod		= msharefs_mknod,
-- 
2.32.0

