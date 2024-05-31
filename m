Return-Path: <linux-fsdevel+bounces-20658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 799038D66E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 18:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBC5E1F24178
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 16:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F1016F83D;
	Fri, 31 May 2024 16:33:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147A816936F;
	Fri, 31 May 2024 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717173207; cv=fail; b=QRzFissMO6ymrTqLqKxJJAXVX8n7c5i7a4SQYtE+uWgXQVHHrGgANj5JxvaQYVA9tlqLfojQLyW0VY7Nh+Ag151MSHp0wi9X2Px1gav0ZQXSWJa9ac8X3LhD2z+G0vGH6YGBjQyRE9EWj/0qYAByevMwa+3rQJnI4TV4b7v6CMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717173207; c=relaxed/simple;
	bh=pC5ikyU6Lrj8OCtU9/kcZgyIbFUWIlhCLB7xDJOTJDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bgeb2e0Z0HKeFFNgx8dgCzRR+PJqnkZ11ErfO1LfDIC9+X6l7quNrsLP/SxOfdU01cpD0q/P0p6Q9Ch/oklVD05khr+HNkkz4Furq/MVPVkxE46U6ASyht5V97ihQWVFM489Wv5E6gqelSnE+3NV66k2BcWUrwEnHFxTIFELL1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44V9VWXO030176;
	Fri, 31 May 2024 16:33:13 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DcaSvmY9bE41fDaqsXdYRpUUnMr9miPHUopMtUxgxinc=3D;_b?=
 =?UTF-8?Q?=3DFnM3ReBkjxbV4ag6Y0Us3qM+Vk84i4wDB6FawhfdCk8CD5WgXOCsJRIYDjE9?=
 =?UTF-8?Q?2FxhHnDu_DB4kNnL79LOdd9EHTn6CVp+LLQtHlCc9fmi4IqLwgpk5VLR9EzgczJ?=
 =?UTF-8?Q?9iKYIQjme0JX6L_DdCyDRBLwu24DI1+8ObiIq1bTrTkpixq9AJNCAvNoc1VMuLy?=
 =?UTF-8?Q?kjPXbUxENHuwstdw5Adi_1Mik9VaRa+kJAP2cbWoDx0ke1zmBEi6zXUTgPptc5Z?=
 =?UTF-8?Q?mF5//i0TUgmzKlAUeIU/tIcHRW_YXQAOhc47FtwcyxcW7QWHK0OF5NPWKITnHxw?=
 =?UTF-8?Q?6Kqk3/ODBQGKWPlaiI8stA3bbBa1Lx0Y_3A=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8hgbk84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 16:33:13 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44VFaLYI006199;
	Fri, 31 May 2024 16:33:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yd7c8kmkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 16:33:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOUTz3IHJm2XCe9qsN3X3eAQEIJejHak0yuyacq56VX6IIWWb/bcAWgw968WAKoDU/ntKS228hbgHZQbJ18/IbdhJi1BArQ8cE6NOBZJVuoAaHfGboFBmwI6DL2TpDzj1UwVgByW7B3JpefD+REDMmofSFzRxj6BZtDLApNdAyk9w94q0I2fgwAxVmQzprEaQQ2Y3lJXsaYk0lGDd/dhuCODIbxXycBU64La/UbpoK/t7rgfQEYg4Yo3YPW/+hQlDsKPA6p4RQt1pS+z7L3RPVBZrGP7ed2tmdXeHdMe5TKyBXMVApZczR0QEBylUGb3ik9zsxpTxZ8mKsvWS4ea1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caSvmY9bE41fDaqsXdYRpUUnMr9miPHUopMtUxgxinc=;
 b=IrLDRxXfj2RI1pgRK8RscYBcv47sbCIBWurPz4fWqTO6EEZkSlFfx6kPUZM0iqWIGBQ0TsqEkO9Uf9SQdfzYne2kgZr2cPpY1alwcHPut8csTTB/g2P5nd2BHLt87qIhQDM/FmOyZZEpTVq63zkWBFDCBMs+HqA4WNpQ2c3OhDaaQ6qtEtqEXvcERckFerrz+7POzsC7DC/YcEenWSQ5hoqrJIoyIgwTDysbqhsnM4Q6Xt8hIcckcf5u8Db2HVDYAkBOt9AzQF1jQFNUoTd+RxL/r5dbKFeEuRGXCsQFzYScQWLGT3VCuTEtwXYthS7m8uRButS6LDYwELgj/Fse8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caSvmY9bE41fDaqsXdYRpUUnMr9miPHUopMtUxgxinc=;
 b=HCpTmrnvDTM7rwYibiNdDIHlngkq8QdDzje4dAtHo8y5tgF5ESrF/78fD4ykYxnoqBF/nudrgYrl41RItO9YHPLqFbdn99eX2ipbAZCRDXk7CLDebPBUQKmJ7Gb1GohUSfIuwhDZi4Z7sjTzjNmyVO0xizRPxSxiEsEtW3kEonQ=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SA1PR10MB6318.namprd10.prod.outlook.com (2603:10b6:806:251::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 16:32:44 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 16:32:44 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, sidhartha.kumar@oracle.com,
        Matthew Wilcox <willy@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/5] mm/mmap: Correctly position vma_iterator in __split_vma()
Date: Fri, 31 May 2024 12:32:13 -0400
Message-ID: <20240531163217.1584450-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240531163217.1584450-1-Liam.Howlett@oracle.com>
References: <20240531163217.1584450-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT2PR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::31) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SA1PR10MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: ba740f81-6630-4eeb-4798-08dc818f4c6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?38YLa/oX6v78eoCtQzq5wdXN5Qcc1gu4b3gTg0MdDlJcW/LeKJYjWzF7mZod?=
 =?us-ascii?Q?1S7c0GjMtUW6BzpjQEWslxAqYhxdKlIVFlm2N1wH0bbdlTolqPdCrpFJMv04?=
 =?us-ascii?Q?Q9IhNQZSVoOQcCgyOsGCWm0SoFJI6A7gv48mi56bVaKqEZ/qg5J/wnUvzKB5?=
 =?us-ascii?Q?ZwzeO+v+xBgcs7x2axN4Ofx8Cj9AvlwpilWe0fdXNLtcN5DdQX456EjAn5r+?=
 =?us-ascii?Q?yrmC/6W6gKjbNtUwMN5RYnj+gI/PV/jjulQMcNRjXzHeRonS8kYS+a/zOFD+?=
 =?us-ascii?Q?yGgqAqVrMR8AwJC9zwpMhozvmewdhM0x6YZx26trBmwoAAyalHXjCAQmYpLu?=
 =?us-ascii?Q?zyTGt4V3HOztLH/CMGXTscx2OZR6H686I69fhNxTl8meHalowk5YoMrLMNNm?=
 =?us-ascii?Q?XvnYG/6P+i2g9ZKBsa9SKuP6DlxDO3hoz46FtNQrgSJ3VGROOfmMopsVPqLS?=
 =?us-ascii?Q?9RdisnFeAbpJpa7/kS2pld1Sk5CRFXOyH3Furjx2VKBr9d5bGKNy1E0tMnM+?=
 =?us-ascii?Q?wHCwenp6NczXxMJZy/qhQVYpStvw1Vas8pLdNItTPhiij+iJq7hpXCQhlyPv?=
 =?us-ascii?Q?mBIlaGPjyWNRXc+TTg7RBBAN2PCqqUuYB0PD8ic2KQ+C977RoXAA4zJPi08Q?=
 =?us-ascii?Q?9m+Hi/jG0kL/maO0qb7hxlavromjwSb/2iyPjeWtI2maEakaxAO/uqDJCSsa?=
 =?us-ascii?Q?43Dd0BpZAxNSzocRu7zc0RZgD+UG/No00RQCpF+NTwC6c2Al0YjQUB9niYdQ?=
 =?us-ascii?Q?4IykMQiqwLr5pAICRjPQVgqlBCsZAKoOEKmttsDDnCWgiTrt/11h+ZY7Cz4j?=
 =?us-ascii?Q?BGtaXq4D99crL8lJWFHteO+1+0tNdXdkw6tUzJT4dXmHqKsgmAbcHGy0Nvsf?=
 =?us-ascii?Q?/yYoJUHoClEt5UpCQHiJTEfxrWizSH4bWGPSVVYo7jdhExRiu6QfbeQZuKpF?=
 =?us-ascii?Q?zgRYyk/5MmebHCS6h7DZAhtQrVnVB7wlWq/7sGIqU+TVL4zZbJHycFzMGVzR?=
 =?us-ascii?Q?Qi66HAXqZXvezddYTk/6CpyDZPiDGobd6mvTfjabnZW8scAA94k/g/jK+6ZR?=
 =?us-ascii?Q?KjRmdFFZI6/LGqINsmspm9FLFg5vu/MH7KgQ69mOdNFI4odjqlYi6txl+0kp?=
 =?us-ascii?Q?JADGpnNbK8wNxGC+Suc7uZznbMW2F7wGmEfDLx+uPBmQPI8+wsQIpaiQuJRh?=
 =?us-ascii?Q?jut/IGVm+K7DB3CLNmIZDXCdmJS0m8RjKUKiS+/JmQa3jZB01UeebqKttOmt?=
 =?us-ascii?Q?yxyjLa1cl8lJew5uKgnlUPf+jWkzc1zXKT558f8FHw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1sWvOmpEhG8Fglmgl3EUdjXw0khZczBYPWllIF2etVc8WKVAxxw1/OYnghIs?=
 =?us-ascii?Q?2Ou6U0m+B2zTG3ZIEvq0GTt7aiKlWX9UED1i5DeB4ksvU8bDnS96N7ZEBdtz?=
 =?us-ascii?Q?hs83ONA7/m09Vb6cZTtELkcGbqUQ/VulgywdWokaawY7pZnJap7gEum/fu5W?=
 =?us-ascii?Q?5iZb44c+7Psw1SFYt8amaTH6GNDKRQa6keTY6183gyPuPOC4dMFRnVm2+Lt/?=
 =?us-ascii?Q?Y6Y4vtUqlyY9M3FoY/wlxSHoukFsKdM9ibTCyj8/u4cP+YcSSWVuZ8+SDPr5?=
 =?us-ascii?Q?kbznM8xJSYKnmgEsmORmPGFqxCEMkgkEI2EGvePlmEeMq/ym3Pt/DrzKYV2S?=
 =?us-ascii?Q?Gk2RDlUBciL+zHm1Fu/osoqxmvMxF40BnVZbTDuofVT5UsoV23Z3ccmvJC5/?=
 =?us-ascii?Q?22o+RD23EBTkZbjwuWKAu5AaHQ4Y6gZ9EzCScHYndsEYkjsFv3k2ubZXFCEG?=
 =?us-ascii?Q?rpMxb7Gwq0RYWPNmC/h4nN7/sUwN12rHlcFTjO96lCfV2uvioaH3b+x+WHXp?=
 =?us-ascii?Q?vACfkWPCmXAQHnO+jiFc0UgoEYQL+uwLTJwQVH9yUoZn+O6ilD2+fdI6I9du?=
 =?us-ascii?Q?JtvUSpKIbiBCO4KANVLIVAAYOHr35vTDZjVf+uiSpJsxZ3ywtprki7NbHHje?=
 =?us-ascii?Q?6MkMuta0PPGyKb1vgUGMnvtknV/H/Le+sv78kmzod0sIZm1aa11xEwsN9JKA?=
 =?us-ascii?Q?Irkm0xnUUevuh2Zzs0iMpOcYeXAqIuIHCwDTd5pOoQup01fObjMRrglRrnKU?=
 =?us-ascii?Q?s0BC7q2JjXqxrfDTLy/eODHj7UGduZdY7tkFA2dvzbkXU8EeZ9l3TSmJLCx4?=
 =?us-ascii?Q?uzb0SQdnPpRuDkBCvB8JkylhwU0eQRjb/AToC+spXIdgVeKGogLVEz4AUkli?=
 =?us-ascii?Q?hVLZbJpPsnUibjcl8ZbsQCncECc5IcAz4HTl/E5bij0NPZkV/Y5dId3F8lS5?=
 =?us-ascii?Q?QO1nPGqRBJgX54MH1fvZizuFMzrWI1Fu7nYZ2NnaA9LlKQx0qBo74z45UGMe?=
 =?us-ascii?Q?VPS3zF8YyMzyXk4qlvg8IS07RHddm1wBB2OlvLjSHTD0NL44fCtTc3BnTpeD?=
 =?us-ascii?Q?9KCcdnwC0LsKt4o4QFtm2l5IgU4biOBFHCGeodNglcjrt/PzhAsZ7pGeUvpH?=
 =?us-ascii?Q?riEN+kGdhXaG4UWNaMVgeRO12fQYdpMCN4G5rWEUdA+NYaU4WLrVfMu5SK0F?=
 =?us-ascii?Q?CugAukkUn+WV9D/Z1pMyhJGbO7TeE3uimaGpR5Ox4DSqxz+VvLkysL+7gRJa?=
 =?us-ascii?Q?+P3tQTrubKuQ38+w8s0QMp0Q0XRzs8dNSR4UuTVZHpnyTaLyo1svVm24jr4Q?=
 =?us-ascii?Q?bsh+YeZX0aBYy6GU923A+Rj60QLU0E8NaIuFW7S2LfWHnVYX/w6KD3ejdkfk?=
 =?us-ascii?Q?CjDStrECf9n0Kpkt4KxP+fmYda9XpSOAX+/dZP3jOzF5dJIDgPqse6YEXokd?=
 =?us-ascii?Q?Q+YuV4QuoqLs8r3qOzH6CG3EKuYhG06GXM5dH0HU1VPEhUhNPbLwBUuQfPlS?=
 =?us-ascii?Q?/sXx3JwzNMlbvPnvzuXrI+Y3ASNAD1r0UT+f06EMMgsFcj2GVnIR2CAv8QRx?=
 =?us-ascii?Q?9ax4ivutix6fZ/PfKMB+pDHgfdzKVWwlDXoA+MUX4TApIgAlDj5iNx/jDrzT?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	n4jyp9I15MuhdfTt0Cb0vlrP9ksgH5D7JXXncFANoYckv0CZBbftLGwSQhSVcw+lSasijbI38ymYpDtk50aOZHwexTnRUtZi5K20mU0/3G4vUWQfUX67CVkCsIF3cvIznr3/I4P4RjuVoktfiInZLdRxxa1gcBHBFKkguGRNkJWVX+amslTzyiQmH5sxhCGmCF5tc2+pvb3S6TmGYCYSBnOS5X3AtQU2uGFPaS0Ygl/Vwm8zFTUNGsnUY1aBDt5r/XpN3nkwMX/h5wC7tfeT3Hv/Y1SQBsmRGNMvWETG/exrK1ozRKFftXOdmokZ7I7xH/cVH6Gh1cF6Z6YVQ9FXLnwsPDVSKoJRSvGDpxf+mdEGZGLpJMWmDtn3/81TZ84bBBLFGVKY4DV8oj4QCMrB3l/doA0LX1Qx0cIbQMACdDFCBc4iPvOoQJvlYuIFR1eHYoLSBgj/h7IxITN0XkO7tVvudZa+MA9/CMr+EIV98vcNBHeCLqZFNQz96BOHziulEeIpRQGwLpZV2ojzpsp2ZfyTn4UL3BFaVbdehFaCfZMnNbOUxCiYImnda4+OjRy9oYGkWc1UWDiYV+7VTWesAxZJZhBqTKNEIMd2ECvvcXA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba740f81-6630-4eeb-4798-08dc818f4c6a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:32:44.2820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yH7ZoTYauYkZAPJ34yalWauRh3MyPbJcSUp+Z9Sr/WyL64b8xN9rfc7XslZlBNRNeUAMkZl+PEuQuLMN9Geq7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6318
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_12,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405310125
X-Proofpoint-GUID: 4vE1ATAQnR7pmSNfj2aNkeEbCblKTWyh
X-Proofpoint-ORIG-GUID: 4vE1ATAQnR7pmSNfj2aNkeEbCblKTWyh

The vma iterator may be left pointing to the newly created vma.  This
happens when inserting the new vma at the end of the old vma
(!new_below).

The incorrect position in the vma iterator is not exposed currently
since the vma iterator is repositioned in the munmap path and is not
reused in any of the other paths.

This has limited impact in the current code, but is required for future
changes.

Fixes: b2b3b886738f ("mm: don't use __vma_adjust() in __split_vma()")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 83b4682ec85c..31d464e6a656 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2442,6 +2442,9 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	/* Success. */
 	if (new_below)
 		vma_next(vmi);
+	else
+		vma_prev(vmi);
+
 	return 0;
 
 out_free_mpol:
-- 
2.43.0


