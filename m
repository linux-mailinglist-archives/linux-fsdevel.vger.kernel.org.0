Return-Path: <linux-fsdevel+bounces-71970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93764CD8936
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 10:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0807C301B2EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 09:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC3B3246ED;
	Tue, 23 Dec 2025 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dz6h7FlM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fZkIrR5M"
X-Original-To: linux-fsdevel+subscribe@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7CD276050;
	Tue, 23 Dec 2025 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766482001; cv=fail; b=oDYVUu5kI2m+NzKL5wThisYf2g1lx53PU8XBDG37odlwdQnDcqGaOe+5dHeKLAibHfUAHfyON7TQXxDv7WeuOBWwQgrKUygYEIxnYk5/qSQ7U1EgtGbbgnE8wnZT++ZRJW0RTrxm3F5Caf4+/RT3NaPAa/jdji8NDwr+J8uhpMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766482001; c=relaxed/simple;
	bh=ooYbxFu+x0KJgFM4hfCT1E+Xw7MDVPyKc311YiyN9cw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dXTh7PysIOtHUDPxBHs+2IMpCVFtpUFD9GdC61xKkh2+brTFbFmiLTRgaSEHwDy5Nbg+tvnq7dsn2tgpwkmjR0IUWesknSt0tN91LALBTcdsReu6RYztNDEvHnjg7YKUM986vsmAsqhLmEBd8Z0lfVOZOG5SUHgZEXMKS7WLfCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dz6h7FlM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fZkIrR5M; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BN8v3qW077504;
	Tue, 23 Dec 2025 09:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Lg9yg6BWw9p8cIy8wtF7sQVWu2Cv7V7C3gPjQbu7+OY=; b=
	dz6h7FlMS5cp7MERH9jhpXJtRmFwRGgs0muFD3aYOy16/8ljUmiYzGVghv4IiG81
	13eltgIZEJZ8Uap0+NMuf5MTGN0eoYOg4ALYDd5C1oVrnD8fsAcU4v0QhFEpo+l5
	dIT4WCc3sCNXlOsszxys4cUhhZkpNaNV83iMMgWr1xNconBFys5mY+fF9rKWlRT4
	ggGVetdZLJUNFjTSqT4/F40AXeSnWfDj1JQfuW5K8geCGN5FDWbmvgVbSbwyg0WO
	Zm2cLrt7hBMvEn89MOmOZKijFcZLyjql0fudxGuR2Y6K1qpHDpQuDnea/V5TXukc
	O0xDFILTypkIce8OCx/QzQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b7r16g0y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 09:26:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BN7CGAi016556;
	Tue, 23 Dec 2025 09:26:26 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012069.outbound.protection.outlook.com [40.93.195.69])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b5j8j95j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 09:26:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4Y/6k49rLw1vpeGbQHkDw1eVA2ECO23xamdc1XpSbFZr5TIKHEfLV5YWJ3rP3bhmZwK8Fv+pYwox3v7OwSmCVK+B/me79MRVGpdHhv1XCJrmfacKEGL+yTS+sFjvJGz3B9LVRT6Am98Mcn8QnykySxbVNpxGBY2EblMY56OVfj3JQB0big9yDXjjI9qO04MxNzDRWNvMiDH/G38MZyoXMO1WgrXfCpwgMLP8iz6KkpiNBqNqzgzeNDUVAnDoOWjvvOsfw4w0tpj0N8S0nh13LRpmEF1qbhjsxcD4vUhxQKapeGOHebO1x9skdvt0/hlFRJ/CyAiJQVQj3Aq7uU8CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lg9yg6BWw9p8cIy8wtF7sQVWu2Cv7V7C3gPjQbu7+OY=;
 b=nzGHcC9PILgTordgXfI5uU5XYF7Rgw/dHtG+G6EEwOigQzAIuIzk9pkigtmv1LuTQL3gP9lxNykh7wb/aci/5cxu+7kzF4siEU86MdFjTL/SUzpOGVCWcMoYD/MA7QzP9GBuvJkEg8d4fTN3a3kNfZGnh/TDNVE3BEmKO5sgXzuIphmf3faRc/mj3JtBcev5diwPM3WPqJQPUG23SdIEO7jOVfA16SMAsmS/0wV9K2s/Y9bSBmlcjYjJN06HBMblgXznOgesnYBE3vVv2A3yno1mvKS3GDWjnsGqNlmaE7nK1HrmV+9vfnt9QbHb59ntDuVbYv1LV+7j5gPlHc8vGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lg9yg6BWw9p8cIy8wtF7sQVWu2Cv7V7C3gPjQbu7+OY=;
 b=fZkIrR5MVQLaE+Hzp8pRHx5zMMxeL6dqmZwfqJjxS3CPeC946XBq8cg+W9Uo+2FWtTRf6j3B8CvVWIRTMwrSh7maTZVcC3YwNST2POB2R83PT++IbG4S/zj5qjAC8QS8B/5zPVZnhoh/wfiPOakkEeNLhLywDYNd1FEKhjXyrlE=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by PH0PR10MB997619.namprd10.prod.outlook.com
 (2603:10b6:510:380::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 09:26:23 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%8]) with mapi id 15.20.9456.008; Tue, 23 Dec 2025
 09:26:23 +0000
Message-ID: <9304d77a-7439-4772-a549-5ebcf8bf371d@oracle.com>
Date: Tue, 23 Dec 2025 09:26:20 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Do not require atomic writes to be power of 2 sized
 and aligned on length boundary
To: Vitaliy Filippov <vitalifster@gmail.com>, linux-fsdevel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel+subscribe@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
References: <20251221132402.27293-1-vitalifster@gmail.com>
 <aUh_--eKRKYOHzLz@kbusch-mbp>
 <CAPqjcqqFN-Axot-5Oxc7pXybQW9gt-+G99NnW6cfC==x39WiAg@mail.gmail.com>
 <CAPqjcqqi8uR=RWEpLEC+JiwOg0fzvWvwEOscj-XYHKLuPcnDBA@mail.gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAPqjcqqi8uR=RWEpLEC+JiwOg0fzvWvwEOscj-XYHKLuPcnDBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0058.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::12) To PH3PPFEDB06D67A.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|PH0PR10MB997619:EE_
X-MS-Office365-Filtering-Correlation-Id: 885a5603-5599-4c1e-a529-08de42055662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0FGRFhBKy9LYWhGN3QxbWdLRERuUm0xckdJdTBUbUNZTFV1NjdOVENpRDN0?=
 =?utf-8?B?MDVOSU9yaUZIWG50RjdQemlUeHdHV0IrY0hmWHd0azVQZDZ5VDlNN3FIYkQ0?=
 =?utf-8?B?Y1Q0VzR5U0tvSjNidXR0NnFmb1hhajhJMGdaUEVZMEhVZzFzV0pISElyL1FR?=
 =?utf-8?B?SHlpZjNSc20zNStCWEhlbXh4aE1CU3RwOEtqK0I4OVRIeXc2MU9tNkNVQ3do?=
 =?utf-8?B?R3crRnpCTEoxeUlpVmdNMW15SFJmUDhGcW83akg2dmJOdFN0czJSQTRVNmtW?=
 =?utf-8?B?YUhwbTNlUWk2QkdLcHdROXJNdzc1MzhvQTgweHB1SWdUVHV2ZXM0UU83U09E?=
 =?utf-8?B?c25qRTd2V3ZqMW1iNlYxSzY0VW9IdUFVdUlhZUp2OFpwaUNaSFdnVnowT1Yx?=
 =?utf-8?B?aTA2WWdBWmEvNEsxbHNWN2ViNldXNWlmUUhWM01UTlBCMHlzTzQvZkgrbjhV?=
 =?utf-8?B?UkFKd2FNelMvdFlCTWk1M0Q5c1dxVHN5WjBuQkg5alB0WUJyK1ZhVVllZTlz?=
 =?utf-8?B?NSs5eTNLNS9lNTJSTi9uUzBCWnVLS1ZnSEtTdmJLSUd5Q2JsQ2JIUDB0OG5Q?=
 =?utf-8?B?UjZTN0VLUXBZUTJBM3kwTEJTL2NsQ3BuQ3dRSVZGNWowTzA5dnZ4N21wenM0?=
 =?utf-8?B?cmxKbzYvRXFQVUtObUxvZmRGTGNQTTY0cERNSGVIa0JaVG9CL0tCSGI3dWND?=
 =?utf-8?B?RW5PMjhlejdMQ0pGNURVbjRuS1Q2N2E0Rnd4dDhIRHNUN240MmZGcjU1OGo1?=
 =?utf-8?B?UjBKWXg2MHd0bzVlVmdGbVVnZUwrQTNrTFlSMUt0V2tXT0JYMzR4MU9KVTNu?=
 =?utf-8?B?OVhURTBBWkxyc2FoUS9hOEY4UXZseS9TbnNlaWZZYnFDTUdnRmJXczNuemZu?=
 =?utf-8?B?UWp6a2w4b2lIUTgyemZQZmtVYWIwZDd4aVVmMk55ZnZCU3MvRDVGQ3pmNlI4?=
 =?utf-8?B?eHRENWdkZE9HLzhYbG1QQkY4TEEwTk5kbXh0YVBHQUEwejlKODBMbGc1RWVm?=
 =?utf-8?B?dzBiWFVsbDNuWVBueDFhWk1zaXF4V1BRSzk1WGFWajMrOTRkTjE2cmRJaVpa?=
 =?utf-8?B?S0lCZUVnTE9PZlJYK2VlejhrNEw4eUpXdWRYSVFSTHovMFU0UXUwa1J6eXp2?=
 =?utf-8?B?TUcvOE1Dd2taWjkxeDRoemRFTENBcThmYWIveGVSNExOTUw1aXMzS0YvVUFN?=
 =?utf-8?B?OTgrdE50SFRzTVZ6eTdsclU4KytpY1o1WFpySVhLZVRhR2VmN3YrbXFJTkts?=
 =?utf-8?B?QUlaNkFCTzJHLy93UStMM215TnVpSHk5MU4zR2NrTC9lK2R0YmRua0lSdFRa?=
 =?utf-8?B?NkhXVVlrUWdwMUJKNUJ2WWt2aFV4NFRwUHE3M2VCNndWMjBHT1JvdUIxVVNB?=
 =?utf-8?B?MDE0T2Q5cHRZUzIxaXplbDlFekNRK3ZyVS9RdWJ2M2tIeEZlcnJ2bU5zYjFO?=
 =?utf-8?B?bldxZ1VPcytQSW5pNDdoVGh2TStMSUh2akZ5NTlRaUE4QUEzNGc1U2ZpTWhw?=
 =?utf-8?B?WUpwS3RmZGVPRVYvL2FYR2hvRUVEQ3p3SFdKMlZmeTlsWDRwMXp0VUhieVli?=
 =?utf-8?B?WGdLZnhPeGI3aDBvMCtPNVFNWWorTWZIcFgrZGZFUlZVeWFhMWF0ZUxuNnlH?=
 =?utf-8?B?ejZFZm5rSU0wTmRpV0VBUjY2SDJuNHhWRkN6dUNPZzJubkVOQ1hHbXA1Ykth?=
 =?utf-8?B?UkEvZkM1YVZzQnozd3NwTHZjd3ZpWmZUZHJUNE53OEpvcVVIdHI5Yk9hb3cw?=
 =?utf-8?B?KzY3VTZ6QWVEQy82QmhmY0xLdTcyMU80VVZtalU3UVM5T08vdXlSSzFqWDYr?=
 =?utf-8?B?T2NCNEVpV1p6eDhCZHNTaWY5ak1zSWlxMGMzT3E3VURLVi91Zk5yZktpQ0dQ?=
 =?utf-8?B?OFJHUlBjYWVSeWZHOHRYUGtiMXZuRzZLRW91ZVVLcmc0OFVabkNXck5FVjRS?=
 =?utf-8?Q?BwlSU82wzntB4etxD74EySndjMCYGKJL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0JiZERPN2xySkdyLzUxNlJWTGxiRFQ3S2hocllZQ2tmQnhzTHVISFgxLzQw?=
 =?utf-8?B?NEpXWlJrZWV3N3BoZEJ1K0VvTmNwREJYZElhcnNQNS9PM3RYczlRTzc2S0t2?=
 =?utf-8?B?K0pjYkpxY2NtZkZRRUl6TStnUUNDNjd5Z1ppSERkMFNlMnBDWjJuMGo3RDE0?=
 =?utf-8?B?eHVKNkJPbXo1eDUxNUdieFFpN2VkaE5OVDFKSEhuc1Q1QUYrYk9GWFpxV28r?=
 =?utf-8?B?eTZzK0FvenA4b2FBdDhZbHN6VWk5bFhENFg0dkthUFJzdEtDSG5zRlNpOU9h?=
 =?utf-8?B?V3E0Nzk2UThzSVhmdWhDUUJYaHJlbGN0MTkwaEh2UUtuQ2JKV2x0dExWMGdX?=
 =?utf-8?B?UTdPSWtmbU10NTM0S0NHREc4TkdMRVMrQ3NUQjhicURGYnk4cUxlMXJCZ3h6?=
 =?utf-8?B?RWZvOGJoekhieFZ5UDBkTVZpQmtmNXNlamdSU212NWlRbkJSVWhhVzUzS1Vz?=
 =?utf-8?B?cVc5T01KZ2plaXpGajlnN3N6ZXExVHJFa2U1YXIrUzhHbHhSamJIWHZybVds?=
 =?utf-8?B?OHRFdUNrMlM1cTFjZzNBNjNHODkvNnlxa2toTDJjT0lDM3p4QlVNRW9TN0oz?=
 =?utf-8?B?cDNDOHZoN3EweDcwWEc1dG0wVDRncVU1UE5ad1hGTjFRaGpqdWpDUjRXQlh3?=
 =?utf-8?B?dE9DVGNZMGg5NkppQXdadkx1ejBtempMSGYxNktwWFlrNHpDU1FIQkE1c0Jw?=
 =?utf-8?B?SFJGNDROT3BrUmpYK2NHMmpQN2JING5iQjVXRTNNekV4RHhsSzJTc1hpVFZE?=
 =?utf-8?B?dldXVGxOeUh6NFpBNkcwSkJGRnZHSkdLK3NENE1aeFJZWU5pdXhjOTE5a2Fi?=
 =?utf-8?B?SXQrOEMxQ1hJUTVxRGZXMkR3bmJKWUVzclJQVDZVTFJOd2htNmEvcm5rUkhY?=
 =?utf-8?B?a1BseWwya3lzRGh6V09QbVFDWVNnRU1HSTA1T3FORG5HVTRXQkNNMFNvdFAx?=
 =?utf-8?B?VjRFaExRdVJWOUZVU3lsREdEL2YzN1RBNWZ5TEZTdUdTNHhhbmx3djZyMWdB?=
 =?utf-8?B?Ty9XcjBFeUdsNjd5OUIzSzB2em1lWCttbVF5eDZ5NEZvNm1ndktvSWFpdGx2?=
 =?utf-8?B?cU1BYTJzZzIzUUcwczRQbUVQNnBpdFQ0Mjlva3BNNFh4Y1JnOXFLejNGUnk4?=
 =?utf-8?B?MGYwUHVzUklaaUk1WEhnQjFaWFBlWE5LSmI2dS9OVENneTRzRVh2cTVNeGg4?=
 =?utf-8?B?c2tIWjl0QUJ0NlhQZW1QcjhTcGpIQ0xsOURKTXliYW9XNFRrOWtKbnJaTXhq?=
 =?utf-8?B?dU9OYnlNaldnUnc1ZzdDMmFDRU5aSDc0NWswM1R5ZDQyUW9RYlUwbFNRQ0ll?=
 =?utf-8?B?WjFlRThvaHNGWmpvT3JhS3pzVUVXc0pYT0lmRmlBM1pEcXE3ZFJMUGZCZkVu?=
 =?utf-8?B?VUozbFZrdXpXN3RpbUtSVURiYk9UWHI5RjMxYllQQW9pSDN2VzlKSlNNVWVy?=
 =?utf-8?B?dTQ1OWFCRTVEdFVIVEx3a2UxalRqd2RjL0JKYUp3U3FIWjhkbHJXZEg1aGVv?=
 =?utf-8?B?SUpoemh3UmI4SHM5d29NakQ5bmR0czQ2VlZ1d0FsdCt2UnlJK3hpQTRwVG1T?=
 =?utf-8?B?L0FkS2JLaUdILytVMDlzbmp5bU9JZ3JxQ3pRKzFWckhSQlhuSzcxQ1BweWdh?=
 =?utf-8?B?ek9jb1BLWjdlUjU4ZnBrendodi9HTExnMFpaMm1aNGxSVS9CaGllOWE4b04w?=
 =?utf-8?B?T2hydS9BdWlGQ0pxUWJyZjNyUFlvbGFXMEpUcWRUM3E3Q1Qvbkp5Ym12QnpT?=
 =?utf-8?B?MFNXSWRWcDdzdmFoUTd0Q005NDBGVjFFNXFwbjhwRlNCd0JFVFYrR2RCWDg4?=
 =?utf-8?B?VFhYYkFBWitaa1B0QXJZODR6RmRUMm5zanI2S3dHWTVlZmdyZVUxSFpkS3d0?=
 =?utf-8?B?a0VPMFJTaTZUWUJZb1JMd0ZkUVFyTUJFTkMySW5mc2srdGc1L3pNNTFhWDMw?=
 =?utf-8?B?WVBORWQ2THVjTXV3MUxRZVhQMUlyZVNpTVFzZndaaVBLYmJpMDRTRjBPNzNq?=
 =?utf-8?B?K04zQ2JqOERZOCtmMGVRbGV4UjVHTHVCdU9NVTdOa2FlRU5QZHBQUERWR3hS?=
 =?utf-8?B?NzN3a2RlNVA3bGxqMDAzTjFHdnFNNUd6Zjdhc1JRYVVvY093YUdmeElxU2JB?=
 =?utf-8?B?dTUzT09TcHZwSDdqT1R4SmU3cnAyQVkzSmJCTU15N1libVpramRPZmhzS0ZO?=
 =?utf-8?B?MUVzVnkydWJIUW10ZUx4dnVyQ2U5dmFrWjE1N0xIb1pjem1tZWg4VGVDTTVF?=
 =?utf-8?B?Y2VYcVNvcDFNNUdubFNDamVwQU5EYkxxMDZtRXVONzA2akpJTVdTb3NzTlVJ?=
 =?utf-8?B?dG1jejZZZTdiQ3ZXNkFtOVNvREs3S3JlK1BTR1ZocURKa01lVHFGZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fcGaiM8N0dOD1bcEUhWZTRkSXkglIcxQ61ahJ5q3Ex3L7vbdyhG0VVDBcVoHW3kwyzzAB/yB9UsdhmvNN3yf2YybHoYmd9SVzW9oE7qE76cnMERxJ7ufaYwP7lEoqnFE4Ze2SWMjEX4XiOHNYXW5yAovJas1RzO38yE4JXh4lDmYB8lNF+A+2/lqO8czFHIzohpsGm/VQHIThmo+wsc+3vZIeuSC1ry5mK/5oxpCfo30g07iZgc3rm0P+WUL+byrPun/RO/a5iQL4GFapD7dk7aIL1CDXOhxzonnqj6wFW7E6ybvYHBqCl1LEP1GXE4w9xT92t+w3+zaK89B2qiz9o0e+NUEnj+nDtzLShjAN4T7ZmCxXQbVXRTZgj+FzResTagtxbsuMMtkSNKkeFEF59eoIuXXSwWieBGD/Y6j5fp7oBOIa/uFF3pEaaHco3pAKgULczbwNRmzBoiKd4wjtTUs/YdJFQaFon55W/wB8lOxRgoyIjX+aRMk5qGrc8VxhpXPU/Sxq62usVTpdl6k8FcXogN1uDqrZD0Inxwwa4fw/G7ara1KXhcsjX+KEqQijoMMZkLDmyTTLeP+Kk5cVHMSerf4qYQvaC6MtuDF+sE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885a5603-5599-4c1e-a529-08de42055662
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFEDB06D67A.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 09:26:23.6646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YuQ1WreHkfhETRTYoFB/1w6o2en+MNQJ/rgoZp0BRDKyaQNvG3fBjQc8iM55LK3TvYylDjjRkJFBiasHSVnU6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997619
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_02,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=758
 spamscore=0 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2512230074
X-Proofpoint-ORIG-GUID: 4S2BeGWrzeFe-ELEG_hIif3ztC7mdjoq
X-Authority-Analysis: v=2.4 cv=cPXtc1eN c=1 sm=1 tr=0 ts=694a6042 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=TkuBN2Fti-PRllfk:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=MANbuCPxC39K0DyG3B0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12109
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDA3NSBTYWx0ZWRfX4u+aifrJI1Ib
 rH+N4OZ+TQMqqZfox9OtSsdh/doiBLe0OGsobGuTz4BeYqxYTRbvwWHmVi1945Ioq4gOqwebxyv
 0VV2ItvY1u5nRA1Md9dkMcZaQCdbsWsaccjwluyyr7kGx9EZsHRcDPuDzp1PNcJWzcnuSC+2d1A
 IhpaHfxmoWcvozvbCELkDJ1sq2FizQtpATVZqpqvuBVTejFA4VW+ai/TwTYnzs+EQ5QBm4lXEdZ
 r7e4UhRCAEErr64harByB3DoRBtbUlUMkdSrx2fZYD+UPRzLUqTWTsTv0vl/dnubbrmlG7roH4V
 bPpdLrbN1OA7Z00lhmSwyEC3aRlJ85p8ggDwSlLNCwX7p0K1WWEdMxlNb36hIKMtpXRUazq1Dan
 Flk1w1WDV2LDDp0b9ZecfR3nUI0aTwCAuAB04IX4nsfNiEScoeFLiMCqBy0XuLMdkVyI46XHAJY
 9+7pHXCU30k8AlXQV373HR/00bdGxAlRjeO2uZhI=
X-Proofpoint-GUID: 4S2BeGWrzeFe-ELEG_hIif3ztC7mdjoq

On 22/12/2025 13:28, Vitaliy Filippov wrote:
> Hi linux-fsdevel,
> I recently discovered that Linux incorrectly requires all atomic
> writes to have 2^N length and to be aligned on the length boundary.
> This requirement contradicts NVMe specification which doesn't require
> such alignment and length and thus highly restricts usage of atomic
> writes with NVMe disks which support it (Micron and Kioxia).

All these alignment and size rules are specific to using RWF_ATOMIC. You 
don't have to use RWF_ATOMIC if you don't want to - as you prob know, 
atomic writes are implicit on NVMe.

> NVMe specification has its own atomic write restrictions - AWUPF and
> NABSPF/NABO, but both are already checked by the nvme subsystem.
> The 2^N restriction comes from generic_atomic_write_valid().
> I submitted a patch which removes this restriction to linux-block and
> linux-nvme. Sorry if these maillists weren't the right place to send
> it to, it's my first patch :).
> But the function is currently used in 3 places: block/fops.c,
> fs/ext4/file.c and fs/xfs/xfs_file.c.
> Can you tell me if ext4 and xfs really want atomic writes to be 2^N
> sized and length-aligned?

As above, this is just the kernel atomic write rules to support using 
different storage technologies.

>  From looking at the code I'd say they don't really require it?
> Can you approve my patch if I'm right? Please :-)
> 
> On Mon, Dec 22, 2025 at 12:54 PM Vitaliy Filippov <vitalifster@gmail.com> wrote:
>>
>> Hi! Thanks a lot for your reply! This is actually my first patch ever
>> so please don't blame me for not following some standards, I'll try to
>> resubmit it correctly.
>>
>> Regarding the rest:
>>
>> 1) NVMe atomic boundaries seem to already be checked in
>> nvme_valid_atomic_write().
>>
>> 2) What's atomic_write_hw_unit_max? As I understand, Linux also
>> already checks it, at least
>> /sys/block/nvme**/queue/atomic_write_max_bytes is already limited by
>> max_hw_sectors_kb.
>>
>> 3) Yes, I've of course seen that this function is also used by ext4
>> and xfs, but I don't understand the motivation behind the 2^n
>> requirement. I suppose file systems may fragment the write according
>> to currently allocated extents for example, but I don't see how issues
>> coming from this can be fixed by requiring writes to be 2^n.
>>
>> But I understand that just removing the check may break something if
>> somebody relies on them. What do you think about removing the
>> requirement only for NVMe or only for block devices then? I see 3 ways
>> to do it:
>> a) split generic_atomic_write_valid() into two functions - first for
>> all types of inodes and second only for file systems.
>> b) remove generic_atomic_write_valid() from block device checks at all.
>> c) change generic_atomic_write_valid() just like in my original patch
>> but copy original checks into other places where it's used (ext4 and
>> xfs).
>>
>> Which way do you think would be the best?
>>
>> On Mon, Dec 22, 2025 at 2:17 AM Keith Busch <kbusch@kernel.org> wrote:
>>>
>>> On Sun, Dec 21, 2025 at 04:24:02PM +0300, Vitaliy Filippov wrote:
>>>> It contradicts NVMe specification where alignment is only required when atomic
>>>> write boundary (NABSPF/NABO) is set and highly limits usage of NVMe atomic writes
>>>
>>> Commit header is missing the "fs:" prefix, and the commit log should
>>> wrap at 72 characters.
>>>
>>> On the techincal side, this is a generic function used by multiple
>>> protocols, so you can't just appeal to NVMe to justify removing the
>>> checks.
>>>
>>> NVMe still has atomic boundaries where straddling it fails to be an
>>> atomic operation. Instead of removing the checks, you'd have to replace
>>> it with a more costly operation if you really want to support more
>>> arbitrary write lengths and offsets. And if you do manage to remove the
>>> power of two requirement, then the queue limit for nvme's
>>> atomic_write_hw_unit_max isn't correct anymore.
> 


