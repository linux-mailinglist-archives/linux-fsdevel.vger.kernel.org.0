Return-Path: <linux-fsdevel+bounces-5664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B9A80E9CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 12:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1740B20E46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 11:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500E65E0C5;
	Tue, 12 Dec 2023 11:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="duejtCdp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZKUwsH3H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFB9F2;
	Tue, 12 Dec 2023 03:09:46 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BC7hiVL004099;
	Tue, 12 Dec 2023 11:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=jRgivuBGPAiJE3stZe7qo3VAGM2ldFIKOu17TRfwV90=;
 b=duejtCdpIEq/NrdnwQBn11uIh3VENW89qyGItKngomFhcotnlFpqlPZn3DpGipvMvrLL
 +Z72IUsxrUdTl/vA3B+BNBKH7cLMZ/cB/vlplZyI0WjBlhrscOa5Z2Fb7GUKjfFVwlYp
 3QYxrOScu3p4UmfLDerhqg++/lVO29j3KUlXidGcNnutxWb4KXzbGV/hdewyjidxhuzp
 WHfvUMJsvtplnDaGh77cN3F2wEM9amw08n8Jvf2vkn6IrMa/22oJqxFX/9ENFJFR/83b
 /aaWZ1OmxWAB7ZO7xvZfqPGCgXg1kH0TSt9EF8y4JkfikQKAkeR4Uvp+4gcURhzr6VjR EA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvfuu5bhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:17 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCAxAst003210;
	Tue, 12 Dec 2023 11:09:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep6e16k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbbTGi5L9N6yZw+8tNflzIXYTSr8SS5HYWs+tMJcO9ZMRbZWVLO9PxmthOfU4ccbwYhsEc5aFqmUTaejQsA8N1Nljoazy/5kiYJEjGqGxCwrTGItnnfbEAZTHFI2vG00g0Ni7VoRHxulik/IQzd3vsESa1NBHZ7xUJjDwtpfERF3QDS5hiKUwoAGtTYyY+ds00IGyjdKWafTh0hpDBnJEGdVrWRxDjMg+5HxFDxgTQlZNuPRLFXSLzcaiLpvA33ThYijvFyTxoDsqiGs6qot/nlLlR4OczhJ9Pw6hhwmlhsByFRDFq1Nz/DpJQt3DmMLtQa/EQLF0kdAK3Drq6v1eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRgivuBGPAiJE3stZe7qo3VAGM2ldFIKOu17TRfwV90=;
 b=LO5Qg3YQM9qdL/eyRE+8OzKfc8mNyu7jmuMKiHE7T8BB36nZkTt2HiQrwgoyI5jYPKKA/5MgSo+MgVZHYRziUnf2REZM8JpOpkoT5A3lSeF96axUVdCMQ6Vt3ilauxAMD9jJMi8/Zfjqq/rwf1eMAuqSlRPSYOtax0CCHIn3rszEy3R6eE2qJNL1RRW+JFi70pauvyuYpWiOX+mWc7GSmeRQbH/BzDK7yzbDeOn6CdRqCjty43VAeTFS94PDLjgPbeV9fZ1dclPZTU7n74abBMRdn3jFaiS2TrStkSFwxk/4mfLLf1EQGsU8WiQh4+s/U4aCsIUIM3VUVrFC6QYe7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRgivuBGPAiJE3stZe7qo3VAGM2ldFIKOu17TRfwV90=;
 b=ZKUwsH3H2Cvy3qNiE1x9e/HSzlarBLBjFrtTAnjbejZYyEGiHZ7J3eJ41HuNO29+C/3JayREqI2XJyZk+OSNL+a44QGBoIVm6pbAJi+5+4Y2ewXrO33B47z8ML7cqoRcAd+NNgWR3rY2CeFI3Lqd7q4rOiLPTAtsQ/ODMQbz4OU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6663.namprd10.prod.outlook.com (2603:10b6:806:2ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 11:09:14 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 11:09:14 +0000
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
Subject: [PATCH v2 00/16] block atomic writes
Date: Tue, 12 Dec 2023 11:08:28 +0000
Message-Id: <20231212110844.19698-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:207:3c::39) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b644e75-064f-48d2-3a6a-08dbfb02c699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ez3IhG2vBv+6MJXM3iv8oXvh0i3TPcnSR31HTXxWJHGNaiNgFrgyM30R7POfMm5QiyW6pfYav8la60dnHnuLgdhRs0yNliQNZtZlL3qRcZS6iExr70DLJfDBtJhzOfzpHllOKa6ta4khAdfqrGWUcfFTvduT4c9HjL/A+iRU/RHNHJCEAqo9ziaN36Cxw7LSMalOUE6s6iaM9NFYbpqJwa7d4/1y4qm8wzhs/8r4uMaBrGQiIODRoX9IL+xmbLe8YoOn0P0U0qUVdbZlRvWtNzPUvRt3dl9x4rARyYgvYEijA+VdqmdxE3M5BGVzHIniNXbaEcJQimYNMtIlp56lS9KSNAh+k7eHSsnCPQqF7le0lnYmETxlZHVSHFw6w/gdbtO99VJMykzlcEgQE88Y921fwUybgccL2b00QtJmo9qroV+6t76JsV5If9N4HGW2DRZiSHDa22+z8etbFzCWqCR+Egg7SIKX2Imlpc46Gnbxh+AK69KyiISk6Qj9KAiPYxqCNotXFdl54hC/E6Too/9tEEPGUBCMH4cgiHvtHkFZ8a1+oc9ywC/dEcMpbs2ZT5hQ0wW3pSAmcyPCuXZE7Z4sYi/fVbzpZvDH1CgQ6Uc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(6506007)(6512007)(2616005)(107886003)(1076003)(478600001)(5660300002)(4326008)(8936002)(8676002)(41300700001)(7416002)(2906002)(966005)(6486002)(6666004)(38100700002)(316002)(66476007)(66556008)(66946007)(103116003)(86362001)(36756003)(921008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0QZVgZrw9rBjdsidp+VWKHx0Z0mnzfBvEGCfLhCV01iCa/S0sd0UR/QkhvoW?=
 =?us-ascii?Q?62QFYRrD0tmGaUy4WjXLN83o4GYL/1iAcDHw2NOKHW6/cImgQkN6YEDspP6c?=
 =?us-ascii?Q?m0ELdk/qx4dt0TJnOnBmgH1cGf2U0/wz58wtJ2fvcB5RFdXAYMXtWO9zjs0K?=
 =?us-ascii?Q?xJ5kzBNae1uTD7XAx/R1T0gvDOJesj6RpjPfXyEp09bPt+b50tPHd0mg7+9W?=
 =?us-ascii?Q?j6rXTITfXyCpW6WOiMf38KWtZiox1/YyTibtobN2Kcf+t2tM012prNgZ8XQw?=
 =?us-ascii?Q?5gmMDF+Hv7yyTBuuPX70JZQQl4jLFmuPsV7gRHnilC0oALZ1etZ7yoKMNmdN?=
 =?us-ascii?Q?jA6DscLkHfNTPw+Gi4yzmg0q6RnJP1i/JQd8e3XXbIhCSI07ax2/E+bUgVLq?=
 =?us-ascii?Q?80rUclW0CJVw3H1l/cS+5hva5FMMNxKjTl6PxNrdrDld3z2Rf2JMqUTawSee?=
 =?us-ascii?Q?2Uw6ckAM0mFfHWBbtBRIqlq/VZvrmIKVDzEROnzOhaSBwMg5y95x4JT6rmIq?=
 =?us-ascii?Q?oBMfnr3ONXPaWRTOFWLD2jhgEXLPuNztznrycxxdULYTCwUfZ0g3p6SY0LrL?=
 =?us-ascii?Q?OhpagmAcIAPVOLGKunPiIlvugqeBAnSjbC57oCVuICNej+zQHl3jcHwKIZOy?=
 =?us-ascii?Q?fPU5nig/adzRwH7ArlfsKzJQp5MXa2DlNrEeM8GDRs23boIduUeHi+DJH167?=
 =?us-ascii?Q?rMkUwi32o9Oh6SWFLZzOkbhv8tHTB1Yso/B7S3OXFaKV+7RzM/J/CIaTFPaZ?=
 =?us-ascii?Q?qPA5JMoA7dvQcDe9JKtxIX47gJExyIqQUZNXiDxHlKdlQwQSuTIewRwcg2QA?=
 =?us-ascii?Q?B+2MZEgibzEhq4/oSSfq9wQ+zgtYfKVOK4Jf7LnvvhWzVfFPEUSjS5ejI0b6?=
 =?us-ascii?Q?6km8ahUItOLkz39QAQtDrv74EyGgOAxrWmMgicSqmhx6lEHkOROBDe7d1C95?=
 =?us-ascii?Q?ccWY+2kHqu9Hw4r7XLv1QSgnHcMgy9Bc9Og1qcTs7B4QMdFqDWnv8OhQ7WLg?=
 =?us-ascii?Q?uM//0HMhou6htbF4F+dUeaaYlRXjFMEqg0rjDWPmc2K/hnYrAuHxVV5KJBY1?=
 =?us-ascii?Q?ByhMtlFiOd9VTFQi9Q4kO5Amfrtz/vL1vNnYirJYPDGBo4rglwQft3ZKCuKk?=
 =?us-ascii?Q?D5snCOZAkvcVndEha2HfZUhYSmYZRivo6Nq22nk7v+u/Ib0VTTnXyUzk8s9f?=
 =?us-ascii?Q?ZDgWo8h4YWcSq82eFld2IeJ1trKAKTUSVKyGA49QXY4dBI81taPdq+HQUOLz?=
 =?us-ascii?Q?Y2EYRHe4eOFUwtzCIzmEB/nJCkllNosVLpq5l/K4BrQ12i7r4YcAsTg5WqFi?=
 =?us-ascii?Q?Uv2GZ8Yul//4SiENvAfxdWo/3Le35vVtEr4MZsr4vYhPq5YloUhmtF006Ql3?=
 =?us-ascii?Q?BSUahR7XFET7RAdACcqmXD9V+HEHU6F6tL09zLvtni0peoprEwZYiiH4nWLW?=
 =?us-ascii?Q?ao6BUY4dlBRqhXLtyb1pqby+gzbQ7akzMPRNyyEE4kq9KUB63I/QhY44l7Fw?=
 =?us-ascii?Q?9J4ImHzHxN32XQvZhe/O6/PYhRfv0olAPjxSfbEHIOS6QYdlWNoULv3Epgk8?=
 =?us-ascii?Q?zpBVF6g9U7nBxcpsDBrDy8h7voG51RzBPcz/mpizcLrQHLxSPaQ7pmBHszu+?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rRXR/+UJJfhSLy2aatk12HvFltrRSa41L0Q9FQADCRkOoABpVfchJb7z8LNlTV1m7wz8xGnzPA4FDsELLXBdDIu17FZh3zTFS9FLf26+8CU7lBMS0ZN8K71EbYtoTmf4qsaxMLUgsHGBdUO39alYszLqEFBRhmhmoaKdiuV7UTFJlPEUihsCtLCUBAKCwzyQvKo4+2KHd1yb0eCrQCc/RunR/wjQcHaxYZMV3uST8TLsxuRsnWdLMcmo+wOpu/vUKlGMUXBKgUxcaMRBLexN3STw9VWXmHJOKNVMTzlXOO0LGZFgiYSC/Nok1Sp0MKq2yDALujxHZWf1w1cyUkCjZMnV7PT8Sxv7EazIoVQz8AzDEYwAgBWbdvI+bosOkWQNhxSTm+/c05467vxvGyY4y2/tzobbzzyvK9b6OqL2cWbVrnvB2IHOrggDIKL1r/qCGrHIUt+LIE7c+uLOXBxVDSEpTUC3XgE00sXIvYXJJn0o0dTKcr/872+R6xxZthQ/APe4EoaBhp5x04xZ85qUr6ZwtFYwX44DoPWntpc9z7v8n5mkzqQgo99qyYA4NvA+Xl6czM2x52XiZBYXn2rPWvnr7w7nYWk+Flp9oKwaiMc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b644e75-064f-48d2-3a6a-08dbfb02c699
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 11:09:14.4726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fk7wU95Ct1MUKPgDBNRrPpHnf7x9qwdW5k+jKHrIISjQPzcW5G4zBzUChbQhmdcbtmUd8xG3xAvhE0KHrLUuLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_04,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312120089
X-Proofpoint-GUID: jAd-7shv0zqSgIEqreW_MhyxQ00SoQGU
X-Proofpoint-ORIG-GUID: jAd-7shv0zqSgIEqreW_MhyxQ00SoQGU

This series introduces a proposal to implementing atomic writes in the
kernel for torn-write protection.

This series takes the approach of adding a new "atomic" flag to each of
pwritev2() and iocb->ki_flags - RWF_ATOMIC and IOCB_ATOMIC, respectively.
When set, these indicate that we want the write issued "atomically".

Only direct IO is supported and for block devices here. For this, atomic
write HW is required, like SCSI ATOMIC WRITE (16). For now, XFS support
from earlier versions is sidelined. That is until the interface is agreed
which does not fully rely on HW offload support.

man pages update has been posted at:
https://lore.kernel.org/linux-api/20230929093717.2972367-1-john.g.garry@oracle.com/T/#t
(not updated since I posted v1 kernel series)

The goal here is to provide an interface that allows applications use
application-specific block sizes larger than logical block size
reported by the storage device or larger than filesystem block size as
reported by stat().

With this new interface, application blocks will never be torn or
fractured when written. For a power fail, for each individual application
block, all or none of the data to be written. A racing atomic write and
read will mean that the read sees all the old data or all the new data,
but never a mix of old and new.

Two new fields are added to struct statx - atomic_write_unit_min and
atomic_write_unit_max. For each atomic individual write, the total length
of a write must be a between atomic_write_unit_min and
atomic_write_unit_max, inclusive, and a power-of-2. The write must also be
at a natural offset in the file wrt the write length.

SCSI sd.c and scsi_debug and NVMe kernel support is added.

Some open questions:
- How to make API extensible for when we have no HW support? In that case,
  we would prob not have to follow rule of power-of-2 length et al.
  As a possible solution, maybe we can say that atomic writes are
  supported for the file via statx, but not set unit_min and max values,
  and this means that writes need to be just FS block aligned there.
- For block layer, should atomic_write_unit_max be limited by
  max_sectors_kb? Currently it is not.
- How to improve requirement that iovecs are PAGE-aligned.
  There are 2x issues:
  a. We impose this rule to not split BIOs due to virt boundary for
     NVMe, but there virt boundary is 4K (and not PAGE size, so broken for
     16K/64K pages). Easy solution is to impose requirement that iovecs
     are 4K-aligned.
  b. We don't enforce this rule for virt boundary == 0, i.e. SCSI
- Since debugging torn-writes due to unwanted kernel BIO splitting/merging
  would be horrible, should we add some kernel storage stack software
  integrity checks?

This series is based on v6.7-rc5.

Changes since v1:
- Drop XFS support for now
- Tidy NVMe changes and also add checks for atomic write violating max
  AW PF length and boundary (if any)
- Reject - instead of ignoring - RWF_ATOMIC for files which do not
  support atomic writes
- Update block sysfs documentation
- Various tidy-ups

Alan Adamson (2):
  nvme: Support atomic writes
  nvme: Ensure atomic writes will be executed atomically

Himanshu Madhani (2):
  block: Add atomic write operations to request_queue limits
  block: Add REQ_ATOMIC flag

John Garry (10):
  block: Limit atomic writes according to bio and queue limits
  fs: Increase fmode_t size
  block: Pass blk_queue_get_max_sectors() a request pointer
  block: Limit atomic write IO size according to
    atomic_write_max_sectors
  block: Error an attempt to split an atomic write bio
  block: Add checks to merging of atomic writes
  block: Add fops atomic write support
  scsi: sd: Support reading atomic write properties from block limits
    VPD
  scsi: sd: Add WRITE_ATOMIC_16 support
  scsi: scsi_debug: Atomic write support

Prasad Singamsetty (2):
  fs/bdev: Add atomic write support info to statx
  fs: Add RWF_ATOMIC and IOCB_ATOMIC flags for atomic write support

 Documentation/ABI/stable/sysfs-block |  47 +++
 block/bdev.c                         |  31 +-
 block/blk-merge.c                    |  95 ++++-
 block/blk-mq.c                       |   2 +-
 block/blk-settings.c                 |  84 ++++
 block/blk-sysfs.c                    |  33 ++
 block/blk.h                          |   9 +-
 block/fops.c                         |  40 +-
 drivers/dma-buf/dma-buf.c            |   2 +-
 drivers/nvme/host/core.c             | 108 ++++-
 drivers/nvme/host/nvme.h             |   2 +
 drivers/scsi/scsi_debug.c            | 590 +++++++++++++++++++++------
 drivers/scsi/scsi_trace.c            |  22 +
 drivers/scsi/sd.c                    |  93 ++++-
 drivers/scsi/sd.h                    |   8 +
 fs/stat.c                            |  44 +-
 include/linux/blk_types.h            |   2 +
 include/linux/blkdev.h               |  41 +-
 include/linux/fs.h                   |  11 +
 include/linux/stat.h                 |   2 +
 include/linux/types.h                |   2 +-
 include/scsi/scsi_proto.h            |   1 +
 include/trace/events/scsi.h          |   1 +
 include/uapi/linux/fs.h              |   5 +-
 include/uapi/linux/stat.h            |   7 +-
 25 files changed, 1098 insertions(+), 184 deletions(-)

-- 
2.35.3


