Return-Path: <linux-fsdevel+bounces-42415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D53B4A422F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 15:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96189188F5D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 14:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A69713B298;
	Mon, 24 Feb 2025 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G+4o+AgF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q99vQOS6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9706612F5A5
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406926; cv=fail; b=SDWUv8T7lP9SflXgMYVfpkYptDWc8Vny8IKCVJD/0wBzUt0/x0t1HWqNKJQakKmEdtI/LvBFpN6MQbi3b/Sr4YoZk5uwgooEhwesA6VwrR+8ZxkhsW1e16lmbVl8EQNwyxjozaQ+8xK9r1zEuUpnD0Cm2CkxCTPpJ5BLXcb9CWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406926; c=relaxed/simple;
	bh=4KR6wtlxr5mWWuhYrNj3/tPBjcB2b8qqkIYr4URE4IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i149Kq6DhBm/NlOzpzmJcdg2PInJ2u2GmBVA5BLf4I/HqAkHRI0CiWPhtzaUBA3xONNdoDEBMUz5mZaLXeiVN9EDXuCUy6rrK9uIOEJ2MDVl/kIwGB7RzbnnEENbxszmrWpS2jchlcKX/mwYV1xrt2wjM8zAKJRjYuXSKyx11kY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G+4o+AgF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q99vQOS6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OBMrMi017699;
	Mon, 24 Feb 2025 14:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=lBiRoLJtwZ0s231VKCLPxC/E1Zd5gN6WS5QCv5t7rl0=; b=
	G+4o+AgFIM5QdmLHdLhdImWRLPPxALAmJzimr1Sj+qM9wFXVqHHaw/29FaCS0reK
	Sj4mgoiu+5h7QNMt4pqWuroNPEgDebL78Q1pRmncOS+zu8pBjlKWSnyERKsLZYm+
	KrRIkYiwzraqQGB/dtCfW/ccRmUwfVprmy8obSBypS04rxJkgtq2/NLtL/ye/bNe
	8OD7ukxjlY1rWBJ73ZGUFxxC6XYNZu49I+kJhb3M3THtRTqWj3Qxr0c9IfW7Uv9A
	6j//+ODeRyAhJ2oyRch2WbmdSwfICbbTiyFeVaBcYwXZA6B+pIZdf8g3uQLQug4n
	FBoRnWSw0VfkG5YiIFFEDQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5602nrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 14:21:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51OChTSl002726;
	Mon, 24 Feb 2025 14:21:46 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y517y1qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 14:21:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYl27ULn4LLQ/Rl1021SfC5qvlsQKncAvBD57lIAZ79EyOuIscKmpmHvZbt6/jyIEMfFrS0aYrQGpvmebXK96fpeEUrBdRk1eK7IhZtJ34sKi7lFnHvQl45wpA2riFNpUBTo4pARHT5TDBsAYrHqe55fzXCvpnVtheTybkFZ/D6giyyblAHmXdsxXhfaBINbGsmSQzpsEy+IzMUVySI+1AjrEfxc1Vz/cjtEHCDI6BPvITR321zwuU7bDkm35CxFZCRZ6/eW/bhSMo36YnIL/4m0b+E5yXVIJz/dp6vcabXpojY/eSUMEBW1ZXVNBf0k0A2k//wSv+ARPOh7YWaVzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBiRoLJtwZ0s231VKCLPxC/E1Zd5gN6WS5QCv5t7rl0=;
 b=d67813LihIVlCNX0kZx0/+p8Q0/A+XVAytMdqLfs0oF8UY9sHyB5JrePui9QI5Oyk6EVkopN3O3rU9rnAUsjkeWi5+g2KRKjTgphNlWUcdwA+QsiE64DQ1hWI1hk0LUu51iDrM+y17bU0p8HJSgeIyjlig6EDV0LmA9/ep3gPTxz3j98MutD4SkOz6tJoGx1Cje3/i6CHqJFCF48oTQ/+mJMEDVrchTVIWSsaCdqH0qXqJmTWC6y8gQtdQsSEUuT5tq0yYLdF43LIgTr2d6PpMRwlvomQR+55YFjvfZ7Zc3NUsUlpRclUcQ3Tu+nP2PaPlFf+k715AuEN+r5zwj8dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBiRoLJtwZ0s231VKCLPxC/E1Zd5gN6WS5QCv5t7rl0=;
 b=Q99vQOS6KjrH2puY03hwFFcvWCnX8uMUFCO3sfiL8UCyYFNVrFpcD48B0wIWh8GzoTfWIvjQeKdUMr+6a3aTZTrHAssRAdpNPWUZIoE/OM8L2tWWW1IrDj/dDh6U7fGYxL+66fX73dd8AI2l3MA5hDgV/+ErZceqZfsIkbZAqBs=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by MW4PR10MB6299.namprd10.prod.outlook.com (2603:10b6:303:1e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Mon, 24 Feb
 2025 14:21:39 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 14:21:39 +0000
Date: Mon, 24 Feb 2025 14:21:37 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jan Kara <jack@suse.cz>
Cc: Kalesh Singh <kaleshsingh@google.com>, lsf-pc@lists.linux-foundation.org,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        David Hildenbrand <david@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Juan Yescas <jyescas@google.com>, android-mm <android-mm@google.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Optimizing Page Cache Readahead
 Behavior
Message-ID: <3bd275ed-7951-4a55-9331-560981770d30@lucifer.local>
References: <CAC_TJvfG8GcwG_2w1o6GOTZS8tfEx2h9A91qsenYfYsX8Te=Bg@mail.gmail.com>
 <hep2a5d6k2kwth5klatzhl3ejbc6g2opqu6tyxyiohbpdyhvwp@lkg2wbb4zhy3>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <hep2a5d6k2kwth5klatzhl3ejbc6g2opqu6tyxyiohbpdyhvwp@lkg2wbb4zhy3>
X-ClientProxiedBy: LO2P265CA0180.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::24) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|MW4PR10MB6299:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bf4763e-b388-4b12-5447-08dd54de8dce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzdrZ21CMXhSZHBjbWJSbkc4VlQrRm9IdHU2VDJ2bk4yRllud0lOMmNRbVhk?=
 =?utf-8?B?R0ZGSEZ0SUt2N1Y0TkhaTmU4T2NINlhzVlNuV1VJZmZuSW1hcVlJQUVkM1pN?=
 =?utf-8?B?bDE4OG9PZFAvV25VNzlMb2VOZFAzWkZMWFhYVkhmT3ZqQ0h6SnVkbUpJQXBH?=
 =?utf-8?B?T0RSME5CeEkzOVZBT3lRNWU5eVNFRHZlQVdmYnJuWXduQUdIWnUrclM4bENp?=
 =?utf-8?B?Y2lVNXd4dldhdU1jVHRJRFhIWnhIQ21BcHJocXdEU05mVDZxOWJ3dCtueHlV?=
 =?utf-8?B?YVIyM2NhZFlYSjdaOElRM0ZtSEE5MjBPSFhNeTkraHduNkhwbnBJT1VuKzNn?=
 =?utf-8?B?R1I1ZmhKYVJUL3lpNkJ3alZZM1hSeW0rR3FMSEVCaHZPWERBWlZsaXdBc2JC?=
 =?utf-8?B?TW1HQ1NXZGxZMlowb2NIYzIrZGhOQVBqUmNWRmVnc05ZVXdlWWF5U0lBZEdp?=
 =?utf-8?B?SlQvQ3lqMmh6OGQ4VGN3bmd6anczUGs0MjJ2OG05MmJhZVByaitGcm1nYm03?=
 =?utf-8?B?c25HcWFrT1ZYM3pMekEreU9ySFVvZVRlRWo5WmFEc216cjJBckUyaEMxS3RE?=
 =?utf-8?B?UG1IZ21Gb1lzNnJ0ajR1M3N2bkJHU3cvNThMZHJzUjVmdVgzTkN0Q1U3QXNO?=
 =?utf-8?B?WnVLaFVQUWhrNi9PbDJuK1hmMWRkN3lZM3U1dTFZYVNYUnN2MlRyU3BrYTdy?=
 =?utf-8?B?aGZhdE1jTnhPRUxzMlVsbUNiWCtNdW5RSmdXSklXVWxWRkxlb2puaUU0ZE5E?=
 =?utf-8?B?ZzVLU0VaNGtNUkswRDhiSTFKdHF4VHVGaDFUelJOeGx0TkN6d3JRMU8vM1g4?=
 =?utf-8?B?VXNiNUd2azdlM3FGVFZydktEdWhEQTdJbW1POUJvQ3dPSERtRXY5d0F2ek9v?=
 =?utf-8?B?L05oeUd6WExtbWUva2t1dm02cFFVYzllZnJaY3FYMVU1VnZhRlRJSnRGWkNR?=
 =?utf-8?B?aXpLdWVHUlhvMWJlcEQwbWZBcFRPVGVmWGhac2xOTXkyTFdWemx6aWZLZDh2?=
 =?utf-8?B?bklIeG03Nk5RSFBGbzlvb1JoK1JoVmIrL2dvRU5CSmRob0V4NFZlMGhocU1m?=
 =?utf-8?B?bzNmREgrUWU5UGo4dUtrc0tUaDlONHAvUEt3RkNpVitLZHJzQUtBVmorQ1Rk?=
 =?utf-8?B?Zjg4d1JIUWM2dFJxa2VSakYwcUlWcXhYamNjcTJmQlAzNmYzOGdVTTRQRE9W?=
 =?utf-8?B?NGNodGhVaDJEdXZkSHFoRWRYNGxEb1RGM01FYnkxV2RRMThJbXFtR0k0enl4?=
 =?utf-8?B?WS9LQVZJZWVqSTdNd1FiUTc5bDJqbHlndHpGYmNEWXAvWk83b2hWMXh2Tzdi?=
 =?utf-8?B?Z0RMTWZ5dU14cHNtZjJjWExaRmtadVlVeU93RmJoZHlpc3VsSll0SjNqT1F4?=
 =?utf-8?B?b1JqeXlqRFdDN2RtTGZDNVpZbHVMS21rbG5Ta1N2QlpDczVDMkdhQ01RUURZ?=
 =?utf-8?B?cm96d1NQL0VJbzJLNWJhdWRPeGd0MFFlUmhqZ2ZOZ0htZVM5NGRKSWYyVzNa?=
 =?utf-8?B?V2gwRlhndkoyS0FBRUFMZWhiR09oWDNrTG5STTZSQzhQQ00wc1NKbWF3YVFT?=
 =?utf-8?B?RHMwaXovLzNVSklGNVU2RllPdDJmdVRXQzBYWEVFTTdlWUg5dy9FN2ltb25p?=
 =?utf-8?B?Undsb2VvUDBMVFRaUnVNeDFnRFVsblZIRFVpUVRHZVdTZWg4bzB5NURJeEdj?=
 =?utf-8?B?RGFUNTJ2RXlqN0hYN0pyZFZNODExRG5sNzdNMHcwMmd5V05GeHBzeEgzNGR3?=
 =?utf-8?B?MGtyWWgraUovT3hQQmJhRE5yVXNMckx5MnlWaDcyODVrZ3hUZGxpUG1OS3B2?=
 =?utf-8?B?VUxHbmkxNG01ZlYzMUpJTTZrdjY2NjBNeWVLaElJd1R4MUlKYndHMVFwWXpD?=
 =?utf-8?Q?Sw4Wyat5VauwM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2N1ejk1azQ1OXBwMnpnZ3NFSkQveldRQTd2ZWRyV1h0NWZWbGJZek1DaXBW?=
 =?utf-8?B?aEU4TzRKNlJGR1p2VnBLQzhnTjlKRmREb3lFam5SRWQ1UnErYWRjbEFyMjFx?=
 =?utf-8?B?NStOV21YWHBJSzhhbUJDTE5hTHUxNHBUNzljdk5KVnFmeUQwMW9udWdsN1hR?=
 =?utf-8?B?WlJxOWRuaElZMG9kSVNJRU9iRmdkZCs0V0NHdWV4SlNZSEIwRFlOY2hmSld2?=
 =?utf-8?B?am1qMXUxUS9yR2s1WkpicGFDT1c0eEdUQUlMOXlFNHViaXNPYnpFYzlkSXY2?=
 =?utf-8?B?ZVhjUjloU0RXL3RzWWNFcTJrSGtJbngwMFFEdStIM0U3ajY2cnEva0Z6SnRn?=
 =?utf-8?B?dGNNYWRLZi9UMHpEOCtMUnF3UmFPS0xQT3o2d2M1eVpLWHdQNTRiczFoV0RI?=
 =?utf-8?B?R0gvbW9sTVg0ZDl1Z1VkNkxzY21WdWpqYVl3NEJxSVptemY2RHdGNFgvbUVS?=
 =?utf-8?B?OWMvampHdEc5ZkdBSXVnQmJod2t1bHQxQlZ6K1ZBTzdVV1NBSnA0V1RCRVlW?=
 =?utf-8?B?b0pjcFk0OFpJQ210b2lmaDlWK2x5ZGhMZUxOQW9ualJBdGxGdHhQaUZXOXFP?=
 =?utf-8?B?Y0c4cDY3NVZJS0g5dXFEVFo4cHZJVk9kRjAvUXN0S3JuN2JEcDhiS3l0Mnc0?=
 =?utf-8?B?Y1o5enhmUWwzaGVIVytGUmczOHdMM2lkZDNkclRvNlpIazdvY3JqdE02d0p0?=
 =?utf-8?B?MFNxLzZWVkRGcXRrR2x4bGQrOURMU2FvTllxbFNJaEJOWmZzZWY1cTlGRzdD?=
 =?utf-8?B?K1FjT2szQU1rb3RFM2JHcFhFU241UURYMGRlY0I2TlZhckJybHk4a1BCNngz?=
 =?utf-8?B?a1FiSnNDbW02Vm5GRVBZWjVscVRrM1g3RUF1OXhUTjBEVHRSMGlzcVdhSmFK?=
 =?utf-8?B?d2pCYXFSa0NzWGEvZ2NVVWJVT0NvbmVvL1JEVTlndHphQzNwdFpPS3BnTFdQ?=
 =?utf-8?B?c2tvS1c1M2g3VWpLVXFobG93WmpaNnozSUk3Qjh4MjdFNlQ5UTdPSGFDTkVN?=
 =?utf-8?B?aG9ZYXlreVgvczBzTTY3WlpBcmp3MlRlQ0NkcGxRdDluWW1xVWtpL2N0c1kw?=
 =?utf-8?B?QlJZVll3SkhoTVRGOHUrRnNTcUdpVXBGU3pWd1R5b1d6QXdpOFFuU2g2bGg1?=
 =?utf-8?B?NGhNTGdSLy96YjFjeGJ5T3dzUGJ4M2FxVVZTSFJ0UXQ5bkpNZUh5YlFmSFRK?=
 =?utf-8?B?WG1FTW92anFIQjZmc0hZNW01SFRySmNDWEdVeEdkOVZaY0tvd1hMdUk0VXo5?=
 =?utf-8?B?ZVkxSG5uK2QyczlZclNicitVeFBEUWhseXNwRHpFRWxweEpnckxZV0xtSmdw?=
 =?utf-8?B?NjdsVkFESjZ2eEFJRTE3MWhwUWFWOTVhdlV2OTdUdlNNN3NSZkJ0V0hNVjRJ?=
 =?utf-8?B?UGNIOEoxaXdXMlBvMGFLbmFUYVp4aXFDMGczRXYwdDR6MlVKdFcrNUduYkNZ?=
 =?utf-8?B?RzF6WFI5R3REWmMzcWY4SGtEQmpJQVJOSkVjdER2MnlCdVFSR2VwVjloQ3lG?=
 =?utf-8?B?eGg4ME5jcXMyWTRFZHJQdW5FOXJPL1FWTlN6THNTZzlndWppaWpsci9TS0lk?=
 =?utf-8?B?ZjlCWTFyTHNCNFFjSmxiMkF3cWNpdjdSSWs3WDBqZHp4ZXFjbm1CV2l1RTR4?=
 =?utf-8?B?NCt2ejFIT3V5dEp5NEVuV3NrU0kxaEZoem9NOVEyWEpWUlYwZUtONThmc1g2?=
 =?utf-8?B?OUVxSHRKT0dySlFjUVR0blBhL2xuRnluNFI1WitCZWxoWmpyK0JCYy9MbHVj?=
 =?utf-8?B?QmZ6RFFVZ2I0ZVdXNkpKbWFST0N5R0JidEdpQ1o1K2YrZW5rK1ZKd0tJOEhT?=
 =?utf-8?B?OVBCKytmcEQwVDNyR2ZoQ0RRSjhNcTNIVXZsNHdlOE1iVlpDVnNBczEyRXY1?=
 =?utf-8?B?ajArVUNQaWkzakNsU05kamlDdUVWYWl6SHF6dUZaUWU5VnFCS2V1Z05LbFg1?=
 =?utf-8?B?Vkl3QzEvVmVha04xZ0JxT3ZtblZURExvL2JVbEppa1BhdVRMMEE5amJxRzkw?=
 =?utf-8?B?QlpXSEdKV3pwczYydXlTS1VWYm9SUERORWNsSy9GODVhMVpHYWhvNEJHb0du?=
 =?utf-8?B?ZDJYR2EvbmVTNG5zV0pBbDc4R1VnTTAzS2MwVlRHMFFnd0liUW82YjUvOGFh?=
 =?utf-8?B?eExlUzlaSDdNTWI0U2hpbjFLTEdITmRtRDFuRExQbVRHL05pU0ozMHFNY0x5?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	foxEjrI92NmARzZuyyDOkUuHwD3ZADnGlzcFUDlOt2B5vAZdujXmn++iDCOfrQBZz3nWlIrHZQ9Afqjo/qqu/h+f+CNYJTwguRfTaJQLvZ0p71G3irPeNcarK1hARmBAGZDcCWQ2ikmhtvJFM0dbOXTKAqUz4hht8/VhueSXYJbP2nNMQYp+LzTZUgzDMag5uaPU39mjPCcJBfk8AE/CM+4fchOpP6kon3gn8L/kTr/PjHhLiIZaR8aOk/4Fnw6Jx4awHwXi9v9/jDyld2q9RTwYfMbeHYFBKJcKTT475C5f+v9xaSn0/BUIMZN1N2XtCsvQcKIkuvf0f9oX+4jUaH13ONa6ecXL1v56FD/Kmknv6jT77MeKFHnure6ZzvwnweF1U5wiSpDKJnCfyjMwswvQSBVauujRVDtLh3C5UQUOIkAJUoComCVWQLn1OyW0JgXh9YJTOv8rOUd+Hmg4E1IsuT6vxlP7cQEibfJJ7hZBhQxOvUuNFNRzdq6b3nnXpwZGcXQ2NCQg3/uOG+UYUDTi6BEt8tIFCTLI1DIKlZIMIUIfD+nAdFljCQRyfTGxfJiBWk7UgPl68OfAszAfHMDgkfEZ2BclRXCw4TwcQ2k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf4763e-b388-4b12-5447-08dd54de8dce
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 14:21:39.6350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xdt0gIou1qNrif2zsKxeQsskBvbT1DdSJRTbR+DFh2ictfKpdwYwuVno7SP/+Pcqwje+3gHBRFDLfFe4yQR5YIerUm0k9Xe+N3lExDHptE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6299
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_06,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502240103
X-Proofpoint-GUID: nXjyy5w9E6Bdjoe2dyLWIMhOC2RhdcIx
X-Proofpoint-ORIG-GUID: nXjyy5w9E6Bdjoe2dyLWIMhOC2RhdcIx

On Mon, Feb 24, 2025 at 03:14:04PM +0100, Jan Kara wrote:
> Hello!
>
> On Fri 21-02-25 13:13:15, Kalesh Singh via Lsf-pc wrote:
> > Problem Statement
> > ===============
> >
> > Readahead can result in unnecessary page cache pollution for mapped
> > regions that are never accessed. Current mechanisms to disable
> > readahead lack granularity and rather operate at the file or VMA
> > level. This proposal seeks to initiate discussion at LSFMM to explore
> > potential solutions for optimizing page cache/readahead behavior.
> >
> >
> > Background
> > =========
> >
> > The read-ahead heuristics on file-backed memory mappings can
> > inadvertently populate the page cache with pages corresponding to
> > regions that user-space processes are known never to access e.g ELF
> > LOAD segment padding regions. While these pages are ultimately
> > reclaimable, their presence precipitates unnecessary I/O operations,
> > particularly when a substantial quantity of such regions exists.
> >
> > Although the underlying file can be made sparse in these regions to
> > mitigate I/O, readahead will still allocate discrete zero pages when
> > populating the page cache within these ranges. These pages, while
> > subject to reclaim, introduce additional churn to the LRU. This
> > reclaim overhead is further exacerbated in filesystems that support
> > "fault-around" semantics, that can populate the surrounding pages’
> > PTEs if found present in the page cache.
> >
> > While the memory impact may be negligible for large files containing a
> > limited number of sparse regions, it becomes appreciable for many
> > small mappings characterized by numerous holes. This scenario can
> > arise from efforts to minimize vm_area_struct slab memory footprint.
>
> OK, I agree the behavior you describe exists. But do you have some
> real-world numbers showing its extent? I'm not looking for some artificial
> numbers - sure bad cases can be constructed - but how big practical problem
> is this? If you can show that average Android phone has 10% of these
> useless pages in memory than that's one thing and we should be looking for
> some general solution. If it is more like 0.1%, then why bother?
>
> > Limitations of Existing Mechanisms
> > ===========================
> >
> > fadvise(..., POSIX_FADV_RANDOM, ...): disables read-ahead for the
> > entire file, rather than specific sub-regions. The offset and length
> > parameters primarily serve the POSIX_FADV_WILLNEED [1] and
> > POSIX_FADV_DONTNEED [2] cases.
> >
> > madvise(..., MADV_RANDOM, ...): Similarly, this applies on the entire
> > VMA, rather than specific sub-regions. [3]
> > Guard Regions: While guard regions for file-backed VMAs circumvent
> > fault-around concerns, the fundamental issue of unnecessary page cache
> > population persists. [4]
>
> Somewhere else in the thread you complain about readahead extending past
> the VMA. That's relatively easy to avoid at least for readahead triggered
> from filemap_fault() (i.e., do_async_mmap_readahead() and
> do_sync_mmap_readahead()). I agree we could do that and that seems as a
> relatively uncontroversial change. Note that if someone accesses the file
> through standard read(2) or write(2) syscall or through different memory
> mapping, the limits won't apply but such combinations of access are not
> that common anyway.

Hm I'm not sure sure, map elf files with different mprotect(), or mprotect()
different portions of a file and suddenly you lose all the readahead for the
rest even though you're reading sequentially?

What about shared libraries with r/o parts and exec parts?

I think we'd really need to do some pretty careful checking to ensure this
wouldn't break some real world use cases esp. if we really do mostly readahead
data from page cache.

>
> Regarding controlling readahead for various portions of the file - I'm
> skeptical. In my opinion it would require too much bookeeping on the kernel
> side for such a niche usecache (but maybe your numbers will show it isn't
> such a niche as I think :)). I can imagine you could just completely
> turn off kernel readahead for the file and do your special readahead from
> userspace - I think you could use either userfaultfd for triggering it or
> new fanotify FAN_PREACCESS events.

I'm opposed to anything that'll proliferate VMAs (and from what Kalesh says, he
is too!) I don't really see how we could avoid having to do that for this kind
of case, but I may be missing something...

>
> 								Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

