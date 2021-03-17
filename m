Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5EC033E7DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 04:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhCQDrH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 23:47:07 -0400
Received: from esa12.fujitsucc.c3s2.iphmx.com ([216.71.156.125]:42635 "EHLO
        esa12.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229510AbhCQDqd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 23:46:33 -0400
IronPort-SDR: AY2tRktzTmZelxYTOOGv95zO+YHc+MATujKJJHAPOsz1H1YCg36nRHwGE2ZF484D8DlLFFtTn+
 QxdZ1RRKQOj1JHeEaQWbCjsPtGaTxI7HgtCVJxmPZpuvfjwgNZuT9qVA6SI/7fph8jhUqKFxI8
 vEzrl1ApogsqgnEQZWi2+CnGxeUTyF24NigC2X5Ad8XQkWW+ssf8m40qV9GJrmw2l3/KOHY3pb
 obS6vGw/6cyJgssO5kkAuHfMEX1LZ2egd8e1GzkwZtgw49BquMw+EuF1FBvphTVwHzP/WKxKX0
 wxI=
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="28034617"
X-IronPort-AV: E=Sophos;i="5.81,254,1610377200"; 
   d="scan'208";a="28034617"
Received: from mail-ty1jpn01lp2051.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.51])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 12:46:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcNtrR0zO7BjsVrXueH1xu90WAEUR7DoH+NvQat2JeSi7UK9mlCCFhnWlDd5bdKFHMJt+UzPcnqJOIiLqMBYKOh6yDZ3ts6k9WVezQjxgpIbU4wsFkq0ERB+bPWCWNisJK7jQnnGL9mZV2QqU5WcQgkLDQEG8iCsFNemF2urqUCYHrJbFD7RNm+aFxMlT0kpmr3bXfMqzWAeybOFR6ZoP4fJbCgUphUGJDxppr92wWv1ZCcF7vqNNSAKyLsULy6cHJhO77obXpUX/wAnyuxEtCkMm6cm9vPFDLlg3rDCziqUKCrHPGV1orMe3P3inP0CgyfZdzyLDzHG1tf8eABfPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhSMWl6FANZM6f2NcHjyl62YSDgNpFvrRUlXwpXRu5M=;
 b=VleGJVXJCUPgNB6pxb6i/4Win9WyyI9zpmhy9lMx3LEHj+9oyaPRuu840uZUGiAlzJKlVq8c1cKjzF0YsZ40aXiyV9dda5PRQwe+1bG/KVRYlOgoH5MrElrnjy9So719vMqrRIsKz5/pHhWGNeyEdsiAD6CztMueSNGu4xodZfHXrVACkr1AHsfJsxYPxLle1ngOVVNEs4AlT6cA9flSUwXZS5R3a63jExhOzz53YdBqGlydqSFCV2kI8ICaRElcaQRX/Ii7NEjEWFVzQt1yLU3owTG/bC5cEgR3QRoYrHvCMJwQ3B7+h+Iv767lWu9dViHsepGELGnno4aJ35ca8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhSMWl6FANZM6f2NcHjyl62YSDgNpFvrRUlXwpXRu5M=;
 b=O6OMLHEasmkHkDhdPZ7tyL6nX+7j0wfsWiqPcrY6v2a7SpyAAcStYwbTqAg6hftHsG+D9/0BwHbblYEzfxX1X6KLoJdpqH/XgBzVL7ujAbc5vGTRhXlcdHJFpFNfnwOrgzbEHoXsN7nYaa6h8usPdEBbYZKjpvcFM5uOsBmETXs=
Received: from OSAPR01MB2913.jpnprd01.prod.outlook.com (2603:1096:603:3f::16)
 by OSYPR01MB5445.jpnprd01.prod.outlook.com (2603:1096:604:84::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 17 Mar
 2021 03:46:26 +0000
Received: from OSAPR01MB2913.jpnprd01.prod.outlook.com
 ([fe80::c447:a3af:7d9:f846]) by OSAPR01MB2913.jpnprd01.prod.outlook.com
 ([fe80::c447:a3af:7d9:f846%3]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 03:46:26 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     zhong jiang <zhongjiang-ali@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
CC:     "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "rgoldwyn@suse.de" <rgoldwyn@suse.de>,
        "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Subject: RE: [PATCH v3 05/11] mm, fsdax: Refactor memory-failure handler for
 dax mapping
Thread-Topic: [PATCH v3 05/11] mm, fsdax: Refactor memory-failure handler for
 dax mapping
Thread-Index: AQHW/gj8oXKCFpjX90yJ/yLnXTVuwqqGKuWAgAGHziA=
Date:   Wed, 17 Mar 2021 03:46:25 +0000
Message-ID: <OSAPR01MB2913D9A487C1D55171C5059EF46A9@OSAPR01MB2913.jpnprd01.prod.outlook.com>
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com>
 <20210208105530.3072869-6-ruansy.fnst@cn.fujitsu.com>
 <e1be1767-f9c0-e17a-5c14-22bb2f0ca5aa@linux.alibaba.com>
In-Reply-To: <e1be1767-f9c0-e17a-5c14-22bb2f0ca5aa@linux.alibaba.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=fujitsu.com;
x-originating-ip: [180.96.28.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89035986-5f36-4bb6-ee60-08d8e8f73d93
x-ms-traffictypediagnostic: OSYPR01MB5445:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSYPR01MB544586316A108FF9E8858AA3F46A9@OSYPR01MB5445.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DJgYhbJ97Gq/bvwKOpty3ZzeJ277RNw07ZprwQ71UIjRhht7uN6dTd1DcUfarUhoHe8TIjYVlpba3plT8eMP8CCVzZJ+O9DgJT6bxhGaqCiVkGjfoUJphR1r/1QTqOlyHWWCT+azaqXf9BGYHDJQvRHZO6twLdwvG0ZKSuIrSuGyxVzsnjDqVRYFuHXDxe7/vXNbogGEEPL+eyFVqIjniYovVdYpbOuBw6gEOE425UsqmfI8FL/A4gb1G5PNDT+B0Q6wrZQGEdMfECjmbcTiGhXLixG23GiN0DU2TVZPySQMqMN6yOG4JUg6IPYmgyvE5M5cazAAKDYK5PEOEU0goQo/Oq8OBbu9niQoq+5BZsBgvLgOR8FhKoMuHf/BUCTJyj5qMKGFmxp42l4YP2QlWnlprQU9VtRgZXN7HCjjYnRIjlJWIqV1zSL7FnMxhMVAHRWmMdlJ85OsqhTmf3mjaMBy9OpTW++v7zQIJmWJObfVkZvzOA6jZl/zIdndDHHSu7wpFGg61Vt9ui/OgjYVpdHh9w19rAbOZCP+mk2uwS7Iufb1wxwkLy2LdO1bg0/2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB2913.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(6506007)(7416002)(186003)(71200400001)(316002)(110136005)(66556008)(54906003)(85182001)(66476007)(7696005)(66446008)(64756008)(86362001)(4326008)(55016002)(52536014)(83380400001)(8936002)(107886003)(26005)(9686003)(478600001)(76116006)(33656002)(66946007)(5660300002)(8676002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MzRBSUtwSWl5cDFmWVArS3hSZkJvNEZvTVZIZlhEUXVmc2VYUXloREpwT0hm?=
 =?utf-8?B?R29kNkQrZDJ2Y21oV3pXTUtjengzZFlWL05paWxXNDNZMXRUQUs5ZERheDFE?=
 =?utf-8?B?MUhhUXN2RDlLSVZVeHFtY2o1bkVuellKRk00NjFJbTh1TGtPKzJ3bkFXRnRi?=
 =?utf-8?B?SXRMUzZicDB4K3lJNFc0cDZCa0xsUGQveW4yanBRYUpOejlsRFFITlBJNk5Q?=
 =?utf-8?B?RFdnWEk0R0pCNzREbE9KSytrYjM0MkxWSk8rcjY5c01yMzRIaC84WlVISFNP?=
 =?utf-8?B?d1k4ZXNieUhCUFdOamgwL0NMUjViVG9oUHFRcE1oQUFkRUo3Y1l2WW9qTysw?=
 =?utf-8?B?cGx0Sk5RZ0xndjhVaHlORjU5YWI4NFBVbjZ3V3F5Rlhjd000a3p3SkJRc0Jq?=
 =?utf-8?B?UHZXNm03VWFZWXNWcjIwT2d0eU1WUlkybktPbzltcmdLNi96a1NnWWJoU0NH?=
 =?utf-8?B?dkg1U2gwaDhSaUxNMEFWeS9UdnM5c28yb3o1S3BNcWV3enJpNXhjcWtTc0tP?=
 =?utf-8?B?SmlWV0Q3cEQ5Smh5aVNQdkRybWVENFFXQkt3ck42OHV2d21JbDFhWVN3MXpF?=
 =?utf-8?B?N3ZvN0hQb3NmUlR0Z0RSR3oyQ21xQ2FYNzgrZHV6SSt5WW53VTRtYXBFN2tL?=
 =?utf-8?B?RHp1OW0wT3RMRHFlNm95alQ2WDg4MUR4dWs4ME55T2k5RHdIRGFnTUNYVTBQ?=
 =?utf-8?B?c0YyM2Z4YURZMzdOUVZ2MFpnbHM4OVI4UWR4dzFGRm9NR3dhL0pseUN6RFhY?=
 =?utf-8?B?K3FRYndvbklLWURZTHpuNHhnR1FWUHc0NnNKK1YzZ211eFBZYlJtTjErVFJp?=
 =?utf-8?B?WHFLT2kxcjBmMnFiSlpYZ0pkUDRoczk4Sm92dVYwdVB4YlBiaGNRR2VJdm1J?=
 =?utf-8?B?L1JxZkJWOEw4QTdWSlNuNjhWejJTUm8rdDh5UVZ2OERXbFYzMW9ZQnBRMjJo?=
 =?utf-8?B?SC8xUVIxTEJLUTZrc1dyTG80SFp3RjZ5OEh5QUh1U0UweXEyeDhBajJRWjJV?=
 =?utf-8?B?ZERtTEdFd3haalNSRTZOU1NTaFVtR3MxcnB3L2RnRUd0clF3bDZta2toVkor?=
 =?utf-8?B?aTRtMG9jT1BwUnBnZysxTUtaZ09tRXBRc1QrTHlxczk4OFRqdjNycmRjRlA4?=
 =?utf-8?B?V0VmQXV5eHA2QWFFTXNyZU9BQjloOUY1UEUvM1RZVTVoS0lzWmp4cGZLbUQz?=
 =?utf-8?B?MHdGMUt3N21mdnlEYTZrU2ZFbFlpTHJNUjVSUlM4elRqMXBiazhCL0kwdWg3?=
 =?utf-8?B?VTFKSE02Vy9rTXA5SzZ6OVZPNmQxWmZrQm9kcndJck01bmFMNkdVSGcwdlNh?=
 =?utf-8?B?TkhjV2UyZ24yUVhJSWdKSy9vbldFSXZJVjhnSmw4bzRZMjY1b2EzL1R5TEE4?=
 =?utf-8?B?UVZrWmZEdW5SM1diM1htUEhyenM5TmNBVFhxaVl5bUYyUXVGNlRmTTZzUTd0?=
 =?utf-8?B?d1NzdzBYWmNreGZDRHVMazlEQkd3QzlEVE9EMkEwTU9wQUY0UTVyYUZxbE95?=
 =?utf-8?B?M1dQdUFxbGVKdndnbzZsYkpLVTJwS0V1M1pVZEJkdGZwanpHSW5ndXV2Vm9m?=
 =?utf-8?B?Zi9TQml4WnJpSjBONFN4NHJhMTlSWGhWNGdnYWpXK0UxNFdJSUYvTGJRaWhm?=
 =?utf-8?B?dGRFYWh0VzA5aWxGSGxuRnQrQ3BTeE10Wkh1YTZpYTZVUHdRRFlqbk1McG9C?=
 =?utf-8?B?WmdncnFsUDhvNUZJdnVXZm84am9QSmo1UE1FMk5uR2ZxenFNemVrUWtEdDlT?=
 =?utf-8?Q?cdLspVQhXufuSIHp1RFk9YiYyfehN2AlLwDyjdg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2913.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89035986-5f36-4bb6-ee60-08d8e8f73d93
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 03:46:25.9826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O3q7/T8OHRdZP7dVxFUxQjFog5+OAtHOXFrFPBKx1gNqjyC1rNb8WM51223zQJQahybz3n/lUwO1o5QS4qYKXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5445
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogemhvbmcgamlhbmcgPHpo
b25namlhbmctYWxpQGxpbnV4LmFsaWJhYmEuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYz
IDA1LzExXSBtbSwgZnNkYXg6IFJlZmFjdG9yIG1lbW9yeS1mYWlsdXJlIGhhbmRsZXIgZm9yDQo+
IGRheCBtYXBwaW5nDQo+IA0KPiA+ICtpbnQgbWZfZGF4X21hcHBpbmdfa2lsbF9wcm9jcyhzdHJ1
Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZywgcGdvZmZfdA0KPiA+ICtpbmRleCwgaW50IGZsYWdz
KSB7DQo+ID4gKwljb25zdCBib29sIHVubWFwX3N1Y2Nlc3MgPSB0cnVlOw0KPiA+ICsJdW5zaWdu
ZWQgbG9uZyBwZm4sIHNpemUgPSAwOw0KPiA+ICsJc3RydWN0IHRvX2tpbGwgKnRrOw0KPiA+ICsJ
TElTVF9IRUFEKHRvX2tpbGwpOw0KPiA+ICsJaW50IHJjID0gLUVCVVNZOw0KPiA+ICsJbG9mZl90
IHN0YXJ0Ow0KPiA+ICsNCj4gPiArCS8qIGxvYWQgdGhlIHBmbiBvZiB0aGUgZGF4IG1hcHBpbmcg
ZmlsZSAqLw0KPiA+ICsJcGZuID0gZGF4X2xvYWRfcGZuKG1hcHBpbmcsIGluZGV4KTsNCj4gPiAr
CWlmICghcGZuKQ0KPiA+ICsJCXJldHVybiByYzsNCj4gPiArCS8qDQo+ID4gKwkgKiBVbmxpa2Ug
U3lzdGVtLVJBTSB0aGVyZSBpcyBubyBwb3NzaWJpbGl0eSB0byBzd2FwIGluIGENCj4gPiArCSAq
IGRpZmZlcmVudCBwaHlzaWNhbCBwYWdlIGF0IGEgZ2l2ZW4gdmlydHVhbCBhZGRyZXNzLCBzbyBh
bGwNCj4gPiArCSAqIHVzZXJzcGFjZSBjb25zdW1wdGlvbiBvZiBaT05FX0RFVklDRSBtZW1vcnkg
bmVjZXNzaXRhdGVzDQo+ID4gKwkgKiBTSUdCVVMgKGkuZS4gTUZfTVVTVF9LSUxMKQ0KPiA+ICsJ
ICovDQo+ID4gKwlmbGFncyB8PSBNRl9BQ1RJT05fUkVRVUlSRUQgfCBNRl9NVVNUX0tJTEw7DQo+
IA0KPiBNRl9BQ1RJT05fUkVRVUlSRUQgb25seSBraWxsIHRoZSBjdXJyZW50IGV4ZWN1dGlvbiBj
b250ZXh0LiBBIHBhZ2UgY2FuIGJlDQo+IHNoYXJlZCB3aGVuIHJlZmxpbmsgZmlsZSBiZSBtYXBw
ZWQgYnkgZGlmZmVyZW50IHByb2Nlc3MuIFdlIGNhbiBub3Qga2lsbCBhbGwNCj4gcHJvY2VzcyBz
aGFyZWQgdGhlIHBhZ2UuICBPdGhlciBwcm9jZXNzIHN0aWxsIGNhbiBhY2Nlc3MgdGhlIHBvc2lv
bmVkIHBhZ2UgPw0KDQpBRkFJSywgdGhlIG90aGVyIHByb2Nlc3NlcyB3aWxsIHJlY2VpdmUgYSBT
SUdCVVMgd2hlbiBhY2Nlc3NpbmcgdGhpcyBjb3JydXB0ZWQgcmFuZ2UuICBCdXQgSSBkaWRuJ3Qg
YWRkIGEgdGVzdGNhc2UgZm9yIHRoaXMgY29uZGl0aW9uLiAgSSdsbCB0ZXN0IGl0LiAgVGhhbmtz
IGZvciBwb2ludGluZyBvdXQuDQoNCg0KLS0NClRoYW5rcywNClJ1YW4gU2hpeWFuZy4NCg0KPiAN
Cj4gVGhhbmtzLA0KPiB6aG9uZyBqaWFuZw0KPiANCj4gPiArCWNvbGxlY3RfcHJvY3NfZmlsZShw
Zm5fdG9fcGFnZShwZm4pLCBtYXBwaW5nLCBpbmRleCwgJnRvX2tpbGwsDQo+ID4gKwkJCSAgIGZs
YWdzICYgTUZfQUNUSU9OX1JFUVVJUkVEKTsNCj4gPiArDQo+ID4gKwlsaXN0X2Zvcl9lYWNoX2Vu
dHJ5KHRrLCAmdG9fa2lsbCwgbmQpDQo+ID4gKwkJaWYgKHRrLT5zaXplX3NoaWZ0KQ0KPiA+ICsJ
CQlzaXplID0gbWF4KHNpemUsIDFVTCA8PCB0ay0+c2l6ZV9zaGlmdCk7DQo+ID4gKwlpZiAoc2l6
ZSkgew0KPiA+ICsJCS8qDQo+ID4gKwkJICogVW5tYXAgdGhlIGxhcmdlc3QgbWFwcGluZyB0byBh
dm9pZCBicmVha2luZyB1cA0KPiA+ICsJCSAqIGRldmljZS1kYXggbWFwcGluZ3Mgd2hpY2ggYXJl
IGNvbnN0YW50IHNpemUuIFRoZQ0KPiA+ICsJCSAqIGFjdHVhbCBzaXplIG9mIHRoZSBtYXBwaW5n
IGJlaW5nIHRvcm4gZG93biBpcw0KPiA+ICsJCSAqIGNvbW11bmljYXRlZCBpbiBzaWdpbmZvLCBz
ZWUga2lsbF9wcm9jKCkNCj4gPiArCQkgKi8NCj4gPiArCQlzdGFydCA9IChpbmRleCA8PCBQQUdF
X1NISUZUKSAmIH4oc2l6ZSAtIDEpOw0KPiA+ICsJCXVubWFwX21hcHBpbmdfcmFuZ2UobWFwcGlu
Zywgc3RhcnQsIHN0YXJ0ICsgc2l6ZSwgMCk7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJa2lsbF9w
cm9jcygmdG9fa2lsbCwgZmxhZ3MgJiBNRl9NVVNUX0tJTEwsICF1bm1hcF9zdWNjZXNzLA0KPiA+
ICsJCSAgIHBmbiwgZmxhZ3MpOw0KPiA+ICsJcmMgPSAwOw0KPiA+ICsJcmV0dXJuIHJjOw0KPiA+
ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKG1mX2RheF9tYXBwaW5nX2tpbGxfcHJvY3MpOw0K
PiA+ICsNCj4gPiAgIHN0YXRpYyBpbnQgbWVtb3J5X2ZhaWx1cmVfaHVnZXRsYih1bnNpZ25lZCBs
b25nIHBmbiwgaW50IGZsYWdzKQ0KPiA+ICAgew0KPiA+ICAgCXN0cnVjdCBwYWdlICpwID0gcGZu
X3RvX3BhZ2UocGZuKTsNCj4gPiBAQCAtMTI5Nyw3ICsxMzQ2LDcgQEAgc3RhdGljIGludCBtZW1v
cnlfZmFpbHVyZV9kZXZfcGFnZW1hcCh1bnNpZ25lZA0KPiBsb25nIHBmbiwgaW50IGZsYWdzLA0K
PiA+ICAgCWNvbnN0IGJvb2wgdW5tYXBfc3VjY2VzcyA9IHRydWU7DQo+ID4gICAJdW5zaWduZWQg
bG9uZyBzaXplID0gMDsNCj4gPiAgIAlzdHJ1Y3QgdG9fa2lsbCAqdGs7DQo+ID4gLQlMSVNUX0hF
QUQodG9raWxsKTsNCj4gPiArCUxJU1RfSEVBRCh0b19raWxsKTsNCj4gPiAgIAlpbnQgcmMgPSAt
RUJVU1k7DQo+ID4gICAJbG9mZl90IHN0YXJ0Ow0KPiA+ICAgCWRheF9lbnRyeV90IGNvb2tpZTsN
Cj4gPiBAQCAtMTM0NSw5ICsxMzk0LDEwIEBAIHN0YXRpYyBpbnQNCj4gbWVtb3J5X2ZhaWx1cmVf
ZGV2X3BhZ2VtYXAodW5zaWduZWQgbG9uZyBwZm4sIGludCBmbGFncywNCj4gPiAgIAkgKiBTSUdC
VVMgKGkuZS4gTUZfTVVTVF9LSUxMKQ0KPiA+ICAgCSAqLw0KPiA+ICAgCWZsYWdzIHw9IE1GX0FD
VElPTl9SRVFVSVJFRCB8IE1GX01VU1RfS0lMTDsNCj4gPiAtCWNvbGxlY3RfcHJvY3MocGFnZSwg
JnRva2lsbCwgZmxhZ3MgJiBNRl9BQ1RJT05fUkVRVUlSRUQpOw0KPiA+ICsJY29sbGVjdF9wcm9j
c19maWxlKHBhZ2UsIHBhZ2UtPm1hcHBpbmcsIHBhZ2UtPmluZGV4LCAmdG9fa2lsbCwNCj4gPiAr
CQkJICAgZmxhZ3MgJiBNRl9BQ1RJT05fUkVRVUlSRUQpOw0KPiA+DQo+ID4gLQlsaXN0X2Zvcl9l
YWNoX2VudHJ5KHRrLCAmdG9raWxsLCBuZCkNCj4gPiArCWxpc3RfZm9yX2VhY2hfZW50cnkodGss
ICZ0b19raWxsLCBuZCkNCj4gPiAgIAkJaWYgKHRrLT5zaXplX3NoaWZ0KQ0KPiA+ICAgCQkJc2l6
ZSA9IG1heChzaXplLCAxVUwgPDwgdGstPnNpemVfc2hpZnQpOw0KPiA+ICAgCWlmIChzaXplKSB7
DQo+ID4gQEAgLTEzNjAsNyArMTQxMCw3IEBAIHN0YXRpYyBpbnQgbWVtb3J5X2ZhaWx1cmVfZGV2
X3BhZ2VtYXAodW5zaWduZWQNCj4gbG9uZyBwZm4sIGludCBmbGFncywNCj4gPiAgIAkJc3RhcnQg
PSAocGFnZS0+aW5kZXggPDwgUEFHRV9TSElGVCkgJiB+KHNpemUgLSAxKTsNCj4gPiAgIAkJdW5t
YXBfbWFwcGluZ19yYW5nZShwYWdlLT5tYXBwaW5nLCBzdGFydCwgc3RhcnQgKyBzaXplLCAwKTsN
Cj4gPiAgIAl9DQo+ID4gLQlraWxsX3Byb2NzKCZ0b2tpbGwsIGZsYWdzICYgTUZfTVVTVF9LSUxM
LCAhdW5tYXBfc3VjY2VzcywgcGZuLCBmbGFncyk7DQo+ID4gKwlraWxsX3Byb2NzKCZ0b19raWxs
LCBmbGFncyAmIE1GX01VU1RfS0lMTCwgIXVubWFwX3N1Y2Nlc3MsIHBmbiwNCj4gPiArZmxhZ3Mp
Ow0KPiA+ICAgCXJjID0gMDsNCj4gPiAgIHVubG9jazoNCj4gPiAgIAlkYXhfdW5sb2NrX3BhZ2Uo
cGFnZSwgY29va2llKTsNCj4gDQoNCg==
