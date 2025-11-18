Return-Path: <linux-fsdevel+bounces-68813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 837E4C66CAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 02:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EC7A2353D41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 01:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081532FDC4D;
	Tue, 18 Nov 2025 01:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YE9cpcR+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qPtvIJe9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444912E11D1;
	Tue, 18 Nov 2025 01:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763428030; cv=fail; b=FSGWH8CF/11b31oEpzZyD2Tm55eTZvpBixQqwoOLQ+gvslZDkOxjzo+uYIpFqOYHs0rAIjTyH5jSiSqlh6jbgE2AvAok8YuVMb5Uabq8+a1kJWJWnfVrIkn32ETcc0nHKnAF2JmPlNDnpWsRtljRsfBrf7emmILz/8C7CbzaDgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763428030; c=relaxed/simple;
	bh=DoBRiTvZ8u2zHjJBvOo89WAOxphNyCEDCjE+r7J24z0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pMAct/Y6oltxL8TdpO7xdBClxcKQNRuQjfwqGVstzpJ7lWstIA++lAQdzDOZXU0WeHuLItZNCRVuo8SG5yL7tIEEUXZcdaFXfzScv/ZvkJ1nJdd6k/3Xa82ydzHMp5jq0Be8WjPJGIlJZkYpU1y5RZbqKA6FvQ4Pn5MNgA9AQKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YE9cpcR+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qPtvIJe9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHKubXr021408;
	Tue, 18 Nov 2025 01:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/ODyWo1S+pQEtH70YbilDYwHHHjpwXTv2mKzP/lsAbU=; b=
	YE9cpcR+t2KnO6dL7Y2Y+l45AyyIakgavm/FWMnZc6wv/YLdCu+sygw8c3pW+ssE
	MuHK8h6vM3CkqKfi3E8m8845F4XrY2nyOu+iDicXHPO/LNrJXx0lkosd7PV4tZ8e
	E8vE1XHVxwiacitQGCsTvHN1wfFRD5tX4mBAqacp0ri0I1Yv9W0qIqILm/JVpRLT
	Q4eZKKzksfSS3hyP6STx5332cNv6MK9KFJPIsBUmqgosTmUp4rKmg/q/ouZqY7oA
	/KNj90vSVrbtRWa5rkH1CX5gkxz3izkaPaoQqZBN8nSWBwZfuYvLVxcqenZrY0Gn
	g9QyWcZ1aN3t9sTdPaiEKQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbukrrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 01:05:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHMBRKr002488;
	Tue, 18 Nov 2025 01:05:33 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011069.outbound.protection.outlook.com [40.93.194.69])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefy8eb88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 01:05:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpDVt2I8/pEr32cuyfPV6SBI/0rmdtqMjTv25wQiar9On96uTK6CIr5671aOGpMi/IwxUzeUCYeDGH3L4eUMutJLRWWLRl80Uenm3B/nBE53YQZ1C1bhFMlHrMhsnh/wFK09c/f9RyVJNznEjWVoT/9me/BwzXEwfj65NtDTrl14R31AFgA5dFxqhix88VFSUewCYzU9Ow2AACoYWXc5wQ8akazz0SvmtXyt/M8SSde96R3rSbCK0xmJzWUHKF0xWILY0g7JWc+5FgF5XNZiBPJDIQiEzw6v64OBzmkdMj6Q7lg/wJ1NxAIabDVszaoG69hQ+nAcAN9lVUivQjNI3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ODyWo1S+pQEtH70YbilDYwHHHjpwXTv2mKzP/lsAbU=;
 b=x5Ah/r4xaq6oHM8V9/wpfMXbCZlBJKyuIiwpC2kLeytd2h+pikxosAKaCp8ykbYaPaJpN7Q1u6oMz3Ioxr4LcNkDZjw4saWjFyuzjvAEy0vV/NZZ9iG09ZvETzXjnYNdIU/kxmmzfsO79B6khO+gac8gaAU2Os8AiFvWTo/Q+dDbSz6ch8Fh6jc7WuzLyo8CYYSVu+uXlnB3Rf3biryzR/a3U7A+LF3bi6VxEpSkc2Z0Pq4Vted8cpEy8rp/Zp4dfmHpaB8JTR0XTC38W3OQ4IQ0xqWTLjke/qE93l3YWD9jt2E2JchGX0MjU/smnDfOoB4LCRMsW11SdRZav+s/OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ODyWo1S+pQEtH70YbilDYwHHHjpwXTv2mKzP/lsAbU=;
 b=qPtvIJe9XDpawBOifkJw3efMiMmLBKCMAxnlUXJvxkLmPndcMUubDj08tm0wffZbTUDylZoRNowBf8xXNzzrnwYqwN17ZcBUaJDpsCu3H2RjLgPmbrRhe64qo2ozeIClXjhT6mS1ZTuqtidD9i+BX46M1djmPHAdqDIe7qtI9NA=
Received: from DS0PR10MB7364.namprd10.prod.outlook.com (2603:10b6:8:fe::6) by
 DS0PR10MB8007.namprd10.prod.outlook.com (2603:10b6:8:203::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.22; Tue, 18 Nov 2025 01:05:30 +0000
Received: from DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::b7d7:9d3f:5bcb:1358]) by DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::b7d7:9d3f:5bcb:1358%6]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 01:05:30 +0000
Message-ID: <1c4b521a-f84c-4a3a-99f7-ecb9ace3baf1@oracle.com>
Date: Mon, 17 Nov 2025 17:05:26 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] mm: introduce VM_MAYBE_GUARD and make visible in
 /proc/$pid/smaps
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
 <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
References: <cover.1762531708.git.lorenzo.stoakes@oracle.com>
 <94d1e9c6c6dd8a4de1f2a8022ca92e2e320730ff.1762531708.git.lorenzo.stoakes@oracle.com>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <94d1e9c6c6dd8a4de1f2a8022ca92e2e320730ff.1762531708.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH3PEPF0000409E.namprd05.prod.outlook.com
 (2603:10b6:518:1::4e) To DS0PR10MB7364.namprd10.prod.outlook.com
 (2603:10b6:8:fe::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7364:EE_|DS0PR10MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ac287c3-c4b2-4031-3682-08de263e9155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZS93SXJTT3ArQ3BrQ3NxV29YN3dzeU1odGw5RGE4T0hwSldQVlphTkxCb1VC?=
 =?utf-8?B?bWhqREszNFBtRXRXblRucVVnYkFvckN2aWdwNXNpanRKUUdyS0lKMkFrUFNs?=
 =?utf-8?B?UzB1c0lLUVR5aTdvNGRJR1dQUGxkWVJYbnd1WkdmSEJPRS9xNzRjYkpMTlk2?=
 =?utf-8?B?WkE2N1pOcFl1ZU1QRzZzaFRvbS9zZmdISXBwL1p0YlBIWS9hM0dXaURONXMz?=
 =?utf-8?B?RlBlcEtFT0Z5dCtkQ0ZPcFc5dTZrRGpDU3N1RzJiWm1zd1QvOUV0VjM5d1l5?=
 =?utf-8?B?WVdBcC9YN3JaQnpTY0UyL2g4NEgvekViOFROMWZXblNaQ3EyMCtCL0dRbWM2?=
 =?utf-8?B?cEhqamZQREd4b2s1VEtwSW85Z0pPZjl4Y0ZyM2djSFprdmd4S3lseHhYSmRr?=
 =?utf-8?B?ejVqQ3hoYVcvMnBQZUc5MWdTWmJpa0VXNngxbVZ5d3cvMHdYZ1A0N3VoVTVG?=
 =?utf-8?B?Lzdra2E0Z3llVzRXNkpyd05qSFVDVTQwY0tEVGVxeTY4VXpxUXVyenJnS3B3?=
 =?utf-8?B?dWZpcnZ2K1Q3c2IrNERLYks2OXFEbEpoY3pPa2YxaitnQWtpSko4Q1NDU3px?=
 =?utf-8?B?clQrWlFKVm4zcEtzZ2pmM2MyUTVtSUJqYk9qeU1vUHI2MTd0QXIxcll0aWhv?=
 =?utf-8?B?VU1PbElyejR1YkFETWJlTmNxYTl3WnVtNnVjbDNDRzBxd3RRSW9NeW9vakI3?=
 =?utf-8?B?VTJWSTBaVlFVMjdSRFBEYUpkVERTMUluL3QrZ0l1YUZ0cFhSbXk3Sk1JNURO?=
 =?utf-8?B?Z3gxRXlpQU9lSFhxVnJQOEFDeFB3WXJoYnBGb2Q5SHkzd2JDWno4R0J5SFNJ?=
 =?utf-8?B?NVY1NS9CaWJlV1U4RnJGaEN4OGVnYnlEWkZnTkxjTnU0TnkwZnRCd3E2NHRk?=
 =?utf-8?B?aU1sb0lmeUlmRlNlYlo2NUVXKzVrbmNPcUJaRXUyZGhyN2pqNkhQdldRWXZw?=
 =?utf-8?B?OUY3YWRyUjd6MCt1ZDR2Wis0SkY1dWRUU3EwZXoxeERlczVKb0tIRG9zaUFM?=
 =?utf-8?B?eDFqR0Znc1NhdHovYjIzZGdTWlhyQy9kTFhlNFdtWTl1QThGb2RTc0V6WVYw?=
 =?utf-8?B?R3VwVmxBYmp6NDBiK1UwMy83TUpFUThGdm94TkVXRElyL05UWFdXRUFXV1Fx?=
 =?utf-8?B?K0xkM0ZwaWpINWc4ZHFqN3lKblpaK1gydExFWnVkb25IemNnbnFJME45Rnhh?=
 =?utf-8?B?QThTN2M3YWxJVU5NRGZNVEZqajZTQ3dmaWdNbm42TEw2MkxYNi9nRFdRRUw5?=
 =?utf-8?B?aDZCZWt3NFo0TW9IdzBzNGRWN0ZOdWQ4M2N5NkhBdVR1OVlNUjUxV3A1alJV?=
 =?utf-8?B?bjQzUUl0a2w3b29OeHB6OXVYNUt6OE0vbUFueitGcnBVYkhnVDFMemE0V29o?=
 =?utf-8?B?MmtndVcyZzg0NXdIVkd0dEova04rbnk5NVBUYTNndExaKzlIblE0allUazYw?=
 =?utf-8?B?SktZS3c5L3A0TTNSczhpOXZvbmpGOFRqTVpuR0NHOC8rcGZaUCtsLzBrN1Ew?=
 =?utf-8?B?QUdrSjdIbVhrM2NWTXNnTW1zOUs3WEM4Y1M0cHJENldTQWRVaHR4azFzR1pD?=
 =?utf-8?B?aFdGc1hhQmFXU2l2dEkvMWpMZXF5TFVkak5SVlo3THhvWTdrckgya1E1RkM4?=
 =?utf-8?B?N3JJeEEzT1MrNHhHTkJ3MEJJZUJ2VXZUSnFKOWN3Zmo5cTJzMjFCRjBwVHlO?=
 =?utf-8?B?S1ZOcUpEREo1ZFdDYWl2VFZEWFFnUVk3STMxY3p0NitWRTJsTExQMi9rOTd0?=
 =?utf-8?B?eXZuOXg4SUR3b0NxQW9tRkw1TUFDR2VyUlZVSkRsSlRVeEZTVFFCMWRRdW0y?=
 =?utf-8?B?VUNnNHpoMnVEb1RMc2w2TVErT0xYWmRLVUZkT1ROMS8wRlhoeEZZcWZWTjl2?=
 =?utf-8?B?K1JsTWxGcjdFQkhXaldMM0NzRlNBN1ppRFhpL0Q5NG8wSlZTSUdPbEpnVmJs?=
 =?utf-8?Q?OBSk7P0cgPzFfxfwk5jWeuSGN2+q9pFL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7364.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qzh3ZXRpNEN4WTlMZVhCem5YMUtWS0NLdDIybEpGbkRhWkV2TDVjbmRpcGd4?=
 =?utf-8?B?dGZrV0dOTVh6MzJEbUZzanhoYitkV1RDRU9TbUJwSVhLOXVVRkQ4cjBMaVp5?=
 =?utf-8?B?TDdJaGd1b2Z2VjJ1bWl1b1RKTUtJZHJqbW9HTlRiSTBhWGxLYWU4ekh1MEVQ?=
 =?utf-8?B?ZTVyMmZNYldKd1ZYYjBCZEQrZjQrazFRZmdoeThkVXRTN05WcmhMVzB2eE45?=
 =?utf-8?B?aVNYWjBjSERkYjhxRE9nNUI4QUZ2ZEprOVRaZWtUQVJpZUZDMkhKb3Q2WE83?=
 =?utf-8?B?QVNqQnk0dGV6VmphNjRtZzFBVktma29xYWNnTnlsUy8rYTc0dmZ0WXRMeklV?=
 =?utf-8?B?SXVadUo4a0JCUU0xT3hnRlgyUVR3ZHgvcThYaVRJUk5wSGJWR3d5T1pNUldk?=
 =?utf-8?B?STVjaGtEZ0RwZkl3djVZRFVKdkJTbjBZMCtSRDNGdkVEeWJFd2JPVFRRTmpt?=
 =?utf-8?B?R0o0RHpqUjQwTlNkVDRaUlMxdXNUUGpvY1l6S0x4VFE4RzFYQWdrOGlvV3ZW?=
 =?utf-8?B?Y2dob2dVUURUN0JjYnNmelhFUG5JdGVCVGdIbjdleSt0STVYRDFGSnl3UVBy?=
 =?utf-8?B?eU9vc25RdWZ3WTRBMHlqNUJHTS8zRTN0NGFaVmxpckFPenU3a0Q5c2gvYzMy?=
 =?utf-8?B?S09URThNY1J0TmNIU05LaDlhMzBLOXNZWkhXUkhjRjgwd25RY2pmdjZqYjNK?=
 =?utf-8?B?bWR4NzAwbFdoZ2ZlR2xNQXkrWDhDVlV6MG44YnVoUzhrMVM2TTMwOVpUK3FV?=
 =?utf-8?B?MGdULzJ2a3BiY3RUSS9sNVJxWDlFWUYzN3EwSkdHS29PanMzYzRxNXFEa0ZZ?=
 =?utf-8?B?aTJ2VmtjWG0zMlU4NXhRQVpKT2l3cndTNjFGRUNZdjZzaVg5TUpYMjc1T2lY?=
 =?utf-8?B?SnpXelVQdEpJeDJuaCtuTXhJOTFZclZmQ3RWcSt3TGtjSGUrVlg4TlNRQzBF?=
 =?utf-8?B?cCtHR0tZM0JMa1VQL21ERU5VWWR1WVZQb2lqYzZMVVJJcFN6VjYrTWViMzhL?=
 =?utf-8?B?OUZiaWI0NFFEaGJvZ2RFMXBLSWtiQnZwRlFBQ0k3RklWTHZKVUp5RDZVeUgr?=
 =?utf-8?B?bGcxb2E4bEZqeTJ5cDVlaytTSDJNWjFIS2VkM3Rhem5CUWtWanEzVlczQnEv?=
 =?utf-8?B?UW1iN2I2anhuR01YOTFTWDdwZnBEY0pQaGg0NEpjZXcxUS9zNDNEcnVDdml5?=
 =?utf-8?B?dkdjUEl0OU8vS1hoUE1Wc1M4amhRd3dpd3ltRjQ2bnlEa2l6ZU85YTkzaTBr?=
 =?utf-8?B?U1ZiSUZ6QXZhdWN6Nk9YRmhPK2ZvcDZ4akJIQ3FDMUVpNUFzaWNKN2dOK0ZB?=
 =?utf-8?B?Mi81RE1DUHF6aWtibWx0MkpFMjQrWEg5UE01WEhRc3h3amFBL3dPeXJFVGRa?=
 =?utf-8?B?K0txeERrY1JoY2NUWDdkRGFwbUxFZlBoOTA4RitrZ0hDWmFGbjZkSk1tK1BL?=
 =?utf-8?B?SE1pUTQ1ckJhVzZOU3dFTkVUM3Z4VHBqQmpEZzE5RGhNYWEwZTh3THJPaWZG?=
 =?utf-8?B?QWtuaEoyQ2NqbVFxMmFpR3NyZmZCZVlCWG5BR2JoUEdsZ2dUYldoN3ZKNmd0?=
 =?utf-8?B?UWxDSHRqOXUvai9XdVY4c1dxSTBxMHJxK0FhZmxNKzVDNy9WbGQvQjVlUTNV?=
 =?utf-8?B?dE5GZks4eTRBWTFDSmNLNDRleDRPSHN4NHFPT2dTNkpOdFgrcXpqdHc5S0RV?=
 =?utf-8?B?NHRLWDc1bTd0TXhuVW5VTE5jbGlBZUg5YkRzUU44WkpleCtseDZibnlUeEwz?=
 =?utf-8?B?NTJINkVWRHAxS1NvZ3dXZEZWb1ROQW0rcUcrdTRFVlNGT250aVM0eGozNFhl?=
 =?utf-8?B?NU5VbVpYQkRON05KeENjUHg3S2FaSGNGMXFveXhtcmVuY0t2U3ZjQ2NkcGVq?=
 =?utf-8?B?MGd1WjhvdkdiUS93dkx6VU9lb1kyUTgwaGFZRXNFMnBkMWFzZS9SczZrcklx?=
 =?utf-8?B?WEtwWDB0THIrQzJVTXVzcWVaN2dRL0RkMlVKdHpJdkRCSWU2dGtoUWJDMWxG?=
 =?utf-8?B?ZmZ3L2lDZUx2cFhyR3B2MUNNVCtiRWMyN1cwd3hGcy9nTDBRVFlOVE9DQ001?=
 =?utf-8?B?SnAyZ1V3K0RtYnBxMzlVMVRGcENTeUxZTk5LZHFBRmlSNXltN3RVRHhGRmI2?=
 =?utf-8?Q?nhE7PKz7UZTDy2BFx2p/rUkxi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BPTx2osQMZaDEM39ztYP9P/po+2TS1RYSyevvd7DJ17+vwWariMd3ViH7rziDY56HgaExcfZ/8ysItuyPyJk/pYjID2xOe9AOcvCdZBnUKLUzviIWJ6wpQsNbyHU/JkyCmoSEiFhzIy2MkvQBguxeco+8M1VcDP6w9RRQ0DxKlcwouHNKhVEHThCiGDynUO5EklUeFhuZKHEM1aX4QPvX9odUeCNoBuz7bSqnwKk2JjxiDQFbvilVXg1EZnId/+3fgVpiwBW5UZln/cvKWkgQhOLgJiH2qVVidJH6GEgvZfzSkcAQWnp8mChSzTA9KaLvtKOcT4rI+cEy5DtkxUyTdMsxG/Pse9SJDF949oIBSkVKiMov/yPvC1jvosYKJPss6qzA0K4FO/Oxy3K4mgsAmim5isyaSjFFQWmzROv4T3vRsAhCayVPtUB264/1NHszi5nol+aKZDngZ3tDIVBLZfyxsC3NunEFZswW+LdbMEFhMnypUoXyo6ZqG/pGQA+iXse42X6k5mh+9aUo/3bGezA42dSmqkEd12K5T01gfIjhRKhCj1v54PhbgagcDgbyH1rn5rZ5JemBw9ZGcqCV5A4EOcnwMeVGWwdKCzSd/Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac287c3-c4b2-4031-3682-08de263e9155
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7364.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 01:05:30.3331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXMiVKPl6ybGQZN/oRoa7qXW08AOvtDV6M7acctstKD1kVMLVXIrZcxv+zdva51LaGJ5oqU5hlPAeeyViOSG3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8007
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511180006
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX0q4aqYf5LrKz
 WWo3rU/4JDGeRdfLcvfGHwmfYC3Ao9TNtBUK2G998LJyJZNG5Gys4x66GOY25coUl2wxAS7aZzn
 ZBWPkrmzgdH8U/gEUUH41TSQIffzJZZlKas2wKCJw8pdiLRvz2CpLsPDL8NagzoI681TZCsaPHD
 8ZThSMjQt9ozWPCddUMMM/8PdD5gpAswfOgugUJ0d3xsZZs7yy8GYAX9A+NmNMi7XvNUt1duGs7
 ZLHTYAh8MXzX2KvEqhatNS/ANjPwmUPlxkxORyXxuvcp8H5ncZ8sxYT+lUMUBM7WW9qQw8XgJJk
 Nou4vqVC6FaHgHpAX5GO8QkBwjG3dnSUYilH0QY7caJOKTCnFTp17uTn61aYdab7n86Pgp1uVgw
 Hb/B5frbzIzjROOYmDhEStV4wenixA==
X-Proofpoint-GUID: GGP-Gl6nYupaw6F547bENUWn7JeS71j0
X-Proofpoint-ORIG-GUID: GGP-Gl6nYupaw6F547bENUWn7JeS71j0
X-Authority-Analysis: v=2.4 cv=Rdydyltv c=1 sm=1 tr=0 ts=691bc65e b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=7bPACF5aJCe1f_RsraYA:9 a=QEXdDO2ut3YA:10



On 11/7/2025 8:11 AM, Lorenzo Stoakes wrote:
> Currently, if a user needs to determine if guard regions are present in a
> range, they have to scan all VMAs (or have knowledge of which ones might
> have guard regions).
> 
> Since commit 8e2f2aeb8b48 ("fs/proc/task_mmu: add guard region bit to
> pagemap") and the related commit a516403787e0 ("fs/proc: extend the
> PAGEMAP_SCAN ioctl to report guard regions"), users can use either
> /proc/$pid/pagemap or the PAGEMAP_SCAN functionality to perform this
> operation at a virtual address level.
> 
> This is not ideal, and it gives no visibility at a /proc/$pid/smaps level
> that guard regions exist in ranges.
> 
> This patch remedies the situation by establishing a new VMA flag,
> VM_MAYBE_GUARD, to indicate that a VMA may contain guard regions (it is
> uncertain because we cannot reasonably determine whether a
> MADV_GUARD_REMOVE call has removed all of the guard regions in a VMA, and
> additionally VMAs may change across merge/split).
> 
> We utilise 0x800 for this flag which makes it available to 32-bit
> architectures also, a flag that was previously used by VM_DENYWRITE, which
> was removed in commit 8d0920bde5eb ("mm: remove VM_DENYWRITE") and hasn't
> bee reused yet.
> 
> We also update the smaps logic and documentation to identify these VMAs.
> 
> Another major use of this functionality is that we can use it to identify
> that we ought to copy page tables on fork.
> 
> We do not actually implement usage of this flag in mm/madvise.c yet as we
> need to allow some VMA flags to be applied atomically under mmap/VMA read
> lock in order to avoid the need to acquire a write lock for this purpose.
> 
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>   Documentation/filesystems/proc.rst | 5 +++--
>   fs/proc/task_mmu.c                 | 1 +
>   include/linux/mm.h                 | 3 +++
>   include/trace/events/mmflags.h     | 1 +
>   mm/memory.c                        | 4 ++++
>   tools/testing/vma/vma_internal.h   | 1 +
>   6 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 0b86a8022fa1..8256e857e2d7 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -553,7 +553,7 @@ otherwise.
>   kernel flags associated with the particular virtual memory area in two letter
>   encoded manner. The codes are the following:
>   
> -    ==    =======================================
> +    ==    =============================================================
>       rd    readable
>       wr    writeable
>       ex    executable
> @@ -591,7 +591,8 @@ encoded manner. The codes are the following:
>       sl    sealed
>       lf    lock on fault pages
>       dp    always lazily freeable mapping
> -    ==    =======================================
> +    gu    maybe contains guard regions (if not set, definitely doesn't)
> +    ==    =============================================================
>   
>   Note that there is no guarantee that every flag and associated mnemonic will
>   be present in all further kernel releases. Things get changed, the flags may
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 8a9894aefbca..a420dcf9ffbb 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1147,6 +1147,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>   		[ilog2(VM_MAYSHARE)]	= "ms",
>   		[ilog2(VM_GROWSDOWN)]	= "gd",
>   		[ilog2(VM_PFNMAP)]	= "pf",
> +		[ilog2(VM_MAYBE_GUARD)]	= "gu",
>   		[ilog2(VM_LOCKED)]	= "lo",
>   		[ilog2(VM_IO)]		= "io",
>   		[ilog2(VM_SEQ_READ)]	= "sr",
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6e5ca5287e21..2a5516bff75a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -271,6 +271,8 @@ extern struct rw_semaphore nommu_region_sem;
>   extern unsigned int kobjsize(const void *objp);
>   #endif
>   
> +#define VM_MAYBE_GUARD_BIT 11
> +
>   /*
>    * vm_flags in vm_area_struct, see mm_types.h.
>    * When changing, update also include/trace/events/mmflags.h
> @@ -296,6 +298,7 @@ extern unsigned int kobjsize(const void *objp);
>   #define VM_UFFD_MISSING	0
>   #endif /* CONFIG_MMU */
>   #define VM_PFNMAP	0x00000400	/* Page-ranges managed without "struct page", just pure PFN */
> +#define VM_MAYBE_GUARD	BIT(VM_MAYBE_GUARD_BIT)	/* The VMA maybe contains guard regions. */
>   #define VM_UFFD_WP	0x00001000	/* wrprotect pages tracking */
>   
>   #define VM_LOCKED	0x00002000
> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
> index aa441f593e9a..a6e5a44c9b42 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -213,6 +213,7 @@ IF_HAVE_PG_ARCH_3(arch_3)
>   	{VM_UFFD_MISSING,		"uffd_missing"	},		\
>   IF_HAVE_UFFD_MINOR(VM_UFFD_MINOR,	"uffd_minor"	)		\
>   	{VM_PFNMAP,			"pfnmap"	},		\
> +	{VM_MAYBE_GUARD,		"maybe_guard"	},		\
>   	{VM_UFFD_WP,			"uffd_wp"	},		\
>   	{VM_LOCKED,			"locked"	},		\
>   	{VM_IO,				"io"		},		\
> diff --git a/mm/memory.c b/mm/memory.c
> index 046579a6ec2f..334732ab6733 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1480,6 +1480,10 @@ vma_needs_copy(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
>   	if (src_vma->anon_vma)
>   		return true;
>   
> +	/* Guard regions have momdified page tables that require copying. */

Nit:  s/momdified/modified.

> +	if (src_vma->vm_flags & VM_MAYBE_GUARD)
> +		return true;
> +
>   	/*
>   	 * Don't copy ptes where a page fault will fill them correctly.  Fork
>   	 * becomes much lighter when there are big shared or private readonly
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index c68d382dac81..46acb4df45de 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -56,6 +56,7 @@ extern unsigned long dac_mmap_min_addr;
>   #define VM_MAYEXEC	0x00000040
>   #define VM_GROWSDOWN	0x00000100
>   #define VM_PFNMAP	0x00000400
> +#define VM_MAYBE_GUARD	0x00000800
>   #define VM_LOCKED	0x00002000
>   #define VM_IO           0x00004000
>   #define VM_SEQ_READ	0x00008000	/* App will access data sequentially */


