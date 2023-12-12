Return-Path: <linux-fsdevel+bounces-5675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D318280EA12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 12:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62DF91F214BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 11:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1415DF27;
	Tue, 12 Dec 2023 11:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NNvtiNlc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B619psh8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A81BD5D;
	Tue, 12 Dec 2023 03:12:11 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BC7iCtk020707;
	Tue, 12 Dec 2023 11:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=e2MtufRTXXYathMPqWsaL2vZTc0diGY0QRspYAKXl5c=;
 b=NNvtiNlcD47Ow0Iu1m8BYzpUPQOKqThzNAk05WMzFMySWQJ1aTGb77JlAPn3yo+dE7mO
 wv49LafWo0Jw14/oqfSrBAcCA4skRghNA2D9/YP3tGwiw6m4WLThOxOP9B1X7+Kv7MdC
 eFu+aR0AmoI2mmfW/oLG/f+9ucoRCieFzV8X6VavgIxgWENy1O2JKO1Mtw8C8cpcKv3l
 yDr+GKf1diz/xVxnO/vHinf1a+diaWsQWmT9iyXZl5wN6/CCt48vtdmOpTsQlO1AX56K
 L4CbdoiLK1Qn053A4pu2DFnYWfmJu1Ojc3rIx0Xo09jtBvQPkogvtgF94UAevCePYvbV +w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ux5df21hh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCAq2C2010022;
	Tue, 12 Dec 2023 11:09:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep6dfje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 11:09:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tt5m7xd3GxY+jzQVZqD3PzSBzcS5aSr+sF+PMv7UN8NRSfhKP4qA7z7hvG2WXF2tkY+QpU9L+NB9toryiIOwkAifVVDiVc/epGNHWj3Oc9zdwHLb8q8roGxGB1XSS+fSWCQOf782Dt6I3nWZa7EclcKEG5QumsHIv18AlP9a6YVJwefMcne/AHOAINGstz2UBccJuVN527I1HOOIJLCi+m3l1NlJUp8t4YPPLdA/U+Ml3HadTsjddD0kIAsBA1OOZQ1ZBEmY9SYqbBVpqbTq643m3zNJGn8ldArtOHwnU9k8pVK7YWGw5ujtECtmfxtUgfsQ5dySytRayl15yax2qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2MtufRTXXYathMPqWsaL2vZTc0diGY0QRspYAKXl5c=;
 b=PDi7v6+Uc2fTuuIV/reFWGZoN12iQu7fkhT7W62ajCcYJhxFiVoEERRNVDngZKIMS2m7OI7RwZTZNScTQFOd2sXyNu8zU/iDChHJpB/33KSDqsx2PHiiRdPn9rFshW4daXqjbwlHUq4JFdDKiB0ILRdcZTF7kITwHRfQgZ618FMgyWz/aeeczfz1Y4JB+tXtNzT6Kb//pIYx3YsIp0bpFEIwGkIPwvWjIr2XsXueYgcGicv7EbWIRJQYW5zIE9j8eAO7r8LVW0CZlzBH6yhHblOmSndWyRl2pz4hi9JmoCPbsqWv1+B+owimuqGhv9ylRvzW1lOEMGWIuz1H8k3yJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2MtufRTXXYathMPqWsaL2vZTc0diGY0QRspYAKXl5c=;
 b=B619psh8vmP1pig5dGyl29J8S0KB+oIM5F7/a50lqlQhVpUmddOAOZAVJDWHIikpvM/F8tczBrjj9Py5rpeFLf51bc/TE7LMBC4RuPmawvHUzT4LwC5GPDGIqkxREgsH6eiGSv10oMXBrWOlckZmAun/kReZ+gt8/VFdAPHbRVU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6663.namprd10.prod.outlook.com (2603:10b6:806:2ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 11:09:32 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 11:09:32 +0000
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
Subject: [PATCH v2 13/16] scsi: sd: Add WRITE_ATOMIC_16 support
Date: Tue, 12 Dec 2023 11:08:41 +0000
Message-Id: <20231212110844.19698-14-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231212110844.19698-1-john.g.garry@oracle.com>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0053.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::30) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3ddb56-2cae-4e30-ec59-08dbfb02d17e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tkBoYTyHVmVZIQtbv7Zqap7qWEt+j2Ga8K6NLqSiMAOSXB1JRLBIpH6tsNgnT8WpyHGO7SCFUR5FEc/bCIcJfGs8nHBtfYLEVSX9Yrm3iaH2V7Bxui0sjwAHOH8K7nnKaP4PUgHMVXa+jvhymPJ73FAi/i3THPaOJJonrC937VWqZYuNkh1190I5w4bqbU21r/xQQQOzjsYMCnegvAJ9rqWIOZHcb2Y9tmJ1FY8QZTAR382mZEV58j1e6s7+ryQZRZXYZ4DMGpwihVKJHGvJTm4fdhkREgTPvZDRo77lZ1a01cXoreWZQ4wL5jeDlYCJUvIyCH8Ljo2/W/p9coysFz8/ezr2u+SGvGvxSkJIkNN8LbXqtweWI7jOSp/n0DFoW44rs3UMFh7Ipz4y0s9aADDsPxO3hBaPD0MCocHrLN9VVyKJBMR2q+9pxS7TRBqqKdJrYS4l60XVF2ClF42DerIIC3B6g+qU8aNOksKszJVSqEA+h4m70RED1cufpI/KaSFQIpFyMKmHb4F4TsoGQf55LstV4QgHb8gNJuRqNbUSpBWxDtonwHulf2N3MZjRc2F45RHBabbufsWM4GQNZfBWfeyiWGtDQKkf9/w3aUI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(83380400001)(6506007)(6512007)(2616005)(107886003)(1076003)(478600001)(5660300002)(4326008)(8936002)(8676002)(41300700001)(7416002)(2906002)(6486002)(6666004)(38100700002)(316002)(66476007)(66556008)(66946007)(103116003)(86362001)(36756003)(921008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VqzI9dqGNjcQuenugiv2ll+op2gS+gU+e07dtvBqvYeZgGbVf8vGMD0kH9Eg?=
 =?us-ascii?Q?2QEHY9QBisEHTI57ujK5tUWttwzw8AbYB4XAT+UdFKJAH0oEWIykQAftpiXj?=
 =?us-ascii?Q?VRiyxNtHBNz3z3ocFallSDDzNEJaA+aXpJ7wCZOm8WUv5RNgQYcmuUS7E0A2?=
 =?us-ascii?Q?IPhkrH77cp5jOt/RkPThWMPXUM8tL5DXkB9IUsyZQIXdi1msdvFqT52kKPgt?=
 =?us-ascii?Q?QZWPB+WzMM23thnfaSWVs0hItmHoFUeBFn0xaIFqT2qYSFzcJVRWLjqXSDLL?=
 =?us-ascii?Q?oegmeWWqSrhfw+ZB84IG/ZGijPT35dIBAWfD0lfMQtMz9lQ9mo1t7AUk4wwm?=
 =?us-ascii?Q?oZe0GmDi2s3NTB+43VDJZpmEneQ9HIYfmNg23EGcU+pIxYJnlCEh2VZKLDVN?=
 =?us-ascii?Q?YUIWPhhQehHthkqUcJl6ddKv/yinPoHa4iNSojxLhQvD2F9aGdE7bc+5b0Mt?=
 =?us-ascii?Q?5F7G9qU3n0UIpugG2Ug10Lak2OlaEeWGmop85Ji25ayGtSUod7O7rR5Ci3Os?=
 =?us-ascii?Q?WdmgqVim4w4FIDAEnfPM2pLfPdNIxC94yWCZk4XXm8C+ll+bUqiMNM1HnsU9?=
 =?us-ascii?Q?CQVv++4alpqMbMBQIBSEpDX6TAy966HLaeithrvEgtxuQgO2iTltcFf4dWMb?=
 =?us-ascii?Q?9FyARcOEp7MIRSUyH3x1svVfTsnZcBPwzOZUSRxk1/Sc64uDFpSvQOXiwNSj?=
 =?us-ascii?Q?QTXRBc6NXXIvwg9Vu9MNTnk7C9s17SVFzD+ggsMvKdH1XSnkMpctdY3YqT9t?=
 =?us-ascii?Q?ZJ/VYObdciX00QU9YPATRhEgdX2cLpSpQ25mpUCaYXRii+DwXQygne0dpkH2?=
 =?us-ascii?Q?1znTZz4BSI+M88g3G4fTQkiMvJQYrjjFolwnifLAeIcSmm6HICnOaupHrDuO?=
 =?us-ascii?Q?PkjuxNT9wcbGDHoCVSzMe0qC71g0caGRXMaZ/rq6HonC1H/MP+BUwT8H/G9G?=
 =?us-ascii?Q?XM5vxO7+JqhbzK9/mN4BRlo1E+Gow/OKzllgUUkU74VylHli3AVBFLbvQ43D?=
 =?us-ascii?Q?PNRgg5H5txH35ile14KwrjtzJAOL0mNAh2xSWHm6YAMU5hI9Dub9SwkwUSiU?=
 =?us-ascii?Q?4u078o3PRdhkiUnAsuaQMCTMaQHN43HbskyHq38qoMECRJ0SZL6K3Mi8IxFX?=
 =?us-ascii?Q?/RCwhsM6CV43ggDU1vnpoplYdswIm4oLt4LqI943/+kSvYSuTGEzEkTBSKD7?=
 =?us-ascii?Q?NGnqomdb6NCeLlFuaHtDeoTUzXMu55e0LSCrThSceFQ5LlZ8Ml4P5Ilycopd?=
 =?us-ascii?Q?V0jRtXF9AaK/2y78KSmDYhvYdYALlwkb0Ubrvd6zftX5y+49JpYCZ4a0aqKk?=
 =?us-ascii?Q?PFg8Y8NZjG0J/dJapRVallfLbvCU6NcyMvjdza08bRxpxS3TIb0MADSmDq9z?=
 =?us-ascii?Q?kj8hmw/gRzloPu2t0/pDgW+ghS4IV0c8vNpnmrWrXEbsVQGPkGhx7vEJHRZv?=
 =?us-ascii?Q?fwiZpFK7/hmyi+6518oiOGsmRbn4TfNvlpXGl13JvYSCjG5CEPJHHOmwr7hX?=
 =?us-ascii?Q?Ghqi4ViF/ptcceZViehUuR+pQ1YRR1BIIOY0bCNaswltZd/VdGmvYbPkNzXJ?=
 =?us-ascii?Q?f0UloVL526zhdeWJigaPt0f9Q+11q1JEDyLfQXe/FAXnzfY1d15Cc/G4NRej?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CDu5j9vu47gDDfjnW6/fgUcq9qxco5CjO1NNtUB4C2VkCjrv15GFI39wx0/NtZwE9laQtmspyUkW910jhcFwQa8kmJYY9a+81otdzwv12Gm9XLd0ZYu3SHmFJmPtR87BiYERBNPU0wqCWbEaNTN0Aruqft1uz7j1zn75UQ+wfhLYNZeuMoD3Srwkw2LpQbBbDJD3rMCM/avNbtE8w7GfxWrk8Uf3jQgYvQcm5DnmVoP896wkyTxW/6pg2kDGNKivk605BhD/Uz7mXoaar4kPr7MjVbopCYUwr/61gdazusnxrMuWUisnKtAJJylOtuxQ5I6v7QbHjWCXRIU8LnWYo6npUC6AHdV7fPv7nRQ6J2dJlJichegB1sb+rZeGwDhMs5euDx3sEKuK50EFhs/3haO7T6FtyobveDCcmdtmNwn2wgAzWlGU/qTkx1XBaakxDLrX23FBPHK0hNcfk8t+RE+wSSUMBMUX53+Nz8yneOQ8fs0nWZG1TOfTnVl+MRupqTtT349FqI02bWGLu1L5So6E9/tl7MGEuSWo0LIoE2T7Hg47yalKKIlZF5T1a3yDRKLdKQL8jRCBTbxJ7ufxopttKdTFEt3VhnD+nTX/kBo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3ddb56-2cae-4e30-ec59-08dbfb02d17e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 11:09:32.7653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGzIHM0PWHbaArDkCyZxoUQ4U5eAFAepYe42Z6vLFyDWT554RKcdcsWC4aaF7MvsK797vFsybgfXMYiwswIkcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_04,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312120089
X-Proofpoint-GUID: c4Pv2dGC33CHDAUH2eyQv6pkhjEXNLM5
X-Proofpoint-ORIG-GUID: c4Pv2dGC33CHDAUH2eyQv6pkhjEXNLM5

Add function sd_setup_atomic_cmnd() to setup an WRITE_ATOMIC_16
CDB for when REQ_ATOMIC flag is set for the request.

Also add trace info.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_trace.c   | 22 ++++++++++++++++++++++
 drivers/scsi/sd.c           | 24 ++++++++++++++++++++++++
 include/scsi/scsi_proto.h   |  1 +
 include/trace/events/scsi.h |  1 +
 4 files changed, 48 insertions(+)

diff --git a/drivers/scsi/scsi_trace.c b/drivers/scsi/scsi_trace.c
index 41a950075913..3e47c4472a80 100644
--- a/drivers/scsi/scsi_trace.c
+++ b/drivers/scsi/scsi_trace.c
@@ -325,6 +325,26 @@ scsi_trace_zbc_out(struct trace_seq *p, unsigned char *cdb, int len)
 	return ret;
 }
 
+static const char *
+scsi_trace_atomic_write16_out(struct trace_seq *p, unsigned char *cdb, int len)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	unsigned int boundary_size;
+	unsigned int nr_blocks;
+	sector_t lba;
+
+	lba = get_unaligned_be64(&cdb[2]);
+	boundary_size = get_unaligned_be16(&cdb[10]);
+	nr_blocks = get_unaligned_be16(&cdb[12]);
+
+	trace_seq_printf(p, "lba=%llu txlen=%u boundary_size=%u",
+			  lba, nr_blocks, boundary_size);
+
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
 static const char *
 scsi_trace_varlen(struct trace_seq *p, unsigned char *cdb, int len)
 {
@@ -385,6 +405,8 @@ scsi_trace_parse_cdb(struct trace_seq *p, unsigned char *cdb, int len)
 		return scsi_trace_zbc_in(p, cdb, len);
 	case ZBC_OUT:
 		return scsi_trace_zbc_out(p, cdb, len);
+	case WRITE_ATOMIC_16:
+		return scsi_trace_atomic_write16_out(p, cdb, len);
 	default:
 		return scsi_trace_misc(p, cdb, len);
 	}
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index fa857a08341f..10942e322253 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1240,6 +1240,26 @@ static int sd_cdl_dld(struct scsi_disk *sdkp, struct scsi_cmnd *scmd)
 	return (hint - IOPRIO_HINT_DEV_DURATION_LIMIT_1) + 1;
 }
 
+static blk_status_t sd_setup_atomic_cmnd(struct scsi_cmnd *cmd,
+					sector_t lba, unsigned int nr_blocks,
+					bool boundary, unsigned char flags)
+{
+	cmd->cmd_len  = 16;
+	cmd->cmnd[0]  = WRITE_ATOMIC_16;
+	cmd->cmnd[1]  = flags;
+	put_unaligned_be64(lba, &cmd->cmnd[2]);
+	put_unaligned_be16(nr_blocks, &cmd->cmnd[12]);
+	if (boundary)
+		put_unaligned_be16(nr_blocks, &cmd->cmnd[10]);
+	else
+		put_unaligned_be16(0, &cmd->cmnd[10]);
+	put_unaligned_be16(nr_blocks, &cmd->cmnd[12]);
+	cmd->cmnd[14] = 0;
+	cmd->cmnd[15] = 0;
+
+	return BLK_STS_OK;
+}
+
 static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
 {
 	struct request *rq = scsi_cmd_to_rq(cmd);
@@ -1311,6 +1331,10 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *cmd)
 	if (protect && sdkp->protection_type == T10_PI_TYPE2_PROTECTION) {
 		ret = sd_setup_rw32_cmnd(cmd, write, lba, nr_blocks,
 					 protect | fua, dld);
+	} else if (rq->cmd_flags & REQ_ATOMIC && write) {
+		ret = sd_setup_atomic_cmnd(cmd, lba, nr_blocks,
+				sdkp->use_atomic_write_boundary,
+				protect | fua);
 	} else if (sdp->use_16_for_rw || (nr_blocks > 0xffff)) {
 		ret = sd_setup_rw16_cmnd(cmd, write, lba, nr_blocks,
 					 protect | fua, dld);
diff --git a/include/scsi/scsi_proto.h b/include/scsi/scsi_proto.h
index 07d65c1f59db..833de67305b5 100644
--- a/include/scsi/scsi_proto.h
+++ b/include/scsi/scsi_proto.h
@@ -119,6 +119,7 @@
 #define WRITE_SAME_16	      0x93
 #define ZBC_OUT		      0x94
 #define ZBC_IN		      0x95
+#define WRITE_ATOMIC_16	0x9c
 #define SERVICE_ACTION_BIDIRECTIONAL 0x9d
 #define SERVICE_ACTION_IN_16  0x9e
 #define SERVICE_ACTION_OUT_16 0x9f
diff --git a/include/trace/events/scsi.h b/include/trace/events/scsi.h
index 8e2d9b1b0e77..05f1945ed204 100644
--- a/include/trace/events/scsi.h
+++ b/include/trace/events/scsi.h
@@ -102,6 +102,7 @@
 		scsi_opcode_name(WRITE_32),			\
 		scsi_opcode_name(WRITE_SAME_32),		\
 		scsi_opcode_name(ATA_16),			\
+		scsi_opcode_name(WRITE_ATOMIC_16),		\
 		scsi_opcode_name(ATA_12))
 
 #define scsi_hostbyte_name(result)	{ result, #result }
-- 
2.35.3


