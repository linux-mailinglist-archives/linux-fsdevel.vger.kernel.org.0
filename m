Return-Path: <linux-fsdevel+bounces-66433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C05C1EF73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 09:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B58453AB441
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 08:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30CA33436F;
	Thu, 30 Oct 2025 08:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VgmjJiji";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IgHQW3Xe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3842C25CC4D;
	Thu, 30 Oct 2025 08:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761812549; cv=fail; b=logViiiXspFvv3uUv6EWIXTVfGozF5wELNJCgVKDbv4xF44WhwKIwpGn0w+wsyLZWuM7TYIkHOcE2n5vowTe1kvFhh4FyogrlfD/HDrhDbUTL3oFIWSLizHKSzBYSZ4fl3hqmBxZ3ec9Q1mvXSuXaMkGhEvcTEud6TbbB92QKco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761812549; c=relaxed/simple;
	bh=tPeBRnfYjR8e20A4eKVmgscspxDiKAbI8KJ5EjINk7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gfsOvdeEdPEL/xZgmwzjCW3Cp2Sn/bY22+bpQ1Xsx3TYJcOTDYn2n5oHnWAprE6t8Ux+dbeOwTkv39evw0OKZgpa5NZ72B5XRfuQuQtaeI5BlETLs5zkq6WXmG5Q2hQ0ZCuP6qKATeFRn3NVa7YwABb0bHvaPiiJEuV8W2gBags=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VgmjJiji; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IgHQW3Xe; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59U88nvD010274;
	Thu, 30 Oct 2025 08:22:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=f3mCVn/v6xkXkP3Z1tUwqNRQNNFaBv5B3wp4o+oCz6Q=; b=
	VgmjJijiISJ9a1ivneEQlfD7AMfxho+SAj2sYIfI4QKo6Kjl9XFy3feZ9wogbPdt
	5zw5sbUB+o0vJ6Y06VoA+GNJPAJ8IqemnfTXh32SDkIPi7tT2W+1PC9V5mofogav
	cV3MRV+UDQvMrFl9RFmQanNlRbfgLIhT9lZSIXCaHhCui9eJ1cYwCX90+mmIJplB
	im4jWcxfakBYNzWX/Ei4toBy47BriZFq/mQruowtenFjQR5yWPen/dIbjgN8SDlb
	1DKSGeewSA5p5CWy/cY6Y05S5XjFjycywy6iPrP4wsXgaeZrjQevImGPgzRFMfSU
	v6KqVZa4L7KXf522r703JQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a430x844u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 08:22:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59U7oEC7011267;
	Thu, 30 Oct 2025 08:22:08 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012059.outbound.protection.outlook.com [52.101.43.59])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33vyaj96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 08:22:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFTcqh7OW7DYTDKl35xJQ7Ew8JDwCeRwNjuHwApzlF6CdseDI+w/++919EcrLet2rRL0j9+utFjMo4jReGRSismKXTQRKaAm63149VAKXG4vBL4evSWJCzJ4Y8YAQ/53CdEKpHE5vYbRNXvgzRham0O6NWGc/C5WjFs+8s80/3r/rBzYEbtAr/dy4i3p8qE3Cn6l+h9t0q2gXCsi6Dz5EevmK+L26jC4uXke1E8kAQuj1+u7FqWQ7OaRlMoL4/8URTakLb6W35ssDmeCzDVbDSZzM78yZzfStwzMUdK6IATOClma3dsgeUCo1c3rt79H2mbvadvlRNBVQ4RuY+Bf7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3mCVn/v6xkXkP3Z1tUwqNRQNNFaBv5B3wp4o+oCz6Q=;
 b=SuqpWcOhW6ll65buUMZ7bHtnEmy8MDy6uw2AgFcPkkya/V9JrXbpcRzFwVfJGYa90XRU2RJIErleJ1pZJ9chh635tfGsNZGzSL99loQkEqBvFY+d//slQm/hmVe1Ntzu0UWUujyCxFaIDBzCS0ehoq0ty5W368HCydJA85xToaHz+idub1v/DIYktU7ezu1ZV+EQijxMcACaioy+EzWJzm77cmXbOFr08lUY9sTnwpc2d2ZWeScu3tf7Os8ciCbYLZwwj+U0CEM9qXryg56YOFnZAgzv7N48prfNkFEnL3J/DFbEotftTf532HW1fmQ2EKl98Mbd68ZgPPEetQaRBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3mCVn/v6xkXkP3Z1tUwqNRQNNFaBv5B3wp4o+oCz6Q=;
 b=IgHQW3XeSU/HVJnL+lYunC25Fde1zpsnJo40ktslcPfBh4AuZrhz26NMhOrYvISzQseC3MBDrY3B7Oa6T5Ix3N+5RrvjlJsCMsnBSFyDxxjhXamEmvHdx4yAh4Ov6uhIYMzfNC1g+JgnoabRuddf2/6a/Vq9pWn8v39f71pjXqI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB5747.namprd10.prod.outlook.com (2603:10b6:510:127::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 08:22:05 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Thu, 30 Oct 2025
 08:22:05 +0000
Date: Thu, 30 Oct 2025 08:22:03 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH 1/3] mm: introduce VM_MAYBE_GUARD and make visible for
 guard regions
Message-ID: <9b882dab-7b27-4605-9adc-54e23323b405@lucifer.local>
References: <cover.1761756437.git.lorenzo.stoakes@oracle.com>
 <7de40603015dee82970f5d37332a6d5af7532063.1761756437.git.lorenzo.stoakes@oracle.com>
 <CAJuCfpEefC1nAQ6TgKcq7osX4Zyr_dLhiR5W0So=CReed+LSuw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEefC1nAQ6TgKcq7osX4Zyr_dLhiR5W0So=CReed+LSuw@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0699.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd6f8db-8966-405a-57c4-08de178d68ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OE1ZVzFaNkM5bVJ3d2hQK2s4enFaOGJWclQ1MGhSWWVpTUczZ1ErRHUzYUgz?=
 =?utf-8?B?TzR1OU1NMzBiVGUwVE1nWTRlbTM2ZTRNWUtyNU44VUhRQ2pEVE1lYWxWVjBo?=
 =?utf-8?B?ODlaZ1pVV0ZYQjQ0UHBJNFhweUpjNW4xRDVMQ1kyc2htRUNTSkU5ZkcyTGVj?=
 =?utf-8?B?eVlqL1R1ZTczVTlnR29UTVRTWVkrbElXN0x0LzRIZnhSZFNhOUhRQnhNcTFG?=
 =?utf-8?B?aVA0QlB1cTQ3ejhDUUhLTkVGVXQ1Sjl3OXFVZmNGWDlwUFlWUEpWV255elE3?=
 =?utf-8?B?VGNFWkZYcUQ3elZPVm1sNVNaV2RHS0VaUTBmUHVySjVGWlc2bDVnQ0pGYzIz?=
 =?utf-8?B?TWFnS1MyL0YzN3pzMUlGRkVBS1NFL1BQT2VZZmVhVTQyY3ZqWHREMHVwMEJL?=
 =?utf-8?B?VmJCSk15b3J1Z1BuYzBVQXZTeTdtdk91dmpRTVdZK1BQTjJWejBOWlRnMENl?=
 =?utf-8?B?dWhtS0w3K1B5aVZoR29qeDI1TnJSVHo0TzFJdS9wTk1qM2lHTExXb1AvVmIz?=
 =?utf-8?B?WUVTeTlpdlJmWGhiUWxaSzlWSEhBYmVGNFdlMUJybHRoRDdrMWsrbXJldGZX?=
 =?utf-8?B?VUFadDZzeVJUakcyakFrRTJaWFdCQm8vVlpCVFYvTU44cUpYUnUwQStuTlVk?=
 =?utf-8?B?dUZNOGVLOTBsY0pJeU02NW94U0tjOFA0VDV2ZVZYNlJzM0pmWmlmU1JYTE9h?=
 =?utf-8?B?Q3lNMDluRHlqbmNKZkRHeDBJYWdkMnV0ais5b3NtbHAzN1JNR01OMG85WTNq?=
 =?utf-8?B?WVJRanlOWC9RRytWRlgrQ2lDemwwMHJqU252MFZZMzhwcEw2WFZJblE2TURP?=
 =?utf-8?B?UDJpNW45aTRtUmljUHdGaHhNRmRLcDJIZGxzZ2pCSDMzSEpHYkFaeXMrR3Nj?=
 =?utf-8?B?cUNhd2dnR0RZaVFCWVJNZ0xZdTVnNHFHODN4YWl1c2ZNODFiczRWN0Q2WUVU?=
 =?utf-8?B?WVZBRURPRmFzYW9KUGtOYWVvRnVyNDltZUQ4bFRZaUVpTHQyRG16Z2UwMVN6?=
 =?utf-8?B?QmFtS04rbjZWY1o4YUpNZ0ZTZ05uY1VEL3lFalY5YWNjNEVBckdEUVJvNzd5?=
 =?utf-8?B?NnAzbFJ2K3pyOWNxblFPYzJQS2JxWXhnUUw1OWpuVXdpVjhxeE8wY0tKaEda?=
 =?utf-8?B?QmExOUlmQXU2MUJvd05ESXROUm5wdzEyUE4waEhneUxUOGJKQmpjMEFhTFcy?=
 =?utf-8?B?ZFlUdHkxVHJWc2ZUOUtPQVpQb1kzZ2ZtVVJldk04ZnpDTDdCVFltSWZFWTM5?=
 =?utf-8?B?bWM1TGZEbkdPRTIzczZjWmhITkpONzR2Tkw0aUh5ekZ0aFFGckptMGZ1bXdT?=
 =?utf-8?B?eHVnQU5lSUhqb2F4M2w5amM5cU5HcHlpS0E5bW5Tc2kxMG43a3N6MVJxNHQ1?=
 =?utf-8?B?eHAzcXUxak8yZFcrRFgzL0ZpNVVJcHZJY2laZDU0c0F3a3lkdVhrVVlpd1Ru?=
 =?utf-8?B?bXhlT1hKaW84Y3JPdUk1RjZNdTNHaW1UMW1ncEpkWGFsNFZrK0xkUGZsc2U5?=
 =?utf-8?B?UTgxYU9QQ2FoMEVGN2hBSlpLenNWTXdoMGdES3MyaE9YRldOSVd5eC8ycFFx?=
 =?utf-8?B?SmM4NjhiR3NVQi9UVllhZWhqWGx6Vkw3QWszRk1pZWkzam9PZi9MNFNPbFJn?=
 =?utf-8?B?SGZsT1NVWkZEOGxoQ0kxd1V3MHNteG1DVVAvNnhUYmJoWmdsZVRLbU52WnRP?=
 =?utf-8?B?Rk1MeXl1bU1KMFFibVIzUTZaYjJBa0l4YTJVbUc1eTlxL0ZDZkNqaDBlOWRF?=
 =?utf-8?B?cFhGckE1dHVSOURDTlVTcXNId01yenFyYnptYWVRTkRSS25VcXdRVGhpNnJQ?=
 =?utf-8?B?L0xoZHo5N0lxd3diOVpxME9URWJoR1UveTFwNUZIRWJkWmpQVnV5RnNaY21m?=
 =?utf-8?B?SXpKMjdkZmtRS3plWk9KZGtEVWo2V2lMODZEQWo1bDhKOTBuMkh0VDNBT3RO?=
 =?utf-8?Q?bbw/BKPSomuoxg024zbIzxoZCUMSaxk2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFYyeHJPZkF6Nm81akhhU3NNbmlVbTRuY253NDYvM21HU0trTkRWQ0tvNGhH?=
 =?utf-8?B?Q0poNldMVWpRR2NVMkloWnArelBtd3M4a00ydThIRlZTQ2d1Zk9SVGJXdmlk?=
 =?utf-8?B?d01PejhPeXlMclM4RGJqZ28vMjZuZktmUTQ3QjRrbmNvSlA1M3J4K1dBeFh1?=
 =?utf-8?B?MlVjdXpWNjg4S2l6TGRXcmgrelc2Qnl6Tkg3Mnk1cDc1cUpxMElXSHNHV3VS?=
 =?utf-8?B?c0Q4eEJpdkx6OUNXdlJlTHJnbExJNXMweFdNR096VnNIbllMbUVXZGFZQWMx?=
 =?utf-8?B?MDUxUDhmL1NMbEFyV1Z0UTZxdG9Nam9zZER0MURGd0JmQWk1bVFqTklESC9x?=
 =?utf-8?B?MHFWQTh0QkxPSUZpU3dJb0NvNXVGaUFLS0x3b05jbzh4dGk5UTFpNkV3V2VW?=
 =?utf-8?B?UkpkamF1dGMyQ1hwK2V3TlZCQllrbDdDa2RVaHhUbmNZTXZwbWQ0c0lqZXVr?=
 =?utf-8?B?YmFILzUydGtIMUhvRlF1SkU1MFBNU1VVODlmbUtzR0VMTnFKc29QZlJ0Y2xp?=
 =?utf-8?B?S3J1QlFFUVhGbEFKeHBlOWhjRy9UbHlFZXp4MkhhUjZIK28rQW9vM0pabVNo?=
 =?utf-8?B?QTNWdEo3cjRTNUdzWlpuK3RzVDBIR1VmZ3pxV0hMMFRhYjQ4Rkh6SVlCaldl?=
 =?utf-8?B?RjdVWkpOZ2VibHBIOVFISHIxR2pZME5yOVBtRGROQXdDa0ZFcDNRbGFJall3?=
 =?utf-8?B?MGp5QW5lUUJzTGhaS1lvMzByeGN5L0wraktmTm9Od2V5d0hLUnZ1WHFCZEZs?=
 =?utf-8?B?a1JmK256NDNldFkzY3ZNZzFnS2FDOXpQeGowREFoS24wUzJscFJhTWtid1hv?=
 =?utf-8?B?YWtOMDhPKzJoUk0rZitlVEQrZFptL1A5VWRaWHZiemFYcysreDNsYzF4VFZj?=
 =?utf-8?B?QVRmWEJlbTB2U0FmaVprRkFZKzRNaVJjUnM1MHpvZFRnaHFNY1lNd3lkWExV?=
 =?utf-8?B?NVpaRGoyZlNZRTNQeGZ3K29wZUgzdm1hVllza0dlLzIxVERmMlFlaFNkL2tJ?=
 =?utf-8?B?aWI0bHlIUnlZOXdxejhtNTZFZXdaNDVXbDM0WFp5SVdhOHUramxnWTBTWVU3?=
 =?utf-8?B?QlZvSjNwM1pxRk9aSlBTeUljcE5CYVFEaFZZUWdLSTdUOXB3cWltTEJuZlBp?=
 =?utf-8?B?RE1qbEk2WGIyQ2tJS2NYZFhGdmN3c2lDTGgxc1FEalY1dGdNK1dRNWV3RkJU?=
 =?utf-8?B?TmQ3VTYxQmxVWitHcC9hT3pjbXVvWFV1d0lEVk1YWlpWNHd3MjY2Qng2RmNZ?=
 =?utf-8?B?aHcvd1h4ejQ2MnA1ODIzSno4UExnN0dyK2hEaDFqNXZmSWxpUzhaMUgrRmVo?=
 =?utf-8?B?SmNSbjA4SktIMmZGZmtTdHBsLy9QQlY5dWRNNlJWOEl0KzNyWE9sVElBMm8w?=
 =?utf-8?B?bHZxSXEzVlpXcEZ0NlFjZFBRMURISkF3K2J0bUp5WncvZm1nTFgrbjhUOFVE?=
 =?utf-8?B?YnhKS3JNZmdpdFJIT2t5NEU4dEw4bGpKa3phQ3VaVUZFSnU2ellBRTFSUEVt?=
 =?utf-8?B?VGlkUUE2aEM1VjNxUUNyR3hXUk5uWGZjYkNLdHBTY1Q1eFoyaE9ROUpGbTJt?=
 =?utf-8?B?K2lpYy84eUllU0Y2NFhVaDNQbUpRamdhRzVScFZQZ2M2QlpWdHB1elpsUjBX?=
 =?utf-8?B?d2Q4SVVsUi94eGNQdlR1aE4yV1FhdHVUd3UyN2JDTEFpM2tQa0tGRXpkTEMr?=
 =?utf-8?B?Rm44ZFJLS3NEa3cvaUo1MGl6Qzl6MUFNQ0xMUUFuSjZhNm1tVFc4Nm14WU5k?=
 =?utf-8?B?b3NYM1dwSkNLekd2THNVd1dQMFhLUXpWQXpIM0huK25hcTQ3Mk9DRWtyQkxj?=
 =?utf-8?B?Tk12SDl3eHFGUEJvRTY2QXowTVB2d043c0ZtWkRIeGszMzNUdURSU2F0UGZs?=
 =?utf-8?B?NjBOL08rNGcrQSs0TW1DZUxwOFNaODJqWnhTZk1SeVpSZ3liVVlHajYvSlRx?=
 =?utf-8?B?dnNTd050dWlKd05KYmZkbDdiVTdtRHVBM2QyMzJVV2k0VEJjU01NSzd0bUZs?=
 =?utf-8?B?aGtuYXlvRHRSTzlxdTdWZGhBd2hZUUhtTHpGVUNuNk44dmovYk9CUnRkZ1Qw?=
 =?utf-8?B?TVpaMFc4TDNWeVpZSCtWdW9jelFsN1R1MTNwa1lhdmkxSjBYSEFQQmtTbEVa?=
 =?utf-8?B?S3VLS05MSVNGdlZPZlAvaEdFVWQ3TDVRWTFaemdsT0dwSFk4ZGZMU1ZoSmJi?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uJ1yNu2YEqrx+aIhbrSElX+aVdP57oI7yd5rudv/+TPfetr1abacQRwVjzazwTE1TYHTaBBsyDDtgPQTq6xG7Xxs/avVCR49Kf85RYwQk2H3a3nu6IvcLKD7pftIoDB3ii1yzSd7MXrc3HNlIiH0AS0c8NUlBHMzxMi+KlSpNqwxVx/qCkBj4SbgODRBh4OtoRTWmIVI1KqemglyKcQCGIhOcaDJkquRlvrkih37mSkyQCiB51uwVjjqkX2UGjpvgUlN+WK3GIz3zpmkRLKEyE+jPszY35ZZztYudw0VtpHpgkPoOdBY+oKz4Z0eeuSvdZceI3mJEZlHYWWyrUTqzdEzMP1IkiesroLto+bFYU2mj8X/6dZId21G3eGHKkSyTtw66SuTqIjc4RqUvC7gxrgk3ynXoTc+iiHvR82VM5UGMp51Sxo1WDvQ/xNhpI3hD0kSUpv6K5M+iYTbncRtYEfrKH1MVWg+OmWcgBy/gyXd863UTF1SBZL3IWI0kItrNXXInCcQjFA5I9gmuAcs6eNC0dHFZMRqTk6J0qXXamKKNPtCP9nNhIZ5t6G+Jnt7EdfirejIHtCjOWyv47vY9u+fyXeSKPJ2Naq9wXbo6tQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd6f8db-8966-405a-57c4-08de178d68ee
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 08:22:05.3141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UhdrvDWsHqL1FMVsuRqTUHwDIJYTC+dTFlTOInAmbf3O2xRRolHeSa0gm6+FTJNAcmfC5+5/U8X8y1nsup+/9ykIcpIqnFPrxcsq4vO+Iro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5747
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510300067
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA1MyBTYWx0ZWRfX5VvvC3TvUz3F
 Q8BMXjlLiU3dFPw0BJ/2EUrWuwdzXvyURmlB0+JBuuYPLVvF61E2yxEHp3g87rVyJ4KIAvcc4Lm
 WYX1DW+3osp30dDaoEuCJux7Bxt0x0637cpBeFwskYEAfovCPt1ShGkzk+0au78rgrulLissBNE
 DzRl6nh/U1Ti8ip19Rdf1+nyjPLdj9BfcJ/ecBcc8Ua2amJaCiqqPlY/IHf1ADn2fp1zoZKsjfC
 ZqAWqhjbh9KdA+Y2FGRFBzNVwLYDia2D5IS7hJ/EzOjnrf/qckT/o+ZGFCHIa1XYC6oc4TOQA6V
 yADf4+nm/+Ym974V59lY4ourSDsaucl0LufhytTZj7RPWYNQ7hmjlufK7osVbHkiRwdvum+QXYS
 FQVIOFATaQkqeVcpi87h42+jbwfLTg==
X-Authority-Analysis: v=2.4 cv=F7Nat6hN c=1 sm=1 tr=0 ts=69032031 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=d3nJzThXslFVXst8mQkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: R5qlNVZmHyFYKripzNsYbHVzUgcv6NBG
X-Proofpoint-ORIG-GUID: R5qlNVZmHyFYKripzNsYbHVzUgcv6NBG

On Wed, Oct 29, 2025 at 06:05:54PM -0700, Suren Baghdasaryan wrote:
> On Wed, Oct 29, 2025 at 9:51 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > Currently, if a user needs to determine if guard regions are present in a
> > range, they have to scan all VMAs (or have knowledge of which ones might
> > have guard regions).
> >
> > Since commit 8e2f2aeb8b48 ("fs/proc/task_mmu: add guard region bit to
> > pagemap") and the related commit a516403787e0 ("fs/proc: extend the
> > PAGEMAP_SCAN ioctl to report guard regions"), users can use either
> > /proc/$pid/pagemap or the PAGEMAP_SCAN functionality to perform this
> > operation at a virtual address level.
> >
> > This is not ideal, and it gives no visibility at a /proc/$pid/smaps level
> > that guard regions exist in ranges.
> >
> > This patch remedies the situation by establishing a new VMA flag,
> > VM_MAYBE_GUARD, to indicate that a VMA may contain guard regions (it is
> > uncertain because we cannot reasonably determine whether a
> > MADV_GUARD_REMOVE call has removed all of the guard regions in a VMA, and
> > additionally VMAs may change across merge/split).
>
> nit: I know I suck at naming but I think VM_MAY_HAVE_GUARDS would
> better represent the meaning.

We all suck at naming :) it's the hardest bit! :P

Hm I don't love that, bit overwrought, I do think 'maybe guard' is a better
shorthand for this flag name.

I am open to other suggestions but I think the original wins on
succinctness here!

>
> >
> > We utilise 0x800 for this flag which makes it available to 32-bit
> > architectures also, a flag that was previously used by VM_DENYWRITE, which
> > was removed in commit 8d0920bde5eb ("mm: remove VM_DENYWRITE") and hasn't
> > bee reused yet.
>
> s/bee/been

Yeah this series appears to be a bonanza of typos... not sure why :) will
fix.

> but I'm not even sure the above paragraph has to be included in the
> changelog. It's a technical detail IMHO.

Well, I think it's actually important to highlight that we have a VMA flag
free and why. I know it's bordering on extraneous, but I don't think
there's any harm in mentioning it.

Otherwise people might wonder 'oh is this flag used elsewhere somehow' etc.

>
> >
> > The MADV_GUARD_INSTALL madvise() operation now must take an mmap write
> > lock (and also VMA write lock) whereas previously it did not, but this
> > seems a reasonable overhead.
>
> I guess this is because it is modifying vm_flags now?

Yes

>
> >
> > We also update the smaps logic and documentation to identify these VMAs.
> >
> > Another major use of this functionality is that we can use it to identify
> > that we ought to copy page tables on fork.
> >
> > For anonymous mappings this is inherent, however since commit f807123d578d
> >  ("mm: allow guard regions in file-backed and read-only mappings") which
> >  allowed file-backed guard regions, we have unfortunately had to enforce
> > this behaviour by settings vma->anon_vma to force page table copying.
> >
> > The existence of this flag removes the need for this, so we simply update
> > vma_needs_copy() to check for this flag instead.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Overall, makes sense to me and I think we could use it.
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Thanks!

>
> It would be nice to have a way for userspace to reset this flag if it
> confirms that the VMA does not really have any guards (using say
> PAGEMAP_SCAN) but I think such an API can be abused.

Yeah, I'd rather not for that reason.

>
> > ---
> >  Documentation/filesystems/proc.rst |  1 +
> >  fs/proc/task_mmu.c                 |  1 +
> >  include/linux/mm.h                 |  1 +
> >  include/trace/events/mmflags.h     |  1 +
> >  mm/madvise.c                       | 22 ++++++++++++++--------
> >  mm/memory.c                        |  4 ++++
> >  tools/testing/vma/vma_internal.h   |  1 +
> >  7 files changed, 23 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> > index 0b86a8022fa1..b8a423ca590a 100644
> > --- a/Documentation/filesystems/proc.rst
> > +++ b/Documentation/filesystems/proc.rst
> > @@ -591,6 +591,7 @@ encoded manner. The codes are the following:
> >      sl    sealed
> >      lf    lock on fault pages
> >      dp    always lazily freeable mapping
> > +    gu    maybe contains guard regions (if not set, definitely doesn't)
> >      ==    =======================================
> >
> >  Note that there is no guarantee that every flag and associated mnemonic will
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index fc35a0543f01..db16ed91c269 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -1146,6 +1146,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
> >                 [ilog2(VM_MAYSHARE)]    = "ms",
> >                 [ilog2(VM_GROWSDOWN)]   = "gd",
> >                 [ilog2(VM_PFNMAP)]      = "pf",
> > +               [ilog2(VM_MAYBE_GUARD)] = "gu",
> >                 [ilog2(VM_LOCKED)]      = "lo",
> >                 [ilog2(VM_IO)]          = "io",
> >                 [ilog2(VM_SEQ_READ)]    = "sr",
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index aada935c4950..f963afa1b9de 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -296,6 +296,7 @@ extern unsigned int kobjsize(const void *objp);
> >  #define VM_UFFD_MISSING        0
> >  #endif /* CONFIG_MMU */
> >  #define VM_PFNMAP      0x00000400      /* Page-ranges managed without "struct page", just pure PFN */
> > +#define VM_MAYBE_GUARD 0x00000800      /* The VMA maybe contains guard regions. */
> >  #define VM_UFFD_WP     0x00001000      /* wrprotect pages tracking */
> >
> >  #define VM_LOCKED      0x00002000
> > diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
> > index aa441f593e9a..a6e5a44c9b42 100644
> > --- a/include/trace/events/mmflags.h
> > +++ b/include/trace/events/mmflags.h
> > @@ -213,6 +213,7 @@ IF_HAVE_PG_ARCH_3(arch_3)
> >         {VM_UFFD_MISSING,               "uffd_missing"  },              \
> >  IF_HAVE_UFFD_MINOR(VM_UFFD_MINOR,      "uffd_minor"    )               \
> >         {VM_PFNMAP,                     "pfnmap"        },              \
> > +       {VM_MAYBE_GUARD,                "maybe_guard"   },              \
> >         {VM_UFFD_WP,                    "uffd_wp"       },              \
> >         {VM_LOCKED,                     "locked"        },              \
> >         {VM_IO,                         "io"            },              \
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index fb1c86e630b6..216ae6ed344e 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -1141,15 +1141,22 @@ static long madvise_guard_install(struct madvise_behavior *madv_behavior)
> >                 return -EINVAL;
> >
> >         /*
> > -        * If we install guard markers, then the range is no longer
> > -        * empty from a page table perspective and therefore it's
> > -        * appropriate to have an anon_vma.
> > +        * It would be confusing for anonymous mappings to have page table
> > +        * entries but no anon_vma established, so ensure that it is.
> > +        */
> > +       if (vma_is_anonymous(vma))
> > +               anon_vma_prepare(vma);
> > +
> > +       /*
> > +        * Indicate that the VMA may contain guard regions, making it visible to
> > +        * the user that a VMA may contain these, narrowing down the range which
> > +        * must be scanned in order to detect them.
> >          *
> > -        * This ensures that on fork, we copy page tables correctly.
> > +        * This additionally causes page tables to be copied on fork regardless
> > +        * of whether the VMA is anonymous or not, correctly preserving the
> > +        * guard region page table entries.
> >          */
> > -       err = anon_vma_prepare(vma);
> > -       if (err)
> > -               return err;
> > +       vm_flags_set(vma, VM_MAYBE_GUARD);
> >
> >         /*
> >          * Optimistically try to install the guard marker pages first. If any
> > @@ -1709,7 +1716,6 @@ static enum madvise_lock_mode get_lock_mode(struct madvise_behavior *madv_behavi
> >         case MADV_POPULATE_READ:
> >         case MADV_POPULATE_WRITE:
> >         case MADV_COLLAPSE:
> > -       case MADV_GUARD_INSTALL:
> >         case MADV_GUARD_REMOVE:
> >                 return MADVISE_MMAP_READ_LOCK;
> >         case MADV_DONTNEED:
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 4c3a7e09a159..a2c79ee43d68 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1478,6 +1478,10 @@ vma_needs_copy(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
> >         if (src_vma->anon_vma)
> >                 return true;
> >
> > +       /* Guard regions have momdified page tables that require copying. */
> > +       if (src_vma->vm_flags & VM_MAYBE_GUARD)
> > +               return true;
> > +
> >         /*
> >          * Don't copy ptes where a page fault will fill them correctly.  Fork
> >          * becomes much lighter when there are big shared or private readonly
> > diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> > index d873667704e8..e40c93edc5a7 100644
> > --- a/tools/testing/vma/vma_internal.h
> > +++ b/tools/testing/vma/vma_internal.h
> > @@ -56,6 +56,7 @@ extern unsigned long dac_mmap_min_addr;
> >  #define VM_MAYEXEC     0x00000040
> >  #define VM_GROWSDOWN   0x00000100
> >  #define VM_PFNMAP      0x00000400
> > +#define VM_MAYBE_GUARD 0x00000800
> >  #define VM_LOCKED      0x00002000
> >  #define VM_IO           0x00004000
> >  #define VM_SEQ_READ    0x00008000      /* App will access data sequentially */
> > --
> > 2.51.0
> >

