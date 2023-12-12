Return-Path: <linux-fsdevel+bounces-5672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 417D780E9FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 12:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2D2281E6C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 11:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310765D48D;
	Tue, 12 Dec 2023 11:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iWt+rbOB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZEBKg62r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983F51BD1;
	Tue, 12 Dec 2023 03:10:17 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BC7hhli004079;
	Tue, 12 Dec 2023 11:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=/t0zPXXcRWFzWm94HZuIP3m7HVI3K70dH5CmAqqifJg=;
 b=iWt+rbOB7ercdVygWsmI4hqx2M4RGI5h4btVw8zMRvWvdo9nDjPdMBGd/H2eYOLOGcEQ
 IcbxLrL+10IZzxww+9i+tvJGPBwIkywb2CO6Eo3c2a00eVHYXsLQ3gqFYDxy6e6z+bXg
 1bn2JD43RLmHRmIbgTtXmMBkvXmnXzaidpem9gPUanEBwGrFJuYh4IAY8hcx5q5jm8z0
 a04RGJhEP7uzv4dsn9Tph1EqWsOB6A6shOcHuK0O28psCDObqD9k3UGHd+W090lFD9BZ
 lidUbashNn7j6lKdWpD8YBuj2eyYsPv3XmKutsdow09/KlWNMjQ2WowTh5apQnSzKQF7 Yw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvfuu5bhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCAxAsu003210;
	Tue, 12 Dec 2023 11:09:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep6e16k-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuB2eLGm4pDBtviyY0cmvrZb89DFKY8hv3ztWmhFl0yeDJoveoPmgl0Kt3n+/JWyohtHw3OGtRhoADoNJGFpDYaSJXplb29vxBGks++maKAw7EZ39GDqjyVy19H7p+czJ2reQHPU64NHUKWNdSe8RTQqOQJIh8kdwM83I+xGiQBLkACAHSuRn2RFZVMhfqyZ5NV7nS1WBr0zmdbKEhTjyaSqP1qyNisIKIZ2L75nNdQLiLcml16WXh9TyyHanRkw4psAizWjZBdNlDq54oeSLIO7N6Bl49yMJRyQ7FOfs/Y1ULFEDO0rHOmgfM1+9vI5q30TRwne8KIcFOqqliSAPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/t0zPXXcRWFzWm94HZuIP3m7HVI3K70dH5CmAqqifJg=;
 b=KFiiCELSYOb6wM2ZTrH5FxiSQiQItYhYMnww8yZ7jKYwO8CVM3b5OGvVubD74EGGPXbY9adNmvd5VI/uOATZ3Uz+wBj5YQxHj62bFliLsgtlhTZMARbUSrTRssQ2YxdMYnZnWUknTF8aZxMq/DBIK6tnQeABho4oU7Y7zWcE0pJH0M4qIQGvSjGDJsqKAeNLGg2eJ3QsTlnIPnux+iHi357K03R9mHRnJBbbPiQAT3/Ou9sl4X0dQWr9PzSWk4qX8BIflMCjD5raHrXJeaBn7TZDyFAVf9zWhy2lBNGhs2aE3zKoOHajGFtlBoKEr/D/5KrsWW2GmofpEpns14WGdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/t0zPXXcRWFzWm94HZuIP3m7HVI3K70dH5CmAqqifJg=;
 b=ZEBKg62reYevxTCzO1djRdfDTt1Aeq5wBVdZlNuT278008Nvko5g7lCvujMHWedNICCmjYHUpT3FGF6eCi3Cy05NVHby9pB7k2PXjnIxHmaMoVlSV/PCvi0KMrnUVV0VS1OMkgLNaU+hACGdmNPoCSKVvbEWKWjVQ8oaTWXasrA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6663.namprd10.prod.outlook.com (2603:10b6:806:2ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 11:09:15 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 11:09:15 +0000
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
Subject: [PATCH v2 01/16] block: Add atomic write operations to request_queue limits
Date: Tue, 12 Dec 2023 11:08:29 +0000
Message-Id: <20231212110844.19698-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231212110844.19698-1-john.g.garry@oracle.com>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0031.namprd17.prod.outlook.com
 (2603:10b6:208:15e::44) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 28c6f2f5-15e8-4e1f-f6d3-08dbfb02c738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ALdBC/EvuVYkOrTCyO/ohDIPyxDnhpPSiQq7eUQj5XJlFfhuktRaucw80P54EHeHMfEgV7pwnZzSGTHB0AvduJcokeDnj+knW43OXMhrvZ92WX8/u2mfjJi8zv81Hywek0Z7A/LTJcJRCAAIJJkE/Et1EJ5NeD/On8XJroTQ1cInyQ8XAq7jhgmm5RuPYQrCqfwplAo5Me9QIcysyHowIDuuvEPEvrRNOzjk1AgkNR5lebrgYVVplBWHuiaB0oaNp4B+nlot2RTWq/jKLTDFD64q8geJbxDfV4MybCiQ2uOT2MwrGCFHQI0zUNS1NO+gbwr3PVaiB4S4X4DXfTeSg3k7YrAZw0HKXZKB7hMHKe9wJdvzXh/QctxeKzAVkJyzLc0n6n7Q+3dJtDjdiVADazTTdUE+srx7JLhPTJ4Nm/YxgDVlpm+0Hv90obZjXnnSfIDBJlh3RNL4XkvkoRolwhkoLE9LU0JTlCchFVptsFeSJ9iciEGrdXSecE/5OCLDUARIANlAcSPqi0+AUemxokkX7EIERpJK9GwlN56NeCzHQnwD7bPl08jdlmQf818jAqjJV2YIugdbGw4IYx781MVpaMEk8mls3YGKLO39pqs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(6506007)(6512007)(2616005)(107886003)(1076003)(478600001)(5660300002)(4326008)(8936002)(8676002)(41300700001)(7416002)(2906002)(6486002)(6666004)(38100700002)(316002)(66476007)(66556008)(54906003)(66946007)(103116003)(86362001)(36756003)(921008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?EhDOrR8F0wnQqw+6Pt25Z5HPpnDjKny5enPwfiaKynUYa452xmXupCf3Tp4k?=
 =?us-ascii?Q?8+6NKPPXKKZvVKv7u6ApkQo17wT3IR4yCRObp6Ki8o4nzigt698Bbz0Df5OG?=
 =?us-ascii?Q?dgLE4nlSlpHTZk+FoeE+jyojKnTMxOXK+fBgfn6FTgz/8LFieQLrjs2Mphsy?=
 =?us-ascii?Q?zKYsAue+wlcE+QayYW/nNNIchT/R+xtBxEvSBit0fBXJ3Z4EEXPGS/O7IoK3?=
 =?us-ascii?Q?/5go7+1X1iefd+cKwFnsm6Wm+BmyBVIymsIduAGfudZKbFQucLF5ipAbYzEj?=
 =?us-ascii?Q?R2jfGDOnHlux7e1bDPYudKKTCIflaZbuUJmPW2/Ml9OCHKRTNJsGHYu33Hk8?=
 =?us-ascii?Q?5DukvQ9kL+mGRwFx9GxyuzHfzxPW0LQq1vJbMHaePL6iFoAIbD1zPDhf+5j4?=
 =?us-ascii?Q?ZVrFQLyQr8afvq1jWCP3QBTh8lJwAuu1n5lySHzNg7MdDr8wdFkhxmgKKQMx?=
 =?us-ascii?Q?Ya+/+s9hIOIFEdwMBTJX2oNvt0xDl8VGxY2hdQy3tYt47qjl/PhXlo8kjE/p?=
 =?us-ascii?Q?DpyqH+8esfBaGfcdwCtJ5KzqMcoH+E3kHRVghEY2YPfsg4URgdV3hbMuQpHj?=
 =?us-ascii?Q?AZX7vjC05zXFPMJGkGFJ6OlnirOs6v1Of7fAj3/nPUv2yCLbj2epV2Gcp0D0?=
 =?us-ascii?Q?jQV4DQzQDiCNSel5JC7FBvmGi0z3UjJiuOVgY/b+M013blz0cfHLWLYp2w9d?=
 =?us-ascii?Q?XiuzdyEx1fBTO+ZvK/4oaPWOnRi9oiQQTErgHhIo3Bi8NUemlsz5ps6Zk92V?=
 =?us-ascii?Q?FNKY1II94P5MyGfmb3n2w3HC91xsRzB6lzssI2/Vv8rgaom74mP5gjHdhCJv?=
 =?us-ascii?Q?eLm0gxYrJJDqLnyULbnKK8z/F5SSNCe5hrAS3Xz6rIFmIxtjXWi8HYNCr+KE?=
 =?us-ascii?Q?NxBrPoVy0EM0AAdigy/hhQqqKJlB205IiGpAvPW0uJ2MSJqreBGMKmH+upkz?=
 =?us-ascii?Q?DpwOGymMnlvfMnTSfWWOgljpAPoqFIAye5vm5EAG82eQzC4DP/Bogb+vidQV?=
 =?us-ascii?Q?/rD7jd2IOSToFyaielk12gKEFw+1G3V7ykgrYJSw1QQAPR3fyZJiyAd1qr37?=
 =?us-ascii?Q?tCBpgzfUxBkNpEKV7dPGfJA8FC+1ZJptINHsH238TlUwHOvHLpq1Xy++zydO?=
 =?us-ascii?Q?SOFiUqUwxjdTujurSbM3nrp12uM96IxcS74lL9HDIxOWlpGMgLcxRaLvmurR?=
 =?us-ascii?Q?UPdQ5VqIpQ9Lg1OIBwK2+LTXKYBB0Jc340L8NNqQi3gyHj6xOgKv/P8Nk7lk?=
 =?us-ascii?Q?3z8GOk3AHsGMQKBPupAUzl1pHmrMfVMN/byUTYLlOTqYIXxVPnfFvVZ8QkUp?=
 =?us-ascii?Q?MF2ZhFHaRkmQ8/Ku2Mom5NbxJRKU7s8ZbEXM8Zn6yrELHO+yOwrd5Sqdx8lD?=
 =?us-ascii?Q?N4q/suKF/Yxad4B9qrHoQ8NKm7gqF3uOle3zt8ErxiVpfM8uIkxHNCyboFnP?=
 =?us-ascii?Q?gK2hzSCM3rr2PMp9U/zqea03on4GCC1sHrx6xA3h7asIIrhfofiiOkm5DCYX?=
 =?us-ascii?Q?vI48NgItLUnwGBkPLmTpX5bLjFJoJwAFsP03Oo9FYOBz9ws70rROCMdE7TSe?=
 =?us-ascii?Q?J1RuLX7Gf9DXFBXI5jepdIskj7dXPPG6kO/6j7/WxKA786n7MCmv39TN3C4/?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0qoJPYQ7j+3WzEJ9IXykfVoq0l8unu6lYvLBwikSwTmVDCZNZ8x/nqqE3gIeV75mgIO0UaQXySWL/3tlN4SL7rILlRH9smxNTcQDbcT0qQOJcBQqapS+BR7nav/II3aehOGzPoEh8jq2VfQGifn90GfBybzkmUKRcWArfrtitBqtgwpcfmVRpuxGlcPo+4DanWNP4BXZxR5mgB+2ibsFcLG/Wvrb9v67fWylGKo/ctEkxOGAn/HkkNxDwExmcTfWiP4ufpRIjugjNJbvhXXqforez5mJ4L9xYVVA75cNtstOwBnDff+hw3HOBrZJvzZWKUi///LoD0T/7cfA3+EzvwO79Xn7FJhOo8lUwC+aUZz+rBLl/PH29rEPIiI2JiQZsPmpu/5tdwBHeMbHuS2RZhZx5Av0VImOaG66KmtamN23c2NXdCaHIzIsgcq7IF1Nk8MkptSBWFvV8e2EilY7A+8Cgxukx8LBVLOXoI2PscSILR5h1QFGkugzrCRScpr1GfSB0XmMuMpCSc0FCI4o0h1sF7uS5ZtyAqV/TF1ux0P8s7wfoLS5IL3LCvNcNLEY0d8MdhbN9b8HSEYrf6bcRzHQ/E1u6qN0JOwT7yrXvCY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c6f2f5-15e8-4e1f-f6d3-08dbfb02c738
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 11:09:15.5085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BtBrAxx19HWgQ25pPxl1bmmPccxJusrZYFN/zEG3xBkT6LSJnTLNq4GaGsSrWT0HivVB1vHVytwmTd0ooZ9ImA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_04,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312120089
X-Proofpoint-GUID: 68ZRdlAkdztc9O9E1I81pKTctJdFAUUi
X-Proofpoint-ORIG-GUID: 68ZRdlAkdztc9O9E1I81pKTctJdFAUUi

From: Himanshu Madhani <himanshu.madhani@oracle.com>

Add the following limits:
- atomic_write_boundary_bytes
- atomic_write_max_bytes
- atomic_write_unit_max_bytes
- atomic_write_unit_min_bytes

All atomic writes limits are initialised to 0 to indicate no atomic write
support. Stacked devices are just not supported either for now.

Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
#jpg: Heavy rewrite
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 Documentation/ABI/stable/sysfs-block | 47 ++++++++++++++++++++++
 block/blk-settings.c                 | 60 ++++++++++++++++++++++++++++
 block/blk-sysfs.c                    | 33 +++++++++++++++
 include/linux/blkdev.h               | 37 +++++++++++++++++
 4 files changed, 177 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 1fe9a553c37b..ba81a081522f 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -21,6 +21,53 @@ Description:
 		device is offset from the internal allocation unit's
 		natural alignment.
 
+What:		/sys/block/<disk>/atomic_write_max_bytes
+Date:		May 2023
+Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
+Description:
+		[RO] This parameter specifies the maximum atomic write
+		size reported by the device. This parameter is relevant
+		for merging of writes, where a merged atomic write
+		operation must not exceed this number of bytes.
+		The atomic_write_max_bytes may exceed the value in
+		atomic_write_unit_max_bytes if atomic_write_max_bytes
+		is not a power-of-two or atomic_write_unit_max_bytes is
+		limited by some queue limits, such as max_segments.
+
+
+What:		/sys/block/<disk>/atomic_write_unit_min_bytes
+Date:		May 2023
+Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
+Description:
+		[RO] This parameter specifies the smallest block which can
+		be written atomically with an atomic write operation. All
+		atomic write operations must begin at a
+		atomic_write_unit_min boundary and must be multiples of
+		atomic_write_unit_min. This value must be a power-of-two.
+
+
+What:		/sys/block/<disk>/atomic_write_unit_max_bytes
+Date:		January 2023
+Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
+Description:
+		[RO] This parameter defines the largest block which can be
+		written atomically with an atomic write operation. This
+		value must be a multiple of atomic_write_unit_min and must
+		be a power-of-two.
+
+
+What:		/sys/block/<disk>/atomic_write_boundary_bytes
+Date:		May 2023
+Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
+Description:
+		[RO] A device may need to internally split I/Os which
+		straddle a given logical block address boundary. In that
+		case a single atomic write operation will be processed as
+		one of more sub-operations which each complete atomically.
+		This parameter specifies the size in bytes of the atomic
+		boundary if one is reported by the device. This value must
+		be a power-of-two.
+
 
 What:		/sys/block/<disk>/diskseq
 Date:		February 2021
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 0046b447268f..d151be394c98 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -59,6 +59,10 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->zoned = BLK_ZONED_NONE;
 	lim->zone_write_granularity = 0;
 	lim->dma_alignment = 511;
+	lim->atomic_write_unit_min_sectors = 0;
+	lim->atomic_write_unit_max_sectors = 0;
+	lim->atomic_write_max_sectors = 0;
+	lim->atomic_write_boundary_sectors = 0;
 }
 
 /**
@@ -183,6 +187,62 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
 }
 EXPORT_SYMBOL(blk_queue_max_discard_sectors);
 
+/**
+ * blk_queue_atomic_write_max_bytes - set max bytes supported by
+ * the device for atomic write operations.
+ * @q:  the request queue for the device
+ * @size: maximum bytes supported
+ */
+void blk_queue_atomic_write_max_bytes(struct request_queue *q,
+				      unsigned int bytes)
+{
+	q->limits.atomic_write_max_sectors = bytes >> SECTOR_SHIFT;
+}
+EXPORT_SYMBOL(blk_queue_atomic_write_max_bytes);
+
+/**
+ * blk_queue_atomic_write_boundary_bytes - Device's logical block address space
+ * which an atomic write should not cross.
+ * @q:  the request queue for the device
+ * @bytes: must be a power-of-two.
+ */
+void blk_queue_atomic_write_boundary_bytes(struct request_queue *q,
+					   unsigned int bytes)
+{
+	q->limits.atomic_write_boundary_sectors = bytes >> SECTOR_SHIFT;
+}
+EXPORT_SYMBOL(blk_queue_atomic_write_boundary_bytes);
+
+/**
+ * blk_queue_atomic_write_unit_min_sectors - smallest unit that can be written
+ * atomically to the device.
+ * @q:  the request queue for the device
+ * @sectors: must be a power-of-two.
+ */
+void blk_queue_atomic_write_unit_min_sectors(struct request_queue *q,
+					     unsigned int sectors)
+{
+	struct queue_limits *limits = &q->limits;
+
+	limits->atomic_write_unit_min_sectors = sectors;
+}
+EXPORT_SYMBOL(blk_queue_atomic_write_unit_min_sectors);
+
+/*
+ * blk_queue_atomic_write_unit_max_sectors - largest unit that can be written
+ * atomically to the device.
+ * @q: the request queue for the device
+ * @sectors: must be a power-of-two.
+ */
+void blk_queue_atomic_write_unit_max_sectors(struct request_queue *q,
+					     unsigned int sectors)
+{
+	struct queue_limits *limits = &q->limits;
+
+	limits->atomic_write_unit_max_sectors = sectors;
+}
+EXPORT_SYMBOL(blk_queue_atomic_write_unit_max_sectors);
+
 /**
  * blk_queue_max_secure_erase_sectors - set max sectors for a secure erase
  * @q:  the request queue for the device
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 0b2d04766324..4ebf148cf356 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -118,6 +118,30 @@ static ssize_t queue_max_discard_segments_show(struct request_queue *q,
 	return queue_var_show(queue_max_discard_segments(q), page);
 }
 
+static ssize_t queue_atomic_write_max_bytes_show(struct request_queue *q,
+						char *page)
+{
+	return queue_var_show(queue_atomic_write_max_bytes(q), page);
+}
+
+static ssize_t queue_atomic_write_boundary_show(struct request_queue *q,
+						char *page)
+{
+	return queue_var_show(queue_atomic_write_boundary_bytes(q), page);
+}
+
+static ssize_t queue_atomic_write_unit_min_show(struct request_queue *q,
+						char *page)
+{
+	return queue_var_show(queue_atomic_write_unit_min_bytes(q), page);
+}
+
+static ssize_t queue_atomic_write_unit_max_show(struct request_queue *q,
+						char *page)
+{
+	return queue_var_show(queue_atomic_write_unit_max_bytes(q), page);
+}
+
 static ssize_t queue_max_integrity_segments_show(struct request_queue *q, char *page)
 {
 	return queue_var_show(q->limits.max_integrity_segments, page);
@@ -507,6 +531,11 @@ QUEUE_RO_ENTRY(queue_discard_max_hw, "discard_max_hw_bytes");
 QUEUE_RW_ENTRY(queue_discard_max, "discard_max_bytes");
 QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_zeroes_data");
 
+QUEUE_RO_ENTRY(queue_atomic_write_max_bytes, "atomic_write_max_bytes");
+QUEUE_RO_ENTRY(queue_atomic_write_boundary, "atomic_write_boundary_bytes");
+QUEUE_RO_ENTRY(queue_atomic_write_unit_max, "atomic_write_unit_max_bytes");
+QUEUE_RO_ENTRY(queue_atomic_write_unit_min, "atomic_write_unit_min_bytes");
+
 QUEUE_RO_ENTRY(queue_write_same_max, "write_same_max_bytes");
 QUEUE_RO_ENTRY(queue_write_zeroes_max, "write_zeroes_max_bytes");
 QUEUE_RO_ENTRY(queue_zone_append_max, "zone_append_max_bytes");
@@ -634,6 +663,10 @@ static struct attribute *queue_attrs[] = {
 	&queue_discard_max_entry.attr,
 	&queue_discard_max_hw_entry.attr,
 	&queue_discard_zeroes_data_entry.attr,
+	&queue_atomic_write_max_bytes_entry.attr,
+	&queue_atomic_write_boundary_entry.attr,
+	&queue_atomic_write_unit_min_entry.attr,
+	&queue_atomic_write_unit_max_entry.attr,
 	&queue_write_same_max_entry.attr,
 	&queue_write_zeroes_max_entry.attr,
 	&queue_zone_append_max_entry.attr,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 51fa7ffdee83..ab53163dd187 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -309,6 +309,11 @@ struct queue_limits {
 	unsigned int		discard_alignment;
 	unsigned int		zone_write_granularity;
 
+	unsigned int		atomic_write_boundary_sectors;
+	unsigned int		atomic_write_max_sectors;
+	unsigned int		atomic_write_unit_min_sectors;
+	unsigned int		atomic_write_unit_max_sectors;
+
 	unsigned short		max_segments;
 	unsigned short		max_integrity_segments;
 	unsigned short		max_discard_segments;
@@ -908,6 +913,14 @@ void blk_queue_zone_write_granularity(struct request_queue *q,
 				      unsigned int size);
 extern void blk_queue_alignment_offset(struct request_queue *q,
 				       unsigned int alignment);
+void blk_queue_atomic_write_max_bytes(struct request_queue *q,
+				unsigned int bytes);
+void blk_queue_atomic_write_unit_max_sectors(struct request_queue *q,
+				unsigned int sectors);
+void blk_queue_atomic_write_unit_min_sectors(struct request_queue *q,
+				unsigned int sectors);
+void blk_queue_atomic_write_boundary_bytes(struct request_queue *q,
+				unsigned int bytes);
 void disk_update_readahead(struct gendisk *disk);
 extern void blk_limits_io_min(struct queue_limits *limits, unsigned int min);
 extern void blk_queue_io_min(struct request_queue *q, unsigned int min);
@@ -1312,6 +1325,30 @@ static inline int queue_dma_alignment(const struct request_queue *q)
 	return q ? q->limits.dma_alignment : 511;
 }
 
+static inline unsigned int
+queue_atomic_write_unit_max_bytes(const struct request_queue *q)
+{
+	return q->limits.atomic_write_unit_max_sectors << SECTOR_SHIFT;
+}
+
+static inline unsigned int
+queue_atomic_write_unit_min_bytes(const struct request_queue *q)
+{
+	return q->limits.atomic_write_unit_min_sectors << SECTOR_SHIFT;
+}
+
+static inline unsigned int
+queue_atomic_write_boundary_bytes(const struct request_queue *q)
+{
+	return q->limits.atomic_write_boundary_sectors << SECTOR_SHIFT;
+}
+
+static inline unsigned int
+queue_atomic_write_max_bytes(const struct request_queue *q)
+{
+	return q->limits.atomic_write_max_sectors << SECTOR_SHIFT;
+}
+
 static inline unsigned int bdev_dma_alignment(struct block_device *bdev)
 {
 	return queue_dma_alignment(bdev_get_queue(bdev));
-- 
2.35.3


