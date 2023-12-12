Return-Path: <linux-fsdevel+bounces-5669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5752B80E9E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 12:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCD911F21365
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 11:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09005CD31;
	Tue, 12 Dec 2023 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oINOyPuU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ARlhJx+S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06EB10C1;
	Tue, 12 Dec 2023 03:10:08 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BC7hpfB021911;
	Tue, 12 Dec 2023 11:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=AI7wWNeH9LWA0Y0nIu01iwJ5SXOwYnCuLWBO5mP506U=;
 b=oINOyPuUOLmi7LYwFIHsZiFyeDiNaZXs7Ln4cb6ZMIPZjt8oVRAoGvZ3JUaqaPo5dn/r
 +FHMUxu1HF/M/dXF4jLBLFOTXv4aQJJQV6Ea1YnvNHKdbzENYnHlZHt2yOzWk4cnSayV
 rkIeWINhBPGwNoOsMNkGx4GuUvR1uI07Ix3X+fCQj+gTUlMCbJxD8H/cL45euacHOAP+
 d300vdvoVe7aUNbxqQvooiK5F0dRDEaxShwZj9x8arg+xo+EEd11XbMkHAaPqG7fkID6
 UygwzSJo3gvMiLhQL2rUGabvFi9VGwPPJzR6rCJhZYIkHubIgCE6V9amHjxDdBBZwBQG 3A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwgn3knah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:50 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCAwj7I008234;
	Tue, 12 Dec 2023 11:09:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep6cwvf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWh+CchaiMDwtS+BQMtAdWtTs2ePs537BAzX0aQ7VuYoI4lA+X5QC58jeEbwqxznD99ctY3eTCVijMD1l6DL/XjmEhy+CE+6lrI7lhneDNSSTQ65Z6FsYzh3lwcDeYjFiKk1eEP45ZORsPyr1ZhFZZjrjwX1CSn9d3S/nK8xIsh+DzBse99joMAvM05/8Mn0ZODvXAJxe7o3hF6h6jozGZ9RGlELEa6Ye/4atOb4JLzIjtA4tuxOtdML+AqMqVettOlf1seqUdaMY9wSyrG+dtUaKa58prh45/5s9r9z/trNk+EjBIaA9jgGtJHR7fPMDxAyfKIi2jnVlk/xJBWLgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AI7wWNeH9LWA0Y0nIu01iwJ5SXOwYnCuLWBO5mP506U=;
 b=Df7tPCt6m3gn3al3p0M5iWpxZf3JdM0/KmHSu8YvidlwTRShOt4GLDZVwr3TulBUFWY5I74KoGe5vTHauzWC/bz9CDzRW2Op7KXM64aNXb/hq0ygVyh9+Sm9bzUVhuKuYP27G/ZTKkBv+3AaKz3F3URq2GGvTgHaYVuBbZdCrx5QbWmOKthfvIY+x8MhuxyCu5B6aDGn9fb9OuPkD7RVy4vfwvn2Ase5sKkSTiKTQR4F+PcIgzLRKqc7hrjx3lzI2brivj/ikjzoGTtDWWwUzaL7vKxoLmPiS5cyp9UhtB3w6G7pDyquYsXjaNpFSPTv4LYDUV8a8r5gl/LfdGF/oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AI7wWNeH9LWA0Y0nIu01iwJ5SXOwYnCuLWBO5mP506U=;
 b=ARlhJx+S7NV1MABU1IOqqmcfAYfSrBGVu4wX+SHko3tmub0Z6j5ShCx/Td/ThqckhHBCq82pfxHJSdwgl1ZMN1dEXjYpIBJ+QKpSirDJem+fMJlmqqjWNzbrrYPvkHIt34buh1yCqf3N2fjGcEvWhGQ4ilhBGxzGKO6WT91duwk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6663.namprd10.prod.outlook.com (2603:10b6:806:2ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 11:09:46 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 11:09:46 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, jaswin@linux.ibm.com,
        bvanassche@acm.org, Alan Adamson <alan.adamson@oracle.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 15/16] nvme: Support atomic writes
Date: Tue, 12 Dec 2023 11:08:43 +0000
Message-Id: <20231212110844.19698-16-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231212110844.19698-1-john.g.garry@oracle.com>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0263.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::28) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd8afd4-9a3c-4251-451a-08dbfb02d967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	e7nR1ybpOKPgqMigIdNNaVuObIrIz6bzuGeLV6MrdoLQa3+yP8mgn/EpnsFqEFcUoVx3Mf83cUxEgdLUdIHejIrA56rYrHioJGOD0e45H33YE7qze/8bcFD0tu69fipeW4hUEVZIsTL2mNlBc395Fks8JBPatznesMuZHi+LlW+9v6dtvZKrN6InfNH4PDfm1w7yQ0dMsWByFd40F4nrnQphOv9+1wYginNOJTd7kLG8HzEQ8gy7cIS9PbotF3tvSEfEDZVX3YYqrDScePXTJ/GQX4dZ/oHwwaJlYMpKxyD77RZ1MR8RpOByH3IAv4NwMDKXMyZvVRcUjWeQjP0aQDfCYVFmVLbm2K66YJylWyzjscfcSLH4XYMv8zN/gKiTwgpVPcZ6QFXjoAFnBufq48T9pRhEnGoJhR1n+gbfqWwcGh+0ghNpKRPMNdl3TMK7SsGelxf42iR7igcRjPHW4/09d8M367qCv+DKOcmYyGws0YP1NB7OXDsIcvuXTxHNScUu3FpX3jYQ/7Rq7UhGBIdVHENyslPie759HMbtNPMxY6KrypQbGHCXkqsO/61PRvxjyplK08GDkZfvRM85PRAAFU4KiVthilmFuuz46JI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(6506007)(6512007)(2616005)(107886003)(1076003)(478600001)(5660300002)(4326008)(8936002)(8676002)(41300700001)(7416002)(2906002)(6486002)(6666004)(38100700002)(316002)(66476007)(66556008)(54906003)(66946007)(103116003)(86362001)(36756003)(921008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?v8Qu7NSlN7v+K8Qk00b94pX42efjOeg+h1oX4s7Ws6ex4mXDiJWzDIReb1WW?=
 =?us-ascii?Q?PzdECgrwFbHpoVXGrGeDv3YrQa9vuwLOAkwMgZBXEBURKHK8Gdhgwe/A1Q5P?=
 =?us-ascii?Q?iSSapsImVpE8fKxyudTqNjBL/b8dJE6auyqgNvPybjGK6tUyplIZ0lXwznyN?=
 =?us-ascii?Q?g3NFk4aMXHqFze9vp2KnvnzCQmZFkDXiQvUbqqxy4ApqwWyrM3mBDmZAkIc2?=
 =?us-ascii?Q?ue8SLAcyEqSdSXN+1a0YC3K0wOXRLVPKAA2QKS5Ahvw2uZqZPixbGn391LOO?=
 =?us-ascii?Q?I1duvlDGspKZv0O2uYF9h1qYc6ZEv387WUCeVUr1ebuwjzk8kHnbF2fV0Gza?=
 =?us-ascii?Q?wsuo7vpG9+PUxuFkrwPaSM+fQIEY8MgKeMY+KMYlfFhG7lEKTlKHD66ulASU?=
 =?us-ascii?Q?XcEfpGl0m3cd7fb228oF1YsD7uLWJ1VQJ6iv5IVQ5OJNPo6EdbLi6qPLMZ4N?=
 =?us-ascii?Q?uPGBhtQuqcszkErihaUlmExPVx0+k4asMRv2ZfAZGRGoQzvCDmWgDl30PBzb?=
 =?us-ascii?Q?iQr58s7NTslaBgvyU5tljMDVjktK62ctM/3ovYyRmeq+SFYzpUBlJQ5vqc1A?=
 =?us-ascii?Q?UpqmGIlYj5f66TZZAZzwp1THKE37Lr3pURveIGeYvgOo1ENXXY+4WUZYTUqg?=
 =?us-ascii?Q?c20Jr+33THRHJx79Y3Fdasdjv2YQigoqJPe0QNmOlsk4J6AoXlRbqBEXV5VM?=
 =?us-ascii?Q?rCxsvtYMayU5pTo2ec0vH+ODQTt6KZFJ/I6UbnPLmjQQ/huWzRIDh8xAp+dK?=
 =?us-ascii?Q?CTtAQJJi1o0/EnS40uIg8RtcRtiWVMcJpFl9S7bggQIfvEKVmRHfT9rcvuPx?=
 =?us-ascii?Q?qrgOmn1Tk2CG19dpoQ9ByZeI87ndRbJlKqRYICsbo4aiZjuvcdHVWx+LeZvE?=
 =?us-ascii?Q?cw2jj2+skrPFt5ppchqP0kyRjGpsXX+sSwXUv9Eu8VYC7F4yD2EYl42HlEQO?=
 =?us-ascii?Q?bQnV4Bpy3K8QFnlBxSo2Fdf8LFJqZQehfdc0OGIQpys/gAn7pbaYYQTMd49e?=
 =?us-ascii?Q?T+hx3HspUDgHtE98Cjvhji9mkomWorpkXYzP65JpjkRzhKFOWULlwLiTWOqQ?=
 =?us-ascii?Q?AqzvYP8NoZxuv7uwdYmX8QM+j84MDl/MxiYXqwBOwSVtwvTNKL5K1ToK/agG?=
 =?us-ascii?Q?bAVhzEqfCvWReF15ew1vgemfLrWFDFAqu2FUJA9NgYWwip2vRdUH3vrK0g6Q?=
 =?us-ascii?Q?MUywDqYO/rKedmzfq43vNj0/xu0AWhjSJylHE6ADnY8a1D6zPy2vSeyA7047?=
 =?us-ascii?Q?fE/duMeDJr0qIDoacAKWemerenXgRRyWB0aSV/b0lqUiBFCn0Vy4RAIhdCLc?=
 =?us-ascii?Q?GV9ifvQ+mKR/PPpNPt2hwJ6tc63uwuaavOjT9za3Etb8Lnwks+Nq5CJcdAH4?=
 =?us-ascii?Q?/rEOPsW1UI908kJBWK64HALCxPRODgrnAoywRdCHuCUn6LBtxgxEqOdOudaR?=
 =?us-ascii?Q?ZdeMKsTDs13eic0qp1eejPtZcL7ctDX5iMVhxGnDnU6MZpqaX/1yRIEqi9Zv?=
 =?us-ascii?Q?XfhsNft1SQdpB15A40OB1dF9YDx2WyoQXMKLMcuRy1MUyH9LPlr8hjSNMplY?=
 =?us-ascii?Q?CKsVFnqKvj9daN1MM/F6FpDe2zfOHYKCOav5RD0lO8YEpovtFgPwEKLJial9?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	muhR3dUeTk5Xo8KpIL/LVcPkwCbvC80n9Qp/s3N9UK4ubeuHGiMtgERWnPMWlpuJMrg3Tr0+bu1ofYGiefqKDsh9Q6xEq3o4dA4k6A4LNd6WTIFU7EqgpLR6z9DMHyQZvUnAclckh8cUTPRe59enExbOFlNPi5b21pErPfSNQbqaE6kK5Qc8S7cQX37WSu0rZPy+nze4WAtwFQSgVqH/aq6FprvdSD3bpUf+vAf+meLDh/apQqtThorjm9pT5hY2epXv4AATlgwe+afRaN+m+eiKb6GgeFVL6uFtsUuDK4uMBiF/saFM2Ww+fl47irFsGNV3yOnzD4ssUNXcVstrjDno5eSPuKmONUonvSP0c9zwQjcMMH0NAZKv6GpLojSgsfwV+mnSbBlIUdGFDnaNyL3+6IDzrUsM9MvFpagfb3YGkMNGyF7InlDlF9soFKcIcbTrBzZ7wEVF55k+eKaBzKCZn6BO/fsrmXgbCnyypg+OPMFu7K9c8Te+m2etpoufunl7PlkYsqP066U0607F2Oc9b4Oz4iMe8aea/nHpSCfZ5hWfJjO2T7J3rDhvjxx7mDouoghVWASIVw8+qtvZhqhKKuMnm3VKUMBgS7Mcvyg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd8afd4-9a3c-4251-451a-08dbfb02d967
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 11:09:46.0487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mc+/w9XzbyXAcFHwg6sxiYfXgZ0Seeok5SqDcU6w1A76UoqkStMgYdEdXloBzPqLrDJ4wrZHnhwQ98+6g4NoBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_04,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312120089
X-Proofpoint-ORIG-GUID: cupF7vrX7tqhuHEXQ3tNHBFh3q3pcOlV
X-Proofpoint-GUID: cupF7vrX7tqhuHEXQ3tNHBFh3q3pcOlV

From: Alan Adamson <alan.adamson@oracle.com>

Support reading atomic write registers to fill in request_queue
properties.

Use following method to calculate limits:
atomic_write_max_bytes = flp2(NAWUPF ?: AWUPF)
atomic_write_unit_min = logical_block_size
atomic_write_unit_max = flp2(NAWUPF ?: AWUPF)
atomic_write_boundary = NABSPF

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
#jpg: some rewrite
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/nvme/host/core.c | 85 ++++++++++++++++++++++++++++++----------
 1 file changed, 64 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8ebdfd623e0f..fd4f09f9dbe8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1894,12 +1894,68 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 	blk_queue_write_cache(q, vwc, vwc);
 }
 
+static void nvme_update_atomic_write_disk_info(struct gendisk *disk,
+		struct nvme_ns *ns, struct nvme_id_ns *id, u32 bs, u32 phys_bs)
+{
+	unsigned int max_bytes = 0, unit_min = 0, unit_max = 0, boundary = 0;
+	u32 atomic_bs = bs;
+
+	if (id->nabo == 0) {
+		unsigned int ns_boundary;
+
+		/*
+		 * Bit 1 indicates whether NAWUPF is defined for this namespace
+		 * and whether it should be used instead of AWUPF. If NAWUPF ==
+		 * 0 then AWUPF must be used instead.
+		 */
+		if (id->nsfeat & NVME_NS_FEAT_ATOMICS && id->nawupf)
+			atomic_bs = (1 + le16_to_cpu(id->nawupf)) * bs;
+		else
+			atomic_bs = (1 + ns->ctrl->subsys->awupf) * bs;
+
+		if (le16_to_cpu(id->nabspf))
+			ns_boundary = (le16_to_cpu(id->nabspf) + 1) * bs;
+		else
+			ns_boundary = 0;
+
+		/*
+		 * The boundary size just needs to be a multiple
+		 * of unit_max (and not necessarily a power-of-2), so
+		 * this could be relaxed in the block layer in future.
+		 */
+		if (!ns_boundary || is_power_of_2(ns_boundary)) {
+			max_bytes = atomic_bs;
+			unit_min = bs >> SECTOR_SHIFT;
+			unit_max = rounddown_pow_of_two(atomic_bs) >> SECTOR_SHIFT;
+			boundary = ns_boundary;
+		} else {
+			dev_notice(ns->ctrl->device, "Unsupported atomic write boundary (%d bytes)\n",
+				ns_boundary);
+		}
+	} else {
+		dev_info(ns->ctrl->device, "Atomic writes not supported for NABO set (%d blocks)\n",
+				id->nabo);
+	}
+
+	blk_queue_atomic_write_max_bytes(disk->queue, atomic_bs);
+	blk_queue_atomic_write_unit_min_sectors(disk->queue, bs >> SECTOR_SHIFT);
+	blk_queue_atomic_write_unit_max_sectors(disk->queue,
+		rounddown_pow_of_two(atomic_bs) >> SECTOR_SHIFT);
+	blk_queue_atomic_write_boundary_bytes(disk->queue, boundary);
+
+	/*
+	 * Linux filesystems assume writing a single physical block is
+	 * an atomic operation. Hence limit the physical block size to the
+	 * value of the Atomic Write Unit Power Fail parameter.
+	 */
+	blk_queue_physical_block_size(disk->queue, min(phys_bs, atomic_bs));
+}
+
 static void nvme_update_disk_info(struct gendisk *disk,
 		struct nvme_ns *ns, struct nvme_id_ns *id)
 {
 	sector_t capacity = nvme_lba_to_sect(ns, le64_to_cpu(id->nsze));
-	u32 bs = 1U << ns->lba_shift;
-	u32 atomic_bs, phys_bs, io_opt = 0;
+	u32 bs, phys_bs, io_opt = 0;
 
 	/*
 	 * The block layer can't support LBA sizes larger than the page size
@@ -1909,37 +1965,24 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	if (ns->lba_shift > PAGE_SHIFT || ns->lba_shift < SECTOR_SHIFT) {
 		capacity = 0;
 		bs = (1 << 9);
+	} else {
+		bs = 1U << ns->lba_shift;
 	}
 
 	blk_integrity_unregister(disk);
 
-	atomic_bs = phys_bs = bs;
-	if (id->nabo == 0) {
-		/*
-		 * Bit 1 indicates whether NAWUPF is defined for this namespace
-		 * and whether it should be used instead of AWUPF. If NAWUPF ==
-		 * 0 then AWUPF must be used instead.
-		 */
-		if (id->nsfeat & NVME_NS_FEAT_ATOMICS && id->nawupf)
-			atomic_bs = (1 + le16_to_cpu(id->nawupf)) * bs;
-		else
-			atomic_bs = (1 + ns->ctrl->subsys->awupf) * bs;
-	}
-
 	if (id->nsfeat & NVME_NS_FEAT_IO_OPT) {
 		/* NPWG = Namespace Preferred Write Granularity */
 		phys_bs = bs * (1 + le16_to_cpu(id->npwg));
 		/* NOWS = Namespace Optimal Write Size */
 		io_opt = bs * (1 + le16_to_cpu(id->nows));
+	} else {
+		phys_bs = bs;
 	}
 
+	nvme_update_atomic_write_disk_info(disk, ns, id, bs, phys_bs);
+
 	blk_queue_logical_block_size(disk->queue, bs);
-	/*
-	 * Linux filesystems assume writing a single physical block is
-	 * an atomic operation. Hence limit the physical block size to the
-	 * value of the Atomic Write Unit Power Fail parameter.
-	 */
-	blk_queue_physical_block_size(disk->queue, min(phys_bs, atomic_bs));
 	blk_queue_io_min(disk->queue, phys_bs);
 	blk_queue_io_opt(disk->queue, io_opt);
 
-- 
2.35.3


