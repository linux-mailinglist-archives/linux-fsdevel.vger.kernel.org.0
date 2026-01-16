Return-Path: <linux-fsdevel+bounces-74031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F81D29C45
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 02:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4EA8F300CF3A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 01:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE98E33554E;
	Fri, 16 Jan 2026 01:54:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020099.outbound.protection.outlook.com [52.101.196.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEBA2E7165;
	Fri, 16 Jan 2026 01:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768528443; cv=fail; b=snO3yzC6sQsil1qfUUDCBKLmM77XOBoBfM9bmrelyVAzAq/y1PA8usOst1OCKf4wmkeD3Ig3HQJ3OpwE4SiajSLU+oFAORzG6VwSsfeuJEYa+J6yqk1w/l3aHrbgTTJLMS1rpFboQA5ddnwRhlgPI2IcjWkzF2L/Zw2i5yWZuRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768528443; c=relaxed/simple;
	bh=/pzT0CfmqZnXZ25ZbLVtwTI6R3qoMUQmc+xiB3FtiRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KDsOfWG5vDDBT3jCxpifn6ylpfRJORp0Nb430CVQBTm6lSAVbJa2jWI+SpOX/pfjEc3TzyiWv6u9/vSurnkRDFoOzn6eBTQwtE3oCIyAFs6Oko+/3Tn9ItitlKA58Zs/MOfZbbEAHgwAXQF6itI++sBsbnt0hQBgy9z3KN4gBjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8278TelKurnf3F2Iru3ZBGHY1N9kM0bFxj3ubx1yAt7IkzbKztqEZH5uVyBNTrKo9VXpd3TECw6Q4gEuFiUkyGbmdIgsO2N2osJRRJlr7KhN0nE5CjyEFhfNquPoS+riA40VilEjRTDvhbKt6Bs0lPfvUAaqOO8ZsbI5z7HuchyeR4GD5J1cL20M+LQgvn2pIstVmjCcvJEv1+7Uh3DBeUe9PWU29caNgshpeP8kcfIQALZBwYxrAxJPZZ1HwUEFdJmm3JbYwaUtF/j1yg8xwvPxH9GJnhb3mAh22whnz6P8lruHMwaTZUM2lAC59yRM2FPQTMrxe4Gvnx0GX3qBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVHXNW0JOU7IRaawKu1fqrSVND3H61+XQ/2b0lFurME=;
 b=JyXnT9XflrYImd2eJfnIWxb7RpNhJXdVBv4gHnUT/H7eLk2TfevHpUIYwYul1x+jbMWo9MiYbuZSIVKBLFf4rNTTMGoRYEaOZj81ELmRIjTEnCy+1jO9X7HSq1eAxl2k5EOJifd/TX6WO4PAATNiDSXZtfGOR3m2BH4Oa/TBuAxM2qGJrwvRZhBCeaRfc2IYVpC84M/5Ga4NCaE0+XsqzzGYuJnyI9DOYClUid44uWAOgMwhN6kwnqtIHpD/1B0e+0bbZrr7RqydtHtVUIdpSTTos1/ZOFzXE+tyxMy79Ll+2u6ZSoXMbHKMRlLSP8ZEcULp7j73atIa/+5FkLsG5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CW1P123MB7713.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:245::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 01:53:57 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9520.003; Fri, 16 Jan 2026
 01:53:56 +0000
Date: Thu, 15 Jan 2026 20:53:48 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>, oleg@redhat.com, 
	akpm@linux-foundation.org, gregkh@linuxfoundation.org, brauner@kernel.org, mingo@kernel.org, 
	neelx@suse.com, sean@ashe.io, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, riel@surriel.com, 
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [v3 PATCH 1/1] fs/proc: Expose mm_cpumask in /proc/[pid]/status
Message-ID: <zkl42ttlzuyidy2ner5sjfbg5b62l5mcmlcmardd534y2p2u2q@vz2w4nbwvbhf>
References: <20260115205407.3050262-1-atomlin@atomlin.com>
 <20260115205407.3050262-2-atomlin@atomlin.com>
 <4a1c24ae-29b0-4c3e-a055-789edfed32fc@kernel.org>
 <6531da5d-aa50-4119-b42e-3c22dc410671@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vzaj2oylpzhvsr5q"
Content-Disposition: inline
In-Reply-To: <6531da5d-aa50-4119-b42e-3c22dc410671@intel.com>
X-ClientProxiedBy: BN9P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::34) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CW1P123MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: de9658e8-d363-425a-94dd-08de54a21984
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVgwVTRZdDNpbDIyZEE1Zm1WZlZUMjBUcUJ5bWRMSDRiTE0wR3d6OVZtYWxl?=
 =?utf-8?B?VkExaDRZcWtxU3AxZ0NFTmlucnFGTXRydXg5bThuN1NudUxFeWYweWpnUE1h?=
 =?utf-8?B?ZVRDWm5ZZ0RGME8rSCt2UzZTRitENUJ1OXVDb1ZhZVI4YzgwZFZtcFdvR0FQ?=
 =?utf-8?B?TGYreXJRMmRCVEcrMVdvZW1BK0VyRTFwWlgrS1g0RkxMNSs2NGNNNkpMTFNW?=
 =?utf-8?B?eXRua0VDQ1E4cndFTlNMR0cwd283anljUldqeWlxZTExQTRQUFRQMmlISHZU?=
 =?utf-8?B?S215dTJENDZ4dUpldWpFOXQ5OGdYRnZzUTBKS05sY2tRaWRIVjNkZFNJRFZy?=
 =?utf-8?B?U0NHZThQM01TUndTdzBsTWVwMTRISFRTMDlUOVJkSTMwV2hFa3hjVGJqSFFX?=
 =?utf-8?B?cGZoeVdLZG9raXdaRFUwRy9Xb0I4UHJTYktqYnJxVUZFMWErL3BzM0Y3cDZT?=
 =?utf-8?B?QVZiSnM0T0xaYmV0V3MrMXFreGNzdUNCVkk1d2VQV0VVTXljbmdDWE5TM2Zm?=
 =?utf-8?B?RXNON3lqOHZSNHptVDNLS0s3ZmdVMGFma0kvTFdQUjNYdVFkZ241d0FQTGlN?=
 =?utf-8?B?NklleTBIM01NZjNwSFNIb2FxSDRaZGNXN0t1ZjN3ajcvMzM2NlY3TXB2OXNq?=
 =?utf-8?B?bGFtdDJ5RVBUMG04ZDBYQnFYU2pnNHJSdmhMUFZnYTc0RVFHbzlobURSN203?=
 =?utf-8?B?Y0RocUtMcHdkK05uQmpMVHoxb1lWODZvL0JiWkxjSzVrVDBCVW9rK0NlU1hP?=
 =?utf-8?B?ZEJHN0tqRndsYndlK3BhMkFjRlgvN1Q1SnJFekRSZ25uS3hmSXVXUG8zd1BE?=
 =?utf-8?B?S0pBNlM0VzVqV3NNNWxwR1p4bEZEd1QvQXZKcTNTaFhCYk9mcVVGK0laNm43?=
 =?utf-8?B?Wkl1UjNBQjRmcnJCL3piVnhHTnVTM01ZRmU5TU1sZTA2N2tPaVUvSmdKeUIv?=
 =?utf-8?B?WVJ1RysxQng2RllSTkg1SjRvaTJ2d3lxS0dOZm5uenlUKzN1YnUxc3dLeVNq?=
 =?utf-8?B?U0FmUW1GRUV0Z1VZbXZydXNtMlBQRkx3b016T3dVZUhmbDh0NUtzMzdCbjZs?=
 =?utf-8?B?aUx0ejl6a1B0bmJOWDBRQTNwMGQ3djZIOFArdmlsYldNa1JMcDhPZkMwN0VK?=
 =?utf-8?B?bFVuMWFVRzJUbjE4VFhyMVg2QzJ5MHZhQmkyN1B2eDZDQWNjZjMremhjTG5t?=
 =?utf-8?B?eUlLb2JidWdTdHNXUzhhWmhiamFTVHRxU2lBQ2c3VEdVWG4yakhOZ0pGaEh3?=
 =?utf-8?B?VVdpdTNKR25tSWl1ejFPV1diK2twc1VnMlZQdXdibTFsYmN3UzllZ2JHbXBr?=
 =?utf-8?B?Wld6QndnOStjc0ZzWHZYczNZWDE1V1JnSWRuREJtV0Q4SnFnN3Y2MlJBUjBK?=
 =?utf-8?B?QVJPQjdCVkF1ODZ2endpVHJVYXRPaSsrb01vaEZjU01lV3NMcG5QYmJodW82?=
 =?utf-8?B?dTFBU2I0aktla1diWDlyWUpidGVqRFp4SmVnZ3BkdTFpQkhQQU9DZ0ZsbnJZ?=
 =?utf-8?B?aGxyS05CeW9xSXQ4UTdXcGo5WGZvV0poTXVqVkw4SVNhL2U1bkpxRVdmN05x?=
 =?utf-8?B?RW9kOUpzWG1OR2VXTWFyT3dmUzhZaU1NaCtSOWhKQy9xZVFId29wQ2Q2QlRG?=
 =?utf-8?B?YjJqMFh6aDAvOW10NEhKbUtlakFRVmw5UUcvT1FHWThtVUpnQjVtc0JIRktv?=
 =?utf-8?B?ZUtPMysxWTRDL3B0eTJNZmtlZW9zbTJ2a3lkNXl2TVRaSmMvd0RoRVZmV09o?=
 =?utf-8?B?VS9SSTRRV09RNXFBN3p5cElVbWdrR0VyUDFSdXN1WlNkUkJvMWw5THo4WFJ0?=
 =?utf-8?B?TklEd0ZDRENxUHNRMEJnd2R1d1Q5MTE1ZHVPRWFxajFrcXo5djFpazRjaWlH?=
 =?utf-8?B?RUNQS2ZyRnIzQ2U3Q1ptbEZSM3gvRHFRWUNuNEhib2lPeEpKN1pjdkhnblll?=
 =?utf-8?B?elRlbVQyNGs0blRhOFZ5SVl6VE12NDlRRzI0MXQ2Y21YbkdMcG1EVDc3ZFlm?=
 =?utf-8?B?QVE5NEhNeTRSUzd0MENzaFBvc1I1M2QwelNuaG9FR0lQd2lXbm9ndHNIOCtU?=
 =?utf-8?B?MjFSSWhqb3Z4UDFmYWV1RzBYMkNEZlQ2Z2lBZE52YjliUmtob3dTSTcxa1dZ?=
 =?utf-8?Q?qw/A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzVsNW1McVpsdmJpVXFLTnVkWXpDSjNxZVBvZHhlRkhSbHhDNUlaZGorOVRh?=
 =?utf-8?B?TldtNGNUeUNQamdYL2taNll4MzM3cDNXNXdxeXI1L3Y3WllHNFFnKzVPVXli?=
 =?utf-8?B?SW5RcWVOLzFQbnlpdmtORU1sdlpxOEh0aDVwT2RmMjA0VGcrSlUyUE1lN0JS?=
 =?utf-8?B?aklpYi9VeC9TbTNFenBleFFoa3dLa1ZVampVZHAycXNCL0FvUS9UVVlENWN0?=
 =?utf-8?B?ZGJTa2ZMNTdvaDVYK3FSVkVvaUxNRnp3bk8rZWNwanNhOG5SNCtsL2xBbDc4?=
 =?utf-8?B?QmptVytuN2Iyck1kckgvcVE4ZmpBQU14WWo4K3FYRXVVYXJEcEdjTWFyT3Zo?=
 =?utf-8?B?aHFpOEMyZ1ZvN3NTN0Q3dFlJNTRWVE8xeTVPRnFZTHBvUlJSNzVyQlRMWkEx?=
 =?utf-8?B?MmtVR2svVzErTzZFVjlpbmZ5b1RLN0tEeGROODF3TjMxWEM3aE13bjF1b2pJ?=
 =?utf-8?B?dVk3UFRUa1BpZW1MSnRqdDV3UU9rbnJIVVAvdkRoSlBLTFRTanZ6QktiNkJp?=
 =?utf-8?B?OExJZEZudWhhUU5ybHdWNEdUais5TTlZbmZtN1A3QUtGcU1oeTFqVEYrYllt?=
 =?utf-8?B?ZWhVS0hzTXVmamFOanZKQVFiWUxPRUVhMEVHcFJVZmpDZE1iTTJGYStQakFr?=
 =?utf-8?B?cnVjT241dU8weitCanZ1QWJwSVVNUzZ1RmxUSjBlZitCTElqa3pMQ1dhZXlx?=
 =?utf-8?B?S25INm42RE9lc1NjY0htNnhMektoNlhBbTZWbzU4N3gwVlRmdEpGYW1tUS9J?=
 =?utf-8?B?SklWMWJ4V0YxSTMxZVZORGpsakJ0KzVRVktMMlNsRElNUndmaDhmMUh6b1Rs?=
 =?utf-8?B?dXdOOS9NNzlNR1pXdjRMVG85WnVkeW5WY214V2YvZlhiSTlLcTJXSVMxZytV?=
 =?utf-8?B?dEU3TlNiUnVad0xFL2ord3N3bkZpVTBna3dEamlrUjQ2Uy96cHBOOTgxUEZE?=
 =?utf-8?B?OGlwZ0JDSkc1K1BuZURrU3YxR01RN3BrNVpPMkhINUp0Q3Blbk1PMytBMzdR?=
 =?utf-8?B?NkxCZzg4SUx3Z0l3OUNudkljUFBZWWFaZlBmMG9TSjExblhHWTNNa1EvaUhr?=
 =?utf-8?B?YldjZzBabG0zZDlMNk0vMDk5cnZDT0VTZFZRYzVsejJvSU41cWRyUTNiQmJp?=
 =?utf-8?B?aDdqZlhZMjVDN2VEYTVpS3BSbE9xRXpqSWdRc3JLSk8wZGZ6STBVa0JicFgz?=
 =?utf-8?B?WHFoclltYUY3OVNPRzM2WjV3OXBRQ0drc1NQZzhQTzd4VE0yS21CR3EyV3VX?=
 =?utf-8?B?cFMrM3U1eFNpRXE0VFpoUW9qeUlmWC9mN1IzV051d09Fb3VTV3I3Y1ZFNFps?=
 =?utf-8?B?R3kwMm04MWJYU05veGxTRkhXSEhERjBNMTJ6eTBvQWVNKzArb1BYczVvRzJa?=
 =?utf-8?B?bzY4bEU5NENyMU5NWVdodVp3NTA3cEErVER5dnhYMEZjbHZFV2dCbGxqM0xs?=
 =?utf-8?B?RmZMRFpjcXEzWU85enhaWEluclhyelFjWFA5dVJEOUEyckQ3Z0U4VXo1RmZK?=
 =?utf-8?B?SFFHNTNQNU9aQndQSENpdDk0NXBXYXFQd2FUWjVqVUVPTkF2L3hFQ2JJUmFN?=
 =?utf-8?B?Zm94NDZaWlBiRlJsNGx3R0luMjRLaUdQMFZ6RjdydXFGZmluSXkzd2J0VzNl?=
 =?utf-8?B?clJMQUUyR0RzNEU3TllvSzRwbUxSbW8vNzNjdWJVQ05ZakVHM0xqNzlJdjJY?=
 =?utf-8?B?Z00vb3MwMTVGN0EyL2sxVnFkbGVXSFloamticFZNaUZHaFVQSHVDank2SE5X?=
 =?utf-8?B?TlZya0VReDJpWDJyYmtWaHo4ZzJ1dTJlZGczMTBiQm1ENXhZS0pXTVBNRXFz?=
 =?utf-8?B?NGpVZFZ0UUF1R001NUJUTEJ5ZncwWFhFV2NWbURCYmlHNmZpWkVTT1VkYjgz?=
 =?utf-8?B?V1VUOUZEN2RiYXJDR1JFWHlsZStaOWJlVXl2YndaWS9wYmhnSTJpL0tPMnpv?=
 =?utf-8?B?V3B4eWJMcWdNWEc5WEhzQnlocTlVemNueExmanlTd3pDSERyMGl4eFdLOGQv?=
 =?utf-8?B?UkRaRWdpYUNObmUwSXl4VndJNXRPd1RDSG9ZcnBraGRhRWhWbkt6dWY0UjUv?=
 =?utf-8?B?Y2gwY0FVNkFzOWIza0VDcjR2eHZoKzdtbzlGcmhmV3IwT2FlRFdaVE81TFBQ?=
 =?utf-8?B?czlBb2I1TXFtVFkyNE5YOTZxVlZobTV3RWFQdUtad0VaWXVqQi9YY0NxWkFk?=
 =?utf-8?B?NFBNYTFQQnY3Nm5LYStjUy90SUk3U3lOVmQ3QmlJZGVkdXFlUzFMQlpCT3Jp?=
 =?utf-8?B?QTRmVWw1QXVZd1I4cGhKNHZQdGo4d2VhZVJ2YzM5S3kzQVRLbElmRjd6WG1Z?=
 =?utf-8?B?eXhaK1UzTjBSNzhnM2lheWRRbnhucHRDaEtOUnh4b2g4Mklha2MyUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de9658e8-d363-425a-94dd-08de54a21984
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 01:53:56.6561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0GjBw/G+SbZPJbogpkZxiG1WMANI9h+Ic/nnx7dtVvTB9jQz5m3jXfl7+wWiO58DmaX9a7g3nVnd55aRDoCsrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB7713

--vzaj2oylpzhvsr5q
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [v3 PATCH 1/1] fs/proc: Expose mm_cpumask in /proc/[pid]/status
MIME-Version: 1.0

On Thu, Jan 15, 2026 at 01:39:27PM -0800, Dave Hansen wrote:
> I don't think this is the kind of thing we want to expose as ABI. It's
> too deep of an implementation detail. Any meaning derived from it could
> also change on a whim.
>=20
> For instance, we've changed the rules about when CPUs are put in or
> taken out of mm_cpumask() over time. I think the rules might have even
> depended on the idle driver that your system was using at one time. I
> think Rik also just changed some rules around it in his INVLPGB patches.
>=20
> I'm not denying how valuable this kind of information might be. I just
> don't think it's generally useful enough to justify an ABI that we need
> to maintain forever. Tracing seems like a much more appropriate way to
> get the data you are after than new ABI.
>=20
> Can you get the info that you're after with kprobes? Or new tracepoints?

Hi Dave and Peter,

I fully appreciate your concern regarding the exposure of deep
implementation details as stable ABI. I understand that the semantics of
mm_cpumask are fluid. I certainly do not wish to ossify internal logic.

While the static tracepoint trace_tlb_flush is available, the primary
argument for exposing this via /proc/[pid]/status is one of immediacy and
the lack of external dependencies. Having an instantaneous snapshot
available without requiring e.g., Ftrace or eBPF, is invaluable for quick
diagnostic checks in production environments.

Based on my reading of arch/x86/mm/tlb.c, the lifecycle of each bit in
mm_cpumask appears to follow this logic:

    1. Schedule on (switch_mm): Bit set.
    2. Schedule off: Bit remains set (CPU enters "Lazy" mode).
    3. Remote TLB Flush (IPI):
       - If Running: Flush TLB, bit remains set.
       - If lazy (leave_mm): Switch to init_mm, bit clearing is deferred.
       - If stale (mm !=3D loaded_mm): bit is cleared immediately
         (effectively the second IPI for a CPU that was previously lazy).

Would you be amenable to this exposure if it were guarded behind a specific
CONFIG_DEBUG option (e.g., CONFIG_DEBUG_MM_CPUMASK_INFO)? This would
clearly mark it as a diagnostic aid for debugging, allowing educated users
to opt-in to the visibility without implying a permanent guarantee of
semantic stability for general userspace applications.

Please let me know your thoughts. Thank you.


Kind regards,
--=20
Aaron Tomlin

--vzaj2oylpzhvsr5q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmlpmicACgkQ4t6WWBnM
d9bZPA/+PshDBvX0sbkGQ2/Zo9ljwSDUUPCnlpTBLdUUKWqLIF12s1pwuvvfDHff
EBE4ZS2sTSlItE6ayFaFlXC5MfOzkIGYTeqLEsb88vAjcGbKadig0QMzpanNkJ2m
eXtzUl2OH+YBOMEVRn4WngH+1E688aG5IY9W6NHvwRqh/AIQHowDmxFs3G0w2FYy
zkUj18/ezF5uUgSwiLEOctm3vbdajig7+tDpae251fwa5+SwMGwfXKDNOI0UZtTt
t1n5PbridWcUSnSd4N8RiDWAwtONy7XzXrzDAWedNpKJjm+i9Z5BqhbljVvYBBHO
RNyEBQ6evoirvdUHAqRWJfpGRfHxvwQBxNrLceRlWku3aAwUjvaoO9BoSTXzam64
PfhUe8tZ/Iujgu/PyDiS+l/dNladal8elsZ3f14EOGq1kc3n8xrfENkgBOJATga/
5q3Yot57VDl5t7rgVarDshNx5mAdjW5RztENPOFUAEibvS+2eLB/qciVPuG5u4X3
lskulveWA6lEUtPgN4Dq9zWC+vPIjfp2Hx16ePItu+dlYJN3/KaWhDH6KWZuKFG+
Ebrb7OMrIKYS2Y1w7+c6aiVAOWx4S8lBCeLfT7CbiZyfSZak0+t1OnCv+AvRKGzY
Gsu8mi/Ba79P0/XGpyIH560bPquMXeXN8zQ81l8VkC2gFgC9te4=
=a16z
-----END PGP SIGNATURE-----

--vzaj2oylpzhvsr5q--

