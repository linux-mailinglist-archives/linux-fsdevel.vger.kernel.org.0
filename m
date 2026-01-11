Return-Path: <linux-fsdevel+bounces-73153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3592DD0E8E7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 11:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 942253004E20
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jan 2026 10:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D292D7DFE;
	Sun, 11 Jan 2026 10:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="eAhNXNJe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27BF1A5B84
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jan 2026 10:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768126680; cv=fail; b=ejXzOSS972Y3OPXPZc6mMJLAY8jMoA4D46tJu5peJXajDdLm6v0HzpZnueYhAadV3ut4j/NsW4EITJGijQvzmSLDPDkYYmjb4miton78IfDg5O7hLUpM6hXouFm09MEvbHcJTIHsYsVsSD6CrACZmqaqUxRePN9v86kjca90uIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768126680; c=relaxed/simple;
	bh=FI7puBFjpoKxQUQDwLvjwMpVBs6YVhDJpplvP06LNbM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XyIDwHlYN4Www0GCGwmdvN97mTWR/5l9GOht5P1us9v8rkmJNpO6NnJag7bnl6Djtmk/5aXEzPG2h9w940MGvyGzeT8JEu5VqIROZKR60DSK7QNofXaDL9slrcN9dVkPtplu9sTEzCvLh6+v5C4Lc8JWFh3vzh/v1BvnVEX8g9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=eAhNXNJe; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021080.outbound.protection.outlook.com [40.107.208.80]) by mx-outbound43-48.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sun, 11 Jan 2026 10:17:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3Gz+w28Tcrou2DNxP5pRA9pw8niaAY12tXCU4agtxEZqGNgL3u5+22EsacprNkrewTzBYh0nGWJNA6d8Uilm60M4f45rTenhVuqo1ESJUkwMU16g35SxwtLV6dDrjO98fLt6V0mnXo52dUYjKoRCKyeoLBny/Siez7POXrcoGNSm2XsLpmO2LLs6BhFdRfW2dZ6/uOlm5aZ76vzzjrMn7fNQ/eqcI7GYxaAW1txp/ItGxNx6hFMAZ/cMqUUFD/xxbP5NUJt9wW/kRg0ygEL6ydF8fj6LjaNFh+DXO1qHebHi1HTcEnFlUtE8p1Z8FzXlp282aFTAMuxFqkYDqgAOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yARcooJovWSrI2iICTv2/nsFB05wgyGkbDlftMO24jA=;
 b=iZv3T2r8Iryflato4UcqmW6X0KgHdcQ691xWWygznyAx7pa1Dhpt5KEDh7S30hqTYQo4hXeQJcWoz/bA+pjKdkKHuIyOlSOwdCPXrj3PxU7z95BC/VkV1DLOBPIWhwUVjLnd6nbZnVsELfdqOWYSqapD4OVyvj17bip6IvztgWHrDVNvhQxWg9XKh9kxq5cMVRgB/dAPuO40ROrQEOBuGPflOgebWpJrQTgj+X3Tu6KWnIez8aQ5B/W3dobKMRVVXpp87MpjCF28J7erNE7u0OhBHCiTZ19oZs9vtp0wrk68sNIiRwfukq0y01BSpFg55qXGkQzvCZaCqTxov6dlzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yARcooJovWSrI2iICTv2/nsFB05wgyGkbDlftMO24jA=;
 b=eAhNXNJeHl4/juYO3A7SEYPpaA0zo0Br/PUJRpD0EQ4QoMP7R1UdHG1IJSf6V5CizGnzH/t+pSu8eljlhpiQkdr3lkgfLu33FJi4k5smFhUVl3UoJeIeNCW/A6+RmGThu/k7OgCuP5mLa1UUzVxXxsl7AAiObjBbD4oRRtHVBsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by EA3PR19MB9497.namprd19.prod.outlook.com (2603:10b6:303:2b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 09:43:48 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704%6]) with mapi id 15.20.9499.003; Sun, 11 Jan 2026
 09:43:47 +0000
Message-ID: <55403442-6f35-479b-845c-8659e31491b8@ddn.com>
Date: Sun, 11 Jan 2026 10:43:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fuse: invalidate the page cache after direct write
To: Markus Elfring <Markus.Elfring@web.de>,
 Jingbo Xu <jefflexu@linux.alibaba.com>, linux-fsdevel@vger.kernel.org,
 Miklos Szeredi <miklos@szeredi.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20260111073701.6071-1-jefflexu@linux.alibaba.com>
 <abb96eb3-49fe-42bf-aae1-a1bf5e7a3827@web.de>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <abb96eb3-49fe-42bf-aae1-a1bf5e7a3827@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0034.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::21) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|EA3PR19MB9497:EE_
X-MS-Office365-Filtering-Correlation-Id: aac6c504-bc59-4c2a-a26a-08de50f5ead8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjJoMVROTEVuY25QZk9zU2Jpa2xZNE9wTVQvRVdiMlo3eEc2eDMwYTJtZzMr?=
 =?utf-8?B?d05OdkxGb3p4Y3VxVXFCR0J6SWp0YW9waVovYkFCYTRZaGNwRHNNSU9WdGhK?=
 =?utf-8?B?ak81ZVU2UFRaYzJUNEthTVVzb2VOeVUxZFFWQlI3UDNqNTB1cGZiRW5vMFFl?=
 =?utf-8?B?N3F3akZuTUpLeWQxZHdqd2hvbGFwME5yZXF6VXZnU3ZsQzBvZlF4ZUZ4VWU4?=
 =?utf-8?B?NmxXYjhNcHZBQWNCTllQTVU5Mk9iNmVEYVgwVm9qRXdCQll5SVA2UWFvM2xC?=
 =?utf-8?B?Y2tPSzlYZE12aGY3ZllHN0hsY1Z3aTBqa3VIUTk3aG54cmlIMk9jS1BEUEtK?=
 =?utf-8?B?dDVKS2hpb24rMzlRSUxDS0lxanVIWkpOSDE1YW1OdnBDa1Bxa1BUbHNwRXhl?=
 =?utf-8?B?b1FHNzZiSTBkKzIySXVsNml2NjIxVnZoSjJGUkJNbVlXeTJVUU5BNEJobnpy?=
 =?utf-8?B?Y3RscDlTQ05uZFA1SmwyT3dSQ2xMMlpZQllFczhaOWpKK0Z2c1FrellNM0lu?=
 =?utf-8?B?UExQNWo2ZHcwR01wdDNNSG51RGJEU3hhUEdUa3hOam5rMkF0NE83QndaSUhK?=
 =?utf-8?B?UHJpeXpMZGJtcXYxSzc3Y2hNMG1ONlM0aGdTYmp6ckJ4cDNZcHk2Ry96RC82?=
 =?utf-8?B?NS9SNkdQYXROYU9hOFZEeWkrZkxzbmFpVVV4bDIrOEx5MTU0WnRrMVpjTnB5?=
 =?utf-8?B?RlN6b1g3V09iaWVxQStudEJkT3lCWDlralBVdHlCYzdMSFRzcS9WekxFSHd0?=
 =?utf-8?B?MmJZdDBnWDA2TnFJVjRuRG1qWGZWeEU3OUpFaUdKRElOTnU5K2xGbDhRK1R0?=
 =?utf-8?B?eDAxWG1MTzlUYS9jdUd4Vk8yeGR5NkNvLzVEWld2Z2p5Mng0UmQ1YUFVUFIx?=
 =?utf-8?B?VUFQMXdXb3FjdlVUajU4d1RxUGY5cWZoVlhqTlFsMDlzdkl0UTFQdW1uaUVT?=
 =?utf-8?B?MktOVlFURVdPdDJuRmZFaVM1aUNHaTJ5MWdyb1ZQWkM2dXpraUhTVkcwOXc1?=
 =?utf-8?B?K2M1d01WOTBxRTRqZFAyRU82YUxlUzJoRFNBNDN6MXoxVGkvNHBTeDlMcE5Z?=
 =?utf-8?B?VjBLMUx4dWJpclUyWjFZQVg1MzdGRnhTOHQzeUpKS3NCL3ZtaHhKSmFTZmxF?=
 =?utf-8?B?YlVWM3BRRnY1RWJqenJRSUYwMk0wVWZqRDNRcU1QUjl3MjVMMExwOWlHK2Ry?=
 =?utf-8?B?N1ZSTUI3MWllMjQ0SEVVakhWTklYYUt6bU1rUERzVktUMVBLT005RFhrc1pS?=
 =?utf-8?B?NjFRQ0pYM2ZRa1Q0ZEFuaGZsQjhhMVlLOFNSNERFM21Mbk45L0tGaE5vb0Vu?=
 =?utf-8?B?eUZhQTZ6M2lIRGkyWUp5elM2S2xIWU9CU2N1UEp5Rkd1R29nZ3pFL3o2aUNT?=
 =?utf-8?B?S25RYm9WRTRMUng4SFYzQ29XSHNEUTVqcnlkcjZIbUtaVUlOaUs0K241a2Fm?=
 =?utf-8?B?ZTh4VEVoVzZLNzlEN3J4SXRWVVdNQkpkRVZiVy8rdWY3OFdSZmdVRmRweE51?=
 =?utf-8?B?N0lGQkZnTE8xdEtGTXFVMm1WMTJTa2l1NGdzSHZOVWsxWUIxM1h4SmcvOU9G?=
 =?utf-8?B?V3RjNUtLV1dCQ21Fc2ZOVjRwbitVVWlyaWE1QlczbjBBVEN6eGRBZ3RKTi8w?=
 =?utf-8?B?ZEhXYi9mb3hQUnp1YUdyM2lha1Nyc05VWnRlZ1hiWXgyYVhtZ3RZem4rdjli?=
 =?utf-8?B?TU9qY1BmSWJETmtDT0o5NUNIZ1pDTFR2dmxMVEJCNklSWmQrM3ZYZk9Id0Ey?=
 =?utf-8?B?T2l4ekpmd3ZOWXdkcmF5Sy9QNjZ3eVl5YUlRNXdxbC9SMUdHY1VWOFNlbmo2?=
 =?utf-8?B?WXQrcWw2R1orSUZJdGFkaDNwbUpzT3E0Um50TlQ1MlZVUlFDR2dMY0NoME1P?=
 =?utf-8?B?bUVBZ1UxTlZ2eHJleTAwWWx4TE1pYWhZRk8zcTRqSVY4V3FFSjR5NEtMcFV4?=
 =?utf-8?Q?SmQQ96SMmhVGo5tUephlpkEzqaqh7ig4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVRad2pvUXFqaHdOR2ZYT3VtSUwyL001SER0dnBOa2o5cUc4MGFIdWp5NjQz?=
 =?utf-8?B?Z2lnaDhMbm00M3crVVpTaXhRSXJQSW1DMjBIYXZUL243VGw2WWh5aTBsMzJX?=
 =?utf-8?B?NkxURU52OGM5akM0K1ovcDkxL0RvcUJFNnpnRjhGN1BpL2JpdkllaEFZUXpP?=
 =?utf-8?B?MnlkTGRSVnNwcGhYdmpxNFNTNXBqUkRFWko4NWc5bXNMSXRwZnBjOElkalNS?=
 =?utf-8?B?RjVHTWxCMVJiRVJvNTkveHZzUWdCZW9nU0pldXpWMkhDb1g5c2ZmZjcrbnlN?=
 =?utf-8?B?RnRCbWlhSkZRNkEvQ21VbXZxNU9aZE16YkVwUXgveDhvcExPakpqUnZYU1NH?=
 =?utf-8?B?NXBRYUlIZW5MaHVSR05lT1JPTlJhZHRzV29wN09oRS9CbGxpU1czVW9nQTBs?=
 =?utf-8?B?cHNXRmR5KytlWTNSbkx5SkI5WGRWYktaUWlCNUsxRGRUNFJSSWdPS0pabG5n?=
 =?utf-8?B?QUVpeDh4VmM0S3dqRCtYZHdwelQ0NzJXOXI4UDJ2a01YN05pV3lQOThQSDIy?=
 =?utf-8?B?OW9TRTBjSTFqejluOFdySWNtMlZLNHpTeXhOY1U0cHdESUptVVkwRnhGbnVW?=
 =?utf-8?B?MjRXY0ZWRFdZcGlyZVRVTW5TMzVON1k2RU5sM3pRZndMOWtGR296dnpLN1hG?=
 =?utf-8?B?YzVtWXdYdm5LNW5BTUhZcFYva2E5Q2dTK0xYa1JSWlNLYmkwUE0xaGYyK1pl?=
 =?utf-8?B?aEtHWExPQ2lyMEJycjg2a0FyZVZEUFdCeXZzVlNlUE1kUWJaUEpSeEtHU1pz?=
 =?utf-8?B?d2dSS2VMODM3NVRscXpLZ1NGeVg2aFVOZEQrRzFCQzVYYnhGVmp4UU1nSXhU?=
 =?utf-8?B?Sm1pb3krL1pMQ3FQb2VTek9laUtVY0dVU2tEU2hwRVlOWXFoZnlHTmx2bStF?=
 =?utf-8?B?U3gxZW1lSThmSFVJTXE4NTFITUp0bTkyQVl2V2lUSTc2YU1jTGdBblAyZlpw?=
 =?utf-8?B?MDhHWEsrVDNzbis4cDA2cmhzRUVzTTY1R2NONXJXc1pYM3l0OGNUdEMza2M3?=
 =?utf-8?B?V1dFUG5iODh4VlpLRCtYYTBOYUFZeU9xcXBkbEdFdldqYjRWZmM4anNnTzNz?=
 =?utf-8?B?ZHpURkNBTFFJYjZCc1BINTNtL25ScGg3TWo4N1gremg5bFY3amszTjdnblJZ?=
 =?utf-8?B?MVNVUURJL3QrNUxGS2hNUzRHZlo1Ky9BS2ttSTNrVzRLbjFFaXJOVjZ0dnYv?=
 =?utf-8?B?RmZsWG9sTGtkWk5ObWlDMlNSK3IvL1g1dmplYUlDWENNM0QrMG9taytRdW9s?=
 =?utf-8?B?andJbUxIWVU5dkR6QWo2bmJUdnczY3dSUXBPS0RrWVBxMytkR1ZuSDBwZUpK?=
 =?utf-8?B?dzhIeThtVUJQbDYrVjVlaEZseHZ0UkpKdGhsMDdoRkRzU0R5TzZOZ0V4bnhM?=
 =?utf-8?B?OFE4dzduR2FwaTMvL3dGZDRKcm1GMXhYT2lmVHQ5NDBTTjVPWHVrMnJoUHdN?=
 =?utf-8?B?dG85WisrOUE0UU8vV3BLQTRnTUl3czR4Q2R6cUdGRnZpTTRWclRTMlBObWNT?=
 =?utf-8?B?dnpoOFYxa0NFOS9QSnNVOVJXbHNLd2doVFhzZEdSZTJQVjlLYUtnaUsrYlpE?=
 =?utf-8?B?MWtINnF6cWtNNndPS0REU3dZWmZ3Vzh3eEZhQmRsNC9BZFEyZlhjOFZ0NEZ0?=
 =?utf-8?B?RyswVEs4ZDM3MXA4Q21HUG5kTzNNeDlTd21WejU2S2dBK1VFVytNY2xrUnU4?=
 =?utf-8?B?R1BKaTYyQjhvci9QZys0d0hjZlp2T1RpSDN6Y20rLzBubDNpUGdOTVpwN3Zu?=
 =?utf-8?B?WGdKTXdxWERUUll4c0d1WG5CUWNoS3lBR2N6UzZvT0hXTDFleEhyYzF0MjFQ?=
 =?utf-8?B?MEZNb01oc0hpWTBQeW9GRHZTK1YzWVdCZzZielhscExwSzk5UnRZVGcyYlBG?=
 =?utf-8?B?aWRaUjRWd0p5ZlpXZklTMFd4Zk5qUE1PMlVzcnZ3Z2VCcWNsS3NoQ0wvK0tK?=
 =?utf-8?B?dWJIWGZ0VmRzeFZYVGxoK1lsc0h4eGdhR1J0cXQ0all0N0llcGRSQjhzNnN1?=
 =?utf-8?B?SEMzU08xckF6VDU4Q2ZQYkV0TUgrbzd0aEtyZkErOFUxTnpKdWlDbGtWdG9V?=
 =?utf-8?B?Z0laTWRDMFdwNURZVXlhZkp6cWdFdEdjWnIxWks5QjZUWGttcHpmVDNXQllE?=
 =?utf-8?B?V1Z0UlVKaUs1bG1LS09Zd2ZxNkxDZ1ozT01YNnJ3TnR6L09yZVFHNFlUOTVP?=
 =?utf-8?B?R1N4ZjNTKzFKYUtYMVhCbG9tNDkxK2dNVkZmaVVHNlhvZ283NWJ4MEMxcUY0?=
 =?utf-8?B?MUZtdXNtZjBCUVBYZVZLMEhJZXBYYkRQRUVSSnNJZ3JIV0t1aVlnTExES3hZ?=
 =?utf-8?B?d1dKYUJuMmw4OTE2eDJxVk1Oa3ZEVlRPblVrK3ZUbnZ3bXdvaWRFMmVDSE9H?=
 =?utf-8?Q?hylLeNupS3zTgvnyBVUe2ypsq5Bj8eMXvZE0v+zMEvJfw?=
X-MS-Exchange-AntiSpam-MessageData-1: JTg///rAWbs1Vw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZPC5xKsZRTmcAsc1dmKweMhXjP+Xr3Ia23cCXlsRpk0rQWhYZN5HY3N6X1iFd4UUeCViy19oiz8/JCHuIi1wxAtc+TwQUaRRqYI0o8b4hTwrD22Nh2G2XdyWobtXgh9Qb2tHTAjSXkOx0NNy8js8h5WQeO3mPnQybj3/w1UyzDr2GbBeQn2xNgcvq+IXc+Ggm/lN8k2RHWBw3QHpV8WBuDgKA51aDKHFbkMETnIUQ0y8+CL1jToO9ru8tioHNuuWMcpt52st5H0b8ZDeh13eO7U95Xsa4XKITPBRjWVrUXsSVHlGnps6lBVBIOQOzi4JPDzXTy9Jy1q1vpMW4tHtJcpSPVbZ4K7uiZ0mMtGP50GT1+aJtMyyAKfEnDPSriqpBhcX704NXElg2R3ah1NzD1m0ng/lxMIe/s/h6i6q7zZoqKoLER2NF6TtSJleJix9Y10Q582RFfcWbMLW8eXr+5mhsS3N4aWMgSWRo4wdVFjwwvGwRLbV1FFZWK+4ia8mMvOmuKzYI82X5KOoQ/vzZRNwKrdLSmVt5kd3Kk9zYIbYfFt1kR+S99IBN9kiFDyHbk/pEOPlKaYvLdCcKISwGpQCRJPGEzjftJ87pXaa0HbKqLElDZlz1nCF82L6qzpw4dBtHuzjm7V+xDZDW9P96w==
X-MS-Exchange-CrossTenant-Network-Message-Id: aac6c504-bc59-4c2a-a26a-08de50f5ead8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 09:43:47.8761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8E+yj/9D3Ew8nRjhgRCAvrwU3UMioPjcpmuNMwKG7nyaAwTXBTMoW5cvr1d1BvTnyoNOrQ65ha1Un2LYkhI/VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA3PR19MB9497
X-OriginatorOrg: ddn.com
X-BESS-ID: 1768126670-111056-12967-16113-1
X-BESS-VER: 2019.1_20251217.1707
X-BESS-Apparent-Source-IP: 40.107.208.80
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYmRgZAVgZQ0CwxLdXcMiU50S
	LRxNzAwMQ81SAt2cIs2dTCyMzALNFEqTYWABpGjDpBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.270318 [from 
	cloudscan10-193.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1



On 1/11/26 09:18, Markus Elfring wrote:
> [You don't often get email from markus.elfring@web.de. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> …
>> +++ b/fs/fuse/file.c
>> @@ -667,6 +667,18 @@ static void fuse_aio_complete(struct fuse_io_priv *io, int err, ssize_t pos)
>>                       struct inode *inode = file_inode(io->iocb->ki_filp);
>>                       struct fuse_conn *fc = get_fuse_conn(inode);
>>                       struct fuse_inode *fi = get_fuse_inode(inode);
>> +                     struct address_space *mapping = io->iocb->ki_filp->f_mapping;
>> +
>> +                     /*
>> +                      * As in generic_file_direct_write(), invalidate after the
>> +                      * write, to invalidate read-ahead cache that may have competed
>> +                      * with the write.
>> +                      */
>> +                     if (io->write && res && mapping->nrpages) {
>> +                             invalidate_inode_pages2_range(mapping,
>> +                                             io->offset >> PAGE_SHIFT,
>> +                                             (io->offset + res - 1) >> PAGE_SHIFT);
>> +                     }
>>
>>                       spin_lock(&fi->lock);
> …
>> @@ -1160,10 +1174,26 @@ static ssize_t fuse_send_write(struct fuse_io_args *ia, loff_t pos,
> …
> -       return err ?: ia->write.out.size;
>> +     /*
>> +      * Without FOPEN_DIRECT_IO, generic_file_direct_write() does the
>> +      * invalidation for us.
>> +      */
>> +     if (!err && written && mapping->nrpages &&
>> +         (ff->open_flags & FOPEN_DIRECT_IO)) {
>> +             /*
>> +              * As in generic_file_direct_write(), invalidate after the
>> +              * write, to invalidate read-ahead cache that may have competed
>> +              * with the write.
>> +              */
>> +             invalidate_inode_pages2_range(mapping, pos >> PAGE_SHIFT,
>> +                                     (pos + written - 1) >> PAGE_SHIFT);
>> +     }
>> +
>> +     return err ?: written;
> …
> 
> You may omit curly brackets at selected source code places.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v6.19-rc4#n197

We could, but we could also concentrate on code correctness instead of
nit-picky debatable code style.

Thanks,
Bernd


