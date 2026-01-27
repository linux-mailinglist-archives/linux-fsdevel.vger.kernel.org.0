Return-Path: <linux-fsdevel+bounces-75600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDq3DvnHeGmDtQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:13:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3A9956F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C34F630B4CF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 14:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB72F292918;
	Tue, 27 Jan 2026 14:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T38LWdVZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cK4+EnG1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1191C27F4CA;
	Tue, 27 Jan 2026 14:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769522956; cv=fail; b=fcxobEP+iwkCHwYF6EIx9OgE/deys29D0+rA5NtfbwHIL7r3taLpl9DKNbrA/ksLCpwKW4CC0FfJ69xWO4zPyIwUvRR7KGp/y+599ksmVq6ZNxic90een20lna7kYWONj4VtteZLmC9rUkKZZqVxrO2HULQUIwrGIjLiDeYQhCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769522956; c=relaxed/simple;
	bh=3uDoTZNMs8yL06gH6KPB6T7mhKDN6RbxwMaTEWiPvJk=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=uv7ipUTMNF14f9/n/tWtH1ZV17AGUZMiztwQvtGAmY7KXDZsyH3R0hxiMwY6dkUCEkuiOZPr3VHxMU5KuBw4zleh6J55AA+IFKluDF8xJxF4QENKqkvI3Gszm8sTYTw+nkB3z9/VerPcuvP2y78dCASlEs3wVvj52gOlalaxoWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T38LWdVZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cK4+EnG1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBFN7R3331101;
	Tue, 27 Jan 2026 14:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=zQ+Eh/mIwr8qpDBuZL
	ClsEM14dXNsJtTVV5SOAeg0ZI=; b=T38LWdVZ18qjOc5GgN9Z4hBgDNEKUDz5qr
	AQLJ7WawBfVGkz8A27Gdf/jNey8uQdm5FzUjBelmmAT9ivn8EypZ8UCqWq+4n+oh
	8eE0aKFCJh4KhIKPGAaPqqUn5Q1Y9vxDcV86O4gPwkPhJlGcfnVa19ekKdCSIzXC
	RdmaWEz2b6ntEQH1gFSFZDCOvzx8NE9Rxj94sR8RY40jU6kjbYXr8eDmKyB3IYlz
	OTj9ijnAwJ3nbuGY0Ay2nemiJ3SKExj3VzP8cxhzkhcSUGUtLqZL10Juf8avi+2p
	uRWCnIU5arFJcHJfv7V4XbFef7Naof5pudQKjm0v2NrzH6oLNHqQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvmny435u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 14:09:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60RDGDI0012162;
	Tue, 27 Jan 2026 14:09:01 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh9fsaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 14:09:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKWBU3Ed5+b3y6gKaxEOvxs7wXBA6GEUIxG2TdPlEtfEZD0zSlpCDAC2WhasD5JclQR/rZPGbgrgfynUAc8TG6Ca4QrTD+lavAg6yIRxy3BILUQhtQWt0rDVqd1NbN/z37vZWHk2lB43c9YhxJ82l7CREgPgIGqTZIJBZ3eDipe2wwPA0jP2zlPNVFBNhRCylsTDPsmD+O4252oZE8PZN/NxPn8errYPrhQ1i03F7cFWZtduZT7DEPejiQxmX/+ZfXbf07YWf43RPEjatvZt9b3d9cpAeN1T0O3d/xL0BrssQ34mta2ljP9AaznWeYpKl6KGmZ2i32BAqgQkXGvMLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQ+Eh/mIwr8qpDBuZLClsEM14dXNsJtTVV5SOAeg0ZI=;
 b=KiFwEQ93IWr3NwV1/3hnHH1XRqlR/14lIOb7VHtEBa5PmZRq63+OdMmebV4INY9SRZ//4izMDnS1xFUsJKSbi9iWzn4RYbrE+1vzUs04zzICh5Hv/CAWMHEwIOjPYG+h/eSugp7UehD3kmlKDO4gR/M3NMg4ZPCxnG+qru6sCCEY1Qu8JrhPe2c6zfsQQJbZeq0DEpkrz7ItImDEQRC7jW3WjSaULthGt83dRsFUJTAW2ee+/kIKHiMInZtgZdyJHytLeDqwVVaPJEQ/zdLMHgxirFqWBUSg4OjoWCi1kuy0JsOAFX4pB7ogab/2rrA90Pg2hwQVk/PX45CqayvCaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQ+Eh/mIwr8qpDBuZLClsEM14dXNsJtTVV5SOAeg0ZI=;
 b=cK4+EnG1eas8J+QXd6YSsNf2W9eSS5R1vO0kRLkiEuzt99aoYFsshWYxPBkqXW6tIqoiyz/XXPsySgXJXvxDMERYQFSfkTURawbfIETTXXeI9YvAhGOuU+rmQ+cgJyfJQgs9MZo0hwMmpk2XeJXc2uaHKgZseOvyPM/zsFfLTOI=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by PH0PR10MB997643.namprd10.prod.outlook.com (2603:10b6:510:384::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 27 Jan
 2026 14:08:59 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 14:08:58 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Anuj Gupta
 <anuj20.g@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 03/15] block: add a bdev_has_integrity_csum helper
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260121064339.206019-4-hch@lst.de> (Christoph Hellwig's message
	of "Wed, 21 Jan 2026 07:43:11 +0100")
Organization: Oracle Corporation
Message-ID: <yq1ms1zw3kc.fsf@ca-mkp.ca.oracle.com>
References: <20260121064339.206019-1-hch@lst.de>
	<20260121064339.206019-4-hch@lst.de>
Date: Tue, 27 Jan 2026 09:08:57 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::28) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|PH0PR10MB997643:EE_
X-MS-Office365-Filtering-Correlation-Id: b171a948-9ced-4c44-daf7-08de5dad9d98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t3Yse04pjT+QGhMqsAEVLRjWt+vmjFiAESpiEDoLMQx+qiEQWWfgvA8JuXFR?=
 =?us-ascii?Q?UOyLJPvOrJCMErsFFVYYfJlnh/6vnrGobAufir1OPz5eS9Ba8/k1mlpFjZ6A?=
 =?us-ascii?Q?tPrubjAQ8CGfp3G7YvFYpvLQGnLFsnaGHGaa//hfjXG1ABeLbl7U/kdZ6VUG?=
 =?us-ascii?Q?NR1HynVeKp/msp/MJjoIjtfysyOcLdyBD9u7Vz17Pk7aw/L6BxypZ7ib8W6B?=
 =?us-ascii?Q?InpGsAT2/oigIs59LXg99O5gszMGNRnbJXiCOJIj4gLVRc2s3n8S1Kr51UTb?=
 =?us-ascii?Q?PFgHgI9qZW2F98Ieyl2aiJ5YWRDUW1Jj+0DxYEOGwHqS3zXBC+89bd7/Qu9f?=
 =?us-ascii?Q?Lu5sNMyIRf7cpe+hNMNcaVLXKrtYsqLykjX/4tCVzTNboveRpvgc5w93ln1i?=
 =?us-ascii?Q?tT8cIYg6coQtcRVFY7wyx0ZPcNbnGDqlvspfMV0+eDYBd+tQAZ4AwTSZ4BR3?=
 =?us-ascii?Q?DGvDUBYwmaqgAVGONUJ20NtN7/H/zbLu2+4tMZuDDHQlLSa+0qBaJ9msl+we?=
 =?us-ascii?Q?Qk67rCGIghrle35+mymkPYPRf2TzUjmg0ZT88eZX5kW+8+0DgSkMeVzqUFRa?=
 =?us-ascii?Q?Xej4GtMKrVNz78OpSSaRhNiDv2n80kJTYbZiEjknM+r2ddeB/DvUkEDGI3cE?=
 =?us-ascii?Q?aZjWvyUZo52uCD98kZ9ZBvarkYUmmzYH/2f+EuLcZW242LJIbm0kCTJ/q9Nf?=
 =?us-ascii?Q?T52GdEo2A+mmOeuPPH3DTEFQQH1x55qyXtHXRivc8u3ZO5oEHnWd0BCK3d/R?=
 =?us-ascii?Q?p6ysp6ArdIex3ZIJWbd9V+mOGJ0gE8JusVojlOxkIA2BHVqQxDas1ByFskmE?=
 =?us-ascii?Q?w/wiLtLLTm5RbNb9nYxrAlGWWDmZaw7S8NhQFAOHI4qM7BZY/jTcKwX+loPB?=
 =?us-ascii?Q?MQYQ3eKZY/ElPT0nn0vdjgXcLQ6k3akRjn7u0IBXQXNK4pFEoR1NLTOLCuVT?=
 =?us-ascii?Q?7skb6k3KqDUCH5gTZSlgtlgB+xv3Dq2L1tO7VcHNFqJvssOAu5XfVZBIPNd2?=
 =?us-ascii?Q?dHqGVcpDSuc37HierwtsgjRX9oaSN72/+1ix61KNn3nOZfjl/Uf1pJQt9Usj?=
 =?us-ascii?Q?VPC9mOiNUw1oQ00dpHPzz8dcNA2VPd7TVzF1+bs/0/0/hbyyQQDooxtf6/qu?=
 =?us-ascii?Q?j+0/mbmi8rP/SEaBPDCzRh6nxQnq/r6D8b4SFsKRKEpLiruheSnYa427QlGr?=
 =?us-ascii?Q?llYNHt4yrdiaE4kh7c3AkPmdnu4KYHmL/e4/GJjcise26T8gotFb3T9lvjkp?=
 =?us-ascii?Q?AhoZanaCa/O7bdz6/M/PQtq3Ude78/DIQXLDDft0pxcYQQW5fOMeR7SNglsA?=
 =?us-ascii?Q?YL0WFe+L3Ao191m9Kf/SkIfh7ERem+QfIQnvpRBUjLoUlGz68GDmK2y6YOBi?=
 =?us-ascii?Q?+51zhwD3kYqsNH4q9oomAo07gP2W0s/dq1lUU6FEuWTYw4zAsKoXsL+FyqEp?=
 =?us-ascii?Q?KX6vY7DMigIxfmJrWVEmXEDqeeI4vvL7Bv6TrGzjIpCyp9arejHDAsLU7L5l?=
 =?us-ascii?Q?G/cCiC1YK3q+WSTHEEiedM3Q16FIS46t66yFkbeS+YX49rqMSZoBjzDxCiuw?=
 =?us-ascii?Q?1ynU1MuGFITvSuT1RJQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n0tNC8JKwSPkgbHG3Sh+z6v1BNbTU4eELwelP7ckr8EmiO900/lbM819gNZP?=
 =?us-ascii?Q?96HJCvESCXRQ89cD5ugZdSEqjKZvluR+eelxyt5cPgr1Rq0Z6PSPldMBgdgm?=
 =?us-ascii?Q?uD63d36WqF6qhrgMpxnH/iAidFWu4eZAjl5Jgwxeti11ymxAYZEgbjxX4dbU?=
 =?us-ascii?Q?iqgSwskwGncV07FyiOJB0H7dW2grIkFpYyPPn4YYfLJeOr2UIWKocXr4cfTG?=
 =?us-ascii?Q?vXZwyxgkgwR+AW1KkVXzrLvzqEwUeehGD/jfOl/5AludgciUO3Q6P0dfjO7r?=
 =?us-ascii?Q?fL6d6muqWbyZ5LehDNDVLwmWco6JKHs1FkuYf4WxnDJ/rBrjy9cOm8Ex2IqG?=
 =?us-ascii?Q?cPTBfG8lqeSEsaNrQUhvMYRoyftrwSvVhI0j3rRj2bSSsfhBEbcpkVUuW408?=
 =?us-ascii?Q?9zwhSwePEELpn4PUwKWyJyz00m8PO8cMpkhegtgC3neoCHTP/pjTqoq5IvoI?=
 =?us-ascii?Q?nIyPXpajjEBdNS08933ZfruFnocCIjGjX0uO+uiz+a5q7EJEclBc82U9CIPm?=
 =?us-ascii?Q?6qW8B94FXWNFzVBB25WPtPRFg2xhKQAs1y492I2BJGf9Xds2Idma0sxL4s7q?=
 =?us-ascii?Q?Snq75k6nbObENxlV0DwjJBfLlfujQmfT2/hOqXfHCRppdzy3QQU7/W3n2tn5?=
 =?us-ascii?Q?RIDEOkgQ6PnJphcziLbHrr0JU0XbwgrtGqidc8zsVN0EybAcjeFfXQF0qc+x?=
 =?us-ascii?Q?zR6DwsXLc8La9nWZu3IEUGnHaMNlVy8VjyJUmrgBGuvelzXzyAVOp0SA6TTT?=
 =?us-ascii?Q?V3KGgPhIdraW3ZMhU/NZSUwjqVJ+/VSnAfvVmLdK45cpeW2itLGM0g31jErU?=
 =?us-ascii?Q?HzhpymOPrL6J+BGS19ScWYTrZjGMhn1gC24G9L5yra27q1+2tRSysTVrmeJ0?=
 =?us-ascii?Q?9IttngcPrTD2Ega46VK+2BkcieeT00mCmpHSnQxvlef9Gb4J9aP3Ea9243b+?=
 =?us-ascii?Q?6p5OQgVCLJ14+aU0Uy9YTvdscIgOatRr73lOTOAOeahBzr/xc3GT/JrENgqa?=
 =?us-ascii?Q?pxbC9U6qKmiyHUmf8PyJ1qYLprOaLuV8CaALdCzWrAfX5orQGIbI0Hd+XynZ?=
 =?us-ascii?Q?rhkn1VkecA66KD0n2z/YyQhVA9whi27tFJFNFHWNmIMzrT7VicZoqQkkNxDB?=
 =?us-ascii?Q?uHTsxRYeWEeDRR+M8seAK+/ptxF2nXiUT/WrpC7mENDJAUrFCEvXo3mldow8?=
 =?us-ascii?Q?+luTVenQA733XcRhzkKi37ywyXwrnZL3fFImH7skW0KasBwrKt/DC2jlVZFB?=
 =?us-ascii?Q?Xn+XLlnL7W7+TynYqs9+wiS7SmSbv8EMY66yDL+BWG4ubijbHHK9YE/wsLi8?=
 =?us-ascii?Q?2SFZYpnd/TDJUTT1TZalVwOqSlJzPfzyQN2JAkK8UnnZDoR06sregu310wbS?=
 =?us-ascii?Q?UwDvsy+bGE0Re+OwZ4W3mINwWrC8cOv+owGiBZqSv+I4uaMLUrdS/KOVz+de?=
 =?us-ascii?Q?zmZ1nSGOYZJpHqguRnlCzrWppmwGs4WpVkHdySTOClro3JzVhqsbVB5HkzeV?=
 =?us-ascii?Q?YbJGUntQzRtxm0Evx3d3kH/h3sugexK+zZ0fvIV+DBru75p85TPcht+VZ83o?=
 =?us-ascii?Q?GrF5CCJRkQURGk1L8MMscZf9e4kWIx1e3MGvHdz+RfKzLEvmTFW3Evoom0lI?=
 =?us-ascii?Q?H+/rwxKES2btFqH7uKg1pjySAEXm3Hm75m/DG5TNjF/W0H43qqSwsBqqruR2?=
 =?us-ascii?Q?5x6XfA2k+Gpm7NntDUdSW+JP4oLqmmZVPCeTPL9KQyaj0TwwG1RcAvqgYWzm?=
 =?us-ascii?Q?XYeANXkZsjYa2KRdG9uLUtqUYZqulFQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CxMtUim7MzWA3ijEz2RwzBe3KalogN4ZvivT3JC/Xr4+xdCuZ6hJwP4pKDdeu3ZO93MSGRZjWbawGMMj5VnDBrTzYeIq9O4p/1f8WPkV7vJZYugakwZp5KwAKy+ADUwaFqpOGzAgUzbDeb39Q0EQ/9qwBqFQF44loyjE//o7uJqWClox7MDjt25FdaxGAWagUO3c6MMxJvuTUvvr9S8iMwbVYztrkNMPjluKJz1wQ2pt6KlJR0bezYI9tOIZb2d8qcIrMz6ZOll+dYkIgZHtsoKj6WpKZk00cBPk1l15kuZyqhSfz07AlOfrTUO4xLG5tX9mub6Qzg4qKF4f0iqRVVNGVE7mq2EkBLkXKib3uQlv2+uUv8Ufl1qrb2ni5G7f78KBOrjo36qO0Rl7gYcLO1wusccHrak/28Abir7RTbLgp+utc2MKFbJfxTAf1lDNlpUQh2OW7iy360e7DZPA1UKahheIWV+FYIrHd6nFq986uHO+8i7lH0cI611qn0zFX/+NwNR+/4xYNCuF3hN03QcnifPm+oaJ0Ff9+4hBmhUs3Bi1Mt3O2i0BmlCXrkfkUF7GRt+dgz5wjqmNhoya2iXhHgUUxMCQqKquxJ4s/PY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b171a948-9ced-4c44-daf7-08de5dad9d98
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 14:08:58.9295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5u3PO/Gs4rMDbsPdaewBD+izxTEcBJo8RZ1T784sLBi4yIdvddmLcw2vGoNa9H02RgCFM2ibSoD3L/B/px1coOWP1ItC4SbUwZXtPBIv98I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997643
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=926 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601270116
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDExNSBTYWx0ZWRfX2gYEARJWIPZb
 SvbZfB8VlHb60iRu5lC+ekAz92mjO96lMSDc1VMWJC+IgJf4AQGIPQbLIIT01LBhu8938apchlj
 p7l8XJQZNaDDpjDgBNyLIdDc/BkOa1j0i4UsZdljjNgG0FU9RgGGgmmu2x/ipg37E9Wib5cL/Mu
 0s1f4jSCfzFDQ6Aoa9LRf+U8rf3bWyAl0cAVl207gezwO9UAAnhQMzl04oSPlJDGNPUsCBW2Vv0
 Bjr9hr/XlrBB0tLjnhD1bQ+ZH2mI2zm84sKUIdEpEKcH32kLgkhRWV2LHSc6esuERKD9CefnO3F
 UiI2XHyT7KuKykJqVmbc2iRGcocamwsJsNyX42C40vQKp1toa8keX2e3J0vbAziD4ca9aYHI7gM
 NH12pn6AZ+v5oAinvu/PugVI+tyZgSZlvWuA+NSx5V44iojCVgvV8IsJiFNXd33ucn3MyZ1/mx5
 TYOK8ct0FtGZMTgOTTg==
X-Proofpoint-GUID: CA-jrkC8JH3oKU2t2VT_FKYd0nMfF6no
X-Authority-Analysis: v=2.4 cv=cZrfb3DM c=1 sm=1 tr=0 ts=6978c6fe cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=2MvIzK7t_h_xjAHuEY0A:9 a=MTAcVbZMd_8A:10
X-Proofpoint-ORIG-GUID: CA-jrkC8JH3oKU2t2VT_FKYd0nMfF6no
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75600-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.petersen@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,oracle.onmicrosoft.com:dkim,ca-mkp.ca.oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8E3A9956F6
X-Rspamd-Action: no action


Christoph,

> Factor out a helper to see if the block device has an integrity checksum
> from bdev_stable_writes so that it can be reused for other checks.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

