Return-Path: <linux-fsdevel+bounces-5668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9B280E9DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 12:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CECC1C20B30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 11:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8C35FEE6;
	Tue, 12 Dec 2023 11:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OMF1rGOQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mm9RVQ72"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC8EAC;
	Tue, 12 Dec 2023 03:09:51 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BC7hrR7021975;
	Tue, 12 Dec 2023 11:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=BIEby+qrRH9/KKKqVmi3p/Hpl0mSIdRTMzAbdzkwOrI=;
 b=OMF1rGOQnU1A96miiYSfgColIveyoyiKjQYNaYUG/ruARZAB+ho/ROa7lmg5hLznAzEo
 8sc7/ec9dXD9RwAomfEsSjA6LtrBtSjoywslGBiDQB6Lsy1J8etJUbcECn6g5A8fTuKX
 KFZfPpgXwS6sCbf6xE/eF3NwVRYHjTKFDN18P0m7ZBnaqsoNUH1/aV3+fcGI2hyF4kql
 4G3tTVTwPqfekZ+mA3HEmXyJiB51Ab7mcQo5aCmjcsb1fqfBEdqsHiJQHJc/b8i/uDh6
 KEBX3Hk3DinRJ7RVL4yRigdrO42FaiSZsl7a7QWZzbgKSJZf7abLbQSNrHTPISIf+cJ1 Rw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwgn3kna4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:29 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCB6w8a009916;
	Tue, 12 Dec 2023 11:09:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep6dfg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tbsmi6jWEiQKJTFsbQ5RhsOSHcoMfgavd+7f+bzeuju5ny+102+lJNf/0bOTNiTBG6IqAnnZwaPIls8DZOPzdtk6F3p0/8/Zlz6ZqsGauznUtDl3eA/iAjN+7Sgb+GS1nPr4k7CPhguc9+bEJP1VTEm7Q94kIU3fGOQDO/5wZwSjM0wg/OhkAZfS0e95kCP+hJKgVRVfv2xldL8D2k1p9uJPdSiOaVimDgZ9gVscvK+qG+yel2Gevxw6Z9o9IfqJE+R1mUn3yEag83knFzgSiShFKs0njJWWdKFbf9H08YZm/cQegNE8fvre0CK78uK+Zx43Ky5q5jJjHhsfuOd1yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIEby+qrRH9/KKKqVmi3p/Hpl0mSIdRTMzAbdzkwOrI=;
 b=m554JK1lE0IgGvk44bN/SVHLf1MgNw7nZlMVjW0jYC+gM1+nAvKP5taxM6wYp36zqUX83c+xqz6T9m3g2bJlYix7SrMmtSrbK6CH1AvvDWICpPkg9lBWDq19A1fPxLauNrMRLnIZO0X3+Ntv054h334bpQZ/AP9wyrclFd0d8fMwvk1rqX5ciRec0TlUKOnbpx9qGkRyVKuYYlKcVhdOXm7YSho4cnsr3xW1P7YHaOMPkTFZO0q1+g9T36GVs4u6YlgQYkSP4hSbrmlzneviyjSJbf/Vdd50lL8ldUnGiXPeEZSu04wTy2hyijGQdT+ivhPxdYyrGVFIxIK6eYwAEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIEby+qrRH9/KKKqVmi3p/Hpl0mSIdRTMzAbdzkwOrI=;
 b=mm9RVQ72nXgLXatZFDGnd6C6F6KeJGT8GgP1t1AhdoKyrPks6wq9FIwcMfMFvziZzwTjhwR6JQ0W8Dth+YxSYtO0TvV6s8MqITTWw/ficdTJnQySsRruDdnkfGhRQoJO6yAIYnAqWYlZ/S0D0r2lvJ7xw3xq92aGfingnBExxu8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6663.namprd10.prod.outlook.com (2603:10b6:806:2ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 11:09:26 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 11:09:26 +0000
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
Subject: [PATCH v2 10/16] block: Add checks to merging of atomic writes
Date: Tue, 12 Dec 2023 11:08:38 +0000
Message-Id: <20231212110844.19698-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231212110844.19698-1-john.g.garry@oracle.com>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ae97a58-1355-4e84-ba83-08dbfb02cd90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Az3dRb/5XxdyoGAx7CMZMQOViobc9AmcAk1ZkNLlgUXlHIJeK7BqBlXyo70RRsTlIMzk/vEuFSoI1zjS6+Dsu/sZf8cZIInqbXosM/YHJghHlUV6UU4Dbx/EtTgLdcdPfAPmTQZs3eWbzKGbwDVOdxr0xv9w9ES4fPBuVEw4+IIVfQj2+qnwOpGmx8C3qhgLEq7CrJ4h5D/f31K4U3g4pSyk6Z8Hf6KQKDpbc5R118VUN4/iYlcxxUP9lAzSGOXo6HWL5G6YfMEcO7yysikfVLMbimcSgEHQ/X+o9KaQ0W9WUSwz6mec8waEScBk4FMc1tnVah8BPXLM2BYKIor55eo9EzcPYGy8pe2Hkq7lWMrwP0lUk1Q3bP/t4yYLcXAVw+eK9B23iFGpZslRNoPmx/zfBIJVoniYfOhKTcZ5j1d3f2k/oGooOUz6Ov6tKaUmREqPNbzlT3nzWLu1Lic5gO83N7QDZIhsbIjFo3HsfR63Fm7A4FAibT60bk7BlpjL7iISjh46F/GfnXtMfK1p0ZlBePnTfxT8/S0Pw6KzyOEbk1KIe4aWQgVhWSKLzNFf9VOsWlTDdXtH0nJQWdW5t5ndU7DPdJix4IGDgoc1RGA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(6506007)(6512007)(2616005)(107886003)(1076003)(478600001)(5660300002)(4326008)(8936002)(8676002)(41300700001)(7416002)(2906002)(6486002)(6666004)(38100700002)(316002)(66476007)(66556008)(66946007)(103116003)(86362001)(36756003)(921008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UTI/9KdLqabV5P42TuU6CeTp0FxRgkZm/a5HvQyW6n4f8FS4lCj2JT5aPgPh?=
 =?us-ascii?Q?q2j4kX8l1zvh4o+l9kISOdG5eewp/NsEyobqViMz2D1cG/eU42M9DzVazui3?=
 =?us-ascii?Q?OoMjPQVsybuASv1vN+6aFeOqgGo+uT7N4EZykVJIC4rYAdR2m0qa8zRG3mkk?=
 =?us-ascii?Q?YVBRH5HGvEq3Aozdc/pMbxvQLgMr5cCvvlR/sLmxvJc9xCo7n239ftw219id?=
 =?us-ascii?Q?+eyKpI6aPB3XSLDWWEtc0camBKhfl/GDCbs/SKuSU9W9cAA+JoC5pWdwshXV?=
 =?us-ascii?Q?rkkct1g4BrrlStFcXJm5CninH2WD0y1NF3QBl0Rw31Ptv3fnVHaKnh69CXWh?=
 =?us-ascii?Q?Yfhfr2SlbNOxuf8CAznWA46rSOaBkxw8lcZyRPGS8AquqOSmI+IIF1Ptgb+r?=
 =?us-ascii?Q?aguVYfqPgcWqBmzq+zQnIJzTmynNfZN0TSdPlo0Kw3IzTVF6v/C4S/Y6tFj8?=
 =?us-ascii?Q?Ab5JnnUcSflvuVbdW59cb0NvgU6ddXDGSqA3HKTDFsAOT51H4AzM7BCsE/lq?=
 =?us-ascii?Q?OTW/HByKyGtth5pQ9Di8tFmj/btDs5Z/DqvOpRQCL7e/JCHtrMiCuSN/38xm?=
 =?us-ascii?Q?ojhygUCqhHwbP0Vnn2Cva8MeyPD0mGVwJVO0SRfywkaMbqJs6pwgX4PN/7Np?=
 =?us-ascii?Q?qtJe2F69s/z1WCgg8lQ2cWvDM64HNzpeA3UZa0wSJnjHvDPFbxNthXn+8b+c?=
 =?us-ascii?Q?RMeYPvH66zIIxsHqOnlzlANLm3vgmw3Z+hXkUKPVwKY5nHaYqOXB8X+C8bcQ?=
 =?us-ascii?Q?FNYQt7DzBvEYUcVppi7RzKBncDXEBiwAsAaCOhC4vhrTqksRapUOCXhQYSnd?=
 =?us-ascii?Q?/kNouyHnMXQq1tX+igdvVBito4hYFjp0PkyR/XLlGxLX9s44o0U22ELeQBSC?=
 =?us-ascii?Q?LVVt20St0EEKB6zQ9ml9O2qi8tEWBMAfDekl5GT8vSrZw+P9g2R30LLZgug8?=
 =?us-ascii?Q?GIdohpG6u0rVQPee4AmzzPa7gBouP8b2yhVHgX4MuJ8UchX8QRuj5PncO0bh?=
 =?us-ascii?Q?F9CJvi1F6m4XOOJh+xRSB4GQWvKoAacjgeie9MF1seM+rNpKtZ4mGi00hC5v?=
 =?us-ascii?Q?xlAj3kbR54pfMgObpQ+51qAG8UlUD3ZT36wKMGT7sRxNGGEYFTXkxSHO7zOd?=
 =?us-ascii?Q?LU79f0inRaUTZHhT9vLwQNTkhZMyi+NYB2GydAyUye3ero5ZB5bYo0J4wplm?=
 =?us-ascii?Q?g/oZcVjoAl64CJfdaYn2ewOVfCwGRP0nUpnm+kfvaXR7bVuuHmDmRqqUudby?=
 =?us-ascii?Q?OJBScAvXLsKR30gHbeX5xl/qCPXct7Ana8uu/UCzlwbua8XSzf9JY1YqNYMS?=
 =?us-ascii?Q?Jpb/ilnIIGG/0mkWcBrcBz3DfHCotmCvtVz51O1dyTxhs3c8ACUY8Z4Vsk8X?=
 =?us-ascii?Q?eb66wKzA9NjGWXhA848faUWjW+jzxReRwuaaqiPkbiINVCtoi0yIK7B9mViy?=
 =?us-ascii?Q?9MmAsKqLLFp0+BfTopMaW8EyzUT5X21WStfpQhuSS1jqlxolPjYPcsStGy+N?=
 =?us-ascii?Q?7GphCPA1FKzI5ywcjtn6e+mkjj0aJ03oM31Qn7OJi2wHGvrYiZlPrwrUJ+r2?=
 =?us-ascii?Q?zooI2M0f4moXnq2me/auuPDjloMmj97WvnhfBDqx9KrYOBczYGBheBlMi5f3?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	77E6KHa8qug3QTbUICFLic0eeGeUExrOu/UtBZJoPdgBXjdjh0ttfrRf1ekffveGpbBRt8NpP+ZvDcCwGvlFj7uj7qfPNtL6du5NXTE34Wgg2XuTXo3h5dQdP4qBTTMPowILIgAMNHwhBRvWLu95dVhlwI+FnY1/domKL7LSlMV+oyHAJ/M77Tlwbh9FxgS5I3tpFcUl3ZGfO8ujYLJ/fJ3A3Ug87wHZnA9FW65SmHK584wiVb3JnXx+rgNHxsR2KHArtYhuHzzXQjWwPQR30UBxVeGmoM5qOwS3V4fIiicdHh55gUGPwiBb9/cUcEFAQRLzvG4IUsS1Q90K6+kNQWY9/6DEhzW3NTji5/RXr446QIe3LTsfHUD3u0MbNVBXuuX5he5/txAALua14dUknxZ4FumHjhCbCYsyTvTm47v/XfKI11a4rCGossoKXWFpKsyvx5mqwUxjc6D3GeOvAviaGBzeP7EY9TtCX7i8AXonDOET5N0bqsrvnFvqdNg8i5vG1cDVVOPyVs7/JwkWeVzp0A9qEd8V3K0i5KKbmU6cs97KFawARWs+qF9nCb+fhWWUJ0hqtEXuU5+2chdTE3A0yGpxLNiRfQ5/7tRiDaA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae97a58-1355-4e84-ba83-08dbfb02cd90
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 11:09:26.1746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+NeYy0iI1u2doxcR7SnDS87RnlTSV5J7+5tf+sT6FhGWaSTHCaoOr/bdYv2hmJ/5CIhtl84dVqoV+oEwmUtiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_04,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312120089
X-Proofpoint-ORIG-GUID: Je6yWMQ4gDSeKJd3lb6811HVLh3-YyCB
X-Proofpoint-GUID: Je6yWMQ4gDSeKJd3lb6811HVLh3-YyCB

For atomic writes we allow merging, but we must adhere to some additional
rules:
- Only allow merging of atomic writes with other atomic writes
- Ensure that the merged IO would not cross an atomic write boundary, if
  any

We already ensure that we don't exceed the atomic writes size limit in
get_max_io_size().

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-merge.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index bc21f8ff4842..05eb227a5644 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -18,6 +18,42 @@
 #include "blk-rq-qos.h"
 #include "blk-throttle.h"
 
+static bool blk_rq_straddles_atomic_write_boundary(struct request *rq,
+						unsigned int front,
+						unsigned int back)
+{
+	unsigned int boundary = queue_atomic_write_boundary_bytes(rq->q);
+	unsigned int mask, imask;
+	loff_t start, end;
+
+	if (!boundary)
+		return false;
+
+	start = rq->__sector << SECTOR_SHIFT;
+	end = start + rq->__data_len;
+
+	start -= front;
+	end += back;
+
+	/* We're longer than the boundary, so must be crossing it */
+	if (end - start > boundary)
+		return true;
+
+	mask = boundary - 1;
+
+	/* start/end are boundary-aligned, so cannot be crossing */
+	if (!(start & mask) || !(end & mask))
+		return false;
+
+	imask = ~mask;
+
+	/* Top bits are different, so crossed a boundary */
+	if ((start & imask) != (end & imask))
+		return true;
+
+	return false;
+}
+
 static inline void bio_get_first_bvec(struct bio *bio, struct bio_vec *bv)
 {
 	*bv = mp_bvec_iter_bvec(bio->bi_io_vec, bio->bi_iter);
@@ -664,6 +700,13 @@ int ll_back_merge_fn(struct request *req, struct bio *bio, unsigned int nr_segs)
 		return 0;
 	}
 
+	if (req->cmd_flags & REQ_ATOMIC) {
+		if (blk_rq_straddles_atomic_write_boundary(req,
+				0, bio->bi_iter.bi_size)) {
+			return 0;
+		}
+	}
+
 	return ll_new_hw_segment(req, bio, nr_segs);
 }
 
@@ -683,6 +726,13 @@ static int ll_front_merge_fn(struct request *req, struct bio *bio,
 		return 0;
 	}
 
+	if (req->cmd_flags & REQ_ATOMIC) {
+		if (blk_rq_straddles_atomic_write_boundary(req,
+				bio->bi_iter.bi_size, 0)) {
+			return 0;
+		}
+	}
+
 	return ll_new_hw_segment(req, bio, nr_segs);
 }
 
@@ -719,6 +769,13 @@ static int ll_merge_requests_fn(struct request_queue *q, struct request *req,
 	    blk_rq_get_max_sectors(req, blk_rq_pos(req)))
 		return 0;
 
+	if (req->cmd_flags & REQ_ATOMIC) {
+		if (blk_rq_straddles_atomic_write_boundary(req,
+				0, blk_rq_bytes(next))) {
+			return 0;
+		}
+	}
+
 	total_phys_segments = req->nr_phys_segments + next->nr_phys_segments;
 	if (total_phys_segments > blk_rq_get_max_segments(req))
 		return 0;
@@ -814,6 +871,18 @@ static enum elv_merge blk_try_req_merge(struct request *req,
 	return ELEVATOR_NO_MERGE;
 }
 
+static bool blk_atomic_write_mergeable_rq_bio(struct request *rq,
+					      struct bio *bio)
+{
+	return (rq->cmd_flags & REQ_ATOMIC) == (bio->bi_opf & REQ_ATOMIC);
+}
+
+static bool blk_atomic_write_mergeable_rqs(struct request *rq,
+					   struct request *next)
+{
+	return (rq->cmd_flags & REQ_ATOMIC) == (next->cmd_flags & REQ_ATOMIC);
+}
+
 /*
  * For non-mq, this has to be called with the request spinlock acquired.
  * For mq with scheduling, the appropriate queue wide lock should be held.
@@ -833,6 +902,9 @@ static struct request *attempt_merge(struct request_queue *q,
 	if (req->ioprio != next->ioprio)
 		return NULL;
 
+	if (!blk_atomic_write_mergeable_rqs(req, next))
+		return NULL;
+
 	/*
 	 * If we are allowed to merge, then append bio list
 	 * from next to rq and release next. merge_requests_fn
@@ -960,6 +1032,9 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	if (rq->ioprio != bio_prio(bio))
 		return false;
 
+	if (blk_atomic_write_mergeable_rq_bio(rq, bio) == false)
+		return false;
+
 	return true;
 }
 
-- 
2.35.3


