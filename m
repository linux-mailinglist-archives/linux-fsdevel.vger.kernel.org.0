Return-Path: <linux-fsdevel+bounces-30756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFD598E1F5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 19:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F54AB20D41
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 17:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF9E1D1E6B;
	Wed,  2 Oct 2024 17:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T8VSWC/y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z3phtg9z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1BB1D0F76;
	Wed,  2 Oct 2024 17:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727891777; cv=fail; b=MHtYzc9m1S6fBdExiT0lW57GHj7ivFS6VHz3HjlkfL53dSU5WfJsRmQgf4RQS98IOK7lTVIz0A1qijsi5Wd8pJX8/dm8SvvzpMhshWQA1RilRnSeXF6oIf24tRQbp8RDGv8FP/hc8diThf4Vj2Qtqss9n2v0dYg0NjZfQZshKrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727891777; c=relaxed/simple;
	bh=zIxo97Vf9qVf5n1pxB9ou7ga8AXBMOvprUZZjGmyQ1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LRN/JTOqhqkvY1r2uFIASQ6GJ5phcdDejbidxcPaeuMp/PHSNOjPmGX1I3imSLENUHcKWXWEHXhcbWUfb0e4l6/kYOTs38IajPSbc8woeRKxAy5/98Oj8X95Q/mvsj0H+V/jDBHuryGRb9vVsvVE6w+pwDUm9EeEzPZY3n55QJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T8VSWC/y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z3phtg9z; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492HfbWg025721;
	Wed, 2 Oct 2024 17:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=4nd17rFB9avr10NTtvBS7y1ApaU0fMrteSuGyyIkq9Y=; b=
	T8VSWC/yNXmptc6lEfpFs+AGeH81GN2X5Ajk0H1xn5QidLOCqDJETPf18YXKosR3
	XGEQyoZxsm6dbanbWMidSxsar3954RliiKoq5JgN8DhvurjJ8yNX+gqYpjXnCBpH
	Py6NymQBJWgWKuKWyb9WiXJlfv850oR3RWb5CAPRoURo8k3fVnSZrXQDmA2+oDTq
	WJFacJEkR2mnjEJQFXtyYMNkBmCwDx9EX7yzmJmKsHvIQuxKEx8JMa+t5HIehooz
	5/xuomREOOID/l6NZtugWh+sNrlISI9y8bYytXGbcLtzvh5P3/+Wroazm1QF8sB/
	F6Gf9U9K/pbZO77BSOBulQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8qba92f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 17:56:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492HSTWO012523;
	Wed, 2 Oct 2024 17:56:05 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x888xx0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 17:56:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLWEcydiYz/d5Fq0KRI1CxpWCcZSNpr+rP7c0e8AJA4czCbrv7fWQHP+6XESQmTyxAr6NYnNDAtaAb1tB6L1qetZWuxnN4HJ8pZXwpJVSev4c5+gjzoaakkRhFrNie2T4xoC8nhGaKZLhjM7AivM7NJWyfyzF2KXCjVmE6sgNgfBKnxGOBL4hF9q75RcV3wkHARchLBrFByhi/HCL45Gc6juq1NDMVnuWL460ja+heLLRKHSOYkwGU3B3A5AOORDVh2giuqlgeZhvM6v6LWMAgt3ko7ht9bxrXaJPmiVLsmHCLsJatQilPbGsep3UV59rPyBIsTSwIxc7un/rqK0rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nd17rFB9avr10NTtvBS7y1ApaU0fMrteSuGyyIkq9Y=;
 b=tNvJnKQWKLF+dH0sOOU2XvUoBocWhkjhhwXga4BtGaGVzAmsdto3NiKLQrIkoUJHLSTsNbSXDKo5YkGDRCI8Z8a/hkS1ZCAx0H3bJB62HUqu2r8E+lryhIq5cVi9ITabaDC9TidS3s5wFqb0cbPGaVV79/axG/8IQo70RmP2yIiuHH1XifDXznrnIJW3t1aG2dlrpSdfrB202eTqduhT8rsUQHHHZ+rs0p0XFe7AC/OT7yUz55HKcxBPaz5FIJMV489j1FkxLhaORW1IdTHlWs/YotqTiQYoa5TXI3yJrlhoM1UvjiJu7Ifx7cIMO+5u6tZlX/x2pIy7oq8WyD8iyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nd17rFB9avr10NTtvBS7y1ApaU0fMrteSuGyyIkq9Y=;
 b=z3phtg9zjd9fWhdryJDgwVjQcZum6vhKA74fzl9vHcnFMG8kdUhBDQy6U5ThVCunudvh3AR6BNwFe88IONaQ3s8N+XMCEB99geAEx+4fwknIU4bGakDPOWpiA9ObKZtYFCcOOCbxXE1RkXkqVIK6iNPWKYdQUQy+TPthu+xooio=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH0PR10MB5161.namprd10.prod.outlook.com (2603:10b6:610:c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Wed, 2 Oct
 2024 17:56:03 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 17:56:03 +0000
Date: Wed, 2 Oct 2024 18:55:59 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        linux-fsdevel@vger.kernel.org, Liam.Howlett@oracle.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: 6.12/BUG: KASAN: slab-use-after-free in m_next at
 fs/proc/task_mmu.c:187
Message-ID: <f6bd472e-43d9-4f66-8fc2-805905b1a8d9@lucifer.local>
References: <CABXGCsOPwuoNOqSMmAvWO2Fz4TEmPnjFj-b7iF+XFRu1h7-+Dg@mail.gmail.com>
 <CABXGCsOw5_9o1rCweNd6i+P_R3TqaJbMLqEXqRO1NfZAVGyqOg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABXGCsOw5_9o1rCweNd6i+P_R3TqaJbMLqEXqRO1NfZAVGyqOg@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0123.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::10) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH0PR10MB5161:EE_
X-MS-Office365-Filtering-Correlation-Id: 13c20c67-26e7-4255-6795-08dce30b7b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0hsemNiR1BDMEFnS1BLdjRFOFhPUFZUT0hCWTFodWFCZzV2KzMzTUY1c1hG?=
 =?utf-8?B?Z1ZvUVNwTTRZSzE0bVNVb1hFcTlvRUI1V3NNWmdHOXMrb1lZNU9pTEhMVE5R?=
 =?utf-8?B?dUJSTXo5dmR5VWUydzJJTVdiUnFPMkF1bWE2SFRXR1NGUWtmd2FuSEJwTElS?=
 =?utf-8?B?aTRmdGdkb24rdUdZbVBWQmc3Y1c0VXhjUmdFelhkWUkyZ3ZxejBJR2IweHhQ?=
 =?utf-8?B?NHNvQ0lUR2JQTE9HYUVNbXU5OXZVaWF4WUpXaU9IcXdrQ0p2bHYzdm1vaU1T?=
 =?utf-8?B?Ui9iNkNYTnNlVHl1ZnhVMHFpeGptanJlVUJnTW9LRTlKc1NWOWwvTVVXQ01a?=
 =?utf-8?B?OVpyc2tTQ2x0SEhjZUJEaXU4Mk5EYlFXakRlcjcwQ3RjK1FMSWg2dzdib2RV?=
 =?utf-8?B?czFKMXVVWDBNU0FROXB1djdKR2ZxbWNabTlHL29nMjZzNUN0dVBYejZYU3VP?=
 =?utf-8?B?TlZYVGNnK214UWJPZkRaSzNGSHJFcGZGbzNYd0NVU05WZkJ3VDJvZUlmZzNi?=
 =?utf-8?B?WS9TWjRvaVp2YlVnRUl3RStGM1d1YzhLSkZYakJsU2dHM0xvZmhSVEtjUHcy?=
 =?utf-8?B?clV6QVFmRnNNZENKdmNhUWJPTUNBNmJNdnZyUTlpZjliNE1nSFphTUhuc0Ju?=
 =?utf-8?B?S2d6cjRXTTAzYis4VjFUYWdwMmNXQzlLZXBCdXNsVFZwUTdUTEFPUFIyWnYx?=
 =?utf-8?B?VVRrV1ZLdTQwV2V3RGxiOXp3ckFUVHhpb1htdm9KMkQ1VVJna21meXk4bnNF?=
 =?utf-8?B?Ukg3ZWVXNkdhcHZ3bEZlZnUrUWg1R21rNkVwZzBqL1JBU1ZXbHNqQmxodUMv?=
 =?utf-8?B?dGlPVE5qSm84QmdkanFYVmdaWW9JY0liR1NVaXpBSUJEb3lsem1jQU43VGZj?=
 =?utf-8?B?ZzVXWkRySFEvL1Axd2ZocXZYS3RhMms2RFI1bm43RlRoT0RMcHVETWc5SWh2?=
 =?utf-8?B?WFBDT1Z3NnNtZDFvdDV0N1BNeUZ0L3ZEYmMvVlRxUlZMdWF1ZXpJQk8yOFRt?=
 =?utf-8?B?ZE8rOFVTU2JmVTQzUG4zL1NSYmx2OGNxYzRmSjZjTFBYR015dGtLVEZWWUpB?=
 =?utf-8?B?SDFXazRjSTFPRU4vNUdod3RSWTArcVF3bTFMMm1yT2J5aVdURzRBTkdlVGtK?=
 =?utf-8?B?NFFaUU1FaDBpNWpGRGg0NTZTUmtXQnRLenA3ekZicjdPejkwQklxS3JJQm9P?=
 =?utf-8?B?MURabzlwM1ZwVWJpRGhyS1lDVUxzblhjNUtRRVpabU45U0hiQXNCZ1JFcEdu?=
 =?utf-8?B?THgzZGZVbDA1empRYzNOLzBJYTFVdDVCdDlWWGFRc0U2bG85Z0Q5NWs1ZWUr?=
 =?utf-8?B?ZEE1ZzBGVkdHNFhkMFZBVVZTb0h1S25hVHppckNXc3ZqRXBpRUtoK2xUQ005?=
 =?utf-8?B?MEpMaTVqN1NCelgxRHpuSlRxWlNBQnVhbVNIY3g0aFREUVA5bTc2ZTljaFJ5?=
 =?utf-8?B?MklIRzY4RkxNMENqNWtBaCtnbUF1U09Udk50WDRGV1FMT2dxVGdKbGkxaDRX?=
 =?utf-8?B?YkRURzlRM1lyK2RtS1VpMm53RDFLWFhTekJkclFPN0ZsWmVLd0pKYUo0U3NQ?=
 =?utf-8?B?cmJJRmFLc2hkWjk3WFBIa2dSNTZ5bzZXZlMwNXgwb0oraE1HNzM0T01Yam5h?=
 =?utf-8?Q?65LuDE6PAwq1U94QI3l4RDzAMoOZvwjuzyOnyvUoLcyg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1RhOVRTSVBlUzRDdXZpdzJPandtVHcwaDB4TnpmWGhZYzN2N2JRdEZadm1y?=
 =?utf-8?B?ZVZsdHFGa21ITDlibmVuOE8yVkJHUzJCQkQrakpETy9MekRGNko1c2RudHVw?=
 =?utf-8?B?QUYzRHlaY3VFY2VuS21kb3VyUVJTenpyQTg0ZW90T3dCZVU3UlFnZ3l4V2NP?=
 =?utf-8?B?RS9Ic2I1dzNwRjZCdVRmNTBHNlQ1RG95MnZjaitoNHQ2U3ZGbVNpRUo3WXVk?=
 =?utf-8?B?RFg4VkF6d2NOUzk2YU9VQ0gzdnhHZmdvdkJmNG9NL0hud1pteW1EdkV0VEFm?=
 =?utf-8?B?VWtMZFpCSWdMc04vYlhMeE5SaUNYVFhFbllFUmFKaTh6OU53NnU2SnNUaVdh?=
 =?utf-8?B?MU8yVmhLTTFQVHpmbmJNMUk4ekJuL3k3RG0wUm52d3ZwdkJTTksyd0FtNVBn?=
 =?utf-8?B?MTVzSFNjUVpmQ0JWdGlZSlBzR2ZWZGl4OWxPdk9TVWRnQ1NYTmZsNnJsTUt3?=
 =?utf-8?B?OTBtSDlzcE8yMUhMY2g0QTZpNkg5bFRzdGRHODhhTGdJOFJiNEdqbElCZmpx?=
 =?utf-8?B?MUxDMG4yQXk0dHlqV3prL1VxVERhL0VlMjZlNDg3R2pEYjlibXplL1hobXEw?=
 =?utf-8?B?c1JuRnA1YXpQOHV2U2thZlVBMUhjc1JPeEV4aDhCRE1pamorR3YxZmRtamtG?=
 =?utf-8?B?dGt2UGR2cms2NzAwRXJJT29ENlNXM2xKNmJaajVxMCtvRkp4M2lrbUlmcy9Q?=
 =?utf-8?B?NUVjeVJ0cEhiTmE2aysrMUhvRUNDS3V6L2s1YTNyZkpVY3lSOUUyaXRpay9H?=
 =?utf-8?B?cm02cndrZkV5WEQrVER4Qm96cUxxNVJzc2NYZW51YVBxa2I0S2MvM0VzV2FE?=
 =?utf-8?B?S24yNHU3SWZiaXg5dWprdnNIMUVGeW9KT2xRbEE4ZjhHQ2hHenFYNitReWU5?=
 =?utf-8?B?NUpJMnA3djkxZmVjbENCQWdpeGFGcnlqVFJLYkwwZUMxWUpwYlFJTDdpUGIr?=
 =?utf-8?B?ZlNqODArMTdXODJrMk0xeHgvVXFPeXJsa29NWmU1aHlhSGhjTW5mbGF5VFBs?=
 =?utf-8?B?RC9lTHc4bURMU0F1aWM3dW5nVDZEVjhqVzh4TlZJV1JkSUR1SGtYd1JSb2Vz?=
 =?utf-8?B?eXYzT3gzQXdyejFPdFRTUFZXMEpFNnhDWFBWdEhhSVdHNXlROGJmODNmSFhX?=
 =?utf-8?B?VnVVRkp4MHNidTByTmpoM3pNUmFSV2Z5eWt6Szhqb0FQWENOektKTlBTa3RD?=
 =?utf-8?B?Sk9CcTc0ZldSV2g3NjlmY2syZnp2bmluTVlxL3pYM3cycHRSQnk4TU1WanhH?=
 =?utf-8?B?TmoweXpsdmtRRG9EOWlJTjFNYVJITDZNcFBvOVBwc1l2UHVnQkFYZjBYa0Vo?=
 =?utf-8?B?Ym5vcWpCUm1Fb3ZmbnU0Njd3ZWtJZ05NWkhnV1hLMzFYR1Z1NlVtODQ5aTRw?=
 =?utf-8?B?MXo0ZUFLLytEajR0TVRpdGdFbUxqR0FJa2Z3YTFNUjRCbFNTdGg5b1Rqd2Nx?=
 =?utf-8?B?MmdqTkZBTG9wVVNsNzh4VUltaFFHSHBKR0tmVmcvUktlVk11MGhRaUVGc3Ex?=
 =?utf-8?B?cXZZU2Mxem9jM0pVcEpydmFBdjZscWxiWmdLZkRLbk01cHdIZVB4c1Q4ZFF0?=
 =?utf-8?B?dnNQajQ2NXVTWXNoUXAzL3JDem5WQTg4d1dXT3gzSlNCSGV4SzNXWjZMLy9q?=
 =?utf-8?B?QklxdHZjeUNuQUdIVVJxc0NPc3Y3THo2aFJFdDdza0MwL1g4WmpHLzJEUldL?=
 =?utf-8?B?ZXJ3bjgwcDJ0OGJ6Qnl2TTFEZ2libHpEUFhFbERoOEJhc2lzNVV1WEl0emZI?=
 =?utf-8?B?aWVqdnZwditWSE5zU0JXeEdXbXVMRWF5UzRnNCszanRUSE52QnJBVTlnMmUz?=
 =?utf-8?B?UHNtVWpyUVROQU9YNmROSGFYUWhiS2NPYkRBSEhZekFKcm5IMkl5TXg3WFN5?=
 =?utf-8?B?VkMzQU9QRlZ1RlJWSVhUejVEaHovcXhFRmJUTkZvVzlnMk9vYTVrUmsvU2Va?=
 =?utf-8?B?SHlObFV1Qk41aVBzR1lQSmNXb1pidmhYUUw2OTlXWkN0OHFLbXhKcnp5eHBM?=
 =?utf-8?B?ejIybE8zK2crdldUOUtMa3FBa2xwV29HUlprSHZtWWNMaE9LZFVXbStKdFNB?=
 =?utf-8?B?b2tIcUFtQlFFM2FLVTVCNDlnZzJkaitwNEl3Y3ZNZjdrRzZhWmcxMVRRa3pi?=
 =?utf-8?B?RGMvWFNHcHA0RnptMlhsYmxSZVRNQmhCY3UvTkdBdGxpQ1h6anFJNWZVUlhq?=
 =?utf-8?B?Q2pBa3FGa2J3ZjI2Rk5WR3NIcVhiQ3V1ZG1KODRCaGNjSzRWMUpKUnJoVjBh?=
 =?utf-8?B?dlJUZDQvbFI2ZFBwYjNKNjZEK3F3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MIkh2hYda6MK7J77WPaegTCw2/74dLa3F1IZZ/qePCP6VCKcjwsgeiqRSfSORjqPi8EWo+etwfEMM4FFkUTUpOWkslWMjwyfvghIIPt1cXoxoNrbZ69RLFHuXDpjV4rxpo1gXs6eOA59VJ9SujBz0T4HG9fFvrzOqDRRNAKItVycAmtf54veNLLxwIMK7+EqhU415uSjAaagrqlLdQOlv4WLJCyYt2ECzXunT96xwYRgPAPMXyC14PPLvxEsDGixuweDcuQm/r/xmi4AAqi4TMRelZ71gmJLPVBhNx8Z8Lv1FD1a3cFXK6A0bYEU6TptDsq6ZV214QxN1FjcJWE3XISW7W0OzDmxbAxATYMUD0o9M0UhuaAjFV7+At5HUu0ACdDw2i7uhdaIAbgUIpYrrlDHnl4eYYAFZUQDHJ7KM/+j0YqWHL5dtWMcIIH6+TQeSBEHqy8L68CeQl0EUd520mu3oHiflAWDoiIKF2N2nO6RLDLpwkrViEnClZJNDDdaVnKkd6R/zfuMXz3IzqQWKHLI+1GiXsO3zwcD53y76GrGf3cjE0s9ayg8mRPH2/GeSEY4mJjJdsmlphJKhnuy+6H0A9xK/Piqh0KYC02QuvQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c20c67-26e7-4255-6795-08dce30b7b1d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 17:56:03.2083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g40WwT8fomiFu6GZxfaPvfgF6hREqcn9rprq4kIvCaSX+ujHOPSi5eEZERWbFZKaJP6NA8z7O/+xZwDTa0KTbMPPUNB2wMTMXeg/VxrkOUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5161
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_18,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2410020129
X-Proofpoint-GUID: mtPrtIJ1v5Sagpny1XWVPNE-rt7i3bMV
X-Proofpoint-ORIG-GUID: mtPrtIJ1v5Sagpny1XWVPNE-rt7i3bMV

Thanks for your report!

On Wed, Oct 02, 2024 at 10:34:32PM GMT, Mikhail Gavrilov wrote:
> On Wed, Sep 25, 2024 at 3:28 AM Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:
> >
> > Hi,
> > I am testing kernel snapshots on Fedora Rawhide and Today with build
> > on commit de5cb0dcb74c I saw for the first time "KASAN:
> > slab-use-after-free in m_next+0x13b".
> > Unfortunately it is not clear what triggered this problem because it
> > happened after 21 hour uptime.
> >
> > Full trace looks like:
> > input: Noble FoKus Mystique (AVRCP) as /devices/virtual/input/input26
> > ==================================================================
> > BUG: KASAN: slab-use-after-free in m_next+0x13b/0x170
> > Read of size 8 at addr ffff8885609b40f0 by task htop/3847
> >
> > CPU: 14 UID: 1000 PID: 3847 Comm: htop Tainted: G        W    L
> > -------  ---  6.12.0-0.rc0.20240923gitde5cb0dcb74c.9.fc42.x86_64+debug
> > #1
> > Tainted: [W]=WARN, [L]=SOFTLOCKUP
> > Hardware name: ASUS System Product Name/ROG STRIX B650E-I GAMING WIFI,
> > BIOS 3040 09/12/2024
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x84/0xd0
> >  ? m_next+0x13b/0x170
> >  print_report+0x174/0x505
> >  ? m_next+0x13b/0x170
> >  ? __virt_addr_valid+0x231/0x420
> >  ? m_next+0x13b/0x170
> >  kasan_report+0xab/0x180
> >  ? m_next+0x13b/0x170
> >  m_next+0x13b/0x170
> >  seq_read_iter+0x8e5/0x1130
> >  seq_read+0x2b4/0x3c0
> >  ? __pfx_seq_read+0x10/0x10
> >  ? inode_security+0x54/0xf0
> >  ? rw_verify_area+0x3b2/0x5e0
> >  vfs_read+0x165/0xa20
> >  ? __pfx_vfs_read+0x10/0x10
> >  ? ktime_get_coarse_real_ts64+0x41/0xd0
> >  ? local_clock_noinstr+0xd/0x100
> >  ? __pfx_lock_release+0x10/0x10
> >  ksys_read+0xfb/0x1d0
> >  ? __pfx_ksys_read+0x10/0x10
> >  ? ktime_get_coarse_real_ts64+0x41/0xd0
> >  do_syscall_64+0x97/0x190
> >  ? __lock_acquire+0xdcd/0x62c0
> >  ? __pfx___lock_acquire+0x10/0x10
> >  ? __pfx___lock_acquire+0x10/0x10
> >  ? __pfx___lock_acquire+0x10/0x10
> >  ? audit_filter_inodes.part.0+0x12d/0x220
> >  ? local_clock_noinstr+0xd/0x100
> >  ? __pfx_lock_release+0x10/0x10
> >  ? rcu_is_watching+0x12/0xc0
> >  ? kfree+0x27c/0x4d0
> >  ? audit_reset_context+0x8c5/0xee0
> >  ? lockdep_hardirqs_on_prepare+0x171/0x400
> >  ? do_syscall_64+0xa3/0x190
> >  ? lockdep_hardirqs_on+0x7c/0x100
> >  ? do_syscall_64+0xa3/0x190
> >  ? do_syscall_64+0xa3/0x190
> >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > RIP: 0033:0x7f4190dcac36
> > Code: 89 df e8 2d c1 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75 15
> > 83 e2 39 83 fa 08 75 0d e8 32 ff ff ff 66 90 48 8b 45 10 0f 05 <48> 8b
> > 5d f8 c9 c3 0f 1f 40 00 f3 0f 1e fa 55 48 89 e5 48 83 ec 08
> > RSP: 002b:00007ffcde82b690 EFLAGS: 00000202 ORIG_RAX: 0000000000000000
> > RAX: ffffffffffffffda RBX: 00007f4190ce3740 RCX: 00007f4190dcac36
> > RDX: 0000000000000400 RSI: 000055bf5e823a20 RDI: 0000000000000005
> > RBP: 00007ffcde82b6a0 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000202 R12: 00007f4190f44fd0
> > R13: 00007f4190f44e80 R14: 000055bf5e823e20 R15: 000055bf5ecc9160
> >  </TASK>
> >
> > Allocated by task 176289:
> >  kasan_save_stack+0x30/0x50
> >  kasan_save_track+0x14/0x30
> >  __kasan_slab_alloc+0x6e/0x70
> >  kmem_cache_alloc_noprof+0x15a/0x3d0
> >  vm_area_dup+0x23/0x190
> >  __split_vma+0x137/0xd40
> >  vms_gather_munmap_vmas+0x29d/0xfc0
> >  mmap_region+0x35a/0x1f50
> >  do_mmap+0x8e7/0x1020
> >  vm_mmap_pgoff+0x178/0x2f0
> >  __do_fast_syscall_32+0x86/0x110
> >  do_fast_syscall_32+0x32/0x80
> >  sysret32_from_system_call+0x0/0x4a
> >
> > Freed by task 0:
> >  kasan_save_stack+0x30/0x50
> >  kasan_save_track+0x14/0x30
> >  kasan_save_free_info+0x3b/0x70
> >  __kasan_slab_free+0x37/0x50
> >  kmem_cache_free+0x1a7/0x5a0
> >  rcu_do_batch+0x3fd/0x1120
> >  rcu_core+0x636/0x9b0
> >  handle_softirqs+0x1e9/0x8d0
> >  __irq_exit_rcu+0xbb/0x1c0
> >  irq_exit_rcu+0xe/0x30
> >  sysvec_apic_timer_interrupt+0xa1/0xd0
> >  asm_sysvec_apic_timer_interrupt+0x1a/0x20
> >
> > Last potentially related work creation:
> >  kasan_save_stack+0x30/0x50
> >  __kasan_record_aux_stack+0x8e/0xa0
> >  __call_rcu_common.constprop.0+0xf4/0x10d0
> >  vma_complete+0x720/0x10b0
> >  commit_merge+0x42a/0x1310
> >  vma_expand+0x313/0xad0
> >  vma_merge_new_range+0x2cd/0xec0
> >  mmap_region+0x432/0x1f50
> >  do_mmap+0x8e7/0x1020
> >  vm_mmap_pgoff+0x178/0x2f0
> >  __do_fast_syscall_32+0x86/0x110
> >  do_fast_syscall_32+0x32/0x80
> >  sysret32_from_system_call+0x0/0x4a
> >
> > The buggy address belongs to the object at ffff8885609b40f0
> >  which belongs to the cache vm_area_struct of size 176
> > The buggy address is located 0 bytes inside of
> >  freed 176-byte region [ffff8885609b40f0, ffff8885609b41a0)
> >
> > The buggy address belongs to the physical page:
> > page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x5609b4
> > head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> > memcg:ffff88814d36d001
> > flags: 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
> > page_type: f5(slab)
> > raw: 0017ffffc0000040 ffff888108113d40 dead000000000100 dead000000000122
> > raw: 0000000000000000 0000000000220022 00000001f5000000 ffff88814d36d001
> > head: 0017ffffc0000040 ffff888108113d40 dead000000000100 dead000000000122
> > head: 0000000000000000 0000000000220022 00000001f5000000 ffff88814d36d001
> > head: 0017ffffc0000001 ffffea0015826d01 ffffffffffffffff 0000000000000000
> > head: 0000000000000002 0000000000000000 00000000ffffffff 0000000000000000
> > page dumped because: kasan: bad access detected
> >
> > Memory state around the buggy address:
> >  ffff8885609b3f80: 00 00 00 00 00 00 00 00 00 00 00 00task_mmu 00 00 00 00
> >  ffff8885609b4000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > >ffff8885609b4080: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fa fb
> >                                                              ^
> >  ffff8885609b4100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >  ffff8885609b4180: fb fb fb fb fc fc fc fc fc fc fc fc 00 00 00 00
> > ==================================================================
> > Disabling lock debugging due to kernel taint
> >
> > > sh /usr/src/kernels/(uname -r)/scripts/faddr2line /lib/debug/lib/modules/(uname -r)/vmlinux m_next+0x13b
> > m_next+0x13b/0x170:
> > proc_get_vma at fs/proc/task_mmu.c:136
> > (inlined by) m_next at fs/proc/task_mmu.c:187
> >
> > > cat -n /usr/src/debug/kernel-6.11-8833-gde5cb0dcb74c/linux-6.12.0-0.rc0.20240923gitde5cb0dcb74c.9.fc42.x86_64/fs/proc/task_mmu.c | sed -n '182,192 p'
> >    182 {
> >    183 if (*ppos == -2UL) {
> >    184 *ppos = -1UL;
> >    185 return NULL;
> >    186 }
> >    187 return proc_get_vma(m->private, ppos);
> >    188 }
> >    189
> >    190 static void m_stop(struct seq_file *m, void *v)
> >    191 {
> >    192 struct proc_maps_private *priv = m->private;
> >
> > > git blame fs/proc/task_mmu.c -L 182,192
> > Blaming lines: 100% (11/11), done.
> > a6198797cc3fd (Matt Mackall            2008-02-04 22:29:03 -0800 182) {
> > c4c84f06285e4 (Matthew Wilcox (Oracle) 2022-09-06 19:48:57 +0000 183)
> >  if (*ppos == -2UL) {
> > c4c84f06285e4 (Matthew Wilcox (Oracle) 2022-09-06 19:48:57 +0000 184)
> >          *ppos = -1UL;
> > c4c84f06285e4 (Matthew Wilcox (Oracle) 2022-09-06 19:48:57 +0000 185)
> >          return NULL;
> > c4c84f06285e4 (Matthew Wilcox (Oracle) 2022-09-06 19:48:57 +0000 186)   }
> > c4c84f06285e4 (Matthew Wilcox (Oracle) 2022-09-06 19:48:57 +0000 187)
> >  return proc_get_vma(m->private, ppos);
> > a6198797cc3fd (Matt Mackall            2008-02-04 22:29:03 -0800 188) }
> > a6198797cc3fd (Matt Mackall            2008-02-04 22:29:03 -0800 189)
> > a6198797cc3fd (Matt Mackall            2008-02-04 22:29:03 -0800 190)
> > static void m_stop(struct seq_file *m, void *v)
> > a6198797cc3fd (Matt Mackall            2008-02-04 22:29:03 -0800 191) {
> > a6198797cc3fd (Matt Mackall            2008-02-04 22:29:03 -0800 192)
> >  struct proc_maps_private *priv = m->private;
> >
> > Hmm this line hasn't changed for two years.
> >
> > Machine spec: https://linux-hardware.org/?probe=323b76ce48
> > I attached below full kernel log and build config.
> >
> > Can anyone figure out what happened or should we wait for the second
> > manifestation of this issue?
> >
>
> Finally I spotted that this issue is caused by the Steam client.
> And usually happens after downloading game updates.
> Looks like Steam client runs some post update scripts which cause
> slab-use-after-free in m_next.

Yeah similar issue being investigated elsewhere,

See
https://lore.kernel.org/all/c63a64a9-cdee-4586-85ba-800e8e1a8054@lucifer.local/
for latest update.

This is ongoing, but also steam, also this commit and also related to steam
update doing something strange, so strange I literally can't repro locally :)
but Bert in that thread can.

We can reliably repro it with CONFIG_DEBUG_VM_MAPLE_TREE, CONFIG_DEBUG_VM, and
CONFIG_DEBUG_MAPLE_TREE set, if you set these you should see a report more
quickly (let us know if you do).


Also note that there is a critical error handling fix in

https://lore.kernel.org/linux-mm/20241002073932.13482-1-lorenzo.stoakes@oracle.com/

Which should get hotfixed soon.



>
> Git bisect found the first bad commit:
> commit f8d112a4e657c65c888e6b8a8435ef61a66e4ab8 (HEAD)
> Author: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Date:   Fri Aug 30 00:00:54 2024 -0400
>
>     mm/mmap: avoid zeroing vma tree in mmap_region()
>
>     Instead of zeroing the vma tree and then overwriting the area, let the
>     area be overwritten and then clean up the gathered vmas using
>     vms_complete_munmap_vmas().
>
>     To ensure locking is downgraded correctly, the mm is set regardless of
>     MAP_FIXED or not (NULL vma).
>
>     If a driver is mapping over an existing vma, then clear the ptes before
>     the call_mmap() invocation.  This is done using the vms_clean_up_area()
>     helper.  If there is a close vm_ops, that must also be called to ensure
>     any cleanup is done before mapping over the area.  This also means that
>     calling open has been added to the abort of an unmap operation, for now.
>
>     Since vm_ops->open() and vm_ops->close() are not always undo each other
>     (state cleanup may exist in ->close() that is lost forever), the code
>     cannot be left in this way, but that change has been isolated to another
>     commit to make this point very obvious for traceability.
>
>     Temporarily keep track of the number of pages that will be removed and
>     reduce the charged amount.
>
>     This also drops the validate_mm() call in the vma_expand() function.  It
>     is necessary to drop the validate as it would fail since the mm map_count
>     would be incorrect during a vma expansion, prior to the cleanup from
>     vms_complete_munmap_vmas().
>
>     Clean up the error handing of the vms_gather_munmap_vmas() by calling the
>     verification within the function.
>
>     Link: https://lkml.kernel.org/r/20240830040101.822209-15-Liam.Howlett@oracle.com
>     Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>     Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>     Cc: Bert Karwatzki <spasswolf@web.de>
>     Cc: Jeff Xu <jeffxu@chromium.org>
>     Cc: Jiri Olsa <olsajiri@gmail.com>
>     Cc: Kees Cook <kees@kernel.org>
>     Cc: Lorenzo Stoakes <lstoakes@gmail.com>
>     Cc: Mark Brown <broonie@kernel.org>
>     Cc: Matthew Wilcox <willy@infradead.org>
>     Cc: "Paul E. McKenney" <paulmck@kernel.org>
>     Cc: Paul Moore <paul@paul-moore.com>
>     Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>     Cc: Suren Baghdasaryan <surenb@google.com>
>     Cc: Vlastimil Babka <vbabka@suse.cz>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>
>  mm/mmap.c | 57 +++++++++++++++++++++++++++------------------------------
>  mm/vma.c  | 54 ++++++++++++++++++++++++++++++++++++++++++------------
>  mm/vma.h  | 22 ++++++++++++++++------
>  3 files changed, 85 insertions(+), 48 deletions(-)
>
> --
> Best Regards,
> Mike Gavrilov.

