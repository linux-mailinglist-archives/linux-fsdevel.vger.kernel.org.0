Return-Path: <linux-fsdevel+bounces-73989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AC0D27BD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 19:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E00FE302210F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 18:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8BF3BFE4B;
	Thu, 15 Jan 2026 18:41:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020097.outbound.protection.outlook.com [52.101.196.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89B83C0092;
	Thu, 15 Jan 2026 18:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768502462; cv=fail; b=cNbhWoXybnaqeGZpxb6fVtXyOIeJahyAmYYZF63cUrMoSd/pmFxv3v33LsFEhAuvu2vugm6iCVkaDE96On1SCJmuIpZzkMW7Sl1sc7EllDzas11nIe/jxlJL4Ib5XuHcgegEKQBBnYfu/EXx+r6hTACcrjpJHf3eGmWHjJWp0KE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768502462; c=relaxed/simple;
	bh=Hcr0hFuTjtgUR8KyvWEGitWSgKdQ65f70lymohfQFGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YoRw7DmfOLUN4tK84sQoj5oFpbtXMQ+YbcoiowS9kDJjKCHr1bLc2naINsypA0GCCNTXiCJD2x2qsWkJ4GSp2knVb/ObvuHEY11EfA/WJs+OFxftBc+NU7Lv9KW+ccJgoJ3GRhA7imQhUlFEMHDGq8j5/T9JZs/Jb3ALKMK5U9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TrHJl46YKjUgjrbEFYacnsIVcQyXXoXn+HpSqnLAiAbQboVEHb+HFG2ank4ei/Mmw3K9BlBqki29N7of5HN9vpfkp8fXolma2WQSqwj+rYp8LvS0kTc14Phd6p1VxUi0flxXzSfLcP74CEzuC2TYsYER6iQdD6UtGnQ2Qr0iMbAZDqZinT6XVVe7hhyNBVXW8jV8IDJTPjqam0SSZb4H4p4XwglMYbTwfRMI7/BYfJMN0Kk+X8zQ9K0ke+g8uFzvB1Yklpu7W43Z9ihs50LKMIVE1JNurcTxwL5rWrogBbShAR+wR0dGD+D3gcWzb8S96RrQ7BsZkulCUVEVPzEDsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hcr0hFuTjtgUR8KyvWEGitWSgKdQ65f70lymohfQFGs=;
 b=N5/6Tlf7g3f22XR4DOVAYR4Djy4IuTn/0tLWWHfbVj+29fe1hn8voKrnx9X6Zu3jat4/laGnF5irsiufAhZiDki3v78pCmXRCSTXZ2N6pwuR+iFRbNK7H9C2SE9AlwCA1h1YelFL3SnTkxWyvXYtyEMyMcPVz9qzMNMORONHIa8q3Ww9pClNLjOXgD3pNF2gZ8GyaVk9Y6I3VS8dn5ipeU0AAEdj6GBfZsclPviyYxRBler8w+UFW2JkDq4lqCOJK4kF/i0i9DNdias9kCnoC223RYAAGg75JYSM/OU+TDricSy9mlMspWoIUV6/ODVaFk+E1TEtcER1yf3bYYPF2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO7P123MB8357.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:449::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Thu, 15 Jan
 2026 18:40:56 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9520.003; Thu, 15 Jan 2026
 18:40:56 +0000
Date: Thu, 15 Jan 2026 13:40:51 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: oleg@redhat.com, akpm@linux-foundation.org, gregkh@linuxfoundation.org, 
	brauner@kernel.org, mingo@kernel.org, neelx@suse.com, sean@ashe.io, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [v2 PATCH 1/1] fs/proc: Expose mm_cpumask in /proc/[pid]/status
Message-ID: <3cbg222hwqejusthscnapmy5s4p3vztyaz6yeg2xz7qxdn5p7c@rcvchlw427ta>
References: <20251226211407.2252573-1-atomlin@atomlin.com>
 <20251226211407.2252573-2-atomlin@atomlin.com>
 <ac50181c-8a9d-43b8-9597-4d6d01f31f81@kernel.org>
 <suoe7pyfr2qcbxyov456lglf4hcxkrzhoyqbiaba4kw32u5m2h@hg2crnjgdfoy>
 <175da76e-3f04-460b-8629-05062edd2d62@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xa47elcdsj3crtvt"
Content-Disposition: inline
In-Reply-To: <175da76e-3f04-460b-8629-05062edd2d62@kernel.org>
X-ClientProxiedBy: PH7PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:510:174::11) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO7P123MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: f0435d9c-b488-4d85-3d1b-08de54659e7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0F1V0Nwamovc0Z6Rjc2aURCdEdhVVk2LzNsTUdHQW9BK21rUENxN25pZGox?=
 =?utf-8?B?WjV2V1MxQzVpa0pIWUZBcFZyMUZ5bWFwOGcwYUtLNitwN1h6aWx2R2E1am50?=
 =?utf-8?B?RHNwaFpnRXE3dHFrVFJuWWhoWnREUVkzSndaNTZ1UWVsSXNpWVJvM2tvdVNB?=
 =?utf-8?B?SC9sbGxCc1oxNklHVHdXblcxb1V0bmZra1lPSkg1YjROOTQwSXpBVFRlSVZw?=
 =?utf-8?B?UHpsa1lpQWcrNWZyWGtBL2o3QmI5QWg3V2UrWVQwWkR1VVN1NnlsY3RVcXNJ?=
 =?utf-8?B?VGs4RFhXREw5T29BdXhsd01nTE5FUlZkcVJCMjRsdGw5eXh2VC9UT3NDdEpJ?=
 =?utf-8?B?MS9pcnMvVm4vTDhoTFJVUFJyQS9nNzBSZktsZE4yVG1hR0V0WUg1YnNzUzVl?=
 =?utf-8?B?NHo3NFBXRHNGUXh5ZGdPNEFkMElFRFUwaU5Gd21ENWdhQnlpS01ib2xxVlZE?=
 =?utf-8?B?ckcrQisvNVdBc3hET25nd2hoQUtTN3lHOGtXb2Q5M3p3Y3RoSjQwS1NOTGsw?=
 =?utf-8?B?Sm0rUTFRTTRjL0hubXNUUjEvaWxYN0VuNWpuUytYL01JSVVSNkZ3RVY0dXRi?=
 =?utf-8?B?Z05nNjhNODc1ZzU2MkJ5SmJJSjgxL1NlVnFldWlNYnRETXFTaHNyMEJRRkJi?=
 =?utf-8?B?bGJFbW82MndCZU81MmFxakN6NTZoZldkVTRqZzBNNWEvTjViT3lUTmprL0hj?=
 =?utf-8?B?bUxQVFZKSkZJOTZDR2lpL1oybkQ4YkZHSWcwYVZCRVhjaVJNUHpLOGczdk1k?=
 =?utf-8?B?bE5UdnBpSFlMMnNqMFJtcHlUN2syZ1VrVDQyR0d1c1lUQlJPMlhUazhHei9y?=
 =?utf-8?B?RldsQkkwSDMyWWQ1KzNZN251akIzakM2MEVQUU9hZW51NjVXRk9zMFcxZDVL?=
 =?utf-8?B?T3pRMStzelMzMzN4U1VIc1JueXdIY0UvS1JkVGo5UlpXckNldTlCOU5qbXJx?=
 =?utf-8?B?VG9nWGdpbkk5b0ZIZEdZdnpFLzBicldwYVlrNGw0WFpka2EvZFlSQmNrUWxT?=
 =?utf-8?B?dG90MUNYZUh1WEtuZXRqMmxjYTZFKzZaVDh6ZCtLZHk3bUk3bkwxcEJLZGdU?=
 =?utf-8?B?THlLV0lTM2x6L0VsNlJMcjFSZDhwcWtjdUNMM2FwZEFOL3ZvSDlFcDlPazRm?=
 =?utf-8?B?cG83VklDSEtLMTJMbGpaSEFIVkJJK3QyRjZ5Sk1ES0JoT0ExNnRMQktaa3hW?=
 =?utf-8?B?UzhzczZDOStQL0xGWU9JTjBWSkVBcXRwMi8zd0x5TkhRNjBiWk4xOUNLaHVW?=
 =?utf-8?B?bGNkSk1DU21MSEEyZEtFRDdMZEszd0ZUa0V2RGQrTG1KeWRDZXFiOWkyREU3?=
 =?utf-8?B?QUM0aW55eFoyRVErMCt5NFpMTkZ3Nzl5ZE1jREhmQUYwOWVsaVl3L2ZZSkRk?=
 =?utf-8?B?Ris2NWZxVmxnRGxHSExNcVlXVmZESmRnc05KWS8rSlA1TnRDVTJNN0RTbHB3?=
 =?utf-8?B?T2pwN013ZFZZemtTNlcxUGg2V1ZEcXk3NXkya05OdWZ0Vi9GQm1pT0xrQWZX?=
 =?utf-8?B?amV4SHlZSCswV0EyckhqN0FBQlp2Um1uVFpXWC85MlMvdzIvb3pSUktsVEFS?=
 =?utf-8?B?d3drQ29OS1IvMExIc015c1NOQkx3UWRaS05GeHhDcVB1M1V2ZUJVYVRVRlFE?=
 =?utf-8?B?OWtXZDlMaDI5MjJ6MmcyQWtIZDg2TXJoam5Edi9GMXBVbFBkUDBwVWdjOG9q?=
 =?utf-8?B?R3FIWVVBZEdBNDY1TDM2NlJzNlNETVBYQVpTdndMRHczMDdWZWt3cUcxNGg5?=
 =?utf-8?B?T29oaXUxaWc3VXR6c0l3RkxRdXd0WTRiTFROWmFtL3pOK1J3RzhzTDJTWldZ?=
 =?utf-8?B?WnRZSElzMzF0TzNWaU9RampQMWVOK291bXEzTnBnWlRhVDMrMU9XSEN3eFBZ?=
 =?utf-8?B?OVhrTWtrQTZGQmYzSTZ4L2p1dVo3ZjAyQ2g3dGdxV1BlZ05CeCt1UVh3Ujcv?=
 =?utf-8?B?YmJ3R2NsY2hhZEhzT21kWWlnUHc2MVRTdERDL0kvZythTjJQZzh3dWZ5bUo3?=
 =?utf-8?B?S0NzcWNhQklrODVDSVVoeVN2eDBqQkRmYlNPdTVLNWxmNkxNam00aTJ2elQv?=
 =?utf-8?B?VnZlN1VnSGFsTGJpL0dHdWJ1MnFaZEJtRm1YZHBRSHI4cDRyNG9HUDJ1cFRa?=
 =?utf-8?Q?PWZo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVVNMElsUWNSWnRTTFNnQS8rdEhpWnBTdGZnZnVPTE4vb0xFMXNmVllOL3Js?=
 =?utf-8?B?TVRKM1ZNa2VTZ0VUZHEydGFGL3JtS2JxczlERi80VnFjbEQxNTRlalhGNUJF?=
 =?utf-8?B?ODRvODhRTW55MmhRaTkzU09aVG1EbVBXSmxYcklBWTF3V09Zb1RyeTA1R1pN?=
 =?utf-8?B?ZlJobWhxTU95a3lSQkNCS1lzWWVlRm42MlV0WHhIMHhsbkFHTEcwZWdkR3Ny?=
 =?utf-8?B?aXpsbjEzUkcycDB4OVRiaGhNNVo4MmM3M2d3NE9nQlQyY1NDQmI0c1lsN3NL?=
 =?utf-8?B?aWFjNGE3VkQ3ZXVmMWhsbjJQQmxmellVZ3IwZG0rbDNEQ3pCUVM5My93aDYz?=
 =?utf-8?B?eVREbGtCaGcvMTBheXZnaFRpL0R4ZjYvOWNHLzNvdDlhRW0wazk4R3F3OXVI?=
 =?utf-8?B?NVQwSEZiZTlValowVTM3cGRSYTZxa3hUaWkwNUJEK1ZHUEtTRWRWTm11U0JY?=
 =?utf-8?B?SkVGeVVjWWw1bDhNSXVabU9lWjJGVEd1K2thQjNicjQvQ1hCamk1MDB0QjZv?=
 =?utf-8?B?a0dwT3owcTA3dnA4YWYzUFY5dDFmQk9hUmZESFBIZG9Day9rSXhTRTY3ekFH?=
 =?utf-8?B?SUhDSTZSVVNJM3prdzlqZDhJV3dPN3pYQlhRTXgwZ0NxMGVyakNDc2xZOGR3?=
 =?utf-8?B?SEI1K0VXcndEL2ZPNnk5MVQ4QzdnL0kwempxVW1wV2tNc0trSTRyTEJySE1F?=
 =?utf-8?B?cU9kcDMzQVBQTDQ1MzNma1lGVDV0aW5YMHNXeGdqZWJ6bmszcGM3OWFOTEc3?=
 =?utf-8?B?MVk4SEJueGtXbDJ3WlYzYmoxZ2Q4R2tEM3pLOWtDd3Ftai94VkpZSExFRjhP?=
 =?utf-8?B?S1ZsdStEblUyQkNpODAyd1B4MFdOL2tqeE02NkJ0N1Y3anNpSWRqTU1hRWsx?=
 =?utf-8?B?VUYyamVsblUzcTRuUllvYVBqK3dhTTZkVFcxNjRwTHAzaVpCZ1ZHN2wwa0Q3?=
 =?utf-8?B?T3ZVZytaRElDWXh4VjloMjU4ZEpsM1dRUS8yU2hBdjRGcFFxTWk5dU1vNi9V?=
 =?utf-8?B?eXIrQ3VjWWt3bWNlNks5R1ZxcEhGZjNqejdUeTBQajc0UU8vbFVSQlVuanB5?=
 =?utf-8?B?c0hYNGwyZE40K1NMY21ySUtISjQ2bTRORVQ2M2paUXFob3NFQWtqRkovUi95?=
 =?utf-8?B?UjdqSitKNTEvbU9hQk51VGlHSVppNytrZThCYjVWWWVtUys2VExvMzJqZjN2?=
 =?utf-8?B?RDhrWk9GenZWZ3E5NGFVdUM3MnN0U2IrOTBmQkRsa2p5eU4wYlZMZHloNkx2?=
 =?utf-8?B?NHAzMFBuQTRibmRrRWs5ZGt1TEFKRmRXVG9SQUxYVmRpaG5Db0ZvaEp0ZUFH?=
 =?utf-8?B?aDdTR3diMlFXVTh2NUx1NysvakZBc2Nod3RkcVplLzhPbDd6WHNSVnJpOTJQ?=
 =?utf-8?B?cXFUMzAvMG1reHlsZFV0bzlLL0xHQTBYSHhNejNPYnlwdkpCUnc2VjU3REJY?=
 =?utf-8?B?bE9MRHQySFRqWk1iUzNLYTVsOXBRNjJsV1ZQQ0s1d00yeGVhaFVpMjRSU2k2?=
 =?utf-8?B?UFVZNGtESm1nQkt2VVpyNlUyMUNlTFhCSWVBRTNkRkZUMjBJdDh0Wis0NThE?=
 =?utf-8?B?M2xMc2pLSVMwd3c0dDMzTXRHc0IxL21FeEYrMFJGeDdEWkpqbVE1eG5qRkJU?=
 =?utf-8?B?UlJmaVhQQ24zd0QrUTFzNXgwQ2tLYnNKbllHK2o2bXd5bTdLYWJHZkNmTzVq?=
 =?utf-8?B?bmNpSllWTU9ma1l6Z21BdkwxVWVZamMxRGhVUGxIanhRUS80M1MzV0k4bm1Z?=
 =?utf-8?B?cW5WK3Y2M1N0d20rdjBwQ01weWlSdWVFNUVmMXVoWXpSY3VnRnBTNHNOYmtZ?=
 =?utf-8?B?bzlUWkVwNU5xQndSQ255Zmx4bWFDSmpTazlBNnRDcENNN1RYMlJVZVBlZmRS?=
 =?utf-8?B?bDc1dVdlL25peEdOS0pKbjRtQ3dpU0ozVDVlNTNiU2M4bnBnTlgxYmRHbE1L?=
 =?utf-8?B?YlVXanpnOHdBY1lvZHRBbjVBdWxKMGlPRlJSMndwY0ZXZWMrVGcyTjNsN1NW?=
 =?utf-8?B?YWtIbndqVWczemF3bDM1WUZpU2l4ODVMeEVjL2dYbFo1OEtVMjdsRXBwOW1l?=
 =?utf-8?B?czBNR1hmZWxoYldFVWRpYlYwMHJSdkZ0R0g2eklDVzZPNTRVT3FPVURQMjA1?=
 =?utf-8?B?SkE2dzZ3YzFHVFNTVVpSbDI3RUlIelNQREZJUnFTcnZSVHVVZVFpSVdTZlor?=
 =?utf-8?B?VDR5UXBpdXZKQTNVekxzUUtjL0xITXZkaXE5aVdJTS9SZzdwSUVxNTJwMllp?=
 =?utf-8?B?SjN0RFJ2NzNBeFZRaG0vQ2k5TU1RSW1PUkpwQ3QzRWtOeEdXMEpuVkxKRmtB?=
 =?utf-8?B?U012T2t2QzBtZTlYTE9LTVBaQkJ4OWtldkFVZ0owbkc0Zm0xT1BZUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0435d9c-b488-4d85-3d1b-08de54659e7c
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 18:40:56.2698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7DHulYVGco/dzW0fCte4aYIBzZKZyDmOo0U9+EwSMWSL2b9o5Y11r1sYoZeAsSDOm9FM4WxyUPrNd2UxQZZnCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P123MB8357

--xa47elcdsj3crtvt
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [v2 PATCH 1/1] fs/proc: Expose mm_cpumask in /proc/[pid]/status
MIME-Version: 1.0

On Tue, Jan 06, 2026 at 07:54:54PM +0100, David Hildenbrand (Red Hat) wrote:
> Yes, starting with a very restrictive set, and carefully documenting it
> sounds good to me.

Hi David,

Acknowledged.

> One question is what would happen if these semantics one day change on x8=
6.
> I guess best we can do is to ... document it very carefully.

Indeed.

> > I can document this arch-specific limitation in
> > Documentation/filesystems/proc.rst and wrapped the implementation in
> > CONFIG_X86 to avoid exposing "Best Effort" or zeroed-out data on
> > architectures where the mask is not meaningful.
> >=20
> > Please let me know your thoughts.
>=20
> Something along these lines. Maybe we want an CONFIG_ARCH_* define to unl=
ock
> this from arch code.

That is a wonderful idea. I'll incorporate this suggestion within the next
iteration.


Kind regards,
--=20
Aaron Tomlin

--xa47elcdsj3crtvt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmlpNK4ACgkQ4t6WWBnM
d9Z41RAAsrY3mkNTKOMbTAAHCrnVqSzKU4g/XI9snf7G+VMRnhWN5MgVlyCGC9lc
v9hTd/+Cr7b8bhTBBfejrIIyyWzgC+lC6/E8tor83/kYbUzufsoUHjrvj63+w7Vj
gcx8+8ROiX7Qa+imwzAACtFm4rKCxicbGNOop9T/GO3wwF/uUmykWSc3wfybZZyc
AqMtQH9H2Oju04JnLWl4v6GnHIaytNmzAUccPuqc4mLQQNIi/3CRlIIsX+odkRim
X7bRt8csya5yQV7Ce9ToJa7ukFAWGwsvshV4lu2HDmIr7cCrk0rD4ONrWUXZd1rc
NbPv66mLGKOQdQQSNu98NLgKkMeSwQMuCRPzkqlnB6GzN2Iu7XEylCI4qNMBKwGQ
tnmVjvGe2hQ8hvYBTkd4gtkiasM5gaAGIB8nsZ5u0u054fiU4SBvPsJx4EaToulP
w8GKAqeclV99gunEs1E5gJ9Mk7ROlK8/nBhdG0kaSLtg5QrYRMvZPTXwsZbpF3L5
FgCZvsyp4HsuK9NwxHH2W9uI1CrlgXRnb5VwmxqvDq8xhUujUcYeu3nUNSoY808f
b6WM8i2oxp7B7Q1P5jmFqmmN6d3KUPeAtwQkDlAlpRUArXbSOkXGFlll0LX5VaFg
Tfgaq0VMWHpjqbCI0jZXxkliZa5eYIr55FalKpQAsDKNrZBul08=
=2f0v
-----END PGP SIGNATURE-----

--xa47elcdsj3crtvt--

