Return-Path: <linux-fsdevel+bounces-69064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB951C6DC79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 10:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D956F4F2829
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 09:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EB233ADAD;
	Wed, 19 Nov 2025 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CXVq5w1E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wIB69hdt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFAD2E9ECE;
	Wed, 19 Nov 2025 09:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763544492; cv=fail; b=Wwk0YYKFkAM8sHjm9nl2LdkALOUcOZ2dNXaSpQDl5T8pW3ZaLBrO9A48xA/FLFk7E+olIt7F2eoFPzqtiqYQvudAbP4FOTUunA+PWjdIQs/r9Yl43afR+gYO1webYVey9wsrS91mTIrIpLMI4V0kgbtPnBMwjW6b9mRJNnNUdTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763544492; c=relaxed/simple;
	bh=w69krguzbLRGAWY6TEnZGGUKi7OyHykjn1hYtOD9gn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kV1f3x7diL/XRWKwAHHaPEyQ4kc/GxiDO1tHQOi4UjsIDIqDtPLgHHrrE0Pokchhh6GFYauV4iv7lO5KBxCBCGqPITPp0AFx3hfVaWeeNBoKElCoExNwG5MmqxjkdG3FQ0w1MnkemcqDkBTzcPuVRaMfv0zyq8htjuum8GZC8fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CXVq5w1E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wIB69hdt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ9BfHU023343;
	Wed, 19 Nov 2025 09:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=6kukpmasDk3AUXDDyO
	N4z/fw/kNgg4Z3KhzMh/RJYX4=; b=CXVq5w1EB2nDDCrir1wNkO47NYn2vyGQJq
	N7gyGqTR4Sz3Ixm6TV7qDQNKq7bWePuWdkKAyYPub8lk3MxOmrmJfLmsHmWttg6k
	BVMujKhxqa641NPX4EqM1rz0LvhTsyZ23z/EVLiXv4FAUY+8VQ1zaSaP+IvEA2bj
	89AbRFKZMW8TyMq/LlFNB498VAjPaK/tclHlRIwHtYrFsfTMRNNnc/ZT2+k7YUB0
	Ri4zqYsm5Uu/8Vlsz3QBr9cfFSBqxVYgPJL4KhUue9CDpxks3avMYtfGMlQQY26D
	tUjzVaQkWn1IOL1ULgTJQfZDZVlaolt7Rm5R/P6ZpqLbh33mdb5Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbupj5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 09:27:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJ8pIae036003;
	Wed, 19 Nov 2025 09:27:16 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012030.outbound.protection.outlook.com [52.101.48.30])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefymkqqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 09:27:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7cLwC0ADe8nGj4BhTcO3gAC/h2hYog9W4mgN79brBy1DnGbVmEebSGa5sOCyiDHLemnYHgoDWOV+NYbMfFpVP3Y33EMpkm/KidzbjvJCOfGFOztTBoByOn3ibYOS+WenAT/74TKaYpJK6rzQ5vT/FDHuXtMGYQyEEkM6PkaBBzjJxDqIDLJpq7xZWzeidPiD/nCvS9AZh8xsNhJc8bVSHgui/zsSE23EKa1SsmlkgD9YQtKWQVWRZHyJakbWe7KxxlW9mJYHWVcR1hkjmKT6BzaAjwtyWOjhI9Ae0EFXVpCIEyxfV3ROpNJfAF9urjKX/698jX09WlCL/4WxolRqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kukpmasDk3AUXDDyON4z/fw/kNgg4Z3KhzMh/RJYX4=;
 b=wGakVbmDgYKBrxgGRABqr9Ivmxti8qptOMYKD4EyDctfXAGf91ZEAHd4cIAzUpMRhZD84TNC4AetcFmqYthEtYqvnUyn7ey3R4+EqNlsymRlVnvX9lHWBXYdysEFIs3y3QDkOycesfOBsEthghXEsfe7edc4vxXHwkItpxJJmuhEGwPhthKk9dgkaJHN7a3/5sodAAF1if87Z+2E8VF1OlqCyxT3j8VOnA7VQc/N0A9xH8/4txzya1RmdPPFG7KmettDAdjO7TRVoBJNI4mr9RGScUKp3Af6wkGsD3cVuF9Vx+EKTv2MfREePQhejfBxxcG4CE3JnjLD2HiT96lsOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kukpmasDk3AUXDDyON4z/fw/kNgg4Z3KhzMh/RJYX4=;
 b=wIB69hdt1VHIc2gQcX4DaLmJAI2B2x4qM22hLaqUABFLrG3RkGZTdbXLzfG5xzE3JLnssDGvvWMJe3ydvptIahzXXXin1Pkw5eeH5nvvgmJxR1BjXXeL+1rkTuwwe4RHtJ8VqwPg5RmQEAVn/sHHJMwA5k5UmvW/RCvAqWkaRcg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4797.namprd10.prod.outlook.com (2603:10b6:a03:2d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 09:27:12 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 09:27:12 +0000
Date: Wed, 19 Nov 2025 09:27:10 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v4 6/9] mm: set the VM_MAYBE_GUARD flag on guard region
 install
Message-ID: <5ac97930-b5d1-4a9d-bd49-5a09c823a920@lucifer.local>
References: <cover.1763460113.git.lorenzo.stoakes@oracle.com>
 <e9e9ce95b6ac17497de7f60fc110c7dd9e489e8d.1763460113.git.lorenzo.stoakes@oracle.com>
 <61f7c6d2-a15e-4c6a-9704-0e3db65eed3c@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61f7c6d2-a15e-4c6a-9704-0e3db65eed3c@kernel.org>
X-ClientProxiedBy: LO3P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4797:EE_
X-MS-Office365-Filtering-Correlation-Id: 204df7d2-a1a0-4154-29d1-08de274dd243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XOr42OJqFs+7Ae1/dmtAxSG18Q9t5SHn/Ws/EArEr+vLG/Dr/TS8NhWg3zyz?=
 =?us-ascii?Q?685MY8TsC3Yd8URZGODrOLY/U4Ptct7Oe5WLnB3unznsW098jLsq21wl+G5P?=
 =?us-ascii?Q?FHDuF6Qo5Fz6R+kLMF/qkEzzf0Wa3h1yi/7SkBryZXrKDKueA9PIKTe7OO56?=
 =?us-ascii?Q?pHcgoGmOPzDBdxvSsEHn96cqDB2Cnllg9a+yxYWw5kzpfPaNwZvP0+R8ymqY?=
 =?us-ascii?Q?/Rwkl79x5GslNbXcSwezqAlnt/0MbpDJWmscVr22sLpw1piL+Kv5A5ArJU99?=
 =?us-ascii?Q?XnkM+njmJ/lMMtlLI5Cje1BZukE9nYEU/0K9cKVeLKil5UD8ufuCVwIMWD/Q?=
 =?us-ascii?Q?JbYkVCVt2U3MTMuBVcDH5ULfqyYDR5K5qkG3sYrKZnmgFZPNFB1DxCnvDhxW?=
 =?us-ascii?Q?Iorf1fuTiaGvzQR8+jnD6jLnUBYBgOxf8z4Zj5mUWPjFPj9gA3lZtclKfqwn?=
 =?us-ascii?Q?Vj36E6ZGwJKdPkFmxgLS7HzZF63lX/rCNqVxP8ceDp4NbHAEeaNKoESE78MA?=
 =?us-ascii?Q?q6tD3Q1FpfM/S3UxbH7107YbmTlBqFhUODyZZmp3NvCLcSdrDK2J5FKOd0hT?=
 =?us-ascii?Q?NanY5u89aW72OY2q/ue+o+DPJeVfCBZGi8qg6zcRkA+jGN2AKcEUwDI8B5cA?=
 =?us-ascii?Q?0ANhxfxDMj5Myy36UZDMFNkTeZvCrWs3P3TzkL1YIJe2UVB+ZiCNeF4+/f+J?=
 =?us-ascii?Q?RgH31NFU4kI1+VA58uz9aDCB4ljHqkVlY9HosaOGewcGt30zgm/b6hVpmX4S?=
 =?us-ascii?Q?ZT772U5oFzKKcMM/sB5Zs2WII8Xn0hwOEVAOxokc4QDq++TZwB9AgyrKftc9?=
 =?us-ascii?Q?9/2SwYQymDS/x/SQcU8fiPyonOgXW+ed/6SNe0nMKwgr72VhkDFcdC2DddB3?=
 =?us-ascii?Q?Xg6W+90D1x6DU8DLR+dyuSkFBdDdB1thUE8Wb/xKxLZeBZEmgOQJS8c9lLva?=
 =?us-ascii?Q?JFDSGZaaxTfr5EFBla/9rHWSUq9j5R4kw6hliYu6BCnW/sZScSbpH2kkq+J3?=
 =?us-ascii?Q?go4aCxLN9ii+RosgFXu31JP3wKMB8BkN+hla+aOf0aQZOjEzxX9ER3LVeRAE?=
 =?us-ascii?Q?lfyE6vZSuZzdd3MLQUJ7f8avmAKOk5qAhssSGAMQ9vw4c+zAcRu4mto184yF?=
 =?us-ascii?Q?A2qW3UUfYocFHGzXcpGhb5I6bV38n4vjMH6VE4wZB1b4yxKGx5QTpiPfiLl6?=
 =?us-ascii?Q?3uDJIUYf5aHUK5ULptYfgoijDFaDxJ2+vPagdMPGDehLZQcTnUjIlJWfj7Xa?=
 =?us-ascii?Q?7+ktIFQJWkTuGnurfJ2AJPol2mFgtD1WvaMvhEkgbnYRXn6qIAxcuHdP6zPI?=
 =?us-ascii?Q?KQWqSmcddr5+ZDIVRFpRKCGnPde9pMiAFFLTFK10FxVi80Mcmnlk8o5vEeXh?=
 =?us-ascii?Q?zhnRlSgPv5mrkn31jp4/slITyEMqL5WZfRDvP8xzwE3kzSs+9zxBgy9xc/t3?=
 =?us-ascii?Q?UdQM3J/wlUjvQriEoYaVmpIFyMqItFPH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zHUbY12VxmE7De434VN/+M8g45PCcxvDuJR0JF26vdgm155MqgWU6sxVtGOb?=
 =?us-ascii?Q?rEdiyTqnvqWAPMXCl/nmuWzYG3H6Rv8VbQucF/ww67MnUKd2lDRUZHtnCqEa?=
 =?us-ascii?Q?Y5uglRhTl3CLEzTwLpcGd859qAmiW+1iZjYIkKY7zUXUcIZDY3v+6+2NVI6M?=
 =?us-ascii?Q?TZdPG71JWkqgS0grkVsaZiw28Wq6d7KkoD9drt44TJDPnctqAcbsDRgK8x34?=
 =?us-ascii?Q?WVmF8UQR7RHRnlN1BPdHmW+MF0feTPV59dzbivtNbj6lHNsTWOmCX3UTnbQK?=
 =?us-ascii?Q?bNFcAvfNeodrAVPUGNbFBYrB1moDpljkTUGMyT+MDF9H6CKnawq8GPgSkVyR?=
 =?us-ascii?Q?GlhBSv1B4iXRpesAKEeF7/mwfPOcwIQ0ge/Onk8VjTxQ/pRbDdW5yJ+qEHe8?=
 =?us-ascii?Q?KGyofDw0TSdWMPm7aOY3wLJjWn5ewhBvxOev49fLE8LuxzECm3H59ZXpgaIk?=
 =?us-ascii?Q?8Qk8rDcTwuvLjgqIsqPyeOnsxM64Ahg9n2btmXywW2VnR8x/FIHs2WN01j8z?=
 =?us-ascii?Q?8cUDX95fuYEuXjzfZArkNa7YFWIB380i6V5zrPyGxmrECTsDIeo9h+VwAYYU?=
 =?us-ascii?Q?MzxW88UO4bAF0ydT9NIJ/ZDH4NIlxEa+0LuxDqm5G1ygXApSE+soKKV4Hjyj?=
 =?us-ascii?Q?6PMP8+590+7WhMSZz60822MKMykQeDHi6Gu+p360tI0UsnkumZ9GufavqRM3?=
 =?us-ascii?Q?J8osCCs0R2P6xPn2j6j9p9RT6dI4XR2ZgjgCaMxv2o1gB/yo8MEhrrT578HA?=
 =?us-ascii?Q?Fu36y69Yk06l9KvdcMqdBnPzGLUL3Awu8JIOjkjjUZrFdMm2rfTpeS6fgL4a?=
 =?us-ascii?Q?inWMbyKUSTdE3LKc+HFR0+vs8WVSbKikODiG+eLV0BCzwUyVdfSiIwS8bqM+?=
 =?us-ascii?Q?JJIDgkQNVgAEnlV+rx1AjL2eYjqi5m0VPd0g2qMxFYKN6pp+nfpHYt8xk2tD?=
 =?us-ascii?Q?LwK76I23bx+5Z6adYlIYwx9CEGoLjWbWwsGDTNGiC38QmDjXvKS4F+rydQYQ?=
 =?us-ascii?Q?T0KqbmdQ8lcpAbgSXgnAPS2U6+m8RQGPkKpi8du9Qs13k7IJ8prH7Fra1sJ6?=
 =?us-ascii?Q?8zyufxeyDOww5EvILD/d1LPsFzV6PuajL5CNruyAChBzXfSN13pYSfWLC0ib?=
 =?us-ascii?Q?zGGQROZHHEDP4Pu3x5knircjcdXxHnabU33DKRKxQz76JSGeLMi09yC1m+HP?=
 =?us-ascii?Q?3A95ESyWtPtWzQ50qGFhhwS9b77NMN42Uvvvm6bwsWNB3+BPCrQvBknA63ls?=
 =?us-ascii?Q?qZFo0yBFxuYOjTMOefpzQ4V203bbdf1QnUm/eU5O5o6dIof2kFbZ2pWo0kqK?=
 =?us-ascii?Q?mkyDQ1vr9NQ90lrH1QraL1d+N0szLDo1uoJnB3WewGHWDHWLW0jghEnFKzdM?=
 =?us-ascii?Q?oNZ89xv3Kaes0EIHioN5GveqYGMNX/WcE2vDh16eGhlO7LJCrAJJmrI1vreV?=
 =?us-ascii?Q?kENJs5le7gTwQc3XaImQfcZkrcGRs0R7vZUgwJ2ntsClLiQY+aLQKcMU197G?=
 =?us-ascii?Q?0iQ/f4woUUvdCvhLa40orNRGXHLDQM3/nkc0LO2R7qKxwzMnuCIDZeIaEx2/?=
 =?us-ascii?Q?RlV4bE7zIwoBQbfU5GATJ/FnSKWc3ZAvQCZ2MF2S4Z7OO1nfy7DLVXQgYSLU?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2DWidZyd2ppcmeO1UscweSLVxkhobwSUThOFVhVHGZH/lKNvpLMs9QPylGe9bq+4r2iaRqhabQxk7DhSfU/rbnZGfiW6SKrwzNRvuUtcmUih0+aDn3+Asqi8PlfwiSOGn8i0P/V8FhTGZcpEWT488myzgikTRjrVXOH3rAQ29XPF3C59vtg+2yr06Mf9GQ4VgFOJyvdWW+WRjL8kdhbdQ/DCfYh7m7JmJ7XR+1em9XngjWTb+9zvUplNv3p6HsjPyW8yxptj/OwhXSZeVg8ryxhmq2Mr3iNr+AXJxIJmkT2ksBMW/i/tI1EdCjUFevRXW3u6nITk+O/9uuI+tDUR3G/mz6YK0DESXFBFahj9e4NR9M7tM+OJOn95hyAJCjIQeV+bdKkyOaW2qRMEs87PoXVyNW1CfWMhZ6pIGn8oT2YAwgR4HRN18Dfnrp/zuTxNaCJdj62kYwdII8SXgurGl+3M+ps5DukgcpGgjSuXuOavBtPpdB13ePP6OIgjl4JCKLGbj68NyPeZG8Ghd/bjLl9PnjRSkB1Dei9qYcKQmajUod8Q4ncq6jlHj6CGUpcpwGNhiREnaXYXDx25GOFaR2Le6tQbmVbh3e9yI0KFyQk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 204df7d2-a1a0-4154-29d1-08de274dd243
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 09:27:12.8547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3SSq3aVhzyxAhgnH6b3wtbe0V9Cat6zl4Q5z92CyK7wNvnfMtI2c7fjT5B/33L2PTpdjZ1CTCjhvX4+n9xmeFH/VcCE3wEzUPj3D9lPcV2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511190073
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX83JhSpu1ySPq
 CTNxtC4rnVU8Ru2lw5zqXF3t3zxopMxJba3culqB1eGHTk8V/pjuzaN+3mDhaT0LLaLr//O2E7o
 5he5cW93pVzzfp8eNItMPkPjFzos09ulp+0L3MC5EO0fXiSmsfMw6SN4zitvNf8M9v4kwbNZFTY
 Gz58OgumC9WSP9tleMatUrczIdEclne43L1I7Ts/cCmPx0G56RHdoblu0eP8AC+sGJLpaA5GHJk
 2wLPSrPrWxu3jRul5liLtyGhnSq8Mcn4t/fM8PwUG267NUcQjwV/KEOceKE0Upzvv27p6qFaiqE
 GgS9zLAGvyEZm+1uQ8PdWw4SMo5t2X5MIMrryLvDifwM9femUgv6H3FZkhBr4LnmFKJoD4gbSjR
 LsLCoL+55ciU/GHSjiqGa1SFSnfh7dcmZu7ciLVfOxAgzlY/6Gw=
X-Proofpoint-GUID: cuagnNaQZ3orfosrM3uhB29lN7kFL-X9
X-Proofpoint-ORIG-GUID: cuagnNaQZ3orfosrM3uhB29lN7kFL-X9
X-Authority-Analysis: v=2.4 cv=Rdydyltv c=1 sm=1 tr=0 ts=691d8d76 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=23atTa7X5ZJbPZFC9g8A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12098

On Wed, Nov 19, 2025 at 10:16:14AM +0100, David Hildenbrand (Red Hat) wrote:
> > +/* Can we retract page tables for this file-backed VMA? */
> > +static bool file_backed_vma_is_retractable(struct vm_area_struct *vma)
>
> It's not really the VMA that is retractable :)
>
> Given that the function we are called this from is called
> "retract_page_tables" (and not file_backed_...) I guess I would just have
> called this
>
> "page_tables_are_retractable"
>
> "page_tables_support_retract"
>
> Or sth. along those lines.

Well it's specific to the VMA and it starts getting messy, this is the problem
with naming, you can_end_up_with_way_too_specific_names :)

Also you'd need to say file-baked for clarity really, and that's getting far too
long...

I think this is fine as-is given it's a static function, a user thinking 'what
does retractable mean?' can see right away in the comment immdiately above the
function name.

>
> > +{
> > +	/*
> > +	 * Check vma->anon_vma to exclude MAP_PRIVATE mappings that
> > +	 * got written to. These VMAs are likely not worth removing
> > +	 * page tables from, as PMD-mapping is likely to be split later.
> > +	 */
> > +	if (READ_ONCE(vma->anon_vma))
> > +		return false;
> > +
> > +	/*
> > +	 * When a vma is registered with uffd-wp, we cannot recycle
> > +	 * the page table because there may be pte markers installed.
> > +	 * Other vmas can still have the same file mapped hugely, but
> > +	 * skip this one: it will always be mapped in small page size
> > +	 * for uffd-wp registered ranges.
> > +	 */
> > +	if (userfaultfd_wp(vma))
> > +		return false;
> > +
> > +	/*
> > +	 * If the VMA contains guard regions then we can't collapse it.
> > +	 *
> > +	 * This is set atomically on guard marker installation under mmap/VMA
> > +	 * read lock, and here we may not hold any VMA or mmap lock at all.
> > +	 *
> > +	 * This is therefore serialised on the PTE page table lock, which is
> > +	 * obtained on guard region installation after the flag is set, so this
> > +	 * check being performed under this lock excludes races.
> > +	 */
> > +	if (vma_flag_test_atomic(vma, VM_MAYBE_GUARD_BIT))
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> >   static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
> >   {
> >   	struct vm_area_struct *vma;
> > @@ -1724,14 +1761,6 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
> >   		spinlock_t *ptl;
> >   		bool success = false;
> > -		/*
> > -		 * Check vma->anon_vma to exclude MAP_PRIVATE mappings that
> > -		 * got written to. These VMAs are likely not worth removing
> > -		 * page tables from, as PMD-mapping is likely to be split later.
> > -		 */
> > -		if (READ_ONCE(vma->anon_vma))
> > -			continue;
> > -
> >   		addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
> >   		if (addr & ~HPAGE_PMD_MASK ||
> >   		    vma->vm_end < addr + HPAGE_PMD_SIZE)
> > @@ -1743,14 +1772,8 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
> >   		if (hpage_collapse_test_exit(mm))
> >   			continue;
> > -		/*
> > -		 * When a vma is registered with uffd-wp, we cannot recycle
> > -		 * the page table because there may be pte markers installed.
> > -		 * Other vmas can still have the same file mapped hugely, but
> > -		 * skip this one: it will always be mapped in small page size
> > -		 * for uffd-wp registered ranges.
> > -		 */
> > -		if (userfaultfd_wp(vma))
> > +
> > +		if (!file_backed_vma_is_retractable(vma))
> >   			continue;
> >   		/* PTEs were notified when unmapped; but now for the PMD? */
> > @@ -1777,15 +1800,15 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
> >   			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
> >   		/*
> > -		 * Huge page lock is still held, so normally the page table
> > -		 * must remain empty; and we have already skipped anon_vma
> > -		 * and userfaultfd_wp() vmas.  But since the mmap_lock is not
> > -		 * held, it is still possible for a racing userfaultfd_ioctl()
> > -		 * to have inserted ptes or markers.  Now that we hold ptlock,
> > -		 * repeating the anon_vma check protects from one category,
> > -		 * and repeating the userfaultfd_wp() check from another.
> > +		 * Huge page lock is still held, so normally the page table must
> > +		 * remain empty; and we have already skipped anon_vma and
> > +		 * userfaultfd_wp() vmas.  But since the mmap_lock is not held,
> > +		 * it is still possible for a racing userfaultfd_ioctl() or
> > +		 * madvise() to have inserted ptes or markers.  Now that we hold
> > +		 * ptlock, repeating the retractable checks protects us from
> > +		 * races against the prior checks.
> >   		 */
> > -		if (likely(!vma->anon_vma && !userfaultfd_wp(vma))) {
> > +		if (likely(file_backed_vma_is_retractable(vma))) {
> >   			pgt_pmd = pmdp_collapse_flush(vma, addr, pmd);
> >   			pmdp_get_lockless_sync();
> >   			success = true;
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 0b3280752bfb..5dbe40be7c65 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -1141,15 +1141,21 @@ static long madvise_guard_install(struct madvise_behavior *madv_behavior)
> >   		return -EINVAL;
> >   	/*
> > -	 * If we install guard markers, then the range is no longer
> > -	 * empty from a page table perspective and therefore it's
> > -	 * appropriate to have an anon_vma.
> > -	 *
> > -	 * This ensures that on fork, we copy page tables correctly.
> > +	 * Set atomically under read lock. All pertinent readers will need to
> > +	 * acquire an mmap/VMA write lock to read it. All remaining readers may
> > +	 * or may not see the flag set, but we don't care.
> > +	 */
> > +	vma_flag_set_atomic(vma, VM_MAYBE_GUARD_BIT);
> > +
>
> In general LGTM.

Thanks

>
> > +	/*
> > +	 * If anonymous and we are establishing page tables the VMA ought to
> > +	 * have an anon_vma associated with it.
>
> Do you know why? I know that as soon as we have anon folios in there we need
> it, but is it still required for guard regions? Patch #5 should handle the
> for case I guess.
>
> Which other code depends on that?

There seems to be a general convention of people seeing 'vma->anon_vma' as
meaning it has page tables, and vice-versa, for anon VMAs.

Obviously we change fork behaviour for this now with the flag, and _perhaps_
it's not necessary, but I'd rather keep this consistent for now (this is what we
were doing before) and come back to it, rather than audit the code base for
assumptions.

I'd probably like to do a patch adding vma_has_page_tables() or something that
EXPLICITLY spells this out for cases that need it.

And it's not really overhead, as there'd not be much point in guard regions if
you didn't fault in the memory (running off the end of empty range doesn't
really make snese).

The key change here is that file-backed guard regions no longer do the horrible
thing of having your file-backed VMA act as if it were MAP_PRIVATE with its own
pointless anon_vma just to get correct fork behaviour... :)

>
> --
> Cheers
>
> David

Thanks, Lorenzo

