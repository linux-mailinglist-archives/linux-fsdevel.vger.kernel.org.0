Return-Path: <linux-fsdevel+bounces-43926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEBFA5FD50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 18:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E5717D572
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 17:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E6626BDBA;
	Thu, 13 Mar 2025 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hb0sbTrk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r3nOUr+b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3534B26B968;
	Thu, 13 Mar 2025 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886034; cv=fail; b=nyviWKxUIHGRJOCrqdwJIGtcq9ic7r0QY+civ0FXX9YY7PN7qDO1zWEr8n+R6iodRp/mNfLbRGvW9t7XgVF8NblbVi9o4Grklm8Iwhe31CemRRCLxVVPZD13m1aA71Z5cjVbQGy0Xsaipv6P/cbnxqUvIAL4E2PE0cwc2wo6hhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886034; c=relaxed/simple;
	bh=4JcV0Is9OPw4R6V9LnI3FA54PNs+HmA0VPXXPXMq4VQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kRsLRVaqwQAa+zIZTVw4Elc4mJP0AyemN8wPjSVFC8d598ELA4p7xI8O4iRzBBM/KfW/TXzWTufhHmX7bHcO/Jm6zOlEsIHrDkdXDuCKvH2FAYp3Sig4uxoI4ytd3DDkCXTPtsVhEqoPmcEzWdP2lDOWBRMiEb3q+P+SK9NRknw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hb0sbTrk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r3nOUr+b; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGtmQv013888;
	Thu, 13 Mar 2025 17:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=F6lr4GwsTZpWyMGKDfhM+tFz2CnnWNsm8aH2kJXDOjY=; b=
	Hb0sbTrkl44IQ1v7pClpjOX9ouM3aC32hO8Npl1wSF05P3zfg5JVvbSy/aPgds42
	lk+ltRl1zdD0KNxIAxM9OCwhso5H1RK5w9zl1jzS6Tr7PZrOXPseHipfa68qa/i8
	+uCS55EMKK0liImQu4gt7hSsO8V/HqtdJFSQ/eRH22IqZ1mX+F/tqGOcWrKtdtRm
	ACXWYEyw7h+Ypz9LM+QIXccEPlqSnnX2B8tK2SJ4mv5zZ3kNI41aAvYKQbNuUXFb
	gr4ceOawU95d3qNAtbLHWQoWguGXIY+U+sY1ebzpm04JYaa+hPqEMSBpZzjtxRMj
	nVmzLHoNf0u0nmLmmdPzZQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au6vmrcw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 17:13:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52DGeUsN019470;
	Thu, 13 Mar 2025 17:13:42 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45atn26mrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 17:13:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftaDpXS3pr8xqvSAk67D82kRtKm2ggBnMsUwEzdnN0PwANjiUs6DNcNqkMJUYcUsUySUDhvU2YpnOa1PnWum74JMK9WcfdxL0xOtG3ghZeSqkmJu9Q3n/9yJODKL4LeTtrQ15aZT6C3tqGD4SIiYpG8R80itVjd/f+E/bNdtEapP2VGr61UROtXX+2DkMIrs/ofOwbOs73hCwRT6eFissdWeYxDhrtCIyoNyyw/zjv7sBAOxtqkrmph5Uzq9N64L/4nP5iILlI02SUv/19ueb6pd6VnHBoqYT17fxjtBwUG0y4eYUyJOXJghZmWKuJQc5PhT6xGeX+G8TlyIyda4kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6lr4GwsTZpWyMGKDfhM+tFz2CnnWNsm8aH2kJXDOjY=;
 b=XbC7+QGRdUA4FkYe0mSS4oGqMzdg46o4/R5L2A82xFvscLN6VECkUrs6sFQV9vmQCA8D7/LMzO0BiS5Pk8qoxihtVq223SArAxUfD98pO2rDZaFNO9wnJmWRBLutHXRvhl/O1P0SUw6P4Q39Od1yUWqnFjcxzMeMyWpUJzQT05CQIvdLa//xgnr3dQDayl5NT++uUqjDocJAo5zkSw6uNp8lygIz/48lxNqBhJ3ba/OBGKIVWl0F+ye2g2hwLdkQQ/O1KeL+J2SlbGZOD4xCqIPImt8SO2wQmN0KueOaieLqzC2Bes9PVu0Q78qHoQgp3naS/BkMf61LUnQtNchrpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6lr4GwsTZpWyMGKDfhM+tFz2CnnWNsm8aH2kJXDOjY=;
 b=r3nOUr+bAFN6ks8ht1YWeRh7hQh4zL9e5Ud21Z8ELIPkyluHjKwWbl8va+wAOw8BngC0f/laY00yEaM7zkiBzpbfQ5W6drZMZ4TbMUUc1dXVdsBB6oMFVcfTaBErqKIuYz9UrsSjqUt992fROzhm8DN6ygCmlCZQKF3fvSB4+pA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MN0PR10MB5982.namprd10.prod.outlook.com (2603:10b6:208:3ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 17:13:38 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 17:13:38 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 09/13] xfs: add XFS_REFLINK_ALLOC_EXTSZALIGN
Date: Thu, 13 Mar 2025 17:13:06 +0000
Message-Id: <20250313171310.1886394-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250313171310.1886394-1-john.g.garry@oracle.com>
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR03CA0054.namprd03.prod.outlook.com
 (2603:10b6:408:e7::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MN0PR10MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb6e064-81c1-4adc-a20a-08dd62526524
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GzvBYgjqgajvwYFD7tU+QHxUTBsi2a5F1uSNZka3KmnmOndIaGaUykGA3LAJ?=
 =?us-ascii?Q?wKIHFydGqfmP/QtRvDJrzAx8bHyfErwEY6oSfp3HUkGJa827M6yi1XTDg1LJ?=
 =?us-ascii?Q?fGCjuz+6ny1sZlIXdL1luWt9dgk4zi1FS6XAXBsZxBzi1Do1wQIvCGmwa695?=
 =?us-ascii?Q?fQyZmdes9HEiDwrEwAbqSE4cvGv+GC12rM4hkH2m17h3oRTozX3Zjg90zjO/?=
 =?us-ascii?Q?BLM9LSU7NdDlaBb4vZ3238hnEA3tH2PzNEaSzTd847NDcbOhpaqOhVKwqTnN?=
 =?us-ascii?Q?zB0E7bpfLQX57rkOYdovvp9wO7PAmhaYM8VSmM2/XL6Fv9KVdSDWVb9/yojB?=
 =?us-ascii?Q?k82Nz1teFceCy222lA5yIuA5krfN6Bq0ae8izwtFY8DRgQ7TrxqstrUaE0gr?=
 =?us-ascii?Q?eBKLTzpbXdtLlhNcBpcdtNuJK/cWOB74SvnUHto5WXbjQn/RPsj6YmLuZjn1?=
 =?us-ascii?Q?KTERNLFPLf+XMqbzZs6OzfyU4wWMCoBi5aqS/IlKmNpjJVPbDPvuMERDDzi/?=
 =?us-ascii?Q?4GknArJrnvYQhjyU1zXvoH/mj7qO4xTBBhMPNn+An/0ZulNAiSHGLGG3eJKc?=
 =?us-ascii?Q?s0oipp8cVy0dZvcTgiXRUq1yJj5PR2nFnrLSLRSYkHbYmfI1iyA9fvljOd5z?=
 =?us-ascii?Q?kWUDew9o2hR2iHvUgV0f6cuPcOaUNK55hQSpXHq5k68u8skorbnkabm31vE7?=
 =?us-ascii?Q?UQO1HZsRnedpCqVkDuWdV5zQdIdvWwjAA4miNkuRUVKJUdysECNQR2gpXSh1?=
 =?us-ascii?Q?gf3uavnA0gruPKqwEH3II8xO5BjwlBZ7RMW6fdRS7CuaSJh25A3cPXzTfLJ0?=
 =?us-ascii?Q?Vd3gF3Eu1b2P4vtV5oaE2gv30R9jvmebgUg98JxdMGhg4BM0sI95FNcB8DeS?=
 =?us-ascii?Q?MNoAicTUwN24hN//Qzxjt3Jk05tU7kplHIW0iWe5S3HG6aoR7d/RBCrA5qGm?=
 =?us-ascii?Q?A46CO8/dgHRDbNZZrBdmlCBU0hN+Hoq9dXihmfBUKkg3aRwX106DDo7wsI3c?=
 =?us-ascii?Q?OQedhu+8wJ3pukXk9Rp/l+1YSL8pTF21uD5X6uu0T0fbs5pXLsaHqmohUBO7?=
 =?us-ascii?Q?qXdNVnloTSKKUKzVlWn6eZ9g9EBg/q0+XrwuIhoSfY2p7ZaihBLXSQMxnbo2?=
 =?us-ascii?Q?UmlfaKWSLQD++JA7q+55ErfkYwaLkKC+471lKgRNO0/CpcjQzaDa9ApUbjXb?=
 =?us-ascii?Q?sOWCuGgSnDK3Czouc6JBhKqEd91NjGqf+4EUraHaCoaqwTcQnxTY2n/c/oVM?=
 =?us-ascii?Q?aUt3G5XFpGTByND5jQ+7Jfde/AfwXryy6N1MeftAV9ap4BfHXrGM6D+Bj1Dg?=
 =?us-ascii?Q?eofaR6YTymU6sNv+p9XE4kKlPBo5qZzuzlC/LfDuS2b2SiPUgS1+CfArhjLu?=
 =?us-ascii?Q?5P/htPrJNSiYXwiKIdBBsAzkY1SX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PfLWpcJBwxdwh/RnXYlIp9kaL5GRtv3ruNNvn9/DLGMhIMH53CUxwEBCRhPV?=
 =?us-ascii?Q?rW4qC/xlMb7NqmywhWZNhG8DXFt7/LRPQdKzSjoGadpZOn2WIu3c0goVC5zS?=
 =?us-ascii?Q?X3pS3sMSdPIDF5U1s62YesWmCriXFYgT0IFw8WQrnMVUZf8tAjLzs0ZJDqfm?=
 =?us-ascii?Q?/af3jy7l2h/KueELzFDl5VGRswddhb7mvFHf4ENHchiZpCQ89f7zacMtWH0u?=
 =?us-ascii?Q?EDK/3YcpAfbGjlKiVBAFmJKYlz+WcRwIG5QzmaSnHMbp2o609mrAGx5vm4Kc?=
 =?us-ascii?Q?ZPg34lvQ8Oriyvuw7WW0O6QVVqXDLLdOEHDeFY+Y/p6cS6n/o4ghGVi2B1bj?=
 =?us-ascii?Q?7ukTpuAv2S89+i2vux899DZRvaIq3GoRcJppoRgtIxFtP98OU0fL8EkwvQum?=
 =?us-ascii?Q?kjrhHa2bNSRiofYZP2WBUPNzi4tepI7bs68/o7UYOiiqIj49M9vpJGcRb/C4?=
 =?us-ascii?Q?5O10PZSbb7dA4/s9Wd/M3FruPKRrqbZDskOR1DNZC/ac1sNs6o6MbuPGjU95?=
 =?us-ascii?Q?O6CT25Bw+zuYZtVupo1kHxEmlBd48AKJQ8Wksayw5V8erwOAP5Jghy3MWCA/?=
 =?us-ascii?Q?T/uIed/SNLgkZMjqfZ8KbiyIzMlCliVSURPQ4q0gq0i3M40Ugscjwv+2v//V?=
 =?us-ascii?Q?nr1pztM0NHs3krAQF13MmldlJv/YoTohPV0nBNPNMuu4wX/lI4tWg/VGKC74?=
 =?us-ascii?Q?wq2UwAikQKrpyva52RsHol5mfNM4ysyqaX0m8oZhkhLcAd74EhWEfWynk2oH?=
 =?us-ascii?Q?v9oI3QQkOnz4kJCp3KyG+vhEMY31kuhifIpp523m7WTLSe6KizdGWVWeFQF6?=
 =?us-ascii?Q?dyIn/a7uNrTFDhNK+8TLsBV5YyQKUXomcoOe+f3u6UlbvPzcUxtbAdbOnA9y?=
 =?us-ascii?Q?7tmgGZ4eP0hVSO22/x59qSlIsnetTpHPlFLqp+yKyiQdzZqepgKXmlySIZQn?=
 =?us-ascii?Q?5xrOg4Qpy4gx6EAcp/G0Z2zOongAZPK8HriuuGFSaN3ushWCBdMF6sfmgZsN?=
 =?us-ascii?Q?+foWH1x3nDJaQuizprL2SsFTb4XVocDzL1CQEAXPaoSG0caaGEgw0mYKuvt9?=
 =?us-ascii?Q?DdRExYpk3UOdxg5HHWmjc6bEtN5N0S3FhbYb7V3PBhcGKr6fJVED8TM776Bj?=
 =?us-ascii?Q?bCrnxAarPVSZ/OSwXrc1jODTKCAPXOPZoUGyxlW0PxrcbDmES11HU5GOBn6g?=
 =?us-ascii?Q?XWqN9luZ7fRqPup8rTZIOcuI3oQQN9v6c+c4pBE+RngOzLKDNm4y/y4dYJQX?=
 =?us-ascii?Q?Hv4B59skOPEX/srjSBvU4GT9v6Xzv+vcvHqg8m1hIOWQo/bQw5RZbNlVL7Mu?=
 =?us-ascii?Q?79EEqGwf6RUHW9Q/g14lmwcOF2SqUac6EfY6ouUIc4lpXuWXJ1Fc3RIdwDq7?=
 =?us-ascii?Q?oNNisyP6F1MWmDDsJdOCpeH6HEB3IXX9FU6TzBauczzuD5zR2XA6AQ2RsbWV?=
 =?us-ascii?Q?NlYy8NipJcmb1CFLELjwN2Z2HMLB4HgPEcHWJ1ToEBSjj/1y19+gtGtFoY53?=
 =?us-ascii?Q?0fLEHrGdfjT3z2BQfl5niGANFDqLw2ipRQnqvx/yZ5oL04l5CPfaW3ldeb1B?=
 =?us-ascii?Q?vL00959WGMp4vDe3H6Br70ZvR3A7Vh2cEce37X+8m+2G/7+KFyTzjBiY5Pmt?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jggHtS9RWTXL5NjM4FhJ8N07SV8phD4Hotunb1a2z0jHp7oRTSyrmWxoXp+baE1Ujr6l/TKWHtSG8WzzoXLHDs+ixiVLlfup8SujkemoDooexL8YqccZ/RddRnPx+miq+XrS8R3jJS0qqGkkYxKdHtt6rQJM8tS1s+ax/EYFxPiOXcVPM09UjHtNmY5n910OWD7cobIPLfpp6Ubg4GStGWT+sSYnTLST6vvsGi5LKFac/y8kZZeMzqz5HSfExenSbgf8rYt20UKvV+odFN1dZZApPkiWMyrGvYVYm5Tw+pGoqS6UdanYRIFilzpy0zbv7rBdAF9e2fp8j+o//akEbNsVyVl1N/oTHz729utxnKKQwqbLAnaLeBa0ksK4mhBGuqREHW9e1uFOXv7npVbLvTqNpo5+fS9W12GblzkAJfYsgi4SeNnlm5C/4jw6Q7HW+SxHff4to/drL/1EtPUhDkGktCglyvl8RQ+Lz+P+tvEmuavdkVyDls12/X4dlE2y/nUOVwclfbjzyn1km14H9VDhtsI9wZWHtNtbRlsFnf3GUQ1MDbZIS0bK3/jq7abuX+pKedT5QUtBmfHPPW8uyMgBmATSJ4nJbXeEPEwkiWs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb6e064-81c1-4adc-a20a-08dd62526524
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 17:13:38.1949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZf3nf/Ocnvb7xVRSNcYaS6obPNTFHW+XEmOQjpNNl1dF3ejt+sZRRVe8YEB7dak1ZFi6uzyJYIDoIK+FZQ/EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_08,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503130131
X-Proofpoint-GUID: NRzhyYNF7Uw2F8XuV2Aa7OrbPJUW71Ts
X-Proofpoint-ORIG-GUID: NRzhyYNF7Uw2F8XuV2Aa7OrbPJUW71Ts

Add a flag for the xfs_reflink_allocate_cow() API to allow the caller
indirectly set XFS_BMAPI_EXTSZALIGN.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_reflink.c | 8 ++++++--
 fs/xfs/xfs_reflink.h | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 690b1eefeb0e..9a419af89949 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -444,6 +444,11 @@ xfs_reflink_fill_cow_hole(
 	int			nimaps;
 	int			error;
 	bool			found;
+	uint32_t		bmapi_flags = XFS_BMAPI_COWFORK |
+					      XFS_BMAPI_PREALLOC;
+
+	 if (flags & XFS_REFLINK_ALLOC_EXTSZALIGN)
+		bmapi_flags |= XFS_BMAPI_EXTSZALIGN;
 
 	resaligned = xfs_aligned_fsb_count(imap->br_startoff,
 		imap->br_blockcount, xfs_get_cowextsz_hint(ip));
@@ -477,8 +482,7 @@ xfs_reflink_fill_cow_hole(
 	/* Allocate the entire reservation as unwritten blocks. */
 	nimaps = 1;
 	error = xfs_bmapi_write(tp, ip, imap->br_startoff, imap->br_blockcount,
-			XFS_BMAPI_COWFORK | XFS_BMAPI_PREALLOC, 0, cmap,
-			&nimaps);
+			bmapi_flags, 0, cmap, &nimaps);
 	if (error)
 		goto out_trans_cancel;
 
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index f4115836064b..0ab1857074e5 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -13,6 +13,8 @@
 #define XFS_REFLINK_CONVERT_UNWRITTEN		(1u << 0)
 /* force a new COW mapping to be allocated */
 #define XFS_REFLINK_FORCE_COW			(1u << 1)
+/* request block allocations aligned to extszhint */
+#define XFS_REFLINK_ALLOC_EXTSZALIGN		(1u << 2)
 
 /*
  * Check whether it is safe to free COW fork blocks from an inode. It is unsafe
-- 
2.31.1


