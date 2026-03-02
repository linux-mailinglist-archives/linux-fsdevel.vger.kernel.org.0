Return-Path: <linux-fsdevel+bounces-79088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KC9iGTMVpmnlJgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 23:54:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7561E5F83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 23:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D32A03025A55
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 22:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9372DB790;
	Mon,  2 Mar 2026 22:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="niBEQHSn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EP2+5UfT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F3E2D7D3A;
	Mon,  2 Mar 2026 22:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772492077; cv=fail; b=Ur68vFFtyj7iShN9081NVJpV/WL2Njy5Uk0VDWV5smvnMCRp5FG7dYuzKvUvnUIBrm/MMjZfECn/cTgc8QcJnIH7EQFFaMHUwt0q9bLf42ql+MoXpTxbgCeaq+LMZnQo8pCl/xwe9oSzrwImqrouT22JO2c1xTLlsHVJEVVdzpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772492077; c=relaxed/simple;
	bh=+IUTbaf3KgyoLK2mqZD83Q3NRD7kQXmxor7Jn+VSjgY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cYsUd/1/kDuhzCWw7lZg4HQ4PItAAY2dJQj8B0VHDMtRmA4tbelOyjoOB06iky6Ztl4NN0O5MQ8u+NqeHLAVeYO+VuoqbLC/Q39jgoQoe9e2Cd1GuX17nsMbcC+dk0Jzot3+BVlgXONXWhchrxJ8DlWTS9GWcntUslr45EMGrcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=niBEQHSn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EP2+5UfT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622Ml8623249114;
	Mon, 2 Mar 2026 22:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=aYpEIu9S7CWwEfLwMynqacjPxoKd6Xm2sOHvZt2LWrU=; b=
	niBEQHSn7SFOZEUwZmB6+MsnAE46Bs9IATlvRRs+mMZS9G6X1uVowfvg7NrSZdXG
	a174XdgdhWbh0u9WMlJeALkiPTl8SqxGM+E2Xfxjuf8z+JzNNT/tsSk4hD5uv/w/
	T48aTu1hcbQ5xoasamoYyUxBGdz0OwrX/J+Q5qgvya49PAramK/uK8Ign/p6Bf8C
	FCH/tVskmWJ1D83j2Ljqr3pUU9MkxxoQDEmQNxAa9XI4k5gLxZ63iRUyhiKqx1qk
	vO03nVZpLWEcMgW91yO7ElvepeyBe1gYdw7T59YFEKKGEVYB2D2poaCbGnGlQsx8
	yNpHmqpmT9cvYwIlGIFgSA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cnkn8r07n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Mar 2026 22:54:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 622LKmiu027357;
	Mon, 2 Mar 2026 22:54:22 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010020.outbound.protection.outlook.com [52.101.85.20])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckpt9acr2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Mar 2026 22:54:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtMeWdOy/nCKWsR7QjgVQrEGICG85cUnCUhEW4qBapPFH4LIWo6kGRni+CPSuiqrflIbuQ9LOFKvtFfb9CgmbMps63OThdDyPcXvcDeXvMQPCaUjw+xG+eEK3+V40Pniyjeb8r6WRDy1G1jNGd3HqKkmj6cYRSm5syzY66diMCU6Gz5dLdu1zWbldArGt4URVR/7eFfUu6WUrVJOts0BzW211nqPT8iW6pL9WmD0A4fkDRzRsjHEFE7EZ+DmkXqPVlb1M7zbNMeNwGq753NoP2JtMuS8pnhR9m2Zx4+1Pq6HDC13rP4apuVlW7JDyEXPZ3foHh6fy9GmhLCOZAsqlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYpEIu9S7CWwEfLwMynqacjPxoKd6Xm2sOHvZt2LWrU=;
 b=igvdGKDga45aMKiqzP65FRb+BJNIbDHtGgJRXB0dAi/5eOegfnwzGHzJ/Idk0UT/DQaCPW5TJp8EI6uspOCbyhodE1fGSAFM2Y1Z6/yjxKdBmJ4gNOrxTBCBk522U0JblyXo9JL59sVAyuj1fj/MlhLk62UwS+qG2ZDleiArbiNbPCPJ2Qlu9nZfO1LRMgchfegp9uFT0ufTRtNShnOGK2DN/GXTcDzUmcnlBXzSdBSnE72Xeno3JqtxucxO7QnCRyYJHAXuq66rI9Y9g5mKkDuM0vONqQt6QeCom1PMfLUzCL42DyaEPhX+RSI4lm1auXMTco1rjvmqJ4e/I6T0Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYpEIu9S7CWwEfLwMynqacjPxoKd6Xm2sOHvZt2LWrU=;
 b=EP2+5UfTY6OCVCIGUyIFeKPDAlUHIwWfZgHURHUF7GysDek20eD3LIl7O7ajDYHNccOs6pkc7RMu9PdWq+7I8jfyG2j2sQDlYZURUN+7ltgfQ67LMUw90SjdXpKFOGCHmOWKt5qQuwf8tj3xZscF5qtRJMnA1D5FMDNJrKN1+Go=
Received: from IA1PR10MB8212.namprd10.prod.outlook.com (2603:10b6:208:463::20)
 by IA1PR10MB7238.namprd10.prod.outlook.com (2603:10b6:208:3f6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 22:54:15 +0000
Received: from IA1PR10MB8212.namprd10.prod.outlook.com
 ([fe80::ee8a:bd21:f1cb:c79a]) by IA1PR10MB8212.namprd10.prod.outlook.com
 ([fe80::ee8a:bd21:f1cb:c79a%2]) with mapi id 15.20.9654.007; Mon, 2 Mar 2026
 22:54:15 +0000
Message-ID: <a431d970-023b-4243-9c0b-a374f7823d2d@oracle.com>
Date: Mon, 2 Mar 2026 16:54:14 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 036/110] jfs: use PRIino format for i_ino
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
 <20260302-iino-u64-v2-36-e5388800dae0@kernel.org>
Content-Language: en-US
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20260302-iino-u64-v2-36-e5388800dae0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P223CA0006.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::23) To IA1PR10MB8212.namprd10.prod.outlook.com
 (2603:10b6:208:463::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB8212:EE_|IA1PR10MB7238:EE_
X-MS-Office365-Filtering-Correlation-Id: e90c5934-1ea6-4616-557c-08de78aea139
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 bhi/0iVISZK+PsW4/EdAoQDggN8y6a/8NbWTRzaErK8DDVC8tpRgUZLej34bl5WgEY+zjTdUrvyZMVe9raLU4/5IXptW21et7RbtyVy4SEnK8/SQ4rbl6nI4ZpQPKP+If6XDBuLnBTZk7Q07Lnr+Oy6yap7PkthLazvDMTPjn8jRX+3xsfRG0Mgp6WA88IcMmRyscHeXxAFE9GEEnxfyIadYWiPS6Btw7tmDizZIVK6WkaXnzlCDLJ8NZTgADdC6M/n+8r4wzvziryOKB4sMX9JJ6lbxDlPPVbB9/vZSSLaj06yAC0Q6yct3svU/vtE2Ylcz3pwwSgwSFLpCDAA29VovFpxILfUTTfQEeKXa4rcZMBT9mN1pc4q4Y/QFdTvrPTEfVsdqmxvHLzC3tJ2RfoSlKHodVfqHk5nHDB9Jv3gl1pdGl3f2ril/H4ZA4f92hgr4PkVgzVWDrrllFaQqwPS0DEJoRLzdmCuWPhq4HBguBcR2Vi1ZKjmltGDg66nT8+oXLwgL5LAwZNTlmZLqUmMMe93uCV/QSZo68ALufG2tWwql4GNMBRK8gZbJnDUk8goezDdNjSGXiNXWd2ObAFo5EkeyjwRPnHwZ38VEa3bz7hSO0Q3J6gF+o4nilyIQEIuOO987ABaV683J+gvYqJXFQE6OHKZWN7fON3dXMhJzi6D552oTWD+HMzzMz+PKEXirG0h7/NbQcQX7JlCXK52CWAAq150lNKtVruJeFhY=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB8212.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?YjYrVjl4dk04SWFDbjdrNmRxemRkR2NrbXpObG1wN2VzYnpRanVOaXhjbExu?=
 =?utf-8?B?SEVhR1JLNzRtaGdVaHlaT2liS2ZIbUw1UjlGSXVhSWptUUJQU3dYVkh6OENI?=
 =?utf-8?B?UUFuMDlDbWZ0d0JXb1dWSjVEampIL1JqSGh6OFdibVFJUVdvZzRDcGJCTUdq?=
 =?utf-8?B?MHp4V0F3alFWQnFud2NhNFVIUW91SlIrcUZXRzVpdnFBa0NTMVN3dWlzaWlG?=
 =?utf-8?B?ak5NYXdON0IvUGtBZGdtd3pxOWRkUGlJMWxKUnRrWm5EbHFoL3NZNWVzY1Ir?=
 =?utf-8?B?UnRXa1hyOEpHMUJTbnpjVENVMGIzSm9jSWFReXM2RW1tbnhWZnFtRXlHZXZr?=
 =?utf-8?B?TjJWYzZLemR1clFSNVVtVno2Vjh1SzJSV3lPVjlkd3N5aDRpSjM5bllNRVNR?=
 =?utf-8?B?RkRYZTdDZUxDbWs3cVJkWjhSL0hZa0pRV1IzeU42RDR6eDg1Y0ZHejg4dG9T?=
 =?utf-8?B?WklMZkErRUpGdk8vcGQzSFhzaWtUclA1K0dzNmpBalpUTkp5MDIwYitURWhi?=
 =?utf-8?B?ejEzZHB5WHpRdTByRGR0b1RxcUdCTkZ2TllQa3IvdHRJT2tiRGNlYXJ3V2or?=
 =?utf-8?B?VVlvTlljbCszOXV0TzVTMmVrUGVDZFVRSUZXYlJsWEs5QVNRRjJ3RlNLaUpt?=
 =?utf-8?B?ckFFUDhRVnd4cy83MGNHRGdiUG1ZeGRCV25LY2hMc0pmWWY4L3hNWmtWWFBT?=
 =?utf-8?B?Zk16QUpLeVlWdXpKaHNCaE51OEx0eUlGejAwbEg3a1hSbUMvSWM4SEhmai9i?=
 =?utf-8?B?MXFhdHJ3U0JhVk1kNDBCKzF1SWFuZVo5VmR3eU1WU01iVkVWcndtQW5FNXNy?=
 =?utf-8?B?SE10SUFEd3k1ajEwY3hMdHRiQmtDRCtmVmJDelpodTFTdGpWdk9lV0wxRXFh?=
 =?utf-8?B?L2RnTzR6clFGSzFCSnBQRE9rY2E5eEVTbFM0RU1vbHBHM09nT2NzYjlQakxo?=
 =?utf-8?B?NGFrbTEvVXhmYTRZZVZnL1JEZGFTM2VMV2RzNkowd2FVMGxtNTRxWi94dEtm?=
 =?utf-8?B?NmgzSHlxMUhEQStmRy9KZlloZ2JFZVZhUjVZMmVZZzkrQ3J5ejRGSitKSVZ1?=
 =?utf-8?B?eENNTTMxbmtrVm9EdGdvVU9CNEVKTHBuUDNkSFZQeHVjdWREaXdrRFgyQVI0?=
 =?utf-8?B?YnhyaDBISTRpY0xHWjMzdkFDUWZyTTNYNll2L2ltYld5bHdwTWJRVmhvdnNs?=
 =?utf-8?B?RWZUWDdCZVRGaTJoOGIxZ05HMlhaN2JxSjJQU1YrWk9NV2F0S2dDcC8zWWlE?=
 =?utf-8?B?WDdTd3U0STZtVjk4NE9uNkN6ZU4vWmZ1NlNpOGZ2RnAzYXJhTFlMejllSGJm?=
 =?utf-8?B?UDJqVWJkS3Z1STVRV0pUb1hIdlFobXltVTYveCtvcjY3RnM0cUZzTGh4OVJT?=
 =?utf-8?B?ejlKNnI3WXVXNVllUTZTenlBMExMY0g0LzhDYVhVWXVlZkRseXRFMEtsMHBD?=
 =?utf-8?B?V2lQNnVIeGtwVTM3QndDdzltNVBheWpURVBOeU1hYTVBWlZNVW1Eb3UvZWZR?=
 =?utf-8?B?U2V5M1BLYnhucTROTkFDdm15U0J4T01ib3Vpc2psNFFxQnk3YmFrVlpnMXFi?=
 =?utf-8?B?NGhKZkM0alV0WGwyeVp6T3FxbDZLWVJwQUFYSlFPQkc1Y1VZWHpYaHN6RTlU?=
 =?utf-8?B?d3BXODZkNmZ1aGFEREdheGgzcUd5Ykhyb1RXeTgyR1ByQmJrNXBaY1FhZ2gy?=
 =?utf-8?B?TGE3WWVzWW1INE04dHBhRVFzZTNVTFNnMmNWcU9tUEJuNnplYmJOUWVneVVx?=
 =?utf-8?B?ZjlCTElqWEtEY0FGcDhXRjViYUdOcEVZZENueGJKdGVtTTlkVW9YMmtsOUh3?=
 =?utf-8?B?Qm92WVVJdW92UEFqZENUakpGdWxubmhTVHphUmdsOU1JbzJzQmxnY3BHS2tO?=
 =?utf-8?B?amlsZEtMOGJwRnZEZWZJbUhDTHhYKzlyaE5NSHVnY1cxeEdPMGRhYnZNSkx4?=
 =?utf-8?B?dDZxOTJQeEdNYnF3b0xSbVFqLzF2THlmOUFYWGNOZmthUjJoaUsySFIwcHoz?=
 =?utf-8?B?L0xQNDdOd05pNXpOdVcxVDJSemZKQnB4US9IQlk3SDRaYmRKbzZjUTIyTWhK?=
 =?utf-8?B?dlgxS3MrT2NFS2FMdTNkbFY1VW1zOTdmMjJZdU53aUVpWGk2Z2U3ZTUvUVJz?=
 =?utf-8?B?WS9lTTZCOXF1bDVWSXJpcldXNHREMjZRejEraXF5K1JOSmpTbEMrdytsQVMz?=
 =?utf-8?B?QzVyc1ZKVkJYMEoyVTZXZWVmMnhvQ2p3SDZ4M0lEZXliQnhPaTJsRFJVcVBl?=
 =?utf-8?B?akVpK2xWclpLZE11Vyt6OS9WUnNJS3ZLWmJaL1NPcU96RDNwamllb2dkSW5W?=
 =?utf-8?B?OEJEMVgzbERHUXQwRGl0aGt6a051czNIWDIyU0YzWWRwbEY0NXJwak40STJy?=
 =?utf-8?Q?zZBCSqENE9f3DE88=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ekN3+VDPXyJvsnC1g6TwD6pHEn7B4+IgNKB+r+ZTFQrt/bDP0vh3vcCOg1Sm9Kouaml1UHat5a1jUl7dZYXpa1hHX109L3WRgPR3FltQYrbqzDNsR027aWMOe/NxBp24rJK/zZu3TqrMd8uIKT4KTwmBlQLGcDBgLo+XbVtghpAH3F29sQYYx6sKd2aem2Nb8eKp0nNa5H2NRcymd0Vvh5N9AMIZ4JS7V4kN5hr95AbOYbX/QWnIXMw508b5Zk4R9gTyUAc053BNfTJweK0SFXDzOcz4RUHMqdYIDL7xQgeB4sPuoq+iZ+RuTbK0nv89QGDu0jPGYY1c4Naj7WVMIrFmJmojfvYKB0tjs0/S4CNTEZ5GuqhOFaRNTmvj0ld7LwwrAMhxogkF9peQ4k0qs0UOp1POEZJZLcLCCGExQ/EEX8OoTQId0x3PDAEcWdgA52UVNIQDQhCAB3Oj99wy87IuHIhvWM+S+fnH422753KRvVHxV5s9Y/BuDnD3GKsXDVe2q2v1gLiTxrfckd95g+MMSQkFZ1ADNWS7Z4A9KNuTsdfFjvdrsYqoDY6B0fF9DEf3pCzZr8w4FwdukL63ZT6it12dKTb0/AQEgAn8dNI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e90c5934-1ea6-4616-557c-08de78aea139
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB8212.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 22:54:15.8898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yrJh/Ik3DKa4dFmcXIlmI+blyycjE0cPwfeyUUpOfZbpY42XPg5CmC8/Wu85RTQJw+uk+28PchH4bldb6TGd0RYsNz2Pq5zvhFLe261UZkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7238
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603020168
X-Authority-Analysis: v=2.4 cv=Pt2ergM3 c=1 sm=1 tr=0 ts=69a6151f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=pE3W739ntX6lw8Ecuz4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE2NyBTYWx0ZWRfX/lPxogCiptHS
 IeImXjnWjI15t1rHRC2xhEIAMJ2f7va6+WY/q1Mvbi7/J54Lv2niOw25J2hD49wLhULF9+IaGh5
 sXksEo0pwmEAXPv7xS/ds4EaH+tC7pjzPBcB+SinzfcnJM6IhyZKRAjs1CEAXxnMWUfcf4a7+dA
 DayZZOsSKJYOlyBXDVuHzRMIIXJhc1ypUHFqIOdA7/fWO38SASwch6VjoyzWjzN44xx6T8Pu4cv
 aT60LqXaQsUf3Pw5C3LDF1OHBivX0PtSKt6QYXubUudnA4EoCgycu7XwV5TC4K34K7Sx2i3SWIq
 RFjdmUknNguF2ss9ez2yMD4YMAcBBgBsGWwJEJM+1PW0+VaFksU/GHcacEO4MTd8BBvnjK6J96J
 uPAMyKqYMwv5Do2RzPniw/ImPecFQm2qa//kn0xgIdG5qfUfyFDzEdJ1lQ83/yn+pU97b/APF9o
 Gc+Vvw+7eLcVFVno9vw==
X-Proofpoint-GUID: b7tCveECFCz1De7pW5yRX9lfGcRR0Unt
X-Proofpoint-ORIG-GUID: b7tCveECFCz1De7pW5yRX9lfGcRR0Unt
X-Rspamd-Queue-Id: 9A7561E5F83
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-79088-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:dkim,oracle.com:email,oracle.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.kleikamp@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On 3/2/26 2:24PM, Jeff Layton wrote:
> Convert jfs i_ino format strings to use the PRIino format
> macro in preparation for the widening of i_ino via kino_t.
> 
> Also correct signed format specifiers to unsigned, since inode
> numbers are unsigned values.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

For this and patch 89:

Reviewed-by: Dave Kleikamp <dave.kleikamp@oracle.com>

> ---
>   fs/jfs/inode.c        | 2 +-
>   fs/jfs/jfs_imap.c     | 2 +-
>   fs/jfs/jfs_metapage.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
> index 4709762713efc5f1c6199ccfd9ecefe933e13f67..7529043baaf30a6227e5d8edbefd9e37a8105d43 100644
> --- a/fs/jfs/inode.c
> +++ b/fs/jfs/inode.c
> @@ -64,7 +64,7 @@ struct inode *jfs_iget(struct super_block *sb, unsigned long ino)
>   		inode->i_op = &jfs_file_inode_operations;
>   		init_special_inode(inode, inode->i_mode, inode->i_rdev);
>   	} else {
> -		printk(KERN_DEBUG "JFS: Invalid file type 0%04o for inode %lu.\n",
> +		printk(KERN_DEBUG "JFS: Invalid file type 0%04o for inode %" PRIino "u.\n",
>   		       inode->i_mode, inode->i_ino);
>   		iget_failed(inode);
>   		return ERR_PTR(-EIO);
> diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
> index 294a67327c735fb9cbe074078ed72e872862d710..c9ea54f06114ce210ab2d80ad80d0dfa6c55b250 100644
> --- a/fs/jfs/jfs_imap.c
> +++ b/fs/jfs/jfs_imap.c
> @@ -302,7 +302,7 @@ int diRead(struct inode *ip)
>   	unsigned long pageno;
>   	int rel_inode;
>   
> -	jfs_info("diRead: ino = %ld", ip->i_ino);
> +	jfs_info("diRead: ino = %" PRIino "u", ip->i_ino);
>   
>   	ipimap = sbi->ipimap;
>   	JFS_IP(ip)->ipimap = ipimap;
> diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
> index 64c6eaa7f3f264ac7c6c71ad8dd0d59b63f15414..0a1efacaf4e2196197cfe44e5c51d89b15d39545 100644
> --- a/fs/jfs/jfs_metapage.c
> +++ b/fs/jfs/jfs_metapage.c
> @@ -692,7 +692,7 @@ struct metapage *__get_metapage(struct inode *inode, unsigned long lblock,
>   	unsigned long page_index;
>   	unsigned long page_offset;
>   
> -	jfs_info("__get_metapage: ino = %ld, lblock = 0x%lx, abs=%d",
> +	jfs_info("__get_metapage: ino = %" PRIino "u, lblock = 0x%lx, abs=%d",
>   		 inode->i_ino, lblock, absolute);
>   
>   	l2bsize = inode->i_blkbits;
> 


