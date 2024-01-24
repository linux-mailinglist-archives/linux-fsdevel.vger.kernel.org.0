Return-Path: <linux-fsdevel+bounces-8713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA6683A855
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBB13B2655C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 11:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AC03D98E;
	Wed, 24 Jan 2024 11:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bawOqIOh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bZSknn0X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4CA2BAFD;
	Wed, 24 Jan 2024 11:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096442; cv=fail; b=MYePiMpvj5esb2JzJWs2Z7S9FnI6KqQih7Gt/nheofTqsGi6s2k5wBHZ5Hv2e49JEO3HCGxMrUYkwsRg9zlbA7IpnVGistvNV7x4lOzE6E0ZO+oVPdCkLxAGMtN5ORQy+YfmazoAHBdRt9pHrmwqGZvm6XLE9SNovKr0LzutifE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096442; c=relaxed/simple;
	bh=3GLYaWDYgxMRH73Ly+HFyKmB2dMMK1LpckPZcxTvXMM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AUxXT9hs4P6DKtIHmaX+Vf7jYN4NCz2ndNHSbLzVMG/zsdSb1TGmI8Gq29K89RlwsKXRuPcxYGF3yV/Jd5t/OtIPA7KRIjWGfysBNwjco6I9h9U9OyQIN7hU+0DeO9U5M8xYSkLyr+oRI4etg4XK+LpkLVcwE5az6klt7xaQUBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bawOqIOh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bZSknn0X; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OAwqd2026956;
	Wed, 24 Jan 2024 11:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=xTPClu86JNnbDW7HnfFZHiSLGjkTFPlzvhGdFqllUtE=;
 b=bawOqIOh/HpQt2AkfbWlEadVVVCjzBmO07OQVmD7DEvmCdc0S9hUNwz3vBVptfP7Dz73
 x9XDwahSoMOo9NM5H9gU7nR8BKJM7huKNDmAMadjdbiGiuM5Dm51G4uGCF/9u1+ohMTc
 mlsomehol09PV6Uo6j2sFCcioWuvEY8yt3GriH6FUKAl6BtIiGUL0ibUR+9PT4HPXrNH
 5JuE1Jb8nEtN9089XvehoN1mjSt/RjWdiyMzSdjFUvSVsbbMn1LS1QLGZ8MkkXyL4l0o
 QvqKF7WS8999tF6XWydVcI/VLVoS4a/3LbXR1zOoragrbdv1aE/tkPq8NYGXBMQwIKsP sA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cwj1qq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:39:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OBOr75040836;
	Wed, 24 Jan 2024 11:39:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs316wnqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:39:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P41yK97dCv1R1eg7SYbedIMYSpxz/YxWpdOIamcqLGcWi1S0/qVIHkd1ps0wDUujxP6Ov+i+haXzgpX0QC2//GfDccCNKJIxZ96gQMgHK/XauBzeyjzztOjZMOopE5JnmYDPNio87pmy+3exf9M3fcfDM7ejvp3w7o3Ju4KwxK4rhMgsT3bRoyv+SP6GLoRWVmjfRF17UCeyQz4dUrb3uJ0K4/mOcrn2rLUKqdXN0mNGI3gstgkquYxZaLSdf/duNid8UeTnEVKPEKAKk2XHdpbASo9QRHQBP1dnHAGnaTBjizV4Ib72U3FIyKXNaM+4y5+1NMoY6Py2wgh1SfrDkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTPClu86JNnbDW7HnfFZHiSLGjkTFPlzvhGdFqllUtE=;
 b=nNC4nWgON5aiF/Rauxd3/MgUTeNWuLRviA3M3ONPLIry5C1T1Zgfimuw2pWdzepvCAOAU6qC2UvYoitZTrzrbUcMERfY0HvyUZF8QMsPaKsUTKBxtWmF+Tq+YL25y7bvV/YSFOflTXtVKZfg2KR2ZtjSd7aRhCRrDtNvWpIjfiPqRuHgm9505kVWIjHVg+/qv0DsMLMkBy35bZ88TjzODCUSaNZPa4WmMTQScZLBIkNByzTvLjqJEg1cSdVaABqJhmUtETcFQqu/HJ8F/oOrGKQsAMHhbP6leY+1iPiGuHE1avn7oN9xMzQEWfPWeHDbC161R/GPOEXBSbYTH5gNNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTPClu86JNnbDW7HnfFZHiSLGjkTFPlzvhGdFqllUtE=;
 b=bZSknn0Xww2aKmfa7I60qcPh4GslHtXVEnDklDNfACSQ+X2L2TpyzbKa38Bzd8zMQ57ENOWmUTMFoSqbLvrkAek4PC/JVVd28yuXKG1nnAdEpYMcajHe1EM6yb52t5534sjbhP+JOKDuYzU5YS+B7hAdjRRnnXKrRGMhi8L4HdQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA3PR10MB7041.namprd10.prod.outlook.com (2603:10b6:806:320::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 11:39:08 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 11:39:08 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 00/15] block atomic writes
Date: Wed, 24 Jan 2024 11:38:26 +0000
Message-Id: <20240124113841.31824-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0160.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA3PR10MB7041:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f7cdc9-fb51-4a90-3c04-08dc1cd11393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ktXFwr3Nj0fAa0FWb0rM0PNqusFFQ/RNkeTuO749qa/bOOiyBsDyBP9SVidO1e/AZb8WI1HNTxFXb28Z1WKUlkg8u6mNhrrp+z/3CzO46DZBcG60h1/8T9Z2z+ze0Eeb9rAQwRuz5h3qRRRI8TZl69kZra4W/6jKZ2r0zUh4HhTtS5yP983wRxjbINaIBGV3BaxuztytNXjqKh9XZpDv+RZgPC+IqUry5mbgWWOiLDs2M+YEIIFmC47X+ACv2GX6DQySg1/VcWjvxqsoD4JjvbjacRKs13it2tnsU42phaLeykRiUmrnd6oQ+iCsEt+tUAHveCuEZ/ooeFUDseP9v9+e9V5fQpuj3o7vA7QA+ECr1GyzGcyFU+Mkq4LpuEIAgmiAtVI4/0+hPSJMXW7Lrs1UK14ezv0VwO4efuSfcdDeliJZWKtWi7fiL1hw7XWJxaHC1+n42l9qqLv7EB7VsBZ5X2KAK/SYw6gNlnjnUuv3YYBUftZppA0mXjruOQYomtwd9d14netYXCSI1dCSnMxPLdJc0/qDHpnAlMYk7wQMI/UOG7LBJXLNGpFy/tWwnlRhIFVilUtl/YVzSQ6KVTAqgjez7S0OUIikVVoB4Ic=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(366004)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(4326008)(8676002)(8936002)(66946007)(66556008)(316002)(66476007)(921011)(2906002)(103116003)(36756003)(5660300002)(41300700001)(86362001)(7416002)(38100700002)(6506007)(6512007)(6666004)(83380400001)(966005)(26005)(478600001)(6486002)(2616005)(107886003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6j9KfUbzgjw1+ji6Id24XttZC1A+YlIGpRWQnwGWmHnXE9NYm+tlbh+ro5zH?=
 =?us-ascii?Q?qPIrEfx5grw6n3B9yMd/nYgcNR2WV689iod4s5VIo/Aa2i5RZcBJIn/L6rMU?=
 =?us-ascii?Q?zE3ZM+A7QvdEcdHhosdiiJCsoOwDKBBhQi2SX2UXC4LRLt7HLiiiw0Hg8XlG?=
 =?us-ascii?Q?Yv7m+C3li9x+57zS+K/DocHzAoSp3J2RAJftad+e6GdqHFHoumdgb6zveVni?=
 =?us-ascii?Q?V5yXnfzMh6g1mm6bwJjCLhqVppmWX8KDWa1k3rX9ZEHGE7I2a3HHk0CJx6Rc?=
 =?us-ascii?Q?5W3nxc5gX50rLJ5OUeLdadnhU0Xrm9Vs7m0hPoRLWskzzSUgUOu97VaSBKWC?=
 =?us-ascii?Q?ioUF1XwveKj1U2P4+BiZ6p7AAAnN1AgGZay4sWesVimMNW6sinysJzRmASm6?=
 =?us-ascii?Q?cyxxtSoo9YlFX4FbGRm3Ilf16c7CI4RGo04M3kN9OVy4I29vechyAmG2Cn2w?=
 =?us-ascii?Q?MwxOZYtDZ0nWdCxPokJgj2RDaj8ZTR6WMXjUMt/cRa3kIt8GzzUP6hQF7Vli?=
 =?us-ascii?Q?VC3G9byupTVFTzG3wzZC5n2rOidr/XVUWFtXQ3TsuTWtvAarJpv/jVZkZDAz?=
 =?us-ascii?Q?Xn9dla1rIRKHunjCvUMkmpeXtnpOpUCvd3pAJY8i9n+zY2NEfHpnkALjEV8z?=
 =?us-ascii?Q?wo9cmSBmHz7QYwb04tU6p0LC08LqHQvtma+4+UQ9Q5pGrv5/HwLSFDV9/38L?=
 =?us-ascii?Q?1psHgH89ZpzOVb8vGCIymc2EKsUqDVflJZzHsiHCD6T02mIJuHAkscFqtKnA?=
 =?us-ascii?Q?8i7AeVj5PO3ozIqtT+A2L/vOycQt2/UlpDn9yAFqC7ysq8ZvvU8DGZyRvHaN?=
 =?us-ascii?Q?buiWRYmKjQlSyS6RPS/gj9o4YJfmfa5+VF3AfUkNFt5F9e/l3RvvWL4giR3j?=
 =?us-ascii?Q?tSBL/ozSDRqneqCNURmedah1iX/R1jhItZkv04+eAiKl9g4sfFy7PP+Vfvdq?=
 =?us-ascii?Q?OCJFMZ6q90GERvH8qIqOnnwLrnGO58D9/7wEMIhWlxn/s+Kg8OAA0Eu7eJhY?=
 =?us-ascii?Q?uRn96VDFo3QpzoVqDXwP5hRrG68QqYjqLPPxAKzehGIFAkmDlyU37/WmBDsl?=
 =?us-ascii?Q?J4vshs233XPKkr54e5lqQiCM30lCHff/fIUZ4jd30A/hD/NjiIMwdWprPVw2?=
 =?us-ascii?Q?CkBvq8GtbfzG6c1OYQFLnQWTM7G6R/v5ji41IXICrCrqYeEgJ0y5+U3J69Xu?=
 =?us-ascii?Q?SLBFR+uq5saA/BAKjYeFBHgs6p6MeF+cjKJfMikKXGgRLnbnXTRHvFOkQ395?=
 =?us-ascii?Q?LoaZruD2N2jG30qaD28fXYYC9v4S79vr8YeoaxbPFqHVbjbGdu/J/cn8HvZn?=
 =?us-ascii?Q?JyDVrJ+PVW1dNNPxl8HKhm91MD6WMpCjmyj01z20cjMq7hcDKmaGIV85YFOD?=
 =?us-ascii?Q?MWVnBLkifs3Rc8XdbQ2FWPYIB0LlzSG1aIMovnTo1Gg0Tr4xCAZd9VwgT+CK?=
 =?us-ascii?Q?F4lS4+kYKKhOoAw0aPpb2akC2cCnb2dO3lEhNZNjGky9mUnUxCc1Jr3cI3kH?=
 =?us-ascii?Q?u9JD/J/4FOykC/Qw9XfbSI4lSarCSSmU0r5AINP0iWfoccAUbl90agBQdqB5?=
 =?us-ascii?Q?dUxX4V5B9slU23tCT6rNnRLx6uCxs23Yvo3TEU2gWJf8FDPMccw8ILltayz+?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2B2u94D4PtsBuUZ89t8QWfdA0/Hu5Q3oLON0zPjqpQZhnFqh9s1vD/hLJdSkT9SasFvNppcn+EfEOyUv8sKphXyKHR7a6ZabdT3UCJ+Pftf9YptET2+M8dZxgdgMEThPC7diHVs6iyTj+nLaq2HLE9sq88EBhZQBAJYf8Z2ORSAS7dmuhtYtxC/+jxcHjaBwPeJKbYB3YcWgm7qPBRSRRDS1Ld4q4OhIg3z/zvZkrh5JOWethbqayy6grzWB0ZoQrIsxQ57kcYsOJB5SCFQmynBerPlIrQYKgy5h2jmuRtH6dBRl/ppnmWHzMN3VDthcOveMbTtYNKPY/0q2CIvq7L+svJSMr2sF43jKm2gXBm7pkeWgzfrJbEDAt+TNBVLLwCUmDdxhfk/djU85pDZRFLN1Hb7rlBPiHwn7l6zxZ/8RqwOLL1urfcx/NVq0tidMOPBpR3EbRtg1U4RhdVNI9bskuD8rIH6qoILD+ivdudU7rPrerGCAYszzoNASPpc15PSVmHbgSxYPcalx3bfepKcgnjlcuGyMJGii80enB6p4/v8nFvqn9GHXavGW2wyzx2H/5lNqPirrjZlfAme77ppXctx+wpuKCPBkV0GxTa8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f7cdc9-fb51-4a90-3c04-08dc1cd11393
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 11:39:08.2721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPc5b6XDQPgAdmBlHebBLFajdT0GZ+b+QrN34bULO2OcS6e6kXFDTqwC9dbjMaQUZObVg3ZlNeuLpzJmBOV5Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7041
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240083
X-Proofpoint-ORIG-GUID: TUZV8SOj3rZg2snQYBvB8wKJzZUpdNLs
X-Proofpoint-GUID: TUZV8SOj3rZg2snQYBvB8wKJzZUpdNLs

This series introduces a proposal to implementing atomic writes in the
kernel for torn-write protection.

This series takes the approach of adding a new "atomic" flag to each of
pwritev2() and iocb->ki_flags - RWF_ATOMIC and IOCB_ATOMIC, respectively.
When set, these indicate that we want the write issued "atomically".

Only direct IO is supported and for block devices here. For this, atomic
write HW is required, like SCSI ATOMIC WRITE (16).

I plan to send a series for supporting atomic writes for XFS later this
week, but initially only for XFS rtvol.

Updated man pages have been posted at:
https://lore.kernel.org/lkml/20240124112731.28579-1-john.g.garry@oracle.com/T/#m520dca97a9748de352b5a723d3155a4bb1e46456

The goal here is to provide an interface that allows applications use
application-specific block sizes larger than logical block size
reported by the storage device or larger than filesystem block size as
reported by stat().

With this new interface, application blocks will never be torn or
fractured when written. For a power fail, for each individual application
block, all or none of the data to be written. A racing atomic write and
read will mean that the read sees all the old data or all the new data,
but never a mix of old and new.

Three new fields are added to struct statx - atomic_write_unit_min,
atomic_write_unit_max, and atomic_write_segments_max. For each atomic
individual write, the total length of a write must be a between
atomic_write_unit_min and atomic_write_unit_max, inclusive, and a
power-of-2. The write must also be at a natural offset in the file
wrt the write length. For pwritev2, iovcnt is limited by
atomic_write_segments_max.

SCSI sd.c and scsi_debug and NVMe kernel support is added.

This series is based on v6.8-rc1.

Changes since v2:
- Support atomic_write_segments_max
- Limit atomic write paramaters to max_hw_sectors_kb
- Don't increase fmode_t
- Change value for RWF_ATOMIC
- Various tidying (including advised by Jan)

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

John Garry (9):
  block: Limit atomic writes according to bio and queue limits
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

 Documentation/ABI/stable/sysfs-block |  52 +++
 block/bdev.c                         |  37 +-
 block/blk-merge.c                    |  94 ++++-
 block/blk-mq.c                       |   2 +-
 block/blk-settings.c                 | 103 +++++
 block/blk-sysfs.c                    |  33 ++
 block/blk.h                          |   9 +-
 block/fops.c                         |  44 +-
 drivers/nvme/host/core.c             |  71 ++++
 drivers/nvme/host/nvme.h             |   2 +
 drivers/scsi/scsi_debug.c            | 589 +++++++++++++++++++++------
 drivers/scsi/scsi_trace.c            |  22 +
 drivers/scsi/sd.c                    |  93 ++++-
 drivers/scsi/sd.h                    |   8 +
 fs/stat.c                            |  47 ++-
 include/linux/blk_types.h            |   2 +
 include/linux/blkdev.h               |  45 +-
 include/linux/fs.h                   |  12 +
 include/linux/stat.h                 |   3 +
 include/scsi/scsi_proto.h            |   1 +
 include/trace/events/scsi.h          |   1 +
 include/uapi/linux/fs.h              |   5 +-
 include/uapi/linux/stat.h            |   9 +-
 23 files changed, 1123 insertions(+), 161 deletions(-)

-- 
2.31.1


