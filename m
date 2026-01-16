Return-Path: <linux-fsdevel+bounces-74172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4B1D33462
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 16:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 58D9C3007C11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937C933A9EB;
	Fri, 16 Jan 2026 15:42:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021073.outbound.protection.outlook.com [52.101.100.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCDF33A9EF;
	Fri, 16 Jan 2026 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768578156; cv=fail; b=mrM/8j5qf1IRZ57gteqAxFmuY78N7YlogzkEh8ygQOHb1M1MdOn4lEFAznlIsHIpdIqYdMHnF9Yy96ckGOZLl/QqIdofQqyX90rfB92ekzLqg1OyW7BdSuw2eKdWd6CKFk8dlQB9b+T/XbDh/UK21zTDXc5YUZEd7PbznQLSTGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768578156; c=relaxed/simple;
	bh=NSv98hDIOwDK0sd7HDmY7iYOZLxtRJWW+M9fBRgLRx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pu8LVuHXyIkrneMBsWtfB+SNFSucZ1D+ra5CbKqELRPd2irZJWTkbppww2EemfD7vcjypgQjEUeXW+qapZ1w/M/zAIANhOYWHJoGStw+bCDsBK2AXHOSTecDydepUEuWcN/gMKVmVIXmkt5vN33eauPtHRyhCzgHatnXM5a0FW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3h4ZjNSTS+K5sTvalwcdUm55v2dp53SuQYrVd+DT+PMIJ7xdu74n8GFaBb+kXQipGJurO7QG/xODSx+nM8mSco3UR6r83O5dplDvPC3V38sCzHOZ5fhJDBwNke+sIBnZMKJTzUPJis+jM3AJHfGZn5I2tPj0EPO05g4dNGUD57B7X75ZmvlEHqZTccx9L+yA3DcgV5JGCo5GEB9KWaCbtbII4brQrI6Dzfl6RfUstli7oKZbPQyC+BzpsC94YrS1PyI4vMOKe6LuA4QLafbS6aEbe8daaVD+r6hjfCy0pTOJ9gBvw59bwOWi8lrRXMSQWdvFFYMmIvCCOkWL+DUxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSv98hDIOwDK0sd7HDmY7iYOZLxtRJWW+M9fBRgLRx8=;
 b=L8H3f9GgdcKWB5tvEcMI+oobcK1Pe9I1mwQXxuM5yVnYHcjatbOob5JynXqCSIV1WZbv88w7eOoJv9r7gXoBPJI3NGpIAmyC38TwWyY/CG4T9i15MkEJH5WT5/T8s3OHWsyuBxOuyjfPeu8fn22vsXy11CoimKPOvJrNrDDLXAiz5efFoTKk2pZgpcByN3mW7RZDJ7lXzP9j+4D7cv5wb9iL6y4G9wUN0q8NFxYX88/Vywz13KFX4yOTduGs9ZtLDESkEgu9s0PoXEP0di8BU/csQnse9sNGa2l7PzJaECtyIRDCEmnS9boXta30pwX6SCsRvu8mqaIodhaY+i7A9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO3P123MB3180.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 15:42:30 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 15:42:30 +0000
Date: Fri, 16 Jan 2026 10:42:24 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>, oleg@redhat.com, 
	akpm@linux-foundation.org, gregkh@linuxfoundation.org, brauner@kernel.org, mingo@kernel.org, 
	neelx@suse.com, sean@ashe.io, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, riel@surriel.com, 
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [v3 PATCH 1/1] fs/proc: Expose mm_cpumask in /proc/[pid]/status
Message-ID: <bzqdl7cpihvhmqpb64od36wvu6xihyy6l3ooj66d6xcmrgmyii@v6hob4ek3rct>
References: <20260115205407.3050262-1-atomlin@atomlin.com>
 <20260115205407.3050262-2-atomlin@atomlin.com>
 <4a1c24ae-29b0-4c3e-a055-789edfed32fc@kernel.org>
 <6531da5d-aa50-4119-b42e-3c22dc410671@intel.com>
 <zkl42ttlzuyidy2ner5sjfbg5b62l5mcmlcmardd534y2p2u2q@vz2w4nbwvbhf>
 <8111b8c6-737e-4b6f-a8d1-3710e60280e2@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e3yqddyduxpvw4i7"
Content-Disposition: inline
In-Reply-To: <8111b8c6-737e-4b6f-a8d1-3710e60280e2@intel.com>
X-ClientProxiedBy: PH8P222CA0005.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::23) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO3P123MB3180:EE_
X-MS-Office365-Filtering-Correlation-Id: 76dd118e-6597-4713-e074-08de5515db6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amozdlNvREp2OXJDWHR5enhTS1VOd2JTYzRpQ1BhZkpRS1Zqdnl0OHNCVnJm?=
 =?utf-8?B?VmxLbFBVSDBqdEhrenJLRDNUakExYzJxM0V6U0xzNnVTTngybGhiQlVXQWFV?=
 =?utf-8?B?VXI1ZXVid3hROU9BclBiekw2ckQzdEdMbGNzNVc0ZVZnVmZnSWJ1Z2FNYlhV?=
 =?utf-8?B?aE10SW9LcURrUkExS2xBdjRqNXVubk1BQjZXZU5RT2NMSWZESkhETDF5YzlH?=
 =?utf-8?B?WllmUUE1QmxHNm5kRGRzak5zMlpjUzdDaDRLNFV2OVk1eEdwZjlOQ0RiOHlS?=
 =?utf-8?B?ZVg1Q1AvL3FkQW9OSWZsRURONk11c0cyRjdSSW5GQy95cDI5akZVMkNDeExq?=
 =?utf-8?B?eldHRW5yRnlkM0ZGbitzUkNmYTZWNFdodFBkcVhsYkw3ZytRZS8xQWg1cGZv?=
 =?utf-8?B?UVFVVFJyWTVBdUlMRGtIY0d3aDhkVzNZYjNaZEtnam5vb2hZMjBEY083ZWhs?=
 =?utf-8?B?aVllUDJmMCtINmJIOXNGN2dMVUIzdlVCRE9hZ25NTVlSUmdVZU55aXJnTW5x?=
 =?utf-8?B?UEMxaHBGSE1HTjMwU1ZkM0RzQ25SYWI2ODNIOWN1RU1wSllmdWZsSC8za3Az?=
 =?utf-8?B?ODN6dWd6bGs5a1BGV1VUWUNyYU5hUEo4dDgvUzlpSzlMNmtDZ1FNOU1lMitW?=
 =?utf-8?B?TmlSMnRuSzhodlR4MzhPZ0tQUVFyY2p1M3RHQ3B2T0Z0dFI3UUdoTTEycDNm?=
 =?utf-8?B?QVUzeEVLeUZLamIycDM4bXFRR3l6cjlteDRIVnJiVGFXNFd6bTR0T3I5RGVN?=
 =?utf-8?B?UFhROXV6NmpweDNOcGtPQ3NDQ3RvajNjbHdLMWxhMFA3Zml3Vy9SYkhlZnRn?=
 =?utf-8?B?Y2dZSmtrem15Ri83QWEvNkRkUkI2QStXYWFOcGNwSXJQbUZuUHRLL0lJRW5t?=
 =?utf-8?B?clp5UFpmN2lMOFFLWDVHZE93bWQyTmo0L3J4VmJwVXZLU0sxMzg1aEVZZCsv?=
 =?utf-8?B?ODM1YXlyZkI1R2xjRDM0R0Fpd2hWaGlpOEg4VVVqdHhoNWVucTBJYWVpdjF2?=
 =?utf-8?B?NFNlQU9Ma29rbGpaUXpncVYxV04yNGc5SXBnYjJKUzd6cStOTFd2NmhhUUd1?=
 =?utf-8?B?KzU5SC81UWlUbGFaaFkxb0UwVHVOWGhxU1d6Ukp2dXFyS250bEN3TVVISldq?=
 =?utf-8?B?cVljWnBNQzNYcGN5VkpwU1MzK0krOXpqQmtsbWpITmlkU0Njc0c0V25JN2U2?=
 =?utf-8?B?QUNRMzJSWkNOMEJvRkY2bFpnRWNGa21kcGQwUHpWQVBEckIzQ3NnN2xZMjR6?=
 =?utf-8?B?enBuamVCblArSkp3Tnh5UEVBanZsZWR5QWU3STQzeng3VGJmUm9oSUx1QktN?=
 =?utf-8?B?bVVEdFdlakJ0eXFaVk14UWtOa2Job2NHNGhNZEVVNFByLzRJaFl1bWtINzlK?=
 =?utf-8?B?cTNaOW8zbHYzOWVzcVFQbGxDNU5XUHpFcmFsWkdON0VXMll0R2YvZjNFekdv?=
 =?utf-8?B?NDBLYWpCY1hEdGFCckZZNnNQVzBFMFdYbFJUQ0ZQMVlyLzl6SHhzS042SHR3?=
 =?utf-8?B?NmR0c1pMRTdKYkIxcExYeWg0bXBUVi9yK3Z6VDFhSlRKekZpbHR5RWgvMXdm?=
 =?utf-8?B?YUNqaU9LRk1MLzVLNmw4V1VQd1NHMitHWnVRZnlldXdLREd6UTNqY05vdmZZ?=
 =?utf-8?B?eThXTXk1dzFaS2p5NzYrdmN0VlIzYVR0QlhZTGlqc3BNdTFuQXFPY1R0c25X?=
 =?utf-8?B?cUpDdUhUZlQxWXZ3MUVCcVhKNU41RTJ3K2prWVByVDBYOXR5dVY4eXMvUWlK?=
 =?utf-8?B?WlVVM1hGVnk3WGxyU0RpMDIwcFVGbzhrREVFaVNWb0I2eE5TeDFpc096dVNS?=
 =?utf-8?B?N0NqK3czYmVGWloxcjIyN0JjRHZudHZwajZldThIUkR3Z2JxQXdTTldocTZZ?=
 =?utf-8?B?ZnN6YlM2V1k4SWFLalJEZUZLbHhybXk3MVlZeXBveVRzYXQrMGxKQWU4Smox?=
 =?utf-8?B?NURCTHdkMHlQbVZYZld5Ym4zdjhJMXc3M3pUQTRhSHFPNWt0VlZ1cTkrT29P?=
 =?utf-8?B?T1lkREJwMHBqSU5JTnRGZlMwcWlLNjN1a0FoemZ5N2VxcGRyK1ZjWitJWm1k?=
 =?utf-8?B?N09VVDRpV3pBaUo2UXExSkZOUVI0R0NxSDRNWkZFc3o5VURwQnYvYmROSGtB?=
 =?utf-8?Q?iFS4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djRBNUczSWV5bmhPN3JZRGtXRXZJMy9wZlBlWDc5VkxuT1JBa0JBNW1oK0VV?=
 =?utf-8?B?MW5YK3RjQ280c0twekt1MkFnUTJ0dXFXRHdrdE83MWh5UmlWL1hWUVFLcCs5?=
 =?utf-8?B?MUhiQi9UZ2wxamVmNVFVOTF6Y2w2c2xPTFI4Z3NWdk5xWFRhZ0pTMkc3SnBh?=
 =?utf-8?B?bXBZZDZZSkZTL1pmV21aUEZPa2ZBaEJ3ZVNvTUd4SjZuYU0zZVJreFdKRWlZ?=
 =?utf-8?B?TlVJOGZVdFZvSC91U3RtRnBrdm1SWFZBeFlvb20wLzArVTByVitUU2xPSkwx?=
 =?utf-8?B?TUlnZXd3Rk1lb0d1bDBUNmR6U1RHNklCa3czc0V1ZzhGT21IVlQrL3hyS3JZ?=
 =?utf-8?B?cFkxS3ZCTDlVNzVDTncrWEdzdDRXTmM1cDNoMjFpWDBNVFE0ZTZMMGpTcnM2?=
 =?utf-8?B?amZ6cjdNbGJOVGNjSHhrSE55Nm4rL1AzY1JDL0QrV1lBY0xTVHloV2xDWU4w?=
 =?utf-8?B?OEhNVWFaZnc1dFQ0UTRDUlEvUzU4ZDZFTnd6WkRENVBMeTMrUm9FYnJCOGdz?=
 =?utf-8?B?VXhsSG1VVUlLbzVzOEtHMVBObnVjY2lheElYUGI1NFJWcjlWNW83eENzWVNs?=
 =?utf-8?B?bkpieXl6TzJRL3pWSHZMamVidHlpTmN3dEVrT21iTmRNVTA0bkpQRG9DdUJP?=
 =?utf-8?B?UlJqWWFsYXB0NXFuZkU2M3BmUU1rSDF1d1Nmd3ZBTTZEN0lTU2ZMc2pZbFdu?=
 =?utf-8?B?cVBXNWNZKzFIci9XRGZpL1g1dlBqT0JybTV6Q1ViakdtQlR6bWxFMnQ3bzlG?=
 =?utf-8?B?VlY1U1FRMFRNb25qaDB3QnRXcXVha0V3YmpzcU1PNldUUFo5Q3VzTCtzWWsw?=
 =?utf-8?B?ZnBBY2xVSmxmMFhYZ0ZwRnQyQThmTndmZzNsckw3RWZiL1paMTBGVUhvejBv?=
 =?utf-8?B?M1BWS2VWN3JVRERZeUJkVnZSbFdyaEl5WU9tN1BZRzJiTVpDOE5TQWE1Qnp0?=
 =?utf-8?B?NFozam9XWmZBQytQUXZqWkkxZXlVbDFVZnZ0RTMyVmhPSHhKaGpGNmlUUFNy?=
 =?utf-8?B?MzZIOXUxNExjVS80MDYxblpNYWNYT2FFT1BYMnFwYnZ4UndFUVFZeUgyQ3ht?=
 =?utf-8?B?NDBGT0NHVHl5eDU4QzBiZVlRRCtIUXlFTDRTcW1VUEVwR1ZQUEhFRkt4RXpI?=
 =?utf-8?B?S2ZSMGd2YmhBL0RvK0Z2VGVLbSsxcFd0UkdGNVNXY21VZFllSGNmNldWWjRF?=
 =?utf-8?B?dGVPQStzWmIvRzMxY1N6MFhtMzQ2V0lzUWV0TFpEZ1VHNmFmYm5DbjE1Q1Zr?=
 =?utf-8?B?eVVmQmVudGhJblBXQVYxYko4L3prd3NGd3VVUHRIRDFRT0FZV1pwcmVmanQz?=
 =?utf-8?B?RlQvYk92MWZ0U3ZCbEs0cWdrbXRteE9GRWw5dmE2QWtxT1d6M3M1aHdqU3lr?=
 =?utf-8?B?RkxzM3VUNmtUanlJQ2tVbEhXaWtmaW1HTVZIVzN3THc2dDZoQkR5WGhBTFRr?=
 =?utf-8?B?aTltY1NnWHBpV1BwKytUWVBiQTBMSTlralRCdWhmSm1pT1dNY1N2d293Y2J0?=
 =?utf-8?B?SDI3K2pVZE0yZ042eWVadUo5RzlrQUNxR0R4cDdpdDNuZTRGTE1Wc01ycDJ2?=
 =?utf-8?B?S3lWUjF6d3JkTkFwMHVPVlFxREZsMUZFK095M1B3ZDFoMG1KU3ZhWE9CSDdh?=
 =?utf-8?B?dU12ZDUxcVpDcGQxNXBVTWdLbG1LRXp5N1p3ODB2dUxkMjhURnhjSmZ5K3Nt?=
 =?utf-8?B?bktLaExRL2dpR3AzZTA0NWQ1eVE3d0FlVjFCa2xSWjA3NFNRMkJYbXJwM2hk?=
 =?utf-8?B?SFE2QnVQNzh4dEoxV2hja1djbFFVbkV3ZzZMaDVRaENoU3dZaDZ6cjNNMEd5?=
 =?utf-8?B?QmoxWlJjTzE5dGVKdU1CTGRJTWNKVUtpem14VW5MM3dTOXM0SkFrQVJDenJR?=
 =?utf-8?B?U1BJWnVVellMejV0OU1iVUt6R3Axa2lzUFoyS2tTR3FVYVJRVDQvSENCbHpi?=
 =?utf-8?B?MTF2cysweGU5N2xwMzJmWE10NTlPZlFDeWpPWVVYbXdmQS84OTlwd2tGM1Bi?=
 =?utf-8?B?bk5MM2ptNndIQ0NibStaR0F4Z0dJTWZTOThLdjJCR3VzRHZQSC9NUFZQR0Mw?=
 =?utf-8?B?eE5YWXhKMGd2T2JFdlkyaVlxcHVBRTlOWW0yUW0rOHB5akVjTE01bmtmQkQy?=
 =?utf-8?B?bVBwRG1LL1hVdUlDZHVlZXU2WWtocFA1VENJSmN1a1BHMFJEaEc1YjJpK3Zj?=
 =?utf-8?B?RmQ5NllCcTdkdVRMcmgra21rOU9UNjVpcUlmZlBONVlFbUw0UEZUOGl5UUFH?=
 =?utf-8?B?ZEluY0V6Q21yZSsrLzZCeW9WTS9vTDYrd1FFbmFtQS90bDY0d1NnVFpvNjc0?=
 =?utf-8?B?VVJIRUxNMDZlVENsVUhXd3RWVDJHNVBXdU1DUS8xTGZZZzBDVlpEZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76dd118e-6597-4713-e074-08de5515db6b
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 15:42:30.0443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RokHAR8Qn4Yz2AiC/JnPcXUAquPH8R6baumXuqWBY9zQQRJYqaNJIKCowQDQJwzky01Cy/P5r3Y355z2sLd2bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB3180

--e3yqddyduxpvw4i7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [v3 PATCH 1/1] fs/proc: Expose mm_cpumask in /proc/[pid]/status
MIME-Version: 1.0

On Thu, Jan 15, 2026 at 09:08:58PM -0800, Dave Hansen wrote:
> On 1/15/26 17:53, Aaron Tomlin wrote:
> > Would you be amenable to this exposure if it were guarded behind a spec=
ific
> > CONFIG_DEBUG option (e.g., CONFIG_DEBUG_MM_CPUMASK_INFO)?
>=20
> Not really.
>=20
> ABI behind a config option is still ABI.

Hi Dave,

I understand.

Kind regards,
--=20
Aaron Tomlin

--e3yqddyduxpvw4i7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmlqXGAACgkQ4t6WWBnM
d9Z0xw//SThTDcXjJv2pU9WRLaoMlQAxt1YtxOdYc/ChQq6e3xonMIWZjR4nwzwy
mo7QxqwHK8yZcj+SNQm8sudya9N0DyBu7IRCf2RGkC3aZR4s7KVQVAR22XB9pvZK
hX2FQGByU6xM6vTSs4mssN8SHOFCGnlxTYvKMNYE/FateWSz/s28t7c9dN1RmiBY
a08+pUof9LrreUlOwla8GjuLxUrwb6ROXhrRgx6+xicvYrmdcPw6sOIsXYIaWGB3
dSMLYks569R9spzmBsP7PP40RwftShNm7vuh+gqGg/rzTD1UymMJEOLCvs6aoNGh
KANyxutRnd8gRHWWzJeZENGkQSzPFKQejU9KBFy264YWpNlMK9dF8imxTKBaR35M
7OQobSIyyEcMHboDSXMMbDNZT1Rfc3Mx5elgZhMiB2FJoVhaGGCIuvYE3d/peve8
DjBISpnEnXo2ryxpxd5D0HOqYNwpJXfpdO+MLHuhOzU0nn9UKZLYCL6QD92fM9Np
LPIUMifNwcADfdpXoBopzCuw/WW3qBpkXgyg9u4JkmIkbyFeCDoNOHnJMGpWzr5s
jZU5qLF0EFTB13vspTcVxTM4CC4S5fXqN4ACXX78AWLi3UY1EssfI0RUY2Fs+DXy
6K5rDC5kO1P4XEiBG1HZEzb7ccx8DSd6Ka+d4RETUKtWON3tzS8=
=s6BO
-----END PGP SIGNATURE-----

--e3yqddyduxpvw4i7--

