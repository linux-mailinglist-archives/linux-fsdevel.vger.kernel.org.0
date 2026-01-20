Return-Path: <linux-fsdevel+bounces-74675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AWAN/wzcGkSXAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 03:03:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D3A4F769
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 03:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65E3F7CCE13
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 15:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D16043CEF7;
	Tue, 20 Jan 2026 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="BiFTHzY6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022096.outbound.protection.outlook.com [52.101.96.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCF442B74F;
	Tue, 20 Jan 2026 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768920606; cv=fail; b=Y6N6EjTWaGKUaa6fcxVjp5pdPU4t54tSfewJEQwyQZj7FTpUdU7uNvApDfrpolrLWvYHP3Cu+lY7W1rnpSPZ6okhKT3o7j3qT2MIIBIa46t5tZY8dspQ0XrFJrjLRP8Z8AKXfCnq9iovzBVKIcJ1eIDe18t6dQMqZaAabR2j9Lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768920606; c=relaxed/simple;
	bh=zkcQdcWqwD/cgYuBCcmrLyOeVMbnKWqNdGKSie7ki+c=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=pVEoNO81Bm56W74YYzoM/UJLMiH6MZpWyxFzt3Qn/zVTJEDPIHAj5i9dmbdpuatIANgW2zlIyDUZx5tn6ybTaznfO26qBCDlWLIPYVO6bZKopSHgoZsqAW2bQql2hGdZBYf1qrEAW1NeHTLTGic5vy2yP0CTFnfn8qYYCouCCXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=BiFTHzY6; arc=fail smtp.client-ip=52.101.96.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IL/+NDggKKn2pek56aMEPHHaQIcbwJfeYmbpEL7qr7GMbpgHglmk/GSnsiQT6pb4gq2zbf5EsoS1Yd5BHHKgpwlu8k0cf1KJIr4gCq/g01SjCmD0RF2ckxDMDkHRiPWnDJQVMnvp15sDH6/OKViqvdwYksbW0CyBAO+4ycZyDGhE2/yaXIsKDGK8mR8fh1fGYmOluRCSdCRHQ90Y524uAHgb1OEViNrPmEr5iVxrJ62cvXER0T5yJRUMlBO8nHiaPlTVZxEfpIMKcr48SEW4a+4mVD1hlGdXuyRt8abYaBRAgJHUFTSdOCCAjiHIJCt8ESQNzMUtcmcJwxXVS9WcBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYM7KkJN0RbOD95xh397Y3rxXGTy/vYXTLfI0bXkqNg=;
 b=JpDaGFZS6IRzR9ZwDeqyDNCk7OnIt8onR4m6HzPLnciIKt4nma95KXIvFUFpI9Hf7+ypfDOg66/gHQoSxXkw94xBU4g+7nljlatjcFoYdb0Y0uXK99CtVC7Rl3zCZBqudvUQGeoLPZR5IOyJbN0Ftu2UjSjq4pjQ3maKHfHDd93TR3P6YRVCVfM4Y+XLGTZkQHQ/h1ILiKdN5v+TYPVBlEjy0pxetmDYSWqtS2+EYz3h92QCYs+FJmrOV4Xz18ekXVz8RHHlP88v+08GH6qpVTqbTh2/5hi2VUYi+J6ErQza28O6Cwmbq4qh6eUpHcJ6nxF/1fMfhn9Dw9FdRu9yOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYM7KkJN0RbOD95xh397Y3rxXGTy/vYXTLfI0bXkqNg=;
 b=BiFTHzY68zoN4m1v6bTEINNMSwhoi689PqLaT+6Gccen5D9nQS8cjU17obJBCk5NYzYUMl7LXoZtP8qYI/xR7E1eAdHhFSiznIPoXUMsqhoZ9pUeSCvyXEEHIE5Ymz7kUdi7mW8CJg0+RxAd0/aKxPmciserxD3kVBgbMl6kmyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO6P265MB6016.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2a5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.13; Tue, 20 Jan
 2026 14:50:00 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9520.012; Tue, 20 Jan 2026
 14:50:00 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jan 2026 14:49:59 +0000
Message-Id: <DFTI0P4F3UR9.14CA9H3I19GCB@garyguo.net>
Subject: Re: [PATCH] rust: replace `kernel::c_str!` with C-Strings in
 seq_file and device
From: "Gary Guo" <gary@garyguo.net>
To: "Ryan Foster" <foster.ryan.r@gmail.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <ojeda@kernel.org>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <dakr@kernel.org>, <linux-fsdevel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260120140235.126919-1-foster.ryan.r@gmail.com>
In-Reply-To: <20260120140235.126919-1-foster.ryan.r@gmail.com>
X-ClientProxiedBy: LO4P265CA0317.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::18) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO6P265MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: fdba5be4-f272-477f-4f81-08de58332ffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmErNzRYcnVIa3Y2Rk05R0pIMUNFaWFsVEVma3pXaXFTWCtCZnNiL2dzUGZY?=
 =?utf-8?B?bkJiSzZ2eHBXcVY4RUUrOEpGK3JoeWtZTmRaUzJIK3dNL1IwdkQrSEpQSUox?=
 =?utf-8?B?Skhpa1hsRFRzTGhtMUtleVMvZjNZbUl0cnlBeUkxYWd0c2kzZlBncEZKZFNV?=
 =?utf-8?B?VUdCRzdqYWxjQmhIenJ2aDJCT2RKVW1ieEIxUFJXV2ZuVnB4MWJpb3RNcmEv?=
 =?utf-8?B?d1Zpc1NhaW1pQkxSSnRQTU50NjdQeEFDNlhSNlllZ0o0bmhVVjRyVDFVTzVa?=
 =?utf-8?B?NFcyR1ViL3ZzVmRJSTFzcTZCVlpvemx3MWRaWGV3U2IrZTk5SlMyNk1HMkw3?=
 =?utf-8?B?VnlPNjFNMk0waU9oRmVZQk1mUmJLaDkzdHN4bmlGV2lCUW85cE91K2RZRkUw?=
 =?utf-8?B?U05XZGI2TTQ0bU4yTkJLWmM0eXlING5oWmplMlB5a092MW9pazgzRDN0RTlN?=
 =?utf-8?B?SXRTRHJuWU8zN2dQclgzQTVwUVJIcFNPaDhBYjFaaUw1Yys4MXBXeUpVNTR2?=
 =?utf-8?B?bENleWMyZFoyQ1E0MFRFV0dyME9lbnBGblRIdzBmL1ErbkQrdWZHdGVmK0Fv?=
 =?utf-8?B?YWZUY3o5K2hISXEwMkM0SmE4VXptTnFzbDRWSTVPNitwNzFaMk1vTWpUQkZB?=
 =?utf-8?B?NDV2ZHE3R09BQ1REZEd3VzRtcWtjUXBGYmxLSmtvNVhKWm9zQkw5ais1eERX?=
 =?utf-8?B?eTJzOFA3VVFkN0U1dlduUENPQkN0a3NJWnBCVTNUTHVYU3NlNWFQd1o2Q2lC?=
 =?utf-8?B?VGticmtmSmFVbjVJMGNDajhudkNLUnBFeHpqbHE3MHBDN014eTk1ZU9SU1Jl?=
 =?utf-8?B?em00cmVETDZKSDdHRjJ1bzBkMzFTKzFaOG44MitzQnVHL2w1Z2FQMTFGRUZB?=
 =?utf-8?B?TFMwUlpiRDh1U1dXNThKWGs4dW5ZMnI5VVEzZDlnVWhVdk1kMTBHOGcwazJU?=
 =?utf-8?B?RFgyNVdOSDVHRGhuQnB1eVNVc0hSRXBaNzgwR3FGR0NPWDljdTl2R0FXOE5D?=
 =?utf-8?B?TnR4WE1xQ3ZqdGJlTWU0cGI5SUtKSmZWd1IwYXVmSTh3dG91NDVNdnBGOFJa?=
 =?utf-8?B?SjNScVZUTm9kOXZ4OTdodXlnZ1ZSRzFGMHFlaHJlM1hMakw0dTZ0NzV4aVU3?=
 =?utf-8?B?SlNqcitTeEt3bHhZODRpNjNydnZ6WDl6ZEFWMGZyRjV6SW5HOVNxSkU1MzdB?=
 =?utf-8?B?SU52UmxrandqdzEyR09aVm9hRGZaSWd3TDkyRjJ5UWQ0YjNWdHdPUC84VTlL?=
 =?utf-8?B?Y1d0cEo2V2dGS09QaFRIWVBBVVNFN3E3NmpRQ1dzQU9aSDJSRjNHazZFODVX?=
 =?utf-8?B?UVhtVC9rK2o5dmkvSW1RbVFsWmRpUmxkak5hejc5Ti9ubUNiMVB0b1FWelY4?=
 =?utf-8?B?UGdnQ0M3QmNCN3YvT29zejBIRnhEaUlxTDVLR2ljc0Q4Qk1tQ0hDRVoxODVv?=
 =?utf-8?B?c3hzczFOQW5IdDVoU3VEK3piWTZON1h6Nk9SVzdiSElVaEtWMERsdnRzSVBC?=
 =?utf-8?B?NHMvTGxia0cwbktsT1JNc1lhMHEzeGJYYzVOU2ptZ1pFZ2FLQis1cytQV0hq?=
 =?utf-8?B?UHk0N2FKcDIrYlpPM3RkaGM1VytqZG01UEVwbnVYdDJLWWkrVG53SEYvbk9N?=
 =?utf-8?B?YzlJVHVJS1NJL3VmSVNqbjlDdjM1a3hDSmZ0cHZKaFJLa2ltcmx6UmdkMklG?=
 =?utf-8?B?MkpxZVdCTzk1RU9tWUJxSi80N2tmTjE0WkFRK2tUZThzQzhudVMzWC91QVc4?=
 =?utf-8?B?bHhjRDIxYWQ0YWlTZ1ptTnQ3bFRESThJczhlTXRVN3N2VFk1cW9GK3k4L1d4?=
 =?utf-8?B?dE9xc0NmYm5yOFBHelo4UjIyQzJUTzVHdUI2WGtDa2k0LzNHQklsWVVuZmkw?=
 =?utf-8?B?WFY4TkVuRXRCWUdwTXcvejBWSFV4N3loMUN6bjF4dnpBR3UzSWpZMVUyREFq?=
 =?utf-8?B?cFhIWXJKU0k1Um1POTI3MDZZYloyRG9jQ2hTbzZFNUJyZ0M0bTczR0N3eTQr?=
 =?utf-8?B?aWNwY3RvNHlVZGlPK25sdHlSWmw5b2JWdGRmOWRTODZVN1gvYzNhNVV5UjVF?=
 =?utf-8?B?TksySVdSbTdhN1dqOWVTSHM4Y294aENSZlBxcy9DYjEvYVM3WXl2ekJpVXNI?=
 =?utf-8?Q?8NvU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UE5hdHZacWFuU2xsMHFKZXVlWG9UWlNGRU15UHZDRzdyUkFjZ2hGVERDRjZK?=
 =?utf-8?B?cTZBRDA2V0xVTDY5R2VyWk9PTVFXZm5CcVBScWtXSlJGMzJ6N3Y0VUdjOFFX?=
 =?utf-8?B?aldrZHZISldoRUs0bU1vTlkzSGZXVFlPdVpFS2hSZ3hLNmI5akJlRU5uNHkv?=
 =?utf-8?B?ZjBRcmI5Mm5vOEV0ZHBadXBwRzY0cnltaWErQStLcW5SSW1FdUJDaGEvcStl?=
 =?utf-8?B?Uk5BNUpNSGJ6ZVlNWE1qV3J3c2hJM1J5VE8zelA1bkFQWDNyVnhCSWJMQzE2?=
 =?utf-8?B?YXBjNUprVFA4eDRwYjUyQ2ppR3VlTUJqY1pEM3I1Qmk1aTd4Q2Z6QTVDVEpt?=
 =?utf-8?B?NmFxY3NSVE50RVJRbjZSczIwZFluVHN1Rnd1alVEbDZkbllJM1kycnRRaVhu?=
 =?utf-8?B?VlB4a3ZqVHY2Q2pveG1MR1ROcHo1SmdBcHJGMDhzNktrNHVaRElpRWFweDNP?=
 =?utf-8?B?MUhVRDZaTEV5YlhHcUU0Y1ZwRy9tSmh4Zml4SVZQcy8xUDNtNnh4TlMzWkZW?=
 =?utf-8?B?OFNVTkU2ZW1KbDFtRU9sbHdxRGVTdFJGQ0RsZkZFZVFtcXk0RG91QVlBZTdj?=
 =?utf-8?B?azU2NzNZWHlZNXV0ZjN1Y0xZdENhZFpONlJiV29EVXhTUmVJWWN2bExvaUx4?=
 =?utf-8?B?QWsyUkQrYk05S09JSGxUdVkvMlF0OEFOQmp0QURhVlBuR2c5Si94eXhjNUlr?=
 =?utf-8?B?azkrK1ZxQWM1KzBvWlhXNUlOQW1Ra1ovZllwbXRaU05uSGFlYkFGUHVlVXlK?=
 =?utf-8?B?NWhPeXFPYi9SQVN2Ly80RmdSelhIUDBkNkgyMjZEcWJCTHhpWHNjdVFXaUhN?=
 =?utf-8?B?VFhTMXNNL1dQTjZ6ekxHMlUxQWZTNnUwV0pMRUhhV2JOQ1MwalloYStYN05C?=
 =?utf-8?B?TUl6WFJlM09DcEozTllYTUEza3dnazZoMmQyNGhxT3c5eFYxL09Qb2xUOHVx?=
 =?utf-8?B?RStINDRrWTZ5OVdvdlVFd1l2SFJPMnJyM1o4dmNQTkNoU1lqZzV1ZjlQQUc3?=
 =?utf-8?B?SEZHRU96R2NYMkJOandrZkhrSEdTYUE0b095WlFxeWhLdEVPMDE2NUltTjQ0?=
 =?utf-8?B?aTNrSGZqb2EwamY5QzRRVERsWDlrUDlsSzZOZFlRbndRMW1qck0ydzJ3NzVo?=
 =?utf-8?B?Sm1KSXd4SnZGZGxMWi8vU2dmdnhWYjBpampET0g3eTZ0OW5yYmNZQlJCVkRN?=
 =?utf-8?B?Unk2Ukw4OUpQTVd5TCs1ZmNNNWNvUmdlT2Q4K3dzVmtGUk1VZ1hzRm5nRytX?=
 =?utf-8?B?UUJrNW1MUUt6T2tGYWdHMFh1LzRsTnVRNDNGZlZiWU8xT3VwQkxlYVlCalpr?=
 =?utf-8?B?YUtTMGRGaUZWeWdUcXcvTEVtb3FUYUY1QVl1aFl3UENVWDR0TVBWdmVZNFR0?=
 =?utf-8?B?SlZaZDkyWGJZODNqK3NFNDdZTHNJa25nQ0Z6VWxlejc1NDg5dVQwamM5Zlgr?=
 =?utf-8?B?b0FhSWNHMXhHN0lKYkkwQU11TkRZVUJ5MFZnZWlwQTBMNm02bWs0MXZzR0V1?=
 =?utf-8?B?WkhsNElWS0VQVmhzUndwNnh6SkVWUm01UjBGaG5KL0hHK09CYnNmM0pIQW5I?=
 =?utf-8?B?RVlWaWdKbkduM2ovUW1NR09Tc0R6NEN5TUFlSFM0ZnFhdVkwMkhhRUFURGZ2?=
 =?utf-8?B?MWMrQWVzUEI4Y1dGY0N4c2ZWcWduMkMwcmJlOEttSmEzSWpucjBIMk1TbkVM?=
 =?utf-8?B?MGEzSVhCNWlmWjJGMWIyUVRQUDh2S0E4OFdoVWJpakcyQnJYWmpyRmhKckEz?=
 =?utf-8?B?TWJhWi9TekFPYmxyRHBRZGc3OGNPSzRsWUZua1VBRXY0YURIUTlRUEdSUTFn?=
 =?utf-8?B?Z0Y1amJDQUcxdEJqSTBOaVpMaVlZa2VlOVdYR2xhTVQwaDZHbG9BS2hiSDdk?=
 =?utf-8?B?K2ZrWWloTzhLTTlmMEtiZW9aVGxWeUw0aGE1VDhNZllHUTErajJ3ZnNSVTYw?=
 =?utf-8?B?MVRScFN1dUJjOHJOUTFVUlp2RGZuUThDY1hqNWw5dGMvZnJSSE5WRnI5NVh0?=
 =?utf-8?B?YU94SFpxOHhKSk9xOFhUYkN4YytSMFNEcU81YXBlSWFVWjRUY1BuV3JQUjNO?=
 =?utf-8?B?cGlWazVIeWZtNzFJRmw1V2hSMVJyTFVlUXA3dVVzbUFTNHJYOHhsUFZBUU5Q?=
 =?utf-8?B?eUdmejVReFVucnVkcnVYU2ZObkcvSDhyTUE2UjgrR3lGUDBnV2JHajV3dVN3?=
 =?utf-8?B?YVF5bU5ucGJMczlHSjgyaVgzZklQOGRndGtWeHpWclBkOGVESW1pcWk3UWpH?=
 =?utf-8?B?dGVVRkhKRXV6TWdBa1c2N2FDQUVMTFljclNWOW1zR1lCcXd4RHJSVy9FYmI3?=
 =?utf-8?B?TEtWb2QzN2p1MCt6bndsTEhEem9VTzJhNUpjQnhjWEp3ZjMybVJjUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fdba5be4-f272-477f-4f81-08de58332ffe
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 14:50:00.5743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bTXCBm5pStPTB1biOY988jbzF3KOfVsQ4d/mttO7e67CmhjwUX5AAFVmKuuwDHakpS1sp7Gw/TkRojEt/+znw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6016
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74675-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-fsdevel@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[garyguo.net,none];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 56D3A4F769
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue Jan 20, 2026 at 2:02 PM GMT, Ryan Foster wrote:
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
>
> This patch updates seq_file and device modules to use the native
> C-string literal syntax (c"...") instead of the kernel::c_str! macro.
>
> Signed-off-by: Ryan Foster <foster.ryan.r@gmail.com>
> ---
>  rust/kernel/device.rs   | 5 +----
>  rust/kernel/seq_file.rs | 4 ++--
>  2 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 71b200df0f40..1c3d1d962d15 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -12,9 +12,6 @@
>  };
>  use core::{any::TypeId, marker::PhantomData, ptr};
> =20
> -#[cfg(CONFIG_PRINTK)]
> -use crate::c_str;
> -
>  pub mod property;
> =20
>  // Assert that we can `read()` / `write()` a `TypeId` instance from / in=
to `struct driver_type`.
> @@ -462,7 +459,7 @@ unsafe fn printk(&self, klevel: &[u8], msg: fmt::Argu=
ments<'_>) {
>              bindings::_dev_printk(
>                  klevel.as_ptr().cast::<crate::ffi::c_char>(),
>                  self.as_raw(),
> -                c_str!("%pA").as_char_ptr(),
> +                c"%pA".as_char_ptr(),
>                  core::ptr::from_ref(&msg).cast::<crate::ffi::c_void>(),
>              )
>          };
> diff --git a/rust/kernel/seq_file.rs b/rust/kernel/seq_file.rs
> index 855e533813a6..518265558d66 100644
> --- a/rust/kernel/seq_file.rs
> +++ b/rust/kernel/seq_file.rs
> @@ -4,7 +4,7 @@
>  //!
>  //! C header: [`include/linux/seq_file.h`](srctree/include/linux/seq_fil=
e.h)
> =20
> -use crate::{bindings, c_str, fmt, str::CStrExt as _, types::NotThreadSaf=
e, types::Opaque};
> +use crate::{bindings, fmt, str::CStrExt as _, types::NotThreadSafe, type=
s::Opaque};

As you're changing the import list, can you also convert it to the new kern=
el
import style?

Best,
Gary

> =20
>  /// A utility for generating the contents of a seq file.
>  #[repr(transparent)]
> @@ -36,7 +36,7 @@ pub fn call_printf(&self, args: fmt::Arguments<'_>) {
>          unsafe {
>              bindings::seq_printf(
>                  self.inner.get(),
> -                c_str!("%pA").as_char_ptr(),
> +                c"%pA".as_char_ptr(),
>                  core::ptr::from_ref(&args).cast::<crate::ffi::c_void>(),
>              );
>          }


