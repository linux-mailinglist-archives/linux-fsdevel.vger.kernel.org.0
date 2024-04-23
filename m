Return-Path: <linux-fsdevel+bounces-17504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ADE8AE602
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 14:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB9F6281B72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 12:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307B78564A;
	Tue, 23 Apr 2024 12:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o7Gz93s0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HztfVfqm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFD212FB05;
	Tue, 23 Apr 2024 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875181; cv=fail; b=CeMeyMMgEjkPEdjwuNGywOKzBC97mdkRqvS5KUw6Wa4tXCvt8txY46tAgDIarwWlKn+Hyz6G3+7R0GuYt6ornn1z7MMtfF3+sJYxnF5ytUS3BY8ZiADUPNMzO4zPEKThrZEqq2Y6qG34PKxODZBOAM168zAcq5l9x/7pZx+qVRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875181; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nJ3UHgU6F0uLo9NblOmUc6iNNg432Ti07MnFr4m/BxygjLJadtH8hQTf3snlUYF/hi8N0vpwkp29oBU0jf7CCB7YxPaol86Oaljo4lu4lZmJoaT382FclcysH55bmuW43lCgaNO0nCH+NhEPB8+TFTU/RNF9gVAUuhPl6WJq0DI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=o7Gz93s0; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=HztfVfqm; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713875179; x=1745411179;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=o7Gz93s0lYjzip5xNeNFV9Tp7wad5vqbWCGjfefc4yWiLUimWokNqEuI
   ZMW2XQTjJpsqe53A/wlt4HDLr3kc4Yb0+NkxhEZ8OlwUvS1O3KOe5oepI
   F1pVQWGOYFhjntpYGdim1UbbOQzUstGdM8hgAFwDVYbcjURO8DnYNOa74
   X2+TZzPZVm1agICt+kChuA+K+kW+F7s+9tM4+HZcdJHIrRlsnh+69PwEx
   CLcy9merRxEZga4XhjDHmTgW0B/TKVzF3qMwITELrSbuyumnZHYgu6pDO
   SPfE8ntisK1lqo2A0FG0Q/SSnOhQdNGfcDxUB2xCscpJImAkW7f5ZIekQ
   w==;
X-CSE-ConnectionGUID: uNIvEGf0SRGAEAuLl6EzWQ==
X-CSE-MsgGUID: OS9x2EWBSrGjQWPfNgW71A==
X-IronPort-AV: E=Sophos;i="6.07,222,1708358400"; 
   d="scan'208";a="14655089"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2024 20:26:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSTcmieFfx+Ozmx9/DWW1BVjTP9rZdECUH7kFa0ih3P5g1S/ATPueuktc1BhvuxxaxbncPvQ4EqACB3AqU1PdbKLBNjxf/qPk5dqER8AeBNQiuCgRzIkJyFgkCZTfutTCqvZYiWl9KXeA3L8+Yo9myiXzfdU5N5AqxNJ0Y2lP6qAnSFATf5WRxuUVtaYry0ZvRzZ4p+PBYPGmkT/LwLSEftpWU++A/4j1ckxii2Vc34hDyOF/esNIzecPFGLlH8//PfcvIefEDDjy7/Q1vB8Xj1MI3zLuEdzzHTgRR21kM4GgC5dLexjaECHHpjD1sJ8zRbpebg31g+eeFiV+Qbztw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Lv8kjZHLcgZ1HvMqPXQv+cYV2G6I2kWwkebycsiLSsuHHEGztjeE/lTHwz81TUTX3hHrbHKucr9OrdnjfHcuW3fP8WdNAfBAGhu/9D+G8JCvYHr3NOhDkYMLVwfnAl5CTKbNcbTIYhMgdMNR9zemmpdTKJlxVf5siimybDBKzipCgBzK4b5CpWRT4E5ZK3ISAxjt6PtuxRRQVy6HtL1t27NTT5j8rEe9c4gtrtm3OA66vN33SqAy+7bPbfoPexvZAxtMoTVT3Wg6yVVX/SFBiebKympjQA64te19OjGLNhtVCMVGmOLgxiVmc9zvNUl798KEca9PXXgUyWRVEdC8Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=HztfVfqmeUdqdOVX1Bku+Iae0ONglj0+RxIAEhVNdnCjftCoXakJkk5eXtadfUWKQNbh5xGojmGLwSm1oOW/wtKpC7KFGJOuxcNwVZwUFqXyZOrOg08LttSpqR0tTPxkzUO3trYW4ASokQREa0OyQdGMEC8vqKK3y+1n8lqgCmY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6983.namprd04.prod.outlook.com (2603:10b6:610:9b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 12:26:16 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 12:26:16 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 02/30] btrfs: Use a folio in write_dev_supers()
Thread-Topic: [PATCH 02/30] btrfs: Use a folio in write_dev_supers()
Thread-Index: AQHaks2qldtmOxF+/UqqkI1EON14KrF1zUQA
Date: Tue, 23 Apr 2024 12:26:16 +0000
Message-ID: <12314ed3-7884-4f1b-bf81-22f9cb6ea452@wdc.com>
References: <20240420025029.2166544-1-willy@infradead.org>
 <20240420025029.2166544-3-willy@infradead.org>
In-Reply-To: <20240420025029.2166544-3-willy@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6983:EE_
x-ms-office365-filtering-correlation-id: fefdc68e-16b6-4707-cf1e-08dc639092c6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?VndUOTdDTHh2K1AySEkzdlB0UDIwSzBhYTVFOGlDL0Fyd2VEQVc5bVdpaGw1?=
 =?utf-8?B?QWNibTFCQ1JiSDB0b1pRYzJhK0pieEVsUUs1TmhTbndBV1prT2NUOHRRRFQv?=
 =?utf-8?B?VGRMbFduZUxCRjJxT1ZMYjQweTdjd2IyK1NjaXdRaXdQdDdDMTIyWC9QMkRt?=
 =?utf-8?B?bmxUWjg2ZGVlaUVRczlNaE85YTVpWnpUemROVTRSMHkxa3pBL2FNZW91d1Bn?=
 =?utf-8?B?ZTJEVGlCMlFiK3hKTmlENjRYWnpRclFYdTZCMmRLUHRwVTFaUHdDSUhzRzNn?=
 =?utf-8?B?WHduem1DZjFER2ZKTzRsb0lkSWZPdzhQUEJNeFVyc0xjeEsxYUh6WDdyeE0z?=
 =?utf-8?B?VFRCR01IWFo3RXVySUUrYzFPMlhGd211ZEw3VVZCbXgzR01QZ1lKZjkyajI0?=
 =?utf-8?B?UERMUVJ4d2d6eFpXaTZTdU4yTVJOUFFZaEhvSE40OXNpSlNhWUlKZGN5aW05?=
 =?utf-8?B?TGQ4algzVEVaaVdJODRTNm1JQzFRRWdydlRSV0NmaWxkUWlpTXNrMVpGNHhP?=
 =?utf-8?B?TlZGbUpTSVhwV3lyNElPRzBFakQzUTMxWXN1RmFjb2xxSDdQRE9pdXRjZTdU?=
 =?utf-8?B?ZVNkM2hRTmh2Q3d6TGgrcStnV1VicURMWTR5ODQrMHhheVJQTVFlQnBzcWVk?=
 =?utf-8?B?aUx5UWVvZEpQZnNuUTdhWjdyeWpYY0R3Uks0eVBqU3R5SFlaelpUWEhXOFhO?=
 =?utf-8?B?Y0YxWEJQcDJacHZ2UUw3SmJ5Ty9ZcnduNUFmS3hldXdabGh6QmFlRzBRV0Vw?=
 =?utf-8?B?d2VoNk45SWtldWNUL004dzlqaTJrOUdrbUhNQzFGbFp6MmMyV0RqMWR3VXND?=
 =?utf-8?B?aHh6T3dsSUE0N29oalVRUjVqdnZlTUdRU2xuV3JyU1kydDg0M1hjYWlLdXVu?=
 =?utf-8?B?S0RiZDhmTFhnUmRBVmQyVFRKZ3dLWFNELy9Fb2wxaDlxd2tUc2t0OUFqTnpB?=
 =?utf-8?B?Qkc3cUFZUmZsb0w1aUkzL2drMzF6RHprTHpJczNtMkc3U244cjc0REcwcUpo?=
 =?utf-8?B?MXYxREJTSW5XdXZRamxjaFRiZ3haekc4WHFxWUlRWERsT0paWVlBQ0xqSExH?=
 =?utf-8?B?UVB6dGdPcVgyR2JhR3hPVy92OUM1ZjF1WjMwRmQzMExnM1cySXhTWk9FWjcx?=
 =?utf-8?B?SDVNa0NDTHpwU3UzZ3RLcWhLREk0cEJXdEpZZTJZWGJUYU10UFlqUWNvV1Nu?=
 =?utf-8?B?Q3hid1BEMG4xYnlXWno5aVFhdXdtRHplR0ZjTHoxdFY0djhaWUN4SmdHcXBx?=
 =?utf-8?B?MU10RlVMNm1RYVJUaXIxOFNIV2R0VU10eUFwL2k5bDBMY2lLUFY3Q2NtdDQ4?=
 =?utf-8?B?a2QxOXJOeTE0RHJwcFVaVFNIRFFsVnhCWFVSODlSaEx0U0FlbW9CY1psUktB?=
 =?utf-8?B?YVYyU0g3UG10UGlJc2h1N043TkkyUXhNcjBYSG1RMFNiSUNXQ1BuUFN3SFdB?=
 =?utf-8?B?cDFJVjhWZU9XdndHdnRXc3dYZVdpK0RaN0ZEVm5yLzRZSnBsSy9yS1hrSmQv?=
 =?utf-8?B?TDFQTGVRQzEwYzZ3NUM3Kzl5STlNNzIxWHl6TWhibm9Jclo4QXp4Vm0wTjRJ?=
 =?utf-8?B?ZXdrZElsSm96eEF5Rm9XRDRYTFRzdXFWL1JxRkZOWDRya2F6ZHhIQUhHOXN4?=
 =?utf-8?B?V3hOWnR1TVZuQkdOWWRRdFd2WkZzcllOaURkZTk1ZWlaOHFEdVhKM29QYXZC?=
 =?utf-8?B?T1BFNXlZbnpKdWM0SXcvWDlJTndjellmOEVUZlJpMmNSRHVtNXEvK3pablZI?=
 =?utf-8?B?T2VUU3NvYmc5SHB0OFZXcFF4M09KZk4yczZDdFU4YWtVSXZsT0p3cGg3SzRq?=
 =?utf-8?B?eGZtUTlMdTNUU3pWckpkQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MmFFeTdrdTI3VVBCNlNia1pVQ2Y0QkhjVFRtaUNHdFZwaENhYWVvZmJFaGxo?=
 =?utf-8?B?RWtZVWpoK0FBZkZFNHVDdmVZVkRKbGNqZy9NLzhUL1lPUXBCbXFjZ2JNSzhp?=
 =?utf-8?B?RGc0ZjdwdEFHbGh6anp0aG9KVnpKMFJQYlh5c0JKL3FPOWVSem5KWmhtMFl6?=
 =?utf-8?B?TU96Tk9RV2lUcjZ4TDJuMXR2NVVHUWVlTW95VE9jZjZZVXFnMHJoaVlKaTN3?=
 =?utf-8?B?NVBnVWdnY3ZMeUVNK1J3ckxjMENocm5Uc2Q0eXBxcVR6dTRTaUFHaDN4MnFN?=
 =?utf-8?B?TVNseGpnVGFLaVpRczdxbVJXUk1nYjZxc3MwSXE1ajc0SENZNVJkTHhpeHNQ?=
 =?utf-8?B?UjlGbG40WkJKd29ETThPVE9obGkxanNJNTdMY2hSM3laVE9YaGc3Z3dnbmk1?=
 =?utf-8?B?NVlRbEkzTGpFNytuRkRtVFhPZXdhamdWN2tRcVRWZ1BhVDIreVlXNEo0ZCtU?=
 =?utf-8?B?QXRLWE1DVEx6Y2VYQk1FSkhjdnZZR0JMSkFPemhoSExWcGtUYzNKSUpabm94?=
 =?utf-8?B?SGpXL0ZVWEgvRmZ0bDd2UHlUd1VJTzVLVGpiNEoxeWtLb25KQnNrSXhld1B4?=
 =?utf-8?B?MThDeURDSG1WV0d5TDl3RTdPWkFtY2ZYcDBTcjhaanA1RzI4QXRrQloxVmww?=
 =?utf-8?B?bFVyQ0dwaHF2Nnc0QXRBYnNNaU0rT1A0ZkNjTjE1UHc2MjZaa3NzZ0tYczBP?=
 =?utf-8?B?YitBVUxYQXdIcDRZaWErN1c0dGhVSmJnRXQ5TTlsaE9Ca2VGbHNKME1jSXUw?=
 =?utf-8?B?VDB2YkwwL1ZqcUNnMTQ1THY0cmFQVzJrSXZjQTJSWkIrQWFYWVFjZkQyYTIx?=
 =?utf-8?B?aG5SNGpOQWRMdk52ZWozRFpXRmxUS1NFMUp0N3g5ZFVWRnBLRC9UYnI2Rytx?=
 =?utf-8?B?VjU5YkF2Tmp5dFZGUkNST215b0ZNRnhsYUZEK214U2hNazZ0UCs2OWdibXhN?=
 =?utf-8?B?U1ozMGZVbGk3S2NvTWJKSnJVa1VJMFlLS2xZN085Y2x5ekV5MXpNUm5jMEpn?=
 =?utf-8?B?ME4velFLYWtaZlBBY2xML2VnRmtzNTdsYi9hYU9ab2pGdWREUXl6WCtUNHBF?=
 =?utf-8?B?clk3SkdUNlNDTmxzZ25QcWcvQXlXV1ZPOVRSeWo4d2szR0VKSjI3b1doWXFD?=
 =?utf-8?B?SktNSlJaWFBmSHR5em1NNUJDYlpCZXEzaTJrZEpSR25JWmFDeEkvb0hvTlUx?=
 =?utf-8?B?dStQcjdyRGk2c2xUaXZFUGNkbnRPWTExUzk0Unk0VDlBbzlGbkI3YXVwc3N5?=
 =?utf-8?B?Y1RTb1ZlYzhZZHNZK2xWK1lJVlcybkRkSjQvMkoxdTl4MGtkLzhFbTBUU09U?=
 =?utf-8?B?MTdaRHFyTlUwaWFwMDl5V29QcHE0bGlsWCtEZm10bGRJUmdFemdKR2d4LzIw?=
 =?utf-8?B?V1BCMExMaXBLbm9lbVFZZGFBdCtvb0REaTBJeEJQYTJtY2ZBYzJIa3VnME1s?=
 =?utf-8?B?MjF1SjU1dUI2cjAyV1VibWIzM25MMXB4Q0E1VXUrN08yUzFtdWhqRm85bE9G?=
 =?utf-8?B?SHdpTUJSYnZsdVU1WEdYTUdza2hXRXdqbWNISDEwVW5sekh0M2hOTXJHVXI5?=
 =?utf-8?B?eWN5Z3hPQ01sRlUyb2FMYjFrZ3RlTDlnVXo0aTlyVWtDMEdrMklhdEFJc2w4?=
 =?utf-8?B?TnRaT1kxczdLODh0TzBIa3h4aURqY2tOSVo4TTFjZjlBbG5oOVhHZnZoMi9x?=
 =?utf-8?B?NE5CLzk0UzlKSnF3cEVMRis2ZHZ1Rm1LbUxkbUFYL0xVZVVlZ2RheUFPOTFi?=
 =?utf-8?B?MTltQzhxMEFCQkFTYWNQKzNCQWt6blNxZVVDazZDNm1HQzg0S2tTODQ4YjFR?=
 =?utf-8?B?MWNkMW5SMlFWZ2NGOWl5ODlzZVZnejltZVJLN2h0WEthbTZIWXVrdEhMdkZM?=
 =?utf-8?B?T0FaMnN1aHFLZVVWVWRYM2p0ZFFzVWdvWjRiM3BSaXpUTW9hL05YMjh6YkNM?=
 =?utf-8?B?R3pqL3ZXWkdDYkxLdEVZcStPbjdHVFlGNjBHYkhtNmRMQnRYODVzbGJyRzM0?=
 =?utf-8?B?SFlwWG9HaGQxcDFCMEZKMkY1OTE2V1hjelVmZklqbHZIZGFWZE9mRnpacDJG?=
 =?utf-8?B?b3dnZ1pXL0g2S0RNSGlzVDk1UlNMSkZqNHErRmpNRGNGK1U0dUJOMG1WRlpF?=
 =?utf-8?B?THVuclAwWEI0VFhUQW1hMklyaXVhV3hiOUdaeXFMV3J4MVU2YTdOeHZhZER4?=
 =?utf-8?B?REE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B17BB94B7E58AD4694C77914943EABBB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nz3crr246dmdyXgnu6ynhfOXjYtfBR+VOI+mzk0QUDgVyKWFMW3oEAB5yX/DPJtiJVer/WWGRbSwqpK22J7ofCuaH7sBGSvItRkr05a3pEER6c/Pr2sosTldfIjw7CUVWCZjefFtYln/sbHHCuqOcWHBJno8W+/6OnULkCqnaaeaSc/CNjXpF6cKkjtCLXgY8APEUiEs2ppNiC/EivuuV+wEaZsLVc4o/bIpuHqjkWdITbvUc/igZzuXSfi4J9kMsQngnVYbnaJNZpZLy0whblIFbjMdy9ZuxXfLHgXQ7/dN7ceL6JycrWYKzkvyKyNGAJPfiiR5N8R2LHtsN/wSAvaA04TnKRpmJFSKRVeGyfE7Q7rYanvDu5Vq0h30aSh0dwEbYJ+/s4u4ESqMA3WFt/6eGeQyBgAOMggLCVsHZCsw77dghvax0fEb9rm/9d99MZM7MLY8hAjERQr7Zr/ECN+f7mo7vud2RZN9UGaa2Uoi9r69plwDwNGM7eI6VwOrR/Qc7JW0NuXez54zLMfzRyNJzSWLjsvG38la2zqYjTBw7Pe5R7SUImCdnoWH0qOfn0PKm2XHZYRw8c6d77QNquvCdZsk4Pwb49PCbxPTapox2nzEK+t0Si2ZxK74ZIAZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fefdc68e-16b6-4707-cf1e-08dc639092c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 12:26:16.7962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zknZ2YivqvtamhamrnFGUhYEsalSpcjQJYJ9mpV+H7D0DfVQ0XibzcVDMmBt1SZWGo5EkkSkTN2pcsyp0tTM/iy01HR9oFodyw977JSLGUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6983

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

