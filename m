Return-Path: <linux-fsdevel+bounces-17044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C21E8A6EFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 16:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E9C1F21FE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 14:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60A312FF89;
	Tue, 16 Apr 2024 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TRnSuzYY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xr59GWro"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C63E12DDBD
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Apr 2024 14:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278971; cv=fail; b=d2+LahUA6asha5Blv9lu8A7X2BywTVgywwW7C2qib5cxmbkyTr+OokVRm3FmTXIuaN63I5xK0SJESBrDeN+E9POAI5E0j0EaTepE7lb/ZO5PaJ8CaINudMqbJMavofnNoAxkGauImoRwjM6owfOXhlfthuQuMCzixVIvbrLrvwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278971; c=relaxed/simple;
	bh=kaWQdzCJvqIxM1stujLwhCDNWMVqBIgaFw1WtszU3jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RyD3YGRBs0yvELVM32qt/NkkGjr7BzgmSNQwC1mtitM6WJBEMEc6CgFsKgpZwKg+rMnfIz8Sb3qYy6TI6XpGgby3JuLY2S3VuN7yhbmNazLzcvtPLaXMCPRipSipYy0uBiV6y7B6QzhoZLlqV6LxBasQ0lqSt6x5AjnGhBY6YfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TRnSuzYY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xr59GWro; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43GENnUg013840;
	Tue, 16 Apr 2024 14:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=D+luyAa5UV7ira1kjNaw9696cpQahUkJScKUE3cE6yg=;
 b=TRnSuzYYzBRIgLOkAj/DKuof+XoDKSEcTZQBo11Y79o6TUhjOFwQlsDlWUC6SfmYFVoU
 w1PPtjle8QQMCARm4jk5EBBPorsF5ymK4hZRxD4uSwOunJGXWc0YARp19OXPGLC6jJdS
 ijqTrGExZz0qu5QoZS1G7POsdX0FtICa4FKw4mV6hhOaxelO6gIBvX2x+X9lqjLmevjp
 wn5KfmSBa5rSU7FEddJ+hVEXc5e/aON0KRmK4IjPJlKfVdu7ldtzQMlCjWSMc6b942co
 +k4gS6VqQtZyijRRI+eSrywxoD33DDU7qNhUpOuBef1JOk1prQj5H/3x/0wn3+abUox3 Hg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfj3e5j1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 14:49:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43GEaT15004283;
	Tue, 16 Apr 2024 14:49:13 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xfggdkrh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 14:49:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddoLCtSGXtemcHVxfbTs09jllxF8SFs0ISiwWMHeDnYfpRMtohOuE/HKPghbypAZ+cMP9uee7rF54aTpqjLT3wKvl7MKEt1e0j1L5KjkBUvh0FxFNGy7eu2IFFnb4GxyZgPXf/ckE7j8TvqzWKbGxlaRmi6YDQLS//aWoU1/34zsltop7+3DITYGjsX2hhpMIcXjkudLwIVlc3TsJTK9PLu+8WgrkP/EWZNSGX9IVMoZQgUG6YqojYGGFCg7v08qHHoE4vzMKJGHIBYa/hbHSZJ7llSE2OCu2cZnVEUlCQhMWYyOBPcYSVH7Ojpal0cia15m1CXmVtxJ4zZ/eic7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+luyAa5UV7ira1kjNaw9696cpQahUkJScKUE3cE6yg=;
 b=lYINXytz7ywlBwGDnE1IEfZtfxEdJLe8tvSXxZaIh7KAvAXc9KMkfSSulTgNHJbKyqTkRP6RTD9XUMdwTctrOc0PQN11PkS/bBRT6r2XPjEoXwgEK8WwN2icQHIQgGT6Ew4jgjGYWs0ne9XOanuljiUNpy9cwhj+2XPVOTk7TwLSAZ6VGIX4ZvX85vOX4Acxo6z+TBorDbNSIC3r7JEuL5vm3rF7IdsaUCPb/EiWJ0iu8FwibBa26AXhFyF7Cs2NbkCuu0WwzDR8tAzQshm1sNTDg7+WWjIcoEqCQmoedxNYROMDx0cXeISA/1a5LuX3gudEnQTq+bn+9/GyBCTKdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+luyAa5UV7ira1kjNaw9696cpQahUkJScKUE3cE6yg=;
 b=xr59GWroDvpnicxgfnwpv6JRiDWb46aVYs4yeDWVEtl648eh8AdcaCf41Jwa821ErkiQWIldJ1oQ97ZP7A3w0Ojk+rDrrKbrTVZqOt44G1s+8Qk69Co/1VQA2Bf7Dc7X+w74pryUa2aLgl3S7oduUl4jz2OcA9ASO00TV0v+1ZU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4307.namprd10.prod.outlook.com (2603:10b6:a03:212::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 14:49:10 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 14:49:10 +0000
Date: Tue, 16 Apr 2024 10:49:08 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, cel@kernel.org
Subject: Re: [PATCH v2 0/3] Fix shmem_rename2 directory offset calculation
Message-ID: <Zh6P5AIANliv5Ona@tissot.1015granger.net>
References: <20240415152057.4605-1-cel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415152057.4605-1-cel@kernel.org>
X-ClientProxiedBy: CH0PR03CA0271.namprd03.prod.outlook.com
 (2603:10b6:610:e6::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BY5PR10MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: 59bc692b-30af-4772-0449-08dc5e246038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1w0V00UKe4g90bUXAzvD+VcrHJy9XkdKEAz2Q/c4+HFantEhi7g/kUIN6cw2E9E2mR2FBWwgxgLlrGyt1ecAOwOA935f8l1iGUkFUm6q1VPuojY2OxJkF7ttmXhpsJzedJIw5pym7tYRHuwWOdvkTEDMGUYCq50ivkhTw5YFF2Jng7voli9COMabHcwgh4gHlnb/bti1wlqZ/nVkLMMLgzsQwfzS073pCf1w2sNs/4oyTFSGfgJJJktsKzFPeknTKxkSOXGyKRs2ohGvAcpvNqwsSiOCJb9vIJzlDCrvyy6MaFiRVGQExXyM9yzlmaalm1If0D3L9O/Gf48FUOQK++DWtH6s6ugR/uoUqGR6ydC90havlSv8safEWQvRTu3j2NRyHiGGXFcRibF/ougQsvVZn5ZdnxZ91ABNuat+JZc82RsQduDufMBN+7RHFGlC3T2SZ5RS615NPwDzGu9N8rK6m/9jle7mAxTXqC62uUS/Le25KrT969QOOACHR/2OVqyIwySI9XB1n49Qj2wspEzqSgXJZWH7VRn11Cv0DfHGkotfFBg2Df/6vKAuzYbpi0xPcDHiw9/1g9a60Pxd+qB/wEB2CpBZW5OFIkSLQauUXC0QFFKsgBHpmHmQUwHFQNIrdZnWDwMTN2YiCvGV9Bg4f9/jsUQwhXt/V98bDDo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JMX3l32ueL9sjgfhPeDQxUHzIuu/kynBpjiJRNBRHucapUHdqbNj3T2lArRa?=
 =?us-ascii?Q?TWvFxC9QNy0Difw1v/YvU+Kju2wX33Mw1ZkxqA3XkItlHVDb1kdEQI5sLHu2?=
 =?us-ascii?Q?Dpyd73u0V3DK4Ol8q2OT2liFD1B+Fp/jQm0YydXN33MH2iTKNgYArSEJfTr4?=
 =?us-ascii?Q?CViaIgQOgYr2wKsXuN11D5i0Hj8DexwXGCb6YrHS2gA5IjjJTldWFujIe6Ks?=
 =?us-ascii?Q?HdAghXuU6u0eUevZ3kmXShscld3ulHIC9gUfRrLtcW0cDMVuKwFRxuKXJvPg?=
 =?us-ascii?Q?Yd/4Mst/oE61fNUbnff9S4ba7T/PlWpFPMzULDTmqUf1TNBM6b04BFIMiQ02?=
 =?us-ascii?Q?4VDcT10RfREzzq1LIn7MNHBPnac1Ut1BcWNeQyBIZNhfDp6SHX6Q4M6aTaGv?=
 =?us-ascii?Q?iHXhN/g8UykOD7r/BXSm3Ocl4izOW7UBf4ZhiLPEeI9LDvpCK+kXbd+4wm5p?=
 =?us-ascii?Q?PYnYEGv2jOPX6DFkZLfUUTdwtG7aD1t2EMRjXxAAKXJREkX6FYgaYxXxkrRf?=
 =?us-ascii?Q?J6FyQpk7djC1jSzt6CDDvxIXFRj0MbI5A5qQ7lrPX4EdVrT8QbjXXWqDAIat?=
 =?us-ascii?Q?LfDrgXgoLj6Buua3+m8TTfSi0PVrH9IHu82rqE3yCFo+GV37xceglyJzubae?=
 =?us-ascii?Q?c66rIWSxFveaEUH2XNia9YpEI+YeUwC1O1u+g9lhqIMAGFSriHXnYAU6Qzl8?=
 =?us-ascii?Q?kxGxLCdowlquIfzH3nS21VT8lkyoXPLJoyJCHHdJKvHJXjnJOGdz/+FomtA0?=
 =?us-ascii?Q?wF9tO4Zv+X5GMMQ3VD2MQShaHcoNYiauLe4BKhcEmO207bhR+hQ7xHqm/yk8?=
 =?us-ascii?Q?qT+b0Vum5xn0n7PO2s94xlb7iODm2mGXnA6pWYxNhCCe5JYZcW4HNuqSZhGK?=
 =?us-ascii?Q?yRfFdNH5pSNE990K/6xWYN1vmGTyEZZm2i3ckkZdU19ipM5PVzJtr6KE/Ka6?=
 =?us-ascii?Q?/+/hGIpIDlOTayE2G43Rw1FNJT4HNd82C4KDqoVC9gX6aBrVSvkUo43WwR6r?=
 =?us-ascii?Q?dSmIxIZLxYITX8Zarea1z2GCzgkjw8mcqDlLFYktCw0rQA/V0v5eENVlMQj7?=
 =?us-ascii?Q?vKbrYW7bPwmiXtF5IAyZkMnXrSkuJzBkBda9bBni3RFm38PpQ6xTw32i3Ua7?=
 =?us-ascii?Q?8UTnNhx+EVgStSafdfIMczGGesZBvMZIiRHZaYlQPbHDD9zPHxiaFmkoECYj?=
 =?us-ascii?Q?0B2+eKiPh3gK8TGIT9fUamgnEncr43DQtL2CtrQnCRyaq3Za6Q0KPlKtPbZS?=
 =?us-ascii?Q?6g1/FEMLT4a9fq+Sdk0dQexcVHNJbI006g5/Cug1poMKDkQcLAaJfFA/RDxf?=
 =?us-ascii?Q?JaLilbIwFEe5frNXNXSPucasOvChoAvQB7AJh1Xs8WPSqhuvkYcq3JhNJVTd?=
 =?us-ascii?Q?PUv1JWZ2RGKSEC2gnM7gZT8B+gwNXNiYQOV+25CaTv9ht3MPm3zKJoAKqjpr?=
 =?us-ascii?Q?/hsq0XWkgUqFhk0KeIOegPaV3uyCyX5XZztqP1iAzs6uf7nO9t0l7Bvp26HS?=
 =?us-ascii?Q?wm7WpzczOGjv9ndl1QYwaqTFbfZ0eSsgDb0jePBbSJM0Up8kHMBW8k6yPPSt?=
 =?us-ascii?Q?4FQJm73s2EamtLFKiYvYdYtVLz/0CeUupPrUNNzWzTS5QLWuIvbcpxFCp/Pd?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZkfLVAo7/tCl+/eAIUu8u9M6wXpOCiSLJ0dVdG5D7CSMPQBp4ozn2g7fORyr2fQuB/bDFSlNuFje1l7GUfqu/Rbi6Xr6T8OewrvWrGbl+HGvgvEuvkegB8rokhfX2LcXqPKr/j8I8O1QoT6lGCGIWbwj/UXwQpX1qPe8EpKUPoASLLrQMNoUnvLfBSxoesJgsRib5QcgKnBsxe4/jOu59DWNEhTP+ip6wOzH7Vd1fkwmkNUar98mgj+JxMtdwKKgsIK5vOQ8cgnMQuWE0NAuLbG4r64YbiI9NgiRTsJKf0t3sLQrLm7tLgQ3VtnaNrl/qKQu32nqwxq55E71Sd3JJ1LhIf2LaRahxquwPjEfmZ7eoHhwVOUBk6MHiRAvskz0/X56uaNyo60KYFD7usBA+PR7qpjkKN+RA9VDbtBQj9XGtDmpqvVPVoiBuJZApInWCw6PU+gTs+9J08FxWAukHgToTeTn/g+d2O5P12R+DsQ+hW7yWZQYCzq40FPMX98bYoZ4NJ0PpBl4YTSxgNj/G7sT5MadXXAnO1oulx6DrdH/Q7Mh7JtCtcuZGB1HfceACX7HyPYPxyp/a5Z3dAhYJJj2VuZhCe3BeKV8hD/pq/s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59bc692b-30af-4772-0449-08dc5e246038
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 14:49:10.7328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwH9AwQ31WaRmDvO1tPjesrhLc1TZoDPv/apPGBAze7eXVd8fZziJOWcV7AMpNR3AfV0BgS59u5yWe8gWfrCnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4307
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_10,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160090
X-Proofpoint-GUID: E5KXz2oQ09tIO_NP7nZ9Q0wJm-S8WV-0
X-Proofpoint-ORIG-GUID: E5KXz2oQ09tIO_NP7nZ9Q0wJm-S8WV-0

On Mon, Apr 15, 2024 at 11:20:53AM -0400, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> The existing code in shmem_rename2() allocates a fresh directory
> offset value when renaming over an existing destination entry. User
> space does not expect this behavior. In particular, applications
> that rename while walking a directory can loop indefinitely because
> they never reach the end of the directory.
> 
> The only test that is problematic at the moment is generic/449,
> which live-locks (interruptibly). I don't have a baseline yet, so
> I can't say whether the fix introduces this behavior or pre-dates
> the shmem conversion to simple_offset.

v6.5 exhibits the same behavior, so this fix did not introduce this
issue. IMO these patches are ready.


> --
> Changes since v1:
> - Patches reorganized for easier review and backport
> - Passes git regression and fstests (with scratch device)
> - Dropped the API clean-up patch for now
> 
> Chuck Lever (3):
>   libfs: Fix simple_offset_rename_exchange()
>   libfs: Add simple_offset_rename() API
>   shmem: Fix shmem_rename2()
> 
>  fs/libfs.c         | 55 +++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/fs.h |  2 ++
>  mm/shmem.c         |  3 +--
>  3 files changed, 52 insertions(+), 8 deletions(-)
> 
> 
> base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
> -- 
> 2.44.0

-- 
Chuck Lever

