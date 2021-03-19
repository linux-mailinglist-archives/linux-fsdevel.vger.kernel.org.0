Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4570B3412AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 03:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhCSCSR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 22:18:17 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com ([216.71.158.65]:64306 "EHLO
        esa20.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229736AbhCSCR5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 22:17:57 -0400
IronPort-SDR: zPm2+2pF97Uawy83ONfC05LFNPRQ36uG/xzkeleXDHb8tgMwe9a0MF8/bAQoZt55tjF6IcxVAm
 Zg3OlWY89fu5rjmF6q2P5WwFkeTWR5MBFWVkE0RSVI8B6Zjja3qpmZ5L8TPioLMu+pzRZMLC28
 gO0vOR+71Q4CDdrNuUBJRyIBCCRhBD4mM1EchbSWaHxebOA4rcyK6z3CmaTGPoERzWV+fRhEuk
 5HGWnOnUU7AXzaRZsvy81/1KUA0jD3FpxhbPL6rZAvHEFm9dTZ5pwBnBNbzi/7Ys9aco06FjOI
 WBg=
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="28071189"
X-IronPort-AV: E=Sophos;i="5.81,259,1610377200"; 
   d="scan'208";a="28071189"
Received: from mail-os2jpn01lp2059.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.59])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 11:17:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fw8x9liisHjDbNdOVf7KubHN84gYArYeojF6mbDC469R6yd2wjtfFQu45RKckm+qaF4+QMo98Npe86NmN0vn5ho6D+ixZsSYxPUN1ti8GGUp5wMziaAzo/JQ0Qs3EB2g6ytIzidhdfpGjVcl1RW3/TDkDd5v0CWRjErqJLHAYEba9NV8qZXA/xnK8PHk26KhAqqY8WHiGbefbbjZrJf7FiHabIDPI1v/r8tZC15sn+aQtMlx0JX41/oGvuaAG4EjRBbCvRnSbrdc3jVAH/ueedpcAPlBiImXlSTnNmiwvCJOpL72ngRP/Dbj5Fq/HG8nhvqj4xgdD7V1VkhohK/WGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2F4LqsAZPiy6OnHttdKA01dvnBJHXapPoQs/RrbEhJM=;
 b=NW/ZnZdC8SQ87z2X0pz8gcgD//kTmEQHG7yTGertbiBFaoQ03qcdv6mSWob4Fjy0neDBSjVGy+Z8qFgAskSaz0t2UgVZ1PWYgwdBmPjVvm3lpL6QG+ON0OmSgGF2zHofvPYDBQcpvD6op09A/mEACncYkEZ1/C6+ZNzhS1wZQBsHtPuxaNH+djevB7AYQI5Fm1dvL3ltSIR7NPw/tleJWS0pLleMm2egOyDZZi8UKjLBHZRRy0/gZ3UkO7Ja0slTvh1AJdAOGy/mCzDfJgQf8EhH8MCVU8jpRNPavruPArc1tNKmaV+RpbOYKMKXTtfL7TZAr+9S7dBsUmtStIBfQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2F4LqsAZPiy6OnHttdKA01dvnBJHXapPoQs/RrbEhJM=;
 b=ceVO6aQc1xxsWzP4nfvrooZ3h6Et915Nh3cjWslmt9wbMYdyj80d+DSR3LCDXozbTUoIblkYbnJrhNgK0yoDjz/aB5XXeFUvfz66tbLAXP6M/ZXZhGNw13fFdBaB5GA0LeRrnADGEHKwnRq3RFXPpyeDN1yJ085inamQuAcu1iI=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OS0PR01MB5586.jpnprd01.prod.outlook.com (2603:1096:604:bf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 02:17:49 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::68f4:1e20:827c:a2ca]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::68f4:1e20:827c:a2ca%4]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 02:17:49 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>,
        Dan Williams <dan.j.williams@intel.com>
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
Subject: RE: [PATCH v3 01/11] pagemap: Introduce ->memory_failure()
Thread-Topic: [PATCH v3 01/11] pagemap: Introduce ->memory_failure()
Thread-Index: AQHW/gjzAa5hnh6PaUq187fVBTbxkqp3lL+AgAIDAHSAACKcgIAARgh1gACNxwCABb8rEIAKgTOg
Date:   Fri, 19 Mar 2021 02:17:49 +0000
Message-ID: <OSBPR01MB29208779955B49F84D857F80F4689@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com>
 <20210208105530.3072869-2-ruansy.fnst@cn.fujitsu.com>
 <CAPcyv4jqEdPoF5YM+jSYJd74KqRTwbbEum7=moa3=Wyn6UyU9g@mail.gmail.com>
 <OSBPR01MB29207A1C06968705C2FEBACFF4939@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <CAPcyv4iBnWbG0FYw6-K0MaH--rq62s7RY_yoT9rOYWMa94Yakw@mail.gmail.com>
 <OSBPR01MB29203F891F9584CC53616FB8F4939@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <CAPcyv4gn_AvT6BA7g4jLKRFODSpt7_ORowVd3KgyWxyaFG0k9g@mail.gmail.com>
 <OSBPR01MB2920E46CBE4816CDF711E004F46F9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB2920E46CBE4816CDF711E004F46F9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [180.96.28.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6fc31437-9f03-4cca-a5a2-08d8ea7d31ae
x-ms-traffictypediagnostic: OS0PR01MB5586:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OS0PR01MB558677EF19197E54EB7615EBF4689@OS0PR01MB5586.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6rqyAY+ZpT6uZj2rIajFHn8MhSqCsNudK7LVXsCrUzKZmi4FkqNcK+hnsImJsenvWK+B5uTfULNcXwECr0ZMSNffBw6YRUTb3WW1VXxi7QNk1YL0mcAA44JcGIvXC0MBNZ0u72Q947YcnmJWdbwNqSqQuGpIlGrBZRpM5WTCsqeJKovr5ok7Vhu0ggSiKWhFzpfgVZytPHtRSAfaZqBXPJbNMjnfomthuowqT5pEGe5XbngWiYAQCPpZMcYIWVIw2MKfJ4rUkG+r2lNX5kVrbRyPx9nujEm8dISOCEMuim5tOuHmexH+cSpP/hQtrRbXnbhOma6ru39aAPxFCOXrIOBLG40xfylaaPHMN9FXfxTWDpomBnBxlBA8n0F8AAbKQdtLqxTx2UxSijWlGnYcep7p46/PDHDqJFJnKK++lBOmG+uRamir40Q1da5VNQQQk0tboGuc0BmmOD8za9y/gyXyLrBgUZ/mebfvOFym+cTJ2I+vToXEPV9ir+aWEq4RxhY21H8MtfCtchIMcJYEG/4Nu5pH+AciZgFQw0YvOx06Z+2Rlx/kum/7NBapH1OmYsckb1ygEYHLYNLKlsYczc1jZDsH2GyDJ817uqEuk5U+wF47eYk3FtA5U7F/JHktIjVnwu7SJIqbMAB0L1ExNit/xkRMq67v+IXcEzAru6Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(5660300002)(83380400001)(26005)(85182001)(71200400001)(7696005)(6506007)(186003)(86362001)(107886003)(66556008)(55016002)(38100700001)(54906003)(8936002)(64756008)(66946007)(9686003)(66446008)(2906002)(110136005)(33656002)(316002)(7416002)(66476007)(4326008)(478600001)(76116006)(8676002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?MUg3ek5qR0dLeU12L2FWam1waVYvTjRzQ2x3TFFTLzFEOU4yTmN4MGpscS9s?=
 =?gb2312?B?Rk15QmsxYzJ0NmJabCs0OXlzL1cwY0pIakdWZDUzSTl2Y1pKUHpCeDhST0Z2?=
 =?gb2312?B?Rnd5L0xzbXlRVGdMWGlxdXVVMzRXVFgzMWx6WlVOWU50dDFTcnpZQ1g3aElt?=
 =?gb2312?B?cXVvSy9BNG9MSXM0Mkp3bWVSOW9XSVZIN1d0NzZpSy9XaEVKQnhpNXJVRUJR?=
 =?gb2312?B?cDhnb1RwMlhnd3Y2YzIvNjFtbjNnUFdMdmZnRkJDRkdxREtUbFJEMjFBTEFn?=
 =?gb2312?B?bnVNSThEbFFlYWs0UUlRS2JpZVNuMjFHUmZDUXU3R3gzRXlPSWN2cXlWSFly?=
 =?gb2312?B?VE5Fc2djalM2L0c5b1JYQ2hvK0d3NXN6TjBGMEVjVCtRYkVpbm1PbFVidkhG?=
 =?gb2312?B?S3ZETGlsc3dxdDF0NUtJUHoySElxOU8xSG1ESmgvNDh4QkFrMVlNSWw3VXhs?=
 =?gb2312?B?SE9iTEpPWFhiSlpScHZmbGI3b0M4K3gxVEdXL2tnVE5vM01KcUFISkpKejF2?=
 =?gb2312?B?aGVXUG1paDZTUVc1YmIwc3BLVTREMjRCOXZ6WTExY0hGRklQbUVEOTVNVzJp?=
 =?gb2312?B?YlN6dXdaYS9Gd2Y4enBsQmY2cklITkhOa3VHd3RlblhXam0wMWRZOFRzUFpi?=
 =?gb2312?B?NUNNOGFkOURWSEQ3d3dldW03QktJZ3Y1ZU9TRlpLY3ZpZCt2aThSNGZiOTlD?=
 =?gb2312?B?Z2tzdXlJQzRPY1pwai9QVjVsZWVaUlZ4cUpPSjRwWVdjemppYlR2c2gwK0da?=
 =?gb2312?B?ZEVLMUFYOUZ2L0w0WjF1UFlLVHROdWFUVHdWMlllUnBHNDkxS0Q0MXh6TWVD?=
 =?gb2312?B?Yk5rN1JzRVBMbVNkY2t2dWV0N2tqdXRGK3Z0WVNrblRDMDdqTGw0b2UzL0ND?=
 =?gb2312?B?MFRKaDFNYVVjbUpUdE9UNU8yTy9GTHFMT2tNUTRVSjBEZjlERnB1SFFkUDc2?=
 =?gb2312?B?NER5ZS9QTGtXZEdBSVlqcnpySStmNnZvNTVLNVRMenI0Y1hPNmxaQi9OMmpj?=
 =?gb2312?B?cW1pbXEzSklJSzl5TWtvL04zUWdBRTl5M0FVSGhHdVVIcjVmUFlGZjJhVW9j?=
 =?gb2312?B?N2hOYkNSbTlmSDdpTERlcTVIWURMRUVjU0FhVG1JWXdGemNzb0ZtRWpqOU5H?=
 =?gb2312?B?d1dOZTVxWmF6TjZkWXRaUnNhSnlsTzdwS2xXbFhuUHYyelZQRTBtTFV0NS8w?=
 =?gb2312?B?d0tjT2gvU3NaVzVZelRSQkRXYzM5aDA0QzdBYzU2V2twemlWaEw3YVIxOW1X?=
 =?gb2312?B?MGZndDVoTGpJSnJSZlNnOXc3TWxCdzYwYmRtZW5haXA3VTdjTXpRNnp2RlI2?=
 =?gb2312?B?NDFNei8vYlNZdHh4S1B5SDdBTlJpSjBjRHlXZEg3TmllbGV4Rytib3hYQU9M?=
 =?gb2312?B?SWtkVXk4QStDOGNrRHJsUWEyWnhHMCt4L3pPQ3BQdkpGUlZJNENYTWFHYy90?=
 =?gb2312?B?dzZSWnlMVXkvNHFIMkd5dzFweUlYZTcrdE1nNTIyTDBPaEt2RnQvdmJ1dlZZ?=
 =?gb2312?B?OGRUNjBBazRGeDRuaDBETHJsRkxRZTJpYXREd2pMYWxOOHQ0dE5jVm5FSjh4?=
 =?gb2312?B?dDY3OVhKT1crdnNRTFpsVHVxOE5Wc1lFd2lWQVYyTERiRVhiUVdTZCtJZUFF?=
 =?gb2312?B?MnJHbUtIUU5MV2dEZllBQWx1cWl2VVFLRUZUM051UTlEM2YydlFXbENaQ3pr?=
 =?gb2312?B?Zmo2THZmdHNsMGU3WHBNcURyUHFmeWN5MjB3bEJWZHRLU3NOV0diQ2MxZ2FZ?=
 =?gb2312?Q?nPgsR0DuoBaYxdbSnhkgVB/pG+FMz7qWIWMESSN?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc31437-9f03-4cca-a5a2-08d8ea7d31ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 02:17:49.7406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h9NWQbpQ6JT53B9DiakKDwOlCjixYEn4XWmiNnx92zzDxiaxyZy9GfBCzc+YRrDbHUUkZ9QegUj/cVDrNg1e3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5586
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogcnVhbnN5LmZuc3RAZnVq
aXRzdS5jb20gPHJ1YW5zeS5mbnN0QGZ1aml0c3UuY29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENI
IHYzIDAxLzExXSBwYWdlbWFwOiBJbnRyb2R1Y2UgLT5tZW1vcnlfZmFpbHVyZSgpDQo+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gQWZ0ZXIgdGhlIGNvbnZlcnNhdGlvbiB3aXRoIERhdmUgSSBkb24n
dCBzZWUgdGhlIHBvaW50IG9mIHRoaXMuDQo+ID4gPiA+ID4gPiBJZiB0aGVyZSBpcyBhIG1lbW9y
eV9mYWlsdXJlKCkgb24gYSBwYWdlLCB3aHkgbm90IGp1c3QgY2FsbA0KPiA+ID4gPiA+ID4gbWVt
b3J5X2ZhaWx1cmUoKT8gVGhhdCBhbHJlYWR5IGtub3dzIGhvdyB0byBmaW5kIHRoZSBpbm9kZSBh
bmQNCj4gPiA+ID4gPiA+IHRoZSBmaWxlc3lzdGVtIGNhbiBiZSBub3RpZmllZCBmcm9tIHRoZXJl
Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gV2Ugd2FudCBtZW1vcnlfZmFpbHVyZSgpIHN1cHBvcnRz
IHJlZmxpbmtlZCBmaWxlcy4gIEluIHRoaXMNCj4gPiA+ID4gPiBjYXNlLCB3ZSBhcmUgbm90IGFi
bGUgdG8gdHJhY2sgbXVsdGlwbGUgZmlsZXMgZnJvbSBhIHBhZ2UodGhpcw0KPiA+ID4gPiA+IGJy
b2tlbg0KPiA+ID4gPiA+IHBhZ2UpIGJlY2F1c2UNCj4gPiA+ID4gPiBwYWdlLT5tYXBwaW5nLHBh
Z2UtPmluZGV4IGNhbiBvbmx5IHRyYWNrIG9uZSBmaWxlLiAgVGh1cywgSQ0KPiA+ID4gPiA+IHBh
Z2UtPmludHJvZHVjZSB0aGlzDQo+ID4gPiA+ID4gLT5tZW1vcnlfZmFpbHVyZSgpIGltcGxlbWVu
dGVkIGluIHBtZW0gZHJpdmVyLCB0byBjYWxsDQo+ID4gPiA+ID4gLT4tPmNvcnJ1cHRlZF9yYW5n
ZSgpDQo+ID4gPiA+ID4gdXBwZXIgbGV2ZWwgdG8gdXBwZXIgbGV2ZWwsIGFuZCBmaW5hbGx5IGZp
bmQgb3V0IGZpbGVzIHdobyBhcmUNCj4gPiA+ID4gPiB1c2luZyhtbWFwcGluZykgdGhpcyBwYWdl
Lg0KPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IEkga25vdyB0aGUgbW90aXZhdGlvbiwgYnV0
IHRoaXMgaW1wbGVtZW50YXRpb24gc2VlbXMgYmFja3dhcmRzLg0KPiA+ID4gPiBJdCdzIGFscmVh
ZHkgdGhlIGNhc2UgdGhhdCBtZW1vcnlfZmFpbHVyZSgpIGxvb2tzIHVwIHRoZQ0KPiA+ID4gPiBh
ZGRyZXNzX3NwYWNlIGFzc29jaWF0ZWQgd2l0aCBhIG1hcHBpbmcuIEZyb20gdGhlcmUgSSB3b3Vs
ZCBleHBlY3QNCj4gPiA+ID4gYSBuZXcgJ3N0cnVjdCBhZGRyZXNzX3NwYWNlX29wZXJhdGlvbnMn
IG9wIHRvIGxldCB0aGUgZnMgaGFuZGxlDQo+ID4gPiA+IHRoZSBjYXNlIHdoZW4gdGhlcmUgYXJl
IG11bHRpcGxlIGFkZHJlc3Nfc3BhY2VzIGFzc29jaWF0ZWQgd2l0aCBhIGdpdmVuDQo+IGZpbGUu
DQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gTGV0IG1lIHRoaW5rIGFib3V0IGl0LiAgSW4gdGhpcyB3
YXksIHdlDQo+ID4gPiAgICAgMS4gYXNzb2NpYXRlIGZpbGUgbWFwcGluZyB3aXRoIGRheCBwYWdl
IGluIGRheCBwYWdlIGZhdWx0Ow0KPiA+DQo+ID4gSSB0aGluayB0aGlzIG5lZWRzIHRvIGJlIGEg
bmV3IHR5cGUgb2YgYXNzb2NpYXRpb24gdGhhdCBwcm94aWVzIHRoZQ0KPiA+IHJlcHJlc2VudGF0
aW9uIG9mIHRoZSByZWZsaW5rIGFjcm9zcyBhbGwgaW52b2x2ZWQgYWRkcmVzc19zcGFjZXMuDQo+
ID4NCj4gPiA+ICAgICAyLiBpdGVyYXRlIGZpbGVzIHJlZmxpbmtlZCB0byBub3RpZnkgYGtpbGwg
cHJvY2Vzc2VzIHNpZ25hbGAgYnkgdGhlDQo+ID4gPiAgICAgICAgICAgbmV3IGFkZHJlc3Nfc3Bh
Y2Vfb3BlcmF0aW9uOw0KPiA+ID4gICAgIDMuIHJlLWFzc29jaWF0ZSB0byBhbm90aGVyIHJlZmxp
bmtlZCBmaWxlIG1hcHBpbmcgd2hlbiB1bm1tYXBpbmcNCj4gPiA+ICAgICAgICAgKHJtYXAgcWV1
cnkgaW4gZmlsZXN5c3RlbSB0byBnZXQgdGhlIGFub3RoZXIgZmlsZSkuDQo+ID4NCj4gPiBQZXJo
YXBzIHRoZSBwcm94eSBvYmplY3QgaXMgcmVmZXJlbmNlIGNvdW50ZWQgcGVyLXJlZi1saW5rLiBJ
dCBzZWVtcw0KPiA+IGVycm9yIHByb25lIHRvIGtlZXAgY2hhbmdpbmcgdGhlIGFzc29jaWF0aW9u
IG9mIHRoZSBwZm4gd2hpbGUgdGhlIHJlZmxpbmsgaXMNCj4gaW4tdGFjdC4NCj4gSGksIERhbg0K
PiANCj4gSSB0aGluayBteSBlYXJseSByZmMgcGF0Y2hzZXQgd2FzIGltcGxlbWVudGVkIGluIHRo
aXMgd2F5Og0KPiAgLSBDcmVhdGUgYSBwZXItcGFnZSAnZGF4LXJtYXAgdHJlZScgdG8gc3RvcmUg
ZWFjaCByZWZsaW5rZWQgZmlsZSdzIChtYXBwaW5nLA0KPiBvZmZzZXQpIHdoZW4gY2F1c2luZyBk
YXggcGFnZSBmYXVsdC4NCj4gIC0gTW91bnQgdGhpcyB0cmVlIG9uIHBhZ2UtPnpvbmVfZGV2aWNl
X2RhdGEgd2hpY2ggaXMgbm90IHVzZWQgaW4gZnNkYXgsIHNvDQo+IHRoYXQgd2UgY2FuIGl0ZXJh
dGUgcmVmbGlua2VkIGZpbGUgbWFwcGluZ3MgaW4gbWVtb3J5X2ZhaWx1cmUoKSBlYXNpbHkuDQo+
IEluIG15IHVuZGVyc3RhbmRpbmcsIHRoZSBkYXgtcm1hcCB0cmVlIGlzIHRoZSBwcm94eSBvYmpl
Y3QgeW91IG1lbnRpb25lZC4gIElmDQo+IHNvLCBJIGhhdmUgdG8gc2F5LCB0aGlzIG1ldGhvZCB3
YXMgcmVqZWN0ZWQuIEJlY2F1c2UgdGhpcyB3aWxsIGNhdXNlIGh1Z2UNCj4gb3ZlcmhlYWQgaW4g
c29tZSBjYXNlIHRoYXQgZXZlcnkgZGF4IHBhZ2UgaGF2ZSBvbmUgZGF4LXJtYXAgdHJlZS4NCj4g
DQoNCkhpLCBEYW4NCg0KSG93IGRvIHlvdSB0aGluayBhYm91dCB0aGlzPyAgSSBhbSBzdGlsbCBj
b25mdXNlZC4gIENvdWxkIHlvdSBnaXZlIG1lIHNvbWUgYWR2aWNlPw0KDQoNCi0tDQpUaGFua3Ms
DQpSdWFuIFNoaXlhbmcuDQoNCj4gDQo+IC0tDQo+IFRoYW5rcywNCj4gUnVhbiBTaGl5YW5nLg0K
PiA+DQo+ID4gPiBJdCBkaWQgbm90IGhhbmRsZSB0aG9zZSBkYXggcGFnZXMgYXJlIG5vdCBpbiB1
c2UsIGJlY2F1c2UgdGhlaXINCj4gPiA+IC0+bWFwcGluZyBhcmUgbm90IGFzc29jaWF0ZWQgdG8g
YW55IGZpbGUuICBJIGRpZG4ndCB0aGluayBpdCB0aHJvdWdoDQo+ID4gPiB1bnRpbCByZWFkaW5n
IHlvdXIgY29udmVyc2F0aW9uLiAgSGVyZSBpcyBteSB1bmRlcnN0YW5kaW5nOiB0aGlzDQo+ID4g
PiBjYXNlIHNob3VsZCBiZSBoYW5kbGVkIGJ5IGJhZGJsb2NrIG1lY2hhbmlzbSBpbiBwbWVtIGRy
aXZlci4gIFRoaXMNCj4gPiA+IGJhZGJsb2NrIG1lY2hhbmlzbSB3aWxsIGNhbGwNCj4gPiA+IC0+
Y29ycnVwdGVkX3JhbmdlKCkgdG8gdGVsbCBmaWxlc3lzdGVtIHRvIHJlcGFpcmUgdGhlIGRhdGEg
aWYgcG9zc2libGUuDQo+ID4NCj4gPiBUaGVyZSBhcmUgMiB0eXBlcyBvZiBub3RpZmljYXRpb25z
LiBUaGVyZSBhcmUgYmFkYmxvY2tzIGRpc2NvdmVyZWQgYnkNCj4gPiB0aGUgZHJpdmVyIChzZWUg
bm90aWZ5X3BtZW0oKSkgYW5kIHRoZXJlIGFyZSBtZW1vcnlfZmFpbHVyZXMoKQ0KPiA+IHNpZ25h
bGxlZCBieSB0aGUgQ1BVIG1hY2hpbmUtY2hlY2sgaGFuZGxlciwgb3IgdGhlIHBsYXRmb3JtIEJJ
T1MuIEluDQo+ID4gdGhlIGNhc2Ugb2YgYmFkYmxvY2tzIHRoYXQgbmVlZHMgdG8gYmUgaW5mb3Jt
YXRpb24gY29uc2lkZXJlZCBieSB0aGUNCj4gPiBmcyBibG9jayBhbGxvY2F0b3IgdG8gYXZvaWQg
LyB0cnktdG8tcmVwYWlyIGJhZGJsb2NrcyBvbiBhbGxvY2F0ZSwgYW5kDQo+ID4gdG8gYWxsb3cg
bGlzdGluZyBkYW1hZ2VkIGZpbGVzIHRoYXQgbmVlZCByZXBhaXIuIFRoZSBtZW1vcnlfZmFpbHVy
ZSgpDQo+ID4gbm90aWZpY2F0aW9uIG5lZWRzIGltbWVkaWF0ZSBoYW5kbGluZyB0byB0ZWFyIGRv
d24gbWFwcGluZ3MgdG8gdGhhdA0KPiA+IHBmbiBhbmQgc2lnbmFsIHByb2Nlc3NlcyB0aGF0IGhh
dmUgY29uc3VtZWQgaXQgd2l0aA0KPiA+IFNJR0JVUy1hY3Rpb24tcmVxdWlyZWQuIFByb2Nlc3Nl
cyB0aGF0IGhhdmUgdGhlIHBvaXNvbiBtYXBwZWQsIGJ1dCBoYXZlIG5vdA0KPiBjb25zdW1lZCBp
dCByZWNlaXZlIFNJR0JVUy1hY3Rpb24tb3B0aW9uYWwuDQo+ID4NCj4gPiA+IFNvLCB3ZSBzcGxp
dCBpdCBpbnRvIHR3byBwYXJ0cy4gIEFuZCBkYXggZGV2aWNlIGFuZCBibG9jayBkZXZpY2UNCj4g
PiA+IHdvbid0IGJlDQo+ID4gbWl4ZWQNCj4gPiA+IHVwIGFnYWluLiAgIElzIG15IHVuZGVyc3Rh
bmRpbmcgcmlnaHQ/DQo+ID4NCj4gPiBSaWdodCwgaXQncyBvbmx5IHRoZSBmaWxlc3lzdGVtIHRo
YXQga25vd3MgdGhhdCB0aGUgYmxvY2tfZGV2aWNlIGFuZA0KPiA+IHRoZSBkYXhfZGV2aWNlIGFs
aWFzIGRhdGEgYXQgdGhlIHNhbWUgbG9naWNhbCBvZmZzZXQuIFRoZSByZXF1aXJlbWVudHMNCj4g
PiBmb3Igc2VjdG9yIGVycm9yIGhhbmRsaW5nIGFuZCBwYWdlIGVycm9yIGhhbmRsaW5nIGFyZSBz
ZXBhcmF0ZSBsaWtlDQo+ID4gYmxvY2tfZGV2aWNlX29wZXJhdGlvbnMgYW5kIGRheF9vcGVyYXRp
b25zLg0KPiA+DQo+ID4gPiBCdXQgdGhlIHNvbHV0aW9uIGFib3ZlIGlzIHRvIHNvbHZlIHRoZSBo
d3BvaXNvbiBvbiBvbmUgb3IgY291cGxlDQo+ID4gPiBwYWdlcywgd2hpY2ggaGFwcGVucyByYXJl
bHkoSSB0aGluaykuICBEbyB0aGUgJ3BtZW0gcmVtb3ZlJw0KPiA+ID4gb3BlcmF0aW9uDQo+ID4g
Y2F1c2UgaHdwb2lzb24gdG9vPw0KPiA+ID4gQ2FsbCBtZW1vcnlfZmFpbHVyZSgpIHNvIG1hbnkg
dGltZXM/ICBJIGhhdm4ndCB1bmRlcnN0b29kIHRoaXMgeWV0Lg0KPiA+DQo+ID4gSSdtIHdvcmtp
bmcgb24gYSBwYXRjaCBoZXJlIHRvIGNhbGwgbWVtb3J5X2ZhaWx1cmUoKSBvbiBhIHdpZGUgcmFu
Z2UNCj4gPiBmb3IgdGhlIHN1cnByaXNlIHJlbW92ZSBvZiBhIGRheF9kZXZpY2Ugd2hpbGUgYSBm
aWxlc3lzdGVtIG1pZ2h0IGJlDQo+ID4gbW91bnRlZC4gSXQgd29uJ3QgYmUgZWZmaWNpZW50LCBi
dXQgdGhlcmUgaXMgbm8gb3RoZXIgd2F5IHRvIG5vdGlmeQ0KPiA+IHRoZSBrZXJuZWwgdGhhdCBp
dCBuZWVkcyB0byBpbW1lZGlhdGVseSBzdG9wIHJlZmVyZW5jaW5nIGEgcGFnZS4NCj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gTGludXgtbnZkaW1t
IG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnIFRvIHVuc3Vic2NyaWJl
IHNlbmQgYW4NCj4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZw0KPiAN
Cg0K
