Return-Path: <linux-fsdevel+bounces-59877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C13B3E7ED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 16:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FA3B16E637
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 14:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E631C2EDD76;
	Mon,  1 Sep 2025 14:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H225W1Uq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rgXNI/38"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE0D13B5AE
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756738320; cv=fail; b=IBDD+xSjCVEiZvMEykIy6e8gQLMPoA2etZTwIxM9bcLeeBvZRptSWL18bu0M2zbl7nkOLW13QjZWwruLCiF+xldL6eZkk2TGnOE2cKnxxV4YYDi9atgRqShT7IAzdRLExGYzTNk+5Vx7B6SnWmgR7UhXht7/CZqKjwKgD0SjNNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756738320; c=relaxed/simple;
	bh=NosAtzZfvZgfrADWoBZVXNryd7OWjyGGozzya1eQofc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aAil/wwb/H7Iol1/UmTYOnqejItNnTNRi5QsgiYZ7UKFqTiehCe0RIN9kQSoKFonzuWo73f0G1fEQF6zDyJy80X9fUPtJsrgcIIEgLl7Mmhp7w5quP+q8xeRdA0niWH+5nD4RN4F1AlEsHtS0X6dJp5s0WM95QFyB2GmT16skDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H225W1Uq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rgXNI/38; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5815gcVq016660;
	Mon, 1 Sep 2025 14:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=9BVQ4pmtYPtnZXvIGf
	iRUo6YPHXlj6zkR76Uqx8/8XU=; b=H225W1Uq6s12DSh+nVISN+VDqRBxraPyXx
	H6qA7TtXvpJ8qem6qDVVUv8GpkQfaLMsansribTO0/Hp1wR2yA7RI2fwxf18ARGy
	TmgDQBfJa70cKrq6O0Yp+F+TB73SaTuBXHtWhkN5rxGymvwLlii0XrocEob7N2DR
	FxdMGbt9Iq4l5t13AVW1CWDfzlSTmdCv8Mf+wBoS6o091Jr2jXXZbJLwFn4jDDd7
	WYw7tbcLEFvH+XzNOvxzx5A7JESkagdL+pTzW+i3H3v+X5R/tAJy9/nfu8LK8aJb
	VGSvRomn2phN0C2GbRywdR+HDWTTMCEr05dQIa6BkxTPu0pIlyDg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ushvtkc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 14:51:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 581Dt3TO011651;
	Mon, 1 Sep 2025 14:51:53 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqre8261-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 14:51:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpMtfVbp48qfJyoLIYzsw8W2E1C+sKADlkl5SQ1uczm9nRCC7VmvfDPvZBVbZqKwFAyYYn8P3+pGYDM+YrQMKFohQ5gsmVabNLHXZqV+G4pB3tw0WCDtel2P/i8LWxAUoiOxEfTdYeCvMASnvGGytPChssZIEFcoo3/8acJyRESXiXEggDEIZ21taVO8Akn/xEnTVy7YhG7Gbvwsoq188ChBWn87fvagTfEtvuW/62t36/OyZQHD/tBbyH54p/drSOMg4s9FCDe5HwECzTVeUxPhJpCMUadXNjBPj2eYxYASxB6shC4QaXc9V04vAOBm/OzvaEVXWkBp5fk3LYx/bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BVQ4pmtYPtnZXvIGfiRUo6YPHXlj6zkR76Uqx8/8XU=;
 b=a/tFTvTBnz+0sDFPNgu7prAvYsNh6ar9aoU7Px8szCRvLisrqEtNz4j4MvVk9e6w+gh+6OTISCVA4XElRxpXs7D4iACoBVm92mnNl1YixppxKzQ0chstSuEb3Ld7K5VwvLnvK0NGk+PSAgaKfnEbMLdyHKW50Hh3JBF6yvVHl0pWVXCnPPohhnDMfXlNRMz1MWDrAJ0YGA3Oe959MpLSxee+7QcqdNR23tTGyl7pi6L9U9dUEWDyu/fN8afyM/KIQiFDYh54hYjV4vnhswRpj2oR9HpFQe50kRizzvnXfTnTyQg9jP8ms1j37j0iWBo1r0d54lOcca+aK6KeTOXGRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BVQ4pmtYPtnZXvIGfiRUo6YPHXlj6zkR76Uqx8/8XU=;
 b=rgXNI/387nDHLUPr9s+1MnEFIsM4aoSZlFGy+rVt1izAtUqK9S07KRt5b4FD3BMd058r64gezhsnVkQ98U7TZ72HnpS7A6PUFCE42x8ZAp1dpQ95YlFtM6mCW+NpQRxFFjj5hHHwrk6l7INRodQxs0fP09i+MIrd8u561YSC0EI=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by SJ0PR10MB5584.namprd10.prod.outlook.com (2603:10b6:a03:3d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 14:51:50 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 14:51:50 +0000
Date: Mon, 1 Sep 2025 15:51:46 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com,
        yuanchu@google.com, willy@infradead.org, hughd@google.com,
        mhocko@suse.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, vishal.moola@gmail.com, linux@armlinux.org.uk,
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
        agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, davem@davemloft.net, andreas@gaisler.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        weixugc@google.com, baolin.wang@linux.alibaba.com, rientjes@google.com,
        shakeel.butt@linux.dev, thuth@redhat.com, broonie@kernel.org,
        osalvador@suse.de, jfalempe@redhat.com, mpe@ellerman.id.au,
        nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 12/12] mm: constify highmem related functions for
 improved const-correctness
Message-ID: <a6cd422d-7c44-4a4a-bb27-ca0e2a93aa68@lucifer.local>
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-13-max.kellermann@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901123028.3383461-13-max.kellermann@ionos.com>
X-ClientProxiedBy: GV3PEPF00007A7E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::609) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|SJ0PR10MB5584:EE_
X-MS-Office365-Filtering-Correlation-Id: 52f8deb1-ed73-4b1c-2bb7-08dde9671504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mA7IWwTT8UaYxUCeqk57Zkuy8ttnlRxOnSTMqTfda7UibyAm8LGv/A6RdHk/?=
 =?us-ascii?Q?f4WvGwoqgeKktg/HpLEeVfQQTtyzCgiLCPfCI1q7FXCm1QOp3KcTYZT+825X?=
 =?us-ascii?Q?vv7GV9PvFiTMkHhqnuA5mNn8mBj6h0gxUf/sPGap9Z0D98+hIm8fbNRl0eSp?=
 =?us-ascii?Q?C/uWVIDcv28w/fkdO6dQ9IJnsP40yqWkoAjtVsbFpt79o9/1TQbJrk+QgqnZ?=
 =?us-ascii?Q?SAp2X31IRk6NrHVwKfju91++3+J7HPCEjxwBkJA2zxsZ9eKc9ae88A+heTCi?=
 =?us-ascii?Q?/4kV/O2Z191Dw5FUTfbvhlJfzrqVW7SzS/xsIdNSDN6wZJOSMgLsbcre8N/Z?=
 =?us-ascii?Q?Y7RPSN7oHeo9oKbR7pRYFVgHpZK+ZOQ0zGiEVQNNQsZKMtvIIJiEeEklq489?=
 =?us-ascii?Q?Eu9Jjqt3lLp320KRSdzazjRP+yBVwOq50DWiMqls0XuBwEAK4MRQbTxOZzyg?=
 =?us-ascii?Q?dItdym3+5j/oh6zazafaXhihc1f8bsJzUNo6oOccbkVHzCY0EpdeTBNZHB2B?=
 =?us-ascii?Q?pR79oj/AAsEOLQIdD68/gdnrFF4lis0x4LZN+kd+GO79dh6+Nrydv6NB0oae?=
 =?us-ascii?Q?2gjCs+eBaSnO5E2HO0wLM8FGebjHm/lxUJZ+e9BqybMtY+X50MfdX78Ns1cb?=
 =?us-ascii?Q?vJX1YSjTiejjOvgDWUIf/EAxZKyFqTml9AW10osjowDwc9OEVl98ThxR4wxR?=
 =?us-ascii?Q?8dcYdK8fsL0w0EufFUyY1Qjm4fJEv+uaSYUbBHEQrlNkrmyUdkWt+S+qEm8R?=
 =?us-ascii?Q?8lSfVYOxd8BgpiROtZENuSVi2L+VeZOlCU6/ewCCwVOpKTifYbOlJCg+YtAF?=
 =?us-ascii?Q?tsicj/9Ni6p7o3WvhGO2eSvCKThDe+ccX5Zrfq4sfVCwux6S5TwOlzFSRXk2?=
 =?us-ascii?Q?DT8VtYtu7DmAemErJi1aOlgwfTzu59A5HF0KnwLJ0VEIy2mvQ1v+MgUvdnBS?=
 =?us-ascii?Q?AG0GiXh13ucIg21zlcwbtQEKoqN9muickgwjpNIGmEsslk3e8/nNapH9z9+d?=
 =?us-ascii?Q?a3r/Q7FIUwWqrgybdt2QlDJxIm/z4MlnXOtXWidw9moKWzfN7WEj9B0BOgpB?=
 =?us-ascii?Q?Kx1Zta76GSmOW96e4WGC3YX414GSziuiYwifsNjNmfdEox8OIkicLIrjrJkw?=
 =?us-ascii?Q?Pn7RkCAK7MIg17q2qr45x7uszWlbz1XdncGhkTfw+xekd2dFFeYAC9z7q05Z?=
 =?us-ascii?Q?gRu25zaDK1Dmy+aQD2io1AcpfBTGr4YRPqvVRxJZ7abhILy9M5Cf0d487nGH?=
 =?us-ascii?Q?cgfbddUujtOkvpjAw02fL7r0Pwc1v61ChTV5sywd/tiRHTjo10wQegCIKm7Y?=
 =?us-ascii?Q?4SOB80SFZX+B9cbGdJCrLpudGEMYmAPAUPc0zY/BwlHjmQ22gV2TWH6+Tf+R?=
 =?us-ascii?Q?Yi8CzWj4Kl+SMhYeyVZQ9nFdWo40kNNA6brj/Nl3KLZc9vViAguQZpyL5zrl?=
 =?us-ascii?Q?X6EuoxjlaUk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?50T7Kll14XPIvU41C72Qm31Vf/Cby40urXBH0GKNKafJcG7/b9Cn+avSO+HD?=
 =?us-ascii?Q?B+56cfQs9dO4iPCPp7hEzDTrOzdH7xynfRYZ3opeRhzCunHjts55n40bbWrk?=
 =?us-ascii?Q?+Ivsufk0RVp0WYSghxS9gA2Ire6Ggqx/suivEi1fz74PAFzLQKvfch/Pyk+6?=
 =?us-ascii?Q?hMLxMQFkXVaeHJDXOYwtcWS12XJWJJ1kfpHiULkAd6mvEKX5WnncvBNpKjlG?=
 =?us-ascii?Q?0I2zsR9/8LahioFBANGKd/Xejkrf+m4go0bcVVwEemm0tEyNePKuWz3qpNG8?=
 =?us-ascii?Q?gWJcTBmy0f4QxmHj8bQLI1wOObrUbnelLfSZ3gc04T30J5Xw7M6UdTT/24Mp?=
 =?us-ascii?Q?GmWm9dlzhqg09hWtyIilImHfSBZkPu6ZT2JNoqicIZdeqT6Rl+nRAV7dSdZu?=
 =?us-ascii?Q?n0avmT9IdcRoXpYfBbDKIUxcr4Kkeo4VGoi6ZUM6j39143oUsRWy/rPuWRwb?=
 =?us-ascii?Q?JdVAKQEZW56tdK+sLk7O5FRWs7ilGkGiw7Ulz23L6RBaC9l0ECEo6b9Gvmgm?=
 =?us-ascii?Q?/6pddtWtt96ikx79Vhy6rwFqe6aklJ9OlAenjByrpQXbNGKu+98bL/nmmkUT?=
 =?us-ascii?Q?61jU3Tx4i9l4J2Gsn2IEQMbDVY+GsPuKOTigYCIuqyoXc11yMlsVeowl2fdJ?=
 =?us-ascii?Q?Ocqdna/0s/r3P64hfELrXNflWFlN0XDiyn1xgfPtj7FhpBKiIkdqjnS0WHFn?=
 =?us-ascii?Q?m/Pvmcbq9BjNdj1sjm21vAX14wQBcLV8QMfdTFmy+Y5KWd6THEOxmcMQERJz?=
 =?us-ascii?Q?OuvScFBhf2DtIm8odBQfSLkZCdqFYlMBX3Qth492r9iKlQ4SCQVijtNMP0G2?=
 =?us-ascii?Q?5Zo84HkV7q/d6D/3W4GrTK0X3HI5UJ0VIM7l04SjFrkt7Exlly9UP8Q4LOQf?=
 =?us-ascii?Q?Xl/t+USgj855KhIo2YkIcJ/cqWbHFXlDLPehNHdQcdaFtEh56aLf1mK6Tuk7?=
 =?us-ascii?Q?n2hkYV5TVPOoJHwB6nM1M04pGmAFSZtBXjABL36rmWF1Az40RqYgd3O9Nji1?=
 =?us-ascii?Q?ogIzwygtwlYmXoe4KKfcRxUzqENChkbxiDKPr+zQeBgK5kb1qckrJlKFd1SW?=
 =?us-ascii?Q?tAfsqHMFkEeBghnEuAjp9KjbOLf2VLSzX7QsOoOwwt6w9seLKNoj7Do6ykrp?=
 =?us-ascii?Q?t0C8Ahl0m5/g4aUN722xzAfvf6FiD6MtmdOSnsCgebwoFOABhiNQGtQibRt9?=
 =?us-ascii?Q?LRjih4UKqoA/MqC1yo6rTgMwHRdBLgmicLX78mXyrg1nc20FwpU/2FE861os?=
 =?us-ascii?Q?Eo6BY6bwCXxmVHHZhMVWRLfsCDklKPNfdo0/alLH1jeTz9R9Nwfk/7quZBtb?=
 =?us-ascii?Q?Wz3eEOZDSqHxx+JiCeuBIqDXtdsBCUukqwBi6YlqNEISOqS9FuWvTO0IbFt+?=
 =?us-ascii?Q?oOlJORON0cUYuUTk8G66/0+IbbUEfIrEQD9BNBKLxbYjYVRPPNpSeFVB3M3F?=
 =?us-ascii?Q?SxNZtF9O3N18Fdx0sEYxqbjZQ6C8mGB5Ozi6RrVTRUYoPCN8Tv4OO/p52Z8V?=
 =?us-ascii?Q?nHnRrUlXjaPBPTF+fQYLYWYKzllKvdU6Dar9odVT7wr+lUF03yQN9FR71M3t?=
 =?us-ascii?Q?HaOTNdjlP1aA+eGiTzI3ugVBdgirR66NGdZkbvnpZe5RFNFEYszrvmaO7mZm?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O2AjTFhnP9hZsXSzPol7BNyYdEAYyZLn/5/4yw2aBs+sVD4jJJyYJrgw8SAGtlRRKA+zJux1BcfCrhADjG3EkyAiAagFhWbExhjZCaVJmlMWDaehBPW1suzRv71WN46sH5AXjcXMqz3aTWr3QC/JwuVRlkLPpkTK8BhjvBMzb1AmxVR4x8Rv6I4viS8ZcYjJqrdIrbn/xmTBZ+BSRnpQFXe8KI2Fr4PAafLbmxKwz8RJfCBMIU7uN31hQisKPGJ6X6BQuvN/zfLkZyhiy2uHesClPqDLTUR+CFpikq+y/aA81MQYIO4xobPwNFLbiTATywPOhxwFKpEIMBvm7binnsf/YPlG3Uxr3uqWzZhfmP5gTnmKLDCsczVvGxGE3L28qqy41UD+SxDqDHPV+fghucMIgVwflFTXCJGqZ2yVD+SwWw2/RhFZrrFVZX0x/oeFR+7P1Jah1i2smUt1uFHl1VkhQcLnHiapZGyYHEJi5EoYRmDB8fR/Q5p+OXWTkncbCmffcKVB0idQmlKIkNWcacKvb7RgSCnxK7VwSHEL+2rynwgupUkAHhhthFfOrOUoizGFcoNvbQ6qRLTAYbVW7Bx8ForiT0YVI1IT9JkndgM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f8deb1-ed73-4b1c-2bb7-08dde9671504
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 14:51:50.6358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHZkMkvgUxFG/Z3fvLC3alm8TRrJ+CcYExpqly21W7AyT7poCbTw/9lVFTekmoEenSKF1qZyfOu3xvwP1Y7mw+tBM5+7PsbGl7gRMgQGikY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5584
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509010157
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX1ZMRjSl4PbpO
 OPQy4FV9vCAFUJBdKbn0BDn8hPsLfVNpl39GViiKsrQ7GlooEDS8lbhyUe7SgORylY7UsdDRoDt
 ouXnx+HywGGA35NzTqypfym56ps4YJOnixxfWxFJMeVZCP/gaGaKQba3im7UVH9PrQBLd+E2Obl
 ERXZnsCeetXcltXabznSVXrkTGrfoXBR0hmFpRkaXUoM6J0j7V1sS9AUyAX4aKbAVqTz2Ain+xk
 YzvKf2zmvA8qQEwguBwsE6XctJmM6yZfAw7S5+BiRnuncmmpf14Mhnrm000UtOqr6hY1jKv5Ahz
 FqRyfPQF1lg+Y4c66eTQuH/hUbnBAUAlcWhnXJbBeRBeceqi91zKJDZ27GQMQlEorNxSpF1P6aM
 /8yuKv1JJIuHftpOtPiNzJdxZRyUgg==
X-Authority-Analysis: v=2.4 cv=fZaty1QF c=1 sm=1 tr=0 ts=68b5b30a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=UgJECxHJAAAA:8 a=bY8S992UxOBSR411kFcA:9
 a=CjuIK1q_8ugA:10 a=-El7cUbtino8hM1DCn8D:22 cc=ntf awl=host:12068
X-Proofpoint-ORIG-GUID: coah1VaKyiHp6F1B0tCWE2XydUWuKTym
X-Proofpoint-GUID: coah1VaKyiHp6F1B0tCWE2XydUWuKTym

On Mon, Sep 01, 2025 at 02:30:28PM +0200, Max Kellermann wrote:
> Lots of functions in mm/highmem.c do not write to the given pointers
> and do not call functions that take non-const pointers and can
> therefore be constified.
>
> This includes functions like kunmap() which might be implemented in a
> way that writes to the pointer (e.g. to update reference counters or
> mapping fields), but currently are not.
>
> kmap() on the other hand cannot be made const because it calls
> set_page_address() which is non-const in some
> architectures/configurations.
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Some inconsitencies on const vs. double-const here.

We need to figure this out :)

Since const <type> *val will pretty well work in all circumstances, I again
think we ought to just do that instead of double-const.

Thanks

> ---
>  arch/arm/include/asm/highmem.h    |  6 ++---
>  arch/xtensa/include/asm/highmem.h |  2 +-
>  include/linux/highmem-internal.h  | 44 +++++++++++++++++--------------
>  include/linux/highmem.h           |  8 +++---
>  mm/highmem.c                      | 10 +++----
>  5 files changed, 37 insertions(+), 33 deletions(-)
>
> diff --git a/arch/arm/include/asm/highmem.h b/arch/arm/include/asm/highmem.h
> index b4b66220952d..023be74298f3 100644
> --- a/arch/arm/include/asm/highmem.h
> +++ b/arch/arm/include/asm/highmem.h
> @@ -46,9 +46,9 @@ extern pte_t *pkmap_page_table;
>  #endif
>
>  #ifdef ARCH_NEEDS_KMAP_HIGH_GET
> -extern void *kmap_high_get(struct page *page);
> +extern void *kmap_high_get(const struct page *page);
>
> -static inline void *arch_kmap_local_high_get(struct page *page)
> +static inline void *arch_kmap_local_high_get(const struct page *page)
>  {
>  	if (IS_ENABLED(CONFIG_DEBUG_HIGHMEM) && !cache_is_vivt())
>  		return NULL;
> @@ -57,7 +57,7 @@ static inline void *arch_kmap_local_high_get(struct page *page)
>  #define arch_kmap_local_high_get arch_kmap_local_high_get
>
>  #else /* ARCH_NEEDS_KMAP_HIGH_GET */
> -static inline void *kmap_high_get(struct page *page)
> +static inline void *kmap_high_get(const struct page *const page)
>  {
>  	return NULL;
>  }
> diff --git a/arch/xtensa/include/asm/highmem.h b/arch/xtensa/include/asm/highmem.h
> index 34b8b620e7f1..473b622b863b 100644
> --- a/arch/xtensa/include/asm/highmem.h
> +++ b/arch/xtensa/include/asm/highmem.h
> @@ -29,7 +29,7 @@
>
>  #if DCACHE_WAY_SIZE > PAGE_SIZE
>  #define get_pkmap_color get_pkmap_color
> -static inline int get_pkmap_color(struct page *page)
> +static inline int get_pkmap_color(const struct page *const page)
>  {
>  	return DCACHE_ALIAS(page_to_phys(page));
>  }
> diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
> index 36053c3d6d64..442d0efea5c7 100644
> --- a/include/linux/highmem-internal.h
> +++ b/include/linux/highmem-internal.h
> @@ -7,7 +7,7 @@
>   */
>  #ifdef CONFIG_KMAP_LOCAL
>  void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot);
> -void *__kmap_local_page_prot(struct page *page, pgprot_t prot);
> +void *__kmap_local_page_prot(const struct page *page, pgprot_t prot);
>  void kunmap_local_indexed(const void *vaddr);
>  void kmap_local_fork(struct task_struct *tsk);
>  void __kmap_local_sched_out(void);
> @@ -33,11 +33,11 @@ static inline void kmap_flush_tlb(unsigned long addr) { }
>  #endif
>
>  void *kmap_high(struct page *page);
> -void kunmap_high(struct page *page);
> +void kunmap_high(const struct page *page);
>  void __kmap_flush_unused(void);
>  struct page *__kmap_to_page(void *addr);
>
> -static inline void *kmap(struct page *page)
> +static inline void *kmap(struct page *const page)
>  {
>  	void *addr;
>
> @@ -50,7 +50,7 @@ static inline void *kmap(struct page *page)
>  	return addr;
>  }
>
> -static inline void kunmap(struct page *page)
> +static inline void kunmap(const struct page *const page)
>  {
>  	might_sleep();
>  	if (!PageHighMem(page))
> @@ -68,12 +68,12 @@ static inline void kmap_flush_unused(void)
>  	__kmap_flush_unused();
>  }
>
> -static inline void *kmap_local_page(struct page *page)
> +static inline void *kmap_local_page(const struct page *const page)
>  {
>  	return __kmap_local_page_prot(page, kmap_prot);
>  }
>
> -static inline void *kmap_local_page_try_from_panic(struct page *page)
> +static inline void *kmap_local_page_try_from_panic(const struct page *const page)
>  {
>  	if (!PageHighMem(page))
>  		return page_address(page);
> @@ -81,13 +81,15 @@ static inline void *kmap_local_page_try_from_panic(struct page *page)
>  	return NULL;
>  }
>
> -static inline void *kmap_local_folio(struct folio *folio, size_t offset)
> +static inline void *kmap_local_folio(const struct folio *const folio,
> +				     const size_t offset)
>  {
> -	struct page *page = folio_page(folio, offset / PAGE_SIZE);
> +	const struct page *page = folio_page(folio, offset / PAGE_SIZE);
>  	return __kmap_local_page_prot(page, kmap_prot) + offset % PAGE_SIZE;
>  }
>
> -static inline void *kmap_local_page_prot(struct page *page, pgprot_t prot)
> +static inline void *kmap_local_page_prot(const struct page *const page,
> +					 const pgprot_t prot)
>  {
>  	return __kmap_local_page_prot(page, prot);
>  }
> @@ -102,7 +104,7 @@ static inline void __kunmap_local(const void *vaddr)
>  	kunmap_local_indexed(vaddr);
>  }
>
> -static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
> +static inline void *kmap_atomic_prot(const struct page *const page, const pgprot_t prot)
>  {
>  	if (IS_ENABLED(CONFIG_PREEMPT_RT))
>  		migrate_disable();
> @@ -113,7 +115,7 @@ static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
>  	return __kmap_local_page_prot(page, prot);
>  }
>
> -static inline void *kmap_atomic(struct page *page)
> +static inline void *kmap_atomic(const struct page *const page)
>  {
>  	return kmap_atomic_prot(page, kmap_prot);
>  }
> @@ -167,38 +169,40 @@ static inline struct page *kmap_to_page(void *addr)
>  	return virt_to_page(addr);
>  }
>
> -static inline void *kmap(struct page *page)
> +static inline void *kmap(struct page *const page)
>  {
>  	might_sleep();
>  	return page_address(page);
>  }
>
> -static inline void kunmap_high(struct page *page) { }
> +static inline void kunmap_high(const struct page *const page) { }
>  static inline void kmap_flush_unused(void) { }
>
> -static inline void kunmap(struct page *page)
> +static inline void kunmap(const struct page *const page)
>  {
>  #ifdef ARCH_HAS_FLUSH_ON_KUNMAP
>  	kunmap_flush_on_unmap(page_address(page));
>  #endif
>  }
>
> -static inline void *kmap_local_page(struct page *page)
> +static inline void *kmap_local_page(const struct page *const page)
>  {
>  	return page_address(page);
>  }
>
> -static inline void *kmap_local_page_try_from_panic(struct page *page)
> +static inline void *kmap_local_page_try_from_panic(const struct page *const page)
>  {
>  	return page_address(page);
>  }
>
> -static inline void *kmap_local_folio(struct folio *folio, size_t offset)
> +static inline void *kmap_local_folio(const struct folio *const folio,
> +				     const size_t offset)
>  {
>  	return folio_address(folio) + offset;
>  }
>
> -static inline void *kmap_local_page_prot(struct page *page, pgprot_t prot)
> +static inline void *kmap_local_page_prot(const struct page *const page,
> +					 const pgprot_t prot)
>  {
>  	return kmap_local_page(page);
>  }
> @@ -215,7 +219,7 @@ static inline void __kunmap_local(const void *addr)
>  #endif
>  }
>
> -static inline void *kmap_atomic(struct page *page)
> +static inline void *kmap_atomic(const struct page *const page)
>  {
>  	if (IS_ENABLED(CONFIG_PREEMPT_RT))
>  		migrate_disable();
> @@ -225,7 +229,7 @@ static inline void *kmap_atomic(struct page *page)
>  	return page_address(page);
>  }
>
> -static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
> +static inline void *kmap_atomic_prot(const struct page *const page, const pgprot_t prot)
>  {
>  	return kmap_atomic(page);
>  }
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 6234f316468c..105cc4c00cc3 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -43,7 +43,7 @@ static inline void *kmap(struct page *page);
>   * Counterpart to kmap(). A NOOP for CONFIG_HIGHMEM=n and for mappings of
>   * pages in the low memory area.
>   */
> -static inline void kunmap(struct page *page);
> +static inline void kunmap(const struct page *page);
>
>  /**
>   * kmap_to_page - Get the page for a kmap'ed address
> @@ -93,7 +93,7 @@ static inline void kmap_flush_unused(void);
>   * disabling migration in order to keep the virtual address stable across
>   * preemption. No caller of kmap_local_page() can rely on this side effect.
>   */
> -static inline void *kmap_local_page(struct page *page);
> +static inline void *kmap_local_page(const struct page *page);
>
>  /**
>   * kmap_local_folio - Map a page in this folio for temporary usage
> @@ -129,7 +129,7 @@ static inline void *kmap_local_page(struct page *page);
>   * Context: Can be invoked from any context.
>   * Return: The virtual address of @offset.
>   */
> -static inline void *kmap_local_folio(struct folio *folio, size_t offset);
> +static inline void *kmap_local_folio(const struct folio *folio, size_t offset);
>
>  /**
>   * kmap_atomic - Atomically map a page for temporary usage - Deprecated!
> @@ -176,7 +176,7 @@ static inline void *kmap_local_folio(struct folio *folio, size_t offset);
>   * kunmap_atomic(vaddr2);
>   * kunmap_atomic(vaddr1);
>   */
> -static inline void *kmap_atomic(struct page *page);
> +static inline void *kmap_atomic(const struct page *page);
>
>  /* Highmem related interfaces for management code */
>  static inline unsigned long nr_free_highpages(void);
> diff --git a/mm/highmem.c b/mm/highmem.c
> index ef3189b36cad..93fa505fcb98 100644
> --- a/mm/highmem.c
> +++ b/mm/highmem.c
> @@ -61,7 +61,7 @@ static inline int kmap_local_calc_idx(int idx)
>  /*
>   * Determine color of virtual address where the page should be mapped.
>   */
> -static inline unsigned int get_pkmap_color(struct page *page)
> +static inline unsigned int get_pkmap_color(const struct page *const page)
>  {
>  	return 0;
>  }
> @@ -334,7 +334,7 @@ EXPORT_SYMBOL(kmap_high);
>   *
>   * This can be called from any context.
>   */
> -void *kmap_high_get(struct page *page)
> +void *kmap_high_get(const struct page *const page)
>  {
>  	unsigned long vaddr, flags;
>
> @@ -356,7 +356,7 @@ void *kmap_high_get(struct page *page)
>   * If ARCH_NEEDS_KMAP_HIGH_GET is not defined then this may be called
>   * only from user context.
>   */
> -void kunmap_high(struct page *page)
> +void kunmap_high(const struct page *const page)
>  {
>  	unsigned long vaddr;
>  	unsigned long nr;
> @@ -508,7 +508,7 @@ static inline void kmap_local_idx_pop(void)
>  #endif
>
>  #ifndef arch_kmap_local_high_get
> -static inline void *arch_kmap_local_high_get(struct page *page)
> +static inline void *arch_kmap_local_high_get(const struct page *const page)
>  {
>  	return NULL;
>  }
> @@ -572,7 +572,7 @@ void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot)
>  }
>  EXPORT_SYMBOL_GPL(__kmap_local_pfn_prot);
>
> -void *__kmap_local_page_prot(struct page *page, pgprot_t prot)
> +void *__kmap_local_page_prot(const struct page *const page, const pgprot_t prot)
>  {
>  	void *kmap;
>
> --
> 2.47.2
>

