Return-Path: <linux-fsdevel+bounces-5666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 835DC80E9D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 12:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A7402816BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 11:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260A05EE7B;
	Tue, 12 Dec 2023 11:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bSFKxIx/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sfFEiGD0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2811EA0;
	Tue, 12 Dec 2023 03:09:49 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BC7i9iV008700;
	Tue, 12 Dec 2023 11:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=ywF7mrnAuyKRPnMwwtKddSv+HQAGzlcpV+6vWz6T6Xc=;
 b=bSFKxIx/FCAf2VgJokIvElPXEIeK12Cw/SshzKGb8U/4EOgja+mw7a/kNMsALWIULijq
 WMTccPsdRepWaFM8brlEfe5zyZVR3ozVsOIQNmiNp9QiHesWyhm4yjYNwsNWY4gg9Qhi
 X24FS+OzYisxS1CGW4tJodadTlJCqYtN5/L0WV406DplwQvXcmj0h62vh7vEMs+PMlca
 pM2wEBieVrOYrgEqC55dInRJ1M6pQH5oNVuz3NIC9x0IPyyqoceFB3+defulCpNtm9s8
 fdqxeOpImsJmMhDADKKzKfNfR3mbvixRUW6FfteDvXKBdKHzLFIftdT6Gx8iEgXqcI/M tw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvf5c5bkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCAwIaq018681;
	Tue, 12 Dec 2023 11:09:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep6d55k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIMY9gWlE1rItzhV6SeEC2HMAY9m9KkKGyGE5rmJsH6dVIHIWnsb0NTyeU1G2XhG0JxxsJkbjLLD0kWVG0ve2qGdIXQ4CTEqDWU7mXFKD9wYG6ZUfIfzOZGX2e1jFm5NCxQ5Pst4NjnIESH0XG0MJjWpXCbVT3j6FsV+/xLtuXpjMv2LA7WhKylMG1mfotzhahbEdn/PtPlErH7MvgxuLo/w8NT7HB/woNwtxBr5ZLAwnQkgiEKlyKdqtsl4jPWyAnboqq4QSwUEpf82mFaBtrM+XZQ78Uay21u3gZcb7Qb6mZ6dCBtrSrSPfgYQxQ/WqQwrnOocDrjFCnTCV3STBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywF7mrnAuyKRPnMwwtKddSv+HQAGzlcpV+6vWz6T6Xc=;
 b=aovruYB9E15QYWFfamL/HS2hx/QW41OrQRk8Q87dqmB5dzJSg9frUbL6UycOLxTz9PtvIVQYQ+ONNJfUFSQX4/jLY55ZGFBuGX+kiGs2fepRWD/z3kywu1ZICsxH2bbHa9S1Z7fdr9mCts0wL3aFmmVBpMWa2XARAS/j+QvBVBD8Aj4I9RcFlJoAXJXOdfvzaE4m4qP5m/4Hrxwsog603mhy0kkk1RC9WmqiKrADCExOgipGpZ8Z2ceBfPuvUZYa2CtKV4NoIR0BwMEfzqYADWoz1oGjrpJBLxxHzfxmbq/4+qkcAy1a0FEM0YowPK04MwQENPZAtsY9/nXrhXiCHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywF7mrnAuyKRPnMwwtKddSv+HQAGzlcpV+6vWz6T6Xc=;
 b=sfFEiGD0905Qvqz+gfZUi4HtxDBAIaqAA+Qret6S7boHLO+1vClbMWnvdJEwGJvfpPuRjs53Wcd+bypQcxoLHGt0fcQoAgZ7yMZbLPU4/sNVeA9h03w+e7s4Knrz6dm+1yZXgDAvIF2inTShZBPXuz8Zaa3YBRNrcNsrpfA8PIA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6663.namprd10.prod.outlook.com (2603:10b6:806:2ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 11:09:17 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 11:09:17 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, jaswin@linux.ibm.com,
        bvanassche@acm.org, Prasad Singamsetty <prasad.singamsetty@oracle.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 03/16] fs/bdev: Add atomic write support info to statx
Date: Tue, 12 Dec 2023 11:08:31 +0000
Message-Id: <20231212110844.19698-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231212110844.19698-1-john.g.garry@oracle.com>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P221CA0020.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f01874c-80bf-4c8d-8fd9-08dbfb02c88b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	90NJowif3oo3W/0g79+Iiw8ekzNF53dm1h/6Xw5FQu01Wf9HogVRKtPppWzBUPhUhvfDu+lH6ndppIi/XhuJMNY3MgeGy8/di6cZfF3kIhHDmFiCw4PGx16LwQBLMRLtdEeEDGvmdAEt2ZJam9hdDC/0zjSOGPYEGqLBZSyeWc/gpUVN1szoF9fe6MPreKHistHhwxWk2UIVgEiHCrD/M64NW/ijeUfJkudOtqI2vfilhFV7X6i8HGvL0R9zZZTqIdg+3VVlOUl99QxDEKoJJL4iQx23bwOpN5h0jq/T/JB9gSxuTQodGyiYLxR9zcUkkwEnZi7ikaqne3ka1kjWPqBL6cGDusvX6KYG18HF74SObAkYdQZ/hmPEvdmYufZMnLuvjJFXCEa41+b2QG4OLlC9r/t8zE4I24FeMIxkoETmOrDuyd5r7RDcLfatZD0uFRn3mT+OlNfeeBq+jsIhrmx4cT9St5hnIJq2AQElT1GwJYe/zCnfQLhQH4le3LpqprcfD9X5Q1/zIZHjDsFUe4J+ATSPSVgviO7Ymf032S/+yzHGhc6ocBqFkiZXM3Cxs+29ih13zbLNd0Vf5g4EdrErS6z/D9cWXWXmyxS/lKw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(6506007)(6512007)(2616005)(107886003)(1076003)(478600001)(5660300002)(4326008)(8936002)(8676002)(41300700001)(7416002)(2906002)(6486002)(6666004)(38100700002)(316002)(66476007)(66556008)(54906003)(66946007)(103116003)(86362001)(36756003)(921008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lebSU4I2Pj9Lsl5P7clfiqPQ8jMqNLB+EP31nzrCWFEkc/3qIlJ2U4F2uc4d?=
 =?us-ascii?Q?yJVdo6QyYG7g62ErmA6SU8cLhXV2PhucB/e3Hpk7DBxKZsuCwBGG5eEW/oX0?=
 =?us-ascii?Q?RW14PXNGG6MEVl2hICfWYLLONCH2Nfpi1J5OEoTawy8OfKuh4Xt7/d7P8L2y?=
 =?us-ascii?Q?YPp62s3y5gVOKelTst/RIb2mQIn6xR3spAe5jd0CCiPvYxfOrXePuNiPe5oi?=
 =?us-ascii?Q?jQiZFRWcEWo3sPu/WGHlXYidbaQreJF+xhDS4qpB13Wz42jVPXylLPLoEKyB?=
 =?us-ascii?Q?X5HuBxPtHjbgtcXEhtOsav3iXvc7NtGrX9TyZJRvhnQCtAsboMFY5CAuttPe?=
 =?us-ascii?Q?XZBB+gg68roz3GzxxZa3lTFidzkJmg5C91uP+m2VkLjVbBRwgLIa14JVUItV?=
 =?us-ascii?Q?RLVwLcUEU4XG7RUOT8e9wYe2wt16NEM6uzkA9IYjIWcOKPYrAZEb0Q74TrWN?=
 =?us-ascii?Q?PboPQPHpOorxMJggw+pWHS0fXdS+Pe0ARBLtiaMVN8nPBdcxcwf8OukgySL7?=
 =?us-ascii?Q?tiIidW6pcrPez6patMMUohHBpLCpiCk43bmbPN1OMjqRDIWQOva1MJmDeYsY?=
 =?us-ascii?Q?96eyJGrNWxa9M9Qb+RY5Lye1ToBWEGb/7wH+amQEaRNGClhoJYHoblpkUDF2?=
 =?us-ascii?Q?AHWWrBihBcOwUL/SJvT1iktsECNVaYspIlz6Xe9BY3VDHEaQ9q6taecBaYW2?=
 =?us-ascii?Q?cyVluCL0PfE/PSfIrbmrz2+3b3taXKRGXhygy3Yg0WoEvANHd73c3WOs8HPR?=
 =?us-ascii?Q?hrs1iRigLh32zJcONTUzGxbn3rjQgqmeCuyyS25wRuJHf8yy+wbRCng1U8Le?=
 =?us-ascii?Q?S3BhAXIiAucVi7DkFnlJtM12v9H08XhvxH0NldYLCqSaA2LhDFAc36ABbfFF?=
 =?us-ascii?Q?YA56og+aMbJ1+O2bW/0m7JY2DT8qjC6sAfkxCWBVPNT5nAUEk3zCh+IqA0mS?=
 =?us-ascii?Q?7T/6HFcmKs0tI0Aq4UGZc2wfVQuYqMhyY7TLHoDN06Mb9oCc+UI+7DgHAR3s?=
 =?us-ascii?Q?gPGQEYq+mb1O5tjDZDHBf09OApQPJIY1shezwOypvwoR2Dd8FRpdPtJru5KF?=
 =?us-ascii?Q?yIQrOQn7tt7QbDP9Nhv+IT4xnWc9dnF/qHC02WA5il2HlJZXSMzQlisi/Xj6?=
 =?us-ascii?Q?i+atekNU/TRBgrAwJY7F2GvSw3ikvArWR57FCxqXO3ZW5UH+N/WRCx/c/3Qy?=
 =?us-ascii?Q?4UzcoX1feeCld1cGX8HmuKI0/3nuj9wkddEIb3NFtJMhWnY0wK7hquVNBdcK?=
 =?us-ascii?Q?impBeJahw7LVahtT1blboKKcb1uQkbgV1y9YKCIaoySxaymVwOtlE0f9osfi?=
 =?us-ascii?Q?Xmsf29NJxES9z4tPMdTCgw8ac8PoFanZ073rWjVA2JhhlmsRVVUeF8MXUX6A?=
 =?us-ascii?Q?07c+YnoQVr59xvYF6srhjT4YprYXnjx3sCy7LZw4bYdB8fQWuF8UJVHjXHOH?=
 =?us-ascii?Q?ONhblSX4DdtRmZc2a45fIbdWG4LOmqBbsw2UCv0E6iuZ0Ae3nN2ffomOHDvQ?=
 =?us-ascii?Q?1g7KIt0WTnGVOF53hywk59OfecWjSRLXmmL/HEDfShmBgMU9mXuWv8lwYxjQ?=
 =?us-ascii?Q?/2joerWOxD/d1hCwmFlqR//ly8cCSjSO9RYrDP4E6VzMkxgBxzVx1gaTRNIa?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	z2+eAYzSeq10mErczKYNwXZGTH9YBRjhpv/LMAyjAuSkpKkVPXngtVhMaP+rTNQXKTP2Ttk7SN6xZOWpldQVW2qmTzkjnMnFbpgM4FnVZ/fLnuV2TID3Xbyw6k1lgW9XMpxawJiLzi9GWynoWm4xa/M8Y7f2iZiQuMVYW83WStNNNH0IlpwXeUEI9vrWPvnhFUu+JXkWlOp4+/X/XlsrwXBKLHl2CP2VimTk5ic/pXPDVm8V1mF21BAomRwJXTD6QPXSdCi4KvVqf8FVG+Kfz7XGfM/IWWsouI65LV39nuPMOLgMQLj+V8xO8cFeTtwrzov29uv/lI1Hn75GjTKDpgkQZ4sa16Kb8y7apoa8JRAUNsgfbenxXjmDzf8ktbFdFrvYh8LMrcjX4P1FgEdwZvLXWYY3Isbonffmn9LEe/Myr7U2JugGKhoIx46SgYaE0+o4s21iaKeUhyrjG/mmtS1rFXYiV+Fa8ORxQ/0WcFEuw0BvTztSfI7XVbfK2HIT+St4sNmY8+cuGfMuVcpvoo2KmLdRN4GNH00xmW8rPD6H5Wi6eN7hWimxNBRbQZpXFjNuGoy9VzcU0MfDB1WKlzSLMjXkz36NyM8YsekTJ+Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f01874c-80bf-4c8d-8fd9-08dbfb02c88b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 11:09:17.7129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9QsViAfy4THZpCHHX+HbN2uEqPVMvIdIFvBAgadMe3qAy4q+smTZ7J5BpDeDnMnlj5paw9Zn0YNtjoPcmP2vkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_04,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312120089
X-Proofpoint-ORIG-GUID: 043myKRgbO9iU9jJvO4bbnqMxK6b5qa4
X-Proofpoint-GUID: 043myKRgbO9iU9jJvO4bbnqMxK6b5qa4

From: Prasad Singamsetty <prasad.singamsetty@oracle.com>

Extend statx system call to return additional info for atomic write support
support if the specified file is a block device.

Add initial support for a block device.

Signed-off-by: Prasad Singamsetty <prasad.singamsetty@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/bdev.c              | 31 ++++++++++++++++++---------
 fs/stat.c                 | 44 ++++++++++++++++++++++++++++++++-------
 include/linux/blkdev.h    |  4 ++--
 include/linux/fs.h        |  3 +++
 include/linux/stat.h      |  2 ++
 include/uapi/linux/stat.h |  7 ++++++-
 6 files changed, 71 insertions(+), 20 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 750aec178b6a..1b514df48dac 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1081,24 +1081,35 @@ void sync_bdevs(bool wait)
 	iput(old_inode);
 }
 
+#define BDEV_STATX_SUPPORTED_MSK (STATX_DIOALIGN | STATX_WRITE_ATOMIC)
+
 /*
- * Handle STATX_DIOALIGN for block devices.
- *
- * Note that the inode passed to this is the inode of a block device node file,
- * not the block device's internal inode.  Therefore it is *not* valid to use
- * I_BDEV() here; the block device has to be looked up by i_rdev instead.
+ * Handle STATX_{DIOALIGN, WRITE_ATOMIC} for block devices.
  */
-void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
+void bdev_statx(struct dentry *dentry, struct kstat *stat, u32 request_mask)
 {
 	struct block_device *bdev;
 
-	bdev = blkdev_get_no_open(inode->i_rdev);
+	if (!(request_mask & BDEV_STATX_SUPPORTED_MSK))
+		return;
+
+	bdev = blkdev_get_no_open(d_backing_inode(dentry)->i_rdev);
 	if (!bdev)
 		return;
 
-	stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
-	stat->dio_offset_align = bdev_logical_block_size(bdev);
-	stat->result_mask |= STATX_DIOALIGN;
+	if (request_mask & STATX_DIOALIGN) {
+		stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
+		stat->dio_offset_align = bdev_logical_block_size(bdev);
+		stat->result_mask |= STATX_DIOALIGN;
+	}
+
+	if (request_mask & STATX_WRITE_ATOMIC) {
+		struct request_queue *bd_queue = bdev->bd_queue;
+
+		generic_fill_statx_atomic_writes(stat,
+			queue_atomic_write_unit_min_bytes(bd_queue),
+			queue_atomic_write_unit_max_bytes(bd_queue));
+	}
 
 	blkdev_put_no_open(bdev);
 }
diff --git a/fs/stat.c b/fs/stat.c
index f721d26ec3f7..ad8f9235f1c9 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -89,6 +89,35 @@ void generic_fill_statx_attr(struct inode *inode, struct kstat *stat)
 }
 EXPORT_SYMBOL(generic_fill_statx_attr);
 
+/**
+ * generic_fill_statx_atomic_writes - Fill in the atomic writes statx attributes
+ * @stat:	Where to fill in the attribute flags
+ * @unit_min:	Minimum supported atomic write length
+ * @unit_max:	Maximum supported atomic write length
+ *
+ * Fill in the STATX{_ATTR}_WRITE_ATOMIC flags in the kstat structure from
+ * atomic write unit_min and unit_max values.
+ */
+void generic_fill_statx_atomic_writes(struct kstat *stat,
+				      unsigned int unit_min,
+				      unsigned int unit_max)
+{
+	/* Confirm that the request type is known */
+	stat->result_mask |= STATX_WRITE_ATOMIC;
+
+	/* Confirm that the file attribute type is known */
+	stat->attributes_mask |= STATX_ATTR_WRITE_ATOMIC;
+
+	if (unit_min) {
+		stat->atomic_write_unit_min = unit_min;
+		stat->atomic_write_unit_max = unit_max;
+
+		/* Confirm atomic writes are actually supported */
+		stat->attributes |= STATX_ATTR_WRITE_ATOMIC;
+	}
+}
+EXPORT_SYMBOL(generic_fill_statx_atomic_writes);
+
 /**
  * vfs_getattr_nosec - getattr without security checks
  * @path: file to get attributes from
@@ -254,13 +283,12 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
 		stat->attributes |= STATX_ATTR_MOUNT_ROOT;
 	stat->attributes_mask |= STATX_ATTR_MOUNT_ROOT;
 
-	/* Handle STATX_DIOALIGN for block devices. */
-	if (request_mask & STATX_DIOALIGN) {
-		struct inode *inode = d_backing_inode(path.dentry);
-
-		if (S_ISBLK(inode->i_mode))
-			bdev_statx_dioalign(inode, stat);
-	}
+	/* If this is a block device inode, override the filesystem
+	 * attributes with the block device specific parameters
+	 * that need to be obtained from the bdev backing inode
+	 */
+	if (S_ISBLK(d_backing_inode(path.dentry)->i_mode))
+		bdev_statx(path.dentry, stat, request_mask);
 
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
@@ -653,6 +681,8 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 	tmp.stx_mnt_id = stat->mnt_id;
 	tmp.stx_dio_mem_align = stat->dio_mem_align;
 	tmp.stx_dio_offset_align = stat->dio_offset_align;
+	tmp.stx_atomic_write_unit_min = stat->atomic_write_unit_min;
+	tmp.stx_atomic_write_unit_max = stat->atomic_write_unit_max;
 
 	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ab53163dd187..ab7289995615 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1548,7 +1548,7 @@ int sync_blockdev(struct block_device *bdev);
 int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend);
 int sync_blockdev_nowait(struct block_device *bdev);
 void sync_bdevs(bool wait);
-void bdev_statx_dioalign(struct inode *inode, struct kstat *stat);
+void bdev_statx(struct dentry *dentry, struct kstat *stat, u32 request_mask);
 void printk_all_partitions(void);
 int __init early_lookup_bdev(const char *pathname, dev_t *dev);
 #else
@@ -1566,7 +1566,7 @@ static inline int sync_blockdev_nowait(struct block_device *bdev)
 static inline void sync_bdevs(bool wait)
 {
 }
-static inline void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
+static inline void bdev_statx(struct dentry *dentry, struct kstat *stat, u32 request_mask)
 {
 }
 static inline void printk_all_partitions(void)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98b7a7a8c42e..70329c81be31 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3084,6 +3084,9 @@ extern const struct inode_operations page_symlink_inode_operations;
 extern void kfree_link(void *);
 void generic_fillattr(struct mnt_idmap *, u32, struct inode *, struct kstat *);
 void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
+void generic_fill_statx_atomic_writes(struct kstat *stat,
+				      unsigned int unit_min,
+				      unsigned int unit_max);
 extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32, unsigned int);
 extern int vfs_getattr(const struct path *, struct kstat *, u32, unsigned int);
 void __inode_add_bytes(struct inode *inode, loff_t bytes);
diff --git a/include/linux/stat.h b/include/linux/stat.h
index 52150570d37a..ba690ff89efd 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -53,6 +53,8 @@ struct kstat {
 	u32		dio_mem_align;
 	u32		dio_offset_align;
 	u64		change_cookie;
+	u32		atomic_write_unit_min;
+	u32		atomic_write_unit_max;
 };
 
 /* These definitions are internal to the kernel for now. Mainly used by nfsd. */
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 7cab2c65d3d7..64dfc1baa640 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -127,7 +127,10 @@ struct statx {
 	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
 	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
 	/* 0xa0 */
-	__u64	__spare3[12];	/* Spare space for future expansion */
+	__u32	stx_atomic_write_unit_min;
+	__u32	stx_atomic_write_unit_max;
+	/* 0xb0 */
+	__u64	__spare3[11];	/* Spare space for future expansion */
 	/* 0x100 */
 };
 
@@ -154,6 +157,7 @@ struct statx {
 #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
 #define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
 #define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info */
+#define STATX_WRITE_ATOMIC	0x00004000U	/* Want/got atomic_write_* fields */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
@@ -189,6 +193,7 @@ struct statx {
 #define STATX_ATTR_MOUNT_ROOT		0x00002000 /* Root of a mount */
 #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
 #define STATX_ATTR_DAX			0x00200000 /* File is currently in DAX state */
+#define STATX_ATTR_WRITE_ATOMIC		0x00400000 /* File supports atomic write operations */
 
 
 #endif /* _UAPI_LINUX_STAT_H */
-- 
2.35.3


