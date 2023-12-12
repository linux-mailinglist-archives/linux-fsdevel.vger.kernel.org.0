Return-Path: <linux-fsdevel+bounces-5659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8AF80E9AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 12:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A032DB20C21
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 11:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CB05CD31;
	Tue, 12 Dec 2023 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fPPsBLGc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k2Iv44bK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B18D2;
	Tue, 12 Dec 2023 03:09:45 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BC7iR7s032011;
	Tue, 12 Dec 2023 11:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=qY7i1VBZZQ745lF7eevxcnu0k4K8YrzyHITvDtXhqno=;
 b=fPPsBLGcpTmHZ4j5Rois1QfjzcGIZB8AB6WjMphU9Y4RBGiRYtWCL4Qn4f/kEPskmgsb
 arpRNB6UA57NEhASWuL9JqelTEqI458a1nopTJiULaKb2ALHW6xNUV71x7sDmoZ0D8oJ
 5CCaaaJ7ICtOqJEWcAvCq+eiQowVeiYVSlhAHi1jAWM041tU66XdqBB7cI04eLuXlH1a
 BRTheyxcW4oxe6oTBPNaeAI132DyxSDD5D2RThPs/LqA1ISq8lskHofmZFebRz6+4goR
 G2xbSUB0oIevAk0CfDX+ILWE1EkgOu0EFogPKZyxUpDEJILeIpGhupdQZ6JWMmfSx9w+ 2Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvgsudb6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:27 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCAZCip018664;
	Tue, 12 Dec 2023 11:09:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep6d56w-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9yLR70AiOEb6Z2gazA5hiT3+jSPwwBZWvEbR+y6rvhuNfACVVf5v3861AvaDkbUWRB2k0w45FL543UhpEhUtcN9Lji8nzow4hzgNcVn4OdrhzE+iKTUVk1ZIAfy9a+uMG0vfUU5NGNDcWSU4LDU46zYqt7YeDuE/0Y11mLyaRMQksL0F9isAmHmLy7egXVJ2kwxlmo4oLQ52ddrR8IxkoD+ZAW8b2kC9kSWzmYkELJlPkjBz5o6WfA3d2kqp4A+8CZjjM45V9n+PA+/bssfn6kvhQKx184X4D/E/ONr4rl+pPllbc+g6+0/sUkdneDaStbmJUcFzisxtmyxXYJc6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qY7i1VBZZQ745lF7eevxcnu0k4K8YrzyHITvDtXhqno=;
 b=dhgpLrRUL9VeXjjRwMdkjwAD7kUrTeU/91XkDMnB7Ix/5p9/FfmPL8wXgQML7SVg1Vt2ZI2NPvLnfg8sHzFoM06KZwZzO0vDk2R80AswdvlqFk3rMeLRhjbQdT0mwg0LjZcauwhhdjRvBDD6BSoI8TD+aBZwwHF1KQsPdlkNnYgJIO1XEumZYw8kPcG29eGLk2XIHwsM9U5ovKUl9cS2ztT3fOd0At+hqm5qAS1CPibXrzIQuChJypPvo6yWnbAQqzdU156ER4U7IUCxWOkWUMG/e0gZnDNn/PaSuDTI17Vxc2YGnpkcWp+3o7Dorhg2mbuMKpmeXxkd/6QfH3JS7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qY7i1VBZZQ745lF7eevxcnu0k4K8YrzyHITvDtXhqno=;
 b=k2Iv44bKSitELVRHERlS9+xiRsZoPnnQ94QMpbl+Ld45pStki/jgALR6pbPiZ3abgq7ImydU64b1ieApKns+xm/WqLcRGKyyRiV39NaHCzhw2N8GmEJ4Uk7GHSimY4Vml3BP0TCMDxoiCCmvlcorSjZJF4y1nlH61eTq1BaimTs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6663.namprd10.prod.outlook.com (2603:10b6:806:2ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 11:09:23 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 11:09:23 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, jaswin@linux.ibm.com,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 08/16] block: Limit atomic write IO size according to atomic_write_max_sectors
Date: Tue, 12 Dec 2023 11:08:36 +0000
Message-Id: <20231212110844.19698-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231212110844.19698-1-john.g.garry@oracle.com>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 26154140-fdba-4c59-ffaf-08dbfb02cbba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YO/La7JnbCidotp++p7LU4HgqjzcHmKvIQgJQPfe59okxUDfv6YrSPvJ3+1OwBMRQzHAjGWWlyuql4+ToI+/M6hlxuaz9fUrHuLjofwQgvEokkOR4GBd8WwDQxwBvk0BWPHdq6BHWIu2gbBoPAUtljhSHQjuD2ZFo4cggTlKBBCbgjZ0/fzXHrexkPSHi3Z0Vf0hOPYtkkY1qyvvNrtVxSjUwBN49QbPUFiG6M0YihAvvsGRGuRuhAl8xRo9vB/I8B9Y/QHVJ5IrdZb5v09SyMCNUvPN/Hk+BFr772U9BDj3WeeUSW5IoyfqcMT1rSFGTcs95kkmXOKEbADPqNRzud9tSLNye8UpF+/Lgg+32TL0R2F2nj6yfSFZnC7fga1nvJiIHIU7COWAZRGHu0W2QGO1DDJfTLNLn3NBCLoYk17RHYldoBlqHEKaTcsicAS+q/X7F5twLx2MXhpTtggud6iMhiyiosxFz96JHTUUvVAcLz7ZKoXF+K1maOiraS1jFFQ9lK+85sw7I+d5GtbWRIJ73WMfNf2BdLtUwWUJY9MO2HEjf1FjUOFYPNoXhawtTlWUcfJqYNMovLAK+Sumk7hiADE+cSsKwhf8VMo/ieo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(6506007)(6512007)(2616005)(107886003)(1076003)(478600001)(5660300002)(4326008)(8936002)(8676002)(41300700001)(7416002)(2906002)(6486002)(6666004)(38100700002)(316002)(66476007)(66556008)(66946007)(103116003)(86362001)(36756003)(921008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?yriAlTzKIhvpIpvhXRpAjibY4JEWLafWdgwPIOeWdFLlToLkU0oZEU7uCDfp?=
 =?us-ascii?Q?tsGap3veO9jqrGkiXXb4WUJIR95ITok/BL0x+FFXimC7aqu1RO6K0W2F+qY0?=
 =?us-ascii?Q?DH5TT/of4roCA1RlxmSEctrrs+mAQzop9b2ICd33zGuw/sZBXp6buBtVY8zf?=
 =?us-ascii?Q?Zm/1nhWEN60+AtHrx2WdyhcnaKqzII30WpirXMPA7k/VF9lMypVVQDXa9iqG?=
 =?us-ascii?Q?GvClFBeSa9vonnz8motQs2CU0tleR3lQDr5jLuLJWJvwazGVOvGoORnDWnif?=
 =?us-ascii?Q?P5g6n29UjBtm/OBuQQqgTTwiYNtABxgpap9puw9zGB+ZwCu2Zhd+siWezdxu?=
 =?us-ascii?Q?5flf/ye73CU7a9tEnBse1joDNjrJI9Un1YRoTsKUFMmRfCv/EKPezY9BUSFF?=
 =?us-ascii?Q?REPKlHEknHfWPvmDqR0JMZXui48q0UnJ5cRKRYZw8rzueUJRiQxCEU6Cuvd9?=
 =?us-ascii?Q?Z/48qzf/Mr9tngivGk8Th26HHIxUKJDva0XfCcUOCrPru1QexYQWFhbjahq6?=
 =?us-ascii?Q?wBeNnt34S4gmbj2Lw5hilYgHRNTrVOV3ly0QkRS8jhDjrqN+Df94SMbJ7fVM?=
 =?us-ascii?Q?Egb/QMDo2Zy0xbFfEiWJFU+Y2VMvsadk4jyLx18kSaXn99Nv6gmSDA4tBxdt?=
 =?us-ascii?Q?AONMGXmQ8PtK4+zGXOW05LAFMIesi1np59TnAMaQ2i9d//noOSjaUbiqY4Rt?=
 =?us-ascii?Q?yceBrfMozI3GkDNgNpnoWASAqV60rpPa+safCGOQf1M/Wr5MsiFz0OFdkHpY?=
 =?us-ascii?Q?JXKbaRj1oZIFrUQXbebYB493io5cDElQobGdvQGjLhPT7iZgWYNJmpWk18kx?=
 =?us-ascii?Q?P8rFXdLvaEelk1hB8J759Z9Y+m3hoC10dwUWc5vF9bVOJW1skgHInI/I9e2O?=
 =?us-ascii?Q?8cm0nItYVlGe1YlxJxbCrPlLGAN+A8xOu3xL4PD8D7Oxz/hJJoOWpUuXBl2b?=
 =?us-ascii?Q?0aaEUxAoq4UJi9tMp/OiyrIdUrgJ6qzTYqTi3DV62JIVpvujogXh0RlAtjy8?=
 =?us-ascii?Q?QHTLbod6sW8hJQgfJpxDFA3W0CKvlN9G9PbrxCX0x3zSJ15XwMHdZe8Pu9x5?=
 =?us-ascii?Q?9Yphv4CkXCyCyDzXSNfHmZw9fPQWk50/khOPeXRLrVw/Ld0BrfmvIPDyqOuc?=
 =?us-ascii?Q?MXDl4wZka6K7c3Hd+pO8f5aMAGccyx+APbhVCWbB3v3tt9sDw0+AHhYREctP?=
 =?us-ascii?Q?cvxP9HBuocBI4vdkAd39gNXgd6Fn6MBbm48Tv7IJeBAN4WPcNGwya9qzZj5W?=
 =?us-ascii?Q?I6jcyTKDivUEKn2yWUF+RsZzThdCeYebKw36vdpA41R63perCchx6tTnyWma?=
 =?us-ascii?Q?2aZ2NsdvNOlOYU/H7D90xrszmjtMmX/KaERotNtaOrIoLTxaMgingZN9sVhd?=
 =?us-ascii?Q?ARJp3Xe3w/9k4VGLAN38VVRP0KttZQVw4JGuCq/mOlNJ88x2o68m9XUkZ8Oa?=
 =?us-ascii?Q?KC0aRIBkPQEzvc69isN3ms+Dl3syinvdyj3tZ5BUl3elF2ege4RA4qp1q+vI?=
 =?us-ascii?Q?QtJKxf5EZ2TRgr/o/SJ9/tTE9f5mJQ4GpcKAchd3VyxkKTAc0G1TlI5uoeSY?=
 =?us-ascii?Q?l4rHy6k8mwiGIyIdvIIBp8rLqE7WCRxHYCh4rlwjiYgUzH23p8CVwMuQr1CH?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hy+olQ4Tl11IDDFcJL9tEq/feqNnY9XUZYZsrBi+rOI4KtohhF9J3UY/+DRO90+myI/UOBbuAzMyRe472Iw+CXXvi4TNwo3WfPPlQKyDXkjt/Z+hfTLEnszcEY7WJatktP4e0r8cjKYr/hKB+Bm/nxl8NBzWdfLVf8SrL8XY5925sXdJxW2CM1CnLX9iIfPFFnjvwfBJpTwWH5ffaEXL4Ek7gACnKZEz0nr+jlxITdXaXTtSbtwVp3UwdeYA4y6bL47t6hjlC1TircKn3IYVmECmjS8I2hCK2/XP4znKwqrswEY204qrLAIFTEG2YQcBygogiR8Xr9h/qNvDf2ixszoyxb4lhSR7ArsEFiDWBoddneAYxoImm86wGKVIEQZwZwD3UvBXhiPfE7FSqbmSfhKYHir8DzlAT4DqY1/+1TWmDJLe28fT5g2HpveTC13D0KIsshYS3KO2K12w6ASN654amqApDoBzYbmqFCQ7qJKjXXshgMzAlnAi0LEbYiflNXKiyhsXTL14cUmxnCUEqW1CiPNmrQhTG0u1yD4MJDbv0WKqGxjJ1ALvWPVjMbY2yVtzPv/CyutlEut309IRGJULRq/0D6M6pkOYijaC294=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26154140-fdba-4c59-ffaf-08dbfb02cbba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 11:09:23.1379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4nAmF2uFgQfpDTGe5a+16RpgkhwH/1OnENoKaR08f3D6p1I5EaHH8cUnf/N3pYDSSw4OH8nh35F6MGTgHVcKWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_04,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312120089
X-Proofpoint-ORIG-GUID: 2rWle9ijbzIjJK9b_s1tCZYGHsrN96ap
X-Proofpoint-GUID: 2rWle9ijbzIjJK9b_s1tCZYGHsrN96ap

Currently an IO size is limited to the request_queue limits max_sectors.
Limit the size for an atomic write to queue limit atomic_write_max_sectors
value.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-merge.c | 12 +++++++++++-
 block/blk.h       |  3 +++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 0ccc251e22ff..8d4de9253fe9 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -171,7 +171,17 @@ static inline unsigned get_max_io_size(struct bio *bio,
 {
 	unsigned pbs = lim->physical_block_size >> SECTOR_SHIFT;
 	unsigned lbs = lim->logical_block_size >> SECTOR_SHIFT;
-	unsigned max_sectors = lim->max_sectors, start, end;
+	unsigned max_sectors, start, end;
+
+	/*
+	 * We ignore lim->max_sectors for atomic writes simply because
+	 * it may less than bio->write_atomic_unit, which we cannot
+	 * tolerate.
+	 */
+	if (bio->bi_opf & REQ_ATOMIC)
+		max_sectors = lim->atomic_write_max_sectors;
+	else
+		max_sectors = lim->max_sectors;
 
 	if (lim->chunk_sectors) {
 		max_sectors = min(max_sectors,
diff --git a/block/blk.h b/block/blk.h
index 94e330e9c853..6f6cd5b1830a 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -178,6 +178,9 @@ static inline unsigned int blk_queue_get_max_sectors(struct request *rq)
 	if (unlikely(op == REQ_OP_WRITE_ZEROES))
 		return q->limits.max_write_zeroes_sectors;
 
+	if (rq->cmd_flags & REQ_ATOMIC)
+		return q->limits.atomic_write_max_sectors;
+
 	return q->limits.max_sectors;
 }
 
-- 
2.35.3


