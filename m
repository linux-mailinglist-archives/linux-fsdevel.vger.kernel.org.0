Return-Path: <linux-fsdevel+bounces-47278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5906A9B45C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 18:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C9814A19BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 16:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F0C28B4E7;
	Thu, 24 Apr 2025 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aPYolpTF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QJypq05p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642F4289364;
	Thu, 24 Apr 2025 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745513004; cv=fail; b=DzgEmFetg0XFPKuROd9/KHTXew1w70APxKIggoeAXf6ryp6FRCgffpoCQ+Znv0TfghX3yaMhctgFMsoWqWS5YpyFgfMLR0M+Bbb9ZcSAmWAebtFWe/Tv4/P9BfD/P+WecrvTl5/UFE4kelWsq6iwkNvv5J1xD1loDcbX9d3q7uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745513004; c=relaxed/simple;
	bh=QXjPkSVocxP+sxvhJS1tPGk6S4CiUTRJ1ZoyzfC87Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Axtt2lIrAvNrGJ5DKRH7dYXVmyHEaw5tUfdJEpOWPSK4by7o+H+KsNOENft/xgR3QvOu6OQzSzmnik2J8k5P7DXgWsRNH0OhqSn2FshIn68Iuku/aXMm6h5RVsYhQgqa9nFREJv1+1CoCqqOeNwGZ0FUK/j4RqxTn+GPilOsJyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aPYolpTF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QJypq05p; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OFW5OE030592;
	Thu, 24 Apr 2025 16:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=SS7Fscz0NsjUBSIC4uEu0CAwJkzfiao6LgVuNc8iPnI=; b=
	aPYolpTF86jez7xZLde8lzQCjrQROlwZ2JmxtVqOwGlx8GTHgu6+aBCMceNViG6D
	mroyYS51cKDj213LFXVHTIB1rRB8+PYZ4Q3yuiJCiUcbJ9bkkb2t5I4CZ91WdIQb
	0O/78c1gd9hwn+lk2gpMFaDI+h83PVvYjYBLOvJRVKSeCfc016clsfS3InNVn+1p
	+FWP4y1/TfHOCRGgYTIhZYtZOQzwVpPTRdh/iHO/7ntFFJ4jGA1TTdwJrhzoCzRN
	4CutXIYIpy+aCM2ySlmWMDGXzETq2ewpWgYMUmpjV1XOh/0AxBk5hYgl1fF15d2c
	PynxGYWWK1LpQ5/PgUnkaQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 467r158aw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 16:42:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53OFt1j7031635;
	Thu, 24 Apr 2025 16:42:53 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazlp17010007.outbound.protection.outlook.com [40.93.20.7])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 467gfrn6v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 16:42:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJZJK6DMx6vwfwkEtPnHSXZ9DfFFZiEIhR6ecmWrhtHdF5reXaOCOeI3kMIba8beRJ0A95JugY7FhfqgY9JtrUWDK7ZSIRxoB1Z3kCpuRbLrjLifx2H/wx1eoAuzpS2SKUowCpMYCmDfD0Q2N1yrDKlRZ4CQy48wAvxvLIjTqVP28XGePCj7a7KRXAQjjPTytFLHzWYL0L44KUu0wNqxaQ614XtecMh7lPlVX2SNLnXorzq3YEMaartGNARFuCQkoao5NyL724bZDhO0YwAI/1StbNTivRiDtYKqVy00t+hnEgBbepslENOzccLysVzkFt0kt0jIg/dMpmZAPPvDyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SS7Fscz0NsjUBSIC4uEu0CAwJkzfiao6LgVuNc8iPnI=;
 b=a1tWTmdJ2phL7kdnkjQS9XJaWJruWyQKiFyGncZcE0rMcHc+G4UcwG+zuEXXwJIk+275XLMIAvOhRIRz2lGfV4vz0dBGw2V78EfgZjVEFsTOxsyR5I+2GqoE4EjRSy7nxlaeAJm/lRPGvcFxUjpJT/pmXNb1Z1ZRIlHVmXefRU5l4S6i9OC9OxZW7uHAXDnD4et2rLElkWnolCpRvP4Uk/hBDsQRhoMQNmyfze5acUvdALZ/T6ssrEUA/zYKX82ylKo3i4qR0lkozw3TkGkfBmu5o1UqjTyMOrcShiTmPAI/H4vWWzRG5IPJqBmF1yLDQYDeHkOs7UrTwGEQxRTuHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SS7Fscz0NsjUBSIC4uEu0CAwJkzfiao6LgVuNc8iPnI=;
 b=QJypq05pfUnp1NCFD6F6gcKFrGR4PsQgp3qoKNbHUjcFOy+I43yw3eMQRA32BS7ZrZNhXHgQfqrfGj2FnBO6fLWogg3Rw5az/tOFkjZhBP9Wwa/Sh/ZWsQIMZrm290OH0Dj9ZZ0eqZhvSO226jQQZYN2jDYv0CVsHVXb9gFgJxQ=
Received: from MW5PR10MB5764.namprd10.prod.outlook.com (2603:10b6:303:190::15)
 by SA2PR10MB4780.namprd10.prod.outlook.com (2603:10b6:806:118::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Thu, 24 Apr
 2025 16:42:49 +0000
Received: from MW5PR10MB5764.namprd10.prod.outlook.com
 ([fe80::8d9b:9200:a7f5:19a9]) by MW5PR10MB5764.namprd10.prod.outlook.com
 ([fe80::8d9b:9200:a7f5:19a9%7]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 16:42:48 +0000
Date: Thu, 24 Apr 2025 12:42:44 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        lorenzo.stoakes@oracle.com, david@redhat.com, vbabka@suse.cz,
        peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org,
        mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org,
        adobriyan@gmail.com, brauner@kernel.org, josef@toxicpanda.com,
        yebin10@huawei.com, linux@weissschuh.net, willy@infradead.org,
        osalvador@suse.de, andrii@kernel.org, ryan.roberts@arm.com,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 7/8] mm/maps: read proc/pid/maps under RCU
Message-ID: <by4pd6zomtvo64vjddthqu3ps2n7fqzaeqttinmy5nzttxjjd6@ch2uxmy2bgks>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Suren Baghdasaryan <surenb@google.com>, 
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, david@redhat.com, vbabka@suse.cz, 
	peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, willy@infradead.org, 
	osalvador@suse.de, andrii@kernel.org, ryan.roberts@arm.com, 
	christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250418174959.1431962-1-surenb@google.com>
 <20250418174959.1431962-8-surenb@google.com>
 <CAEf4BzYuA3ZRCwPsAxhQZDOOpjSTrphKEsgPAqgRP8Ly7+fTWw@mail.gmail.com>
 <CAJuCfpE_jJ0Xq5T0HcLpquRzO+NdvN3T3_JXEwSjt2NG9Ryy5g@mail.gmail.com>
 <CAEf4BzYctDuS4DRTzdRQyyhCYvFTggOz=wcbizXEYvC_z_SSng@mail.gmail.com>
 <6ay37xorr35nw4ljtptnfqchuaozu73ffvjpmwopat42n4t6vr@qnr6xvralx2o>
 <CAJuCfpGc-23xpEYZQQevkzx+iN3AAqXXzbyqJAQjd4TQP9j9Dg@mail.gmail.com>
 <CAEf4BzYBdG95Zhi0M0CDTHAU6V9sF+kGSLB+346dq0Aa4Timmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAEf4BzYBdG95Zhi0M0CDTHAU6V9sF+kGSLB+346dq0Aa4Timmg@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0236.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::11) To MW5PR10MB5764.namprd10.prod.outlook.com
 (2603:10b6:303:190::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5764:EE_|SA2PR10MB4780:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b42d20-0e4a-4112-1305-08dd834f0c1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3YzTFRuREVES1BzUE9DaXhxR2tUaVIxbXNJYWszK3JST2JHOG1kQU80Ukwz?=
 =?utf-8?B?WmhySWh3SkZwd3NjZWxDdXo1eit0UjFiQkcrd25yLzVjOW45dDBaYndHTzFx?=
 =?utf-8?B?NldSUDZnanJLNDl0ZHo4ejlPNGIyNUU4M0VuMy9xRWY2cW85YnQyUWdtYm1h?=
 =?utf-8?B?NXVYQ3dBZTNhazc5Mk1CVEpwYlVncWNLUTExMThMQTZmLzdaemhpV3NhR2ZN?=
 =?utf-8?B?dG5rdUFubGJxU3F0eGlIbTFZSXhldDYwRVEyN2svdzNEN0VPVjVBZVJxbkxo?=
 =?utf-8?B?M2YvNTBaUGhmMStqV3hsR1RLYVVMWm45bXEreWNtSm5oNDJhekJvVUZYM2V1?=
 =?utf-8?B?aWl5V0tUWHJaTEtBVVJvT0ZuZjM4M0dWZWt1QXdJdlJKUEEwM2NZMEtycTB3?=
 =?utf-8?B?VVpGMTBQbll1Wmp6YVpNUytPbFZVaXNLTVZFTDI0RGkzK3FuaWN3OE1rM0VH?=
 =?utf-8?B?aW1CTWtjZk1jSVRzM3h0QTFtZlV6NEQ4ZGV4UFBid2FZM3RGdFMzMkh5SzV6?=
 =?utf-8?B?ak5tVUxoTFZQWkg5Y0VYcElOMTU0djFDejJIVTRNVDBSdUxmbGs1VnY1WUkw?=
 =?utf-8?B?bzVQNElNOWN3TlIrcUhqdGl3UGtuUDQ3UmVVWGNNdTM0NWVBbUxMKy9tSDc3?=
 =?utf-8?B?ckxybkI1Wm9NOVh0MFJ6UkNmbTVteTYwZythMXYrMzNyUUlyL2VNT0JxVE02?=
 =?utf-8?B?blBlM2F0NVhtM2lmVTA3elJudnlLbDVqQ3RkaVM0Zm9JVlpDcUVZN1AycFpM?=
 =?utf-8?B?c210M1UzOXBDZjlIMDdBa0p4NTZMd3hXMTlSaTFYbXBYc0c2WEhtUzI2bkox?=
 =?utf-8?B?L0J6bTJHdHlDZXhqL0w4cGdQNkJ1MTVaSW9mTk55TTFMcVN4UzBCTUtPSkFR?=
 =?utf-8?B?dy9HeURySHFkWjZCcmlNbkVWQnlhMU55VTRIVng0Q3B3ZTVWOU5tZzFwN0hZ?=
 =?utf-8?B?VnBIMzRTVk5XRTYrSWRxVTFYeHJMaU1BUmplSkt2UGpmS3FHbzZqdnl6eVZN?=
 =?utf-8?B?QmZ4Q1Vqc0F0TTNFS0RaMSszbVVDZHRBQ1ppd3gyZ2xMb0JaMjhlaFlUT2FJ?=
 =?utf-8?B?WkhrZ2poUFVsZTFpdWZiR09WbngrUkhDb0luS29leHh4Z1ZmZGxNUGhKTlNv?=
 =?utf-8?B?ZWVrcmNsU3U1QTFqNUs3RkR6MUswdytoUSsyMytSVU5Sb1BlVnppSmwvWCtJ?=
 =?utf-8?B?QWlrN1VoQTFDeHliV2ZLalkwZWRENGxwSFBJbDFzMVVoeTlyQU9KSkVnVTlF?=
 =?utf-8?B?aDJLTlFEYUpTTTBtb0pSMVlwT2lxbmM0SWR6NVlGL0k4SUhxNXg0c0ZmSFNk?=
 =?utf-8?B?MVRlVzk0ZnN2Y0FwYTNrREVoUE5SMVFoa2NxWHlUWmJBZW16ZnE4THhpWm9Z?=
 =?utf-8?B?MFNMWjJUNDV2WmhoaUFtUHBrQm5uOVFDR0hxa3RWL3RGQ1M0b0QrM29tRDgz?=
 =?utf-8?B?VUEvSmhibWgrV3RHdG9qVWRxK292ZmtBT005T2JNczZLTURNTkphdEcrTUZQ?=
 =?utf-8?B?Z04waUtSUlJ2SFlKWXl0aWlzNVdPY1RHejBscmR1QkJWdTRsMUVjTnphZnlx?=
 =?utf-8?B?K3NRMkVXcVd2bmJLTjNzK3RJOXpTZ1BUMGxwZ2ZyRFBFVHJpL09qWDJCWUtP?=
 =?utf-8?B?Rk9ZeVZFRnZVZGNCMm0rODh0QVQwaGRYU0NScTJwWXd0VHQ1ekNrL09Wc3Vs?=
 =?utf-8?B?eU9UV3pzd1JGcHFOVnJJM2d3TXN2eXdkVDRXUGVUckVBcXgwVXJUVlh4MEtW?=
 =?utf-8?B?QSt5T0dNK3A3bi9xZUJzTFZsNzBEd04xOVcvTWZHNnF6Ymg1RlZybDhLRzBY?=
 =?utf-8?B?dERIeWRhNkJaTlBPRWhSMFBBWFlkNm9oVXFkS042ZEZLOXp0Z0F6ZlFiMjk1?=
 =?utf-8?B?VjdmdnRqckR5L0RQUDNhSUgzTWxXcjRZUjhia01KZzJGS29pcTJGNk1xYlpm?=
 =?utf-8?Q?nV1UeZH5WXA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5764.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0NqK1NSeWpWUzJOZGNlM1c5N1VKcWlrODZpU2FHN1BVUHFEWE1hVnppOVhy?=
 =?utf-8?B?dVg4b1hsRHNLWDlKQ3JybjZtNXhHRkVHU1JHbXVlcFh1eC8xc0Z5YnU1Y1lS?=
 =?utf-8?B?dHBWM0RvZkFPeElRd3JMZi9YeEFnbitVSjBId1NzZmpOOTkvZjQ1aGd0R2JR?=
 =?utf-8?B?aGZXTWtpYjdyR1VuNjN6bnRhYlFsTVdtMTI5bkVNVDZkU1J0M2ZjT0ZiTTZo?=
 =?utf-8?B?cFJrYjJFT3pUeWRkZk9xdWFzMG5pMXRWV2FWenZrcGFJamhVeFkwd1ExZ1R5?=
 =?utf-8?B?c1RQak9zbmROVkRVYUw1TC94QVpyVWlyZS9hd3hmR0RDaWNyYWp4RUYrUWUr?=
 =?utf-8?B?c2JWNUpIVitacXFkSXpadWxMWlU2bFpVT2tMNTJNWU9KOCtiQTVqY0FqeG9H?=
 =?utf-8?B?Nmxyd0R2bWZEMGdxeU1EMDdxc1BrYS9oWTFieXBkc1E5OFpxeWs4R1M0V1Qw?=
 =?utf-8?B?aHFxTElLMCsrT3RBQ0lsQ2xDZWYyd2VyZlBUSmwzWTFlaTdBclJLL0szWk4v?=
 =?utf-8?B?M0I1R2pjQ0ZEMkhJbWlBUjFaRTA5V2wraFB5SUxaNm1mVkUxMmFiZ3VGS21S?=
 =?utf-8?B?d0RPK1JNclg5WGF6MVNBUDNPQUxleVlKV3NkL0h2ZGxiUWVGZzIzY1Zic2Ro?=
 =?utf-8?B?czdRajY4K0xJbnpMM0F5d3NGRGg2dE5tNStrS3VQaVdCRjBXellnSys4aDM0?=
 =?utf-8?B?T0YzcVJReHdIak9iamMvL05lZnlLZzVpOEtueVlGS2NxMFQyaWFXTXVjRTBl?=
 =?utf-8?B?MWx6cTZEVG9nOHRpR1F3TXpNaHFOUEZ3S2YwZWVnYUxzaGprK0NzaXFMM2J6?=
 =?utf-8?B?Ulk2TFl4bWdWazgzczRaL1VVNUdmdFllalNGTVBFTG9YYy8wd1h3QzN1bW5F?=
 =?utf-8?B?UDJpL21KbVQrYUl0L0E5dDF0VUdxS01ib0xQS1ExbU5Pcm94WjBhMWxreEdS?=
 =?utf-8?B?c1Bnb2U2U0NXNlV5cWNPV2JqQkg5MEwzMm9KeHN4RUlnQXVldVVlVkJyRHUx?=
 =?utf-8?B?YjBocm1ia1M1cjVab2hBaGtnSk5UZW0zMWFneFVXeWJzNTRRcUFsbDNTeWdI?=
 =?utf-8?B?Y0haeEp1TnJCcWJhZVlGaExXV0szcWJZaWIrZWRQMUxXYitQYS96T3d5VlRa?=
 =?utf-8?B?cWpDbUhxVzdJd1ZZV3VneHozK1QrcU92ZkowNlQ4WHk3YUdqY3FCTzg2akVQ?=
 =?utf-8?B?NEVrRUFmaEtLRnB4U1FlbDBmQlpkaEZaWjZOajU1ZENnVWxzeDhFMEdJYXFT?=
 =?utf-8?B?NVIrSjNZL09MaVoydzcxM0hraDI2R3Y3K0J1aHFUS1ZCeDllWXBOL0VOK0Vs?=
 =?utf-8?B?RUxpZEZ6VU5hMUR5dDNwaE1JRlEya0VxTUFHdWZLenljUDdxdWdSS09oNzEz?=
 =?utf-8?B?Rkg5Zk5kMWVmMDEraDBiQ2ppaU1iNGQ5OVVxZDFpMzNhemlqNnZ1M1lzdVh5?=
 =?utf-8?B?OUdnVndMN1ZVMCtJU0ZTYWZZdmlHTDVwbFFPM0JLUUwzSXg3VWdMODRJdFZT?=
 =?utf-8?B?cjVQMXI2cnF1OXlkckxENW1OaWFwVlM1YWhVOSsyNHlXVStTa0JFNnpycWpz?=
 =?utf-8?B?NzBSR0pvRnQwTjNlRVBNYkdIdk1WdVFjRHUyNXdySjN0WjdsQ0lyRGZ4SER1?=
 =?utf-8?B?dGJ0REVybTVkYTdyc0t2R3BSMzQ5N3NyTENMK2htY0tub09sS0tqdkNiOUEv?=
 =?utf-8?B?ZFdWWWY2c1l0RmtZVXZpOUltdC9hazM2ODdEZ3lCcXlIdGYzT0ZlU3JzWmdR?=
 =?utf-8?B?aElrYW5NQ2I2Sjc4NzMvUmxEYm0rRVRNa2tiNUVZZThESHlFU1lPTUlOeTEv?=
 =?utf-8?B?dVNzVDFSam9GcVZkUVV0OXlvK2VmalNDMDFzSFMxazlySkpTUTdieEJjZlp0?=
 =?utf-8?B?VlBFZEdpc0ZRNHFBYmpQTmlYcDg0a3g3SStKTXpjRWdENjZSd2RJME4yVWxB?=
 =?utf-8?B?QWtzQWpLUktEOFMydlBZWGErZElHWEZtQlVxTHFtS2NuT0VsN1BtT1BIV3hH?=
 =?utf-8?B?K2cxUjY2bVJQcFJMbk5rNzhLSFZpNENTWUtSN2ZPbVRkdlVhYjdxWE1maWFF?=
 =?utf-8?B?OEZ5aUtncEprU2NpV2d1V29mWVl2MkZKOG9vSFhrSURLQThmVm1kMzZsa0Jz?=
 =?utf-8?Q?Sp3VtDmpRnHJVJ5DN48KWbcUK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ACxrEh9n0V6/KPIlQyCLrVhGEa9Ps5ZGKAsnNn54/P6i1BZCzGD/CWIp3a5MHP6+jNbnLPdx2V8acw4hYstG3N1N3o2KEAE4SSPRdl0nWdKNKU+NUxfLMw390wA+UPP8H8312YBrAe7qsocnMnWx8c0MkMUMhAM0Hjfz3+LpOPRowf2qxDPCY/A0DFR7dTkMY4gxcv/+XFcw63EHKKp/pMAgISPKIu7EOuy8q+FVfpwK94KtCo5EmyiXOwus1engasbea3P4jf0s1UCu+ew4LBBouanoMbUifRm1IAqWh5gI6QP0vqsMvwJHhH+1oWPU9Uz/0OoNGJ2+7HEs6oLvgtW/LQmBWUjBxb79T46fxfkQ+wdVMdINfZ9jmZ1MtWdshqXiZf5e09Q9GsyI3LqaVwbN0GY0k0WSDVKjlHCAzX+HPq6dBkxuRqjExH/KwT65v+9E3g+YAMnxRlPLvtN8TqA+xTQIfy3ebtmVeB2X18aPbDZ0Duf7yHHU/NgoDXKOE/AL2Pli6p3cxXjBq/O4WxIe7FnKxOe2V5EMtGg46J+fs9QsvfeO4HwYqAtS/DGf7udfcYMN8XBwpajZwq+Stty/cwx79uGa6M7FdbHYCF0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b42d20-0e4a-4112-1305-08dd834f0c1f
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5764.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 16:42:48.8067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fMswLPVj/3Ncv+GX15MekitoSNkmvlAB2+xavyktj+q1+rj27aGb53kI/FT26XsnBAq5yPycm2bPan9GdNel+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4780
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_07,2025-04-24_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504240114
X-Proofpoint-ORIG-GUID: 4ybwqqFcaqwrY79v6KDJfjKwt4F49FDV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDExNSBTYWx0ZWRfX9Z+CHhb0be9n P+8oOpiKKGYXH0cUVgQ/Ja4O91Yl9aSjdkyftTS3a2Bg+5670ktJPZkbsIO2xQpd/5t2JvqvPQA C1SAFtH0bS4phUN0d8VnR/ZEGrlmE1qY66UdFmmsVdKD60mNbzUOIO7kQ1v2SZrNHkKyro5Hi4C
 VNODBq7bwxQHy+WkB92ewk4gpdZniOrs3e8WyUluCqPIc1koUu/GrqE0pP6hVDvlpb52weEI4Li LmM8ajLSY9ugDPldV+Gn0CJFL4tX/H5FjykTuXorN3QbPFTUWmntswKu9gnTsDK2DwkJDYqTwlG SE/fSmWdaoZ7K/jZqNf1tEQraYiuKpGlf/bsCnxTJIGAOV6K0HDnNyS8SCo4+z22owsFa8tEc/2 sVeUECPU
X-Proofpoint-GUID: 4ybwqqFcaqwrY79v6KDJfjKwt4F49FDV

* Andrii Nakryiko <andrii.nakryiko@gmail.com> [250424 12:04]:
> On Thu, Apr 24, 2025 at 8:20=E2=80=AFAM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Wed, Apr 23, 2025 at 5:24=E2=80=AFPM Liam R. Howlett <Liam.Howlett@o=
racle.com> wrote:
> > >
> > > * Andrii Nakryiko <andrii.nakryiko@gmail.com> [250423 18:06]:
> > > > On Wed, Apr 23, 2025 at 2:49=E2=80=AFPM Suren Baghdasaryan <surenb@=
google.com> wrote:
> > > > >
> > > > > On Tue, Apr 22, 2025 at 3:49=E2=80=AFPM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > On Fri, Apr 18, 2025 at 10:50=E2=80=AFAM Suren Baghdasaryan <su=
renb@google.com> wrote:
> > > > > > >
> > > > > > > With maple_tree supporting vma tree traversal under RCU and v=
ma and
> > > > > > > its important members being RCU-safe, /proc/pid/maps can be r=
ead under
> > > > > > > RCU and without the need to read-lock mmap_lock. However vma =
content
> > > > > > > can change from under us, therefore we make a copy of the vma=
 and we
> > > > > > > pin pointer fields used when generating the output (currently=
 only
> > > > > > > vm_file and anon_name). Afterwards we check for concurrent ad=
dress
> > > > > > > space modifications, wait for them to end and retry. While we=
 take
> > > > > > > the mmap_lock for reading during such contention, we do that =
momentarily
> > > > > > > only to record new mm_wr_seq counter. This change is designed=
 to reduce
> > > > > >
> > > > > > This is probably a stupid question, but why do we need to take =
a lock
> > > > > > just to record this counter? uprobes get away without taking mm=
ap_lock
> > > > > > even for reads, and still record this seq counter. And then det=
ect
> > > > > > whether there were any modifications in between. Why does this =
change
> > > > > > need more heavy-weight mmap_read_lock to do speculative reads?
> > > > >
> > > > > Not a stupid question. mmap_read_lock() is used to wait for the w=
riter
> > > > > to finish what it's doing and then we continue by recording a new
> > > > > sequence counter value and call mmap_read_unlock. This is what
> > > > > get_vma_snapshot() does. But your question made me realize that w=
e can
> > > > > optimize m_start() further by not taking mmap_read_lock at all.
> > > > > Instead of taking mmap_read_lock then doing drop_mmap_lock() we c=
an
> > > > > try mmap_lock_speculate_try_begin() and only if it fails do the s=
ame
> > > > > dance we do in the get_vma_snapshot(). I think that should work.
> > > >
> > > > Ok, yeah, it would be great to avoid taking a lock in a common case=
!
> > >
> > > We can check this counter once per 4k block and maintain the same
> > > 'tearing' that exists today instead of per-vma.  Not that anyone said
> > > they had an issue with changing it, but since we're on this road anyw=
ays
> > > I'd thought I'd point out where we could end up.
> >
> > We would need to run that check on the last call to show_map() right
> > before seq_file detects the overflow and flushes the page. On
> > contention we will also be throwing away more prepared data (up to a
> > page worth of records) vs only the last record. All in all I'm not
> > convinced this is worth doing unless increased chances of data tearing
> > is identified as a problem.
> >
>=20
> Yep, I agree, with filling out 4K of data we run into much higher
> chances of conflict, IMO. Not worth it, I'd say.

Sounds good.

If this is an issue we do have a path forward still.  Although it's less
desirable.

>=20
> > >
> > > I am concerned about live locking in either scenario, but I haven't
> > > looked too deep into this pattern.
> > >
> > > I also don't love (as usual) the lack of ensured forward progress.
> >
> > Hmm. Maybe we should add a retry limit on
> > mmap_lock_speculate_try_begin() and once the limit is hit we just take
> > the mmap_read_lock and proceed with it? That would prevent a
> > hyperactive writer from blocking the reader's forward progress
> > indefinitely.
>=20
> Came here to say the same. I'd add a small number of retries (3-5?)
> and then fallback to the read-locked approach. The main challenge is
> to keep all this logic nicely isolated from the main VMA
> search/printing logic.
>=20
> For a similar pattern in uprobes, we don't even bother to rety, we
> just fallback to mmap_read_lock and proceed, under the assumption that
> this is going to be very rare and thus not important from the overall
> performance perspective.

In this problem space we are dealing with a herd of readers caused by
writers delaying an ever-growing line of readers, right?

Assuming there is a backup caused by a writer, then I don't know if the
retry is going to do anything more than heat the data centre.

The readers that take the read lock will get the data, while the others
who arrive during read locked time can try lockless, but will most
likely have a run time that extends beyond the readers holding the lock
and will probably be interrupted by the writer.

We can predict the new readers will also not make it through in time
because the earlier ones failed.  The new readers will then take the
lock and grow the line of readers.

Does that make sense?

Thanks,
Liam



