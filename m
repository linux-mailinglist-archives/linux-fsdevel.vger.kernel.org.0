Return-Path: <linux-fsdevel+bounces-54867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A909B044CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 17:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D9C57A7580
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 15:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571AE25C804;
	Mon, 14 Jul 2025 15:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dy+OJoXd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zFVTLS5f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1288A1A5BA3;
	Mon, 14 Jul 2025 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752508446; cv=fail; b=sPTTDt2b9HVcXAyUubuGQNeHlUGWCgmkW4qg4u5/mFHrfPDzU+4nsizm+YVvvGmdxBlYLefZtZohm3AuhiujO4JS+Se1Acq2L8DPwbIJdeKsQXULGma58UdvDnuyPabUnc7BJtfo+4pJk9it85LZuc1j2OqyBEUiP5FnFZp2L7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752508446; c=relaxed/simple;
	bh=ao2xchvs1G/GNkzevRUVoMIs9iW3ajRnI6jChue80rw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NlXz3K0cLLKwLm51kiVv8nzo2ymWBVGGbLdCN76jUeGby2bAhu3vHs5NxXhNa+92N47EzoK/kaSWj71UJQK7gURJjirFCeDD2iJ6Vpe+H8JFZe6Te1N4BDjmIeqHhKHW/Yiuh/OwJ54BJ4NZBBJIEjLjKUpBlXJRfIk+f30ad5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dy+OJoXd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zFVTLS5f; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z54i001302;
	Mon, 14 Jul 2025 15:53:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mEDXOw2E9tBjrgMjEFhiR2Hkp72JT9geqg+KzB0rfIA=; b=
	dy+OJoXdAFi3e6yMBomzsRgjSVlcToEPp89lcL5H1L1oLMKl28kPEfcNZMZZZJYJ
	Ps7/pVf7pyqY6CYpTzFUWaNbyt4xGHmPxAaF/ZLQudX6Fa97Y+AJPVO1lh+F4rTp
	ib0FxstZuOYZbs5x6BNdokR+svQRvTGFVoYX+CEI/ThuHbAr1h/pki1os6MjbGmb
	GAKS/cqDFvXn7G79rsilnImksp6sZBmFHsxGRBbZJi6WqLQ9Ajlu+e1ZcltQROkP
	HBm15yk6TCnBUpeG35gm7tVbawQscTRee1YMnOAG0UU1c2LEJkI64oB7fF1Yr0n6
	CnT5CVFoTSnk3NBR6WX9KQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk8fvhw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:53:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EFV6KR013842;
	Mon, 14 Jul 2025 15:53:54 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue586c1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:53:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3DEPzOdXmKqHypM4Y+M5B2zd3ESNRKNp1cHwL8mlI7aKdO8Sj3MYj6nRJJ0uIklR9P9/U/h3a/IoHqwbMGlt/QnHXWS5N7aSXS/4zOJESFn4Xb0dkLR6GueIlEQ/J5I1EVDc0YXSChCVms89EhuIWRjI4VoavdYi3pIreDKzw2dR8KyPM3BHANM6ZKcVrCzjRsLGABrifItKF3lXHtalHv676nldYA1jOcesFgE7P/bG37xPHoWRYaS1P4sMlXA5niyOAkJIDHkkHvWNHoIr5RMQlVvV6ju+E9F8uQqE4u+NBzsxFKCtBfGipvvZClhydNWdThJZ9HXUXl9zJu9Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEDXOw2E9tBjrgMjEFhiR2Hkp72JT9geqg+KzB0rfIA=;
 b=P5zUH3KH1SLCHTampj3lGN4olq6MyfeVzgBie6dsQgyGkz0KLENsuGSas0FgKCFoRQxWj8Oxt28vaQrMFCgdasqE94FHfixAXK9j/RiHykHHc5teGdMEUTYT498Bj+yKCQHA19iAXwVOsyY6ZxdXoJ+XSO5DVspubPjYPVg0NQ2sccG8N6GCBNiuRlGdeMzJAbVSqofmBf7v5wHJ+MacLGfzr+B6HhFNU4rb2HGciOwwa4P2tR3tfmS4eZUngEalw2egMr/5izTwKPMBmY0dnnfZTdCrF+rw68JLv0g8p+DaEe6+Rd+Hj1QHHi5HrX0jeN77BhQubmP+a5kS6nDDjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEDXOw2E9tBjrgMjEFhiR2Hkp72JT9geqg+KzB0rfIA=;
 b=zFVTLS5fNPI5YHzBEU6L//xc+ani+e0uOVaHlxGLCLF3bbJM2HhhAKbZaNfSJwWu6vUmpVB3SJWpDVWsOT9l3o7mrV4mVlhtwJaKOnAKNtrJaEuSLAx1nnHLP504z+chgL3pFIqsLFMRX1fbeXLKS3K7+mbh8x4jJFB6WUSzNvk=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by SN7PR10MB7074.namprd10.prod.outlook.com (2603:10b6:806:34c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Mon, 14 Jul
 2025 15:53:51 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%3]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 15:53:51 +0000
Message-ID: <6babdebb-45d1-4f33-b8b5-6b1c4e381e35@oracle.com>
Date: Mon, 14 Jul 2025 16:53:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
To: Christoph Hellwig <hch@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20250714131713.GA8742@lst.de>
 <6c3e1c90-1d3d-4567-a392-85870226144f@oracle.com>
 <aHULEGt3d0niAz2e@infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aHULEGt3d0niAz2e@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0035.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::48) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|SN7PR10MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: db3726f6-fad9-498f-50a6-08ddc2eea0ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2lXcytYdWxVYVlwV0lZS2g0dW5QSlV5d2VuRFYrUjhxN2ZsNEZCclVIL1BL?=
 =?utf-8?B?RUFqbW1XTW9wTG0rY3g5djZhTkJ0SWMxSnBkNnhyeVBJS1hnTmp3SStrNkVF?=
 =?utf-8?B?ZW8rQzVOZzg3K0tnUFd3bUlqUTRkd3dXMzBXeGExMGdaaTRBYzlFZXQxVDhB?=
 =?utf-8?B?YWNTSVpvK0lsejlzNi90V0wxcXhGL2RzUElrTU9IcGxPRXc2Qkd0ckRIek91?=
 =?utf-8?B?VTVONE1IMVppbXZrNlkvaUNXZU5BTkhvS04zYkVlNzNsUlB4MmJXU3dDczJY?=
 =?utf-8?B?QllNOVl0eUc2TUZCOGlEM0ZvNXhzdGtvQzhIaUtSWEdpOXM0TE1uSHJoakpa?=
 =?utf-8?B?dXZEU2k3RExGTlV4WVV4ZW1UOE91TllhQ2NrNlY5MFl6NG1qck1WUXo4Yzda?=
 =?utf-8?B?NlNHT3FtRDhUNFVjdXZ0d1hoZEdCWStiV0djTXBHWWdNOG1STExxVDcxTXVP?=
 =?utf-8?B?ekw2enJrT3dHOUZoUFkrUHlFQVhTQU04Q0NwZzd3RVBiU2lETDRVQ3lhS0JV?=
 =?utf-8?B?a0JndGRJSTRyY05MUDNTejVDNFBVLzgvcGRwY0lVMXh2MW8xM04rZEtwK2tQ?=
 =?utf-8?B?RldMMFY4THlIVFlYYUtwMXZFOTUrZE84QnFrT0d5eXNnOUltUnBlQXV4T09V?=
 =?utf-8?B?eG9YMWVtaDEzZ0NwUDZBUXdNSXFKY1B4N1RZQmpmWmFVblc2djZaeEs1Sk5Z?=
 =?utf-8?B?R1ZUNXd4RElTa2Q5dXNIeWc1aHlDMW0wbkdUYjF3bHVVckJSNjdjOUFybXNM?=
 =?utf-8?B?djlaU09kd3NCdXVNOVN0alRLVkliTkU2dW9DT2hMYkIwOU9ZajAvY0FDbml0?=
 =?utf-8?B?VlJuNFUwNjUrU0NFWXNuM3hZZld3SUVPWEJ5YkIxV1lrc3Z2cklaaWNOeWRK?=
 =?utf-8?B?NHpRMHo3V3B6akxQN0RPUThBbGYxZm0yeFVnYjRiRmUzdmprblkxVDVnL0NU?=
 =?utf-8?B?Ui84S0dXa01ubzl0bVMyVlJ2bDlqR1UrNGlxQnlvYjJBLzBtV0hkUnRvZFVY?=
 =?utf-8?B?TFVXUWM4bDNQV2Z5Y2ZRWGRXRkxUalNhbEY3MllCZlZlV0JoYU1PWnI5ZUpY?=
 =?utf-8?B?djVoSEo5NDNmL1JIa3pZYUQ0V3pjYnZVelNuVndNSzk5Ty9vNlJSWWRWbThS?=
 =?utf-8?B?RXcrdndvbWYxdDl2QlkwcWpsZG00dlUyQ0dKaUgrenRQdVVUT055MjhONnU5?=
 =?utf-8?B?Z29PNUFUSW9DSXdHUzdsQnpmT3JtME82UzJ6aW13aDhFL25tNy95K0FNK1A1?=
 =?utf-8?B?MjRWdThKUUsrdkZLTXMvQ3VuNEc0SW82bEd5VGZIczZQS2E2aEJpTnE0N2hE?=
 =?utf-8?B?RjFzMWNFZDdWUEcrM2pHaXVzQU5Xb2txanpDbTUyd3VnQldUSHBvWDAxUkdk?=
 =?utf-8?B?NDhpK3NWTW51U1IvY3BJTFBhTUlEV1NrV0RiU21PNmdHOFQvOFZnTE5qNTY3?=
 =?utf-8?B?RjcraFlvUERYN3ROUGgrUEJHUkNxNU84UTIwZFUzYit2SmxZYmhZTzNZOXlS?=
 =?utf-8?B?anNXMEhCQWpMdjgzWjgwWlE1N0FGUXc2NVVNVlZ2TjZ5TnpOM0NTWXBJZFhI?=
 =?utf-8?B?M2o1RklKdldzQkxyemdFcGZ4RmIvanNUSk9SV2cySkRCMkRvOXc2aVhYUTZV?=
 =?utf-8?B?emRHMGlPU09mS0FJN3d1dFJLNENJVzFaVGFMOEFiMm9QdUhxRXNOeWN4WVRY?=
 =?utf-8?B?SEMrckdwYjdMRUp4b0s0OHc1bzVDY2ZVakYvZ0QxTUFNdGtKZzlIMFM5TFF3?=
 =?utf-8?B?Y2ZOb0E4SGUxNS83ckJpY00rc3djaWkrdXFteFY1TTdadFlPb1NnbVZRc29P?=
 =?utf-8?B?bVc0cWcxc1BoNGU4SGJRb0JLd0hXSFprWmpnQk1GSm01ZDFiamlLSXBCNjJ1?=
 =?utf-8?B?b25vTlR2Yk0wcmZKREkyWm9HZDY4V25QWHhwTXgybWhxWVNrZmFSVXQxZ1Yy?=
 =?utf-8?Q?yC8qgD1dhsw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akpkVElheTJFelFWSk1KSWcwSEJYeVM0RHoxNEZ3cUFaTTNJeG05WllpTmY0?=
 =?utf-8?B?ak9BT2hBK2JndmpOb0lMMi9PWmlYWE1aTXNNSURVb2N3dXNDY2dES1YrSkVv?=
 =?utf-8?B?b3VCUmJlb3NicCtCQS9lSFo3T295SnhZQyszWVQ0S0ZPZndzVHRZdGkxaVd3?=
 =?utf-8?B?MnAwelZZdW5XUytKWW9jaEFzL0pwMUFNL2FUZlJZSFV5MU5CRVVtdm5UWGsr?=
 =?utf-8?B?dzQyR2djcTI2VzhFMWpzVFJBWmpJS2dwWGlvTmdNV013Mk9RRFhBdVdMWExT?=
 =?utf-8?B?Vm5oYmpDYWZNSHNnSG9GY2VjMWJwS3NuUTFjUjBXRzRxVmppcHFKdTZwWGl1?=
 =?utf-8?B?QzJGNTBNc2tOTzhNRFdjSkJKaTQrdlJ4VmtpUVJDeVVZK1lMc2x1WjJZcUlL?=
 =?utf-8?B?VVFxZUk1QnF2aS9oSGxVK2pWOG51bkZJbi9tUVVlNEF1SExrbzY5MVptSjVV?=
 =?utf-8?B?TENCOTJIejRUOENkZFByRTlxR3luamtNT0E5aXRCaGQ1QjdNR2FDMkhSdXk0?=
 =?utf-8?B?OTZMV3ZXejYraE9xWUlyemJ0aVBQUGdQcW94MGVnV1dSSFJzc0RPazAvazdT?=
 =?utf-8?B?TzgrZ3hZUkhKWjZpalYvcEd6OU93S2V0MDZMLzV5YjN4bis4VzFpd3VtNisx?=
 =?utf-8?B?Q1JFTWlJcHk5ZzNSM0tSSmoyN3QxcnZoREdjVnJEOFEvcXE1NndQU20zR0JK?=
 =?utf-8?B?VEVieDhONEZRQ2k3Q1QzQjVzYmdJZWhrY0U5YSsvKzNEVWNmRCt1ckg5d0Fz?=
 =?utf-8?B?bExVQ0Rqc2JYOGxSY2prSHdyMi83MXVibUJVNUd3Vkp1OEUwMVBsMmEzYmVh?=
 =?utf-8?B?VW5mL3Fhb2lRaGVjaG4rTW82RTdHZEh0OGdXbkkxTFQyYzcrVkRMbGpPTmNG?=
 =?utf-8?B?Nzl3SkFhU1hsY0Z4aXA2MzEzeXY5RzY0NkJGS1dYb3dzUUZYTkE4RWNXSDNR?=
 =?utf-8?B?RVFGa0NaTFFYNEJFOVdoMGhiZ1VXbmt1cTJoRTd3cXc1bVN3VUJ6aW0wcTZ3?=
 =?utf-8?B?YmcyVEYyR0U5U055Mk5Da1JNRnB2OThVUTByK3A1YTBXcVNORTVpRkFTUmxV?=
 =?utf-8?B?c09jZ2tjWGpzbER1WnB1SWs3OTVHZ3pzbkVPV3RsemszRFNmbnRMc2ZkMDA4?=
 =?utf-8?B?SWdFMmwzSkFlRUhscFhHekNtbm9KYzc3aXVkVzNrS0dQZzQ3N1JYUDhHamtG?=
 =?utf-8?B?WEdIVjhlQzZQRWtPNjIzb0p6WEg4YmRicHpKcWVNS2tpTHdNelVFRTFoNlJW?=
 =?utf-8?B?RldHRDJDM0p1K3ZKalk0RGgxTFVGQ1Z1TWVJOHBWVGNnMGNyRUJ4NFBQL2c5?=
 =?utf-8?B?UnFRZWdHdytwbjdkV3ZQdHlvcVhBdXp1NzkyVUUwMTFOckxucW5QSllXUkVa?=
 =?utf-8?B?VGVuNGhSOEF4b2tLa2VJMk9JWE5NRVB5b0J2Yi82ZUUzWjZSRjFjVDdIaktP?=
 =?utf-8?B?aENuWCtCZ09WZTNjUnJCUmZhTlRkMnBOZzFrbHZxOUFFUU82aDBseU5hazU2?=
 =?utf-8?B?NjFzaE9VL3RGSm1WTzVPVXA3Qis0SnYzR05sSEt5Q1V6S1F6dUwyVG5Rb0ls?=
 =?utf-8?B?QTloMjlEbCtSak8xekJVeEZYM3J6eGpKejM1OUNxL2cwd1Njc3VGQ0UxOXVT?=
 =?utf-8?B?Z0R1Q1ZoeXM1S0NWTzB3enI4QVFxazh1ck54VENoK1c1ME53dFFNR2o2YUlo?=
 =?utf-8?B?cVZscDVHS3RIczVIcU1kdzNvclpDRHRsc1dPcnhBRGpiRnR2TUdsV3dXK0RD?=
 =?utf-8?B?ekx5ZFZTaVliMmxyN3UzVE03MjJ0eVRUNlFVOGttV3JUMm5yVllpdXNGeHBY?=
 =?utf-8?B?b0FlaTQ2Vkd0cS9sQ0J2dTJ2ODVLanRMdjFXVG5PQW1hdDZjR1NaTllPWm9x?=
 =?utf-8?B?TThrNk5zcXZTb25sS3JqL0sxM2pPKzBaYm1TQ1AyT2hmcy9PVVJDSjVOT2ND?=
 =?utf-8?B?SkkyZWQ4OGkyMGxadzhMMUFoQWRNRDdRMy9HQUN0SEdIcGFGYnZicmNRVDk0?=
 =?utf-8?B?ekpPYkRYeW5TVzVXY21XSCtvZVRXZHZKN0ZvMkZscDVDQ3JEamhxckhZUWN3?=
 =?utf-8?B?eEcwRWJpaFFrbWRWK3A1b1lWaThCT1MvOHpNcmMrNllKZGY0SHprME05cUhp?=
 =?utf-8?Q?Pgt6uEIzP4VnJSLEBYtgzerEd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kUBfYs/BQZTSEJRszJfSoyvmHy2gXDRvrLvRiYLtOk1hUj4079DCE2DGobpBxOTZQH9QNrEkot1St9JvP0I+Tm+bylkIUVdyLUmziXBupFA2K6+jbHMjumq4pYtpcjNfgwfxZNXfgqPDh9f8tGgoXLR/6XuJCrgBYz2p4YUZHxH6q/c/ayUaWPFlfWX8ByR7KpBy/8U5UsBMiXi9zITjHmffRgXWFp1fspwxyBddZwyFRHyXCNZBNp5IWwQNqx7KKcs2/67/COMRn+3HhE9P8aUBCRLxjJVLTkg5pNlYVrq3rogAVCbT6YI5Q3djKg+WtGKMM0pkYxiBuIGLKw7p3NArfwpAzQJ5z2jmjjHV/MjtajgWzImbGZ4qS33ukr/KnqpyI05oBTfdNdqxdToiG4hmJJFejjGctR7+QJiuJ8MUnw4EPuyMGrNO9iCSMjkVLsDhGwZdrpFYV4oJXDe35l1E64h2yCgSGkC78TMXC2KYFyR7Bgulsuv2hRnLjrts2WuHrjbxAgsrI7bwMhwIVcskKenjQpeAKPqIXSmg3YwSCZw3/kHjpMWL90IrbT630QiGpNrwzu3sdNNLfG7Xmh498xokVzE6UwSQ2sBbqWQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3726f6-fad9-498f-50a6-08ddc2eea0ee
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 15:53:51.7599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yohk+RKgx0+FmPYsI/iP1opAhmcPjPhfPIdO0QKaaI/GC/hT8QuOl6C8VSfTP9ZOFnI1Xnldci/JCZc+AddNtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7074
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140096
X-Proofpoint-ORIG-GUID: bMO93h46D5Jbvw9Izf3Mh_b0S5ropAGs
X-Authority-Analysis: v=2.4 cv=Of+YDgTY c=1 sm=1 tr=0 ts=68752813 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=kLWA3gBXtu5QbDPQ:21 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=_4416MSJwGB3MlLbwpAA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12061
X-Proofpoint-GUID: bMO93h46D5Jbvw9Izf3Mh_b0S5ropAGs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA5NiBTYWx0ZWRfX61f2KkX8gS+A +TsImqjIptxwD+KsS0cdxWSuF/XIqkozujMrT8cS0GPyhRPlRAqvNzbzfn3mwhj2wOypSq8IzUR Hf3sJFdOl7iEHhgvVoYvmQqkxAgNZuFzIDDNIdp6MgkJTgsjwCuuUb7bHqDcc5JdTNZWmJgsTLS
 gTiWid2SvTz7n1Gn2yEnz9N5sFFmxsWecWkkpI1Lkn6Ks8U+5PkXyoG4j/pYUpv/MAL1T0Sr4tS 8dQR4rs7YfRmubyArxQVZJghHMpnq5gpHVFIqAIs4IgI9DfbTbFNojZpqT2W2o13R+d4gJ9os5a REQFHok76Hlp8xRAOlsJw6M+G+z7vM/wUMCpsmUtvEO11LZbK1RS+VUpsgyl6CoO7jV8tdg/edk
 lGM8Ygz2+/AxLhmT3ZRmMYAGhl3FTqSL18Sm38W9joJyDth9kNmxq39C5Y07CHa+2oYUcQ7d

On 14/07/2025 14:50, Christoph Hellwig wrote:
> On Mon, Jul 14, 2025 at 02:39:54PM +0100, John Garry wrote:
>> On 14/07/2025 14:17, Christoph Hellwig wrote:
>>> Hi all,
>>>
>>> I'm currently trying to sort out the nvme atomics limits mess, and
>>> between that, the lack of a atomic write command in nvme, and the
>>> overall degrading quality of cheap consumer nvme devices I'm starting
>>> to free really uneasy about XFS using hardware atomics by default without
>>> an explicit opt-in, as broken atomics implementations will lead to
>>> really subtle data corruption.
>>>
>>> Is is just me, or would it be a good idea to require an explicit
>>> opt-in to user hardware atomics?
>>
>> But isn't this just an NVMe issue? I would assume that we would look at such
>> an option in the NVMe driver (to opt in when we are concerned about the
>> implementation), and not the FS. SCSI is ok AFAIK.
> 
> SCSI is a better standard, and modulo USB devices doesn't have as much
> of an issue with cheap consumer devices.
> 
> But form the file system POV we've spent the last decade or so hardening
> file systems against hardware failures, so now suddenly using such a
> high risk feature automatically feels a bit odd.
> 

I see. I figure that something like a FS_XFLAG could be used for that. 
But we should still protect bdev fops users as well.

JFYI, I have done a good bit of HW and SW-based atomic powerfail testing 
with fio on a Linux dev board, so there is a decent method available for 
users to verify their HW atomics. But then testing power failures is not 
always practical. Crashing the kernel only tests AWUN, and AWUPF (for NVMe).


