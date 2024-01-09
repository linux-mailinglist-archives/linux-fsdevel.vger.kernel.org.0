Return-Path: <linux-fsdevel+bounces-7641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75124828BDF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 19:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB2B288BFE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 18:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978763D0B9;
	Tue,  9 Jan 2024 18:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FYavU2kz";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Dr+ZzpGB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436F03BB29;
	Tue,  9 Jan 2024 18:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1704823456; x=1736359456;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TQiuFAfqa9mYaDy5yw9k5M6yXeH0nDobs2kf+FOL+I0=;
  b=FYavU2kzi28BGqe47AELtwPa+kCgRKpOrb1qF+Ft7J5I2FeY4Tn0Vlnp
   PDXlVR89UVouRNeO0levnh+K9j+fq/8ViULbg5lTG+kk/v+l+CVBsylkd
   NKuEA/nEMapDNBIoNMWqeEY+kl2YqwM3WjJTp7QXlyWd2Pkk8RrUDfcGd
   UbX7P7+tke1LJTM03yBqXCkhYCbwvZu61UOTaFwkpEn7D4eLftD/FAuC8
   nSoKGY2pK2np36XPkf5Lj5Qig/6hBVSMyFPiPO6MTLvCZld71WCQEyZ4T
   i3/tTMYL0ttK+EC6pkwRkN9ecOa/kSlAB9lQTWJM7Vx+HrvKHYobfQ9bx
   g==;
X-CSE-ConnectionGUID: xIKZhSWGTs2RxmNO1qDm8w==
X-CSE-MsgGUID: tfir0j9cR8SY0FgoNFPpiw==
X-IronPort-AV: E=Sophos;i="6.04,183,1695657600"; 
   d="scan'208";a="6480218"
Received: from mail-dm3nam02lp2040.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.40])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2024 02:04:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ToWiWgzV4nZdPKXC13C45PEzp5cNG/uNYDeYsuTIbBqgnXDnYPEnGyEKdvfPyzbsACq4/GvTTZu0UU+vdTBNbzunwjfvF0DEK7odzTyN3nl0JBEqdDaSdE2Am9c38hSl4zQGOy6wa5Nbi5C9RrVK0MBniCx5myn8CqPyl4hWnBxJCqhx87OrnFfObP1UVU89Cr6TDrwB+ASUJCkPbnJrsdc4kKZMwcjhhkjCpN95I1cNEWNAqQpNt/N4kMapFNFseD6qvL9mk7x7f020OAyVEw+eHO1VmqoNWLkeuWC5hh5mI+OxTZpwgEmcDCnwXmKKtRnhE8HG2t7iDOsAGiUt7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQiuFAfqa9mYaDy5yw9k5M6yXeH0nDobs2kf+FOL+I0=;
 b=anICe6vPnrv3Gw+hr+NHWO8uz7qD9LF13CYLhTP3mBHYkiKXEFBsrWTsUW1xb9F4n0I/ngpmHNBr88M87iar5fMPKQ13mzb0CF75SscCs6EOGucwyyYfua+2HUp4yKg3kgAZc15R8zj/1Li1A4a32mWdb5MyjqpYCJfRSGhcq1tQIT9D8fLcWWz3CAvMymkPXSnI5QQVX59+7eFbSvJaFDd/13Wy/F0CinhYslAFkABcFORE5hOCqc3vc16cJsCUWaSEfz40ryk9VUiG0ZTOIyYEmoI3vexQOLff5Au4gQVjuMOg7tZtbpHHJJI5hB59VP14tvVvTZMPronN98BNmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQiuFAfqa9mYaDy5yw9k5M6yXeH0nDobs2kf+FOL+I0=;
 b=Dr+ZzpGBO+A6lMy3SpmzxFAy+YnmW5uf/7Gx1nxJ7LHOjcfUV+kQennR2FZrenzd/EMEt1cEbu03WJgxLrkCljKCI2MwFzMtbZeOnbTkuTfsmTxHZYCi+XNq32y+KLfJJbKGAWt67AyBwFXfRGjFLaBLpx5ArgSErNp2A+/u230=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB8041.namprd04.prod.outlook.com (2603:10b6:208:344::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 18:04:12 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 18:04:12 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Luis Henriques <lhenriques@suse.de>
CC: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Removing GFP_NOFS
Thread-Topic: [Lsf-pc] [LSF/MM/BPF TOPIC] Removing GFP_NOFS
Thread-Index: AQHaP1N1f1xtm7GuQkGyfOpNi6HK+7DLDVQAgATE2YCAAdWSeIAAJhiA
Date: Tue, 9 Jan 2024 18:04:12 +0000
Message-ID: <274c4bce-1104-4126-8a85-65a603a2980a@wdc.com>
References: <ZZcgXI46AinlcBDP@casper.infradead.org>
 <20240105105736.24jep6q6cd7vsnmz@quack3>
 <20f3de31-fbb0-4d8b-8f34-aa1beba9afc9@wdc.com> <87cyua33vv.fsf@suse.de>
In-Reply-To: <87cyua33vv.fsf@suse.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL3PR04MB8041:EE_
x-ms-office365-filtering-correlation-id: b805a255-d5c9-4b69-69c5-08dc113d62b0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 F+ne2J3lA4ysQn+kJDxpS1grWdoKf855BH62jOJ8Rj5C6lMOnmxbiDtnvfoDTYUEiN3kXqEMQTm1xQ/rwrS++6kTJS+i+S30ZKfV3LSc91M14rOwxLNTK+i//yJo7oYEt6UGKv9y8hI7iswmQ3kBAIreSLqtif0S9OpNZIdBNACvVZlHSTaiwDtaFh0CL7mKz3ze34mtKnpNWGsamsja+ODS5yH14jysm+4U6cCvrYeyrRGKqMyrakQXXrrCAavRVqwBMqZS5ekG69WAgTjmKacUX8V7xNcnqQKq4BgRBhPsYyk6RvCKjwq1QNC+mdaZ0A81JpLkC1lVPOwCpwvi4NB9074LPw7d/T12AVpTxZPVDbIGcvDTtAB8UXUEE//sPe0aacHI8YxLc/qZdXVkM6Zcs81kdEYNdnBgGJCIFaggdSwdQVzl9/1U4LnQKmAvSRXGcCXxcIVtSKVieauKLgJ9j8Ic2KMxDkxBqUzL44A15VKOoQsmFzjf0J26T+krvuji/2bAw2gOxy8ipuSdxG1T4j1nG5lA/UNJ6BbFDOWFXoCQKAocV3KVOs74kwcHxH8cPr4n/Uf/Kj7QhzXHQm+Mts0040/Xz/LgNumUoTKA2tQf06A8vj7JN+HP+Rg2m35SNci9J0qh6njZFkeV9ukCGk5opQcZfrGmmN5OSTaWwVM7cw5v7EqTOeBwBj13
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(31686004)(83380400001)(6512007)(86362001)(31696002)(36756003)(38070700009)(38100700002)(82960400001)(71200400001)(5660300002)(4326008)(4744005)(7416002)(53546011)(6506007)(2616005)(122000001)(91956017)(64756008)(6916009)(66446008)(316002)(54906003)(8936002)(8676002)(66476007)(66946007)(66556008)(76116006)(2906002)(41300700001)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QkZML2hBR3RtbTllWVFrSHVhaVpDUDR5ZDY2emEzdDBlUjlwSU0yU0RMSnR6?=
 =?utf-8?B?VmkxeThBRGpaRUQwZHhJMHZCcmYrcE9rNFhzbDlwSFJEd0ZhQTMra2RtRDNM?=
 =?utf-8?B?QWx2UjFHbGxTWnFoMjJMZWxycU1kVFV2Mm1BK09tNU9oRkNlbTFKeEN6eHZk?=
 =?utf-8?B?cGZ4YmNYKzZ6RUQ0M0lDMWF1c0dPWnJHdDBJY0JlR1J4dlBDZWNReG5rMFJ5?=
 =?utf-8?B?SUhWTlVST21iREFXbnB3bG1UNU5XOUtmV0txb2VRaXV3Rko3ZVZ3czZOYVhI?=
 =?utf-8?B?VmNEVklyUzA2TUVQY3d4K3NHejFpc2NKR0dwdDlOcy9kTFE3b0hjV29ZQXFp?=
 =?utf-8?B?OHFoY0dXYm1rSVM1alVlTVl5S2xER25xZWtFdjQ4K3JaWGpWQmpqNzJwRUdH?=
 =?utf-8?B?YUJURFlaemdBWTBDZDJNODdmQlVzRDBFeDY3OWkvWDlvcGlDNnNBaloySHFC?=
 =?utf-8?B?Qk14OXdsYkpzZGtjY3lXaFZBTE5vT21BcThYSlYxby9BVUVjdm1NQVVYS2ZQ?=
 =?utf-8?B?NytCUTJmSnpFRjJ2cTNYZ3BVUThiVkhhdHJCWUUyRktmMWdCc2ZDVXZ2cy9F?=
 =?utf-8?B?NVdqV1ZQdWp5TnB4OXpabTBzeFhsN20rNnY2ZDBvUzZkRzJoZ05BMy9PWTUx?=
 =?utf-8?B?YisrT21GNzFLMmNPekhtZko5eGQ4MGdNU2hQT1dMeGNZcjNqUXUzRFpuZm5W?=
 =?utf-8?B?N1kxRVl6NXBmY2NmWEEyRHlJOGZhcVJneW51ZWVLeXl6Q1RCUlVoOW1MenRi?=
 =?utf-8?B?VDU1ZVFDK2g0Ym5wR1drdmRlMm9PYkQ4bXh4WFg4SVNuRTVjYzdQQ1NjWVZW?=
 =?utf-8?B?VTJzQ0NiYURKRnBySWIyZ1JqMmhFNnlOVlJHVjl6MkpaLzlEWDNmdXV6VWx1?=
 =?utf-8?B?MWp3NjlvaWY3MWVDbEFWdzU0RmxtVzZ4YWVoUGVFbkg1Y3dSOUtxQkVSN3I1?=
 =?utf-8?B?MWw2SkdzR00wWUh5MWQ5M1lUcTNSc3NMRzFVaVRwWktpMEg1b1kzTjZreDRt?=
 =?utf-8?B?eEVvYTlBdU1RaEM2ZUxreThORENONHQrRmtFQUdQVHl6T3lrampNci9WYWh0?=
 =?utf-8?B?UjhiSmI0RUo0SG5Ja1NjMUdteDFCR0VJUStQN1NieGlXN1JOVDZwNStMRmsr?=
 =?utf-8?B?cHNESXZqa3BZaVluSEdGOHl5Lzc1aGFreGw5bjNkU1RjcFpUT25GYko3Tnlh?=
 =?utf-8?B?VmhZWHR2ZjNKVUhkTVlCZTE4MDVIWnZIcm1UZEZpUFo4OWxUaFRxNy95RWEy?=
 =?utf-8?B?UDdZRjYwUUxXR01BZFZvOHdERXdnd0h0WWtGdWpSbHBZaUhhT1JZSmtuYWRi?=
 =?utf-8?B?UXh5Y1Rza2ZtN0RxRHhjd2VoVEFSSnl1bWF6SjdRejlieXBBaGw1amhLcGg4?=
 =?utf-8?B?czc2bXlMR3h2akNnYXpNb0ZUSWdnZ2hCSitqMDZkVnBqN2krK2tYb2w3SFZP?=
 =?utf-8?B?ZlNUemhCRG9UMnZqQUJxMEJNOXpKUTQ0VFUrS1FJYmlZbHZDN1huS21oUXZq?=
 =?utf-8?B?MWhvZU5JUDlTSjIrMm5FUTdlTk5ORklEMVZtQ2xLQjhiSFQ0ODZ0b2JvOTZz?=
 =?utf-8?B?N2NlczJETUMwQmU2aVdyMHFNS1kzd3V3NVhFVFVkYyszWCsxNFdkbDRTdm1s?=
 =?utf-8?B?TDM5R3JjaElIS2pnMmV4ZWlMVmo3eUVCcW5wRFYwNzd6cHJXUHRRdmRDaTNi?=
 =?utf-8?B?bWN2QXR3RnNEVmR1bkFadW4zYjhOcWE0QmUwSmhwV1F6Y05tdGt3eFpCVS94?=
 =?utf-8?B?SEtVRXFPVjV4aGE4aERRVjJBZnhlbnZCVlRtdlZOWDJ3SkpMekxJSVRkdzJX?=
 =?utf-8?B?WHI2L1pIaDVHOUFqUEVkc2R3NFJtTzZaNmRib1VacEIzVklBVi9FZ1oyNFNm?=
 =?utf-8?B?Nm1iRXMrV3R1TWk5NTNOMzZDdmgvbGtUVlZhRUhWOVRUWWhEWG9xeEFVNzRz?=
 =?utf-8?B?T3ZuZjVZdyttTTZIRytTOUk4SWNqYWJVdXQ4NmNSUU5lRW5DU1NHL3lwTWRX?=
 =?utf-8?B?OEZPalR5SkpIQlFXTVM3c3hMbU1lcjQ2Ukt0RXVPMHB5QXhwYW03MWFJSTh4?=
 =?utf-8?B?UUt6dzhmbVlTWGd4M0szSHVUa2FDMHRORDdTeXJmdnQ2L3RMZUNnRWgzSTNx?=
 =?utf-8?B?T2IzSkNwMDJYSTdPSHpWRnVsYk9KQXpTN0J1VFc3NkJoVzNvWEtYNTl3by8r?=
 =?utf-8?B?cVJiaUZJV1ozSCtZaHFiVFlBV0JkUjVQNk9zT2Z0WHJWUGYxQnhjaWMzR3FM?=
 =?utf-8?B?L1pDNU5qOFlTWEFlUDA1WEFDd1lBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE0483F2F70F704ABFC3B43FCA95DBB3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3+ayGLgmvvVqBGmLg05bOg8lJUpxVI4nGa9tvHnLGriKVQYj54pi8XeRpvyl2vwInH9ICRsVBtZuqoXa6MjMONe/P5JAdY1H1+rJMX9XhXo+uCpsijNlXk6X7a1WNh1ePO3BuqLYhM6C7nnFF3xUQkgyklm6l9YqdV9LagpDktFzJGnDw1CrNkvU8ONLbZMVsPTNtHREmZ1e+VMRZJoIsAcy6iCFi9l+OhJGDgaup96OeYKydJaFX8Nv7cwPF1O9MIEEPLA191GwT6MlvbmhmOniS2zIKIAFD0lvTK3w+usLj8/UzTgu8SfhEhL+NSCONsDDVwxBqvpyrhZE60Uzt7OYHY13FgK22lB4uTf6wg+pZLsFBp5gYoFJR53Jjl8xyHxSJvEncK2NIgcAZsgAMTuIJbEZfR1F9lmKNzKrsB162raMN5emDF8uzc1zFWvUgUxceBRyamB7MIa9JOHx4va3wvw0CcRsTgkhaGYrckS6xFztdVL7DkOwo/S2+xU/XJaxnE71NCAQDNY6CXqGQUKZOVwCJxdF1uLenBjEH+twxtgQIsdWpEnHwKF4TlOYJC5NoeFJjcGRBSDY4lOjLL4cg5GMgYy6q6Pc/CVSjAEBwsWOPazoDzl2C9B5Xcio
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b805a255-d5c9-4b69-69c5-08dc113d62b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 18:04:12.5754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zQfV2oIQriRY5QwKip8Gk44c6BGvqJc5eVTkAMPm28xBPS7e5kV5+7be/MTsSlqtDeS7XdDDHaWXpWP7R26XA9e1TZeDc/CnTVyHkyfqEQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8041

T24gMDkuMDEuMjQgMTY6NDcsIEx1aXMgSGVucmlxdWVzIHdyb3RlOg0KPiBKb2hhbm5lcyBUaHVt
c2hpcm4gPEpvaGFubmVzLlRodW1zaGlybkB3ZGMuY29tPiB3cml0ZXM6DQo+Pg0KPj4gQXMgSSd2
ZSBhbHJlYWR5IGZlYXJlZCB3ZSAoYXMgaW4gYnRyZnMpIGFyZSB0aGUgd29yc3QgaGVyZS4NCj4g
DQo+IEl0IHByb2JhYmx5IHdvbid0IG1ha2UgeW91IGZlZWwgYW55IGJldHRlciwgYnV0IHRoZSB2
YWx1ZSBmb3IgY2VwaCBpc24ndA0KPiBjb3JyZWN0IGFzIHlvdSdyZSBqdXN0IHRha2luZyBpbnRv
IGFjY291bnQgdGhlIGNvZGUgaW4gJ2ZzL2NlcGgvJy4gIElmIHlvdQ0KPiBhbHNvIHRha2UgJ25l
dC9jZXBoLycsIGl0IGJyaW5ncyBpdCBtdWNoIGNsb3NlciB0byBidHJmczogNjMgKyA0OCA9IDEx
MQ0KPiANCj4gQ2hlZXJzLA0KDQpZZWFoIEkndmUganVzdCBxdWlja2x5IHNraW1tZWQgb3ZlciBm
cy8uIFRoZXJlJ3MgbmV0LyAoNjkpIGFuZCBkcml2ZXJzLyANCigzNikgYXMgd2VsbC4NCg==

