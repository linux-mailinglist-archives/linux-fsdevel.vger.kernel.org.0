Return-Path: <linux-fsdevel+bounces-47830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E64DAA601A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 16:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0CD1BA82D7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 14:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E983AD24;
	Thu,  1 May 2025 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X/PS04ct";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U7R9soiw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098BC1E7C18;
	Thu,  1 May 2025 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746110061; cv=fail; b=nxMOiXTHzhnIb5Ssk3XQ3X502KkX1WGKrbB1oy3bl42Gb8Guv7Ys1VGXFJhUhS8qscVdjwtbgyplNhyD5Y6b0Zm6MtvDIXZmAsfAyM/Qws0xNpbfo+39GxMInYaI3nq6UxGkUKzoIESwHtgtesTrReA7N1drNUHmwbhOKlQ+s1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746110061; c=relaxed/simple;
	bh=wryAF67hdcJiLHkyOFaFjqBRTCfqj4o1BfuDrAd6wnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dZ9+EilIku8zY+MUriTtIn+JOTHZ8AaIOf6hwyz5KrRIUZFfKqp5/AqEfFckVQ5/U4FIF4Y6WMJP5L+654VqNK0ESfopImhmuXbfWXimKUlPD0T30E8GLmvPFjKBDSWdTd15EfvD/KJUwVYCfMUSsDFZlABSWzA8V99n8Tf63lM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X/PS04ct; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U7R9soiw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541EMtD9007016;
	Thu, 1 May 2025 14:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wryAF67hdcJiLHkyOFaFjqBRTCfqj4o1BfuDrAd6wnI=; b=
	X/PS04ctaPyP4bPG4h0fi+8smUrgd6Sq5Bp5mRlIKePT6XAbFRDLZJYkHSJkiIri
	qm4wUA9POYsYbL0KcDKSE7zpNm/HUIlkDZ8/mgAv00Xt4d09Ji4M0vBTnBtvH/uH
	U1K9yy4xRVt7daJfK5x1Wql9slGRhgChXw+DXh0xxOdVzuzlug4CPaYvgWiODVdr
	l+EXEadE9YwDhsiNXdGtLEt7AnoNpSAVQAF4EYh2cEzVugYzblina1OcXbieFiDh
	sRVjrfa/uiYsQFy5cStb9YX///cxE9sOOkvbid4+2KuYjwgveZzuUK8th4gW4wd3
	flSsnWTUpWMcktV/Cd5CcQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uku5sa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 14:33:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 541E2Smm033464;
	Thu, 1 May 2025 14:33:58 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013074.outbound.protection.outlook.com [40.93.6.74])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxcke4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 14:33:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=psoPkgpoGwTMPBBJTaDIAycLChjI7Srb1g8BicHZk8uty49lBoIP+iRGnVpRSbGa7U/rMQPrJx/cWz8e7lMbSuoprpHbkjLXb4Z5gtSozj+X8YtLbFtsnovX+BjMlQPGhEafh4/szySSmp4RgxgorPNQ3yq3LRSvCHSETQPNVke6fAcOI7CwFPKHJlZwR3A8ObZ33n52+IsRww2BmdNVRyFdhW9V7eKpFXD1F4DqSfQsyGnuetNrcw9hJz4jzvrtAfhqbye4YaAJB+EW0Sn2uySHX6scKB8KdHhvMTWX+n82+USA0yzTqroeIHXs68p7/pxhTjS7slfRmYljgSgFYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wryAF67hdcJiLHkyOFaFjqBRTCfqj4o1BfuDrAd6wnI=;
 b=MTHehZpiNndOiUvuHCIUbzhF4ylvxB72RMlhe/qHpHNn2rfUYInwtVbmXgtMBnDeo7G7Q5XMD4LnLaZarV8VJ/dINcwxq8VqFx1IvOuZrohn4LmMSY9dAzBdtxr4Wz0LB6iV3DkhohiNs1ZyrbKpiB0/y/Jfmts5LfzTo6IqbWi8pdIj9/2hmN77E+pE5PkGsA216yXfXczo6nDTh/ONVglbwIH9ESKbl4LEm5Rjwl/kecJl6oFPNuvgVdhAC25MOLZ9VggWJZmg1ke3jQv1izZue0yh7cHNcCF/N0f+v6MScpweEED1/eIqcpCwDJnc8hiz2rOo8uzZPL4T2bjF0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wryAF67hdcJiLHkyOFaFjqBRTCfqj4o1BfuDrAd6wnI=;
 b=U7R9soiw0HDwOqFSuXHIM+QnIzTaF/NspMFyubmHABPYPq5Atokuchi+Vp95EC1Rc+aV6tu6kax6B7Eu+UeTqvsTWFIT/j0oTPfAVa0NgEaXsK7DLGuBW4OYc60r0BJ7Uifh6LezY0L0OCfINibwJ+uxdQWf3bZ12rHN25mzjzw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BL3PR10MB6139.namprd10.prod.outlook.com (2603:10b6:208:3ba::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Thu, 1 May
 2025 14:33:55 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Thu, 1 May 2025
 14:33:55 +0000
Date: Thu, 1 May 2025 15:33:52 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 0/3] eliminate mmap() retry merge, add .mmap_proto
 hook
Message-ID: <95db9ded-ebc1-4e28-99d9-fc3e98c49aec@lucifer.local>
References: <cover.1746040540.git.lorenzo.stoakes@oracle.com>
 <CAG48ez25mXEgWSLZipUO2d7iX-ZjF630pMCgD95D9OuKGX1MfQ@mail.gmail.com>
 <c2254436-008c-4adc-a144-78dc81d8607e@lucifer.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2254436-008c-4adc-a144-78dc81d8607e@lucifer.local>
X-ClientProxiedBy: LO4P123CA0198.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BL3PR10MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: 69a8982c-ed76-4bd4-869e-08dd88bd337b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHNaTWR6eVEwMkhXTjFlS29JT0JxYkk5QStkNEhOY0o0cHlVSG8zb3BmdUFa?=
 =?utf-8?B?eEsrOEE0SnVpaithdmZlaERKQUtHNlBnUE1aNDV0eVRXdXFvWHJ5aXpUa0lX?=
 =?utf-8?B?ZGpsQnMzcVJKYU9qQW1IaG9KZytsRVdLQjNBSWZKZjJnRnJEY2Nla3JmOFlp?=
 =?utf-8?B?TDFPSXc4WXg2bW9ZaFpxSDQxc0NieEdkaUFTTWkyZ2swTmNnbjdqYlBGeVhD?=
 =?utf-8?B?TUFhSFdKa05DNzRiV1VpSFREKzlZcGQwTGVpSGplaDdoL2E3RUUwOXp1R1JJ?=
 =?utf-8?B?aW1XaFd0ajdwN0VIc3luci9tNldHeUI4T29Ib1VSSjl3UG9pLzhQOUdQTHc0?=
 =?utf-8?B?cE9ndVZaUE42Nmdza0dyS0QrY1JSVlQrbXNoMWdpVWZhbnZQeTF3SSthRlRF?=
 =?utf-8?B?cHlaQWtxM0I5bHYxTGppbzU2aG82dlZSZE9FbDY3SHh1T3dQOWpNM1RVbUNV?=
 =?utf-8?B?TXZrT04vOGtsSVNpN284REJUZVRaajJHT3pWVGg3ZDNlRWtPZC9WVTcxa1pG?=
 =?utf-8?B?MUVTaER4aGV4dEpNLzdkQlF6Yk5KNE5qQjdGVUtkQnNTL3V4VWQ1eUF3a3Uw?=
 =?utf-8?B?a1crNHNPbU12YmZobFNZa2hOR1lIRDVYQVZMVzVCS3JHZklkdTByWFRFcE4r?=
 =?utf-8?B?TzU3ZUhEYUdpRGRXazlhK1ZoUU11b1VVZS8xSnkxYk5ZOTlhZ2c0Yld3cUhX?=
 =?utf-8?B?aUJaWWVtQlFHcGJwM2ZHbjUrRXhYck9HeDFDUm5DOVBZaE1qL0tRellqMTh1?=
 =?utf-8?B?c2k5WmFsR212MXkvSUtueUdaYTJyWUxHcXpvMG1Pb1IwWGRVOExLaWJJS3dy?=
 =?utf-8?B?MGQyT1NwYVRaaEQ5enZ3cDRBdnFmL2kvTDZUUkEyUXJuRzBjQnRaYVdOOW84?=
 =?utf-8?B?UXIvSEgvUnd1dFVYYzMxbWZDZkIyUHRyTHFqMlV4U01DZm16eW5VajV2WjVl?=
 =?utf-8?B?MEhYT2x0OWZ0MEtWOS9TV0J4K3ZOZWdvZmlYaW5jUysyZkRXYkF5cVNJMGRt?=
 =?utf-8?B?N1dINnhtc3pwTDV6anRvZE5YQ2xqRHllOTFWVWpHYjQ4R04yMkdnSW5nRmF1?=
 =?utf-8?B?Nm1Sa1lCZTZxWXdaMjNxTEtZR2Q1cEhrdHIyOW9jOVhxVnluUlZQdGVOaVQv?=
 =?utf-8?B?Q2ltSzEwNnRnSlNPQnk3TFNzdTlmc0NzVnZMSkRlTXRkQW1sekY4NVFUYjM5?=
 =?utf-8?B?Rksyd1R4YlZpc1V4RjhjakV6U1B6UVRLa1FZYjNrRzgrdTRkdGxsc29hcjl4?=
 =?utf-8?B?MUU2V2c3U3VlUHV0bVRudnN2d0huRGpDNDc3NnlJRUthUVNyVjgwZjJQWXhH?=
 =?utf-8?B?SWxqMjdDUExMc1g0WTV4bkV5djd4a1ZhZjRGcW5pOVdtUVdGNTRseFRVUVNU?=
 =?utf-8?B?UjgvUEhRWjMvcENWNXg1dlFiOXB2UnpIQUErSjdPcVl1OWFLdlV3ZTNQd0hl?=
 =?utf-8?B?N0pma0R0RlVXdks3UXVFY1BhY0RiN2dhdnQwdUJUZmRRcWZVNXdtczZyR2hP?=
 =?utf-8?B?cHBvZEJ1aEp1NVM3Y09nK1QxU0NMbXkzeFJkakhja1Y2L056aUJ2UEFhY1pN?=
 =?utf-8?B?R000ejRBWGtpanR1cGV4TmVTeTVqaGRwTW5JSTlGbU1CS0laUERyTGh4Rmk4?=
 =?utf-8?B?TUhVM3lJWU9yM1pBT1NjRUhNbEJUMGQ3M1FHN0VVME8vU0wzK0VwNEhxeDl4?=
 =?utf-8?B?Y3Z6di9FV3ZvdFJVa0NmRDB3d2ZNTGRpUHlaZ1hTeGZLWnVWaHdEUXl1K2Fw?=
 =?utf-8?B?ai9nMVkvWWhSeEk4M2lLLzJYaTRJeEY2ZGdONDIvTTBYTlYySUlnUFBkS3A2?=
 =?utf-8?B?NHFtYjI0eU1FK2Fod1lKUm9OaUdwaXR5T1paNmNkNi9QSlE5dkFSamZpOHVM?=
 =?utf-8?B?anZqWXYzUktRUkdDWVhWRHRvZk03bXl3S0tMaUxIVlNqLzE5U0dYbC9jUTVz?=
 =?utf-8?Q?VWaEM8i1tog=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmJDbng3eGZOUjdOSFBPTzl4c0FxRGdkbW9kVHlkTWdCU1VTM2NFU296RnVB?=
 =?utf-8?B?cWRtYmkvUFZDcVl2ZzdDSkUwUUNqYW44VWhuRDhnalhrQ2EwMmF5Z0RmWUg1?=
 =?utf-8?B?M3JwYTdGSTVQaHJhd0ZGZktGWTQvbVljVi94U1BTWEIybTRYM2FUdXUvU08v?=
 =?utf-8?B?M3FUTUNMZEt3QkRnRVlIUUJZV0ZWRVRmdlY1aWJLbXpWQVkzRnpRN3drR2RH?=
 =?utf-8?B?ZjRheUJjVzlSSUl6cEVzeklPcGU3cm1CRjR2OTB0dkNjai9qOVdYZWt3d2c0?=
 =?utf-8?B?N3pZNmtsakNqR25vQVpqK0ZpdjRLOWcrKzJnMU5EVGJZQlpnRnpFZ3ZLeFFE?=
 =?utf-8?B?R2ZWeGpoa2F3T3JkTWM1NjZrRzlrd0hNVUE5ZVJyQ3N0aHo0QXJvaFJCT1Ar?=
 =?utf-8?B?L2YvRFdjZ3hWREpaaWhKdE5MbjhESURWOS9wdmN3OTUvd2hKWU8ydFYzMHE1?=
 =?utf-8?B?NnYzYnhLbGVKajYyWDU1TkxoVFVnRExKNXVrS05DN0hFU1EvNDFFK2xCOElZ?=
 =?utf-8?B?RGMzZDB1cFFXcTRKUTJXR2ljUG1FeUgyTFFkdm55ZXJWSFBydHhCenlETWNT?=
 =?utf-8?B?a2JXNng5clFZelB4K1FKWUZxTWVNc2dNYXQ5S012a1VnNUhKUTBJN3Q1d0xk?=
 =?utf-8?B?Q1p6NEZaZ3VsRStScDFsbjI4ZUx0WHoyY3Y4UW4yQWt5SnJybkdueG5tclda?=
 =?utf-8?B?KzBQS2RFUWc0c0t5VlltVVJsd2c5Vk5lTktLNDl2WWoybkIzZ252UjUxVGdl?=
 =?utf-8?B?ODl6bmJ5WlRPZ3RXbGZ4eHcrWTRlU09la2xPL3ZFRjk0MXEwcS83UFZ4czgw?=
 =?utf-8?B?Znp3allLbnVoOE56amdzU1B3WE5qdFh0QzhSdkNkZVpMNkJ1emx4bms1M1BF?=
 =?utf-8?B?WmJwQ1N3N3RzL0VvVnR3bnh1NUVkaFQ4dnk0WmRjRjZueWpObEFXZ0NiUXNW?=
 =?utf-8?B?YkllVTBOWnJiSmx5SGlIMUVNRFo3ekJOcUQvY0R1OHhETVVTNHFYWVdEWnZT?=
 =?utf-8?B?WUk5N0gwNlhhUjlaTThDYXpaQ04wRTQvbzQ2MElQQnNlK2MycFpHbmxCZllS?=
 =?utf-8?B?N2Ztc3ZabzB2MEVsb1R0OThyRWUzTlNzWEU1b2c4NE5vbHhrNVJPalhUUyt0?=
 =?utf-8?B?R3NYcW5mU1hicDFWV05BY29lcE1HcUNENjhRNytvcE5jejZNZk04VisySHB3?=
 =?utf-8?B?bUlid0FTTnR2d040QmtTeUxKTklIMi92YXVZYXRybFRvUVM1WkM3NjRUd21L?=
 =?utf-8?B?ZlAvWkxtdVBOZnVFUzloczJYWFE4TVh6WHlIR1FFdHprajZzSThpM0F0MXZR?=
 =?utf-8?B?dXNSZmwvK1QzemdBRE1vTW43QU9pcUd3dW5ZMXVpcUpLMGZPV3VGY1lxdlFk?=
 =?utf-8?B?NC81Sy94RDJrdjZxK0FoL2QveCtCMm50dXJXdU5RVnRRMGRFVGxHdWQvdHJP?=
 =?utf-8?B?bmlGZEU4UmxrOFBjYjFKUUdaRktJUDdYSGI4ZFMrdCtTbTVyMzFwMUwzVGRv?=
 =?utf-8?B?VzEwOGNmU0xZNkVVMGpvZTZmRGM1VllpekR1ZkY5MWJVTnVwamVOem4yTjF4?=
 =?utf-8?B?bm1jY1REd294OUtoR3BjRnNMakdKMXNwdSt6b0RvT0RRV2RSQ3NMcE5pUC9a?=
 =?utf-8?B?NEsyUGlVRGhHNmpaNzg2ZTYrd3BHOUhpYXZQSVJlYTV5akhRMHVWdzVnQTJz?=
 =?utf-8?B?R2diby9rSGhNWDkwamhTOEptdWdZK245VGFIb2RKYTFmczVBeUtiaUF2MXEz?=
 =?utf-8?B?aFBBaERBV3NVMzU4TlVsWEhjUmpTL0FKYktXOWs4R3lzVStEOGViMGFMeUtZ?=
 =?utf-8?B?dDh2NTNuUlVud1RWTCtKZW16T25MK1ZQc0lSb29aeE1uYU9RYVB6bVl3QXFJ?=
 =?utf-8?B?YytZZ3ZETWJ0VUVMQ1N4SlFGbUxSZm9XempCZ1VnUUxBM2haMU4raHJSRmJp?=
 =?utf-8?B?WWNLTFdpbzg3OTlTWFZJd1JuTjhldDFCVEx0M2ZrUmIxYk5ZckV5MEUxWUc2?=
 =?utf-8?B?SS9UMCtHa1J4Mi9ieGFiMXZRQjZ2ZEp1RDV1cHdudVhBdisva1c0VlI1WkNS?=
 =?utf-8?B?TzNiVjdYV2R5VUJjYWlMS3VRa2NBQmZueWtlSWdMM0lMM1hxenJxYnNqMDZ3?=
 =?utf-8?B?VzZ5a0lnSkhEZytPc2lTT0pZZldNaU5IUUJ2MkVqZG9HMnBCTXE1ZTdkSGNU?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FqRL4f2Ax3nuV01YbBUN6Y+1Rbi2Kq2iPRrvXmMMIeAO6nzd31okDpogX3jdxfwk8uIkRPF3/HI8VyrMeWBKkcBUm9TzzXnSpyobtV/BLX2k5Vk0Zj2B+8Q7ix6vMxSHjvEWVZZ/JfGe3sTosv/xSoNBo6LOu5LQXf3+SS1c2fAeDqK3nNZ/K0UBPgjfK0tVVrgtZHRADsgOJajiLzZdJOKAYyHFBNWtB7WH3ueBXwUFcQmALwXnSt/pdSS7bPEE6gnw0SBPm7dD1vTj35KSpMIPkuVfNpTqOXS0IcPr6geKKPpWVcMw9MtNgWwwUGdtorKKQSVmatDk1SX/KBfbPNJsCQt/ga57TwZOrf3K3Ng3ReRLKEWvVKKFQ+19kdvnAjN1l5y+4c55LvQDxIA3Yo5eddgjw1lQGHB1BnLo5IjFEopPFz2UHWXKDlfQJ/9eT6oB4BDtXDk5X1Ql1kBu9jLXOAuGGUvCu4zYCmu/jq8TyLT8m460uARPX3KviFy1rc1cBMQfA9kqfFfbw60Lr+WGmubF+aGPcb0IKyiXTAe10FkdDGQDca/GbrfaC4zg5iPkx28B/xIKOvPKrMnb7hJ3+8Np2y7FK3cuWyTL5ts=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a8982c-ed76-4bd4-869e-08dd88bd337b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 14:33:55.1879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hy23bNyJBonIwkGVKu3ONREmw905DZ92SYQfgcu0gAyqcNiSCht41Lk8m7f9kmDjYMtEjEnl6yVVH2SIVNQBonepI10B0RhIdLNNTvf3l0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6139
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=982 adultscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505010110
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDExMCBTYWx0ZWRfX/8Sf4sXck00C Z5ya3XRuP5/3B5wefEZwSpRB9sAqY+wCCyhORLzs9gTc8lAN1jFO6CZxNBZCyprL6hVFkMojo08 g3cgbSNYbyArjQbEcDBt6CWP8ezlQU8Y4TwaAze72iiOPeIqN2u+j084gVTaS/b4pYlCM4QFkkn
 ObVYHBUeXOyF0q8CQSeAO9LdHK+qDrj/t2gEi/Xnwq6TpG8iBzwnOzbVdJftQwavsUDXGQQJoaY XH/u0Y1I5gBrqF6DxINeHWFKzlGbFB5mapAKuzdAc061lDWO3hLZe4bNojjDO2CKpKqIYWx+Suv hMI7oBmbWRaPgF1RiweNvRzqY0Yji3yaFKgSFnfuBqQ4KiTmGnlD1UFhSVeLsir0zLx0bwu6jUJ
 dlgfjMm9/YpFJyTzGLATDBAdsYMo7k218m7h9yMoD5KVe0aybUlfxCX34dJlDnYZxX5vPBEC
X-Proofpoint-GUID: Q6s2zoFEwPuPgL4LU9gCEDsMFlBvM-LU
X-Authority-Analysis: v=2.4 cv=A5VsP7WG c=1 sm=1 tr=0 ts=68138657 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=jkiq23WxKqrNFzc8Od8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Q6s2zoFEwPuPgL4LU9gCEDsMFlBvM-LU

On Thu, May 01, 2025 at 11:27:51AM +0100, Lorenzo Stoakes wrote:
> On Wed, Apr 30, 2025 at 11:29:46PM +0200, Jann Horn wrote:
> > On Wed, Apr 30, 2025 at 9:59 PM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > > A driver can specify either .mmap_proto(), .mmap() or both. This provides
> > > maximum flexibility.
> >
> > Just to check I understand the intent correctly: The idea here is that
> > .mmap_proto() is, at least for now, only for drivers who want to
> > trigger merging, right? If a driver doesn't need merging, the normal
> > .mmap() handler can still do all the things it was able to do before
> > (like changing the ->vm_file pointer through vma_set_file(), or
> > changing VMA flags in allowed ways)?
>
> No, the intent is that this form the basis of an entirely new set of callbacks
> to use _instead_ of .mmap().
>
> The vma_set_file() semantics would need to be changed actually, I will update
> logic to do this implicitly when the user sets vma_proto (or whatever this gets
> renamed to :P)->file - we can do this automagically.

Actually there is no need, as the file pointer we pass to the caller does
not have an incremented reference count (it is pinned by the .mmap() call),
we only increment it once it's in the VMA so this is unnecessary.

>
> However the first use is indeed to be able to remove this merge retry. I have
> gone through .mmap() callbacks and identified the only one that seems
> meaningfully to care, so it's a great first use.
>
> Two birds with one stone, and forming the foundatio for future work to prevent
> drivers from having carte blache to do whatever on .mmap() wrt vma's.

