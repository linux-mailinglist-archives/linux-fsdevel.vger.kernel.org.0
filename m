Return-Path: <linux-fsdevel+bounces-56359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C27D1B166F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 21:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2BD56077F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 19:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC651EF38F;
	Wed, 30 Jul 2025 19:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qkQ9KbRb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XwpT9aLg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662C518E377;
	Wed, 30 Jul 2025 19:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753904117; cv=fail; b=qD+cANAvmDrZRbC0/hUmr9fxbYq2AWwwxG/4RbWtEyAf03f2sU6VzSMSxOePge1K85vDIKxUcYeeJ9jb+QKRJWOXnrtKHoJBnlRv6vlS2NgyEYBJYb3Bz4xjdMUiX9U48vkROyOS//tZuO0Fi13xyDci9JcK+OvYLVI9w4YY1IA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753904117; c=relaxed/simple;
	bh=85RbuTqRhfNNTFq/1r5e1oKfCTQmqwZsH+RpQaWy31U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HSPuo1/CdtUTR/b3QOtXw5oAN4l4HSENJTT5UkNXYMjZj6FgneEZc59qHymNRNlIyCI439V1EUxrsV9cyOa2cb4MR0J++Tm58uISgg893AW2voFzGJlgxNp0H/etutTZr0Gw4BLtM5nKntosvyqWsWceoynlZUxIpGDJ06d6xNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qkQ9KbRb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XwpT9aLg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UJC56o020031;
	Wed, 30 Jul 2025 19:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=C68sWzSq4hJJBa7Htc
	9P4IEMRDugJkc7r3UqggbC/wc=; b=qkQ9KbRbTRkpWxQT3ue8NTHbaXo17HVF61
	7eTnhhMbPnDZtV/08LnSEJb13gWTeKumvTzK2vkfEvJ/L5wcMAaZkoFgvNjWy/oK
	IrShAY/5PfW9CQFriPd+L6ZTi0hMhkFKUCrutrsBC7yYRQRrLefXLJGZlGqHaqP6
	DF+bGTgLeGvv0mppXL593t/jSUwIr5jWAVL464YCZnNByD7nD2dReNEcEKbb4XRf
	cNgaaTUgg4/7hilErLUpyxi7cWk3TEkFcH8E0vpOHZroCkaceV4KQxToiM4dDl+a
	3XgpHw4djI3EBXl3GhDXSshMnwqCKnW9c7MnGcl11v0zHt9Hlj3g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q5wtgsn-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 19:34:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56UJ4HoW002467;
	Wed, 30 Jul 2025 19:31:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nfbm9up-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 19:31:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EO/rXdmaxeGokEHq1XrKw6FR6ZsVOb0e7aqkpYhfyQX9Rq+4TuJ7rjYJ3FHH/KrrkIXlAzVQNr+rUzTcyr3p6XXlnJq5GjsG0kSgSQQ+wkJ6lk6gfJED51qcmwz74j3nph3ZtODph12dxzJnhmGgQK6uvLu/e0FiygGYjlFnOPulz9d7u7FdmmCYXCWopQphPzk5OL+VAOapNV8uzeZJGeDfFQE1nlsfsFZRclFDkrzWloRVcPGMw9Eoc4YTUvcTBvIVRhiycMrCPXdroRqiWtLjCCdKlw82W3vwYr6AXOemoR0k5FfjeUhqJTfi+wGJCecH2Dzhte0n1IYFIhDyTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C68sWzSq4hJJBa7Htc9P4IEMRDugJkc7r3UqggbC/wc=;
 b=Cqc/uj+YXj03mL5sKFb/Bx1DG3aDT+C9+gItiw6QLJJKPE+ejucceYntM9kgSAH0Zq4Rv+G70Zo5AtYjUtMe5voJ8CADDfBNJvUm/6/ZZgSOBFogMOhrWiUZ+lLVmFuLrKAftwvlSx/8Ie1XON617Gi4d4t0YzE6OmBLq9zh31pWeUfsGFwlvSu/5jwrPzwyeinYehQUC4ApM7RMX0Dm1Ubv+JdsT0Qbe6Xpokkz4o1Tmz89eDniM3ttbMBz4oSI9kT+R2RH485T0bsN0lVT5fnRxrYYrjL79o4LMTA5WLMPvPb/4H7DeoGbb807Bk8mrHJqhc3YByD5AJwKjXwVYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C68sWzSq4hJJBa7Htc9P4IEMRDugJkc7r3UqggbC/wc=;
 b=XwpT9aLgI37byi+45B1GsEoug+m3ZcP/iU/7XIU5cYdY4gYDp4Uoq5k68oezqToogJ58cqLE8RiZsdzf9sX6D2XClVbiSkkBPLzYSfBy+oRs2fwMMC4vRWFyNR9iIFHhO0wRFEOI0tYs+lIa+RqoVvDZFeLt4Lwn5pbGGkMfdVM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA1PR10MB6518.namprd10.prod.outlook.com (2603:10b6:806:2b4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Wed, 30 Jul
 2025 19:31:18 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 19:31:18 +0000
Date: Wed, 30 Jul 2025 20:31:14 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, corbet@lwn.net,
        rppt@kernel.org, surenb@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, baohua@kernel.org, shakeel.butt@linux.dev,
        riel@surriel.com, ziy@nvidia.com, laoar.shao@gmail.com,
        dev.jain@arm.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
        Liam.Howlett@oracle.com, ryan.roberts@arm.com, vbabka@suse.cz,
        jannh@google.com, Arnd Bergmann <arnd@arndb.de>, sj@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/5] prctl: extend PR_SET_THP_DISABLE to optionally
 exclude VM_HUGEPAGE
Message-ID: <8c5d607d-498e-4a34-a781-faafb3a5fdef@lucifer.local>
References: <20250725162258.1043176-1-usamaarif642@gmail.com>
 <20250725162258.1043176-2-usamaarif642@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725162258.1043176-2-usamaarif642@gmail.com>
X-ClientProxiedBy: MM0P280CA0027.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::34) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA1PR10MB6518:EE_
X-MS-Office365-Filtering-Correlation-Id: a524c0c0-d543-4966-917b-08ddcf9fa7eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NIKkXQjdq0JpSk6+98ggqTpX9vVJLW8KhZiVrfk0tOo+4PHjdeul3cz1/ud8?=
 =?us-ascii?Q?r5IkCSe63uyKdrNiHaznInslBJbUWWUEIxX1ddJCGNguBgOkijWQQSQLIV9K?=
 =?us-ascii?Q?1hkMm2FARDmdjlIHKkAvBqZUTEN9DwlHS92nEoy/tN1hlET0pXWyGnytVt0o?=
 =?us-ascii?Q?wCV3wt/S2Jz5YYWskT/5pRxzmqtS/DhoEcFmGDqecCtvoUJO3S69laFBmj1d?=
 =?us-ascii?Q?T/bZxV88yeP7HHl9tJqLUkqIsNJuZUM4irRBJayNNPr0nwq8BIWx4ZrfC4wH?=
 =?us-ascii?Q?j5EbLjnTAKgi7c46HvH0qnpwOTJFrGtwrOGIDUQ6Ayc2BPHux6OQW7QeFghm?=
 =?us-ascii?Q?EKEp4if7FOGYkGl2hCMzfLEeEKS7yKQZO92J57ARE/1s6BlRkQQhTskXVlI4?=
 =?us-ascii?Q?BHAnQ173Npc8UcE8qbPk2dJo0kpLiOVGD9QC348JtdQ894MZaMYEwpfKGmda?=
 =?us-ascii?Q?wv634iWSYgGMXZULBZ3+EFbogziNKsXcUooe9AGvnZivBy6x0nVmLbbZtrRe?=
 =?us-ascii?Q?2BQBn2y84PvLmTyxy2w1s5W34z1rKwRiwXWb8+DMhVH2JLLyvc2LnNoG4RWi?=
 =?us-ascii?Q?XrcT43T2C9pUkP0QKGeQ9NxeUMYG39WBcPzpY9WzGOsJUSJZrAOkecdQxXdZ?=
 =?us-ascii?Q?/ADgb6nHsHrdIS5pzWq9cT60RRhhTWGjv7Gc1AsU2GLuBttm9OF2KajL+uL+?=
 =?us-ascii?Q?XrnKh5p9lI3psjNloYV9HvUnl5TqXcen4sn8Key4bsoaa8T2fAoFnNxhUjz9?=
 =?us-ascii?Q?QeFy/51wUB6yREAp84TanN0IAXOtiIYpO8uj8IP4gyJXHlHY+sFmpfVJsgH+?=
 =?us-ascii?Q?Buj+3ALauP9WHbt13T0Bq5Ae4hRpBIW4enuW9LgnNwz+A+PlcaUpc7ud9UXj?=
 =?us-ascii?Q?qrkQsz4nosMF5ABWKQsl/Q6zOCwfbjuTeotO1MyA/+m4oX1SmHFyXYokqleX?=
 =?us-ascii?Q?vXCH9sIPnFUjYmSy22b3CXPjXWkjs8MCQDkFUhGPKUza0OZAJ7zYl55phUrW?=
 =?us-ascii?Q?/Gyk6v4gV8Fb3V0Kuc/GKyhD87fttQ+BTO6prevhjCEB/v1w+FIt/PCDQ433?=
 =?us-ascii?Q?wcwqWajYIGec31s/a5T3ldweKP8+9l85rzLy9TzwgthYHE7Z7j4AYU5GqVKa?=
 =?us-ascii?Q?T2CwOIXknjwEy40kHWuKpTM0Nhp83RH5IAbKWY6Hitt6g7Q047hlL501Z2Mw?=
 =?us-ascii?Q?i+uxQyL0NRN5YqfPY9ZqmLuZj82VZJdOmsPIyGG0OALNHxZyztPKHeg4x4z5?=
 =?us-ascii?Q?ol/eMRnt/L6JMPVGAekSfgJZLJRTA9QnYD1EarWeIqeK+U5J1nQ6lWlII+D+?=
 =?us-ascii?Q?uwPb4aHRI1s//+CgNVGYvFhXZfSqa27rAUnKjhHaymueuWr7078g/nBrOL6+?=
 =?us-ascii?Q?weMgut7QsqGt7Drvpsu5sS1Cv8/5A4/ekekFF8HjaOJUbjoHL4kmMkUfPaZ9?=
 =?us-ascii?Q?fIUQG0BPaZ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LU6wDRe2APmy16Tk5mhntnfjCEdqxfOKd1OEgvnijhSnjlta99zwFlfYKH9j?=
 =?us-ascii?Q?IwAMSIkviHluFPMA/TiROqU7o7PXPLOMthGX8T4hn1NTyC+2/CoK83cZIzVs?=
 =?us-ascii?Q?szSqH2sgj/E+9Hu4j9Eb6cPev7OCi2jmH//k7XoKuy+Of4OpIVoRpNW4U0za?=
 =?us-ascii?Q?LCKSWQkf1LRSdPvFOuh8lfuD0GVCuhtjYi3VmqprqZw7nC4Tr84k/YcvoxeO?=
 =?us-ascii?Q?44D++9SPLxXDYB+jyCbEzTHK2zCkBPfwSv9MMDy/nKqTk32H7tqBqya5Mj7/?=
 =?us-ascii?Q?ycxee3x/R+aQ+dwEktmXVCr+C56PftGfr75fO8BNc5WZVHwUdflTOL9Y4L0c?=
 =?us-ascii?Q?SCVyX9pm23RmXGVExLBYF3Mfpr99FWY31AiB9PmVxE5Q3KUfjzgZcTMhpaau?=
 =?us-ascii?Q?VGekQ5wY0Mu5c6j8lR4+qJe2Qil9UZkXyPN5iW//rzAGhk7mpJ6auXAPbTwE?=
 =?us-ascii?Q?ifxcR6aoS8aWRqnPfVUBrpDDH66xlKnQ+6XkbfNdLPMtifw2PNBN7vRxU5HE?=
 =?us-ascii?Q?l+8rYswlE6SKu2CrtIOUxdyu1hny50Q0gynKuxXTd+dlpqWrbl0LlXpouEZr?=
 =?us-ascii?Q?HYDu+uvzdvBXY/UM+a42IrCTEley+3JmWMQbywzNDLriJItkhCz9ll151X+A?=
 =?us-ascii?Q?Hvp06TL92wX2jIiR+8ut9LLd2Nr0Gr3kIe0baXA8/6VvljCWpvOBLXJxZ6UA?=
 =?us-ascii?Q?avn0eIe9qfFhnG5jL2gsJSsgSxdYEmXpWs/6QOZ4+RQ4G1W0GNhw7YnkPWtu?=
 =?us-ascii?Q?le+fRNvyrHvLIxZcXtglCdcYp14ok4iGtYgCxlNkThzDGQzBC88dX3ygWKDk?=
 =?us-ascii?Q?Js23pxU0LsoQ24Qsi0Ow+dX6BPWQ8UBgQh+zcanLdC4UmTrmfTXpPF49bX0b?=
 =?us-ascii?Q?914KT56TkIfo3lDLMqF+EeIzASy8v1oBwXMJgfBYqi5lLPyPnEYyfOS/VfoO?=
 =?us-ascii?Q?cjOGbOco8UtasI+A2lOrEoFDDY2scaiQXwPggXnCHK+kAR/slmtALVf6AOXD?=
 =?us-ascii?Q?mEuZNXNUwdPsFYuApuy5wDYlimRDA8qecXMUlCFpKwTpZgtYY8SI0Q6ZxADE?=
 =?us-ascii?Q?pu3JCaC8X6aNoJZXtEGG8W8r9tZcKids3j4NhBlY8QA/ybh5Gfyzb/EjPFVx?=
 =?us-ascii?Q?6u/fYnFwcTg/o/WvpxY9vrQTCUOvwYXl3NoC4j9FvYCWuzdOHg+W8FFtxjWN?=
 =?us-ascii?Q?Jn/Q9t+kOeI/BmGOiW7TpRoJGjMonzvojWqbxeNVNojXY03PG6QqELFGpSJ6?=
 =?us-ascii?Q?albi38jVGUBQDBmZbDX1+MjlTN3SygNkICu6/30h7U00qKeYwmB3ZrO4T/gx?=
 =?us-ascii?Q?t1aiZkPcd/IfuHnV4l7qSsTuqZGawt/0x1Vb4QielGphdNFkOn6NNra4I/cj?=
 =?us-ascii?Q?WTyFghVEtoI/K+Z8uS0gBLXtkiCSxnopqwml2WIZjdDg9DNl5cuBrf/Efwac?=
 =?us-ascii?Q?jWuQcQeCXk6TSVRiOQC16EOwZeQso6Xi0lfFjSq9eDSlYkiPyVLUIr/FLLtr?=
 =?us-ascii?Q?ZrIkFdpg3ivOc0BJZe1fgSZsDnxkEU+y1wTMQHO8wMozes9K4k8LLB1wIDof?=
 =?us-ascii?Q?VPsCmUvDcxXpwWtJDLp8K7e/9oVEtfEqFdJIKcQ75irPcqYHgHkfgrSXMiJd?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n3iBXL7fOT2CcyLOpYmxwzQ6V6u2GEpsC6i0rZgTd8YIF1ZLSm+csTAvcoVZJ+NcFwZS9AEDVUGslIYjsFYsQDZxcjOWjSnLIS0WjC/Y9+mcR68DL4uLyJHOqWSQcFrM15/b9E4xNsnztCOg/pJvSrz5WEG3Qc+EyIVnOMH/VgeDh3sht4ucOr3jspq1ACUTbQNgtKGaW+v3Huv/8pw2nTRRe49gBszSy29WhGus+hhC02mHrfZUTGKih9qO9Os7Ip2FG9ijgd9RvBgiFALzAe+0HpOODiq/d6ohYjqZX0+ZOD0dZk3gTvCqfnAZiNR8PDiy0a2Y4NIX+KNYIESQa0bH80r2Ifjq8JnW2BXH5LHpLlMlAOSV8D2KkU14yVVeGmgDPrkLouC8nRiKZNl4iaqlY47mpw0v8YddwR4mXpIthbrWnzZ0DwNu8xwYmGfT9LliZElnqsMzx35q6xeqPxTOUrMmG+G7gmHywNiVs0eq4yWv16ddsmBLV8I/Q4lAVygn5GISg6767TLyyrnfDkSRiZL6hKEItAvPXCSTtamYP3xOe0FBlNG9QV+3YG+grnoEuTBYJcUgfaW9h8FsmyXPWpVeASW+m6+Efu85zTY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a524c0c0-d543-4966-917b-08ddcf9fa7eb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:31:18.7904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cDB2NxNNpIxVhccjdpXnWF9tf7YsfA3TiReAZIlJ2QkzzGAcIsBhQYXJaQ/SMLc22VLMNH1Wu/uhHpFCGxLGTYDA9NWRUzBAHFvhaXMuumk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6518
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_05,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507300143
X-Proofpoint-ORIG-GUID: dxAX9Kdz-I2oF0MYt1Rbz2qQ6mLErK6C
X-Authority-Analysis: v=2.4 cv=LdA86ifi c=1 sm=1 tr=0 ts=688a73b5 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=GcyzOjIWAAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=07d9gI8wAAAA:8
 a=Z4Rwk6OoAAAA:8 a=Ikd4Dj_1AAAA:8 a=SRrdq9N9AAAA:8 a=7CQSdrXTAAAA:8
 a=1XWaLZrsAAAA:8 a=iox4zFpeAAAA:8 a=JfrnYn6hAAAA:8 a=c0ttVL1lVnP4ghz0ziMA:9
 a=CjuIK1q_8ugA:10 a=WqyWNqh7FqEA:10 a=hQL3dl6oAZ8NdCsdz28n:22
 a=e2CUPOnPG4QKp8I52DXD:22 a=HkZW87K1Qel5hWWM3VKY:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=WzC6qhA0u3u7Ye7llzcV:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDE0MyBTYWx0ZWRfX+cblEcgVO+n+
 WvFSCSfCKFSgMfLioOnAa5lvvLYs/OGRswR8mf7AZdF7BR5PGqbVeWzvjdTH1xv8o95PbGLDfBX
 h73OT4Sugfr375BwCKFyOk3HjMyqJwrVQsh/ufwlywPMc6q8boGXGReHjZDKE6lLpL0ektXI8/t
 /+AEah73BWMF8+8ofC02Gu6BYm0zc6hoCTHredzeogM3839trF/rmUeo9RQeVqxuBHrcSuz4Hl8
 FaxPLSzkCD46Ni0/EIbZr5EQdCDUYHgRdsUcPlHqQ1pdnpMOJ5T0u6nCCdwvYqNLoxKaNE3lBt/
 blmU1AOZnqNpWapnFlEuhbPgbH9O7oovzZXOfQqsdDugt8QRLzgLLWMtE4pYr/aSN0YNLxsAOyM
 8RU50RZOh+VkpfwkgVo3CE18ZRDgfACgw/tntq4NTasdqeBL145mUODn7I03RO5304wEyuJt
X-Proofpoint-GUID: dxAX9Kdz-I2oF0MYt1Rbz2qQ6mLErK6C

An aside - we should update the man page for this - see
https://man7.org/linux/man-pages/man2/PR_SET_THP_DISABLE.2const.html

This has to be done separately from the series I think.

On Fri, Jul 25, 2025 at 05:22:40PM +0100, Usama Arif wrote:
> From: David Hildenbrand <david@redhat.com>
>
> People want to make use of more THPs, for example, moving from
> the "never" system policy to "madvise", or from "madvise" to "always".
>
> While this is great news for every THP desperately waiting to get
> allocated out there, apparently there are some workloads that require a
> bit of care during that transition: individual processes may need to
> opt-out from this behavior for various reasons, and this should be
> permitted without needing to make all other workloads on the system
> similarly opt-out.
>
> The following scenarios are imaginable:
>
> (1) Switch from "none" system policy to "madvise"/"always", but keep THPs
>     disabled for selected workloads.
>
> (2) Stay at "none" system policy, but enable THPs for selected
>     workloads, making only these workloads use the "madvise" or "always"
>     policy.
>
> (3) Switch from "madvise" system policy to "always", but keep the
>     "madvise" policy for selected workloads: allocate THPs only when
>     advised.
>
> (4) Stay at "madvise" system policy, but enable THPs even when not advised
>     for selected workloads -- "always" policy.
>
> Once can emulate (2) through (1), by setting the system policy to
> "madvise"/"always" while disabling THPs for all processes that don't want
> THPs. It requires configuring all workloads, but that is a user-space
> problem to sort out.
>
> (4) can be emulated through (3) in a similar way.
>
> Back when (1) was relevant in the past, as people started enabling THPs,
> we added PR_SET_THP_DISABLE, so relevant workloads that were not ready
> yet (i.e., used by Redis) were able to just disable THPs completely. Redis
> still implements the option to use this interface to disable THPs
> completely.
>
> With PR_SET_THP_DISABLE, we added a way to force-disable THPs for a
> workload -- a process, including fork+exec'ed process hierarchy.
> That essentially made us support (1): simply disable THPs for all workloads
> that are not ready for THPs yet, while still enabling THPs system-wide.
>
> The quest for handling (3) and (4) started, but current approaches
> (completely new prctl, options to set other policies per process,
> alternatives to prctl -- mctrl, cgroup handling) don't look particularly
> promising. Likely, the future will use bpf or something similar to
> implement better policies, in particular to also make better decisions
> about THP sizes to use, but this will certainly take a while as that work
> just started.
>
> Long story short: a simple enable/disable is not really suitable for the
> future, so we're not willing to add completely new toggles.
>
> While we could emulate (3)+(4) through (1)+(2) by simply disabling THPs
> completely for these processes, this is a step backwards, because these
> processes can no longer allocate THPs in regions where THPs were
> explicitly advised: regions flagged as VM_HUGEPAGE. Apparently, that
> imposes a problem for relevant workloads, because "not THPs" is certainly
> worse than "THPs only when advised".
>
> Could we simply relax PR_SET_THP_DISABLE, to "disable THPs unless not
> explicitly advised by the app through MAD_HUGEPAGE"? *maybe*, but this
> would change the documented semantics quite a bit, and the versatility
> to use it for debugging purposes, so I am not 100% sure that is what we
> want -- although it would certainly be much easier.
>
> So instead, as an easy way forward for (3) and (4), add an option to
> make PR_SET_THP_DISABLE disable *less* THPs for a process.
>
> In essence, this patch:
>
> (A) Adds PR_THP_DISABLE_EXCEPT_ADVISED, to be used as a flag in arg3
>     of prctl(PR_SET_THP_DISABLE) when disabling THPs (arg2 != 0).
>
>     prctl(PR_SET_THP_DISABLE, 1, PR_THP_DISABLE_EXCEPT_ADVISED).
>
> (B) Makes prctl(PR_GET_THP_DISABLE) return 3 if
>     PR_THP_DISABLE_EXCEPT_ADVISED was set while disabling.
>
>     Previously, it would return 1 if THPs were disabled completely. Now
>     it returns the set flags as well: 3 if PR_THP_DISABLE_EXCEPT_ADVISED
>     was set.
>
> (C) Renames MMF_DISABLE_THP to MMF_DISABLE_THP_COMPLETELY, to express
>     the semantics clearly.
>
>     Fortunately, there are only two instances outside of prctl() code.
>
> (D) Adds MMF_DISABLE_THP_EXCEPT_ADVISED to express "no THP except for VMAs
>     with VM_HUGEPAGE" -- essentially "thp=madvise" behavior
>
>     Fortunately, we only have to extend vma_thp_disabled().
>
> (E) Indicates "THP_enabled: 0" in /proc/pid/status only if THPs are
>     disabled completely
>
>     Only indicating that THPs are disabled when they are really disabled
>     completely, not only partially.
>
>     For now, we don't add another interface to obtained whether THPs
>     are disabled partially (PR_THP_DISABLE_EXCEPT_ADVISED was set). If
>     ever required, we could add a new entry.
>
> The documented semantics in the man page for PR_SET_THP_DISABLE
> "is inherited by a child created via fork(2) and is preserved across
> execve(2)" is maintained. This behavior, for example, allows for
> disabling THPs for a workload through the launching process (e.g.,
> systemd where we fork() a helper process to then exec()).
>
> For now, MADV_COLLAPSE will *fail* in regions without VM_HUGEPAGE and
> VM_NOHUGEPAGE. As MADV_COLLAPSE is a clear advise that user space
> thinks a THP is a good idea, we'll enable that separately next
> (requiring a bit of cleanup first).
>
> There is currently not way to prevent that a process will not issue
> PR_SET_THP_DISABLE itself to re-enable THP. There are not really known
> users for re-enabling it, and it's against the purpose of the original
> interface. So if ever required, we could investigate just forbidding to
> re-enable them, or make this somehow configurable.
>
> Acked-by: Usama Arif <usamaarif642@gmail.com>
> Tested-by: Usama Arif <usamaarif642@gmail.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Usama Arif <usamaarif642@gmail.com>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Cc: Yafang Shao <laoar.shao@gmail.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
>
> ---
>
> At first, I thought of "why not simply relax PR_SET_THP_DISABLE", but I
> think there might be real use cases where we want to disable any THPs --
> in particular also around debugging THP-related problems, and
> "never" not meaning ... "never" anymore ever since we add MADV_COLLAPSE.
> PR_SET_THP_DISABLE will also block MADV_COLLAPSE, which can be very
> helpful for debugging purposes. Of course, I thought of having a
> system-wide config option to modify PR_SET_THP_DISABLE behavior, but
> I just don't like the semantics.
>
> "prctl: allow overriding system THP policy to always"[1] proposed
> "overriding policies to always", which is just the wrong way around: we
> should not add mechanisms to "enable more" when we already have an
> interface/mechanism to "disable" them (PR_SET_THP_DISABLE). It all gets
> weird otherwise.
>
> "[PATCH 0/6] prctl: introduce PR_SET/GET_THP_POLICY"[2] proposed
> setting the default of the VM_HUGEPAGE, which is similarly the wrong way
> around I think now.
>
> The ideas explored by Lorenzo to extend process_madvise()[3] and mctrl()[4]
> similarly were around the "default for VM_HUGEPAGE" idea, but after the
> discussion, I think we should better leave VM_HUGEPAGE untouched.
>
> Happy to hear naming suggestions for "PR_THP_DISABLE_EXCEPT_ADVISED" where
> we essentially want to say "leave advised regions alone" -- "keep THP
> enabled for advised regions",
>
> The only thing I really dislike about this is using another MMF_* flag,
> but well, no way around it -- and seems like we could easily support
> more than 32 if we want to (most users already treat it like a proper
> bitmap).
>
> I think this here (modifying an existing toggle) is the only prctl()
> extension that we might be willing to accept. In general, I agree like
> most others, that prctl() is a very bad interface for that -- but
> PR_SET_THP_DISABLE is already there and is getting used.
>
> Long-term, I think the answer will be something based on bpf[5]. Maybe
> in that context, I there could still be value in easily disabling THPs for
> selected workloads (esp. debugging purposes).
>
> Jann raised valid concerns[6] about new flags that are persistent across
> exec[6]. As this here is a relaxation to existing PR_SET_THP_DISABLE I
> consider it having a similar security risk as our existing
> PR_SET_THP_DISABLE, but devil is in the detail.
>
> [1] https://lore.kernel.org/r/20250507141132.2773275-1-usamaarif642@gmail.com
> [2] https://lkml.kernel.org/r/20250515133519.2779639-2-usamaarif642@gmail.com
> [3] https://lore.kernel.org/r/cover.1747686021.git.lorenzo.stoakes@oracle.com
> [4] https://lkml.kernel.org/r/85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local
> [5] https://lkml.kernel.org/r/20250608073516.22415-1-laoar.shao@gmail.com
> [6] https://lore.kernel.org/r/CAG48ez3-7EnBVEjpdoW7z5K0hX41nLQN5Wb65Vg-1p8DdXRnjg@mail.gmail.com
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  Documentation/filesystems/proc.rst |  5 +--
>  fs/proc/array.c                    |  2 +-
>  include/linux/huge_mm.h            | 20 ++++++++---
>  include/linux/mm_types.h           | 13 +++----
>  include/uapi/linux/prctl.h         | 10 ++++++
>  kernel/sys.c                       | 58 +++++++++++++++++++++++-------
>  mm/khugepaged.c                    |  2 +-
>  7 files changed, 81 insertions(+), 29 deletions(-)
>
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 2971551b7235..915a3e44bc12 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -291,8 +291,9 @@ It's slow but very precise.
>   HugetlbPages                size of hugetlb memory portions
>   CoreDumping                 process's memory is currently being dumped
>                               (killing the process may lead to a corrupted core)
> - THP_enabled		     process is allowed to use THP (returns 0 when
> -			     PR_SET_THP_DISABLE is set on the process
> + THP_enabled                 process is allowed to use THP (returns 0 when
> +                             PR_SET_THP_DISABLE is set on the process to disable
> +                             THP completely, not just partially)
>   Threads                     number of threads
>   SigQ                        number of signals queued/max. number for queue
>   SigPnd                      bitmap of pending signals for the thread
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index d6a0369caa93..c4f91a784104 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -422,7 +422,7 @@ static inline void task_thp_status(struct seq_file *m, struct mm_struct *mm)
>  	bool thp_enabled = IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE);
>
>  	if (thp_enabled)
> -		thp_enabled = !test_bit(MMF_DISABLE_THP, &mm->flags);
> +		thp_enabled = !test_bit(MMF_DISABLE_THP_COMPLETELY, &mm->flags);
>  	seq_printf(m, "THP_enabled:\t%d\n", thp_enabled);
>  }
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 7748489fde1b..71db243a002e 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -318,16 +318,26 @@ struct thpsize {
>  	(transparent_hugepage_flags &					\
>  	 (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG))
>
> +/*
> + * Check whether THPs are explicitly disabled for this VMA, for example,
> + * through madvise or prctl.
> + */
>  static inline bool vma_thp_disabled(struct vm_area_struct *vma,
>  		vm_flags_t vm_flags)
>  {
> +	/* Are THPs disabled for this VMA? */
> +	if (vm_flags & VM_NOHUGEPAGE)
> +		return true;
> +	/* Are THPs disabled for all VMAs in the whole process? */
> +	if (test_bit(MMF_DISABLE_THP_COMPLETELY, &vma->vm_mm->flags))
> +		return true;
>  	/*
> -	 * Explicitly disabled through madvise or prctl, or some
> -	 * architectures may disable THP for some mappings, for
> -	 * example, s390 kvm.
> +	 * Are THPs disabled only for VMAs where we didn't get an explicit
> +	 * advise to use them?
>  	 */
> -	return (vm_flags & VM_NOHUGEPAGE) ||
> -	       test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags);
> +	if (vm_flags & VM_HUGEPAGE)
> +		return false;

Hm is this correct? This means that VM_NOHUGEPAGE no longer results in THP being
disabled here no?

> +	return test_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, &vma->vm_mm->flags);
>  }
>
>  static inline bool thp_disabled_by_hw(void)
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 1ec273b06691..123fefaa4b98 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1743,19 +1743,16 @@ enum {
>  #define MMF_VM_MERGEABLE	16	/* KSM may merge identical pages */
>  #define MMF_VM_HUGEPAGE		17	/* set when mm is available for khugepaged */
>
> -/*
> - * This one-shot flag is dropped due to necessity of changing exe once again
> - * on NFS restore
> - */
> -//#define MMF_EXE_FILE_CHANGED	18	/* see prctl_set_mm_exe_file() */
> +#define MMF_HUGE_ZERO_PAGE	18      /* mm has ever used the global huge zero page */
>
>  #define MMF_HAS_UPROBES		19	/* has uprobes */
>  #define MMF_RECALC_UPROBES	20	/* MMF_HAS_UPROBES can be wrong */
>  #define MMF_OOM_SKIP		21	/* mm is of no interest for the OOM killer */
>  #define MMF_UNSTABLE		22	/* mm is unstable for copy_from_user */
> -#define MMF_HUGE_ZERO_PAGE	23      /* mm has ever used the global huge zero page */
> -#define MMF_DISABLE_THP		24	/* disable THP for all VMAs */
> -#define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
> +#define MMF_DISABLE_THP_EXCEPT_ADVISED	23	/* no THP except when advised (e.g., VM_HUGEPAGE) */
> +#define MMF_DISABLE_THP_COMPLETELY	24	/* no THP for all VMAs */

It's almost a bit weird to have these as separate flags, since they're distinct
(of course, I don't think there's necessarily another way).

Though this makes me think maybe in future we can have a new mode where both
enabled == something else :P

But perhaps I've been infected with 'bit packing' disease.

Anyway as discussed in the THP meeting, I'm going to be (hopefully!) making
the mm flags a bitmap soon so we'll get more flags available.

> +#define MMF_DISABLE_THP_MASK	((1 << MMF_DISABLE_THP_COMPLETELY) |\
> +				 (1 << MMF_DISABLE_THP_EXCEPT_ADVISED))
>  #define MMF_OOM_REAP_QUEUED	25	/* mm was queued for oom_reaper */
>  #define MMF_MULTIPROCESS	26	/* mm is shared between processes */
>  /*
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 43dec6eed559..9c1d6e49b8a9 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -177,7 +177,17 @@ struct prctl_mm_map {
>
>  #define PR_GET_TID_ADDRESS	40
>
> +/*
> + * Flags for PR_SET_THP_DISABLE are only applicable when disabling. Bit 0
> + * is reserved, so PR_GET_THP_DISABLE can return "1 | flags", to effectively
> + * return "1" when no flags were specified for PR_SET_THP_DISABLE.
> + */
>  #define PR_SET_THP_DISABLE	41
> +/*
> + * Don't disable THPs when explicitly advised (e.g., MADV_HUGEPAGE /
> + * VM_HUGEPAGE).
> + */
> +# define PR_THP_DISABLE_EXCEPT_ADVISED	(1 << 1)

NO space after # please.

>  #define PR_GET_THP_DISABLE	42
>
>  /*
> diff --git a/kernel/sys.c b/kernel/sys.c
> index b153fb345ada..b87d0acaab0b 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2423,6 +2423,50 @@ static int prctl_get_auxv(void __user *addr, unsigned long len)
>  	return sizeof(mm->saved_auxv);
>  }
>
> +static int prctl_get_thp_disable(unsigned long arg2, unsigned long arg3,
> +				 unsigned long arg4, unsigned long arg5)
> +{
> +	unsigned long *mm_flags = &current->mm->flags;
> +
> +	if (arg2 || arg3 || arg4 || arg5)
> +		return -EINVAL;
> +

Can we have a comment here about what we're doing below re: the return
value?

> +	if (test_bit(MMF_DISABLE_THP_COMPLETELY, mm_flags))
> +		return 1;
> +	else if (test_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, mm_flags))
> +		return 1 | PR_THP_DISABLE_EXCEPT_ADVISED;
> +	return 0;
> +}
> +
> +static int prctl_set_thp_disable(bool thp_disable, unsigned long flags,
> +				 unsigned long arg4, unsigned long arg5)
> +{
> +	unsigned long *mm_flags = &current->mm->flags;
> +
> +	if (arg4 || arg5)
> +		return -EINVAL;
> +
> +	/* Flags are only allowed when disabling. */
> +	if ((!thp_disable && flags) || (flags & ~PR_THP_DISABLE_EXCEPT_ADVISED))
> +		return -EINVAL;
> +	if (mmap_write_lock_killable(current->mm))
> +		return -EINTR;
> +	if (thp_disable) {
> +		if (flags & PR_THP_DISABLE_EXCEPT_ADVISED) {
> +			clear_bit(MMF_DISABLE_THP_COMPLETELY, mm_flags);
> +			set_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, mm_flags);
> +		} else {
> +			set_bit(MMF_DISABLE_THP_COMPLETELY, mm_flags);
> +			clear_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, mm_flags);
> +		}
> +	} else {
> +		clear_bit(MMF_DISABLE_THP_COMPLETELY, mm_flags);
> +		clear_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, mm_flags);
> +	}
> +	mmap_write_unlock(current->mm);
> +	return 0;
> +}
> +
>  SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  		unsigned long, arg4, unsigned long, arg5)
>  {
> @@ -2596,20 +2640,10 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  			return -EINVAL;
>  		return task_no_new_privs(current) ? 1 : 0;
>  	case PR_GET_THP_DISABLE:
> -		if (arg2 || arg3 || arg4 || arg5)
> -			return -EINVAL;
> -		error = !!test_bit(MMF_DISABLE_THP, &me->mm->flags);
> +		error = prctl_get_thp_disable(arg2, arg3, arg4, arg5);
>  		break;
>  	case PR_SET_THP_DISABLE:
> -		if (arg3 || arg4 || arg5)
> -			return -EINVAL;
> -		if (mmap_write_lock_killable(me->mm))
> -			return -EINTR;
> -		if (arg2)
> -			set_bit(MMF_DISABLE_THP, &me->mm->flags);
> -		else
> -			clear_bit(MMF_DISABLE_THP, &me->mm->flags);
> -		mmap_write_unlock(me->mm);
> +		error = prctl_set_thp_disable(arg2, arg3, arg4, arg5);
>  		break;
>  	case PR_MPX_ENABLE_MANAGEMENT:
>  	case PR_MPX_DISABLE_MANAGEMENT:
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 1ff0c7dd2be4..2c9008246785 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -410,7 +410,7 @@ static inline int hpage_collapse_test_exit(struct mm_struct *mm)
>  static inline int hpage_collapse_test_exit_or_disable(struct mm_struct *mm)
>  {
>  	return hpage_collapse_test_exit(mm) ||
> -	       test_bit(MMF_DISABLE_THP, &mm->flags);
> +	       test_bit(MMF_DISABLE_THP_COMPLETELY, &mm->flags);
>  }
>
>  static bool hugepage_pmd_enabled(void)
> --
> 2.47.3
>

