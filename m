Return-Path: <linux-fsdevel+bounces-42978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F50A4C984
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 18:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CF0D1888DDC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF1E253F1D;
	Mon,  3 Mar 2025 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kaa5APk9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R7HzRRqz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1692253F04;
	Mon,  3 Mar 2025 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021924; cv=fail; b=i7U9zy23xRAm0LYl9aU9JgegaM/7alKAcJv/rWrDIcfJ+EbaPnlLQrlgn+qOte56KBRy3qfEIRKkj/YMK+IH+Xr2DNDMzH7Wr5E0GkwtRBlBnyhZLWXwtovAUT65RroW3PwcTk9SlLDkpWElHn9grJx1UGbKZksNQG7hB5QRpEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021924; c=relaxed/simple;
	bh=bt0DPrJNxwV6eLygdi3EMJfNWzPthARFPqKzxNGPucw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ekQljU1CUn2pOTPEMB87kJ1NjBUzZ/fMhTPtro1IS+fbzmFJJwm4ZWyr9t45DzgNFfmypHZDtKz1VNbWkc5MrbHNN8txMqO7mwYo6ERkxKx23k3NCabHOe+9jCdg/BBx0EM52zzECgFLJtxhRw0DP2idzddN8qh8o/O0XXB1OwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kaa5APk9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R7HzRRqz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523GHJ2Y009330;
	Mon, 3 Mar 2025 17:11:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ESS+WT8jtxmYZ2r0ZqDXsdOl6DPejybb6wc7DL5kslM=; b=
	kaa5APk9wBjQVYD1WafC44Ba+e3rXq3ILDg5PMNlzkdW3Z9ya6Yp5lxACG6dU1ek
	GacoFoEOnC0UK2jyfHcn/YeGBuxZmrarNNUi9jHb9LQZzJ8LZ/4jeEzQ/Oc+RHEE
	dBxKhX6qFpkNL+lesLvd3Df4ST7ftvG4Esxy6mtbY8wLL7yfT40l3gdGJLwVEqbP
	oGQ8ZOPA3L4d9mewK1MCw0Mvsarfuz6LzhV+4mmYPfat0kwdEvzWGQ+FXYxXnavD
	iLUe01X4+V/AgimgPqUVWt827RwYpWlHcpHFtFRHhBEJnQRPtNF/GfNaXCqpHvC0
	xuoHV9tgi2FVseNdZcFhGw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8wk50y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 17:11:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523FvD9Q039093;
	Mon, 3 Mar 2025 17:11:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rp8g9cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 17:11:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9YxEagkhXp3xUOKMWPAhN/ev0hQnnD1TlXxucNIxQmZ87QX6U81OCQWjrlEWjKRj9a5qTvLK5B3Otn5ATMY+DuChn5yk/M4cVoN8o/vQSLyYfTf/vtmUtN8GaHS5wHCSEfgZ3XifLF9T85vZdVM2VNxh2q06oEkK9hKyvq/uGRBnFgwXVBEvSvyf9nWPaPdd2mqQzIuQyZwTU0BTvI/WXxJQvG6AqMlTdHwUivNlA2aKSDSZ3kXUkZHS6YItoaaddwwHSHMN3YKjyC66Mqb7JItmxIzGoCFygQT9eX7S5inpc7REz8ApwnAfWYwODsIostNza2sy4K9+t2rOOyejw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESS+WT8jtxmYZ2r0ZqDXsdOl6DPejybb6wc7DL5kslM=;
 b=iUwxzkOfu3gYhU1SxH6qGpwQ/vWZ9KrvAcLXGGdeAj801+hV+LXkrPutXamQL9j58zop6rydk2Cu7vqRVBUIm/olAkqLAfL7BT9OKR/Dhiz6mYe3oR5+7emHs+/AWstwgHMu7h9IgFbtchjXfNH0HLC4Q1ekvOBkIrDFJIPS2B/myCp0+Hkxkoo0/UwPlKKNqELrglWkURGMolvHMz5z8CPYU+sbOBo+07zH/JlZ3sCMy/dr9Pj9qs/5SVbdjJTsv9bKN3NLVboyY/ap+IXHQmrvaSZyrlejEl3HSHz87cbVIiDXgM7F+Q8caEXtnfjrXeynUGZW4Eo6Ur4zDhOvDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESS+WT8jtxmYZ2r0ZqDXsdOl6DPejybb6wc7DL5kslM=;
 b=R7HzRRqz8l8n5X1onYZbqehTK1eu2DbfNPwOaYzApN0aeFRVFgsmwTTlhQFBWaXVPVTsuqK0yl2XAOL+NkRJB+zFBwzideGfdtHm4OSQ972gWXRxphSVSVPtB870Oac1snMAkcAw2evxNdCqXlWUBTas5+cZbgC6/LK893AYoMc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4696.namprd10.prod.outlook.com (2603:10b6:510:3d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 3 Mar
 2025 17:11:51 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8489.028; Mon, 3 Mar 2025
 17:11:51 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 06/12] iomap: Lift blocksize restriction on atomic writes
Date: Mon,  3 Mar 2025 17:11:14 +0000
Message-Id: <20250303171120.2837067-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250303171120.2837067-1-john.g.garry@oracle.com>
References: <20250303171120.2837067-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0038.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4696:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a205fe5-9a32-401e-3b79-08dd5a767d43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SjbU6M0SJpXDQdqkOkaPXB62nnVKgBaVQQ0F6bBK9ZOOZzywq70+L0e8gOBe?=
 =?us-ascii?Q?nSiZyjzVgtTWiFZm0eLGuXA5UZc2gkOgGe5RGadz5YS888lnJrKEFr3txLHE?=
 =?us-ascii?Q?ABUw4VXUFpVu5ZGbX35RYHH3V50gcPODwyk9S2FdKoRYT8ZknXewZr9lyED6?=
 =?us-ascii?Q?y+paMdExNEq/EGUz7R03z39OU6LF9F99xzRc0xiHmQEfWr2Jx4plc1sbzUQF?=
 =?us-ascii?Q?YIeco2sEYtXSsanEr4uiL38UsWyBD4KIjg0nKJcHO/cscMsTOALhVAh5JVZU?=
 =?us-ascii?Q?BVv2tJZZ6OhgZMBIuj7h1ZxPavbunzuaIZbJkjvucl1zIEW9ml0K2lrDy3VF?=
 =?us-ascii?Q?meiA0dIuV1iMTtaOlMhDQaGNwV9CPOIdU7OCI5SqWF/TDbDZHP5NWyLk/kHR?=
 =?us-ascii?Q?JIZT2R9UkFCE8kPsQfNXVTlqylbOWsjnReMDLzjrC1sj0yUOZSgYcYbqUrPK?=
 =?us-ascii?Q?RCbghU2R3JUONA3RHREHnkmkVzjVZLYE9i5/MGm6P1SL2uS4gq+ht9qMHsve?=
 =?us-ascii?Q?ttURbG3DHjSQMCuAWVFQ9jiUtgUqJNv1Ban8eOOuhRqJ2XaddQbMZzz0jx5k?=
 =?us-ascii?Q?W9TZallhD2Z5iEa2oBH71QHrdDFYwwLOcZMTCd+TNpgj6jyhw7va4C5W+Sf0?=
 =?us-ascii?Q?GwvMfDV+QPt8gbtqQ1QmbZpzMyzU0KkhMXRtf43sDiuXZ4gT8MEDfQ9MtcyZ?=
 =?us-ascii?Q?iDa5zJXTWfTvsAZERSigQt9QYxTjAQQQXWo/W15EQJ0DD/IGS6nREg0afe0t?=
 =?us-ascii?Q?s5izE4jSgOfASJo22kWY96D4PpJWl41N1roz7+9ucFLV9+hzRH2lZvvFmXD+?=
 =?us-ascii?Q?oHp4W4IfdfUGrGTMocO8rsBp4IOWmjCjmeSloUENdvVZo2Ql2wD6fzn/5gMs?=
 =?us-ascii?Q?Q7zIfG/xm7aG1GH1kMSkYNntvfw0G7rE2LCT8A87lzs2u9DTYzrvDlQ4iGBO?=
 =?us-ascii?Q?UihVqK/QldD11AdiPxDO73gbsdSYZL9dcOLzDMFuqimt4yoCk2q5Ls444pRO?=
 =?us-ascii?Q?dLEXc2RvKyvnzuMXLW4assa84RkfUO2FtlPEYhOUqL7DXacVWIGQQbuutHVR?=
 =?us-ascii?Q?x35BALFoiWglYs/JylsIoCjrx5NCAz/fOUPQ/AaHumPDqleRen/BB8nT3bDe?=
 =?us-ascii?Q?/fp4O37dZE0ppW3xFj0ZeNsdmrIjHl4wupKbRO89x4BPmJ710UWmbJsO7mJ2?=
 =?us-ascii?Q?1mE/i3Zx0sdrnjVNFav5SYfE1QbYECjTe4O2C+KG7C0BGOvO2yI4G6aqU2uW?=
 =?us-ascii?Q?p1wnHldqaZ6SGczKE9l8i9ZXkUT1jgq+mBfNxbZogKYkCW7Ykjy59Bk+qxff?=
 =?us-ascii?Q?zWeuyYcXMeCKb5OIgr6Vt+gurT4hLm5iRB6iD/K9AiGHb1hHUBJoqdfbzOin?=
 =?us-ascii?Q?ISZQ/J8fGrHMPede+oxuTjL9Pb5v?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+0Tt/J3etDKkyPW+t8xlsqsOmvB+iFl30cX6HEakMXbHuaIJBWKzMzQpbKPa?=
 =?us-ascii?Q?ZNFflD2x7NM6kTY7wrA8Riku9S0UW6wsqNENCjvPAmEaCM12q6ZRk/lo179y?=
 =?us-ascii?Q?xVPSTVeaG6WBjs89XObwGupn3YeQxZuz7VeagKHBMPfb3EeO5hFRxB5AxcTA?=
 =?us-ascii?Q?Vxjxy1hHhMkwf721BVgeKifDCvN6tAkyWsuynHnveP7gBPICNpa38WkULjuQ?=
 =?us-ascii?Q?NndBHfmAgTAw5uVPZm1WT6IN+siyGtRGFl43BvYz0wFlp7kqpsAgpWSlJtQV?=
 =?us-ascii?Q?UxNr4rNpfhZ23e9ois/s5zEd9SySHz3kLGXIjEiz0e4f+KkWX8CRtURKpFe4?=
 =?us-ascii?Q?P4q8kEaJli7dhHrfdykzvo0CynRbmnqs+bnbc4nP8TNu/9HVs9tc+nV0/0VG?=
 =?us-ascii?Q?07iYVLdK3uZS4PXc/y5yXRZMDhlaFVKTTohf8nO6LPuYB6Po3IyCeTn68IC/?=
 =?us-ascii?Q?iIfW1A90VGwj3CZyIurpHrRbVasouJle6zIxvDeUBAygqwmQsk3ePuq9iIV3?=
 =?us-ascii?Q?L+EfzTC9ZU7nuahThXM8DFxXMTr0Tw7a8YiGaPSuW6E/LPw9Xk7VJAdQ0wgw?=
 =?us-ascii?Q?TSvq9j3krN6k+KxQSNQ2NIKBEVGW7WlCglTKswij6sq1YlVRbBWqHjHDCDcA?=
 =?us-ascii?Q?fUyroZD2xzeyWr6RR47zTWw1lcQLdsao3ElclE5IntQpZsdF2Avy/ubc+vBR?=
 =?us-ascii?Q?skohMN8M852Wz0c1Od8nXMy1n3foR/rG7Ar8znfnMktsx4xPY0VIAgCZZK2x?=
 =?us-ascii?Q?0JCUBn3HLWKsYlV8kowYKHGmNbKoEdjt5xoNicKeMVhSw0sD3x3JtE6vGV4s?=
 =?us-ascii?Q?zobstBcEmgtnKyVhogDeuN9Aw2Bt1I9WGRaKrDkMKZCUMassTv1eRYDKn9m0?=
 =?us-ascii?Q?zvbngbsgBnmuBKFUejTigEplAW2QBvmjndaDCYsECG+iDQ+UrM8WWtjZocSF?=
 =?us-ascii?Q?+dn/v5Hf4kkIfKDB+OFZfl3KYcK3a1evqxpSKzJ+FcAqb05gWmU8oKOw5BS0?=
 =?us-ascii?Q?KgfCwODZpVPRIKME8iGUI/xWdtsAGVdaVASbnsUYqDktf/BcIC381VNnQaee?=
 =?us-ascii?Q?DJt13nA7alq3wZZm7u45mCPj4UaYkmMQu4y3tLdcdQp8V/pxKnDGQ8TuyyGi?=
 =?us-ascii?Q?xF8VWqx00Q/5y1j2Ik+EQCGY2qtoH0ezohJ6/y8MGbQuCwAdQ+5y6RZFhSSx?=
 =?us-ascii?Q?9o4cBXAk/pKP7GFYxaBlSD13Y+7u0Yinue6C6WYdpdnNH13EDkFcNcoz5wJz?=
 =?us-ascii?Q?31o88WC+KiGu7esUWqAoflnrq4Kn6igOKQGmPVCpPG+ZtWulj3lWGCPr5Bv4?=
 =?us-ascii?Q?8oEU55wYR4QL+syKfB1421syJ4+R7ybJ+rZcVjWgJ3iEWindQFyhRmLA5Hov?=
 =?us-ascii?Q?9INOizrIhG9+/oKujgxe2vnd4Eb1Hem237Vm5uIIsiBiWrzyjv15QFFLJfvf?=
 =?us-ascii?Q?08ksLHVddDyngPs/fXDB9Oc8Ld/alQNkQb3ZY7h6UElICMh6ChjLVbIZQhTe?=
 =?us-ascii?Q?DEiiwTlt7hoSwOf6U3LmqMj36mO6Rs690l/vuOAbjftQ51e5jfFChAEiHdkO?=
 =?us-ascii?Q?9n0dsM1sR4vPI1NWz9pgJcgQ8VZe2a6JZ6buWK2u6lfkWMxX6SNc5khM2m73?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pOtgHFRBYfDPjvSv8eWod9LZ5wdBt8e9FOhI1Q6KbbO4ZJ+GcOi/+xAqlAe/1yV6j+xc6jt/El4VSjuIbqD6PbB3JOh0BSxzce+UmfwQdCkyUAX6eDORGV8RGudDo63misthomQYHMF/DaGYNwNg/E6gmRAN2j31HVJu4aAGldCsd2vjzryACPcxdDFodzgRJCsILdcl9ZxyKSa5nonxkxuvi3rNFLVoe9HdoijWNewgVIc2OZq52LpeAz/gMiXPyQLFpnLCW07U9i0U1PQEJ+fEGqGJLC1xHUjVgHwvV9jgvEgvEbyQX56lsOxzK+Fyg4qpJV6OWZlsfLkxdBA2NqGtyOOhSloFNFPcZ8CCG7Y+TVKsiNNj5me0wljTBWiQa4Z8LUwx9GBroIZYG5AIIDqOv7tXL+fEo24tOJydv7vt/zyYMXKhH8rrgIkgOKWcjyA55gjvbcdwsb1raGy3aESBvR8sbnXi60sjJPLq5gT6vyBpDak1Rg7cYvMTuW6ATVBrIzTBxKHKNwqPcaYGEGlITMf/e646IS21ZkC8/jVk1mLY3pgSfUK2h8hEH9gQkTGjsNCqrL5PryhPmRx6WdmFkuyd28SSq6t01cpfnWE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a205fe5-9a32-401e-3b79-08dd5a767d43
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 17:11:51.2758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZ0iQIjGJB+pNi3oibDZS/fXzBJhTHS30hAIf7zLKi00s+fQeJCQ+HpNjVhf7+WeOX3YKoRMGbBVw2A/PiLmTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4696
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_08,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030131
X-Proofpoint-ORIG-GUID: jVaNrOUV4R6fNiH-UoOosb7qYtFzYxyz
X-Proofpoint-GUID: jVaNrOUV4R6fNiH-UoOosb7qYtFzYxyz

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

Filesystems like ext4 can submit writes in multiples of blocksizes.
But we still can't allow the writes to be split. Hence let's check if
the iomap_length() is same as iter->len or not.

It is the role of the FS to ensure that a single mapping may be created
for an atomic write. The FS will also continue to check size and alignment
legality.

Signed-off-by: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
jpg: Tweak commit message
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/iomap/direct-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index c594f2cf3ab4..5299f70428ef 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -351,7 +351,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	u64 copied = 0;
 	size_t orig_count;
 
-	if (atomic_hw && length != fs_block_size)
+	if (atomic_hw && length != iter->len)
 		return -EINVAL;
 
 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
-- 
2.31.1


