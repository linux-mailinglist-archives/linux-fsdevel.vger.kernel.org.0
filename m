Return-Path: <linux-fsdevel+bounces-46934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E74F1A969D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFBC03BDA99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 12:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B453285418;
	Tue, 22 Apr 2025 12:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FK7SZeST";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dVfvLkIw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE99327E1A7;
	Tue, 22 Apr 2025 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324952; cv=fail; b=OyXC49evqOkvog47qFMFtoEZ8cRr77FTLImuvmaBbJ0DathKLUhHw/zCmfK4v4YF/NACgA21mEgRUluuAyZwAPrzcIo1QvEaRimV/DMY/sBBWHxmOnN7R7U3uzrFCqpfDtWtkLrHDPksnjBIRuMoIQOpLTPxOw6tl6zybdAmFiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324952; c=relaxed/simple;
	bh=4qJmWMCCAZiOdYEsztIyCzyAgKFhiR1xKFRGWso0gCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=shA4cp+w0iuSbmn4RUKoGJ0OFrQyUEtrqmwXwl20ezkPaaCVgd8cAKwPHr/e2DmQRUb48db4XjPVmgIrSQGAoptF7XZuTWGnoTLTW8o7c4w4rxidYpOaZCxOGhS5PUll8nuLit9wn1I/xtmt1dZBMtmL/E+uozdwHThQE/dTKoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FK7SZeST; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dVfvLkIw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MB3W0o020939;
	Tue, 22 Apr 2025 12:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=40PwpeIzG9nynydBAoU1k/Dw3Kn3C0tzNf1hl1so1Lg=; b=
	FK7SZeST1dlCndBQSvShnoQseczjh/xzbd6/2EztDUmGb9rfetVaXQqq+gVV6IgZ
	NAtnwsdI6sPzRZtfXVHZKEWbkOcP5bw+f+Lem4co2YdB/+Zt9xcLpk/xj8ov97J8
	zRtGq9S7m0xKr5kerdXnsXwx6KcRJLLswlly8YHOYZqkNh56Wuzoc1vWheRSukQU
	BNqh/Xg0Zy1pEbq6aDQxMzo/PIGc3RCONO3yoIWmT4FP8GnxHWTlntWPUGO9xwvn
	Wzpzayw1EOoR0zTlNdamQjOKlv78L7cr203Wvd0pqaKsOgiDUD+d7eU2Au/s+Kes
	PeSCgH0hA9wd4ULdxN6zZg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4642race2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 12:28:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53MBtH9T002293;
	Tue, 22 Apr 2025 12:28:56 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012013.outbound.protection.outlook.com [40.93.14.13])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4642999v45-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 12:28:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cixpKZv789Fqk5VdHo2jKQsFofvmjzNyrWORgt8GR6orwgoWmlABCN3mII4piNv5HaRl19fPzbehCitCaL1cCC98G8ngd82XTGDCnFpVDUnzb9Hi4h2fNwF3ZC7YVsY5HllxuGrMHeZwcB+pHNoTHZS400vfYUXWmoZU5rGKix4jLtvugIe+2xm/IfZZMOVK9uEeXaKOfmYL0Pb6HnOx0kIy+1v/hs0Zw3r9El8+9AY652tSwIutN4zNvVaKqTinPnIv1RECBlqz9thMDeMs/7v24Du/iMWJ9vkt0/GWWSDCyTkYqdXQDgkoa25aFT+Ga5Rjp3RRJ816Hol+y2Al2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40PwpeIzG9nynydBAoU1k/Dw3Kn3C0tzNf1hl1so1Lg=;
 b=ql1m6cX/lbvIgGxMommfNIpdG/MaMDw3cOKCd16rnj233/eaLu2UtIimgQMcj1cFE2ZN2wqDHs9Nx9bJH5ro0OTp5/2CxalYaAvMWTz04WBT949ZuId4m35D2efqL6dcnt+DYq/qpYYdxAmfovZXOZrOUEswlAamW+XPJiYFYUo9dfAAxiafL3SFHopL3yFntsVqgrhbtieo5xMkgHkVujH+ogJxo6Pu/HxwKvYfZv8cM/VvQ/fZ6W6oWcbOSdW6ozL9S5mDbyUAQyl0N4uLROaNBfPGf/OXXHk2vTqdVUWFimh7F60jfHNKdHlxHJHMdUrihpatj11auIOxlqGRuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40PwpeIzG9nynydBAoU1k/Dw3Kn3C0tzNf1hl1so1Lg=;
 b=dVfvLkIwUyqVa7f36o8Qn+dcsy5D7FdnCYaDZto99xEiEabR6CKwFt8y/6hHOPcwWIc0nPBepXmUx1cFP8nDIcqGrWgCmcVTm8UE8S5P+IsWrc6ABRbIFe4Xn9HTuuCd6X4GB6wPepe7VMr9nADolDHAvEJeRBBRKcKR3YDfdt0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB4895.namprd10.prod.outlook.com (2603:10b6:5:3a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Tue, 22 Apr
 2025 12:28:52 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 12:28:52 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v8 14/15] xfs: update atomic write limits
Date: Tue, 22 Apr 2025 12:27:38 +0000
Message-Id: <20250422122739.2230121-15-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250422122739.2230121-1-john.g.garry@oracle.com>
References: <20250422122739.2230121-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0582.namprd03.prod.outlook.com
 (2603:10b6:408:10d::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ae7349f-da83-4f1f-0098-08dd8199374e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1jKEdUhQT69TKdB5HFxW8zuhPn4en82vSWTuorO6zJgcw20ZmqEZV8E/CDjt?=
 =?us-ascii?Q?pSf4p9jyOOuvZJAEYpKEQF45e1qq1UWVCQgy17s/ME/L3VLgsWAZr394bGRz?=
 =?us-ascii?Q?3avqFe/e28Ehuv7iKPJcXBL6bKVgO6E8bZIAidoJcj3x2tnmsSMXyjiZVVZx?=
 =?us-ascii?Q?G+UYyO1HPWYDc8M23lmxSAG6EoHWD9kTk2MMgKR95vU8LvWPlWC9acw3umF0?=
 =?us-ascii?Q?1RFVZxhqpnGoM2cgr/Zw+fybFfHIZ07R7fGlwjnBAWd1l9RZYx5ialYYcx13?=
 =?us-ascii?Q?ZSdTlPztptm0ZlUBMGA8wg0zYhjt2UejlsqbERJwETkg8sKAfsPW/iy1u+/t?=
 =?us-ascii?Q?L5fCxSlIdRVv6QLfdbC5wC69n/hBrLtt+YDol7ZDa1C16a1rzIj7+4cjGcpW?=
 =?us-ascii?Q?Zmsy0rOFyAGzwFYylOIYzb+ua76YnYVpgV4GRLwwMsIz4E5YrMwHUf+VMcRd?=
 =?us-ascii?Q?yRN2OSsJHA5LS4Lqlq9y5+d6ejgn0fw0g+Ii8sTQyxKhUIDfcF59dq9QHh7p?=
 =?us-ascii?Q?rbD2pm6k8wFzWvmwc+suCqk+kj+02YotaVnvWAthkY5jc2V9XTRu9IdvdiXt?=
 =?us-ascii?Q?XFHWsmOUeLM8eIK81td86k6iSwU9FtohKddoN1axk2dHH7tOh0YqTDZYRrIB?=
 =?us-ascii?Q?JBSErHj0SmRg269VsTYiWwgo6qdRinWKIzNAsnkc1ZWB5ZVGfcChO+6WYudf?=
 =?us-ascii?Q?t+vwE58Jhj5+e7eHpEt4+3ECnGTQJEORdxjNjgwwT4vrFigjdVr5segiG6gT?=
 =?us-ascii?Q?IToUmAg7C4NPHf9U2Mgsp4fUaBBCP5aD4tjmMYttAElBV2H2YucBrlHpG9K+?=
 =?us-ascii?Q?40nJlNF70xl5IgRuVA4G56EIHiGQyg2fhX8ikohzYzFskr/ccZFOUE70DaU9?=
 =?us-ascii?Q?J6Lwj0iwBRUwDaTrzaudf2w4n3az6mGNIddxVA2zb8gd8EOTdXmcjlmNTV1T?=
 =?us-ascii?Q?N9i6IEE3ZrWyAgwn6pOvq3CDVJoIxZFuoBV0TU+Nh352OVdu59ivQHBtERrp?=
 =?us-ascii?Q?XRzOH8eYhTsQtrS0xF5eMyn0X3UI6+zlXteqgtHcUxJPNo6LCkBSxuzW2EWQ?=
 =?us-ascii?Q?HFQZjnZmljx9kN6ASPvCaHRR58IQczJSBTTc/3DFjM9JgNoBm2QWIL8PwH/m?=
 =?us-ascii?Q?86qi8kQE7F8T8QB8dMXSRD0qtNPf5j4c1zecdg0uNzOolhVtk1JZ1hyvruuY?=
 =?us-ascii?Q?npNbJqHzFBXpZg2R/c4QNY6MMz8pCc9Uk54+4xoS0qZEYUXOJ6IosIer6qF4?=
 =?us-ascii?Q?OyAUIRjMRxs9rdAhduBjb40uREd50uApMIg43fmnX/J9uZpWTQayUHIJPq5X?=
 =?us-ascii?Q?eTE5YbM2nTMTX3v8lHUBkH+B/rJnSMwUr49moy3X0SqdE4F4nds8T8Ay4OYG?=
 =?us-ascii?Q?tpKDxpe0jl88lYX0PwvhmRNlClESbGwq9uqsphDINFgMMEvUOg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yvI4MEjahgfbDDvoTHjz80mz7DmKfxoLttQPCUVB98+TgCB7D5mrCUPIbH+7?=
 =?us-ascii?Q?UpQFcnVdTMrK/DhefodWvgDKDSLUd2JRhu5rfYUp/D1r2qOEpVQDTMdUfD20?=
 =?us-ascii?Q?BdY60Z3Vut5rX8mVxkzLcDc0PGj1Btxg3eLALwplPeIpJMoJHv7nai53y4Ny?=
 =?us-ascii?Q?cLt/Cl4aiXWDgRJ8ZmQRRSBSuyw1NWofARL3dq82xkNwXKNvtklmmM/aYN7t?=
 =?us-ascii?Q?2GWEYJUmNkYunghK8SZZZaDYgnsrotxDwoUnMvsvVg2S9/rqWQ9JkdM8J58O?=
 =?us-ascii?Q?5U28OiSoOsRUs9eqHCM7ppOkuUaHwU9Y46vnqbXRDTyj9RH30xWFHO7cDi2L?=
 =?us-ascii?Q?mKM5ZdCrbwMnHb5KDjmvDvhHfMBNfbHWtQrCcyFEea/jZZxvr0EoRIpRdXXl?=
 =?us-ascii?Q?hG1z7LXJIuPZSXPUc8KU5MhmwIWcYibozvMoAkekCrUkjHY4D6tmAcxTR17J?=
 =?us-ascii?Q?OusVsSibttG6wUfahU7Ngkg2NJ6mhuYQyKhzl+rioCF2JdaTnwM3Q3hBsgVP?=
 =?us-ascii?Q?5/8RTw9pAt+VexlNaaofjaFjjbVjpuqU4ksA2pwRMZ1DXJwp25fRH7q7BDeq?=
 =?us-ascii?Q?JTbOmxBTQ6qV2jhcGA2pvNRJQful0a6/chPk8W11KkNXBt9jZjFONOkyh+tP?=
 =?us-ascii?Q?LARtTrBw+KWpsAE/zb5mdtQuXwVhUhGmqHj+Iq10I5y3ZkK0ZCGU+oWM8J/1?=
 =?us-ascii?Q?0G9y6Le35ECBZEdPBOv94UN2Wh0mhapJZeBSe1urCgiV4aqJLL+DZPAVtS9I?=
 =?us-ascii?Q?uGf7fTJ2qwz5LJiTGX3naHyL6/CJxRwpVviaBMCfafZz/wkZ9UXgUVmFPnzO?=
 =?us-ascii?Q?euUsTfWG7SB3EVx+xzrJ+z5lEQxKJ4So4ymnZvDIjzElwX1nhyoW5mdibJoK?=
 =?us-ascii?Q?cx5efBXYHMg0Ya2zBot+Ko7/9RPRjvQQRjw5vk5vnYaoqY25lmU8yZMq5dVe?=
 =?us-ascii?Q?MpnNX2JdxYxbwOv7ECRlIJEqihnBJKb0dfVgw41PwC8p8j6nMtMKmbVIAw48?=
 =?us-ascii?Q?C7dxu6bYKD0A0cUfd0v+qiBthVZLqAwPsuLfF4rSA3DnVdhdGj2YjzTepGEo?=
 =?us-ascii?Q?iPC19AI7tUA8ASFQ17C4KwKV2M/TdhkeH9km1LsA9GvjUkr25PpUvpjB00YE?=
 =?us-ascii?Q?CFP9T8UdxUXahf3mW0RDGZV6MpjFJfJMbiZq8+5s+CANnGNtNX86wLF2N8Va?=
 =?us-ascii?Q?lCmaTbwtz1ApbehDta0LnRAQJ+LnGyQUpwJk0Qvj0OqflWr3Bm3/QdKcdCe/?=
 =?us-ascii?Q?xQjRwO7cbFmg5/ne8I4FcRwLLrkykjdAHgdH+YNJ5Z0Ofv2xPfT3Lb+lHUgk?=
 =?us-ascii?Q?vt0YYjWACyyPAPmd70uB3rR8giiD4ak8RyLK7HwH5sAIEYFjB88AnhCh4Byp?=
 =?us-ascii?Q?exof+1PaPokQXl2F9JsEvu8Zr5XF5q8ey+72YJ3cYVLYvzvH2Dmz1Jl00HTl?=
 =?us-ascii?Q?g7r6BZGEBj7Ml6I9436GokzQGCiAzFD1NQ+bxRAbCRNDTO3w+HZL1M4wNsLg?=
 =?us-ascii?Q?n8Mx4E95ttl/DGD4Nw6SMOXsSxEgf+BWlhA6sh7DDqbDx++Pdt+8yOe83nv3?=
 =?us-ascii?Q?2CbloUA1Qv6UxRFI8LW1thqgUf7Nlsmc3oKjviYTSBIyIiRHFBhCxdsAEkRM?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NJsbJ66GHTZ6A3BCDagmm5es6uGrY0fRKSW2c+A0WwaqPYFerErgeTuQhP2MzBD2R65vh+RV+8XEtJGgWcINBnUufIBmy6XPfGMuds5WoQNzUyM4/u4ETdP8hD07peVx3OOuejzBarPwCyUANk+id5gCuq8jsZYDOJYhMqe5ta4VPXCc2mZmGMFb+CVV4DQcXbQmN3WjeApNbpZDH5rrGICKEVNK+qR2WrzpzOu3EtQi0t+/VPofynQ8FBsxjJtNdKdSlEJ5UDUeWnJJM7hPbn7aUjbn+mCMgv1HB6KPmTBpQTGemfIZSFe325d02CtlEB4ITeski6OO5pBv1izCmCItwdVK0xadYltuWU+SrgzzujUdAiEmbCn0jbQT4xg5/I/9Old7SLCsKjevtFMA9hF4BjzjHhXn0yNeGbyfUMJbTFjfGhURUH8ZEwlgqA8JFQRLMzmhJT5K5OSA/deujzSHhlXQ2e5cJ74YLozbGzX8cTNTNWTQiDVRP1dyvXEEj9v+codKDW3PRDHESMyYYitzLVfmqk+XVOh5qBv8Kuzxug1fnGIGTq8qfAijU1E8ymzBNT1S1Pzh9AxFRUbS3xGfFyJk1r/xxW9+cK3i7lk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae7349f-da83-4f1f-0098-08dd8199374e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 12:28:41.5548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Z6I317H70Y0JETC/jNtQVHZAmscn4yRnv1lMwLeSAQrl9ZowH8Mdx99g8Y/HtGBE2RAjm80D98/Q8OKk3VpMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_06,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504220094
X-Proofpoint-ORIG-GUID: -TQTTKRq876o_sQDhqWIa5Jx756jmtST
X-Proofpoint-GUID: -TQTTKRq876o_sQDhqWIa5Jx756jmtST

Update the limits returned from xfs_get_atomic_write_{min, max, max_opt)().

No reflink support always means no CoW-based atomic writes.

For updating xfs_get_atomic_write_min(), we support blocksize only and that
depends on HW or reflink support.

For updating xfs_get_atomic_write_max(), for no reflink, we are limited to
blocksize but only if HW support. Otherwise we are limited to combined
limit in mp->m_atomic_write_unit_max.

For updating xfs_get_atomic_write_max_opt(), ultimately we are limited by
the bdev atomic write limit. If xfs_get_atomic_write_max() does not report
 > 1x blocksize, then just continue to report 0 as before.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
[djwong: update comments in the helper functions]
Signed-off-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_file.c |  2 +-
 fs/xfs/xfs_iops.c | 52 +++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 000bbb0d1413..371f0d30f859 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1557,7 +1557,7 @@ xfs_file_open(
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
-	if (xfs_inode_can_hw_atomicwrite(XFS_I(inode)))
+	if (xfs_get_atomic_write_min(XFS_I(inode)))
 		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 	return generic_file_open(inode, file);
 }
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 3b5aa39dbfe9..118377d3f8d2 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -605,27 +605,67 @@ unsigned int
 xfs_get_atomic_write_min(
 	struct xfs_inode	*ip)
 {
-	if (!xfs_inode_can_hw_atomicwrite(ip))
-		return 0;
+	struct xfs_mount	*mp = ip->i_mount;
+
+	/*
+	 * If we can complete an atomic write via atomic out of place writes,
+	 * then advertise a minimum size of one fsblock.  Without this
+	 * mechanism, we can only guarantee atomic writes up to a single LBA.
+	 *
+	 * If out of place writes are not available, we can guarantee an atomic
+	 * write of exactly one single fsblock if the bdev will make that
+	 * guarantee for us.
+	 */
+	if (xfs_inode_can_hw_atomicwrite(ip) || xfs_has_reflink(mp))
+		return mp->m_sb.sb_blocksize;
 
-	return ip->i_mount->m_sb.sb_blocksize;
+	return 0;
 }
 
 unsigned int
 xfs_get_atomic_write_max(
 	struct xfs_inode	*ip)
 {
-	if (!xfs_inode_can_hw_atomicwrite(ip))
+	struct xfs_mount	*mp = ip->i_mount;
+
+	/*
+	 * If out of place writes are not available, we can guarantee an atomic
+	 * write of exactly one single fsblock if the bdev will make that
+	 * guarantee for us.
+	 */
+	if (!xfs_has_reflink(mp)) {
+		if (xfs_inode_can_hw_atomicwrite(ip))
+			return mp->m_sb.sb_blocksize;
 		return 0;
+	}
 
-	return ip->i_mount->m_sb.sb_blocksize;
+	/*
+	 * If we can complete an atomic write via atomic out of place writes,
+	 * then advertise a maximum size of whatever we can complete through
+	 * that means.  Hardware support is reported via max_opt, not here.
+	 */
+	if (XFS_IS_REALTIME_INODE(ip))
+		return XFS_FSB_TO_B(mp, mp->m_groups[XG_TYPE_RTG].awu_max);
+	return XFS_FSB_TO_B(mp, mp->m_groups[XG_TYPE_AG].awu_max);
 }
 
 unsigned int
 xfs_get_atomic_write_max_opt(
 	struct xfs_inode	*ip)
 {
-	return 0;
+	unsigned int		awu_max = xfs_get_atomic_write_max(ip);
+
+	/* if the max is 1x block, then just keep behaviour that opt is 0 */
+	if (awu_max <= ip->i_mount->m_sb.sb_blocksize)
+		return 0;
+
+	/*
+	 * Advertise the maximum size of an atomic write that we can tell the
+	 * block device to perform for us.  In general the bdev limit will be
+	 * less than our out of place write limit, but we don't want to exceed
+	 * the awu_max.
+	 */
+	return min(awu_max, xfs_inode_hw_atomicwrite_max(ip));
 }
 
 static void
-- 
2.31.1


