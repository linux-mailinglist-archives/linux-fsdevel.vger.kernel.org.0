Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7570D463B6F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 17:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbhK3QRc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 11:17:32 -0500
Received: from mail-co1nam11on2119.outbound.protection.outlook.com ([40.107.220.119]:63329
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231614AbhK3QRc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:17:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUY09XZsC02Ps0JBCT5+T+Wok+XFXJ4c6HbsPOV2SrbbILJNZY/RT+BUZqzH6V2kcyNJTBYdyL+zByyVQztwAeor9KsQc3GHrhHks/JM+Z3OMSw9BvKoMXldxOv8GPeLKMEYadlraV68LB02U2f1+O33pjZ6llip/oOSYnEToMBZPD1GbtY9DVOk3HY8q/UH9kQa4JFYUYEAffGKek9LK3vS+y48dh5POxLCjmNKsCbshenj9vnQIz1lk+mfOzqcGVdnDBVb+eNQnF9nVvZK9jFEChQBpPELkalRwlBMs1YxGGkf2W0vuIBqUOTVQKw8Etwfsr2HYNuKx4+r9uPg3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ON0zV/LsEUtHLmoIc1gBb5FRr3ZfVAYiNuohDPXBzjQ=;
 b=lhQcUjoNCY3beLLFrnqTzGExfCMTY3Jka3OkNhsNB8wNLAFKUXno1uXrZSLsFQ5ayF3vOAAO70/CjMJzbaMCUZ1ALniC4Qnycg5yyeFG8kK9USl1XgxWLNvSgZzsQktpw+SPBzYI2zmciwwZ9u8KsdCjMhu6wCOgqksAUsSTybe15eSx4/jurXRkLAAjj1/6H9ZsPlzaZmE/tn5ez2+/ZJlGv2+u2HKdA1sPjz5O7f2ybP2zvcnxB4OxVczDn4jYgt6Kc3j/DBlHqTFMw0BtfM0nZEqTUgepSo2qGlZruNhSZzzKMCWwGd849IsZj3GfmhO2zEOoGMWMXwXnDRpbFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ON0zV/LsEUtHLmoIc1gBb5FRr3ZfVAYiNuohDPXBzjQ=;
 b=ZPs/wsqS8cewfQMprMJPgqKTKK/6NzddPTIi5/b4qu9CplgsldEihfqyjojkNcK703b2eNjRtAh5qXaNBboI8m9FgfQAg2loA/XEMYZDtKtylGhVmeY8TpkubufBy+zZkrJiP+EPohKUFNBjmOdhKoaMwn1o8e5kkzVpqr0mmzs=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3815.namprd13.prod.outlook.com (2603:10b6:610:91::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.6; Tue, 30 Nov
 2021 16:14:11 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::288c:e4f1:334a:a08%3]) with mapi id 15.20.4755.012; Tue, 30 Nov 2021
 16:14:11 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Topic: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Index: AQHXtMzkc4v6dd1KNEyHoBK8G4XROqu+oymAgAANi4CASGLiAIAA/bOAgAA+8oCAAD8yAIAALy8AgAZzIQCAC+10AIAAFrcQgAAIAACAAAk2AIAAGm6AgAAyloCAABlkgIAAKLsAgAAK4QCAAAK5gIAAKI4AgACKI4CAAAf3gIAAAn+A
Date:   Tue, 30 Nov 2021 16:14:10 +0000
Message-ID: <978a322ad63bfdd8752b6ff9fbfce129c4c99193.camel@hammerspace.com>
References: <1285F7E2-5D5F-4971-9195-BA664CAFF65F@oracle.com>
         <e1093e42-2871-8810-de76-58d1ea357898@oracle.com>
         <C9C6AEC1-641C-4614-B149-5275EFF81C3D@oracle.com>
         <22000fe0-9b17-3d88-1730-c8704417cb92@oracle.com>
         <B42B0F9C-57E2-4F58-8DBD-277636B92607@oracle.com>
         <c8eef4ab9cb7acdf506d35b7910266daa9ded18c.camel@hammerspace.com>
         <0B58F7BC-A946-4FE6-8AC2-4C694A2120A3@oracle.com>
         <3afa1db55ccdf52eff7afb7b684eb961f878b68a.camel@hammerspace.com>
         <7548c291-cc0a-ed7a-ca37-63afe1d88c27@oracle.com>
         <FC3CB37C-8E5C-4DB0-B31F-0AA2B6D8B57F@oracle.com>
         <20211130160513.GC8837@fieldses.org>
In-Reply-To: <20211130160513.GC8837@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbada163-1b04-4af4-ecb7-08d9b41c71c1
x-ms-traffictypediagnostic: CH2PR13MB3815:
x-microsoft-antispam-prvs: <CH2PR13MB3815855AFF4B7AAD7E567EC2B8679@CH2PR13MB3815.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PTYGnp/61PvPWvw8vZY8DnMl4/GXTxDeJj8vzYch4YwGy6s9FkBThs7zdqfCrVhfMxHzJI/qgqpQC1ub4XtOcsXxEgJCUnVnxRzM3GvZzj/pzf1vCPjL5yWzKrBm/n9nJw0A1nLKkb/FZWpBEO/uenX+GYKpbFfYUpAZx9V7XGqmZogstOwyx/OwGJ33vTfe3uDYbBkHBd3KhO0J0ufeHNQ3yTyRxfs5HpurUJWYCmIrJyvqFRJa3p2nWKFj+d6hgl67a1RZzBT+jITdt/0aCFpl/EzAtQT2xkqNpNWrZrnXeKcco3UFBVxO5u2V1vKwK7hKxTN5J0cOGu847eeSc2XgzpglPG7jVjMjocWN/LLRDaUyVxNjHkDzQdtPK1UQClF/hLg08uN4soWxZQkln/qa7t1JEHCFVqcXMQDPyKg0KS+OdjdqsVMOpE4ZKA6M7s6CEMwKv2rvX5cFxieIKufY5BduWxgTwDoZtc6IBoJLQ2RQPhzp4laoTbu3iuOrLIYsnC0vGuDjS1fIUk/H9a1sV2p++plUJdU3bT0BF3QRX+iyIH3Xuyl1tUQ4lyz1FES5vIh36YHkkk98fTyk392nYWKCuNUt4Cbj/55i+Gs9eQtR6diT6qsTHjA3myBTM3LcSkrZZYbj/ANV72SF91m+46Haqhq6VDjp0lzWpS2FuaAZzzbN7xDR4NN2o8TR/yLKE/3hvYhgP6XWlXbPdPt12Uw7c5XckhfaTmj203OZwMjAq4ZE91M1yuxgRzPG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(366004)(396003)(39840400004)(26005)(5660300002)(6506007)(186003)(8676002)(4326008)(508600001)(4744005)(66946007)(2616005)(86362001)(66446008)(64756008)(66556008)(66476007)(8936002)(76116006)(38100700002)(6486002)(6512007)(2906002)(83380400001)(4001150100001)(122000001)(316002)(54906003)(110136005)(38070700005)(71200400001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmhKOVFWUUpYWFd6RVV3aUNTWG5udEpmY1FkY3huOGtzVmc4Ky84UThrSFRG?=
 =?utf-8?B?cWFtWHdVdGhPOGNueE1KdVdJNUJCQzhTblJQZHhBUEdKTEFzRUkyTTdvMFhv?=
 =?utf-8?B?NmRMK1ZOamNjeHhSeTl2eU1aU0NVVGNtQjhKOVZpVTE3ZDRwcmVmc3N0TzhI?=
 =?utf-8?B?Wm84WTVTVWFUSmVHNFE3NHBBWDBIZzFrSC9jOFA0RWlMUVpXQURlQkFWdzhY?=
 =?utf-8?B?dU0xUHlOM2J5YjNKVE1DdnJaZ1pYRE9aU3F5L1JUZWE1UG94RFkxMlV3RmFz?=
 =?utf-8?B?RlhvQmIraWtRUXBwd2UrVnFJNU0xeGZKVUhqWnVqSTVrMUorb2lJdHJ5RW5z?=
 =?utf-8?B?Ung3QUZlSksyVHZGR3FnamtMZC9sWTZlOXhVTk16eXFSK2pRL2w2UkRwR1M2?=
 =?utf-8?B?bHBsSHNGVFJENzZpbXZkSnRKMUNJSHlrQ3R0UUh0ZGEzN1F3dEhZS210VCtr?=
 =?utf-8?B?VCsvWUhMSjY4VnV5QWV5YUZpVEpiWXlUWFRuazBJb3BNYjBuak0wY2VYcytK?=
 =?utf-8?B?blAyMnIzN09FU3pSdm04UkR3ZnU3RHYvTkpxbHd6Q3ZOZjVTV04vSkRJZGx2?=
 =?utf-8?B?ZFlNd3h0QnRFalM2bjBoZ0twUU9QZjNCNm45VWRsMTRMMTZUZWE5eFNLbXJK?=
 =?utf-8?B?Njd5NVdRK01YZ09qM1JNbnZJalk4S2wrSC9mTnZNYnd2UFlZWHVYSDhCM3Jm?=
 =?utf-8?B?WFNRNStrVjVBVnVBOUwyQzcyZXR6dWI2NlNUcVBoQ2dDR2pWaHBleDBIcUJ2?=
 =?utf-8?B?TTdmeUkvN2ZZcmlqdkQ1K2NpRkdVSG1BaUxITjNIY0l2MUY1K1F1a25saW5P?=
 =?utf-8?B?aDZsK2I3U2hyYm01TjBvQnhkYWFCYzJ0VkRtN3YwRzM4Zk5iUUJXN1hNa2F6?=
 =?utf-8?B?NU1XOXdyQytMek9wK3luTTFFbk8vcFNtQWs2UEJiekFtYkdmSmZUSVJJTXR3?=
 =?utf-8?B?b21yWi9oeXVKbUY0dFJBWG85REs0UjgzdmhlckRwTk1kc0RyQ2dIcy9KUGE3?=
 =?utf-8?B?cHYwa0o1R0J3K2hwQmZ3MkZIMngvdHZvZHBvWEFJOFpPSzlTelU0d2pXc2x1?=
 =?utf-8?B?OUpDUGlLYTVrQXBpamsyTzdJK0NMZU45Y0xvUVdtYS9MZmhGMVN2bVRJcVZx?=
 =?utf-8?B?dm83RWYvb3Jycm5jeTk2S1VMRnJPMkd0K0RCN2hnVUo3UlN3eU1JbzFCZUlj?=
 =?utf-8?B?T0YyL3FPRjY4a1ZyRGpMN3QxdWg1UUtnTitSSWtwbEFCUUI5MGc1N2d0Mkc3?=
 =?utf-8?B?bWRZRU9xNXNVN25aLzI1RDRZVmI2VE9OcTJqYmZPcTNPUFo5a041QWZBQjE0?=
 =?utf-8?B?bWx3ZERMb3VRWGRPWEVYRlZUTFNLWUdDNGxtblBvYlRuVklyS0JQSitUMnJH?=
 =?utf-8?B?ZkU4UXFSc0JnM0ZXZXY0cHlxbm9FOWJCR3YyY2pEYVFqWUx4eXZqa2J5WmlH?=
 =?utf-8?B?M1lvSS9mNzZjbFNTT1VPUy9xbnR3QkhxSUFGb0ttaUxjTG1LUGRic1dHZE9U?=
 =?utf-8?B?UzlKeVFsZ2ZtVXZuVTBPKzlhWnFVenZsZUF1dHgwVkV6WXJwTWRHK3Z2b3dI?=
 =?utf-8?B?UW1tZHVPd04veThwOTNnZ1l4aEdvaDBGYzlCM3ZEck5uQzlUdnUybExyZnBE?=
 =?utf-8?B?ZUdjWTZMYzNxcWoyQUp5RkQxVlRUSFNTU0d6WXRybFFwV08xVkN3UU56b3Yw?=
 =?utf-8?B?ZHNOSEo0MnhQUW42VUNIYzN5dmZXVzVrdmpwVFk5UEN6cGUrVktnZERvVXJi?=
 =?utf-8?B?eWtLY3lLamxYL1lPeHNNUWY3cmpJZVp2eFVjNXBjdXJYS3R0c0F5K2YrZDh4?=
 =?utf-8?B?UmpVeVhObnNiWWZZS3NCS0VKQ29EaFNBNkVvd0Ztc2pzYTJuUnZhblR6R1Jm?=
 =?utf-8?B?M1Jzait2SHp2cmNub3d5bXZSanhlRUZKY3VCZGVoTHpZbGtLSXBGMXE0WTFU?=
 =?utf-8?B?eDNBTmpXM0lrbFV1RjJGSlFBTEtRM2FoYk14cU5KNEM5aTdkUm5tQTFVdXl2?=
 =?utf-8?B?ZVRNbVlQcWo1MUkxQWJ6MTFHb2tsb09la0tqQm1wdHVvdHpiMXNlSVZjaVhR?=
 =?utf-8?B?TFJ1NjVsK2t2VkZNVkVHQzZuME5mM3c1RXdxeVYrZDJYZ0hUbVVoTE5kZjI4?=
 =?utf-8?B?cXhUVUlBWlJqMlJDekFmZkN4dUtMdFI4MFV1N1lVZWV1QTJLN01XMVc5a2xQ?=
 =?utf-8?Q?GIhLaOa+bmuN63tWWauctYs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AEB1CA25D2ECFF4C87A418BD9FAD053D@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbada163-1b04-4af4-ecb7-08d9b41c71c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 16:14:10.9477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3k/x/YKDy3rA43RCdalkQlRc/z7OG4B2AAFvXES+ErM5q5Grer5bYJwihe1TauvCWbD7WJO1SmEVkoBvlqmiZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3815
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCAyMDIxLTExLTMwIGF0IDExOjA1IC0wNTAwLCBCcnVjZSBGaWVsZHMgd3JvdGU6DQo+
IE9uIFR1ZSwgTm92IDMwLCAyMDIxIGF0IDAzOjM2OjQzUE0gKzAwMDAsIENodWNrIExldmVyIElJ
SSB3cm90ZToNCj4gPiBJIGFtIGEgbGl0dGxlIGNvbmNlcm5lZCB0aGF0IHdlIGFyZSB0cnlpbmcg
dG8gb3B0aW1pemUgYSBjYXNlDQo+ID4gdGhhdCB3b24ndCBoYXBwZW4gZHVyaW5nIHByYWN0aWNl
LiBweW5mcyBkb2VzIG5vdCByZWZsZWN0IGFueQ0KPiA+IGtpbmQgb2YgcmVhbGlzdGljIG9yIHJl
YXNvbmFibGUgY2xpZW50IGJlaGF2aW9yIC0tIGl0J3MgZGVzaWduZWQNCj4gPiB0byB0ZXN0IHZl
cnkgc3BlY2lmaWMgc2VydmVyIG9wZXJhdGlvbnMuDQo+IA0KPiBJIHdvbmRlciBob3cgaGFyZCB0
aGlzIHByb2JsZW0gd291bGQgYmUgdG8gaGl0IGluIG5vcm1hbCB1c2UuwqAgSQ0KPiBtZWFuLCBh
DQo+IGZldyBodW5kcmVkIG9yIGEgdGhvdXNhbmQgY2xpZW50cyBkb2Vzbid0IHNvdW5kIHRoYXQg
Y3JhenkuwqAgVGhpcw0KPiBjYXNlDQo+IGRlcGVuZHMgb24gYW4gb3BlbiBkZW55LCBidXQgeW91
IGNvdWxkIGhpdCB0aGUgc2FtZSBwcm9ibGVtIHdpdGggZmlsZQ0KPiBsb2Nrcy7CoCBXb3VsZCBp
dCBiZSB0aGF0IHdlaXJkIHRvIGhhdmUgYSBjbGllbnQgdHJ5aW5nIHRvIGdldCBhIHdyaXRlDQo+
IGxvY2sgb24gYSBmaWxlIHJlYWQtbG9ja2VkIGJ5IGEgYnVuY2ggb2Ygb3RoZXIgY2xpZW50cz8N
Cj4gDQoNClRoYXQncyBhIHNjZW5hcmlvIHRoYXQgaXMgc3ViamVjdCB0byBzdGFydmF0aW9uIHBy
b2JsZW1zIGFueXdheS4NClBhcnRpY3VsYXJseSBzbyBvbiBORlN2NC4wLCB3aGljaCBsYWNrcyBD
Ql9OT1RJRllfTE9DSy4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQg
bWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20N
Cg0KDQo=
