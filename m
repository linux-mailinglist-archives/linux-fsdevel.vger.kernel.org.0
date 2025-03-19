Return-Path: <linux-fsdevel+bounces-44474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BE8A698C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 20:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 411267A3FA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 19:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87C3213245;
	Wed, 19 Mar 2025 19:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m5vdCV+G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xX48XyDN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE1F1B0F1E;
	Wed, 19 Mar 2025 19:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742411596; cv=fail; b=aK2j5MVUSDrglljZiRdPWoK7RDgFJlYp+Ng76ft3JXwqIq3er2Np5i8TW1mXqfVZQzE3b+knOn9RNVjQK4k2QvBHQz/jBq073tSGFEkz0fU6oUN6KJSem9/bmaIHlCUBzSbpy4DzWpQq9bsplqgsbOR/JfrtN1N67dg1Pj1c8gY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742411596; c=relaxed/simple;
	bh=kWUn+F+ZUJHzqFZ1IfaIxXcAlH1zowzxpnl+tfewGG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=itJbU+vJcJ5Vvc2X/jS8NIsad38nmi5P7AGmT7suHJjidZznu+TLhe7cfXWopAU8Qe9hP5H01x+OmsUrK82Kddz7IM68AFV9NbSviKeMigt3Mg3HnbzXPmimSbvrAQN3XAOUV8XvSDETZKAZsefMCo0X0vNuu5VdjP2zgaanmxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m5vdCV+G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xX48XyDN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JH0sBs012161;
	Wed, 19 Mar 2025 19:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=h6OzWPmsi6tg30rdXGdMzkQ8YDnuGC/WhwLMDZ5wgOA=; b=
	m5vdCV+GUBe8gYUMYV47McGjynFu22vFq8Fo79XqV38mk/WvumUNpDC826jkXEC7
	gDk8lFoiR4otVZxQeY85OlabHvjkErfm7I43vc7SrrfrbGHw6gc5xFhu9/0KsdXz
	CNX2CUVW7v6SH3uWehFFCmvQPpl5lGflkicA5txOfCWcXVtoavqeS1Y0t6aIpxSs
	F6Si53T/5Eoi7/gNWInycJ+eaMNWGD2MaNZBilaeOGP4vIZ1+xWxtEy/7qPZ1JB9
	zzGmJX2+3t3Nq6+H/jUDryKRzS/2gmUUsP/rje0VqK+cfn8td6CHeA2LucwwHSwi
	5AfeRy8fVGR/uRhWjB9Mww==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d23s47ge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 19:12:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52JHgSCY022502;
	Wed, 19 Mar 2025 19:12:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxc7hrb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 19:12:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zFhY14Kwy/Ob/HrBceZJBKTtaSPee1+9MlGfv8JynU0UPVKZW4JxL1VNu3Z/XHt0GChkUTGqzpJDID1VRA4wQmc9LsCIH3B1UxLTOOkhgB3Z6Ib1xCSE3jgHFWQn/s3gOiV2cz+cF9dnxuvzApSsN4WcDiC/0DwlchZHgoA21L0hEWEpzXsxMmQnsM+RFHdh0VvQGw0JbXkfYqh6lRs2raHyLTtCm1B2pz0dPCp/694bXVb+knbDoqwgLulMJlJCMjp9MR9RBaTwc1BnaXrjUnfbIY1RbIRatpr3sS8VKi5Eds1xklM6qB1oCB1ru+GZAG5YYxi23+LKmqTYYbepdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6OzWPmsi6tg30rdXGdMzkQ8YDnuGC/WhwLMDZ5wgOA=;
 b=yf1lCCsfr5Jlzi1oGzHkey1mtbZQguzcsnxOcvoYgc502nODhEsoTQ1VCFUlnC1nQ6GIcWpstlsNUQOQv2lkzL9WK+Pr/Wlyig+U4O8tnUSY0h/FHjpUTR8oi/1RZzv0lnhYU4cstxrCWMn/hxtsc+hmyucqAlpHbNk0rdHGq3h5QnBlkx5jFeshTJy7vTNkrtD0bRcb8+f5dokmOPWzCC+r5++yBGAd69YZ42CTMRQe1icZ3K+hBZHOfWeSMKlvLNcOjelIAcMd4tXAK2um56FdASVG2NyjEKwVXugNYXSXCXjXwHuChMObn3YX+z9PZgDzTcNhO9ixp/zBM6jx+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6OzWPmsi6tg30rdXGdMzkQ8YDnuGC/WhwLMDZ5wgOA=;
 b=xX48XyDNWX+x7cxx7kxS68DxGYDc0zsbDFEgjkLYFYmA4fpizaeneBEYr2+/H48bQYlRwDsdRZgrkJPliiIgIApuhi0r+tLhIE2Mg5NjFmcNkHWpP61zZNVUCms44ZKspPtUisBeuDDEmVI0rZ6bGWOqIvGVZbr+Ipsfmy72Qrk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7211.namprd10.prod.outlook.com (2603:10b6:610:125::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 19:12:48 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 19:12:47 +0000
Date: Wed, 19 Mar 2025 19:12:45 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrei Vagin <avagin@gmail.com>
Cc: David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        Juan Yescas <jyescas@google.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org, criu@lists.linux.dev,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Pavel Tikhomirov <snorcht@gmail.com>,
        Mike Rapoport <mike.rapoport@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] fs/proc/task_mmu: add guard region bit to pagemap
Message-ID: <10c3e304-1a6d-45ac-a3ad-7c0c8d00e03f@lucifer.local>
References: <cover.1740139449.git.lorenzo.stoakes@oracle.com>
 <521d99c08b975fb06a1e7201e971cc24d68196d1.1740139449.git.lorenzo.stoakes@oracle.com>
 <857b2c3f-7be7-44e8-a825-82a7353665fb@redhat.com>
 <cd57ed04-c6b1-4df3-a5cb-a33078a08e74@lucifer.local>
 <09d7ca19-e6cc-4aa9-8474-8975373bdebd@redhat.com>
 <CANaxB-yMBSFeYcTr-PaevooSeHUkCN9GWTUkLZUNW2vxKzm0sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANaxB-yMBSFeYcTr-PaevooSeHUkCN9GWTUkLZUNW2vxKzm0sg@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0545.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7211:EE_
X-MS-Office365-Filtering-Correlation-Id: def4bcf9-17c2-4b66-6563-08dd671a0914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWVTNzJxNXk0cTl6ZXhERVRNU0hKb2tsaWhhWG5CaUhHdE9OTWdnT2k0OWZN?=
 =?utf-8?B?SWFZQzIyR09VR1dzTGxheS9oYm11N1hlK2U4UHZYMFltTVdnY0pXV0hXSld6?=
 =?utf-8?B?a0hYcE1oWENzZ3hsUzVCVkREZkpBNldKSDJmSHdpbmRHdVlCVU9jZHRjNGxI?=
 =?utf-8?B?NEhYaWpKL3ZXRzJKbG5wcU1WVDIvTzgzR0w4V3l1V0plUXFIRmNVQ1dkK3hw?=
 =?utf-8?B?OFo2S2E5aEREalhTaUdIM2hwK0pPN2lnMDE0UUpJbmwwZ0pKc1Zod1dqSjhK?=
 =?utf-8?B?ZzBEdHlveURUOGdMaWEyazFxditMOVNSdi9CMWR1KzcySmRQRjlrMWhHcThu?=
 =?utf-8?B?YmhReklXV21NV2lVeCs1VEwyVWVrbTBqTUlFYkd0aXVScUNMcllLRE53b1lh?=
 =?utf-8?B?dkpmc1IyeS9TdW9IN1hjaVBaaU94NThnU0hKdVJYaUVMdmRCQy9SMDhabGwv?=
 =?utf-8?B?RFFmb1AyaGNWb3JzK0Qvby8rVExyTnhtc2VFcjc5NXhjVzl0Y2k5dUhkaGU3?=
 =?utf-8?B?aWY2b3J0WVRYTk5RUmJNVS92Sk1WQzFHUlNnanRTSU5LU0RraEVaeHFydlVn?=
 =?utf-8?B?cHU1MFFlMDJkZzRqd1Q3Rm9MSDZTQW4yN0RFME44MndiN2U4Y1dkQ2E3a1dO?=
 =?utf-8?B?YkloMFdENmJtakdhZkNZTWlKQWlHVlBDaFIvaXJVUUFha2QydzUwWGQ2czZr?=
 =?utf-8?B?T3FJUytGVTVVU0ZxcUh5YzJkUjIyRmdVMFZYbjh0ZytoaEFQaDYrS1c2VUNE?=
 =?utf-8?B?WlhwQ0l4bjJQNnY3aFdZbG9HS3A4VXRqMnlHU1E2ZzZBRHZ3dTcvUUhud251?=
 =?utf-8?B?ZmIzM0cxSU1XYlpYYWtlOXZTZVhsS3hGbGU0ZVpkeG13Z3FKQjc0SWt5Qm04?=
 =?utf-8?B?MjZ2ekp3ZEdWUW9jRWV4MFphRlBPWEdkSU85Q09TY0Zqc2pBRXBuN3VrNDQ1?=
 =?utf-8?B?OE5KQ25jVFp2U0dZOVE2eDV6cU9zam5XZ3NIS3JwWERpeC91SHVNVldGd3dJ?=
 =?utf-8?B?bGxzQjRtQSt1Q0twYVZMaDB5UExVMEJiQlMxOXVDZnNZbkJRZzRFWmkxZzVt?=
 =?utf-8?B?NGczb0Q5bEJXaDMvREZsT0xMMTFabFZ3d2lzRmZmK2JOME1BcWtRWENpajNp?=
 =?utf-8?B?RlRmeUJYRWdadHFNRm0zS29WR2FhWVRxcWduY0xscXhvUkNMOXlMZ2ZDWU9t?=
 =?utf-8?B?dVNLdVFmd2tlTDZxNXhIRmU3UnIzSk44QjlYU2ZxZ2RCNjJDajhNUWtiUjVy?=
 =?utf-8?B?cVJZVmR4aVd5WUJFa0w5aXNoLzhCLzczNFFyUDhaYmFqbHJudXh6WnN1SXVQ?=
 =?utf-8?B?MDhhUGhYSWZ6Z2ZKc2JaR0hwbkwzRzVmRXV1dHBtNlVJQlorSGhwQ2ZmZTlS?=
 =?utf-8?B?TGdYbnQwb080YmxxQVhDWXdzaE5KTm1wODhtTmdXbXFpMGl3bGFjUzd3YXBk?=
 =?utf-8?B?UmlnalE0N29xWWttYVpMdTQ4eVF1ZXNROTNhbFB5Y0d2SUxNUVVEVlBRSE5h?=
 =?utf-8?B?MHdQRTh5K3RYaWtEcjlvc1VnRVhJN1dmcWU4LzJaZVp6MXZMTXk0cHkxeXFl?=
 =?utf-8?B?L2h1OXZyd0Zhems3ZzJ3NmwvU2ZXVHBIQkIyYlA2WldyOU01YjY1N214cU5t?=
 =?utf-8?B?NFdKNVVhOURmZUZpNDdSa0VqMUV2QzVJRURPNDM1SkgrZ3FteG9qQnkvUXVx?=
 =?utf-8?B?SjRoeWpyMzQycWJ2MGtlSS94QkRIT0FYYjZOQjJyMnpBNmxnb2Jacy8zdjdU?=
 =?utf-8?B?aWJuY3A1NGRkNEJ0UWQrSzdxOS8wZC9SUkhCYTYvNHg5ODBuZkpvd3VwVkw4?=
 =?utf-8?B?dGRZeTJGWENtanJvVEdnQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VU83SG5XUFFBbSs4UU9kRy9DR2FtN1NZMHNCY1BTdzh2ZXhud1B1c3MrVjlN?=
 =?utf-8?B?djE0akhJdkxSZFd5Z0NrODljUTBFa3ljTFBGbWxkR1FnSFo5R3FUNTNHS1J6?=
 =?utf-8?B?MWUwRkFVNXhMOHB5RzNzL0VONHk4blpDRFVEWVhxb1NrQkErU1pEL1NtU003?=
 =?utf-8?B?d3JTOVdKbGJkaHNPZnB3RGNaNW1HTnZhSTVHc0NicmdVL0wxWUV0bTFWVjhO?=
 =?utf-8?B?KzJFT0N0eUttc0V5am00c1cwVGVSUFVTSUFLRFV6aXRzVUVIKy92dndrdGRU?=
 =?utf-8?B?dytJSS84WWRDVk9qVGJHdEluaFR3UnJWdWk1NU9Cd0NDTXdnWHUrWmdGZDJI?=
 =?utf-8?B?KzlrL0taMjhpNW54RWM4T3JaUXFpWmluVHc2ZG8wODJjbWg4YjBMYVBKZi9m?=
 =?utf-8?B?MThzdW9BMUVKeHg3TVRxRjB1R0RVLy94MXhQRFpMUDVLTzhSektmUGJFT2hJ?=
 =?utf-8?B?clZZbUpOUXVEcTdnSlpMYjJYTWxCSENqRkRsVlJaYTlsVFBpdUZueFJxenRm?=
 =?utf-8?B?bXZIUFhybHlXaUJ3MnpVekhHOGdxK1RycW5YdHRhNG81TWlGZStDOHlCdUtN?=
 =?utf-8?B?dGIraFhMOU0yTkxlVWFPdWlxQjN0ZVVvZlRBT2IrRDErT2FKU0FTcE96UkFC?=
 =?utf-8?B?bGJyeVB4Q3VBSW9wYThDTHJuaFpIWUFsRThuQmpCM0pqWlA3VEJEaXpaY2Zx?=
 =?utf-8?B?ZXVDaGI2VTcvZEJOR2dJMDNZN08zR2RUZU05eEpOWUhITG1wU3pNbFlINjZZ?=
 =?utf-8?B?Q0hZQU5vdXdjRkQyTExxV2lhUmJ5UWo3WlRlR2hOY0JBNm9iYWlOSU9ZYnNv?=
 =?utf-8?B?YmhuVmpNSDZobGw3NVhEUWROek11K0JjNVV3OFgxUkIwVWhUTnpIc1FZZFVI?=
 =?utf-8?B?b2FrdkxYQmorRDQvUGNxR3c0Vmd6Y3VLOHhua0NKdEJNNWNXZ1owaXVrbHhT?=
 =?utf-8?B?QVJVbytwV1dEMjdHc2hYNlVnb2NmdnAyRGVKWFVERzhwZ2k4Z3dQSC9MZ0dF?=
 =?utf-8?B?L05ielJEbDlac21rbGRXSml4U3BTNHlIMHJHRis0ODJaQ2MrRmpkU2NjQzVK?=
 =?utf-8?B?TXAveGRJRG1WdXlHUUhIcVc5QXlHakxNYS9aNFlNUjJuTWhuWEtzV1cxT1Nv?=
 =?utf-8?B?M2xmOERia0o2dDVDNUMrTWhlY0tHTnJUdGZiM1FQTjRDRFJHTnFtZWFqMVJx?=
 =?utf-8?B?b3lzTTRIT0Rrc0MyZFRwOEtPbGxPbHFVZEVBL2xpZGF2ZjJGTFp4bTFVZTlP?=
 =?utf-8?B?L1hJQTgweTlKMUxURlAvL2xuS0VtYVV1NkNkWVlibHdQSFdoNlpZUHpaNDM5?=
 =?utf-8?B?SkRYR0RSenpvamFyd0ZnY0ZxWkFra3E5SFBkVHFOVU1GblVMSkZFYnRBT2k0?=
 =?utf-8?B?VEZTMjFpSDUxOTlMNVNaY1M0RjFzaEVpTnltVHgvQkRBc0o4ZDZWRFp4YjFa?=
 =?utf-8?B?VGIyeFNnRlcxZGh1MFM1MW5rUkxXNjBqZ05WNG5BYjFhZTBmVlZYa1lzQzhB?=
 =?utf-8?B?N2xWdmxGZGpTTmI3QjVBNWx5YTdZUkhpMnNLOVlxWk1aTjU0WXJrR3VBb1hw?=
 =?utf-8?B?dkxJUHFWcGlnVHVVSVJ3NmZ6VFdHaExWMlZLYVlaMS9BaVQwN0tkVWJ3K24w?=
 =?utf-8?B?QjUzakRYTTA0TzVIQndaRDQrN0JmcjFMSXZ3WE02eEZKZzB2RThQQWZuUW1q?=
 =?utf-8?B?YmxVcXpCWmtpZEMrZXQxOG9BelBDZ0l4L2ZIMEpUTGF0SE8zMWpYK2VYS2wv?=
 =?utf-8?B?VVVQR25PR1NySUZWVDJFVy84MCtpQUIyRkQyYXJJZk9vUkpUTFBST1VhU3B4?=
 =?utf-8?B?VFhzM2E1VytiNENFNkxsb2c1T0JzSkN1bFJGL1V0L3dUUHJQSnZucTdWUElk?=
 =?utf-8?B?VEgzQlVOWnpUYk96KzkwSk5LbVJNaGM5Tm8zUmpQSUNCTGRJTW56MHFqTncy?=
 =?utf-8?B?SFVkN293TGJ5TFJzNU5FbUxVUng2dFBsQ2lGTFMzbkhJMXZaZGY5OXBUUmk2?=
 =?utf-8?B?RnhYRnBvRGJEci8wYlN2K2hib09xOWM3L3E3V2tBaGswTHRQYXlDK2c0R2hC?=
 =?utf-8?B?WEp1Z2NXUzk5YWNDb2F4YStESk1pa2VGbDZESVlSYmFaQWpxS1RQRUZMQ0JY?=
 =?utf-8?B?emFpOEJvZUZURk1WY1Y5ZXZkU2pqNGh6SGtBamtzSWNpcS9rZ1NhY1FhWGVp?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VQfuSQyVgxkbmrh9jB2Slp3Tu5TaL5y0xnr6FaaJX0xlDiScYmlhvCOoBHGRJDlxv+17IZb4ElF0TXeoTRZNyodQZscfdjxvQkr15SZye9muIyS/l9vbun8cXIwEvCLGOSJf25FxA8RsMb8aXgX8RZZPVj+qDlcaNH/NiRI1JyOhsx7u6NWKyAyBoUQzE8GcicM5LrjzPwQxrRIXOmk/D7CGK4x53WQByJLKHEn1x+wGncB/7N59p5Lvij5aiMI3vwuNugwYNcrA9zM6BSxrcTGRdkEznWsidJ20MPieXHUsqjBON8+OW/qMnUY2umwTCrD68rSq+XTQ2yrABUI2P1HB5AhbgohGAgY0lDShC0l+Y5yV6wZbwuz6Gbq5KRSyZIFu4wnzYmjF9vtOhKpJXevtjOTanVT84qy2JSIOdKtU5rsE3bD8NYZ+cyuisuOFs2I2ZEvGiEork5C+UvrHozBHHhpCzWf/6w8y8hYJJ3CkVG0MAkZLvNS6qLNT2kKoGqVuPlgM3DVNLTb2s/T8Q34ryREAK0T8yQ9w8nF4IqVKmXzBPjOt7nmj2SWXJd5X54zZ4bZztl9N9R55m5Yn6LUMHTEuJCpvS9yAjwUEnr8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def4bcf9-17c2-4b66-6563-08dd671a0914
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:12:47.6528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7Yzc2jzEzwblicBran11f7WPlvX+R6xoHFLizjkg7uDXIq03oCnN1LQvLQjUD00cWfBdxW966qfzSeZ2YSkf5fntEq1iQRWS+zGPh8Ru6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7211
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_06,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503190128
X-Proofpoint-GUID: PETW3lGC2LqfcR2YqkalJfG19aIAX2Mr
X-Proofpoint-ORIG-GUID: PETW3lGC2LqfcR2YqkalJfG19aIAX2Mr

+cc Greg for stable question

On Wed, Mar 19, 2025 at 11:22:40AM -0700, Andrei Vagin wrote:
> On Mon, Feb 24, 2025 at 2:39 AM David Hildenbrand <david@redhat.com> wrote:
> >
> > On 24.02.25 11:18, Lorenzo Stoakes wrote:

[snip]
> > >>
> > >> Acked-by: David Hildenbrand <david@redhat.com>
> > >
> > > Thanks! :)
> > >>
> > >> Something that might be interesting is also extending the PAGEMAP_SCAN
> > >> ioctl.
> > >
> > > Yeah, funny you should mention that, I did see that, but on reading the man
> > > page it struck me that it requires the region to be uffd afaict? All the
> > > tests seem to establish uffd, and the man page implies it:
> > >
> > >         To start tracking the written state (flag) of a page or range of
> > >         memory, the UFFD_FEATURE_WP_ASYNC must be enabled by UFFDIO_API
> > >         ioctl(2) on userfaultfd and memory range must be registered with
> > >         UFFDIO_REGISTER ioctl(2) in UFFDIO_REGISTER_MODE_WP mode.
> > >
> > > It would be a bit of a weird edge case to add support there. I was excited
> > > when I first saw this ioctl, then disappointed afterwards... but maybe I
> > > got it wrong?
>
> > >
> >
> > I never managed to review that fully, but I thing that
> > UFFD_FEATURE_WP_ASYNC thingy is only required for PM_SCAN_CHECK_WPASYNC
> > and PM_SCAN_WP_MATCHING.
> >
> > See pagemap_scan_test_walk().
> >
> > I do recall that it works on any VMA.
> >
> > Ah yes, tools/testing/selftests/mm/vm_util.c ends up using it for
> > pagemap_is_swapped() and friends via page_entry_is() to sanity check
> > that what pagemap gives us is consistent with what pagemap_scan gives us.
> >
> > So it should work independent of the uffd magic.
> > I might be wrong, though ...
>
>
> PAGEMAP_SCAN can work without the UFFD magic. CRIU utilizes PAGEMAP_SCAN
> as a more efficient alternative to /proc/pid/pagemap:
> https://github.com/checkpoint-restore/criu/blob/d18912fc88f3dc7bde5fdfa3575691977eb21753/criu/pagemap-cache.c#L178
>

Yeah we ascertained that - is on my list, LSF coming up next week means we
aren't great on timing here, but I'll prioritise this. When I'm back.

> For CRIU, obtaining information about guard regions is critical.
> Without this functionality in the kernel, CRIU is broken. We probably should
> consider backporting these changes to the 6.13 and 6.14 stable branches.
>

I'm not sure on precedent for backporting a feature like this - Greg? Am
happy to do it though.

As a stop gap we can backport the pagemap feature if Greg feels this is
appropriate?

[snip]

> > My thinking was, that if you have a large VMA, with ordinary pagemap you
> > have to copy 8byte per entry (and have room for that somewhere in user
> > space). In theory, with the scanning feature, you can leave that ...
> > scanning to the kernel and don't have to do any copying/allocate space
> > for it in user space etc.
>
> PAGEMAP_SCAN doesn't have this issue and it was one of the reasons to
> implement it.

Ack.

>
> Thanks,
> Andrei

