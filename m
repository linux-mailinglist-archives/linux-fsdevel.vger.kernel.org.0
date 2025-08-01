Return-Path: <linux-fsdevel+bounces-56503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C969FB17FF3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 12:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858B33A7E23
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 10:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E06123372C;
	Fri,  1 Aug 2025 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dT8noPon";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KEfs32jV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD0420E030;
	Fri,  1 Aug 2025 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754042996; cv=fail; b=DLnI5DXEQA7Xc+A8waNZj4NwVnfbqSHmv2wR3HzWd/jhKAXj5T8hNeX+wLV8OA+GtQwTYqgxQfZZqMBVfRL0zI2E10JLTWt3uQvUUiywngNRjFouAbsN6oQ1+RpAYzPAc37Rqtg76UNCtdcGgZaiJGoG0NObrne2xurhW02SjcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754042996; c=relaxed/simple;
	bh=Oa4XvKxRQSypAr9/yF3+hV4o5+id39UCCiWnf8/W+Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iWOhPgC8XMT4B8KQ8xLw5WCWmcOq+reTrNLWpivin0NGd/L4KPbKj7ywtTaEFjLaAUkazNx4kD+TKgVLYQUhO1rN3WHnatWViOy07MXhE5+ZABFu/jZTU4W2R/oWHyOHKhNu8xn/mZZhmM4bfwOmZokT/RzoeJa9IQbfDnW7Yuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dT8noPon; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KEfs32jV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5717C4mM005751;
	Fri, 1 Aug 2025 10:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=8rgHOsdtLw1cxmIl5a
	6mbCI2I4e4ewi5dvWtiIO6udM=; b=dT8noPonF+cCU4/Pq2fz+6bfn2muQRkgMB
	T4LlWK6nOjxL5Q+EPsmwVe4eWUTn63r3QkdTPg72l2hDA1RbEws4u0heGA3GtBYG
	j3U+qzFxKMaZz9qcTCtMnEelnMuKm/r1S1ge5TtO3Y95tzcyqWMqNGyQ+K4WM3Wz
	YQ6YQ1GHQuxRDFW390x3rRflB5S6CgHwiPoLM7HH0f44r6sWajT1/Hk8Q/NifkqW
	iiqh50cubuyJepMpv/kChR6Vr+Vs8mb360VpRWKb0XcDevlyQgLUFuCcg3ig/F/h
	hR5koN26Dj8NDsvzjLB8VT1kjMfLYvwYjV/BwJDXAiaCOo5YZedA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 487y2p2ufn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Aug 2025 10:08:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5719ELu8016723;
	Fri, 1 Aug 2025 10:08:57 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfkyhhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Aug 2025 10:08:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BbnFw4hgROEADqEbN/k3sJS4YErqe+OoKAHZZMVs/pivyBUi5uVDFzDRbq4lNOi/igXCly7syWHQPaDwwLctlrHLyFlA6AjJPcdKWcFVvHrEYsZ2lhFo0hyUwwdlWo1DPymteenN6KisWIUjUH5iCpC/6XljthyKqguObISGiUTbaCbGhgFbEMo98/ARdD7WBHe6zbMuJiCd+Z8he+UHbEwiP20CNQmAqUWBiglPMke0DU1aHUWRnknvlSF+zIL3UnJAiN3u57e1Qqaf1MsrfYIX4NXiKA7JDmzHzTqk2O60b3Ts94YF7sGXg3jBiXGA/Lm3OCsn6nFe+3mLBUWaLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rgHOsdtLw1cxmIl5a6mbCI2I4e4ewi5dvWtiIO6udM=;
 b=YR2cGOY1gWLp66rZN1usMcBtFUS2AErg8jkMcjfnB9tc/oA4K08Qjcru5roJDr6hbSha+kVPSyjKRd9XvAXI/jklqk3/82FfgGvuRC+w2cTYoXLWz65UPQuSPlQSl82yHcLIC59ZWcfL2FQDmjH1g0ljPkEd3DPaNJw6inQU8JJMXsO4eeP5vMdLJE26osYY2Re//FDt/Q5XrrbXU7ciIgFuItNiZZ0j3zcY2T/wbAwvmU3yUvTHhbzagVPdAcHtY7roLVl0KmppvskM22lSkVoZAESYpDhL6I1/N6F+vbVABcdUya64wM/xcYDEubRN9VIJqsmlgVijWNhxbL+inw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rgHOsdtLw1cxmIl5a6mbCI2I4e4ewi5dvWtiIO6udM=;
 b=KEfs32jV3S5EKmfPcAXt5g63fuRMXnTpvnOu+y+l+N2fII3nk+0fCJ8YyhF1+Myw8MSCsEXywnpMexs8FHb5/vXYCh33FVyMd/g8dVFxTP7i+e/MkiXIfCxNnlL6xbopYploLq2nXd1RdBj3eSYvyq9Ph4J52h0oXrXlCO/8jfA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH3PPF7B51A0F8B.namprd10.prod.outlook.com (2603:10b6:518:1::7ad) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Fri, 1 Aug
 2025 10:08:50 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.013; Fri, 1 Aug 2025
 10:08:50 +0000
Date: Fri, 1 Aug 2025 11:08:47 +0100
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
        kernel-team@meta.com
Subject: Re: [PATCH v2 2/5] mm/huge_memory: convert "tva_flags" to "enum
 tva_type" for thp_vma_allowable_order*()
Message-ID: <f76da1e5-ab70-4765-a8a4-01a84ae49c3e@lucifer.local>
References: <20250731122825.2102184-1-usamaarif642@gmail.com>
 <20250731122825.2102184-3-usamaarif642@gmail.com>
 <c44cb864-3b36-4aa2-8040-60c97bfdc28e@lucifer.local>
 <09acd558-19b9-4964-823b-502b9044f954@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09acd558-19b9-4964-823b-502b9044f954@redhat.com>
X-ClientProxiedBy: MM0P280CA0078.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH3PPF7B51A0F8B:EE_
X-MS-Office365-Filtering-Correlation-Id: a18ef8c2-e1e6-44af-0241-08ddd0e36978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?39r1m8Fa+bn4w00UGlv96HMlCHy2HPDC8EK9cxB0dqzFDLN62U0H0+F5nEUb?=
 =?us-ascii?Q?DKCa674+xIhBgWkj47Nrw+Re1oMrmfv9k0m3HOH2JpiGoBuqdALnxTqagpo2?=
 =?us-ascii?Q?hbg1O0GcR1SlXzngD0NRWhDPL0odMwdrif+ahJxiyrLk7awaDKU/xMeiZU6P?=
 =?us-ascii?Q?DNqmBEg1HNnRpAduMjyPJYUpd1TEN9OXRFdSLBYsV9dSsRRZpA+35me3XV25?=
 =?us-ascii?Q?ndb0jfBYD/fv3tIICGAW/cB7zejbvbQ5aYoxp13kdEzHRNHpN8VSgEZg7ciA?=
 =?us-ascii?Q?ie0pwSDac8VFKlKxl7fvhmsgGutwt5Sdkr9I+nZzlHQVbKBvSL6JjBbtfe+G?=
 =?us-ascii?Q?5M0fH6MHIVd4fUAeRSWKgdUxii2fCr5LofOKs97zlgwhIb+AL5SLkgA8zCKK?=
 =?us-ascii?Q?wPwejEVqjwIH4KBY4ruTwQP+oUelfskW/ORQ8NTWyZcbSWoKwlnCqH2vRCkL?=
 =?us-ascii?Q?yfcpT5nmRXxQKM0iQNSDFST3mfHTRRU8Xbf25uVUtCXio8Yi/VvPROCkqnST?=
 =?us-ascii?Q?yCHy1zREvKgwYb2hu0DfCIztvzWASNp+e6QX0SW1vNEISFxk+aO1M0Hi67+c?=
 =?us-ascii?Q?CBhE0urb5DCh3zM0NPlE/NfM9xfL18JF1Ugp2fs31LZ7Hor8twz/eb0CktL9?=
 =?us-ascii?Q?RMIPuXj8wZ2Sn67fRHP2h/YYh21UeTdGrbO+v9wI1cKj0gQHjQR5wBWPyWy+?=
 =?us-ascii?Q?Ouungho5YY7kON6GO+JNhty8yQydZk6jWIrbwNE5tOe7i39W5e2xP6bnb0Ha?=
 =?us-ascii?Q?9b7S6fv1EatwzyvFWfShZLbkwAdhed1ZpwnzAL/ZGmlu6YSiQ1Fb9mWR0Le1?=
 =?us-ascii?Q?nlCTg4B/+IM4d0eDFXQ4U+f0fsdv8yUkOkcyYqHCIEQ/jfxb5tSbcqSDrxFt?=
 =?us-ascii?Q?G6UqQOi7MT1X4zN8q3vU0/A8bZidJRHTIDX2+87XMugCyQG8dL9bowh3LE7s?=
 =?us-ascii?Q?43fycbCsYvpkk+a+NeOpMmvQ2tRHf5IrwV1vehAnn+hMDUPjbUrbF/lPaeZ6?=
 =?us-ascii?Q?yddNwFQjtu3SQR/qXrUvQ7k2ViB6X8pfOEkqRQW6EgmiytLIuHaq4s1xM6gk?=
 =?us-ascii?Q?3JuayiL5QpjRd8WoxdzhFP3C6Q1QaynzmhPQd/+yZ80mpmAXrrX4B6fHyU+n?=
 =?us-ascii?Q?Hp5iV+R/6QYoaAdNDnT3PTsc+qvWSEiPiKeZs1s3Zho1EpGrjuiv2UsHEdhy?=
 =?us-ascii?Q?i/aigRxqvnsfLLAzTbPY5liwdgQL+YhM1S273Nc2/qMtJEXnxNeo6RONNcmq?=
 =?us-ascii?Q?NvaLZPnH1u166a81VcKK7jw8NqOXDvw/STA6Oh6Y+0Sp/H01AeaE+hb2WX3f?=
 =?us-ascii?Q?8/ra4TJA2Ec53h3KHZ63VkxwLpYorJ1BD1Hvv/WZL6gA5she3/Iuj1DTlJQS?=
 =?us-ascii?Q?qvWwkELQadBpIUo/vPx57IKgci0/Wfoy/r/Pb7aXUk+/0M4p/mkqNCbQswY3?=
 =?us-ascii?Q?hZHXtbngGLU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H+/ElxqcxDLef/lPhpMnHUgAWR2w1KaT1FIE/6oXHGU071NnDggOREzGJcVj?=
 =?us-ascii?Q?7/fpyB3RsV9PRpPqrqu0O42H7sgjWQ6W35QcxEFFLb7tA+mnLr/os8Brw4gg?=
 =?us-ascii?Q?mbE+uTIYl80tfxBl76ByzePSmKYCp5d9GozEM4hdeXABrEHpJBe8Geh9A/lf?=
 =?us-ascii?Q?V9K1ZCNUsFlfotoPizbgr/zu+FoNlD4d+p+kWZfEZCCCHeDm2QAiPtrsFInb?=
 =?us-ascii?Q?KsyJcoTgX7Db4xR7+ZWhpMqv5/Cs5nluOTX8bvZArdY2PGgt0/bfk+G4h0sY?=
 =?us-ascii?Q?yFcl9fknYBgTbidE+T3WW63NmJeK6JKmt0EnKGuuL6OmpIvpsh0WFB2QPihQ?=
 =?us-ascii?Q?w73yidPh58m4kjtfI1yDQuYuFDTvBkndc8PlaRCmIodGohDBmLeMP+MNNrPQ?=
 =?us-ascii?Q?Y3DZS0wEsotKq3bZaiH0CfIfxWxlYEgUGlabVEXtnanRFZJ1YQZ9zlNB+MrE?=
 =?us-ascii?Q?eqdDnX1yL3WfnwUJoKc5MBrHA+SMKW29k2JUE1pu1i0JZnxDJSWWUC4pDtRW?=
 =?us-ascii?Q?L7siK5+3uic+HS3gmtxFl45oZoycrw2vii9p1q3v7/78HNUqcjIQ0HNmfjOG?=
 =?us-ascii?Q?wbf2yOVBZJc1nK0v2ex8aE6KY9ijUzX+x7SqROnrgJaAWAvsuYtnFcisnVYD?=
 =?us-ascii?Q?PMnCEeHO7aOwR3rI8C30QCLojTERl7w8JC3JXOOo4HyfAIwJMsVxpimSk52c?=
 =?us-ascii?Q?KZKuTIcUZFNpjInUMJzvUugHajKWoDmRyChGxB0eYwUy9k92GYBDbS5zyXcw?=
 =?us-ascii?Q?iRSDuZ0zY4kStfDTw/nAD2wY6n3mf8evUG8BtYSw928PoWo0s77O8sn3W9CK?=
 =?us-ascii?Q?G1LYZvxqsw0v9RJsmRJvCEk8gTZY73aDcokYJSkHo8H1ayy43NUPE5OzjDmC?=
 =?us-ascii?Q?aZBq6XhDO8AvPQ7HQOLlb5q61uiZhd45UARBy6+f0klhcU+hT371ABNiC7Lk?=
 =?us-ascii?Q?OiST92io1ij34vsA3mt/DpNHtyrA1qMq+bB39YFpJoBukz0j38k3QFneHC4x?=
 =?us-ascii?Q?dj+04yTQ2cmtoQJHK4iWZqbBqNhdJjP2NOHiZCVxpRZDKnfTir+JG62leTwy?=
 =?us-ascii?Q?Picxb/bGrVGSCZJjCaB9MmURJTmOnmKXMc9Xab/348Cv52SAcWvWPSeWOnM/?=
 =?us-ascii?Q?ONCGa4+gIBjr2nxHn+tlXYGRzW6sOcN0lCu4HvywH5l19OI9AvedH7H+Tdd9?=
 =?us-ascii?Q?4Yjc26NpuKqFw+Sim6jlDD4X4xhwVkI/4KMHkKV5HOqeDD0FyLm05fujj1uf?=
 =?us-ascii?Q?PtTdWVGd6hu9Si6UW8vzKR6zL9tJHFuxih6gj7OjyYpJF4KQQS2OOA2HPiL6?=
 =?us-ascii?Q?EL72diiQZObSN8SJIHpfxi8TF0MxEoAuSSF1H/IES4LWMrWAi/bUbDJU8Jzb?=
 =?us-ascii?Q?zNafZ5VDWSbX7BbSdkGQPSJiv9nennZ+dbnr4Ht8kp8h/3gQHhypBAASh/Jx?=
 =?us-ascii?Q?9sxY5otDFdVDAaxp1alszt1xmXh6QbAGl0p82fkfmWhjPC9gQWspo3Uc7BFI?=
 =?us-ascii?Q?VQvQ2QTmqwg6ffPqnIe7i5c6zfD5OZGkAKVLFBGoCUMYrIH3BZ4exggZQutg?=
 =?us-ascii?Q?MaJuP+a9wDBa78oKJU9Xg7rg4Npid6Yk5EJZq51wTelvIHw09eksUccxaTbz?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O/3cuLgYiqhGLSSAdOKnHiIwLqzbHVDQCa7um26cugfGb9TB66xNWHtqO5QZJzUyqRCdUAapFVZmv/huvtP59YBHJwVj0NcJRI/XisFzq7ZOTtU7rGCbyGkjDrDSV1ldNaBaSa0huUQeNNmg8PkFQdTigPotVpqRNp+/aA7RLfu4O+JsixgCsVoXFkbRfHcITnE8NqVXd49GmKg+J1ELH98dSNQSCy0M+Cwo0QP1MzFdw2OV7zgTKWtIb+Inrz6E2FaSVWtBeLYQFL+7dmRbjjdNWfC6XvTDl5vgJzTRzhVFOqX1POxKSBrs7hejMZ6140C8OxKsBAk6ZFH99NdySFotHcbCNxD7ahEPLQglABCFR5d4Tw7Q98gTe68epCr1KbLqJxbBjrsMyaD3xg/DIjkX8TP8oYinrSxsSwVtfRsShQDaA8wdz3dfnALJkc5KttHo1UvBFfjLklebcYl1GouMoAc2tVi6lyi1wojEaK0q2w9raC0b1dgiLkYvXmltUV93vPabDv9HYd/FhR4Pbys7tyKUfDjVl0LmlTQChoPYyolfLIiqpnj5ruJYAcsaCzZ9v9+OUy1x51n0UhZvqakdMzzsNjBG+Bj1cmznYU8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a18ef8c2-e1e6-44af-0241-08ddd0e36978
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 10:08:50.4268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: quKht0srogYz0Ti1VI40uoyHZARTEUhdVGceFUNDIf2ZE6xgcEu/RI74bLe2nSsOILW7ZM7ZIJTh0VBdWPCZ1YhsAzNXUjArm3qf92jhEoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF7B51A0F8B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508010075
X-Authority-Analysis: v=2.4 cv=COwqXQrD c=1 sm=1 tr=0 ts=688c923a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8
 a=KZZk3aPqlL5hFo5lmooA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12070
X-Proofpoint-ORIG-GUID: SbhfKKl7yCjP31l0wVklg4OJDbsjfjBc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA3NCBTYWx0ZWRfXz71/7EoEEIfW
 TtuhmMHqr4oHF0Aua+Jeu4Y5u7nhnR5n8DfsIxo/t5CqHg7uRzfVHXDNUqAZIUY/d583oymmNjB
 yOXkfGRl87geW3kunqnZ6KxA2oVbLmCF8d70BBygko3QxFgwJiPv131Ezgq1/Oeh2eqYl1M1AXa
 kfrliqR98ZaSGtgY0b9DmpG7V/pFY4GhlUiYsXwWUA46TozCRSIgjrdP5mNtmhtXwZsld17uY5F
 o1/9Ke+XxzXEs38Pq33uB3KzQDSrdExHJXpyVyKE1bxfQyd5SUJo1Yt4naMkpLBqgKSICZ/Djun
 tHSl4GaUs76uagNREBKwsEM6QilN7/dUo54I/Nq2UvmW3sCad33jY6tKBl/Yr1pFLhz/y2JJ1zS
 yel3A9V50iv7dYrQXWf2c/Kd265301KQ/17JnGRZUp7nMs0U1zSPhnSW9kl45bKuHZiB5ct4
X-Proofpoint-GUID: SbhfKKl7yCjP31l0wVklg4OJDbsjfjBc

On Thu, Jul 31, 2025 at 06:15:35PM +0200, David Hildenbrand wrote:
> On 31.07.25 16:00, Lorenzo Stoakes wrote:
> > On Thu, Jul 31, 2025 at 01:27:19PM +0100, Usama Arif wrote:
> > > From: David Hildenbrand <david@redhat.com>
> > >
> > > Describing the context through a type is much clearer, and good enough
> > > for our case.
>
> Just for the other patch, I'll let Usama take it from here, just a bunch of
> comments.

Ack!

>
> >
> > This is pretty bare bones. What context, what type? Under what
> > circumstances?
> >
> > This also is missing detail on the key difference here - that actually it
> > turns out we _don't_ need these to be flags, rather we can have _distinct_
> > modes which are clearer.
> >
> > I'd say something like:
> >
> > 	when determining which THP orders are eligiible for a VMA mapping,
> > 	we have previously specified tva_flags, however it turns out it is
> > 	really not necessary to treat these as flags.
> >
> > 	Rather, we distinguish between distinct modes.
> >
> > 	The only case where we previously combined flags was with
> > 	TVA_ENFORCE_SYSFS, but we can avoid this by observing that this is
> > 	the default, except for MADV_COLLAPSE or an edge cases in
> > 	collapse_pte_mapped_thp() and hugepage_vma_revalidate(), and adding
> > 	a mode specifically for this case - TVA_FORCED_COLLAPSE.
> >
> > 	... stuff about the different modes...
> >
> > >
> > > We have:
> > > * smaps handling for showing "THPeligible"
> > > * Pagefault handling
> > > * khugepaged handling
> > > * Forced collapse handling: primarily MADV_COLLAPSE, but one other odd case
> >
> > Can we actually state what this case is? I mean I guess a handwave in the
> > form of 'an edge case in collapse_pte_mapped_thp()' will do also.
>
> Yeah, something like that. I think we also call it when we previously
> checked that there is a THP and that we might be allowed to collapse. E.g.,
> collapse_pte_mapped_thp() is also called from khugepaged code where we
> already checked the allowed order.

See below...

>
> >
> > Hmm actually we do weird stuff with this so maybe just handwave.
> >
> > Like uprobes calls collapse_pte_mapped_thp()... :/ I'm not sure this 'If we
> > are here, we've succeeded in replacing all the native pages in the page
> > cache with a single hugepage.' comment is even correct.
>
> I think in all these cases we already have a THP and want to force that
> collapse in the page table.

...Yeah, I remember looking at this before and thinking 'it makes sense to force it
here'.

But since we have some sort of random edge cases here probably best to hand wave
'and a few other places' or sth (I see Usama has proposed a commit msg, will
look shortly of course ::)

>
> [...]
>
> > >
> > > Really, we want to ignore sysfs only when we are forcing a collapse
> > > through MADV_COLLAPSE, otherwise we want to enforce.
> >
> > I'd say 'ignoring this edge case, ...'
> >
> > I think the clearest thing might be to literally list the before/after
> > like:
> >
> > * TVA_SMAPS | TVA_ENFORCE_SYSFS -> TVA_SMAPS
> > * TVA_IN_PF | TVA_ENFORCE_SYSFS -> TVA_PAGEFAULT
> > * TVA_ENFORCE_SYSFS             -> TVA_KHUGEPAGED
> > * 0                             -> TVA_FORCED_COLLAPSE
> >
>
> That makes sense.

Thanks!

>
> > >
> > > With this change, we immediately know if we are in the forced collapse
> > > case, which will be valuable next.
> > >
> > > Signed-off-by: David Hildenbrand <david@redhat.com>
> > > Acked-by: Usama Arif <usamaarif642@gmail.com>
> > > Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> >
> > Overall this is a great cleanup, some various nits however.
> >
> > > ---
> > >   fs/proc/task_mmu.c      |  4 ++--
> > >   include/linux/huge_mm.h | 30 ++++++++++++++++++------------
> > >   mm/huge_memory.c        |  8 ++++----
> > >   mm/khugepaged.c         | 18 +++++++++---------
> > >   mm/memory.c             | 14 ++++++--------
> > >   5 files changed, 39 insertions(+), 35 deletions(-)
> > >
> > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > index 3d6d8a9f13fc..d440df7b3d59 100644
> > > --- a/fs/proc/task_mmu.c
> > > +++ b/fs/proc/task_mmu.c
> > > @@ -1293,8 +1293,8 @@ static int show_smap(struct seq_file *m, void *v)
> > >   	__show_smap(m, &mss, false);
> > >
> > >   	seq_printf(m, "THPeligible:    %8u\n",
> > > -		   !!thp_vma_allowable_orders(vma, vma->vm_flags,
> > > -			   TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_ALL));
> > > +		   !!thp_vma_allowable_orders(vma, vma->vm_flags, TVA_SMAPS,
> > > +					      THP_ORDERS_ALL));
> >
> > This !! is so gross, wonder if we could have a bool wrapper. But not a big
> > deal.
> >
> > I also sort of _hate_ the smaps flag anyway, invoking this 'allowable
> > orders' thing just for smaps reporting with maybe some minor delta is just
> > odd.
> >
> > Something like `bool vma_has_thp_allowed_orders(struct vm_area_struct
> > *vma);` would be nicer.
> >
> > Anyway thoughts for another time... :)
>
> Yeah, that's not the only nasty bit here ... :)

Indeed, sometimes I get distracted by this... but we'll fix it over time!

>
> >
> > >
> > >   	if (arch_pkeys_enabled())
> > >   		seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
> > > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > > index 71db243a002e..b0ff54eee81c 100644
> > > --- a/include/linux/huge_mm.h
> > > +++ b/include/linux/huge_mm.h
> > > @@ -94,12 +94,15 @@ extern struct kobj_attribute thpsize_shmem_enabled_attr;
> > >   #define THP_ORDERS_ALL	\
> > >   	(THP_ORDERS_ALL_ANON | THP_ORDERS_ALL_SPECIAL | THP_ORDERS_ALL_FILE_DEFAULT)
> > >
> > > -#define TVA_SMAPS		(1 << 0)	/* Will be used for procfs */
> >
> > Dumb question, but what does 'TVA' stand for? :P
>
> Whoever came up with that probably used the function name where this is
> passed in
>
> thp_vma_allowable_orders()

Ahhh ok that makes sense, thanks!

'THP VMA Allowable' is kind of funny, like an abbreviation that abbreviates 2
abbreviations :P

>
> >
> > > -#define TVA_IN_PF		(1 << 1)	/* Page fault handler */
> > > -#define TVA_ENFORCE_SYSFS	(1 << 2)	/* Obey sysfs configuration */
> > > +enum tva_type {
> > > +	TVA_SMAPS,		/* Exposing "THPeligible:" in smaps. */
> >
> > How I hate this flag (just an observation...)
> >
> > > +	TVA_PAGEFAULT,		/* Serving a page fault. */
> > > +	TVA_KHUGEPAGED,		/* Khugepaged collapse. */
> >
> > This is equivalent to the TVA_ENFORCE_SYSFS case before, sort of a default
> > I guess, but actually quite nice to add the context that it's sourced from
> > khugepaged - I assume this will always be the case when specified?
> >
> > > +	TVA_FORCED_COLLAPSE,	/* Forced collapse (i.e., MADV_COLLAPSE). */
> >
> > Would put 'e.g.' here, then that allows 'space' for the edge case...
>
> Makes sense.

Thanks!

>
> >
> > > +};
> > >
> > > -#define thp_vma_allowable_order(vma, vm_flags, tva_flags, order) \
> > > -	(!!thp_vma_allowable_orders(vma, vm_flags, tva_flags, BIT(order)))
> > > +#define thp_vma_allowable_order(vma, vm_flags, type, order) \
> > > +	(!!thp_vma_allowable_orders(vma, vm_flags, type, BIT(order)))
> >
> > Nit, but maybe worth keeping tva_ prefix - tva_type - here just so it's
> > clear what type it refers to.
> >
> > But not end of the world.
> >
> > Same comment goes for param names below etc.
>
> No strong opinion, but I prefer to drop the prefix when it can be deduced
> from the type and we are inside of the very function that essentially
> defines these types (tva prefix is implicit, no other type applies).
>
> These should probably just be inline functions at some point with proper
> types and doc (separate patch uin the future, of course).

Yeah I mean this is the most petty of petty comments. Just as long as it's
consistent it's ok.

Slightly an aside, but I'm motivated by previous case of passing around VMA
flags as a 'flags' parameter, when in some functions you also have mmap flags
and it suddenly becomes painful to know which is which.

Probably here, given limited scope it's not really likely to be an issue.

>
> [...]
>
> > > +++ b/mm/khugepaged.c
> > > @@ -474,8 +474,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
> > >   {
> > >   	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
> > >   	    hugepage_pmd_enabled()) {
> > > -		if (thp_vma_allowable_order(vma, vm_flags, TVA_ENFORCE_SYSFS,
> > > -					    PMD_ORDER))
> > > +		if (thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED, PMD_ORDER))
> > >   			__khugepaged_enter(vma->vm_mm);
> > >   	}
> > >   }
> > > @@ -921,7 +920,8 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
> > >   				   struct collapse_control *cc)
> > >   {
> > >   	struct vm_area_struct *vma;
> > > -	unsigned long tva_flags = cc->is_khugepaged ? TVA_ENFORCE_SYSFS : 0;
> > > +	enum tva_type tva_type = cc->is_khugepaged ? TVA_KHUGEPAGED :
> > > +				 TVA_FORCED_COLLAPSE;
> >
> > This is great, this is so much clearer.
> >
> > A nit though, I mean I come back to my 'type' vs 'tva_type' nit above, this
> > is inconsistent, so we should choose one approach and stick with it.
>
> This is outside of the function, so I would prefer to keep it here, but no
> stong opinion.

I'd rather we be consistent, but this isn't a huge big deal, obviously.

>
> >
> > >
> > >   	if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
> > >   		return SCAN_ANY_PROCESS;
> > > @@ -932,7 +932,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
> > >
> > >   	if (!thp_vma_suitable_order(vma, address, PMD_ORDER))
> > >   		return SCAN_ADDRESS_RANGE;
> > > -	if (!thp_vma_allowable_order(vma, vma->vm_flags, tva_flags, PMD_ORDER))
> > > +	if (!thp_vma_allowable_order(vma, vma->vm_flags, tva_type, PMD_ORDER))
> > >   		return SCAN_VMA_CHECK;
> > >   	/*
> > >   	 * Anon VMA expected, the address may be unmapped then
> > > @@ -1532,9 +1532,10 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
> > >   	 * in the page cache with a single hugepage. If a mm were to fault-in
> > >   	 * this memory (mapped by a suitably aligned VMA), we'd get the hugepage
> > >   	 * and map it by a PMD, regardless of sysfs THP settings. As such, let's
> > > -	 * analogously elide sysfs THP settings here.
> > > +	 * analogously elide sysfs THP settings here and pretend we are
> > > +	 * collapsing.
> >
> > I think saying pretending here is potentially confusing, maybe worth saying
> > 'force collapse'?
>
> Makes sense.

Thanks!

>
> --
> Cheers,
>
> David / dhildenb
>

