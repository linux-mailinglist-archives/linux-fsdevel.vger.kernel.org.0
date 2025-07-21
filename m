Return-Path: <linux-fsdevel+bounces-55581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34427B0C0C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 11:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4349217E068
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 09:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BBC28D840;
	Mon, 21 Jul 2025 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gl2ZTtRn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i6UJUiyS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D744288CBC;
	Mon, 21 Jul 2025 09:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753091769; cv=fail; b=D9RbcnuzVYy590q5jqBZP1KLLA3cc6eKYOyrhlzEPNvE/ojyB2btdoDOn9xB4lJlhvPAj5Xs1PYW6D0+7hETCkHj35aju70tQCwNiBa8vES2KvmHZ2/PrmvhlGUVR/d07T36A3UwUQLHajC+CNcqdWZaVWR7XjfDbtZkhlhdDzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753091769; c=relaxed/simple;
	bh=jRxVCAy9MGWR5IbaJBDQK8CY29WFpCbgIBV774Wf9PI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fN84a8Db6c7Je4ctpEe30n6vcbOAEu0P107lAOvuodXg5xefYW6RnLYq+LlLppISmOtoZM3I5p4DnZ2thRuNRl1Kuk7pww4oH22ufczvjmY2gkhajYy2QwfNGHeKdRqXUwp4KyYl0LabP+kw1l+SlY2ZEmiaKXBtBL95ejFLC1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gl2ZTtRn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i6UJUiyS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56L7gEOA003060;
	Mon, 21 Jul 2025 09:55:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=N+wttk8VplRTQhY7
	YkAOHNMBRvk6+1dyI1RGFL8z+Iw=; b=Gl2ZTtRnVJhqV42ZhIkSGd1Wk79xDt5P
	XpvqTgjSg8RTRBn+Zk2uchw/PJvl3u2fDLdE18ea9VVHtapE2+IqUuRDRe71LnK1
	nSXoSSh5ekeaU+xYFaDuxwRBGYX9rERdVViw7jnE9RnlZq3nh/dR9CV9VO5vZngT
	aiIbCrCgth1aGnRSAiBKnWj/rWaI6cL0uTCd/BzyRfY15sw/aZ+TDIpNqJihB/1T
	ofgqgM07tKzVESskp+R4UhKftMC1wpOJe8rB3dL/qV4m0uzBhXBLMaylAAizPfWQ
	EeDy3DxXP3v7PK0TSChdFyG72vbYwNhLJsEqtUb4HvyGWLC8IkjFPg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805gpj8cs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 09:55:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56L8TRlo014501;
	Mon, 21 Jul 2025 09:55:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801te47uh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 09:55:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uk25btp7KHg6c28z+By69usp/bjSWgcGMBcjHJw4ErIWbH7ahgxtH/1X4K6wy6gL+I+VSpaYJzftMf0Vs9vjv1XtP+ChwhfjyzyTlPT6v5W1PwPZlUuCP/ctRo/vNHjoQy9Ccu02GSPGZ67pHd9DnbZ1aakitGkrabtdZkfzN9ilxTNrRgPmrJxndPNQ3wRuVZooVYBxCQz1Z3j3bzLkNWdXBK0FrtjWfP6gBZAc7XrO8K821k+zwMUSm26CqCZzixXEIHZ1e15kDVVwxefJ3BNJETURN2uQ4Ptilq5EuQQyrbnNitlRd44Pv6kJ0LDwqdiPJUFFXzu05HSXN9E+pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+wttk8VplRTQhY7YkAOHNMBRvk6+1dyI1RGFL8z+Iw=;
 b=uzqClTwfvNwksE2ThpEwBIsRgq6x4sv1TQn97+3cfBzQpyFm5BoSJrsRxV1vi9U5yfpUQpalcn73FswVMAVs31Vu88t4apPvS3I0bMaZ0Tgfv/Shy5I3dhkxcsADs724rpdHevOeNynlKXfoHCy9ECtPy75xmfuXYBxRMxUd+L7ppIqVogn2rsRh8SIMCdhl4Ez/tdEV5a+6LQ9BLXKmf4CbWb9ibcSiRVRFmvV0ix22ihrEJy7Ru+WkS1y3sO1yWwifFmDKw/iuJ7gw8hmH+ka2a8acCt4Dw7a5WsVD3oyaeISHSUKv7iHoTa8dBAnIsiqER5urXba+TAMDgw2CwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+wttk8VplRTQhY7YkAOHNMBRvk6+1dyI1RGFL8z+Iw=;
 b=i6UJUiySJgckSt4QXujQFCnSwUJfhZVNLo+4Ary4sX2EgQuLdOaNW1miODEuGfq0aCw6+Qqsq24/oAQcHsmDgGFcxw9Mj03ZtJyzhWkgkRzgJdzZbXwt+VavsWNQ5QKSBKHMDfrsffBhr+9zDfVWWeIEGNDDYSDbugI48dgBfys=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB5060.namprd10.prod.outlook.com (2603:10b6:208:333::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 09:55:55 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 09:55:55 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH] doc: update porting, vfs documentation to describe mmap_prepare()
Date: Mon, 21 Jul 2025 10:55:49 +0100
Message-ID: <20250721095549.21200-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P265CA0016.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB5060:EE_
X-MS-Office365-Filtering-Correlation-Id: 78325773-a836-41dc-07f8-08ddc83cc924
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PUrxuXVZWP25xh2zxFuh1e+v3Hwmkne1az96Lnyx4m+EAjS2BLRgc90FiazI?=
 =?us-ascii?Q?uJ6BHQ+B4Zld7DCGl7eazPa9Ma3gmvJw1n5V8D5iGE6F7Z8knmuJhINKLkSk?=
 =?us-ascii?Q?8MNIs0c+YxfLRBvbeT79q07/Ve0oLWDqU81/sJKh6tv8D1Xe68vEtrOtSXzy?=
 =?us-ascii?Q?y7Lqvl/rOOZHcKLB/B5zw0PIycjPZi+CESyRPHb2akEft/VootqnPn950vZj?=
 =?us-ascii?Q?soGnIZc7dQ3XWIb3OAlCj+HY0/svEQp83GW5wCaCQDqNrF3lwpcg8C9HQAa/?=
 =?us-ascii?Q?VUrRLj9bxMKVLvDkW3sxo3DVqCoeYWKjx0yTdc1NKa6+EUK06xqpZMfTxc6G?=
 =?us-ascii?Q?9/csgeKtVRLPttlPr/22ac64aCq68mOWZSPwiJC2Krq28w5QgRKM7ucj+Pes?=
 =?us-ascii?Q?vKCqJpmy05RSdYlqNm/wgwwx5yV4b9letBY3CDWNfJgYeEqhosncyQn9WIEd?=
 =?us-ascii?Q?oVdWgdHQxi+aeR6GtHEbNCyjh7dTobF0gRDMFeI40aKIdyJpf/wuotltAzn8?=
 =?us-ascii?Q?x/bPo0EaETozB8sPPoyIv1CWFzZonSBH9z4rTIU9DyIKrjpwSXdzcQQly++w?=
 =?us-ascii?Q?CrpBu/Rxjgsp+O5oK3MuzRYB8v23qoYVNZHuU2vLp1ukYc7bKwtX+mR7sfA6?=
 =?us-ascii?Q?ZhAqKo18CzhRz9SaTQ4R4G3ZKO9nGVYYpqFz+lzzsdZaj4Fv+xVXl1yiHLQy?=
 =?us-ascii?Q?4Biv0d2TXNl655KHb8VwZUSI81W1k/n0wF1xA42RX8sDQUBUAm6Mwm8hMtvN?=
 =?us-ascii?Q?/9ucJrUCZ4sOcbKUKzdPE4Q2mh/qXFM8bgh2PN/o8BxcsHHL9N5UTmDq/G2Z?=
 =?us-ascii?Q?rto6R3FQLpYlznJaNvUpOrGyw7dOyP5Z4m3iLwYv1X7CueR31igU78M8OtVc?=
 =?us-ascii?Q?77QfV5iUFwyrngPQURnXG3l/X9VHBIJOWrfy2wjJv0+/ejZP7fRHL+81utBq?=
 =?us-ascii?Q?h+YWmeUmOfYtzmE849Sf1+IlPnJZGBMx9dr7+KvluOI2wpRZNkiD/oRI0w54?=
 =?us-ascii?Q?GBemmaDQkI8Fsu0Wkgqz+p6vHNxJn8EP/t05d44DSCE6NlFJcUJhUk4qEtob?=
 =?us-ascii?Q?oH2cSh2YLH3Wxrj685VSV7PhbFkpYk38bU3WQhzwfE5ixkr/Br8eqXWK3VaY?=
 =?us-ascii?Q?PX33EdtyRyM9m/V43fNF0H4rN+axfBngvHeBKgDPHLqcl9lBEsasb4k4+9LH?=
 =?us-ascii?Q?qe8FL/xK+FuEGDpURP5JDJRLdxOBSDB196i4s/eRy//PE9f0KwjqnMficSCX?=
 =?us-ascii?Q?gC8nyZDCkSWFptUZBOl5j/UYBF59YBir5eSTIyVQb7iW+uVeQXm8ZjaKegiW?=
 =?us-ascii?Q?kwNOH+zTBKD/gJBk1IJz135onLmB5Inmlr0NClmLljLLXjVkFCrT91sq2u+G?=
 =?us-ascii?Q?ZL3FbRELNttYA40hlXbf3FWjvL7MyUvSGnJYQQrh+LtTdfoyHQF4LQFdbuGE?=
 =?us-ascii?Q?OQtny0zLuWo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iwc/KfBf3yFrnXJ8zD9iGxJf/YgrMq60nmm0+vY0AULNhJI4AjVn7E9iDM1q?=
 =?us-ascii?Q?a/xs0dqhexHypnTRrkYRUKkP6n2BfiC04hu6Tz8CZKZMsO7fjB9fY3diBBR/?=
 =?us-ascii?Q?45209lxva9SowNQVK2iksn9OQvEzTDedaMF7JxrwXaYuvLjj1g4YfIbVsgxv?=
 =?us-ascii?Q?wz72qHmBYMKh7FDbCzxEjJeCW0m0OAjRPZRDPYsm/H5OjxZiXz8GrHkKc5GD?=
 =?us-ascii?Q?n+dhVbgq1GPe5DVZzc9Vu5YnnB/3pDj4ehaoVQmkGHTjRYEzb45AxXd9cqE6?=
 =?us-ascii?Q?x1dt8yMCXbkC4pAT2Il8jm2cc19bi42L/Up7bGMxPjKIzVRg7i/ip09QP6xR?=
 =?us-ascii?Q?8fTAqNPFkHeMJeToKaiFYMRYVMvZJFz5nbdcS6149MTOOT2jwHrjxuVtZWPv?=
 =?us-ascii?Q?IAO3ea4bZftRv3KHW5GXcNKVKim5EeAr1JWBcd7wMR4D/w8UjxpcGMzLGSKt?=
 =?us-ascii?Q?AlhF3fhy60UpSQT0a8QqK65DLeEyDP80zKUfIRpFlwIXBkEono/5Y3pVlynT?=
 =?us-ascii?Q?RJTZ3Tyl2ViEzHPOPpkbDX65rZc7slRw4ijU+tyNJXUvtnqu2goVXnyHFtJr?=
 =?us-ascii?Q?GfpnnHV0YUR6GgWqyVt9z7ETkk0FcUqLC9qmKNESiS+FlM9YDgpYx6LmrPqW?=
 =?us-ascii?Q?DoyW0EesMcxeJdUix7LlgFfG4dEh/ZbJCFX2Jkv9RIQK/i1R2/ZSscWKZ5W8?=
 =?us-ascii?Q?imcfP7hlZRCppsQZo3FWzg+fXmT8YXKsZbaXMHyLnWpSG8moRV4T4txHqXSw?=
 =?us-ascii?Q?/6g3O1d631MWaUtX0z2Q4T/8irlUSDnT9eGxfJc2cxMT6+EPrPufGqVAQy/H?=
 =?us-ascii?Q?J7Me7xZp5r6GuxprQvDX5bVylHt8aE4NC9DdyYTw2cJjHkK1Wg6xVEz+gIdg?=
 =?us-ascii?Q?sEwtA2LvTXosvi7YCU6oEmk/Nj5vlhNKD0Y7prPhJ4kbLFfiLDPC7xP5jjSy?=
 =?us-ascii?Q?QhxdqrEqmO3h4HzlIMTiWFnN/lC91DbbHzZs8bHZudAiX6GthO6mfXjK6nle?=
 =?us-ascii?Q?i/kPQNguSrXy1mFs+EwVgH4PNqhi2w2pOsskxL7fbLa48Uhdazw2ywmxMH5+?=
 =?us-ascii?Q?eRQ9uS0kYkqKPfppTjbhi7x5QPV7dpJZppEU/ZQnzp4p0JYoeJIwo8z7Esbd?=
 =?us-ascii?Q?RtwKWmIJKnmc6rP6O21gteCnZsDW1JGiUtKUZ6wIXdsXuqIMsFZEs4brlaxG?=
 =?us-ascii?Q?3dovyp/iTVj0D4X2CCfLAnL39CE2kW7kqay1iCEYOZPtOJdcBq+SqMgs1xBF?=
 =?us-ascii?Q?mWyjHajl9Lc0G3GNMhckakipzhtjhbHeEmXH+BUjQZpyC7s2tierBnAfuVK1?=
 =?us-ascii?Q?2obRgR2TRCY1uEOTA1/XXt5ulJjXbUpp4M4XFD7OK9Vx/besVwfEyAZ4LTsr?=
 =?us-ascii?Q?/k9CU0uRYXBFCmMx7fLiJ/zQ3HmyfqUxDiqWnHCS1wJZGqxDOevociYvxRpO?=
 =?us-ascii?Q?Nr70KfBvc+sV8VvZ1EAJr1XOQ5HS1jtAJ/eNfN0LBi/P6ALjmOTs2BIiistf?=
 =?us-ascii?Q?4L1etvPD+0Mgk8W8UDryWio9XjOc6QmLsO3OuHyHROsTm6vp4JGdGQsbvcdq?=
 =?us-ascii?Q?HKh5Iimssxno5aLyiIyW6TGg3+wtiKj80KWINSLxthKIs/+dF4ZyKo8QCXCF?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FR+HcDlc+W802gxJbhIapmCVm+pCYLZyENpEXquotrkJMRKN+6TJC2OejSES6AgSty6E6wIkD4lhTNtS7GLHLFMemXZuADvomUxrLji8MWKRQKaBUb7SevKpYWo60ziwsowG9NOcwcPVT+cZcPIr3Swd7IhMfMCC2p99UMLsHY1rz3W/yMOtrF9TLJYfLPBShSyuUDJsNG4d5a0kDlg6UReTuKksej5DekfjInijhYgwO05iFK3cTdqr0hQZmPG8Ltqo5RUDD2jXWxB5/um0LH+kFtG0HivaszY+mdlNF8vSu4C01q8KFNxd+57nOGKD21OMRUX0K5ua6BfIJiCOV5N3FpDGmTkO3dfW31BTwHDtgK4NyvCyh+4oUf7hRsQqDUXbg3JmRPFKJkxjLoNGWApJ4RMOlGZrdZF7WGeBoyvlAMp55sxQsslJYQ8pn6zb0EEeI6Ba/DHyChkoGtGGaH4A/EjiQ2DB0znPR/O16k2isvZTUFs5wukE1WnQ5f4FOqcmxHkvDGDlI2Tdep2vmBRgAVVvjWcWS2AcjKNN3jKm5RqV8828ugw8OmRYsy1163RXhcqv+33h7CLQuJybjn1STQrtrCAnJeUaQUJhzRo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78325773-a836-41dc-07f8-08ddc83cc924
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 09:55:55.5459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6AN1OYftgyvDHapPaq3ZK9AvZ/x9apae8JfOddorAFVvmXqDo5NK/f5GAw9OZtwTGa3Goox0nv7DbU7A7MB9lL0hBM++j5cInbq/fh6lK7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5060
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_02,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507210087
X-Authority-Analysis: v=2.4 cv=TfGWtQQh c=1 sm=1 tr=0 ts=687e0eae b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8
 a=HMc_vxr2tB1ClLHyQNMA:9 cc=ntf awl=host:12061
X-Proofpoint-GUID: IOYoaI7IHxUTYhzP3suKGyG0ArhhRGJT
X-Proofpoint-ORIG-GUID: IOYoaI7IHxUTYhzP3suKGyG0ArhhRGJT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDA4NyBTYWx0ZWRfX14rfu8KhNnp8
 L4bhe9gFSydHTQqF6NmNSOuO/R/MSJUMY98INe0hRzU3EUkc7z8ErhrWQpQ6X3ZM59n7d9vOpMV
 OYuoKBH4UNDX23EkGD8NU7wI3pUO2UAIlzYEB6KZI1CIFcpYAsaFFqm+Zzit2wh38WbOkHItFsF
 jZOi7gzBnX1HftM65iCk4uYEulexbkfRL5+9ROmHI0uMgE+UMy6MIjCldTMet5oEv9cX/eeGRKg
 3NRqoFKCTseb/yuShKCO0YHMOAgmO/cyfS1VSsaoorUDgKIJroGBKFE22cJ3tTBr4bAbHbdSsHA
 vdwmEd7UgXsZav0FAW82qX6W4iDz9RK+yozzGV5yme33ImAsl5Y/XzMtO4fijiuVa+rP1oA5jrm
 dyPZbYrzYFVPID9y7ceb8SGW7OlJ9hHOowHxbLdt0BKXYkoxkNbobicGqsTZK5xdP+qJw0Cs

Now that we have established .mmap_prepare() as the preferred means by
which filesystems establish state upon memory mapping of a file, update the
VFS and porting documentation to reflect this.

As part of this change, additionally update the VFS documentation to
contain the current state of the file_operations struct.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 Documentation/filesystems/porting.rst | 12 ++++++++++++
 Documentation/filesystems/vfs.rst     | 22 ++++++++++++++++++----
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 1be76ef117b3..1defba21222a 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1134,3 +1134,15 @@ superblock of the main block device, i.e., the one stored in sb->s_bdev. Block
 device freezing now works for any block device owned by a given superblock, not
 just the main block device. The get_active_super() helper and bd_fsfreeze_sb
 pointer are gone.
+
+---
+
+**highly recommended**
+
+The file operations mmap() callback is deprecated in favour of
+mmap_prepare(). This passes a pointer to a vm_area_desc to the callback
+rather than a VMA, as the VMA at this stage is not yet valid.
+
+The vm_area_desc provides the minimum required information for a filesystem
+to initialise state upon memory mapping of a file-backed region, and output
+parameters for the file system to set this state.
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 6e903a903f8f..10d560d96603 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -1074,12 +1074,14 @@ This describes how the VFS can manipulate an open file.  As of kernel
 
 	struct file_operations {
 		struct module *owner;
+		fop_flags_t fop_flags;
 		loff_t (*llseek) (struct file *, loff_t, int);
 		ssize_t (*read) (struct file *, char __user *, size_t, loff_t *);
 		ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
 		ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
 		ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
-		int (*iopoll)(struct kiocb *kiocb, bool spin);
+		int (*iopoll)(struct kiocb *kiocb, struct io_comp_batch *,
+				unsigned int flags);
 		int (*iterate_shared) (struct file *, struct dir_context *);
 		__poll_t (*poll) (struct file *, struct poll_table_struct *);
 		long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
@@ -1096,18 +1098,24 @@ This describes how the VFS can manipulate an open file.  As of kernel
 		int (*flock) (struct file *, int, struct file_lock *);
 		ssize_t (*splice_write)(struct pipe_inode_info *, struct file *, loff_t *, size_t, unsigned int);
 		ssize_t (*splice_read)(struct file *, loff_t *, struct pipe_inode_info *, size_t, unsigned int);
-		int (*setlease)(struct file *, long, struct file_lock **, void **);
+		void (*splice_eof)(struct file *file);
+		int (*setlease)(struct file *, int, struct file_lease **, void **);
 		long (*fallocate)(struct file *file, int mode, loff_t offset,
 				  loff_t len);
 		void (*show_fdinfo)(struct seq_file *m, struct file *f);
 	#ifndef CONFIG_MMU
 		unsigned (*mmap_capabilities)(struct file *);
 	#endif
-		ssize_t (*copy_file_range)(struct file *, loff_t, struct file *, loff_t, size_t, unsigned int);
+		ssize_t (*copy_file_range)(struct file *, loff_t, struct file *,
+				loff_t, size_t, unsigned int);
 		loff_t (*remap_file_range)(struct file *file_in, loff_t pos_in,
 					   struct file *file_out, loff_t pos_out,
 					   loff_t len, unsigned int remap_flags);
 		int (*fadvise)(struct file *, loff_t, loff_t, int);
+		int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
+		int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
+					unsigned int poll_flags);
+		int (*mmap_prepare)(struct vm_area_desc *);
 	};
 
 Again, all methods are called without any locks being held, unless
@@ -1147,7 +1155,8 @@ otherwise noted.
 	 used on 64 bit kernels.
 
 ``mmap``
-	called by the mmap(2) system call
+	called by the mmap(2) system call. Deprecated in favour of
+	``mmap_prepare``.
 
 ``open``
 	called by the VFS when an inode should be opened.  When the VFS
@@ -1224,6 +1233,11 @@ otherwise noted.
 ``fadvise``
 	possibly called by the fadvise64() system call.
 
+``mmap_prepare``
+	Called by the mmap(2) system call. Allows a VFS to set up a
+	file-backed memory mapping, most notably establishing relevant
+	private state and VMA callbacks.
+
 Note that the file operations are implemented by the specific
 filesystem in which the inode resides.  When opening a device node
 (character or block special) most filesystems will call special
-- 
2.50.1


