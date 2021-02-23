Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5BB3223C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 02:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhBWBmP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Feb 2021 20:42:15 -0500
Received: from esa18.fujitsucc.c3s2.iphmx.com ([216.71.158.38]:53196 "EHLO
        esa18.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229852AbhBWBmO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Feb 2021 20:42:14 -0500
X-Greylist: delayed 458 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Feb 2021 20:42:11 EST
IronPort-SDR: Y8UHaLvXo0HCKwxsBA85ThP4xXd2+k5dZ+QJ/ovjO1O3vHuT7deFEx2E1E6BMY4xQwv4qPklKa
 Kkv71nnuKnE28g6FdTwxcqJP7Hna96hFpN+7iTVeRz/dePpYFgW06Xr0UtEEe8IdFYH1q6fDh+
 BlQA6MM8o1DouPmg51IlligyRhs4cTEnkS84zixVXQlp41zT1cSVqPnOowOTTvvaQXpFTWM5ZX
 yhI0g9nHEodoeOuQA4XV65I0d9H9u5162IiZ8fhklCBs14ZNNDTZSRg4//cc61YdLtxzgWvq8q
 Q4U=
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="26942697"
X-IronPort-AV: E=Sophos;i="5.81,198,1610377200"; 
   d="scan'208";a="26942697"
Received: from mail-os2jpn01lp2051.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.51])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 10:32:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LN7Imi+v4hy5inYQmL7U4KqU8rH/jJrEftJZiyueWgh0gb3a92x4lTpyMW/D/x+jgAcGp/Ei3YOGD6SA62ZYmP6B0OoPqp6+sO2z4f9rKwQxTKY3EJd9dESbqBihf5P5VOoWZOLzEHeYocsqkgCd+nIGWVUDMfWI/wvTjOUx4rpTeUCjIKc6E73hPxlOHSVDQCSeyV+CHb84RCVSXMX55EP2e2japrEHTbXDnizbAUMDcC30zRIAhndRmYl1q/3AxTMw5AYd7162javBxT3iVe4qiw+t7lcNMr2HX3cKznUjIc/zoG3zOntyzUsH+cmlsVTxlaIcUKqldZfZf3gukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZOrbr2QQES6DPVS+8wsT6rYGThY5CU/2vKcjKDbih8=;
 b=jhktDQwG9JgoQ3nSfHy4FDLXA+7dvS8h5wBTYSA3vWD/CNbJ4WIoDpuc4Bm1pv/CuQSr10bDXf0KJKt0ue1RsA+IPtgMguftuVk2+mBt0ylHNQE9FHGxkDAqeogpjCjXpstssFFhBklaiBRnJ2VsdLu1zuv832SKBgxX423QtW5Ytq1IVDQptUdxrdC9O9F04O5A2N4Gp+7BCLPjrosuRAyfgWs4kF+0OL2Lho4ilZd5aWb2xsxlQlyqBOFV6UsEF/PMTFTkxEtFlga2anxJrhZwZddyp8FG1OPUoA2C6a63Gly/nULqAEGz4GdJRFLGHpXlLqyxdVyDu5T2CkkJqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZOrbr2QQES6DPVS+8wsT6rYGThY5CU/2vKcjKDbih8=;
 b=HzkFg8x2XEiQBeusjC1ObmlgV9PMdisztzJrftH4rPWJDh6bLMNzHJpBBalgfJB+ouaPv2EIHa9Eb4vutpEfIUE4LaG8PpU1Rkh81GUM06ktAQDngUyHH/vPqTO3FrkXzoxvAMrz+vIsw7/LABlFNQWWRMSrzM7ieuFmhm5kJlE=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OS3PR01MB6039.jpnprd01.prod.outlook.com (2603:1096:604:d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Tue, 23 Feb
 2021 01:32:11 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::7de7:2ce8:ffc0:d098]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::7de7:2ce8:ffc0:d098%7]) with mapi id 15.20.3868.032; Tue, 23 Feb 2021
 01:32:11 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
CC:     "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "rgoldwyn@suse.de" <rgoldwyn@suse.de>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIDEvN10gZnNkYXg6IE91dHB1dCBhZGRyZXNzIGluIGRh?=
 =?gb2312?B?eF9pb21hcF9wZm4oKSBhbmQgcmVuYW1lIGl0?=
Thread-Topic: [PATCH 1/7] fsdax: Output address in dax_iomap_pfn() and rename
 it
Thread-Index: AQHW/XQKfp6kuelFCk2zvQMEsL6iU6pj4i4AgAEoxBI=
Date:   Tue, 23 Feb 2021 01:32:11 +0000
Message-ID: <OSBPR01MB2920F7474667D6D73A681D98F4809@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com>
 <20210207170924.2933035-2-ruansy.fnst@cn.fujitsu.com>,<cd067457-5aaf-a2a9-06b0-953f49437500@linux.alibaba.com>
In-Reply-To: <cd067457-5aaf-a2a9-06b0-953f49437500@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=fujitsu.com;
x-originating-ip: [49.74.161.241]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b9d27bf-23a9-496a-fb60-08d8d79ad7aa
x-ms-traffictypediagnostic: OS3PR01MB6039:
x-microsoft-antispam-prvs: <OS3PR01MB6039FB526BEB63D321A022CDF4809@OS3PR01MB6039.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w1i/uP4ES66PL/zOEIKtryJhe2y+B3TorW59BKDyCFR71Rcbsw1Fe6dJFVhkSKukGKKLqQFi82oPH/u/7ArNdIyqska5KgpG7rZwlueBNzJETxyQtITR9jVMWprCb2nNdV5mfk6ERy93G0u9tyXJdnr4KZYMSB6mq/93dFfH3iiT1fKzAIrW3Yd/Q7PLZhU8jDiJfeJRo6lfD67MzkyrMnO4818K3pn3jZTSrKnM0eXxJxm2rwN7HQbTMPHgylpPSMjvX1h9+6Gxyn9e9mMIPVigkHgistt//7RkmcyLDKwChTxMXlP4OnU8On3udOeJlLnq8bMMQo4JYuuBR7+zJFE8/6XmQWH5TQuntGypQCXLFKD3bAW00njWFmOikctIzP6KDiWzSfFWAx/wcf/wXzrfI4LqIhXbzNDYY6/IdL65T0o2EMGpEb1qDUOU2BuJag5TEJMexBhn0mM6PmlcGqSel731RRp69cx9QgaPwZrpXuYorpKujQV35U37/l+DmjBRXrMEWYkfTiYKHTqX/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(86362001)(9686003)(7696005)(26005)(478600001)(66476007)(186003)(66556008)(2906002)(83380400001)(4326008)(6916009)(55016002)(224303003)(76116006)(66946007)(66446008)(64756008)(33656002)(71200400001)(7416002)(52536014)(5660300002)(8936002)(316002)(85182001)(6506007)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?TkVKaGpkY1pqWmlUUmtEZmJEcGRtNXVlR0Y1bXIzb0twSWtyVnJNMGxWWXVO?=
 =?gb2312?B?a0VOT3I5bUF3SE5ZdVZ1b3dkcmFRUklNcHYvaHBGdGpmeXRqak1WaXl2VElZ?=
 =?gb2312?B?dkRreDYycWRJdVgrUjBLMzExTU9MeVpSL1J6Q2tnVUtEejV4WnJsa0dvN0FM?=
 =?gb2312?B?aUNXZFJwendUSENaZHZtbGV3TkI3djlMMjZBQjR1UTJSMmNCc1c3VnVBZklF?=
 =?gb2312?B?WThvQWpRQ0N4UEs2dEJrTjYyTHNFQXBOY01TWHFKQTFhOWdScjN3L1dyVlB5?=
 =?gb2312?B?eC9qVDI0eTdRYXl4VllxbHJ2M0tKdHZJWXk2SjlxTEIzczM4d3Z2dnE1Y1lt?=
 =?gb2312?B?N0VNTmc4eEhqSmdsQ0o3cEZFWWc5R3ovS3hKamlwRjc2YWtHbTRodTJsSWwr?=
 =?gb2312?B?TkcycWZGOElWTGZ6M1h2aFVpZk9WNUVSeGpYSlFuTGNpL2RLSHNHU0hNUXJQ?=
 =?gb2312?B?M1RMZDlEVlZLaWtsR3F5YUllQUJ6aXE1TzM0SmMxNUlxTHRlN1YvUzZzMkd2?=
 =?gb2312?B?MXd4dmJsQTFiMGsyMXBSeS9UbnQ5SjZqUW5iQ20vbnNuQUNnUDJtNnB1cHFK?=
 =?gb2312?B?VzFUWDFTa2pJYnU3dGh4K3Bha3dmT1drc0RGYU1sZjB4NjEzVnFPcDBrOFNX?=
 =?gb2312?B?ZGRGZng4ZHc1dFFpdWNhMzF3U1ErSjBNcEFqajJQcmhXSm95WHdnd3A0c2dQ?=
 =?gb2312?B?K1VFRW1rcnhUdVQrajdYY2RxeW1UMkdXZVVqM20yZjI5QytyeUtIUDBvMDJv?=
 =?gb2312?B?YmlON3hlUk9WWW5mcTVaek5MbjJkZWxKTWd3bDlPZk8zdFNtb3ViNG40ZkpZ?=
 =?gb2312?B?TUVsV3BUMFdpY0RlRFZBZkZhMVhlZHJTZExXZThZTTBjRFdjNURVdTh6dUVW?=
 =?gb2312?B?dXNUZDZmRExreFJIVFhJaitPS0Q0UHFFbCtERUJPWkY5UmRKU2Y2b3pGelRQ?=
 =?gb2312?B?eUd6dzlsVXBoNllYVzRzc0ttNHVsRVYwRGpuUlUrS1diVjc0NlErK3JKK1lF?=
 =?gb2312?B?NU5yYXRkcTNIWGNDVlRFdkFERURPZTV6YWZMSFBGN2R0cEhwalBtK292Vm02?=
 =?gb2312?B?czZ5SnF1UDFVelZ1eFV2T0FBN3p6NE1EOXEwNHo5NlhJa0ZRSFJoTk15VXh5?=
 =?gb2312?B?NnVvelRCeWdaTTNLNnBPNHlmMVdSR1B5Yk50YlpVTUY1N1lLejNsd2ZMVXhE?=
 =?gb2312?B?ZGVRSVgzNzBDVVZQRzBFK3pBZEMzajliS05oSC9VZExlQ1M5cWJTN1l0NXU1?=
 =?gb2312?B?amVYYlRtWjBUeU90L1NhODVFOHdLQVA4N0ZGNnFLUmI5UVJ4bzBmcDNEcnBD?=
 =?gb2312?B?dlFkc0hBQ3F2dEcxaS9SeURKNTRzKzRGa2xzUzJJQmQ1TW01RW9nRUkrZjRR?=
 =?gb2312?B?aWswWmg4RGpGeXRncTBlb3hIU1JsYmZNYmQzYlkrK0xhOFVxNDV3dnpTcmQx?=
 =?gb2312?B?L0U5MHI0bzVITkJUVW1EK3AvVUdwNXhKdHAxM2pkOW9NcFdwZWE3M3p1cXNP?=
 =?gb2312?B?b2g2cFQ4L0FSMFdJc0VkV2hMbktic1o4Rk10YTYwTXFtclZiTWVZd1N1Yncw?=
 =?gb2312?B?L2FqZFJiRVR3WWNueWRQV1V5cjJiYVlObXhSYk5zWTN5MEpqTTg2NVhlN05B?=
 =?gb2312?B?bkZRSTdackk0R09wWVpsNjhtcFVsMXB5Tld0YkszY1JwSUxMZmtPYS9NaDJn?=
 =?gb2312?B?c04zTlVFMyszWEpYRnZCV3h6Y2ppUEpvZmFMT016WXJmZzEvMS9hL3J5Mll2?=
 =?gb2312?Q?p5iP0J+BdmjGP7BojM=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9d27bf-23a9-496a-fb60-08d8d79ad7aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 01:32:11.5587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bhXqoG8vxtYGXoMAOKNGw1hSLHx0vnnJAAGNqcI6ov+LV0e8U2600Stbb5UGnVFpTfICVAkGHXTqtliqfEsTHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6039
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBoaSwKPiAKPiA+IEFkZCBhZGRyZXNzIG91dHB1dCBpbiBkYXhfaW9tYXBfcGZuKCkgaW4gb3Jk
ZXIgdG8gcGVyZm9ybSBhIG1lbWNweSgpIGluCj4gPiBDb1cgY2FzZS4gIFNpbmNlIHRoaXMgZnVu
Y3Rpb24gYm90aCBvdXRwdXQgYWRkcmVzcyBhbmQgcGZuLCByZW5hbWUgaXQgdG8KPiA+IGRheF9p
b21hcF9kaXJlY3RfYWNjZXNzKCkuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogU2hpeWFuZyBSdWFu
IDxydWFuc3kuZm5zdEBjbi5mdWppdHN1LmNvbT4KPiA+IC0tLQo+ID4gICBmcy9kYXguYyB8IDIw
ICsrKysrKysrKysrKysrKy0tLS0tCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25z
KCspLCA1IGRlbGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9mcy9kYXguYyBiL2ZzL2Rh
eC5jCj4gPiBpbmRleCA1YjQ3ODM0ZjJlMWIuLmIwMTJiMmRiN2JhMiAxMDA2NDQKPiA+IC0tLSBh
L2ZzL2RheC5jCj4gPiArKysgYi9mcy9kYXguYwo+ID4gQEAgLTk5OCw4ICs5OTgsOCBAQCBzdGF0
aWMgc2VjdG9yX3QgZGF4X2lvbWFwX3NlY3RvcihzdHJ1Y3QgaW9tYXAgKmlvbWFwLCBsb2ZmX3Qg
cG9zKQo+ID4gICAgICAgIHJldHVybiAoaW9tYXAtPmFkZHIgKyAocG9zICYgUEFHRV9NQVNLKSAt
IGlvbWFwLT5vZmZzZXQpID4+IDk7Cj4gPiAgIH0KPiA+ICAKPiA+IC1zdGF0aWMgaW50IGRheF9p
b21hcF9wZm4oc3RydWN0IGlvbWFwICppb21hcCwgbG9mZl90IHBvcywgc2l6ZV90IHNpemUsCj4g
PiAtICAgICAgICAgICAgICAgICAgICAgIHBmbl90ICpwZm5wKQo+ID4gK3N0YXRpYyBpbnQgZGF4
X2lvbWFwX2RpcmVjdF9hY2Nlc3Moc3RydWN0IGlvbWFwICppb21hcCwgbG9mZl90IHBvcywgc2l6
ZV90IHNpemUsCj4gPiArICAgICAgICAgICAgIHZvaWQgKiprYWRkciwgcGZuX3QgKnBmbnApCj4g
PiAgIHsKPiA+ICAgICAgICBjb25zdCBzZWN0b3JfdCBzZWN0b3IgPSBkYXhfaW9tYXBfc2VjdG9y
KGlvbWFwLCBwb3MpOwo+ID4gICAgICAgIHBnb2ZmX3QgcGdvZmY7Cj4gPiBAQCAtMTAxMSwxMSAr
MTAxMSwxMyBAQCBzdGF0aWMgaW50IGRheF9pb21hcF9wZm4oc3RydWN0IGlvbWFwICppb21hcCwg
bG9mZl90IHBvcywgc2l6ZV90IHNpemUsCj4gPiAgICAgICAgICAgICAgICByZXR1cm4gcmM7Cj4g
PiAgICAgICAgaWQgPSBkYXhfcmVhZF9sb2NrKCk7Cj4gPiAgICAgICAgbGVuZ3RoID0gZGF4X2Rp
cmVjdF9hY2Nlc3MoaW9tYXAtPmRheF9kZXYsIHBnb2ZmLCBQSFlTX1BGTihzaXplKSwKPiA+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5VTEwsIHBmbnApOwo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAga2FkZHIsIHBmbnApOwo+ID4gICAgICAgIGlmIChsZW5n
dGggPCAwKSB7Cj4gPiAgICAgICAgICAgICAgICByYyA9IGxlbmd0aDsKPiA+ICAgICAgICAgICAg
ICAgIGdvdG8gb3V0Owo+ID4gICAgICAgIH0KPiA+ICsgICAgIGlmICghcGZucCkKPiBTaG91bGQg
dGhpcyBiZSAiaWYgKCEqcGZucCkiPwoKcGZucCBtYXkgYmUgTlVMTCBpZiB3ZSBvbmx5IG5lZWQg
YSBrYWRkciBvdXRwdXQuCiAgYGRheF9pb21hcF9kaXJlY3RfYWNjZXNzKGlvbWFwLCBwb3MsIHNp
emUsICZrYWRkciwgTlVMTCk7YAoKU28sIGl0J3MgYSBOVUxMIHBvaW50ZXIgY2hlY2sgaGVyZS4K
CgotLQpUaGFua3MsClJ1YW4gU2hpeWFuZy4KCj4gCj4gUmVnYXJkcywKPiBYaWFvZ3VhbmcgV2Fu
Zwo+ID4gKyAgICAgICAgICAgICBnb3RvIG91dF9jaGVja19hZGRyOwo+ID4gICAgICAgIHJjID0g
LUVJTlZBTDsKPiA+ICAgICAgICBpZiAoUEZOX1BIWVMobGVuZ3RoKSA8IHNpemUpCj4gPiAgICAg
ICAgICAgICAgICBnb3RvIG91dDsKPiA+IEBAIC0xMDI1LDYgKzEwMjcsMTIgQEAgc3RhdGljIGlu
dCBkYXhfaW9tYXBfcGZuKHN0cnVjdCBpb21hcCAqaW9tYXAsIGxvZmZfdCBwb3MsIHNpemVfdCBz
aXplLAo+ID4gICAgICAgIGlmIChsZW5ndGggPiAxICYmICFwZm5fdF9kZXZtYXAoKnBmbnApKQo+
ID4gICAgICAgICAgICAgICAgZ290byBvdXQ7Cj4gPiAgICAgICAgcmMgPSAwOwo+ID4gKwo+ID4g
K291dF9jaGVja19hZGRyOgo+ID4gKyAgICAgaWYgKCFrYWRkcikKPiA+ICsgICAgICAgICAgICAg
Z290byBvdXQ7Cj4gPiArICAgICBpZiAoISprYWRkcikKPiA+ICsgICAgICAgICAgICAgcmMgPSAt
RUZBVUxUOwo+ID4gICBvdXQ6Cj4gPiAgICAgICAgZGF4X3JlYWRfdW5sb2NrKGlkKTsKPiA+ICAg
ICAgICByZXR1cm4gcmM7Cj4g
