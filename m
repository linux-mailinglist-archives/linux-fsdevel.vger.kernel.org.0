Return-Path: <linux-fsdevel+bounces-79292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHkbENtlp2mghAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 23:51:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 942291F82B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 23:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6A593059809
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 22:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4D7384222;
	Tue,  3 Mar 2026 22:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DUMBbadL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GcJUSTHG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8FD361653;
	Tue,  3 Mar 2026 22:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772578259; cv=fail; b=bFrIS/iUSxl5Y1JbnnqOLSTOfz0sJXJiHWWGKf0LXvcQia2C9ynDI8kxKACKf0Na9J2ahha7WFWiIREv0sCjSDOjD/e2Sl3vcoPYxjLNFOewMFsjj0iG9EAYrNHwvwNMliH0+qHSlNAR5BJtCw8IVMF7MvwpEIi57DmkcYIGA4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772578259; c=relaxed/simple;
	bh=3q54X5D17DGYukm7rPNyT2LvlXZIbCGLltxdRuqOytw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bUIpzEvCPZHLnhOqmMoqN/SfdufcQPEJrKzcVMzinrXHmUCE/hoX1qPabKycA1VDa7MgUAJEmVI5BFl9CSJuk/UkrV/x6DomjxUxHyAtAKNb/tVIYotgA+qZy/mh5Jl1BgJff5Yo0CBD9dk1Uj5dhRaU/lw5J6y80Yiq1ZVeNCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DUMBbadL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GcJUSTHG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623LNQRf234644;
	Tue, 3 Mar 2026 22:50:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=a6l+YpKYa1zCdUvAZOQwK25R30hEvKdV/q5Fy6zMAe8=; b=
	DUMBbadL22QdTNk45pBZlKSDCmg7ns/BCXLHKuUiigJ/YQKW6+4Q1W7xTze23Y8A
	lpUioae2WP7mMA+cBh0UfQObklfLb4m2/vkOWBxO5FqX8+76M8Gdzkq67fBh9DA/
	T49RjcSuKqOtVwxGSrlFu46PC1JYb99xREmjlxiJnPhIU+VsbuM/9SgYG44f/WQF
	CrjtWw0qGChbcbgzE6URrWE6P21FHrjTU3IQe2uINVqOx/Ptz4+YFjiLp8EVKqpL
	pbhvCtQdQiCXXpmde21ZiGyMV8OWIxNbCnWl+qOQ1cDrVluziJQkZ8Hlrv13zAi8
	+41cwbQMgg5xhpLa+hIwvA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cp7gu83vv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 22:50:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 623La4A7023081;
	Tue, 3 Mar 2026 22:50:44 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011067.outbound.protection.outlook.com [52.101.62.67])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptf8v40-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 22:50:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V97C8Wo/qeiZEmE5+XNsCjng8sTVDOhnKYCDdlLEYQm/ru3A52QIDJbDhbYFTehC2vbcTs3bNzpitVc1e/FQ08USASrfg7JdAjbXQ3017ANb5oiFZwJMsXytis5YZjIgcjqXg6ZUCKaanIhP28K1xYHkxti+MJTvqCi+dygb6O1rseH2n58HCNJI+LZM3gQnv6xaxG+LSVsjmRwjnS8diBXSyqj6V7XyWmAT2fwjyPNzp/IN0w9NiySy+/IIyRyRhsUaixI9sRMCebGm6ocrPf7tislnprMcdBnh+U90W3VEHRdbv8Jg/AvjcSuLReaZcP8s6VjKVs75EePofJPfkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6l+YpKYa1zCdUvAZOQwK25R30hEvKdV/q5Fy6zMAe8=;
 b=FNWqkG0kjNGlxnoYWslxRumoS+3E7kxnnvjn67Bd43QjnFGHDqjswqrC6CjhYe3NGwI53NGX4NnwQxahzoyEevPf9bQftbZaV50r5phtgeZ2V64bFnuapzC1NqA/9QLwe91lsOQTNcdx6U4oJgOSsnTSA1SHk/TEwVU7UCerjHfDtBJU8nYzWFB4uIs5f7n8LpdzvNiVy1JyS20+gq54j2kBEwGB/6i/iUbTDoTKZpgkHz/qK49NypP+yehBYZU1Ola9DTuUKYXc51cqPVwZapqwVyQXbX3rekO8zIsRA27aoX0fLoxmuwhRIaFQLZvXxI7BWMsgDa3HsvRNNZLl5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6l+YpKYa1zCdUvAZOQwK25R30hEvKdV/q5Fy6zMAe8=;
 b=GcJUSTHGDPriwi9J10nmlldWuwCc6/rMzgr//Eidh/3kjUIICdd5JdiPa1KgPeQDfB9xmD0865+/r3EbFRtf47gY/IA6Pcut3XdgVa9uCDKV+JfEThN1IbcUxJtcAZmj8jSzSVuP4D0OIKM4y7q1nT54yof52LHR9+Cxzok6bqY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB6566.namprd10.prod.outlook.com (2603:10b6:806:2bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 22:50:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::4083:91ab:47a4:f244%4]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 22:50:38 +0000
Message-ID: <5a4775b2-fb04-4297-b9b3-ca0690130094@oracle.com>
Date: Tue, 3 Mar 2026 17:50:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] fs: add umount notifier chain for filesystem
 unmount notification
To: NeilBrown <neil@brown.name>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.com>,
        Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20260224163908.44060-1-cel@kernel.org>
 <20260224163908.44060-2-cel@kernel.org>
 <20260226-alimente-kunst-fb9eae636deb@brauner>
 <CAOQ4uxhEpf1p3agEF7_HBrhUeKz1Fb_yKAQ0Pjo0zztTJfMoXA@mail.gmail.com>
 <1165a90b-acbf-4c0d-a7e3-3972eba0d35a@kernel.org>
 <jxyalrg3a2yjtjfmdylncg7fz63jstbq6pwhhqlaaxju5sk72f@55lb7mfucc5i>
 <3cff098e-74a8-4111-babb-9c13c7ba2344@kernel.org>
 <CAOQ4uxiX5anNeZge9=uzw8Dkbad3bMBk5Ana5S94t9VfKNFO5g@mail.gmail.com>
 <d7f2562a-7d32-41d5-a02e-904aa4203ed3@app.fastmail.com>
 <CAOQ4uxiO+NCjhBme=YWCfnVyhJ=Zcg4zmnfoRspJab3n5waSCA@mail.gmail.com>
 <07a2af61-6737-4e47-ad69-652af18eb47b@app.fastmail.com>
 <177242454307.7472.11164903103911826962@noble.neil.brown.name>
 <d7abef36-ce90-4b36-af16-e8bd61b963ed@kernel.org>
 <f52659c6-37ed-4b5f-90a1-de5455745ab7@oracle.com>
 <177248378665.7472.10406837112182319577@noble.neil.brown.name>
 <fa27c3a4-ec29-4d0e-a8c5-56c4635c9e3c@oracle.com>
 <177257302207.7472.9288506237444156916@noble.neil.brown.name>
From: Chuck Lever <chuck.lever@oracle.com>
Content-Language: en-US
In-Reply-To: <177257302207.7472.9288506237444156916@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: 7508b5f1-7217-4742-73ce-08de79774a19
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 +YM1PgByQnWpxXM7POZxfsyfk6KDXackZsYjPmEvK/X+8rSzY2XvvdTOvemtM9GdD89IT+Gs+EkKJa+yuR4F8Mu+2OOI5mwhHVKxgjsTgOlXT4cD9Bw2aA2mnpU3/YjkxC4F0/xXOt6bQbI5IJb4hn+3cAGfTlkHffBuCnKPaHyg434OUbzxXRxxIU+055hVOeaWTGsuGDyraC9INj5hNkn7Y16TDXVeN+XxgAP6sXuo7Vxr4Yx59XIPGAlAMQcC8z8ZDd9ognkxdjsrvH3fDYS15mg8cF33JXVFQQtte9nMo1t4leTN3fCf7sPdMVOr+V4y+4gncFkPocNNYmf9z8Ut4RhJ+urgyq3FuGi4VHdVNl4LOJIDDbfIcTq312wphrgWEy3pGvDiS9045jpCIH2gcGWLKIgYaxL8WScJGL25zxJoeJiZ6TsEgG5/Kr3F35VE9ZDhJVR4WaDmnaib40REZLhn1o8VgVobXpPi2ga7rtYRuDeerZbp3IxgWErW4WcwNeEbtYNgSIAW7PppiW3z3G8UcoKvwNluov+KGYMmuvbDek0T28LYdb8BgZXqloO8WNlgw2RAD8y76KW4KXq6J1xA9XeoMj9EwDbdoBdTFMiQPX7876Wyl975lZXhPBnuaAHzt93GX1HklzOXvhQz84v/xj1mH0oBwd00Zb9yBabLi/4Fq/QUHDYRJhXwH/ZKktGnAOQqoke9/aRhybz53RQNkHsTQMY851d3hH0=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?QTJyZFQzN29VSGhqeUI3N2V2LzBDZ1UyYll2MzdyM1Rmai9tamRITzhLMUlm?=
 =?utf-8?B?NHZHUlpWVWtJVDY1dW95WlN6VzRIOEduMzU4dTZITW45SG5hSXFhL0NzWHkr?=
 =?utf-8?B?bm5sbVZMTGQva1dvemhpZlBjVGZVYm5zbFFMZWN1bjBZSWw0ZkdNODRMSWRB?=
 =?utf-8?B?Rjd6Qi9WRUYrc2YzL1ArdkVpZkdJeG50czVnQWlmWnBjVVkzblBrMnFyRjQ1?=
 =?utf-8?B?VktuTkZWMVc2cWQ0bE1EblhZSHdpRENvTlA5cTNYeTdSR2dObkErS3lXT2Ew?=
 =?utf-8?B?VXpHeENwZWgrbUZpQVgvRUo2UzZwNlZBQlFHSm9yNURacFp6WVF3MDNCYUQ4?=
 =?utf-8?B?K1crNzRDR3V5QkZmdWg3bkNjZnVWZW9CZ2tXVmNsaExKVllWc0NOT2RiTitq?=
 =?utf-8?B?RmpzYVdFOEEwcGNIRkJsZjhxb0tqOStiOWtJNzNKMFduRmh2SXdZYjNSRHJy?=
 =?utf-8?B?elJZUTR1NTdFelJlVjV0OHEyZkViVDRDQWYxeFpqYmQySVVCaFVSTFBac1pw?=
 =?utf-8?B?N0orZjBhMkZhMkFweWxKTjhVc2I5M3JLSTQ1MjVibFgzemlOUm9OUGdVSTQ5?=
 =?utf-8?B?TmxocWZwTWlyejJISHpNanRLamoxZm03Z0ZCd09YUHlwcG5lZkY3L0w1aHJG?=
 =?utf-8?B?YUhUYmpScnd3Z3E5VHdjSGRkWEQvSDJDT3k3S0NmVlpQK3dOemM5ZUxZVkNv?=
 =?utf-8?B?TlkrVnlTUUpJUEs2eDA0LzNnL253d0dERGszalkvNUZHYmhlYnM0K3hMbExP?=
 =?utf-8?B?U2crR2hGcUo1anp1SFlrSkdTUjc2VjhNVWU3VEEzK1JrVFVTZTZ3Vml3UnRZ?=
 =?utf-8?B?U0djYS9GOExVZlYvQU9Tb3BsSHRROFFTZC9RMkNGQnF0OXZkQnNRRllaVkZG?=
 =?utf-8?B?YTZsREJpOXo0TlhVTEdhc09KZXdnWVpMU0NyRTZJbmpPR0RmUzFtbFk5dEU3?=
 =?utf-8?B?Q3NuSzBWckJTQlRmeHJoVVJzVDdjVU11ZWdYWEZFNGJIVDZ3RWFyY1VpaXl6?=
 =?utf-8?B?eXhvSkl6UWpGc1NoSGU1SjVoUnYyNWFuYWtDT0xkREJvcmRYWWtmdStNdkF2?=
 =?utf-8?B?OEpCbFpiMnF2MS82S0xobnhpaFRxQ21MQm1ZWXZ1czFmL1dTZldhQUltSjlT?=
 =?utf-8?B?R2FNNjZ4WEljVDhQYmxaMW9ablNWeDhwOXZ4a0hBQVVhKzhNQVRLcWwxWHVT?=
 =?utf-8?B?aGU3MDFIblJ1UVRjRXJicHFacUhncG9SZkwvaXdRMmpLb28yZzVKNFlnSm04?=
 =?utf-8?B?WGMxRE4zTWN1czRVSFpkQW0yVk4vSGhzZTkyYy9wWEV3bFByaFdPUWpTZzRS?=
 =?utf-8?B?MTRNUzIxcFpBRENURjhRbnlBSFNCeWFnZWd2Y0syZGgyS2tFMVFyVEdhNStQ?=
 =?utf-8?B?WmZIbnl1cGNRM0lmQnYxS0YwWG12bHZ4ZHVRZjR2YjgxUDBXMGVIZWRpYXBU?=
 =?utf-8?B?SkMrK1FqVzFGWjRrc3gySVlyc1k2ejJ1S0k5VWJGcG1CUWlVYVJKMDhjbVIr?=
 =?utf-8?B?Y2xNSlVaWWxvTVlRKzZ1UlJzUHh5TEVqZVVnVkNYRGoxeHlNYkZUS1BYK2Ez?=
 =?utf-8?B?Tlg3c3IwdFhKL09aY3lZQzlKNVJ4b0h6YXNtZHF5cGdJVThzWVhyVERrYitu?=
 =?utf-8?B?dzNDS003V2ZxQlc1T1k5cDRJUmRyK2NNU09oN28xcElGS2V1amJzRHNFOGFs?=
 =?utf-8?B?a3NqOUxjYkdwQys3T3QyN2orZUxXVDR6RTJ1Sk1JZlFwWDR0RVIwOFE4N1ZT?=
 =?utf-8?B?VHN4ZWJ2bFA1Qzdtb2JrajliY04yS1Jhcy9zNndOcmcxTFJibE5BR3F2RTVm?=
 =?utf-8?B?cHEwVGFEZHpTSXZ5RW4zbldJTjRZVXdaTmRuU1VRbUFjTk53RW9XbVpCSS9v?=
 =?utf-8?B?RXlWYVM3WmJ2ZGRxbGEweDBjYWRoa1VaazhHMGx2S0kxcWpSSkNrNy9WRlFH?=
 =?utf-8?B?Zm94UkFtQ3NQaXFMVHRqRFFHMTQ1dSs5cHlnRlZBREVjbUVKTVlNdDFDeTZz?=
 =?utf-8?B?UDBPaVZUZ1JYWGdMQjNucEJyZ2NBVmFEM0tMRnBWY0I2UEVHaUNuSDU2bUMx?=
 =?utf-8?B?THpXRlJpUmQ4SzZVTS9MYjVHQlZOZDBWRm5FWkZOR2NiSXhna3k3VXg1ZXFO?=
 =?utf-8?B?OENERFFsUko3Zzljd3dKbXJPNGFQSGFMSSsxQ0ZZTnBSNjZsWXpQTFVYdWho?=
 =?utf-8?B?eGtNei90UXFSQitKbXhwdHRGWmxCemN4cEQrd05iRTdUSVJzRUx6N21HS05C?=
 =?utf-8?B?NmRwTE40MXpZaW1ua01xRDNWYzJDMk1PZTQ3Rlh1cUR3YVFsVGxtVzAxNnZI?=
 =?utf-8?B?ekFVNWJaL0NiS3hVMlh3U3BRYmZtZ1V0MXh1dm0zVlNWcDNyOGRpQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D6M562OLmexv5pP/DyxmVyM0n8DVP3ktV4QTfTnrnxXB8TTDYloshKxefX2rMRNUmCJTrgMlSI/LILUDDP4qNIwKKdIN9AI92x7w8PEaLx6kNFiqdR+YnhUKwxW8bFqMhW0XTweYEj5y67HyvOqfWJKtdRxtXWswSC/TlNHc6LyA0kROocnDh7tkhMa0d6UikuJ8haydLuBpqOj8L4Kg3Hq8/JgYeYktuiNatjD7rc0pEsF1sa9ZFm/mXzxpRa3h6PUCPLojQX5kInRBxIIIlIguZmGdhP3B4z1ZqTc1qeNEUfhnxQqkZW6wT/xtxEzc0fNmU3yELDEqJqEEXO2s8fzXqOXDwSkmk1SemxSrsv+CxCFtd0ZN9oyRe0Vewyr4eu51ZhsuznNXE9QnQW4C3J68+JeSOpBTt0h2tJ/fXMLlfTpkwJtRwpCDEr03HGsqoyYuBrIt0poKeG1n123rGOHaBuMiyCU3r0muxd2BTtZ3jRdtsCvKFZdkWFgbdfaPxpXcSTaG5mWoDHlVVO7b7vU5F6bi1kDUDk1/QXDOJEJ7dIV42s5Y9cxjhectoAC2y0DhJZ7iSh6woppbvlApG2SIWKZ5OOouHHrNLrEZwwI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7508b5f1-7217-4742-73ce-08de79774a19
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 22:50:38.6528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWtiJPt0ca+/12AhdsnT3CLtaQw/bUSGGEdokZeRdgHmSmYNeUyrcMspMqZuDLZyeW+jXRn9fCb/z/m9XOzFRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6566
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=963 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603030188
X-Authority-Analysis: v=2.4 cv=VIvQXtPX c=1 sm=1 tr=0 ts=69a765c5 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8
 a=cxdn4DPievauSXUY5wYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12267
X-Proofpoint-GUID: LN9-Uk9h46wsSO1nDKGj7R6ElIDd9Drj
X-Proofpoint-ORIG-GUID: LN9-Uk9h46wsSO1nDKGj7R6ElIDd9Drj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE4OSBTYWx0ZWRfX5ONW6Cll7tyB
 DeF95jAdM43TcDs1Sc/JnUNcOWQ/wUEr/UKJ/mee8nWen4C4rO6tdhwYljsDunQSZlosE0QLtix
 wGsdVhsZtZRaiIms/ImV6KxOPaVxcu9kqArJUWRtkeIVhdWDTQI7umQ9a7FsK/HiS0QzBKK5Ehg
 P/djuVvU2moDzlz1O1lTJhFdhq1gxCZ4rWTDyHSxkZGQb2NG/cfweGzLF05P8h6S8STAQ7P0lIn
 LRO8NdcsDvnoJy/GNqKHrlZEIs20ko4BkoSBIKI319tQGcw2eF8WqJpqd8KKspw+6EMWDomr6kt
 BvsGd/5W7/G1KPx6s/tUzjqtferJoSYyxw7fH+l2rRNRgXExLievlioV6hAD4RHmnH6PWB8VMJT
 Aj4TFwulfwRX5DxA844/Efj10G5ZWyoiiP8YjvpA2bNycOEJvfEYqUVartvOWmcOq5ZRoA1GZfH
 BHR5v8AmylMpC6NI7cBj2eyBFnVk++/L4rDL7hOQ=
X-Rspamd-Queue-Id: 942291F82B7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,kernel.org,suse.com,redhat.com,oracle.com,talpey.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-79292-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:dkim,oracle.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chuck.lever@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On 3/3/26 4:23 PM, NeilBrown wrote:
> On Wed, 04 Mar 2026, Chuck Lever wrote:
>> On 3/2/26 3:36 PM, NeilBrown wrote:
>>> On Tue, 03 Mar 2026, Chuck Lever wrote:
>>>> On 3/2/26 8:57 AM, Chuck Lever wrote:
>>>>> On 3/1/26 11:09 PM, NeilBrown wrote:
>>>>>> On Mon, 02 Mar 2026, Chuck Lever wrote:
>>>>>>>
>>>>>>> On Sun, Mar 1, 2026, at 1:09 PM, Amir Goldstein wrote:
>>>>>>>> On Sun, Mar 1, 2026 at 6:21 PM Chuck Lever <cel@kernel.org> wrote:
>>>>>>>>> Perhaps that description nails down too much implementation detail,
>>>>>>>>> and it might be stale. A broader description is this user story:
>>>>>>>>>
>>>>>>>>> "As a system administrator, I'd like to be able to unexport an NFSD
>>>>>>>>
>>>>>>>> Doesn't "unexporting" involve communicating to nfsd?
>>>>>>>> Meaning calling to svc_export_put() to path_put() the
>>>>>>>> share root path?
>>>>>>>>
>>>>>>>>> share that is being accessed by NFSv4 clients, and then unmount it,
>>>>>>>>> reliably (for example, via automation). Currently the umount step
>>>>>>>>> hangs if there are still outstanding delegations granted to the NFSv4
>>>>>>>>> clients."
>>>>>>>>
>>>>>>>> Can't svc_export_put() be the trigger for nfsd to release all resources
>>>>>>>> associated with this share?
>>>>>>>
>>>>>>> Currently unexport does not revoke NFSv4 state. So, that would
>>>>>>> be a user-visible behavior change. I suggested that approach a
>>>>>>> few months ago to linux-nfs@ and there was push-back.
>>>>>>>
>>>>>>
>>>>>> Could we add a "-F" or similar flag to "exportfs -u" which implements the
>>>>>> desired semantic?  i.e.  asking nfsd to release all locks and close all
>>>>>> state on the filesystem.
>>>>>
>>>>> That meets my needs, but should be passed by the linux-nfs@ review
>>>>> committee.
>>>>
>>>> Discussed with the reporter. -F addresses the automation requirement,
>>>> but users still expect "exportfs -u" to work the same way for NFSv3 and
>>>> NFSv4: "unexport" followed by "unmount" always works.
>>>>
>>>> I am not remembering clearly why the linux-nfs folks though that NFSv4
>>>> delegations should stay in place after unexport. In my view, unexport
>>>> should be a security boundary, stopping access to the files on the
>>>> export.
>>>
>>> At the time when the API was growing, delegations were barely an
>>> unhatched idea.
>>>
>>> unexport may be a security boundary, but it is not so obvious that it is
>>> a state boundary.
>>>
>>> The kernel is not directly involved in whether something is exported or
>>> not.  That is under the control of mountd/exportfs.  The kernel keeps a
>>> cache of info from there.  So if you want to impose a state boundary, it
>>> really should involved mountd/exportfs.
>>>
>>> There was once this idea floating around that policy didn't belong in
>>> the kernel.
>>
>> I consider enabling unmount after unexport more "mechanism" than
>> "policy", but not so much that I'm about to get religious about it. It
>> appears that the expedient path forward would be teaching exportfs to do
>> an "unlock filesystem" after it finishes unexporting, and leaving the
>> kernel untouched.
>>
>> The question now is whether exportfs should grow a command-line option
>> to modulate this behavior:
>>
>> - Some users consider the current situation as a regression -- unmount
>>   after unexport used to work seamlessly with NFSv3; still does; but not
>>   with NFSv4.
> 
> They are of course welcome to keep using NFSv3 (and to not lock files) :-)

>> - Some users might consider changing the current unexport behavior as
>>   introducing a regression -- they rely on NFSv4 state continuing to
>>   exist after unexport. That behavior isn't documented anywhere, I
>>   suspect.
>>
>> Thus I'm not sure exactly what change to exportfs is most appropriate.
> 
> I think any purging of the cache should happen at unexport time, not
> transparently when unmount is attempted as I think the ordering
> semantics there are complex.
> 
> And as the kernel doesn't know when something has been unexported, it
> must be exportfs which initiates the cache purge.
> 
> So the only interesting question I can see is:
>   do we mount "purge on unexport" the default, or do we require an
>   explicit request (-F)?

Yes, that's what I was trying to say above.


> A complexity here is that a given filesystem can be exported to
> different clients with different options, and different subtrees can be
> exported. If the cache-flush were to be the default, it would need to be
> on the last export of any path to the filesystem.  This would need to
> include implicit exports via crossmnt.  I think this would be hard to
> specify and document well.

Is there nothing we can do to engineer the exportfs command to remove
some of this complexity?


> So I think an explicit "flush cache" exportfs action is simplest and
> best.
> Possibly:
>    exportfs -F /some/path
> would unexport all exports which reference the same mountpoint, then
> would tell the kernel to drop all cached data for that mount.

I passed along your original "-F" suggestion to the original reporter a
few days ago, and it was not met with universal glee and a huzzah.

Although "-F" can be added to automation easily enough, their
preference, based on their own users' experience, is that the fix should
not require changes in user behavior.


-- 
Chuck Lever

