Return-Path: <linux-fsdevel+bounces-5661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D92280E9BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 12:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F091F21933
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 11:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BA85DF02;
	Tue, 12 Dec 2023 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ieqL4Dz7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CYkeF4jt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26E3D5;
	Tue, 12 Dec 2023 03:09:45 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BC7hlpb028870;
	Tue, 12 Dec 2023 11:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=LBFgxpedTkFbvvKS24Y29UjrBHCkfr4l9A2KfGnrW84=;
 b=ieqL4Dz75lRft8mwNoeRckfT/yJwuZeA8GRkoROPjS5MKJvQrLAr47hn6pZHAyITakJq
 hK4Ju5YKVgF6FJ78pD5nyPAMUmq0YqpullAgzbKhF4i3Z5N1Jca+GBCQJJ9CENebKuxQ
 dcOVY+fwo27XwhBvfA+sDV+9/TrM+y/k1J3Q3xD2oeDMiC3T8s4nSFEs/PNrjdmUZ9Gv
 nsxiDtYRiwvWD3sCjCMSATEVFgRzfyoKYs15qw+YWc0MiCAlcKA+rTCMASHk8mOiFbzF
 dsagv0vzYA08/o0m0D3X5B9bAInNNRc5BLnK6M9l9JjR+1qL/KxgvAP4+goVaMxarHKW XQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvg9d5da0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCAwIat018681;
	Tue, 12 Dec 2023 11:09:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep6d55k-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuywUQWAW+X38ipm5PFvWFWHuo8y8u4BNFy2imCIV3YYhGRxDQy+sC9bNJEawNeIheKlzlk++kNmQjaIIiPtaVo8k9G0Tj5qYwuqmGresO+gTvlK7vmL2QWY83+3jvr6vmkazvuZ6JR0xOOtiTwfULmpBr3/H+Hm4hDC49diskIYgOVolB3Pdsl1CGd+4u7glRC2HWWrMM+SLwKUmoMCn6cbfDX7hlgGIGAsPQocyMCcPGzD9wO9spkzqMy4fFbUO+3zKNHiWnIEob6n5ixHeIY1miRPDydB2hNaVgRo9GlXDAKKtg8D4ST8TgYnYret+b8QZpoWWSqDLDjFW5J6gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBFgxpedTkFbvvKS24Y29UjrBHCkfr4l9A2KfGnrW84=;
 b=bgmio9zQsjIX9kff4LuWMjjeAuA/k39Zh6hE0IGCYQAcrth0NUxyBFfkO0W8d/i2AL/9Z7pFFYdz8S6tljxFYRb9mUraxi+B/KbxMCYvzAlwzK3Loqp3OwYIX/1MeRLncposyXJNr7q/ZwSWsiIpXDHQjVuLYEdXdB2L0D5FYxd7eMXZ4SX3CK/Fanb7ELhis1Qsa+8jUatF9pW/gZd7JSdYiU4/Qj/4P+tnJtZkjjwn8Wg/1t4ypYWIw/sLfIjiuXfFmONDJtZxNgaX2kuSMTr2u4Xz3F+b+XdolBqO9BKijM3GB/ShxBIOGTzH6ZCThx+oq1OATc4so4ergZD63w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBFgxpedTkFbvvKS24Y29UjrBHCkfr4l9A2KfGnrW84=;
 b=CYkeF4jt0uFjJIjelC6xLsayayYtE26vo4BK3SejT7qyLTDk3eZgqU7+LXwri9TLaRtghh1ffuEYbdLJr+D1W+iRaw6LtjV994FAmUXbOFl177EEkLg0YjhcGWfTzylEVluiX1eFyHY/tt+MkKfAL7s+UXp+N4+MgAqr9cw0vE8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6663.namprd10.prod.outlook.com (2603:10b6:806:2ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 11:09:21 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 11:09:21 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, jaswin@linux.ibm.com,
        bvanassche@acm.org, Himanshu Madhani <himanshu.madhani@oracle.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 06/16] block: Add REQ_ATOMIC flag
Date: Tue, 12 Dec 2023 11:08:34 +0000
Message-Id: <20231212110844.19698-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231212110844.19698-1-john.g.garry@oracle.com>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ca59c9-692a-43a7-07e9-08dbfb02ca85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Z4vkeyTsDlQltXbnGb6taKf0zU5Y3kZL6iIY03n/cHksF+nEWAbEiosQjmoxAnPWY/jtx3RLv1csPhqo6VpcX5jGukoeHL1uwL3N0r0ET6G9lCxQni1JsBh+BN0eusX1nPI1UQ9qPfCgxCE1/LxPpQBth8x3nmq2XDvH34ldME8YjYiOpOQlTbvtSq0R/a4rJfITS4TgL30ltxgHnwWlIKWZvP/jPwTlMGfQcSFPT/ZGAykfgpspJUJWrZCU000aZHFjRGKS+qmL1Sj4EVEanLACTYtiit5dni4lUDjhOGP7SkYP4y0K05fiVQ3QG/0b8MOcWjtKXFiQbpcB1U3p5BOPfB7TEqODnW6VszK47UTYF05tBi3vMRRtaAHJ5tFW/L72HsbSpKaFVeo96lq+3dPxhndrOG7C23R3Hx0u4V18BNjJKVp4Wn2Mz+z3qzfUwQ9x8lvC95VXxwE3gSx37Xuiuf4lR14PUZlfC9EjvuVlEGYshg5keRH6qTFLyGpnEsJBsTjQj6yQsS0KC5yjm9M5e+RnGwMrF3JmZ/IbDwyGkbHAHkTIKE+WrlgCX6fpyPU+OIjuUb8pVD7NxD91E6KCvlKTud12t+ZYKg/+Ipw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(6506007)(6512007)(2616005)(107886003)(1076003)(478600001)(5660300002)(4326008)(8936002)(8676002)(41300700001)(7416002)(2906002)(6486002)(6666004)(38100700002)(316002)(66476007)(66556008)(54906003)(66946007)(103116003)(86362001)(36756003)(921008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?SWWWMk7n9ER1BmlbhkJR6ytjnKS8v41rFXIt+ydln3vZ4PpNhVzVPDd1ia52?=
 =?us-ascii?Q?rP/e/ve0Cmyp/SN8inYhYMxI/4cXWApgGK8pnj9lBSmaUNrSJ2atki7V9aot?=
 =?us-ascii?Q?pgO3l1+eBLcoTfZEV2mS4kRipnsHK87ddZWyMMpbrOF0uRpndYY6m736RjhP?=
 =?us-ascii?Q?tugCgs/egXe4M78fFWTuac33UFH2wNZI2QeiCfno9DatZS8XvWOo6JifIM1r?=
 =?us-ascii?Q?VWRXosMWxfjY0CfQjX+zYk46DDeMos8hvGG6H3vdhrfnMo1UEKR0TbzQigFk?=
 =?us-ascii?Q?vYdGFbldnPnBUZWtqAurCCLBHi+jCc0QS6wlKWlIP605BiM8NTYg/C95+iBp?=
 =?us-ascii?Q?XVRiQhD4MdSI/RtxrNPcVJoFzfydHx/AhPE9ToqAgXKV0zbZStJWuhTD2pks?=
 =?us-ascii?Q?sOCaWhRIlD9Gcv2/LDZmG3URc+EUx6e23Do0cyYqcbdCYsx8pIN32avbDPS3?=
 =?us-ascii?Q?183Hqk8HbJ2OALUOFrSUoB0VIbIL5DBtYmL8VXfgwZnnqmdYaLxBDHjZ5vMz?=
 =?us-ascii?Q?rj9dE9rIWYk9j9+JqP1kHpJSpKrBj3OUpRoGFC1Je5GF8gR3Z8B0T4ySK0p2?=
 =?us-ascii?Q?V5SjC3KhMeLVgdr2thDneGi7fOn7PXMMF7TAY2PyTBUHmiHDm9yf6sCdkwCf?=
 =?us-ascii?Q?zqXHINH91E8GjyfaE+eom7Dl/NXfoDr/bJNnqogY2eLwYwXyxG3M9eAq3xl8?=
 =?us-ascii?Q?3mHbn5tHpixGdUnVWvvNHFvMUO5euEdNydcGsDcrAD1jIwlXwoZ5sD7f+VY0?=
 =?us-ascii?Q?hEa0CSKCWjrWBFV5sIJo/nvgx2c6fRfkHZL0vQAYATv+zhndNqGNQhXiNV7t?=
 =?us-ascii?Q?Wqai+zHNPFjodqPu82ODAT3ShwwUuBRI8+6Qt/oVlhdXrpOp1oZoWSgvWd7I?=
 =?us-ascii?Q?lxY5je8mz14IxVwnvs9kwm8RldpWcKUOu+eKPc5U2mPA3xfG1AG2QLQ7VS+e?=
 =?us-ascii?Q?z+vk5xMdwUTGzEkpHqzrMp0SChDCxgUzntpb2kAnm5Q986whOuzZV0+TsB26?=
 =?us-ascii?Q?FzLUdB4vsbbplVZ5pk9WVehmPqgAlZjw0X6N+A9Wu8x5E6jDzGX75hKRHZjG?=
 =?us-ascii?Q?veOsGVqtxhRmj49WVOhYWkVG17UH3NVDAVxIYDj7li00mjESi/3/AuhvYCUV?=
 =?us-ascii?Q?yYcYpCgCX3O2CwHhFtvS22DIE+UJTqd+UPzEPiI31zE36Z5omGH7l90IV7J3?=
 =?us-ascii?Q?ZIoDUHf3ecAlbKyoy53Wd8jCHJnib1TLZmgxtF/QuMdWi0HuNqbQxYa2V31R?=
 =?us-ascii?Q?1kFVh6vF7yPia7Ggjsrt+iM5hrgGmBgaTRzvrxl2CaHp4JtvCMJ8PQ9pLoH0?=
 =?us-ascii?Q?EsvDzs4Dk3vLHhPsO8UMocmObodRezuHKQVNaV2Av1+3+9vn8GduM2r3szri?=
 =?us-ascii?Q?5lfXttbaOZiPR3iDBg8Y76T3MPxAxNT6wQxlTiI1Qyt9gCpcY+WpC8EpvA42?=
 =?us-ascii?Q?dQhZeGpdMQmPsCTVKVMMbvpl2rBd8nhkZyNNNA5UmGPGhk6EufItijDSzGPj?=
 =?us-ascii?Q?miNd+MjuN9J1aEbI9Pua8thlxW6LWQU8COqDniFdVpfQ8w16SN+ARftnX5Ag?=
 =?us-ascii?Q?4Y01DcbozNlKCqJH2b8jEmfShRcRckYflB9MNxgHK7UyoRsOV1lSL2321T1n?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	sYM4ujFuTmFxveIPxMf0LQv4s1tTof8GzX1QS8ZJIsevLsAs88QRky/htMSbk3cj3RNlLqux1Q1bbQgLSdronktbm3QqkSijg1Zyis8X50HkMGiRBZyINGxv9Dg8WAXero0plt/c6JHa+NjRaBizMaxQy9Lg2dctijideBWv+uxBg4owpYF0J66WmWLaYXjkaZk4h2v80DQuyztcz9TV1K1+Pr2duhjP3ia/Q90Ev0ln7DokAbj6LCy/TRlYiojFkSmc2NWihFKytL9LfFcVDFmZcXV68Zqz7RZ9RHCb79WG7e8qzuiUK0uBWsFTDRarI5dnIzivvco5sKS8U7QbllMESpzDtNlfMN3ncrr6zLJIEKrSMq6BO1kW2Dw9BH6NXV/yd7NVH4F6tzVrjBA7FMPHsIv2idrOozfLWFGc049EAba9h31n7L/qsMbnAJxKiPqohWJYurRa06RaPVMvirYzEyfAeNYuNTzG+6FXAEKb67L0RlwUFj+iuEJxRZ29n+OB0SAU0JEqpzpqJJ4QxRig6inhqnpek0pltk8xl0yO53c2KGtAioqPDHjRuwamOpbcLUmUusnNV92KPvtLa4GMjPxup4nT00a4QM3ahBU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ca59c9-692a-43a7-07e9-08dbfb02ca85
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 11:09:21.0717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SaR8tGhr6q63KjVB1MK9ZswcBJ0PBhVX88wBfspAdSqKNIL48n2ewjspKw5qosj3YLMFM1HD6v6BIhzLAvBN6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_04,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312120089
X-Proofpoint-GUID: e5568fBUaDPnyYcjuBc9Gen1LfvJi0Qs
X-Proofpoint-ORIG-GUID: e5568fBUaDPnyYcjuBc9Gen1LfvJi0Qs

From: Himanshu Madhani <himanshu.madhani@oracle.com>

Add flag REQ_ATOMIC, meaning an atomic operation. This should only be
used in conjunction with REQ_OP_WRITE.

We will not add a special "request atomic write" operation, as to try to
avoid maintenance effort for an operation which is almost the same as
REQ_OP_WRITE.

Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 include/linux/blk_types.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index b29ebd53417d..b10d4db753b9 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -424,6 +424,7 @@ enum req_flag_bits {
 	__REQ_DRV,		/* for driver use */
 	__REQ_FS_PRIVATE,	/* for file system (submitter) use */
 
+	__REQ_ATOMIC,		/* for atomic write operations */
 	/*
 	 * Command specific flags, keep last:
 	 */
@@ -450,6 +451,7 @@ enum req_flag_bits {
 #define REQ_RAHEAD	(__force blk_opf_t)(1ULL << __REQ_RAHEAD)
 #define REQ_BACKGROUND	(__force blk_opf_t)(1ULL << __REQ_BACKGROUND)
 #define REQ_NOWAIT	(__force blk_opf_t)(1ULL << __REQ_NOWAIT)
+#define REQ_ATOMIC	(__force blk_opf_t)(1ULL << __REQ_ATOMIC)
 #define REQ_POLLED	(__force blk_opf_t)(1ULL << __REQ_POLLED)
 #define REQ_ALLOC_CACHE	(__force blk_opf_t)(1ULL << __REQ_ALLOC_CACHE)
 #define REQ_SWAP	(__force blk_opf_t)(1ULL << __REQ_SWAP)
-- 
2.35.3


