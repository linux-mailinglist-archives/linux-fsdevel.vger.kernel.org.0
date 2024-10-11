Return-Path: <linux-fsdevel+bounces-31691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DBD99A261
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 13:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 888671F27323
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 11:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BE721732D;
	Fri, 11 Oct 2024 11:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="miEzzZFw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="naBbbxdI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA09216454;
	Fri, 11 Oct 2024 11:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644790; cv=fail; b=X5xl3fi2Xx/To0+mYRYtRfXY9swfW1V0lU5fd4pia2Te0v8KYFoMgp8tkgdCS/bkc58/uwbsIfhQ1dffwYcuNYhDOCCUZFSg3ee6Ds/yhAViR5LTjA+pM8YJotJskSwMrukRMwt8AcGkhVK/6SOqn5/mAOB8aCkBAa1t2l+YmxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644790; c=relaxed/simple;
	bh=GPlOhKIanY5W96v7RGBGpX8RJziFA1dUbaLUGsBPIm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nc9sNMi3MGzdLGTB6DvWG/5r9Dr1D99WwJA+IIygUtMuvtVFfFr+jviDxY0aVdPPt1nW+65npSKWbuGdpAEZo5jE0TdEhe3x+n/7e741i3E4YFZaEJu7h9qrCsJWdmS7MTxYT9ljEaM8ajXRD3EHJcaecN0ixZSde+vN2+Am36o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=miEzzZFw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=naBbbxdI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49B8BeW1026139;
	Fri, 11 Oct 2024 11:06:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8nWoDMl5VOvjzc4SgroRs1FM4zRRVAwaOsTS/I20V4M=; b=
	miEzzZFwvV1+PH1NuWfyYyBG3VhgvAchD6E7qeRHCnBKawtTLC6qclj7w7zlM/7v
	euciQgj6IZzRJaHzZOtNsl/3G81I3x5hpo2BkPac8EM28b/hHMhdsGMBu1Fti3eK
	O4WZwFnBEkWvzZYITkhd8EEC7NXpj2cANYrkxqRpHt8wisI+Q+bOkRKMUeKPfZt8
	vDhhFiMS+9542YdSXftcfyZqxExkSfBxaiDu60wZB9pdixTGtKDypThB4L5ejvGq
	AUbQ9YuJV51Rh2bemLTs7iBERFaYaIk5RRaA7wzxMh7MybIgJue3u3J+Gt4hg2NN
	qCxvoZtBXbGngCHpHgRBew==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42306emn7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 11:06:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49B8soBg005760;
	Fri, 11 Oct 2024 11:06:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uwb70jq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 11:06:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SM9+D4jzdr2ZgQQhFMfz6MtfY5+j3CQHlbfnhkPyaWaQDHargJRzAyqCWy4G6ZflYFlSYeCrSGIt/eYeuCAIw1NDeOy/cScoI31+hILt3ykQA6Sz6K4N3w1QKid4rHwSmN4w3sOc17+KhjOGJg8PBrHv5f14xrAjYBZF148Ehl8k1jCeKNc+IBS7Ot57Ipxvh6Rf9l8rwY/guKMBFlZXLBy5F+LW39FVpnrpVOnswFt/LYrE748uGziyBbK2c5W1FGFo8nMJY434ZyichSuF8+ucgqwzunnHSoV3uqFYKvkVey/ERFmianZTZ80WsqiLW8/vZS+reP+A31aq1dTpwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nWoDMl5VOvjzc4SgroRs1FM4zRRVAwaOsTS/I20V4M=;
 b=fX3ZAqPe+RiPWXjn6M8CNN/BG0/DvB6yT3uqsn3PwN+80pG1j5Kq+GJ2y37L1Ni55ZeptXd2AZf9NXGgp+8d4AGB/NlVNInO7/BNVxbqf28xWKXqUFOKlG/V2SpNXvsEEMsQRzCmOALvrp8Qmh3Xl1UI6EbxY6BOcJ8yfM+evnPNeKnnnORfSjDmAw4k/2TvkGcPs4qrCy01/vQdOHs9/WVXSdKW7Quyu4lfPVmkAeBPmiHz6JLkstSddzSwY6somaLb1dmDh/SCE2CIWLU/ts7UhzZMLoEYBkvZfrekKrUwtfG7rrhv4vGsCFSTE9oP6n+HPEv+1nZJAi2r3aF87Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nWoDMl5VOvjzc4SgroRs1FM4zRRVAwaOsTS/I20V4M=;
 b=naBbbxdIMIQBI7BQHjOogQnUFjWgE5T7SUWOwrXnn+rRE8kbk5z8BfsOU2K6sdPWXvwRdoC9MuOu5i7EnHDuLPmAn3N8MiWivenGCTRZcbwXa++LomEH+pVO4q9o628NJtuH6Zzi/bOmNi+14M6nb8PfmCLF7L3aCSgGUsnpnsU=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CY8PR10MB6708.namprd10.prod.outlook.com (2603:10b6:930:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 11:06:09 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 11:06:09 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] pidfd: add PIDFD_SELF_* sentinels to refer to own thread/process
Date: Fri, 11 Oct 2024 12:05:56 +0100
Message-ID: <e03b9b06ec58433e1d4d284ddc978177a12b4196.1728643714.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1728643714.git.lorenzo.stoakes@oracle.com>
References: <cover.1728643714.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0065.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::29) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CY8PR10MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: 4224fedd-4833-42a8-8548-08dce9e4b5da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TsPOe1b1Ac/jOxpHYw0Q2rWE0jYJd8tfMbi1Xm3pNhpiSAqb+I9t/+90tefP?=
 =?us-ascii?Q?roHHJUunWICdW6aMFmtP8O9cEHNrA62mDWi40ftHxudQR3p3oz1YjQj8mzJa?=
 =?us-ascii?Q?4KZtwnrIP5+LAIn0KCM+MHMpkP8fNGhTJgtgvoOf1Q7MUlIz2XGoqT3cGRt+?=
 =?us-ascii?Q?rOKuefnp1vW81pM55T1wCJJgC/oFRIr2HSEjMsL7C245JcpWoqOUKBFx4BWp?=
 =?us-ascii?Q?+IXF8emFdd4KteOP3ZMOFFc/jdPwmqBXyaZOBdFl7e947LqvhvbkvOeRRon8?=
 =?us-ascii?Q?fpx7dEs1RmTlB3Mc4jiUSOPFZNJRTnXZDqtTMu4rf8+odDoh+Cz1HfunitGo?=
 =?us-ascii?Q?thgkQT549QkQS9sX3mmQIUhmQvP0vqmcGt7QxAdY/RVOql6ccXRyN2/Wwmy2?=
 =?us-ascii?Q?PTKr6ZhM1sADMWNhxqNTWkBuC/dAXg76E+9b/0+qcCAD8Vwx1aFkSdqMYKFe?=
 =?us-ascii?Q?zdePGPfQN3TVKHDSh2f//IdjuNR2F34KyWKJu26MvutNqRGlcdekjVEHLH22?=
 =?us-ascii?Q?hLe7TZJOmRYUOoHXdhDCgo2ltRUr1VwjA86FTy8yPvkybEqHuswJoVuW7vUF?=
 =?us-ascii?Q?2ftZCBNbSyiM8Z2p53ggHQ1/1GwvQgGUU6IYU0QaWp73L+fKJyiJm09psmF+?=
 =?us-ascii?Q?CG5NKtEnU6089fGnLI8LnQVb/TCfP4IB24s33lF3U8gq/yX+M3dGeePu26WE?=
 =?us-ascii?Q?1wHSp124tQHye6AEUBOgwQyyyTYRzo0AjUyxI53hhOPIGsp8H9bpf9Fj1Y59?=
 =?us-ascii?Q?wy1HCtbI/SGrVw1xheeudB16CJlt9x+SXLGdH0rLPn2PhdMHwrWcZG+SVd43?=
 =?us-ascii?Q?IhN0STrGQcKZx78xE1A59bzfF6g8rGSW+h3LbYDZP/fxEY71DLg/mAv3d2Ci?=
 =?us-ascii?Q?SXNQgjBobPui19uf3vpE9gqbRmoJn6C8qLye47FfWtlXE5Got3P+FfJLOUP7?=
 =?us-ascii?Q?8LnMHR2NTEyjpJq0+2diW9NmH/dHCf7b5VMFzYZK4rRf4k0UXetuP2DhEQjY?=
 =?us-ascii?Q?ZwRiGbtb2PYSrSi64URoiLhW7SVHGxPOgCYljJdamBHzj2XqNNycd9RTBKts?=
 =?us-ascii?Q?W38bVEHDq4KC7URbQ8T6+Rz8+9ZGEBJMK7wqvJc22lxYbmP9H/YPV3bSIS2K?=
 =?us-ascii?Q?EoZS1PFzcHteF1ByZlyUMiiRBVs6k4+0nh2tFGdPYjhn2m28rYQ613v+i1fH?=
 =?us-ascii?Q?kwjv7yxlyiFkpjL4Z128sbqSmc9bBRWskJ9vT8oQy7E6erOzbhwchGXZuQv8?=
 =?us-ascii?Q?g9VJ6zVAf9rwmsq9ztR75ZCffHhAWhaiX/MqJITQxQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kA+1xF6FWu/bmKgBRvWg5mBn4upjl1N2KMKGeB7sfAraZUvFV0igalCNwl+g?=
 =?us-ascii?Q?LfLZVPAkMQyOmGw5mKeRA2enQGnoHNd0FN+LTy3HUIQGiLD0abIEf2C1TGU4?=
 =?us-ascii?Q?QqU99wO7XeDfgUsa9sFATERQ96VVeK3BE9DFqv0N3l/KT5sca5CnQZcx5z2P?=
 =?us-ascii?Q?aijRjll6hA/DChMa5HZlwA5B+Bd85v9q193VEK2lv1P6lsRvjKpiWUsSdG5t?=
 =?us-ascii?Q?FXeJJXY+cStFQWeXoTzYSEgXoSqN7qgDrusH63Kz64fdcmFT5/CMMRrXldJq?=
 =?us-ascii?Q?glzDQPj9FR1hamztowsNrVxMF5c5Zlq+fTBRZWroBBdoTR3Lo7nk1Z5bziia?=
 =?us-ascii?Q?MV2kZQUyjCt20W6/uHz01ncUgsOrztNEodDQz1XRzPoeVyVQKFcZcDNF4pPa?=
 =?us-ascii?Q?6RYl41Qeq1dIhL6WeUCiNbmK6gLTvVip87jKRQHkeUjQ7e9aFM//uxvq7d39?=
 =?us-ascii?Q?DmCCtxGERNXqtm/v4/4HN3ELPyA9KGRfaWd5HjH7pZoTf6s3ikjWwLiI9A7m?=
 =?us-ascii?Q?/uIacbDckM0ehSmOWNJL+qvrvF99hO2MIoKrfW3rMZUSbD2BgEXv6xG6/hVu?=
 =?us-ascii?Q?Q2HryycfuWJVCCYiGeiG4+u470YGoh7BaJqKZJr0OeoxHz31+t+4kzbu9vfl?=
 =?us-ascii?Q?QcZv/7hKeTA0jbYjrOOxphqI7DG7EQheI+qQILzNOGcv7Oxe7N+0W0F1fwMz?=
 =?us-ascii?Q?zoVBhp+3WiNnlc4uwDo+dppghsGvdjvuAVkQaOizoUXhj3TTFEC367Z2rElq?=
 =?us-ascii?Q?hqMbe4cgoXP/K6ik9SEb0jquEqH5Kzpwt7/vMmHS4LqV/6AyXSk+k3IN2XUB?=
 =?us-ascii?Q?67rGhWmpmXrDbgrVYkU2ejI6jGx05BF6UntmuADkZ4mKLqvzKV2tpAO7DmOD?=
 =?us-ascii?Q?UAXaGcfPJq/NUgkKbYqEpO4jgYcdFz8qsH3IrJGlSmq2MF3Yz2u32qd5mOkl?=
 =?us-ascii?Q?1iJpa9Bdc28zXrx/G+zL+Zv+AJ4fociLFPjBpJCDqnJhrToKjFs6Igo0ayDv?=
 =?us-ascii?Q?JMew7rEV4HeiN1kjMrLonTQ+fIdUmHEbHbjM1FW/66k4TIE56rZYI1N6W8HW?=
 =?us-ascii?Q?FTT/Is3hpEmWN0TQSjvnF9dFns0Wf8a8t/QNdIdrSruhxv8OhlKSthitboId?=
 =?us-ascii?Q?dpygWQkVcloMct60bzUn9D5K+y6euEpyas4G1MTzHBlf1mpVehuTdRLiUw2/?=
 =?us-ascii?Q?UsBnsb01sxGCTo63qDnJ+Vc+LWsUkmwiFcwzRQHG+aRd8eoq2GolCiW9TNwY?=
 =?us-ascii?Q?3/UTjK8NyH5W6b1utTYcTp2/iAGX6d3Toa9/vM5SJ8cFCx4uNUVtgLsO+1du?=
 =?us-ascii?Q?I+4z0F+QdcRtB6FiGrnBojsyVXvVCb1yP3Vqx204im6oYzjAfVBCq7467p1d?=
 =?us-ascii?Q?i/aCRzo4OspDITR1W12MSHihDWQA1nTEpJuRHJS9CbZS7keEL3nT/C6xGvJO?=
 =?us-ascii?Q?l2wYIamkn6uuD8CFQ/atNt2D8ylTYgFqpyEozNvDuiboDz1AJFCY+ArhPfVp?=
 =?us-ascii?Q?xwIR+FS/YcXcIBt9DHjPiWXlaE30AJymGkZhcpUc7T5SDNq+pUiJXpYlUM+c?=
 =?us-ascii?Q?CILOEoZ6Cw5HqqI0ZB8hfWlpzhQfrbrW3jxUnAmRkwa8uT7vbj7xoxie+L2c?=
 =?us-ascii?Q?DkuHE+3A+n7VhFcOv0bQ1oYZHutnvFl3DspCINLXOVgjLJ6ps+woNdlNzxmN?=
 =?us-ascii?Q?+QE2cQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IC8kvJxLxDVDNP0Nx1dlFs4pOtrtKcJcqMhtdgK9AUixVencef++6IUHHf+Pk5I85ORfPfKj5hx1xVwmfzna+hA1T7/gnEdCTdh246zln2AJp/D7nksWa06x8JbZzvqvQxzFTg17iJ88E+rVt/U1TlzuhiKwhJuqOCRITff73kiuqKXzauItRqe5GthEzwKVQix/THLXmY0k9/PcgJBQrwo7zGTYqKFP5ZADIIuQCA3NwltM0UOhG0SGdIyCTx5QUp++beqUP+h9LiZxRaZLQZIA0WRjjPowoowbiy5DljF+8ocD8rAOIsUlIKvd80Adit+ECp5oirj24xWdbht4G361fslipYJVdswW1Bpby0HK53YF6aSMVuhYLgfGzpw71BD3EBX3ex8XAoijXYq+s5MWcuPT1cpelWjoSYyd7riEjcwUTyYxTTAh/w+Hl14PNp6Bjz0kScrxXWuylQ9jSkb+zFFNmUf5Ig2SKqjCWyiJ/KkOWxT1tiilUP+n8Dz/U7lhICysbcKZS2YbwVppiYcJ1fq4MD2IEYf3yylyLfdQodjs5UXzgJvA7BiqwktWXZ+O8C8qI/2lfWdi6SuKXTGQ0lOCiXy8l9csdMHoSnU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4224fedd-4833-42a8-8548-08dce9e4b5da
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 11:06:09.7659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRSZSYEdjzI2NVXEyhav1CRSOeYLFjSAdtlhg6/vPs5m6D2wshVbkdEO4XBvhW8PNSCumYOLxe18gTkSU/XPD+xN+/3RokGfhzOlcGdN+cI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6708
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_09,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410110076
X-Proofpoint-GUID: HA-ExcME-ELBLTV0eFZ4awNQLE-6i32L
X-Proofpoint-ORIG-GUID: HA-ExcME-ELBLTV0eFZ4awNQLE-6i32L

It is useful to be able to utilise pidfd mechanisms to reference the
current thread or process (from a userland point of view - thread group
leader from the kernel's point of view).

Therefore introduce PIDFD_SELF_THREAD to refer to the current thread, and
PIDFD_SELF_THREAD_GROUP to refer to the current thread group leader.

For convenience and to avoid confusion from userland's perspective we alias
these:

* PIDFD_SELF is an alias for PIDFD_SELF_THREAD - This is nearly always what
  the user will want to use, as they would find it surprising if for
  instance fd's were unshared()'d and they wanted to invoke pidfd_getfd()
  and that failed.

* PIDFD_SELF_PROCESS is an alias for PIDFD_SELF_THREAD_GROUP - Most users
  have no concept of thread groups or what a thread group leader is, and
  from userland's perspective and nomenclature this is what userland
  considers to be a process.

Due to the refactoring of the central __pidfd_get_pid() function we can
implement this functionality centrally, providing the use of this sentinel
in most functionality which utilises pidfd's.

We need to explicitly adjust kernel_waitid_prepare() to permit this (though
it wouldn't really make sense to use this there, we provide the ability for
consistency).

We explicitly disallow use of this in setns(), which would otherwise have
required explicit custom handling, as it doesn't make sense to set the
current calling thread to join the namespace of itself.

As the callers of pidfd_get_pid() expect an increased reference count on
the pid we do so in the self case, reducing churn and avoiding any breakage
from existing logic which decrements this reference count.

In the pidfd_send_signal() system call, we can continue to fdput() the
struct fd output by pidfs_to_pid_proc() even if PIDFD_SELF_* is specified,
as this will be empty and the invocation will be a no-op.

This change implicitly provides PIDFD_SELF_* support in the waitid(P_PIDFS,
...), process_madvise(), process_mrelease(), pidfd_send_signal(), and
pidfd_getfd() system calls.

Things such as polling a pidfs and general fd operations are not supported,
this strictly provides the sentinel for APIs which explicitly accept a
pidfd.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/pid.h        |  9 +++---
 include/uapi/linux/pidfd.h | 15 +++++++++
 kernel/exit.c              |  3 +-
 kernel/nsproxy.c           |  1 +
 kernel/pid.c               | 65 +++++++++++++++++++++++---------------
 5 files changed, 62 insertions(+), 31 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 68b02eab7509..7c9ed1b5d16f 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -77,18 +77,19 @@ struct file;
 /**
  * __pidfd_get_pid() - Retrieve a pid associated with the specified pidfd.
  *
- * @pidfd:      The pidfd whose pid we want, or the fd of a /proc/<pid> file if
- *              @alloc_proc is also set.
+ * @pidfd:      The pidfd whose pid we want, the fd of a /proc/<pid> file if
+ *              @alloc_proc is also set, or PIDFD_SELF_* to refer to the current
+ *              thread or thread group leader.
  * @pin_pid:    If set, then the reference counter of the returned pid is
  *              incremented. If not set, then @fd should be provided to pin the
  *              pidfd.
  * @allow_proc: If set, then an fd of a /proc/<pid> file can be passed instead
  *              of a pidfd, and this will be used to determine the pid.
  * @flags:      Output variable, if non-NULL, then the file->f_flags of the
- *              pidfd will be set here.
+ *              pidfd will be set here. If PIDFD_SELF_* set, this is zero.
  * @fd:         Output variable, if non-NULL, then the pidfd reference will
  *              remain elevated and the caller will need to decrement it
- *              themselves.
+ *              themselves. If PIDFD_SELF_* set, this is empty.
  *
  * Returns: If successful, the pid associated with the pidfd, otherwise an
  *          error.
diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index 565fc0629fff..f4db20d76f4b 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -29,4 +29,19 @@
 #define PIDFD_GET_USER_NAMESPACE              _IO(PIDFS_IOCTL_MAGIC, 9)
 #define PIDFD_GET_UTS_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 10)
 
+/*
+ * Special sentinel values which can be used to refer to the current thread or
+ * thread group leader (which from a userland perspective is the process).
+ */
+#define PIDFD_SELF		PIDFD_SELF_THREAD
+#define PIDFD_SELF_PROCESS	PIDFD_SELF_THREAD_GROUP
+
+#define PIDFD_SELF_THREAD	-100 /* Current thread. */
+#define PIDFD_SELF_THREAD_GROUP	-200 /* Current thread group leader. */
+
+static inline bool pidfd_is_self_sentinel(pid_t pid)
+{
+	return pid == PIDFD_SELF_THREAD || pid == PIDFD_SELF_THREAD_GROUP;
+}
+
 #endif /* _UAPI_LINUX_PIDFD_H */
diff --git a/kernel/exit.c b/kernel/exit.c
index 619f0014c33b..3eb20f8252ee 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -71,6 +71,7 @@
 #include <linux/user_events.h>
 #include <linux/uaccess.h>
 
+#include <uapi/linux/pidfd.h>
 #include <uapi/linux/wait.h>
 
 #include <asm/unistd.h>
@@ -1739,7 +1740,7 @@ int kernel_waitid_prepare(struct wait_opts *wo, int which, pid_t upid,
 		break;
 	case P_PIDFD:
 		type = PIDTYPE_PID;
-		if (upid < 0)
+		if (upid < 0 && !pidfd_is_self_sentinel(upid))
 			return -EINVAL;
 
 		pid = pidfd_get_pid(upid, &f_flags);
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index dc952c3b05af..d239f7eeaa1f 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -550,6 +550,7 @@ SYSCALL_DEFINE2(setns, int, fd, int, flags)
 	struct nsset nsset = {};
 	int err = 0;
 
+	/* If fd is PIDFD_SELF_*, implicitly fail here, as invalid. */
 	if (!fd_file(f))
 		return -EBADF;
 
diff --git a/kernel/pid.c b/kernel/pid.c
index 25cc1c36a1b1..0f8943ecc471 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -539,22 +539,31 @@ struct pid *__pidfd_get_pid(unsigned int pidfd, bool pin_pid,
 			    bool allow_proc, unsigned int *flags,
 			    struct fd *fd)
 {
-	struct file *file;
+	struct file *file = NULL;
 	struct pid *pid;
-	struct fd f = fdget(pidfd);
-
-	file = fd_file(f);
-	if (!file)
-		return ERR_PTR(-EBADF);
-
-	pid = pidfd_pid(file);
-	/* If we allow opening a pidfd via /proc/<pid>, do so. */
-	if (IS_ERR(pid) && allow_proc)
-		pid = tgid_pidfd_to_pid(file);
-
-	if (IS_ERR(pid)) {
-		fdput(f);
-		return pid;
+	unsigned int f_flags = 0;
+	struct fd f = {};
+
+	if (pidfd == PIDFD_SELF_THREAD) {
+		pid = *task_pid_ptr(current, PIDTYPE_PID);
+		f_flags = PIDFD_THREAD;
+	} else if (pidfd == PIDFD_SELF_THREAD_GROUP) {
+		pid = *task_pid_ptr(current, PIDTYPE_TGID);
+	} else {
+		f = fdget(pidfd);
+		file = fd_file(f);
+		if (!file)
+			return ERR_PTR(-EBADF);
+
+		pid = pidfd_pid(file);
+		/* If we allow opening a pidfd via /proc/<pid>, do so. */
+		if (IS_ERR(pid) && allow_proc)
+			pid = tgid_pidfd_to_pid(file);
+
+		if (IS_ERR(pid)) {
+			fdput(f);
+			return pid;
+		}
 	}
 
 	if (pin_pid)
@@ -562,18 +571,22 @@ struct pid *__pidfd_get_pid(unsigned int pidfd, bool pin_pid,
 	else
 		WARN_ON_ONCE(!fd); /* Nothing to keep pid/pidfd around? */
 
-	if (flags)
-		*flags = file->f_flags;
+	if (file) {
+		f_flags = file->f_flags;
 
-	/*
-	 * If the user provides an fd output then it will handle decrementing
-	 * its reference counter.
-	 */
-	if (fd)
-		*fd = f;
-	else
-		/* Otherwise we release it. */
-		fdput(f);
+		/*
+		 * If the user provides an fd output then it will handle decrementing
+		 * its reference counter.
+		 */
+		if (fd)
+			*fd = f;
+		else
+			/* Otherwise we release it. */
+			fdput(f);
+	}
+
+	if (flags)
+		*flags = f_flags;
 
 	return pid;
 }
-- 
2.46.2


