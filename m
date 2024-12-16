Return-Path: <linux-fsdevel+bounces-37514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F619F37D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 18:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E900B1884202
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 17:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C30D2066FF;
	Mon, 16 Dec 2024 17:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Of/pPurh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tlNpnsDH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDD120550F;
	Mon, 16 Dec 2024 17:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371373; cv=fail; b=PPvh13WdjE7PIykDvfTuyfuLRxstnzBvrsLEseZNxLrlRHc0Fm0SIPGmM1mRvKuHbiCJpnPKTDT0TcCmJzZHPMA9GPATyJ0uSOlwpzXgVum+f2WKcUbHRY6MPG/zQ12lFmadpQ1HObzUP/GqVSxyqpHLUWbMJZNvBkUM+3Z7vwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371373; c=relaxed/simple;
	bh=i4x/Psj+ZpWqk8/5MBwLPuBS49DXmYL4yea3s/STlnM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qxqFgHI2f6TPb5mA4Ya5yK+nTo6lddOxWmH9OTPScLEo4rL1BeuhW348lxvyKW97K43XYi5//5rJgqM3JIQRfRpY6FC36fZzC2eu2LEWx9A3M0L6du9V4OdB3Ik2LM0aId1hBIVoCXICCG8GQUIz6FFhZB1ndbhsd/sMq+6uXbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Of/pPurh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tlNpnsDH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGHQieG010938;
	Mon, 16 Dec 2024 17:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/8yY+GDjfGZ5asEdmHWUfFO4y0wymExcmAU3t1IYyeo=; b=
	Of/pPurh19Ko9ku+LyFZ89g+YY+ech5MokEGlkcTE4BeSbDwEM7yEzIFKq1RoILQ
	BSsbSfTvi7FFZIfd9eaqxJMdX1CZrMjyosfBB4kU6Htxrk03NLkt7oW4J68JjGzh
	VLvw2LKCFj+Dle2mMYCBW5L88ia8hQq5pYpTOJu6esVzR1mlcqz64KQoxUm3QjUJ
	atwu3/7AU//qZ3gyHKTN2h/42SwXgdku3200Ng36rvLQsfPZ5Cj7Ed2rwiL7YgFA
	VU1xCnphDxvjruDnndguUJIeoL6vTmquh62qWy3NGp1Ncd++/W82y0+9up2pUeI9
	lQVSLCJjP5GmwDqaS/y3CA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h2jt3xb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 17:49:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGGLFL2032652;
	Mon, 16 Dec 2024 17:49:18 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fdkxky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 17:49:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usNcUKHpCesjlxf9hh7xypsZ/ROVnnMGsjwtP9FewMAT0RqLlsWjUZhIbryT42WPSiXig5Rprq0gm+9fWRWl7Mq4n66JN2CoAjowuFaJw7nOnBYRzxJs3mFJP8rkHPdED4JRdSgV22b1SdijBAqa6TEFzfqP1JiO2t47hb3qrc+VvcSLp5Q+Pk+epR4RVM4X+7cAmNKxxRWhK8cxDbp+6ZngRiNrcjrZTHaKB0Xf24JPHqXaIrULv7RAL5s1LYwC/E/XeQPxP3srPApXd0PlJnPQA6qFJ4gfKRh0FAQIiX+HNxn9PAPJGm6Y0WO+YLKWOIR94KYOenT7eQ/22IcXqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8yY+GDjfGZ5asEdmHWUfFO4y0wymExcmAU3t1IYyeo=;
 b=HM/FrMyYnOqBtPTBZ0tXDZGv0EDCVFWnjpez/xVQIOEdXTLbp12O8kIR8narVf+uMQBUKMaXbbQRMs+D6ix8hsLMHEQAW8FIlJ/gA7rt31L0pyVz2nh3J2tU/USDQi2jFzgqNsH/J6bJGqFW99ozkeao3UDZfwdHjyMhdEfQl4FenKm43d0XYcylh51hw5dUuiQZPy+AapT3WeRMuw8/YMl8W8FRqyOa8yv66ITM//UDK91VU+f5UC8l8M5mNWQK/aCUtFhJX/FvOgPh0XQwV9go9/+qC/yeEAbMxbVgS1k7Dsrvyiu/cO4kNXnpdZRuRUHqP/vwcYnmeGDkTzsHVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8yY+GDjfGZ5asEdmHWUfFO4y0wymExcmAU3t1IYyeo=;
 b=tlNpnsDHyvm17owa4AY5qG5ylvdVPtghRVIQsEDPvPsnF9mghdX24r6vC06Nra3/i+dZ11PDDQbBIvSTlJHdU+8BWaAUFHpTI5EBjIl8O0kp88PACsf3tmjjRgsnD5q7ZDFS5PXoAYSNQNL7wL0eK1hBMDOif0Grunqg454qQsA=
Received: from SA2PR10MB4780.namprd10.prod.outlook.com (2603:10b6:806:118::5)
 by SA2PR10MB4761.namprd10.prod.outlook.com (2603:10b6:806:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 17:49:16 +0000
Received: from SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb]) by SA2PR10MB4780.namprd10.prod.outlook.com
 ([fe80::b66:5132:4bd6:3acb%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 17:49:16 +0000
Message-ID: <0e5bdfeb-11ef-47aa-a21b-29c47069066d@oracle.com>
Date: Mon, 16 Dec 2024 09:49:05 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dax: Use folios more widely within DAX
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang
 <dave.jiang@intel.com>, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20241216155408.8102-1-willy@infradead.org>
 <20241216155408.8102-2-willy@infradead.org>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <20241216155408.8102-2-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0446.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::31) To SA2PR10MB4780.namprd10.prod.outlook.com
 (2603:10b6:806:118::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4780:EE_|SA2PR10MB4761:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b9c37de-31aa-4089-64b4-08dd1df9f3df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWNROUtKMG91NGZhVFpaU01teXpNS2RQMEJ1d00yTFZqRE5RRVcxREc3eWsw?=
 =?utf-8?B?OGVrKzhzTzIzWFY1SXF1WGpkcXRSVTROQnhDQ1YxOWxzSVlpVTdHbU5wZzVz?=
 =?utf-8?B?azROTW0yU2R0cGNXNlM5bi9za3BXa1JKMmFyWldqOVZ6cDVkVk8yUm9neHRy?=
 =?utf-8?B?VnVkV1BZYWg5Wmd4L00zSWt1eDNoMTB3elpteG9PK2grVFJuNXJ2S3MrWXJn?=
 =?utf-8?B?aU56aEpKcDBZVlN3eFVISEpKZnlvYm94aHhGWW12ZDgrRXlkcTQzbWNqNHRy?=
 =?utf-8?B?Q09TQldTY3BVdmF4aTgxK0xIMEs1b3RWenBWbUZFbWFMeTVHMlUxbEM2VS9M?=
 =?utf-8?B?MWdCNUtmTzFpOHRXaTZERVNFa1ZxSU5TWDZNU3QwRGFhNVl1SUVrNHdxOWh5?=
 =?utf-8?B?MlhyN1luSkxwWEtGQ0plbDdoNFVQdmFqbXZjN3kycElsNjU0MFY5ditqOFVS?=
 =?utf-8?B?VkpoQlc0MmJ3SmtEcjVwQm1OYUZTZHc0b2hONDZtK3JrTHEzUHltMDgyVzVN?=
 =?utf-8?B?TitOaHQ2U2tlL0FhWHBXQkZLZzhmcHF4SzNEenBSaitTMVdVTHozRGZnQTVE?=
 =?utf-8?B?R0diaFI4SVh4ZFVRT3NxcXFiMWdGbG5uY2FJMzVzeExrb2JvK0JWa0Q1K2JM?=
 =?utf-8?B?azJlWmhkLy9WOS9hOWFMK2Fqd2VKbVBvRmU3Q0FWUEk4R3R6TFB3VjBOdnc4?=
 =?utf-8?B?VzNSaUN6UVBxalJFaW9QQmJSZ2p5UXJaL2JhdnNiZzhrTmlRUmtlb0FLNitY?=
 =?utf-8?B?YzN5L0V4Y2MvMUpvNElYU0UvcjIvUlZBMHhNVWlKajlwUHFRcW1wd2dUdDVl?=
 =?utf-8?B?Z3I5OWhtektiUkVHYWl4MG02OHZJZUgwcEJYRnpnSEFmaklMbE5mTUNhejBh?=
 =?utf-8?B?ZGlRcVBnbUZrZGNmTnEzSjFTYU1pd1Y4YU1iTVBFRUZrb1JKV3ZnTnFCL3pw?=
 =?utf-8?B?WmpObUoyMlRkbzYxNWI0S0RNRFBNYU8wcjY0ZFVBYW5mRHJpWTlUUnUvMHN5?=
 =?utf-8?B?MkJ1UHNLcnFxMEZLcWh3MGpVR0xYcGJWNWZRUEV4V0treTVGbGlQTmh4b01u?=
 =?utf-8?B?bVdUTi9vaXN1ZWtCaXRlV2poTURyczhCNzh2RTJINHo1ZUJQVFFjeVFPbGNO?=
 =?utf-8?B?c01yelhBeUFUMk1hejZVcXhLRGxSV044REhvOEtXZCs0TmNyS2Y4Z0RvbC9o?=
 =?utf-8?B?RmtrL0I4YnhoZnFlOXZsUDFaZUN1TWxRQ3d1ZDJMdkQvVEI5TXRTb1R0ZlRz?=
 =?utf-8?B?ejZQbGNDb2dkWjhZcjlTVVVzOW9RYXJnazJvdTNpWUVlWEVxVW5OTWJGS0Yv?=
 =?utf-8?B?aytHOHI3dEQ3MTJQOVpDZUZXRXd1azVhOVBnSEdibzRGVFEwY2JBdmk2Zyt3?=
 =?utf-8?B?SS9GeU9uSVE5Uk5jdklINVAxMUlpNkZjMVNkb1lqQ3hUaVNwVDdxc0tBb2h0?=
 =?utf-8?B?RUlWeng2WEc3NndTUEJ0ZHE2ZGRkM1dlcUdGMGg3aTZmOEdtd09lQmttcWZJ?=
 =?utf-8?B?bGVScmpiUi9VUnpkZUx3LytEWllRNzU1VGRydlIzRG9DMitoU2JCS2dDTXZy?=
 =?utf-8?B?YzhsY1p0OEtCdjdRMnZlWkNQcXlHWGxpWGdpa1czazJVYU5TOHY0RVc2cDla?=
 =?utf-8?B?SFdCdW9YUEd3aC9IaGtXY1VhUXgycFlBcGdJaURPVHJxUXFmVW93Y013QnZx?=
 =?utf-8?B?MzIxbTdSdHMzUVBkeWJXQ2VaWDZCeHpsRm1PbVZVMjBMY2RJSXFibW9YZlN5?=
 =?utf-8?B?YkhGd25Dc1I3ODFBNTVINW44R3BMUFRibmdhTER0QU4vR1JFZ2txLzJaY28x?=
 =?utf-8?B?bFNHL0dVcitQVFBhZHk5YjR5c0R5QU9QVlFGTGd4UWdPcjN1ODRmN25XQk1s?=
 =?utf-8?Q?36caqQiZWW1qk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4780.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1ptdXE5V1NYZ29zakJmMnRMVUtuSk15N0FSYkZicmNUZFJFSlUxWjJBVFZi?=
 =?utf-8?B?U3hiQ3BUWnJlTHZtNTdkWkV1YTRCMy95VzFWeFJXRkJtMFhmaWZmdVlrdHBN?=
 =?utf-8?B?RFhYbkpiL1g4aDlBSFFUZkdFcjNHSzA0TEkyUnlBZ0JYdVpVSFFkT2twR3kz?=
 =?utf-8?B?RjROZjUxTTZnQkR2bWVXSm8yK3BhRzBwaFlVZDZ0ZFg1OE4xWVJvUlI2ZHUy?=
 =?utf-8?B?QUxDcjVrSGlyYTVyRkFuYUxCTmtlYkxLUFhldGZDcXh4MTlLQlRXdkpKWFIv?=
 =?utf-8?B?TEM5dzBHTkU0QlFkQzg3alUvTHdqSGV1bmlHS3dsdmc1VUlJdzlHanREM2Nq?=
 =?utf-8?B?amkvUHZZbnZpWncrSTV2cUhjNUJzb3VOMC9oRDFVd1F5WGk5VjJWbUJ6Mnlp?=
 =?utf-8?B?RmE2NHFZL3prMlBSS1FUY093ZnRjS2ZJK0NUMitDOVVpVmZISTgyalBSQzcv?=
 =?utf-8?B?bVFEMWFaeWVSTExKTTdvTHdnSGZ5RTdubmRVRHhSTWJsenN4dlhSR2MxYndx?=
 =?utf-8?B?ZmZVTFdReFRCYUxWbmU1OUc2U1ZwdEo3Vi9EUDBNcGxvZkJVSnF2bGpNcjFO?=
 =?utf-8?B?dkIyMFd4YklQcm5jRzVvTjJaSlZkc1JCZUNWdWgrRWIxSUk1ZVhSTlBOanVx?=
 =?utf-8?B?STA0YWdZY1pTTU9iSHU1UjBoY2dCWWVDTUhndDFjNGhIOWZIb2Yva2drdFNk?=
 =?utf-8?B?WWpab21XWCtMM0dOWU04aXhZaGZJNjVuTFoxcktBU3F1T0h6cVRuWmlQWU1u?=
 =?utf-8?B?MjNpYlBSc1J5MzhBOVc5bmN2RnM4MlpxaW5TSGxKVlVxNlFLUld0Zk1YQWt6?=
 =?utf-8?B?MUU2L2pyL1Fzc3lTeEtTMVNTOXFVQ21XUWhpVENaNEpEN1ZpQzJvM3VkSHhF?=
 =?utf-8?B?c2MyZ0FnRnY0RW9SM1ZSUWpnQnE4UEd1ZDhCSlcvZUJhYzhWSlA0cytXTFow?=
 =?utf-8?B?bVJsNTVRQ3RhOUVpUklNMkhuUEtManFiVkRXUERPMHBQazNGbWgzTWVBL1JE?=
 =?utf-8?B?aTFFMk9nTkx0MVpzbVNicXF6dWN1ckorQmExMkJsdk1FS0wxZFpkY0hDVWIy?=
 =?utf-8?B?SWpXYnhtM1JJRHNqMzJxQ2pKSEpkanZFNnltZUdjcmhIbmtmanRaamRBN3h6?=
 =?utf-8?B?UE82ZmJJaUk4RndKS3hMRWFISG1hYVNKZEdYSzJ2VkNXTk1OSHN5QnZNS1R5?=
 =?utf-8?B?OTJIU2NPRUJ4L2NsZnpkN3RuNGc5UmxGT1dqL1JlTFB5NkxJNTQ2T2J4cVNi?=
 =?utf-8?B?Q0llZHVJYUJPVk5hV080NlREdFZFWTI5cWp6V0RqcXlIUUJ0K05nY3ZjQk9p?=
 =?utf-8?B?MFhGcjdhRFZXSCtGNU53QjNkMzdRM054Z3labllpeXIvUFVWVXRPTTRsNGtq?=
 =?utf-8?B?SGYvQzlHQnBUNTlwUUZwNVpSQUx0VGwrNDBKajRTS0dScnNybE5XNW5GTzJD?=
 =?utf-8?B?Y3ZZRjZSMXE0V1RNV3pqVDFnSWhZT05Td3h4bVZlanEzT1haZmxBNUVpWCsx?=
 =?utf-8?B?OUV2UFVLeEdMN2ZTSGdHVFEvZllXdHdHaEg5NERNWUJUc3dURmkyT1ZJQ0RH?=
 =?utf-8?B?Q1daOEZvWU1pNkVoU2JjUytzWGlWQkl6bVl6UWVnNzVGMk5oT0s5a09BckFZ?=
 =?utf-8?B?WVBKTEFOUXNPYmUzaFBWLytUVkJlaGROV3pJaUpnK0U5TFJqQlJCTDhnb2Rw?=
 =?utf-8?B?YnZvazJ1dTBUN0pwWWRpUld0cHRSNDZWN1lFYW4veHlwMVh2OG1LM0Rvdkhu?=
 =?utf-8?B?OUlQYVp2dnBYc1lsaWJnUnk3cmRWeFZmZjVsakVSa2pOOW5LdVNXNWlQZS9T?=
 =?utf-8?B?Y2ZoMGZSNVVRbWxZd2FGOFhoRWMrYU9Wb2NpbHQvYXlBY0lJeDBDOTU3dGEr?=
 =?utf-8?B?ZXZVWTVNbHY3Vkl3M0ZBVFAyWW5teHNsaVB3ZStmRU9qY0RaTUNxWjJ4Z1NW?=
 =?utf-8?B?Z2x0ZW9SUGdlamZBN1liY0h4Mks3c05peGlRWnVRelBUdzVzUzExQnBMU3Rv?=
 =?utf-8?B?TE5SS0pTZmcweXlPeHp0VmlSREZzeHlsbXpZbFVpOUNIT2pJeXdtWUt1cmZI?=
 =?utf-8?B?NzR3bTZsR2RzZFhJUVRtbEZKSUJBV1c0OG8rK0dqNXJrM2ZDTWhuWVBxRW5w?=
 =?utf-8?Q?n5bEsAraU6jJXmRMaOeKhc1tE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9SI9BWoAooBOtZwkpw0HPGMUDCt9TDTffW0oC8m6Ja1ip2l7pwMMY9DZrStr+OkknBCMhC4ZfBydZ0cFMyCvhQfX6iFpDF7gAPJolr658sPZeWNLdWINZtCnNhsTczr37UqBD9E78oDnZA9SgOtDIC4oF3qT3jJKcFvEHHEjy3jB1gNE0W9WuU7Y2a/FKCfwRtN6VglQX6w88Ha0L3a6LwKociJOeJx25ZzteIIYMpVjmEdFVRUWsm2wn6yZZsFnJSGvfQQWxVsfcqe7QedRyebClU9Dj0ysl/lKJyOGanPNDjUPeuqjVU1WaGmk/xzpc+fX2KsBqcRrl4HdP0npx89HIYRTEAXP8ZHaeneOXqQDX7f2xYeL3BFzBnbLr1Fh/Ulnf1Uw1dFUB6JKE/dxKFBEF9vSfLr0nWf9W4lMGe5MLKvOPqKUKVmfUTf9CDTTfovC385hbjoEosdkMPwG4NXTonFFHZUPmTA+0vhknigZQ9U0rdga0BqPrDLFtcf2VT1otQCIjYuCWef6ZsiCj10W9o0TDiRMd7ijI+zzPwpMG4a64wQ5ujSuAjmzF9768b8tKlA1/7U6qvvFJLUaF2QbxdqsIUPSNZQLCwRvXDs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b9c37de-31aa-4089-64b4-08dd1df9f3df
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4780.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 17:49:16.6890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0ITQL5FIY81CPEil/NQL6b63Vg1kW4XPSvw2oVEFi0SawZaDJusIKLbwN0N0eP1F5WXg8FHyHwn/lR4o4+sKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4761
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_07,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160148
X-Proofpoint-GUID: uhTY8Zuj8NSrWhipl4hggn4WLz1-4dC3
X-Proofpoint-ORIG-GUID: uhTY8Zuj8NSrWhipl4hggn4WLz1-4dC3

On 12/16/2024 7:53 AM, Matthew Wilcox (Oracle) wrote:

> Convert from pfn to folio instead of page and use those folios
> throughout to avoid accesses to page->index and page->mapping.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   fs/dax.c | 53 +++++++++++++++++++++++++++--------------------------
>   1 file changed, 27 insertions(+), 26 deletions(-)
>
> diff --git a/fs/dax.c b/fs/dax.c
> index 21b47402b3dc..972febc6fb9d 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -320,38 +320,39 @@ static unsigned long dax_end_pfn(void *entry)
>   	for (pfn = dax_to_pfn(entry); \
>   			pfn < dax_end_pfn(entry); pfn++)
>   
> -static inline bool dax_page_is_shared(struct page *page)
> +static inline bool dax_folio_is_shared(struct folio *folio)
>   {
> -	return page->mapping == PAGE_MAPPING_DAX_SHARED;
> +	return folio->mapping == PAGE_MAPPING_DAX_SHARED;
>   }
>   
>   /*
> - * Set the page->mapping with PAGE_MAPPING_DAX_SHARED flag, increase the
> + * Set the folio->mapping with PAGE_MAPPING_DAX_SHARED flag, increase the
>    * refcount.
>    */
> -static inline void dax_page_share_get(struct page *page)
> +static inline void dax_folio_share_get(struct folio *folio)
>   {
> -	if (page->mapping != PAGE_MAPPING_DAX_SHARED) {
> +	if (folio->mapping != PAGE_MAPPING_DAX_SHARED) {
>   		/*
>   		 * Reset the index if the page was already mapped
>   		 * regularly before.
>   		 */
> -		if (page->mapping)
> -			page->share = 1;
> -		page->mapping = PAGE_MAPPING_DAX_SHARED;
> +		if (folio->mapping)
> +			folio->page.share = 1;
> +		folio->mapping = PAGE_MAPPING_DAX_SHARED;
>   	}
> -	page->share++;
> +	folio->page.share++;
>   }
>   
> -static inline unsigned long dax_page_share_put(struct page *page)
> +static inline unsigned long dax_folio_share_put(struct folio *folio)
>   {
> -	return --page->share;
> +	return --folio->page.share;
>   }
>   
>   /*
> - * When it is called in dax_insert_entry(), the shared flag will indicate that
> - * whether this entry is shared by multiple files.  If so, set the page->mapping
> - * PAGE_MAPPING_DAX_SHARED, and use page->share as refcount.
> + * When it is called in dax_insert_entry(), the shared flag will indicate
> + * that whether this entry is shared by multiple files.  If so, set
> + * the folio->mapping PAGE_MAPPING_DAX_SHARED, and use page->share
> + * as refcount.
>    */
>   static void dax_associate_entry(void *entry, struct address_space *mapping,
>   		struct vm_area_struct *vma, unsigned long address, bool shared)
> @@ -364,14 +365,14 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
>   
>   	index = linear_page_index(vma, address & ~(size - 1));
>   	for_each_mapped_pfn(entry, pfn) {
> -		struct page *page = pfn_to_page(pfn);
> +		struct folio *folio = pfn_folio(pfn);
>   
>   		if (shared) {
> -			dax_page_share_get(page);
> +			dax_folio_share_get(folio);
>   		} else {
> -			WARN_ON_ONCE(page->mapping);
> -			page->mapping = mapping;
> -			page->index = index + i++;
> +			WARN_ON_ONCE(folio->mapping);
> +			folio->mapping = mapping;
> +			folio->index = index + i++;
>   		}
>   	}
>   }
> @@ -385,17 +386,17 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
>   		return;
>   
>   	for_each_mapped_pfn(entry, pfn) {
> -		struct page *page = pfn_to_page(pfn);
> +		struct folio *folio = pfn_folio(pfn);
>   
> -		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
> -		if (dax_page_is_shared(page)) {
> +		WARN_ON_ONCE(trunc && folio_ref_count(folio) > 1);
> +		if (dax_folio_is_shared(folio)) {
>   			/* keep the shared flag if this page is still shared */
> -			if (dax_page_share_put(page) > 0)
> +			if (dax_folio_share_put(folio) > 0)
>   				continue;
>   		} else
> -			WARN_ON_ONCE(page->mapping && page->mapping != mapping);
> -		page->mapping = NULL;
> -		page->index = 0;
> +			WARN_ON_ONCE(folio->mapping && folio->mapping != mapping);
> +		folio->mapping = NULL;
> +		folio->index = 0;
>   	}
>   }
>   

Looks good.

Reviewed-by: Jane Chu <jane.chu@oracle.com>

-jane


