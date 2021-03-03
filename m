Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF99032C528
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378741AbhCDATZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:19:25 -0500
Received: from esa15.fujitsucc.c3s2.iphmx.com ([68.232.156.107]:12493 "EHLO
        esa15.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357545AbhCCKvl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:51:41 -0500
IronPort-SDR: 6x+xJWaC7pRv+9hIhuGr2c3J7i0si7DX7IAGONM9LfdolWkntM/ZFh6faHYVBV8nFEMWDnvKpz
 8R+9UAVKu9DZFPEtgJ+59xxTMb5z80H9ZoIycW0RIK8+HlmqexIbEd5oRRQCv0P7uwk0xCMftM
 dMxfQWpWxedWcrOIuFJiW2OXJsbBDP1fKRPF+H5LFPgnBLkO6e3q123xov5VcynEOxxfoRcPOB
 wOyPMRdnng6njP3T8n7n6OarqsMkq+tRPzaaJee81lxOJcVBJULM8MLysYgAwD5lSRpt+zpQs1
 Gg8=
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="27045987"
X-IronPort-AV: E=Sophos;i="5.81,219,1610377200"; 
   d="scan'208";a="27045987"
Received: from mail-ty1jpn01lp2057.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.57])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 18:57:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQ8qCvs9VGZce7RXIGO/HYPsT5G7x2hCaQmfiCRcX/KorgAc3IuDPXcEzdxxJY02Z3GqEDhbtkdUhiBuA8NyUCvVVmofIxEAYidk1xv9/jBLeSbOy3KDrEPbyRBL/7fyaUpwsO5JT0H2I24mlKay5I+0r7DwmurxgpFpcMaEf9gv+FYSEjexHjfvsai0BbbgFBASsyyLMOX+g3FLfiSNa95kLEqAMYUB0v1DUUW6tTgGmmLe74A8ryo6O5PcgpqqEEwpc9DEQ7+8ptCGrS8aFfKeAPVZpCllMwiNFr0eVLOiJ1cX1wHQubUabjG694epnAn57OXLasNo0jPB47dN7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKBmE+x9CyD3zaAexGZ0CUdqoTyyAG0+6Qsy/hgTmBA=;
 b=NvKPJDHPfQYeyt3Qgnamc3UMB1VtvKa3ya6JjmI+Mwj3D84uWMNhCu/Ayh3zb31JNNpRGW2Q9VLkyRk6EpuRJfnVSs9fiE1D4xiwLDGfRTulw4dY30LgN0cHaQJNDDYI4xH+SngURLZFYDU9RL0zcRfzaSKGv/FwKzxyvcu9oGF7Mr4MAf1N26HINuaqQ+0bsTG30z8WhdNPjDoVJggE8NEdi/fukuslIcYTG4W3uY0HphmzSm0BzAKOjEPghpHKv72w5Q9uyQ4ix8exhT4Ee1fvr2hnkSN/keO9pCKRpNZOlMywWzX/Z870hFR9E9Fwl7swQcmFA686grxBFQ/STw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKBmE+x9CyD3zaAexGZ0CUdqoTyyAG0+6Qsy/hgTmBA=;
 b=qcT380CkOnsBvyf/49J2zBVy1z2h7Z0G33Rll4oh18W/yXUG6cJczshPNDLlW8YiVErp3+j2JneGcNBGyPVz26/OQnjKoqkOnWespe17IFA8d8Pkm+OCOk8DS76fuJHl8W5nDpQWn5oYfoFyEUuFybZCwREnAT/V7GMliPqzLXw=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OSBPR01MB2823.jpnprd01.prod.outlook.com (2603:1096:604:1a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 09:57:48 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::7de7:2ce8:ffc0:d098]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::7de7:2ce8:ffc0:d098%7]) with mapi id 15.20.3890.028; Wed, 3 Mar 2021
 09:57:48 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "rgoldwyn@suse.de" <rgoldwyn@suse.de>
Subject: Re: [PATCH v2 09/10] fs/xfs: Handle CoW for fsdax write() path
Thread-Topic: [PATCH v2 09/10] fs/xfs: Handle CoW for fsdax write() path
Thread-Index: AQHXC9Vk3oCFfiQYI0S5UeFuOjPnZ6pyC5KAgAABpsU=
Date:   Wed, 3 Mar 2021 09:57:48 +0000
Message-ID: <OSBPR01MB2920500BEA2DF0D47885A8FDF4989@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <20210226002030.653855-10-ruansy.fnst@fujitsu.com>,<20210303094309.GB15389@lst.de>
In-Reply-To: <20210303094309.GB15389@lst.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [49.74.161.241]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b53e7b0c-1497-4f8c-7fb2-08d8de2acd60
x-ms-traffictypediagnostic: OSBPR01MB2823:
x-microsoft-antispam-prvs: <OSBPR01MB2823183F4E82A5C444EF5125F4989@OSBPR01MB2823.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x8m7uV0I6YSHA74LwyFd7fBAzHfKWRNhE543SLtrSxZNVRK5OQyveGZQn1IoTG/nV+xTuwYAj/s0MYXuvRpD7NAonm+YRbthqrzrCMCPp5wWVEXgM5h2wWt9w2vqa5gCG2amJzw12pZFzJEQqTzW1dismlaSXHt7Tp04hnB9nsySAu9fRpEAWyNVGosg75VBkyd7oJNJ/fTydDnstvhJ9mLdwJ1PTr16IWO1WbAeYKSFdvMmr1kfncSjB56FeJ9qBEXLM5xurU+M/SDdq1DEygegFQAnAqpuC92wv3moTvoLY7XevwtiyBtlQDOFTH6nHlVv7Ab/6v09aU6hi8DnsdVgORsQx5t0r3PhudGSXC01OQvlEOmWoH0z15FCuSRy3Gm8qcxEl8TaeJhtzpexxqKWl+zXZ2Ui2qfwRwc1g6qg0Y/Fx0Q1XBuebY0hk3WdrO/aLgarPW8C21kTDKWWl6X96ImfkPm92RcjCoSwZH3YcvDUMEwAi4S0RBrgusFD+yALo5hD/qlE4EbcozOxDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(316002)(7696005)(86362001)(85182001)(8676002)(33656002)(478600001)(6916009)(54906003)(55016002)(9686003)(7416002)(66556008)(5660300002)(52536014)(186003)(66946007)(76116006)(66476007)(2906002)(91956017)(8936002)(4326008)(71200400001)(83380400001)(26005)(66446008)(6506007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?RzVNVHVmN0k0Ky9HNWxYT3dwTDVMa0toTUtkR3ZBdWh6Nng2RGttbE4vR0xk?=
 =?gb2312?B?Sk5ybHAwa090dXd4YTdkaW8zZjluZHFMbC85N1lsZG5OWTdCcEhUdDRkaTdW?=
 =?gb2312?B?d1JlYVhQazU1VDhISDZ0eFg3RzZONWd3QlU0OWhwbEMwbExjWUgwd1RYc0V5?=
 =?gb2312?B?UHJML1lhUUtIZTA3ZG9leDhBcklZa1gzdFg5ZmdsNTZkN3BFN3pMTThhM3E2?=
 =?gb2312?B?S3I2TTUvK0lKTXFSRFlTbk9OVktHMnNOZFhlOUhZaVVqbUNyUE1NYTA3V2Qy?=
 =?gb2312?B?bjIzclo0Tk9GZ2o1cEdoV0VsMXlHTkhFYzZmU3lRK1VjUTVSaXZJMmJVak05?=
 =?gb2312?B?UGlsZ01zYWwyV1pUODJiOWUyYnBqM1B5UWVwYThteFF5N3gyOUExV3dMY0Vi?=
 =?gb2312?B?b3lzRXBPUEhMMGs2dEZSbENTdjlNVm11YmhXQU8vdTRhWlhzU0dwNDd1SXor?=
 =?gb2312?B?cGQwV1NpRVUwakdHTGROQm9JY0N6NTUxdlBJZnZUSjloSmVFNXpoVGpwTnZz?=
 =?gb2312?B?cVpKa1p0Z0FLaGlvVVZrMHhSUCtEMUZkcldUbjBtd0pQK1BBZVZad3R3dkVy?=
 =?gb2312?B?Yi9mSGxBTjBvb3lIYkU1bWovN0VIbS9ILzZ4SzN5YXNqcnFremErMWhWUlBG?=
 =?gb2312?B?RWFkTDRsQlpMZzFhcnFNaXZYdDFWc01wYUJHWVFjYmdGYlVzR05wMTN2cEJS?=
 =?gb2312?B?Z2FSellIZXdvQzR5bHJKOFFWVS9jVGZNYnJKMTJMSHl2Sm83bERKOCtlSy9t?=
 =?gb2312?B?dlRRVkt2bkhYTTZ2V1A4NFNaejVESXRac2M5NXpMK3l2WEJ0Skl6YjNwMUky?=
 =?gb2312?B?U3JxRnpHMW9ackRseVJNWkc0MmhBMEJ1dS9tSGFaQmVSTFJhQnNYMWQ0UUtr?=
 =?gb2312?B?SU1hZFI4by82N2JqTkVwSjk0SDFqZ3B2VUJRaWl5TWJSVmJHV25iT29mcURj?=
 =?gb2312?B?N05iR29jT1UwZzhXTnlsQ3U1bDNlekhWRkVDcjVvZVQzcHh4UE9WNTl6M3ZS?=
 =?gb2312?B?Z1ZXeDlvR3M4WDkwdHFsMmtxelJKdzh3NTdaVFcwK0FSb2tFL3cyQXJFeVdY?=
 =?gb2312?B?NzY4YkdPbnJjZC84aXRRdVUwWFVCbkcvRkxSZ2I0NEE1RllxZFVjZEcyYW5R?=
 =?gb2312?B?WVFra25CaXk3WnRmZFA0NlI0VEREczY5ZmZSYUVqSmxPNjdDS05YaVdQTG10?=
 =?gb2312?B?VjdPd0ZsWURMY214MWVsSXFYdzBGdk1JbFAwcmQwTFExZ0lGbTl0QU1LV2dr?=
 =?gb2312?B?Y0NoeGhvNFExZno0TnNRemluOXdPRWZJL1ZCWmZxQkZWK3V3Znk3a3NCZ1Qx?=
 =?gb2312?B?cE44NnV5ZFlYdGpGb3graERmQ3ZJblgxODFERHN1dlJ1OWV2VEpuQWZFa2FD?=
 =?gb2312?B?YWxDNmYrN3RTZndjKzRYUGJyUGZKeUpHQnRxVFNGSEtlRUlSTkxCYjdrb0lw?=
 =?gb2312?B?bnpnTXYvVXFIL0pnc0FrRGgrdmJPMUxISk1naUduWnlVYkFQT2xtZXZtNGlx?=
 =?gb2312?B?Rmo1NC82N1hLQUplNURoSzZ0NDA1UFdSai9ZU3gvQXVJYkJiR0IyK3RZMHJr?=
 =?gb2312?B?QU5nYmhNVTB2LzNXNHZkQnB2a0NOLzV0Z25oVEJwTmJrU2RYTnNHS1cvQU9Z?=
 =?gb2312?B?bFcxOHlPVUE3Mm84RjVzUnhBb0NudStVZTBaUlZyK2IzL3dkZFJ4b1V6Q2J2?=
 =?gb2312?B?aFB4L1FhMG91MXhtNFBndkZDNTJ0VitONDJtZWdRWElTSjA2SXZHa3kvQ09y?=
 =?gb2312?Q?ZgP4IO2WPnfgPElXuk=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b53e7b0c-1497-4f8c-7fb2-08d8de2acd60
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 09:57:48.8251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9mJ9Ip4nCq6qinztLEtVWMzw+X/KJl+BRTtDueg+guZ8VCn3WDIxnLkBO75Ed0FFQwQZB8S6RwHMwgsVPuPT8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2823
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiAKPiBPbiBGcmksIEZlYiAyNiwgMjAyMSBhdCAwODoyMDoyOUFNICswODAwLCBTaGl5YW5nIFJ1
YW4gd3JvdGU6Cj4gPiAgICAgICBlcnJvciA9IGlvbWFwX3plcm9fcmFuZ2UoVkZTX0koaXApLCBv
ZmZzZXQsIGxlbiwgTlVMTCwKPiA+IC0gICAgICAgICAgICAgICAgICAgICAmeGZzX2J1ZmZlcmVk
X3dyaXRlX2lvbWFwX29wcyk7Cj4gPiArICAgICAgICAgICAgICAgSVNfREFYKFZGU19JKGlwKSkg
Pwo+ID4gKyAgICAgICAgICAgICAgICZ4ZnNfZGF4X3dyaXRlX2lvbWFwX29wcyA6ICZ4ZnNfYnVm
ZmVyZWRfd3JpdGVfaW9tYXBfb3BzKTsKPiAKPiBQbGVhc2UgYWRkIGEgeGZzX3plcm9fcmFuZ2Ug
aGVscGVyIHRoYXQgcGlja3MgdGhlIHJpZ2h0IGlvbWFwX29wcwo+IGluc3RlYWQgb2Ygb3BlbiBj
b2RpbmcgdGhpcyBpbiBhIGZldyBwbGFjZXMuCgpPSy4gIEknbGwgYWRkIGl0Lgo+IAo+ID4gK3N0
YXRpYyBpbnQKPiA+ICt4ZnNfZGF4X3dyaXRlX2lvbWFwX2VuZCgKPiA+ICsgICAgIHN0cnVjdCBp
bm9kZSAgICAgICAgICAgICppbm9kZSwKPiA+ICsgICAgIGxvZmZfdCAgICAgICAgICAgICAgICAg
IHBvcywKPiA+ICsgICAgIGxvZmZfdCAgICAgICAgICAgICAgICAgIGxlbmd0aCwKPiA+ICsgICAg
IHNzaXplX3QgICAgICAgICAgICAgICAgIHdyaXR0ZW4sCj4gPiArICAgICB1bnNpZ25lZCBpbnQg
ICAgICAgICAgICBmbGFncywKPiA+ICsgICAgIHN0cnVjdCBpb21hcCAgICAgICAgICAgICppb21h
cCkKPiA+ICt7Cj4gPiArICAgICBpbnQgICAgICAgICAgICAgICAgICAgICBlcnJvciA9IDA7Cj4g
PiArICAgICB4ZnNfaW5vZGVfdCAgICAgICAgICAgICAqaXAgPSBYRlNfSShpbm9kZSk7Cj4gPiAr
Cj4gPiArICAgICBpZiAocG9zICsgd3JpdHRlbiA+IGlfc2l6ZV9yZWFkKGlub2RlKSkgewo+ID4g
KyAgICAgICAgICAgICBpX3NpemVfd3JpdGUoaW5vZGUsIHBvcyArIHdyaXR0ZW4pOwo+ID4gKyAg
ICAgICAgICAgICBlcnJvciA9IHhmc19zZXRmaWxlc2l6ZShpcCwgcG9zLCB3cml0dGVuKTsKPiA+
ICsgICAgIH0KPiA+ICsgICAgIGlmICh4ZnNfaXNfY293X2lub2RlKGlwKSkKPiA+ICsgICAgICAg
ICAgICAgZXJyb3IgPSB4ZnNfcmVmbGlua19lbmRfY293KGlwLCBwb3MsIHdyaXR0ZW4pOwo+ID4g
Kwo+ID4gKyAgICAgcmV0dXJuIGVycm9yOwo+IAo+IFdoYXQgaXMgdGhlIGFkdmFudGFnZSBvZiB0
aGUgaW9lbWFwX2VuZCBoYW5kbGVyIGhlcmU/ICBJdCBhZGRzIGFub3RoZXIKPiBpbmRpcmVjdCBm
dW50aW9uIGNhbGwgdG8gdGhlIGZhc3QgcGF0aCwgc28gaWYgd2UgY2FuIGF2b2lkIGl0LCBJJ2QK
PiByYXRoZXIgZG8gdGhhdC4KClRoZXNlIGNvZGUgd2VyZSBpbiB4ZnNfZmlsZV9kYXhfd3JpdGUo
KS4gIEkgbW92ZWQgdGhlbSBpbnRvIHRoZSBpb21hcF9lbmQKYmVjYXVzZSB0aGUgbW1hcGVkIENv
VyBuZWVkIHRoaXMuCgpJIGtub3cgdGhpcyBpcyBub3Qgc28gZ29vZCwgYnV0IEkgY291bGQgbm90
IGZpbmQgYW5vdGhlciBiZXR0ZXIgd2F5LiBEbyB5b3UKaGF2ZSBhbnkgaWRlYXM/IAoKPgo+IEFs
c28sIHNob3VsZG4ndCB3ZSBjYW5jZWwgdGhlIENPVyByYXRoZXIgdGhhbiBmaW5pc2hpbmcgaXQg
d2hlbiBzZXR0aW5nCj4gdGhlIGZpbGUgc2l6ZSBmYWlscz8KPiAKCkkgZGlkIGZvcmdldCBhYm91
dCB0aGlzIHBhcnQuICBUaGFua3MgZm9yIHBvaW50aW5nIG91dC4KCgotLQpUaGFua3MsClJ1YW4g
U2hpeWFuZy4=
