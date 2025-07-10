Return-Path: <linux-fsdevel+bounces-54529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6977AB007DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 17:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BF531CA4A0D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 15:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537022D46D7;
	Thu, 10 Jul 2025 15:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VQq5CXeB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kwRDOtzW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299192797AF;
	Thu, 10 Jul 2025 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162733; cv=fail; b=X683EJoWprlPyVw0mF+Vx3p+cI8NbFTDTln4sn7342DA9AvDT/56A/grwUSvSuBoWZRoaxD3OWSFJyT6KaUuxGE++/eXKdLM0dSPHEkAy4Y9Na5XdF2gOk0ydG21ukfBYGR0owhXI9gRqsbFX8BFgTzmK2luXAS996CKTLtBiDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162733; c=relaxed/simple;
	bh=x2WfqaXmOANO5D4YO5/TRIo5NHLzlQt9N2l6zLrb9o4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TigTw+A9f36Ml9Q+cLcop71Yl80c0CX7302sAvkyIy72+59dF61RT7jyOtEhrvTdbKtsJIWxCtAeU5F3wl59RarqGBGIT/vx558sTi9DVppdGOgRuBrW07/GTXfXNy5nSDXkASeFXgNn2nP/ReNS+2JGnceS898n6FVYC6f6YOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VQq5CXeB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kwRDOtzW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AF74jT007439;
	Thu, 10 Jul 2025 15:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=BNm3SwULJNMyf7RE+WPGHmXkhEbzBnzDprncZ6EzcYk=; b=
	VQq5CXeBCwo7y/4JsIRDu3VKw/fy/hU6bF6XU99b7sU7hJv2VhAEL+lOn/eOoR2q
	2AmA/fWIAZRc/5FH9KN1Ag56yXLN3he3LhruOmUGHrYRcvMRWIpzDhoxMcIW+Kx6
	8iVYGPMaF9LmurzJgaCJcz+yfHzdLJJ/gmAU9GTYzxbR7eFXVWXuz4XA57cOVctT
	3V7UDRVXey0G+AqafV4GXAPrPEkHo+rLjiIjisVPqYfoj5lvCgyCJeZs/fK8ubdK
	qHFhU539lUGa+qd1XGXDHwT0/mtsnQ8ZwNl3IcgfktwcjKZozMqUAHUWpxkU9S/U
	ycT6czlCkmlpgxdukTmbmA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47tfvd0397-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 15:50:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56AEkQbd013536;
	Thu, 10 Jul 2025 15:50:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgd7ywb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 15:50:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sW6kyzj+5je0oyh8Ri5B+N260ADr6DRqbIEjI0KIIUPtr2zbK3HkF2qmP4iR6I7/2iGLir5m4U5iGm3lSD1ZnxiBivhz+5XDJJfhyh1X3jj3QJmgs+0OvPEcBS4oa4UzGkS10O0peq0Zmar0c539E00FFgnJCf4GP7Gqss5kXvwtZNye5pN+4OEWGqJoXx8wThP1YHmm29QUOEnesSNhsCTNr6FTN6N7jwTeZeMXvOatEpX9IiUgeaEauXsPg8Tw+hBpNlRrBgVEEX3bvBgw9ismTygzDsehhRWm4nF2PDOlD9xKjRCkGSV2RqH7RkOJ53X/e6XmzfLjit9LfE0pxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNm3SwULJNMyf7RE+WPGHmXkhEbzBnzDprncZ6EzcYk=;
 b=x65fiTmZpNNg+2LYviB0kI+W3KcfbmKZz07b44s50GRNj+MWkpbC0isvfo8IlhYQh/IGiop4E0yHeG+Ut8/lmskc3P0g0+35MkFsAJzZDHRk83z/z9lC+8Y37y1ql67HRJ7wLoV4xW8bnuuz/ZDWGtm11XOW2pn32xD0Xbgoq12YlwGofJQJffYQHBQMAYP6AMZNHs+XFVjBEJxG7IKVrz178hlQ+s7N21FUVzDqK5VOhTjXIqKJHL89WIkFIujUBjKOBIOihbq15V4GwzAko4GT3JGXa7buvxdEQcuAf87tPPeuDk3ZAhre9bf02xZYbLv9aq2aN4ZnURLftFJPzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNm3SwULJNMyf7RE+WPGHmXkhEbzBnzDprncZ6EzcYk=;
 b=kwRDOtzWLYrTYX5ZTgj8Cq+bqd1Vk5SC2xdrCi+7Hf2kS/8d8DzsMUNj5+/9OyA68hiHiKH7j+AKNindQ4MBRk7H9vtJR5q9L9c9lbDvQ5vN0etLMSTcxHf91r/6F8eTYlpu5uhb6HH2qk0QAr/FATeOXLt/ZoeHcfApL0M7mSU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB6691.namprd10.prod.outlook.com (2603:10b6:610:142::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 15:50:50 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 15:50:50 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 04/10] mm/mremap: cleanup post-processing stage of mremap
Date: Thu, 10 Jul 2025 16:50:28 +0100
Message-ID: <4eb6dd13ff135a01a1cc82583214d8d790be9592.1752162066.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752162066.git.lorenzo.stoakes@oracle.com>
References: <cover.1752162066.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0064.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: 835ceaa6-2e05-4ac2-8db4-08ddbfc98b61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bOWI4RhhvczHNWVlGKyzwJ2jo+vNWVQxYRNOnmhcw53U/2oSjQCfWpAtnW4I?=
 =?us-ascii?Q?Gg3YByOvO/GM8USwIlXLVuyvPQfVdkPvhRDDQlAyaHTTp4D1LDUV91fSKRPm?=
 =?us-ascii?Q?QmeW2KOMxQ3g4Jn+55rrQtMRzvZzasDxSUKU277Y8wSmJ9hFQmiRVFukt7xp?=
 =?us-ascii?Q?j6Bh49+xf2B4AnpRmzEyhsZ2Qt48FskujbFRG5dJvqiVvMIekQyMWtll4x3b?=
 =?us-ascii?Q?qdzVMk5oYUkanKc3XitOxVn5+a3tnk7wKVIRLyNmEx/295c14Iah2FRIbPyG?=
 =?us-ascii?Q?xmDUVxoZazlXEyxUzKR7m09RXd7LrrHP5QYmx+mtkZCHwpJiClWOSH9SYkMm?=
 =?us-ascii?Q?FXC5K62WqXlUv33oTAttvr8huEobOMj44WCxNyNfGE0ZqxQcVxZwEFLJ9Eyw?=
 =?us-ascii?Q?bwaR27KjBSM+4muPFEGhd2tAuVgllmESL/cjtkmFdpTuBRi8AnwXgmicbu97?=
 =?us-ascii?Q?ctc8ay97RT1hAWEn5UhNK/BGi4oCGTdFeaPEyow2odscLNd67bCOR1K8rkYE?=
 =?us-ascii?Q?9ri6g6MVrv0nGQIjzfHETKTZiZihJ1fDuOfW7TBE6QU02EuB9VGKZ2gyGjXK?=
 =?us-ascii?Q?soSdpmJORvKAeoxhNfZ3ZmlUWVCWaQ5igbgi+TYy7wjlVnewbi/Zpc0BvU8H?=
 =?us-ascii?Q?AWxdm6Qw74ApeVz9EPiqi8a1MhO/tsoXBVUuYk3NbmYOviu7QfQcRKK87XNg?=
 =?us-ascii?Q?xVgORI1J9IhHJOSiuWIxujqu/Y1x88yMYqehPyOkDg1FhIkIPBJ8TdQmmSMG?=
 =?us-ascii?Q?KHkUoejv5himnCfwQXt1aLjv8dzqChrdfRSUcqdjzN4v7e8z13qiin6JJtai?=
 =?us-ascii?Q?lxfbPEzCQttGpZW5ezZReiL9CRI7qt/m6uAIELilOGF37EAV0arFI1uYqqBs?=
 =?us-ascii?Q?vFoAMH15jJyy6XoGUNHVBKQcBW4us6oOdkycIn/i2BadJcQpxs5XdFu3JI9O?=
 =?us-ascii?Q?ub7LFE52pU3fskhbk6lSFnXW4+13hsslZC9hcDra4wOApjKzfZEu1JZd+r8H?=
 =?us-ascii?Q?O/upnBQTQQeJDCT8k0QH+5qlBMRQlvR5unafa9WnThEYPjtFxmALxOorVlCp?=
 =?us-ascii?Q?fHT4WMfoJFW02X4DAWsGv3u+G7NcRPrDrFRg8FjfptwPoM3xz2VBLBRD2v3f?=
 =?us-ascii?Q?56BBgekCDMqbCcheCW5cJKKkTBkoVlwSGSJWCP+I2pOAsW/WKCBKox5jUuVP?=
 =?us-ascii?Q?eseAY1y79A71VA8wgSLTkFbW+qxKdohI9Js8NLEjr/6zhbfjoxD5JCo9LhZC?=
 =?us-ascii?Q?iDuobqnbj7rgvBnMyL4crxQiAC8scEluESGInwHkQ7LjiXmtlyWaEDlD5jbg?=
 =?us-ascii?Q?fWXUV51WtNDGqgAVL3k8lfyfrMLOUfEfWTqf7D8zgx13ZlbNjo8D91HUou6O?=
 =?us-ascii?Q?W5ZmwdGWoJY3av71xCj1Le/WqWJc/pUubkO9rnBNhNJiizZcq7b7/zA7vav0?=
 =?us-ascii?Q?TlDQyq5KQFs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z0d0+uiikpipbMJUjKBueRUALA0B99bCXMXXe/9gpTq+IjsXtgVmFQqG3oNN?=
 =?us-ascii?Q?SBce4ANNtYEFhLNHsL0o5xIybrFunmatksAb/Z1aH8Lh/09H1MAiGxiCG30K?=
 =?us-ascii?Q?11WzJwIY1Wyk5eZ0sS8tTj7WgawDOWNQ49TokQ1DNIwPTGMByRqU9BbeHjlN?=
 =?us-ascii?Q?HKbJ0yavcgl1wAJBPRQ8ZUep6VqbidY7Fs/2RMFOTaR9PbaeXmBUsarZYlTt?=
 =?us-ascii?Q?eWzO0IdNMQdOkn+ZT1oD0ebtgL0ZZtHx8plSxZdrTSGeEqLIWCIu3VYr0u1M?=
 =?us-ascii?Q?2hTcJmPETQRC7/R4X4yWqTxzTCVP8YxKX8K9IYnPntahfUh90ESjNLda9iPi?=
 =?us-ascii?Q?aH2xcLBKm5m54m1mLaVx7TNywbgxdFIAbce/g8sdrf3sAhup6YNjdbzHQnd4?=
 =?us-ascii?Q?MS+LRE776XfNw38dhaPoalKxFh6/yZvuuxbRY63w77TpQdKnApSG7JRFuQbs?=
 =?us-ascii?Q?Btao/bvFSIH96gPw2UYTePYoMXDRy99AXortV2hW3om3QR2DNCPdEWHsrkXf?=
 =?us-ascii?Q?hdg4C0fOvoYrXC3CY+E+JfF+rtR+ivgj6hWXSrBcG7PQVd2dBMSXH7J8taqd?=
 =?us-ascii?Q?GNrxCIFbJ9XDUq78kiAWlwUwSx5rkNgwZO+HGSJnHqGiHquCG8J37H7oh9Eh?=
 =?us-ascii?Q?+KaoK3NsPnw0ZTkoU94elOyZ0+spw3ObTdMSQRx0sc7lSr2NaOSoCRYGfHuy?=
 =?us-ascii?Q?NxTXNI6yBDyorHGTmsN/K1Sc5rqCN4an37V1W6gcLwlNGULCVUYIj0jFHYpT?=
 =?us-ascii?Q?2cgdQXyq+Ib8yTWqBTdMO27c1N5xj+6j5FdbYzt3YtyMQI34pQIjJfCep1vP?=
 =?us-ascii?Q?BZiEDRvBmqJhWK8yQxPh2W12EiYiyPV0YdMR5VsOgM1oEW/szcbV52ZQHUKX?=
 =?us-ascii?Q?Y99llO+XXCxCKDnQRKpNnAlfxtOENgwCFqc5uqLv0EMwj4vyRFpGExHBcE5c?=
 =?us-ascii?Q?18zKexgQn1ejlOA14dDCn5tA0CSUMiOmWYwp1QVVA/u8sgskhSl97HxXMTop?=
 =?us-ascii?Q?o9mzf85AJoL9BPjKb1z8ZA3fMPlvSJVjXpb8m6jUjFpcsezlfxPvfWkcyhh6?=
 =?us-ascii?Q?qeltvcHv80u5FKCCCfsDNxrQHHsaG9hsNm2/ii8VO6JDUn6lYoVPPjomB7it?=
 =?us-ascii?Q?iy8pDNKOyv1khynoreuc9lMOvsqv88LJCqicKmYVtZV94gote/+liMPxcM1a?=
 =?us-ascii?Q?MbmITLJYIBYuq/UzGJnVotK4N7eJeoStZdmBsj/ZOxDjEw22YVeEEE1AG966?=
 =?us-ascii?Q?CyGIrHsG9f6l7o4L2qLmuI2GEpiZ2cz65X79vVdJoSwOSGuMoRoOv1fA3Z+W?=
 =?us-ascii?Q?5mAa2rdH9p23IB1jg3qcPmZl5i7k5pHrN1nePHrZAUYY2gHN++VB0JiNp44L?=
 =?us-ascii?Q?udqbcwCis0uvTsPUpvu7bDBi661jRI08YrMr8+Jne8UBkWWsquWH7fhyw/oh?=
 =?us-ascii?Q?d2OFA+nP6WWM4cdvjaVzGnVCBKmZFRPE2AGS6zemPCxXYP7DJBoxJlATKHEf?=
 =?us-ascii?Q?6EugHDn9ruC8kkGNBbZRstLMcpHpUr+fG7G0Kcug63Gko+JN+FN+rUHqDGV/?=
 =?us-ascii?Q?gL51fhWBf4rYWVzJHkb8J9g4bCsqnB/Ck4AEeZLAT6hXRGyBsCVMsJymaANv?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kHrV9TdNoX2rh+bI8k+X5iVMYIxCvUCdUzGq0BkKjhNOylhhL/VXfTVuTX2naq4qZ+edb0zAo1iVmx59VgfUBw62+lKHu+Tz70fxWXupvNRnjtVdDiz5rZge7cwD9ZeSbEMxOCfMHP0ve5gVvzFtGnJTse0mck8lHlbHPo9Kgrbucfe9jbFbLlp4pHak0Pp7UJ5JtBH+vg3OH1DHxgVih62vl3VGuPqCeYfLP3Ad/XhXb1TBT5EPL6mbYfp3QbZestAKeIWflIR8p0dYlOCXM8518DKGpldZL+sMv0rE86nnHzqOfcHIBrMj1Ad9XgnF0SEKxkjQyOzVF6sDyqt0e+3tTm67/VP5oQmoNSL1EhVfeQwTeZUx4oE5HMttm9CEjBP3EwGn0kpEkj3i7tTtUBJqZ+zObqDHxppJdtHWLrwowYxc31MbsqToBvOKs3AGznLml4VqYRhkoPGORdE3QM7HwjBauyBAIU8LvS4oqcJrr4utmnE9UW60w9k+wcDNkn1Qea4x7XQjXyYHGLFSEOIPBU/kVDVmL6NLl5WrSC3/nM8e3SUGf6SInQYTTNiU9dmATqhMKb8lNn4RRrqmgfDTEjAh0eOUYtxEITjDPn4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 835ceaa6-2e05-4ac2-8db4-08ddbfc98b61
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 15:50:50.4910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8asgWbI5lWIVc6QJLszjmXvLDNqONt8yRZJ6izlS+2rwALDscGi8HBh0GER3E+qKQ+FnZVWRDcO3t8mjs/7zw06kl1X31mDGcaSTJaRDKX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6691
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100136
X-Authority-Analysis: v=2.4 cv=Ydi95xRf c=1 sm=1 tr=0 ts=686fe162 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=ULdmrcW3YHslXA7JyQcA:9 cc=ntf awl=host:13600
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzNiBTYWx0ZWRfX3k6F4iDj7kiC Kl4QknuN2ZeHTx0nL1pZiz5dPpkjITde1ri0CrAl5rvL4DA45z8vBaFLXNTMGLk0YOBCF4j8J2g MHGKlYlipMO8l/qTD+5Gbmh41fs5xMK+JSGGrQbfsWZlp7lY12e00JNoqUsBW4mk1WRg0IcGEt6
 gSLc11l2KXBQtbCXjt8i+erbtkcds7h9Kevx8vYt3vWEb8btAk9zo9NJviPjBBQ/GchPkiaAFIg cT01fE/U+aQDpT4h/j31ZvECaUPfEg1d36UWISvdsCyb65yIh3qFTuvRVbFy6tTl7NR1vhM9don Kv0+Rt49Sznl5J6P1TmtP29E9R1yZhFEcrtI+t44+K57q/Ee1YNG+9BDe9cvLPia1+RMM3T/HNP
 I537qUWpEpcQsdOQXhLbkRjOEYKbya5/xUMy9dwUFXqeeZ/HAq6aJ+9aBqre4+pA/qj4xACN
X-Proofpoint-ORIG-GUID: Qew9zwzZxYEVbXJe383BJgEiZ7QiS9Ku
X-Proofpoint-GUID: Qew9zwzZxYEVbXJe383BJgEiZ7QiS9Ku

Separate out the uffd bits so it clear's what's happening.

Don't bother setting vrm->mmap_locked after unlocking, because after this
we are done anyway.

The only time we drop the mmap lock is on VMA shrink, at which point
vrm->new_len will be < vrm->old_len and the operation will not be performed
anyway, so move this code out of the if (vrm->mmap_locked) block.

All addresses returned by mremap() are page-aligned, so the
offset_in_page() check on ret seems only to be incorrectly trying to detect
whether an error occurred - explicitly check for this.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mremap.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index d57645573e0d..87cab223f2bb 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1731,6 +1731,15 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 	return 0;
 }
 
+static void notify_uffd(struct vma_remap_struct *vrm, unsigned long to)
+{
+	struct mm_struct *mm = current->mm;
+
+	userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
+	mremap_userfaultfd_complete(vrm->uf, vrm->addr, to, vrm->old_len);
+	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
+}
+
 static unsigned long do_mremap(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
@@ -1756,18 +1765,13 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 	res = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
 
 out:
-	if (vrm->mmap_locked) {
+	if (vrm->mmap_locked)
 		mmap_write_unlock(mm);
-		vrm->mmap_locked = false;
-
-		if (!offset_in_page(res) && vrm->mlocked && vrm->new_len > vrm->old_len)
-			mm_populate(vrm->new_addr + vrm->old_len, vrm->delta);
-	}
 
-	userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
-	mremap_userfaultfd_complete(vrm->uf, vrm->addr, res, vrm->old_len);
-	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
+	if (!IS_ERR_VALUE(res) && vrm->mlocked && vrm->new_len > vrm->old_len)
+		mm_populate(vrm->new_addr + vrm->old_len, vrm->delta);
 
+	notify_uffd(vrm, res);
 	return res;
 }
 
-- 
2.50.0


