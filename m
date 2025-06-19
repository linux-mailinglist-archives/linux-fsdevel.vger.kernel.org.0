Return-Path: <linux-fsdevel+bounces-52245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFE6AE0ACC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 17:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BC0E3AEFC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 15:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9EE28640E;
	Thu, 19 Jun 2025 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YGPjlVN6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V5uHHBjx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD93F26C39D;
	Thu, 19 Jun 2025 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750347912; cv=fail; b=Gt1YgQvrXrOhu0ENO+XLqeGrfuch4HtPMmXXJgdThgmT3jyuEUQjZb/LoLx4eBOtoD11CYlhs7KVxMw/xqdbVCrrOZviRNVsZkKiQGw64AuD8HIvMtFHwSUqL34cejtYErunFw8zlaUfAEso27tg9ogcVKhjbEsvrh5YsfJWTMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750347912; c=relaxed/simple;
	bh=Fy1CNdgdqTsojzlnyRbOJkfwNc+PuGNVjwxnDBbBaiw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IsoeGtijO+PGgt8gj5S/JblpY3RFYx/z9RGBnoFNjsBB1XEjLaXUDO+iljqFJn3eLNlSymierpgveM8Ws8r5qvJV0ANjcQgieh7KryNEtVCj6/W2PQMhluMOj8QXtmRT5ik67BX9DN4rl2ZKcz59+5KV/vh8Hb8eQ6Bn/5xTlJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YGPjlVN6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V5uHHBjx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JEMZPG025805;
	Thu, 19 Jun 2025 15:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=n9kGsMpUz3hyn++l
	IqViIx2e/85BRmW0fRPDtRTTKQY=; b=YGPjlVN6GdKO++ev7VVGSTA4lJ8plE9i
	dp0q331P9gk9tqE2uz3SA4J6EBBWRXKeWBDgjRrNVsYlEQzoQGK8xCoteVKwtvVv
	Sz0N7oA4ra4DvAklsOkINQedu1csJBVRZo5nIdBmIk6dMdbUllsI/7k85IaM4JLI
	/bqeQO9l1IvYoHWRMQ4fO9RdcueB/9cGGou5bwqpifMd3butWtJnUA2r08WGGbSU
	+YnPQ2tnM1bWWMlB+M1hQnvQmqL15Q9jhynN3+2TA2EHpGIgUq1WTvagfNVLoSvg
	TcxLkfGrdsLilOFrr+2XRAf2fXeJf0CLBOURvWrJwYtjBkhKngy3lQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 478yv5a35j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Jun 2025 15:45:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55JFXS4a037485;
	Thu, 19 Jun 2025 15:45:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yhbsm2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Jun 2025 15:45:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ei4utVJjVZ1xGQ8urNlL8zK1Xh7xrKS/HLewXW6VUlp9gpw03nzm3eKvgaWAcglh16UonaXD7635TxxeX55CCj5fSE40xULm0ApZhCX23dvFO3aPnySUXmlRl4b6yeovWY7ZF6HGKUyuRp19LoJ2V96WyNSpmzQQ/i7o0Ch9Zy2qF5MmjGkm/uFxe77iMUW+XN3rhO+bIm5cICoZa0rbauZPK2usYBydDWOftsby9t7l5lJIsOBpNgKSLa7vvGo8IRaCP6I+WPN9ZklbgpjKtur+oPnu2qSNmuKupDmBXXKQd02viERuQcFUUk2y3T8xdQ+n8CTR0diuSfXJlSWJ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9kGsMpUz3hyn++lIqViIx2e/85BRmW0fRPDtRTTKQY=;
 b=VBh5Rav28HiDMSb4YGdO6K1+lCdKoyv7NHrxcvCivd6u+WSzdJc9sFvo4ActiMQ68ymfLoEXByVlnpg00UmlugtJh5iQcrqpqDQPicz/wCAE2KY/NBzhHgSwTkyDVRpn0X0m0w6wShkriOEW8Yr3Au6sCJE7g11CVkzgCjuJkMAu+g0wwj2qh2Vab7wquuoORAItS6Az6tsH9WRZJpw3HyPIdiVNKeul6xzvMnbMdIn34uU3dRk1li/M45ZuWCVeSGunutsF1IES5cKSO4aWqWYKvui7aXk6RcWBCNzebozI6zJ2oxx+9XqLd8SZ2P0ld6K+ZleYHYfcIdaC6zdwbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9kGsMpUz3hyn++lIqViIx2e/85BRmW0fRPDtRTTKQY=;
 b=V5uHHBjxv32bNEIHcv3V2snrLwP+2kdVIWrXGgU7y/f46hBAvmYfZYEPlFH+1c4wpJD09T6CwucOOAqVADEhOoQVXjSpL8HhGuNTEf9OQ5REg9oIB82LH5DdD3+sTG91xatP8QZesWYTnqV5bMy+V3efbYfs3Px1QZIkNQsbirI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CYYPR10MB7651.namprd10.prod.outlook.com (2603:10b6:930:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Thu, 19 Jun
 2025 15:44:59 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8857.019; Thu, 19 Jun 2025
 15:44:59 +0000
From: John Garry <john.g.garry@oracle.com>
To: alx@kernel.org
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
        djwong@kernel.org, linux-xfs@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 0/2] statx.2: Add stx_atomic_write_unit_max_opt
Date: Thu, 19 Jun 2025 15:44:53 +0000
Message-Id: <20250619154455.321848-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::30) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CYYPR10MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: b0facc64-1b8e-4e43-6f20-08ddaf483f8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ULBlXbZhq2cfM538CF4mc53+zXIMLfftw2oV4dS7GpGprg72jvIiwYwpkKld?=
 =?us-ascii?Q?gd7DynfoTsDgWWamxD1W15fBmlilgjOObIQaOLFln+WwbcBJh44P8C+D/1f+?=
 =?us-ascii?Q?mdm0Y5/ligjPXR31bfrMARd5GxMZ2YLXmiPjmYj8M3uyABYzBlaxHXRvfaa4?=
 =?us-ascii?Q?TmZewZpiHs9wF3SLM4pbmd9YlARmg1b1F31pgWNwMaA/QnIkrGDfl3Ie6Wy/?=
 =?us-ascii?Q?D+1q0VmJ5ONSwEFrKlcgVwj9VE/CyNHrN3dcw082siU2AAlefZm7dMV6LhrR?=
 =?us-ascii?Q?CExmhU8eSjyIul3l5iNh8hRp+EI/3V4P9g++NYmDUypSCdbqnEA8P9CJPR+E?=
 =?us-ascii?Q?p7qJh228/IEr3xENZilNDqsX8oJU55uocBGoFfP+cH7fWndW0q5hIF8oJClo?=
 =?us-ascii?Q?k9TZB/GoAxadHzDs4IYGN2b+ykVqYQv+1U0XV8h2YbjaX4rxKYY84m7jzy/E?=
 =?us-ascii?Q?n706YMt2fBPYw6vo9GlYciTbbp83rAdNc+LD86oW27QQtu1MnTT/YohL3B5w?=
 =?us-ascii?Q?FNTGaz8d6u/YOmJ1xlL2VN4e+6CPN/CjUlTsC4soOAcPQDtbK8X0IgYanl7N?=
 =?us-ascii?Q?KKSeLCr8kvIv3//VfTQTqm5U1QoVnPkelBZnmhJHnFtxwrn2TnL0CBlDrjPT?=
 =?us-ascii?Q?YTRIs6ho9Z+BWJcBUn2LFKoRRfJpWv6PZA/nFfcO3VewogkYgs+spXIx63gP?=
 =?us-ascii?Q?R88cR4o/AEju9qSHbQKhnsTbuttAt7nRKVOuUs/iV5qNJSaXooe5Q3vCyfsN?=
 =?us-ascii?Q?fIi+BqdlZlR7Y1MrPg5hWaqzL+IV3yiE1vvTPln29ThzVKf7ajLCLA5HX3Sk?=
 =?us-ascii?Q?tJoXeWLPC9tTytr9AHIv6GzNj46kFK+SNjmZ77Ncp4QjC/9g0Yn4Xg0bR1ic?=
 =?us-ascii?Q?tviWCpjKCMGw1MnNetsMAjJWtel74WbcAqIOniWwtWaCv4MA8AyVoK6ZdL7S?=
 =?us-ascii?Q?MQmt4W4OPs2qU0C+o5jvLZrPsk75+EOmGp8CxqbMrvgXkAeA/tUMmLyN5VkZ?=
 =?us-ascii?Q?/1pNS6GfOmu4U/R+HYohAk2N0hhH/9AVy5wvd3fKXpt+iwokefuVvjVjK1m3?=
 =?us-ascii?Q?glLGVmOrCfrdUAnKfHDVCsEA/IwEp2knax+Ltgft/vhRp4cLqGmAs0A+wKhJ?=
 =?us-ascii?Q?W03ysQF6d8rvSYTiRv6DnFW5O3AyQVXeatBNcrauDkQWNp3+NPgW8KQPd4uz?=
 =?us-ascii?Q?QceaDF9HoBygj96J4MDs8MtLzGDnkdAhTjpS/Le9yowwv2BqHTXgzaLPSWpF?=
 =?us-ascii?Q?KCtV5FtcvFtUajVXnDHJ5fzSTpKso0m2onSQy3f0sKYwIsmMlu1Lda4/ZiOV?=
 =?us-ascii?Q?izfl7B4aqeao7rBEzdmR6wHGObAQLWdL+fCaM1G/F7KAnL9seqdOtkwVnAj9?=
 =?us-ascii?Q?8NtoLhLdP2GrdNG3ZDMo57j6taKDm3zuHG3JTMAtH1/GYsE5QnpUG7svS48z?=
 =?us-ascii?Q?95x34bPe2RU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IkHW7iqijn0gqd0XQHN5tr89UesB0Cfd6VCr6KKlCIQtjp2KX/9KOxifrmOL?=
 =?us-ascii?Q?7OGGYbpAuZU1wATBaSZ9eCnw3lRxnQLqHCKNRAYtaqrDtD3PVEsavBNNKaTL?=
 =?us-ascii?Q?KWhB/rIN/UI1h3B62dBUOO0owg4Zg5m2XGEMRVs27N/KOILatWVOFUCNerD4?=
 =?us-ascii?Q?qqiZaRoAfsFFL5WA9XjSD2vuZ4KnKBmSaZSRh6cy2UMToQbIFUCAzCN9W8ro?=
 =?us-ascii?Q?UWgH2brHrSHQoEgUwjHRxMDcrIViO6osOa58dI/0G5xLrVCLUdCxDzIHb0wZ?=
 =?us-ascii?Q?LpEI+Rew8rleEBAhVxOsMfu2dDtU7WHqPZTG9ile9sW/7Gt3i2dgofo6PTwb?=
 =?us-ascii?Q?YtJEjKsDJCfT6Fwp+Uaf6nrgn1x5EcK0apbPSPRVcGzy0JdzNKBuTFM2DF0i?=
 =?us-ascii?Q?dhidP8romnh6/ELh1p7dPIgsvv5hAEI89HaeOnLoRnV6EeV21PdxpoYZLYXZ?=
 =?us-ascii?Q?3fNm7YzRsOrFtqrIVfmdtvE2cPN9pQIJrB+cXm7RJATmhK+F/Q7iCvjUUhaI?=
 =?us-ascii?Q?OkVXfxzUzbk23ISetfejLUDejwW9S+ZY5jxPORSXF3bpxdsnS1CfvqYH95jG?=
 =?us-ascii?Q?LPJFJuMPfrmxULGFDiSGxPbEmXqpMcavtbpwGxWz1pxvjIqWoLk/wtwKN2TP?=
 =?us-ascii?Q?GBW0XEAtqGvmcfdUfg0ZRDqQTLy5ESTTgVXV4XOMtDCGmzd/76Atss9nTWAM?=
 =?us-ascii?Q?kolRMphbWa77hoCPmZlMjrQbocnwBQuclWEWO3reEjgvxbTqltJni7WIkiP/?=
 =?us-ascii?Q?3WiSigbChQlLFs9nS8SH5zipIL4ls6FAzxykav3/WI1t4v1haYGBe7jsVHqd?=
 =?us-ascii?Q?shGvsXqwwAETC7y6hou6mrnmI3vAflSb4engd6RZw6Cc5EmeXfjs+HAtZqLL?=
 =?us-ascii?Q?6HqWpIhO3K67teVH7328mXSexDmjJfQ1nQ0zOzQe6koEsVLUuW4Eb5xLgN+W?=
 =?us-ascii?Q?BInTD8MOl+NntvDVNdpzRe5hzpuKpmxgaLIL3j+MU96myqjH8BVOBcx+qGjx?=
 =?us-ascii?Q?0YgxuwAgkW+vWtjyPbuxL6J4uUF6PY+ofOQx8TSkOm/3+oDcaCMnUPvZYgXi?=
 =?us-ascii?Q?bxt+s72hXlpAvEl6IB4PoFiEFGlD5fi3bkKtCHjxbx+eXX6m9smR0p3L5DEM?=
 =?us-ascii?Q?IOBIm++8QVYWfFWjlpVnYpy/rpMiRJXWh2/1dfH0pz3wAq6ye/Lb61mGNj8h?=
 =?us-ascii?Q?iB4qfOPr41UpmdtevSztgTaYlGJy1bA3LBXyXHzLIoX+2vTIOLHjL6sTdjI2?=
 =?us-ascii?Q?UggZHkliH2rk3CCBPfCPih1sxrQ8q9WfmgadALXR6HreZ1hvx+C21FOq7AEG?=
 =?us-ascii?Q?5BLpCOFLyNmXTohLlsfwK6EQ15JpFC2cT5pFOMqvfjJ95lFLlKEvQDSN5fYH?=
 =?us-ascii?Q?dTpyV8Q1ToU3htf4pB9y2voU1KKYpdke+c5q1DW+CX0zi/VBPQ0pDN3TO4Pm?=
 =?us-ascii?Q?isoBTQYkIic1f96FAiax3KNbCovOnG7tqjrkvE2Pkt1Owg3Z4h8WWsUDgU7S?=
 =?us-ascii?Q?zGw2a8MW6Y4awHURPqFDVx6LNHEV7pGLM+46w9NKFXGJ6utumaCSY55uswNC?=
 =?us-ascii?Q?ymlWFcIXjYA5KoUGW1LoPE/85m4Oq+vjwwa0xUQoDm9cWdBjT8lOQU+wsddH?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a5yjTyhRII4szXLVKXGnhc62l68GK83LWVo1OSWDx8EHkw9reQXFCI/zdgMoyikd7xKjKguMvF8XUyh6b+tJWCUnmlJOA3UnppXvhWlf9VhQ/O9gGpr0p/BGdWN30NSNJoK5jwNVTeEd8zLZEuxQ3ZpyuLYUAOEPvGhWRaSV5aQRy7imICPg/rZ1Cyh597uZVpGZBFvY2JSrOGAm9Iqb4S8C5+mO1S/yaisCbRUVQPGS+q1WU4y4NN0vd521paPDoLsfG9QDvzS1yq3021uSO4ekYjL4gEZKuHZq2i6bu77n8Vh5rifyaF8cL2r7I1tW3JTfbqKt656wIAy+5tMYd3WlsXZ9ynbw+dbBUKcdBOjaZo75IFvt64YW+5uF3mc6wOB5BXfj83JaQ1J7p+5pB5OjZ2HPxhcvYlffgM/OAL78rJ8yzoGptOPKdDrXUNePk5/UhVQ2oyLRijOhTCmn447bo0M2X9E8WSAP5TkaXF439bJVLfIpqx/svVv7/3FLW79K2ZY0qcrv1BlYoz8dp46/KV+6gnrUQ09/vyZLRHxcnRYTMuC2P2tF+P8Ix8E4k+XHnncC3RDvliOTjSwldGN8lo80cWe6aqXU4L1z+iY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0facc64-1b8e-4e43-6f20-08ddaf483f8b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 15:44:59.6241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2p9FEYcRWtEWG5DSt/55WdcE3X3GfWuJ+h5+oPtyEZBhBB4NJoS/lmrHheCUmfEDfkp5kC5ANqsO5Dg1LQ255A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7651
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_06,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxlogscore=877 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506190130
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDEzMCBTYWx0ZWRfXwZgHbIzS2nAX veVmqtk0Dft8mVARGOpae7Bt9ccBKV8SAH7l+m5W6VHL9cGDVttboAw0A5La11ek5k1U5kcRMUs BIQkzwv5QpemJLkCdJ2h+NofFE5bwckvx/1lFdgKipYop3T9H0OTlc5VrA8aN6ygUa3rguzxYvV
 hyyGScArZEWzI0PFiNR725TgQE2M9Ma0ABUGQ7Hdm/mbTMEVsGdTFk7WuSJjO9osSKiCwNkqdmI 5GS3RG30PEANEe89e5q0Xa4bMG+SSWM4lyLjBGsK6KEUvEnvjlAu9fybZTVij9JPj7krTsv+9UC TLvW7sbmDfRHkD2A2PopytVeNl3gMc53YrniSGxCU9FKZkey+boEpEMC/5t6iPgFuqQEPIttNvR
 yxBbu6nvNScaoQThZUcYrYNkFn1KplponL4L/+fTyGs4ls0lDoqJK1M34Dvav1/+MUtxzwBN
X-Proofpoint-GUID: qVOsX2GQVT6syA7bVV0HLsx_YNuUgMal
X-Proofpoint-ORIG-GUID: qVOsX2GQVT6syA7bVV0HLsx_YNuUgMal
X-Authority-Analysis: v=2.4 cv=W9c4VQWk c=1 sm=1 tr=0 ts=6854307e cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=V2WN1QJisCgZDHqT8xcA:9

This adds the man page update for stx_atomic_write_unit_max_opt.

Differences to v2:
- properly align stx_dio_read_offset_align
- update formatting according to Alex's recommendations

John Garry (2):
  statx.2: properly align stx_dio_read_offset_align
  statx.2: Add stx_atomic_write_unit_max_opt

 man/man2/statx.2 | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

-- 
2.31.1


