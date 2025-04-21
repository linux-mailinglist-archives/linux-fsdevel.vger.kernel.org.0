Return-Path: <linux-fsdevel+bounces-46789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F548A94F5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 12:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC343B02FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 10:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C64261393;
	Mon, 21 Apr 2025 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="BjJdV+Fc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24EF26139A
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Apr 2025 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745231015; cv=fail; b=ADG6l9hglKWsuvvpyJf5p/HHrGLoLbsQbqOsPZKHKTeiDre/ato9m3lDfaBmy48EArHTvMxpXCQTJ/AxUj+9mJRkLVE5T4ovCcdQzp5sAugtqWSEDD2X0XrehH+MLle3sfyl1gm6xDD5+Xdu/vX+N6Aq6h76157PTLAu4ZfIgiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745231015; c=relaxed/simple;
	bh=7d/dtpmMG1GmIaCv6/zsh++eijec9LvC6Yqeprs5d8c=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cf3p3nKzvWCg8cUEhYBIOr3WdciZEbnA/5Iait4MCm7yUR7tRapuyzx09iyiuYCWO60KJyTrC3Ezcg3O2a1xVC73zaZJhIUUCKyfHZg8RAnUa5EEaIDcwJV+bn3+PmmdqZqZU4+e8L1xBTwlYCy5RFlPjniGyTX137OplPQYsOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=BjJdV+Fc; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44]) by mx-outbound43-3.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 21 Apr 2025 10:23:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFHh1YU6q1WbMxvs/v0ZmkHRvTGURYAL7xu5kW/B6ZKQUQ7mpadU38xp1FsX0a4Ug9uhpCC5nt4dsUOiAHZVC2myYHpnWjDHjKv2w1Y78VNwPK+kTrFGo4wmN0RKz8VKljZN1NH5R/IYkhSMzi1IkYOp1GZdQyIzDazex2Xy+cAjZs+RtCyczs41SDCnn960P17QEgm8yG9TzoCiDfve3PAcfiN1F9v1WlkIcXslwbEdOvnQd7GYybD2OrvlELmDq2GHJX24HojiVq+5yCyWz/pEAEhAbKMF3FinPHCnQ5lw/5sr2mSrj56ApiugM2itQwMrAtchuxJ9VfQ8EmjYKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8FKi8pwTUKcy3P4oTUgom7U6heF9WhLCoWF/d6nZPA=;
 b=KchyY8CDKYto6n18p/183azTVS41vpoiZW/VH0heJ7HrQcskRsb9nP1w19q1S15A4llPibESrM9uf5DEhhz2IrXeH7n7hDiUVnfVlVxlBKYIeY2CMCkN9B9ZuiPC2SG2IJoju3AzdrN2Mb3B+weFW8pwoz0QMmiMF253HUzRuCXOmXcxcTIg56DF1O5ueUB8bdAUvLcQ/vPmVPRt+w5c55VR/ieDlsQQxJfG+jVcOYq9oFnIQgZo/T3/R8biMqFglxOnFiD05DVwe24U6jkYfdXV959mthcfvxV6NGn221M+l6bUqNFymQMai8s01FA1DTag0jYek7zn7cphimojkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8FKi8pwTUKcy3P4oTUgom7U6heF9WhLCoWF/d6nZPA=;
 b=BjJdV+FcffeT87EmI6UotDccPWydeUGNRuDUmpRlVTmEhMX0tqsVCVsLFKFdNcIwZWylIKOKW/g/ELlhjhPzqpsJdMuYMlbPyYEt45hdI3Se10f41C6D53o/acyzUKVIN0RqmZL97wnsJlj441qn/EMPORS4cyDxwEFhCxaaI50=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from BN6PR19MB3187.namprd19.prod.outlook.com (2603:10b6:405:7d::33)
 by MN6PR19MB7939.namprd19.prod.outlook.com (2603:10b6:208:47b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Mon, 21 Apr
 2025 10:23:20 +0000
Received: from BN6PR19MB3187.namprd19.prod.outlook.com
 ([fe80::c650:f908:78e0:fb00]) by BN6PR19MB3187.namprd19.prod.outlook.com
 ([fe80::c650:f908:78e0:fb00%5]) with mapi id 15.20.8632.036; Mon, 21 Apr 2025
 10:23:19 +0000
Message-ID: <62a4a1dd-124a-4576-9138-cdf1d4cbb638@ddn.com>
Date: Mon, 21 Apr 2025 18:23:13 +0800
User-Agent: Mozilla Thunderbird
Subject: [PATCH V2] fs/fuse: fix race between concurrent setattr from multiple
 nodes
From: Guang Yuan Wu <gwu@ddn.com>
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Cc: Bernd Schubert <bschubert@ddn.com>,
 "mszeredi@redhat.com" <mszeredi@redhat.com>,
 Miklos Szeredi <miklos@szeredi.hu>
References: <BN6PR19MB3187A23CBCF47675F539ADB6BEB42@BN6PR19MB3187.namprd19.prod.outlook.com>
 <91d848c6-ea64-4698-86bd-51935b68f31b@ddn.com>
 <BN6PR19MB31876925E7BC6D34E7AAD338BEB72@BN6PR19MB3187.namprd19.prod.outlook.com>
 <8b6ab13d-701e-4690-a8b6-8f671f7ea57a@ddn.com>
 <BN6PR19MB31873E7436880C281AACBB6DBEB22@BN6PR19MB3187.namprd19.prod.outlook.com>
 <CAJfpeguiPW-1BSryqbkisH7k1sxp-REszYubPFaA2eFc-7kT8g@mail.gmail.com>
 <0e1a8384-4be4-4875-a4ed-748758e6370e@ddn.com>
Content-Language: en-US
In-Reply-To: <0e1a8384-4be4-4875-a4ed-748758e6370e@ddn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0963.namprd03.prod.outlook.com
 (2603:10b6:408:109::8) To BN6PR19MB3187.namprd19.prod.outlook.com
 (2603:10b6:405:7d::33)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PR19MB3187:EE_|MN6PR19MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: 0598ed9f-95de-4d28-c209-08dd80be8999
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEozYzJTWUR0RldXdXYvVm1LejVNOWdXMGlraW5CN01XTCtPYkI2ZTliSmpx?=
 =?utf-8?B?ZlRaVG8yNGdvZGNNQm1yZCtlRGJaZCtxc3EzMDZtbnpydi9ieEFsY1JSNmZx?=
 =?utf-8?B?Ry9YbFVFZlhrNEE5aGlCZlFscEYveHBKZVRNZHhodjlPR2kvNnVvc05YUmhZ?=
 =?utf-8?B?ak11WGg0T0xxeG52Nks0ZC9qd2JBekZQcG0ybDdVNGhXY3BZa0JpU2JtZnQr?=
 =?utf-8?B?OSsxVnZXYkZ0ZG9QMGF1cHBtYmtaSXpnbVJjWlk2aWdPYkxGRGJ5Rm90b1p2?=
 =?utf-8?B?YUhnazdaWkorTEMyR2dJUjcycFFwOVFNZ0JsOE1uTkNBNEVrSmdBNHk3YUJY?=
 =?utf-8?B?My82NDB4U0RGQ0xJcml6WUc3SUdpVUExcWRudkdTS2pIS3FobWlWSllCVXda?=
 =?utf-8?B?M3FUU1lvSm9KaTJuSytUVG9yNWs0OHV1M0hpUjgvZ09FRUFlSS9UZExxM2xZ?=
 =?utf-8?B?SE5ETzczVzRYR2l5eVhyZUp1cG1TOFRHb2FER3BoREkvZlQrbmpFa1VoZXJ5?=
 =?utf-8?B?azMrb1B0SU0rOTlHR1lrU1JRdXNtcDE2eG85UWhUaUF4OUhRRUlnSms2Smlj?=
 =?utf-8?B?WVh1YU5FWmVUY3BUSVdZU0tCWmJQU1NZRmF1VGIvVG8wTkdIMVh0UVZCejRr?=
 =?utf-8?B?SUZIU0pXK2tnRTBuaUc5RjZzaUtWMUl3MWowd3dkU1I3cjZoOUw4YXFXYS8v?=
 =?utf-8?B?QVc2ZnNrMGRXRUltdGpQRlNCZG5DWXR1N3NubFdpRGVPZW10NUlKTjZld0xE?=
 =?utf-8?B?VWJPS1NHUkR4WWhTK2t4ellVeEFkVW4yRXE2b29MMWZXeE93S3ZxWlBzS1Fr?=
 =?utf-8?B?RHBFZkdZZFVxcTF3enhHZXlETXQvYjZmMU9LZE9pM3BXVEJjVVdoeldMSFZx?=
 =?utf-8?B?ZjZyWWlQT0RLWDhXZkh0WThieVI0a0I0dEV1Z0tYYUh1YnI3dVpiSzhBYTNY?=
 =?utf-8?B?OFhWSGRmTDdSZHBTT1NDWHVMUGRsaHVIT01qc1RwNkVKTDBwRi85S3JmZXBX?=
 =?utf-8?B?T2dRSVYwYUdjNWtmQjFuZk5UTThFdk5Tdms3ZExDdjh1WEdkaEw1eHZ5Q0FS?=
 =?utf-8?B?YlBqdU9weXpoYU1rdUlFQTdjNGRNZ0lwSlhWWFpMV2JtTDh3aUY0L3B4ci9j?=
 =?utf-8?B?VFp2OE5LaDM3YzQrWUx4c1lOMk5aTWpndFFuT2hKbkh0OWoyN3o0L0tQaGVo?=
 =?utf-8?B?OUxYdFZWRDdMUjFOMzBFaVk2SEhTNkt2Y0Erdk5JNUxFRHNRL2N1Si9sTXNV?=
 =?utf-8?B?LzNQS25pM2FpazF0OWJpcVlQaU1CbG1OZ3MxMHIwNS9DSy9MdTJ2TWxyK3pW?=
 =?utf-8?B?ZElWV2lRc3djRW5tN0Z5TThJZ1lrZkZmRjFMNEoxTnRnVGdhRmVOSGNuMlBq?=
 =?utf-8?B?SXhTS2MyV3VodXoyQjkzNlo5ekF5VE42N1YzS2x2ZkRrakczUkR6V3hYOUFC?=
 =?utf-8?B?YnJXejFiTnhtQTFjSzZabG1ROXFQV1l4TmU3aStEVVBoT2pKeHVQRFdpOEZF?=
 =?utf-8?B?RjNrUDN6WWNLRnB1a2J2WTZhTmJuaVNHWTdGSitTVnppZFBDNDY4RjFMZWt4?=
 =?utf-8?B?WDE5YVFTOXZvRkNzOEFzTUp1VTVBR3VPZ0JGOEtuV2huMXM1cWlOOVU1MUZM?=
 =?utf-8?B?WjZyMlQrYWJsbFBMS2p2eFVxLytwUW1pZE9tRXprbUpMYjRCa1ZrL3NwbHlk?=
 =?utf-8?B?UC9relhXZVJZYnh6OFAyaDNsZHFacEcrWVBDeGYraUdUdnE2UFhvaDRLY1RF?=
 =?utf-8?B?d1A3bXdQRzN0cWQ3Y3hEL3g3cVVQZS9LclMwS0tUK1hWbW5QMXNIVWEwRWp2?=
 =?utf-8?B?U1A0YmprRzNJVEhlUGxBTzVta2VYb0c5VXh6TDFyb0FqQ0ppY1lmeXNUQkRz?=
 =?utf-8?B?c2FHemR3R2pOWFR4TEV0NHNuNkoxOWw5RG9sY2Q0SnQ2NWlSb3U0UlFPWTVo?=
 =?utf-8?Q?kPyzF38rpVs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR19MB3187.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWhWUENuYTdvWFRGYW5UMVVURC9zWnBreFJFQTVIcWNvcHNTT2g4TjA3b2JO?=
 =?utf-8?B?TzdxbWhSRXZ3TDV1aXlvT21TNjhDQ1F5ZUFsbHhiMDdnTlNyM0RIMTkzVVhs?=
 =?utf-8?B?ckxPaHRVMndyR2tXM0FQNC80WnhQZE1peVV0SDJCb2dYUm4vSmpGSkY4dVJV?=
 =?utf-8?B?a2dPc2VybnZ4SFpmOEhIZVZ6ZDJhMnlhT1dtb1ZNRXRTNUkwTkRaK2ttc0pi?=
 =?utf-8?B?b0FzTWZ6bmF4eEY3V0g5T3AyS2p6aUNiN1Erc0U0UmI3aDEzZ04weUdhb1p5?=
 =?utf-8?B?aU55T1FaaUZsbm1SblRwWk5td2YrbnhsTlhQenJuYno3aithRTZrZnA5MlVo?=
 =?utf-8?B?a0lkc1g5MzExU2JpeUdyYkJTeXZuYU8vTUVYZGpCNXljWUNmNFk2NTRNb3or?=
 =?utf-8?B?UVFVMkVGeEtxNTRDd3dhM1Q3dUwxQjlNNWRVMUc2WXROV1NlcFdmSHZXZzhz?=
 =?utf-8?B?MWZJaGlGVVlxc1NwWnNmTms0bTZPdUE1UUF5WU9KTk5TQmZPNVBhNDVpS3F4?=
 =?utf-8?B?WDBDRTgyMEpmNWVUbU5KMThFUGJobk5YOFZlTFJYVHRwQnNrdkJNRVR5Mmhy?=
 =?utf-8?B?RGZGRlF4YWxOK0xMSnR5OUxYazB3ZUl4Q25WZGluN3FiSlJBV0VZTXp4MEI3?=
 =?utf-8?B?VTVkdXZRWXE5azVPRDN4MHRsakpqUVNVT3FjdzcvL2lxQzJuTTcxQ2oxbVJq?=
 =?utf-8?B?cXdHcGpMUnpBT1FRVWJrUndnWUtOa0FPODBveWVmZTVaZzd1cDZvQ01UQjlP?=
 =?utf-8?B?ZzZLVml5dlpkS2JCRXZLdWhxT2NudC9wUGhndlB2bm9vTFBCaUZUZTkyNndQ?=
 =?utf-8?B?VGF0NUM1U1g0dyszd0hmcEw5VVgvUkNoa1FMYnFTVVhPK3NDMktnelBOY21v?=
 =?utf-8?B?c0dKbGI0bGlJNXlocG9vdm0wYkJZL015elppVDc4STQzQWQzOUYrMTU2bzVt?=
 =?utf-8?B?QTNMeWNUSGhlL1hwcWg1cVRROEd1WGluOTlWS0NKY2h5ZVlvQUo5a24rS0Qw?=
 =?utf-8?B?QXFMTXZuM1ZibHBSMnJ3U3ZOd2dUeUUwbUUyc3hKUTBBK3o1NzZ3Y3VLYUQr?=
 =?utf-8?B?WHdlcmp4SWZDOEgzVTViK1hHSWw1eDNLTU1pMEFZZ3VTSTNWaUVvQ1FUVGhK?=
 =?utf-8?B?UHhrUWdXdXZSWUhheU5Qenkva3Fob095aVZaUjVZYXBSdVJmOXB2LzVNSmg1?=
 =?utf-8?B?NmpvNEQvQ1l0S0Z3dHNvWWZ5Q2tZSXpRZUtUMzhFeThxRDZUZXo4cCthTXph?=
 =?utf-8?B?eklTNlBOT1hnL09SSGUxY3YxdVovYjRsVTlBcmMvMFJhdC9MSXFySXpURU9x?=
 =?utf-8?B?ZlNONUQyYkRYd2xxUFFhc3pBcktmeXJHVTVUVXZCU2swS3ZEWlhDMStGMWM4?=
 =?utf-8?B?bDVJUHN6Q2xqTTB1cFgxQWxnbEhnMUNIS2pLZ2k5T3dpZm1uUnJXdUZ3bG1o?=
 =?utf-8?B?RVpzNWlQZVM0UHg3R2loTllSVGdBSVVRZ0JrbFJuNEpzTXRNOW5iWDRtNXkr?=
 =?utf-8?B?a1V1UGV0akJsK2xheW5PelM4ZmVTdTdjOFdKUkxSNWlBUXlPT3pHbzlZSnA4?=
 =?utf-8?B?UGFzTWdONXdVUVN5cUx1UDE1Mk9TSExaNzhqQUFGUDlIbk9vOWlpWmU5aDBs?=
 =?utf-8?B?VW9IWVFzU2Vod1NTdkZhZzAzUVlISjk1d3FJVlJ3bFpEYVVra0RyQmFCNFBt?=
 =?utf-8?B?djdMZTVHMDg2TVZDWEUyVFJETUNXMWRGaC8zYVI4TjBGRzZuczJReUM3Rmdt?=
 =?utf-8?B?cjd3VHpaMWszSzNoZFhselQzOVhaTjNwT0dHV1VENHphYStyKzBHeWoreklq?=
 =?utf-8?B?VGhUZFphbGFzRG5rZmRTT2gzekFud3IzcGZ5bkNHQ3llMTBnWklQcjUyeHJt?=
 =?utf-8?B?aUxzVGtBdkhHL01CbHB6c2o2aHVxL09zZnNBSWVpVzVnMVZkc2trQkF0eHJr?=
 =?utf-8?B?ZUpreWQzc29za2dETHc0bTJ0SUIwMjhKZnVNcEJXZG0xRVV3U25UNGV6Qi9h?=
 =?utf-8?B?dHJkUit4UXovMUtLUTBKaFptTUZrYU85Y0hwTGVuQUFOMWlYZDA3ZFVvQ2oy?=
 =?utf-8?B?QTBkTDFoWkRVODAwQUJzb2VuQlJSWTJFRWNwZjByUjJWdVRDSUJPYnpTb3NW?=
 =?utf-8?Q?/OkA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Mb4EMwaLn5SJzG5g3qWzLWju75tP7IAJTRMHr7I6X9uBEjNY6t30CfQXwcfQy3+QAVC74Y1XBnznfQAfDI5SGuVV48V85eYzv22sIUMV9N6N3+6Cj8O8cCTvZrW0yrdAljNGQmilkQLJJ8DKCTV+7m1cO4HkBFizXfLfnVichal2iCiGM6sgMB6/sLRBRvhZDhHGIl+eX8V0AiD1rQ4i62prYltp+XqVsVGK80jVn/jw/KYDUtVR5Rz6mQ1ZI2RTQ+7OWxnH6vtMg9mtnUSRYbiKjCLnjcekuEjCyCLU17Wo1jxhBQ+VqdDVf2Hgj+QWsuJTRUap46B2cu5A4h6/pQhWDktTMKoo6VxkOdSOHGzfuVwYI4Md3dJsW5O5eIugpLkPKgYnrvUhX4Nn2tgp60xnUfKMsb+0dc3qiqn0k4bJaSK3QQmWhXlSMqIWbIlEhjbN+SCd+BD8yHZplfTNqgJKcKz7vcU+gKiObkbZdSx5fX5ZnsWp6CqXOM0lfGxzuUtUKiWt0cYFSSv5MTUpVStKsBes2ZDDQF35iMAlLsf8ln+PIJ6I/U09jlLiu9vnfTTr6gk2BHh7yaITthjN9ZGelzBDpYIXXu+vGZe4L9ouvgpPU6uymzW6SULplwR29MQtb2w1NufWmIzeFoQnwg==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0598ed9f-95de-4d28-c209-08dd80be8999
X-MS-Exchange-CrossTenant-AuthSource: BN6PR19MB3187.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 10:23:19.8828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RCK08FewJirEqUorT9YrmlNJ/iKbSVNNTzEjUyMmzxPBF2iXopr00mXp7Rs7xMWT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR19MB7939
X-BESS-ID: 1745231003-111011-11240-58929-1
X-BESS-VER: 2019.1_20250416.0026
X-BESS-Apparent-Source-IP: 104.47.58.44
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViaWpmZAVgZQMDk1NcnQMi0lNc
	3YwtLSxCQlKTHNyNA0xTTZ0NIsKcVAqTYWAH5k8DRBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.264046 [from 
	cloudscan16-31.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Hi all,

On 4/16/2025 6:18 PM, Guang Yuan Wu wrote:
> 
> 
> On 4/15/2025 9:13 PM, Miklos Szeredi wrote:
>> [You don't often get email from miklos@szeredi.hu. Learn why this is 
>> important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> On Tue, 15 Apr 2025 at 04:28, Guang Yuan Wu <gwu@ddn.com> wrote:
>>
>>> I though about this ...
>>> Actually, FUSE_I_SIZE_UNSTABLE can be set concurrently, by truncate 
>>> and other flow, and if the bit is ONLY set from truncate case, we can 
>>> trust attributes, but other flow may set it as well.
>>
>> FUSE_I_SIZE_UNSTABLE is set with the inode lock held exclusive.  If
>> this wasn't the case, the FUSE_I_SIZE_UNSTABLE state could become
>> corrupted (i.e it doesn't nest).
> 
> Thanks.
> 
> for truncate, inode lock is acquired in do_truncate(). (not in i_op - 
>  >setattr())
> 
> others (for example, fallocate), inode lock is acquired in f_op- 
>  >fallocate()
> 
> So, I think FUSE_I_SIZE_UNSTABLE check can be removed from:
> 
>      if ((attr_version != 0 && fi->attr_version > attr_version) ||
>          test_bit(REDFS_I_SIZE_UNSTABLE, &fi->state))
>          /* Applying attributes, for example for fsnotify_change() */
>          invalidate_attr = true;
> 
>>
>> Thanks,
>> Miklos
> 
> Regards
> Guang Yuan Wu
> 

After address Bernd's and Miklos's comment (Removal of 
FUSE_I_SIZE_UNSTABLE check and add some comment), update the patch as below:

V2:

     fuse: fix race between concurrent setattrs from multiple nodes

     When mounting a user-space filesystem on multiple clients, after
     concurrent ->setattr() calls from different node, stale inode 
attributes
     may be cached in some node.

     This is caused by fuse_setattr() racing with 
fuse_reverse_inval_inode().

     When filesystem server receives setattr request, the client node with
     valid iattr cached will be required to update the fuse_inode's 
attr_version
     and invalidate the cache by fuse_reverse_inval_inode(), and at the next
     call to ->getattr() they will be fetched from user-space.

     The race scenario is:
       1. client-1 sends setattr (iattr-1) request to server
       2. client-1 receives the reply from server
       3. before client-1 updates iattr-1 to the cached attributes by
          fuse_change_attributes_common(), server receives another setattr
          (iattr-2) request from client-2
       4. server requests client-1 to update the inode attr_version and
          invalidate the cached iattr, and iattr-1 becomes staled
       5. client-2 receives the reply from server, and caches iattr-2
       6. continue with step 2, client-1 invokes 
fuse_change_attributes_common(),
          and caches iattr-1

     The issue has been observed from concurrent of chmod, chown, or 
truncate,
     which all invoke ->setattr() call.

     The solution is to use fuse_inode's attr_version to check whether the
     attributes have been modified during the setattr request's 
lifetime. If so,
     mark the attributes as stale after fuse_change_attributes_common().

     Signed-off-by: Guang Yuan Wu <gwu@ddn.com>
     Reviewed-by: Bernd Schubert <bschubert@ddn.com>
     Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>

---
  fs/fuse/dir.c | 12 ++++++++++++
  1 file changed, 12 insertions(+)


diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 83ac192e7fdd..0cc5a07a42e6 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1946,6 +1946,8 @@ int fuse_do_setattr(struct mnt_idmap *idmap, 
struct dentry *dentry,
         int err;
         bool trust_local_cmtime = is_wb;
         bool fault_blocked = false;
+       bool invalidate_attr = false;
+       u64 attr_version;

         if (!fc->default_permissions)
                 attr->ia_valid |= ATTR_FORCE;
@@ -2030,6 +2032,8 @@ int fuse_do_setattr(struct mnt_idmap *idmap, 
struct dentry *dentry,
                 if (fc->handle_killpriv_v2 && !capable(CAP_FSETID))
                         inarg.valid |= FATTR_KILL_SUIDGID;
         }
+
+       attr_version = fuse_get_attr_version(fm->fc);
         fuse_setattr_fill(fc, &args, inode, &inarg, &outarg);
         err = fuse_simple_request(fm, &args);
         if (err) {
@@ -2055,9 +2059,17 @@ int fuse_do_setattr(struct mnt_idmap *idmap, 
struct dentry *dentry,
                 /* FIXME: clear I_DIRTY_SYNC? */
         }

+       if (attr_version != 0 && fi->attr_version > attr_version)
+               /* Applying attributes, for example for fsnotify_change() */
+               invalidate_attr = true;
+
         fuse_change_attributes_common(inode, &outarg.attr, NULL,
                                       ATTR_TIMEOUT(&outarg),
                                       fuse_get_cache_mask(inode), 0);
+
+       if (invalidate_attr)
+               fuse_invalidate_attr(inode);
+
         oldsize = inode->i_size;
         /* see the comment in fuse_change_attributes() */
         if (!is_wb || is_truncate)
(END)

Regards
Guang Yuan Wu


