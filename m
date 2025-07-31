Return-Path: <linux-fsdevel+bounces-56374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6FDB16E25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 11:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60E8564A04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 09:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E75A290BC4;
	Thu, 31 Jul 2025 09:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KWaiYc7Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xl6a/5X9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1361F2557C;
	Thu, 31 Jul 2025 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753953015; cv=fail; b=eGa9T/qFY1V9J6RCAt1zpGqeFWBAIYS21wvPnZX1hhXQIvzwyu55XLQJ2dZUUBO95u7VouiOga9u+/tJhsm8Z+hi4S8XxJBmzI0zm5CeSNF6BToxTw6fSL4lKHcWl/9QWa5Iwuw64W9Ml6yYKB97pCTalGBNDQK2V0rrRa0FHqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753953015; c=relaxed/simple;
	bh=mjDdIPNu4FnMT8JTdkTEaAm16phrG10CNsrzRHJZmqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N2U5GN8qxhqWy9UH3pH28Jl0fQ+AgSj94X9LHtKF4UQ5MwLCJe1RY+EUBDaF+yxTQECkIG+HQguzamFaQoAUFba/jl7aFFz7i2bP/kG/dIPT1VdxD1+nD8VNPiHatriGuls0WqCVLejW8rC1Wh5P6AK+G7gETvaiXFiR4YbvOz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KWaiYc7Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xl6a/5X9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V7C4M8009946;
	Thu, 31 Jul 2025 09:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=j0RN3BGnmdscb0sGo1
	scDHW3hj8c8X2j+etuhxnOOyk=; b=KWaiYc7Z+C3NNafN82RV4RbivlU9KvEs5o
	SBt2IoIle19K9hHwDocw/hdkOjQpkWCPcdBpl1tlz4uvFGPs8Y3SxtQC2YETpeo7
	c6ZBNixJFFhhVtRaQMklRvC1jMymqDqjbu1n42ptBeARHNC6p9N381/nTX4A1BqH
	EdRhMODEdMEh8Wvi3nUSHzB7GJMvz1OLdjBcvoDXe8uk7cCtd0Unmde+JhDV/Is2
	/dL9WNbdC+tKcXooF1sfPofj8LjPSzAEEsRc4JWZQ4vA7BMTuI3S+UPktKilflnw
	9m6L1MfbD9QsRB7bWKeF39ZvHFY4xEKDDWolVlRT8zsgz0Ffdggw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 487y2p0jfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 09:09:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56V78Ort020333;
	Thu, 31 Jul 2025 09:09:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfjje2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 09:09:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLXjl3AGpjMyfswRCDhKQr5Qi3rmiXqHxO32rMATsjo2I2qhwV2AdkpSJOQo6q58tmoIRiJy1FoeatDSrLzch0JcnWoGKBvawzl7N+PhF5orLL1k3EjqyRWmEwFiupRo9F0hRbwiSJ0HsSRtTHcYJURVE1gMo9OcDCn0mcuY9xt6ffYN428EY4QR/Zy3fYzB9tdSjTnVBrJxmuwBoa/5NzvhtWLLcYfoqfWt0TLOHAHNvq1sxvtXdKW9e7WyRL/GQPcc/wG0F2fIQJOpZ/GXcweY1kB3qwKyl00pGWjeGyxovNoJIlqcF3BMIKuhQT7KWS9Gd//3Zuahxc8j+247Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0RN3BGnmdscb0sGo1scDHW3hj8c8X2j+etuhxnOOyk=;
 b=HmhFT8BwfxQhE5n9KeV/dNDPdB0BH7RqY5uypeN3lH2jyhDGEyk2MVaYvH1/XFQaN2BVSmEbGIxXVPLOdkft7RoBp+J288r5NY1cToAiHXGoDEJjs8WUgEB1WsR41kiY5yD8EmQGSGCeWONTeJmj7W95zxUgq3M0H7EIxu0ZeB07dSUARf4oq0DYn97DMInoyyJMaW+O5bakXJbiZ2f5YDZYALdIUSoTheN5kXeVBvmXvRT9HDJBuy4tQbOMWhmMpQXNSa+F6V8Xp1LEylU4LiRZJ/2Fil4awZk80dIi0mNk3D8sqqkxI8oGSH7M6NIiLIw8i9z+WrZ4uQDLQTdWjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0RN3BGnmdscb0sGo1scDHW3hj8c8X2j+etuhxnOOyk=;
 b=xl6a/5X964qUP1SBITWSmhMcdJeBsh29YxyqiTN4GQ+UrgYPsbhmflJ1InAZ9hpIhi21XvPGpvJQY+ZM/nMA4O0lMauwvXmds8xbcoh2myobxtoZiYYG684EGlOUajll6TiatdY306r+1nwFyyV18OvB8xG/wLfe6c+XxYrqUbc=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by MN2PR10MB4302.namprd10.prod.outlook.com (2603:10b6:208:199::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Thu, 31 Jul
 2025 09:09:13 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.8989.011; Thu, 31 Jul 2025
 09:09:13 +0000
Date: Thu, 31 Jul 2025 10:09:08 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Usama Arif <usamaarif642@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org,
        baohua@kernel.org, shakeel.butt@linux.dev, riel@surriel.com,
        ziy@nvidia.com, laoar.shao@gmail.com, dev.jain@arm.com,
        baolin.wang@linux.alibaba.com, npache@redhat.com,
        Liam.Howlett@oracle.com, ryan.roberts@arm.com, vbabka@suse.cz,
        jannh@google.com, Arnd Bergmann <arnd@arndb.de>, sj@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@meta.com, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/5] prctl: extend PR_SET_THP_DISABLE to optionally
 exclude VM_HUGEPAGE
Message-ID: <82f41b2f-fbf1-419c-9ce8-6875929de814@lucifer.local>
References: <20250725162258.1043176-1-usamaarif642@gmail.com>
 <20250725162258.1043176-2-usamaarif642@gmail.com>
 <8c5d607d-498e-4a34-a781-faafb3a5fdef@lucifer.local>
 <6eab6447-d9cb-4bad-aecc-cc5a5cd192bb@gmail.com>
 <41d8154f-7646-4cca-8b65-218827c1e7e4@lucifer.local>
 <36cae7e8-97d0-4d53-968b-7f39b34fa5c0@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36cae7e8-97d0-4d53-968b-7f39b34fa5c0@redhat.com>
X-ClientProxiedBy: PR3P193CA0050.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:51::25) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|MN2PR10MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: e7e96557-a2fb-4181-b07e-08ddd011ea54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M8raP2yJI1ho3ws6iQn0igGxMMAemAN1KpYJ831fYmrVaQGkNy47Vo31aTXv?=
 =?us-ascii?Q?rbHwBqZD3n1ISaCJTKelQ54Utfmf93nbaiQlYyGymRFOHHnni0kdYdAleZq+?=
 =?us-ascii?Q?QEUanSdZ8xbf2rmhh5wbOBQTwdBoK2U3EDR9PKeqiOehiQ+ZIA+y1rJkhu15?=
 =?us-ascii?Q?OcJw3OXVo0YnIjriX4/OVqIrrqOUmhr3q1uAcHPMXOPat7ePeCopPdwK1Pba?=
 =?us-ascii?Q?1GZq8t9a68LweRSLbMqPoQE2qp+vAhfPceRqRo1Sk38zAH7o7XRm86Tas7lV?=
 =?us-ascii?Q?85MW3lDOdGS+hpHP/yXmPaU7MCvwzqYNDl7GJnpHKNIMu1HUY9Xhke7LBfBk?=
 =?us-ascii?Q?2Wnt5brzXGWDzW17k5IBY9VOlPtaeGiWpRbs25mQbn0K1RSmUL22/GvHbPGP?=
 =?us-ascii?Q?MFpPA66UZAUFJFQx5gvy9WAt4StIvBg28vGuhn2KDavARLbi5IXl+5TB50Sx?=
 =?us-ascii?Q?Z9nhvOhG5WTcRQ+mhCgzO1kBGtO6FJuJ7/VIaUU1uubrMHKYlRsu8wim0myD?=
 =?us-ascii?Q?iEMnXZogpqzCQgQhBaymUNQ/vzJ6io44CApYCrzRWOWBEJM4WWqmo6WDQd2r?=
 =?us-ascii?Q?AUBSa9zT6ltsG/BCFvF/qGnr0heEar0n/Y0yEKj5tZ1jPfGNZ8kybz0taVpR?=
 =?us-ascii?Q?gxCivCq9feti51FpmzKBKIBAIuk1FB6+tbZChUQS17AYDj2augWnv8Y1SWdT?=
 =?us-ascii?Q?ap6X9y5Do+QX7ZULt0Fwi+49/u5GizJKwqXdYDoIw/hdMH1HHYQnY016f+la?=
 =?us-ascii?Q?L4CLy7JmZAOXRNg1QdK7rQsA/6hFfqO+iupkWOU+A1zaOLLqLeinm3zUyd8y?=
 =?us-ascii?Q?w9cpubGWcYNo7zd09A457KC9bWYHIsZUwYbtrkWJSb8wpAjtc/mc0dIFPQuH?=
 =?us-ascii?Q?S7w7Q73HtYqjes4RdhjzH+RRf5UwGuBs9WQpsOuXwqPPRWhp3fbrWiKNlmvO?=
 =?us-ascii?Q?/K4pzpocjrJGa6gZGgd/3YhHR4qMTnwItUZGr2IwKhdBD0Vi8+cuvndorB/a?=
 =?us-ascii?Q?gS0sGBF191w77JKupb7u9R4V2WZd0nBVnXYBeI1856I7CvaKolXfz/Z9Yefu?=
 =?us-ascii?Q?a/Dz8IqX4jA7RhrGZcDN5ETR/9uJP16yxsyeMQER3B3aruB0i+2Sw3in1Ey1?=
 =?us-ascii?Q?EqRGROttXpVd31Bd6pe2XBV4sZplf4v6mIPAvB6uaPy+g4FJVDRYVG7pAj//?=
 =?us-ascii?Q?o6oIJL7gel4VadMofLPb9dmBTosOGhQWDMr77Zwn9A6zWwpq757awMNeYizn?=
 =?us-ascii?Q?hjfIdxXcLkcXJw766qqntvZpoAnnurwHc6ddvD3vPhwYHk++qDTdCVpgnHTT?=
 =?us-ascii?Q?uo5X+5KEwBuBZ+u2UDxJijBFCN1COLCQxUMf6MnqhNrECrXVQguudatKZaDd?=
 =?us-ascii?Q?gXm6oHrnwlBC+RF+x8gQ6gMCU+P/gQODb/NjvVeYGWc+ZxvlniCXuGlwBok+?=
 =?us-ascii?Q?y7E9PIRdZvQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B5PtBxPJK3qER5WKhIQm/6bnqobP9i2ezFUE2S4JpWTUbRiCQubbbqdsbFkl?=
 =?us-ascii?Q?k0NxRAWiUV54gFG3XtshNfg5cfgyIKh3BYi7xfNs3xzF4QsRL7JONLClDuJq?=
 =?us-ascii?Q?nVFicgHF3L0zlMcGrAEn+AqkpmJ36nRSU6LdNQbdhxxJ/71r8HmfPZsSSMRk?=
 =?us-ascii?Q?gNkRUTP8HoJPP2yPpUNGJ3tkN/0zH1h7g2M38Ofru2aSmpRPKx0ip31Ci960?=
 =?us-ascii?Q?PNbFdPAOy8DI0hlT1q1tmK/B6eJD4IpOaDW2RmzEEEi/DmF0e0qPyGy3KZnT?=
 =?us-ascii?Q?kFQpb6Z/YZL6Z9bHVOuNBS0+Ar5i8fA5apBtx67K2eM6EKzpH3UInfQ8huPp?=
 =?us-ascii?Q?ui9bkB0EL/ZxozYZbhsau2RA13MPe8p1KzkJLkhKoXGPMziMZXs7vNPCZgZO?=
 =?us-ascii?Q?vCSWOtcxnlM/HQKlMFXLUEVPuQtUOl9MYlJi4ZZf4+lwcltYXuq7Z7f+eTty?=
 =?us-ascii?Q?ILnMVO9Y8njrNX4KCsMpkvRq3XntQgklu2NPmgPhx/3mcCkcxtDIxNu5bHB7?=
 =?us-ascii?Q?LxVnfF3MJMpZLsn7YS7KpRuq3CMHrg+lWRIO59Z0NPDMd98Fj6KOafKpfZXJ?=
 =?us-ascii?Q?Z0RfBVg9cuBbSCyI/yPmEG7bm/5L9foK5ABnTbzmjHdej5wG9TK4nS+edx/m?=
 =?us-ascii?Q?4E7uRATo3CdepR7O3H7i5jJ6hlhKoZKr6wHNyVZ3H6ONmcaPIeKwNlqA5/nS?=
 =?us-ascii?Q?SnIjCv3LQhNOJwi3JgNFGplUymJn9PTg/OMo18WFfw8F4JkEWkOZ4qiakMcE?=
 =?us-ascii?Q?jmssaZBmqKQRRxoGWb/tfn+5OPx6besMUOV34knkV64msdAwIi0CbYLYiJNl?=
 =?us-ascii?Q?ApSbIp2aXcsPT6F9oWHeqZ+B9FEOxJufyWVUQF2dz+spNZjkxr9ahZ8WSEGe?=
 =?us-ascii?Q?uXTiYPW87Stp5RMFsiZBJ3OUf01aSpAHyzk3mOU7ieT7knZ6A4lHe+5A7xqg?=
 =?us-ascii?Q?R5a+7KA7Tr1Vt1HTlpeNNyWrz8R3G+cOoaC4rtGNBWuOSVpwmUs3VVffAQ80?=
 =?us-ascii?Q?es2C84I90BQG+rRZ1AtEhAnGr5FOWF+lpu9puiiYNsiT5xyOnQVpgQA0Ai9Z?=
 =?us-ascii?Q?ZNqRUzB1D7xppGWG8YnFLAzDY8lZeFOjKvW1gPWnx2IkrM7u9rM9ZBvsWOQi?=
 =?us-ascii?Q?QeQh7JkfdVrfVEZD8KI6orhmJnX67EKIN8snqk6efFtsGpsOEsJPfiPMxX06?=
 =?us-ascii?Q?ZjQrnFGkgyRp5njMEi6aaCE9KkvlL0iKXNbdjv13uAm0spK5bGigsMH+2qy8?=
 =?us-ascii?Q?o79UWnckNE9mPUNZavsyWH/2cHGVe1k52Wvj4tVORY0GxVkMVYTazVRysmH0?=
 =?us-ascii?Q?kgFZ7B8lVmA8+vUVHYsNmPJs+bfmLvnLcv/GbYRzS9oZ+mxmLQ0l5rukT15P?=
 =?us-ascii?Q?2pmow4mQNncWpFk/MP3+lUQiD7Awrgi87N8RGlsAqwIN2O1VAaXJbAkUVJan?=
 =?us-ascii?Q?gcOad3S0QSYb4BgnA4w5nDPA/Lb9lNXH+jbvpFI6spGoEJmjkucb/rrHnhFI?=
 =?us-ascii?Q?NjIPkzAEWSJfbs+0Q1DEai6Re18QEftRCdsvFxBROBpew9G7OhCP1XAkfPTr?=
 =?us-ascii?Q?dDdYOjKiEOk+37IFrWpiraNVJPopqwdOnCb6F8gYOuAKGOddKJ/aWxxCZXI3?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ERGVZwqDsvlgB/MIw26acUhtYSRBkI3e83CAEL8zrOa0xQIoWbFRl5Q/drkNhZpvuRHCZ3+HphTEGb5Uhc7swhKA5ySDi7pBwcQrGlJnDEf9vtidO8ld/+s4E02h19E37pKHYeBqjobMPq9ZgROT3HwW1OAPOdWAdJBN0qtB+MEPlCggruS0O+24zx6T45kKJjN0L3Ha2XeCBIxrry0w2yCdFccsEWzlOHibctJmN+kLyIrn/uqxqgt9pgCE9QITahN1YnbL5fZTFpCioNf0bAxqfz9oYJSEj4ZRNKD1iTPZrtshhD+BBeu+xUaTBaznKa+7Asfvod9TdagAzgMO4FJ+BBYHfkDRjpMt2MvIsrItXoGAftjCt+u+IVCV4Zf9Om6U6ictnmuGNudVvN+R/CCUXDPqEMBZq0it3p8NkLMOmS8gF1WcT4r9fPm0I7rxjQjoc0ZfUhhTpI86SbhCRWSoyxSdVjVTUtaSEt5S7GR3TbcDuHJoBdudf6P6bABG/BjhNK0OcPrw5Xl9eZCPvBpWxjQkCRwTdA1tp/NIdIV6DNe2dg+Tf/2Bd6orhssSJN/qhMwFNKwKUw/BZT2ffb94tpTq1cjeJXsXvYMzKVc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e96557-a2fb-4181-b07e-08ddd011ea54
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 09:09:13.1221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5OUGlTFAfw7qZj6/CF0aVtaRGVCONogTdNvPnTB+Lp+0wRpgxWVhnZ4S/F2g0qce1eq8BVh/9wUXbuXI1R546BHDaGQZreTPmidKUhT9qGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4302
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507310063
X-Authority-Analysis: v=2.4 cv=COwqXQrD c=1 sm=1 tr=0 ts=688b32bd b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=IrAq7DpOE0TcJ6naTEAA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12071
X-Proofpoint-ORIG-GUID: QiexHVy_RtD7mvCGubKdY-4bowuYuzkp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA2MiBTYWx0ZWRfX39O+7+JrcZ9N
 R17Kr9xwFj48jQ2ABrkTI2Dx72sb6GdWX0le4iwEndwV6J4NjZxMG9D1KsZmMW9T++iDcmgNBer
 97WJnv4M4JBq0dcprQRzkrx5POo60D5YJTeW8AMnhLVQnvtpDjjmQ0KIMYwD0qs1Tzg781YGYeH
 Nlz53cSrQ520k/z8miQHEsyVXPDyNoP3vxVnI/tnB5/kctKps+JaehBHuUfEawQARDUZ9jFl/h1
 68vT4YdOmLEWRIOrqGScaEAPKLZJbb8xgCY9r4lNZ2BQRCjGBIzgOEDlZjK99VCHApJdaGLlQBo
 qXRX40rjJfMWEGpbxQ0VzPv24nqbXg2w6V5HwekgF/SJdEud5izhXckPNZz2/EltjZWR+5tZrY/
 X/MGub5Cp0WBxKogmsrXXaVhQAlsubkz2+V+enoAlqU4G8mCTog7AVcAhcm4PnO+Y9tIyjwm
X-Proofpoint-GUID: QiexHVy_RtD7mvCGubKdY-4bowuYuzkp

On Thu, Jul 31, 2025 at 10:38:49AM +0200, David Hildenbrand wrote:
> Thanks Lorenzo for the review, I'll leave handling all that to Usama from
> this point :)
>
> On 31.07.25 10:29, Lorenzo Stoakes wrote:
> > Just a ping on the man page stuff - you will do that right? :>)
> >
>
> I'm hoping that Usama can take over that part. If not, I'll handle it (had
> planned it for once it's in mm-stable / going upstream).
>
> [ ... ]

Thanks

>
> > > > > +/*
> > > > > + * Don't disable THPs when explicitly advised (e.g., MADV_HUGEPAGE /
> > > > > + * VM_HUGEPAGE).
> > > > > + */
> > > > > +# define PR_THP_DISABLE_EXCEPT_ADVISED	(1 << 1)
> > > >
> > > > NO space after # please.
> > > >
> > >
> > > I think this is following the file convention, the space is there in other flags
> > > all over this file. I dont like the space as well.
> >
> > Yeah yuck. It's not a big deal, but ideally I'd prefer us to be sane even
> > if the rest of the header is less so here.
>
> I'm afraid us doing something different here will not make prctl() any
> better as a whole, so let's keep it consistent in this questionable file.

Sure not a big deal.

>
> >
> > >
> > > > >   #define PR_GET_THP_DISABLE	42
> > > > >
> > > > >   /*
> > > > > diff --git a/kernel/sys.c b/kernel/sys.c
> > > > > index b153fb345ada..b87d0acaab0b 100644
> > > > > --- a/kernel/sys.c
> > > > > +++ b/kernel/sys.c
> > > > > @@ -2423,6 +2423,50 @@ static int prctl_get_auxv(void __user *addr, unsigned long len)
> > > > >   	return sizeof(mm->saved_auxv);
> > > > >   }
> > > > >
> > > > > +static int prctl_get_thp_disable(unsigned long arg2, unsigned long arg3,
> > > > > +				 unsigned long arg4, unsigned long arg5)
> > > > > +{
> > > > > +	unsigned long *mm_flags = &current->mm->flags;
> > > > > +
> > > > > +	if (arg2 || arg3 || arg4 || arg5)
> > > > > +		return -EINVAL;
> > > > > +
> > > >
> > > > Can we have a comment here about what we're doing below re: the return
> > > > value?
> > > >
> > >
> > > Do you mean add returning 1 for MMF_DISABLE_THP_COMPLETELY and 3 for MMF_DISABLE_THP_EXCEPT_ADVISED?
> >
> > Well more so something about we return essentially flags indicating what is
> > enabled or not, if bit 0 is set then it's disabled, if bit 1 is set then
> > it's that with the exception of VM_HUGEPAGE VMAs.
>
> We have that documented above the defines for flags etc. Maybe simply here:
>
> /* If disabled, we return "1 | flags", otherwise 0. */

Yup I know it was documented, but nice to have here as I'd definitely read this
code and think 'huh?'.

What you suggest is fine!

>
> --
> Cheers,
>
> David / dhildenb
>

Thanks, Lorenzo

