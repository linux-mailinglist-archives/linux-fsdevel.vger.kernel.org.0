Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE36330687
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 04:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbhCHDpq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Mar 2021 22:45:46 -0500
Received: from esa2.fujitsucc.c3s2.iphmx.com ([68.232.152.246]:62602 "EHLO
        esa2.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233898AbhCHDph (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Mar 2021 22:45:37 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Mar 2021 22:45:36 EST
IronPort-SDR: H/hV0Tkx8RTH0Snb8FCcvcfcKVicJC6FyVLmB4JjiuEfT+WAPK6h1ipAIS2KxKR+sn2TYQheXf
 Z2h4ZN9CuyLJGdfYWEtMsnsLzmQLIXFPU+iP/+Gq/5lbyotRc9+zwdaTnJY+aehEfmVJ1k73il
 3zlLRok0XTT5ndApjeW+9StB3nWyJVdIXYUiwtWdLVKT1R4T7zLx/bxBJc2POdNlIrG1VT4J+z
 SN0opm9FkhxVxLe05b32uCiFOIQE0MVIFB5Xt3TGm/dJU5HoRtI+pMbHLDBRqJKw57KTGXF/84
 klQ=
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="35607024"
X-IronPort-AV: E=Sophos;i="5.81,231,1610377200"; 
   d="scan'208";a="35607024"
Received: from mail-os2jpn01lp2055.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.55])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 12:38:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nno42MreUxJQjbJ+K4KkGUpIDnVUALLuf2gnlt7p4CA2/9Mo5qii5A+sQ4eaXLn+zp41NZrMj81VzzeSW+v9tE9cn9bA/UWbItyfP4rHKT1ur7Q9X+gSD0gcZ1j37jG321uP0Sid+jX+kzsP3b/NT4zv/ZN6Z4dpVK874NP+oKUOeKWEqX3nx8nm85YDN4Tl+j6wTAOsau0DLfSXM9CqmB93teEzljZgyAZqfa3KMVrb/edWSCRn891JyoOT/s2VbAvhfZWyMovVuMm6dgkWzqHEeICWHMvdsuzz44DXNVuhI3Vgt9KT8C90uF5hV9XDPml8ehDa5MwFBaItZrilAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drJqISjTiVKRcv0otCdyH/ehFTK9ipTCRLB50U+HdWk=;
 b=oHHjP44bbc1dIzhuNA9hyEp3K8MzAQ/0+gKC/jf9F841v6+/HVhCFlDd8xxtL7ONiPimD2QbwpIN40wqx/WzvmRghbMCnqShXZKF3j5ENG9+nUfLt/08KcO4uSqqGCSdvjmWp0PEmQFiF+jyLRF11PCU6PH2xXuHjoavGRfHV2XyLxbmwVKobcLDx76an/J3KxhXF/G8Ekq4kfVWyvA7OwfQWuIuB8v6q7mahHq/BP70xzjmucAx9w5FB0hlO1pNOgcL12R/Gs42BQOHebtTlD2DWvyk0IvtYgfUl0AtngljOjDopZHcLNFsIBqQ7z09ZIkBXDjn8ZHNOhnKcpqZYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drJqISjTiVKRcv0otCdyH/ehFTK9ipTCRLB50U+HdWk=;
 b=B67FYMwRClBGcas65eHReK0N59hcj9Cls3h6435+X3WQ5m0fc+JIpPke9TAYuGPJLxQ+M5iQ5gCxVH6EqUaMcxIl7K95rlidXOXeOQ/8OEinIKV/h1yohxEo4cVUlR+79tJPklmm+dlHLcbZNOaDHVIn+l2WtBfGjFEntSEsHpQ=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OSBPR01MB3063.jpnprd01.prod.outlook.com (2603:1096:604:14::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 8 Mar
 2021 03:38:21 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::c482:fa93:9877:5063]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::c482:fa93:9877:5063%3]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 03:38:21 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        david <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Subject: Re: [PATCH v3 01/11] pagemap: Introduce ->memory_failure()
Thread-Topic: [PATCH v3 01/11] pagemap: Introduce ->memory_failure()
Thread-Index: AQHW/gjzAa5hnh6PaUq187fVBTbxkqp3lL+AgAIDAHQ=
Date:   Mon, 8 Mar 2021 03:38:21 +0000
Message-ID: <OSBPR01MB29207A1C06968705C2FEBACFF4939@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com>
 <20210208105530.3072869-2-ruansy.fnst@cn.fujitsu.com>,<CAPcyv4jqEdPoF5YM+jSYJd74KqRTwbbEum7=moa3=Wyn6UyU9g@mail.gmail.com>
In-Reply-To: <CAPcyv4jqEdPoF5YM+jSYJd74KqRTwbbEum7=moa3=Wyn6UyU9g@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [49.74.142.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89145445-ce53-4a24-fb1a-08d8e1e39efd
x-ms-traffictypediagnostic: OSBPR01MB3063:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB30634E86D05876482518D200F4939@OSBPR01MB3063.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xWqVxLYZCgGUV3torY93IL7K1W2JPbIASE5YIgoXK/O4zF26vcmuStKJcO9VThTYwlXddW4zRruAfhxgjiUwkCRm6gTGppUHkCBYPAMp4+nk6ip/gUX0QDZgMQ4H2QpAr+HeO+EHJvaQ+W8c0xnbq+oSXlFeQuGbeRVOC5OXSRpE7JYwOWVoS1IzpNRN/M4qms47yGljqAszGqVr14sWytzIp0/tf3Gu0wCz5w3BwpGDBfrF/dRQEiRoRaZ6uvqQO9J2tBXpsgQIy+kZJwLzUp0axPLYmBJwTjwRnw0bsZkuEi4ZqY9IK53aW5qTA39fQFSCO7qWfPv5Eiq7V3h26zCEvT4GsFArZ+PKpLugguHwdUFHEtWO7HhP0rMmrIaGSqyfM9/c83CkrfHIIYjJ/l0lvdAejCozgRufyZQ8aCnObCZZwDdU8Vj6QXOakKq0NT2yl8nNDFM1b9RZOw6zMGmoCV8d8MYSXTNh9Lz7y0TE9bxDGs0Mg4ApDK5sld8D3pl06MRwzSEIvFBYDcMOxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(91956017)(33656002)(8936002)(4326008)(86362001)(478600001)(52536014)(6916009)(66446008)(76116006)(7416002)(54906003)(71200400001)(55016002)(66556008)(8676002)(83380400001)(64756008)(53546011)(66946007)(66476007)(7696005)(107886003)(85182001)(2906002)(26005)(186003)(5660300002)(316002)(9686003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?UTdWSFVFbDM5QlY2Q25Ydk1hckRqUlBSVENjYlFIM2d3czhtZE1WbjB1cmZR?=
 =?gb2312?B?czdORWJaTFljU1U5b0g2bERtbTZiUWNuYXE4SjRHODBTZkFqVlpNbHVkcGtY?=
 =?gb2312?B?VTVkVDVESlQ0elZudlFSdkhhNVNQS0piRGlhdDBtK1FZY2JPbXVyVm5DN0tn?=
 =?gb2312?B?VTVUblA3N2FZRlN2bm1PU0d1cHdJR0toUXV1dDhPcnFEQ2VxWVVKM3BJMjUw?=
 =?gb2312?B?ZDNiRDR3Vis0cG9wS3Y5V3FFNy9EMXo5QjJ2WXozclFnMHdkbkpjYzgyVXZj?=
 =?gb2312?B?bUhqbFVYVG54QkRXVW5PMlB3TzRWbi94VGdTSWhoUXRhRnhOQWlsVmJoQVJn?=
 =?gb2312?B?YThZSzBOelVIVmU2QVZOOEMrOTd0VE5xZ1AvVE9SVGU2RExDVU9GNUJmdkg3?=
 =?gb2312?B?Rkh1OGxuelFudnVGUGQxZTZUUkl4Z2RCNERTWFljSzF2dWpSOWZZVWFSUkxl?=
 =?gb2312?B?Sjk4cnplK2pVNGlBdjJHUVUxR20wVUs3TXZNZTNyREFsamx5enltTm5TVE9C?=
 =?gb2312?B?d2NweitEZzZHazUvVnR5d1hsUCtjWlJxZlRBTm1wdnFpRGxMSTJHdmo1NE1D?=
 =?gb2312?B?ZVF2T3RYZEFYTmdTVWVvSkFPYUFGRVE2U25uT1JkaEJWbE00V2QvdDFqeWl3?=
 =?gb2312?B?bTNkT0ZWSlFjelJCMGlDYW9EUUF6SDNNamtYQjlBSk5LVDg4WHNSR0VBUFp6?=
 =?gb2312?B?a2F6a09ORFFuRUhqU1NYOWQvdGIwTzhlR2MyMmxjcm1LVUtqZFZnN0FJOVBl?=
 =?gb2312?B?S3o0S2d1QzNiS3prQlJxTlAvRTVTaHBkRE1tVEdzd1pRWFdDYnEwelA1ZXds?=
 =?gb2312?B?RFoyZEhpcGU3MHJWYVBFZ1AwaVlNZ1k3dTRBMHJubHZudlRiWVd0a2tHRExk?=
 =?gb2312?B?c1NHdE1mS0F0eFAzYnJwdGtGTXZlUlFyVVZkQVIzRldtM1pKajh4Z0RmdE5n?=
 =?gb2312?B?MEEzaTc1TGJoSDhHSjJXRjF0dU1jVjJna3o4TjZ2QW5BaldmazNyTXJEWTJj?=
 =?gb2312?B?MWVtd01RenNBN3ZMQmhnQjNZWUc1SGZDenBnMHc2eWtpR0lWZnV0T1ZXMHd6?=
 =?gb2312?B?MURqdkF2UWpSdzlBUjBtOTV2VUlkTVl2UTAwdnFwOGxhRmlyeTFNUTRaSTlW?=
 =?gb2312?B?WDM4RGY2d1lxVHlWK1VnMGorVzdqbUEwSW41Uk1xekFoOVh6ampnck5UdW1q?=
 =?gb2312?B?MWFDMFJDaXdDVDZWdzJ1TEE2VHZnTHZKTG5GYzRhb1FrdlI5aTBGMTZNaHJp?=
 =?gb2312?B?Nms1QlRrcDh5YTdHSmVNYUhrY2N6R3Z3T0hkT2tiNnNsZkplQmV3Ni92WVdM?=
 =?gb2312?B?bDlYeW9pQVo1WDgzTmpOTm9KSGFPb0MrT2QwMDlzc2RtWmpwRndZRFZlUGZY?=
 =?gb2312?B?WVplemVodXplaFNOdFN5U2FUanV4b3BqZW8yYk1JV2IyQTM4UVQ5SkFYZzgy?=
 =?gb2312?B?TFZmZkpnTnorMy9zaXFGcFpDQVZBRkhlYzRHZ1BZZE95SVEvS1pja3JaYkNi?=
 =?gb2312?B?VktHRWJRMy9uRFc1eENVeTNpeVVJNDJBVGc0bFo0TDJVRzVPRDV4d3NGaGEr?=
 =?gb2312?B?L0dPVmNvL1EreDFEK0JRSWhCdW1yTHZQNEl6SERqaUpLMU8valpwUGJiQTlz?=
 =?gb2312?B?N1ZkQ1NoR2JoWkZ2YXhvZ05kZEdWRFlLcUFQTW5PdXl6YmxhQTV6K0JQUTVr?=
 =?gb2312?B?NDNCbFVYdUpGblJaMWU5elUxdlhzR0ZQQVdDS1FVbjhJT2I2MzJkbjlGWjdk?=
 =?gb2312?Q?Ww7HIutj9JfdUZRldo=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89145445-ce53-4a24-fb1a-08d8e1e39efd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 03:38:21.3416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IZLP7UReXXhVhPijuXgAj5ZBb83+M4KIepnbBBJ/89kl4ymOfsQLvzDlc5c9M90Wa7jiIYcNs4e2Id2ssQxzDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3063
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBPbiBNb24sIEZlYiA4LCAyMDIxIGF0IDI6NTUgQU0gU2hpeWFuZyBSdWFuIDxydWFuc3kuZm5z
dEBjbi5mdWppdHN1LmNvbT4gd3JvdGU6Cj4gPgo+ID4gV2hlbiBtZW1vcnktZmFpbHVyZSBvY2N1
cnMsIHdlIGNhbGwgdGhpcyBmdW5jdGlvbiB3aGljaCBpcyBpbXBsZW1lbnRlZAo+ID4gYnkgZWFj
aCBraW5kIG9mIGRldmljZXMuICBGb3IgdGhlIGZzZGF4IGNhc2UsIHBtZW0gZGV2aWNlIGRyaXZl
cgo+ID4gaW1wbGVtZW50cyBpdC4gIFBtZW0gZGV2aWNlIGRyaXZlciB3aWxsIGZpbmQgb3V0IHRo
ZSBibG9jayBkZXZpY2Ugd2hlcmUKPiA+IHRoZSBlcnJvciBwYWdlIGxvY2F0ZXMgaW4sIGFuZCB0
cnkgdG8gZ2V0IHRoZSBmaWxlc3lzdGVtIG9uIHRoaXMgYmxvY2sKPiA+IGRldmljZS4gIEFuZCBm
aW5hbGx5IGNhbGwgZmlsZXN5c3RlbSBoYW5kbGVyIHRvIGRlYWwgd2l0aCB0aGUgZXJyb3IuCj4g
PiBUaGUgZmlsZXN5c3RlbSB3aWxsIHRyeSB0byByZWNvdmVyIHRoZSBjb3JydXB0ZWQgZGF0YSBp
ZiBwb3NzaWFibGUuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogU2hpeWFuZyBSdWFuIDxydWFuc3ku
Zm5zdEBjbi5mdWppdHN1LmNvbT4KPiA+IC0tLQo+ID4gIGluY2x1ZGUvbGludXgvbWVtcmVtYXAu
aCB8IDggKysrKysrKysKPiA+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspCj4gPgo+
ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbWVtcmVtYXAuaCBiL2luY2x1ZGUvbGludXgv
bWVtcmVtYXAuaAo+ID4gaW5kZXggNzljNDllN2Y1YzMwLi4wYmNmMmIxZTIwYmQgMTAwNjQ0Cj4g
PiAtLS0gYS9pbmNsdWRlL2xpbnV4L21lbXJlbWFwLmgKPiA+ICsrKyBiL2luY2x1ZGUvbGludXgv
bWVtcmVtYXAuaAo+ID4gQEAgLTg3LDYgKzg3LDE0IEBAIHN0cnVjdCBkZXZfcGFnZW1hcF9vcHMg
ewo+ID4gICAgICAgICAgKiB0aGUgcGFnZSBiYWNrIHRvIGEgQ1BVIGFjY2Vzc2libGUgcGFnZS4K
PiA+ICAgICAgICAgICovCj4gPiAgICAgICAgIHZtX2ZhdWx0X3QgKCptaWdyYXRlX3RvX3JhbSko
c3RydWN0IHZtX2ZhdWx0ICp2bWYpOwo+ID4gKwo+ID4gKyAgICAgICAvKgo+ID4gKyAgICAgICAg
KiBIYW5kbGUgdGhlIG1lbW9yeSBmYWlsdXJlIGhhcHBlbnMgb24gb25lIHBhZ2UuICBOb3RpZnkg
dGhlIHByb2Nlc3Nlcwo+ID4gKyAgICAgICAgKiB3aG8gYXJlIHVzaW5nIHRoaXMgcGFnZSwgYW5k
IHRyeSB0byByZWNvdmVyIHRoZSBkYXRhIG9uIHRoaXMgcGFnZQo+ID4gKyAgICAgICAgKiBpZiBu
ZWNlc3NhcnkuCj4gPiArICAgICAgICAqLwo+ID4gKyAgICAgICBpbnQgKCptZW1vcnlfZmFpbHVy
ZSkoc3RydWN0IGRldl9wYWdlbWFwICpwZ21hcCwgdW5zaWduZWQgbG9uZyBwZm4sCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgZmxhZ3MpOwo+ID4gIH07Cj4gCj4gQWZ0ZXIg
dGhlIGNvbnZlcnNhdGlvbiB3aXRoIERhdmUgSSBkb24ndCBzZWUgdGhlIHBvaW50IG9mIHRoaXMu
IElmCj4gdGhlcmUgaXMgYSBtZW1vcnlfZmFpbHVyZSgpIG9uIGEgcGFnZSwgd2h5IG5vdCBqdXN0
IGNhbGwKPiBtZW1vcnlfZmFpbHVyZSgpPyBUaGF0IGFscmVhZHkga25vd3MgaG93IHRvIGZpbmQg
dGhlIGlub2RlIGFuZCB0aGUKPiBmaWxlc3lzdGVtIGNhbiBiZSBub3RpZmllZCBmcm9tIHRoZXJl
LgoKV2Ugd2FudCBtZW1vcnlfZmFpbHVyZSgpIHN1cHBvcnRzIHJlZmxpbmtlZCBmaWxlcy4gIElu
IHRoaXMgY2FzZSwgd2UgYXJlIG5vdAphYmxlIHRvIHRyYWNrIG11bHRpcGxlIGZpbGVzIGZyb20g
YSBwYWdlKHRoaXMgYnJva2VuIHBhZ2UpIGJlY2F1c2UKcGFnZS0+bWFwcGluZyxwYWdlLT5pbmRl
eCBjYW4gb25seSB0cmFjayBvbmUgZmlsZS4gIFRodXMsIEkgaW50cm9kdWNlIHRoaXMKLT5tZW1v
cnlfZmFpbHVyZSgpIGltcGxlbWVudGVkIGluIHBtZW0gZHJpdmVyLCB0byBjYWxsIC0+Y29ycnVw
dGVkX3JhbmdlKCkKdXBwZXIgbGV2ZWwgdG8gdXBwZXIgbGV2ZWwsIGFuZCBmaW5hbGx5IGZpbmQg
b3V0IGZpbGVzIHdobyBhcmUKdXNpbmcobW1hcHBpbmcpIHRoaXMgcGFnZS4KCj4gCj4gQWx0aG91
Z2ggbWVtb3J5X2ZhaWx1cmUoKSBpcyBpbmVmZmljaWVudCBmb3IgbGFyZ2UgcmFuZ2UgZmFpbHVy
ZXMsIEknbQo+IG5vdCBzZWVpbmcgYSBiZXR0ZXIgb3B0aW9uLCBzbyBJJ20gZ29pbmcgdG8gdGVz
dCBjYWxsaW5nCj4gbWVtb3J5X2ZhaWx1cmUoKSBvdmVyIGEgbGFyZ2UgcmFuZ2Ugd2hlbmV2ZXIg
YW4gaW4tdXNlIGRheC1kZXZpY2UgaXMKPiBob3QtcmVtb3ZlZC4KPiAKCkkgZGlkIG5vdCB0ZXN0
IHRoaXMgZm9yIGxhcmdlIHJhbmdlIGZhaWx1cmUgeWV0Li4uICBJIGFtIG5vdCBzdXJlIGlmIGl0
IHdvcmtzCmZpbmUuIEJ1dCBiZWNhdXNlIG9mIHRoZSBjb21wbGV4IHRyYWNraW5nIG1ldGhvZCwg
SSB0aGluayBpdCB3b3VsZCBiZSBtb3JlCmluZWZmaWNpZW50IGluIHRoaXMgY2FzZSB0aGFuIGJl
Zm9yZS4KCgotLQpUaGFua3MsClJ1YW4gU2hpeWFuZy4=
