Return-Path: <linux-fsdevel+bounces-68781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CD86FC660E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 21:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C65E8346957
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 20:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346B231A81C;
	Mon, 17 Nov 2025 20:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QnAiv4xq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tWJI2485"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA965191F91;
	Mon, 17 Nov 2025 20:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763409789; cv=fail; b=V2EuSwGnhkOGBIVVwJSbnTcFfBZGqwuoXOREuN/68oS+daVf4z8mr3M8SwiMoRZM6kIlhZpRegMv3Eul9FcLL1gJt3U0G/ge5tMHmPg9Zu5Se5h2kB7m7RiDvVA8KGh4JSkJQj2NZcr7TcyLeK78qtkOsCAeTw7Zau6OY/Gzo0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763409789; c=relaxed/simple;
	bh=B/5ZQkJzY6anSLuLg9pnezdoi/4avbe5/Fml31ybbfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K3mL38iujUjguEDWe3zsmVze//yLcSGtauNqq2PmiprQlkl/Eg5xZAgSgz1JfCQ5zljFxkxYgyuLLjht3ayMPvZeGTMcH0XHGQWFTD3FB6aFATJDZelz5Cg1cHRWIFpLdKPsGAgZYhvCatw2RoGQW5n+gDYV9e/Nrxx+sOMpSYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QnAiv4xq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tWJI2485; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHC9Lcr003186;
	Mon, 17 Nov 2025 20:02:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=1v8nLw6C/t/06FvKw9
	1cyDoh0DoiekpXf2NZNidqPq4=; b=QnAiv4xq5Fv8vuWJrI/agvmnQ6l1bIc1N4
	pZK7PpO2a2yL2Ol0NMjixIUiQMjIuldlHFa840/Fgq5U2Y+KYOZNHnlg7mor+gYm
	oz17GeHFv8nlASGQ39urQiId7qi2mDBv3mS8DWBGE0Z7bR6DKPd4bS1e5jvhGUDH
	oQVieFrKijRZUkhiY7XJzuTew/js7+rkRfRAe8eo96HhiWHzGxwL7zA4ei5hXXA8
	rocys1jY77sWObfs5f7QbdoLNCgffZxoXb8ZQowhZDk6EfC+b+MxkR6IXRZidWbB
	crhdJVvdIbjBsNi4mwsJcf6eejGTsLzHZ0p0+YZvLxxiQVcDSidA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej96377g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 20:02:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHJQDQl002499;
	Mon, 17 Nov 2025 20:02:09 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010009.outbound.protection.outlook.com [52.101.46.9])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefy85etr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 20:02:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tz+Nz5nipEtb6AHAKEthlQ6rOYWKae/bNIeuDJC24o9NeVHogy8VZiz5smNmdIQAHhX6l6jst/+lt3bZ/ScrwqXUxpnzTCtEAMIjT9r6MctK95wiOqLaZbl3jtjB+fGmdbIpAW+rWJPXzieOgYEhooErl4/YmFfwGnsrBL70YET8YSNh0ENBMrDq8fP2OwFFh5Eps0MuGpu3Gkdv9tYHGCMkEG368515A4CCsa2sIbqKm543SR1GIgWiDdtzEctYLhpI9NuAN/mltGurxjw9H8/ePp3m5onRxwOhOwZpqFnz9Y96CmNZaVLzgFpRd4Ae/mTT2qVBfA0L66xhSfxuTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1v8nLw6C/t/06FvKw91cyDoh0DoiekpXf2NZNidqPq4=;
 b=AUIeUoO+RoduRZX6ivU1ybItrJeHWXip75FlqvDaD+jV9CxsL3czQ+1i697viHIf+SCIwbwRueXiVqYLXlOwu79sebnPzHAaRIKkEVRVh8RPkBG9VdCrT04hEXsFwzS6xHCtTxAvJ6+BIozltt8xCNZUIfMn0p9+wsXPEwEVtnPftFFb6oON9DDcVNmPgv9zW5eG9GzZfJ+3Ai4O/DmKhuTACwa+ycz71WPsaSk1pcaW54qqctwntoM3Po/vHdPuoBkUflD/CqMsv0nzhDGmKyjkLkeUi9g1bVOFBXUNO2rm1bx15S+99fU9fXC99K1aZRRRyAF98kI5KO6ySUc7Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1v8nLw6C/t/06FvKw91cyDoh0DoiekpXf2NZNidqPq4=;
 b=tWJI2485DT1F6eeUhXLHnqBBK1VgMQ4XmSdhMMgKNyX986dvQ17u+5V+YNreC/kZ9tEtn9wvNxpmSpfPmxI6iejNibpHA7c8DeYIy0kddqeoG2hY2HHQweyjCFIow7cuooMuOrnPgfq2Tkt4dUGXRw4TPg6riiYNP6f+IgK8SAQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MN6PR10MB8165.namprd10.prod.outlook.com (2603:10b6:208:4fc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 20:02:05 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 20:02:05 +0000
Date: Mon, 17 Nov 2025 20:02:03 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v3 3/8] mm: implement sticky VMA flags
Message-ID: <cf58c518-05d0-494f-8fe4-571879834031@lucifer.local>
References: <cover.1762531708.git.lorenzo.stoakes@oracle.com>
 <1ee529ff912f71b3460d0d21bc5b32ca89d63513.1762531708.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ee529ff912f71b3460d0d21bc5b32ca89d63513.1762531708.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P265CA0303.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MN6PR10MB8165:EE_
X-MS-Office365-Filtering-Correlation-Id: 50ff1430-b392-48fe-21c7-08de26142e1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aq0g43n/DSoonPbeykZx1UAfT7cHITtxdKnwLNojyUPtOA2XfuAIdJ2bcQKu?=
 =?us-ascii?Q?fz/ZIDckeWD15t7vqGfqOdZKCdMcJi1F1q0W05l+5BvbT6oMbku6eogUbpI5?=
 =?us-ascii?Q?YXhpystLHoZbi9iQRh6rv/0A68Ya8a5HAFFiNYtb5nItqzqoAzeveK4bsoXd?=
 =?us-ascii?Q?brCvFidC2XAJd4HOHXwTheAeUpT/F3WAYVPQd3aycQruK4TwuZ1DOnUtr61r?=
 =?us-ascii?Q?diOUbVf+Nkzha/xzgEdlATl2VkUFx1CCxLJ7LBNnfAJFAOcLRfKgL50ngYnf?=
 =?us-ascii?Q?Akq9f/eC8djb17COp+6Txgn1CjCm+57UWg7ykNsV5yR3tzZS89lxslOo4Rs3?=
 =?us-ascii?Q?UD64sRs9LGqE1zZnmr80LI/6FWJcAM2l8ILA+nbWm640VeJiryVCFGUhWuKB?=
 =?us-ascii?Q?cvaOMBDEM5nsRraxwroSyqmbrDD/u6R9Km9g8GgE9vn0cAtb+yThtCP67UEo?=
 =?us-ascii?Q?5sJmleq99cqkmX6GglUh2v04UBf/n+LjcAQjIlejIVDbRIOmeoBK4A8shL6j?=
 =?us-ascii?Q?faUm+5FA2OlSIlh6qOd8upaFmNccqfsdL38LGqcXzGJHvw/6zpJCDVA126JB?=
 =?us-ascii?Q?NaMsF8ZAjFt9plTKWG6qGkgNTj/0zAlZQ/pG0XHSzF7ttnh01bhkOqN0wnXZ?=
 =?us-ascii?Q?S5bcXQcFg64y4U2HBd7Zx8EH37eExVjya3t3gDcC6NQFWtj+k9If5OmDXHfe?=
 =?us-ascii?Q?o8Yo7Ni74r7KGK8f9G71rhB52hkZ2zFfr7Pmza6gkZHkCsT3TF/9jXis3Onq?=
 =?us-ascii?Q?I60iYibx0z9B6qIHflIfleUcrEEBH5MuHSEU1Y3GnuHLqRnlLgemtrVABvOg?=
 =?us-ascii?Q?DIK4hJFuIOiM4CW99+5vn5tpXIKUUprGhmk5gPiIb2jCVbL5cpRXFDbUkb7J?=
 =?us-ascii?Q?ZIxTrDSQbw1Av1QKroo+WwTHj84gI9ZXAJY6FQseCPPBeptwFE+iLjuvaQkP?=
 =?us-ascii?Q?2sIEyBTeg/9cS+czNFNN+FKdGqqIjoXZRCe4JTkNLnxeL+I/pewVSw+9IpVz?=
 =?us-ascii?Q?wVz6jsg3tARjri7Zy3V+jqSRkSzhuOOyot/WaRY9tJwd0Vj392le0njwjlyN?=
 =?us-ascii?Q?lCzskBJhGtMtvNFQ1TqrteK9F9oZFkclOP5CwzVLr7I8q587bLnvXB1x133N?=
 =?us-ascii?Q?UM66tiGPAc/CyToMEVL8MSoAXruTiB4Slmq6gZUlM/Mt6EV+F4L2saWzVYBN?=
 =?us-ascii?Q?YBTvi9b2MHTOTFcQaD6epn0099nHDRZvDnXLDJWwetlszkkAx87XZYEogfAS?=
 =?us-ascii?Q?w5XkMKKc8eJWP0a81geYY+6csvnABRasLVAyFzyezjvaULoI+tR0tCi8S+XN?=
 =?us-ascii?Q?bGpY2xaWmLy16FLi1csfyZtB4qK/gJ77Z/cD1eIjSxIEyijP9ODIiVRgMfT3?=
 =?us-ascii?Q?5w4Oa9JO2slRUGLiPAky6qp4uZYs7xdzTjz9z9HlEYhKrLhaKdVAjtpg91O4?=
 =?us-ascii?Q?1Ylw8nIxTZ95/9aeeVXQ7/bBBGmzRKRQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vtCfOhTBKFXfqrN850/sF3hH4N3sp03WTs2Hk0Eq93h2n+kXFGMrcg7c33rO?=
 =?us-ascii?Q?YB+Ya4QzJzwgTU3MKbDhxlkjLT4QiAFqpCgqNlShX/eDDWG8VuNy9RUOOC2H?=
 =?us-ascii?Q?P5RMO+xnIM4GN2s2zjBzxwZIEC3XiIMkEazhtT6gtL+qEBEGlfdooJxfINtv?=
 =?us-ascii?Q?2E0uc3k0fky5D3aK/oRfuhBUN/lQsXIhye3Eg8ekBuNtUuDATclNM4AveVvn?=
 =?us-ascii?Q?R2chRankffcYvkYLQYoEl2/m3VMWHsEJz3MTKIix6MtqPNkKwg6Dd5sDby0X?=
 =?us-ascii?Q?FcVfQDZo4JBXvneEjrlR4+AMASssYU8kBJhhzzXajxkV910eb3pD85Jfkp+1?=
 =?us-ascii?Q?pCOx43doxi0dyfcj/DaMYy6DuWWN/g2Obb5JHDJWdHiW+iels3EcwyHCn26w?=
 =?us-ascii?Q?EyBTI3cq55vesgA9VkSIZ8MKjtSSD080Sys0sS7NZ9yR9F/bzVJ3krcWY27v?=
 =?us-ascii?Q?ttkpTqQNoGYZhRg/DGO7dUST0fC0OiLBp4Mc58Uu7Wy6uZ6nCa50u5Jl/qrZ?=
 =?us-ascii?Q?hj8BhK6MlWNTnZhWZBQnC27V7r00HVwcGMNCX+qO1hS9AhmLfc9Q9rCoVHQx?=
 =?us-ascii?Q?TT5ioZjafiuBZoe7IEf1SmZJUYhozx8viX6Z4uwgFxi5aMHXSEpsAOwnMo8Q?=
 =?us-ascii?Q?B4Jm75gnmcVkemz736CZa2Jsap7aHL23hPgVO6i1KZ5QWGO1+NBuhCExMAuq?=
 =?us-ascii?Q?KO+CFHYtwTI7rdF75Nn9r3BIG29EaWB+VdYqhvAqlBtXtsLRfACglCTkzuX2?=
 =?us-ascii?Q?wgdfH2/dJSN3uhbQ8F1n1AccM12Km+tLF5lDBbfw8PVBp6x3B6ycsH52tMDp?=
 =?us-ascii?Q?9oUvS6FcPzKRrWIQPlfEFYekDkcTDSggVpO8xVF/lWKdsmACK0ooGUkSUP8H?=
 =?us-ascii?Q?o4srEW6qgpIW/FPyPW7eUkYXu+XQzjdS155YohDiozmiesDYpugVaVdMWkLO?=
 =?us-ascii?Q?VuT1fhQ81gC1DsI+fIumzwE4DqDXK0M/yQ1gaIQ9eFlAmAaKPDgrBbB6C7vG?=
 =?us-ascii?Q?iwiXpjLB/vyO/294rRWx0PSSa/L1oA/Yz/ZHIEdLRVrMP3HIP0zqOKhqrjff?=
 =?us-ascii?Q?kO3AywpHdh5IwhPOpJSpmRuhOGOO0sq4LKb7xJ7OzuK+d0ioNBqBtyK1sd9u?=
 =?us-ascii?Q?JexPlQ7HEDwRI4VOBU1JB032Uc0frJ99++GlnFG1SXvZp+8ac9qZ7fKOh8pJ?=
 =?us-ascii?Q?yReTpSZbAYkC6VSk3mtseketMfNboJXQA3ZmwMgUE12cu01HxZ/56rf8Je1m?=
 =?us-ascii?Q?FMyHVM8ihBpDlohYKxkYzypolqLuP+G9T0lSsS6IwDk/YzghtyBIIqssYfy5?=
 =?us-ascii?Q?M5x2/Mi36H+hsOdleVD3D/yioCDgmAUQJT9ZBLgb8W4v55O3R0BU7J4ZI4oH?=
 =?us-ascii?Q?1QbyIq+0Leg3cv++Sq0kaj0n/5hwuGU2HJnpT0T5BeC+jAmkHvGPBAGFBaYG?=
 =?us-ascii?Q?filaQ5QDJrkDPbFQGOnTGTrL1Q3GEP0Hl0/f1JedmxNx6QSZqqs0nGdJ/vje?=
 =?us-ascii?Q?/kUfIgFj1EyZ0G479nR8HzkzgLYQegnQRVd9+Ux+niX5hWaZKJuYzA82K6F5?=
 =?us-ascii?Q?ow8eqfoVQX1gvVa+jzzgViZSBZvSf3yuqb8pn/cXDPgMtPv8dIHmLCD8+5ca?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tlyrofAp94pgn6WBROrb6H4VFzJ6PFpG0MrGK4lTSRf4uvQNXH8xe1uPTexxXf1R/9JyRTtoSwkbeH4MpvFAF4guM2EieWjtwWFDpytE6y6StGQm1kkAM0IOd8aN/jSR4xsi/DdJqIO4Jf/Y0zvFAi/kfAd+MM6QGPSRS443zX01RDXgbqZ8YOeWI7wPiuO4k0Vu4FwkKkE4xURzF99RhKctqKI89SL7aMzclgwGw49+13QXeiX5r8IKTe7/WbajDgph27YUOr7sD+RqvzayLoZs3QqYqfo1o+8nED3p1hZRJBm+hrT1pAzCtB9Uusx7X/OEjP1FvS0CmbiT/S84tXHTwS1hja9u8nuuajCdl5YSQeH54b8wXlhs9xve/H5IJ+YCW9+Rl3JaRb4uy7jLuo/twBHPaFjfmzCDBZRDkJzPgfBNYeh9D7dY6yCZu0odYbhMAB5qQjg3sDBxGnX5Ya9EGu9arebqBpcF6ajks1wKe2zDn7ahvBQfnyJJ1FZy0QTGnKCdI3j6orHkuPTleLyDZ4VV03xIooGRRHweTooytmn1A87jZ2mOfqQkfIWZ+YoSywKDMeyF4tsDgNUsT/ss0kXX1st7FsiVfim7qFg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ff1430-b392-48fe-21c7-08de26142e1d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 20:02:04.9891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIWMXhR4fRRxUB4GG2FCkv6uuX91d2AHSp2Ii4JfvceEki2Vb2fxUWlC/5abk2523Y3816l4YWOlBHexNdiEMuLBO6lEN5ya0y++ZROdzkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8165
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511170169
X-Authority-Analysis: v=2.4 cv=DYoaa/tW c=1 sm=1 tr=0 ts=691b7f41 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=VL40ayQiuQFUDCaD3vYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: B60V4ElVTDRz2cI44MJccIalvgkghpd_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfXxPh47uJGAHjd
 0fpHRcOtDCFHXI5xE+938K/X0b/n9MeZ1HBpfEHTaVm6Q6mmCjstAB1l1Oej/QEQyyUhc2SNzNq
 4d1p7ghNuD2bY+8rkGvb8rl1D2XUaeZxAKJ9/f6lrUFLGSlm9F1xT/POgxgMXh3uxRabK0prAqB
 myFm1Vpa4C0w7GhDuwe71RKQggKIQ0AnTb0eLomzJDGBUHhANY3e49tQWyJi9nch7yP/0gyi//Y
 vK5kD20XdQBxEUliWGqr8adejlEvKIRIfw4u8DHj6MCvAEj9oHRbRxfJUKCvdSB+xDIEYIi2pJz
 KDYINDMN21VZxb8XXgH9j7NTUe3XTXoDWwTZC42IW0Nh9aypOCOQwmdtl07C/d+wPSX4YX6Nuq7
 tiYb9Rwr1mVlcKvTeANiVTUU/XxrdQ==
X-Proofpoint-ORIG-GUID: B60V4ElVTDRz2cI44MJccIalvgkghpd_

Hi Andrew,

Sorry to be a pain here, and can respin if it's easier, but can we update the
text of the comments below? As in discussion with Liam off-list we agreed that
the current wording is rather unclear and we can do a lot better.

I provide the improved version inline below:

On Fri, Nov 07, 2025 at 04:11:48PM +0000, Lorenzo Stoakes wrote:
> It is useful to be able to designate that certain flags are 'sticky', that
> is, if two VMAs are merged one with a flag of this nature and one without,
> the merged VMA sets this flag.
>
> As a result we ignore these flags for the purposes of determining VMA flag
> differences between VMAs being considered for merge.
>
> This patch therefore updates the VMA merge logic to perform this action,
> with flags possessing this property being described in the VM_STICKY
> bitmap.
>
> Those flags which ought to be ignored for the purposes of VMA merge are
> described in the VM_IGNORE_MERGE bitmap, which the VMA merge logic is also
> updated to use.
>
> As part of this change we place VM_SOFTDIRTY in VM_IGNORE_MERGE as it
> already had this behaviour, alongside VM_STICKY as sticky flags by
> implication must not disallow merge.
>
> Ultimately it seems that we should make VM_SOFTDIRTY a sticky flag in its
> own right, but this change is out of scope for this series.
>
> The only sticky flag designated as such is VM_MAYBE_GUARD, so as a result
> of this change, once the VMA flag is set upon guard region installation,
> VMAs with guard ranges will now not have their merge behaviour impacted as
> a result and can be freely merged with other VMAs without VM_MAYBE_GUARD
> set.
>
> We also update the VMA userland tests to account for the changes.
>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/linux/mm.h               | 29 +++++++++++++++++++++++++++++
>  mm/vma.c                         | 22 ++++++++++++----------
>  tools/testing/vma/vma_internal.h | 29 +++++++++++++++++++++++++++++
>  3 files changed, 70 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 699566c21ff7..6c1c459e9acb 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -527,6 +527,35 @@ extern unsigned int kobjsize(const void *objp);
>  #endif
>  #define VM_FLAGS_CLEAR	(ARCH_VM_PKEY_FLAGS | VM_ARCH_CLEAR)
>
> +/*
> + * Flags which should be 'sticky' on merge - that is, flags which, when one VMA
> + * possesses it but the other does not, the merged VMA should nonetheless have
> + * applied to it:
> + *
> + * VM_MAYBE_GUARD - If a VMA may have guard regions in place it implies that
> + *                  mapped page tables may contain metadata not described by the
> + *                  VMA and thus any merged VMA may also contain this metadata,
> + *                  and thus we must make this flag sticky.
> + */
> +#define VM_STICKY VM_MAYBE_GUARD
> +
> +/*
> + * VMA flags we ignore for the purposes of merge, i.e. one VMA possessing one
> + * of these flags and the other not does not preclude a merge.
> + *
> + * VM_SOFTDIRTY - Should not prevent from VMA merging, if we match the flags but
> + *                dirty bit -- the caller should mark merged VMA as dirty. If
> + *                dirty bit won't be excluded from comparison, we increase
> + *                pressure on the memory system forcing the kernel to generate
> + *                new VMAs when old one could be extended instead.
> + *

Could you replace this:

> + *    VM_STICKY - If one VMA has flags which most be 'sticky', that is ones
> + *                which should propagate to all VMAs, but the other does not,
> + *                the merge should still proceed with the merge logic applying
> + *                sticky flags to the final VMA.

With this:

 *    VM_STICKY - When merging VMAs, VMA flags must match, unless they are
 *                'sticky'. If any sticky flags exist in either VMA, we simply
 *                set all of them on the merged VMA.


> + */
> +#define VM_IGNORE_MERGE (VM_SOFTDIRTY | VM_STICKY)
> +
>  /*
>   * mapping from the currently active vm_flags protection bits (the
>   * low four bits) to a page protection mask..
> diff --git a/mm/vma.c b/mm/vma.c
> index 0c5e391fe2e2..6cb082bc5e29 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -89,15 +89,7 @@ static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_nex
>
>  	if (!mpol_equal(vmg->policy, vma_policy(vma)))
>  		return false;
> -	/*
> -	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
> -	 * match the flags but dirty bit -- the caller should mark
> -	 * merged VMA as dirty. If dirty bit won't be excluded from
> -	 * comparison, we increase pressure on the memory system forcing
> -	 * the kernel to generate new VMAs when old one could be
> -	 * extended instead.
> -	 */
> -	if ((vma->vm_flags ^ vmg->vm_flags) & ~VM_SOFTDIRTY)
> +	if ((vma->vm_flags ^ vmg->vm_flags) & ~VM_IGNORE_MERGE)
>  		return false;
>  	if (vma->vm_file != vmg->file)
>  		return false;
> @@ -808,6 +800,7 @@ static bool can_merge_remove_vma(struct vm_area_struct *vma)
>  static __must_check struct vm_area_struct *vma_merge_existing_range(
>  		struct vma_merge_struct *vmg)
>  {
> +	vm_flags_t sticky_flags = vmg->vm_flags & VM_STICKY;
>  	struct vm_area_struct *middle = vmg->middle;
>  	struct vm_area_struct *prev = vmg->prev;
>  	struct vm_area_struct *next;
> @@ -900,11 +893,13 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
>  	if (merge_right) {
>  		vma_start_write(next);
>  		vmg->target = next;
> +		sticky_flags |= (next->vm_flags & VM_STICKY);
>  	}
>
>  	if (merge_left) {
>  		vma_start_write(prev);
>  		vmg->target = prev;
> +		sticky_flags |= (prev->vm_flags & VM_STICKY);
>  	}
>
>  	if (merge_both) {
> @@ -974,6 +969,7 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
>  	if (err || commit_merge(vmg))
>  		goto abort;
>
> +	vm_flags_set(vmg->target, sticky_flags);
>  	khugepaged_enter_vma(vmg->target, vmg->vm_flags);
>  	vmg->state = VMA_MERGE_SUCCESS;
>  	return vmg->target;
> @@ -1124,6 +1120,10 @@ int vma_expand(struct vma_merge_struct *vmg)
>  	bool remove_next = false;
>  	struct vm_area_struct *target = vmg->target;
>  	struct vm_area_struct *next = vmg->next;
> +	vm_flags_t sticky_flags;
> +
> +	sticky_flags = vmg->vm_flags & VM_STICKY;
> +	sticky_flags |= target->vm_flags & VM_STICKY;
>
>  	VM_WARN_ON_VMG(!target, vmg);
>
> @@ -1133,6 +1133,7 @@ int vma_expand(struct vma_merge_struct *vmg)
>  	if (next && (target != next) && (vmg->end == next->vm_end)) {
>  		int ret;
>
> +		sticky_flags |= next->vm_flags & VM_STICKY;
>  		remove_next = true;
>  		/* This should already have been checked by this point. */
>  		VM_WARN_ON_VMG(!can_merge_remove_vma(next), vmg);
> @@ -1159,6 +1160,7 @@ int vma_expand(struct vma_merge_struct *vmg)
>  	if (commit_merge(vmg))
>  		goto nomem;
>
> +	vm_flags_set(target, sticky_flags);
>  	return 0;
>
>  nomem:
> @@ -1902,7 +1904,7 @@ static int anon_vma_compatible(struct vm_area_struct *a, struct vm_area_struct *
>  	return a->vm_end == b->vm_start &&
>  		mpol_equal(vma_policy(a), vma_policy(b)) &&
>  		a->vm_file == b->vm_file &&
> -		!((a->vm_flags ^ b->vm_flags) & ~(VM_ACCESS_FLAGS | VM_SOFTDIRTY)) &&
> +		!((a->vm_flags ^ b->vm_flags) & ~(VM_ACCESS_FLAGS | VM_IGNORE_MERGE)) &&
>  		b->vm_pgoff == a->vm_pgoff + ((b->vm_start - a->vm_start) >> PAGE_SHIFT);
>  }
>
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index 46acb4df45de..a54990aa3009 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -117,6 +117,35 @@ extern unsigned long dac_mmap_min_addr;
>  #define VM_SEALED	VM_NONE
>  #endif
>
> +/*
> + * Flags which should be 'sticky' on merge - that is, flags which, when one VMA
> + * possesses it but the other does not, the merged VMA should nonetheless have
> + * applied to it:
> + *
> + * VM_MAYBE_GUARD - If a VMA may have guard regions in place it implies that
> + *                  mapped page tables may contain metadata not described by the
> + *                  VMA and thus any merged VMA may also contain this metadata,
> + *                  and thus we must make this flag sticky.
> + */
> +#define VM_STICKY VM_MAYBE_GUARD
> +
> +/*
> + * VMA flags we ignore for the purposes of merge, i.e. one VMA possessing one
> + * of these flags and the other not does not preclude a merge.
> + *
> + * VM_SOFTDIRTY - Should not prevent from VMA merging, if we match the flags but
> + *                dirty bit -- the caller should mark merged VMA as dirty. If
> + *                dirty bit won't be excluded from comparison, we increase
> + *                pressure on the memory system forcing the kernel to generate
> + *                new VMAs when old one could be extended instead.
> + *

Also here, we dupicate this for the VMA unit tests, could we replace:

> + *    VM_STICKY - If one VMA has flags which most be 'sticky', that is ones
> + *                which should propagate to all VMAs, but the other does not,
> + *                the merge should still proceed with the merge logic applying
> + *                sticky flags to the final VMA.

With:

 *    VM_STICKY - When merging VMAs, VMA flags must match, unless they are
 *                'sticky'. If any sticky flags exist in either VMA, we simply
 *                set all of them on the merged VMA.

> + */
> +#define VM_IGNORE_MERGE (VM_SOFTDIRTY | VM_STICKY)
> +
>  #define FIRST_USER_ADDRESS	0UL
>  #define USER_PGTABLES_CEILING	0UL
>
> --
> 2.51.0
>

Thanks, Lorenzo

