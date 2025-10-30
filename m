Return-Path: <linux-fsdevel+bounces-66522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E41C220E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 20:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 50AB04ED8AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 19:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A26F312813;
	Thu, 30 Oct 2025 19:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OCTfVO2M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LqkoTXjx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A312459F8;
	Thu, 30 Oct 2025 19:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761853671; cv=fail; b=jL5eJZAHwzzmihG0cEi8mjOAJjv5JVcRriG4vE0DQYPdmWL9HcNOOSsF5q2GrpeEggKcktOPlICzBd93ckKG5dovbp5Y5aJtZ+i9xn22JoxScHkA95LumXyFHfInMPiJR+T06HyHbsJpF561WWUSvuetlZC62C4Z1BW7IEwaOgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761853671; c=relaxed/simple;
	bh=4qe1XrML60Me4zvwPEzfIunYey9WBs0s0iGZE5W1hQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BUxyglbY/1McFuMzQ1SdfqZw4hWyKNb6c2G/Ie71gjxAL2eriswF/416N7t1zBIQ1IbGv60ogM62N3p9KiliCbOzxhwFycP/sXLTVUz2Pei1gwVXdL2EGXNzoN3e+OiB4jfUdmUTDEV50ynvZEhk+UYjbnmthLuWRpiRs0trPB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OCTfVO2M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LqkoTXjx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59UIUIs2010492;
	Thu, 30 Oct 2025 19:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=4qe1XrML60Me4zvwPE
	zfIunYey9WBs0s0iGZE5W1hQk=; b=OCTfVO2MmA+QFIfntL+nk2nIBps6ZAmO/c
	+GkAyPYQwGQAfcpJJLLph73Qv4wVHcwm07s5vK1sEsXLqO1wtkh0nFeuqbC2TsUF
	+ff3WKpJueM1Llwh6YPmWIZGBe07jnsbU/z+lsmSJWFg8mtxbBxuJ3HdZ/g2cBI9
	264OzzBHDOQKus0pKn51ctHUZf83Jlf0p6Kg5Uh/EOvxn/XpPLZtrqKLCE1UZ7ZH
	aBFoEkJsDAgPG4K9v+XT7WknFsbTOi8EilTUxUWZtZDozqgMGkbw3sJRO/qUKkYl
	PPyWVZlt8EdV/fbsqN5/eaP4KFSrJmazaY2HrMEldZLlEeYvDE7w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a4dbdg6au-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 19:47:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59UI642b004146;
	Thu, 30 Oct 2025 19:47:30 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012061.outbound.protection.outlook.com [40.93.195.61])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33wn42f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 19:47:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsYr+YZ94Sl53WdWGUZgfc1XzIDmhu8L2Ucy5Q8N+wJ19Y3ObciSdcqukscBTbXR/t4q+mKc+duDC9P3IPRUPBkNkaznCkJJFUt8rD+lDjnaa19v9cw65/ZblBRGrYD0KlX0UC2MlnhN3JfJiGxbEFIBuWjaCx77y3EgyV5o2n+rJKnT5t+eNiuAMwCDiRj6HADlOq55a+O2csgJp3QRMnBhllB2zUN6vcrXi3E+3T5kHrpoUOWdXTd/RS5QTzQnKTtXDTvB89um4GsXpiFgCdAC+slLMgxcaOquKii+2VE4wNasB8jA/l61FIvkoWwZw2h5fNtLhmcfYq1D/+HGyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qe1XrML60Me4zvwPEzfIunYey9WBs0s0iGZE5W1hQk=;
 b=BjwyAu7Ixj2tDlwKiQ0MsDCvYTlG/VV1q/KKTrvPza+mW2YmGemnzih34ft/0+B9sJxxKjwXAzAr/yxpVEvhB8n/P/lZU/QVizu1uKxtgVuQQe6/zwQf1YEECTZOWfGxesSKlW6xCoqEVE2SVU4s4VVNA/QddfUtaeCuZG4xUCZz5s66DKZHfWNeFnMgSflOYm9fSjBJH+2I9Kjb87JmEmm/ysWKe9tthyp5Rb5KgsHO0/m0MK4Ch0jNZjS2Caxo+BQdNETEwOA+/gnTn1oDksk72WpHTv++Az6YsxGE92NT5pTLAKUY/hLhgk3aDK0Eq4uOG7hrpoN0yvDrGRVlgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qe1XrML60Me4zvwPEzfIunYey9WBs0s0iGZE5W1hQk=;
 b=LqkoTXjx9zVXf+d2k7Bbz/sm/u5m44MsBBqQi+T4A90jmSPrEdCfYWgOEOC2kcrLC0ttYTO6uG+7BNzA0YLabcYGvAbfK898hFAC8+U1sgTJjpd1aX8o2LmZx2+E9/iCmDQ+LV7W6cYnGKWf+tFYPVYwaC+lMYJXV8cXLoxnv24=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ2PR10MB7110.namprd10.prod.outlook.com (2603:10b6:a03:4cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Thu, 30 Oct
 2025 19:47:25 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Thu, 30 Oct 2025
 19:47:25 +0000
Date: Thu, 30 Oct 2025 19:47:23 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Pedro Falcato <pfalcato@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH 1/3] mm: introduce VM_MAYBE_GUARD and make visible for
 guard regions
Message-ID: <88b72728-fa3f-4a70-9ea2-40ff50673047@lucifer.local>
References: <cover.1761756437.git.lorenzo.stoakes@oracle.com>
 <7de40603015dee82970f5d37332a6d5af7532063.1761756437.git.lorenzo.stoakes@oracle.com>
 <xnsn5rfqigbm5ryjtbf2rtfotneiwygzesvyfdxiqrzlyzljdr@tmbht4ggnjcv>
 <61ae955e-310d-488e-b350-59bb809f06e1@lucifer.local>
 <c736tssdw3z57kamh6eqc23gr575q375n2o2nnszih64afnaf7@zwbqremsbhwf>
 <053f3a04-9195-4f8d-8959-42e0c3ba077b@lucifer.local>
 <72ee2324-d599-44b6-92ce-ed0afafed78f@suse.cz>
 <3ae457cd-6c18-4870-a617-7f937b107cb4@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ae457cd-6c18-4870-a617-7f937b107cb4@suse.cz>
X-ClientProxiedBy: LO4P123CA0668.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ2PR10MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: 6852d255-6ce5-41a1-b1a8-08de17ed26a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?82QV93kmXdXAvhvQmIJhwEPfjoncS64Vjheh2yCEZGSlVdGfzt+Ci5tYlDNT?=
 =?us-ascii?Q?6nclsvptzVcvAsMgRWw0s6fwj4ue8PWQzcnsbU2A1ZVePww9cjVR5z/6roEg?=
 =?us-ascii?Q?kwtDYTqlFpUGSWzIT1qflWjNWkOV0fbjBUYbyaERQGSXkf7YBrYP/iAjgJFe?=
 =?us-ascii?Q?Og0DoSwOORx8meCztHEGvsgGD/AIbXsWED/O6A7OlPym2L2FMCwmg2a3eL/W?=
 =?us-ascii?Q?1peKW+NMtgCbBB3eNekIDWrDZiN7B/cBetBIwrrxFkjGoi7rXqJH7/zNeBzJ?=
 =?us-ascii?Q?wojYz8vIOf0AFvXB4ZjT+5iVKApl9DxEUFmvxn8HNaGEapRK6MUK9swXetiv?=
 =?us-ascii?Q?c6698E2Ai/8P+Notf7fOr5c0zDyCXgE75VxnkVO597pK/79RAHzG2F4Ck8MY?=
 =?us-ascii?Q?kkUw7ZLSlKuLScGYr/LMoYnqeWgHBNlu2sqHm6mXy3EDSvLtgN7MQS47mCnf?=
 =?us-ascii?Q?gbBFNS175CWDAeQ2xO9oMNmbFvYq2s6ef0RKO+fj1R+8zXxtecJQQIuajjVn?=
 =?us-ascii?Q?/rlSogUUxTydDXjPCsMz4nv7+AGnTz2CbeNUPOObEaGAW5ZaIXkWIwhk8Tx/?=
 =?us-ascii?Q?zHVpYac7kkeXbe0UFDRhiVxCtNbi8oOFPS57Wbv8LmVsUZcwy2Bs1npg0Q6W?=
 =?us-ascii?Q?1DdhLl1uVIBk21GYAnZyvWkUWI8oNGkqDi2/cOCukwNlp85is4hzZ4k+7umZ?=
 =?us-ascii?Q?NPcG8tlklPz4DwkaP+pDYIqcBN1PTw3O0EhNuF+vkiUYG+LHZChbciRjozdP?=
 =?us-ascii?Q?5ooqrAOfreja5+pLRSL7sV9yqu2IHBUcxiWqzJSr9c8e80mFQ/QdcSDCnWkS?=
 =?us-ascii?Q?nQ6qFalHmjghGQFpPleoDAOpLfNMTXGePk7sn2lF/1ovCJZTamMkacKfOhxc?=
 =?us-ascii?Q?taio4jZqCfTZRDWPy69NNIHimH5J8D6xRjsVeisHmvpALS+y3j9EE6ZnacGQ?=
 =?us-ascii?Q?EOofdWJLWSuvr+OWtX/sxzkG6cHDaErGs3kSJebSs1ML3vp0zTgULVANVAB2?=
 =?us-ascii?Q?x/clGAeoszrsWn7rulPM5KytwaUKMKXbQORc1DTU2vXv0JApOy/0ah/Oas0n?=
 =?us-ascii?Q?sxkSf8/OMXDmU/SWrbw/Vw2svHJj6CMtMXEJqcje6einLrpky0Q3X/C10kp6?=
 =?us-ascii?Q?BCVeNNcodCVDQoOs2yltveOGqSOKcAVOu0/657jX7Njxqq2wekiYjjlTRKRp?=
 =?us-ascii?Q?aQ1nvJ0TF7cCDTq3HEHPm5+WK+kQcP8kk2Ov9Z2Nqn03/mqYmUgJPXYQyWhB?=
 =?us-ascii?Q?HvJv0S35loi7aCXJVV8uC9nzBs/sFWaBx2xbCmknwoaX98000OWKZxYuUcfd?=
 =?us-ascii?Q?Xw4pOtISlF7gTavvWH6R/6h9lSqRx6Q7qTaBQpnT3JrDFG+2ScH98P6xFWtE?=
 =?us-ascii?Q?ff6IZC27LsQxHj6Jhgo5u/Xeh+s4T0esxMDohTcjYRUFUoxdJecCFeVScRgM?=
 =?us-ascii?Q?sBLXTmheCBvDIU+KGN4VP/ISMyVSRfaz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F6NBlXkikz7zie1JyBGhg34Y45XF7NAGRZ5dXfUiSciMUrhXkcAtaqBwqPjr?=
 =?us-ascii?Q?IhWqMZPMfwJDheDB1z//8Y/HGCm8Tilul+Ly4U/0JaWoti5vBDUQD2U4rVnI?=
 =?us-ascii?Q?m+Dr6HZeNHBlVElsP0KVnEZXvgQoZK0T6+NaaL/IzbmO/zd9tUf8eK8PhTZ3?=
 =?us-ascii?Q?FA4AEBS+tyzBGIlkCoFxEzMOOsOoRazLixO+gz6GtpdihLs4x2T7R/lfNLKl?=
 =?us-ascii?Q?h7IY+2ZxxmXCTfvTx4NTaAYeN5HAyNpqmN9SNC9PsXb/sMfush7Qeg5o4oDA?=
 =?us-ascii?Q?I2JG+trqPkGWjVegOTuOeyudbvfZubc8pRA7d6mWPGTAj11BJ7eL9b8ZYTN7?=
 =?us-ascii?Q?pu2qh/HaUbebGb4cZd//OsIW5VdBlm9zLQzAgUrj4yd7s66Ji+v71gWPRhNC?=
 =?us-ascii?Q?OwM3iZW7uy5N70LuRhIRBK5qn7SpAQqaqTCIbA/qZcmYWzVAnhTCnVtCSksM?=
 =?us-ascii?Q?/4UOUIRonPEY0D7PgvxnGIRR1C040Fl7uE+nsfJeEMqdfgwB2us0t9b3DWJN?=
 =?us-ascii?Q?VgUyKf5S0Tm86UFaBuT+ZlwtTVEBWj82udj4H5332Ss37HnHGjeFzcts5YvI?=
 =?us-ascii?Q?1HUv5jvMjYbymaaEfPD8Zd9W79XVpO2TUqRaqZyFIHGzZNFRqnhkxc/QYNCZ?=
 =?us-ascii?Q?3maSOcSPNIYhreRt4DoFFqxsTj4UBKbdkmW70KXRidokFOW5Y/14dnS3dvQ3?=
 =?us-ascii?Q?5nJKvw5C1AEFeNpLbpKg0x27bMArLyEDr4P+kRAn6mhixlrrrjikG5rY2cWL?=
 =?us-ascii?Q?B3jFFDGm2uIuYLx8hXUUvhuOSJ2fPAd0D97UuVXX3Qo7yPQYGQKVOXpMrWJB?=
 =?us-ascii?Q?hxG96M/2bC2H0BzWk9Fwe9dNC7AHR388R/wPdKooMmv8G4qKHWqA+ZJTfhXD?=
 =?us-ascii?Q?shEa9GpMrx+EgS5hi7Uf2ykMvrtpR/niqpl6zutf51nzuH8ypcGAUJI1OgPT?=
 =?us-ascii?Q?vmb2culth3PeR+usc49IetgzOg+WilizHxDdb937tqNjIlNlQoQ2J63WUIEJ?=
 =?us-ascii?Q?i+DYIF70YfrXiJTsKEjJGrTdr+ObYQuUXeLEPZloHmMvdeDMBsuGtahrGm2x?=
 =?us-ascii?Q?67tUkBh+oXXt3QQTrfUdE+cY7TJIcGYxRf3DR3J9X4ZzI2SnlWaPlXeaeO+Y?=
 =?us-ascii?Q?MZbNk8wVhJ87EWyfIVtBVK0RmJGXol7RWSCZuU3BTcqxVUJ5L1vViVLxH0iM?=
 =?us-ascii?Q?qgzPbDkqMwmPqKBYhIS8L0sGkqYFIAC1735FCB0DRgPuR36X1okmMpMu3v/Z?=
 =?us-ascii?Q?kVfjEimzmhNf7o3+w0JdAF3/r3/gHmM/A2QJi/1ZFD+DpfLljqss7Uks7ieF?=
 =?us-ascii?Q?I+DtxDnchGqlaipQgB4d0c34i86qNZXJlff0A6UymCQ+6No5UV3w5kDvj2U5?=
 =?us-ascii?Q?88OwFfd3Nk78VrIrYQzx+dGxhyhs7fktQZFJ5EjvFqeHFtv1Ji2wuKAJIQlh?=
 =?us-ascii?Q?7qw+5uLu4Z54EeqGWhCRe+T14dra5nxaHKYI/TEW2haHpLkZnTaexCGHDQJy?=
 =?us-ascii?Q?Si9PDUGlOOQ7tJsxaHQUHZZkJe+sJAMM6L/RWLedIS/XenBbexATyT2Fda3H?=
 =?us-ascii?Q?Yst9RgkKmanHMxgOSQBINpIkRXcbcE/YN5nhyMXG9S0VK7Jdi+k2+EPNwov4?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	456mmikjiko9E9iuoceqroAAE6qISXpzymH+kEDWq6Sy1so19MgN5Kvj3a4ta/NI4JKvkpPct8ztwPjKMcUMxz/zRRASW0bE58lkGnGWPMtyS+Ga2MKn9HM5pdFOpTJtPc/ePESc/4iKF4VW8HMfCVklsb5pyrW4yvnK9KBv6CAfxQwQ11xbVzpEtdmjtTgTICVO9fTyc/+T6obmme5fwOPkgWFiA4jMi+Lh0pP8W0C1/piLn7DHv6qqhsm45ia5cC+f2d0jsMZi4qLNMYO10XZ5xj9nHrB2jItaQRoNY956m+O+go+gMovFGMZOMPRX2zFWvcvaRQKhZtUxUlOkbcFYqVQ0Zbw2z7wKIHu1UnOlxVVUF26amJnhD6UOvq4Sepca5cpygJTdVtZRDmP36D8+xmpUrUpKNCMmEfnODAmItU0OOIJN2gL+xYUC/4IHqznAHlY9ic03DKDhDlX84z8dAKHMUQ3IIC2FduGrjzvESm1WOi0JzM3G/OczeFllpJf1oxjZQPQ+6x8lvNSHIP0JM59JipsbC2ifqcWwWbj/1qe3p0l2xI/kPBoTT/H8qcpm25Xo26Af3UaHxtyp+m6QPOHUoDC3C4fqKPbWV4s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6852d255-6ce5-41a1-b1a8-08de17ed26a0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 19:47:25.6608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxCF6triFnpFXZrE8d1RmtqUo/JGN8A9Y+xTVkHjy3MlcTQEz5ylKBgOEpt1G5PvYQfvr1F+7NtIZLifTx9+VzIaQVy4OIouXJmbq0Ltz0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7110
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510300166
X-Proofpoint-GUID: naI5UXiF_PPyv2pQQ6FDafJU1HTigSPD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE1NCBTYWx0ZWRfX6wm7vC5gMFlc
 63v0tVFUYi6gX5s/oQ3MbxVjkj9N1qz93IkqsuWSqbVuxuxCmfMCUfIDfqWuOhdKwYs6Tc8rDKv
 eadwGuV7RsfSaojtcj3axId4+nj27Q0teHoq8bFwDPQBZppqfzkwmB2VZmyw6iLnC4++pi8jAMp
 HiOaZGIGPW1Pq2N4n3LbGtaSxdHyuLuEOyh8x6eyTKhjsWFFuvkGHqBe6COxIt+9YhvRnQpKlyt
 Iep5a2l51TJegb31g0lq5eJJiUZrYsmbB8TlIZDpVG/DhNBjW2mVerew8PMa1hhZ5y5iL6ioBBp
 tWKuwbf6v7mExGKR8ezrybUTxavoLUyz6K02ID/KTl4u1ab2aahug8nPMsvZO4EYch7imnSqOCz
 I20QiHvcbD1e81H12DLvolRk35r8kw==
X-Authority-Analysis: v=2.4 cv=HOjO14tv c=1 sm=1 tr=0 ts=6903c0d3 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0vmmzv1oPUPr4CyveQMA:9 a=CjuIK1q_8ugA:10 a=nl4s5V0KI7Kw-pW0DWrs:22
 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-ORIG-GUID: naI5UXiF_PPyv2pQQ6FDafJU1HTigSPD

On Thu, Oct 30, 2025 at 07:47:34PM +0100, Vlastimil Babka wrote:
> On 10/30/25 19:31, Vlastimil Babka wrote:
> > On 10/30/25 17:43, Lorenzo Stoakes wrote:
> >> On Thu, Oct 30, 2025 at 04:31:56PM +0000, Pedro Falcato wrote:
> >>> On Thu, Oct 30, 2025 at 04:23:58PM +0000, Lorenzo Stoakes wrote:
> >>> > On Thu, Oct 30, 2025 at 04:16:20PM +0000, Pedro Falcato wrote:
> >>> > > On Wed, Oct 29, 2025 at 04:50:31PM +0000, Lorenzo Stoakes wrote:
> >>> > > > Currently, if a user needs to determine if guard regions are present in a
> >>> > > > range, they have to scan all VMAs (or have knowledge of which ones might
> >>> > > > have guard regions).
> >>> > > >
> >>> > > > Since commit 8e2f2aeb8b48 ("fs/proc/task_mmu: add guard region bit to
> >>> > > > pagemap") and the related commit a516403787e0 ("fs/proc: extend the
> >>> > > > PAGEMAP_SCAN ioctl to report guard regions"), users can use either
> >>> > > > /proc/$pid/pagemap or the PAGEMAP_SCAN functionality to perform this
> >>> > > > operation at a virtual address level.
> >>> > > >
> >>> > > > This is not ideal, and it gives no visibility at a /proc/$pid/smaps level
> >>> > > > that guard regions exist in ranges.
> >>> > > >
> >>> > > > This patch remedies the situation by establishing a new VMA flag,
> >>> > > > VM_MAYBE_GUARD, to indicate that a VMA may contain guard regions (it is
> >>> > > > uncertain because we cannot reasonably determine whether a
> >>> > > > MADV_GUARD_REMOVE call has removed all of the guard regions in a VMA, and
> >>> > > > additionally VMAs may change across merge/split).
> >>> > > >
> >>> > > > We utilise 0x800 for this flag which makes it available to 32-bit
> >>> > > > architectures also, a flag that was previously used by VM_DENYWRITE, which
> >>> > > > was removed in commit 8d0920bde5eb ("mm: remove VM_DENYWRITE") and hasn't
> >>> > > > bee reused yet.
> >>> > > >
> >>> > > > The MADV_GUARD_INSTALL madvise() operation now must take an mmap write
> >>> > > > lock (and also VMA write lock) whereas previously it did not, but this
> >>> > > > seems a reasonable overhead.
> >>> > >
> >>> > > Do you though? Could it be possible to simply atomically set the flag with
> >>> > > the read lock held? This would make it so we can't split the VMA (and tightly
> >>> >
> >>> > VMA flags are not accessed atomically so no I don't think we can do that in any
> >>> > workable way.
> >>> >
> >>>
> >>> FWIW I think you could work it as an atomic flag and treat those races as benign
> >>> (this one, at least).
> >>
> >> It's not benign as we need to ensure that page tables are correctly propagated
> >> on fork.
> >
> > Could we use MADVISE_VMA_READ_LOCK mode (would be actually an improvement
> > over the current MADVISE_MMAP_READ_LOCK), together with the atomic flag
> > setting? I think the places that could race with us to cause RMW use vma
> > write lock so that would be excluded. Fork AFAICS unfortunately doesn't (for
> > the oldmm) and it probably would't make sense to start doing it. Maybe we
> > could think of something to deal with this special case...
>
> During discussion with Pedro off-list I realized fork takes mmap lock for
> write on the old mm, so if we kept taking mmap sem for read, then vma lock
> for read in addition (which should be cheap enough, also we'd only need it
> in case VM_MAYBE_GUARD is not yet set), and set the flag atomicaly, perhaps
> that would cover all non-bening races?
>
>

We take VMA write lock in dup_mmap() on each mpnt (old VMA).

We take the VMA write lock (vma_start_write()) for each mpnt.

We then vm_area_dup() the mpnt to the new VMA before calling:

copy_page_range()
-> vma_needs_copy()

Which is where the check is done.

So we are holding the VMA write lock, so a VMA read lock should suffice no?

For belts + braces we could atomically read the flag in vma_needs_copy(),
though note it's intended VM_COPY_ON_FORK could have more than one flag.

We could drop that for now and be explicit.

