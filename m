Return-Path: <linux-fsdevel+bounces-47509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF52A9EE45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 12:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 879747A8C38
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 10:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DEF224244;
	Mon, 28 Apr 2025 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n1VbAPbp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R6slzjSm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711951FFC45;
	Mon, 28 Apr 2025 10:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745837189; cv=fail; b=vA93K4mwlzHexdqEN23RqVIVH33V2uWYFdA6WTL2oyCqZ6RukvNsiLGRW4rv0YlNHE/hfoJBTXI/464FMgGRyW1WEoFAYD16kl+qqilww2qvtq7CqoZ2PYx9mrGw4uUpjCw8u6YHVR26/O6WQTW+Qzak8Dtr4zQL1s73weTUypM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745837189; c=relaxed/simple;
	bh=ow0d+7OGh16r5F7Wr4EVZvzPAJvfj6LveYBryGnWTiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=APLjxZqvUc5VBhcF5LdKE4gjRnfl9LWu+j+U7hC79fpDeBc1hvHESPHq7SsMEf/UbkiBy6vzEHZXoI79kG2h2peATANGO7Rtm+hovGDL91aP8afM07cuS1gNv6CJX38qIDSZ1zyoioELbrFKQVilyB1YzOhK3ZaTRZq0xDNZ1AA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n1VbAPbp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R6slzjSm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SAX5Wp027756;
	Mon, 28 Apr 2025 10:46:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=NqIA6rMGVbB+dVewIW
	pHNFdkx12niiXMt9nnoYuaezI=; b=n1VbAPbpxbQXq0ZR0S7nO6MIxickkP7J36
	1V/jxoc3/IKFgd/aIfi9JEwJMXTNq0dwSEfGqLDaUxV3ih149q2mWE+m0Sa5D2rh
	4ClHsG4F6nBU6KnpJgc32v3wmbo4Kb+SeQ0p5iNRSxaYJoWblms9eS7KQkKZ/dHx
	ZOGWhWuaOI9UBp5XfMFl0thl+C/LrpmImBVrgVExCw+oPKXDO2e+EEBND9uhih5v
	vV82RYWjAF3KJt/fBhWcyQOMj2JCm4FdaQNHQzFS4jV3m/CKnN03vZzAyN7ztREc
	ZLOB7WfWB3UshI4Sk9+Qtby9zX2AA0cTsLaoEFSC5AhR2vpjOWHA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46a815g0k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 10:46:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53S90eww007773;
	Mon, 28 Apr 2025 10:46:10 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011028.outbound.protection.outlook.com [40.93.6.28])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nx80cwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 10:46:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sp1Vfd50sAXJw3VG7v2KEjKJR7ZYC0zqD2jb8Uhh/2T9073fZuaVdPZBAUrvtXMuJhejWmU9myArwpeBAU3MeFuf5Y9TEj1nJfrvtX/y/g+ZaMBCrqTsLDmVdZbd+h9rRv1oqe1tspN2SFTfSqAgJQ7bfWmO5JgQx5TClTpYjab35wHNddtc2N1AWvQE8FryO8cLVj5tcSebRiuwcMlLlaNEuEdlZm/H/X3CLxTB80FWpvvGs1CeXcjGlwTqpaVPStblLPwLWx8rToV3RMwrqAiHaT92wq/C/LzqB7mpGcWPxbdF4S9ZYG9yDf8pP404zC5yH5nU3+xP2RALt8Fa0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqIA6rMGVbB+dVewIWpHNFdkx12niiXMt9nnoYuaezI=;
 b=yE8I+RpUMshUTbdUYtBr7OgJy3WUxGqjf7l1UdTXP8xNGAt83X1klJa3V3vXmP1NLlzN7qKavpLdtgLo0JQmKoxKVPKwKDVdZc+Sd9q1qwSDwrU4klf0Z2/N1iVnqFdlKJorxTFbDXnWJHka3ThlbtqeQY3TvSCifvZ4Rr1EDO3yAbhXYkvuGqUqsB3RFkpH1qFao0+QyeBQWsx8IurkaBWUmvXwlDfOwEDyIrjKvBQOuTyFJhtXefiLdShBsZAXvSphNQ7FD/D2F0EJDh2+cRo12rwLmCGgOOWyPEoFtxMMIDGrs1FUbad89KTfvTf7RZ5WCiA6tHar5dbj36x4ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqIA6rMGVbB+dVewIWpHNFdkx12niiXMt9nnoYuaezI=;
 b=R6slzjSmwDJJuA7xoBY651PUTevBLeFuJ2YYC8i3HdmUvyothHJy5F9ya4o5NNgOk8Q0XdKImf7H3fQ7epbEIFpck1Iq9Y/rZp5ihl7eGfblxQPRfY1RbrYSKYFThAjMw5HoEBqIk/+xkFwjjEiBnAEeyobxfpcanc2IP3olm18=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH2PR10MB4165.namprd10.prod.outlook.com (2603:10b6:610:a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 10:46:08 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 10:46:08 +0000
Date: Mon, 28 Apr 2025 11:46:06 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kees Cook <kees@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm: abstract initial stack setup to mm subsystem
Message-ID: <4941ed00-09a4-4926-b7e4-9cdd70eed281@lucifer.local>
References: <cover.1745592303.git.lorenzo.stoakes@oracle.com>
 <92a8e5ef7d5ce31a3b3cf631cb65c6311374c866.1745592303.git.lorenzo.stoakes@oracle.com>
 <202504250925.58434D763@keescook>
 <8fc4249b-9155-438a-8ef8-c678a12ea30d@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fc4249b-9155-438a-8ef8-c678a12ea30d@lucifer.local>
X-ClientProxiedBy: LO4P265CA0133.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH2PR10MB4165:EE_
X-MS-Office365-Filtering-Correlation-Id: 131b8bed-1d42-4268-ae63-08dd8641e246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hJ4p6GhOubjKbg74NI6l0jakLdO7vvjejhVhwTOb7KreRgwPd4wHCXBvTvZy?=
 =?us-ascii?Q?e2tWHNi1ZlILqU4p2fQzKXGv6hsqmiHFCt3BCqcBrU7bkedgebm2BpzXasic?=
 =?us-ascii?Q?nSVnCzoEsrdxCmLPM1uTHO1CaagdT1UKQEpG1WsDSoPdKAsMsM2y1oUJxaCA?=
 =?us-ascii?Q?pKyCHZ4qMbknD7W9UlQqsLA4Deth5f2E0IzmoV1MrktQY/0VNqUfnD5nSK8v?=
 =?us-ascii?Q?w4LXhWl3QftcEzs8Y0RFlYLVXnVcEeffdW9w+WZQlMqGcftV5hTy3YgyvzQx?=
 =?us-ascii?Q?qIhB4Ma5SSFqW9F4GSQSrmOoeQXu59p/QP3kLc/jrF3rB71J9Xbb2jXG9WDk?=
 =?us-ascii?Q?sSyBtg6HMRIlWIAltpvHRQEsAQ55h38us1AdMYENORsdcIiYmFfZXHMzyHdP?=
 =?us-ascii?Q?FjcY/BNsrCoOcc961TQVlDDElg02nrAsdSF0ROnblu6m3HyNe9v0cpDI/3pf?=
 =?us-ascii?Q?T8w51EF5ngsN9P2g+2lQ/tdiAnzWGR+0aCvotjg5abPVVsZrix2Z87npNQM3?=
 =?us-ascii?Q?zEPRv0Gq7z6pXAe1R0nf7XHnq13Y2ZztUa7A7vxgW/2JQnohKTRnywETy/TD?=
 =?us-ascii?Q?xe3LM8t5AejO7oF8JAJm+WzcWyFZl+bEGEgO+k6EmdBDkPnc9ckbiX3dFlPA?=
 =?us-ascii?Q?BcNTqkGq3cEWzsSWMHVRw9gcRZx/rHD9LsBzYkPuQhvpYfIb9xY4OAVmWUEZ?=
 =?us-ascii?Q?hFEsSXR8Bl53IRgdYJ/kNhIn94K85/YUJf5CVPCeg09UMyG2PB2RKcjp4Oo8?=
 =?us-ascii?Q?l7Y0nfkaEgvpXsXDiF2pWBmuU3TXTXKAyYNSZX8BUtFdvkkkOeVBX0D9rhH3?=
 =?us-ascii?Q?Fn6joeQbrJ3rQeHZQUiaE1n9yvUNJTAv1eMUchQRtZHH4+GSjAMsWb+fQI+C?=
 =?us-ascii?Q?Hv7z7xMfXJFzUJ51lC0R5GGGUnEkHB7bvgsQySqYLCCNcYwc7sEy4dxOciQQ?=
 =?us-ascii?Q?T1ECKZrl+EcomQB7gu1PwL2t31dslyKQ5wKtE6ZRzYe6P2UXlGOlXbckwGus?=
 =?us-ascii?Q?Ys/ylXhXsRj3L/vfHx6YVEVFtX0XXRQk4/lQ0vKIWmGGlmjYsN7sPGnwQX+i?=
 =?us-ascii?Q?GZhF18K12XElKrFZzK9APrdJcnessu0Wx93BjhMySFiw1nfj6Nrvm9j3rgx8?=
 =?us-ascii?Q?7grbM0ClaffvISpnnfJLryF5Ul5uYLfABIItXKI0BHJzOAZBHU5QvbDIZyKs?=
 =?us-ascii?Q?rIUAz9q/DEAtz8yAYRwpUB5zGM2j1QF9cOTmJwm/rN9An1k6ag6OMU4qlgRw?=
 =?us-ascii?Q?jggDNUeVJBPULn4KJa0Dotw4NLigzq87No1AMiwInanZfO33Jz6xVGtlYKCl?=
 =?us-ascii?Q?/x9A3QZeNaU3kSx+nezPgsKXHqzxDX6jhb7KCKm428WUJEYdyME5yuLpDoi0?=
 =?us-ascii?Q?Ki702sweeQRKIavrWDHQpNHPKVCpDMYxV9P+9fMirKIca/GbPVMpiDHaPhf5?=
 =?us-ascii?Q?KpiR87x118A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j+lFLaHZC9jEsNs+orYyWodBGPWfFKtncdKzEJJ03hxSEfSWIWSVjAQupRh4?=
 =?us-ascii?Q?absI5Q8Jp7WwC0/oJf1/zAoffiCnZSm7SblpHiER5dGZsgSAaSznlMknNcsw?=
 =?us-ascii?Q?uiuAAfVgfSA415girl59Vd8GJynpbvxk5oFgUVjY+5PWWJCmq2OGX0GP19MP?=
 =?us-ascii?Q?lxkgeTlGzVb8cUOphTA2YPVNMiMzHEAZcwFShgh68B/BMqxg7u0Td7Rhpypx?=
 =?us-ascii?Q?wepzU5RWfGW8YOQSQbnF50/vIjDcj6bHUbn8s8fw+/21sxYxXV7gGLsVuNdy?=
 =?us-ascii?Q?zIJVHXeB33MMISIXPlli1igAKxtHncawxis+KO39gKjsxKQbkSkAOOFNhlKw?=
 =?us-ascii?Q?QFGMCB8iqeQQRk5XGAt0VO7SDTGY/7JW5CT1Un0WB/9A00U1hx52d1NTn38o?=
 =?us-ascii?Q?hSRLxmFgVT17cXUGySgPzc7Yto+WWo8xlysV7MMDs8fz+x6N25weVfkPpHDS?=
 =?us-ascii?Q?X12WNbrK2dL6kulT2LPEq070B4QUVVTTN8RtMLRYROv9HeIUZS5ocglGaRnb?=
 =?us-ascii?Q?LgOylicPy1Yg/x1Gln8KsGfuO8cuzFDUFchsGc8Grlbu3ScJ9svHrfkZFLit?=
 =?us-ascii?Q?6YV9VpArhrW0kJFtWE8vFYknA9GoQ9r+L52eEO+b41KT9pmdcQVyk+PTRIfr?=
 =?us-ascii?Q?a09dEyZFEycOTBF9OtwDEbKuM0NswRexLfSU+hjEd2s5bdFqwiiGYGQkJKze?=
 =?us-ascii?Q?szOlbs9h7/N7G7fo+StOb5SKaMfnRgUmXquxs/H+42xFKEKiJMbpIIKGdsAZ?=
 =?us-ascii?Q?pN4U1i3RQuihhJfrvOJImIQq+RkQ12Kt1a1khh6k3TktD9CLUBaceHFp7+9E?=
 =?us-ascii?Q?04eBMDVRBdxGksS/BE5bsUhwufPtxR5T1z8dItGZgYJhki0dpDzIu4qe7Ufg?=
 =?us-ascii?Q?zbn3OBwF8G2bAoG31fBZQMmTTR05N1TlPQTqJsplJkz+L5QT68laxMUf/qqO?=
 =?us-ascii?Q?uOPravU7L62HU0RbnD5Avd+f8kqD1XNIUtdqjyJlvVyp6VP5zJVqX2IRfnVa?=
 =?us-ascii?Q?tLQEDqtc1kdprhID7NBXBLB7Ob1DLd/sJaGnVFxj8Pau23J6aisiNZ+oNIsP?=
 =?us-ascii?Q?Hsi9OlxrwQHs/0015oOZeOqEJR7W1Vcs6CXS7Bo9lmOlO0cmi4hlUcjeEUup?=
 =?us-ascii?Q?Oh7NDPcXmd4ZLC6wn+sU5HR4jwA+Yl+6mIJn24ST368H9PmeSJgkIuRuCCAj?=
 =?us-ascii?Q?qSjIIbyGoAgfQ6SE5zPBXQ67LWAQJYHsXqycvapYfFUqp/UUufrWPU9FJ9Qa?=
 =?us-ascii?Q?bJp1mv3/ECz4lqw59u4dgIYgxrtbrHXunticUSn2krqkdHqWOvWet1FD6kxt?=
 =?us-ascii?Q?+vlZiIWNXqCIBAQE0bHeTbGpucsVASN8gtnO1WvS8mxxorG2/68RNWacTzGH?=
 =?us-ascii?Q?lOnXWU0tfljFIVe0J3inFMhoZY9U52IlRZjX6hHBvcExN4LG82qvxYhsC/ea?=
 =?us-ascii?Q?YzclhdhiIHsCOOpQEwCQBLA9i+tkkmWJNbBYXt3un1pssgPC36+KuY5fVLVK?=
 =?us-ascii?Q?Vm2yEs0nR48KjJtGYd/rzAejRrxxzqQwW8SGY/V9oUCFgYun0L2GzWwgep0p?=
 =?us-ascii?Q?BV1wczQ6iPsKpYAZZ34vvihX/tS2nlQPkuPOMdG9xweCfevMzWbr9pbjLDSw?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RcNpTTdiGuMNpDGoIeGQxSAt+nTLpZfQwIHxUEFfR+XjB64CYnPKdMDAyInS40JOEo9tgoGUmnWYwcGXHAzNBjwZwCG4QfKsNGOMILj3rCbefKoFLhSOOQ9gaBQVUCqvA1eWSQ7WtN0RJYn24pOFpYkTqPIc1lVOX0m010iparuSX94ojGx0aBGP9ms0bWIRU+QzAnf84/KE7CI7/1Z8g2NVh8jWc23snXdN2lKZ+1lmKtDaoKduEOQ0p7QMQKfXAG/Ink4sWbQdQ1x2vbE4msFjuIZhTuSRSxWFkj+LCPn/cUfViyOrO83g23T/F30R0pX2tUxyuu+lhk5uMBwwL6xIIruwxZNdLNzQLg6shAmgjmsV3mA4o3dAY09064lWnIcPxSL9IuGLK2ozGCMotMGkgqs9gUMfFvNmOUvLvlP7x3RCsTYuoIL5503g+5ytm81trdNMs87pC7yb+pqE5Rjmtu8LINEc4bG1IZUSPgu4CYN8sHL/N5RvchLI+MqwVHCG0gKclNrl7nIpHYKxcbyB+UQi9fNT/Mk7UnucNZYJx9nFG0AMSdZ0I+TrRhf7Kq2NNRt3dtwrsAK61h6xlx865NVQXh6zCY7DhHuDjdM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 131b8bed-1d42-4268-ae63-08dd8641e246
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:46:08.4522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mlhv2O2LM7zEfeQ52Rv5sbS7yeOjo5K2qhU93j2XDjJD5hiwbFejPyOIIoEsQ226ceEaDbJ35ZmaYSXXKTSgf2yjuyirpyv3fzlXIg/mgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4165
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504280088
X-Proofpoint-ORIG-GUID: q0EVTP9d3_VdJC1hkTz7OwXXpGct_ejP
X-Proofpoint-GUID: q0EVTP9d3_VdJC1hkTz7OwXXpGct_ejP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDA4OCBTYWx0ZWRfX+cnBFhNYJHq2 gBF8xXxR/zRAXIoHMPH7+2QQIVIE9RK3xC1Ch1BveXX1cTmbooK2bhCSdmj9bWbMcLpXv8zv7z6 2ss1RhjXx5h4XxBb8JlTAbelBb6D5/XiDZsb0lPCxfQ0WL90D54eYQAnK13UE2coDTT2P1J+aZS
 QX1OuyKi52TfIDXhPJZH7y2U0slZJIDKPQhz1b23a6LuHFbzQRqT9wfiYKQi71arzXUb75w0+k3 2kExlr6q2EpjlCZUssQr4hung4qjhLGEUV2dZ3kopFp3ekXw9yAdSwPoVCAItdrMHjrWEOtcjtM uEkTZI0/FdO+M6HdJExuCdJH9mmCNAHp+UlhSk4J4ljy199NI0esjl5fko5L8yLaJn3OduIobfN GS5JrGGw

On Mon, Apr 28, 2025 at 09:53:05AM +0100, Lorenzo Stoakes wrote:
> On Fri, Apr 25, 2025 at 10:09:34AM -0700, Kees Cook wrote:
> > On Fri, Apr 25, 2025 at 03:54:34PM +0100, Lorenzo Stoakes wrote:
> > > There are peculiarities within the kernel where what is very clearly mm
> > > code is performed elsewhere arbitrarily.
> > >
> > > This violates separation of concerns and makes it harder to refactor code
> > > to make changes to how fundamental initialisation and operation of mm logic
> > > is performed.
> > >
> > > One such case is the creation of the VMA containing the initial stack upon
> > > execve()'ing a new process. This is currently performed in __bprm_mm_init()
> > > in fs/exec.c.
> > >
> > > Abstract this operation to create_init_stack_vma(). This allows us to limit
> > > use of vma allocation and free code to fork and mm only.
> > >
> > > We previously did the same for the step at which we relocate the initial
> > > stack VMA downwards via relocate_vma_down(), now we move the initial VMA
> > > establishment too.
> > >
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > Acked-by: David Hildenbrand <david@redhat.com>
> > > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >  fs/exec.c          | 51 +---------------------------------
> >
> > I'm kind of on the fence about this. On the one hand, yes, it's all vma
> > goo, and should live with the rest of vma code, as you suggest. On the
> > other had, exec is the only consumer of this behavior, and moving it
> > out of fs/exec.c means that changes to the code that specifically only
> > impacts exec are now in a separate file, and will no longer get exec
> > maintainer/reviewer CCs (based on MAINTAINERS file matching). Exec is
> > notoriously fragile, so I'm kind of generally paranoid about changes to
> > its behaviors going unnoticed.
> >
> > In defense of moving it, yes, this routine has gotten updates over the
> > many years, but it's relatively stable. But at least one thing has gone in
> > without exec maintainer review recently (I would have Acked it, but the
> > point is review): 9e567ca45f ("mm/ksm: fix ksm exec support for prctl")
> > Everything else was before I took on the role officially (Nov 2022).
> >
> > So I guess I'm asking, how do we make sure stuff pulled out of exec
> > still gets exec maintainer review?
>
> I think we have two options here:
>
> 1. Separate out this code into mm/vma_exec.c and treat it like
>    mm/vma_init.c, then add you as a reviewer, so you have visibility on
>    everything that happens there.
>

Actually, (off-list) Vlastimil made the very good suggestion that we can
just add this new file to both exec and memory mapping sections, have
tested it and it works!

So I think this should cover off your concerns?

[snip]

