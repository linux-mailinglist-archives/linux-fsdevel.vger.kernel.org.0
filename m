Return-Path: <linux-fsdevel+bounces-47147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F58A99CE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 02:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3990462517
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 00:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4BD4315C;
	Thu, 24 Apr 2025 00:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JbxbZfcn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R31fRB0s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A21D1A29A;
	Thu, 24 Apr 2025 00:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745454275; cv=fail; b=TN/H8dvoJSeIii7+E4914knMXwPQsrr4RsUlEDNdJ0uyuRsHBs4l34/DUElOVMSEuz3wzhd4ufcsGzB3RaxeQ7j86Q1taxf0YCmut3n4x9jp3wKvGZeBeMyEBnqOz3UFvgH8B3q/enJsb8YD0OXpnliAvuQ+Q+SZHWrAht9C2yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745454275; c=relaxed/simple;
	bh=VkRJFsDvnZqff2oh2riO6147nEDESR4AaOj+nrIEnys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VUdKcyneNRPgPRMg6ovtyMzTgd66nOd/H4rpNlAlsSV7Jk3XK2c1lHoQ/Tn24vcqYFQvKWpILMjIj4aDjXZ9jQ7OuEuPQ1tN28s/0o3qrFBy/52AoqhQII2qH4KRdZiq84PWRdGGxzQPDC/IrR7pI3NRw8l/jmgPii656M1EED8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JbxbZfcn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R31fRB0s; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NLMraT019197;
	Thu, 24 Apr 2025 00:24:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=qVmfQyVnPJX0i2iHkdBa7d4SREKrnD+chR0+scm+gpk=; b=
	JbxbZfcnmAi4RWumzYIDWZS1KsaCB7gkEgGm7piFobzMuNkSaZDBhEaDEpmPXlN+
	PhmIPBNdVPanXqmzGlAS97Ry9MpV2HpxF2m4u8XBXko2d6awKNh/UChXAnEuZ1hJ
	azgIWjghpunv6bEmS7qQXGmovSaj7AT3ukezz9n/Hfc9PBx/7Lflei2TF3yzAZxL
	UEn8I2cwF66wRB78ikNbyivzI0bOEzkmldHjsI3vxO8gab5yqZCR0YSpk/rDKq9a
	5qL8F0CyFfRG7WeI+LeyMylZW0Yydn+sahp1bXIO0pAGPO0AmEBcWh0K38CKwXvu
	cRj6izJyLBZm3w2jKk08DQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jhe2hpq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 00:24:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53O0KrCK025135;
	Thu, 24 Apr 2025 00:24:02 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jbrd4pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 00:24:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BD8m38TK+AUI2MV2GPu6obVpoU+k03VCOP5QIERfvBgfbjOE9Agt57x7XR/BxoXnDEd6FzlIftVjZgrQoJFzTOGQfGcIsZ1cbCnXaluomQbP5ooR+/hrV6HLe6r3Iq6UEWcWNVnZGBtaCx6SpzBzXKKrWESwj8Yg04P7vRqYryYiXqqpKTmluFo0ghbMEbjQ3eUfGyniHGHJ5qkzy127Nxszvcg85R9QvEI+afiMar8gAtw0tmc0vEXuYOJMIDwu76d1xuH4IH0ayfLSlR3zeNiLX42CNvxneyddyrK8Kaib3X65ipg6ifGgLecRmsY/b+bGMDFvss8G/f6efB/YbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVmfQyVnPJX0i2iHkdBa7d4SREKrnD+chR0+scm+gpk=;
 b=wb2tEeecEpRuj+6t9r9QMTjH7ZaL9fj8qEt5VWf0sCeGbX9QxzLsBVJrq0cAE3xktHHznT4E5NRUpdr/6hEkMMgjL/7bgKg0+OETk9jY7R4mgK7DvpnGmIxpB1X+X3ZBVOoQHsUGjvWH89z1GcMMdG+w61Ag7dLzxISj5WAumKMk0vcr+pFdVEJ8LBDokhafbZo6jVL86ui5Y+ZhKKICmzLjoebgAI0g9klmIxy9DEIhU5otukLI/KLmD+b5DaUvR20ZnngMQfsE5o56GQ+sClu5yNpf0+5C6j4Zbd7S8xfW8lWoyDfDXN1GJaUK3ByjJLx12Q1GXcRv+2JIL2QV+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVmfQyVnPJX0i2iHkdBa7d4SREKrnD+chR0+scm+gpk=;
 b=R31fRB0s5K8s6fGtbaU3hrfxmtBkGYBBSLpEWVB3LqbyIpPnqeYQN+Id0Uy63CpJZdNbakvanbHt3987l2jX90qFDqNO8EmM11EFvLLo4d4M4mQ1N/0yGlll6gRhmd45PgsqVg7SwPKvz/ZS7StIYxrZP49S6km7E0dIq6XtBkE=
Received: from MW5PR10MB5764.namprd10.prod.outlook.com (2603:10b6:303:190::15)
 by DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 00:23:59 +0000
Received: from MW5PR10MB5764.namprd10.prod.outlook.com
 ([fe80::8d9b:9200:a7f5:19a9]) by MW5PR10MB5764.namprd10.prod.outlook.com
 ([fe80::8d9b:9200:a7f5:19a9%7]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 00:23:59 +0000
Date: Wed, 23 Apr 2025 20:23:54 -0400
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
Message-ID: <6ay37xorr35nw4ljtptnfqchuaozu73ffvjpmwopat42n4t6vr@qnr6xvralx2o>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAEf4BzYctDuS4DRTzdRQyyhCYvFTggOz=wcbizXEYvC_z_SSng@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0205.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::27) To MW5PR10MB5764.namprd10.prod.outlook.com
 (2603:10b6:303:190::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5764:EE_|DM6PR10MB4363:EE_
X-MS-Office365-Filtering-Correlation-Id: f4f296c3-3882-4cf2-d822-08dd82c64ed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjNyNEYzSXVzb0NPeE5oRmt4QVVjdkxZU2I0MlhQSFdCN1dyM3dVbG1VUGVx?=
 =?utf-8?B?SHFyMjRSWGJBa0k0MW9wejZibnE3OXgra3RVMkZXVGM5bGtELytGQXJ5WERp?=
 =?utf-8?B?WG9XaElKSTN1QXQzMmlvYUVPaHVRZ0tORVRudFdmaEpidEVrelFqUUVKUFU3?=
 =?utf-8?B?SGl0b292blR5RVh4NUdJU2FYSGlRcjJVVWtVek1hUGpPUXBNTzY4ZnZDb05u?=
 =?utf-8?B?b2RVdG41aDFYQnpycklzUXV1eUpHaWJJK2R0elJtdCtObnhwbDBiMFhpUnNU?=
 =?utf-8?B?ci85eW8xdjhTalJOV0x2d2k5ejNvd1BNbDhUaXhWbCtJOXZPK0Q5aUEzakI1?=
 =?utf-8?B?WDFyUVFhUzJPV3E4UHZtUXRzT2IxOG5FSGZjbE52eUxuL3VjT1ZTT0N5Tzl3?=
 =?utf-8?B?TVo4OHNQN1MzYnAwekxlamEyNld0dHRqWjhpMnFQbmt2VVRUTXUrVVhnc2da?=
 =?utf-8?B?dWJtd0ExTHlGN3RkU1pQbnN3VE5uMUFlRXVPY3pyU2ZtZkJLNTRXS1hEL1p2?=
 =?utf-8?B?WStkOXZLL2VQMkJGdENjRWtGb2RHbjVjT29qQlpXMVlwMWY4d09pQWxyZnBu?=
 =?utf-8?B?bXdVTDFKTXdBSE1ib2dIeWZGN3VRcXJzbFZrTW9aQnpGS2JnWVY2YXFVYnBa?=
 =?utf-8?B?WkNLOEJlWk13N1M0Sk5aZW1JelZkTFhhOCtjY05FU2c1VGV0Yk9qQ202WFlp?=
 =?utf-8?B?c1pIQWNrMlFLTWV4dllMRXFURktjRU9DZ0gydjg1MVQ3QTd4T2N0RUxNbkpm?=
 =?utf-8?B?NFlUT2NvYWFwOWpzRFBHRzNKZjVIdlhqSmZDenZYUnNOM3VEWjF0ZzZzS3BX?=
 =?utf-8?B?QldmRWpKT0VJYzRDanlBU21IOXJteXVseUZKQy90U1hZWmRvNlRramNCRDcw?=
 =?utf-8?B?cC9TdGhSRE5OcVllZVlJNWFIcXcyMHh4L2ZZU3pBQ1JtNXFxSEhaM1I4RWVm?=
 =?utf-8?B?dU5oditJTktOdEt0cE5KNVJBT1M1Wm9qMzNNbVVsemNZWWduSGgyM2ZVWTJu?=
 =?utf-8?B?WWVRYjJEQ0t0TWN3N0hPUmZGK0xkby9CMWF5ZUZwMmNTZzJkTTNwYXRhUUVR?=
 =?utf-8?B?YVZvUXBsNE5QdWtCQ0xYTVUwWG1NSTZMVndLZldzdXl3NSt0c3Q5ZW40MVpI?=
 =?utf-8?B?bVN4SUowVGZUbUJBVzhNTG8zSFN1ZlVaTkZYeklCSmlMaDF1K0taZUZ6dHU3?=
 =?utf-8?B?QUdMYXZBV0ZVdVBsQVhjNTIrNDNlQm5SUUlzeHEwVlU5Qm1RdER6NWhzYUZM?=
 =?utf-8?B?N3RZNFo0N3NCTlg4VXVEY3Vxd0t0QmUvaG5vSGJ3ekRpenBKQ2Y0OWliM2lH?=
 =?utf-8?B?Nk5kN0VJYTFGdFhXNUQ2RXBGaGhnYjcwOUUvOFQ5TnFaU1lRWm11N0NtRnNp?=
 =?utf-8?B?dXI5RVdtSkdUTnB4akVWbWp4V21KbndYUVhFZ0hZczJmdUJZVEI2OVdMUThC?=
 =?utf-8?B?dlNoY2NxV1Q4MFNYUXh6SWNOd2piQ3RHM0p4QS9zQnN0ZWhqWDlaa2Y1dVdq?=
 =?utf-8?B?ODQzNmU5MGRzMHN2c0czSU8zL2N6VGZ5RkIvYk5pcGhXOUs0elFYWWVyVjJN?=
 =?utf-8?B?bWZKU2FKUW51WDFXTksrdWMvV1JoOE1LR2ZtRks2TVpIUFpxZHRxQ0dMcjR1?=
 =?utf-8?B?b1QzOUNtMFhxVzZyKzhhT3UwRHBNbFhIU3Vrd2psejdUeFdpczhoMzFRYVJ5?=
 =?utf-8?B?SXQ2V3Q3VFNiYXZpY2cwd2RaeTZNR2oyV3FqcWNwWUdlMWNoWkpiMzlvVzIy?=
 =?utf-8?B?WFhaY2s1bXoyQ2xJYUFKa25oSFIwNVJjSG9lOWE3MlhsZDBmTHc5ams5cE0w?=
 =?utf-8?B?anRCVEV4MUJhM3Vsdmo1aDdicC9lSTN0U2lVNytxVkVwQU1XcXhoaWJadHZ2?=
 =?utf-8?B?N3hZNzFpVVdSeCtvYVRSMGN0ZUxKdzZBRDhIcHQ3NUkwMXVYRWlmT1d6bVJa?=
 =?utf-8?Q?HXLR5/wbd3I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5764.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFVNeTVOZS8reTFCdWhkcHNQV09FbkJoZ3ExdXpvS2ZaNk4zNGJhTWxyYVBG?=
 =?utf-8?B?K1F6S2lraXY0LzdmZ09hRjlNN3FERXd4eHFBdTEzNHpOZHFza2E3ZS9OSUt3?=
 =?utf-8?B?KzJWbElZUXdEQXpxTUdwSlhDS1pXeU80TjlTeHdDeVI5Z29mZG01YVdITlVl?=
 =?utf-8?B?VStWRGJMQWFEN2p0M0duSGNsT2dCdWJNcTdCZ3hyVkxkV0lMZDMvUzk2QjZR?=
 =?utf-8?B?TitIc1JXN3ZpaW9oU1ZrV0x6dVNNL1plR0N2L3RhUURNTUN1NDllbXpKT3hz?=
 =?utf-8?B?VjY3bStwL1hrbVFqZTh6VkxtM1JpNHNVQWRIa3Rsd2tqdnJZQ3NEOFNURUtk?=
 =?utf-8?B?YVpKaG5WRnRma0tnN3dELzlwdWNnWGNkUFU5WjI5VkRBWmJCNk9nT3M1SGhv?=
 =?utf-8?B?K3FkeUljWUVnTDFoSWFLYS9adHp0OXRLUkVIRGtFQi9Tb2J0NGhaZ1NWbmRQ?=
 =?utf-8?B?TEpWeU1PbjV0ekxzTWJ0VmdkazlwUm5OOGNnaGpCamltR1ZaN3AxaDR3aWpH?=
 =?utf-8?B?anFTbDhaR3VMZWRNOEIxWkJ1YWFsaTdUa0RMcHE5cWVsUWFIbmZIQWxCMGlF?=
 =?utf-8?B?bm9OV21yWFg2OFdqWEdmaWlxQmlpVVd4Y0kzT2RkcGEyOCsrV1ZFOGY5NU9X?=
 =?utf-8?B?dkRKT29sK3poQW9TVVpLWS80YXdpeDRWYWxwZUl0eXVCUE42Mks3V2o1TVZz?=
 =?utf-8?B?Q0JaMTNyV1JXQWVBSTMwRnRXQzRTU1BVZG1tTXEyeWEzYkVUeDUwNmFCSU5y?=
 =?utf-8?B?NTNtZXpub1dZZGRkZkNpRDNVWkttV2Fra0lOczQrTDVuajVzU1ZWNS9DNEZt?=
 =?utf-8?B?TEpQU1BqS0prV0lqNGZ5ZkcyYnJBTHdvSDlLUGw0RXkxak9SeG9kTUpvekpO?=
 =?utf-8?B?MldyOFJCbVlCbWNKYUNiYWR1QlZQTUVaZFR6T21wUmxvdExWNmdSZlcxTFhB?=
 =?utf-8?B?Q2VKOXVScWNxbWNXekVYZFp5VUM0ZVJ1NkJqOExZeStmYTBlcW1odzdTTEs2?=
 =?utf-8?B?aEE2OFB0ci9IYzFRZ2srR2dJa1c0TVE3QWFwUjhDdU9yQ3RFTi9GZisvWjRT?=
 =?utf-8?B?T1JkWTc5WHhCSkFXYXlaVStEc0Erb21wRGVkalAxSk9wVjlSaks0R3ZSM0tK?=
 =?utf-8?B?MGlVeWljcEFBYVc4bmkzWkJvTFRyN21PejRmb0J2eC9NQWk3Uk4xeGZKbkI1?=
 =?utf-8?B?NllQbzYxWUJWa282NGZxdllYanlQcGVGeWIxNkR3ZXJwUTdrZVVjYmV6ZWQr?=
 =?utf-8?B?M2F3ZWlRYWZNQ1FRQkpoQnlMaWM2TlkzaGMvdmxqZ2c3d25xejdNZjU5VG5t?=
 =?utf-8?B?NkpBa3dnanhPc0tEWW84MGpaZXNEeTMyZXZTWVRMc2JzU3c3VXU2cnNlNEsy?=
 =?utf-8?B?WDhwZTJWWHNRVDI1SXdFT0dTTzlwNnFmeU9IVENHNmxtRURnVDBUMFFOSWFm?=
 =?utf-8?B?VmltNVVoQWl4SG9NWUhqbTdvYUNzTWtndFJmVWNjWGZpUnZ3b1VBU3UyVnFO?=
 =?utf-8?B?emhxYUtOZTBxUllqeEtzaHd3Ym5vWjl2YTZ6WTNkMXlYYldiS2g0ZStFV3Er?=
 =?utf-8?B?WHVRQnBSbzQ3T3JsM0Z3NEc0KzJjaG5YOEhLQTR3ZlB5cFlIUklUZnNHRGt5?=
 =?utf-8?B?eFRSdXBhWTNmdW1PQ3Fla0k3cWVlOVI5Y29mYWlwdXQ1d29POGlHa1dQNFJo?=
 =?utf-8?B?dUpqV3Q0bnVXNzNzZm5JWEVyK2pEYzBZRkJqT2xnempoSXNUYVlQWnhOVWdB?=
 =?utf-8?B?UnRiSElVYVUzRGRWNEhDRWhrRkVPKzFxOUpOMXFsR3FNZFc5YVlFM2RNVHlY?=
 =?utf-8?B?U2tLVHp4ODNZdDE5Rm1MTHBxNFdpcUVpcEdGZUpFZ2oxTXFMd2tOUjl4alRB?=
 =?utf-8?B?MnJJblRVdGNIWEU3NENuQ2hHR2tKa1Y5by9SQVkvOERQYlFDNnFRNWsvYW1s?=
 =?utf-8?B?Ym5GSThlUThKTHFheHN0dEVXd01XSUdoVEFXaGFiRlovOURERkw1bXFDVFkr?=
 =?utf-8?B?ek9kTEtMNkN0UnhFam05b2NtbFUyKytZZEUxcTYzZW8wVGxRUWRqM29PV3FQ?=
 =?utf-8?B?QlBJQVJqLzVZaElYdEZyZHgwMXdzakVOK1BKK0MvM2ZUTnJxQ0hOK0pLd3A2?=
 =?utf-8?Q?7fDofZS8WbQzVqO3Rm1WRaG/l?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JHtvuytPgdiUwE0efLkfetgxCVvWLgQoTv/NGd70fzo4IxlvNXIReM6IPfobVpSYG+/HeQGJjEUe/Lr0sYD9upS2tUfQpr1wEbvEv9uj2QpIbuvuHAFbIaKZn4uDeXGYmHRouT+/qsXeX6SqBpSeEDa0NPvLjK/oGffReRQAaXoaHaqgJBu1tS4Nkozv0ZVzPoeDljsgwwqZhjGZ/PODLV6et3VR4mcZIoVTCIS9ML3LKrppnjjtH0kq6jZ+VWo5Sh5fc7ZCJ0HkrBSkC8+1JfWNX7BED4L4Cp1hNxY+yEIIoynghIdQVcejn3POMacnCcVcoXxm85a32vJlk3u+VEsepsTqaUc1fu8jpHXl3hjWUoG8+E3JbXJF8TG3oBxq3YYS6nZO75X552PxNgPHHzQS445ZhRgDv1RUpOxSIltckozVTU0adcGj/abClILzOovJFsI9TzJ9jgsegCXqnrAStG5GDfN33OgyxA1ZRxYJVt79i6VaP8zj+jTu72BK57wXDtEG9wKeyz59x8xER3kaGaATSIfSDbOHj6t8aiBjDEjUeJfiPYXN1p5EYpfVkGMQL5Ika4I4RlDxjSZ35pocrO6Clb2K6sw3ZfUdTt8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f296c3-3882-4cf2-d822-08dd82c64ed1
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5764.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 00:23:59.5925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XrGEgEn3w6qVsvRdLhVu9R/kkJZAtpeabGN2j21D3N4TSKuLi65g0g9f1zXIOqdnGsTtMERj8P2W3ozrou+BJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4363
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_12,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504240001
X-Proofpoint-ORIG-GUID: 6ywuJKAhdapLgIElXoo0v3maf2JQiGc-
X-Proofpoint-GUID: 6ywuJKAhdapLgIElXoo0v3maf2JQiGc-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDAwMSBTYWx0ZWRfX4vzbx+r6QBjM np45SuSQZt73rs/z/UvJKgcFvv3FLth9SlYNelAdHJkOi6zkOCQ73ODGeMqO3QaJzgvUvA5boID oAXS4QNM6Kx0Eoh6YUUSbKTtjUFudTaOdyxLfiNHj07NV2HZtmeL6/XHK4f82+yaFdxbR1gSTXl
 Aw7Vk9XJIDaRzYn39tKZYVXP9ZDuHc+g4NK+NvSyLqT38fR6JmPcI82F8fPJLwzblqPKImqnj8l xC2jw3Y7k9grIMYefY5jCn8PiL6iLsJCfIiMpdggtPwkE2vE2ZbyiIbc5dMoDOjcpydWIy/qrI5 wyEVrDPHzqqxlH0opssZ4aTR6z22OoLfokKaNJClkViRwZkqD3S/q+QWqQyxszXF+2bXFYqHLp6 EHziyPL7

* Andrii Nakryiko <andrii.nakryiko@gmail.com> [250423 18:06]:
> On Wed, Apr 23, 2025 at 2:49=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Tue, Apr 22, 2025 at 3:49=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Fri, Apr 18, 2025 at 10:50=E2=80=AFAM Suren Baghdasaryan <surenb@g=
oogle.com> wrote:
> > > >
> > > > With maple_tree supporting vma tree traversal under RCU and vma and
> > > > its important members being RCU-safe, /proc/pid/maps can be read un=
der
> > > > RCU and without the need to read-lock mmap_lock. However vma conten=
t
> > > > can change from under us, therefore we make a copy of the vma and w=
e
> > > > pin pointer fields used when generating the output (currently only
> > > > vm_file and anon_name). Afterwards we check for concurrent address
> > > > space modifications, wait for them to end and retry. While we take
> > > > the mmap_lock for reading during such contention, we do that moment=
arily
> > > > only to record new mm_wr_seq counter. This change is designed to re=
duce
> > >
> > > This is probably a stupid question, but why do we need to take a lock
> > > just to record this counter? uprobes get away without taking mmap_loc=
k
> > > even for reads, and still record this seq counter. And then detect
> > > whether there were any modifications in between. Why does this change
> > > need more heavy-weight mmap_read_lock to do speculative reads?
> >
> > Not a stupid question. mmap_read_lock() is used to wait for the writer
> > to finish what it's doing and then we continue by recording a new
> > sequence counter value and call mmap_read_unlock. This is what
> > get_vma_snapshot() does. But your question made me realize that we can
> > optimize m_start() further by not taking mmap_read_lock at all.
> > Instead of taking mmap_read_lock then doing drop_mmap_lock() we can
> > try mmap_lock_speculate_try_begin() and only if it fails do the same
> > dance we do in the get_vma_snapshot(). I think that should work.
>=20
> Ok, yeah, it would be great to avoid taking a lock in a common case!

We can check this counter once per 4k block and maintain the same
'tearing' that exists today instead of per-vma.  Not that anyone said
they had an issue with changing it, but since we're on this road anyways
I'd thought I'd point out where we could end up.

I am concerned about live locking in either scenario, but I haven't
looked too deep into this pattern.

I also don't love (as usual) the lack of ensured forward progress.

It seems like we have four cases for the vm area state now:
1. we want to read a stable vma or set of vmas (per-vma locking)
2. we want to read a stable mm state for reading (the very short named
mmap_lock_speculate_try_begin)
3. we ensure a stable vma/mm state for reading (mmap read lock)
4. we are writing - get out of my way (mmap write lock).

Cheers,
Liam


