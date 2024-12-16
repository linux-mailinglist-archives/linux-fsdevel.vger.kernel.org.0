Return-Path: <linux-fsdevel+bounces-37494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9064C9F31FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 14:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63A2D1679DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 13:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0485A205ABA;
	Mon, 16 Dec 2024 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QqXpWuGF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HqUR/cBT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354522054E1;
	Mon, 16 Dec 2024 13:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734357147; cv=fail; b=kqdx98V22N0BiDacAQJeyvYU9uFXjZX7H4Gi1zH1ANvuhy2Xwz9X027AlcZ4QslBjquhvtxmRtSpLv5VPtP9yDJitlMuGjzTOYv+SgjCbpGCFv3SiexmUJ9MT42ufl91+b93MC7bAs17qJmuavIgAJXFTHitoNWdkhN0HIV4/n0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734357147; c=relaxed/simple;
	bh=UIX2TZXC31sjX/f39y0hPZrLhMMJPKSGZKKAh9C5hKE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dUGXGHBl75LHfl3WpBrzfbx7hZ7EuCD4GBgs7RPkE53pQpHuyCnF7banCzHzp52BExvYr/H96usDAniUAKZHL7Rns012w340/B8xx24YLfHv3gDq/tSuZcArh22DAGuG/ex0raIdP1KOp5OdoprU+QsZNFpHxjkznqLAp9COj6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QqXpWuGF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HqUR/cBT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG9MqKO018722;
	Mon, 16 Dec 2024 13:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=TYSjsxqSfRHQ31ud9LZmZY+FhMUUrI9aWOCukaLpWj8=; b=
	QqXpWuGFG/iw38p9dOqLWWrKH5Z+zLKL+vrcAyk2Zt6cVERS0MmprVGej8EF9nxY
	O4A+v9nfI7nkfY3MhxieX6PKWAYUZY/sbuDOOMQOnOzP9bm34y1wR3Va5YV6AVMj
	td4JARX3+zytr2Qw+BF5SYWtnwpMZyo5K5GtbxCHP3tfR+Qg6IFkAto3Q+XXkWRY
	y+uJM12ZOCum6F4vtRXtQL+uaqFDIh4ex04G/+oa1uscG9KtZdTifKBQabwug42d
	7hhYvRHH8Q80Q2qzQjXfoqnipz9NQvlySSeLPYhiS+JvpiMjo6MFAD9GZQa6G6GH
	nHxJBnOU/2pRADD0Fs4iIw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h22ck80e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 13:52:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGCOw7w006367;
	Mon, 16 Dec 2024 13:51:59 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f81amv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 13:51:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOj5WZUXRx/IV50FjybXQAO6GtEvdDWa/gXiPykw/FDMVqj8KI4xiMiB3phzJwaIk+04GabfdSN9tpXhTPXc1rCUi4R9vKff7b2AfluN3Eg5ZZt6uMDRsTYC7i/H5f9QjOE+srJpkrsdf4UfkEtsQ8T5B5CFiveq4pqX0Ht07WDYaY+MfeJeyFHPqES2tyUFdCg2Pqgq/qRm8BCPtT6KyYd2XqRmmtsDCQNMkuajkvyrFqtP/eSFTrwCNwcxpQ55mbPflBUWrKDJh9rnrohOjHu3EtQJtaG/I5aeNNTBp6XXOVnXRjPo/QLVLqLDnYRyQ0tx4uvG2PGCMyJArljSMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYSjsxqSfRHQ31ud9LZmZY+FhMUUrI9aWOCukaLpWj8=;
 b=KWK4Z47wMgxxm83UbpRgC9UmazzqvZjWafv0lCfghTAyvH7dPBOxaO/vwemLyY2ARZEd4wm23WMG/FyW08qaa0/7pkj99RuH4Pe8Ng3tVKs3kadZ2dzz/VLPAuVk3SdhzJZU8fVQiYxXS0yVkGj5UtXRrmx1Az0dk+yoC6RyCYfzfcZRT8VjChUUtNsXVCCUEeY1MzUxhl8zfoLMwV+EInUxLld6Fru8FX3NocVjwIiNThLePEstmTacRjV4qYWoGbVStpxsKF7IndQ3iMWMuIeroJN78xQRQo95AM2gh5yKz/5UVN60VFUdS0MleDxUdbsGr1B9BQyjhZVIdRBTmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYSjsxqSfRHQ31ud9LZmZY+FhMUUrI9aWOCukaLpWj8=;
 b=HqUR/cBTDZJv5ob7goE8x02hpm5AuNx+dS2Ix5LVfBSKXhzjyleYZbdD2yVBWn3CpymJTfotiRIKv1xJQCo753TfogSPaTstpBiZUauvaQT4P1FzOf+0xb/UI+7PL1oBzK1UqAHO+HQ6BJ6cKoipr1UK91E4uKDFBvPqVGBflGw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6176.namprd10.prod.outlook.com (2603:10b6:8:c0::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.20; Mon, 16 Dec 2024 13:51:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 13:51:57 +0000
Message-ID: <2e3428fc-7569-4698-98ac-4576824e3c90@oracle.com>
Date: Mon, 16 Dec 2024 08:51:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] libfs: Return ENOSPC when the directory offset
 range is exhausted
To: Pratyush Yadav <pratyush@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>
Cc: "'cel@kernel.org'" <cel@kernel.org>, Hugh Dickins <hughd@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>,
        "yangerkun@huaweicloud.com" <yangerkun@huaweicloud.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>, Yang Erkun <yangerkun@huawei.com>
References: <20241215185816.1826975-1-cel@kernel.org>
 <20241215185816.1826975-2-cel@kernel.org>
 <95d0b9296e3f48ffb79a1de0b95f4726@AcuMS.aculab.com>
 <mafs0o71b21dx.fsf@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <mafs0o71b21dx.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:610:b1::9) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6176:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d6a958-1653-4f50-d404-08dd1dd8ceb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3VON1hVNEgwRlVZdm16Y0ZIOFpBNVk5TyszTjk4M0dIVUg1aHoweG9raGx3?=
 =?utf-8?B?dTFhZElxZ2cyZjlzZ1gxcTdIODZZTHgvRUdZdHBvem4zS3pia3hvTlVrandx?=
 =?utf-8?B?UG1WTGNsalZLU3ViSEZUbU5NNlNHQXQ5MlgxWThTc0t4cTZIZEltYUJVR255?=
 =?utf-8?B?RmM1MHlIeWFBa0owdk9XSzJiZXVuZlUxU2dSVmRNUkF0WDlBeGg5WDJrVlc3?=
 =?utf-8?B?SkduY045ZGlYMWl5MFU4cVZDa0lwRWQ1MUpncjlNSG9JNzc0Z1Q4VVlUdGNI?=
 =?utf-8?B?dk9rdFdTU25GcS9nV3hWcE5pcDd2N2J4WDQyalFkZlBqcGt2WHNsR0FrSEVa?=
 =?utf-8?B?UDh6cEYrai90NkFKN0tRa2MwbjhZMEc2ZHY3cm02UVROVy9vRVBZRkZvSlpt?=
 =?utf-8?B?Yzl3YndaWE9uRnpYcEFrYjRLMVRFLysvNlVUVDBMWmNKK3ltem0vb0Z1d2w3?=
 =?utf-8?B?Sjd2WDRNV0JCaWp5MzhWdk5hS0UrYS8yRmpSZmg5UW1GQ0M5b3QxVGtpODJ5?=
 =?utf-8?B?ZHE5aUtRRExZbXRJSU9ydmVwQnZoam02NmdoUllRU3ZHVHhFczVWdXNTYXQz?=
 =?utf-8?B?YmFucmZsMzdPMFRmSExtb041N25SaTcrbVByZ0VrYkpQbGc4MkdIT2hsdTI2?=
 =?utf-8?B?TjZxWnhRMlZIZm9aR1RBbkVzOExxTjRQOVhpMW1jNEVuaFZROE1ZeWVDallF?=
 =?utf-8?B?UWxZOTdmR29aNUZZaVk4eFhXWnN3WWZJYXY4SkpUTFhscHlrUU0rQ2xFeFNx?=
 =?utf-8?B?aTZNUlZ6Nnp3TmhocUN3YzZ2ak5TUnBGbTIrVjVkcjNXTEdGeXNjWDJ4WHJM?=
 =?utf-8?B?SVd3elNoOTFwb3NXajRnb2hBNzU0L2kyblV3R1JqYllXdnRXYk9FMSs0SThh?=
 =?utf-8?B?bi9pQzdJdk9HWUpBdkNyYU0wODBhNkhBdlRoSzZ3ckJsU1RiaTlSZXZTL29x?=
 =?utf-8?B?VTdodTV2bmwrNFBWRHczb1poRXltUDJPbkpQemU4ZTRvZy9DcHNURCs3RXM1?=
 =?utf-8?B?QlliUkZsNFRuYktaYW1nTVFzMVJjSndtcXBVSnUzSVJ6ZC96MjdSaFFBNkVO?=
 =?utf-8?B?bG1oN2RtN3dHVzlhWFpFODgwM1FvWmRlR1l1UFJ3TzJnRUUrNmpTUkZhQ2E5?=
 =?utf-8?B?TkhPL3hTcjMxTitjUWhRazAxVDRMeUNpcHE3MGo1K1pvVDhJSFZpRGVBZXV1?=
 =?utf-8?B?THJoRUg3L3JpMkw4Tm1wbWFTTW9taElUNGZsVnpobG5leHd0ajZjZmlNK3NI?=
 =?utf-8?B?UWhDOGJLYjMxSUVtM0tTV2ZlY0ZHQTl6NVZmMXFKY3NRMStGUzUwdHh1MTA2?=
 =?utf-8?B?MFpBd0xhZkw3TmJiVFhqUUtxVERmc1BDN3dmRmh6alV5SytXZlJPeklrYVZR?=
 =?utf-8?B?OWxpakhUdFY2eHJRRWl5dmdhcnVWNUgzRHIwQ0xvSVVNMW50b0FZWEJnYWhs?=
 =?utf-8?B?MXRFRnpmd3YyMUhmT0Ryb3dJSVM2dDloOVdScmxEY3RCQWZGYUQrc2Q1QjRj?=
 =?utf-8?B?VmJKbHZWZ3BoeU50U2wxNFlnWFBiZXJJeFEydUo0dzgxU21FRmhaT3ZaQlRv?=
 =?utf-8?B?L2dOMzJxRTY0NkRkckFKSnRMQ0VLUExDVCtOWGoxdnc2eDBmRGlNV1U3aTZN?=
 =?utf-8?B?c1dBY2tzcnVjT1Z2Smh5UWc1VjM2YWFnRm9iUGlXMFdjRFV6eFd0R0VvVDVr?=
 =?utf-8?B?ODNKKzBBUnJDYkpucVNDQ0NCWS95bFNiSm5vNmtWMHRvYlB0TkZMdEFjTUdD?=
 =?utf-8?B?MFloU3BrMloyVGVrd0tnd0xFcXMwcGlrTncweU5keEtvdTlBV1VpMTVlOFlW?=
 =?utf-8?B?UW9XVXlTVWNqNnM4UGFpZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ak9vRDhBNytyejZLUlJJTmkranR4b0NFSXlUSy81MU9MQUUzWGZIQ2M4UDZG?=
 =?utf-8?B?QUw0ZGNKOHBGVjNNZzB0bjAvWmpjNUo2anJZQTU5aE9zTVJtTjNYQW44WFRR?=
 =?utf-8?B?bVZVRHhwd3U1K0Z3MFpuZzNvU1QyT0I4d210WE1uTkFyU2hIMW9aVEZmOVZL?=
 =?utf-8?B?TzVKOWs3eUxlMi9tY2FmZy9TNjFHRjVXTmkzZGJsSXk0a2pEZFMzZk93blli?=
 =?utf-8?B?bEUyOUdlZmpWVjNHb1owQk00aEN0Z2NvTW0vSktySjBPcS85V0U3QVpiZ1RT?=
 =?utf-8?B?VGE1ZzlrQ3N5R056am5IalM1VjVjelZnRi8veEg2Q2pBQkNGS2I4MS96YWV6?=
 =?utf-8?B?dGJoME05REdydUF1L1VFbE9qcnFONUxkZWdsSnBUZ3NPRWlCcVhHN2F0Rm04?=
 =?utf-8?B?eE90WEJRS1dreVRCbldocUh2bXVFWHg3amsrMEc1ZFo3S0tsUzk2cXMxcllx?=
 =?utf-8?B?Y1dGRTZqRERhSjdsYklMc0tJa1hteDZyaXZiaFo3TUZmYTAwTkdFakpkb2lu?=
 =?utf-8?B?R2dlWjNzMnJUUnA3SnVaNFRERytaYWduQzk2ZWN3cElDczI0QTRhNTdGWlBC?=
 =?utf-8?B?YjVwakNKdjNFSkp0M09wWUQzRjVMQ2NFYy83cXUwTTEwZWZaWmRuU1RzSVF1?=
 =?utf-8?B?RS9UMnpYZXlKNTVHVmhkYnlpeXNHRkxpUDdBQXcxK2I5RzdUSEZzTjdDVDJx?=
 =?utf-8?B?KzdHY3FiVGlSNXhaM0ZBWFlOVUcxbXY3NFU4dm1EZjBJOEpzeHk0czBHby9L?=
 =?utf-8?B?T2YxaFlUOFhYRVRndFh3ZXNxRnlleFlERTBqc1Y2NG5xY2ZIWGRMdjMxTVph?=
 =?utf-8?B?azVMNWw3Rm5nTW1uN2hEL2lXKzZocU9ZZWQycmg0RC9NTklNcCtIM1pscDdw?=
 =?utf-8?B?bklXL21DNHFsaGNWNnZ0VGVTY2ZCaGdyZmtBY3NtN2dPbmxKM0YzOVhYL1dP?=
 =?utf-8?B?OGx4dGJTL2V2aWlVN0RHRGFnSzYvTS8rTTFMeFh4Y1lHRkl4RVZPVjdOMXhL?=
 =?utf-8?B?SDYrejdmZ3dibzErMitPdEFoY2dUaVpBMXgzT2IzZUJSOFhlT1p0Tmg5WWpV?=
 =?utf-8?B?WnBrRFpKZzV1a05kWEhXbVZkZDlOZ3JrYjZ6RXNCa0F2VzVtbXVrbURSUzV6?=
 =?utf-8?B?eFFwTncvRW82dEVySmV2K2h5cWgzYUJDNGtvcnZFYk9tMHVuSjBpMEZjNDhR?=
 =?utf-8?B?cytCRTJGZFhJZ1RvQU14TlhkYmF6aWdtdVQxL1piQXQ2TzJseEVPY3hlR0hW?=
 =?utf-8?B?M3ZTZjBxMXZaZlorcXB1ZC91ekRLeVZjQVpRL3l2REFKNEtaTG93eTRyOHFz?=
 =?utf-8?B?QWV4bFN2MTliMmMyVXNvbGxDbGh6WmRJQnl1NlFkMSt2QnZYbkl1dkVpVitG?=
 =?utf-8?B?M1ZBekxPdW9meFNjZFE2Q3c0WHhzMzE1Uk1YM09sVGxrRUxybDZ6YmJPNThB?=
 =?utf-8?B?eWtqT1dwSUZnaHpHUHpGRDFyVHhZczJvMG9BSCtrTi9pYU1FNFNvWmlWZDhU?=
 =?utf-8?B?Z3ljNG5tNWpITnNxZTBrOUJ6SUxOMEtObGpBbGpFcUhXQ29XbWp1VERYUXJ6?=
 =?utf-8?B?dG0veGxjWU9KM25nVlNXZnJzNXpYTjVndTNkNHdRL0RzcERmRitFK1FzUmVP?=
 =?utf-8?B?TXZkUDdnWGJ4cVB5cCtLMmdrUW1RUDYySlRWdU80dVBIWGd5K1FWMkZEWDBu?=
 =?utf-8?B?L3lWd0d4ckozNWQ0N3RVTUIzanBSQ2gyR01uUnBsWk44amdkN0ZmUFZTNUxQ?=
 =?utf-8?B?V0RRNmNISVAvMXdFRkU2OFhLcnl1MnFrUUZTWTFZbmthQlpmYWZ0Nmg3dEdY?=
 =?utf-8?B?S0hBYVlLSEs0MGoxKzU0VE15TTlteGZyN0FXSThkTTVqZzBueGg5LzM3dDBQ?=
 =?utf-8?B?SWQ2bTVTQkxPNjd2OHM2Mm5ndFA1aE02OVhxTDI4SHRvc3Zpc09VVTNKanpp?=
 =?utf-8?B?ci9jS0hiRWtQTFU1ZjNLaksyVWlMS25waG05czZielNHOEhqNmhjd2M4WHl0?=
 =?utf-8?B?WUFGU01INnd3YTROT1J4RnU4cUZ4UWtIR00yc2dZVFYvUmUrQWJpUkFRNHhI?=
 =?utf-8?B?Wm1pQVh5UVh1Wkpqd2J5eExLbHFkS3orUHhJWWlvMURBQytucFd1T3JubDRH?=
 =?utf-8?Q?zCjTbGtFHIqvLSr9FyhfSUki/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	coMB8K4U1af6aWoxrc+2sHI5d/74LN6eic8mAVdvrbg4LOMbeJibx587HvvaxC02SZkakQ2Yfbr6Ls3kipPIfdW82aP1OAiWMm8U9ftg9BA+aUlJibXn6YYtG5dG4r0gaDCP42cK0Yx7yS39QFalvOBSV62e4PNJyiNr6f7f7T9BUCkIljOV2at+AwkUf5ivslq6KqGw9VtFqQfMNBPfEuWei3BN35JnD9yTFr9AZXfVS4EDgeD6RHUUg09QDPZGCtacPkU8UnWPZZGZupkYlp45Qi36TLdunXf1FaIbCKf8rms1i6yl5o/zHX5vPEicAD9a364gihnh4ccZF1CGuudkqGQhuCMbUvxXoxXleMxatXr94TKC4Iwq4xyBc8iQPhNw8mgFfImDJ40Q2fPNyC+kQQosVIt8n95SZdAJmRNmofLVvw0uL3UFr/WlyAkOyTJS4uFSg7/ijku4vYVg+ZZjs1NunixXQ9Q4/ke9qL0FXnAic+lNo1o/UmmyavmPUy56lf/EVSoUM3aigwWEjy2r7GFOVjkfsl5vOUim74zeCv8hrqUNBL2kAaaK8+AYw11YK3YEOs2FpflVtPAThO9soF44ITdHJ87iVAa/o9c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d6a958-1653-4f50-d404-08dd1dd8ceb6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 13:51:57.6274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uv1ft6uecfH2MjI2V4G3ui8Q5g8hMLUhFC1XoNsvfri9MzUnW7Gp2aLdMvtH8FF9VNlr/Ir5PiQxyC+qPmrmOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6176
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_05,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412160117
X-Proofpoint-GUID: bcv3GEIqzkoGnGOXp0-U6isGJxYANlen
X-Proofpoint-ORIG-GUID: bcv3GEIqzkoGnGOXp0-U6isGJxYANlen

On 12/16/24 8:39 AM, Pratyush Yadav wrote:
> On Sun, Dec 15 2024, David Laight wrote:
> 
>> From: cel@kernel.org
>>> Sent: 15 December 2024 18:58
>>>
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>
>>> Testing shows that the EBUSY error return from mtree_alloc_cyclic()
>>> leaks into user space. The ERRORS section of "man creat(2)" says:
>>>
>>>> 	EBUSY	O_EXCL was specified in flags and pathname refers
>>>> 		to a block device that is in use by the system
>>>> 		(e.g., it is mounted).
>>>
>>> ENOSPC is closer to what applications expect in this situation.
>>>
>>> Note that the normal range of simple directory offset values is
>>> 2..2^63, so hitting this error is going to be rare to impossible.
>>>
>>> Fixes: 6faddda69f62 ("libfs: Add directory operations for stable offsets")
>>> Cc: <stable@vger.kernel.org> # v6.9+
>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>> Reviewed-by: Yang Erkun <yangerkun@huawei.com>
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> ---
>>>   fs/libfs.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/libfs.c b/fs/libfs.c
>>> index 748ac5923154..f6d04c69f195 100644
>>> --- a/fs/libfs.c
>>> +++ b/fs/libfs.c
>>> @@ -292,7 +292,9 @@ int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
>>>
>>>   	ret = mtree_alloc_cyclic(&octx->mt, &offset, dentry, DIR_OFFSET_MIN,
>>>   				 LONG_MAX, &octx->next_offset, GFP_KERNEL);
>>> -	if (ret < 0)
>>> +	if (unlikely(ret == -EBUSY))
>>> +		return -ENOSPC;
>>> +	if (unlikely(ret < 0))
>>>   		return ret;
>>
>> You've just added an extra comparison to a hot path.
>> Doing:
>> 	if (ret < 0)
>> 		return ret == -EBUSY ? -ENOSPC : ret;
>> would be better.
> 
> This also has two comparisons: one for ret < 0 and another for ret ==
> -EBUSY. So I don't see a difference. I was curious to see if compilers
> can somehow optimize one or the other, so I ran the two on godbolt and I
> see no real difference between the two: https://godbolt.org/z/9Gav6b6Mf

In my version, both comparisons are done every time through this flow.
David's version changes it so that only one comparison is done unless
@ret is less than zero (which is rare).

I've updated simple_offset_add() in my tree to use David's version.


-- 
Chuck Lever

