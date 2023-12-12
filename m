Return-Path: <linux-fsdevel+bounces-5670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8934A80E9E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 12:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88AF51C20BAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 11:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAFF5D4A0;
	Tue, 12 Dec 2023 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l0+HftME";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jszRWtSA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651AC198C;
	Tue, 12 Dec 2023 03:10:12 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BC7hhll004079;
	Tue, 12 Dec 2023 11:09:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=OAVy/9R0/bbRD70fkTvpQqSioGRhdig6Z34ouGNPKM0=;
 b=l0+HftMEWO+ZPaKnUsQ24HF8jz3yvRbkQQSk3lJXWDlIs6cU8QU1G1p0ww8VFGIJgSaM
 9CJggRSsYiwWM499DS9OKvKbkU9fdX1RdeABrvIPNVbhX9jx5UnbmOWbbcRyNUae+R8+
 x5Zmw3lBkjmyK3MvLIsER5ZFiL1PyURNcO6tYEDfXZ7MP3oc+gxP4R6M3rPNG0rHSuid
 CVO8Pq6LaIX3KPCCmtho/OmtAjnklTntpzvEUfWf/kBxDltxr/WhL9VsG0yAEyn0Ku9F
 eKA22EwJgg4iUfaU1FaVQAcw34Yl3FaNWQmk3yHUYa7m5SQr8dqskx0st9S4LLMHn2Oh bQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvfuu5bjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCAwj7J008234;
	Tue, 12 Dec 2023 11:09:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep6cwvf-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlFAxsUvCiMo7ejoblEMn6wjUYRfBpZm6a7ljZWIlUvUJ9VhV8X1bmn21RGuYJF8QT+/2r9qP0rViMKeAVguCmeZLHvFoDTNJ+kqc6zqMAmQ9DR8xbaLfo2eBw3EwVgIwcuEqoBh/jib3tFc4tlIiivl2x7nnT6gC3QUio+Zs9MZ0HvEsgizOo1PimfliK29VULt6Wk/xgIORog/iayQzsV6RXEarSkOhx+KgXjxkXIcFy5VBLc2/ATeBHogadRRtH1X4LM9yFFAK71Ls+1nDnaJAogmoK2B/vbzIGYdyygh8hb6xwmb27RgC43poG9b1Q3KTPxrPOmFGABlXvcnyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAVy/9R0/bbRD70fkTvpQqSioGRhdig6Z34ouGNPKM0=;
 b=gCR9ofKvMjmYTA7CePEjQ3SojpdnnNRI5rnDqJOZoedsknhzAn1wmcMc9PD4dEuqMaB9WTnzbXctMnvZY8Iv8kBBnqe6ikJYyaAm11YFuKpswqNa/sUNc+fiyJ3qeVP3MwdPqdM+EWR+QJ62DgPbkgyy2bYehNy6/hB/g7HVXnoGpwvY1tNwkQ0nyYNCnpyweXXWE0Jsp4dQTnoW49R4UfjoTVJYEon9+q6LD06EAr8o/Xhnk10yOaf3+8RtRCTNhBZTs6gteIVH33QFHZdp8+MTPzBRSYuvixwFj9syvooJLxlF/BhVzxiEhmR65HUNqkzFLZ2ayVGq90FMnBBsog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAVy/9R0/bbRD70fkTvpQqSioGRhdig6Z34ouGNPKM0=;
 b=jszRWtSA2CHsxcAaHX4uKepgpjyOMkblwlwbKL6ZcrCbVfFEAM8o5GliIY+SgtMOdVBj+c+9aDK7M0IJNET+LVj1MIr3awNh/BfZ3cFG6hlMA0FgKSTfj9cIchbE5qF5NWpbBfYX30c+ZByHNVZBTOZKgXJxDiBKv3PcQB3E5VE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6663.namprd10.prod.outlook.com (2603:10b6:806:2ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 11:09:47 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 11:09:47 +0000
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
Subject: [PATCH v2 16/16] nvme: Ensure atomic writes will be executed atomically
Date: Tue, 12 Dec 2023 11:08:44 +0000
Message-Id: <20231212110844.19698-17-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231212110844.19698-1-john.g.garry@oracle.com>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0241.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 74db341f-d7ec-476b-b5ad-08dbfb02d9f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sjb0YosYf88Xey4WL0pMTkcjvbGuDxICSmHxJAbKuSgKBdAraHIkP2iXL4sSrak0F/LDphoe8wqboMhnD978m18lec2iirQQF7QbmEAf8FWo/+BYJygdjTApvuoVOmuC//NZZlOrVi46YEpKZqrK9Cca/VVvnrY8p3cmiqlJ3duOTKbSWHdDANuP1E2A20TA0AfF0Dg/Xr3mtEKV6+G6QZPv0EDnIVMMSsTJhyaGds+9e6B36w5ZaXak5Q1n2rkuOa9cZYpLBwwxDgtfka3g7msjTN04w858jbNEp8PxKhCmVhIhcceeg5REMywxCsuSW5beGBOm64OOqlYtwYTtIJRM0HmhESHZiU6Y5ttSAxI/E3SgUH/2IL++BU+YiOJ/Qza862augLl3S4RKgvRtFwtP3+zDnklPw8XHAuWAUK/a1oVI24d3+3TRABTL2N3M5/5g3y+1gWt/TuceQL/iodn5RO2dGMGtIpFrVmNjN6d1DJ90d/2shZ8TtiDD3Ox3EgTw8Wsz79PPszSAUf/q5MUSt3vrOG85ES9cPgGpf+whYXWKA7a31OJDooRYTJDk2uqBy3ufOHCK41mdZI4rJFCuq+AYuNjQcVaSugBefI8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(6506007)(6512007)(2616005)(107886003)(1076003)(478600001)(5660300002)(4326008)(8936002)(8676002)(41300700001)(7416002)(2906002)(6486002)(6666004)(38100700002)(316002)(66476007)(66556008)(54906003)(66946007)(103116003)(86362001)(36756003)(921008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DwQqT4bWfRNkCG1qsWiNFQ9jFajVPPxrEgQSOKuTEMNQ9rJQtRzgByiSWgYJ?=
 =?us-ascii?Q?whVl4/1Up+RnICuXGH/gPrf6PCmTOhmmsr11RzZFzBfvR0BbNNdGk/9YJ7Ab?=
 =?us-ascii?Q?rjDiqOEF4pkwjm0SJy19YULN6fDLhZvIwpYmQTMk5gJcAfZ88lfcDg7Kd0BG?=
 =?us-ascii?Q?pDS2mdl60uFrwUS9Rmtg025KcznQ0UhQwKRfi4d1RUNdjAo1XEJ1BSBB+HGW?=
 =?us-ascii?Q?5jvvkIHdnmgP/0F86V36Dki2CV1lidERQWPJApPb71X8XOntomsiAiSqkM+v?=
 =?us-ascii?Q?P/EUIgVSiD3Dl3wuZKP+1H+jbSMWWVESU19xrKDDvxO2L/phkMPRc0Ew8/pD?=
 =?us-ascii?Q?WJeiBfozq42q3LJ1LK7PBr+llIQfyDO4hNZnqSYbQzXJhkQxBeaRCNZeLr0W?=
 =?us-ascii?Q?4q82zh6OQtyl/8Euf0Q1rRweORDgELvS1Edz6Oc2iqysO8XLBXe7jSkWnsvk?=
 =?us-ascii?Q?inGVLRTDEEjd2zgRd0jCwKUFSbhLeUE+DzOcBzUL0ie+ztdlOQm3PSH+Gk9v?=
 =?us-ascii?Q?0NCgEQrsqNSJzoiPqsjMPYMqbu0/fWhBpPnVTjDkg/4g/pSPIHQlXh7EthCk?=
 =?us-ascii?Q?iGJd+QFCxQ8b2jvGr+3xeII+R9cSPq1ae+/IltF9XmOHviPvd6NolE1neolM?=
 =?us-ascii?Q?7ykP02iw0WLksr8IOS7/tZYGGnaWP0fUpEWexF3Z1b0PVt6gpaIbzaDNu8GN?=
 =?us-ascii?Q?UgKhjMI1t645ZieAlu0EegUnDULw9hP46uJFczQ3OjVU2rzPCI1usMA54Kjl?=
 =?us-ascii?Q?DkSkTp8g5sLYsIHGAbE2rXKbReYFsB6Mwf9C+fNHq+c0uJmdHNFBzAR/J/F4?=
 =?us-ascii?Q?kNRiSK770GftSn7rS6QHklO04K8FYjT/5kVUodXWNUR3yDX34/x7vR1+eW3C?=
 =?us-ascii?Q?4pm/hfMoseuF79j4usPlt6MxxamKP4NiN3lt4PTFXxRCqJtL/HE3pabqHLAm?=
 =?us-ascii?Q?WwVNRAdON65x4Vbn0h3++tiZ8qLorlwM1vttgu9/FJdDxHFgKRXdhjq8NoBR?=
 =?us-ascii?Q?aHaWz02VX+oDAfI7J28bGJMNSPvHDKBTIbAADadRc4iDqlylh2WswW+3RuFf?=
 =?us-ascii?Q?cVSDaFEx18FSq9xFVUZev5y1ClLQifpePCEvFOlS8qK5vweI+R2zIgKOkGmc?=
 =?us-ascii?Q?LN2VSSyHZ0YryvYf9Nc4rwr5aZy2iLJk3TyUX1uXEmX1h0APRZSIt1y4R2qH?=
 =?us-ascii?Q?FF0ot9RRk6twFItsimm5C8Dj/qudthNp5PAAnMc4vTkkoMz1cOlPAzrgyq7a?=
 =?us-ascii?Q?R70XxHNHHicWiqvXVxtcnjdJ8xhyys0rieYzLYEKpUmmB/rkPfHXuUdFXJD+?=
 =?us-ascii?Q?HdaFnW7JWH3s2wa3YLbWdJhb6+zTaFHFizzk+k0sJDSndNGcQAXsQft70z6j?=
 =?us-ascii?Q?DQIGAMop9A3Rwe1vRMMAS49tdLi2IbvC3WHVOcrWUr/JuIF9M0wpfbwSMwqf?=
 =?us-ascii?Q?WK/F60FgQiBaZjaF+/D7DYiKe2e9KwP5dapTs71/w3iEVkt71il0u9zG/Em0?=
 =?us-ascii?Q?DyNRH9/T8sZJJbbvYWT4Zg7105RS2Oj1KjnqcPeJDpxu4w841KkC2l6rVCwr?=
 =?us-ascii?Q?5/eGoVX5IJtfncTG6n3Y+iud7oHw8BENqXyP2HQMOcdOSRW64X8hOYvInOAr?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Wq1wzedCty21HmZ/6hIg9smcKML6AShiv6Abi0dk+ZXygG/mGSQUKsCVFC0plWJcAXeLwJI8AvgV4ZBCL0x20lUj1nBLWT5Xy/h+mCVkI91nBlnVQov2lpp0J0xeEhuMWx9d8Voxu/T//RjaouZHawOhiVyNMWB/C/V0UXScbWXMRc7SBtFiDj/sDpf+EvOcxZrcRh6XBFsHxgZBTJh9MCEd8RIG3dvdj5ODboLv/RAFLYR1hQYF8kxW5LLspCvNPD33m6fvj0a8TWtOiejSz8peC+Xn6QqMVPQiJx342ezV/alb17/rVnDPMXF0v8TC9Qoa0oRyM3iqxPJiL9rfGkRokw3c8yRqqUZ8yMiupu1Nr9f9DH8OQYIdGqg707muXwjEknlkKjgnmkUJpPyWhszncf9pT6ulPw2xMYpbAKTEQijNBJrRI0JznRLJkXo9B1GsvhK5bMY62lzF7YsU4gLuTzNWewX314nw2CKMotXk7cwTR68ub1wQNVzCg59xpjhZY3UunfWHqYl/CGjBGhnYmvS1p9iZWU4lNpMkeiS9Wc8Ladtf/LKhI7j5/sjA26obCGR0AIo3vkGw/DxPiWnmumQ1MOvr4UbdZMDplw0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74db341f-d7ec-476b-b5ad-08dbfb02d9f8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 11:09:46.9945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iebAWjyjEq2gAM1FaJs8cSFDdVi0C9FRgXTZ36ZBXwTefzpzUsu2TKddqptmpEvYtOMHFJm8rvVQCHiS+taKZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_04,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312120089
X-Proofpoint-GUID: DKW9AuX8fVUZuUVTnOkx6uiXE9aF-f7a
X-Proofpoint-ORIG-GUID: DKW9AuX8fVUZuUVTnOkx6uiXE9aF-f7a

From: Alan Adamson <alan.adamson@oracle.com>

There is no dedicated NVMe atomic write command (which may error for a
command which exceeds the controller atomic write limits).

As an insurance policy against the block layer sending requests which
cannot be executed atomically, add a check in the queue path.

Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/nvme/host/core.c | 23 +++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fd4f09f9dbe8..6b89ee7e9921 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -905,6 +905,26 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 	if (req->cmd_flags & REQ_RAHEAD)
 		dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
 
+	/*
+	 * Ensure that nothing has been sent which cannot be executed
+	 * atomically.
+	 */
+	if (req->cmd_flags & REQ_ATOMIC) {
+		if (blk_rq_bytes(req) > ns->atomic_max)
+			return BLK_STS_IOERR;
+
+		if (ns->atomic_boundary) {
+			u32 boundary = ns->atomic_boundary >> ns->lba_shift;
+			u32 imask = ~(boundary - 1);
+			u32 lba = nvme_sect_to_lba(ns, blk_rq_pos(req));
+			u32 end = lba + (blk_rq_bytes(req) >> ns->lba_shift)
+					- 1;
+
+			if ((lba & imask) != (end & imask))
+				return BLK_STS_IOERR;
+		}
+	}
+
 	cmnd->rw.opcode = op;
 	cmnd->rw.flags = 0;
 	cmnd->rw.nsid = cpu_to_le32(ns->head->ns_id);
@@ -1937,6 +1957,9 @@ static void nvme_update_atomic_write_disk_info(struct gendisk *disk,
 				id->nabo);
 	}
 
+	ns->atomic_max = atomic_bs;
+	ns->atomic_boundary = boundary;
+
 	blk_queue_atomic_write_max_bytes(disk->queue, atomic_bs);
 	blk_queue_atomic_write_unit_min_sectors(disk->queue, bs >> SECTOR_SHIFT);
 	blk_queue_atomic_write_unit_max_sectors(disk->queue,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e7411dac00f7..5a3d76bc816f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -520,6 +520,8 @@ struct nvme_ns {
 
 	struct nvme_fault_inject fault_inject;
 
+	u32 atomic_max;
+	u32 atomic_boundary;
 };
 
 /* NVMe ns supports metadata actions by the controller (generate/strip) */
-- 
2.35.3


