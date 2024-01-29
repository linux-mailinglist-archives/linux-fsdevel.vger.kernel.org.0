Return-Path: <linux-fsdevel+bounces-9439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EED84146C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 21:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93851F235A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 20:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40FB76053;
	Mon, 29 Jan 2024 20:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fXySIXIY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tJGe/Aep"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B9376048;
	Mon, 29 Jan 2024 20:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706560767; cv=fail; b=J5vt33zMBbex8msGZksyOqGBBBqXRvyb+DeItF3VPULkQOWq1ikdQcwnZteGlP6HwLwdLol6Tm/wiivctBxt/BXg3eK+Kg4Dfp9x2kb8gLJ4GcRrxc2Njr8w71ofLoUUtDuPF+mexHRWrM+/ih2/EiiALUiy2RlBOkPopqMe6ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706560767; c=relaxed/simple;
	bh=T9mGSFgT2K+VCdHv2lJlqbW/eKC/ZzvbyCIfAgSEUZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BCLX8pdSRZEwgjnyk9++ziCG6ATkYG76XYDVtbX/8GfRYcdSdtILc+/hKr+UuZVWQe284RpzQ1c8SCMWbwGUNRzYt1JCRr7KLJKLh99lxqAj65TU2vT1xgXVGv7HPu2t9dfXplR/bYxUlaDulYXVWZieoagG2orvh062B9k9OzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fXySIXIY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tJGe/Aep; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TJi2HT029706;
	Mon, 29 Jan 2024 20:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=xLhDKxbriWclrss3G8qMrkGYQaxpr4LjUZPaPzJPdJs=;
 b=fXySIXIYazPFoObkDENo2CbhPyI1BCLVFnC2WtuObNwGE/mRs0QvWx0wW7eJOdpOuOIo
 2OLieOOhCFyPwC9OljMD0E1wN5CbmtSI/HXNWUVV7mHS/exHY5o3liXR8I1JxW8xf2tG
 TrJu7fKRNy7pqfq3pA7Gk4vMmgY3yB9eKXCMdXcpTZZ8/3PgA78KXoPCnto2F2A913yR
 lGWppPXdrDmV7nUq+e9r7b00jQUxFP3FQDWJLslcU+UVnbCDvZdAFS4+E/Giq8u4fdS6
 d5AC4zhL+F1ekuRB8tzHq3y2j25UUUErFuyqvR67/2ptbMOs0LnMScwBN5bF+VrvwYU4 5w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvr8ecvu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 20:39:10 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40TKSHmL040118;
	Mon, 29 Jan 2024 20:39:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr96a6wr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 20:39:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSOXmJe+lrYsS4kk/02vT4b6IMLRLEtxAkYR47HrOUz/4F8VQwXE+fCk1051EZ6646csXAPgeufVP/wLRYxuZ14OglwB+0DH1lck8hOzxFuhxUckV1SY0S+cW/7zt0aRBB96t9LR3e7dzn8X4AsKlX613Kq8XDA8RIAG+SYSdY8tgsDyicFwgRy80Ji+KHjWbKB1B+KZCdd4N9/ZJvjfyVYfcJ4CrCrDjurcoNkPw3FRlPlPGmjq69J8t1HQ90FXMbVvHOddpc+Ig9n9bRdSqRQXDh1YuHXAt2QT6IE7Qe0Yb5KKFabNbyYmA+mRVsVO9cPe3JSCr4SX+gXcIxu3aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLhDKxbriWclrss3G8qMrkGYQaxpr4LjUZPaPzJPdJs=;
 b=QxCNYFHMx1mUk48rZkKFBC+Y4ZErT/yePCu6W+bfFUxGNiBQfS5n8Ymlx1mbMPFXko9JdqkzRv75mR2CWlwskb9qfr+Ih94mw8SE7fQgNcImWpTk4DbnGD8SDJg2lQ8cJMcF4knj8J8YMCZXLIrerJEaWrFV9BozN2h6FgY7XgGhHqGrx7rE5vF18irpRraXljHoog0SoBnxCC++dloWt2v/Zn0NY1aquGKGBTNITsbk+eLIC65cULtMdCDl93MPiTiDThi1p04pYJwYgY5eOuVeoITWWN9cu9nOI4weJGLDTN1Jdu4TciQ6cEbT+e6mxtVXlhbOcDfzUKgaQ5ohuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLhDKxbriWclrss3G8qMrkGYQaxpr4LjUZPaPzJPdJs=;
 b=tJGe/Aep3EvFZCwSQezXs8e0dMUKepIvahXA6AIjFkSJMA4YSxveea8cxC+NdGGkgDRKwyUmYcwrSv1tBO82e8g8Dc5S/zg5RoQES21EC8Q8DSCykPhf79dyCQwNIoGhc77s0WjSPkFC44ogdy43wsWUtB3QZIbpMIZ9k+Orwqo=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BN0PR10MB4968.namprd10.prod.outlook.com (2603:10b6:408:12c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.33; Mon, 29 Jan
 2024 20:39:07 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 20:39:07 +0000
Date: Mon, 29 Jan 2024 15:39:04 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org, surenb@google.com, kernel-team@android.com,
        aarcange@redhat.com, peterx@redhat.com, david@redhat.com,
        axelrasmussen@google.com, bgeffon@google.com, willy@infradead.org,
        jannh@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        timmurray@google.com, rppt@kernel.org
Subject: Re: [PATCH v2 0/3] per-vma locks in userfaultfd
Message-ID: <20240129203904.7dcugltsjajldlea@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	surenb@google.com, kernel-team@android.com, aarcange@redhat.com,
	peterx@redhat.com, david@redhat.com, axelrasmussen@google.com,
	bgeffon@google.com, willy@infradead.org, jannh@google.com,
	kaleshsingh@google.com, ngeoffray@google.com, timmurray@google.com,
	rppt@kernel.org
References: <20240129193512.123145-1-lokeshgidra@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129193512.123145-1-lokeshgidra@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0265.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::29) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BN0PR10MB4968:EE_
X-MS-Office365-Filtering-Correlation-Id: d50ec3aa-0e85-432d-89ae-08dc210a56c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yLzQV4Y4lArJmJPlu0bsiSt87mmdlMstmo6QyVwavmMC05Tlupqj3NpZAsNo5EcN7zzTdxKsmRFQ02lxoxFb9/NAWiroqkXxtCwbtqknPly4i7c9nw7SHLbwJv4+6n5ajNXsd0yEh6w4tOP6ma8P0bheXPDFB19loNzy2yGty1yFQfMyN9fxJDJyfF3Ytn937XckCx2E0A3v+DjPN3EFWqiz8wEqlDIidLvq3HXpzg+ORXMG/qby2Cni6eYbTZotbcMtV9BvYjPB37kN818mjagjn8bBnEBzLLdTPFlb+VJWAUcxqHTVvMhjbPjoLqrnp/hUe9ksSD6bQRsrHsbwDaqJiC9fUobFwjeOel6tP1Ow8KPWkT+reW2H777Q3ApgTj9XvKLPsrc0MFjYbaP37U9JBO624u+fvHKrSO6ME5TDGmlSNNLWAvmdcp1f5vx6EH/IrPPbw8xAUCe3GOb0HZzhyKuL8M85refMgYJsemNv2DiBd0SdEsyxZrbQDwyKjEJPbgMCQjDJKo49HXUKTJsgPWswA+9BOciIXmLlpOo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(136003)(396003)(366004)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(7416002)(41300700001)(5660300002)(33716001)(66556008)(66476007)(66946007)(83380400001)(86362001)(316002)(6916009)(478600001)(966005)(6486002)(6666004)(6512007)(9686003)(26005)(1076003)(4326008)(8676002)(6506007)(38100700002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ukIh+X+REqYgcgSp/ihrciTxBm8Nf9wqq2SVNuqgaaH0ZccX51hsEIkVw24g?=
 =?us-ascii?Q?SqDNcW22B0dFt5Awl6adZF0rvVApiV+dOmNYWkQRX6xJRuJGJdJSf4kqzrTJ?=
 =?us-ascii?Q?0m2RAq80ZUYyhu3TBcjI9xFq+LUpKyaEHqc3pAbncakaNIZfAk9HDVp3qnjE?=
 =?us-ascii?Q?dgUoRiq1dgxVXCMkBXcfs4jupxAnXlPVeQSvrLbmCR21VDFEckDyKq4ajNUL?=
 =?us-ascii?Q?UxH2OXmFAJGXDZuH6qvAvBeuCmsrDNqvttE59bAoYlMxxVMNERZvwYAjyvD3?=
 =?us-ascii?Q?/3L4WXqvZMew/VJlzlsrn+upKN2hNZhTbe2TpY9Q1Pe7riMz8EHY7gMJcTYo?=
 =?us-ascii?Q?40SpX8pOyCjb59M9k7zKruAx7zP1If1/1L3XP/zKht69A7NA8zely5o2RpSJ?=
 =?us-ascii?Q?Yaa+uwAjb6ELdU21ameifA9i2/B+SEy6hUU0VnpQ8LG77OzB/OARjBCAj2+A?=
 =?us-ascii?Q?TIunn1OT4skzjHYMGxQrgKb4NmCGaRBEtacyBwTHA4ecy/lRFzlX0QEW0hMp?=
 =?us-ascii?Q?1DOVVr2tQufSCFdVNp6WxJk7Ca1ypPDTaoxOKWvjhoq4e4q8HSNZaEDDkxfY?=
 =?us-ascii?Q?wBx2A1oCcY9LORMmhLjRdVufkMhAHOY0MLwNBSCZOkhD1Xs8oaXaUOPKuIGr?=
 =?us-ascii?Q?w3W5mzXr8QcW69i/ndbfFZquwboS1iuuWPCCRz9kQOcpe2Yt9TA0o3FSEJCq?=
 =?us-ascii?Q?Cm3HLK4jzI7+gQj6hsJyLdKAYq6aaKwGTB9sn4z+LwBxMOm1xkjSr5BPjaB1?=
 =?us-ascii?Q?yfynWYiTQoc5CJZ2s09Dj41gTZLwt7LEb3Y0YwgT2WUDrekrOi98Fo+Tlq4J?=
 =?us-ascii?Q?FLQqyjYVj8jZKHEVPxqew+7OmTtMGf3KIFsufpvp1YSZJAHJea/EDVdFR7Nl?=
 =?us-ascii?Q?1hap8KDwL2uDpMo5vgXnFd3NwsLCIpi34xaYOBg3BYKwbCN5mgdoNIQNPCaw?=
 =?us-ascii?Q?taXAg8I9qtNZYt+7QUDSvXuZd29VqwW8mjpEIgL2j3WHUL7Fca97BKSFgrZ+?=
 =?us-ascii?Q?fzPdOR3glTLJh1+U9UIN6uQ53OjeFCwmkljEArah5vW/dh6bjtOdWXUNzvqT?=
 =?us-ascii?Q?NcXRA56UeVH5MQwmvpZ2u87fPuFOl1dpjtH5BOne58+OQzsXhJjxKcX+nRY/?=
 =?us-ascii?Q?7CO9FN2k6hslS1k1t0m0FW7qAlZV82cfPYCOkEtLrLgeo9WMODldcJZxClbA?=
 =?us-ascii?Q?CznMRzE3PhnBR+2nkNV9/2xnPUDipM4tLqZs07FolW1QVvydEJ547aXYvPV5?=
 =?us-ascii?Q?9XjDhbAC+iqRQXO595xAOI+rPdTIAS3BEHmYZGsb9KB2oH6mKYMNxVIUOjm6?=
 =?us-ascii?Q?/LUeLaYQduH+fKdS/w+xIFUsfRFaHzr5yPOKGGpi3J4/Y0ZynAJLXhTig8QQ?=
 =?us-ascii?Q?nB2Bc3+DEEXL8V10oop4uavbFXuLWKTMgFqGfljJqaBJ5nTIDFBCiVPdUyT4?=
 =?us-ascii?Q?iiaLPRRNv18cVQy98PtEsDbTsSreyCG+PfPhJCAMea9vQcQEgzqLozensLr6?=
 =?us-ascii?Q?lWyJp2lhYGtobVGnjeI8rcClrtJJJLaOaSX4+WPPIq6OKHQu2VjT/OtmzxUn?=
 =?us-ascii?Q?Id3UNL+2obp70kDK1l8BB1OHSjjoEBriiK9bNN95?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dZJQy+YAptTIOOL4zfrz1aG8+8tngN2/YK9ojDHmpXQOFp+JfnPe3qc3GWejQN3Ue2pki/SKl3h4Xm34+4mMg7uc+wYvrP7WLbW6apfSFhY2XwSNPcYOSGiwfbezm7WIOD4sLpC61NqN+4SFaNHN0/64E/Seo+UpzRu0oEo/CHLSQ6KCAbhg34NFtUK5d7z77f1lPZT3sF/1Uhq/0MUbTzuUNuSoj1qgQ+ycTQPlUe3TIW4jo9+ddSgNWI+EsZAbNNTGMgyVUHF1IFjT1LGveRW/BgjNtFm7bN/efQbjOLZOPv6i6fyV6BxvOp2OB/2L533J7+CVVMYFko8BWlSDTEiKJkf9ld+QFAxTHRe0/is6x2LlzuKQM6V3togA03ztN3N0go0VgXTVP1iEJkQTopPJ+lEI/ASm0460jvciG2llm307mv0jEJ/bQvzIPTcjwO75uIVwSrZYTWPk/qdd6K/NL3MnW1Il2whaWTPkSEXnfcea0H5EcjAUJDlYCSqr1YoxStD+u1HacVi04y5JyfanKzUzCXJmJvMkwLz+ftZL1nEn+hHyARsqU9dT3n9Ml9de1hb1RUg0Lo8o/daXvyWz4iVAWpWRZoVGcW83n10=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d50ec3aa-0e85-432d-89ae-08dc210a56c9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 20:39:07.0250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5a/Z02hDaCf6utspHDM3KYhfAj50UlM9Q5l0MT6KY1qmYAlXn9ad4MS6X3SUjTYyb+UDSD9nyhl0EeO3Cs5Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4968
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_13,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=521 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401290152
X-Proofpoint-ORIG-GUID: xw-7LME-MqOsasFHSgLLeZoRv6qp6eZs
X-Proofpoint-GUID: xw-7LME-MqOsasFHSgLLeZoRv6qp6eZs

* Lokesh Gidra <lokeshgidra@google.com> [240129 14:35]:
> Performing userfaultfd operations (like copy/move etc.) in critical
> section of mmap_lock (read-mode) causes significant contention on the
> lock when operations requiring the lock in write-mode are taking place
> concurrently. We can use per-vma locks instead to significantly reduce
> the contention issue.

Is this really an issue?  I'm surprised so much userfaultfd work is
happening to create contention.  Can you share some numbers and how your
patch set changes the performance?

> 
> Changes since v1 [1]:
> - rebase patches on 'mm-unstable' branch
> 
> [1] https://lore.kernel.org/all/20240126182647.2748949-1-lokeshgidra@google.com/
> 
> Lokesh Gidra (3):
>   userfaultfd: move userfaultfd_ctx struct to header file
>   userfaultfd: protect mmap_changing with rw_sem in userfaulfd_ctx
>   userfaultfd: use per-vma locks in userfaultfd operations
> 
>  fs/userfaultfd.c              |  86 ++++---------
>  include/linux/userfaultfd_k.h |  75 ++++++++---
>  mm/userfaultfd.c              | 229 ++++++++++++++++++++++------------
>  3 files changed, 229 insertions(+), 161 deletions(-)
> 
> -- 
> 2.43.0.429.g432eaa2c6b-goog
> 
> 

