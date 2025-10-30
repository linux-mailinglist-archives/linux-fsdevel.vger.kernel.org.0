Return-Path: <linux-fsdevel+bounces-66435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F010C1EFAC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 09:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65FE1188476A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 08:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943EF338900;
	Thu, 30 Oct 2025 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pbahck3w";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UrNIq4h3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D4D1A4E70;
	Thu, 30 Oct 2025 08:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761812786; cv=fail; b=uuGC8/3/DcxCCvtrO4FTMEywaTqjsgMypWbPYkHJUvl2XqAt1PWA9Y7jDIehJQMvqr+4ary906yt+Iytobh7layvSKA8msZkZoMe1nrQDApqOCGRuapOTn7uOJmcw6ZyPLR5rzEqk9AdJj6OtTx4+S1VBCL0MZv6mkcit4w6qTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761812786; c=relaxed/simple;
	bh=KVAKlW35FXGaAHnr4A8PRRsS4WZ1OJHtWNANhGR6clE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rmNVF/bQ3vjE3OxvExAGEiCEsMpdwF9XsDSGxCBEbkFlln+C4DfNa6Ew42xhLulufYpROt7NTTNYk16DZOlF7ifjQGzGgxu8vc/nPSibrVF5fS+9g2M6gfJhECCOSmM7ljnEBSaPymeXu8zCrSGffETZhrky7/yo6KTgVfnJKc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pbahck3w; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UrNIq4h3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59U7EhBr001835;
	Thu, 30 Oct 2025 08:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KVAKlW35FXGaAHnr4A8PRRsS4WZ1OJHtWNANhGR6clE=; b=
	pbahck3wManq/YJI05aiZnh68qqJ2vnZBV8xQl6jmRLIpFRCyMqKNk6jV7hEjhtK
	RiOGCXg0WfL5IXfh3/HqIAJ0cJU4n4eDo/jDpHlsE2wZ6JGvnKedREfK8v4kYWhK
	7kopwHd4bmdQ+FufZQ8BwhI6zGKMDS7L+W545G35/qROlmztyV8NXaH/FnHf4fQs
	5J7ceIz6tSKBgmlWCs5LloRCjRt+A4RSRAkBnDACVvGrkpXIdaYjHz0Em5Zw6GYL
	aMj4hpAKV+6yeJ81U+JaxUtgYsZepTJ6YuCCQ5dGAcBSaf0dqYd5dcUXsI0XxaTg
	Yf59wfVXl/DJC+5nlCTFdQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a43f2840w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 08:26:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59U6iCpZ012210;
	Thu, 30 Oct 2025 08:26:03 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012045.outbound.protection.outlook.com [40.93.195.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33vyap92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 08:26:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QgAv9KUouvSDqOG85CujAW4dxIfLwy9h/fR0c7Tk3R/F0jvfbGdC78fYIIREZehORkf13/Xp2D11PofPnJOaOEq3by/hCbXkfX50h8xwJI4uoIJm9UTSTDuV2ouBWgC8ve/EOSZRuPqG+Cp4orTpleLoxaZZny8cGh7UkGdQggl5mLHsKgBBaj+J+Sxwg3taeAPz0v8ZJwlOtLC211OqAxlNGVBIU+gITaVhbpIFp6RISKfA6auTkmc8sYwcjpZCrwG5NJV844oIWpSlVI5vctaRK9jQEjnQOIez+eZSzGXg9j20bCsqVKtE2XcmnC49Y0gE3rmBhp1SXZOyPX+92A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVAKlW35FXGaAHnr4A8PRRsS4WZ1OJHtWNANhGR6clE=;
 b=JFkI/FPgfUCEFx/gbwxB+WZQv+IGErULDr7VVsUNRd/Q5n+RSLmI/EDvJBUO2sNmnw6NM256E/sE77Fgl53BxLiYWnMl/UlATvjtMrjtVeAwb0FI5CVEsz5jYfNqZ+Y49JtT0o1itn4qremW2edqH8+Yy0VkiCOnjUkqD0hOBTnpjSrfhc+L5FUjiDsdlB56moBLmJ9wq5fI9LuiydIzgq7BuoV8zoV8Ek1wr4GhMRNWX9ZR5NWGOisx9S6FCieDswvMzoailm1EwegVC3DOYrh2kEIjcuuCnSUH2nF/8AME/oSVqZHMB+2RQhfl6CWbWGcTcoFVSlEEr1JD0nUQ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVAKlW35FXGaAHnr4A8PRRsS4WZ1OJHtWNANhGR6clE=;
 b=UrNIq4h3Ghp7VxBv18dwdhVafZZfx3+o6CpNwl2svANaTgr/ESBV7s2WdW3+DnXPsT66ZLYhUhH07298z4Zw5uGt1A4pk0xTzezlHESetO58SJzUMzS9y1MxkaSADmM1KFyeKV3ClG+K2RsETBMFishBswz3mRgfaheYCeQo8Es=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB5747.namprd10.prod.outlook.com (2603:10b6:510:127::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 08:26:01 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Thu, 30 Oct 2025
 08:26:01 +0000
Date: Thu, 30 Oct 2025 08:25:59 +0000
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
Subject: Re: [PATCH 3/3] selftests/mm/guard-regions: add smaps visibility test
Message-ID: <034da71d-7c13-4638-bc61-35888e35510d@lucifer.local>
References: <cover.1761756437.git.lorenzo.stoakes@oracle.com>
 <9e5ef2bedbff6498d7e5122421f0ea5ff02236b7.1761756437.git.lorenzo.stoakes@oracle.com>
 <CAJuCfpGFAv9DizXOzCn1Qi5=NDyHh6XyxpmsQr0K45LS6x4igg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGFAv9DizXOzCn1Qi5=NDyHh6XyxpmsQr0K45LS6x4igg@mail.gmail.com>
X-ClientProxiedBy: LNXP265CA0074.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: 908a2c5d-9a30-478c-ef39-08de178df589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RjNmMFVJa0xZcjdEdjhMUUdNbEljSGF6alhNV0U0eTUxSUYwaS9GRGZIaWJG?=
 =?utf-8?B?eTNwR3dYTVJtS2pCckxOa253eVdLNWhhMGYyRU5BaG5jUEFzMzRPRGFHRkVa?=
 =?utf-8?B?cEpqb2V4aDNxalhBMS9nZkw4WWtzbmM3b1NEa2tHb3BxaVV6bG95Z2RRbGNa?=
 =?utf-8?B?UDRjTktMMGZaaFhTeFpER1lxRlpad3graGFFcmpnRlVjUEsvYWY5a3JqaUo2?=
 =?utf-8?B?aWZycWFqcllKL3hHSjF6Yk5KSXJKcE9ES1VYeGdQbC9pU2pqMVBrQTZXRGln?=
 =?utf-8?B?V0lyWjhUYjZTTGZZbGV0SlZDR0dWM1NPQmI3RERvZGdwQVR5TnJKQS9OMm9K?=
 =?utf-8?B?bTU5TFZ3WHBRMkNzcmc0Y1N0dTJDazJSZnRWTXorL0g2MTRFYVRDM2xZeFNE?=
 =?utf-8?B?S0M2TmFDS1dKQkIwaGxHeHdXR1k2QUQyNWRvWDgzUDVPbW02SnZsbS9hOTJh?=
 =?utf-8?B?clRJZjJHQnhiazNFK1IzOFVNYXJBUzFOZlgxNWpjOWdZcXE3Y0pwdFU0OC8y?=
 =?utf-8?B?Nk1sY09yNm5hUUI4YXJ5L2xCaDFXZFJCRTlSWnR3eEExMmZPSlNjT0ZpckhG?=
 =?utf-8?B?MFVlSm9scE5wVXlKS2NMR0VMZUFuWUVuTGptblJMa3NGNnpDam12cGtTSHlF?=
 =?utf-8?B?ZU5LVTJ0T2lnUk9PcXJLdU4raTlQaklyZW1rLzFKOTBlRTNPYnpFRUZpRnBQ?=
 =?utf-8?B?M0w2ZU5GdkgvMi8vV2U1VUJqTC9HcitkM0RpaFUxZHV0TU1iQmR1cFdhOHVC?=
 =?utf-8?B?VkRRb1BVWTUzUTNjOXp5SkFvT0xjYnJxN0l4eXY5OHVFNWJtand1T1FQT2VF?=
 =?utf-8?B?Wndlcm1MblQvN2gyRW8yQzJjUk9OZGtTN0l6RkxzVU81UFU3RjlvQ042dFUz?=
 =?utf-8?B?b0R5bXovRWRhOGJZMmJaNGJreEZLaFBSaE93T05XVGVnd09OelQ1YVVUVnpT?=
 =?utf-8?B?MEdjUlNadkNOMUF5NHc4NFVhdkdrZ1Fsek1VUWNQK2doblNJNUpQQWw2TFBC?=
 =?utf-8?B?czR1dmtsM1I2REtnMGRHUHE3OFRQZElrdzRqaTUxK1YzV0dJc3d3MmEyVEVE?=
 =?utf-8?B?VEIzSmwvRGp1R1VhRDJqdWVRYnZReHhOVE56RGRucmtMdDRQd2NodGZiY2Jo?=
 =?utf-8?B?VHJxTUtUc3pDTmpDcU9XNFZEYitNOEtJalVNU1VSZEdHZUs0TFMzb1ljb0Z0?=
 =?utf-8?B?L3NjTHFVdXpmZ25MdHBrOXVBc0NLM214Skk1azlxbjB2SlZvMGxWd0l1MXVn?=
 =?utf-8?B?Z0tHWHJQK2dOeWRUWDZhUHpWZE14cnloY0VtR0NXVnZsQ0dubmNxNEUzN25i?=
 =?utf-8?B?UTV6b2Zubmc0cktXV25waUpJV1FMdXBKUHkrTnlSaE9uQXNnZk14a1hQYXpR?=
 =?utf-8?B?bGw5N1BVWU9qbUxqRVlyRVk1ZmptcWh3YzlJQllITW1jSHhmUDdSendqVm42?=
 =?utf-8?B?QjZIQUl0dVIvSUlNWWpDQzBRNzFFVmJ2Sk9GNGJwMFlSanMxV0swSnJpenBh?=
 =?utf-8?B?enRpc1J2ZXVkcUtMdDRtQlF6K1NJNkdlVUJ2R0dFVHZIdmJPbG4zSVhpd0l3?=
 =?utf-8?B?dzZhTUdhWEQwZjgvemJmZUVkM0R6YTUvTkgwem54cXE2NmJHSVJRaDZnem5z?=
 =?utf-8?B?WWh1aXpOcDc5VmhzNHNBQ2c5eEx2TlVObXU4WlBlQ1pQbXpnVzN3V1puSkNX?=
 =?utf-8?B?andWRzFLUitjM09KdzRGcStvUWJHNnk4V3gwa0hHTkZrS3lTd2lHcnVaSkpB?=
 =?utf-8?B?LytqUnpOeFNvMUptWFIzUWE2U1BYUTcyM1d5YmoyZXo5aVBTV090S1prREVO?=
 =?utf-8?B?ZWUydk1icGJneEw5bnA5eWw0eFlkSGFUMVpMNzJXVEU0aHhGdWJVYWZlVFd0?=
 =?utf-8?B?V0F6TGF2VmNiZSsyNHNTMHFsTHVaaEdxOUhaYU1GY2U2NEhPVTlTeG1jM014?=
 =?utf-8?Q?Vc/GhK8okShqhCe9NePeMaxOrGpQXq9Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTdHckN2d3JsSjUyT1VNU1ZHR0cvYmVGMktOOHo5dk5VT3FiQkxvSWQxeXZx?=
 =?utf-8?B?cithazZQd1l2STJHR2lQMUVhSHUxbktNaWx1dG9OTkVwOThCSFZrQXBKRGY3?=
 =?utf-8?B?RlJSOG9kd0loVFFFT0Jua2Z2ZkF6cUhnazg4NER1bjFPNUg0RW5DNU1Ta2NU?=
 =?utf-8?B?NHprVkx6TmhWcnp3ZGVwSFZmdXJtY0xRVkk4dzJ0enVRM1JTR2JUNzVrS2NO?=
 =?utf-8?B?OXZZdFhiN0w4RURWQm82amxEdGpxNDh5RExYSEIyN1dyb3FwSUJvWWJTMy9D?=
 =?utf-8?B?ZE8vR3ZadlJZd253TmxROFdMMHhUSzJEWm1Bay9FMEZnV2lnSStyTFFCYkRp?=
 =?utf-8?B?bU9RbXc3NHhsVnlMWCs5UzFIMWczTWJlaWIvSkxOYUZVbmkwZVExWkdscjNQ?=
 =?utf-8?B?V2dqelJTSGNFWk5jOEdIR3NhclpDYU1mMnRoL09HMG5QeHdSWDVNUGhMb3dx?=
 =?utf-8?B?ZkhIU1J2Qk1scm9QWXRxaU8yM3lRUGlGTmV3V0tORDh3MTBoc2pJZm1wNVBO?=
 =?utf-8?B?cFMya2FDcHBzQzJGanJVaHVRZEJzOGRHc0RROVBlSy90ZGRMWUhtbHZpYkRW?=
 =?utf-8?B?NkpUTFc1Z000aTB2QStPWHRiV3doRG5KeVhmWUZwN3dMTFN5TU1qcGxiazF2?=
 =?utf-8?B?eGhLcHNLZUpmNTdtOW9qYW1sVEFhY1NtelluQ1UrRTgyS0dXR2VKSTJuSnFV?=
 =?utf-8?B?VU9CYUg3b0ZsZU5iY29YQStOUTdZL3gwWEJQWmNmblRQVmFGdXJCdC9ZWkxn?=
 =?utf-8?B?M25ublV1Wm1sUDBnN1haUWphTUpPd09oVkJUM0pqeGFxYTMrZEprd2o2UXlk?=
 =?utf-8?B?UDFTUXNzcFp0ZU9qSkExY3UxQi9oYWdnQkJXRzFlSmtxbXIreWs0bWs0Wkc2?=
 =?utf-8?B?U2ZoYk04S1JZNlhJczh2Ykk0bmp1WUR4M3ZSL1Z0aEpkdXlLaHlVZmt1UEF5?=
 =?utf-8?B?OGFPb0wzdzlTSEtzTXdYS2kyTy9LbnV4UXJqRHUxekRDMldqQWc2Sk9aVTV6?=
 =?utf-8?B?RHpabW03cU5MU2tiWWJEdU8wdFNDUUg4MjZjOUFUVW1sbUFKVmRkNE1wNkg4?=
 =?utf-8?B?TGcyQ2NoaWs3ME1qU2lzUEdTeWlGOVhabFhCa1Nxb2trUnV2MjFIVU9RQnJF?=
 =?utf-8?B?UFI3dGRxU0ZWZWp6VktmV28vMDlrK3JXZ1lXR3gvZEVGY1BiQzU5NlJKWDNY?=
 =?utf-8?B?N2xPZ052ejI1VGRmd3VnK2VDNU1xOGlOZWN6d2c3S1daMXVqVmF1TmhGYWVa?=
 =?utf-8?B?VVVqQmNQaHpMWEZxSjVBY3h3THczNkc1NS9DczJHRU1HbWcxdEpKYWhSS1hU?=
 =?utf-8?B?eExJWkI5ZFZqZUhKUTZtbmtlWi9BN2ZGcmMzVTNjeEl2RTBOOE1qWmZjdThF?=
 =?utf-8?B?L051b2V2QXVTTU84YnZ6UmF1WEMxZnNNU3lHdk1sNzhCdGRFdDFDbnJQdXBm?=
 =?utf-8?B?ZFFEbUF1ZW9HYUwwcENHWjh6NS9SdVNodUNhV081Y2k4TWQ2Sk52eVFKeU1l?=
 =?utf-8?B?Z1k0WjIwcFVESXkxT0Uzai9zV1VrT01IK2VDd3NvSDVIQXh2YVRWb3c0aU5I?=
 =?utf-8?B?SGdCNzBxcWIrQmlWSGc2dnFia0svMHBjRGtrRnFqYjI0U3RjaW43eWxMb2RX?=
 =?utf-8?B?bXZCRzYzUHdoODJxQUxROWFxTmJLYldnUDZpWmNwblBsQjNrWVN6Q1o0dGRX?=
 =?utf-8?B?bkRmOCs3dXBsenFEcWxsT25kWDVOSkkrekd6aG1FN0JBeUtyeTIvUEVTR0tw?=
 =?utf-8?B?TUJMcFY3cWNqblk1RHhwWW42ckFpSklYY3BEcFNTbHpyUDd5dURDZjljV2dm?=
 =?utf-8?B?VWxIbUM0QXl0bnpvM1VBeVRod2tDb0I4a1ZtY21WNDgyOHFsMGlXSTdic0RT?=
 =?utf-8?B?S1JBM2twbzl0a3E2dWlhaEpmRVYwM0V2czlNRkwreE5XL3Y3L0JPaVBsNVlq?=
 =?utf-8?B?WUlmcjhUVXJ5SWJRRWgwMndkMnlVY2IrdTRLUThkbm8zSHdjelV6U2UrQk1w?=
 =?utf-8?B?ekd3K2Jta1J0NlRLTVppT3lGMGsyKzh5Q1lSV1d1TmpsMVdxaG5MYmRXb04z?=
 =?utf-8?B?eW0xYTFYRGZJM1NZU254ZkJJYnI5ejBzZXl5MVFjSzFlWEZPbjl1K3NtS3BC?=
 =?utf-8?B?cXhVOWdGYmpsVk1HZGw3Q2ZObFBoblovRDhmb0E1TFVKK2FrSUJVQnY0UXhN?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LWnqavO9/IsxNSsoe/wdD8tpZ2nXG3XuavTrkf2Z3EWbkOu0Osyd4sGF2CzRcnC/VbX10u4Gev+AiCSwge/YZIQ7DkgKftWfH/t6r4YfIbqjtE+cTvwhGitQRORbUJeCWMHAuWbRc1LYNYKR8EPkfEgiJoZA8U2Y38dFAYGa/SNK14N9r0XbVLeBqh9XdH+Noi516uYjtyRj6kyXeD8bY20nruRQzrcZZSI4C6RD/RpRhRvUMhzXAeoPPJukF1Rx5sbxUdWBX7wF4hGjNRyUzGvl0Vb5wlx7nVQF3h5pSbuWrIl+YHlWC8R+ubAmzJp8Mn+gmYnh0ngRl6g2NC497efiQTxx50U+aThrmmU7GSGYYqyjSXU6BGvwGNyy5uOliDsw+G16O0kmeRVxu3632w4SgULkTJaO6Na7/vMtcrmtm7UGN98zH9LwvFMjn3O9eTSDPeEtzvBdocLPSC9uSMdyqzc01VPaKeoXmoy3E42MduVbeSt4UaPGMUYB/tjNqjkw1N4xpRxo6zxZoLoaWXH67eEhPDy1+1gBytANXwEa3dPLHzNBPjNYUEAlrlAtSsP9D9Gf0EyEFVvWVgu89PUPst9xhjvevZkTAu//IeY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 908a2c5d-9a30-478c-ef39-08de178df589
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 08:26:01.1123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZgyrPbM3gICBHb1P5RndCUehxXIlI9oyU/DZWSun3faXMUna4QcA78S9WN4fIHsMrqCqqCbiZ6MbnbfNmZi5s2TSDjTKqk44gKXa4bk5gvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5747
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510300067
X-Authority-Analysis: v=2.4 cv=PoGergM3 c=1 sm=1 tr=0 ts=6903211c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=tPu2dLCoSz1dwxMZUn8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: lXgwf4UEfiAhAM4HU30-SNHirq-A2d-5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA1OCBTYWx0ZWRfX+C/yZGilvjwN
 F3MsBy10rL/PwWYgJ2UGjzTpqoRiUYYz0bj2A19rlJneAVVLFdArut6jnQV+MBmUBEmZmyXS/1+
 A1EJB9HPs+WU3ieQTxBKFkBY4eQNGBwPlDZfgNTgJay8PGxjNmpSMvMKSgr9Y2H3OvZsZy2LRgG
 Tkg3RVa4Wp6oW4J1Z4sscniiNnDpygG6RSVF3FD2Gv496X6k+SaRuZDhd+fTVJ0845zntjcRubx
 ADcK00G2D+EsdCbXADpmkm0aTkAfg9zlDfo+21vbLbVqi6+EU51PpMP+6ZAhwFYObB9VC0fuW6a
 rGYzVrTdpPyxZsQKpmH0bASm8xCpM+x0l893xVU3kyVH3KrMtux3ZHNl8B+hFlr+AmPImaiVQxN
 GzfBVT7zSa3x03WZB6bVuQluVvWjlQ==
X-Proofpoint-GUID: lXgwf4UEfiAhAM4HU30-SNHirq-A2d-5

On Wed, Oct 29, 2025 at 09:40:19PM -0700, Suren Baghdasaryan wrote:
> On Wed, Oct 29, 2025 at 9:51 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > Assert that we observe guard regions appearing in /proc/$pid/smaps as
> > expected, and when split/merge is performed too (with expected sticky
> > behaviour).
> >
> > Also add handling for file systems which don't sanely handle mmap() VMA
> > merging so we don't incorrectly encounter a test failure in this situation.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Thanks!

