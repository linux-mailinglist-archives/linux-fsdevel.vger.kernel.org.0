Return-Path: <linux-fsdevel+bounces-54056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 787F9AFAB03
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 07:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8F6C17B872
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 05:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFB42750F4;
	Mon,  7 Jul 2025 05:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZOrjx7us";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DyNzdX8G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDCD26FD9F;
	Mon,  7 Jul 2025 05:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751866215; cv=fail; b=JKhwNK+Le8/Ru2tu8BZnvasfLuXarzp9xUwoEBda2vOmeEGhqZORd+5Z/JmXxc+10m7Tj2F01Of5fzUO6VfkO8NlcUShaOch7+8iMoybzTsoGbn4W021d1n4kDfGSr4+tQVNFS8WMljbR5t3OG+jsDU6KO4puVShgKfXwwjJyY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751866215; c=relaxed/simple;
	bh=b/yvgMxz1HVjl+UVQ7cem+IGq4bS+Wiu7q5JS2z5Db0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m7VLdKQ/f1owLgqOAYjR7+jJ8TKB0LmkfvOF5ODiYV7xntjy0QZrZjwRzZcpM07uNBNRs7F5URckdFzXVdgVNs/3HjJp2pDa2H0PZgQOC9luFL3OrOsCylROM75UhbwgK6gZSr9vzBrlHR3jz/cO/YiwYxcBuHgd5UYxEjlOnCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZOrjx7us; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DyNzdX8G; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 566Nse1g024569;
	Mon, 7 Jul 2025 05:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=e3LB+GMULT67jUz3w3synDT7nQFwJRZ/07o0x78CIBA=; b=
	ZOrjx7ushw8fLT1G5z3VOTpSYPgitOM1MXDe7yijdmncvAglfazGk06vXRi7HR6T
	/o7uASiFRadQYrTJ4Gx76jKVHYLRqc2fD/ZhnI4nsk03g6OWArs9ZqRSxPv3HAGA
	qPx88eP7NqQFtkxlefG3cj0dyaPQKxFswQKs/Vxto6g0aKNShKej4CH6gIVtZBu3
	Q5sXATpUL/bPcoJI0bdEbvWG6e/GW0orBacG3LUOSYjB7k3BO5xWSj8K98YSHqG7
	EFM0RMa4qeD3N80muUBhXz/1pu9f/9U01rvKs5JJ9gNMfNvpViMqutHlBH/657cX
	h/1Hqo3FHRgTR2Uxa4/TQQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ptn520dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 05:28:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5672PVBm024285;
	Mon, 7 Jul 2025 05:28:57 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg82hd8-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 05:28:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXiscavBOZbHSgl6oAVvhlXiaAGvu2EWR30h63CXFNQk/9bFOYVKZegiJWiY81u2DZeX3lhEQlwlqysx/rod3c5d74bz/xvTMrKNJVereD/0KstsOIgMX7U7NPcF2vu1gRe/UXZw3dNXVir4SzCAxcOfYFM9nt/oABBnNsxOemYmOb79U0/VOnaRkgYm9VAbY6AXE4pyupFcBTVRZ8icdfMsHv/LQ8hxyQPxMxifk7jZ6hXD+vkEhPIDuRggh0Rf5kIc30qcT5SqrGXhoa/zwnc2LzKzOpHWmaQud1D8c0m9Z+MsWgwHrNIHsWQkKmK21WfE7ETURigj8zLotidYQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3LB+GMULT67jUz3w3synDT7nQFwJRZ/07o0x78CIBA=;
 b=oYucKlSiNo2lR3jEHPDR/ndNxl4V1lLHJEtwTMQmZSeCTDRKXR7aSGui9rMHl2Sq+rIU7HWxObR6dhdgcQb5fZlOGv9PQC991UhKsivyNhZ9xObruHW+xFXOUdenPokVL14VUfvY8JincBmkhwQjuL5P+Ql5PX82LHYbHME8PlNsxhFPabhd59PaO5AFXxSUamuCmMU0rbK/j6H/GFrYgArx0TBGudSipC2M16aMP4mjJgtxYBPiJDvonZHBg29mLObqdM4QnVmBA4kR+20hjFNnLr2XlKHZMsDVP5Q15zcaNt+yYUUVYlIxY8VdL8/+B8UZ7G4QJE6ejCsQlxpETg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3LB+GMULT67jUz3w3synDT7nQFwJRZ/07o0x78CIBA=;
 b=DyNzdX8Glh5RWNxVVurVEX7OPd+p2vVYJiCpGSvaqk7+7HPnf7aGbhRlW1nZ7eEO6PPb+1GE6ScnRrB/aKJfwU5WS/Q3B1laobzNS17GeFQewTwbynl4g7e8JgXGfDp2K9qkMdZEPl0SsrcEE+wxIR/B0GVZ2CHO63NPvPRgLqc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF00080FB4B.namprd10.prod.outlook.com (2603:10b6:f:fc00::c04) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 7 Jul
 2025 05:28:39 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 05:28:39 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 03/10] mm/mremap: put VMA check and prep logic into helper function
Date: Mon,  7 Jul 2025 06:27:46 +0100
Message-ID: <a09be10810ca3e3d53aa89408a47d8d2ef12682b.1751865330.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
References: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0060.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF00080FB4B:EE_
X-MS-Office365-Filtering-Correlation-Id: 3722046b-85df-4245-87e5-08ddbd172125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0cUKf5Iebmlew86y/4G/Mw2B2ywDxSmGoyQOL0xGr4ANXNsOWJ6sDnCXqdYt?=
 =?us-ascii?Q?sTS0ZLVcK2DxKcu3qP2dnhKBjG939rE/2lHIH/Z4lkAvcKwHVaCntuKZ6ySD?=
 =?us-ascii?Q?CumNE/lRk6QzCCJhNedyMMTf21paWVjo+qEbv6CFlE3nCfLCtbdB82+gAqL2?=
 =?us-ascii?Q?KcTF4ZpU/YzQgyXqF7kaYDdGhDdyxZToKweya6H1A9BdCTCB8darp5xHmXM5?=
 =?us-ascii?Q?gTOdw2JLtFMuuHQP4vwoCaHlz2Enn84CqvpMU6HX5A28I645+K72Q67vYAfK?=
 =?us-ascii?Q?mk/PqT+vSI0YCgjpAO7l3P02/9baCSBeMS+TfxHMLPcjjoyK/qAn94eCO4lM?=
 =?us-ascii?Q?nc7OTIX4qeIf8YEqQVfCBAfpvKEsXEUUSl+hagKKo32h84jH6GtQLIZbC0FF?=
 =?us-ascii?Q?fkFozKnbLNBMBCz+1iXw69+Ormq5qTZR9P5zycI+8UuNVG5gbuDIat7f/R5F?=
 =?us-ascii?Q?gXgYwnQGl+atAJVnf+eWm1ZsPvC+auvtYj35TVgY6N5gQsjjjm3egwloEDS9?=
 =?us-ascii?Q?twBT9T1HJK5RvNwWYFrbg5hD2B3S55Fy4oi9OHMKpu2SRVjqLxFNA8BGY/EW?=
 =?us-ascii?Q?nOJmpYPDgrx2cjFFj8HOh1tDrPjM+m2YjvjjKoIENvhLybh92U8MmATvjc+Y?=
 =?us-ascii?Q?4b7ouRC/SiBYQli+Vttbn4uaCqc2Je4sNKfV+LkUn/CPJU6KB7wVDAOjOayg?=
 =?us-ascii?Q?LACC5OMV/77YYlMK5vCfTCzHrliI8XSkZZ/gSfP0tkK6UBb4fB0+sIWQMV5+?=
 =?us-ascii?Q?VS6wHDFWauKFc4ZLV1vTqIUQR3mtB6xBWk860/mgCCOxoSWo8hzXH36U5IuW?=
 =?us-ascii?Q?ENUOzxeakiCJ9Y6Aew58DKWJYnl7t8C0VYSk+FevHe7mxCv/obWFI1xlgnhw?=
 =?us-ascii?Q?+fbLbN9U1JDaDUNas5rpC+Pnos6dSV3qMfaJiqNtvDiN8WtizLQJg4QVU6bG?=
 =?us-ascii?Q?MzKkqpWKheMsEzVVAmIJm52A6FLhVmM+Tl/6PKbJTNG/gH9xiBnyID1R3BG1?=
 =?us-ascii?Q?1OTLqX8rIDu156F9zILzqYCeHYIxIxSJIBNM7mywx+mh1mu543AJJ5dxlFxA?=
 =?us-ascii?Q?c6I/bRtFpObOtZJUZKC/HcFcZluKXDAwCBBvHavPZfl29zLIGU/iIMLUHwuX?=
 =?us-ascii?Q?ByTK/jg/FP4EAfgFPhrseH3gSSBCv0DvUMjgG3Def03Av3YInqpawUxLJHQd?=
 =?us-ascii?Q?PXfXFQRt74oZIGmHpoC8NRps6Fu3mwaxhSciOgT/rQ7Z6j5ISiHwH1bG+/Gf?=
 =?us-ascii?Q?oNXRovXkCwNYqKI7iBa3X8qbNLyHAZ1Idy1VOQxgZGCEQzUl3RbYq4VkKr9U?=
 =?us-ascii?Q?tm9FvHpgyLOlKPkBBkYBNTIkyGsRAFiQuzOgLYy3wjHFeOwel06TiVaj556d?=
 =?us-ascii?Q?tfYWN9hhjHgL9znx/RAFqnsS9xIYCQNq9UVjz/NypY2X7fD/4ts1uid/bfSS?=
 =?us-ascii?Q?V27Gnm6Hctw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yqhP8yR8PqmA4aux/X01OjWfodp62Y6vpDl4qL3Bd16y/w5Vv2GW6E1F5BY3?=
 =?us-ascii?Q?JL0IQro/aENO+bD13h78Cd2Tnu4ll4AWQ9h1joxvMlILKjcNLCo6FtpAhWJ4?=
 =?us-ascii?Q?XqnSS3cSUEGbGyqbfbbA82YgrrABiA/fhKwpUiVnyvdsee9LLg3dbaejbYGC?=
 =?us-ascii?Q?FGq1R/vYmwORamFrEq/mBkq5JreLhZ0jR17DsB3RWwaHojlxgkQqy0Cu6Qxa?=
 =?us-ascii?Q?OSkf16BMFDxhH1fJ9iByqInbtBW6fHY3DELhQ/tLYKXNhohq50UO5khofd1E?=
 =?us-ascii?Q?XJscOzhW8Qev2P997vqJDFjDL/j1drfrK2zTTexf1bSp2vQT8XrwgE+z7Lva?=
 =?us-ascii?Q?sSoVNith5vA3kVxrxRtjd1YH2OeIKS2wi8w6TV2bVw+QO8u2/TcWdVD+EQOg?=
 =?us-ascii?Q?3Vd1PPWMp3iLyyfw3P1dTz9VdovLV44JXKl/+7VW3b6Wm36SLoNV9ow54E8O?=
 =?us-ascii?Q?v18ElylShh65qCAnPcbo0BkI3jOYzVBz2+pLNFD2QRfSwuXWIq6PopNdgi82?=
 =?us-ascii?Q?D+DUeTZmNhydIVm9rYMtV7PNlJ9oe2ZNVhuNBI/mxFz10VU9ratSldDBLHaG?=
 =?us-ascii?Q?53nSWf5oM+t+GCe2/g/2yfcrNAN+ImFgvqVMnQHiOY4KCaLeK/loNcyTgPgo?=
 =?us-ascii?Q?acrXZJgwFl6jq6OeXiamr4ZS2YIiyyC9DJMb+1zm356EFqxGYeGaJHl6/0NW?=
 =?us-ascii?Q?rsvw0iwK3v4NxOZwMNjmHo3hRWqaEVYGb3H0zL+IkYSJUzNUF115sH6/l+2G?=
 =?us-ascii?Q?arSlymkicpi8voYHFXdBImsCgNKKKmWOX3jVNaMmaPcOGyMdds63RQ7bvScz?=
 =?us-ascii?Q?+vDAT1+j+cZlTyqp5aUNpHrqGGofV6X+tACRl6BKoC+OcsRxcb1iW0ZdOWHL?=
 =?us-ascii?Q?EdGBtm9I/dtmOtRcAEwhJY5C6+EaQqKDs9izF0AYzJZKyo/4JkCbzXLQjrnP?=
 =?us-ascii?Q?Upwe+VD88iCVyXbFrY64WR4c4/tQi3TWQg4qu6oMdG46oxzNW2mmIVFmDnUM?=
 =?us-ascii?Q?40c4Z4CZXxVathQbEmTFPE6uKkLtMOm16szz8CmmZXP0vpXIuHuuGX0IxM02?=
 =?us-ascii?Q?RHmgjIavhkblAeZq429uWk0e0Qgyo4JDFbGys8/LuRrBcRYCBBf/QFUpc9tX?=
 =?us-ascii?Q?BWPUtg+2LliU3Tg98PF4YgA3qctuVw2xO5ocIa7qWegGACsiKblgzzCO3S9e?=
 =?us-ascii?Q?yP9J9NRdUOy1uzrumYtxYlhCz69UxS8OOVJypK14dzW37JZDB/9iNeoKUTEC?=
 =?us-ascii?Q?EySFDJZI5xnJd1i8tu30kizE6u3uleLnb8kooRVPK2UP2B6bIPA7z/Oks4TA?=
 =?us-ascii?Q?CJfR5CHNduDrYbYPjd51i7YxEtjzM9B/elFRMXFs0FBn85SzQtIVIBvCJccz?=
 =?us-ascii?Q?p5gycAKV4wmOyYxWaHssKtlQqDCb58nKHJjzPxdyaMdjfE2H8IsJ1kkpZe3H?=
 =?us-ascii?Q?Gxajs8Bc1tlyMp8gOhWPPhFJdtWhYXE4+zaiKg6aWSZdYGmBzmymOZgY2gnj?=
 =?us-ascii?Q?Cfi86t9rbJU0h1GLskQ+hfse4iHEqgFoxXyLHdMsTmdZF4/Ks52cp1s4yJBY?=
 =?us-ascii?Q?TwWASSwsuvD+JkfApumEgrfrfxWH07b71TNcmHBjLz3VErQQicbwM5QlmDcV?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9fB79gCNss0LgTnpoY4VonqheUe4oN5TpxzFbpfYfQ6QhWkv9EzQb5iznzR3PmTkIe5dxh/sVOgUmiPiQa8hP2PPY84d20NMh3zv6KZo3a+PIUNZK4vg0U6S8+5sgbOa7wKWkhpecHoNEbFLRHko39+lW29Ro6BV8Ww88lDCF0BMVrOmDJyeGDZVsb+NWMIres3eUeIrKHVfXNVP3swVnKSr6qIw8n4FcSe1qrwWmaluhuOBWmjTMzxfVRyXU+OY042G1CrDFK8nTd2Z95AulkIYx/l1RblTC8QYdP53R3v4+gQ/RVsk4vutDN84l8IGzz+gojnutmO19jSNtn7op3yMYs/Y/ZGGSeiTbHdBJeWYmQEBGPHgb1yPdSlg1AT/CIOdhkhoBot5zRp2PozKGMYRaN4sc2QnVt+sEh72ltFx9Ocj+bRacZPpDXqdSoPg3Iz8PwAQL9LgcXxaW0eakDymNZLPsuUrDpoAjcugJ9dllhzTl6OhtFgEn/z3lWYFWmJijcWNgVg1CdMzCDAe/XWuPqy/WW1aaCk7MrwETxvof8WRouymNMXtJkO0/tFH0qV+IsD4r6Yufry3Ljfksxld7DbJF3yMjmx3dX0rVZE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3722046b-85df-4245-87e5-08ddbd172125
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 05:28:39.6494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsOgJk/8sUg9qbMkQfg3Ags6xA1X99t2soq5MO95DxUIwXEaU0CcloowTmH9VJCjWirS7jNixlkZ8E2B7QVJSurZYL4MAHbC5/1cuoF4EbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF00080FB4B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_07,2025-07-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507070030
X-Proofpoint-ORIG-GUID: IUUpRFMtEI63gqbXj4uyKRducYf-NaYa
X-Proofpoint-GUID: IUUpRFMtEI63gqbXj4uyKRducYf-NaYa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDAyOSBTYWx0ZWRfX4fFZ87GEruoo DobIEAtIseDXCzosyKnDAJ+LRVFOrq5RgcP06Tq9FW3+WM46S7QD66xLxZZ/gUM9fJzmwLE7nfh A7AZ8GsqbYcfOEywiDrtU3XPmI341FVC38XgcGbQJB/dmLD28bk6pavcMp2ZKKgFk/5jCM5qimo
 3XBCT2oLECa9nrpdgQf+4Znu+MJDufvoNp3MrlVjvZfD4oJ53Ulu6wJ4YdIoV32GkkKzjMU7Qa/ lScd34TX5ZLjlZFn+n9xbc9F7UbjJ5fXFNQCF0XTRFfLYponWr22vIXOuXEe1xTjIx0UKxW/YHF ZGaENb2Wa4EJwCsJDMREPykXh3RCC/fDu5uWGwoh3OMzJznddM9WR90nbYWEjz5PoVATHqLezOz
 FEir3kEZlWwdDPBWU2OHsf6UWatmhShAX4kOD3m84OVYAutrNmQS8w9sJB8LlA3kLyGo8hob
X-Authority-Analysis: v=2.4 cv=UpRjN/wB c=1 sm=1 tr=0 ts=686b5b1a b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=oe0nGBzXn9sRT8uPAZ0A:9

Rather than lumping everything together in do_mremap(), add a new helper
function, check_prep_vma(), to do the work relating to each VMA.

This further lays groundwork for subsequent patches which will allow for
batched VMA mremap().

Additionally, if we set vrm->new_addr == vrm->addr when prepping the VMA,
this avoids us needing to do so in the expand VMA mlocked case.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mremap.c | 58 ++++++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 9ce20c238ffd..60eb0ac8634b 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1634,7 +1634,6 @@ static bool align_hugetlb(struct vma_remap_struct *vrm)
 static unsigned long expand_vma(struct vma_remap_struct *vrm)
 {
 	unsigned long err;
-	unsigned long addr = vrm->addr;
 
 	err = remap_is_valid(vrm);
 	if (err)
@@ -1649,16 +1648,8 @@ static unsigned long expand_vma(struct vma_remap_struct *vrm)
 		if (err)
 			return err;
 
-		/*
-		 * We want to populate the newly expanded portion of the VMA to
-		 * satisfy the expectation that mlock()'ing a VMA maintains all
-		 * of its pages in memory.
-		 */
-		if (vrm->mlocked)
-			vrm->new_addr = addr;
-
 		/* OK we're done! */
-		return addr;
+		return vrm->addr;
 	}
 
 	/*
@@ -1714,10 +1705,33 @@ static unsigned long mremap_at(struct vma_remap_struct *vrm)
 	return -EINVAL;
 }
 
+static int check_prep_vma(struct vma_remap_struct *vrm)
+{
+	struct vm_area_struct *vma = vrm->vma;
+
+	if (!vma)
+		return -EFAULT;
+
+	/* If mseal()'d, mremap() is prohibited. */
+	if (!can_modify_vma(vma))
+		return -EPERM;
+
+	/* Align to hugetlb page size, if required. */
+	if (is_vm_hugetlb_page(vma) && !align_hugetlb(vrm))
+		return -EINVAL;
+
+	vrm_set_delta(vrm);
+	vrm->remap_type = vrm_remap_type(vrm);
+	/* For convenience, we set new_addr even if VMA won't move. */
+	if (!vrm_implies_new_addr(vrm))
+		vrm->new_addr = vrm->addr;
+
+	return 0;
+}
+
 static unsigned long do_mremap(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
 	unsigned long res;
 
 	vrm->old_len = PAGE_ALIGN(vrm->old_len);
@@ -1731,26 +1745,10 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 		return -EINTR;
 	vrm->mmap_locked = true;
 
-	vma = vrm->vma = vma_lookup(mm, vrm->addr);
-	if (!vma) {
-		res = -EFAULT;
-		goto out;
-	}
-
-	/* If mseal()'d, mremap() is prohibited. */
-	if (!can_modify_vma(vma)) {
-		res = -EPERM;
-		goto out;
-	}
-
-	/* Align to hugetlb page size, if required. */
-	if (is_vm_hugetlb_page(vma) && !align_hugetlb(vrm)) {
-		res = -EINVAL;
+	vrm->vma = vma_lookup(current->mm, vrm->addr);
+	res = check_prep_vma(vrm);
+	if (res)
 		goto out;
-	}
-
-	vrm_set_delta(vrm);
-	vrm->remap_type = vrm_remap_type(vrm);
 
 	/* Actually execute mremap. */
 	res = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
-- 
2.50.0


