Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2173AAE81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 10:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhFQIPG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 04:15:06 -0400
Received: from esa4.fujitsucc.c3s2.iphmx.com ([68.232.151.214]:53837 "EHLO
        esa4.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229842AbhFQIPF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 04:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1623917578; x=1655453578;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oIdAGb811+hMM36V8+OauWM4rEh3Y6rqRCiO+EF7U64=;
  b=ETajgP8waowqGu08MQBjL6Q77ZuMNsboskGhSS0v3Ai22kzSAbADuAsR
   D+0UZ+0rv5zPmSy/H/F1aaxPe+6X8sL/LdG2cwXWvZKlzVNY8CFHLEItT
   rEJqcjLd98Yuxj3oSCEYnHyjWUGipe8stqdy1MTzF22Tz/9IfuK82JebW
   MugrCzOi32g7Y38lxDkces+OEEA0Nw5BeOpdHIInEQoZBE/DMA/wRvbLJ
   /M9b53dTChjDE/yH9IkVLxE+gIqh9igm9wkrKK+S4aUN88dNDrvR0eqq6
   5VC22B7QPiZ+kUfiaGxoYGrHLTqvLAgkJYLicZ5qKA8WxOq6SrMAR3ida
   Q==;
IronPort-SDR: 4TY5TTVDZZmGjDdtmqPm9hXlWt2m2cCLqxtUA3JsWki/I2dyA+xXWtY3d9ztrH2Z1gSakWcW/S
 e2R37M6WNVDt2tqkmZF2YgSN4jTGP88woCcDsvI0c8UxhgXUcd5hRtOQdOy5/SWXxB3Qf7U4fu
 UsV86GgX6RSNNjr8a1ptGMEoX6Hq/Mc6a/lObPnXshiCTt9afqQXcr0rrgUzpIImvcGniacvUH
 onX+vabbBVwA8UwaGp1d7pvbvdf9/hhULw4ih4U7FtwgJYPazqqtekdRqrj0MoS4daKHt8/NP2
 JmE=
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="41210390"
X-IronPort-AV: E=Sophos;i="5.83,280,1616425200"; 
   d="scan'208";a="41210390"
Received: from mail-ty1jpn01lp2051.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.51])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 17:12:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1UnPyFD6kY0sbvOaSSTpXus52Co9gejmWyNoYZnoWA7AKqRrpj96/JnZhwstTSRTaPwUIE3/timE/NhawORS7mYP7+ogf2aLEkQvJ87S8V+mQwGVB+jx+qQbz33jBsFo33qlg52LaUSFu8Nvvkur6lgOgiwbSeQR7081xeuk0ePRyrrg6oQZjyjJSkakeZA9QGgvk3OWlNaKvcBSRdpkAhRPrb1RI3+qttzPvYJSKKBVYzOvVqqK8BOGuIbicwpvf9jCfd9swcHLeoNPvN/sX+8LiGsu7meg7ya6XVHdVVjKmNmTuPqwCRGuyyhrYZNZBHaVwDEGUh97PxtuwcXLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIdAGb811+hMM36V8+OauWM4rEh3Y6rqRCiO+EF7U64=;
 b=nf0Ezv9ID+LaC+wvLezefij3d7XmeP1/s4hEdJlx6WDBUFB1Vd/ALv60K8BMDLoEOv+uyYXJ1m/RTPvG+l5i9NLUQwN7Df9qmuSxu88MWTsjSHO7SzkqX5sc5VqtoWVnEvI2O+wBB8uhjvpIebDO0xTiH/YrQ7NBGJPOdjRfLmI6T/zORChazwU3sP0oMcfTlXIwGFI4O+KXtXO1JwWNMy8RErsEl/Ig/kF+8P5iEk40a3tMDdhx7biO7yBHaFFaNhGkuk7yPiOmSnlPQEdwVngpPfDXs+R5IIE6KMDGBM8GcVYdIYycYY90zWQK/ad0KgXTFZXpjI+NZoeeIbXNtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIdAGb811+hMM36V8+OauWM4rEh3Y6rqRCiO+EF7U64=;
 b=WMHVTTg1PKtVOVKzMdqmaE9nXchkqf3PFtJc/Xpktk9Ud1ZLZ75Gz21gQAc+Guh5m8c83exg+hbFAPQ+Kmh+c60rnmr7xdyszx5RxrU31VXlFX/Bf6Ddy0IcPQZiMPELsQKp2susu2jBklWbbBQHqtZewx+dqiYlMiyyMhcbTjI=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OS3PR01MB6039.jpnprd01.prod.outlook.com (2603:1096:604:d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 08:12:49 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b985:8239:6cf0:1228]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b985:8239:6cf0:1228%7]) with mapi id 15.20.4242.019; Thu, 17 Jun 2021
 08:12:49 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        david <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Subject: RE: [PATCH v4 03/10] fs: Introduce ->corrupted_range() for superblock
Thread-Topic: [PATCH v4 03/10] fs: Introduce ->corrupted_range() for
 superblock
Thread-Index: AQHXWN/AzVDrjJsgmE+2b5OugDUMoqsV4P2AgAHv3zCAAAtaAIAADhSw
Date:   Thu, 17 Jun 2021 08:12:49 +0000
Message-ID: <OSBPR01MB292031EC271D4AD843389A3FF40E9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210604011844.1756145-1-ruansy.fnst@fujitsu.com>
 <20210604011844.1756145-4-ruansy.fnst@fujitsu.com>
 <CAPcyv4h=bUCgFudKTrW09dzi8MWxg7cBC9m68zX1=HY24ftR-A@mail.gmail.com>
 <OSBPR01MB29203DC17C538F7B1B1C9224F40E9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <CAPcyv4ihuErfVWHL0F1OExQashutJjBdaLn5X5oPm44OkQ+a_A@mail.gmail.com>
In-Reply-To: <CAPcyv4ihuErfVWHL0F1OExQashutJjBdaLn5X5oPm44OkQ+a_A@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [223.111.68.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 451d5c3e-9486-47a8-9fc7-08d93167b2ba
x-ms-traffictypediagnostic: OS3PR01MB6039:
x-microsoft-antispam-prvs: <OS3PR01MB60398550E55EE9C1FF90F79BF40E9@OS3PR01MB6039.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B9AnJhF/JQd4bpht4zUuYsiOgrt6wbsLhAS4rkzxFSTsGbhZI+WwXAmP4/cv16uoMtoy8c1Pxwup8OSqTSO3V1jJ/4Ff3j19rdZZcy1du3eDP5RiWlaXLBOUXyz//lvELPWs8GF5TxZiugAg/nUXf4SapezH1Q4q1PO6+LP4iufXy2NJbM7xhHpk7QtskdaDfkHfB/6M+1UiMSq74yqdsROA8HAu7L3JnC80SHHHFdkfnkyDcKg6qEsZ5aRnSfkjO0sGPkEEYibo7lzPAchnbKbse7ThFJBBsPcwfoR5r3jgProZrEG3t/4Sr+pPO/na47qcYCcCiEi2TPrZIgUpn9R2TGEGR2+cM4464qyQTi89aGNaT/cFDxAXvHVEvYCov/jTno+D1qOA+BCSPfM5Y5sW4Egnkm0E7FfNaK+woRNRLSEBX9v5V/sPM8p4PSlP8/HCeYTi9dzNG5+2rwcSDFnTDl2jDfj3iRZFMM4pF5+7MQuLvNgK6hZFSU4Mb/fRxlQzgZOn7OYyAmg7QnXffglulKIAmayXxlq2QiPOna0S515zMfx4A8Ry7itvZAymSWL/A8lqqTfaNzcnBs6KYITMbicij2aC2v/JM2QF5DQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(6506007)(71200400001)(53546011)(64756008)(76116006)(26005)(66946007)(66556008)(7416002)(186003)(316002)(83380400001)(66446008)(86362001)(66476007)(4326008)(2906002)(55016002)(478600001)(85182001)(52536014)(122000001)(9686003)(6916009)(5660300002)(7696005)(8676002)(8936002)(38100700002)(33656002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVVqMVZ3VDJHcStyQ1dZRFJUQ0Y3N0ZNZkR4N1UvazdDZVFhSW5RQkd2TnU0?=
 =?utf-8?B?RmJsUmxmd0xEOHRVbThCd3F0c0I1elRUYzVhSFNKR1BrTlMwMEhPenRidGhh?=
 =?utf-8?B?YVgxTlVGUG9KTVY3WWlvcFdtNlAyZTJpV0dZTVlYVDEzM0d1L2JaN09YZlE3?=
 =?utf-8?B?ZmZ5MVQwZnJMVDFGYzRxTm44dEE0R2dSTTNPbzNlMkhuRTVhRUd3ZDArQWx3?=
 =?utf-8?B?L1VqcytkV0dGdDd6cEc5b3JXWmQvUk9WNGZiMFJ1UWdxOGdPYlV4Z3lZUCs3?=
 =?utf-8?B?aGI1a203Q2ppVm11c0hmVk9JYWt5UGY1VHNpS0R0SllhUCsrOU1XbkpzMWJ3?=
 =?utf-8?B?N0pKRE43dkprdE1JcGNjeHpvTURESWFRckgreDBuM3VDRlhCRlc5VUp3RGlq?=
 =?utf-8?B?YTRWZ294Z3hhRCs1Sm5xMFRRcnhYeDRBWlRYbjBibHF0OVdoY3FtU1Bjai9Y?=
 =?utf-8?B?WHg4TTVTaVpIYXBZcEJpWENaakNvN1RpbDRXT1doblovdUNGY2NtcU9RcTBL?=
 =?utf-8?B?eTZ2UmV0OVR3dWRBZlNGM1gwWVJEYUZreDdqNU9vKzhXcnBLNk9wWEtXd042?=
 =?utf-8?B?K3VFREZwbE40RDhIcmJMMGNPTnZVNTcxcTVIMk5WOVdTTVVHdEpRODEzT3Iy?=
 =?utf-8?B?WUlwWCt1V21lT3ZtaUFmd1dKRFpRNlpFT0w1bVhmZGViZVRGaXlScEFicVFj?=
 =?utf-8?B?aEw4YnRFNk5ZY29uTit4ZEtWYmdtZDI5MUVJYU9zTHZsTGkxNkUzQ0NkK0k5?=
 =?utf-8?B?TlVRS2w4Z3dwSXhtNEpiOTdSQzF6cStjZmxKUUVMekNDa3orUStlVUpZZ0VN?=
 =?utf-8?B?RHV2SGtoNHJ2QmxUTFNPYlk1QlZDS2tMbmd6UXcvVmpXUWNraVZLd0l4VEsx?=
 =?utf-8?B?SitlRjNUS01HVW1jVTFpSDJCbVZRTHhDTjFON0dKbEJiU3l3UWJvdkRtcE43?=
 =?utf-8?B?ckluR1FkMW5pOTF6SDV3YXNTZzBJTDg5cktkWlVDbGc2OVZWaWxGbzg3SlRD?=
 =?utf-8?B?WC9rZXpER0JYcC9CeHRMaGMwT093eFNSVG9DTHU3Q0N2WUI2TmFLOXVXZzVH?=
 =?utf-8?B?U3pXZmlubFJRZmtGZDhaNnVGc1FXZ2pyMU93ZEZoZE83bG9abnBWN2RMcGVo?=
 =?utf-8?B?eU1vV3FOQWNKRVZOTmJVbzREQ1pMZCtVSlErTTdXdlBRNklEYUlKWDJFK29B?=
 =?utf-8?B?UnNYRFI1N2o4VFRvbFZSWkdINStLdVk1NGRvcW9ZYXhWM1RFYUhyWUN6OWI5?=
 =?utf-8?B?MWUvNU5sdGFjM3orOGtLSllFK3REWnRFUG8xdjd1bkx5M3FPbnd6dzJQNGxm?=
 =?utf-8?B?YlZjcWxKZEhSRW5Ud1ZQbW95SithQUl0VWRnZDdoeDFUUndpeXY2S1hZak1N?=
 =?utf-8?B?L1kzN21EeXppV1dLL09ON3dDTTlIRmhmMjlKVEtVcEQwSkVmb2c4RHZLaGRF?=
 =?utf-8?B?V0F1NnROU2F5WDlYOSsxWVRYNWNQaVBtRWRORHVNeTJKRm5rS0lNM0tEMjRW?=
 =?utf-8?B?VTBoUWRzZlF5VnhMeHFWS090OUFTQ3NFV0toUXZYekpvbzRkV2JUY3pDdlVx?=
 =?utf-8?B?S3lDcnlrbU9vRnluZ1JmZXVNMGMxdFZjQ3poRWJCTE10K3ovN2t3UG41emZa?=
 =?utf-8?B?WktuRlIrb2tuZWZSdFZTcGFHZWhiWXRnREF3N0ZLcmQyOHZhbGg2ckRDMC9p?=
 =?utf-8?B?ditnWE1RNXkxRFdRT2ovNmJ3TzZBc2JKakVBM3czaTRQYVZsSjJnQkZyMUo3?=
 =?utf-8?Q?4ED+NOUUgVMtp08frYgD1G84/nhLdGdtzz6jGK2?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 451d5c3e-9486-47a8-9fc7-08d93167b2ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2021 08:12:49.8623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rEmEpeIKrW7JQ1gQVHnyLYfhE+ppl02n66wtf/QFgWjKo4714OBwCxnRBTQ6jPISaZBjtnAi/JaCSYy/VpQt4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6039
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW4gV2lsbGlhbXMgPGRhbi5q
LndpbGxpYW1zQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAwMy8xMF0gZnM6
IEludHJvZHVjZSAtPmNvcnJ1cHRlZF9yYW5nZSgpIGZvciBzdXBlcmJsb2NrDQo+IA0KPiBPbiBX
ZWQsIEp1biAxNiwgMjAyMSBhdCAxMTo1MSBQTSBydWFuc3kuZm5zdEBmdWppdHN1LmNvbQ0KPiA8
cnVhbnN5LmZuc3RAZnVqaXRzdS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0Bp
bnRlbC5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDAzLzEwXSBmczogSW50cm9k
dWNlIC0+Y29ycnVwdGVkX3JhbmdlKCkgZm9yDQo+ID4gPiBzdXBlcmJsb2NrDQo+ID4gPg0KPiA+
ID4gWyBkcm9wIG9sZCBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnLCBhZGQgbnZkaW1tQGxpc3Rz
LmxpbnV4LmRldiBdDQo+ID4gPg0KPiA+ID4gT24gVGh1LCBKdW4gMywgMjAyMSBhdCA2OjE5IFBN
IFNoaXlhbmcgUnVhbiA8cnVhbnN5LmZuc3RAZnVqaXRzdS5jb20+DQo+IHdyb3RlOg0KPiA+ID4g
Pg0KPiA+ID4gPiBNZW1vcnkgZmFpbHVyZSBvY2N1cnMgaW4gZnNkYXggbW9kZSB3aWxsIGZpbmFs
bHkgYmUgaGFuZGxlZCBpbg0KPiA+ID4gPiBmaWxlc3lzdGVtLiAgV2UgaW50cm9kdWNlIHRoaXMg
aW50ZXJmYWNlIHRvIGZpbmQgb3V0IGZpbGVzIG9yDQo+ID4gPiA+IG1ldGFkYXRhIGFmZmVjdGVk
IGJ5IHRoZSBjb3JydXB0ZWQgcmFuZ2UsIGFuZCB0cnkgdG8gcmVjb3ZlciB0aGUNCj4gPiA+ID4g
Y29ycnVwdGVkIGRhdGEgaWYgcG9zc2lhYmxlLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBTaGl5YW5nIFJ1YW4gPHJ1YW5zeS5mbnN0QGZ1aml0c3UuY29tPg0KPiA+ID4gPiAtLS0N
Cj4gPiA+ID4gIGluY2x1ZGUvbGludXgvZnMuaCB8IDIgKysNCj4gPiA+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKykNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbGludXgvZnMuaCBiL2luY2x1ZGUvbGludXgvZnMuaCBpbmRleA0KPiA+ID4gPiBjM2M4OGZk
YjliMmEuLjkyYWYzNmM0MjI1ZiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9m
cy5oDQo+ID4gPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvZnMuaA0KPiA+ID4gPiBAQCAtMjE3Niw2
ICsyMTc2LDggQEAgc3RydWN0IHN1cGVyX29wZXJhdGlvbnMgew0KPiA+ID4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHNocmlua19jb250cm9sICopOw0KPiA+ID4g
PiAgICAgICAgIGxvbmcgKCpmcmVlX2NhY2hlZF9vYmplY3RzKShzdHJ1Y3Qgc3VwZXJfYmxvY2sg
KiwNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHNo
cmlua19jb250cm9sICopOw0KPiA+ID4gPiArICAgICAgIGludCAoKmNvcnJ1cHRlZF9yYW5nZSko
c3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgc3RydWN0DQo+ID4gPiA+ICsgYmxvY2tfZGV2aWNlDQo+
ID4gPiAqYmRldiwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxvZmZf
dCBvZmZzZXQsIHNpemVfdCBsZW4sIHZvaWQNCj4gPiA+ID4gKyAqZGF0YSk7DQo+ID4gPg0KPiA+
ID4gV2h5IGRvZXMgdGhlIHN1cGVyYmxvY2sgbmVlZCBhIG5ldyBvcGVyYXRpb24/IFdvdWxkbid0
IHdoYXRldmVyDQo+ID4gPiBmdW5jdGlvbiBpcyBzcGVjaWZpZWQgaGVyZSBqdXN0IGJlIHNwZWNp
ZmllZCB0byB0aGUgZGF4X2RldiBhcyB0aGUNCj4gPiA+IC0+bm90aWZ5X2ZhaWx1cmUoKSBob2xk
ZXIgY2FsbGJhY2s/DQo+ID4NCj4gPiBCZWNhdXNlIHdlIG5lZWQgdG8gZmluZCBvdXQgd2hpY2gg
ZmlsZSBpcyBlZmZlY3RlZCBieSB0aGUgZ2l2ZW4gcG9pc29uIHBhZ2Ugc28NCj4gdGhhdCBtZW1v
cnktZmFpbHVyZSBjb2RlIGNhbiBkbyBjb2xsZWN0X3Byb2NzKCkgYW5kIGtpbGxfcHJvY3MoKSBq
b2JzLiAgQW5kIGl0DQo+IG5lZWRzIGZpbGVzeXN0ZW0gdG8gdXNlIGl0cyBybWFwIGZlYXR1cmUg
dG8gc2VhcmNoIHRoZSBmaWxlIGZyb20gYSBnaXZlbiBvZmZzZXQuDQo+IFNvLCB3ZSBuZWVkIHRo
aXMgaW1wbGVtZW50ZWQgYnkgdGhlIHNwZWNpZmllZCBmaWxlc3lzdGVtIGFuZCBjYWxsZWQgYnkN
Cj4gZGF4X2RldmljZSdzIGhvbGRlci4NCj4gPg0KPiA+IFRoaXMgaXMgdGhlIGNhbGwgdHJhY2Ug
SSBkZXNjcmliZWQgaW4gY292ZXIgbGV0dGVyOg0KPiA+IG1lbW9yeV9mYWlsdXJlKCkNCj4gPiAg
KiBmc2RheCBjYXNlDQo+ID4gIHBnbWFwLT5vcHMtPm1lbW9yeV9mYWlsdXJlKCkgICAgICA9PiBw
bWVtX3BnbWFwX21lbW9yeV9mYWlsdXJlKCkNCj4gPiAgIGRheF9kZXZpY2UtPmhvbGRlcl9vcHMt
PmNvcnJ1cHRlZF9yYW5nZSgpID0+DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAtIGZzX2RheF9jb3JydXB0ZWRfcmFuZ2UoKQ0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgLSBtZF9kYXhfY29ycnVwdGVkX3JhbmdlKCkNCj4gPiAgICBz
Yi0+c19vcHMtPmN1cnJ1cHRlZF9yYW5nZSgpICAgID0+IHhmc19mc19jb3JydXB0ZWRfcmFuZ2Uo
KSAgPD09DQo+ICoqSEVSRSoqDQo+ID4gICAgIHhmc19ybWFwX3F1ZXJ5X3JhbmdlKCkNCj4gPiAg
ICAgIHhmc19jdXJydXB0X2hlbHBlcigpDQo+ID4gICAgICAgKiBjb3JydXB0ZWQgb24gbWV0YWRh
dGENCj4gPiAgICAgICAgICAgdHJ5IHRvIHJlY292ZXIgZGF0YSwgY2FsbCB4ZnNfZm9yY2Vfc2h1
dGRvd24oKQ0KPiA+ICAgICAgICogY29ycnVwdGVkIG9uIGZpbGUgZGF0YQ0KPiA+ICAgICAgICAg
ICB0cnkgdG8gcmVjb3ZlciBkYXRhLCBjYWxsIG1mX2RheF9raWxsX3Byb2NzKCkNCj4gPiAgKiBu
b3JtYWwgY2FzZQ0KPiA+ICBtZl9nZW5lcmljX2tpbGxfcHJvY3MoKQ0KPiA+DQo+ID4gQXMgeW91
IGNhbiBzZWUsIHRoaXMgbmV3IGFkZGVkIG9wZXJhdGlvbiBpcyBhbiBpbXBvcnRhbnQgZm9yIHRo
ZSB3aG9sZQ0KPiBwcm9ncmVzcy4NCj4gDQo+IEkgZG9uJ3QgdGhpbmsgeW91IG5lZWQgZWl0aGVy
IGZzX2RheF9jb3JydXB0ZWRfcmFuZ2UoKSBub3INCj4gc2ItPnNfb3BzLT5jb3JydXB0ZWRfcmFu
Z2UoKS4gSW4gZmFjdCB0aGF0IGZzX2RheF9jb3JydXB0ZWRfcmFuZ2UoKQ0KPiBsb29rcyBicm9r
ZW4gYmVjYXVzZSB0aGUgZmlsZXN5c3RlbSBtYXkgbm90IGV2ZW4gYmUgbW91bnRlZCBvbiB0aGUg
ZGV2aWNlDQo+IGFzc29jaWF0ZWQgd2l0aCB0aGUgZXJyb3IuIA0KDQpJZiBmaWxlc3lzdGVtIGlz
IG5vdCBtb3VudGVkLCB0aGVuIHRoZXJlIHdvbid0IGJlIGFueSBwcm9jZXNzIHVzaW5nIHRoZSBi
cm9rZW4gcGFnZSBhbmQgbm8gb25lIG5lZWQgdG8gYmUga2lsbGVkIGluIG1lbW9yeS1mYWlsdXJl
LiAgU28sIEkgdGhpbmsgd2UgY2FuIGp1c3QgcmV0dXJuIGFuZCBoYW5kbGUgdGhlIGVycm9yIG9u
IGRyaXZlciBsZXZlbCBpZiBuZWVkZWQuDQoNCj4gVGhlIGhvbGRlcl9kYXRhIGFuZCBob2xkZXJf
b3Agc2hvdWxkIGJlIHN1ZmZpY2llbnQNCj4gZnJvbSBjb21tdW5pY2F0aW5nIHRoZSBzdGFjayBv
ZiBub3RpZmljYXRpb25zOg0KPiANCj4gcGdtYXAtPm5vdGlmeV9tZW1vcnlfZmFpbHVyZSgpID0+
IHBtZW1fcGdtYXBfbm90aWZ5X2ZhaWx1cmUoKQ0KPiBwbWVtX2RheF9kZXYtPmhvbGRlcl9vcHMt
Pm5vdGlmeV9mYWlsdXJlKHBtZW1fZGF4X2RldikgPT4NCj4gbWRfZGF4X25vdGlmeV9mYWlsdXJl
KCkNCj4gbWRfZGF4X2Rldi0+aG9sZGVyX29wcy0+bm90aWZ5X2ZhaWx1cmUoKSA9PiB4ZnNfbm90
aWZ5X2ZhaWx1cmUoKQ0KPiANCj4gSS5lLiB0aGUgZW50aXJlIGNoYWluIGp1c3Qgd2Fsa3MgZGF4
X2RldiBob2xkZXIgb3BzLg0KDQpPaCwgSSBzZWUuICBKdXN0IG5lZWQgdG8gaW1wbGVtZW50IGhv
bGRlcl9vcHMgaW4gZmlsZXN5c3RlbSBvciBtYXBwZWRfZGV2aWNlIGRpcmVjdGx5LiAgSSBtYWRl
IHRoZSByb3V0aW5lIGNvbXBsaWNhdGVkLg0KDQoNCi0tDQpUaGFua3MsDQpSdWFuLg0KDQo=
