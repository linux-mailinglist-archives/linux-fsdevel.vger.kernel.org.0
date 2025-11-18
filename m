Return-Path: <linux-fsdevel+bounces-68928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DC6C68CDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 11:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2BAD4EF2F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 10:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78534347FCD;
	Tue, 18 Nov 2025 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R4Uh7Yl/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c5uuNNgd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8F8346786;
	Tue, 18 Nov 2025 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763461184; cv=fail; b=EKy15YAN+uDqSU0WLBKHD4OHfVTfu8+1OyvhfxfGX27haUE6Sd6G6yhFTMy9n9Qxh9BXNpiD6lk8fO8aeQLiY0db6q0fmnEhrq07sDEB+o2QvOmzdlRFqF0yKYUdAQE09MYfwN7PEObpu/a4/ZN6LWyS1Dv7dPQTMjW7h0uGHUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763461184; c=relaxed/simple;
	bh=s1BHxtfrXV+RS+aoBnX5A82jBkQKQbNb0mVdRCUB4BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MycrhM8gHNPaZjaGz7kX2bSpK+n+SEwzpZZJaVB6LMSRaZxVa+hNd7hf+/uagP2utL9cmgmUBJnsPnujnRagmXzgsTUZP12thv7qEgvXO/QMTyt1IRmcIP6HbEuO9LK4zs1Og4GRqlxlPPCzW/AbYPls1H+XArw1QYbTLyanCVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R4Uh7Yl/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c5uuNNgd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI9CaVB024833;
	Tue, 18 Nov 2025 10:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nrb0nke0MxNQdfATTGM4VlgHv5k6jO1hYqRufDydMVI=; b=
	R4Uh7Yl/qMBo3O04StjLCuBTl1pqO/l69iJWCaaMTgPTtX9XpRjGmQcnJb0aHsT7
	hVGmjv33U6nZISYcXUoH9tH9CgxnrFB/zdlTKy5Pv/HUxn9ZoR9pGdVOg9oiIbir
	lzp7EqKsxmBObZchFbmtGN+NJVFnzgE04Ay4ymUNpaAErMNHvXVI/uqJF2Hia3qL
	/hx5m+R5A6EFYDLSONNrD2xbBeOIn3HZ2gGftvlPOvdAL0/jjc60WVy39HCSGeDP
	p4/HNijZBYOq/7Cgw+PxgrW2D3d64a9w4dAdxAFGEeg1MYRryE4hnMRcD2z65nJ6
	7GwsAK9PTsHlDkdXP8cP0g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbpvjff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 10:18:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI8wjfm004268;
	Tue, 18 Nov 2025 10:18:38 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010048.outbound.protection.outlook.com [52.101.61.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefy8pp85-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 10:18:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLyv9qnvIXctA1330PbBF4TfwQ1BzlROucsZTF6YS1x/8ZTE5GidzVpDmvuhnehsK5D0bTb//w9PnyO3i+UHafmWV2qgjuG5h5uq+fmHZjH5MvIpvr+gHM1FonjNbmbSXj9ZCTuQho+ySWIe1JR1M36ZovUaIeKztvFJB5RGUxAhSCJkeYLi5sOh/Gnw13//Cr1wtWTXVc9heq2ufT0fDdhA7ynlktMQBX3cFS3FKh/TlezKNjsjC69uotCPUnkNGXRRnPbn45ejWW2iEA407PIpMCb3aWjpXN3919bWwIKJ2d7RRXuSnhdPDkChmg+XhBh0G/Agw4izP280o/WFJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrb0nke0MxNQdfATTGM4VlgHv5k6jO1hYqRufDydMVI=;
 b=qBoPp4GoPZHr0QFotjkhOk2lCyD1prKlyIiSkaDmWjGY9S2UNA1V9TwlCcb78kh9cpeVuiEDPPrpzDLScDUR1thTO+O9ugd+SvNsciHYanRH7Aj8xzRsKgrK11f12YfIiFhPsOEPpsmwL+Q/ckvSeVYosTrsPyqZa+Y0a7aLPwJaecGJoQ9FphpkUN2cAbjWWjCpEegq+/VQ9M3GZ7cStkY11gYRQOPeoHgu6nqNK/Kby7D8Wcgz7NNrkBug2SEwHGG/TuT8bAE3LdIymZaMhW1+k+UPZIPr7qMNWOZJUsCCk3PyAJWjdYTeNk3RRqkjfCSCjj9T1StnaLgUOBvq3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrb0nke0MxNQdfATTGM4VlgHv5k6jO1hYqRufDydMVI=;
 b=c5uuNNgdKFXjwT88vmJLBFvOrNxe+ok5tUdD6//C68ubqlFkO/wNjk7ib9bvFyGJWeySsb+u98d/DuNaY/Zvyt0+RBi/x2TjHi+Tk08vZ092YD9BTNkBBWwhVmplPS7nZX0pA0O8v/8Tjpt+FfO1HZdwbIbNTZv3Wz4WXptU/GQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA4PR10MB8756.namprd10.prod.outlook.com (2603:10b6:208:562::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 10:18:21 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 10:18:21 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
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
Subject: [PATCH v4 1/9] mm: introduce VM_MAYBE_GUARD and make visible in /proc/$pid/smaps
Date: Tue, 18 Nov 2025 10:17:43 +0000
Message-ID: <cf8ef821eba29b6c5b5e138fffe95d6dcabdedb9.1763460113.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1763460113.git.lorenzo.stoakes@oracle.com>
References: <cover.1763460113.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0213.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::11) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA4PR10MB8756:EE_
X-MS-Office365-Filtering-Correlation-Id: 385e1da5-4029-4954-9eb2-08de268bccd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5+0w+qOsO0OBMqAJValOs214S5+BkG8wrYOpSvM3fdlkOEODJyJ/PDagTpX+?=
 =?us-ascii?Q?bsRYvGetWgjptsGeg5vvE543X+YuW3v4f5g8soU1NBY+qf8zb4nrn1CFlQQm?=
 =?us-ascii?Q?RMgsPFpudfa14y96S2PseTxq0W6kNUy6LbIS+iOHosZtT8VeSdqOoFNU/I5W?=
 =?us-ascii?Q?+Ah+OnjQ2FpkcB+7KgkBXGu6s0ndX3tJDicQTbrKWm0ku98VnZ9ytHAkDq7Z?=
 =?us-ascii?Q?okPYA+6WQu/TxjczX57bszs4bfwrFxtLC1+KPA2WhqJlguot3OtAnHjIWXjf?=
 =?us-ascii?Q?KVIz9t2RlV0C/i/tdy+NyO8XavNGj6u5lRB8cX385BovOqtBdw9Uhbet1qK+?=
 =?us-ascii?Q?pjdQrUKtdxWwui826hO0GZXSUkHKcuBdDOU7uXdqWbFmxr4iFYdVt228eH1w?=
 =?us-ascii?Q?HxfHKT5FA0NEG856sH8qNEMSmajldUXejQO+gdUmTeSTuXyz4tXqMclwlro/?=
 =?us-ascii?Q?POGHgPaxszBlC/8zIg2kyCOBUFCt/PIKts4HIQGjDKftOAeLvjWokTH9j4Bv?=
 =?us-ascii?Q?QquXR0BOLdVlFSSqlGQk57ILi81pfOLnrtbydw7dLAlhOjbqqLege1BjQBhB?=
 =?us-ascii?Q?kZ/vlm71OCGN7hFaqmF5nq6Z+dagev41ujJ84+aATIeCcBNW4MM/yOk1/MWQ?=
 =?us-ascii?Q?noJxS2/P4ifda94LgwDUdFxinMwCPyi+SlAc+MxzHjd6H1xVeb8S1MK0lk23?=
 =?us-ascii?Q?0KdDzJrmUHee3Hbr1GCRohbwmeQvbG6vGDRDsgj//e2hocPYnkxKpWlTjQr0?=
 =?us-ascii?Q?xazrdS2MCKOLiPTjnHlAy1xPX6hnMSRJw1H+PITwF9FWoCyk4Bt67BEaN/Hz?=
 =?us-ascii?Q?4sOFkHqZaYSuQMRZPU886fGexDc78VKKfPLVOmziFpB5mqQR0KbMGhRr2D8s?=
 =?us-ascii?Q?ml+HKZhIsBV4imD0d7EqcenXrBeDoEnmESH0oZ4OtPPkaUekOWAMQqp+g0ks?=
 =?us-ascii?Q?gQ30OVAhj3LuI0cajMQ2dNkuuCUgLjYcJ1lrHLvj1y3levIIKJy3HXctgraO?=
 =?us-ascii?Q?C7wp231N+i47wV1s2mJ5WOy5NYpVlvAuLu/xwYIiXy9EKVCwZVh2DDnUqbG6?=
 =?us-ascii?Q?OCGODdIVHpd/RDsh9ur9Z6EnPXE7/Zlnd3OctSkSHeQAGoG6XSxEyPwhjIn4?=
 =?us-ascii?Q?awldufmW1JX6W23vwaeBUz81HBexxNPb4ugCUkueSDRNp/QBgTlFwktUr25V?=
 =?us-ascii?Q?yvZnbSGv9+GjWMcBulzfHQfKyec4JvBoH/LyV/pgTwi9X25C6D0iVm9TUN1c?=
 =?us-ascii?Q?WvBYjqtHXSqtKOLS8BHgfoo4PPNhphblorY0rMuwvXFElT2xYdX49S9JqKsM?=
 =?us-ascii?Q?q2XHJpcolmwr2i7EEK8vmD+1AJLbpOoG3wcMivReR8mdV1Dd3fBW0o/b38W2?=
 =?us-ascii?Q?SGJyisRoDu+sf7F6pwZB3xOtti+Q+hWimTj78YUdi23ky/JPwnQgwYG0yjvk?=
 =?us-ascii?Q?Qe2ZN8xNPkTnJW1TZc7mbjZFaK/oAVFJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DTR97mhH/e/s62pv83MQIJgq6X2FpbEw7E+mdqr+6pATQvAh42TVk2f6iNHF?=
 =?us-ascii?Q?3JRDyF0vQOe6wnRI0eCh5b3wLcL+6sBMdUpmG3xTrqs8zvSuoDcRMPbJbPuR?=
 =?us-ascii?Q?9hfZKUUl3H5VyM06BpSEzsx6COC/srqo+1YwQuCsVZTISoUX+0/R1lCQVjvA?=
 =?us-ascii?Q?JZ2lh+nU7YJBrd9TLeujcz2iiLKK4nd6uBygKYxgU/TzEbCNynOjeXBrwHCM?=
 =?us-ascii?Q?cmdui9JUhr7IVaDnufFnLAVS5hmTqOgNlfVdqyMAsXWz69ffgbgcbDF80EFO?=
 =?us-ascii?Q?20XvFBnTIRweiDt949QPibp5UfDKSsQqP1i13wBoKrt5NkdYxwIrL6xTWHoF?=
 =?us-ascii?Q?aBbo2KCNzh55JRYQGZ4o9pF6wsqThA+wKDMmmRl3GwMZQ8fFFUjRtEdHxkEb?=
 =?us-ascii?Q?UWkUM78mf9nedsl31xUtVoHeJPH9mNa6IZkreJJmnsDifLv8/0qFRwcnFJq3?=
 =?us-ascii?Q?djqZ94RCa5yNCXgmQ4LsDKSdXaonph2gGX9KGARDblswsVuD3wRZpAaWqanp?=
 =?us-ascii?Q?G8C7Gkwj970wMwKqj3waG0bGGqHRv6p51mAVXch+XqjoFG7tSlGOzvs4wWYu?=
 =?us-ascii?Q?vjUNWEcPyZy35XLXkIQs2RRdqXxivulqv57V8S5/LBhr7HnOUcP9dijiyKSv?=
 =?us-ascii?Q?ZS7tFafDPhpJEEzsO03bYIkHWwHUjrvk0MUNSLVYHKmsVeyfdDj3hh5MrXGh?=
 =?us-ascii?Q?obdRt74BjrH+3RbU3fwBXl/ihSrqna6Qtyx7KZqt6moqQkiRCTVakqcfhQLS?=
 =?us-ascii?Q?BnELCH8RPHQ7jprNRTDulV0B3M4n1/Rmt0zHssW5JCEs/otXuotCaRCPQkNZ?=
 =?us-ascii?Q?L+jDrtJAgGqzE5Yr1lelcjNF1ioWQdWq5lCVRmXM1t9Gih98B3TDEBJEJBI1?=
 =?us-ascii?Q?nXu8geXbK9tPGgxsjq+oaiGhn0Lab9/j2lUD6WkXaoLS5IeVFgnKuNRSiMHG?=
 =?us-ascii?Q?F20UxghgZaA9JCptjP33rIMypG9eCpJOX8uvnfdRjb043adZpnX5MbxA4qxl?=
 =?us-ascii?Q?kO5SjvTtd6QLJiNzMQOzVG+yHvJaEnLFtYtuHe9HOi26ZwhW8PXK0tUx5Im5?=
 =?us-ascii?Q?Tl632uRtsDHZox2EgpDGheJWHzmL8Xt0Kw34OHopzJtsacCknmE8ytEUDH7U?=
 =?us-ascii?Q?TBd7+uMZfYmf2GBBan0Oe9Pi9EN10YzxFJz7boUL3fV5ZYL8ESy0+q+H9ymH?=
 =?us-ascii?Q?uRGWIY2Xp0im0jNygCoc1C30fJcCGIkfr9c9YgnJGjvDuiEmv3134ox/00OT?=
 =?us-ascii?Q?IcFl678H9gvYOg7/+qfEI75Quq6OuQFv6KxRGl7eiDqkY5/YZrOGdBX6gcvp?=
 =?us-ascii?Q?RqGbXgM0Lq09uNlf01/5b97EWWqr2DEpwzKLxEjHab22VAG3+35++N/Mpvyn?=
 =?us-ascii?Q?SiYKjXoM0i0m6hHBqsEYmzoob9JmJRP8tlS5ry/r9XFK1ac7iv+14pHvMvxE?=
 =?us-ascii?Q?3eljvMnuqDq4Hh37shVb1iqnMfAkdoMzDDyjM+JZgp4I8fvuX9ov3gmnx/sL?=
 =?us-ascii?Q?gtIwIVpCrOsou9rnr+6UK+g9GUaUnavlvDxQX7BXW5xo2fkrBPLmOR5WB+Qg?=
 =?us-ascii?Q?6iVr8js2h2wXNMVnTfTO3fZaOvqpJjpHtSnIuTRj4jyPakjHuXaVVf0Y0R+q?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QMItehSM0dowlYvHMt9kXrGjTilp+9Zlqtb81Pm9CTJHvcqJo4LF1TQ2tlo4RhVK90EXbsguBst/ArAlWcBGnwm1mJBNlLRmNC2yG00v9WcwOJ4PGKgo51nY8vz+pknqbjPFUirFWlY4ChyY2GG3P/tQ2aeZj/FvYVbm2W1rLT0r5cc8ITDZcD9jNOZYIB0fMS1bC4H2PhDUEwIELTK7ejBNeHNYvPsgUq1Vc7u5Gg/d+jJ/RkNZmYZ2GdfheQCtp/3kzq1/OhOrhvotk57yCZNA2FuhBTdYk8aqLSHcLg5GQ7dfB4GlfSoOJitIT9kdY+kA7fiz/FrrzIMKPYPDWYxmhXtkVxknm+MDrRHGv8uxm8Dk1uRxhkIu/einp1j32ml9EucJdkmRvlE5m4yU2yjH2RnkCLqZShAzJaXQCn2BYjsYVT9EJWzw73EbmtOjcGHPqroDkrnyBfKZJkYjKKn8qcY2KcbZ7zuBTgdWc7PUH2X2tlfYV4X8q0hF8mV2Jajq/ROha9LmrGZC5liRgolPv9Q7yV+R3jNA+27H3X+9RqhGcYylJSGbK/qYptm4btO/EZ1eD34CYW5b7UynXtK9U5sBXViEaBRkWluQKI0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 385e1da5-4029-4954-9eb2-08de268bccd6
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 10:18:21.6814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1trfjcDBIjcv0Z3vxEAAKpUy65BXLOz7HEPre9JgITuWPXMByAbh2WbnxXbOSewMD3DA2bD1rVRlDqM3RRehD7egEtDBrKUAqNCVwI3u9nk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511180082
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX7+bKCI51wses
 6M6xyVjCAj8XgdfnvvtUaWbCsf9ekEwN6Z8ivjV+xC3VOgqFb92x436wBWY7QGr4taxAiQQYwIk
 8uHCFWVyivP/5DPG4opnne2GSNlO6xyfq18g4cksW/DdjQFA6dyuFj7ROX/Vi1ESMdfo59w00RJ
 fBkPziu5ARrVwL0nUtXZdpaOGehvMCp3de1CHd4IhRCKHtvoenbIMZ1uk30LvE8z2PfbXxqyQ1n
 ywnpeHLK/ZvfFQ4Igd4muEr7FU4GizqhnNhFK3hrrzZAMOCBjpWi1DSEepE3JzO4qISxhTqI9HQ
 k4dnRPX+cuTBg6TUPq2lUNAPDtSFXRI4+8/5ze03BivCQ4nRMcyquBUrn9gt0pwDFD72fA1hx+q
 jSdv/iuTgLkO0QJB97T84szhkEgDBQ==
X-Proofpoint-ORIG-GUID: peSyNjazSxQuivqXDVtoCRB6D3bF_ZYH
X-Proofpoint-GUID: peSyNjazSxQuivqXDVtoCRB6D3bF_ZYH
X-Authority-Analysis: v=2.4 cv=a+o9NESF c=1 sm=1 tr=0 ts=691c47ff cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=lkmYoepbxJn_IgOSQAYA:9 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22

Currently, if a user needs to determine if guard regions are present in a
range, they have to scan all VMAs (or have knowledge of which ones might
have guard regions).

Since commit 8e2f2aeb8b48 ("fs/proc/task_mmu: add guard region bit to
pagemap") and the related commit a516403787e0 ("fs/proc: extend the
PAGEMAP_SCAN ioctl to report guard regions"), users can use either
/proc/$pid/pagemap or the PAGEMAP_SCAN functionality to perform this
operation at a virtual address level.

This is not ideal, and it gives no visibility at a /proc/$pid/smaps level
that guard regions exist in ranges.

This patch remedies the situation by establishing a new VMA flag,
VM_MAYBE_GUARD, to indicate that a VMA may contain guard regions (it is
uncertain because we cannot reasonably determine whether a
MADV_GUARD_REMOVE call has removed all of the guard regions in a VMA, and
additionally VMAs may change across merge/split).

We utilise 0x800 for this flag which makes it available to 32-bit
architectures also, a flag that was previously used by VM_DENYWRITE, which
was removed in commit 8d0920bde5eb ("mm: remove VM_DENYWRITE") and hasn't
bee reused yet.

We also update the smaps logic and documentation to identify these VMAs.

Another major use of this functionality is that we can use it to identify
that we ought to copy page tables on fork.

We do not actually implement usage of this flag in mm/madvise.c yet as we
need to allow some VMA flags to be applied atomically under mmap/VMA read
lock in order to avoid the need to acquire a write lock for this purpose.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
 Documentation/filesystems/proc.rst | 5 +++--
 fs/proc/task_mmu.c                 | 1 +
 include/linux/mm.h                 | 3 +++
 include/trace/events/mmflags.h     | 1 +
 mm/memory.c                        | 4 ++++
 tools/testing/vma/vma_internal.h   | 1 +
 6 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 0b86a8022fa1..8256e857e2d7 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -553,7 +553,7 @@ otherwise.
 kernel flags associated with the particular virtual memory area in two letter
 encoded manner. The codes are the following:
 
-    ==    =======================================
+    ==    =============================================================
     rd    readable
     wr    writeable
     ex    executable
@@ -591,7 +591,8 @@ encoded manner. The codes are the following:
     sl    sealed
     lf    lock on fault pages
     dp    always lazily freeable mapping
-    ==    =======================================
+    gu    maybe contains guard regions (if not set, definitely doesn't)
+    ==    =============================================================
 
 Note that there is no guarantee that every flag and associated mnemonic will
 be present in all further kernel releases. Things get changed, the flags may
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index fc35a0543f01..db16ed91c269 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1146,6 +1146,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_MAYSHARE)]	= "ms",
 		[ilog2(VM_GROWSDOWN)]	= "gd",
 		[ilog2(VM_PFNMAP)]	= "pf",
+		[ilog2(VM_MAYBE_GUARD)]	= "gu",
 		[ilog2(VM_LOCKED)]	= "lo",
 		[ilog2(VM_IO)]		= "io",
 		[ilog2(VM_SEQ_READ)]	= "sr",
diff --git a/include/linux/mm.h b/include/linux/mm.h
index df9f258a017c..36b9418c00fc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -271,6 +271,8 @@ extern struct rw_semaphore nommu_region_sem;
 extern unsigned int kobjsize(const void *objp);
 #endif
 
+#define VM_MAYBE_GUARD_BIT 11
+
 /*
  * vm_flags in vm_area_struct, see mm_types.h.
  * When changing, update also include/trace/events/mmflags.h
@@ -296,6 +298,7 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_UFFD_MISSING	0
 #endif /* CONFIG_MMU */
 #define VM_PFNMAP	0x00000400	/* Page-ranges managed without "struct page", just pure PFN */
+#define VM_MAYBE_GUARD	BIT(VM_MAYBE_GUARD_BIT)	/* The VMA maybe contains guard regions. */
 #define VM_UFFD_WP	0x00001000	/* wrprotect pages tracking */
 
 #define VM_LOCKED	0x00002000
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index aa441f593e9a..a6e5a44c9b42 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -213,6 +213,7 @@ IF_HAVE_PG_ARCH_3(arch_3)
 	{VM_UFFD_MISSING,		"uffd_missing"	},		\
 IF_HAVE_UFFD_MINOR(VM_UFFD_MINOR,	"uffd_minor"	)		\
 	{VM_PFNMAP,			"pfnmap"	},		\
+	{VM_MAYBE_GUARD,		"maybe_guard"	},		\
 	{VM_UFFD_WP,			"uffd_wp"	},		\
 	{VM_LOCKED,			"locked"	},		\
 	{VM_IO,				"io"		},		\
diff --git a/mm/memory.c b/mm/memory.c
index 1a1626bba55a..a520720702f0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1478,6 +1478,10 @@ vma_needs_copy(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
 	if (src_vma->anon_vma)
 		return true;
 
+	/* Guard regions have modified page tables that require copying. */
+	if (src_vma->vm_flags & VM_MAYBE_GUARD)
+		return true;
+
 	/*
 	 * Don't copy ptes where a page fault will fill them correctly.  Fork
 	 * becomes much lighter when there are big shared or private readonly
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index c68d382dac81..46acb4df45de 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -56,6 +56,7 @@ extern unsigned long dac_mmap_min_addr;
 #define VM_MAYEXEC	0x00000040
 #define VM_GROWSDOWN	0x00000100
 #define VM_PFNMAP	0x00000400
+#define VM_MAYBE_GUARD	0x00000800
 #define VM_LOCKED	0x00002000
 #define VM_IO           0x00004000
 #define VM_SEQ_READ	0x00008000	/* App will access data sequentially */
-- 
2.51.2


