Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C26497D4A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jan 2022 11:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiAXKiR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 05:38:17 -0500
Received: from mail-mw2nam12on2082.outbound.protection.outlook.com ([40.107.244.82]:27104
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233480AbiAXKiO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:38:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2XutAqg/j76Nke+rSR0q0FkbPNYg8n/P/LsI9tvdu3K+jYlZP7FwNHogJVaAuAX3hooWwcHL1TZcDSLOPY1tSOKgT46ImDy8koXDNrWo0CfJBBWjERnFUSujU06eTxb2mPR+lDp4i0ShoPIluPBFXwqmd+/IzpLgfhvMYKedgNQPSBXQiDbI0Ic4bURobxLkS6PgMTZ9y8gLLqIf75rW+9eNNMR1IRkwQn2AoPuuBS32yNxGvvFOz39P76gnbImqlVJpk+OVrC0fwCk3JiEbV7kW9fEKuD8kmVHPhvHsgk7hK09o3jtP57T5fpxzATXFGVEeWrbw7B7mCb9Jg14aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaoKupETCsz4tL5nnaqTBjMsD577JmzN6yhBYY+kZnk=;
 b=guypfmlgx21C8XeEW6AruMRV+m+usfOnxaNzljbimLayXkEHNw5XdvuX9jcOuk9CG0+SQ4Ly1LDncQ8i3KBJETH/okQ5qT3bUvmDkinY5AQchzJ3D3SQPzxrxPeG2hP2nzhyLDzTN/dpnMUlS5nHT7N16dWywPydjdkVHWuGP7a4AMI2lQoLdPQ9/w18yJ37gjT0o5kuHx6aQFRhujJguET1A05Ezi4sEhRFsySR+VAvTg7T3+v3su2cR49awJVXThFOFTZ1KpLMqk1LfxOruy2pwAmlOIVnDgZtOYduuUwng69pX9JqfQXMfqFkVERxoeXydw5YLczgYQCe9qMxrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaoKupETCsz4tL5nnaqTBjMsD577JmzN6yhBYY+kZnk=;
 b=a/o3GjpIoFAVX66/8FrLwPUoWmQkLrxl70VgmkF/tJGMLp5BtTpYzbqn5sMCRO9pMADt+PXawiXh+jpUeGKFCtwpbGaW+1uZf5yZSe/dJLOCfKotdr+5Hpdnwpere65MrkQMuA8B6UXf9buvtshc1ck+ZOt+NkI6iIjNwzH0eO71ZcF/Njh66p50VPPqn1fPFNxCqlenDvQj24WFVH6WWC5Y8NgRtIGG+pZqKIdUwrhav6ke86Lt+pmrYOpDrafRyT5/jnpfMrFon2mr3IyVdwszhvDS2wc+jm+2OBC0i8sOZfIB2Bb9JwvUqFfW6rvlU55u+IkbPRIOJVL9Utr6wQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB4073.namprd12.prod.outlook.com (2603:10b6:5:217::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Mon, 24 Jan
 2022 10:38:13 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f%6]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 10:38:13 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     John Hubbard <jhubbard@nvidia.com>
CC:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: RFA (Request for Advice): block/bio: get_user_pages() -->
 pin_user_pages()
Thread-Topic: RFA (Request for Advice): block/bio: get_user_pages() -->
 pin_user_pages()
Thread-Index: AQHYEPdO6ap2eqegPUKaf54vvJDoRaxx8cSAgAAJRQA=
Date:   Mon, 24 Jan 2022 10:38:13 +0000
Message-ID: <cde9acbb-ba1f-16ba-40a8-a5b4fdf2d2dc@nvidia.com>
References: <e83cd4fe-8606-f4de-41ad-33a40f251648@nvidia.com>
 <20220124100501.gwkaoohkm2b6h7xl@quack3.lan>
In-Reply-To: <20220124100501.gwkaoohkm2b6h7xl@quack3.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47b9b6c4-d6cb-4ca5-6774-08d9df259f99
x-ms-traffictypediagnostic: DM6PR12MB4073:EE_
x-microsoft-antispam-prvs: <DM6PR12MB407305727364F921FCC3A966A35E9@DM6PR12MB4073.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TvuLP7KFgF3BP+FnpKYraftXQMn16v1mJ6Kr6ss0XtjQ1dNMzW0tax0xI41f5Cei0Anw36AC00kBxNmPlnGBZTkki/sGHmcqolUPeHD55NTurVhLJmn3fWe+rCoGsIco4H3Zv9JuQMP85DPgQJMcYpkqI/z/ANDG1pQ8sFgUPn+BWESLvRqMhoEwTox0bbODWN5tEqfxNs7mBDUA50RFjXxs0eO2KZkHcJR9uii38LfMsMxpIwjf66vsQRKGu6PbcpVQ6C1Wmko+qEEWaF/0R+evP9MK0d1PDIYtCxCQ9uAQcr8M1rKO7iv9BCjycJYJHX94lHSxWg9Stoy0xPIDvlty8nH+xecKpLmUGnG2xQo29AHj9Jln8mTh0BLcZi/2Ue7u/1qTfIXcDAS1mB4JYv7nfKXZpuFLIJZLGVcjqjtf8St/uy8zvY8wWUpQhTAwv2YgijPwZ94x9DqHHrq5x115zzxNK9q5H38KqPPB+98pz1gzjwNkH3h9ywfaXXIN/l6W9o5XaeVt9+sIlbnzyiAx+cWHbtqAhuQazu2LUeKICe8aU6xwLfZ48PbHAES6AjmYwZ9aJaAlxw2v3kXd/HWD6cPFeB/dRrXkSYwrkuZJ3AAkDaIHyUfKEnUHk7IsU2o2YbPDsq8O0vNp3CWt40fDJgDoN5TQO4fbf82puMZS4E/SNX2C+2kPPZIbMwgt26s7igHNZsky+/QsMr2yG7gvENEOpA/Wr4oLa0BefxOtZp+Roi/UtR/et0PiR4OU69bkRNEyfgfn27Lw0/TR8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(36756003)(186003)(53546011)(6862004)(6486002)(66946007)(76116006)(64756008)(2906002)(6512007)(8936002)(66556008)(66476007)(86362001)(6506007)(122000001)(316002)(31696002)(8676002)(4326008)(5660300002)(508600001)(54906003)(31686004)(37006003)(6636002)(83380400001)(2616005)(91956017)(38100700002)(66446008)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SytKN1JjM2NGUzhLRDVuZHE0TzR4d2crcGRNZ2lPTzRNdGpJYmpKc0dDN00w?=
 =?utf-8?B?YVJ4d3Bsb0xtbWlYOHJFSVhMS212RkRLT1VtWDRFZUVST2VNMDgzbHQ4WjZF?=
 =?utf-8?B?SFN2cHdSa3d5RlJtSkI5N1F4ZkQzT1dLYit6aDBXUWZxQVVNZExBcngzUm84?=
 =?utf-8?B?UXFPY0VEUTR6YUhnMWxONFZZQVVrNHd2Q3NIOTdqWlJmbjdHWlY0Ymk0aW45?=
 =?utf-8?B?QTBTWTZ6NUtqYW9ta05yWmMzMS9YVFBVUXVNVUV5dTZRcERLZ1NxWDJJQzJ5?=
 =?utf-8?B?WllFcDNKdXBLelpXUjhDOTZ0c2FkalM0RlpVR003dmpyQ1U4SnduaEFMTDM1?=
 =?utf-8?B?a0VickpvTHlabmU4UUUwLzJGVk9oUUN2S3ZTWFUydW5TaC9QbUltc3hIeklD?=
 =?utf-8?B?Z1hhWm54SnJEclVwWGs5QzFpeDhCMHp5Qnd1T1lua0czU1dlc0VCMGRDNWhY?=
 =?utf-8?B?bERGZmdlRGtwTUYvNXNWRGxzRjhQVmxnQXZlOG9GcVFvbk9temVJUUE2eEJv?=
 =?utf-8?B?T0pPUDJ2TUt1dnQxZUowcHNJcDhqUGRNSlVkVE4vaStLN0VFTUZNbW42N3lY?=
 =?utf-8?B?U1k0U2JOVE5VbEZVODdacE1DVHhFSCtvSXhJR3BsSFgzbC9OZWFrKzdNOEZM?=
 =?utf-8?B?Smh2L1hPUGswREZxM2lhbExRWkVnRnN3V2Mxa2d0R1k5VTdrNXF5eWVjZGt0?=
 =?utf-8?B?Q3dhaUd0SEQzSjBtaVFNZnJ3TGw2aHR6KzNHb3NGYmFBc0tEWFI1Ung4RWdI?=
 =?utf-8?B?ZlRFM2Zhd1Nka1dUM2prQTkwc2RyRm1PdWl4aFEyQ1U2RVByakxJdUowSTZQ?=
 =?utf-8?B?WXBvOTlKeDJ2cURrT3BEUUFodVhiQ3ZPSzZkTzRSR2RBcW1lbjJIdTVQYld5?=
 =?utf-8?B?OGtGMXM2ZEoyN2RJVCt1Y1RPWkc1RHdaUmo2RW9yWTFrWExnTE81T3krdGhS?=
 =?utf-8?B?dlZoaVBhV1hnV0VZNlZpMUFEN0NmN2plTGY5Y0pwdVMxS2tkb0xIZ0hpb0hP?=
 =?utf-8?B?RllYRjZmY0VicEJaSUxKZzZ3ZWxqdXl1TUExK3M2UThXL1o5aXpQV2RadFE3?=
 =?utf-8?B?ZjBLVGVlQkZ5cTh1ZjMwWnVXSFFFdVJBRGtMKzJ0T00wOUR1V3M1WFhtZVp0?=
 =?utf-8?B?bWVlcWJ1RzNkUzVBNzFHbTZycXo3YStxbFY5YUVweFNzazYySnJBa2JnNnJt?=
 =?utf-8?B?SGptWDZxb2drNFl3WVRKdE50MVJ4TjJvcHBiSldOd3RMM3MrdW5Ld3R0cTRU?=
 =?utf-8?B?SnBLdTN2YnRBV003Kyt2RlB5ano2Nk1zNlVhbnMrRzd6eHJQSGZiUEZIcDZC?=
 =?utf-8?B?NllRWmN2RSttSUNZY0xLc1BZRVM5U3VOcURCZm5BalFHckM2SVFrVFl1R2Rz?=
 =?utf-8?B?YmJQNWNZNUFlVVBOczMzWVMza0h2M2gyVndyNUVlS0VhbWdydlFDTWQrcXNu?=
 =?utf-8?B?QXJxTG5FL0tEbXh2RmhFSXNxUzl6aTNyWlBpVTNlSjg1NklHVFlTWjkzOCtU?=
 =?utf-8?B?RXRzbkhtU3pqMysveXlHUXY2a0Z4eEtmd1lhdFhzeTlTdy9pWWNmTlMwWmlD?=
 =?utf-8?B?ZzR3N0tiZ1Fwc0xKRTl6RWdPQ2ZsbFgyd3F3NzI1T2NGeVUzQWJWaXl1UStl?=
 =?utf-8?B?cTJjNGNZTkRzZHdaVzU0OGJqU2x4UzhoS2l0UGF1cWptRHVpSHd4SzNCN3JH?=
 =?utf-8?B?S3laY3lOcXVBNktub1h4V3JWL25UVXcrRVNzTzlCSllPcUw4ek4vaTlUcnpH?=
 =?utf-8?B?MTAzSjVIWU9sUDh6MHJxK3dqUlp2TWZEa0wrZzRBT2NvNHlWRmcxNmJsK2RW?=
 =?utf-8?B?d3BjQ2FqbG9tMVo4QytvVzF5TStIemp4OW5zRCtQWmR6U3FyM1pGRXBJYWth?=
 =?utf-8?B?THExdHZzREZSeXdaVlZmZzlKYjBwQVZ4TUlSK2xYK3hPSTVnS2FPbVUvKzEw?=
 =?utf-8?B?WUVEWEZyUlZ1clZBUldTNlF3d1RGZ2pPSnJJVCtQcDQ2dU9LOGJGcXMrcWxx?=
 =?utf-8?B?Z2Y3VzcvYVFiOEFGelRrZS9vMUdXaHVTbUhnODVhY3l6MnkvaXNEbk9QdmRN?=
 =?utf-8?B?SE1lMjNzU0M0WDA1Q3A3Q3A1THducEdjWURXUno2TUp2cWtmSUVUc2tnd0hS?=
 =?utf-8?B?Qlhwdjg1aFM0enBwdWlxVk0zZEVlSEUrMGZSZnhWOWV5cUszdVdWbndkTElW?=
 =?utf-8?Q?UC9lUtVA7LQESjr8bjcNoyBvYubviq8ULz+3yVVY8y8A?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1C25C05A9BE98449AAA55F4604ADD51@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b9b6c4-d6cb-4ca5-6774-08d9df259f99
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 10:38:13.2644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9jIY6zvPZDDqc5K5t1quApPWAUQTNSjbkTSKOur9oIN06OiCCWWE4UHLfcuoLubWZU7Is5NrcaENiOAAczszjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4073
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMS8yNC8yMiAyOjA1IEFNLCBKYW4gS2FyYSB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWw6IFVz
ZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBIZWxsbywN
Cj4gDQo+IE9uIFN1biAyMy0wMS0yMiAyMzo1MjowNywgSm9obiBIdWJiYXJkIHdyb3RlOg0KPj4g
QmFja2dyb3VuZDogZGVzcGl0ZSBoYXZpbmcgdmVyeSBsaXR0bGUgZXhwZXJpZW5jZSBpbiB0aGUg
YmxvY2sgYW5kIGJpbw0KPj4gbGF5ZXJzLCBJIGFtIGF0dGVtcHRpbmcgdG8gY29udmVydCB0aGUg
RGlyZWN0IElPIHBhcnRzIG9mIHRoZW0gZnJvbQ0KPj4gdXNpbmcgZ2V0X3VzZXJfcGFnZXNfZmFz
dCgpLCB0byBwaW5fdXNlcl9wYWdlc19mYXN0KCkuIFRoaXMgcmVxdWlyZXMgdGhlDQo+PiB1c2Ug
b2YgYSBjb3JyZXNwb25kaW5nIHNwZWNpYWwgcmVsZWFzZSBjYWxsOiB1bnBpbl91c2VyX3BhZ2Vz
KCksIGluc3RlYWQNCj4+IG9mIHRoZSBnZW5lcmljIHB1dF9wYWdlKCkuDQo+Pg0KPj4gRm9ydHVu
YXRlbHksIENocmlzdG9waCBIZWxsd2lnIGhhcyBvYnNlcnZlZCBbMV0gKG1vcmUgdGhhbiBvbmNl
IFsyXSkgdGhhdA0KPj4gb25seSAiYSBsaXR0bGUiIHJlZmFjdG9yaW5nIGlzIHJlcXVpcmVkLCBi
ZWNhdXNlIGl0IGlzICphbG1vc3QqIHRydWUNCj4+IHRoYXQgYmlvX3JlbGVhc2VfcGFnZXMoKSBj
b3VsZCBqdXN0IGJlIHN3aXRjaGVkIG92ZXIgZnJvbSBjYWxsaW5nDQo+PiBwdXRfcGFnZSgpLCB0
byB1bnBpbl91c2VyX3BhZ2UoKS4gVGhlICJub3QgcXVpdGUiIHBhcnQgaXMgbWFpbmx5IGR1ZSB0
bw0KPj4gdGhlIHplcm8gcGFnZS4gVGhlcmUgYXJlIGEgZmV3IHdyaXRlIHBhdGhzIHRoYXQgcGFk
IHplcm9lcywgYW5kIHRoZXkgdXNlDQo+PiB0aGUgemVybyBwYWdlLg0KPj4NCj4+IFRoYXQncyB3
aGVyZSBJJ2QgbGlrZSBzb21lIGFkdmljZS4gSG93IHRvIHJlZmFjdG9yIHRoaW5ncywgc28gdGhh
dCB0aGUNCj4+IHplcm8gcGFnZSBkb2VzIG5vdCBlbmQgdXAgaW4gdGhlIGxpc3Qgb2YgcGFnZXMg
dGhhdCBiaW9fcmVsZWFzZV9wYWdlcygpDQo+PiBhY3RzIHVwb24/DQoNCnRoaXMgbWF5YmUgd3Jv
bmcgYnV0IHRoaW5raW5nIG91dCBsb3VkbHksIGhhdmUgeW91IGNvbnNpZGVyIGFkZGluZyBhIA0K
WkVST19QQUdFKCkgYWRkcmVzcyBjaGVjayBzaW5jZSBpdCBzaG91bGQgaGF2ZSBhIHVuaXF1ZSBz
YW1lDQphZGRyZXNzIGZvciBlYWNoIFpFUk9fUEFHRSgpICh1bmxlc3MgSSdtIHRvdGFsbHkgd3Jv
bmcgaGVyZSkgYW5kDQp1c2luZyB0aGlzIGNoZWNrIHlvdSBjYW4gZGlzdGluZ3Vpc2ggYmV0d2Vl
biBaRVJPX1BBR0UoKSBhbmQNCm5vbiBaRVJPX1BBR0UoKSBvbiB0aGUgYmlvIGxpc3QgaW4gYmlv
X3JlbGVhc2VfcGFnZXMoKS4NCg0KPj4NCj4+IFRvIGdyb3VuZCB0aGlzIGluIHJlYWxpdHksIG9u
ZSBvZiB0aGUgcGFydGlhbCBjYWxsIHN0YWNrcyBpczoNCj4+DQo+PiBkb19kaXJlY3RfSU8oKQ0K
Pj4gICAgICBkaW9femVyb19ibG9jaygpDQo+PiAgICAgICAgICBwYWdlID0gWkVST19QQUdFKDAp
OyA8LS0gVGhpcyBpcyBhIHByb2JsZW0NCj4+DQo+PiBJJ20gbm90IHN1cmUgd2hhdCB0byB1c2Us
IGluc3RlYWQgb2YgdGhhdCB6ZXJvIHBhZ2UhIFRoZSB6ZXJvIHBhZ2UNCj4+IGRvZXNuJ3QgbmVl
ZCB0byBiZSBhbGxvY2F0ZWQgbm9yIHRyYWNrZWQsIGFuZCBzbyBhbnkgcmVwbGFjZW1lbnQNCj4+
IGFwcHJvYWNoZXMgd291bGQgbmVlZCBlaXRoZXIgb3RoZXIgc3RvcmFnZSwgb3Igc29tZSBob3Jy
aWQgc2NoZW1lIHRoYXQgSQ0KPj4gd29uJ3QgZ28gc28gZmFyIGFzIHRvIHdyaXRlIG9uIHRoZSBz
Y3JlZW4uIDopDQo+IA0KPiBXZWxsLCBJJ20gbm90IHN1cmUgaWYgeW91IGNvbnNpZGVyIHRoaXMg
dWdseSBidXQgY3VycmVudGx5IHdlIHVzZQ0KPiBnZXRfcGFnZSgpIGluIHRoYXQgcGF0aCBleGFj
dGx5IHNvIHRoYXQgYmlvX3JlbGVhc2VfcGFnZXMoKSBkb2VzIG5vdCBoYXZlDQo+IHRvIGNhcmUg
YWJvdXQgemVybyBwYWdlLiBTbyBub3cgd2UgY291bGQgZ3JhYiBwaW4gb24gdGhlIHplcm8gcGFn
ZSBpbnN0ZWFkDQo+IHRocm91Z2ggdHJ5X2dyYWJfcGFnZSgpIG9yIHNvbWV0aGluZyBsaWtlIHRo
YXQuLi4NCj4gDQo+ICAgICAgICANCg0Kc3VibWl0X3BhZ2Vfc2VjdGlvbigpIGRvZXMgY2FsbCBn
ZXRfcGFnZSgpIGluIHRoYXQgc2FtZSBwYXRoIA0KaXJyZXNwZWN0aXZlIG9mIHdoZXRoZXIgaXQg
aXMgWkVST19QQUdFKCkgb3Igbm90LCB0aGlzIGFjdHVhbGx5DQptYWtlcyBhY2NvdW50aW5nIG11
Y2ggZWFzaWVyIGFuZCB3ZSBhbHNvIGF2b2lkICBhbnkgc3BlY2lhbCBjYXNlDQpmb3IgWkVST19Q
QUdFKCkuDQoNCmRpb196ZXJvX2Jsb2NrKCkNCiAgc3VibWl0X3BhZ2Vfc2VjdGlvbigpDQogICAg
Z2V0X3BhZ2UoKQ0KDQoNClRoYXQgYWxzbyBtZWFucyB0aGF0IG9uIGNvbXBsZXRpb24gb2YgZGlv
IGZvciBlYWNoIGJpbyB3ZSBhbHNvIGNhbGwNCnB1dF9wYWdlKCkgZnJvbSBiaW9fcmVsZWFzZV9w
YWdlKCkgcGF0aC4NCg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBIb256YQ0KPiAtLQ0KPiBKYW4gS2FyYSA8amFja0BzdXNlLmNvbT4N
Cj4gU1VTRSBMYWJzLCBDUg0KPiANCg0K
