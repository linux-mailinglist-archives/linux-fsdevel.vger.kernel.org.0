Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78A249C356
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 06:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbiAZFnB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 00:43:01 -0500
Received: from mail-bn1nam07on2063.outbound.protection.outlook.com ([40.107.212.63]:53312
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233744AbiAZFnB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 00:43:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMiJ+/RCM/bu0Ou/v+/fEicQXcpv4GFAyJGXRWAmVUufg6pfvcVYZJ0EEWcyc9MklhzHFVDUHkLD4+pSmc3iCpmk+leRpU71WERPCiseUu4e2dHaQEXTCV6b0pVsx38lJVW6BEA9wssEAnhdJebwUxtqpHW0TjUpEHmp0eaRNpydGXV+OmPmscdngN/dN2Hp86O436SpPAps3AWpt2eHI4QNl0/G0lMTKzT2449eUMxR6/iiOAryx31OHEE/O0cDDdYIbsgX2MkE8accOAIj1yVziWOiTi0qUY3AC1s0XcnDtgBrubDzFNx9Rz1862kqQxjpkhBF/aosDM0D9Lgmzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHZ8UQg81IcIEHTmbdbQ0nFgoYY0Y8WQgxDGt3fEDRM=;
 b=TxX2KHZSjbcUa97Yko+ubC2zYfWof5kHpBaMDwccXAvuyJ1R1/+ER8+5G3E2lEZxFtmGf+ZIz+2p6O3TdD7TXXjOyCKI9QFrTcAAQH7jBUIFt84WJmnaRBPJpEzNgS5vkA7I3lCWkkYGuF5Kk/unP4se1jPmoeO5DZGv2zXLwSlT/93UFczaFTTTeWA1KH43L5TXqGFUfGJZSu6OnTtJ4HWGK92UucWY220ovBgq24CI5yWvrKWPk5zmR+uJnODTHZ4qQgjY9sUbuNKMQqIEljPCjyRBVDSvHszkbptOpLWohLie+KVomdSA5YanAVrcz/VNOeHDRmDXniWNCnObJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHZ8UQg81IcIEHTmbdbQ0nFgoYY0Y8WQgxDGt3fEDRM=;
 b=WSmEeEM4FI630dMChrrh0b1OlohzH4ilNtLLYDeonD49hA5hkxm4cvzp0zdomnfjC9+Ikc+hO64dppyJv+Izyixy1n+WHIEC1JpK2rvSAZWVjfbgPRxy8msCEbyfiWVp7NA2JcmhvWJY6ZXqTc09S25NZkNGV1IuGAHrRaCquHUIHvSWg9TTtDbt6OnXuPb7pFMiFcbXd+eK5v8KkbK81XXWsHzZeU5clO+amPHGHJPIunDopPkY0ZTTTzYaU6I2LUvAO3ZepOdw2+ttmEKsZCVdvOaCA4BMrdzBC1UHQL2uoFSoxtGkmZBQfs9kGJF7j3bflJ0DizsbLZsBbNkAVQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH2PR12MB4006.namprd12.prod.outlook.com (2603:10b6:610:25::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 26 Jan
 2022 05:42:58 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f%6]) with mapi id 15.20.4909.019; Wed, 26 Jan 2022
 05:42:58 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     John Hubbard <jhubbard@nvidia.com>
CC:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: RFA (Request for Advice): block/bio: get_user_pages() -->
 pin_user_pages()
Thread-Topic: RFA (Request for Advice): block/bio: get_user_pages() -->
 pin_user_pages()
Thread-Index: AQHYEPdO6ap2eqegPUKaf54vvJDoRaxyJ8aAgABtBACAAjhsAA==
Date:   Wed, 26 Jan 2022 05:42:58 +0000
Message-ID: <9d9c9fc5-de3b-53fd-2274-ed23c669f290@nvidia.com>
References: <e83cd4fe-8606-f4de-41ad-33a40f251648@nvidia.com>
 <Ye6nG6xvVG2xTQkZ@casper.infradead.org>
 <c01fde9d-53a8-fe34-3abe-bad1b680b1df@nvidia.com>
In-Reply-To: <c01fde9d-53a8-fe34-3abe-bad1b680b1df@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7a8ce2e-6859-45bf-e9f0-08d9e08eb5a3
x-ms-traffictypediagnostic: CH2PR12MB4006:EE_
x-microsoft-antispam-prvs: <CH2PR12MB4006B74BB886E36CE2173E8AA3209@CH2PR12MB4006.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8lshpupBe3Q6DxstQ82IFKS9rYSsHKp2ZxyR0krtl9ZIZ71qxssCqPPSNyl7m6NSVcaw+8f0lX5SXBKTjuOekCP4pHCRqiAwxIZprkGS2lau6xCaQpzlNPmbPSgK4rl3XrXCjXCpa2Lc2vr9D3tqngwm1PPnxC+s53jile8oft82WORIgm67UqHwvzglo2783OfK24Gt1OoFTxlw8ZiGIQ6oTzTYPYdHwsWDeJnCdn6b99F0nPuxwHjS54vzCua2TG4/KHSd6q/Afb0X/Xv1SaUkAFyGSC4LK0aBNYSd+qUVKjbr2aBnXnmjZkx5GFZSS7pD2mvqCPWdxwl9CQeequIRf987cFMiY1Ky5L8aBeJWf8fVJ/KpHbJ8LMqEUoxNlsjEvtiVdyNe7sKFuEiSihJkxFJiQgpy6SLuMDG9ce6AzYQNLJIVbIqw7BNfBwt6EBrglya0PRrb5bcCzl+Pfna//3sk6CoprxqLvtSX3Bv6yEvhwV12PgO9odMIZ6iPmulpz/so0dNLcuxm88d1SBUF7houXpknOrp+i9p1AxewCEpU/oO0R8quRXc7LZ4cVQEhnPvZGfloBYozLvx6gIxFThNxCPdS4NTPB0q665bM0vxVfVg8kp2SAZ4SWqZg1jnH9WnNxw5qYhcR1OSagfckxLmmrK2MBzJeKj4gvfR8CqiFly5YqVrrLOWYfFQgTIr6MVU++uibkqsXrB3vwPA6eQhuNXza3yZM1EhtUXbisvtfkYaDMzvwYo3FnAuyQqEFR5r+0ugGpL0JYQeH4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6636002)(6512007)(37006003)(316002)(508600001)(54906003)(38100700002)(31696002)(2616005)(122000001)(38070700005)(8676002)(186003)(2906002)(8936002)(6486002)(53546011)(6506007)(4326008)(66446008)(64756008)(66556008)(66476007)(86362001)(91956017)(71200400001)(76116006)(66946007)(31686004)(36756003)(83380400001)(5660300002)(6862004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTZYS3QrS1ZrS0Fjb3hjK1MwY1NEMWtTdHJlQWJqZjhkNEZFS3RaeXNac2Vx?=
 =?utf-8?B?OVc2TC80aFFKVzdKaFRVNElweFV1b0FpUXFxM0JEL0NsOEhFU09OK3VkRkRx?=
 =?utf-8?B?RE4vVzlGMmhsL0Vub0I4R1plOGVDQm9WaHVPQU13Y1Aya005SGpoOTZZRlNs?=
 =?utf-8?B?TTgwbTY5YU1maUhKbWYvTHAwK2Z5ZDlXWXF3WXMvZXhXNWpBbFgyR1ZuQkV2?=
 =?utf-8?B?djM3Z2ZVR3Zlam9qYVdwbHFrZlpwem15eG1IUkIycFQvbTJhSDdOdE9ONi9C?=
 =?utf-8?B?STZTbGxsUkxaTEI3ZWhHUUR5VTB1K2ZhTUE1Z2NMWDZKc293TWsvK080Qmxp?=
 =?utf-8?B?N1c2V0dpRG5vVUtkdHRCODBORjErVjhoblFZRG9ReVNVTFcxY3FuREJ0dFVs?=
 =?utf-8?B?K3h0K05SU3BQOUdLZU00Mmp0NWxCTXZWd28ySkYydW0yK0gxdElxMWgrd0JN?=
 =?utf-8?B?cmNVamVOckZWUGtac3RwdmZ1RlloUTRLaTVRenI1blN2bEQ1YWZUV0VCT2Z5?=
 =?utf-8?B?REVPMFVMckJMN25sNkVCdXMybllOMTJYd0RnU1BDZXlVRDlLZ0FNbXFxdStm?=
 =?utf-8?B?Z2tpTkR4VkxqbFRBZUYzRWl1ZTdURkpoU3VWNDl2Skltc1BXZWs0Vld0Tkdw?=
 =?utf-8?B?TTZWQXhsdDZGSlR5WVVha1NDQnFYaFpTRWQ4SUVvMDVMWldSaFdURjhxZHVJ?=
 =?utf-8?B?dUI0bExTNGhYWmR5dzhsdklSSkhQWStMQlhYQjJnQmdzTlJQQmt6alFvSHZs?=
 =?utf-8?B?bloydlFhazR4eFcrdjA0b2E1Ty9SbTJuQzRYSnNWc1FPbU9adktVZU5TMDZy?=
 =?utf-8?B?NnRjWGRCWVhCZTR6R0oxd0FMcVU1bTA4eFpHVkdWaFk4RkxTTkYxYnV2VDVN?=
 =?utf-8?B?QjhoaGdDQk1kbnF2VE4wY3RPUmhIdW5tbWNIOVJYMVJEQkJlOVIrZFFEUVpM?=
 =?utf-8?B?U0pvMURiclNNeDY5ZUk0bzZMdnEreU5yMko5U0FrQkRHb2xFYm9MMWQ1N01x?=
 =?utf-8?B?M2Mvb1JsREpFVlZ0QlhjMFJaenZjMXdiNWh6eFl5b0pnTjVkZ2IyNk9EdDR5?=
 =?utf-8?B?d2JOR0E5dHRJaE1JYi9oRzBLdkZWaDdYREdaS0VMTnFTVDNMT1NyR3JjdVVu?=
 =?utf-8?B?aFFISEFKSFRORUxOWFd5QVdYVENDbk1lbUhmZWM1WEE0NENlUFpHd2JySnc4?=
 =?utf-8?B?dTNpT2J1QmVRZlR2aTl1TWNhMGVtc0tPRzJUeVpmQ1l0dmxYOGxBZVMvam9T?=
 =?utf-8?B?dVJmeEVGanBWMEFxRlpnamhEdlNSWUNncnQycWg2MTNaNnJWejVrWTcySWxw?=
 =?utf-8?B?N0pnNDZVUVdCL0FWY3FNTmhVS1BSTXZzSURGVzVsbWVDZzZOL2pGWjJNT0kx?=
 =?utf-8?B?RTJzUUo5dzdZY2NNUGZPRW1DcFMyR0pPYWZ6Y082b0J4a25Jb0Vxd3NsaE1L?=
 =?utf-8?B?NVlmUU5Sa1lqbTBVakV4ZDJJNjdYRWxacXZ0ejgzdDQxM3JVSVhqaGR0eGRs?=
 =?utf-8?B?MnZmT1dydHR5S2ZLd2FRYS81SkduUVI5WmJzR1B0UnZzL2JRcldWdFVwQzcy?=
 =?utf-8?B?dWdXSFhoWkwrM2lycDBscXREenkrcm40cEE2TFlWeTF3QzVTNmJIL1VWSTZx?=
 =?utf-8?B?T0dDbCtXenpIWWFleHlTZE5Wb2VOMTBYbzFOMkZpRUpCSGlUaTJvS0trZUxI?=
 =?utf-8?B?bGhhb0Q4YUJHY1BiSDhyMUxtSzBQT1dGZEJoeUQybWRtcTk0MWVqQ2RrSXV4?=
 =?utf-8?B?Zy9sbTZDWlBvam9qb1V5ODVrM21WTVAwTndvY2d6Nmd0eDBuRUJmQytXZE9m?=
 =?utf-8?B?d2FvcDQ1by9YMW5xeXpPKzBtdDdUVi9OWUU1MjNkalhDTVlRcHJVSUZXeUtF?=
 =?utf-8?B?U1hsYW8zY3J5S2V0VC9oVU9RNVR3czVzdkk5bXNoQnhDMDYwNVh5a2diZ0VI?=
 =?utf-8?B?ODMvZU9QZmlvR3lYb0NrLzRyTC8yaHFBM0l1THVZVzRzNDJQU0RQOGZqbnl4?=
 =?utf-8?B?NW5ON3ByYnRzWFlpTCt0UlBtSEI1aGdadjVXUXZyN1h1K2ZKeFA1ZUhIbHRQ?=
 =?utf-8?B?Y0diaG5Iek5KekhQY1Mwb0dVNWlEemVLdTBjNk1HOTZuM0Fjb2dnZmhCL051?=
 =?utf-8?B?MUJMTERCa0dpaDRWMVJlK0FtN0pwNnYvVkd6TEVNNVdsYnZsT09qWEFiYUpp?=
 =?utf-8?Q?KA3JmQLxWeOgzOcH4rB0WflKFihqgWfRRnKj42k2BBUJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC0DBCA85E469F46869601F23EF547A5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a8ce2e-6859-45bf-e9f0-08d9e08eb5a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 05:42:58.6094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9/dg+UWcxzmgk4mePxgYfXxtzZ+FHz7tnJ7y/dWvEnlUCMh47R7DyyMQ/HUnYuoJjSxATaRArIRHkL4B07aQYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4006
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMS8yNC8yMiAxMTo0OCBBTSwgSm9obiBIdWJiYXJkIHdyb3RlOg0KPiBFeHRlcm5hbCBlbWFp
bDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IE9u
IDEvMjQvMjIgMDU6MTgsIE1hdHRoZXcgV2lsY294IHdyb3RlOg0KPj4gT24gU3VuLCBKYW4gMjMs
IDIwMjIgYXQgMTE6NTI6MDdQTSAtMDgwMCwgSm9obiBIdWJiYXJkIHdyb3RlOg0KPj4+IFRvIGdy
b3VuZCB0aGlzIGluIHJlYWxpdHksIG9uZSBvZiB0aGUgcGFydGlhbCBjYWxsIHN0YWNrcyBpczoN
Cj4+Pg0KPj4+IGRvX2RpcmVjdF9JTygpDQo+Pj4gwqDCoMKgwqAgZGlvX3plcm9fYmxvY2soKQ0K
Pj4+IMKgwqDCoMKgwqDCoMKgwqAgcGFnZSA9IFpFUk9fUEFHRSgwKTsgPC0tIFRoaXMgaXMgYSBw
cm9ibGVtDQo+Pj4NCj4+PiBJJ20gbm90IHN1cmUgd2hhdCB0byB1c2UsIGluc3RlYWQgb2YgdGhh
dCB6ZXJvIHBhZ2UhIFRoZSB6ZXJvIHBhZ2UNCj4+PiBkb2Vzbid0IG5lZWQgdG8gYmUgYWxsb2Nh
dGVkIG5vciB0cmFja2VkLCBhbmQgc28gYW55IHJlcGxhY2VtZW50DQo+Pj4gYXBwcm9hY2hlcyB3
b3VsZCBuZWVkIGVpdGhlciBvdGhlciBzdG9yYWdlLCBvciBzb21lIGhvcnJpZCBzY2hlbWUgdGhh
dCBJDQo+Pj4gd29uJ3QgZ28gc28gZmFyIGFzIHRvIHdyaXRlIG9uIHRoZSBzY3JlZW4uIDopDQo+
Pg0KPj4gSSdtIG5vdCByZWFsbHkgc3VyZSB3aGF0IHRoZSBwcm9ibGVtIGlzLg0KPj4NCj4+IGlu
Y2x1ZGUvbGludXgvbW0uaDrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXNfemVyb19wZm4ocGFn
ZV90b19wZm4ocGFnZSkpOw0KPj4NCj4+IGFuZCByZWxlYXNlX3BhZ2VzKCkgYWxyZWFkeSBjb250
YWluczoNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChpc19odWdlX3pl
cm9fcGFnZShwYWdlKSkNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBjb250aW51ZTsNCj4+DQo+PiBXaHkgY2FuJ3QgdGhlIEJJTyByZWxlYXNlIGZ1
bmN0aW9uIGNvbnRhaW4gYW4gaXNfemVyb19wZm4oKSBjaGVjaz8NCj4gDQo+ICJPSy4iIChXaXRo
IHBvdGVudGlhbCBtb2RpZmljYXRpb25zIGFzIG5vdGVkIGluIHRoZSBvdGhlciB0aHJlYWQgd2l0
aA0KPiBKYW4gS2FyYSBhbmQgQ2hhaXRhbnlhLCB3ZSdsbCBzZWUuKQ0KPiANCj4gVGhhbmtzIGZv
ciByZXNwb25kaW5nIHdpdGggdGhhdCBhbnN3ZXIgc28gcXVpY2tseSwgbXVjaCBhcHByZWNpYXRl
ZCENCj4gDQo+IA0KDQpKdXN0IG9uZSBtb3JlIHRoaW5nLCBzaW5lIHdlIHdpbGwgYmUgbW9kaWZ5
aW5nIHRoZSBjb2RlIGZvcg0KYWxsb2NhdGlvbiBhbmQgZGUtYWxsb2NhdGlvbiBlaXRoZXIgd2F5
LCBpdCB3aWxsIGJlIHdvcnRoDQpkb2N1bWVudGluZyB0aGUgcGVyZm9ybWFuY2UgaW1wYWN0IG9u
IGRpbyBjb2RlIHdpdGggYW5kDQp3aXRob3V0IHRoZSBzb2x1dGlvbmV2ZW4gaWYgdGhhdCBpcyBu
ZWdsaWdpYmxlIGluIHRoZSBjb3Zlci1sZXR0ZXIuDQoNCj4gdGhhbmtzLA0KPiAtLSANCj4gSm9o
biBIdWJiYXJkDQo+IE5WSURJQQ0KDQo=
