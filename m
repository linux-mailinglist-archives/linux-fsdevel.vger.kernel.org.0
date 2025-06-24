Return-Path: <linux-fsdevel+bounces-52682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034C1AE5C9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48F21166381
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 06:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE30231842;
	Tue, 24 Jun 2025 06:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oDPGl18n";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="P6a6Jfk8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747382222CE;
	Tue, 24 Jun 2025 06:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750745305; cv=fail; b=fs2XmzK36NbeWb2wDesPPAA799clShmN9yWRbbaRUNZgao73cj7W1jqwoo5iohMpOdU7DOcWIYqjjzX6iSCjx1Q+KLdyr/6VzHVrZB6CD9jQjclXIZ+l6+RnTpcmGp6v5uG/13lDfDPBdjzrjOfbkH21JrvlwbmfUFo9+ADFr0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750745305; c=relaxed/simple;
	bh=OqGcQnEaLhPqdvyQ9iSLeu9PRzfalJapipCB1DmuSqo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JS85wkVFIRpDRDzOrp5SjZ8K0IfPdg9RJghT7EpvGD1DtQoIiMCThtQFvm6dS8hm3kJLMrbjA6wJE4YerY88Td1ue7I2N/RfSqf88JJg6uBEJz1jW+9qaaf8aS85XFOtcUfWfuRJgRUydSGCowqUmAepPCzPwo3GHgIkg1xX20I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oDPGl18n; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=P6a6Jfk8; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750745303; x=1782281303;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OqGcQnEaLhPqdvyQ9iSLeu9PRzfalJapipCB1DmuSqo=;
  b=oDPGl18n+oOaW1Gsc6zpX7H2ZffRJeVcmSbF15qE+TJh8OrV8A/bHs6e
   6BRsf9B/0UAshuhwVJ1Mx6um7ae+L1PjAkPmvE08LaKhIhJIShDJtkumT
   pCxy9W1znii+CpH7zc6d3yVat5ldWBOxcThp6h6ccG3nTgIhemPu7Nkp8
   1qkRpZYqEQQY4CC1I9J/RmnkTbSXVCfhNSXJ/X22+j4znSGbH33FXpo5x
   5ObFyTYRNfafslwprov7twCcggEz9PVW5kmlwDq0q04r6fWDUSiFT+VmQ
   +mDBJ7RTanLIxybVyxcDhXNmFff3JctzEw4celkfGKUasAnhLR7rqFPa7
   w==;
X-CSE-ConnectionGUID: mI5lGG29SRCJ89PNr7QQOw==
X-CSE-MsgGUID: lrjPuz15QyCjjdOJNTnBgQ==
X-IronPort-AV: E=Sophos;i="6.16,260,1744041600"; 
   d="scan'208";a="87111896"
Received: from mail-mw2nam10on2088.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([40.107.94.88])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2025 14:07:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGJsXxUep3ids2GQI5jpzjsrZ5CsLLKzYOe+iwxDJSHMSSvYb3+TMDrjA4ke7hYbTMhoBF9o19R3S9JIcmjPcOLCU/8obRoG6VfMMO00F0kxKp+JQ8aolFXwxBh7kHyNmfGw67t2f4wxJ/MAx6O3RBox31Burvmg03BTuK3qt0cr9HYn+U0uM7RRwC6t7NMBGsH5l9G++V0Ytm3RH0UZXZ7yjiaBEBgFTaxkAR1W7nSf3eU5+ZA6DsWqIRX6IphOSMWFR/R7damH/IsAR8yA2iQDeDetlKkxkckU4n5QsafOO2GbeT1szWi0klJGs9zpv5dl49xiU0+bsU9RaUk4Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqGcQnEaLhPqdvyQ9iSLeu9PRzfalJapipCB1DmuSqo=;
 b=vFb4dcWY2gM9kVPXhhGKmGKdq/1u0vLfWQzszLX5k024k1bawcS3cpBbmdwoyr7wKY0+UlXsAxyozADpoD2D1y3awMUPc+sysfiar3tl+PlgxvN/HqCmoKOWNRM21eBudSCX9XQDTc8BfOY3q+XRoVbCNcAd9RxzsjVL1zlF3vehn3OG92zhdBL1GqLPKbfdHe6gCefjoIZfDnOm33gC1HapbSIoW7dEtejoZeLmsZxBTlXFpL1cx+7mMeYr0OolMopALA/FmR+Se0nm3aNJDG2YZ7Jmkb9FtOJhrKmK7f/oDwGRud6mSYlP6NWlp5C+acLG8s6cEHahC7n36tcw3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqGcQnEaLhPqdvyQ9iSLeu9PRzfalJapipCB1DmuSqo=;
 b=P6a6Jfk8DGAe9YH7hLzGzOSovpUHcxMMupTZVaXz341a11jf7JRYyENm8eRShAoR1kA+173/sbIk+/WRtyszK21fw4S0nBclcz4M6v1J/5Qxon/de+b1IPYOLwlXJsY2XiMqeGzMdmOfUuWWC7imFq07Wt+aj20G3129ndQ67fQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW4PR04MB7140.namprd04.prod.outlook.com (2603:10b6:303:7e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Tue, 24 Jun
 2025 06:07:12 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 06:07:12 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Joanne Koong <joannelkoong@gmail.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
CC: hch <hch@lst.de>, "miklos@szeredi.hu" <miklos@szeredi.hu>,
	"brauner@kernel.org" <brauner@kernel.org>, "djwong@kernel.org"
	<djwong@kernel.org>, "anuj20.g@samsung.com" <anuj20.g@samsung.com>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"gfs2@lists.linux.dev" <gfs2@lists.linux.dev>, "kernel-team@meta.com"
	<kernel-team@meta.com>
Subject: Re: [PATCH v3 01/16] iomap: pass more arguments using struct
 iomap_writepage_ctx
Thread-Topic: [PATCH v3 01/16] iomap: pass more arguments using struct
 iomap_writepage_ctx
Thread-Index: AQHb5K71Ibf2fHRkvEWKeXVNie4H97QR0xSA
Date: Tue, 24 Jun 2025 06:07:12 +0000
Message-ID: <783b0f0c-e39c-4f52-90e9-7f7e444d9e84@wdc.com>
References: <20250624022135.832899-1-joannelkoong@gmail.com>
 <20250624022135.832899-2-joannelkoong@gmail.com>
In-Reply-To: <20250624022135.832899-2-joannelkoong@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MW4PR04MB7140:EE_
x-ms-office365-filtering-correlation-id: e89022f1-3206-4544-8e15-08ddb2e55ca6
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TXJ1YlRBUkZ2cnJZeVdNN09QRHNQSktMdzcvRnVHcmMzWEVyNlU1c1pOSStu?=
 =?utf-8?B?RGRSM2k0enBtWDRHWk95TWpLRDh5Wjc2cGNscWs4b3VYWHg1VGFTZHkxa0wr?=
 =?utf-8?B?TEM1U1BOdWl0MGRNaEdiM3ZNaG93dXFRbGtIdTFHenBFR2dITmhKZzdvVlVp?=
 =?utf-8?B?SHRiSnNCRG1wVi8wbDFRNVhEcnhMczd4MlFabWZraUZJbWExSlRHMnVPQ0Za?=
 =?utf-8?B?aGIzQXVtdFk5S1RSZXVCLzNaOG1FVHA5OXlrS3dhTGhrWjZNUmh6WDBEeVNk?=
 =?utf-8?B?WnZ5TnhOa1dGdXBhUm9aL255MXZ3bG9POFNUTXhid2FVVkdNMktoUkxOUURh?=
 =?utf-8?B?NDRYY2JXM1Q1eDljazlIRHIxdTNoeHRrdjIxUkZPSEh2cjIyRm4yOWE3aEQ1?=
 =?utf-8?B?VnlUSVp6Vm1VTlpmcDd4VFRPOGh3T2doWWk3L1hxRG1IcVVLb091UEpjYXE0?=
 =?utf-8?B?VHFadjM3dDNHOW8zSHNzWGFKY3FsU1JsVDNZVnJMQk5BQ056TjdDOEdLejJp?=
 =?utf-8?B?SFdUSnkvZE9sK0RDc3VoME1lREg0SFpuaFJZMXpmcmVjY2Z3bEd3ZnJIblA4?=
 =?utf-8?B?K2tseTFMT0dnVXdRaXV2ZUxqam9PYndUV0o3ZTBjSmNORXplOFpMQzFhZ3BY?=
 =?utf-8?B?ckhGay9SYXZKRHY2eEZWQ1dLZGhYaEpBc3h6Yk5iZmFyTDhsb1dYamZscmpq?=
 =?utf-8?B?T1NIb1RtOHFFa24rb25OT2hrMXFuQ1FRMW1YMzh0TThkb0diNzU5OTdJMkpI?=
 =?utf-8?B?VUZNTmI1VEtnTnRlYkM5Z0p6WHFsaEZSdGg5M1lXd3Y3blJteDZYSXp1QkRX?=
 =?utf-8?B?NUdjVWNZVklvMHdITEtvaDRKV3FzYWJGV1FvTTJISm9MOVY1V3Z4VEtPTmJt?=
 =?utf-8?B?WU5KTHl1a1FlMndHTkFDRVd5SVdaQWhsaFpLaFFOY2VyOE40ZXRHQlhHNWI2?=
 =?utf-8?B?eHlWSytSQTB5VE5TOTVFZHo0QWVuckpnOG1DdG8zZ3IrZmNTams4ZWdncUlN?=
 =?utf-8?B?Mnp1THFscUlBcXpmTXBwV1IrLzZvdXJqVWxGTXBtcDJZTVpRM2p5ZmtzMUdz?=
 =?utf-8?B?RC8zdUR5T2VTa1VReGVZUzhMQ2k5NzlKazc1RlU4Q1NyVFhZVUluOERrY2s4?=
 =?utf-8?B?eGVnWkJGeWZ0bDJGWG42YmFTQ21yNEtVUWM4UkN2Y09yd20xVm4zVHpnREhv?=
 =?utf-8?B?dCtrMHNvMlZRZ2FKRnVBcTh0YVYxSVJXWXk2dXAvV3RaRmtPdjlSSXF4ZGFS?=
 =?utf-8?B?WGxJUTgxT2lDNEROZ3E5aHpKNC9jK1l1Nml1Nm0rdjcxUnJwaEFQN24wanpS?=
 =?utf-8?B?VzBMU1I2SGlWdGhZUW5NRS91Rm5qR05obEp0aXl6WDRaS24zQUhVWnFrQlND?=
 =?utf-8?B?cFlYWEo2UHBnWHlKTi9IZG5qM2dOellUaXVhUFBteXJ5cmxFOW83YkxUcXlm?=
 =?utf-8?B?UUtHYXR6UjJLdEFYSEoyL3B3YUgyZlA3eXE3aWF2eVYyWi9yZ2JzRG5GMDdL?=
 =?utf-8?B?eDJSeDRBL1hKaGRWdDVKbno2UEREdGhEcGlqcEs1SVhjenltTm5WVFhKT3ow?=
 =?utf-8?B?QUZRMnBmVHhvMUIxemcyVThoRy9YUDdVRjZZYXo5UU0rQ1EyL0FBc0JQV29l?=
 =?utf-8?B?NTBvbmszWDFCZm1wZmJ6dXJDendiT09BWUZCWmtqaGdlKzJwS2N6QlVVYXNj?=
 =?utf-8?B?bXloVlhNUW9MR1FGcmxZbXFtL1k4UTZOd0FxdlFQbC8yejBjVi9rMmY3Tnpl?=
 =?utf-8?B?d3NXbkdrTWQwN2l1bkJ5Y0tHZk4zaWxBZFdYN2g5YnhBbHlvNk5ETDdkdmYv?=
 =?utf-8?B?MkNwbUhTbEJUelZlK0FacEFVTXlJWVFyeVd3RlQ0SVVjd3gyZ3RrQ3REZEdX?=
 =?utf-8?B?TUxRZ20wYWlBTVIrSW5tb3p3TXJhRWlZSHl1amw0T1gzY3MzcHdmT0pFN2V6?=
 =?utf-8?B?NDNtWnF3cVpONmdIM1pGaEZLbDdzMjBBeEdJYjFma3ZGbW1zSEVWb3VVY0hv?=
 =?utf-8?Q?BAxagojEtyOF5AFeIW35TFNmpclywo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S3VIOFB4MWpLSWFxWnJGM1FZNG5SaVQ4Qy92L2hiYTZJMU1aS01nSHFpbWlj?=
 =?utf-8?B?STVsemYyM2l4R05Sb2pZLzJSMVBQQ0laNzBrSmE3a212MktGZHRKa0JncHBO?=
 =?utf-8?B?bjRtTkxLWlNtTThQc2ZtVmVqS2VGSDFQdEVyeWc5NU9rdC9DUXRlemlqWWpQ?=
 =?utf-8?B?TllQRDR1K2p4blpmeis1dThmRkVubERCZUNxYU0wWDUvbWJMQUdqdzY0Lzd2?=
 =?utf-8?B?MUtLZXJIRXZiQmh6UU1yQzBCVDZHMGZLUjZ6NGtLeDB2dlBwQm5VdzRQTkk0?=
 =?utf-8?B?MnFIYy8ybmxFTTBsTGhZS0xrbURwMHpCKytSSDAySm9KK1VVY2M5OFZhT25i?=
 =?utf-8?B?djhuQVNZWnoyRVI1aytibFNQWjZlc2hvcHlYd0lFbkplMWpmQUYzVURZTlpV?=
 =?utf-8?B?THJJanFYWndCYUhlcFcyeVlNUEpBbHdCZ1JzZ3BBSmtNYjFNT2dLaUlTUndv?=
 =?utf-8?B?eG5jZ1pDSU9xdkozVnp0S3p0N2RZMEdQeExTb1IwQjNhZTF0bndabWdmQmY1?=
 =?utf-8?B?QU9sZnI4eDdMV0s2QjNtZzROZnNKU1dBNWwzVFNUZ29CTUxUYVNnQ04zVG9z?=
 =?utf-8?B?OER4WVZJb1lHcUh2d042V29vUGtYTXQ0bUVzQVBzVXVGNFRxM1E2NjNaYjJ5?=
 =?utf-8?B?eWVaRDRUc2pxa1JudEZ1VXIwRWVIY25xSHZ2N0JwYUVZSEJJZkRlcVVSODhy?=
 =?utf-8?B?N1B3VEQ4Ly82bFpVbnJPa0xIY0N4WVEwYkhDbEVGVWNIMGlMNFlwem5TV05i?=
 =?utf-8?B?c0xncVlJY0VJa0pqdWhjN1g0ZlZ0Ti9TUGpLblNoVlBVUXN4QVNlYUExM0Vo?=
 =?utf-8?B?UWo1dEhSczRPZXAzV3p0ZDJBWmVvbVhHZ2JZZjVTRDZFY01ZTE9CbzhMczRj?=
 =?utf-8?B?WmRQa2hzMGNkVm9MUkNCVWRyN2tnbW44SDd6bEUwcnc3YjE0Rk13RkFQdkUw?=
 =?utf-8?B?OFVUaDQ3VHZtOE1vNFhjMVlhMWZJam4xaEhuUElyN3IyeXo5RHJaQWpYV1ZT?=
 =?utf-8?B?eWxMMVVDNTBSb3UvbXNHODd1UzlnZHdqa2xxcTREZ3V0cjJDNW01dVBzVGVB?=
 =?utf-8?B?SXYwUkx4RXM5U2lDZmZlTkQrcHlOVFFySjVYQ3BVQkhNYTgwSW9MemlOdUd3?=
 =?utf-8?B?R01KOGd0dER2UW5Fd2Q4cTJLUEJ4eHFyNG9yUUxseVJJWDVVZlJXK205RkJh?=
 =?utf-8?B?MjdXcjR6OXE2S1hTZFVQbHlsaTg4K1Z3WFZ2M2NOUXJ6ZWZ0NzIwN2lvalBD?=
 =?utf-8?B?N2NYOWtraHlXVEFXcWt6RkpsaDZVbkxvajM0TWZrM1dVeHdVSm8wUjJkQU1l?=
 =?utf-8?B?aHZpeFh4QTVRdWF2TEprYW1XdlpUVGltWmhaajBaT1BXRTl4aVlrMDNtSFJM?=
 =?utf-8?B?SDlmWlJqeXRVdll4NjdhZFpyWHhVUXREeTRqRHVkeWVhekV1RGlOUlUwM1Ur?=
 =?utf-8?B?VmJnVWR2VHI0ZnA4UVBBemttbmlTVFFTRHlOWXZqS3YxejNUV01MWnBsa0Nr?=
 =?utf-8?B?ZVIzcFRoRTlXZEtKTitQT0ZzazRxeWs3SFpJcTRPYUpEeHZCb09wTElOUlds?=
 =?utf-8?B?YWZhNXlPZ3pVVFBZODFwaE4wRlUzZjFFek5VaXhsWTFrWXBSeVlseEFiQnZ1?=
 =?utf-8?B?V0ZqQXpsSXp5eFhWV2lRVjlkd0QvazRSMndhL1A1QVFQczJoMG52WFlXbWVn?=
 =?utf-8?B?SXN2S0p1UUpMeXZYUG5YWDlZNTh5SjNrZ0JaU0xzY0dGekszbmgxRkdGT3Bj?=
 =?utf-8?B?M0l1a2xvQTRkUEhSWTBtSkNwaVFraEVkY3Q5b2NRY1M5SkRaTlB0QUh1RU4w?=
 =?utf-8?B?M0wzV0s4QXlNaTFzY0pSY1BoR2pyTS9aOGFoV2xpSEFHN09oOGY4ZWh2MTlK?=
 =?utf-8?B?VC9vbmlBTitNeE01ZkxMaVlNRGdhOENiaFRzWlkybVJwOUc2dDdoYjJwdFhk?=
 =?utf-8?B?QzB3ZEFLZmQxMVB4ck9PdHJ5VkpqcFpGS00yMkIvNGk4S1FYUjZQeUxwZVdV?=
 =?utf-8?B?SGtSZWt1Z3hIZk9taG1IV2dNWmtXaUtzckFJZWhEKzZ4aEpvNHlUQU93d2Fn?=
 =?utf-8?B?RXVEOTZVSTBnQlpUSmQxcEdqaFJJWmZidE0zQXUrNXB3L1d0TDVaZVo2Z2cw?=
 =?utf-8?B?MjhOcU10MUdoMVRGdzA1V2lYWGFia2VoMlI5MktsWkpSYk0wWSsvYmhCQ0hW?=
 =?utf-8?B?bnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59660311DCBE534AAE55927BED046659@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SUGI8YAY4u7qFna3lBVmotnkTT5toYqTOPDBSWbixHFqATuha/2IO5ckcXBa8o3gcmiBmVQQVPZCllNcIFh1dqCIYGWlzHhWbuU7RdkmLyxOlElfCZPqEfohsGsXEUIgtJ1xNGoT6PBDHcD/bYjXB98RNmLwXNZAuT0XfB4crubd6wg4uiq2wIPs4YSWjSNMAMeAA7BTwsgYC5iTDdTrcbWo+ivYPZAnFFMrB67YV3Uwhquf/USct7HUMk6EgbdmP7BaYUbuWdGUlwf2KjTmxtuI+LjQGeWwAc4lUtWzFXvDvHQ3IqB2eXUgbhHBsAQGnpRLucQKYPSR2G+8skOWxSFItwCEoTekhgDokK2dMAzr36I1Y5bVPQSyfvTU50uNiC0JKvkSM4FtszCUPj+IafFdlvdxOZkhaE4GnsmMyOcnvsLKI3k42hSIlJYaY81koOLOXJIWtRtNuaVpEuOn/e0jZ8Y0O8hy/wa3PcsD3LBC8OdHG/1geT6XkCeTKKaYhtWKLB7SQCA622XenP0+8RZv3wLQS+83qG2HVHxb/2/aMLOWSIDo7ISxji21CEUpwm/zSEdlYyWEYelqXKsQrtmi9+8xYRqER2bChnErMR4trD6U9Ilv6LnbLdyluf2B
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e89022f1-3206-4544-8e15-08ddb2e55ca6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 06:07:12.7767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mN1/N1B0pn0/HJ2wkY887i5T/Jkbax/7GnNAJH/nK7jPV1pP7g6ieWFZZh7oN/tUeF0DV8WxT4U7lQgkiiCUDMuqhxBpe3ic4fGoUe2a4aY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7140

T24gMjQuMDYuMjUgMDQ6MjMsIEpvYW5uZSBLb29uZyB3cm90ZToNCj4gRnJvbTogQ2hyaXN0b3Bo
IEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IA0KPiBBZGQgaW5vZGUgYW5kIHdwYyBmaWVsZHMgdG8g
cGFzcyB0aGUgaW5vZGUgYW5kIHdyaXRlYmFjayBjb250ZXh0IHRoYXQNCj4gYXJlIG5lZWRlZCBp
biB0aGUgZW50aXJlIHdyaXRlYmFjayBjYWxsIGNoYWluLCBhbmQgbGV0IHRoZSBjYWxsZXJzDQo+
IGluaXRpYWxpemUgYWxsIGZpZWxkcyBpbiB0aGUgd3JpdGViYWNrIGNvbnRleHQgYmVmb3JlIGNh
bGxpbmcNCj4gaW9tYXBfd3JpdGVwYWdlcyB0byBzaW1wbGlmeSB0aGUgYXJndW1lbnQgcGFzc2lu
Zy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0K
PiBSZXZpZXdlZC1ieTogSm9hbm5lIEtvb25nIDxqb2FubmVsa29vbmdAZ21haWwuY29tPg0KDQpM
b29rcyBnb29kLA0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1
bXNoaXJuQHdkYy5jb20+DQoNCkJ1dCBJSVJDIGl0IHNob3VsZCBhbHNvIGhhdmUgSm9hbm5lJ3Mg
Uy1vLUIgYXMgc2hlJ3MgY2FycnlpbmcgaXQgaW4gaGVyIA0KdHJlZS4NCg==

