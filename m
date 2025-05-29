Return-Path: <linux-fsdevel+bounces-50079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7689AC80E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 18:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72DEE1C00B24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 16:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26B122D4FA;
	Thu, 29 May 2025 16:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DKjvrWnC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SzWkrB6s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBFD18BBAE;
	Thu, 29 May 2025 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748536264; cv=fail; b=eGvTQAURIdXysWKQX6Nfeq4KVaZhMUnLTrrh87EmgAMkyDzpBdO3AvlWt24hzd3uMODXlOgsS7cOjU/mGiFS4td7a47IKyo5HMXsPcSUJQfBh1D/JQ47RlZil7eP2IInFqE8Q60DSRxgBTYPwLpybrmye5vVuq4PzdePHpHP55g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748536264; c=relaxed/simple;
	bh=ua/XTog8WNMzyNkZmtlsxC1HEPcnqCEkaJ+CaNnpjy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rUMcZu/j0FtCL4os6/3MOxsBGO3CyVFmOF6avhRgnHRZ4TCyPPrQ9yS0q6lmyXqh9iNAIpxGR4XFpQx+Pmod4QcMYNFbOCPgKctDsvGCGy1x5Cq/Ete5qf4IgGA9tA18fBsx3LTF2Soy/HQO7gER3NYhW/ej5/7LBSd0YILs0aM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DKjvrWnC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SzWkrB6s; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TFN9Jn028211;
	Thu, 29 May 2025 16:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=XoxhQ4doJpoM9veems
	FwIKU/VnbMPgExN/ARX4GgpTM=; b=DKjvrWnC405SS01r27iv1msHgzAxOUb15H
	sZ7enHXBbyjF/zvUo8FIUiDuHtl1bDYwUj2pc7C9Cgxz5+i1UIeTqE1oGjpL4lev
	1jact25Iijb/WOUhbWDHvSlr9RRJ/qncHzKrSa8Uw8W+QJojFL3XDEdNcZY21say
	AbBh3hQ2+59udLZbvDOzHjGKHNYg5KnX5Qqns/Iya3UZL5aPmltC/9KG6ttkKcWy
	/MKgZ8v4Dn9qzNiqNUeG9Ys10+R1Y1K2p7dhhaW0LQMxVDSRXoAFGf9lWJKbhKxc
	saSgVdHCebi9UKQtHEXanJsNo8723VvPuXA96fTvUeJEtQi+/gYg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0ym0r1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 16:30:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54TFnEIj020575;
	Thu, 29 May 2025 16:30:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jbxg7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 16:30:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXk6YPOO0j3fN94nzUHavUfSzzPBCI35TEg+7DEoJ7B7vXkTKxB+8RHA+JsAq5xJ6A7fwgGX+ItE+Fd3H71GEwSzzRVpUkto3rTkE8JEENZqC2AN0scr3oBPL/b5+ilXXuYXZcp/HaQXMQ98qouFu2UYPDL++nK1UBh7njo5NJW9K214zcB7piBdjLX86fcu9HdZsvm0gJjUtXQ4Xx+Oz6xvcp1EySb9524lwJ4m+hwqP3ki8yOd5IqYek1YHUevbIi81h4mEk+dqKBGdfbJCsuMIMc4+VQM8c+KWvBX3LPer2RxEHFWbVJxu6uRFXRa/JaT3P+8IDt9KhF2cf0UTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoxhQ4doJpoM9veemsFwIKU/VnbMPgExN/ARX4GgpTM=;
 b=oBmV1fRvLQzapApzxMzrLaI93UQbz+Pe2IJjH+gbFRpWUCaM2aSE7UOnYhNd8X9kmKHaMFM3DrUpoupPAxkeEe5Zwmqb36EKZF/QjqJiAulcMTRBeJFnNJQJt4J2XBU/1VcJb+Z6exzyKYJKnt6MONnET9M14cAbo+tmq7wFaKoL1muqj0SNTXzeECbJ1vpNixKycvF86YEmI4scYZG52DtmX3x1ElB8gfWrpwE0ue0zqXEESW/PnxdrfQoms5KTeBuF5uz8JMmKBSXpAvO4mkwTKqsMIHPkMF4NaotbHCUg5kGgM4qGjMGyANbCt8laPvRDqkk1u1I6uK+NHRNjHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoxhQ4doJpoM9veemsFwIKU/VnbMPgExN/ARX4GgpTM=;
 b=SzWkrB6sMMWxAduTHsouPHRwtGHNvvrivjoaC9Nl1ZTqqW6Cmd+aCmtc6lckgFSsYEp86ZDEZjpf+t/YiSLwUYlgh4K9blAtfMtJZldOaLkUvarP2Tftvc8Gfub2cPqP4FxthnJVSNn5LwIr2OXGeH0UMkFYkkZQ31me7SePqX0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY8PR10MB6684.namprd10.prod.outlook.com (2603:10b6:930:93::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Thu, 29 May
 2025 16:30:36 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Thu, 29 May 2025
 16:30:36 +0000
Date: Thu, 29 May 2025 17:30:31 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: xu.xin16@zte.com.cn
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, Liam.Howlett@oracle.com, vbabka@suse.cz,
        jannh@google.com, pfalcato@suse.de, david@redhat.com,
        chengming.zhou@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        shr@devkernel.io, wang.yaxin@zte.com.cn, yang.yang29@zte.com.cn
Subject: Re: [PATCH v2 3/4] mm: prevent KSM from completely breaking VMA
 merging
Message-ID: <1ffd4f8b-2aed-480a-bcb6-72f248cd1268@lucifer.local>
References: <6057647abfceb672fa932ad7fb1b5b69bdab0fc7.1747844463.git.lorenzo.stoakes@oracle.com>
 <20250528233832445zSfRddcejioi-qwhWuUBJ@zte.com.cn>
 <2ed7c9c0-30fa-4ec8-bce4-d7ef9d63b4d5@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ed7c9c0-30fa-4ec8-bce4-d7ef9d63b4d5@lucifer.local>
X-ClientProxiedBy: LO2P265CA0224.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY8PR10MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: 5690c9c2-c36d-4087-d1f3-08dd9ece23e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X8maluLnbbmirMGfUGToGRDKUd7vw2uof46N9Kv0cT768CXq7L7X8cVxdoQ5?=
 =?us-ascii?Q?61SgIUGX9frJkcORReXTJqnEHN2x3x7N65xih8MrXSX2oWnt1CaxoN6R4J/V?=
 =?us-ascii?Q?TJZkzwmetRkZ2G5n2RvKNtaPgSCCs0RI13dowVMRw6cxVLqU+ZedH3Wt8R4R?=
 =?us-ascii?Q?pSNI/iy4rxiymQtiItXFsaFND/2sU6X2OdxnU0l1ggOa+OFAaIgQqcjTthcN?=
 =?us-ascii?Q?kTUqcsVc0sLfogLhiY8ME7RZYhBMQgu4ZX/LEQZioThl9n/nEECymws4Qy4h?=
 =?us-ascii?Q?16+sNAv/I8yIkCGaeQwQhER7DDAILjKjow8SyjnG/gxo4nkQeZa3NORp6BuZ?=
 =?us-ascii?Q?u4787vRH9CrEGgPvD1aexuV5bvKfp4VBtilB4PFtnfbABZz8bZIajxwrbQUV?=
 =?us-ascii?Q?3+ESyaTPIJp81hcQkYmp+nwrFTIvJ34L9ol6byXqom8EBm33eL3Oi3sD5d1Y?=
 =?us-ascii?Q?4wyBpd82pkBUDKwK5Drnwm+N0wQb+O5f/ce3ttTf22TUAbSAiGOXOqb6uc2e?=
 =?us-ascii?Q?7q8g/TQEDxs850zCdHcySkMKyvz5rpF89lNh4pNMcIoCrooNEzWKvJUs40pc?=
 =?us-ascii?Q?y+wg8Zw+o+ulYdZjHtnIiTUXmO6W+KRhJqc7fmqfOCwNLRofjFhlIGJ+avmU?=
 =?us-ascii?Q?Pci7tcrxxOcELWN62XJ6H/UYVh+6rszNEwoito972jzbetzl7ef9zyGmJfti?=
 =?us-ascii?Q?ouorhwYYRF+A5JuA6bLJ71N83O69rcnr7c0Xnbuc6EvNvz7NRDthV49vfqVq?=
 =?us-ascii?Q?NHBrZab2dqf2CR5KQqAuVuXW5kpjJXlcMRv4dVFVtI4+vz7+/barRKm7yUvC?=
 =?us-ascii?Q?QCIvn5aWfwPRoW+sCalRy2SMbJSGQeUezaZBrr6+pKcalD0PqoZVziooRl9P?=
 =?us-ascii?Q?jGcs9tyYkyXq9A5XBJ9KZZxye+EOadKUsyAKsW8q0SYO+k0q1AMjHQXfSI2b?=
 =?us-ascii?Q?xt+eER7eqezUFkCzDyKefrtbWosf3yDNspxx790EBawpfD0ns6CIY2FraZCZ?=
 =?us-ascii?Q?INU+zcU0L5XHTDUWzCKKQpqBklB0JiTlij+KCgZuAFfHYqcgritrbanUBCsa?=
 =?us-ascii?Q?/OLa06uEDNyomAS0v7cjq9PKuNAKrpip+lItXd+x+OxJcJqjaIM94qfQuevj?=
 =?us-ascii?Q?I5gMVNubtUSO8s+kdCich0XTpjpWv64dg5w/+P3YRwnxZmWNdDdTRPxiwiiC?=
 =?us-ascii?Q?opXhZXcJfbSLZV3+tjqpHC1j10RhzdVAJ664f+dNMzL0QUJ54DxB+O2oWD3G?=
 =?us-ascii?Q?reBsyB5QD6DDbtCzorygRDm2gtkWCxZIYqHIaJhgobxAMTbjnnVUkBmmJ08I?=
 =?us-ascii?Q?fgR3Ixhs97oAmgJ/hZZuMdcKTR872ggKa9hp1VjAAsUqIv9bZKOVc8Si4E1l?=
 =?us-ascii?Q?lgnrBVXBTWz92BPjrlL/w9499L4InN6ANSYzlvmylRNK2jZy/KNYujW+0t08?=
 =?us-ascii?Q?xuCEcVWqXRw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WfNNc5HX6VK8uJxC9N5+redneNRU+ewA7KvE9JD9hQalLaabF+NnsK7Ngf6O?=
 =?us-ascii?Q?4Xn0wR/fra/xSveZwWpWVqPWh/L8/C5bkglbz/d1Y+xHlNdXIaurC+BBH8dA?=
 =?us-ascii?Q?TFlNFsjDLgx7Q2BNyrrXjXSaVdxGHWtMPLmkCdRO6dcUMyefgRzYgl6VAIzu?=
 =?us-ascii?Q?HTtsGyQ7edRCMNK72gg/vK+MVDEvufmIHnqmgg8R/M4W+23DwnXJn4zgijNO?=
 =?us-ascii?Q?EOfnlS949viUvNQujr4gMWIcMnP738CTkIBo8KwBz1PU8n6qtXks7izDseqy?=
 =?us-ascii?Q?apNfX2uYQ66QYjW5NWCMAIQHmMqX2CCwC9QmPU/m1rEx21jc2jLJtxoNHrRk?=
 =?us-ascii?Q?l9EzEovc9zx1A4lOTtd41M2pqo9Gb2eWRyuBZWBh7s5bI/849E30ZdW9ovXH?=
 =?us-ascii?Q?HlEJM23/fa7OMF1C1EvTTXHbrxOQAO40nRnxRazXW8tnyIZbx7gisX8MuYyT?=
 =?us-ascii?Q?EPE33m2vfeJyOMUdfiJsGSVw8Ef+UiN9U8B/95Xkkus5hxMrw90gmjfxqkUu?=
 =?us-ascii?Q?Fex3wWt22abALTLSNDwAejmfn/ODMXx1j8PsYaUTWaGV3mhco6u2jrz1+se+?=
 =?us-ascii?Q?0mv/D5SyTiBg1EdMyU9ba5MJ/SMDBFpom4rvX9MP3ydhwUi96xd+4P97V1QM?=
 =?us-ascii?Q?NyQfIlSoRl1/2uFLzzeuiHDFGV0yVCtqN9p31VcipI8KdWEeUsU+XAdjIuqD?=
 =?us-ascii?Q?NCaJqvDcPD7zNBSJHlL1I6yhBGKES6k7vzjJvRzbPuZJ90Powhtog9oa92o2?=
 =?us-ascii?Q?eE5jsC/bzeKKKD2Z3mK4IGNUyr/LCrJNaVITDkxJ2nBC1xF+aLDdFKfTUxkI?=
 =?us-ascii?Q?EPycovIbuSYe2IGCOwdRGt4KE6B7B5xHME1jrdOHPjkjMmR+79bbjqQnjIGQ?=
 =?us-ascii?Q?BfXhS64iVgA4URXC/S6b/7xi8FxTnzjcw1nawgmHTdRDSZDeJkStpGh0MGvu?=
 =?us-ascii?Q?NBmCqUMa7Y1FoxvNiurqpwu9ii/GWsDazhuOOCcHOhcJLumvPHGD7BVfQZ6e?=
 =?us-ascii?Q?vqdyeZlQ5/SSF0xQBnGJFWEkt71L1Y0wtOx6hKhFXvCVFCaYTX5i1pOUr3+q?=
 =?us-ascii?Q?C5wzY2vIYZYmDs1TMDqKqV/baHTbfxuSwPCYLjd+8op5hIwWO0uPl51Vqm7G?=
 =?us-ascii?Q?7kAuWvSQiJvxNSuQik/MVeeccTXQhdM/dpROnM56QGCbJkc4TByLM76OoXeY?=
 =?us-ascii?Q?EUY/LGuBOOovnZ2g2gY3rhQWsxgbPVhMrwkMAT4R3fcR36qtMxWYgGK5tbI5?=
 =?us-ascii?Q?SH3NLth1vHzUmAzqs5VjlMAjNNkZPzLsL1zFGG9WJYCytgMwWiXoXOIZzyVz?=
 =?us-ascii?Q?pr+tNRhl0pPH+MYygeoaPeDY/0f0X8/halqre8y38PnPYhOQMyP3hfESCguu?=
 =?us-ascii?Q?Po9uBybb6M3iruNG1QljEbagdRbQKpxZr9OyEQL1/bqRDVsosf8ZUXY9fm4d?=
 =?us-ascii?Q?DfH0jczd270+8u0rxRha7T2laW+xV4e2HRd8qHEfsiOUSTkBqNRoxzm5HO+e?=
 =?us-ascii?Q?a1uyaHBiVpqJrc2zhT9pAp6wxa3i9fWVitQVWqsaq630EqZJ4rWmyVAxhJ06?=
 =?us-ascii?Q?r6ZTt5nyh8f27fInwA45iDYxY3NiPBLppindxQOb96uCs8Bea0yfPkgd48XE?=
 =?us-ascii?Q?Ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FeXbDu3sQfQFCcRMa2EXBVkObH1+4AStXyxgnym/ZPbKs6kPS7oZsY69ySCY/Bco6SuLfodYrwnH+Odvv3jAjCdQCmljtPbGYB/je/rWktL8f9KVR+ti+qBLwI2SMYM/0ExKB/wpuLj8gNRfwHGXd9S5JNs9teoySOzGrTz2l/b4kIh3laZjOLFsfhgwa1SXjsxuYW5JIQouGTmR0wBMMIl0LBLOJsEKYNIBzgIUgnX1zPeZ8Xdz9nL7N3nV7WJncE9n06qF0ZGA0MARi8vOVZnZAlXMA0EcdVKYH3P1/R1jxUP5rB0EHtpnXnKVxFfJjG4vro03PJX8vYPsMl0ekxY9X62zAnCuywHrExtElC3qSFLBC1X/I2EGv1A3TIKHx4VtYwvbGAMDkRy0e0WUuRboTfR+uVYWJoalmoKIaQWvbf9S17FQhFCUUc4w0+fdCsjVoFi9zsMlhym6kW/orqTjKHbB83qgtsKKO493dJQcFw6E+P9PsKm7Ra43ovrdWd4nQIr3CAayfak2f0PmHw7abZHuxQfDAONZARR0m+6Kh1pg8CZqzZRUI8kmxfpy4ir4W/47BIG8ccYfrC3HEDIqSadpjFC8vDF4vJ864Js=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5690c9c2-c36d-4087-d1f3-08dd9ece23e1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 16:30:36.0688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RdDzQI6ASJ/Ks4ykkyOb/gsmQM8xtbGimvl+/loGuGNn/8zSU7MayK9QQZ+FSalHG6VEvvX043Tkqu0Wx6BJ7raiq6oe3NavORMZe5UEgjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6684
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_08,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=921
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290160
X-Proofpoint-GUID: yBXAKkmLj5GXaCJD6gCn4bshrQggXnI2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE2MCBTYWx0ZWRfXzFLW/gTXSjoe gHzpdYWRi8fjH1kCouZRWrXki0zZc4RwcVMtfcECMaRWx+tXk87mxiZQtighuBzE9JqtjOfyk+P r2ZNGUsNQrvEgB3ENfgAIpQmPFAR09MJYSJywwQTRmdzXWuC7CdzXERBAM0P3EM9gI8dL2P33Qe
 1uQdrJyF0dzPX5KMOyFBeV3B2CSMzbiTgQYcaLHnJPc4oIHFI7FGel/0zt+0nCNPCCId75JlDu3 FsdlFy0aTUN4wG2jqG62RzfPYfKg7Lr6mcaLh4aWdlG4EF/Y6qD4WOMApXQKor9nz53qWfYqbA0 yXREyZt+EzSIIvD9dWfdKaV/TgFc8rzDB8nwkXh7OBtLAoAeIHETcew6gwzGOxS33IuXKw458QQ
 EtYx0av9bCIFIRLmodB3RWX1HHdTcZlidBIc3cAno19+CZg3r0TXtXhiPEdwADwX4es0gZEV
X-Proofpoint-ORIG-GUID: yBXAKkmLj5GXaCJD6gCn4bshrQggXnI2
X-Authority-Analysis: v=2.4 cv=N7MpF39B c=1 sm=1 tr=0 ts=68388bb2 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=1RTuLK3dAAAA:8 a=k22HZQl1n-8P3MQ-DBoA:9 a=CjuIK1q_8ugA:10 a=kRpfLKi8w9umh8uBmg1i:22

On Wed, May 28, 2025 at 04:50:18PM +0100, Lorenzo Stoakes wrote:
> On Wed, May 28, 2025 at 11:38:32PM +0800, xu.xin16@zte.com.cn wrote:
> > > +static void update_ksm_flags(struct mmap_state *map)
> > > +{
> > > +	map->flags = ksm_vma_flags(map->mm, map->file, map->flags);
> > > +}
> > > +
> > > +/*
> > > + * Are we guaranteed no driver can change state such as to preclude KSM merging?
> > > + * If so, let's set the KSM mergeable flag early so we don't break VMA merging.
> > > + *
> > > + * This is applicable when PR_SET_MEMORY_MERGE has been set on the mm_struct via
> > > + * prctl() causing newly mapped VMAs to have the KSM mergeable VMA flag set.
> > > + *
> > > + * If this is not the case, then we set the flag after considering mergeability,
> > > + * which will prevent mergeability as, when PR_SET_MEMORY_MERGE is set, a new
> > > + * VMA will not have the KSM mergeability VMA flag set, but all other VMAs will,
> > > + * preventing any merge.
> > > + */
> > > +static bool can_set_ksm_flags_early(struct mmap_state *map)
> > > +{
> > > +	struct file *file = map->file;
> > > +
> > > +	/* Anonymous mappings have no driver which can change them. */
> > > +	if (!file)
> > > +		return true;
> > > +
> > > +	/* shmem is safe. */
> >
> > Excuse me, why it's safe here? Does KSM support shmem?
>
> Because shmem_mmap() doesn't do anything which would invalidate the KSM.
>
> Yeah I think I misinterpreted actually - looks like shmem isn't supported
> (otherwise VM_SHARED would be set rendering the VMA incompatible), _but_
> as with all file-backed mappings, MAP_PRIVATE mappings _are_.
>
> So this is still relevant :)

Will update the commit message to correct the erroneous reference to shmem.

>
> >
> > > +	if (shmem_file(file))
> > > +		return true;
> > > +
> > > +	/*
> > > +	 * If .mmap_prepare() is specified, then the driver will have already
> > > +	 * manipulated state prior to updating KSM flags.
> > > +	 */
> >
> > Recommend expanding the comments here with slightly more verbose explanations to improve
> > code comprehension. Consider adding the following note (even though your commit log is
> > already sufficiently clear.   :)
> > /*
> > * If .mmap_prepare() is specified, then the driver will have already
> > * manipulated state prior to updating KSM flags. So no need to worry
> > * about mmap callbacks modifying vm_flags after the KSM flag has been
> > * updated here, which could otherwise affect KSM eligibility.
> > */
>
> While this comment is really nice actually, I think we're probably ok with the
> shorter version given the commit log goes into substantial detail.

Actually on second thoughts, as I'm respinning, I'll update this and replace
with (a slightly adjusted version of) your excellent comment! :)

>
> >
> >
> > > +	if (file->f_op->mmap_prepare)
> > > +		return true;
> > > +
> > > +	return false;
> > > +}
> > > +

