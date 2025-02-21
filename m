Return-Path: <linux-fsdevel+bounces-42286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5EBA3FDCD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 18:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29283BEF66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 17:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F3D250BF0;
	Fri, 21 Feb 2025 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cvvtgPCA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hQtP2rWP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A100036AF5;
	Fri, 21 Feb 2025 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740159981; cv=fail; b=si0EkJP+NvxjHhaWBQqMi9IkFLCxc/bvrGZD+ar56+eNpTqj3by5JrARunaQQDQuYMugjZ+oRkmuXwe781/vq11tGU0dlCsEfmYqDet/KGwxvDlwuqUnLwTTr537mfEeueKFVPZWL6MspI7xnuEEXNOXp9peoPCwwqoIntoXJP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740159981; c=relaxed/simple;
	bh=BlbD1PsQ4Xz4DKJVeNaJTzKbr7Oy8HlbaFvU5lo7dFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PF7BpFOq8cSZ061Uk0vt3xntokNmHb0XyVAPH3+HxYglSNA8sf9qh+O11wXajIvHV+DGEB7/KIALV9fC5OXI/yE4KdXhHSJg+F+uuH0SuND+2YRfbUTe7Vz08X87AeCbEI0X5QCW6eQwMIe8ADnN0o/a8IFCOM7bXQVWFAzmr3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cvvtgPCA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hQtP2rWP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L8fd8Q018610;
	Fri, 21 Feb 2025 17:45:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/bYokIJgFdyGamRovcTes7n+88Qha7ncZZKKNV1eMgE=; b=
	cvvtgPCAUctoZ/QleEmMp+KcTy1rVyS+u7lexc3+CR2uxFSBP6yYRhu5p1/5sLH9
	wFhenXbH+7SC5xOR71YoVOOYgcBVwsUouOuWgooWw6ssoNqUx+3rSqOmtVG6ABLk
	fzcdyOcvl11z5eJNzTK70//kh7OqgfP9/TrmXCpyunHL5xZSSCwrLVv9Li4ojwts
	6wGDxau1qtysx8EazCxxo3tWcWmKS4OGF8oG7Q4soQJ0+Zrl8tcKYbX6UXPH9Ysj
	ljdiB8yIKicWFCvkcZvp47LP/EkRBA66r3zKRAnvEWimg+d415vAOzfJppZxxYs8
	M5+j4G1mO9d4HUJGVNWTAg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00npuua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 17:45:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51LHGph6002180;
	Fri, 21 Feb 2025 17:45:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w0tq96q8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 17:45:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndg8eK0/M1IZGITwCKK4HqjDPceuOxL7zcH5pktl2pyeDpk1tPw+ISYKcWCLRtpkxTTTSTB+HeOwkAw9zcv69XxHz6W+so+xbjZtgJuYFjl28fjn8qQph/hu1Pre4xch+9A/k/dYZGLCR832jzoSomFMMe5mpPBMbE7A+CBejI7nvyas/dWKTWs86vba5MrlxRlcUKmlNU2zwccr4tEbIp7LNyyHjtiN/SPCrXoNllSoCAb43d7uEEEHZRbMPNNhG+bedk1Brywa9GlMHE16/WU/PwKQA3Q6+047Nq/hTL291HwiFwzpzVgJsOf5RESkPu5uafkOuW4nw2kA4ZbGRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bYokIJgFdyGamRovcTes7n+88Qha7ncZZKKNV1eMgE=;
 b=gK7y7sfyQ3XJWP9zXXBcNsY+JNfCNMx5d+/aFBsH3ZrBFnFuIcZk0VhSUHL08NhxL8eiOd4Es6fLEfiNLkZ5l6n3W65tR8sA42FMZhRCBPqyHOQ9tt/OQW4QMREOwl5n0/B2DSc7+96GJZnKLBknvi453Hqjx3ZdxNFL8oNwLasQvEA+6HR65e/D1ICsUvnNQTAh31/73JC7//87FPHN3le5K5j9ARGYDF7qs6Ivz7zxZoGUNAQ6HcJ4Nnm7RgrUPnIiL0j5ksAwwTtQ2h5Ac7gqpP9fi/N4CJtYZDELZ+Eiz5L/bpNP6bv1fLOLzYN1go3S6T11XWYm/i5dNYyx0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bYokIJgFdyGamRovcTes7n+88Qha7ncZZKKNV1eMgE=;
 b=hQtP2rWPeGSjzxfJV25RFGISpbaLVx5ywN5L4+f2+dXZSWZ9KjVmopzlnlCxBdHT34gkOsykV4FuGEzt9OI1w/vycWgJmVLNQAxqskhtFK8hw0TuW6yDb4J3qhsh7bCHIJ7TiGeWuk49Nzae5RJ+NqMV4oEtB0UlvIH8C+EA810=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA0PR10MB6721.namprd10.prod.outlook.com (2603:10b6:208:441::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 17:45:54 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%5]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 17:45:54 +0000
Date: Fri, 21 Feb 2025 17:45:51 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        Juan Yescas <jyescas@google.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 1/2] fs/proc/task_mmu: add guard region bit to pagemap
Message-ID: <f5a896b9-039b-464a-b2d1-eac0ddfcce65@lucifer.local>
References: <cover.1740139449.git.lorenzo.stoakes@oracle.com>
 <521d99c08b975fb06a1e7201e971cc24d68196d1.1740139449.git.lorenzo.stoakes@oracle.com>
 <CAC_TJvf-R6MuSS9e0b4orhxLrFwXTnvZV-vf3sB+BnSbEqsprw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC_TJvf-R6MuSS9e0b4orhxLrFwXTnvZV-vf3sB+BnSbEqsprw@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0072.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::21) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA0PR10MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: 13c53943-377d-43db-8c6f-08dd529f96cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlczOWZUa2g5QklUVUdCMjBRUVBQZUttZExsWlpvSGNLY1F0Uy9uLy81eUFt?=
 =?utf-8?B?bzlRTllNYVpFWjZPSm5EeE9Dbjcyb2QvTktzMnpKVEwxUzMvZHJvaEhpOFp5?=
 =?utf-8?B?WlVDZWdLSU1aQWZjY0dJS05CcU1MelkzaXE1TE9vRkgxWVZmN2VkM3NvOFVC?=
 =?utf-8?B?czJmcHF0UkZWdzluRGgzb3FyT3VuNUE1bktHKy9IWWZzTEVRSUZ5VFh1NndO?=
 =?utf-8?B?dXZ5RmJuRjRrQlAwQWQ0eEdpOG1RYmI1SC9tTUh5WnlYMkYrWWs5NmFCUHQz?=
 =?utf-8?B?SVNaYW92ZDgraU15VS9IZ0tsaitQb0hJVDQ5aTlBMW1lVEtRSEUycW9qTUZh?=
 =?utf-8?B?TWVRKzVwbzBpWi92eGUxSURQeFlvZEFDZWh4cGxmK2JmYTZLVzdmOXNEWXcz?=
 =?utf-8?B?b3RTUHdaVCtEK2dOY2ZWT3l5ZGpoak55eHJtYUpHcGFabzNtTFA5eWp5Q2xa?=
 =?utf-8?B?K0dKNWEySUxSejBLcFlmTGNFL3ZjUHltbUJ4NFl4N05JMDZMU1F4VUtPcUM3?=
 =?utf-8?B?ekVHcFFTTW0rSi9NTHVKWkNmN21jYlZZZzJhblplQURDNTNNakN0Z2pMbTY5?=
 =?utf-8?B?UWhjTXZxQ21iRUJSY0Zvczk5NVkrZmxuR3I3L1VzWThmZ0JSMDBGbGh5ZDlx?=
 =?utf-8?B?ZExjd1lwY3cyWEhZK3N0RnBLTmFEeXgvSkd3RkJvSDJTSEVSTEJ3MmxOUUl6?=
 =?utf-8?B?VHJIWlltVVR4QUxWcjZKWUFJVkFUaTd1Z2ZEbFg5TXo3V084d2x5SHhITEJh?=
 =?utf-8?B?QU5FU3d2djhWVExtWStUM3ZEUGgrQ1F5a1FZek1xUGVTa3hkaWJSRlBtb2pk?=
 =?utf-8?B?cVdMcnJtbDJ2MUl3OWVzNTlBVWpqaXhhY2g2Ni9RSE9kL3oxRG1vQlRqUEps?=
 =?utf-8?B?SjhvSi9RWFpuM2R0TXoycG5JSDk5UUs5TWFtSTNzZUQrNlN0aHpCQmhvUHNB?=
 =?utf-8?B?dGcvUUZRSlZjYmNwcktZVW8yV1RyWFpxcEI2WHBhalZ4UzN3dmdvUXRhR2VD?=
 =?utf-8?B?RU81UnczWEYvNWlYMnV4OTF2U1N6WFhrRzRpdGZXbXJ1UnUxVjU3eUJlUnpn?=
 =?utf-8?B?SU5HT2dCVmtoWEJNUVZocFF4d1JlQnpEb2ZXZVp4RHkzK21wZlZSRm1Wa29p?=
 =?utf-8?B?dmpudUhuL05BVGM2b2xzQmV4VkNIaDNhdjRqREczaTN0K3krUlBId0JXMktN?=
 =?utf-8?B?dlVKRDR4RVZhaEl2UVZIdExEYUZXUVJneWhkYms1UjlDR1c1VlpyMzd6eUIy?=
 =?utf-8?B?by9WNHlGU2hwTUhVNHR4MXFKdUdjei9yMG1XNHI5eUdOMUtRTEh2Rnp2UUhh?=
 =?utf-8?B?VC85MEQ0aWxhQndXTmtDYWxEQ3BsUkVKSk5pVExpTHJHbmhxakw2WEVwc0pn?=
 =?utf-8?B?OXVVSThQWTJRSGR0NStzVUxMY3J4b25Jb1d3b0hxNXIrUEdDbDlnd25xd3Bj?=
 =?utf-8?B?RXVPdzh0RVJaanBhNkg1UjkzYlNHVGgzSHRoQUZQNUY2UDhjUG9ra25YZSty?=
 =?utf-8?B?MVhGbis1N1YrbnR3RDgwSG9JR1RQZGxvU0pJSDRmc2RRWEdVb1pLTFVlMktk?=
 =?utf-8?B?ZHRYZ2ZTak9QWkhSUEx0TUgvRzN0alQ3cTFjRFJJWHRxdmo3TFRQcFVnTUUy?=
 =?utf-8?B?QVlhYTk2SExHNzdlT2JTWXJJQ083WlIxb25Rc2JLdFVoeExwWUp4R09VWmo4?=
 =?utf-8?B?ZEdENDF6N3RIa2NtQWsvaWJnK0sxMDZPNTVzMm9TM0I1RUk4NkdQSFRvSDRK?=
 =?utf-8?B?MTJvQU5aUytTcVV1RjRkQ2R3b2tJRWJBSVoycXhGK3piZm4vYTdGQTNxVmZh?=
 =?utf-8?B?UmRxdlJFNjR4TXBjZFo2LzNmL1FMVVkwelJPVGF5bEozYkI2T0g0SDRFUi9R?=
 =?utf-8?Q?YEz092s+7DPTU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MS92Q0VhZnhjZ1BhKzRXNWlkSTF6amVLdVJ6WE51R24zaFJ6VkpmUDdpOEJW?=
 =?utf-8?B?RUU4eW1jZVBNSmRWOFBrNVlMOVdrazYwYk5xVFoxOFBRT0p1cThmaXhsWjNi?=
 =?utf-8?B?NkxEUXFBSVkzS1ZrYiswajE1bm9TL0pycUhHVnBtam1JVmZXN1FGaFRER0Fh?=
 =?utf-8?B?S2JwSDYzRHV4QmZrb3BkcmZJVnFvUVp0eVQ3NmZEcGNXbHNlZjJxK2ZFU0dM?=
 =?utf-8?B?QlI3K3NwSW5CdThLUGhaZWE5MHRZRnJKTXlaVzhBUHlMSVNtSlU5L3RLVWx2?=
 =?utf-8?B?NkJwVk5DMlVRSTVORG1BRC9JdGpQUVR0WUYzK0pxTXVmVjFJMHhVK3JCa1Zk?=
 =?utf-8?B?NzNVdUFPdGpwSFhGL2pIbTVRL0N5ZUhSOHI0OXhmNzBrVHkxc0Y2S3Fsd1pk?=
 =?utf-8?B?RmNhTHNZcXd6eW9Id2RSL0xGbEs4UWQycDlkSDNtVFZMMUFYeWYxbkRvNjhZ?=
 =?utf-8?B?bFVvVmovUnVRNnhMODRPb09JY2lVTWZMVkg2MEVJbDFqQjV3K2YzRVBBUmRh?=
 =?utf-8?B?UXJWVFlOSUxkNlRadjYzRW9nNEd2dGdRTW5jSm9IU09mYnl1V1p6a2VRdFlh?=
 =?utf-8?B?RTRCamt6empaa1ZudzZqUHNrVExmRHlhdVhEQmNmL1RKTS9rRm1jMTFOVkgy?=
 =?utf-8?B?NGlrdWJOKzNsL21Ma1FpbVEycnNnY0s0QUhHWXlaMnpidVVGRUFhNkpUcEE2?=
 =?utf-8?B?M240T245dExvN0dEd28wcnQ4bkhRVlk2OVoyRGhYWks0b0U1STlCMzFCaHFC?=
 =?utf-8?B?bDFRZ3M5NFVLa25jTnJKMHNKQjBTVVpvRDNWYnl1b29GRVR3SUYzMTQ1cWdR?=
 =?utf-8?B?UTEvamVoNk1FSGYvN2QvUkd3dFE0ZnBvREN0MWlNY2d6MVd4TDFrK0p2M21E?=
 =?utf-8?B?UDlaUzd3UngzM2xOUmxHY2drVEhFQlZZN0t4ak10U0c0bFBYUDNmQTBwMmVp?=
 =?utf-8?B?UFE5ZmlKRTZWbWhTRzlLZ0UxMWtqdlR3M3l2RmR6c1M4cmRna0xnMFptTmp1?=
 =?utf-8?B?UEtSWHNndWs1U2xYWEYvb1ZrVHlvMkVNeVJmVDB4b1NGZFFrY0hBcFZ2YXBq?=
 =?utf-8?B?ckF6eS9kTy8rVTdqRWtkc3Q5c3NyclhCUTJyZWwxa0MveEhDb0Y4TnYwM3VN?=
 =?utf-8?B?bnkza2xyeGxJM09DR0xDZ29ENmZ4TzEyNFJ4L3RaVk1mQnBXdkNnMEZidmVK?=
 =?utf-8?B?R2FlbE41dW56R2kvZ3lmdElsRzU0R2VwbHBVTG52MUwwSzFnNW83b0VmaHkw?=
 =?utf-8?B?UUVUSzhqVXVESHRtUCtSZEgvMURpcldEYVJQUkpGVDBYK0JzZkhYNHlUVEpT?=
 =?utf-8?B?OUIvaHMvd0NOOXVmWDI3dEhkRlN1TURCUDliRGV1dXQvckY2Y21UZm1ycGx4?=
 =?utf-8?B?Z0x5QzVjYUtsMHB6SUI2VG96VG1IVWFId1VtRk13UjZOUjBJa0t4eFZGQkwr?=
 =?utf-8?B?bjdSUjBTbXZ6TkkyNnBXWjl5M1hlYUFPMXM4SVRHcFRyRnEwS3pvaFRaOUll?=
 =?utf-8?B?L0RISmNWVllGUCtTMG0wdTlGdDdvQ2VYOWtKSXhYcW5IcThIVjM3S3M4aFdp?=
 =?utf-8?B?bE45K2JlMWpvcml2cjVtUjdSYlc3eExBY2x0WUxsbW5CY1Ixd0kxbXdiNEtx?=
 =?utf-8?B?ZFF4YzA1eHVWYjJ2b2gzWnpBMVM3eFU5ZjdLMHk4YWpSZ1U2NytjZHZBbTFl?=
 =?utf-8?B?L2VBUjhmUGsrZkpoZmcxaHBhdHVZdGFqZHp5N0M5YU9ndWI0T1M0anlwNG1F?=
 =?utf-8?B?RVovUHJDZEdxMkE4MS85bVdyWGRsa2VFc1NSd0ZhT291ZnIxZGxDNkVzN1Zx?=
 =?utf-8?B?bUcvTWVDaUNERmJrQUMxZUYzNnl0QnRzdW1WQmJiTjVRSlc5OW5WbGdicXEv?=
 =?utf-8?B?UmZBMWN2Y004YTFWOUlIWmkxUC9JeXlTRVdQRDZmSnJueXV2YWNDZkVDbEJB?=
 =?utf-8?B?U0d4Yjh5RkNKRzFnYWZoWTNZOXovTlZQR3B4UkpzS0RxMkZjV3JMd3AzcFFH?=
 =?utf-8?B?YmoxdXNZK2RTUk1MZmJjYWJUY29TdDhqd2FwNUFSbVN2cklLSUtpZEszcENs?=
 =?utf-8?B?UHp5Wmh3SWhRd1Nxc1N3TmNQdUhUNCtFN1hod1JGMzU3Q1hENDNiNzhRTHhx?=
 =?utf-8?B?L2JSR0IxS0NEcTVDRWJLUkhiR0Iyb0hLNHJIbjZpcEcwOHorUW1NYTVkRkEz?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CEPaUBiYuPUt5PFcjkH1c5avdAUrRnujFEd5pnVHZ9gAa6VoT6jbANHNJapHyeQJ9pGNqkthCVxvpKwrFPj/H/CYzLpT8mTmKH3w9cOojxaaOuhYPHtK3MUa0ThJN4P57i74XfUChQqd5KTNqJvc8j1F3QEAdr/vWgeUp7RKqrZ0uhKFQuXYy9MDkrp9YhuSXTJe0vPMRfKEK8pH4OScHI8/RI8LBmVyHiIIJx4T1k1pzBHR/Qw2Ih3qg7CLMSkYoGq7xlaiiLV0famCeGYlP9yT7xP3g/PTXXrHktMPwE5IM1O8+ZoKiAdpMGc9YOaHkbib1DjA6Hyx9Ei9F4GT7R6OfP1zbzTdbiCGBt3S4WbM902VWrwegbHWAt+5mgFfEAx8I5RseuEqePiXI1huJZ8A9Z98p/rPtvgLJGeXhQ0Kv0/MuUFntuPsLH3UvF6cb6Xqv6iwB8h1VNEcwoyZk/YRm9O5cbwpfhvDfvknsl5g/sDbNTFss00t46IASZRb4lFouh5+GS9C1scbW9caZ9/YEUylqfc04dZbZAjhQheCgWt1JNLC0jxjJhbsoxAKzZgpXAJtLtcP2+QeYoV+d4aKv53vm7mWCKvpzQ+XjVM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c53943-377d-43db-8c6f-08dd529f96cf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 17:45:54.0958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AgWWZZClVGT3MknHHWRWoJUaHqLe8DrEUeskVLVjhkNvCrkjuIOpcBTAFr+mERx26vqiFyU3mQwfOy4oY8EA/+N0tQ5pBL532GclmUOiveA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6721
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502210123
X-Proofpoint-GUID: ieXQxoqA1Q_GaSQckGg3zLzPLuxe5OEw
X-Proofpoint-ORIG-GUID: ieXQxoqA1Q_GaSQckGg3zLzPLuxe5OEw

On Fri, Feb 21, 2025 at 09:10:42AM -0800, Kalesh Singh wrote:
> On Fri, Feb 21, 2025 at 4:05 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > Currently there is no means by which users can determine whether a given
> > page in memory is in fact a guard region, that is having had the
> > MADV_GUARD_INSTALL madvise() flag applied to it.
> >
> > This is intentional, as to provide this information in VMA metadata would
> > contradict the intent of the feature (providing a means to change fault
> > behaviour at a page table level rather than a VMA level), and would require
> > VMA metadata operations to scan page tables, which is unacceptable.
> >
> > In many cases, users have no need to reflect and determine what regions
> > have been designated guard regions, as it is the user who has established
> > them in the first place.
> >
> > But in some instances, such as monitoring software, or software that relies
> > upon being able to ascertain the nature of mappings within a remote process
> > for instance, it becomes useful to be able to determine which pages have
> > the guard region marker applied.
> >
> > This patch makes use of an unused pagemap bit (58) to provide this
> > information.
> >
> > This patch updates the documentation at the same time as making the change
> > such that the implementation of the feature and the documentation of it are
> > tied together.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  Documentation/admin-guide/mm/pagemap.rst | 3 ++-
> >  fs/proc/task_mmu.c                       | 6 +++++-
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
> > index caba0f52dd36..a297e824f990 100644
> > --- a/Documentation/admin-guide/mm/pagemap.rst
> > +++ b/Documentation/admin-guide/mm/pagemap.rst
> > @@ -21,7 +21,8 @@ There are four components to pagemap:
> >      * Bit  56    page exclusively mapped (since 4.2)
> >      * Bit  57    pte is uffd-wp write-protected (since 5.13) (see
> >        Documentation/admin-guide/mm/userfaultfd.rst)
> > -    * Bits 58-60 zero
> > +    * Bit  58    pte is a guard region (since 6.15) (see madvise (2) man page)
>
> Should this be 6.14 ?

We're aiming for the 6.15 merge window so this is correct :>) I don't think
this could be considered a hotfix haha!

>
> Other than that: Reviewed-by: Kalesh Singh <kaleshsingh@google.com>

Thanks! And thanks for review on the other patch also! Appreciated.

>
> Thanks,
> Kalesh
>
> > +    * Bits 59-60 zero
> >      * Bit  61    page is file-page or shared-anon (since 3.5)
> >      * Bit  62    page swapped
> >      * Bit  63    page present
> > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > index f02cd362309a..c17615e21a5d 100644
> > --- a/fs/proc/task_mmu.c
> > +++ b/fs/proc/task_mmu.c
> > @@ -1632,6 +1632,7 @@ struct pagemapread {
> >  #define PM_SOFT_DIRTY          BIT_ULL(55)
> >  #define PM_MMAP_EXCLUSIVE      BIT_ULL(56)
> >  #define PM_UFFD_WP             BIT_ULL(57)
> > +#define PM_GUARD_REGION                BIT_ULL(58)
> >  #define PM_FILE                        BIT_ULL(61)
> >  #define PM_SWAP                        BIT_ULL(62)
> >  #define PM_PRESENT             BIT_ULL(63)
> > @@ -1732,6 +1733,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
> >                         page = pfn_swap_entry_to_page(entry);
> >                 if (pte_marker_entry_uffd_wp(entry))
> >                         flags |= PM_UFFD_WP;
> > +               if (is_guard_swp_entry(entry))
> > +                       flags |=  PM_GUARD_REGION;
> >         }
> >
> >         if (page) {
> > @@ -1931,7 +1934,8 @@ static const struct mm_walk_ops pagemap_ops = {
> >   * Bit  55    pte is soft-dirty (see Documentation/admin-guide/mm/soft-dirty.rst)
> >   * Bit  56    page exclusively mapped
> >   * Bit  57    pte is uffd-wp write-protected
> > - * Bits 58-60 zero
> > + * Bit  58    pte is a guard region
> > + * Bits 59-60 zero
> >   * Bit  61    page is file-page or shared-anon
> >   * Bit  62    page swapped
> >   * Bit  63    page present
> > --
> > 2.48.1
> >

