Return-Path: <linux-fsdevel+bounces-51151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8346AD3335
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 12:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186C716AA70
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 10:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F32A28C024;
	Tue, 10 Jun 2025 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LkLVqxxn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="haMWoxe1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCCE28BAA1;
	Tue, 10 Jun 2025 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749550013; cv=fail; b=OIJDGNMW4EQKoX2NyewZeqhIbNqimr2l1gQCCVLKaTt2yblKet0ao5nsnLjjCcdPDZWqiw1S0CN6/IsM69gsIbKarHwne6OJxCWYE/APefU4EK2DVO3DWylbv10RChspQrQti1nko3qeDOIcTS779Kh7JWM0XEgdo3IUD7IEDQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749550013; c=relaxed/simple;
	bh=h+8SQ8aTDGPHK1YhLv+NcOWfhwAM/qn0N0IKnbscIGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NijEWYMnr4XQBp33HwEqfjn/RG2tNCrbRouBcqCocchzHFFfE170rYDpCYREl8SENatTv1QXBzr5lHcO6pe0B7g//YVU4SqJHU/Pyo7uVoncUKu6l7NXCIpto7q0bIbzO8zor6ROtVdhRzVMeY3oFxIpQuMS02VRZsM8jftK0aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LkLVqxxn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=haMWoxe1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A2nnhx012613;
	Tue, 10 Jun 2025 10:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=rGyAo8fmFmuvHbXbwW
	ECYtKjnjW7WBkyabHuw0QHTb8=; b=LkLVqxxnqVSJhlEzblG44J+hhwQ+aBHStL
	AYoPlTbDq8MF1uz2JC0VoLzlCazV3DyHvg2UA328T+yNRYKJHD2E7t5hO/xNn9O6
	/IyzaFC6DTFI5Z4DqA+yRkYERPNpAsmJS+LiB9mFEgoo2H6bWFPrOdNqXRExAtuJ
	BLRxk3K26q6nSc8nqtyqPDZRdWGC5VnFNzfdzCJgB2oh+BzCGfcFeJBoJcAIMKTg
	OZLaTXUCv5ACoBw/IM0NGy/yDHOgUChzPKESCCSGooZv4pxuPQyH+XkJ8bNpFXP7
	lSBIpXRuH/4irofuB8zUedvjsmzuSGFv8VJiela2v5H/wCzCrMSQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474d1v3x8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 10:06:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55A9FG1p032351;
	Tue, 10 Jun 2025 10:06:36 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv8hc2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 10:06:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/2E6i/q5NBhRzI75uFfWVRQrahqC77qbYn/A4QQNHsGrT10p4n+SD0nmo4tTR4rPH3a24QEmz+bRlEVW26Z1iLJ6Y5sRaj/FHaPNZJPGyiZySVqWY2BqXlzncvtCdMOqEHuX00ChQsMUCXhyLBihS71S9mbLsN7JM7Hm5sC9rM0L95wz+2iMhaljqSTqOaHCFGx9qb4jrFib8fAOQDfmvepweflaJuZkh4FdawEwrkZ/R8YmgFSp9GYgCDeb5sv0I/LOnzUwbkRbICj+UZJB3vcFzOBXOzp3dzwMp2anZr1VGrulNE46FX4YdO3qVWnfOTQY4cVuBtBFGSfifyiNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGyAo8fmFmuvHbXbwWECYtKjnjW7WBkyabHuw0QHTb8=;
 b=kStEpjKvigWpBfKE6dzyR/VvRlWRGE1FsA4v0GfeLMcZW05Ta4X9tFOQODReQGVx8s2I1BPCt4nEUNSFO8mzlVrWU72PP6o0GdMHiqFuLSFDqCfogWigV1sUnufGgy7LSKkKHqbiKZIGYltnBjF188P3yxOeZqCWr9OWeWuoprIVEQ599iDNKMXlf9GYHApy+sCGk3s8dtqzQz+FyMhUkOsIRAEykGxyjv5AjOkU0eVDv13uPAER6SAOUoooD4wRWtyGiLimFSKxkq4sPImsvIR41pgmJIvefhvYqD0xtaFHyLfkHWzo1ZV5wTVTHEuj8tT+xuTKypvAWIdfVHB+LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGyAo8fmFmuvHbXbwWECYtKjnjW7WBkyabHuw0QHTb8=;
 b=haMWoxe1tyYweEfBVFp/RJ+c1/VAhhZyp0DCO2nr8nJHsUHb08qnlj+DgnJqew1NrHD05VdXxqYf2pL024j5Rkm+Md/S8EaaH8eLhtOLDPWnZ1vv8NNHx6nFnKzEpx1MlXZMgHBDS4K5aGaJdE5GAVHEY4JVDlLZEZc7n/rNWkU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CYYPR10MB7675.namprd10.prod.outlook.com (2603:10b6:930:b8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Tue, 10 Jun
 2025 10:06:33 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 10:06:33 +0000
Date: Tue, 10 Jun 2025 11:06:31 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: add mmap_prepare() compatibility layer for nested
 file systems
Message-ID: <ac3ae324-4c65-432a-8c6d-2af988b18ac8@lucifer.local>
References: <20250609165749.344976-1-lorenzo.stoakes@oracle.com>
 <2d4750fd-10d8-42f6-a396-ceaf386e65f5@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d4750fd-10d8-42f6-a396-ceaf386e65f5@lucifer.local>
X-ClientProxiedBy: LO4P123CA0535.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CYYPR10MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 542cffa5-00f4-40d4-c965-08dda8067a96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3cQjOBJmfc4GpDY3bZRO+//FoYO9opqf2Ry9IdFoT5PR6k/5cL7RPO1ab6pP?=
 =?us-ascii?Q?nKlRY3TWkHhV2H8Sxr/uGzCoIYgPxrRzHE1xaJN6a1ZFga+zEiFEvxXo3iz2?=
 =?us-ascii?Q?jKSDSnLqYs5XALB1LOcsvYYmNT5+ofM//MoA3qqaM7NK3RgmXBCm0iW4SJ4/?=
 =?us-ascii?Q?598w1pxFlO/KvLPyTJ3NgMdVx5jf+V6l6bHqdEd0FyaeUAK07ejnDlhPGi6J?=
 =?us-ascii?Q?zXsypZwFuwaRo65+icHpECWQiC/BTWzfT9GxuUF29dKvMSFmALjemyLcBOyL?=
 =?us-ascii?Q?VKXztFLBNXbKlIcJ5uB2jv7XODKZvjfr4ftdGVQ4vIVHabAL19QjuHaMlQRT?=
 =?us-ascii?Q?rdHxXKH6L5+7/rnH/mTI29Brl82Yvn7X0z79xr0QBqjmI6mkutw4jeNrvatr?=
 =?us-ascii?Q?ytom4Qx4koIl6qsowkm2A41Oxanjh70mlxr6c5uLffIkV3mvoLCle26LXDe0?=
 =?us-ascii?Q?n6VnNpFyREA5TvmwNYSWJN17CHWcBq6BgPhptKAozOedfsgKwxn4x/xVIxOT?=
 =?us-ascii?Q?OrONHHv+n2jEcvxZSD7zTdNTWWMXIxlZwBdSbU9Ct9ElBkYPoMPMOnjnr1O9?=
 =?us-ascii?Q?kRrqPqwrUE6Ksc6+reL2ry04Z36fYu5TdZiJygvLL5P4o5zDCQXLa8tnht/O?=
 =?us-ascii?Q?UZ2wH8gtRPxShqcPbHgLKjaUHEdNy2lLU9P2jDahwCUA5g4axbjOIOCELked?=
 =?us-ascii?Q?CZWLqDKSybgn8+JpgCApwo8rBA1bFZxjX42kel9u8ICPh6evY/D/xkm9ScEA?=
 =?us-ascii?Q?AvSj6NyUtojdFZSbtphFhew3EGGGdnY0ZHaZL5A9l7zrtkLOBZH0Rz1J3rIk?=
 =?us-ascii?Q?zAMPzHX/Hc6tY09T1ghdD2IGRSZAIL2n/SunYWTJJ94Cs/F+LimKHfPXKwzo?=
 =?us-ascii?Q?FwC3k8yny0v9Y8YM8fwN/zrwoWkIAJgsHo119v/0TUzJl1qrJ3hL04u5UzVl?=
 =?us-ascii?Q?sTGsNQGCa6YhxxuHMif28nI7Ey2rXQTCs/05iNkSRymRECpMfksXHHkx46MA?=
 =?us-ascii?Q?VYHlRaxmQmYQ5sSq5KhfyCWEw8n2Fmcy8KlssgFh875MWTA4dOdloyveu3Aj?=
 =?us-ascii?Q?JKpTQDfYXVmA/x+A41res1HRVNwJrzjw4B8K6v8lK0c2nLKgwUhhU9ViLSGF?=
 =?us-ascii?Q?7WmEr+hVCfAc284tNMMIPQ6DUNSej980GSl27suWKc+VYYriAq8cUuiwVEap?=
 =?us-ascii?Q?R9fEVqhx7pDte/5fSKVql83F1YhB+A3vt3v3CANWmqkcFPtAMNEu8jrXz+8R?=
 =?us-ascii?Q?wgiZ2v6hFydNbhibnaxW436pY3DwTo0gbbIDvkQ9OHSFMt9ylVUxgbc5pETF?=
 =?us-ascii?Q?eBoATt+leiTmITERHDules+f4pHTS6EICgmdsL0KKskDwlXS8fh4d/Uggmsy?=
 =?us-ascii?Q?Owqv9fa32cykqLHi4y3UpnJMcc6dhNaegTe8bMrkKlopmYP+Ut6OEPFmqNtI?=
 =?us-ascii?Q?NL6CVaJELUU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gMi9sMcQHRYqrqOcWmlgaUfibBfiCNM6TjPxZuObn/unm4ZnQbaKRqnQtWTh?=
 =?us-ascii?Q?I3AVKvFnOjqRrDnUmyt531iMyXyWhHRHr6OeT2RDIP+LXV6CbRuo0iOHi7BY?=
 =?us-ascii?Q?t8kroltyNF+yFpn4ZnbeH+ucFlrCiTRFsuw2yFz7JtjYwV2IyMUl3B83OKOL?=
 =?us-ascii?Q?airMWB6eU+Y20OtPQfbOtBusm1eyTS1br6GYltNnGvxiz+DBfBShj0HsW/Us?=
 =?us-ascii?Q?sgDIcXJaF61QtPkSoS6eNBxmx8j0fITN8iszA0CrnBrIwU0h01ePv+11V5vD?=
 =?us-ascii?Q?1DUNYCIMHwz2TAfXhwEX2ZKex+1phR7huHX/JGzv9h2as5Kku9X7jqHIaO/f?=
 =?us-ascii?Q?9ViHeL8i3GzjAXb8m/q9E3rxa78g+IPGFgBCIHSVFkhqcQsNj92ISYyEtu0Z?=
 =?us-ascii?Q?8Hk2bGCXi/zhlsSfilAkAz/KCflaOQ9XuJ9NhmXSJP9owCOGMi3QwBG+3IMZ?=
 =?us-ascii?Q?+rjAa0br+rXRyncOk48+YkoP1z49P9pB1Ti3Eyl2FCk9u2QVnfJl27Nu8PCO?=
 =?us-ascii?Q?iAoS1BQnD0DvvitVkIVjfOdHGKGbqZJevbCDkrUN98Vc6jMLIYfuCzm5wWvj?=
 =?us-ascii?Q?LRIeNfpT3WD+fmiB2nYkdYIvxnvi6y6ZwT+6PUyw3AFO7JuLULlH8A907ZAa?=
 =?us-ascii?Q?1MyWu+CI4U+4LkFdWwYSxBComdhyYNnXlcPHqmXHVDx3HzmhGOlz3WQP6hWE?=
 =?us-ascii?Q?bX64D/hc8Wam4WD5qraVjidEtzwTmXo+XUBEmsz2X//KG2sEBB/qstlszcIz?=
 =?us-ascii?Q?VhhZY8K7zfbd+Uq07lVoRtbu4rwiwFZNO0UJp9WYWeWrbsHhqQDB7Uk0Mzb/?=
 =?us-ascii?Q?9vWlymkfLB+YMN8iO6MKC7z06TPVrMsdcU1Ne1TnRyjUbPStpOgQe9YysH5L?=
 =?us-ascii?Q?ObQ13hPIX95MNZn/f945rz2c3qm3PO7NUAjjIg6e22o7hXYt0IzKaGWpMnwQ?=
 =?us-ascii?Q?D6jVu0LMH4YVlXC0rzjHsogDxIjczXfHlBQhFSYcwUWMZFUT2FKJx9W7QfUI?=
 =?us-ascii?Q?jhU8jVMH8Jz+ybceRTKnT/+kUDGrZuQbcFVt5GZY7moo6Y6JxGD/vNQdtoJJ?=
 =?us-ascii?Q?04yZv64UlE+tvawl2cDkR9PkoJYozEG+oFHB7AeIGgOOoTbtJ5xv/MpQjFWk?=
 =?us-ascii?Q?9eOkdsDbRNzSq3W8IcpEcjaeQRI9v60zb7yLS+gEKT1yNqm1E64yJts+UBqr?=
 =?us-ascii?Q?hZGuGRNMbtD/+nmpHNzHLxF0Ud65nHpgRJ8oSxbz7PLoYE7xjvHlJNfGEJFS?=
 =?us-ascii?Q?fFdRZHglFDrUUBs0v6vQ6qx+jQzSeYd/ZpCpq5xt6TbaH9nEIO4To6v2aJQN?=
 =?us-ascii?Q?m8mDkFEMO0ZWuAS+ukKaVVjGEjIDZ8wuzSkhHfxda00ud6UUB7Laj6M2v4Z3?=
 =?us-ascii?Q?dKa1vNYS0Kjy353GWgjy8Q9yK1P2DHqnE5TUgF+UkPAMEPNIOEB6wVEFZZB3?=
 =?us-ascii?Q?cUk0HiMFI/U+z8MHyk8h/mZNKtQpFm//oy4YAfglm/VR5FbDXXcya7NcknBQ?=
 =?us-ascii?Q?XSGvrDohiASgcBnWzb91aQ2YNl80sX/HtCb/4o2Lyl4DvE6nNbbmTwe6cSCO?=
 =?us-ascii?Q?yNg3g/8EozGx4m32Ha353Stcxar5M3QszkRnZH+gTqFM1n/iemAfaI4IyK0p?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B7Oi+JPG28jPrBpEtpW3ArIYbisPmcCVEwfUIxVeL0bp8G6MNo5OFnqD5NHSiKZmywrD4i62foyNEZNKMZKzK79ENrJ7DPUkJL+LTbO9VORr+mG5tRiahJOHubCwd8WKuIUhICIbr6IMxWFwWQSM20SZ0a9lbVlQ/6Gi3grbAlgKDniPUysa3COjGjtKIKZA1s4bFzOhDzsF9eO1Fwk2kvBwQDVE0CMTQ3H4uNtqb69YPvh7yB4mjD37kU8LXSjSByuBH3/AWRLZ1cvrDlWUuJgIfmjpo8d3fi2NK5RDXjK/+Fe1awB+Qiz33b1LuUxPereDGvdpWanSgSVt4OZciJSmHa4SXSwZpeeEyLIB/v8TKubbGkAwBDq/tOmuYfuQ7mq19gNp680lLsPfGfPdra3HTv2lA+axa5MjgVWBgdcCdb6xvU9Fp+R2NT9AQ/1LBBQlOuypO9MS5C4DCH2flh56T2T0rs0nVvcWqYtj/SWySKgb+evnf0xVHcWRxC3DzEvJ8uCzXTvcWNj/9rORDmFynIYzCWGb1cYRc09T5hErNbVk+RYbTfxfjCwxMz/2/BRIEClF7Zx0G+v/JSXapS3FRXwNwCftV+7W2fMQgaE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 542cffa5-00f4-40d4-c965-08dda8067a96
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 10:06:33.8506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XADy+BaWO5woIESRj4vhgf2DdE1xmJW7Rm/OeR0EKpZlH8If3tSdu6wpiPuF9OJJtsb/SK4RtVz9LhxI/GT6QPAu6PJ0IrVMcNg3Vqqcj2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7675
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_04,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100077
X-Proofpoint-GUID: q9cTv94tz7Wjv3C6rV0WENGRiRxfy_7i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDA3NyBTYWx0ZWRfX0XoAdD25EusT NmkGOi7yM7lUJ2nb6pt+9o5vrWJ4AZL1kVgYCSeoTPVJZqsE/VHl0OLTW6tjfYf8HsyljjthADC W66X8a7joOUl8mIo3jKI/FwadbIfCzNAosOh2XB/sSVsLjQJkQt4X/SG4osFQRrAg02uCQgxNVT
 EboV1M1YhcWPew6MHBn59u4uASoM8+N4pb3ZUvFV0Y9HMncuz5ujpJm8F94BUAESrwfRqpqkvoV JI7PiN8s8MSvme1xrGeXEuT/JESWOQ6XDR3xk86GISQOIdKMiHIPc2SDEBERgf4XgZ7SOR9uvRJ 85NxSACXnK4HVj5SN/CrESZqcZDRu654QliJWGGWac+cdpR0pKxPSDPMfhMEWjN1/KLlRetG8bk
 FGACphtvOAc1MF6wdXfV4VRT6zL7WFBmGKfsi5v83mLpXwjqbfijVwPuHdmfGWDGF2mZ5Ihf
X-Proofpoint-ORIG-GUID: q9cTv94tz7Wjv3C6rV0WENGRiRxfy_7i
X-Authority-Analysis: v=2.4 cv=d731yQjE c=1 sm=1 tr=0 ts=684803ad cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=xmuaRcZ9EVncYmRBf1MA:9 a=CjuIK1q_8ugA:10

Andrew - I realise this has been a comedy of errors :>) so let me know if you
want me to just respin.

But anyway, I realise I left in a couple decls by mistake. They're harmless, but
silly. I attach a fixpatch to fix them, please apply, thanks!

Cheers, Lorenzo

On Mon, Jun 09, 2025 at 07:37:33PM +0100, Lorenzo Stoakes wrote:
> Andrew - apologies, please attach the tags as below which I mistakenly didn't
> propagate...
>
> Thanks!
>
> (note to self, figure out b4 :P)
>
> On Mon, Jun 09, 2025 at 05:57:49PM +0100, Lorenzo Stoakes wrote:
> > Nested file systems, that is those which invoke call_mmap() within their
> > own f_op->mmap() handlers, may encounter underlying file systems which
> > provide the f_op->mmap_prepare() hook introduced by commit
> > c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback").
> >
> > We have a chicken-and-egg scenario here - until all file systems are
> > converted to using .mmap_prepare(), we cannot convert these nested
> > handlers, as we can't call f_op->mmap from an .mmap_prepare() hook.
> >
> > So we have to do it the other way round - invoke the .mmap_prepare() hook
> > from an .mmap() one.
> >
> > in order to do so, we need to convert VMA state into a struct vm_area_desc
> > descriptor, invoking the underlying file system's f_op->mmap_prepare()
> > callback passing a pointer to this, and then setting VMA state accordingly
> > and safely.
> >
> > This patch achieves this via the compat_vma_mmap_prepare() function, which
> > we invoke from call_mmap() if f_op->mmap_prepare() is specified in the
> > passed in file pointer.
> >
> > We place the fundamental logic into mm/vma.h where VMA manipulation
> > belongs. We also update the VMA userland tests to accommodate the changes.
> >
> > The compat_vma_mmap_prepare() function and its associated machinery is
> > temporary, and will be removed once the conversion of file systems is
> > complete.
> >
> > We carefully place this code so it can be used with CONFIG_MMU and also
> > with cutting edge nommu silicon.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Reported-by: Jann Horn <jannh@google.com>
> > Closes: https://lore.kernel.org/linux-mm/CAG48ez04yOEVx1ekzOChARDDBZzAKwet8PEoPM4Ln3_rk91AzQ@mail.gmail.com/
> > Fixes: c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file callback").
>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>
> > ---
> >
> > Apologies for the quick turn-around here, but I'm keen to address the silly
> > kernel-doc and nommu issues here.
> >
> > v2:
> > * Propagated tags (thanks everyone!)
> > * Corrected nommu issue by carefully positioning code in mm/util.c and mm/vma.h.
> > * Fixed ';' typo in kernel-doc comment.
> >
> > v1:
> > https://lore.kernel.org/all/20250609092413.45435-1-lorenzo.stoakes@oracle.com/
> >
> >  include/linux/fs.h               |  6 ++--
> >  mm/util.c                        | 39 ++++++++++++++++++++++++
> >  mm/vma.c                         |  1 -
> >  mm/vma.h                         | 51 ++++++++++++++++++++++++++++++++
> >  tools/testing/vma/vma_internal.h | 16 ++++++++++
> >  5 files changed, 110 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 05abdabe9db7..8fe41a2b7527 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2274,10 +2274,12 @@ static inline bool file_has_valid_mmap_hooks(struct file *file)
> >  	return true;
> >  }
> >
> > +int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma);
> > +
> >  static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
> >  {
> > -	if (WARN_ON_ONCE(file->f_op->mmap_prepare))
> > -		return -EINVAL;
> > +	if (file->f_op->mmap_prepare)
> > +		return compat_vma_mmap_prepare(file, vma);
> >
> >  	return file->f_op->mmap(file, vma);
> >  }
> > diff --git a/mm/util.c b/mm/util.c
> > index 448117da071f..23a9bc26ef68 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -1131,3 +1131,42 @@ void flush_dcache_folio(struct folio *folio)
> >  }
> >  EXPORT_SYMBOL(flush_dcache_folio);
> >  #endif
> > +
> > +/**
> > + * compat_vma_mmap_prepare() - Apply the file's .mmap_prepare() hook to an
> > + * existing VMA
> > + * @file: The file which possesss an f_op->mmap_prepare() hook
> > + * @vma: The VMA to apply the .mmap_prepare() hook to.
> > + *
> > + * Ordinarily, .mmap_prepare() is invoked directly upon mmap(). However, certain
> > + * 'wrapper' file systems invoke a nested mmap hook of an underlying file.
> > + *
> > + * Until all filesystems are converted to use .mmap_prepare(), we must be
> > + * conservative and continue to invoke these 'wrapper' filesystems using the
> > + * deprecated .mmap() hook.
> > + *
> > + * However we have a problem if the underlying file system possesses an
> > + * .mmap_prepare() hook, as we are in a different context when we invoke the
> > + * .mmap() hook, already having a VMA to deal with.
> > + *
> > + * compat_vma_mmap_prepare() is a compatibility function that takes VMA state,
> > + * establishes a struct vm_area_desc descriptor, passes to the underlying
> > + * .mmap_prepare() hook and applies any changes performed by it.
> > + *
> > + * Once the conversion of filesystems is complete this function will no longer
> > + * be required and will be removed.
> > + *
> > + * Returns: 0 on success or error.
> > + */
> > +int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma)
> > +{
> > +	struct vm_area_desc desc;
> > +	int err;
> > +
> > +	err = file->f_op->mmap_prepare(vma_to_desc(vma, &desc));
> > +	if (err)
> > +		return err;
> > +	set_vma_from_desc(vma, &desc);
> > +
> > +	return 0;
> > +}
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 01b1d26d87b4..3cdd0aaa10aa 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -3153,7 +3153,6 @@ int __vm_munmap(unsigned long start, size_t len, bool unlock)
> >  	return ret;
> >  }
> >
> > -
> >  /* Insert vm structure into process list sorted by address
> >   * and into the inode's i_mmap tree.  If vm_file is non-NULL
> >   * then i_mmap_rwsem is taken here.
> > diff --git a/mm/vma.h b/mm/vma.h
> > index 0db066e7a45d..d92e6c906c96 100644
> > --- a/mm/vma.h
> > +++ b/mm/vma.h
> > @@ -222,6 +222,53 @@ static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
> >  	return 0;
> >  }
> >
> > +
> > +/*
> > + * Temporary helper functions for file systems which wrap an invocation of
> > + * f_op->mmap() but which might have an underlying file system which implements
> > + * f_op->mmap_prepare().
> > + */
> > +
> > +static inline struct vm_area_desc *vma_to_desc(struct vm_area_struct *vma,
> > +		struct vm_area_desc *desc)
> > +{
> > +	desc->mm = vma->vm_mm;
> > +	desc->start = vma->vm_start;
> > +	desc->end = vma->vm_end;
> > +
> > +	desc->pgoff = vma->vm_pgoff;
> > +	desc->file = vma->vm_file;
> > +	desc->vm_flags = vma->vm_flags;
> > +	desc->page_prot = vma->vm_page_prot;
> > +
> > +	desc->vm_ops = NULL;
> > +	desc->private_data = NULL;
> > +
> > +	return desc;
> > +}
> > +
> > +static inline void set_vma_from_desc(struct vm_area_struct *vma,
> > +		struct vm_area_desc *desc)
> > +{
> > +	/*
> > +	 * Since we're invoking .mmap_prepare() despite having a partially
> > +	 * established VMA, we must take care to handle setting fields
> > +	 * correctly.
> > +	 */
> > +
> > +	/* Mutable fields. Populated with initial state. */
> > +	vma->vm_pgoff = desc->pgoff;
> > +	if (vma->vm_file != desc->file)
> > +		vma_set_file(vma, desc->file);
> > +	if (vma->vm_flags != desc->vm_flags)
> > +		vm_flags_set(vma, desc->vm_flags);
> > +	vma->vm_page_prot = desc->page_prot;
> > +
> > +	/* User-defined fields. */
> > +	vma->vm_ops = desc->vm_ops;
> > +	vma->vm_private_data = desc->private_data;
> > +}
> > +
> >  int
> >  do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  		    struct mm_struct *mm, unsigned long start,
> > @@ -570,4 +617,8 @@ int create_init_stack_vma(struct mm_struct *mm, struct vm_area_struct **vmap,
> >  int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift);
> >  #endif
> >
> > +struct vm_area_desc *vma_to_desc(struct vm_area_struct *vma,
> > +		struct vm_area_desc *desc);
> > +void set_vma_from_desc(struct vm_area_struct *vma, struct vm_area_desc *desc);
> > +
> >  #endif	/* __MM_VMA_H */
> > diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> > index 77b2949d874a..675a55216607 100644
> > --- a/tools/testing/vma/vma_internal.h
> > +++ b/tools/testing/vma/vma_internal.h
> > @@ -159,6 +159,14 @@ typedef __bitwise unsigned int vm_fault_t;
> >
> >  #define ASSERT_EXCLUSIVE_WRITER(x)
> >
> > +/**
> > + * swap - swap values of @a and @b
> > + * @a: first value
> > + * @b: second value
> > + */
> > +#define swap(a, b) \
> > +	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
> > +
> >  struct kref {
> >  	refcount_t refcount;
> >  };
> > @@ -1479,4 +1487,12 @@ static inline vm_flags_t ksm_vma_flags(const struct mm_struct *, const struct fi
> >  	return vm_flags;
> >  }
> >
> > +static inline void vma_set_file(struct vm_area_struct *vma, struct file *file)
> > +{
> > +	/* Changing an anonymous vma with this is illegal */
> > +	get_file(file);
> > +	swap(vma->vm_file, file);
> > +	fput(file);
> > +}
> > +
> >  #endif	/* __MM_VMA_INTERNAL_H */
> > --
> > 2.49.0
> >

----8<----
From 0a2c0811649417e91804ea81f610e896e2ea7aba Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Tue, 10 Jun 2025 11:03:11 +0100
Subject: [PATCH] fix

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/vma.h b/mm/vma.h
index d92e6c906c96..f47112a352db 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -617,8 +617,4 @@ int create_init_stack_vma(struct mm_struct *mm, struct vm_area_struct **vmap,
 int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift);
 #endif

-struct vm_area_desc *vma_to_desc(struct vm_area_struct *vma,
-		struct vm_area_desc *desc);
-void set_vma_from_desc(struct vm_area_struct *vma, struct vm_area_desc *desc);
-
 #endif	/* __MM_VMA_H */
--
2.49.0

