Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC853D1D8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 07:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhGVFBt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 01:01:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:8344 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229540AbhGVFBs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 01:01:48 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 16M5cD7L010195;
        Wed, 21 Jul 2021 22:42:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=JpoN9yW9V8KpS75guTMg7DmQMva6zgnkAg1L46KI8qE=;
 b=Oz04/g37h5qStsLcYA9xd/t7SKOguTZdfXzSfIJ1Ljm8EFIZhcXw4eeP+hJDe0wtcXiF
 L/Bq05+Uue9BIiZtGfHrqSOLod4Z2gmSceFPL5z5Q2ZVoyrnYSIYpv0uXBGmrAD5Vu4O
 RIeGmeWKla+YwwcNu/s1St8t9VuqRpKAA0E= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 39x1agjm1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 21 Jul 2021 22:42:02 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 21 Jul 2021 22:42:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4+sp2Ch2/6qMlbFCIk63KBDdaeISMFp2o03qYF0MqEuS47NDcRHlNgps7RQi5EnkcM8nmH+BDGsRmnJ/7v7mTx5dWpbRQa3rYTLFvb+WjQpO1AjepzbjDRWcVQm2NfQpHSY11qUJF9R1TYqeTBrnTOHHMhj5UnigilCFTyLZyAdzlCMTGJuTtAHJA7NOlbQcstMAn6OO4V0JgUrEO/GhyNSbDBMi7ISPHqLOU6twSVjnRkGdfBWm43XozYhXDocsHyX7ukWxtONRMetwkvY7l9pltnHdS2Vz1Cm0ZrfMlBixZPUnAeszwMv7HoZSbsYJ5ZYaEg562/CwH7KQx2HmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpoN9yW9V8KpS75guTMg7DmQMva6zgnkAg1L46KI8qE=;
 b=YZhxj+hTDRCuNCuGvclybjFZOFMROSvgVj/iZKWJCqcKXdY3KSC2c+/EZEZEuIPSl9JUXEL/0zozt2Uw+hBm/345iM1LT6k0n5cFtNieRl4Z61NNvKewpFoujoNNJUoMoLLid5bTjJ0zqURpxfD1CE6dA4ygpQ+O1+aidC+kYmLQSkfNnkFtCs4mEAyDZkwN1mEHI435kK25HNr9KrPqLP9aKOO5yxBH5sFB2r3vX36U/JL1qI6gi+fg5G7znSlr5kuzgkKwa46uknG6uAVjo31V57ngp22APY3ou78SdBXvtTvS65alh7pB9Mf1gysNAiFZj9tmjtVh/p2KA4FarQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2662.namprd15.prod.outlook.com (2603:10b6:a03:154::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Thu, 22 Jul
 2021 05:41:59 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7%6]) with mapi id 15.20.4331.034; Thu, 22 Jul 2021
 05:41:59 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Boyang Xue <bxue@redhat.com>
CC:     "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Patch 'writeback, cgroup: release dying cgwbs by switching
 attached inodes' leads to kernel crash
Thread-Topic: Patch 'writeback, cgroup: release dying cgwbs by switching
 attached inodes' leads to kernel crash
Thread-Index: AQHXeF9ZgqfbpxfNhUOOQYndGzIGsKtB3ASAgABMLICAAAvDgIAAdC4AgACrRoCAABVVAIAA3z0AgAAxkoCAACcaAIABLHsAgAA9j4CAAQtNAIAHbjyAgAADndQ=
Date:   Thu, 22 Jul 2021 05:41:59 +0000
Message-ID: <B55400D4-809F-4D88-8561-6843553B2727@fb.com>
References: <YO5kCzI133B/fHiS@carbon.dhcp.thefacebook.com>
 <CAHLe9YYiNnbyYGHoArJxvCEsqaqt2rwp5OHCSy+gWH+D8OFLQA@mail.gmail.com>
 <20210714092639.GB9457@quack2.suse.cz>
 <CAHLe9YbKXcF1mkSeK0Fo7wAUN02-_LfLD+2hdmVMJY_-gNq=-A@mail.gmail.com>
 <YO+e8UrCbzp2pfvj@casper.infradead.org>
 <CAHLe9YZnLGnJp-8RpkUCHDrH=5Vrj-8-t5Yf0y_w0Sf6zhNfTQ@mail.gmail.com>
 <20210715171050.GB22357@magnolia>
 <YPCVrwov6R9yaBcG@carbon.dhcp.thefacebook.com>
 <20210715222812.GW22357@magnolia> <20210716162340.GY22357@magnolia>
 <YPHmLwF09QCPB7tw@carbon.dhcp.thefacebook.com>
 <CAHLe9YZLrYJvuXBiZvu0BLVth0Cuxw4Ja1DKgyH0Q43-V62AsA@mail.gmail.com>,<CAHLe9YZ0GC30Cunw+j2ejqtYekacRHgiS+KLxTefAkcV=MpfDw@mail.gmail.com>
In-Reply-To: <CAHLe9YZ0GC30Cunw+j2ejqtYekacRHgiS+KLxTefAkcV=MpfDw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7e1d057-cb82-4da2-4b74-08d94cd36cdd
x-ms-traffictypediagnostic: BYAPR15MB2662:
x-microsoft-antispam-prvs: <BYAPR15MB266208C5AC9E9411646B1187BEE49@BYAPR15MB2662.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /lksAyiwmr9mHDMk9MZ5ASD+OfleFFQ9Yw3Co+Qb1HxB0tQ/KXjyvgiK/THCLNVkDt3xkW94cqzEGhGcMXf8/wQNwHpV/28bY87CYK3ovqGYFoos5l28fgiHNS/vqOThM3CdSbTpgDsWxTl6VuSFStTaFEWOAU4GJoQCbpXA2zck5wqsaRIEBPPNfS0oJlOMcBKowzkCOCeUN+Rmy0h2vYhCtNeM9bIvArQp4UzNiDYgb1GgxIzDvifkL7tNhsc1QMB/wyYdVC5+56g5y6uRGY+2z3he8cAX3q5oNw6knxYvFfnDfEQcJOq+4SA+QFcoSlCuTGs3zk99NdJyQvraQ6Du1kElRxiyY+SkdM7BBaRDBkz0WJksizAoorkPLJWQQJx6XyIUMCOBOJqMREeVnrkPttx2F0pEaKMGI3avZS/RNr9D4F9dcamvR50rmilO2JHucmLrX+yoNNa3A7qkt7v8OYuLC7cltlVcyc4Zix5vUnQJaCSmy5bR33oVJlzW095uvJCayw9hqzYCkDBBErwbNYyNoWWOOAXXms/eD85o3cCk6JUN3AjywN+g+TEBlpLGbmIqbSgygrDlqXD9x8fj2WGczEwPaU2teQMap1nvshutO+mfOvST7Poy2KQz4ZBypKoDNCLNPhH1fTrvBtAzLgrUz7Q6EPXHut8Q/F2tWV1qBdEZhfFK19x1IPgzpyWn8L0AyvVzW60AG7kK5GzlTQ1naavp1QmDZqZKZoA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(66476007)(71200400001)(4326008)(64756008)(66556008)(66946007)(76116006)(83380400001)(6486002)(5660300002)(36756003)(33656002)(6506007)(66446008)(478600001)(2906002)(8936002)(86362001)(2616005)(6916009)(54906003)(122000001)(8676002)(53546011)(316002)(186003)(6512007)(38100700002)(45980500001)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RENuTmh0WUUzNkJlM0JPTGtIblJnNURUWnVFVERWZThMekpOTWZjY1ROeFI1?=
 =?utf-8?B?WUZDb2NHRkd0aVUweGw5L1FiY0E4ZTJCdWgwc1dkQWl6QUNOV0dMaC8vWFRn?=
 =?utf-8?B?VDNFWFZPSlREOU9odnQ4SnUvajdmYVFwd3VTRmF0a1BnV1prS2IyZlNKZDBq?=
 =?utf-8?B?MGFhVUlLRnFtNUdiQ1hrcXFhS1JpajhXbTBHUHh2S2orc0Y1bktod1ZQbEp1?=
 =?utf-8?B?SGQ3Tkp0czBwbWpwUWxPWXFVSnk2aXpkQ2l0NFZPZDViSWhjU3Q3UW0vemFl?=
 =?utf-8?B?Nmc4K1hvSmVJMCs1SHdMRzIzaEJWR0R2UGhOZG5oZDRDRzV1YmRqUDZnSmFs?=
 =?utf-8?B?ZG1lTkF3bVdBb2N4UEF0dExxUlpjbmZ4RCsrZ2NwbmI3UFFqdHNJNWZMakVP?=
 =?utf-8?B?cEFwSXJYaUJPdmc3bDA5ZDZ4TVF6NkNucitGb3hzREZGNXRkcTlGM0VTeERy?=
 =?utf-8?B?ZVBMMU5XL3Y3L0g2TzFtK1VnN2EvQmJDUjBvcURRTWZaTTE4ekY5Zkk3ZHND?=
 =?utf-8?B?RUlYMjBmYTdzQllnZkEvOUxmZmRIL3UrV21hUVFsNGVsUEg2b3NwQUErZWVX?=
 =?utf-8?B?cHJnOWt1Z3BDUzMramR4VCt5ZzRBcWduMWVwTjdROHo5RXArQWhyT2pMcFhM?=
 =?utf-8?B?dk41ZGNTWG9TQktWaCtVa3BVYUpoVUdYSmJBeDhYS1ZaclQ1UkNGSk9Mc1BI?=
 =?utf-8?B?NlJva1dGeEYyK1JTa3FtTHNxc3k1R0pISDRiWXp6SktvMjlrMmRFUzNpdFVT?=
 =?utf-8?B?MEtsYVAzczBnM0swelZpdU5OZnVmU24wUkEyVXl3MGpMV0JpenBmNjNiU0c2?=
 =?utf-8?B?Q3lHKzZvb01GRFlTdDNENW1ja0tVVlVaN1hQcVBnVHFsWVdselc3NEZoVEcr?=
 =?utf-8?B?MEF0M3BtekRRVUk1dE4xOVpTbzhnVVlGS3NOUUhaVitlVk85TUdYeXJQalZj?=
 =?utf-8?B?QTc3cmo5ZDhndEtrdzZ4c3IzQjdFeWhuYXp1cVNZeDYxWkI4MHVnK2tyVjVr?=
 =?utf-8?B?K1VOemw3WlZ5MEgxdDhoaGREZW9PK2JvK2lreWtrdnVJdTA2R1J2VE9ZMGJT?=
 =?utf-8?B?ODIvbTgwUU5lRE1rMU51Q251a2hYZTNVMHNITHluSndBcHk5dk5udFRRRXN3?=
 =?utf-8?B?MVBLb2pDL25OcXJtck8vTkdqbUdoTlpTaml0NzdlVytGVjZ2a3ZERWFuY09o?=
 =?utf-8?B?c0tFOUUxcXpvYmdhdTJobDBSU2JjUjR3a2IvNGJTWFZrOEJyWEtTaDZrRWcv?=
 =?utf-8?B?VmgvdDY1Mm1ObGZ3elpvT1ZjS0tmTGxISHNLdjQ2MkplcmxVbWhqdFhMV2hU?=
 =?utf-8?B?ZTdWNmI2cGJTbUNlRFVUWHFrVW9QSHF2MlI3T0pDL0dRbEJFdmNOV29Sd3Bz?=
 =?utf-8?B?QjNNeGE4Nlc4ZDBZYkRIRk1tTExvbVVydlpxTWZ6MUNiUll3TXE2bzlCR0dm?=
 =?utf-8?B?bkxPY29BU25IWnB4ejFOV2ZTRFlTaUNxT1BMQkJ0Zm02OStWckpocFdMNXVi?=
 =?utf-8?B?TGl5aC9DaXA3eGhKTitIYnFqTHpCTlpXb3BOTHpKeldmaHJaVUh4QlVyMytH?=
 =?utf-8?B?eEN1aVM3emV6ZUNsTHhaQVhrTG5nZzdlYUJLN2lrVmtoOWovcS9hMmtzMUxL?=
 =?utf-8?B?dFNVRjlEOWkwWnNMNkd2MDhHK2JMR2xaTVJSc0JnTWtkQ0F6eTVvQzZaMDI3?=
 =?utf-8?B?bnJMZ3BtcE1ZL1FPajhmMDdkTGp5SWFQRmhsbi9CdEFYNG45NC84dFA3Tm5Z?=
 =?utf-8?B?RXlIZERzVDdDeDlzZXVqd2tMNXk4dWpFeHlpVWQyUFg0a3dUMnA1RzVITE9M?=
 =?utf-8?B?aThIelMvdlBZRlRuZGZwTEl6MFIyQ3YzYTBIU2JnSjhXQkxKSE1CdmZ5a1JM?=
 =?utf-8?Q?Jk5YY71o8m71m?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e1d057-cb82-4da2-4b74-08d94cd36cdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2021 05:41:59.6938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9sppQqx/uxVi4DLqOzXXHeWVPF6IyKolgHY6BIxnTTkP2vsztexEpgTs/8EnuMD8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2662
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: utKD6VdOwUgf5gvAJHZcsF1WvuOOr0_3
X-Proofpoint-GUID: utKD6VdOwUgf5gvAJHZcsF1WvuOOr0_3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-22_01:2021-07-22,2021-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107220032
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

VGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgdGVzdGluZyBpdCENCg0KU2VudCBmcm9tIG15IGlQaG9u
ZQ0KDQo+IE9uIEp1bCAyMSwgMjAyMSwgYXQgMjI6MjksIEJveWFuZyBYdWUgPGJ4dWVAcmVkaGF0
LmNvbT4gd3JvdGU6DQo+IA0KPiDvu79KdXN0IEZZSSwgdGhlIHRlc3RzIG9uIHBwYzY0bGUgYXJl
IGRvbmUsIG5vIGxvbmdlciBrZXJuZWwgcGFuaWMsIHNvIG15DQo+IHRlc3RzIG9uIGFsbCBhcmNo
ZXMgYXJlIGZpbmUgbm93Lg0KPiANCj4+IE9uIFNhdCwgSnVsIDE3LCAyMDIxIGF0IDg6MDAgUE0g
Qm95YW5nIFh1ZSA8Ynh1ZUByZWRoYXQuY29tPiB3cm90ZToNCj4+IA0KPj4gVGVzdGluZyBmc3Rl
c3RzIG9uIGFhcmNoNjQsIHg4Nl82NCwgczM5MHggYWxsIHBhc3NlZC4gVGhlcmUncyBhDQo+PiBz
aG9ydGFnZSBvZiBwcGM2NGxlIHN5c3RlbXMsIHNvIEkgY2FuJ3QgcHJvdmlkZSB0aGUgcHBjNjRs
ZSB0ZXN0DQo+PiByZXN1bHQgZm9yIG5vdywgYnV0IEkgaG9wZSBJIGNhbiByZXBvcnQgdGhlIHJl
c3VsdCBuZXh0IHdlZWsuDQo+PiANCj4+IFRoYW5rcywNCj4+IEJveWFuZw0KPj4gDQo+Pj4gT24g
U2F0LCBKdWwgMTcsIDIwMjEgYXQgNDowNCBBTSBSb21hbiBHdXNoY2hpbiA8Z3Vyb0BmYi5jb20+
IHdyb3RlOg0KPj4+IA0KPj4+IE9uIEZyaSwgSnVsIDE2LCAyMDIxIGF0IDA5OjIzOjQwQU0gLTA3
MDAsIERhcnJpY2sgSi4gV29uZyB3cm90ZToNCj4+Pj4gT24gVGh1LCBKdWwgMTUsIDIwMjEgYXQg
MDM6Mjg6MTJQTSAtMDcwMCwgRGFycmljayBKLiBXb25nIHdyb3RlOg0KPj4+Pj4gT24gVGh1LCBK
dWwgMTUsIDIwMjEgYXQgMDE6MDg6MTVQTSAtMDcwMCwgUm9tYW4gR3VzaGNoaW4gd3JvdGU6DQo+
Pj4+Pj4gT24gVGh1LCBKdWwgMTUsIDIwMjEgYXQgMTA6MTA6NTBBTSAtMDcwMCwgRGFycmljayBK
LiBXb25nIHdyb3RlOg0KPj4+Pj4+PiBPbiBUaHUsIEp1bCAxNSwgMjAyMSBhdCAxMTo1MTo1MEFN
ICswODAwLCBCb3lhbmcgWHVlIHdyb3RlOg0KPj4+Pj4+Pj4gT24gVGh1LCBKdWwgMTUsIDIwMjEg
YXQgMTA6MzYgQU0gTWF0dGhldyBXaWxjb3ggPHdpbGx5QGluZnJhZGVhZC5vcmc+IHdyb3RlOg0K
Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+IE9uIFRodSwgSnVsIDE1LCAyMDIxIGF0IDEyOjIyOjI4QU0g
KzA4MDAsIEJveWFuZyBYdWUgd3JvdGU6DQo+Pj4+Pj4+Pj4+IEl0J3MgdW5jbGVhciB0byBtZSB0
aGF0IHdoZXJlIHRvIGZpbmQgdGhlIHJlcXVpcmVkIGFkZHJlc3MgaW4gdGhlDQo+Pj4+Pj4+Pj4+
IGFkZHIybGluZSBjb21tYW5kIGxpbmUsIGkuZS4NCj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+IGFk
ZHIybGluZSAtZSAvdXNyL2xpYi9kZWJ1Zy9saWIvbW9kdWxlcy81LjE0LjAtMC5yYzEuMTUuYngu
ZWw5LmFhcmNoNjQvdm1saW51eA0KPj4+Pj4+Pj4+PiA8d2hhdCBhZGRyZXNzIGhlcmU/Pg0KPj4+
Pj4+Pj4+IA0KPj4+Pj4+Pj4+IC4vc2NyaXB0cy9mYWRkcjJsaW5lIC91c3IvbGliL2RlYnVnL2xp
Yi9tb2R1bGVzLzUuMTQuMC0wLnJjMS4xNS5ieC5lbDkuYWFyY2g2NC92bWxpbnV4IGNsZWFudXBf
b2ZmbGluZV9jZ3dic193b3JrZm4rMHgzMjAvMHgzOTQNCj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+IA0K
Pj4+Pj4+Pj4gVGhhbmtzISBUaGUgcmVzdWx0IGlzIHRoZSBzYW1lIGFzIHRoZQ0KPj4+Pj4+Pj4g
DQo+Pj4+Pj4+PiBhZGRyMmxpbmUgLWkgLWUNCj4+Pj4+Pj4+IC91c3IvbGliL2RlYnVnL2xpYi9t
b2R1bGVzLzUuMTQuMC0wLnJjMS4xNS5ieC5lbDkuYWFyY2g2NC92bWxpbnV4DQo+Pj4+Pj4+PiBG
RkZGODAwMDEwMkQ2REQwDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IEJ1dCB0aGlzIHNjcmlwdCBpcyB2
ZXJ5IGhhbmR5Lg0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiAjIC91c3Ivc3JjL2tlcm5lbHMvNS4xNC4w
LTAucmMxLjE1LmJ4LmVsOS5hYXJjaDY0L3NjcmlwdHMvZmFkZHIybGluZQ0KPj4+Pj4+Pj4gL3Vz
ci9saWIvZGVidWcvbGliL21vZHVsZXMvNS4xNC4wLTAucmMxLjE1LmJ4LmVsOS5hYXJjaDY0L3Zt
bGludXgNCj4+Pj4+Pj4+IGNsZWFudXBfb2ZmbGluDQo+Pj4+Pj4+PiBlX2Nnd2JzX3dvcmtmbisw
eDMyMC8weDM5NA0KPj4+Pj4+Pj4gY2xlYW51cF9vZmZsaW5lX2Nnd2JzX3dvcmtmbisweDMyMC8w
eDM5NDoNCj4+Pj4+Pj4+IGFyY2hfYXRvbWljNjRfZmV0Y2hfYWRkX3VubGVzcyBhdA0KPj4+Pj4+
Pj4gL3Vzci9zcmMvZGVidWcva2VybmVsLTUuMTQuMC0wLnJjMS4xNS5ieC9saW51eC01LjE0LjAt
MC5yYzEuMTUuYnguZWw5LmFhcmNoNjQvLi9pbmNsdWRlL2xpbnV4L2F0b21pYy1hcmNoLWZhbGxi
YWNrLmg6MjI2NQ0KPj4+Pj4+Pj4gKGlubGluZWQgYnkpIGFyY2hfYXRvbWljNjRfYWRkX3VubGVz
cyBhdA0KPj4+Pj4+Pj4gL3Vzci9zcmMvZGVidWcva2VybmVsLTUuMTQuMC0wLnJjMS4xNS5ieC9s
aW51eC01LjE0LjAtMC5yYzEuMTUuYnguZWw5LmFhcmNoNjQvLi9pbmNsdWRlL2xpbnV4L2F0b21p
Yy1hcmNoLWZhbGxiYWNrLmg6MjI5MA0KPj4+Pj4+Pj4gKGlubGluZWQgYnkpIGF0b21pYzY0X2Fk
ZF91bmxlc3MgYXQNCj4+Pj4+Pj4+IC91c3Ivc3JjL2RlYnVnL2tlcm5lbC01LjE0LjAtMC5yYzEu
MTUuYngvbGludXgtNS4xNC4wLTAucmMxLjE1LmJ4LmVsOS5hYXJjaDY0Ly4vaW5jbHVkZS9hc20t
Z2VuZXJpYy9hdG9taWMtaW5zdHJ1bWVudGVkLmg6MTE0OQ0KPj4+Pj4+Pj4gKGlubGluZWQgYnkp
IGF0b21pY19sb25nX2FkZF91bmxlc3MgYXQNCj4+Pj4+Pj4+IC91c3Ivc3JjL2RlYnVnL2tlcm5l
bC01LjE0LjAtMC5yYzEuMTUuYngvbGludXgtNS4xNC4wLTAucmMxLjE1LmJ4LmVsOS5hYXJjaDY0
Ly4vaW5jbHVkZS9hc20tZ2VuZXJpYy9hdG9taWMtbG9uZy5oOjQ5MQ0KPj4+Pj4+Pj4gKGlubGlu
ZWQgYnkpIHBlcmNwdV9yZWZfdHJ5Z2V0X21hbnkgYXQNCj4+Pj4+Pj4+IC91c3Ivc3JjL2RlYnVn
L2tlcm5lbC01LjE0LjAtMC5yYzEuMTUuYngvbGludXgtNS4xNC4wLTAucmMxLjE1LmJ4LmVsOS5h
YXJjaDY0Ly4vaW5jbHVkZS9saW51eC9wZXJjcHUtcmVmY291bnQuaDoyNDcNCj4+Pj4+Pj4+IChp
bmxpbmVkIGJ5KSBwZXJjcHVfcmVmX3RyeWdldCBhdA0KPj4+Pj4+Pj4gL3Vzci9zcmMvZGVidWcv
a2VybmVsLTUuMTQuMC0wLnJjMS4xNS5ieC9saW51eC01LjE0LjAtMC5yYzEuMTUuYnguZWw5LmFh
cmNoNjQvLi9pbmNsdWRlL2xpbnV4L3BlcmNwdS1yZWZjb3VudC5oOjI2Ng0KPj4+Pj4+Pj4gKGlu
bGluZWQgYnkpIHdiX3RyeWdldCBhdA0KPj4+Pj4+Pj4gL3Vzci9zcmMvZGVidWcva2VybmVsLTUu
MTQuMC0wLnJjMS4xNS5ieC9saW51eC01LjE0LjAtMC5yYzEuMTUuYnguZWw5LmFhcmNoNjQvLi9p
bmNsdWRlL2xpbnV4L2JhY2tpbmctZGV2LWRlZnMuaDoyMjcNCj4+Pj4+Pj4+IChpbmxpbmVkIGJ5
KSB3Yl90cnlnZXQgYXQNCj4+Pj4+Pj4+IC91c3Ivc3JjL2RlYnVnL2tlcm5lbC01LjE0LjAtMC5y
YzEuMTUuYngvbGludXgtNS4xNC4wLTAucmMxLjE1LmJ4LmVsOS5hYXJjaDY0Ly4vaW5jbHVkZS9s
aW51eC9iYWNraW5nLWRldi1kZWZzLmg6MjI0DQo+Pj4+Pj4+PiAoaW5saW5lZCBieSkgY2xlYW51
cF9vZmZsaW5lX2Nnd2JzX3dvcmtmbiBhdA0KPj4+Pj4+Pj4gL3Vzci9zcmMvZGVidWcva2VybmVs
LTUuMTQuMC0wLnJjMS4xNS5ieC9saW51eC01LjE0LjAtMC5yYzEuMTUuYnguZWw5LmFhcmNoNjQv
bW0vYmFja2luZy1kZXYuYzo2NzkNCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gIyB2aSAvdXNyL3NyYy9k
ZWJ1Zy9rZXJuZWwtNS4xNC4wLTAucmMxLjE1LmJ4L2xpbnV4LTUuMTQuMC0wLnJjMS4xNS5ieC5l
bDkuYWFyY2g2NC9tbS9iYWNraW5nLWRldi5jDQo+Pj4+Pj4+PiBgYGANCj4+Pj4+Pj4+IHN0YXRp
YyB2b2lkIGNsZWFudXBfb2ZmbGluZV9jZ3dic193b3JrZm4oc3RydWN0IHdvcmtfc3RydWN0ICp3
b3JrKQ0KPj4+Pj4+Pj4gew0KPj4+Pj4+Pj4gICAgICAgIHN0cnVjdCBiZGlfd3JpdGViYWNrICp3
YjsNCj4+Pj4+Pj4+ICAgICAgICBMSVNUX0hFQUQocHJvY2Vzc2VkKTsNCj4+Pj4+Pj4+IA0KPj4+
Pj4+Pj4gICAgICAgIHNwaW5fbG9ja19pcnEoJmNnd2JfbG9jayk7DQo+Pj4+Pj4+PiANCj4+Pj4+
Pj4+ICAgICAgICB3aGlsZSAoIWxpc3RfZW1wdHkoJm9mZmxpbmVfY2d3YnMpKSB7DQo+Pj4+Pj4+
PiAgICAgICAgICAgICAgICB3YiA9IGxpc3RfZmlyc3RfZW50cnkoJm9mZmxpbmVfY2d3YnMsIHN0
cnVjdCBiZGlfd3JpdGViYWNrLA0KPj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIG9mZmxpbmVfbm9kZSk7DQo+Pj4+Pj4+PiAgICAgICAgICAgICAgICBsaXN0X21v
dmUoJndiLT5vZmZsaW5lX25vZGUsICZwcm9jZXNzZWQpOw0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiAg
ICAgICAgICAgICAgICAvKg0KPj4+Pj4+Pj4gICAgICAgICAgICAgICAgICogSWYgd2IgaXMgZGly
dHksIGNsZWFuaW5nIHVwIHRoZSB3cml0ZWJhY2sgYnkgc3dpdGNoaW5nDQo+Pj4+Pj4+PiAgICAg
ICAgICAgICAgICAgKiBhdHRhY2hlZCBpbm9kZXMgd2lsbCByZXN1bHQgaW4gYW4gZWZmZWN0aXZl
IHJlbW92YWwgb2YgYW55DQo+Pj4+Pj4+PiAgICAgICAgICAgICAgICAgKiBiYW5kd2lkdGggcmVz
dHJpY3Rpb25zLCB3aGljaCBpc24ndCB0aGUgZ29hbC4gIEluc3RlYWQsDQo+Pj4+Pj4+PiAgICAg
ICAgICAgICAgICAgKiBpdCBjYW4gYmUgcG9zdHBvbmVkIHVudGlsIHRoZSBuZXh0IHRpbWUsIHdo
ZW4gYWxsIGlvDQo+Pj4+Pj4+PiAgICAgICAgICAgICAgICAgKiB3aWxsIGJlIGxpa2VseSBjb21w
bGV0ZWQuICBJZiBpbiB0aGUgbWVhbnRpbWUgc29tZSBpbm9kZXMNCj4+Pj4+Pj4+ICAgICAgICAg
ICAgICAgICAqIHdpbGwgZ2V0IHJlLWRpcnRpZWQsIHRoZXkgc2hvdWxkIGJlIGV2ZW50dWFsbHkg
c3dpdGNoZWQgdG8NCj4+Pj4+Pj4+ICAgICAgICAgICAgICAgICAqIGEgbmV3IGNnd2IuDQo+Pj4+
Pj4+PiAgICAgICAgICAgICAgICAgKi8NCj4+Pj4+Pj4+ICAgICAgICAgICAgICAgIGlmICh3Yl9o
YXNfZGlydHlfaW8od2IpKQ0KPj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICBjb250aW51
ZTsNCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gICAgICAgICAgICAgICAgaWYgKCF3Yl90cnlnZXQod2Ip
KSAgPD09PSBsaW5lIzY3OQ0KPj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICBjb250aW51
ZTsNCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gICAgICAgICAgICAgICAgc3Bpbl91bmxvY2tfaXJxKCZj
Z3diX2xvY2spOw0KPj4+Pj4+Pj4gICAgICAgICAgICAgICAgd2hpbGUgKGNsZWFudXBfb2ZmbGlu
ZV9jZ3diKHdiKSkNCj4+Pj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgY29uZF9yZXNjaGVk
KCk7DQo+Pj4+Pj4+PiAgICAgICAgICAgICAgICBzcGluX2xvY2tfaXJxKCZjZ3diX2xvY2spOw0K
Pj4+Pj4+Pj4gDQo+Pj4+Pj4+PiAgICAgICAgICAgICAgICB3Yl9wdXQod2IpOw0KPj4+Pj4+Pj4g
ICAgICAgIH0NCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gICAgICAgIGlmICghbGlzdF9lbXB0eSgmcHJv
Y2Vzc2VkKSkNCj4+Pj4+Pj4+ICAgICAgICAgICAgICAgIGxpc3Rfc3BsaWNlX3RhaWwoJnByb2Nl
c3NlZCwgJm9mZmxpbmVfY2d3YnMpOw0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiAgICAgICAgc3Bpbl91
bmxvY2tfaXJxKCZjZ3diX2xvY2spOw0KPj4+Pj4+Pj4gfQ0KPj4+Pj4+Pj4gYGBgDQo+Pj4+Pj4+
PiANCj4+Pj4+Pj4+IEJUVywgdGhpcyBidWcgY2FuIGJlIG9ubHkgcmVwcm9kdWNlZCBvbiBhIG5v
bi1kZWJ1ZyBwcm9kdWN0aW9uIGJ1aWx0DQo+Pj4+Pj4+PiBrZXJuZWwgKGEuay5hIGtlcm5lbCBy
cG0gcGFja2FnZSksIGl0J3Mgbm90IHJlcHJvZHVjaWJsZSBvbiBhIGRlYnVnDQo+Pj4+Pj4+PiBi
dWlsZCB3aXRoIHZhcmlvdXMgZGVidWcgY29uZmlndXJhdGlvbiBlbmFibGVkIChhLmsuYSBrZXJu
ZWwtZGVidWcgcnBtDQo+Pj4+Pj4+PiBwYWNrYWdlKQ0KPj4+Pj4+PiANCj4+Pj4+Pj4gRldJVyBJ
J3ZlIGFsc28gc2VlbiB0aGlzIHJlZ3VsYXJseSBvbiB4ODZfNjQga2VybmVscyBvbiBleHQ0IHdp
dGggYWxsDQo+Pj4+Pj4+IGRlZmF1bHQgbWtmcyBzZXR0aW5ncyB3aGVuIHJ1bm5pbmcgZ2VuZXJp
Yy8yNTYuDQo+Pj4+Pj4gDQo+Pj4+Pj4gT2gsIHRoYXQncyBhIHVzZWZ1bCBpbmZvcm1hdGlvbiwg
dGhhbmsgeW91IQ0KPj4+Pj4+IA0KPj4+Pj4+IEJ0dywgd291bGQgeW91IG1pbmQgdG8gZ2l2ZSBh
IHBhdGNoIGZyb20gYW4gZWFybGllciBtZXNzYWdlIGluIHRoZSB0aHJlYWQNCj4+Pj4+PiBhIHRl
c3Q/IEknZCBoaWdobHkgYXBwcmVjaWF0ZSBpdC4NCj4+Pj4+PiANCj4+Pj4+PiBUaGFua3MhDQo+
Pj4+PiANCj4+Pj4+IFdpbGwgZG8uDQo+Pj4+IA0KPj4+PiBmc3Rlc3RzIHBhc3NlZCBoZXJlLCBz
bw0KPj4+PiANCj4+Pj4gVGVzdGVkLWJ5OiBEYXJyaWNrIEouIFdvbmcgPGRqd29uZ0BrZXJuZWwu
b3JnPg0KPj4+IA0KPj4+IEdyZWF0LCB0aGFuayB5b3UhDQo+Pj4gDQo+IA0K
