Return-Path: <linux-fsdevel+bounces-18517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 494318BA121
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 21:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41EB1F21B26
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 19:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797D217BB1E;
	Thu,  2 May 2024 19:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RqlVzJM4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SlnDbO1v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393D215FD17
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 May 2024 19:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714679329; cv=fail; b=Xc7lewMlTO5b6/21COuGBrHNMBR/w/xCzZyNl8TSMS1tYpBL3GetPLwDszyC+iZQBUIQj8Jeflcxhe1T96qXYvgqtSrgBRMjxGCs5kcPuoUk3Rkv+JduTrNf35cVMZ4RsBmk9yDM0qH3IF2NQwV7qurMNckTc8zD/YAWGbF7Z4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714679329; c=relaxed/simple;
	bh=XDghW+u+YV9KH2FYhufwL+8egjAqZt1QaYGbeCql294=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VaG1bjOH8Xq8+0xZRkqpdNtG+DycnLmc3KBc3COm7Z8sb2HIiFgQLUYOY3HBLGqLlGKPEe9FHRG+ukH+RNKR4TJTykpbnAUFJ9soz15KU/yjinPoxDSCw7FHFGjV+suy39hki7ILNlknZ2J22Sjbx+vuJGVaTE8iruX66Sz9DH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RqlVzJM4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SlnDbO1v; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 442HH7Om023664;
	Thu, 2 May 2024 19:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=t9pcHnQ3fal8qTgnJDRL2OmpdEwRZNl+zHaVzEvZNgA=;
 b=RqlVzJM4krwXn/93ROS15P/e/YcScqtU7mToNAw2PGCj+IujaEcbFyKzwqfhX/2SXi0o
 uxt59LwkLV2kPtEwYimO7kdBh/us67h/iXjTgYaN649FC/qJ+srmm/PhFMz1mHkI+hQ0
 RbyUN33g4ugSymhnuWRiMKDFOvVAe7KGKZdN30hCkgv6SCvI9bdVafQtQXjAEoY/LmnM
 KMDmRnTDJorQTaTRN3qr/WyA3HnRJ/t06q+PBedkDAnRcD8QmgUkyc5dMiYmxUnE9GwS
 THo2hpZ2j7ztFObugz92rk16ZA6R7sFZbJEEwD/oBBni7je15ILWp44wGpg+dwAg98rU tg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr54q8cu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 19:48:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 442JG220008810;
	Thu, 2 May 2024 19:48:37 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xu4c2pxuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 19:48:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVmDe5g18jJ22/ueGg0deahq9JOmbgzHJInCYNKUTe1pcueETRwZw+Lt7AUj7BmRsNXoO+H6XxtXHtGGiD/7eTYiyUPTPO8EaM8w1P8yLXVBQjdETtWtEBM1QEswxuK7nvtcvpzU4UIyIMR6/94Yazv9azgB6xYfSu1OohlvfFa/UM7OGUUO1f1PR37dvjlE6bXeddls/VkIVhTOycuLeRDBL7TQhYW8iXbylxgtkeDkdmKOESJBn1dCM82rq5ost+dHDwSXzC0DUrQrh035q7ZbAsfMqZfhuE/rwFqpPSOgPnDhWqntsWvekcaMwQ2Nw5cRP/GhxjsjCIAy4vlICw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9pcHnQ3fal8qTgnJDRL2OmpdEwRZNl+zHaVzEvZNgA=;
 b=MLNutE7fwxasqlRkkGkdv9QH9XLneV2QN7/IC4YEmmqgfIDhilnHRZRVv2mUjFxAhsFyiGrBaCHFPJsjPWXXPIBDU3Udd91zNtXsip6Gy3wQZp0BQKzyCJ4JhJEEvRnddkAexd35bjFj5644T2GWJrPwtcXZOjVDAe6nSy1SyJrEcqBiY8jcDnmkcXXIZYyxjaCZX/MtkcstxjhMAkQPNXdn1VTgPpzgzxgfvTwbyimgOkw6LiY0ba6NsBbDa6kObOpsZU1VqE8lyt9AzS2haI2/1KauT3pM7UB1+0b5AV6RmIprfRsFytw81xJJhl6zWdt7rzh8nwS07GPiYWw4tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9pcHnQ3fal8qTgnJDRL2OmpdEwRZNl+zHaVzEvZNgA=;
 b=SlnDbO1vBZeM1VT1zlPxgyR3yHCgbT0LhCIPEniy51+eyndRXeu5Z+0s9bVrxe0Y6NGHQQfSpikcA4yEO7li6F5sFsB1hnr/LcW48kQjyGzseZwqT11NtIu88u0DgIXHpSYu3OgfNW9AvV/5YfDGSJDek3gSE6m4PAKCfeATobc=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CO6PR10MB5617.namprd10.prod.outlook.com (2603:10b6:303:148::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 19:48:35 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 19:48:35 +0000
Date: Thu, 2 May 2024 15:48:33 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jan Kara <jack@suse.cz>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Maple Tree Proposed Features
Message-ID: <t2gvqeel4gbjyfk2g2mezuwwarlfgdbxw7xn4y366lv26pb6g6@m4rhm4u3w2ed>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jan Kara <jack@suse.cz>, lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
References: <rqvsoisywsbb326ybechwwgpdrdt57sngr2zwwrbp2riyi7ml5@uppobkrmbxoz>
 <20240502105304.m44vwdqtirhxhgro@quack3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502105304.m44vwdqtirhxhgro@quack3>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0446.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::7) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CO6PR10MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b90f280-dc20-412d-30cf-08dc6ae0dabf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?wvDK2/X3Z+tg28n1Gx26tCDuutYV+DQMiwGZUCBxInYY6TUihabkam5kSXCT?=
 =?us-ascii?Q?jI0csqof83l4pofXRl8WwupC+Q3wMCXoP7VEb0IZdWNBdKjVACybqGvq+7PV?=
 =?us-ascii?Q?5PTYOr8MGPWwU27SXSSG+PmEJQIRZpFFTNispHdP+eQADR61gai3F6smFF/f?=
 =?us-ascii?Q?1lEav31AO9i2xHuBxLF7FRXLva7JhgTuIL20yhtIur13aEQP6TYCf1krYci4?=
 =?us-ascii?Q?twHCM+p/Ulde6biRENPA5fyYoTw5KESqSOGh2zR7BEfoLxg9YCbKG43bkif2?=
 =?us-ascii?Q?gdUbyHphIsqBrcbARg0IvWChkYnKXij6ZEfm0Zd5CEh30gBKCUh+d9ZRqDa3?=
 =?us-ascii?Q?9rIHwrSfIDU+tMcRAvun2+4AyVWvPR23VRWQ8rqat/NISRem38obPRBncYY6?=
 =?us-ascii?Q?luANkbU0xUddVRsaxdRITk+M+F2hH0PEUf5ob9rMRCSMcZl7HYl/wBJlrOMu?=
 =?us-ascii?Q?qyMrIftryfz/kXfW9eEaaZxQEg7NIxrlqDJOR8UiGhbMrEfP1uDzBw1ib05g?=
 =?us-ascii?Q?DG2w0UtwVc2n0XFZ0euSGcrKZpc1PC3KBTFfpdC1Jl4P4rJTibwmWDqVH/2O?=
 =?us-ascii?Q?4XvFBAD8W+dc2wYRs00rlasw3Z778QL99cF52oxgMcuJvA28McpX1hqLLANg?=
 =?us-ascii?Q?F+djjwjMv/xJA2G95qx+L7UfYpeTfilzYD15/J05vpHdTCMlKUonE7GmmEcV?=
 =?us-ascii?Q?oTrq/IJnMtBfc72TWZmuprfgLKBdZcR19LM4xojNX1mrawLeFeIaEqJMi3f0?=
 =?us-ascii?Q?EuSHssnwRxaqb1WF4T5QF1T+tKUhQgSDwvBf9jkXt1+VNncCvk0e+Evu8D1J?=
 =?us-ascii?Q?FvCS4VSh27nTIbkYK7wLQv9Wxg48l3GutqduUQDKEMqajm4naqIyaN1HUJW1?=
 =?us-ascii?Q?l2ec/fjtYZYvalvBEJoB323cRCVBAmZ/+ztL3jS3d8Hau4Lo8/tpZpvwXxjf?=
 =?us-ascii?Q?wMAqKhQy9hE+s1HR/RDUbdIUNWfMlFWBkcEZorPhX6fNZ0+MoghuN0G931/W?=
 =?us-ascii?Q?ckCTA+L2aON2isnsv+1vQ1zivZBscnIEkkGaUj5zA7ClI08eTtlkX9eHAmIO?=
 =?us-ascii?Q?SLU3eVUg7ZIHAzvv0IVyi0pH7G27/6B/pxY7ujbCTnrbaKmFA3zQtYnXOHji?=
 =?us-ascii?Q?/37ElzVMdOL1WVpFNW/gYtJYYFqsDGYVYWYq7liCAJlLQfFNxPgIqN6mBnit?=
 =?us-ascii?Q?F66fhj9yKkfrRqv88Zk+hTPdLr+hZltxGm8ipoGttOAtg3c6nrcIdyuI1Z29?=
 =?us-ascii?Q?7ckBUnTK/emB1mo8AYeFbU1PU+l8ZFQVvjsZo4TB7w=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XxF59G72sln/xhIXhxy2Gilaqok1+tAqbLIG0h1pKWtK6Mj136QoqYw+lvUS?=
 =?us-ascii?Q?PcClCGxbaW8ztmJ6O7Vy5fcsQtbKmavzLiq5GempLJ+ZQR3hipJQWu2AQL+R?=
 =?us-ascii?Q?4krSvl8wVjrgZPcTQ8BET6Kl5KWhAfDB8y5Mp7epFcpBj1pSX0aM1hSi+wC1?=
 =?us-ascii?Q?fqNlcLZKdvJKTlhzt6T3E4LcCEbTDSJNnf4K8sJZNNXb8bft1hxVbyJIaIoK?=
 =?us-ascii?Q?FwDYLPjGdeQkZCo99MRvqTwaaCuyM8lDLop2Cb1GjZYVW+B+UnHk+6Su2BVz?=
 =?us-ascii?Q?liDlEN8GDPeM5sCDpi1c4pNhcK1YhBGHXK1y5ZS8EUwbeVPDvHUqqOuiHn3Q?=
 =?us-ascii?Q?Xp8g2pMJvGDVZCmvGTOBxm2RFFfcD9U7tWMZ/XR6ElJkQHt2N/lUMHW1tMzD?=
 =?us-ascii?Q?efMG7mfsCMh2mc/1nuC7Z14MPTbIuzs0ic1/XbaGRCalJNQhkMXKQWpdRQ1R?=
 =?us-ascii?Q?PoEPFKK7FSHUmx9pTYUajbCj9jsVzxONJYWr7XAYoUAMATKmnAho5fC8AvLR?=
 =?us-ascii?Q?dwE7KJXIh7NmZUi8vXeumejTLDqCjLMe3UgQn+UkdbWaMTKlnKxdzoejCy4q?=
 =?us-ascii?Q?yPNmtTBLrVo0XG9tQJsdCj0r8+nPm1+rJf2sDDIDtMHyjNWFIzE7CvzQlLom?=
 =?us-ascii?Q?hoy8t1kin5fVxtOIUqpXYmWJyk614jneOroCSkZ8x/xwnHVPuzndIapmC2Cu?=
 =?us-ascii?Q?puseMQKwG4MrKUWJljbChTTHTkbwKV+wjf9LGt2/BikVnVxfq/EVaOmLDAlb?=
 =?us-ascii?Q?zOO+cBW0kDhG58i9nMMHSOVJ/353hzN6uDdFLC5TaWq8vpSDsLG1NZ78vwhb?=
 =?us-ascii?Q?1eTFaBHVcDG/ovrkzUuDjJiEJRrZtQoqHAYuw8h09ztpHT4Zs9zZ9ITw/Vom?=
 =?us-ascii?Q?juqcoBv8Ru16uh7A3741/GGJrGZaTF4Ib9NO8rdTyNJV/9+D41xE8v9pur5G?=
 =?us-ascii?Q?TGQbLSPS29Oa/Yp8hE7fOtA/LzI38lIizRGsnKVejZrgv06bFC+hHHJ4PDVV?=
 =?us-ascii?Q?OjE1hPLcooDAyn5rbG3M9JSwLO47S+TwKKGZjAgIKqY2nwMsbbHcQPEy9qjv?=
 =?us-ascii?Q?z7OrncqWhwUALZyK2q5HrcTpYd7MbMl5dBg9OEiTb5c/Li2DXKBdS+qEK/1H?=
 =?us-ascii?Q?V4EmuppKVxUtSu7P3FLuaFpEWRmzw0evEtDVsqF7OaDf6jfhddMnrJBA8oBQ?=
 =?us-ascii?Q?6xje/wBwUtaydKQcTLuCLqm1Om2CjBCbyNS49x8NtGi50XgP4CZtyvcIApIK?=
 =?us-ascii?Q?UNgSSFV24dFmklavk1sYOJjulx6hpWg8He9FEJvqJ6wUZiTy6N+JdG9Z3hM2?=
 =?us-ascii?Q?uM4gSP7Rm9RItPsZHSOQUAQqS+C5ustcJQboN1jBam7tZM5O/s7FE4z2AQiQ?=
 =?us-ascii?Q?FAhYAboVHmlx+SCubOJJ2R48xBnMYOIlIuw23gDNnM5/y6KaPGOa/WD1dtpx?=
 =?us-ascii?Q?PNqs/X1qi2X1I24nd5B02OE5isylJxSX7Xm+RnVUMGS4C71Dia51ctACoty7?=
 =?us-ascii?Q?wcLW48toFzsb8WCpP2bbQM2Elu2ZaEBHVKTNXeG8FjDbbEx2B9BF/w+4jEnO?=
 =?us-ascii?Q?Ul/d4PH2N+08ZoPaeBLQDQ9JeU0gDXf9w+sc5Fiz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PpRyhrN14vbBdvn6xcyGZ8htA6+82QO/k2Ble4dxX1sQoqvzjPovZB1g8F8Lhx0U/v5/ZkZ7T5DC3cLIVMpYjXkEI2ro7GGrw/eZqzZFMlm7Y2E4QtG0jR9aqjI9QBzUqH56twt/4/1S/aYCwnx5WKDYYhZLOqJT0V3kiABEAizUgLjoi9iIoAshI2KisPFzDWDqvSEym7A6V33dSx2Vp/OtG72X4TRlI586JYweuxP6fWdKERhqn8PRn7GBPUIIcoCDJ4AQApby/CANy+08SzbEdozqYfI+EGsWiG71uA9hXIl+Tb7Yp50H3V1o1lTHFBNrIFKPvf5oKGLqc0UAj6qJObMvuvhY7KsdR+jMHMgalg8wlp6oAKb8m2/2xv1+nKb+u7t40BqkeoVHi2fZi4JBhajgkIR8tYUcE/6bnrjAS+McZgENpyQujlCbddM7H+NoVlLDBOejIVKX9fQPP3cjvQrXSpFsZm5EI3/aULM/Bcbd8zIhhCCwnA1+ilo1HUJcICr74aUaP8kTV4lxPXxb3mw8wh5ODLnSpf/MrwNSYEjh5mc1XAKSDvWQqHatQpRwJywTitENLnWNSSHB9uB4t69a/CTeMaZWERahqTw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b90f280-dc20-412d-30cf-08dc6ae0dabf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 19:48:35.6133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QKU6fComCd+B077x1yVmYJjTye0C8Wh9DEIbDZRfqcmt4MQ5/aa2chMe6lDUrby+2+zp7TswZx5mMnA6R9ugEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5617
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_11,2024-05-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=945 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405020131
X-Proofpoint-ORIG-GUID: PAN_KDYZCL1awimlquSVGzs-Yd36N9rk
X-Proofpoint-GUID: PAN_KDYZCL1awimlquSVGzs-Yd36N9rk

* Jan Kara <jack@suse.cz> [240502 06:53]:
> On Tue 30-04-24 23:16:55, Liam R. Howlett via Lsf-pc wrote:
> > Since there is interest (and users) in both the filesystem and mm track,
> > this could be a joint session.  Although, I'm pretty sure there is not
> > enough interest for a large session.
> > 
> > I'd like to discuss what functionality people want/need to help their
> > projects, and if the maple tree is the right solution for those
> > problems.
> > 
> > I'd also like to go over common use cases of the maple tree that are
> > emerging and point out common pitfalls, if there is any interest in this
> > level of discussion.
> 
> I'd be interested in this. Not sure how much discussion to expect from this
> though. Do you expect this will take a full slot or would perhaps a
> lightning talk where you share where things are going be enough? I expect
> the MM track will be rather packed as far as I've heard so I'm inquiring so
> that we can pick the most sensible scheduling...

I'm not sure a full slot is necessary either.  If there's room for a
half-slot, that might be enough.

This is too technical for other conferences, but also not quite the same
type of discussion that is typical at lsf either.

Thanks,
Liam

