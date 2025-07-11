Return-Path: <linux-fsdevel+bounces-54627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19790B01AD0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 13:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30A03A8FE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 11:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AE52D0C69;
	Fri, 11 Jul 2025 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rVEQlY64";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wElts9IL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D8B2C08B1;
	Fri, 11 Jul 2025 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234005; cv=fail; b=ojoCQIhOwOpeBgWv9kLMD7YKqbTseMOpSCR96lgGM42ohbhOSPz17BDYlZSyTxx91aix7TnyeP/ES2gHoav+48tjruPJh5157KBvGX/vTLjquRdTbfroYielLaRToz7+2h/uxjQs/dFq3g9BVqD1wk8vkvPI2N7qEAaDB7Y6rX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234005; c=relaxed/simple;
	bh=w9b70YRhR0J4qe+E+GHuc75O5MEpHjZSgzYvp69/XTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PNUdotGNmdnzwGW/ZoFkHEUMLa2dfdJPSEWuqVJ3+VUgtLqktD+W1c2QEt87lPyv/j1IvpUMLUjSKWXDLlsRwvoA2CBhFIjedjDVEJX2VrcAaoWARLlx8DiHe4ZeZNWCjYBPdi+IHVQQSXikkPvBUWGuSoQbSclFMJGtPU+cuUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rVEQlY64; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wElts9IL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BBNXnu009386;
	Fri, 11 Jul 2025 11:38:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UCQQnsa42MIfPSuuBqL874zdUhwmLlCZBFO5rTr+5b8=; b=
	rVEQlY647YiCWhRDAQM9vNpyP2OKkXMUGFudaue8I4CyvKa8AU/uUiqLBuwSH+cR
	IO0xXMH5GyEuW4SWcj1BZHNSfHfoxGCikphzsakXuluVNpFOqwh8AHVR7nQ6pHi8
	llPD9vm5EVbabzI2lvQp2IVp5/QdYnC4rcVHb++ytrA+nwcuULfHzCtO9UQIkVk5
	0G1Pq9Hzu6XWk/GC4qNEHvMo0zlHvCgStQ5OahXeS8hmHvSX2qFPo7DqKhwyJeAG
	qa9E5dLp2QXpuMJqoY0pKL1bZV/Pi7aZ7crtJFKlBOFJqnSiBSinmRwWAdsVWVtE
	RsbvzBq8DYmeO3pakChTqg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u1p200kf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 11:38:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56B9N1tc014260;
	Fri, 11 Jul 2025 11:38:48 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptge84cn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 11:38:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bLqyGGVRZlIPextzZhhQamqVhxIxmnDiWTx0Pka5HjvNoAFOFtd0hTnEYbO82hce/Jspr7fE6hf4JirJH1/wqitXVLlS8hjv3e8/Dt2szTgprv4uIbst92sn4dPDS0z55vkUoRgKtHZ4RwhWySKHJJuo8ISCr1iL38eiVjG6/MBj1vOzoAKLvWy2im6EIpsNTnwxq4Ru2j/7R6n4bvUymvUdEKnpsbPPIPCH0OLcGE9N6e0gvgJDOfFejhZkQtASOZIWTg8HMI5nAXlVt+zCR0HdvMSJpJtjuhMESMdTPJsWpSmipzJUls8jDCCMjWnuqX9V1Dg57gJza/DVemurBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCQQnsa42MIfPSuuBqL874zdUhwmLlCZBFO5rTr+5b8=;
 b=yFXIC0WxYwkA3r2n8FuyGVPzGym77XTM+mCSiosNzX6y8/Nsm3l2K6NALtDUJ8j84k1zG2y10RDCR4YNKdqiG7pu4B7FzusWpopLW01FMH+r3xKN1dGMDxpBZuX+ozBNNJ2Td27TiMAf3sJctHkSybpHBL9yU8rJG6oYZOqja2lIaAEKPtpU9Bhji4GQGAdtgPPxtk/w02KeqLqdxi2c5kfYrX84vYNn1RnsPgV0JGpFLUJskqIvCowG22Vj1iJ6XVLWV5rONxESuyx/aHVZRPsoiQqw9M4l3NPBLGBJEYEYFdU0HZGD3yMbpsSXndtARldXLwvoMvTvsL/jfCbbog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCQQnsa42MIfPSuuBqL874zdUhwmLlCZBFO5rTr+5b8=;
 b=wElts9ILFQBaqNLGPNwcD7SMxQDx14MHJvaogJnVsB3ynczqUmEqOFpMHHCKtM0/BogGxrk981ecGdyMAvtaD2E8T8K6pyDozf7ddYGpyCsXa4b+ftiGWnB4f3ewFxVYBhaHBRq/9EYCKJm+mD7QTLwlnyj8aqunQ0WF+2wEM9E=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DM4PR10MB6696.namprd10.prod.outlook.com (2603:10b6:8:110::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 11:38:46 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%4]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 11:38:46 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 08/10] mm/mremap: clean up mlock populate behaviour
Date: Fri, 11 Jul 2025 12:38:22 +0100
Message-ID: <d5f18667cb416f31de846357559e85182a9d8f39.1752232673.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752232673.git.lorenzo.stoakes@oracle.com>
References: <cover.1752232673.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0286.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::21) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DM4PR10MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f67b03-2a57-4f18-52a9-08ddc06f7eef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rrywfhuI+fZ+4ft+bY/ecKeeWGVAwLz463zV2WIyW8cweES+tZCpbnSwW/KR?=
 =?us-ascii?Q?L0/Qvo1/JjbA65met1snLFAgcN7LAOHQPFmJodN7vncfixuIltukmIZuM/68?=
 =?us-ascii?Q?24lPZlatpbo6FysVKmCWy7Gic2PT36bTljQWbJZPnAkD2ibnUwrW41Tzh9ko?=
 =?us-ascii?Q?vVcyz5y0q0eHxpoECmkKzhLXgpzLvIONmK7N0259k2FJl/RSD4zNjxP1BIJO?=
 =?us-ascii?Q?m6ZlPtlQ28hKQbxV8SgdPM4JM3OI6VQHYmoPL7bHuB2EAadqVuYYbYas1sh/?=
 =?us-ascii?Q?NdK2baQPRYOhkD2pjLFmd+7jVfAkRso8KtNIomDISjfK25BJ4FMqpQY8178A?=
 =?us-ascii?Q?hKWRLVSIpIJ3IAmgk0tcRJR3mzZ7bg1gKIGqO+9fh/jntN7q34lWGTJBsB0y?=
 =?us-ascii?Q?Qd/1FfsXb13y1SwOpUeGbJN8bOtxTilXSSHMuDIeeRXWbAPP25VQoTOYl6NI?=
 =?us-ascii?Q?IdGFlC+O4Jz6r2R6nsP7h8kwo+uu3xDPRLVI2vkGBFExoWL08Zgj+6i1/FB2?=
 =?us-ascii?Q?53unP1Tb2AzB+5MYbP5WyhDG1lCvdAWq65NPpxjnNPnVkHu0ulduUCk7FdZK?=
 =?us-ascii?Q?ukeeo9VKLNTunGsrrzQxyKSUYEr2+DPhPw/43HKjLKujmuy3HXQR9EtX4tZi?=
 =?us-ascii?Q?Z0+Nl8+i1PSG8b3HL1u6aWSNRje+GwIQJmuKktPpFKGFv1vjT6mTnYpXKJD8?=
 =?us-ascii?Q?9l8L/atLSXKEEhhSopriLL83JPBrEZ+fOxEd6MTwH6UnsEbukB8uVPYW9Byp?=
 =?us-ascii?Q?I6sbQE096wEoqlqyGSCReYdbnO3LootiuoamN7IJhId1bHrCPlcAszOW9iWw?=
 =?us-ascii?Q?hUUaA2Pp211JBddtWDTakuS5NHgX0FBTR2nDeRaSZzY7BA5TSNbdZMDFl0Dn?=
 =?us-ascii?Q?0+2nnOVxTX+1C+q8FccBw5t2lIVXH+DbqTkmIjnMILybrGH+3dWSkg3GmOyR?=
 =?us-ascii?Q?Iy5aPj7srx+0Za99QW0iys168dzAZ/Q8tMPsPVeVjwNb+Sb1ggcCbguDEsMu?=
 =?us-ascii?Q?X2HKKYohBUWFsrUafea8nQguVQqXZXA7o0VlVgxXgE1lh29DTCe1oocZ1m00?=
 =?us-ascii?Q?h0McZOsoBGCKDMxWq2DpN7MZ4vehYl/AUVgQq/zqdF7/nZPSYu2cRf+SikKd?=
 =?us-ascii?Q?FaPihmcJaxlEEsVSOkkYaWhL9GmlhtTDbVgd5IPmM3wf0fX67okMNRD5+nox?=
 =?us-ascii?Q?ENOp2xC1THZXF96xXnc7H1KOYGKP+nnGJ201Bb9DifzXtkf4h+/6ww3lP7KY?=
 =?us-ascii?Q?xBR/8mKhtlfQdIhYIJNyUm4ibL6tl0xzwMV9kBO7mkG8zdgburaf0m2RVmq6?=
 =?us-ascii?Q?i/tmoueM2HLwAR7uHMfzZr3P0CFcJ0+2d/3LAAgXz5ge8Tb0+1kFcPteHn5A?=
 =?us-ascii?Q?rKKl08+6yLVsI9aqCasW/5AN1cXXouNCAbDkk2OaUMbylujivryk2YfUcu7g?=
 =?us-ascii?Q?tfoOUUE5MZY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SKWyHe8Out1pZ18f+ZS4WLLTI4AnG+endfpOUMiXuI6iBFDTEm9ltH8b1Gpx?=
 =?us-ascii?Q?YwH+zPgyPh66Ff2Tywmd2Owsz1jXeA6WNIsDO2oZs3SkuvZCWhYJop+vyXZ2?=
 =?us-ascii?Q?aoFDjNa4axScRGb5OaeLs8nns7ktVRgBsWeIMM2/pFMx9JqdV0RvyCfygEte?=
 =?us-ascii?Q?cEjBI3lry95gbq4cwYhQEy05KUYNRls0OBNFjhUdzR5UZcLQO1uY0jq0I5aR?=
 =?us-ascii?Q?QvJrvIehPqmtLiIt7QGrQYHQFZYmIdJplUS83b0f7WU08FPdbWk0wF2rYXKm?=
 =?us-ascii?Q?PQql+zkPyhpyxF9rcFjQ1PfmhjrN2z8yWO/Y4sNbEMcj+PPURJ6k1tDPS3iL?=
 =?us-ascii?Q?vwIG1vCrP0TV0h3PKObQS5F7ybkH7xZveG9Bic051oHI4ev3jZRkJfAUL6OR?=
 =?us-ascii?Q?HrudUNk734VvOsen7KvtQIsWW8zJHLC84w3PfILoVvrSZ2eHggSz9P64PC+e?=
 =?us-ascii?Q?2flJFMoal/LYK2evvBlQqMTmfbOupyWLMXrRGMlI3oepVowrZsjk4eGsxxjt?=
 =?us-ascii?Q?jzaiUostlldiywOjswb+7RnQ+kjgHLQWhdVarVCLb96XOMscklgW71YlOMwH?=
 =?us-ascii?Q?QpLoUw1qWQgVM1vSHEqfpcSiHWmMP6l79tO4uz2gX3eTcP/HVywvVo03kNZW?=
 =?us-ascii?Q?SyGRgrouaXPmelmodwrqdcMGR5kq58AHUuCNFFpksj5h4W4X3PFPXZ8/uJrH?=
 =?us-ascii?Q?NShB6V3vdj2TJpl3/hrhs+qkK/mX+p0I7z283Wu9rhKUoqFL9Y+tQazrdKNw?=
 =?us-ascii?Q?uCT6Cr7Af7P+k/nDPcsT7vGY8n0dbsmuUts2cOwl//yNe0TWZynCBWdRgLAI?=
 =?us-ascii?Q?UQ2dbm8oboxVapudYdaP3IuW89NvE+Z8kPmI0Mbh9GReLWCvxcd7qDKs3Zjj?=
 =?us-ascii?Q?ho/6aRpx0RX3qkAAnStkh4Qhh0zQo7lv4FAO2KUHFhMJmO0leRVP4ErF6+ix?=
 =?us-ascii?Q?ts4/U6GQByDH+pUsZTZAz3228aFK+kl6twWYUVG6MuKyOLr74Q5RPNTGEru0?=
 =?us-ascii?Q?q7TxhJoyvM9AV5brSOd1GVtNr9GacIiS1xDXhJ/Fe5rM6UqpjXEOhMqSPa7O?=
 =?us-ascii?Q?sT4ZW79PCd1gi9UCqdTGUI4QULBTu734I3dsvPWZniQ1y6lhiurmKf0T8R5Z?=
 =?us-ascii?Q?xGn0Lj/Ip2/EXW9969i7PjY0t89oIhtSTv4HwnqL1/EU8hF5VWjlUAcSkxWW?=
 =?us-ascii?Q?9dKNv7UukUApWaBXY8CbqcRMJxNFBtJq8EdZMeGo7eXqgXcvx94W63vVmVfP?=
 =?us-ascii?Q?rFi2AGVkrPhngX0Vk6cKfJvZ86uxIbbTj9tHAbRFOKI76ozL/HwKTwQ63tfA?=
 =?us-ascii?Q?2D2EZPMOXx8OzpdQb+0xUWP+oo/9d4gh+CWmsHbxtt+2mkjAsOuyRAEPSW13?=
 =?us-ascii?Q?ISQEkUT+NqDPJLC9p/t06TDjna/gjGlvc5hi2onSNb2ckruM3zOE7aMPdr52?=
 =?us-ascii?Q?YHr7VEZXyuh2cMnjl9mxJ2UnposQAhBQpc4CPrBlTvDaVHu+vY/srkvWdnK1?=
 =?us-ascii?Q?lUqzq7We+Ev3EXnHKXcxPBPqIQLfXnyFvL8JKDKWCI8TKhEm8fA5MM04WTck?=
 =?us-ascii?Q?FgF+gg7hL0eEHOKu5eppV2xBAIowDZ5d0FNNlJfIx1SdACWw8Axb3B69THXZ?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1gKzWPZ2Y9NopJrJ2oia6YK7MPHrxmNggR0IBJRY18zuitfCFCjlN4AU5MdNCXyYyjKPxuwf3wTyQelG0N8l5kAkjQk3WjROm/1HQwgXQxF5fOmiNYa1g9P0P7FXZrYzYEXu968y7aNfwrij6UZO1uDORYQl6qI9kmyJLFuoEGVBOS5lNF5s/hWRyq9E3me5FH7X6pKt1im0SyDR8PivnB2Z2sILhr3tq3Dp4sFElPIduR2FMH15mVdunnDnMwvmVPbhy5irc4/AvD1msgPI7o3xjmBIJ+E0XS62h026B2gcn3IzCXid7ecThxW0kNH60v1BIJSPlbo8iweDzN8AObyXosnPeWZDxj92Q+Z5JRQs8Wui9bNSYKNyS8eOa9uMVfz4YBzDAEmgEVLRJAmPRGfXBVwOpJbggSvWZLAkr/OzVgctoMZvvtagZ5i+qZmgXnVEFW7PeM94mDPGWmnvdvj/asGPUAOxfzYI7vkRmqacZGmFjuCTv/jLZNv9pWE4tUx9VV81XAn8XudGLGZDA9VxD73jml1pQrr9si8qiiO4Z7O4gUDzyxATCQMo94LQuPVB5Yi5oOMdGLf1jofKUa1+otAfGKEr4QIvclqJGWw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f67b03-2a57-4f18-52a9-08ddc06f7eef
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 11:38:46.0523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWXOI3s+7elVK7xdeotcGpmgSa+Nk39N47aRLrKVmGwBkwWpq3auHmir7+IqEZxox84udR4JCwj26ZHR2pYankslwonFTbECn0YeTUYsKoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6696
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110082
X-Proofpoint-GUID: Wi1Oan011IhdWXxSCNvr68kDfNomV84k
X-Authority-Analysis: v=2.4 cv=YN2fyQGx c=1 sm=1 tr=0 ts=6870f7c9 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=vjQNCPEVpfjC6StvhboA:9 cc=ntf awl=host:13600
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA4MiBTYWx0ZWRfX0YP8w4WVCKdn QzG0fV4zYakxMUdpR25qjoZPBGbMr2qMifcCHL5sa/CsPy9mqScPrlBC56Jo1Ayitp1RzU0G92O YlcqDa7LVuCdqTvE2YScGsh4rhbYvAXmx+DxIdSM4guhb5ibXL5LYbdJ8zC0GASGbwfsCVmQGyn
 E346SdtLd2jQUSA/n5pPjUlPAF9F4MUzpiKWdP754WhFAHVmFkog7GpiyBXPwYbh/aGdt5U9rpL Qi0My//GFgu0l2VZxayh/kX7eQPSqMCaMnW/byQaADirZTkyRBoHRzgnMej1PXMmor4Q4oiCkXA 3mjj9kRfQJ1Vf8HANgNyO/HWKPVdofCprq21Z1F+jbb1kmy36O3Q8IQeQlLtnYLN/HZapKyZ0bE
 zupTsCDGmBjHGupFMNSi37CY6EfH567y2EBDkybcinIYCVnF2mNy7ZZr+9OW7Oexr0IFzXUV
X-Proofpoint-ORIG-GUID: Wi1Oan011IhdWXxSCNvr68kDfNomV84k

When an mlock()'d VMA is expanded, we need to populate the expanded region
to maintain the contract that all mlock()'d memory is present (albeit -
with some period after mmap unlock where the expanded part of the mapping
remains unfaulted).

The current implementation is very unclear, so make it absolutely explicit
under what circumstances we do this.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mremap.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 3f8daa3314f0..8cb08ccea6ad 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -65,7 +65,7 @@ struct vma_remap_struct {
 
 	/* Internal state, determined in do_mremap(). */
 	unsigned long delta;		/* Absolute delta of old_len,new_len. */
-	bool mlocked;			/* Was the VMA mlock()'d? */
+	bool populate_expand;		/* mlock()'d expanded, must populate. */
 	enum mremap_type remap_type;	/* expand, shrink, etc. */
 	bool mmap_locked;		/* Is mm currently write-locked? */
 	unsigned long charged;		/* If VM_ACCOUNT, # pages to account. */
@@ -1012,10 +1012,8 @@ static void vrm_stat_account(struct vma_remap_struct *vrm,
 	struct vm_area_struct *vma = vrm->vma;
 
 	vm_stat_account(mm, vma->vm_flags, pages);
-	if (vma->vm_flags & VM_LOCKED) {
+	if (vma->vm_flags & VM_LOCKED)
 		mm->locked_vm += pages;
-		vrm->mlocked = true;
-	}
 }
 
 /*
@@ -1655,6 +1653,10 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 	if (new_len <= old_len)
 		return 0;
 
+	/* We are expanding and the VMA is mlock()'d so we need to populate. */
+	if (vma->vm_flags & VM_LOCKED)
+		vrm->populate_expand = true;
+
 	/* Need to be careful about a growing mapping */
 	pgoff = (addr - vma->vm_start) >> PAGE_SHIFT;
 	pgoff += vma->vm_pgoff;
@@ -1775,7 +1777,8 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 	if (vrm->mmap_locked)
 		mmap_write_unlock(mm);
 
-	if (!failed && vrm->mlocked && vrm->new_len > vrm->old_len)
+	/* VMA mlock'd + was expanded, so populated expanded region. */
+	if (!failed && vrm->populate_expand)
 		mm_populate(vrm->new_addr + vrm->old_len, vrm->delta);
 
 	notify_uffd(vrm, failed);
-- 
2.50.0


