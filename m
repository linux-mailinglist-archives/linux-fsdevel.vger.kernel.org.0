Return-Path: <linux-fsdevel+bounces-49563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86592ABED93
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 10:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A039916CC0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 08:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344CE235BFB;
	Wed, 21 May 2025 08:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f2wp012Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d9VZduBl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AEEBA27;
	Wed, 21 May 2025 08:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747815067; cv=fail; b=jroMuKIYBOwZW65lYSvNt+0/AFjV+VHD1sJenrEg888ode2Cf5XzMOiNxmWqw3ted3c0o+PoSG2luRpmiMecBk24WoaCo9oKPMG+N9tPa9U2yE8kRNSpfl+yx4CUj4eEnkbnvsuKPdUaPxskkRMPts7dyQJyQjt0/Yiv/cTb618=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747815067; c=relaxed/simple;
	bh=dvXW8FSetrM/UvF6LFvsQ/9/dm/J9tpekz3P/5zJ684=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IhySqY0UJin5lflNc6qqVG5LPGdUQRnYxa6Tvs2wUaiv6aYifp3qojmQjwtbdTHR18mIDUDEO/l/tWs/tcUax9k5WO04xdVYg57F0PX9LdjXEDqWNe42yBoVXqXmxLjp1Otelc84jj+dd42o2KtYSBYGTa+tmimR5cn91KOCVFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f2wp012Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d9VZduBl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L87LdZ009364;
	Wed, 21 May 2025 08:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ug07xeZC1REseUAEy4
	rzDizAEjlO4hF3obqT45D+dkE=; b=f2wp012ZGOg3JJcbB0iu8wIbrQq0XLaZNq
	BdCzYRSZ+iz5xeuzsnwruRfDkYw/HO0IcE0/nZqL7KSi5YYg8nyVe6uXmLSYgbmt
	wygJx+WFrzGzto+aNzezFnMXAX0QM0+TM5MsK3imzBG/JLa48jq//a9ffZtUp0a+
	cIgGAI4XaA9leyn/+8RhXEtPsNpuY3FvnLd6AoQnGQK+0wCBP/ucXLx5gPdHOmMc
	8y0N0Fy+8i6hfS9rQKKZRyrrqfcoO/HxnKVi/vMnAIm+ceO5+PYuHD22TQ33WXdT
	Csovs87Kg8RmdoshNAqV67K/+eBBTmPD+8PV+UF+v74O/xgQrTpg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46sb1pr08m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 08:10:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54L7shim001822;
	Wed, 21 May 2025 08:10:47 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013051.outbound.protection.outlook.com [40.93.201.51])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46rwes1jp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 08:10:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXjzB2GyXsqt3PCO40N4YgtnL4zNzXAiZOobpo59X0FbHX79QaK3oq+udl3BAdxgbsoIVZUsCCo7jiO6g8WIhw81BuKyfks+VUrY3Op8Ung8DHSHEMCO3bJowSlMR7EqxZcLLJeIGwDduKfWjBVNE2mJhAyrOa9QniS/UkX3j2a5UZBXFSOOT0+c2q0x3Z6ZpTfaeTFiIiumXUZurwsSXx6UVZbEWmJJJym8p8yLO+svKKsKouef03LrBbS25sUNVJQd043VXo9ZHuDTahpLltYoLWV8OBnD0Oo/HvNgNSDtE6jFZcQIywd1l5ANTYQzGdCMfs9w4YnF1CotR/ODsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ug07xeZC1REseUAEy4rzDizAEjlO4hF3obqT45D+dkE=;
 b=QksVj6qUoxRBkib8SobOCDHe4OSVSgp++ndRPf+Rpb71yOYQR2sVeR+BoJaJxtAQJvZ2yjc6IdiFo1WZl2usajhj5UnrtNDah/QuV/IHA9WnS96IEQrelas3um6AQ1lxcFZDWAwaWpHoh3h0I3uSgRE5XHffAUKkdRVosu8HhsRvLG2XteK9sL+qDxuEV3Rds5gDFg5KNT6GLZpNvWrw4ftNJDKRtgyCANhXzoxjz6t9y82vRpcB1gZYfK+P2AXvyAmXdf2lY53/Xmn1A1oP/4qArXLJ6cSlJaufCGTr6XhWL97xxOpkBAe1b31R8U0/0pEYhfj19rgbzUha2bQeWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ug07xeZC1REseUAEy4rzDizAEjlO4hF3obqT45D+dkE=;
 b=d9VZduBl1xuB11D04Ke806IYZeIdrR4m8+bkfg8eP2qny1Z19TYwZZSHMvv9XNw9+onSvdWckIIBngZnGHz/i119aLKo42pSp8moT/x8/y9DiNovSg3mU8YG8b0oyikAyol3KJeKijw0+r2vltIRMOyjv/OjxAeKDStlQ76Eb5c=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BN0PR10MB5175.namprd10.prod.outlook.com (2603:10b6:408:115::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 08:10:45 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 08:10:45 +0000
Date: Wed, 21 May 2025 09:10:41 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/4] tools/testing/selftests: add VMA merge tests for KSM
 merge
Message-ID: <48746a0c-b2c3-4295-81ac-79bef6bf177a@lucifer.local>
References: <cover.1747431920.git.lorenzo.stoakes@oracle.com>
 <95db1783c752fd4032fc0e81431afe7e6d128630.1747431920.git.lorenzo.stoakes@oracle.com>
 <34bd0faf-30b9-41f1-a768-0ed7165b4b98@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34bd0faf-30b9-41f1-a768-0ed7165b4b98@linux.dev>
X-ClientProxiedBy: LO4P265CA0224.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BN0PR10MB5175:EE_
X-MS-Office365-Filtering-Correlation-Id: 1216f13e-a620-4bfa-0ca8-08dd983efc98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gLs8mt6Laj0zCHPsprAVVyvNyEff3L2lkhw4X+Vlyp1eXp/mxNbUgLqxP7vu?=
 =?us-ascii?Q?nedDJUeQxsW3109YztyvEVcJpzr+wbQ1R6PDOo778o3jSxrlX9ES3rydkGKu?=
 =?us-ascii?Q?2MrniQgsZxtmQuFGCPSmzma+wMc4dkSFr8bbBKJmfOYPSnbIzTENfilHJs5u?=
 =?us-ascii?Q?VSUGgvpN0BkjtgavD4CLGmjNqW2GrdlwlYKdsEZ/Wd7S2LoYffh4VMGb8n+x?=
 =?us-ascii?Q?wu7z1qIpXzgdhAEr1pKl0qcIq5R8Nl4epLXI58O6K2p9vRmKethSQbl0b7do?=
 =?us-ascii?Q?75raxV1U7P0u8JcHr05RAQS02L/696fOW9AWMbM7Qp1vdGkxop+He0U7dtcG?=
 =?us-ascii?Q?XE4HdAW22UovKtV9qNv6urFFSjW5f8UenN9icVnuEV2m3mkvvLnLrDsG6Gbv?=
 =?us-ascii?Q?Q/Cwda5SHewIyR2eLPX39Rlu1ni2y0zETriWMW4crpRtc98js3lf7Y4D7YKi?=
 =?us-ascii?Q?soLMM0WTnBxKYZb3WqxZmuv9SMKMYQf4YlfVR+FA65P8hmDoGj8Mjc9b5ZjH?=
 =?us-ascii?Q?UK02xhr3VmtGaQgXz5iwNZoSw7PPscBsuy5y/pIW4tjjvzD9shFmB2QipntA?=
 =?us-ascii?Q?Eny4uOLf6+8w9Ra8xk3zy9twH/Xx6AYCgnbHtAeKjf9zwR0G0uKcPoYQd8K0?=
 =?us-ascii?Q?pAdtU4RKdMi93l8sauxLs7pZF2Jv/n4crKJD0LHz/whhSaZCtA22FsQyOwJU?=
 =?us-ascii?Q?RIc3hKDaKmzvFpski2WkqLOziACb00xwTJABF5beGGM/eSXnLW6MpSTX4uVy?=
 =?us-ascii?Q?4sn1Bhu/oH+vUm5dvYsVKsDGl/PhLKeF2iPkiNw8TOlUFBqdRBv6fXEIcdxA?=
 =?us-ascii?Q?IoEgoYIIRDaT1IORHC2mNlJHInUnVcLE8rV9x82qwxFpyIt1o8Rm+4CaeqQA?=
 =?us-ascii?Q?fUpKFTGwzDP7ohA3T4IwPf9bUq+L80/oIvISP9tDoUKaDb0jVPddaEXk+Rk+?=
 =?us-ascii?Q?idMudB1qcqm6kS1eZ6R0ebty5fMAzcUsLqY4cPtPWjCkhC5zmFs19nAXFg7k?=
 =?us-ascii?Q?wYjxl63hqBpncc544GtZpconC9rP4xP6DijjkHR5Rt1i1dyXw1MhZD2Y9Li8?=
 =?us-ascii?Q?ZIhrgDk1oRJjKdBxsRxg4azshtCOvor9SwoN/0PeLqOcgyAaMDpR3PtvvZ89?=
 =?us-ascii?Q?mJRVH4YlG9keLSP0oGOmfmrPv+sAbMnWtzDs82HjPdi8gA0uymC5pOode6RG?=
 =?us-ascii?Q?3gMOwYzvJzecCQwOKp7x+yIaDw6F89zd8vdMPUg3M5RQBffa4KksUC3NHCPD?=
 =?us-ascii?Q?929uMOPIbjZed7c/js3iFZhvAFzO1LFBDQzeWSWvCZiwEe3Uer1wtZ6gwQw6?=
 =?us-ascii?Q?5O5YkkAhODLLzqFCWlnQX22m1lnCVLaJLyI/3VkK/7yLzZDnCr7sw6UMtfc+?=
 =?us-ascii?Q?9IahsGH9k/WLmWhz+BTn0mhF7A2BorD2p4trJj/ruaq2c0Mifg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6QYe+gVtg7tb8vY+REpK0Mux1W35YKPd10ff5XgvDcwiXxzRRtWongL8XDIV?=
 =?us-ascii?Q?wo94LOcZyYnhBze5SWuMzQg+ly751Fg8J4cXOn+3odSEDSJLuAXGONsWLfRD?=
 =?us-ascii?Q?uhG2QUx4Tozxn3PFMhx0rOqg/7+owYoU51B76blWLLdqvmcaJbDFp+4xPrml?=
 =?us-ascii?Q?il5XrpTvUva87YprnPOwPffkXZ2ruFgp5a32GqMIU9zYvxYHtFJPHz4j9Dc+?=
 =?us-ascii?Q?vp494J4ixXIiXlX5y1843f4EvSFqbhUl0uHdGDu42lCw8rbCZS/714p0CI6o?=
 =?us-ascii?Q?WSg3j+fdd3/B8G4lprTZRf4JiO9AOvgGweegjuaekH5ziRR/HLhNPSMCTK9X?=
 =?us-ascii?Q?b7rWqO6mPlHKVYYJCrX2KF1tNKaLvmhQI2Y0iewwkvng06nzUxBxp/ZY53iN?=
 =?us-ascii?Q?xqkRD7leVgS/UYR2P/2pTKWc7OMU2rIrf42QBIx3P+uHp2C8pGuC+7ugNrF/?=
 =?us-ascii?Q?1L5kNlgwIs5JUNGAgQwlkxn/WPW8yQYiaj1MTt0Xz4VMl/c5izG/zBhIA1Pf?=
 =?us-ascii?Q?C12inYWpnYg2l793GZvkrvu69+xVySJcWYwZQtaG8FN2dHFqhrjWwIfZkwFE?=
 =?us-ascii?Q?grwMPuhPzX4/D+glSR4zalOem8r83eLP0LuszlcZ+XOrZUw4jw6YqR38OxsH?=
 =?us-ascii?Q?32XmDlUt54jowMdNKSnUNWekWmW3kydsPD480xx0XnOSnlbNwGm56JxfSm1k?=
 =?us-ascii?Q?SZD2BzRfSUPzjN1dBJAWrc/8s3zGFK7J+th7GPZPIMeFUWOqbNIoYlEBEYWP?=
 =?us-ascii?Q?ffvdTh9S2q82mXgWh9wRcjX92Fsfgi1jaYE+NxnHfuxKHlC32u/qcWrgrNRR?=
 =?us-ascii?Q?YAbxjVcGwvPEG1cTkqh/gbcnQ9Xe67EraXr6Rid/vsBdZysYEtKavftVEYck?=
 =?us-ascii?Q?de0tocLjv8bEGuFSg5Aev3PQPwQD2+LAHQ9YillffQN+qqx6yIm4FbLBcIWc?=
 =?us-ascii?Q?h9lhM4L3EkycseYuJWYwKcwqpx/AJ8MQw14TYtFAqt2TVdzBFUUbLCNl8j/o?=
 =?us-ascii?Q?acLbjG9C7swYO4xbfa7VCsGMnPx65+FgCtb/RmCHYVDcFgd5rWWT8LSWBxyR?=
 =?us-ascii?Q?xJ7UeELw5QEQjAogiNuwL3GTGLXFdUfgFtOUep8NcutaaGdNwjw+y8rsClF+?=
 =?us-ascii?Q?zKY+fFhamUGp0XLoL4rg2feFvhHynK2Qp6kRALfKXsZdxeQeYNcf3ghjmKoU?=
 =?us-ascii?Q?EikthMlxws7kudmEjU5AT0uYEhBIYTE8flrph//e04mIQj7EgXw0xPsnT2yF?=
 =?us-ascii?Q?q+X41aJ6b6phQIZ7T0mvjyk8baZbN+SWFzkXqAcBRru9qtz5e9BRuL4E06Jd?=
 =?us-ascii?Q?/GWOV4KkfPLbJdhoeanzQFAKxcsnveUjZZOLcnn4xEk4ddAO1JIzaa2wBG9b?=
 =?us-ascii?Q?VGvhVJo/VZ1CdzYCikZiwQZkHJ9MjJTpANu87tFFd5cwkSZk8dXTfAOeKgcj?=
 =?us-ascii?Q?b4duvAV3A4nBgX+CcegGVtDU4MN8GAfvyY/cc9EIIKnA9yMMAJxYAKCNKZLD?=
 =?us-ascii?Q?bW8QwVqYdb8T0XIEjhZoMJv9W0nC+l/OIKR2fv0zFYI+wEfXmpXjGPKFIb6S?=
 =?us-ascii?Q?NFL4cWXgNHkMJubVHCrv38QMMQy9SRg87SaqQ4L/mMtZMeberhYKQkLncPye?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5om3RSr1lk4PL7UEvs6JvBLs3ACxJob9RKRTiSX+ImUvB/ZtLY9bHFxT7+WeIdq76NsFulbGiL45faZZqtbbM3SD93/1zYpualka+Mv90iVl5rFZM3hIxh40ZCZ1AWHWHaKZ3GTubRs1PaeOcsoIlTfk7BOOqk5FawPZtJBHG+80kFu6Xk1jab5jHcH6s9SFnrjg9KJtkKHpKtw8WRkmAjoJtZ8+IXeiGt4XnPIGalnTZ9YsxBGiJv9s4RIqj/eS0dy2U4GVEEoTKzAM0a00relYqX/+eV4TEFz0z1K733h2G+gQvp9BcdeLrD7X2Vs6KWG972gtJzJpCUwrDPatMo33Iutv4MEg7vstB5i7RMH7/ZOoWuzr6UqY0gX0U7pJ8pKxLQIBY2V+YRb8mO9pTkbUhm0LwCN0LEsHUQ7UxMI7L3SWOqAgkzOJ7ZEdoU2VfQidcC19zdplH6A0l8gStyVLpW8coId4MyuF6YBclo5ZFZqF8VZCgdEBAb8f+FmQ94I2ubwtQ4JKLAlRuaddXVhQbMnbnKb6FYVbQBna7Zotv0PMJzCPOuBlxus9tlZaQppcjLHIj47TZkSnibLafzQlIBdbTvJD4LmOL4FDJgc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1216f13e-a620-4bfa-0ca8-08dd983efc98
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 08:10:45.0497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ns+HbpGsN375wUK7gVma1C1zGM/tNjHpeYQdQFk9cz31B1GBMToC8ZLhXaVI5k4wxEMGFRLbKYuWGzIupBZxl2DHolFNfD8S3VAR9V4R7xc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5175
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_02,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210079
X-Authority-Analysis: v=2.4 cv=BoadwZX5 c=1 sm=1 tr=0 ts=682d8a88 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=wPGFDQHO3wO9n9L_fY0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: k2s9Jz4R50d4j8vs64HYa15YMiPpDHFt
X-Proofpoint-ORIG-GUID: k2s9Jz4R50d4j8vs64HYa15YMiPpDHFt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA3OSBTYWx0ZWRfX8Oek4CBvlPy9 PXVLYZkfT7WfbZ/SEBcKVyaHW31tPhXF72Im+Kmwdn2TEYtwZTxM66B0Lv66IijRBxbrT0tmAex cJPLuDfxAIqEPnV2CbidT3oGqExLNPUFQrBp/HBpVkHQrHFMjGtU913HyS/sA3uqQVJ99JKHPbL
 YquZuQezM9aScHojbxMbyrrGhYGN88HiADn+aoNwBSF2NttLIGk2lowM6so643L+3rTQ7eaK1+b 1phiMDfiXXhffQDWeY+Ikx+7IzteT05Y82hGJ9vB6zUOGor3xddCjOIQxafU0MfLTuj9rMakiA5 DnARzi0jH+9tBWi/kjS3Ug20dzwCb25t5A1JCPWluIQzv66sf1GXLraDjsIV6SK+wU47AfRRARm
 K8Wh3feG1iEJw8Wle9Mq68zHwq1Q3akEJI4CJSz53HP/LSQ4KTNaS3Nhp8sda3RnHQAqscZe

On Wed, May 21, 2025 at 04:07:29PM +0800, Chengming Zhou wrote:
> On 2025/5/19 16:51, Lorenzo Stoakes wrote:
> > Add test to assert that we have now allowed merging of VMAs when KSM
> > merging-by-default has been set by prctl(PR_SET_MEMORY_MERGE, ...).
> >
> > We simply perform a trivial mapping of adjacent VMAs expecting a merge,
> > however prior to recent changes implementing this mode earlier than before,
> > these merges would not have succeeded.
> >
> > Assert that we have fixed this!
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
> Tested-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks very much! :)

I hope to get a v2 out today, so will carry forward your tags there.

Cheers, Loreno

>
> Thanks!
>
> > ---
> >   tools/testing/selftests/mm/merge.c | 78 ++++++++++++++++++++++++++++++
> >   1 file changed, 78 insertions(+)
> >
> > diff --git a/tools/testing/selftests/mm/merge.c b/tools/testing/selftests/mm/merge.c
> > index c76646cdf6e6..2380a5a6a529 100644
> > --- a/tools/testing/selftests/mm/merge.c
> > +++ b/tools/testing/selftests/mm/merge.c
> > @@ -2,10 +2,12 @@
> >   #define _GNU_SOURCE
> >   #include "../kselftest_harness.h"
> > +#include <linux/prctl.h>
> >   #include <stdio.h>
> >   #include <stdlib.h>
> >   #include <unistd.h>
> >   #include <sys/mman.h>
> > +#include <sys/prctl.h>
> >   #include <sys/wait.h>
> >   #include "vm_util.h"
> > @@ -31,6 +33,11 @@ FIXTURE_TEARDOWN(merge)
> >   {
> >   	ASSERT_EQ(munmap(self->carveout, 12 * self->page_size), 0);
> >   	ASSERT_EQ(close_procmap(&self->procmap), 0);
> > +	/*
> > +	 * Clear unconditionally, as some tests set this. It is no issue if this
> > +	 * fails (KSM may be disabled for instance).
> > +	 */
> > +	prctl(PR_SET_MEMORY_MERGE, 0, 0, 0, 0);
> >   }
> >   TEST_F(merge, mprotect_unfaulted_left)
> > @@ -452,4 +459,75 @@ TEST_F(merge, forked_source_vma)
> >   	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr2 + 5 * page_size);
> >   }
> > +TEST_F(merge, ksm_merge)
> > +{
> > +	unsigned int page_size = self->page_size;
> > +	char *carveout = self->carveout;
> > +	struct procmap_fd *procmap = &self->procmap;
> > +	char *ptr, *ptr2;
> > +	int err;
> > +
> > +	/*
> > +	 * Map two R/W immediately adjacent to one another, they should
> > +	 * trivially merge:
> > +	 *
> > +	 * |-----------|-----------|
> > +	 * |    R/W    |    R/W    |
> > +	 * |-----------|-----------|
> > +	 *      ptr         ptr2
> > +	 */
> > +
> > +	ptr = mmap(&carveout[page_size], page_size, PROT_READ | PROT_WRITE,
> > +		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
> > +	ASSERT_NE(ptr, MAP_FAILED);
> > +	ptr2 = mmap(&carveout[2 * page_size], page_size,
> > +		    PROT_READ | PROT_WRITE,
> > +		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
> > +	ASSERT_NE(ptr2, MAP_FAILED);
> > +	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
> > +	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
> > +	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 2 * page_size);
> > +
> > +	/* Unmap the second half of this merged VMA. */
> > +	ASSERT_EQ(munmap(ptr2, page_size), 0);
> > +
> > +	/* OK, now enable global KSM merge. We clear this on test teardown. */
> > +	err = prctl(PR_SET_MEMORY_MERGE, 1, 0, 0, 0);
> > +	if (err == -1) {
> > +		int errnum = errno;
> > +
> > +		/* Only non-failure case... */
> > +		ASSERT_EQ(errnum, EINVAL);
> > +		/* ...but indicates we should skip. */
> > +		SKIP(return, "KSM memory merging not supported, skipping.");
> > +	}
> > +
> > +	/*
> > +	 * Now map a VMA adjacent to the existing that was just made
> > +	 * VM_MERGEABLE, this should merge as well.
> > +	 */
> > +	ptr2 = mmap(&carveout[2 * page_size], page_size,
> > +		    PROT_READ | PROT_WRITE,
> > +		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
> > +	ASSERT_NE(ptr2, MAP_FAILED);
> > +	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
> > +	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
> > +	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 2 * page_size);
> > +
> > +	/* Now this VMA altogether. */
> > +	ASSERT_EQ(munmap(ptr, 2 * page_size), 0);
> > +
> > +	/* Try the same operation as before, asserting this also merges fine. */
> > +	ptr = mmap(&carveout[page_size], page_size, PROT_READ | PROT_WRITE,
> > +		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
> > +	ASSERT_NE(ptr, MAP_FAILED);
> > +	ptr2 = mmap(&carveout[2 * page_size], page_size,
> > +		    PROT_READ | PROT_WRITE,
> > +		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
> > +	ASSERT_NE(ptr2, MAP_FAILED);
> > +	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
> > +	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
> > +	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 2 * page_size);
> > +}
> > +
> >   TEST_HARNESS_MAIN

