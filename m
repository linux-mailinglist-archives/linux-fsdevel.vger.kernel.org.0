Return-Path: <linux-fsdevel+bounces-26478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CF5959F4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 16:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D0171F22F02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 14:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BD71B1D43;
	Wed, 21 Aug 2024 14:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R5gFXHvB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CIO7McFC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB4B189908;
	Wed, 21 Aug 2024 14:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724249355; cv=fail; b=pRIo/VEQfYLMlYl+/653A2tGuOOO9q27X9XPyzAynSqjLxDFS49H2KS6BZCNnFY3ow5+if17z4DsWXQJpRJHvQgS/aR3kWWpQR7lySFJ8FAZjLQJ0uUdIBx1K9URb24tm721ANtDSnIdn//NqxWN3lVxIlCbwVMvBuh1QvQchyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724249355; c=relaxed/simple;
	bh=Y8i3U9Pu69H7+WF/krgDllB1X37sKrKpgTwZCB+0CRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lO+10okpvNwnSvzL6YcsUHsSAQL+JKidkY++2GFAI35+J2Km5SxMCi9snCkfOLoTafTsuF+82iPN10+KfTI6ZXT4NfByHiYF2OiBr9M1dmfgUyor4v24r3qUSluqkwOfxMFCBQ3G7TdV9M47/BFRctFw9ChuGU4fuXfS2Q+Ccps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R5gFXHvB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CIO7McFC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LDIXud031845;
	Wed, 21 Aug 2024 14:09:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=4nxaU+ep4gDasdZ
	Dz95bwOkdbeOF9F2/mnNjB4LtYOY=; b=R5gFXHvBRw9S7wxYvZCN/eLI8mLJMif
	/UlPkU8Is3FSIV0Cvgg7vTmWJ0tPKrAwGkvwAc1DjDBHrSDc6EImUT0kt8eB4cMw
	Gk7TMVLqGAbglw6GCuV1NlkkTq/Wdj4C6irb3Q0zB/Pt7nWHGt46MaTtkx8hkrxW
	NkOET3mpm90KJltedh9atcC8UtTLcombIDocTi6UdDNKAhwSRdhnpAfJEFOUmUMD
	0FKoaOAT0Tzk/M4NaI5EFKRwJwW/AQpfADI6hHxWyJA/qJIZG3oSvDBL9e+SQ+75
	MRQjRAty+1XN4AltnUummFGzAdBtSUdswlqQFzO2GZP/IUMX2gwIpRg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m3dquc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 14:09:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47LDu9T8019018;
	Wed, 21 Aug 2024 14:09:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 415hjb8pnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 14:09:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZplAdAhLFdMDY0G4vtWZB31ikXQ1BXvQRiEuJscFAY4lEgvU1zPDGRRV2VPWIW6BI+8wGgWInfDZOogja+dSrIlnkrBSqgCwhnB7tZ8gCRWw659Gx4k6ES6kANaurRnS4o6plNTdejAWOupHAXUu5z0YlZ49T76NFcakeQIR8QA7mjKG4Xme/LSAQc/sRNi6UcClMmLd7dp9PqvgPknnb63V4Ebz0rUcauVzw5dIXtVXccWvcXm2mNBpGpj3NoYXRfH7bk0g4Z2xVH+26Su3DvcDPVByt2kb5YT7c/jgKICwsk4nyCnC/UDLT86bZv/QRu7hiJ5Aiu9bJnGcOuK64Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nxaU+ep4gDasdZDz95bwOkdbeOF9F2/mnNjB4LtYOY=;
 b=y8jxnYe0rwO8NmDPlYOCcShhdVK1E7mTwhX+g34a3+ze1IWVmsNOSxzN3qyCqkZ7vnhI4d7/4Yrt+su6WDRw4AFuT+ZAHqB1YV2JQNlbGajOh8P6ivuOZnrnX4frVePGeOAPRnykju/tAUyJHqQSSudikqZDdLQjx0SBaASE9N0xkNM248S/Z2eMDvLs/agHH2NZNsJEe9+ddkerftON76rP91A6YpjvgmlKP7Gb7iIelKChEukywxd74Blgzdm557zrESr0dZ/bmXgsQlA5eMVp7F2kIslccYTFXb49V9qJTbDqJJQz+0J/KzBs0X+o3SaDS43qtsrjw2Y8qAiZ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nxaU+ep4gDasdZDz95bwOkdbeOF9F2/mnNjB4LtYOY=;
 b=CIO7McFCfjehnEaHtnlAVi4EGhm5zSvA25pOedwlS+O87B1Wz2xl//yq48NrVnjNRHIfT+Gc5Rdon0KxUtDWCP6PytVBGI7I2Z2pbUIi6sCMVoBqF0Zk0j8eUXaxV4uAtTgrkhm7W7cK5jqcCOtHgMvY8CvaSTglXm82zKYOYxw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB6584.namprd10.prod.outlook.com (2603:10b6:303:226::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11; Wed, 21 Aug
 2024 14:08:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 14:08:52 +0000
Date: Wed, 21 Aug 2024 10:08:49 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: andrii.polianytsia@globallogic.com
Cc: linkinjeon@kernel.org, sj1557.seo@samsung.com, zach.malinowski@garmin.com,
        artem.dombrovskyi@globallogic.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        Sergii Boryshchenko <sergii.boryshchenko@globallogic.com>
Subject: Re: [PATCH v2] fs/exfat: add NFS export support
Message-ID: <ZsX08VdaPhhzcuUD@tissot.1015granger.net>
References: <20240821125137.36304-1-andrii.polianytsia@globallogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821125137.36304-1-andrii.polianytsia@globallogic.com>
X-ClientProxiedBy: CH5P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::8) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: 24597a14-c912-452c-a71b-08dcc1eac963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6zv1upkfbaZ+WOKCfz+1uUGSsPGXSm44gENNi0ShUMng/9xCGgh7ZqB92nuF?=
 =?us-ascii?Q?EaNDI10SHp/GGAn+XfT0Pe40SAamH9GX93pLfHFCfzgH4mJa/rvnz4aTILad?=
 =?us-ascii?Q?tlSYaMmKkrxmpImLnLDl+US78JFoDLT8j8PAbUFGdXWb5sZ+/++6awTMVPKv?=
 =?us-ascii?Q?uQEUZXabPBc7rtV07OnYp4CSFhMgblVrVXPjkEgt9EhtQeda8gc3HjduE2QC?=
 =?us-ascii?Q?LLBUv3kUQrEAegnsyOlomFe7TJXiAyRcl/+HCtfDWAG3ZwTrFlq3qoNvw0og?=
 =?us-ascii?Q?EF8MTNXZlzl/994XbdkfFh1mWXcZyvxUal7couzZHEV6CyVw8OTSEng2Oe1W?=
 =?us-ascii?Q?6i3ww56bHzLx+sAvRr9AMm7tYAh08drKCYY9LQIVh92m4UcNgSXes3GIUius?=
 =?us-ascii?Q?HI+ai1Vt9ow2DFX6COF98PpGkYzFCcx7FAhKDs8OXDW0vHaZj9qghffsYSqq?=
 =?us-ascii?Q?ew2cXd02mQvtBUFfjmFbS3wZi5GbaPDyVL7ZYxvp8c5Q4WZCKQLRR4UqRbkN?=
 =?us-ascii?Q?hUUaLIKcHxzUPX3qxphfoe/R/Kz/CapyenYEtbXkdgf/uhMRtdc5jmP0gr4R?=
 =?us-ascii?Q?gZfNurNHyETb6IgB4LSNorPnJYqCgPzNCAEUTm/TRB7we6qp8Png6sedV08r?=
 =?us-ascii?Q?SQjzqlQt1VKP4r4JGe96Dg1cNYywm3hUp5Jx+ZYOziltCkFG7b8Wo+RNldzG?=
 =?us-ascii?Q?9FTuOvO7hccxLqLGnHr7RObOvASxJ3q+Vll7zbmmXD8s69HPCZ4cd0ACo2aW?=
 =?us-ascii?Q?y19x2bXe6aghJMGRo5WXmQQa4lY7KkKLD0O7KEt+FUqC4UkBN9HRA230Ssht?=
 =?us-ascii?Q?aIhqAhV1jrBTg6PW5IPpc4bOrDeRNwYNzJWAndnCxGS8x6qGwH+Baa8yLlE5?=
 =?us-ascii?Q?7ocUPlsbW5cVdFTpMLzdWvdlfpkEYIl+5SAVuSPPMCafFltisJKZ8qghgXTY?=
 =?us-ascii?Q?Tpwy4f8RyCukRd/Pqp3ZQvewVHS8GDyuH46a2fnIqvksXAHSMlP5iRVGlY3/?=
 =?us-ascii?Q?tVV6zZSi4ygU6mjWYZkEfYKbnfYvAWfQ5Ck7NGB7LFXfmbWEqvDtH9rZ43rC?=
 =?us-ascii?Q?mEYrWJIKfCkRjxFLA0Y34nP+gq5ED9qLexJNBAx3SsvrPfkHTFiKOR/BfnD4?=
 =?us-ascii?Q?9AsY/mXdkPfg039fO4RuFD3Vz6iPhji8mIi0vXQTXA43BeCZD5YTQu3MTvLi?=
 =?us-ascii?Q?UHHEJrc6VCxvB+5q2cZTTohPAna9PIv4ruaceZZNn6josoH5QTVKv4tm+932?=
 =?us-ascii?Q?jMBbyTEwVZ+s8zlmAzJFVy5WvKus7J3tBmnD2r4IVNYDJeRDZ9Z32bcRjtbz?=
 =?us-ascii?Q?2CDtRUQ9Sywi+SHPhDTyDABJ4Ppw13B10BxHmWYgIMTxsA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j9i2J6U02ZyTjze1G5M5T051vhV0OKq2UB3UF2vIEIwQV8tHO3PtqaPhgwvS?=
 =?us-ascii?Q?wjZeskMxCAxSkFfw9eLcUy0Haf9eHfGpl9FtVQ2cWTS2smmw1tRnvFVBSrY2?=
 =?us-ascii?Q?4svIhT8fSf1EPEW3qSLU3dq9TTvbScTwG9/BJq2FJY/dHjyUBK02dIwIae6p?=
 =?us-ascii?Q?Gp1/UIpQINITU4nR0FEUf2GVXgxtsJSTBrHm/xT5KDgPFMWGd8mIgRSOOE9M?=
 =?us-ascii?Q?XzuFwUEkdImqVmwGQs8YhXVavuKknQ75JFfr6lx/8mmJorOoOFLp8tG7v58g?=
 =?us-ascii?Q?IeGNkml0SJBajjZ0mMbK221X4+oXQ9tJu0Nnbw9LI+NeMGBi/Zf68O7P5R6q?=
 =?us-ascii?Q?bpB4Z5NX28IIDQeDqrkUumHw8w2lbVrVMa636ingGTQKbvdkG14MEQIk/xKz?=
 =?us-ascii?Q?68HtzpDhVvmpGJwIhspcwQy84Pglf1oHgD13mQ0Naw6soWfk6xQG2NJ8B+Ge?=
 =?us-ascii?Q?TV7ZuSGvsCO0Xz9cup5iaNpEmC65zbbXNifaYziYNuqQi+dxIW9FAkt37uWq?=
 =?us-ascii?Q?vkTVxAJwuUcXskbZ0jRUebwmYRyMvfxmG2riGYbPnjD11ajfu7zF0sLHizMD?=
 =?us-ascii?Q?RRkg5jmzmgAyorvZ1SN+DNo0PUUSf+xEYkNqADSHHlEwVLKcDRFRiSODW0gr?=
 =?us-ascii?Q?XziiFqcbzX9hfeYKBPoVpYif5w04taX48n/+yJq8WFId1ePMOhlr8kHu5/Vk?=
 =?us-ascii?Q?HnPQne5Ln2cdQhflOQxI7nyqOCDhT7Ax8oa6I3nw4eAX7B5Nh8pr2BnwD62V?=
 =?us-ascii?Q?j1j3GDhdvXK6prGaZ0dkeLA3Ns4pNL9sTOXcfdGB/sbA642qDJQ2fKvrFA21?=
 =?us-ascii?Q?Hf62Z55edvyznv6WNblhaqOLtNj8tgmy6+EkzrQClkHVSAhhRnXBRebl0hrB?=
 =?us-ascii?Q?72TCfs3vYG7pBjinixT6akpSDQ1dzgIfcfd7jGYF+nuO4A3o2hed7L05B5ra?=
 =?us-ascii?Q?DiYA2ZwSgdqkrsDFnyxGYhn2Qr7RssxWMsJnT1+FYt4BP68A+pQHxuOyYNUK?=
 =?us-ascii?Q?1hkRB+6j9jcjS26tiICSnKLGMcc9mwmcc3ljgy7SUADiXoCsgh1rLxlhAczt?=
 =?us-ascii?Q?lU89rTtk2fDrCJMsXKJYv9UFbTh73kUU0lrwslR1mrpmDqTa/sQCiUOr7nIm?=
 =?us-ascii?Q?Z4/cQ4QGfnaXHwtHHI/NGF6QavIdQNJq5cwrrCxln4IcIqpVQsxkoD/3Sr0q?=
 =?us-ascii?Q?3X4nIuMB0H0YMlbMnBQB2xcR3tuCARCqhWal367ZE50gOJIcODB0GLGl4zRH?=
 =?us-ascii?Q?XCiTSoULQu02P1f1na2AnZBez/qWHVgdkVq7OJHY7Je7Ev7VXTJxW1f7LDMk?=
 =?us-ascii?Q?Iq6g/uhowPilxi/K9UMb9U1b5GX2dXqL+0+UvhlNbQWdibFbrUGxrX7nPI7a?=
 =?us-ascii?Q?KYMnE4id4W3wIrAmxe3ZAipbTCUnT8tGZB9nCBhQI26NnWKEYfWZbirdJJrA?=
 =?us-ascii?Q?t31iV2H5Jm3M3JyyUMCJOnhQVkX2yDEhlkojIN9aT4hAn2ElOjA2vayqAuEk?=
 =?us-ascii?Q?t6rPKboimndX//QBPAHO4Ny4VeDIBrDN3qSRkW6hD2u8I2mzteZMw9q48eyz?=
 =?us-ascii?Q?vqZEI4bEimNyJxD9VSoOndN6L5w95XpOzY04WWcj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QLteXaFIqeEPjLD62aO0M2jHBY4evfjQV5qrNngxi0K9bfwpIzuRlM/kdrnKtS7FN9NLAixgMSotRgrZtk9rUHdmoS/K5JysxJQMcazdsXDmmY9EY7VE+OwVYEtVZorV9cC48icVshHTl11+aaxmGnxnwYYfotaiCiJsIBVj+F3QziRHxbGr7FhC9ZJ7vLxfueKtiswz7pbQoEU8Tr1u6OvhF1gVlLV9u+dU9sv623MS+jeMAPbgqdfv9Y1rDLp+6jv9kPgEikVFsVLxsgqc0wRqtgcuAduZLZi692/S5zvSikob1GMqSnxALbP8j3tJTQqjvh4wyaCaSvE/wUDmxDk44NqqGyRKeNbgFIfQlapeI+aZniuNL1Io8PmbTDR7bEfY2q3eVhoC4xQ0mR7NXO+EmhyNvhr5PHr9NFFWmEzJmBOL5feLg2C18Ehas/Pw8Fxav44ufHvnOnkwAVqa3e5upoakfa5ywXAklpjHHLovdzIA0e0WpQp57ZjT4m3l0RMIaKAq2GXvSjjVoJM46eU1vk4bkvHeDQTxiCNiM3IBkt0PV/qzu3rlLhCUYRN5yyw70hry0zqdEH8U840hbJFUbWxDMM3DUb+N77MwoC8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24597a14-c912-452c-a71b-08dcc1eac963
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 14:08:52.6069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ru3muZ2XeIMoAzKgoHmXedAI/WsepY8oyRu880iYPA352BEGN7BEga4Ms/3BwObM+o/SPVGd+T9iRjhkNIRfEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6584
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_11,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408210103
X-Proofpoint-ORIG-GUID: NIq6VBEJJ7zDex43E5fwWlcKcHzBCgol
X-Proofpoint-GUID: NIq6VBEJJ7zDex43E5fwWlcKcHzBCgol

On Wed, Aug 21, 2024 at 03:51:37PM +0300, andrii.polianytsia@globallogic.com wrote:
> From: Andrii Polianytsia <andrii.polianytsia@globallogic.com>
> 
> Add NFS export support to the exFAT filesystem by implementing
> the necessary export operations in fs/exfat/super.c. Enable
> exFAT filesystems to be exported and accessed over NFS, enhancing
> their utility in networked environments.
> 
> Introduce the exfat_export_ops structure, which includes
> functions to handle file handles and inode lookups necessary for NFS
> operations.
> 
> Given the similarities between exFAT and FAT filesystems, and that FAT
> supports exporting via NFS, this implementation is based on the existing logic
> in the FAT filesystem's NFS export code (fs/fat/nfs.c).
> 
> Signed-off-by: Andrii Polianytsia <andrii.polianytsia@globallogic.com>
> Signed-off-by: Sergii Boryshchenko <sergii.boryshchenko@globallogic.com>
> ---
> v2
> Add information about similar implementation logic
> from fs/fat/nfs.c to the commit message.
> 
>  fs/exfat/super.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c
> index 323ecebe6f0e..cb6dcafc3007 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -18,6 +18,7 @@
>  #include <linux/nls.h>
>  #include <linux/buffer_head.h>
>  #include <linux/magic.h>
> +#include <linux/exportfs.h>
>  
>  #include "exfat_raw.h"
>  #include "exfat_fs.h"
> @@ -195,6 +196,69 @@ static const struct super_operations exfat_sops = {
>  	.show_options	= exfat_show_options,
>  };
>  
> +/**
> + * exfat_export_get_inode - Get inode for export operations
> + * @sb: Superblock pointer
> + * @ino: Inode number
> + * @generation: Generation number
> + *
> + * Returns pointer to inode or error pointer in case of an error.
> + */
> +static struct inode *exfat_export_get_inode(struct super_block *sb, u64 ino,
> +	u32 generation)
> +{
> +	struct inode *inode = NULL;
> +
> +	if (ino == 0)
> +		return ERR_PTR(-ESTALE);
> +
> +	inode = ilookup(sb, ino);
> +	if (inode && generation && inode->i_generation != generation) {
> +		iput(inode);
> +		return ERR_PTR(-ESTALE);
> +	}
> +
> +	return inode;
> +}
> +
> +/**
> + * exfat_fh_to_dentry - Convert file handle to dentry
> + * @sb: Superblock pointer
> + * @fid: File identifier
> + * @fh_len: Length of the file handle
> + * @fh_type: Type of the file handle
> + *
> + * Returns dentry corresponding to the file handle.
> + */
> +static struct dentry *exfat_fh_to_dentry(struct super_block *sb,
> +	struct fid *fid, int fh_len, int fh_type)
> +{
> +	return generic_fh_to_dentry(sb, fid, fh_len, fh_type,
> +		exfat_export_get_inode);
> +}
> +
> +/**
> + * exfat_fh_to_parent - Convert file handle to parent dentry
> + * @sb: Superblock pointer
> + * @fid: File identifier
> + * @fh_len: Length of the file handle
> + * @fh_type: Type of the file handle
> + *
> + * Returns parent dentry corresponding to the file handle.
> + */
> +static struct dentry *exfat_fh_to_parent(struct super_block *sb,
> +	struct fid *fid, int fh_len, int fh_type)
> +{
> +	return generic_fh_to_parent(sb, fid, fh_len, fh_type,
> +		exfat_export_get_inode);
> +}
> +
> +static const struct export_operations exfat_export_ops = {
> +	.encode_fh = generic_encode_ino32_fh,
> +	.fh_to_dentry = exfat_fh_to_dentry,
> +	.fh_to_parent = exfat_fh_to_parent,
> +};
> +
>  enum {
>  	Opt_uid,
>  	Opt_gid,
> @@ -633,6 +697,7 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_flags |= SB_NODIRATIME;
>  	sb->s_magic = EXFAT_SUPER_MAGIC;
>  	sb->s_op = &exfat_sops;
> +	sb->s_export_op = &exfat_export_ops;
>  
>  	sb->s_time_gran = 10 * NSEC_PER_MSEC;
>  	sb->s_time_min = EXFAT_MIN_TIMESTAMP_SECS;
> -- 
> 2.25.1
> 
> 

If NamJae is interested in taking this patch --

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

