Return-Path: <linux-fsdevel+bounces-5671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFC580E9ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 12:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91EA2281E54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 11:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0585D8F1;
	Tue, 12 Dec 2023 11:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gL96HSs5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oG2Srx3g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080EF1BC3;
	Tue, 12 Dec 2023 03:10:16 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BC7hlIl028850;
	Tue, 12 Dec 2023 11:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=wP0nm9QqN/P7E2NLBY5g0WTClOu/jw3Wp3yzSs/pv9A=;
 b=gL96HSs5fzQIyHsRczyekGH3SNcBDT35VFvqt4K+mdI/c1F+5ZwkGUiHGQ4HoyAtVYHg
 j7yACDSIJmoCYafAtokylEO2HCxihNG2k+dVzwza8bk/docG3udJDnexVbNU5XsRFq1Y
 PAvwMlS78nHWP+27P3KqlCgZ8HVJMIcJNERw17esmRJt07QbPw3PtTG41l44Hop929V6
 C+aaizQI9Mnys771WfTUSMnFV8iw+EZhX6be+nPG1GwsZbaGt36yfMuVAsno4jiRluZw
 MJ74HMjlY+aINKdvINiAi4375CoJ44AFsoJ9OZvcrtZWjLNKnKdKRFbDT49TJSZR5k8F Mg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvg9d5dam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:49 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCAwj7H008234;
	Tue, 12 Dec 2023 11:09:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep6cwvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDcediAaV3wU+IZQ1rno/qX2DxIWY+ncJuuFuLL4jeUS5cWizJgbATFd8FCm9L00I80W7L/HFL0IPhgi3VBucSn4crcfUhAaw/jrOdTthvlB0d8vzJfwV9JDTVxzMMeh5SMli1v/OrcYxqYVo85Ig7XBT+zZydroQQ7Q2DAjD2YNT4HX5coe145q2PshIkgqj38NuzPrG1meW2linnVgSHkioIC2+OhfopIxLj/ZlFSd6zZ6WT9orexSel916sPjNNF1AUQjzYnXj1GleC4c95G65UuGeRauW2y3nhKglYZOKjoHviDu9bfl9cqL1XqNMrk3pvXqNkBJiNkeHJHMjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wP0nm9QqN/P7E2NLBY5g0WTClOu/jw3Wp3yzSs/pv9A=;
 b=ORL3/g6O5UNSiD1aixoOplYx3kgHOXjzY+Wp9D2ls0S4iAPWMfdQaCPi7XlFP0wCam5Mya9+b+MRR3HYSVfSIJVla4XnbJ1TezKRwRd1jqeYyhU/sDeoRWqZBXuWOU/ggLesrjWwNA6ihDLSVmTuL9B/B0/mCNfr4tZST+tF3Z3v0mStVZOKKilQz6XyVNrLGWukmLd9PvN3ZeGKS22zVbATyI843ZH9HlUTbDkJx159Ywa4gwuayb/uQV7/11grjklr0NGqs6Zyo8hiEjcUKovQbQqkidf5YINjvfR387EEXekCMtnAdMW8IPc7vHfg/of2KyXZe1C6Ufimx6Hiug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wP0nm9QqN/P7E2NLBY5g0WTClOu/jw3Wp3yzSs/pv9A=;
 b=oG2Srx3gERuJkxseuwf7UmnODNEJ6d8y2oxhtJZGSBIzBR7c/gIFNcTxFnHRpd6XFajET2Qx0nBeVDt1iUk0NLS2z2PMbjBgOvyoZjryeIT+W964tU50euN2hH39f1OJfHQTI2eFA7KamNu3DgRPDSFC66OvbLKz2oNO/FLdlcc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6663.namprd10.prod.outlook.com (2603:10b6:806:2ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 11:09:45 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 11:09:44 +0000
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
Subject: [PATCH v2 14/16] scsi: scsi_debug: Atomic write support
Date: Tue, 12 Dec 2023 11:08:42 +0000
Message-Id: <20231212110844.19698-15-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231212110844.19698-1-john.g.garry@oracle.com>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0047.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 6daf1feb-b626-42bd-80e4-08dbfb02d8a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KmdXMaQ/bfuxGdlhV4hEQaJOMegc6UGoR4phKKF3y9bL8O/hCi3CaRV21BP+JG2F48jERbQvMy/OFa8MAHZO1QHDZHclXu5JM+IDWEMmFg6lCnaCDJP4IuYXy1FB41+f/ydKTqTedrUrog60iCkiuhtuVPPn1C1478BeJnysIyGJtHrK29DGyU5ZnkQFunT5iw3QP3mMGwNy9tLupsmRjP60XJ/uMoJWbxdrbpUYbbfzBbmTlCO4YutR24c6yaqhaACSZukIwGyMXbKLGrsKS3+utJrhSVXuqG2xpwQ+kIci0s4dt9z9eVCQRvFpVfU73wTY6VSVMPHl0JzGYcJDtLOygfL4wKihmd9hZdDUqP+32SPBBDWpXgrsMhMSxIKALj60SUC5vFYVL1AsWhSL2zm3f0cQMQAWtb5d5XwlCPS9ovZvucdwHiiQ5Gm3dizltRAzte50haa2s84Glj31FTOT4ApHgwfzXa+GHrs54GAT4RghxH1MI/J1wg4NjO8BMFMH1UT5Y0LcF3zqVCe+XHYc1Xee9B3kPhrNS/bovJiS3rJB920zTInmBnYQHxkE6X2+LC+tHtJEM10SXGIyaoTvW1f8jlPgjcjwVdFwjB4fkFcvJJR3cI/7fyjGP1Sy
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(6506007)(6512007)(2616005)(107886003)(1076003)(478600001)(5660300002)(4326008)(8936002)(8676002)(41300700001)(7416002)(2906002)(6486002)(30864003)(38100700002)(316002)(66476007)(66556008)(66946007)(103116003)(86362001)(36756003)(921008)(357404004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HCjMOSN1uo0Ye0ECTZLFlZWGrLojRX1ba5o/j5qOgqQBnUX4XUaZ1BNJaFpo?=
 =?us-ascii?Q?GIQYHat7AXtZi5QkcX6GbVyWJENKsH/OXSIt2Qh+dZg0GwHlp2uCU4gU6n7k?=
 =?us-ascii?Q?0qVGL82XPgVUbkAJSbnV+BbwPLscYY1zKmNvkZj5LI8sVczmm6tq+Smr/6rQ?=
 =?us-ascii?Q?Mqv1OH8gNksAAi6iyc/Uc9QISrkE2R4rCmIBYGX9KcrA7v0AZFuGDVQPj3/t?=
 =?us-ascii?Q?kzbepQkb7JQTurW1qCE2AVczCwQPP/VxP1rIkZ4hui9dHyYNi3VDCAsz4S5W?=
 =?us-ascii?Q?IEeAvpBJgm8qAPaa9eg5vSOQNRg06MLSXDhD3ZdY8PYkN+zFjUIL+9/8XnLR?=
 =?us-ascii?Q?L0/Sfu/uM8AxI301sLXbbYicX+O09IniDz6kioqJpFWzD0rsMQ+O+6OK7LZY?=
 =?us-ascii?Q?7df7tDgo5jqMDMUDt6jzY+pI/Y+KZZjig54OYw7jRKmImJDw+UBX3zPVpktk?=
 =?us-ascii?Q?Klz7ylO59ucbpLbNEsd+vn3gbdUCfu6cmURyC/NUBXFCQu2ttBMhuuzcgL5r?=
 =?us-ascii?Q?idrWspuWBA2EtVi4h+3v4/aVwMzuxWLHKh5aDoU8VpWFgpdEhSATw8lIp3l5?=
 =?us-ascii?Q?9VpWEL/JtfSvvUplKA7AITannjrENM6VrYRtEd2vFeh0aN8oEU5o0WGHNQv4?=
 =?us-ascii?Q?0HDCZ7oa2A3AcXuPzqiIZBx1oJiRa0UGYK6KwMKtpdrUMib9L99Z7+Z3RVUK?=
 =?us-ascii?Q?N1oF1xQrc1n47HOSWnfmzq2OIQhKIzAEJ9GVYeG6uc0P42dsCkLKjIKSCi1a?=
 =?us-ascii?Q?023Y1r6x2r0pJxbFQky3lun7ZOeBwkNQCdyFWyb3rHpnywM1h1VyLGVg7lpP?=
 =?us-ascii?Q?fPq3L0W9T67eRCbGEhh4CAIg/pjHRONpTXtOEuOvC7KWHSFOKWH8r+TttbpY?=
 =?us-ascii?Q?YxUaeQDWG46lV5HhD1gg2Uo7FospFj4OdcNOFmxBLB5LimrSFCwGuqbcKQ2z?=
 =?us-ascii?Q?XPbeKEIDwgYZUF+ERlSD666B7cpT4MeNhN31HJCGA6LwmnKXZFxF2CywiEi3?=
 =?us-ascii?Q?531WzlGutQsdhSFIDzPoTJO4MtfcGMaNPs4cjD3zX/E9szprLmJSh0KZNbml?=
 =?us-ascii?Q?5SIUKMBP9f7XEfc87qrlvvwucLOMLnBo0JnVptH2JekCziDlqP2JGpb6AaYX?=
 =?us-ascii?Q?6s54a3pyjlQQeEMYl8xDdyx9ew94cvjZEBXq2hXfSUPpPZvkiUZ/rO/vp4tB?=
 =?us-ascii?Q?G/2m32kyh6DFEhjQr3H6f8PGolKmo1x1W6hnpDvwgxZVapSrkLAd6ozs+eTx?=
 =?us-ascii?Q?UUCCs0HpThB/6BiAeKQ1vx4thAyrp+xWVypbYICgYq4zbnSTAYg2ffq6EMgR?=
 =?us-ascii?Q?N8O651WkrgyuLW0nMdbdjLw7zYadD9UzLIJY9FDD1Zzlz66atMUookmgHgDD?=
 =?us-ascii?Q?X7SOx84TW6MrFqfR2JpHWqEDKyFrbCVuTk/odMWh++bUPxs4SkKdJyM2JCYb?=
 =?us-ascii?Q?Ir8jhxU9MkHrY9WSyy07yDwZ9ZzkomcaRHJYfCMNnfq/l+4boqNy2tJCA0Dp?=
 =?us-ascii?Q?ip308XFnFhT+2VNyGR/wPP9eHiMY9B9OY4A3aP2FIals8DINUQrQWn5+rLHX?=
 =?us-ascii?Q?AwPbU1zEqLk+lR0siydObOW30xZ+BX9eibswfgZ0kex0n9Bm6wfISsVknNm/?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	AtqcS6iGj8hwbAchFje7ddl8MLUP5+EpY8ChmxTca2XnS3pQhD0lq+wzgG9BBsQTFsK51FhksNy1E7/khAxoBcwI1HbY3JGTZ8gVwePR0xlFMdCHK8pSaw+rXrEiFgV7NTaUNxpR317E1I6IjsQxKKnIH9NfChU/chX2lQBzvw9d7aNkrdNdxbZdu5fkFpoSPZgd3UeVWh81TD9o3fcVa2MPYiPfrAyyu0/z6pb5YLyAAtfW1xtsDNUrcn07Hu0Oj66Vj23B5Ct+p5kEq62EUJJEwnbo4K+20UxxwkHH2bzD33Bp28cXwFv6HqUjEde3x+k64j5x7gsodX5qR+XL7z1HH8TULKkk8zOChbEx2SvjL8W1DGVgrkvSUYKRJ37GzbLm0LX4Zr/qlGZ5vD6tFW+/7XVaezE4YZBVZ8mGtxKOo9v2urReuqkRRCUuoEIHWxpFyQSLAugGJG6/XbtqxcV5yNy7gbnc6/VI6UK5FPOET/DAFbI9I1unF9XgH5M1L3kO9UTVARUhUKQhuFPdVRxCX2NAsXDnE5reT8tttXGgBy3mkrI/Xs9LrmzkRQ3Ye+tvDL7/lcHcSmF6RySoOO6ND6EkGfJXL32yWjGVP9U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6daf1feb-b626-42bd-80e4-08dbfb02d8a8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 11:09:44.9318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPLkJdHbZ0ahuOM8ChC6MWtrQajtwHY+yA+WwK9pOkJD/ihZ3Sft0uiz+NjuWw6LNvemCW/koWL17ATUzaNBaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_04,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312120089
X-Proofpoint-GUID: VYMDyUoFLMNJDtW26lBF7yuv6zMB4ui8
X-Proofpoint-ORIG-GUID: VYMDyUoFLMNJDtW26lBF7yuv6zMB4ui8

Add initial support for atomic writes.

As is standard method, feed device properties via modules param, those
being:
- atomic_max_size_blks
- atomic_alignment_blks
- atomic_granularity_blks
- atomic_max_size_with_boundary_blks
- atomic_max_boundary_blks

These just match sbc4r22 section 6.6.4 - Block limits VPD page.

We just support ATOMIC_WRITE_16.

The major change in the driver is how we lock the device for RW accesses.

Currently the driver uses a per-device lock for accessing device metadata
and "media" data (calls to do_device_access()) atomically for the duration
of the whole read/write command.

This should not suit verifying atomic writes. Reason being that currently
all reads/writes are atomic, so using atomic writes does not prove
anything.

Change device access model to basis that regular writes only atomic on a
per-sector basis, while reads and atomic writes are fully atomic.

As mentioned, since accessing metadata and device media is atomic,
continue to have regular writes involving metadata - like discard or PI -
as atomic. We can improve this later.

Currently we only support model where overlapping going reads or writes
wait for current access to complete before commencing an atomic write.
This is described in 4.29.3.2 section of the SBC. However, we simplify,
things and wait for all accesses to complete (when issuing an atomic
write).

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_debug.c | 590 +++++++++++++++++++++++++++++---------
 1 file changed, 457 insertions(+), 133 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 512fae20c56c..645571b0fd2c 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -68,6 +68,8 @@ static const char *sdebug_version_date = "20210520";
 
 /* Additional Sense Code (ASC) */
 #define NO_ADDITIONAL_SENSE 0x0
+#define OVERLAP_ATOMIC_COMMAND_ASC 0x0
+#define OVERLAP_ATOMIC_COMMAND_ASCQ 0x23
 #define LOGICAL_UNIT_NOT_READY 0x4
 #define LOGICAL_UNIT_COMMUNICATION_FAILURE 0x8
 #define UNRECOVERED_READ_ERR 0x11
@@ -102,6 +104,7 @@ static const char *sdebug_version_date = "20210520";
 #define READ_BOUNDARY_ASCQ 0x7
 #define ATTEMPT_ACCESS_GAP 0x9
 #define INSUFF_ZONE_ASCQ 0xe
+/* see drivers/scsi/sense_codes.h */
 
 /* Additional Sense Code Qualifier (ASCQ) */
 #define ACK_NAK_TO 0x3
@@ -151,6 +154,12 @@ static const char *sdebug_version_date = "20210520";
 #define DEF_VIRTUAL_GB   0
 #define DEF_VPD_USE_HOSTNO 1
 #define DEF_WRITESAME_LENGTH 0xFFFF
+#define DEF_ATOMIC_WR 0
+#define DEF_ATOMIC_WR_MAX_LENGTH 8192
+#define DEF_ATOMIC_WR_ALIGN 2
+#define DEF_ATOMIC_WR_GRAN 2
+#define DEF_ATOMIC_WR_MAX_LENGTH_BNDRY (DEF_ATOMIC_WR_MAX_LENGTH)
+#define DEF_ATOMIC_WR_MAX_BNDRY 128
 #define DEF_STRICT 0
 #define DEF_STATISTICS false
 #define DEF_SUBMIT_QUEUES 1
@@ -373,7 +382,9 @@ struct sdebug_host_info {
 
 /* There is an xarray of pointers to this struct's objects, one per host */
 struct sdeb_store_info {
-	rwlock_t macc_lck;	/* for atomic media access on this store */
+	rwlock_t macc_data_lck;	/* for media data access on this store */
+	rwlock_t macc_meta_lck;	/* for atomic media meta access on this store */
+	rwlock_t macc_sector_lck;	/* per-sector media data access on this store */
 	u8 *storep;		/* user data storage (ram) */
 	struct t10_pi_tuple *dif_storep; /* protection info */
 	void *map_storep;	/* provisioning map */
@@ -397,12 +408,20 @@ struct sdebug_defer {
 	enum sdeb_defer_type defer_t;
 };
 
+struct sdebug_device_access_info {
+	bool atomic_write;
+	u64 lba;
+	u32 num;
+	struct scsi_cmnd *self;
+};
+
 struct sdebug_queued_cmd {
 	/* corresponding bit set in in_use_bm[] in owning struct sdebug_queue
 	 * instance indicates this slot is in use.
 	 */
 	struct sdebug_defer sd_dp;
 	struct scsi_cmnd *scmd;
+	struct sdebug_device_access_info *i;
 };
 
 struct sdebug_scsi_cmd {
@@ -462,7 +481,8 @@ enum sdeb_opcode_index {
 	SDEB_I_PRE_FETCH = 29,		/* 10, 16 */
 	SDEB_I_ZONE_OUT = 30,		/* 0x94+SA; includes no data xfer */
 	SDEB_I_ZONE_IN = 31,		/* 0x95+SA; all have data-in */
-	SDEB_I_LAST_ELEM_P1 = 32,	/* keep this last (previous + 1) */
+	SDEB_I_ATOMIC_WRITE_16 = 32,
+	SDEB_I_LAST_ELEM_P1 = 33,	/* keep this last (previous + 1) */
 };
 
 
@@ -496,7 +516,8 @@ static const unsigned char opcode_ind_arr[256] = {
 	0, 0, 0, SDEB_I_VERIFY,
 	SDEB_I_PRE_FETCH, SDEB_I_SYNC_CACHE, 0, SDEB_I_WRITE_SAME,
 	SDEB_I_ZONE_OUT, SDEB_I_ZONE_IN, 0, 0,
-	0, 0, 0, 0, 0, 0, SDEB_I_SERV_ACT_IN_16, SDEB_I_SERV_ACT_OUT_16,
+	0, 0, 0, 0,
+	SDEB_I_ATOMIC_WRITE_16, 0, SDEB_I_SERV_ACT_IN_16, SDEB_I_SERV_ACT_OUT_16,
 /* 0xa0; 0xa0->0xbf: 12 byte cdbs */
 	SDEB_I_REPORT_LUNS, SDEB_I_ATA_PT, 0, SDEB_I_MAINT_IN,
 	     SDEB_I_MAINT_OUT, 0, 0, 0,
@@ -544,6 +565,7 @@ static int resp_write_buffer(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_sync_cache(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_pre_fetch(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_report_zones(struct scsi_cmnd *, struct sdebug_dev_info *);
+static int resp_atomic_write(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_open_zone(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_close_zone(struct scsi_cmnd *, struct sdebug_dev_info *);
 static int resp_finish_zone(struct scsi_cmnd *, struct sdebug_dev_info *);
@@ -782,6 +804,11 @@ static const struct opcode_info_t opcode_info_arr[SDEB_I_LAST_ELEM_P1 + 1] = {
 	    resp_report_zones, zone_in_iarr, /* ZONE_IN(16), REPORT ZONES) */
 		{16,  0x0 /* SA */, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
 		 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xbf, 0xc7} },
+/* 31 */
+	{0, 0x0, 0x0, F_D_OUT | FF_MEDIA_IO,
+	    resp_atomic_write, NULL, /* ATOMIC WRITE 16 */
+		{16,  0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+		 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff} },
 /* sentinel */
 	{0xff, 0, 0, 0, NULL, NULL,		/* terminating element */
 	    {0,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} },
@@ -829,6 +856,13 @@ static unsigned int sdebug_unmap_granularity = DEF_UNMAP_GRANULARITY;
 static unsigned int sdebug_unmap_max_blocks = DEF_UNMAP_MAX_BLOCKS;
 static unsigned int sdebug_unmap_max_desc = DEF_UNMAP_MAX_DESC;
 static unsigned int sdebug_write_same_length = DEF_WRITESAME_LENGTH;
+static unsigned int sdebug_atomic_wr = DEF_ATOMIC_WR;
+static unsigned int sdebug_atomic_wr_max_length = DEF_ATOMIC_WR_MAX_LENGTH;
+static unsigned int sdebug_atomic_wr_align = DEF_ATOMIC_WR_ALIGN;
+static unsigned int sdebug_atomic_wr_gran = DEF_ATOMIC_WR_GRAN;
+static unsigned int sdebug_atomic_wr_max_length_bndry =
+			DEF_ATOMIC_WR_MAX_LENGTH_BNDRY;
+static unsigned int sdebug_atomic_wr_max_bndry = DEF_ATOMIC_WR_MAX_BNDRY;
 static int sdebug_uuid_ctl = DEF_UUID_CTL;
 static bool sdebug_random = DEF_RANDOM;
 static bool sdebug_per_host_store = DEF_PER_HOST_STORE;
@@ -1177,6 +1211,11 @@ static inline bool scsi_debug_lbp(void)
 		(sdebug_lbpu || sdebug_lbpws || sdebug_lbpws10);
 }
 
+static inline bool scsi_debug_atomic_write(void)
+{
+	return 0 == sdebug_fake_rw && sdebug_atomic_wr;
+}
+
 static void *lba2fake_store(struct sdeb_store_info *sip,
 			    unsigned long long lba)
 {
@@ -1804,6 +1843,14 @@ static int inquiry_vpd_b0(unsigned char *arr)
 	/* Maximum WRITE SAME Length */
 	put_unaligned_be64(sdebug_write_same_length, &arr[32]);
 
+	if (sdebug_atomic_wr) {
+		put_unaligned_be32(sdebug_atomic_wr_max_length, &arr[40]);
+		put_unaligned_be32(sdebug_atomic_wr_align, &arr[44]);
+		put_unaligned_be32(sdebug_atomic_wr_gran, &arr[48]);
+		put_unaligned_be32(sdebug_atomic_wr_max_length_bndry, &arr[52]);
+		put_unaligned_be32(sdebug_atomic_wr_max_bndry, &arr[56]);
+	}
+
 	return 0x3c; /* Mandatory page length for Logical Block Provisioning */
 }
 
@@ -3305,15 +3352,240 @@ static inline struct sdeb_store_info *devip2sip(struct sdebug_dev_info *devip,
 	return xa_load(per_store_ap, devip->sdbg_host->si_idx);
 }
 
+
+static inline void
+sdeb_read_lock(rwlock_t *lock)
+{
+	if (sdebug_no_rwlock)
+		__acquire(lock);
+	else
+		read_lock(lock);
+}
+
+static inline void
+sdeb_read_unlock(rwlock_t *lock)
+{
+	if (sdebug_no_rwlock)
+		__release(lock);
+	else
+		read_unlock(lock);
+}
+
+static inline void
+sdeb_write_lock(rwlock_t *lock)
+{
+	if (sdebug_no_rwlock)
+		__acquire(lock);
+	else
+		write_lock(lock);
+}
+
+static inline void
+sdeb_write_unlock(rwlock_t *lock)
+{
+	if (sdebug_no_rwlock)
+		__release(lock);
+	else
+		write_unlock(lock);
+}
+
+static inline void
+sdeb_data_read_lock(struct sdeb_store_info *sip)
+{
+	BUG_ON(!sip);
+
+	sdeb_read_lock(&sip->macc_data_lck);
+}
+
+static inline void
+sdeb_data_read_unlock(struct sdeb_store_info *sip)
+{
+	BUG_ON(!sip);
+
+	sdeb_read_unlock(&sip->macc_data_lck);
+}
+
+static inline void
+sdeb_data_write_lock(struct sdeb_store_info *sip)
+{
+	BUG_ON(!sip);
+
+	sdeb_write_lock(&sip->macc_data_lck);
+}
+
+static inline void
+sdeb_data_write_unlock(struct sdeb_store_info *sip)
+{
+	BUG_ON(!sip);
+
+	sdeb_write_unlock(&sip->macc_data_lck);
+}
+
+static inline void
+sdeb_data_sector_read_lock(struct sdeb_store_info *sip)
+{
+	BUG_ON(!sip);
+
+	sdeb_read_lock(&sip->macc_sector_lck);
+}
+
+static inline void
+sdeb_data_sector_read_unlock(struct sdeb_store_info *sip)
+{
+	BUG_ON(!sip);
+
+	sdeb_read_unlock(&sip->macc_sector_lck);
+}
+
+static inline void
+sdeb_data_sector_write_lock(struct sdeb_store_info *sip)
+{
+	BUG_ON(!sip);
+
+	sdeb_write_lock(&sip->macc_sector_lck);
+}
+
+static inline void
+sdeb_data_sector_write_unlock(struct sdeb_store_info *sip)
+{
+	BUG_ON(!sip);
+
+	sdeb_write_unlock(&sip->macc_sector_lck);
+}
+
+/*
+Atomic locking:
+We simplify the atomic model to allow only 1x atomic
+write and many non-atomic reads or writes for all
+LBAs.
+
+A RW lock has a similar bahaviour:
+Only 1x writer and many readers.
+
+So use a RW lock for per-device read and write locking:
+An atomic access grabs the lock as a writer and
+non-atomic grabs the lock as a reader.
+*/
+
+static inline void
+sdeb_data_lock(struct sdeb_store_info *sip, bool atomic_write)
+{
+	if (atomic_write)
+		sdeb_data_write_lock(sip);
+	else
+		sdeb_data_read_lock(sip);
+}
+
+static inline void
+sdeb_data_unlock(struct sdeb_store_info *sip, bool atomic_write)
+{
+	if (atomic_write)
+		sdeb_data_write_unlock(sip);
+	else
+		sdeb_data_read_unlock(sip);
+}
+
+/* Allow many reads but only 1x write per sector */
+static inline void
+sdeb_data_sector_lock(struct sdeb_store_info *sip, bool do_write)
+{
+	if (do_write)
+		sdeb_data_sector_write_lock(sip);
+	else
+		sdeb_data_sector_read_lock(sip);
+}
+
+static inline void
+sdeb_data_sector_unlock(struct sdeb_store_info *sip, bool do_write)
+{
+	if (do_write)
+		sdeb_data_sector_write_unlock(sip);
+	else
+		sdeb_data_sector_read_unlock(sip);
+}
+
+static inline void
+sdeb_meta_read_lock(struct sdeb_store_info *sip)
+{
+	if (sdebug_no_rwlock) {
+		if (sip)
+			__acquire(&sip->macc_meta_lck);
+		else
+			__acquire(&sdeb_fake_rw_lck);
+	} else {
+		if (sip)
+			read_lock(&sip->macc_meta_lck);
+		else
+			read_lock(&sdeb_fake_rw_lck);
+	}
+}
+
+static inline void
+sdeb_meta_read_unlock(struct sdeb_store_info *sip)
+{
+	if (sdebug_no_rwlock) {
+		if (sip)
+			__release(&sip->macc_meta_lck);
+		else
+			__release(&sdeb_fake_rw_lck);
+	} else {
+		if (sip)
+			read_unlock(&sip->macc_meta_lck);
+		else
+			read_unlock(&sdeb_fake_rw_lck);
+	}
+}
+
+static inline void
+sdeb_meta_write_lock(struct sdeb_store_info *sip)
+{
+	if (sdebug_no_rwlock) {
+		if (sip)
+			__acquire(&sip->macc_meta_lck);
+		else
+			__acquire(&sdeb_fake_rw_lck);
+	} else {
+		if (sip)
+			write_lock(&sip->macc_meta_lck);
+		else
+			write_lock(&sdeb_fake_rw_lck);
+	}
+}
+
+static inline void
+sdeb_meta_write_unlock(struct sdeb_store_info *sip)
+{
+	if (sdebug_no_rwlock) {
+		if (sip)
+			__release(&sip->macc_meta_lck);
+		else
+			__release(&sdeb_fake_rw_lck);
+	} else {
+		if (sip)
+			write_unlock(&sip->macc_meta_lck);
+		else
+			write_unlock(&sdeb_fake_rw_lck);
+	}
+}
+
 /* Returns number of bytes copied or -1 if error. */
 static int do_device_access(struct sdeb_store_info *sip, struct scsi_cmnd *scp,
-			    u32 sg_skip, u64 lba, u32 num, bool do_write)
+			    u32 sg_skip, u64 lba, u32 num, bool do_write,
+			    bool atomic_write)
 {
 	int ret;
-	u64 block, rest = 0;
+	u64 block;
 	enum dma_data_direction dir;
 	struct scsi_data_buffer *sdb = &scp->sdb;
 	u8 *fsp;
+	int i;
+
+	/*
+	 * Even though reads are inherently atomic (in this driver), we expect
+	 * the atomic flag only for writes.
+	 */
+	if (!do_write && atomic_write)
+		return -1;
 
 	if (do_write) {
 		dir = DMA_TO_DEVICE;
@@ -3329,21 +3601,26 @@ static int do_device_access(struct sdeb_store_info *sip, struct scsi_cmnd *scp,
 	fsp = sip->storep;
 
 	block = do_div(lba, sdebug_store_sectors);
-	if (block + num > sdebug_store_sectors)
-		rest = block + num - sdebug_store_sectors;
 
-	ret = sg_copy_buffer(sdb->table.sgl, sdb->table.nents,
+	/* Only allow 1x atomic write or multiple non-atomic writes at any given time */
+	sdeb_data_lock(sip, atomic_write);
+	for (i = 0; i < num; i++) {
+		/* We shouldn't need to lock for atomic writes, but do it anyway */
+		sdeb_data_sector_lock(sip, do_write);
+		ret = sg_copy_buffer(sdb->table.sgl, sdb->table.nents,
 		   fsp + (block * sdebug_sector_size),
-		   (num - rest) * sdebug_sector_size, sg_skip, do_write);
-	if (ret != (num - rest) * sdebug_sector_size)
-		return ret;
-
-	if (rest) {
-		ret += sg_copy_buffer(sdb->table.sgl, sdb->table.nents,
-			    fsp, rest * sdebug_sector_size,
-			    sg_skip + ((num - rest) * sdebug_sector_size),
-			    do_write);
+		   sdebug_sector_size, sg_skip, do_write);
+		sdeb_data_sector_unlock(sip, do_write);
+		if (ret != sdebug_sector_size) {
+			ret += (i * sdebug_sector_size);
+			break;
+		}
+		sg_skip += sdebug_sector_size;
+		if (++block >= sdebug_store_sectors)
+			block = 0;
 	}
+	ret = num * sdebug_sector_size;
+	sdeb_data_unlock(sip, atomic_write);
 
 	return ret;
 }
@@ -3519,70 +3796,6 @@ static int prot_verify_read(struct scsi_cmnd *scp, sector_t start_sec,
 	return ret;
 }
 
-static inline void
-sdeb_read_lock(struct sdeb_store_info *sip)
-{
-	if (sdebug_no_rwlock) {
-		if (sip)
-			__acquire(&sip->macc_lck);
-		else
-			__acquire(&sdeb_fake_rw_lck);
-	} else {
-		if (sip)
-			read_lock(&sip->macc_lck);
-		else
-			read_lock(&sdeb_fake_rw_lck);
-	}
-}
-
-static inline void
-sdeb_read_unlock(struct sdeb_store_info *sip)
-{
-	if (sdebug_no_rwlock) {
-		if (sip)
-			__release(&sip->macc_lck);
-		else
-			__release(&sdeb_fake_rw_lck);
-	} else {
-		if (sip)
-			read_unlock(&sip->macc_lck);
-		else
-			read_unlock(&sdeb_fake_rw_lck);
-	}
-}
-
-static inline void
-sdeb_write_lock(struct sdeb_store_info *sip)
-{
-	if (sdebug_no_rwlock) {
-		if (sip)
-			__acquire(&sip->macc_lck);
-		else
-			__acquire(&sdeb_fake_rw_lck);
-	} else {
-		if (sip)
-			write_lock(&sip->macc_lck);
-		else
-			write_lock(&sdeb_fake_rw_lck);
-	}
-}
-
-static inline void
-sdeb_write_unlock(struct sdeb_store_info *sip)
-{
-	if (sdebug_no_rwlock) {
-		if (sip)
-			__release(&sip->macc_lck);
-		else
-			__release(&sdeb_fake_rw_lck);
-	} else {
-		if (sip)
-			write_unlock(&sip->macc_lck);
-		else
-			write_unlock(&sdeb_fake_rw_lck);
-	}
-}
-
 static int resp_read_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 {
 	bool check_prot;
@@ -3592,6 +3805,7 @@ static int resp_read_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 	u64 lba;
 	struct sdeb_store_info *sip = devip2sip(devip, true);
 	u8 *cmd = scp->cmnd;
+	bool meta_data_locked = false;
 
 	switch (cmd[0]) {
 	case READ_16:
@@ -3650,6 +3864,10 @@ static int resp_read_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 		atomic_set(&sdeb_inject_pending, 0);
 	}
 
+	/*
+	 * When checking device access params, for reads we only check data
+	 * versus what is set at init time, so no need to lock.
+	 */
 	ret = check_device_access_params(scp, lba, num, false);
 	if (ret)
 		return ret;
@@ -3669,29 +3887,33 @@ static int resp_read_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 		return check_condition_result;
 	}
 
-	sdeb_read_lock(sip);
+	if (sdebug_dev_is_zoned(devip) ||
+	    (sdebug_dix && scsi_prot_sg_count(scp)))  {
+		sdeb_meta_read_lock(sip);
+		meta_data_locked = true;
+	}
 
 	/* DIX + T10 DIF */
 	if (unlikely(sdebug_dix && scsi_prot_sg_count(scp))) {
 		switch (prot_verify_read(scp, lba, num, ei_lba)) {
 		case 1: /* Guard tag error */
 			if (cmd[1] >> 5 != 3) { /* RDPROTECT != 3 */
-				sdeb_read_unlock(sip);
+				sdeb_meta_read_unlock(sip);
 				mk_sense_buffer(scp, ABORTED_COMMAND, 0x10, 1);
 				return check_condition_result;
 			} else if (scp->prot_flags & SCSI_PROT_GUARD_CHECK) {
-				sdeb_read_unlock(sip);
+				sdeb_meta_read_unlock(sip);
 				mk_sense_buffer(scp, ILLEGAL_REQUEST, 0x10, 1);
 				return illegal_condition_result;
 			}
 			break;
 		case 3: /* Reference tag error */
 			if (cmd[1] >> 5 != 3) { /* RDPROTECT != 3 */
-				sdeb_read_unlock(sip);
+				sdeb_meta_read_unlock(sip);
 				mk_sense_buffer(scp, ABORTED_COMMAND, 0x10, 3);
 				return check_condition_result;
 			} else if (scp->prot_flags & SCSI_PROT_REF_CHECK) {
-				sdeb_read_unlock(sip);
+				sdeb_meta_read_unlock(sip);
 				mk_sense_buffer(scp, ILLEGAL_REQUEST, 0x10, 3);
 				return illegal_condition_result;
 			}
@@ -3699,8 +3921,9 @@ static int resp_read_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 		}
 	}
 
-	ret = do_device_access(sip, scp, 0, lba, num, false);
-	sdeb_read_unlock(sip);
+	ret = do_device_access(sip, scp, 0, lba, num, false, false);
+	if (meta_data_locked)
+		sdeb_meta_read_unlock(sip);
 	if (unlikely(ret == -1))
 		return DID_ERROR << 16;
 
@@ -3889,6 +4112,7 @@ static int resp_write_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 	u64 lba;
 	struct sdeb_store_info *sip = devip2sip(devip, true);
 	u8 *cmd = scp->cmnd;
+	bool meta_data_locked = false;
 
 	switch (cmd[0]) {
 	case WRITE_16:
@@ -3942,10 +4166,17 @@ static int resp_write_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 				    "to DIF device\n");
 	}
 
-	sdeb_write_lock(sip);
+	if (sdebug_dev_is_zoned(devip) ||
+	    (sdebug_dix && scsi_prot_sg_count(scp)) ||
+	    scsi_debug_lbp())  {
+		sdeb_meta_write_lock(sip);
+		meta_data_locked = true;
+	}
+
 	ret = check_device_access_params(scp, lba, num, true);
 	if (ret) {
-		sdeb_write_unlock(sip);
+		if (meta_data_locked)
+			sdeb_meta_write_unlock(sip);
 		return ret;
 	}
 
@@ -3954,22 +4185,22 @@ static int resp_write_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 		switch (prot_verify_write(scp, lba, num, ei_lba)) {
 		case 1: /* Guard tag error */
 			if (scp->prot_flags & SCSI_PROT_GUARD_CHECK) {
-				sdeb_write_unlock(sip);
+				sdeb_meta_write_unlock(sip);
 				mk_sense_buffer(scp, ILLEGAL_REQUEST, 0x10, 1);
 				return illegal_condition_result;
 			} else if (scp->cmnd[1] >> 5 != 3) { /* WRPROTECT != 3 */
-				sdeb_write_unlock(sip);
+				sdeb_meta_write_unlock(sip);
 				mk_sense_buffer(scp, ABORTED_COMMAND, 0x10, 1);
 				return check_condition_result;
 			}
 			break;
 		case 3: /* Reference tag error */
 			if (scp->prot_flags & SCSI_PROT_REF_CHECK) {
-				sdeb_write_unlock(sip);
+				sdeb_meta_write_unlock(sip);
 				mk_sense_buffer(scp, ILLEGAL_REQUEST, 0x10, 3);
 				return illegal_condition_result;
 			} else if (scp->cmnd[1] >> 5 != 3) { /* WRPROTECT != 3 */
-				sdeb_write_unlock(sip);
+				sdeb_meta_write_unlock(sip);
 				mk_sense_buffer(scp, ABORTED_COMMAND, 0x10, 3);
 				return check_condition_result;
 			}
@@ -3977,13 +4208,16 @@ static int resp_write_dt0(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 		}
 	}
 
-	ret = do_device_access(sip, scp, 0, lba, num, true);
+	ret = do_device_access(sip, scp, 0, lba, num, true, false);
 	if (unlikely(scsi_debug_lbp()))
 		map_region(sip, lba, num);
+
 	/* If ZBC zone then bump its write pointer */
 	if (sdebug_dev_is_zoned(devip))
 		zbc_inc_wp(devip, lba, num);
-	sdeb_write_unlock(sip);
+	if (meta_data_locked)
+		sdeb_meta_write_unlock(sip);
+
 	if (unlikely(-1 == ret))
 		return DID_ERROR << 16;
 	else if (unlikely(sdebug_verbose &&
@@ -4090,7 +4324,8 @@ static int resp_write_scat(struct scsi_cmnd *scp,
 		goto err_out;
 	}
 
-	sdeb_write_lock(sip);
+	/* Just keep it simple and always lock for now */
+	sdeb_meta_write_lock(sip);
 	sg_off = lbdof_blen;
 	/* Spec says Buffer xfer Length field in number of LBs in dout */
 	cum_lb = 0;
@@ -4133,7 +4368,11 @@ static int resp_write_scat(struct scsi_cmnd *scp,
 			}
 		}
 
-		ret = do_device_access(sip, scp, sg_off, lba, num, true);
+		/*
+		 * Write ranges atomically to keep as close to pre-atomic
+		 * writes behaviour as possible.
+		 */
+		ret = do_device_access(sip, scp, sg_off, lba, num, true, true);
 		/* If ZBC zone then bump its write pointer */
 		if (sdebug_dev_is_zoned(devip))
 			zbc_inc_wp(devip, lba, num);
@@ -4172,7 +4411,7 @@ static int resp_write_scat(struct scsi_cmnd *scp,
 	}
 	ret = 0;
 err_out_unlock:
-	sdeb_write_unlock(sip);
+	sdeb_meta_write_unlock(sip);
 err_out:
 	kfree(lrdp);
 	return ret;
@@ -4191,14 +4430,16 @@ static int resp_write_same(struct scsi_cmnd *scp, u64 lba, u32 num,
 						scp->device->hostdata, true);
 	u8 *fs1p;
 	u8 *fsp;
+	bool meta_data_locked = false;
 
-	sdeb_write_lock(sip);
+	if (sdebug_dev_is_zoned(devip) || scsi_debug_lbp()) {
+		sdeb_meta_write_lock(sip);
+		meta_data_locked = true;
+	}
 
 	ret = check_device_access_params(scp, lba, num, true);
-	if (ret) {
-		sdeb_write_unlock(sip);
-		return ret;
-	}
+	if (ret)
+		goto out;
 
 	if (unmap && scsi_debug_lbp()) {
 		unmap_region(sip, lba, num);
@@ -4209,6 +4450,7 @@ static int resp_write_same(struct scsi_cmnd *scp, u64 lba, u32 num,
 	/* if ndob then zero 1 logical block, else fetch 1 logical block */
 	fsp = sip->storep;
 	fs1p = fsp + (block * lb_size);
+	sdeb_data_write_lock(sip);
 	if (ndob) {
 		memset(fs1p, 0, lb_size);
 		ret = 0;
@@ -4216,8 +4458,8 @@ static int resp_write_same(struct scsi_cmnd *scp, u64 lba, u32 num,
 		ret = fetch_to_dev_buffer(scp, fs1p, lb_size);
 
 	if (-1 == ret) {
-		sdeb_write_unlock(sip);
-		return DID_ERROR << 16;
+		ret = DID_ERROR << 16;
+		goto out;
 	} else if (sdebug_verbose && !ndob && (ret < lb_size))
 		sdev_printk(KERN_INFO, scp->device,
 			    "%s: %s: lb size=%u, IO sent=%d bytes\n",
@@ -4234,10 +4476,12 @@ static int resp_write_same(struct scsi_cmnd *scp, u64 lba, u32 num,
 	/* If ZBC zone then bump its write pointer */
 	if (sdebug_dev_is_zoned(devip))
 		zbc_inc_wp(devip, lba, num);
+	sdeb_data_write_unlock(sip);
+	ret = 0;
 out:
-	sdeb_write_unlock(sip);
-
-	return 0;
+	if (meta_data_locked)
+		sdeb_meta_write_unlock(sip);
+	return ret;
 }
 
 static int resp_write_same_10(struct scsi_cmnd *scp,
@@ -4380,25 +4624,30 @@ static int resp_comp_write(struct scsi_cmnd *scp,
 		return check_condition_result;
 	}
 
-	sdeb_write_lock(sip);
-
 	ret = do_dout_fetch(scp, dnum, arr);
 	if (ret == -1) {
 		retval = DID_ERROR << 16;
-		goto cleanup;
+		goto cleanup_free;
 	} else if (sdebug_verbose && (ret < (dnum * lb_size)))
 		sdev_printk(KERN_INFO, scp->device, "%s: compare_write: cdb "
 			    "indicated=%u, IO sent=%d bytes\n", my_name,
 			    dnum * lb_size, ret);
+
+	sdeb_data_write_lock(sip);
+	sdeb_meta_write_lock(sip);
 	if (!comp_write_worker(sip, lba, num, arr, false)) {
 		mk_sense_buffer(scp, MISCOMPARE, MISCOMPARE_VERIFY_ASC, 0);
 		retval = check_condition_result;
-		goto cleanup;
+		goto cleanup_unlock;
 	}
+
+	/* Cover sip->map_storep (which map_region()) sets with data lock */
 	if (scsi_debug_lbp())
 		map_region(sip, lba, num);
-cleanup:
-	sdeb_write_unlock(sip);
+cleanup_unlock:
+	sdeb_meta_write_unlock(sip);
+	sdeb_data_write_unlock(sip);
+cleanup_free:
 	kfree(arr);
 	return retval;
 }
@@ -4442,7 +4691,7 @@ static int resp_unmap(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 
 	desc = (void *)&buf[8];
 
-	sdeb_write_lock(sip);
+	sdeb_meta_write_lock(sip);
 
 	for (i = 0 ; i < descriptors ; i++) {
 		unsigned long long lba = get_unaligned_be64(&desc[i].lba);
@@ -4458,7 +4707,7 @@ static int resp_unmap(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 	ret = 0;
 
 out:
-	sdeb_write_unlock(sip);
+	sdeb_meta_write_unlock(sip);
 	kfree(buf);
 
 	return ret;
@@ -4571,12 +4820,13 @@ static int resp_pre_fetch(struct scsi_cmnd *scp,
 		rest = block + nblks - sdebug_store_sectors;
 
 	/* Try to bring the PRE-FETCH range into CPU's cache */
-	sdeb_read_lock(sip);
+	sdeb_data_read_lock(sip);
 	prefetch_range(fsp + (sdebug_sector_size * block),
 		       (nblks - rest) * sdebug_sector_size);
 	if (rest)
 		prefetch_range(fsp, rest * sdebug_sector_size);
-	sdeb_read_unlock(sip);
+
+	sdeb_data_read_unlock(sip);
 fini:
 	if (cmd[1] & 0x2)
 		res = SDEG_RES_IMMED_MASK;
@@ -4735,7 +4985,7 @@ static int resp_verify(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 		return check_condition_result;
 	}
 	/* Not changing store, so only need read access */
-	sdeb_read_lock(sip);
+	sdeb_data_read_lock(sip);
 
 	ret = do_dout_fetch(scp, a_num, arr);
 	if (ret == -1) {
@@ -4757,7 +5007,7 @@ static int resp_verify(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 		goto cleanup;
 	}
 cleanup:
-	sdeb_read_unlock(sip);
+	sdeb_data_read_unlock(sip);
 	kfree(arr);
 	return ret;
 }
@@ -4803,7 +5053,7 @@ static int resp_report_zones(struct scsi_cmnd *scp,
 		return check_condition_result;
 	}
 
-	sdeb_read_lock(sip);
+	sdeb_meta_read_lock(sip);
 
 	desc = arr + 64;
 	for (lba = zs_lba; lba < sdebug_capacity;
@@ -4901,11 +5151,70 @@ static int resp_report_zones(struct scsi_cmnd *scp,
 	ret = fill_from_dev_buffer(scp, arr, min_t(u32, alloc_len, rep_len));
 
 fini:
-	sdeb_read_unlock(sip);
+	sdeb_meta_read_unlock(sip);
 	kfree(arr);
 	return ret;
 }
 
+static int resp_atomic_write(struct scsi_cmnd *scp,
+			     struct sdebug_dev_info *devip)
+{
+	struct sdeb_store_info *sip;
+	u8 *cmd = scp->cmnd;
+	u16 boundary, len;
+	u64 lba, lba_tmp;
+	int ret;
+
+	if (!scsi_debug_atomic_write()) {
+		mk_sense_invalid_opcode(scp);
+		return check_condition_result;
+	}
+
+	sip = devip2sip(devip, true);
+
+	lba = get_unaligned_be64(cmd + 2);
+	boundary = get_unaligned_be16(cmd + 10);
+	len = get_unaligned_be16(cmd + 12);
+
+	lba_tmp = lba;
+	if (sdebug_atomic_wr_align &&
+	    do_div(lba_tmp, sdebug_atomic_wr_align)) {
+		/* Does not meet alignment requirement */
+		mk_sense_buffer(scp, ILLEGAL_REQUEST, INVALID_FIELD_IN_CDB, 0);
+		return check_condition_result;
+	}
+
+	if (sdebug_atomic_wr_gran && len % sdebug_atomic_wr_gran) {
+		/* Does not meet alignment requirement */
+		mk_sense_buffer(scp, ILLEGAL_REQUEST, INVALID_FIELD_IN_CDB, 0);
+		return check_condition_result;
+	}
+
+	if (boundary > 0) {
+		if (boundary > sdebug_atomic_wr_max_bndry) {
+			mk_sense_invalid_fld(scp, SDEB_IN_CDB, 12, -1);
+			return check_condition_result;
+		}
+
+		if (len > sdebug_atomic_wr_max_length_bndry) {
+			mk_sense_invalid_fld(scp, SDEB_IN_CDB, 12, -1);
+			return check_condition_result;
+		}
+	} else {
+		if (len > sdebug_atomic_wr_max_length) {
+			mk_sense_invalid_fld(scp, SDEB_IN_CDB, 12, -1);
+			return check_condition_result;
+		}
+	}
+
+	ret = do_device_access(sip, scp, 0, lba, len, true, true);
+	if (unlikely(ret == -1))
+		return DID_ERROR << 16;
+	if (unlikely(ret != len * sdebug_sector_size))
+		return DID_ERROR << 16;
+	return 0;
+}
+
 /* Logic transplanted from tcmu-runner, file_zbc.c */
 static void zbc_open_all(struct sdebug_dev_info *devip)
 {
@@ -4932,8 +5241,7 @@ static int resp_open_zone(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 		mk_sense_invalid_opcode(scp);
 		return check_condition_result;
 	}
-
-	sdeb_write_lock(sip);
+	sdeb_meta_write_lock(sip);
 
 	if (all) {
 		/* Check if all closed zones can be open */
@@ -4982,7 +5290,7 @@ static int resp_open_zone(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 
 	zbc_open_zone(devip, zsp, true);
 fini:
-	sdeb_write_unlock(sip);
+	sdeb_meta_write_unlock(sip);
 	return res;
 }
 
@@ -5009,7 +5317,7 @@ static int resp_close_zone(struct scsi_cmnd *scp,
 		return check_condition_result;
 	}
 
-	sdeb_write_lock(sip);
+	sdeb_meta_write_lock(sip);
 
 	if (all) {
 		zbc_close_all(devip);
@@ -5038,7 +5346,7 @@ static int resp_close_zone(struct scsi_cmnd *scp,
 
 	zbc_close_zone(devip, zsp);
 fini:
-	sdeb_write_unlock(sip);
+	sdeb_meta_write_unlock(sip);
 	return res;
 }
 
@@ -5081,7 +5389,7 @@ static int resp_finish_zone(struct scsi_cmnd *scp,
 		return check_condition_result;
 	}
 
-	sdeb_write_lock(sip);
+	sdeb_meta_write_lock(sip);
 
 	if (all) {
 		zbc_finish_all(devip);
@@ -5110,7 +5418,7 @@ static int resp_finish_zone(struct scsi_cmnd *scp,
 
 	zbc_finish_zone(devip, zsp, true);
 fini:
-	sdeb_write_unlock(sip);
+	sdeb_meta_write_unlock(sip);
 	return res;
 }
 
@@ -5161,7 +5469,7 @@ static int resp_rwp_zone(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 		return check_condition_result;
 	}
 
-	sdeb_write_lock(sip);
+	sdeb_meta_write_lock(sip);
 
 	if (all) {
 		zbc_rwp_all(devip);
@@ -5189,7 +5497,7 @@ static int resp_rwp_zone(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 
 	zbc_rwp_zone(devip, zsp);
 fini:
-	sdeb_write_unlock(sip);
+	sdeb_meta_write_unlock(sip);
 	return res;
 }
 
@@ -5216,6 +5524,7 @@ static void sdebug_q_cmd_complete(struct sdebug_defer *sd_dp)
 	if (!scp) {
 		pr_err("scmd=NULL\n");
 		goto out;
+
 	}
 
 	sdsc = scsi_cmd_priv(scp);
@@ -6153,6 +6462,7 @@ module_param_named(lbprz, sdebug_lbprz, int, S_IRUGO);
 module_param_named(lbpu, sdebug_lbpu, int, S_IRUGO);
 module_param_named(lbpws, sdebug_lbpws, int, S_IRUGO);
 module_param_named(lbpws10, sdebug_lbpws10, int, S_IRUGO);
+module_param_named(atomic_wr, sdebug_atomic_wr, int, S_IRUGO);
 module_param_named(lowest_aligned, sdebug_lowest_aligned, int, S_IRUGO);
 module_param_named(lun_format, sdebug_lun_am_i, int, S_IRUGO | S_IWUSR);
 module_param_named(max_luns, sdebug_max_luns, int, S_IRUGO | S_IWUSR);
@@ -6187,6 +6497,11 @@ module_param_named(unmap_alignment, sdebug_unmap_alignment, int, S_IRUGO);
 module_param_named(unmap_granularity, sdebug_unmap_granularity, int, S_IRUGO);
 module_param_named(unmap_max_blocks, sdebug_unmap_max_blocks, int, S_IRUGO);
 module_param_named(unmap_max_desc, sdebug_unmap_max_desc, int, S_IRUGO);
+module_param_named(atomic_wr_max_length, sdebug_atomic_wr_max_length, int, S_IRUGO);
+module_param_named(atomic_wr_align, sdebug_atomic_wr_align, int, S_IRUGO);
+module_param_named(atomic_wr_gran, sdebug_atomic_wr_gran, int, S_IRUGO);
+module_param_named(atomic_wr_max_length_bndry, sdebug_atomic_wr_max_length_bndry, int, S_IRUGO);
+module_param_named(atomic_wr_max_bndry, sdebug_atomic_wr_max_bndry, int, S_IRUGO);
 module_param_named(uuid_ctl, sdebug_uuid_ctl, int, S_IRUGO);
 module_param_named(virtual_gb, sdebug_virtual_gb, int, S_IRUGO | S_IWUSR);
 module_param_named(vpd_use_hostno, sdebug_vpd_use_hostno, int,
@@ -6230,6 +6545,7 @@ MODULE_PARM_DESC(lbprz,
 MODULE_PARM_DESC(lbpu, "enable LBP, support UNMAP command (def=0)");
 MODULE_PARM_DESC(lbpws, "enable LBP, support WRITE SAME(16) with UNMAP bit (def=0)");
 MODULE_PARM_DESC(lbpws10, "enable LBP, support WRITE SAME(10) with UNMAP bit (def=0)");
+MODULE_PARM_DESC(atomic_write, "enable ATOMIC WRITE support, support WRITE ATOMIC(16) (def=1)");
 MODULE_PARM_DESC(lowest_aligned, "lowest aligned lba (def=0)");
 MODULE_PARM_DESC(lun_format, "LUN format: 0->peripheral (def); 1 --> flat address method");
 MODULE_PARM_DESC(max_luns, "number of LUNs per target to simulate(def=1)");
@@ -6261,6 +6577,11 @@ MODULE_PARM_DESC(unmap_alignment, "lowest aligned thin provisioning lba (def=0)"
 MODULE_PARM_DESC(unmap_granularity, "thin provisioning granularity in blocks (def=1)");
 MODULE_PARM_DESC(unmap_max_blocks, "max # of blocks can be unmapped in one cmd (def=0xffffffff)");
 MODULE_PARM_DESC(unmap_max_desc, "max # of ranges that can be unmapped in one cmd (def=256)");
+MODULE_PARM_DESC(atomic_wr_max_length, "max # of blocks can be atomically written in one cmd (def=8192)");
+MODULE_PARM_DESC(atomic_wr_align, "minimum alignment of atomic write in blocks (def=2)");
+MODULE_PARM_DESC(atomic_wr_gran, "minimum granularity of atomic write in blocks (def=2)");
+MODULE_PARM_DESC(atomic_wr_max_length_bndry, "max # of blocks can be atomically written in one cmd with boundary set (def=8192)");
+MODULE_PARM_DESC(atomic_wr_max_bndry, "max # boundaries per atomic write (def=128)");
 MODULE_PARM_DESC(uuid_ctl,
 		 "1->use uuid for lu name, 0->don't, 2->all use same (def=0)");
 MODULE_PARM_DESC(virtual_gb, "virtual gigabyte (GiB) size (def=0 -> use dev_size_mb)");
@@ -7407,6 +7728,7 @@ static int __init scsi_debug_init(void)
 			return -EINVAL;
 		}
 	}
+
 	xa_init_flags(per_store_ap, XA_FLAGS_ALLOC | XA_FLAGS_LOCK_IRQ);
 	if (want_store) {
 		idx = sdebug_add_store();
@@ -7614,7 +7936,9 @@ static int sdebug_add_store(void)
 			map_region(sip, 0, 2);
 	}
 
-	rwlock_init(&sip->macc_lck);
+	rwlock_init(&sip->macc_data_lck);
+	rwlock_init(&sip->macc_meta_lck);
+	rwlock_init(&sip->macc_sector_lck);
 	return (int)n_idx;
 err:
 	sdebug_erase_store((int)n_idx, sip);
-- 
2.35.3


