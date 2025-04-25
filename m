Return-Path: <linux-fsdevel+bounces-47344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66833A9C559
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 12:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E02116C6F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 10:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E755223C39A;
	Fri, 25 Apr 2025 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GgJ/T5A+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HARx3AtA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8492818D;
	Fri, 25 Apr 2025 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745576785; cv=fail; b=grwilQtViNFYHtff5BJ5F4loqGV8EL4vYX/ihquQALkwPCAMs13zetNG8fuVQaO1zCMmmFfd+c7WLQZPMXlwYB9DHSxOHaEC5BzCuMOXJplJtyiEYfCjd28cgNh8jqBTpLAZVKWPCWLmCOhQjtsAUW/z8R2303FMNbsUwrhrV7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745576785; c=relaxed/simple;
	bh=aE18bSCQz4nXbsWpql4tDR/oa1eWfEVVC2g8J7XFM2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s5YCyoM4ITP4zlohoDndHbqL9KrGgTBTCJnzacLq3XBKBiP0yQiqmw71mdC1lmXEZ++FkYwqmc2nCDkAAt+kxd1m0pD4dX0h9bFPVFYlBnB/Tzt600jyU0dYaef+bVprOWdSYdB+eB9X+7azO98aCsTsdB5GpL4pCS1NXLNKTOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GgJ/T5A+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HARx3AtA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P9W5XY012771;
	Fri, 25 Apr 2025 10:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XoL4kg6VZfvLVKhkpqk92Mhxot4SSDIyUU/myHfyMaM=; b=
	GgJ/T5A+kFlxKIowqv67OA8CNujk76Gera/7tlDVMLctpXhM1kwrUp5OEB+uFE+E
	0D1As+QTY2x8pbUaXTEfaciRbbWRvv3I6+423wOJrkpzOGujbLdI/kTf6aTEK2mE
	d9IzXVePfWNz+nM2iWAqZhkwXfgoyOGuqs+Fbwy9Wl3GTGwsomfc7CWoNOp5NfuE
	YI/7Ed4DmOY5UDh+o412So+5Ah0E3sgINCPlUxe7T4rb3PhArG4aExNTf1xdSznU
	GpcRrsWMXgJ0tSOtif0H/zndBsm1MvukNbVUq02tvEFkL8eS4mWyop/a/Uo6gFsA
	DQ1b2PS7ACV7ZKowhS/v5g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4687ud02xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 10:26:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53P9aVLi032512;
	Fri, 25 Apr 2025 10:26:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 467gfsj46y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 10:26:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c94RWyosrTABXPvrzRIX2dE/V5CgMaxVoYSw2XIZsvqahPXFLuEglthMkWX96G0zyDFzyhdE8vdQuanmtBmqHpY87JVtP+5LjwvFGqWuT/r5JABiWaVN3+OwNIshS9WyD43jIR3iYZSPwlZw6W1KVBtC6mgGG4HX/O/JaO7mlsf9ajaLhXJFSBLwHZb68OV/sBrztIpVPutdb3pOz1Xme5zWDgOoiqZIGev6brr8Bh1zyspv29AlEac3/R9Fi1LUR+PLeXAvuyz2WyEGkJsos+0jKoHayjmqyQ9etP5t/htJaHf/l02+7GVLOYS1oSsQBjoWeiLVt4cWl4QV95Mc5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoL4kg6VZfvLVKhkpqk92Mhxot4SSDIyUU/myHfyMaM=;
 b=pVbBQTcMxl2W7NuWip1Ktj7z+nXnvvszGllWxHXRudS2FenBhiSj473FTsW3UtvHprmBWPbP7hUC7E+AnGa08SbLN/jcvXAvlbt/z+7uDGzAgsDqP60RG0FWHuWpq82wWHH9OgNh/d8SQIZaZOhP20xpC31aMgBZC/d46sJ1CirbgsO3trGzgpCgtXiJbJ/Nczj7EGcGfqNTvkWL4BQpz1CYfCIoBkvFbBFvbtcht1ts5EUGpoOtnUgx5Y5alG3hP2Y5eqXNvjbK4ZU6z7ALLGNppj4cWhgT/dxDOAfeKMP25g5Q4VZtLagayngnMIlUVqDXTFyObH6W7761SWZOaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoL4kg6VZfvLVKhkpqk92Mhxot4SSDIyUU/myHfyMaM=;
 b=HARx3AtARlHIwIyC2Lj2JXM4m1NEuiAA9mpSf/UEi4EHQQfOGqalQ5/AJkfaKzS/wu6I53ADd5VpRWuf5RwcOOOYPXtAGWsEE7hpjVUvdBRWZ7RXW/xdqW9/ewKZEBFrCf6/g6J8y1E/bA0T87CWpNeUL3TsIdxhwtSB1SxOMBE=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by PH7PR10MB7850.namprd10.prod.outlook.com (2603:10b6:510:30c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 10:26:04 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 10:26:03 +0000
Date: Fri, 25 Apr 2025 06:26:00 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Kees Cook <kees@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: perform VMA allocation, freeing, duplication in
 mm
Message-ID: <ydldfi2bx2zyzi72bmbfu5eadt6xtbxee3fgrdwlituf66vvb4@5mc3jaqlicle>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1745528282.git.lorenzo.stoakes@oracle.com>
 <0f848d59f3eea3dd0c0cdc3920644222c40cffe6.1745528282.git.lorenzo.stoakes@oracle.com>
 <8ff17bd8-5cdd-49cd-ba71-b60abc1c99f6@redhat.com>
 <CAJuCfpG84+795wzWuEi6t18srt436=9ea0dGrYgg-KT8+82Sgw@mail.gmail.com>
 <7b176eaa-3137-42b9-9764-ca4b2b5f6f6b@lucifer.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7b176eaa-3137-42b9-9764-ca4b2b5f6f6b@lucifer.local>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YQXP288CA0036.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::38) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|PH7PR10MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d5d69d1-7b83-4dad-3637-08dd83e39509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWZDb3JCVGR4YWlsL2dycHM1OHYwZ3JEdVFyaUUrcVlsMk1jRWREWXZQUkFT?=
 =?utf-8?B?Mlg3Y05abVpMTXVHUXFXajFxZDRCQ0RjY2llenVEdC8zbVRqM0ptbUpDZGFx?=
 =?utf-8?B?a1lBbCtSSFNRdS9KaUQzYUc4U0RyZU5lUXI2WlBwVXI0czRKYjhmeEV5UkNq?=
 =?utf-8?B?c1BOekVFM2lnalNrLzUwb2FKb29XalNFZ29IV1hOZTZ4YzNtbmErODBQeGlW?=
 =?utf-8?B?R09NbkRHRXZ4SUFvczRYNURJNE0wOTFsRThQMXNqdDhpNWxjeFk2eXdGZ29Q?=
 =?utf-8?B?S2NWY2l2SWV1Vno0aDBzZTdiTGs0K2tLNVNVeTZpdThGLzQyWVNEbDZiK3ND?=
 =?utf-8?B?Tmc2akNXTFhzMWJNMFVrWjdVSGQ0TVhBbnczQlRRK1o3eHlscWIzQWxaV0R5?=
 =?utf-8?B?QXdjQmd5RXVUeGR1OUZTVEhGVkZNcjJHenI0N1VnTGVVNDhjT0txZytld3hR?=
 =?utf-8?B?eHZpaUwyVHJLYStWTG5laE9UVXNyWXVIOWx2VWEweklwcFVXQnBQTmYvOTNn?=
 =?utf-8?B?bnRzTHE1ZU10dXorcitJYVgvTVc3czFhazBkUGprSno1ejBTWlZicmFkeFln?=
 =?utf-8?B?WHdjT3FiWlhyVDFqMDFkbitXTjUrdkpDdU5QZVR5dGZmZDZPbEd5cXMvS2x2?=
 =?utf-8?B?d0xiQzB5NVdQeHlXenE5bklveTdKdTZ6YTRWMW5QYmNvNFBCdkdxaWtINjNi?=
 =?utf-8?B?QUl0cVRIVTRMQllVazNNSnNyV2t4ckNXdUNvS0JZVzlITlhVYWNSa0F6Y1lS?=
 =?utf-8?B?VDQ1Y3NGZURGRXllYW95Wlh1OUh1bnBEUkRwM2huaUFvYVBuZVZkMFluLzJp?=
 =?utf-8?B?ZkZtS3pEK1I2cDdkanY1ZFpBR3Y1S1Y0Y0c5UC9FdjB6cmphdWdyYjY3Y05m?=
 =?utf-8?B?aEhnN0R5N3JSRjV6NFdFajNhUzNaYUlodEFKMDF2RTVGK1NoQ3g4V0VZRHhU?=
 =?utf-8?B?YkJva3dqV0VIVmVNWHNRVEhSUlhPMERTd0tjdE5aaGZzZzVsZnFHeHhadUxK?=
 =?utf-8?B?YkIxSkc3d1I4c0crU0xZOGc1Y1FQaW1QY1V4VEMwUlRSK0JPNlowQzk0N09N?=
 =?utf-8?B?cU1DeVlyN1laSStIL2lLcDdoTlg4NDZhVncySkJsUzh1SlYzR24xU3lZc3FG?=
 =?utf-8?B?S2s1T0tFZmZzTTB1UDdsV3A0cS9jVzkyc2ltVmsrcHQ3YTRxS2h6SXZyMlRK?=
 =?utf-8?B?WkJ5ZjdNQjlMZkFwc05JVmhvcHB6SkVWOGtlZWhGSEVkYmxkVjJQYzJoUmRM?=
 =?utf-8?B?TTRSVW5FMjk5cjZjN0l2VEUwcmc2a3RobUd4eW5YSSsvRVpBTThxYWV2elpy?=
 =?utf-8?B?bDlPY2ZORFFrbGlGRU5say9jY2EyYTFEckdoY0JXYnJQVVpxNjVSTmlJY3ls?=
 =?utf-8?B?SVM0SXdqUVhXWHFyYWNrZFdBYXZHellDcjd0ZEp5UlhCMzQ4WGYwR1h4bnFp?=
 =?utf-8?B?ck04dWl0ZmN5eXNyOU5JQlNFZ1pvRnpJRFJ4VkEzeWcxNUtMdEhITFhWYmFW?=
 =?utf-8?B?L3krVnlxZ2tHWmlDbkNuMlVVbWVMZDVnaDlnT0ZoYkdKajBPUFhMd2F1MzhB?=
 =?utf-8?B?dGVEZ1UxVEk0QkdhUHpYNWtnTy9RV0NRbnJNcm1kclBNaSszSEVwRHY4THF0?=
 =?utf-8?B?YWdTQ1V0TENYaVZua0d4bWFCR2ZQY0krTVJVTkJKS0RSOTF6NmxkLyt3Wm94?=
 =?utf-8?B?SFBRNEZ6TXFXYk1uK0s4UlIzNHJlcUR4YUZ5c1Fja0g3MnYxZVhjTER5UHhS?=
 =?utf-8?B?N2g0eGhrZk9VNE1Za0ZhZWRlV0NsaEVTT0F5SzVwOFp6VEFiWU5KNHkrSXp6?=
 =?utf-8?B?MCtCMzR1ZGh1ckZmZEU0T25QZlBsRG4vMFJSSHV1MmlzKzByYkVVV0d2UWlm?=
 =?utf-8?B?Z1Zzdi9DMnBsNUhVdDJHQTVYSXlHNi8weVBXazRqbUxIb2NRSmZtTUhGbCtk?=
 =?utf-8?Q?tv8T39GrRsQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkZVU0pPYWZnOVVJVnM1S0NkazQ0NmdXbmQvcUVZTmRwZ1BCdERKTm43ZDVp?=
 =?utf-8?B?d3BZT21iNlhlVVZ3cDZGN0NqbVdxVkhXMksrY2xCZmRPWmRUR1l2dGg1dEgy?=
 =?utf-8?B?VXUwNFN1N3MzSEQvdDgzL3hMUzdCcHZZY0cvUzJueHJWWTNZejVKMWxWcTJH?=
 =?utf-8?B?aVZjQ2x6bVFXOWVSSW5CdlI3eFpzMmpGdUk1eEQwZjg5WGI4cEF6WFdLZTR2?=
 =?utf-8?B?bW9HYzBGZ215VzRsMGQvbENTRFloZVpzcXZxb1dsSjFacHNneVRDRTZRMU9Z?=
 =?utf-8?B?K1MxTEFlR2dCbU5IWDloU2hlak5JTXR5QTdYS1ZYckRqay9pVDhnQ3BsbGFR?=
 =?utf-8?B?WkJNMWVHZUFMZjNsVTBmNHdqc1JUbEp6OVF5c2pMc3FTeWx1U0dhTC9hSjRT?=
 =?utf-8?B?OHc5N1krRkNVQ0QvMm03UXpjZUU2amRMTm1wUHVOR2dLSEwraE1kdEV3cm9x?=
 =?utf-8?B?b21EMm9NK08wUm96TnVzYzdzQzRva1JhNytjOUJGQVRGRmJJOU4xejhjMW1q?=
 =?utf-8?B?NldkMllkRXd2elZKS2VJdy9YcjJxN3pOY0xKbCs5NiszUGVLMW1YWVpWMVdu?=
 =?utf-8?B?U2Jsd1YwTFlwdzAwMUZROU95OENvYXZYVWE1VUdCQWs1YnhaV2FmSVlTaVhB?=
 =?utf-8?B?UmpEUjVJNHQwYWNNdXFiczJ0Qi9NckNjcGtXNUlkbHZ2dFpWYW03L3NFVWlD?=
 =?utf-8?B?UGlUM0s2czdkZDUzWWdkck5na0VvYmZYbEkxdkhRamNnaENnK3NGTElkb1FR?=
 =?utf-8?B?VS9INEQ1emcxS1RFOWlpcnZHQ3B3UkR1ZzExMXJQUEJ5aURUNHhsNERUK3BU?=
 =?utf-8?B?dWdFVVBwYlpzcXBiY2hyUWEzVkdTdkQzZ1NXKzd4enVnTDE0SXc0eTA0dUVq?=
 =?utf-8?B?Y3doNW5ZR3NWTjNqMmpzQk5vZko5OVVxTjFrMlV4OElPTHgrb3ErbThWakln?=
 =?utf-8?B?STFLQzc5YkE5RWdNTCs0NXFVUG02ajhDRk14RFFVVWVwTDNvOEU2VkRtUWNR?=
 =?utf-8?B?VVZFazVJZUNnRmlzODdZbmZ5QllQMy9LbEdOM2NsckRzdjZDZlVEL3dUTVZO?=
 =?utf-8?B?b1lkRmxMWGtEZU1lOXduQWpPM0hDZG51WnpvYkFQV3VOc2dDNU1uZzdubVNQ?=
 =?utf-8?B?VTJkZU1Yc0kvbFVZNHZYbWNJTG4rcWpQZ2RFem51NmhIYWlUM0ZWU2MybVV5?=
 =?utf-8?B?MDlJVmFZN3lQcldWaU90VHYzRVhUalZ1U1U4Y1BIaENIZGt1dHFWbEM1RVhL?=
 =?utf-8?B?dkpaSGt2UVlFdGNMQzc3QVl3bEd6Yi9uamFNRTE1aGh0TVg2YUNTb0haWldj?=
 =?utf-8?B?QVdTd3hhNVRYZ21jUFp3MTlCak5RTWc2bEVFUGlHKzJvSjFEM3VZU1hHS0VW?=
 =?utf-8?B?bmoxVnF4SmN1cVRTa2x3TnFubHNTQ2NpYm1PWGJKRUpyNVNDSFhQUlFvbndw?=
 =?utf-8?B?RmhiclFWck9wTy9iS0YyVlB6NG5GR29xSUNOODR4MjV1K00zRHZ5aXBiak0w?=
 =?utf-8?B?emZvRlErR0h4dXd1aXcyY2lnM0s2OEkxdy9wYUd5NFlXUlFWTGFldnp4QTdq?=
 =?utf-8?B?anQ1QjdHZng3Mjg3SUROcG9rNEk0RVpuMzhsUUErNGsza3NtT25nTFpmc1Jn?=
 =?utf-8?B?SzkwMC9jV0IxZkoyQkhXVlF3Q2x3TU84dkVUSnhnTFZEd3prYmdFYVB0YVQ1?=
 =?utf-8?B?MEtFeGR1WHZzNFY3UUxvUEZySGdhamZvL0VkRS8zcm5wanlMSlFEa1piZlRT?=
 =?utf-8?B?bURhSDhNalU3RHNFZnJJQlFveCtpM21CaEFVR3FLZG5vN1U5R3B2Z2hIdXFx?=
 =?utf-8?B?eXZMNTg4ZnBhRDRsaXJEMzFmc21YVUkzRjRDa3RyY1YyQXpxMEo5a0lmNHZN?=
 =?utf-8?B?QnRtSHNjL09keVprZnA0ekhrQ3RoZEwxaGlrazRHc3FhUE1pMmlrK3MzVEs2?=
 =?utf-8?B?VklpQ0xQVkF5aVo2ZTRXTkplZFR1czZZYmhLQ3RqMElQZWJUWlhYTWYvcEpa?=
 =?utf-8?B?NWZEUi9rUm1CYjZhQ3IveXVUeTJoOWVkb1VianBnVVJaOGJMWlhDWEpBVVpX?=
 =?utf-8?B?RWRnUkE5UCs4KzBEdy9GKzBIZlZsZ01NSzIvS1RlSkR0em8xbU41SmVCS09R?=
 =?utf-8?Q?AvI6wJuKGMfH77GcmWLJXNDOf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2DCII4PuCt/r3+lmViddIVbHcjhYAI1s/BgP+mh/d45xR/O/23p0SkBL0ms2GPb4Yeq/xiML0aqq5rQNAosIfAX0ahN+WFjSlY9hzKHKgbjbePst+siQ6b5bDto5XAcYrWqEAxDcPEMAFvaSjJFWmANnXL3MOfteB3Oxhfcu8Ss5nfu0lFjRW6yaHjGtxtyfMEAqBKyMnJ1xiapENpkhl1CSlSA5vhMh8qSPZ5iHn45P1gRn6TMIZNEbdD/p7QmYqyOYUl194xpLjxVkEg9Oe8D7vqz5pyGMMa2/GhBEG2z6ELgCWNPEVyrbhl/igpHlt5P1SASIzlFZDEPtiG1GR2uVFcXR55cw37Mx1A6nU1d9W729n9w7P2bzJmp6n4IrSoQ3pNe2tCQ+X0X7sJ5jvUHOXvNo6ovR42JIRYYIwz8jw0j/Y0Dxt5GThv3vTQ29ziIXCzqErKFOGufJhGPobrRBRGk6CbW9om/aaYb061I0NalCVu41EgIzx9n7Dr8cOwGOy3oVKydS+Pl49kKeyqa4koregc+V5u5rl4sogqYOWWDiprO4PVmvE+Lx5JcytVtX3EKBuOqHiiYxggc0tX6zOEsr67MPf3lOtfAYzWE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5d69d1-7b83-4dad-3637-08dd83e39509
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 10:26:03.9042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n2IboIzkTBGA49NqdgdbXlrrBWyM1tbEN9zEjP6cRnwh78XkHQ3tcDF7Yk/GOHUuM45jGmbSVSEQy2PNej9kTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7850
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504250075
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA3NSBTYWx0ZWRfX+YUTrCcov0+q aiwv1WgfIeSi6/ecPjZaIfkE39cMvZq3mvMEf/RZd7DYaoNnqzh1segp32mdPYKsNvU+cjmrXA2 FdG1FGlP+ju9LbuqWTkWuVYkGiXApnYj9zxp85sU2FgPj05nZ0trchN8Wgn8ctrLOIheeo7oOqK
 it5NcFR/+y0+NmJKFeohv6ITULAEEUGm9ZbKn04Smadfd9A2i1dhQ1n/51LFb7y2knwRW2naIiH y8pijkCwhfNl7aLIb7csO2J8NVHj6Cq8zYQG8U2LOjXllz3EuTWgfrLXor6Y9HIskdvekNVKDau 0gSLzTBi+ny3aL/0TfQlNkGPRJxZ7+QMiwyr8PFEh16vhQgXz0NDR343VR0lAnz6wbkaeqoydNX XUrXf++S
X-Proofpoint-GUID: 9A1R6LJQ2V0877W2BGuP19zU71mtZHIM
X-Proofpoint-ORIG-GUID: 9A1R6LJQ2V0877W2BGuP19zU71mtZHIM

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250425 06:09]:
> On Thu, Apr 24, 2025 at 06:22:30PM -0700, Suren Baghdasaryan wrote:
> > On Thu, Apr 24, 2025 at 2:22=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> > >
> > > On 24.04.25 23:15, Lorenzo Stoakes wrote:
> > > > Right now these are performed in kernel/fork.c which is odd and a v=
iolation
> > > > of separation of concerns, as well as preventing us from integratin=
g this
> > > > and related logic into userland VMA testing going forward, and perh=
aps more
> > > > importantly - enabling us to, in a subsequent commit, make VMA
> > > > allocation/freeing a purely internal mm operation.
> > > >
> > > > There is a fly in the ointment - nommu - mmap.c is not compiled if
> > > > CONFIG_MMU is not set, and there is no sensible place to put these =
outside
> > > > of that, so we are put in the position of having to duplication som=
e logic
> >
> > s/to duplication/to duplicate
>=20
> Ack will fix!
>=20
> >
> > > > here.
> > > >
> > > > This isn't ideal, but since nommu is a niche use-case, already dupl=
icates a
> > > > great deal of mmu logic by its nature and we can eliminate code tha=
t is not
> > > > applicable to nommu, it seems a worthwhile trade-off.
> > > >
> > > > The intent is to move all this logic to vma.c in a subsequent commi=
t,
> > > > rendering VMA allocation, freeing and duplication mm-internal-only =
and
> > > > userland testable.
> > >
> > > I'm pretty sure you tried it, but what's the big blocker to have patc=
h
> > > #3 first, so we can avoid the temporary move of the code to mmap.c ?
> >
> > Completely agree with David.
>=20
> Ack! Yes this was a little bit of a silly one :P
>=20
> > I peeked into 4/4 and it seems you want to keep vma.c completely
> > CONFIG_MMU-centric. I know we treat NOMMU as an unwanted child but
> > IMHO it would be much cleaner to move these functions into vma.c from
> > the beginning and have an #ifdef CONFIG_MMU there like this:
> >
> > mm/vma.c
>=20
> This isn't really workable, as the _entire file_ basically contains
> CONFIG_MMU-specific stuff. so it'd be one huge #ifdef CONFIG_MMU block wi=
th
> one small #else block. It'd also be asking for bugs and issues in nommu.
>=20
> I think doing it this way fits the patterns we have established for
> nommu/mmap separation, and I would say nommu is enough of a niche edge ca=
se
> for us to really not want to have to go to great lengths to find ways of
> sharing code.
>=20
> I am quite concerned about us having to consider it and deal with issues
> around it so often, so want to try to avoid that as much as we can,
> ideally.

I think you're asking for more issues the way you have it now.  It could
be a very long time until someone sees that nommu isn't working,
probably an entire stable kernel cycle.  Basically the longest time it
can go before being deemed unnecessary to fix.

It could also be worse, it could end up like the arch code with bugs
over a decade old not being noticed because it was forked off into
another file.

Could we create another file for the small section of common code and
achieve your goals?

Thanks,
Liam


