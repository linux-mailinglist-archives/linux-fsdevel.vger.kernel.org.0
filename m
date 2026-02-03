Return-Path: <linux-fsdevel+bounces-76117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MLfDJ5KgWkPFgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 02:08:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8ACD339B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 02:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E34C301C12D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 01:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA64214A9B;
	Tue,  3 Feb 2026 01:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XvFI94bJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011000.outbound.protection.outlook.com [40.107.208.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B13E55C;
	Tue,  3 Feb 2026 01:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770080917; cv=fail; b=UqMTQ4LiUarYueUzLnvUXZsBw0M+qJda0eU+jNF8BNGZRoMzJKLy3RNmrWlftvSIB6MNe0Bnch4VAdIf0mdKG9PqfqRSdCNehKF92A1We9YtnDzYAPPYfKqtTeXH1fKe4c2cRQj4OzLS2IKvDtZQM++U1d7dJnLiQvHq93j8oAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770080917; c=relaxed/simple;
	bh=HdDVt/U9bJNjso4dilP7ACle3JqJ+Ypz/p7+QGy86RA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NeBDW2pHNm6bEFULmcf6kRbk4rKV+JsOtOXT1CFFXcCWHnLmpncXIF59vvDZZu4N0MDH9x0IA+5/6Gj+3SfpG1L/vUYli8iRad03lsS7rXZLM7AZx5/9N0ouiOVVswrHODq+Hg+6xWlNkEKSX9kRwUlKj72V3+3DdbLlOWy16dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XvFI94bJ; arc=fail smtp.client-ip=40.107.208.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5j87YXSjb+ie12E+2MHrKMqVk+cA1TZiM0BCaasPVXLJmK8BY0HHn6bm5nbu8VUFxCeYoY7IMio6RGdDT1UDQhehzJD+Ocwptz9Bc/Ulp0bMGlFs2lOr/Ys8FxuyFIG6GLdx4TDDZXfFR9atkxMo3JqxlxREfuz1LQpISScpSGov7GKRJV4AwMXciZbKkhZ4A6K7mXxK19r0sJp5MaVQlEt5UHuDsovl7S4vek1eExpwSXZeZswBrsSa2Y68KRhG+YyvR1bFUFJyOazQXO8v+sWMcnEZMQXcmvg59BzcFgWNgDOftkSjuxLzjoM3X9zSvS36rX9cMCe3eflfPY6Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRv4awzZUpkAgVIhHnGbZNIl/KYZLak/QzA+7W9gdkI=;
 b=GiEectbnpUaVwcA607EBAk0xRm9EkORsxHgdQt2uYIQ908eZW3106qowQ9iIIjekzQM2eOrYwD1qeVdP0kXYuPSUM5Cab14VEJYHqSGXr/a0fVwtXkY57iqgkPV4Dl//H1Xo8OffKk4ekDDqAeM4pbdzLlrzKc2KrFv0FKnX0ii8Hyf64vRkOZ1bR+Kht9cD0fIQ3IkVCZWNFn/8SV11lsE2tD8pUB5a1aS4H+H1dtjxnUSH3wPAZcM0sVQLjrmnnIjuQom/0HXl1oWyJwWzV7QndrqBoobM57WCaZMt8HPBcNOJchaBQJJw+xRunLew+nT8y7hVg2+hEXAJe2vzlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRv4awzZUpkAgVIhHnGbZNIl/KYZLak/QzA+7W9gdkI=;
 b=XvFI94bJ0QSUF1mMzAylJX6G+51dAp7eiKMGOPi8ie+WEPAmioEmz349i7APseC9E/elpz2f6KXnzZUKa/kO5/wjSeFLyuThBBTPXxsActFv18QrIyl3bmB+Nh9+4mT543bkb2+3l67UcEh+FSA4dY04fQtkuB3r8XNF3s6R1mY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by CH3PR12MB7691.namprd12.prod.outlook.com (2603:10b6:610:151::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Tue, 3 Feb
 2026 01:08:29 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee%4]) with mapi id 15.20.9542.010; Tue, 3 Feb 2026
 01:08:28 +0000
Message-ID: <586121cf-eb31-468c-9300-e670671653e1@amd.com>
Date: Tue, 3 Feb 2026 12:07:46 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v1 05/37] KVM: guest_memfd: Wire up
 kvm_get_memory_attributes() to per-gmem attributes
To: Jason Gunthorpe <jgg@ziepe.ca>, Sean Christopherson <seanjc@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>, cgroups@vger.kernel.org,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org,
 akpm@linux-foundation.org, binbin.wu@linux.intel.com, bp@alien8.de,
 brauner@kernel.org, chao.p.peng@intel.com, chenhuacai@kernel.org,
 corbet@lwn.net, dave.hansen@intel.com, dave.hansen@linux.intel.com,
 david@redhat.com, dmatlack@google.com, erdemaktas@google.com,
 fan.du@intel.com, fvdl@google.com, haibo1.xu@intel.com, hannes@cmpxchg.org,
 hch@infradead.org, hpa@zytor.com, hughd@google.com, ira.weiny@intel.com,
 isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com,
 jarkko@kernel.org, jgowans@amazon.com, jhubbard@nvidia.com, jroedel@suse.de,
 jthoughton@google.com, jun.miao@intel.com, kai.huang@intel.com,
 keirf@google.com, kent.overstreet@linux.dev, liam.merwick@oracle.com,
 maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name,
 maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org,
 mhiramat@kernel.org, mhocko@kernel.org, mic@digikod.net,
 michael.roth@amd.com, mingo@redhat.com, mlevitsk@redhat.com,
 mpe@ellerman.id.au, muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es,
 oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com,
 paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com,
 pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, qperret@google.com,
 richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com,
 rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org,
 shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com,
 steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com,
 tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com,
 vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com,
 wei.w.wang@intel.com, will@kernel.org, willy@infradead.org,
 wyihan@google.com, xiaoyao.li@intel.com, yan.y.zhao@intel.com,
 yilun.xu@intel.com, yuzenghui@huawei.com, zhiquan1.li@intel.com
References: <cover.1760731772.git.ackerleytng@google.com>
 <071a3c6603809186e914fe5fed939edee4e11988.1760731772.git.ackerleytng@google.com>
 <07836b1d-d0d8-40f2-8f7b-7805beca31d0@amd.com>
 <CAEvNRgEuez=JbArRf2SApLAL0usv5-Q6q=nBPOFMHrHGaKAtMw@mail.gmail.com>
 <20260129003753.GZ1641016@ziepe.ca> <aXqx3_eE0rNh6nP0@google.com>
 <20260129011618.GA2307128@ziepe.ca>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20260129011618.GA2307128@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P300CA0046.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fe::8) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|CH3PR12MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: fd19a724-65bc-4134-5c62-08de62c0bd6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFE3QnVRQ3dKdmd5YmduU2NZR0ZSWDVLNFl3UU1ISGVPMnk2VDdjN1RmMTFL?=
 =?utf-8?B?MjZSR0VQZkoxcUljekRrZVI5T1daZTZKVWhCZURiMkRQZjB4aWJ3VXJ4QmFQ?=
 =?utf-8?B?K3Y2MEowV25mc0k0LzNIU1Q2Y0hIN3dEVVVRYnlYZFNwQ1NWU0RlbnhpZURk?=
 =?utf-8?B?TkRYQUMzR0ZKaGVCZ25xb1BDVDRSZ0RjOXI5R1JqUFNVVUFSaTJESHZ1Q0xU?=
 =?utf-8?B?VFBHWTkxT0REV3pqdnRNTVp0YmQ0Nk9tTUFnRzFrYnRUQTJrYUJPYWxzWGYy?=
 =?utf-8?B?L294alB1ZkRDTk0rT2hKbElaclJxNDVSRzlFNWFWeHRpeVNpWlZGNG5BRHJH?=
 =?utf-8?B?eDJPMy9iMmhma3VoaGh4ZFhaQmo5S3FydVkzSVdQVTVJbGZWcngza3ZIeHFv?=
 =?utf-8?B?UCtHSXBKMWRxVklNeldhS2xrdTZBcFhKUE1mK25lTllOQUlIQ3FNV0V4Yjk3?=
 =?utf-8?B?bXQyRHJKSFpscFl3Z1N1SktaeXZ3Vks4WWlmV3poSmhOcHNqK2tyd3FHVm5Y?=
 =?utf-8?B?d2oxNWRBaWVNS1RBTlFiSUVQdmxlTEhHQ0I1QUZZRTBwMG9qVi9CUmtIYzVr?=
 =?utf-8?B?eENoZklqRUVVOXpzNis0YlU3QmNHZFpTNHA0Q1NQbDRCQlljK2N6MktEWWs2?=
 =?utf-8?B?WlJ2TXB2bGIxV2ZZV21sNjVlUjBxT1VSNi82c2tjdlV4VmlTUmlCNWJiaEFC?=
 =?utf-8?B?VWtweGNnL3ZHZjBiRGVYejZ0MndVL0R1OXlIVndlRnZvRjRQc3g2ME54UHl2?=
 =?utf-8?B?VXpydlpUVXplQmNKNTBZNHN6QUsydXFnOXYrOFppSzZJdlBsMzZvQmhXcGNX?=
 =?utf-8?B?ZDZ0V3F6STJXdUdPbW5DUDRXdmpCSjUyUytJRW4rU2Q2a1FCWG9abGZMeVpr?=
 =?utf-8?B?MW5vZTFWZU1zYjZaRWhMSzdEbTNxdEd4d2x2aE1OelBMMUF4ZUxIZnNZSlNN?=
 =?utf-8?B?amM5NjR3ZU1YZXJXYTZyemQvb0FmNWFpOHFpRGJhRkw2ZVlOZ0ZoUGcyMFQ1?=
 =?utf-8?B?NnVjRXM1cStYaEdHdmRxMkN2ZXI0bWpzNjl3dU43NHdGUE00OVpGd043Y2pl?=
 =?utf-8?B?REgvNWx3MXRVSjVQRHdHVW5MVHowejdiZXlHNFJWcVJLcXBSRVlOT0plR0o3?=
 =?utf-8?B?RmR5Q1lGbWFoUVZYNjFvK0VuQjBteUN5VHpQcGNaaUJtSHhqVkxDSThheUU2?=
 =?utf-8?B?dGEyQXRuOVdOSTkrQlZ0ZTFJVEhPM0hxTjRnVFltalV5YzJDanJLMW1PNTFC?=
 =?utf-8?B?eGw1a0J3QTV2aGZBd2ZhYTc4VlBJdXZ0RlIraml4K0oxTUZxczUrT0NhOE5a?=
 =?utf-8?B?K1gvSExmb3N3MmNKM0EyN1o3UjFBUVF3MlI1NjdkUDh4bGhMVGI5VzlOcDJE?=
 =?utf-8?B?N3hWL2dTbzNEbkg0WFZ4bTNSKzNMRll1UE1hb29yZ25qRnFZVEZLaEFYTm8z?=
 =?utf-8?B?N2grc21jYm1tQ0REWThHcWJkM2tuMCtJaXdxRWNsZURuNllZTk1Ic3ZkSkFu?=
 =?utf-8?B?YmU1RFJpbmpvZW5qODR5Z3VnOVhyN3YreURtbldEcm9FSUtEQ3hMVytqS0E4?=
 =?utf-8?B?L2JrK0NZMkk2MGJsNlh6N2dXSzRoSnF4dTM2Y2pRa3RFNjJIZWY5OWZrUjNm?=
 =?utf-8?B?NFhKV2czcXpTc1dDM2RsNVZQSUJlQTdVaUJ2QjVEUEx4UFUzejZoOEZ6UVY4?=
 =?utf-8?B?bHBHVVlybmJ2eWRvV3BuSk5tYW5Xa0pybjI5MzRIVTNZbEJwRkMwL291RTZl?=
 =?utf-8?B?RHphdXBSL3NmMXBaajFBNkRpcHl1cUVrREcwa3BwclpNczhYUlNiS3FjU2Ev?=
 =?utf-8?B?UWdmbnNPQUJjSitlQUZobW9aU3ZsTDl1K3FTYkxTQXNZTG9oNFhJcnh1U2FD?=
 =?utf-8?B?T3lQNVJXaXZvaGV4RU9tb3Fnc2xHdmFQdWwwbUwzNFdKK1drQ0hrbHpwcVZK?=
 =?utf-8?B?Q0VieXlhNDBqWWJrdWUwYmhqYXVDRElvOTgwQTFqNjlDZXVxY0hEZ3FIbVlo?=
 =?utf-8?B?T3JDWTZtZW5KRkFKUFlldDFnZElNMFUvU093OWoyUlZjRnRvNzVlT2NlVTFn?=
 =?utf-8?B?dlFEa2xtd01pMmVPeWZYVm13NDJvR1IyVGFyMENDYzZac3pvWHNHWXVzTWhE?=
 =?utf-8?Q?U0yE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2NKYVhVQ2pPSk53LzJGV3FVSFFxM2ZEMHdZRk1sd3VnQW9KK01KOWZBSkxV?=
 =?utf-8?B?WkxMNVhFdFYyclFoK21qUHFmNzI4L2toSm92MHJTY2xqbXNPVmVYT0VaSW1Y?=
 =?utf-8?B?Y25PWTltT3cxUllaVGJmZUxHNW8ySUlaYWdvb3BxZUlSVmFpTXNkaE8wWUxE?=
 =?utf-8?B?TXZYeTRaRjZLQWYwaHJtZFk0Rk5kdEJZeUw2MExNcE56d3JvU1dVS1BSdTY5?=
 =?utf-8?B?dW9hSHl6TG9naHF6OTl0REtSOTQ0dDQyN3hSRkdaOXMva21jMFVrblNjNCtB?=
 =?utf-8?B?Qm5ZUTYrSUFtUVRkZXpGVW5ETm1QR1lNZlN0aU5GYlY4Vmtnb0xYRTE5WmR3?=
 =?utf-8?B?bjgrYjdCRXdKUFdRdEtnZVBGbU51cGhOSVJuSE8zZ0lIc093NGd4Y1ZMVEl0?=
 =?utf-8?B?RFV5WnBFMUc5eWJDN3dBQlJvQ3ZsUlZsUWVmUC81cDZlYk5POW1Dejh0Ryt2?=
 =?utf-8?B?LzFvNkhxNjlYUEhnbzVocXlvekZkdlRwcEpLQlViVFI5ZjVpTEVzVG9CZkI2?=
 =?utf-8?B?eW1kQURsVmppbU9raHlLVUVBZWZNakxzbXA0VEk2QmNKb0Z3eUdhYWYwWFE5?=
 =?utf-8?B?VXJueW1FV24wakJtL3Q2OURrV0Q0Z1ZZM1FDczVCYStWUUZ4T3ZFRXFNWjlp?=
 =?utf-8?B?U2hTc2ozdzRHZlljcFhQdVR0ZlRwQXJhNmNSV3owNjNvWGZzcEVxOFFWTDVm?=
 =?utf-8?B?MUhnZGF0Y2F4ZEV6Tjk5QlJXU2VTOTJPNzZkQ2VjMHF1bmV3Smx3bTYrcnZJ?=
 =?utf-8?B?aFc2aTdwY2MxcGZhenI1NHZyZGFPazdadENwYlBPSW45cU5vWkJkeTFaem1F?=
 =?utf-8?B?QXI0N2xrU0xTdW9HYVlHc0VUNE5GaGJycHlHRUZPcEhoeUFxcGJ3eVVVY3BU?=
 =?utf-8?B?SE4xTUZTMGt6RnN0d0JvV0FRNXRqM1VJcmJQNDFQazBwbW1ENGlyWFNXNWQr?=
 =?utf-8?B?N29KMXdJV2o1Q20wS3haelkwL2xjVjZPd05lTW1EMURnd2V0ajlVRythV1R5?=
 =?utf-8?B?S2dpWDRhaUxBNHJ6NXNOcnZIL09oQkkyV0tueFVmTEkyVW8vVXQ2V1pQOHVp?=
 =?utf-8?B?WXFIMjdnZFU4eENtb1lXRityeW9IejhaWGlqem9sTExlZTAwZXA4RE5WYnhz?=
 =?utf-8?B?Z2R4N3JKR3p2cjBBSXQyamFoQ3QydkVreUt0b0NNVGZ4RGlxOFYyWkdiS0Rr?=
 =?utf-8?B?RzQwYjV5ZUR4REZmcWlhWXZBWmhrdUNXMnNBd2hsOENIdWI3Ry8xRTNXQmJK?=
 =?utf-8?B?WkFVOGhjcU1HQ0xGMVRuWTc0TEhhQVJTWE9td1FQeUwzSU9BODBQckpXV3Bl?=
 =?utf-8?B?R2dFU0lvUkJTbTVJTHhMVDNybkFCR1ZZSmtMdEwvckNjWlZaN2V2NmdhN2tq?=
 =?utf-8?B?WVZzUDkyY1ZDWVc3NzdXRXRsRytQRjRtYkp5VGFEWmM4TkNtQlp4cllEaFBO?=
 =?utf-8?B?bVlzNUZYdDFDZGEvcEppMVBSTjhQZUtmRUJMZTlDd2piaDJ0c2d0bmRCTmlj?=
 =?utf-8?B?OHdOeVpzdFVQTDZ4dTBFRDVKV1NaSm1NVmtoWUNYbU10bURUVWpqUVluTWJP?=
 =?utf-8?B?WEUvczZCZVZSZnpBc1FhUndoaE9RZ3dybzdzR3lPQ0U5SEhGVTFDZEhvOWJt?=
 =?utf-8?B?ZVpTdElCYk9XbWVHSStVSXlIaEdwM1JldnF3aTNuU0VZZE0vbmUzRWV5eUo4?=
 =?utf-8?B?NWdzYnlXNEx5TnZBOVFEV1lOVS9iZXN2cndES3YwTnUrZWtqUmZGSmNJUkxy?=
 =?utf-8?B?L2JkelV4S29kMWFjQWtFUVRoclRXK1k0WXg1d2hmWHlTZnFFY1Q0czlQVFVa?=
 =?utf-8?B?ZW1vbTM0eWFrM0E1NDVjWDkxakdYTzZESXFZNVU2VXBXdlhzNFliRVJEbWFo?=
 =?utf-8?B?TDJVZ2wxaGJyRGRCNnMrL1NlYmQ3WmVkSHVZZ1RwbnVyOStrdTIxQVVhRjNV?=
 =?utf-8?B?Z3RMcExKdlhKcFhhZkVPZW11RG40eXhpYnNDYmxQSXlXaUdhOFp0ZlJtYW1K?=
 =?utf-8?B?UlI3UFArTWVmdDUzWXJkSnplVHU3WWRBb3JxVGxnbzIvY3dwNElNRFlpeXJR?=
 =?utf-8?B?VnBmMXpQVlNoZnZIS29ORjc5UmZpYmY1K09RZUJZbExLSWNCSTJJYjZBUWdj?=
 =?utf-8?B?MjNzZVhvUkxITTFlNXpFbnBjV3pCNGtKRUN5R3BKZDF0MGlUNWpjRWZrT3N3?=
 =?utf-8?B?WjUydHQ3d0ZpVkYyeFF6SEZsaW9rWU90UEZaRGVXd0tHWklSeXY3VUxHOTJR?=
 =?utf-8?B?VWpaTTkvMmhsc0M5ZG94ckJjemQrNFFTVmFPVlE4U1g2aEZLdnpGZ05JSTJx?=
 =?utf-8?B?LzVBVU5mMU9LdHZXTFNQaVBtQWRaUU1uSEZkSHlqTDRycWU1S3dmQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd19a724-65bc-4134-5c62-08de62c0bd6b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 01:08:28.7209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gb5XMbprqJC5WppHHEya2m0hVrcV7TnoKUMKhHrWuHmplaMRtYpkQ14E4gpzvefd8gvN9EXRX2F4h1qfD502HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7691
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,kvack.org,kernel.org,linux-foundation.org,linux.intel.com,alien8.de,intel.com,lwn.net,redhat.com,cmpxchg.org,infradead.org,zytor.com,suse.cz,arm.com,amazon.com,nvidia.com,suse.de,linux.dev,oracle.com,maciej.szmigiero.name,loongson.cn,efficios.com,digikod.net,amd.com,ellerman.id.au,amazon.es,dabbelt.com,sifive.com,gmail.com,goodmis.org,amazon.co.uk,linutronix.de,zeniv.linux.org.uk,huawei.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76117-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aik@amd.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[97];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim]
X-Rspamd-Queue-Id: 9A8ACD339B
X-Rspamd-Action: no action

On 29/1/26 12:16, Jason Gunthorpe wrote:
> On Wed, Jan 28, 2026 at 05:03:27PM -0800, Sean Christopherson wrote:
> 
>> For a dmabuf fd, the story is the same as guest_memfd.  Unless private vs. shared
>> is all or nothing, and can never change, then the only entity that can track that
>> info is the owner of the dmabuf.  And even if the private vs. shared attributes
>> are constant, tracking it external to KVM makes sense, because then the provider
>> can simply hardcode %true/%false.
> 
> Oh my I had not given that bit any thought. My remarks were just about
> normal non-CC systems.
> 
> So MMIO starts out shared, and then converts to private when the guest
> triggers it. It is not all or nothing, there are permanent shared
> holes in the MMIO ranges too.
> 
> Beyond that I don't know what people are thinking.
> 
> Clearly VFIO has to revoke and disable the DMABUF once any of it
> becomes private.

huh? Private MMIO still has to be mapped in the NPT (well, on AMD). It is the userspace mapping which we do not want^wneed and we do not by using dmabuf.

> VFIO will somehow have to know when it changes modes
> from the TSM subsystem.
> 
> I guess we could have a special channel for KVM to learn the
> shared/private page by page from VFIO as some kind of "aware of CC"
> importer.

Yilun is doing something like that in (there must be a newer version somewhere)
https://lore.kernel.org/all/20250529053513.1592088-1-yilun.xu@linux.intel.com/


> I suppose AMD needs to mangle the RMP when it changes, and KVM has to
> do that.

True.

> I forget what ARM does, but I seem to recall there is a call to create
> a vPCI function and that is what stuffs the S2? So maybe KVM isn't
> even involved? (IIRC people were talking that something else would
> call the vPCI function but I haven't seen patches)
> 
> No idea what x86 does beyond it has to unmap all the MMIO otherwise
> the machine crashes :P

When it is in the hypervisor area, there is no "x86" :)

The "AMD x86" does not crash if there are mappings which won't work, it faults/fences when these are accessed.
  
> Oh man, what a horrible mess to even contemplate. I'm going to bed.
>
> 
> Jason

-- 
Alexey


