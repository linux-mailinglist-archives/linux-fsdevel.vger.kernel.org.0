Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654193B4A4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 23:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhFYVwR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Jun 2021 17:52:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:4193 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229531AbhFYVwQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Jun 2021 17:52:16 -0400
IronPort-SDR: KBJh1x3Og+eOc6fXNi91zSkTCyXhKblEywJzZyzjvChBRWScDFOjovMm7uMoZ/D9Bt7oSgzZgS
 z4qABlG22bAg==
X-IronPort-AV: E=McAfee;i="6200,9189,10026"; a="204738988"
X-IronPort-AV: E=Sophos;i="5.83,300,1616482800"; 
   d="scan'208";a="204738988"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 14:49:54 -0700
IronPort-SDR: sY18DlgjawEyejdh2EWDiigxqW65u6i+e04as5qmvwcSCm5T4rS7pLChJ+VQuyVoOQvKcx9/7D
 iROPiXB/yQjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,300,1616482800"; 
   d="scan'208";a="455579955"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jun 2021 14:49:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 25 Jun 2021 14:49:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Fri, 25 Jun 2021 14:49:53 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Fri, 25 Jun 2021 14:49:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=miDXhUVl9rXye18FRPFdejnk6cP8aUjjV1O0XYk3EKr6/CaI/924W7J142oMyCWitAH6Q/mNSr18d9HIdgS2ctCsrhRfywHQiyOOpNlN+O0TzsrI6XHuiBiN+rRFLHNlMd54kYW3c6DptzQ7v99u7dhCuXJBkqSyFiDLgjF5TEm7WPZpeLC9zH59A7zfwvAup4F7ldyKNFA0U7GjYnI9wU+X+1lPjQal8STJeH79YN9R2LjRIzo7406Q/S1umZYlM+m+Y7SsYlL6jbuR5AruqSNM05v53Ojaop9+5ngnM7Y237hBOi/IYd4c+LiILdAYkRGM/pDYPyD3Idr99WDRsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3lo2yECSxCVf5ZNM+dwpjDz8AQHQyBFPtCQ/lM0kEc=;
 b=TeDyC8Bfno+It2x+lgBtFgLMxIrE5rw7RcvG9VSpg1mxylEIehoH2Ip20yYyaAtKrdC9O96vb9I8r5HuhmlxpWMRtK+d4hgxC/gd7twigAi8ywKzECF8igsTbWe1sb5iZkDCskDH7tS5qoF6IgMpCa/flXw6pyP/ZCh+u01fRkBceUnflpvyqk96bR+xyxuE9ViIUwVzDNJeCpoQeROeUBgFmkxskLcqycRIVRRdE8C8IphxUOOIJivUTebUCZEvq178s0exnI0iS/sM0WME7IkCiHmfSeD/ruo9g7Qut1VWhKFThLVtI4rdzavUiFbO7xgZl+hdkL0Dz3PBleOGRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3lo2yECSxCVf5ZNM+dwpjDz8AQHQyBFPtCQ/lM0kEc=;
 b=J7rFAVBfThfDlQG8+ZixhB6JxBUak2KdhF4Eb/NFsF/4kXIIWSxugEl9ZAtRsqAPDma6cTWo0xLlUEKrNPMcaJ2wMq+qBHz7JmNR10UQTZC8DqjjGrQI/huRyxcjZ+UG2zAwCowUM8MLOixfonrzqkDNfHTiYkd7TbqqFtdEq0k=
Received: from BN0PR11MB5727.namprd11.prod.outlook.com (2603:10b6:408:162::6)
 by BN6PR11MB4132.namprd11.prod.outlook.com (2603:10b6:405:81::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.23; Fri, 25 Jun
 2021 21:49:51 +0000
Received: from BN0PR11MB5727.namprd11.prod.outlook.com
 ([fe80::c414:5133:83b0:d0a5]) by BN0PR11MB5727.namprd11.prod.outlook.com
 ([fe80::c414:5133:83b0:d0a5%3]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 21:49:51 +0000
From:   "Schaufler, Casey" <casey.schaufler@intel.com>
To:     Vivek Goyal <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC:     "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
        "dwalsh@redhat.com" <dwalsh@redhat.com>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>,
        "berrange@redhat.com" <berrange@redhat.com>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: RE: [RFC PATCH 0/1] xattr: Allow user.* xattr on symlink/special
 files if caller has CAP_SYS_RESOURCE
Thread-Topic: [RFC PATCH 0/1] xattr: Allow user.* xattr on symlink/special
 files if caller has CAP_SYS_RESOURCE
Thread-Index: AQHXafYvMVmHVcMZ90yko/FN1uomRqslPzsw
Date:   Fri, 25 Jun 2021 21:49:51 +0000
Message-ID: <BN0PR11MB57275823CE05DED7BC755460FD069@BN0PR11MB5727.namprd11.prod.outlook.com>
References: <20210625191229.1752531-1-vgoyal@redhat.com>
In-Reply-To: <20210625191229.1752531-1-vgoyal@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [97.126.110.20]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b498fb35-216e-4b19-e4e0-08d938232953
x-ms-traffictypediagnostic: BN6PR11MB4132:
x-microsoft-antispam-prvs: <BN6PR11MB41323ECD3AEC546382411D37FD069@BN6PR11MB4132.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LTf2GzmC9dm69E6iOFcXSGXoHmO1aHFxdqcSO3GXEgk9F/cea8WbB3ZSrCCGE0ccNOonAjUYlrW4H2FhdQ+1QFnEyb+XVTdnXgYDQjFbKjt5tWgtKz+CHw6Z8h2wSloLYY1JJs4uUWnqm+eZ31CSZx0fWSsklUxsWKsbDIStl9ht50VhjHHtCWffyIeJOF0DYRCWUy7R/Q6gKpv5PJ8ZB3J9qvr2iDuQsFdrMFHqryIQ469JJBrxFDCMygqCYG7ssHV3UWW+xM5dvZN0lU196QnNlWngf2zMMoeanutnS7+HBrGwaz7DJH1m75W4cpmJ0rzjocRa6oH91shmtRajieX6mZlG7e1mm9qkv7uVK4HsGV270PocSGFlzaycIV4HJO5PNzDI0fFs5ZKLLzgmZQxolGBS9dTzg7VcBZTCcfRrmFt+OU2UdrpxeclSSsSDY0c3Iczy2vkXlv2eHuqVZRsw6WPcpA/Vkegmy1cV5zf5FAwFMgGpJ5gd74tZfXJKS8xQHwzFEIWfe1zaBOpViKU96z831RZ5m2qcq3fq0JY0d7PAg3R6QWOFSzWqjxCnpGy0eMJAAX2nSAS2w5bjBLehUpShEmtKkRLCqcM5ChKVssOfHJkpLksi2SILkvQtmvQpibZLJFE8wfGh2uYh5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5727.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(366004)(136003)(346002)(396003)(76116006)(66446008)(66556008)(66476007)(64756008)(86362001)(9686003)(5660300002)(55016002)(33656002)(7696005)(66946007)(6506007)(8936002)(2906002)(38100700002)(110136005)(54906003)(71200400001)(53546011)(26005)(83380400001)(4326008)(316002)(186003)(8676002)(478600001)(7416002)(52536014)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a09TMDdCODJBelFWSFJacy94am5mQ2hKQTViWGJLOHdPWGg1d0E4YnNNQ1R4?=
 =?utf-8?B?aUE0M05uL0UyRUJNcTlXRVFvS0VBNDVpb0hpZ1F0S052eHpGZ0xjSzByNDlO?=
 =?utf-8?B?UitsZkRjSU41MmVFUmxRS3Zac1loeE9iUnhPQzY3SE1tUGtMUDdBMFJBNmxG?=
 =?utf-8?B?SDErOWtHNWVHd0NqL1l6SWp5cFE5c1A1SzBJMkM0ZmRqTE5jeGVWbjlmNGpM?=
 =?utf-8?B?cE1wMG9vS281ekU3N05hcTdiZllCYTk0NS9Wbi9uK3AwSHh4K2lXbERCbzBG?=
 =?utf-8?B?SjMrK1JrVjV5UkVMT3dsTmJMTEZtOHN0TEhLTTRLbjFacExzNUtzZHZWV0t5?=
 =?utf-8?B?bmFrbjB5Q0QyRXo3ZTE0Mi93UTRCWEtOQW56d29JSGxTRVRYazArVkZmc2hP?=
 =?utf-8?B?dkNWa0p6aU44RnowcFdUbUZSRkZsYzgxbWVGK3hVbnJiWmpRWmdjSXRCVERJ?=
 =?utf-8?B?NFB1aDRtNVQ0eUs4V0VYYWVwVnE4cFhUY3dVenN3d1pKZzBub1Q4Tm1vT2tT?=
 =?utf-8?B?NmV0anoyWDdGK2RVWUlXdi9ZL0VUaGlOQ3Q5M2FPTVgzMU9qeGViY05nSXpv?=
 =?utf-8?B?b0ppRVVGdTZsVWwyYnFNTHlLTE55NkxLbEFBY0FUQis3UDZVbHg4bjJyeEQx?=
 =?utf-8?B?RzhyamwzYUVwRmhMNmZmcEliK3d3ZUd3N1h6MytyM0p5VE5mWmRTd0w5K0M3?=
 =?utf-8?B?ZUZhOWlvOFFWTFRjUXp1Z0FqbDFsN2syVjZLdWxnTGUzV3pncmtERk5ONWN5?=
 =?utf-8?B?YzNoTG9naTZMYWM2aFVLMXlscUNZTnZFUDd6emtBRnNvaUJlMk01bnNJcDdw?=
 =?utf-8?B?MFROR2ZBeDM3TlVsRHJSaW04ZDBsb1VNKytRT1Btei9SRFVEZnc5ZzF4OGhh?=
 =?utf-8?B?cVZUZlM0NUxjODRiamVtYzdmc1VYTGE1VGpGTkJhVDIydTMzcGYxejR5bnpU?=
 =?utf-8?B?Sy8zYlFON0x4Nm52K1k4YVlWejVLc1BBV2FGZE50WWkzVWZ0Mzl3MzVCdG9E?=
 =?utf-8?B?YzFFalY3TmV1aDhCdnpGcTdCcXhMZzdOZkJ6QTVQa0FXUHdla1grcnBHczRJ?=
 =?utf-8?B?d3dQSHNYMFZNQ1BxV3F3MU51U2kxS2gzclYzRW1JaUtOTGRMUEVQSGJaSjRi?=
 =?utf-8?B?QytCSVlMdS8wc2JxTXJSSnNlTVprSzR5aktlTXIxK1p1MHlyeHB6WllhNWJ6?=
 =?utf-8?B?UXVYRXc0L2RVdk9HSHBYNSt4ZUxBSkV6R2MvUFRhVXNraEIzVmtPUnJpSnZo?=
 =?utf-8?B?aE5iYThUa1hpMUQ5OVM5VXRpMlo1Y3ZmL0ttUjBySm4zN2szRFFUakZ3Sit6?=
 =?utf-8?B?V1daa3FDMXdtS0hYeERndEdZcHI4MGlRNWhDMnRZd0hmUitVVUUvNTJvNys2?=
 =?utf-8?B?eW43SVdvOE1ZcEN4RnU1a1dLemJMcEcxK2dGR2pCMTFWWHFjcjVha2xzT2ps?=
 =?utf-8?B?cFpzSWRPMEo3YVpmMml4cGxjUnljWlplazdObHBVSHlRbWN2OTFjQkZxay9D?=
 =?utf-8?B?SWdTR1p6UFdpQkF3ZnhzR2FWdE0vQmZtVkhiRVMxR0h2dlRSVEZ1M01WeU4y?=
 =?utf-8?B?ZWpNMit3NmlMQjZmaW1jNEs0OUJtclEzREVyeitqMmNnZi90RTFSWGpqSVJS?=
 =?utf-8?B?Rng5eTQzL2JNaGppSmlRWlR4VWJNK0laRXB6OVIxOWpaaEtaSkUyN2N4c09k?=
 =?utf-8?B?TVlGT1JVMVdxMFJNVVVsd05TZE9FN3kvVWM5ZVBxODhweHBlaU5wZmw0VSta?=
 =?utf-8?Q?rmE5pW6Vp8JjlcU2EQ=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5727.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b498fb35-216e-4b19-e4e0-08d938232953
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2021 21:49:51.6776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: giJcjayQ3F7KmMwWHb0/ETfH6SoVxSuY2D7gjgGCjNnQSTtUdPCwiwyW6k5c7AgTybDmm8kNsYewK5UaL6N0lLYtzh4K2k4qD9RW0cyYbT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4132
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWaXZlayBHb3lhbCA8dmdveWFs
QHJlZGhhdC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgSnVuZSAyNSwgMjAyMSAxMjoxMiBQTQ0KPiBU
bzogbGludXgtZnNkZXZlbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7DQo+IHZpcm9AemVuaXYubGludXgub3JnLnVrDQo+IENjOiB2aXJ0aW8tZnNAcmVkaGF0
LmNvbTsgZHdhbHNoQHJlZGhhdC5jb207IGRnaWxiZXJ0QHJlZGhhdC5jb207DQo+IGJlcnJhbmdl
QHJlZGhhdC5jb207IHZnb3lhbEByZWRoYXQuY29tDQoNClBsZWFzZSBpbmNsdWRlIExpbnV4IFNl
Y3VyaXR5IE1vZHVsZSBsaXN0IDxsaW51eC1zZWN1cml0eS1tb2R1bGVAdmdlci5rZXJuZWwub3Jn
Pg0KYW5kIHNlbGludXhAdmdlci5rZXJuZWwub3JnIG9uIHRoaXMgdG9waWMuDQoNCj4gU3ViamVj
dDogW1JGQyBQQVRDSCAwLzFdIHhhdHRyOiBBbGxvdyB1c2VyLiogeGF0dHIgb24gc3ltbGluay9z
cGVjaWFsIGZpbGVzIGlmDQo+IGNhbGxlciBoYXMgQ0FQX1NZU19SRVNPVVJDRQ0KPiANCj4gSGks
DQo+IA0KPiBJbiB2aXJ0aW9mcywgYWN0dWFsIGZpbGUgc2VydmVyIGlzIHZpcnRpb3NkIGRhZW1v
biBydW5uaW5nIG9uIGhvc3QuDQo+IFRoZXJlIHdlIGhhdmUgYSBtb2RlIHdoZXJlIHhhdHRycyBj
YW4gYmUgcmVtYXBwZWQgdG8gc29tZXRoaW5nIGVsc2UuDQo+IEZvciBleGFtcGxlIHNlY3VyaXR5
LnNlbGludXggY2FuIGJlIHJlbWFwcGVkIHRvDQo+IHVzZXIudmlydGlvZnNkLnNlY3VyaXQuc2Vs
aW51eCBvbiB0aGUgaG9zdC4NCg0KVGhpcyB3b3VsZCBzZWVtIHRvIHByb3ZpZGUgbWVjaGFuaXNt
IHdoZXJlYnkgYSB1c2VyIGNhbiB2aW9sYXRlDQpTRUxpbnV4IHBvbGljeSBxdWl0ZSBlYXNpbHku
IA0KDQo+IA0KPiBUaGlzIHJlbWFwcGluZyBpcyB1c2VmdWwgd2hlbiBTRUxpbnV4IGlzIGVuYWJs
ZWQgaW4gZ3Vlc3QgYW5kIHZpcnRpb2ZzDQo+IGFzIGJlaW5nIHVzZWQgYXMgcm9vdGZzLiBHdWVz
dCBhbmQgaG9zdCBTRUxpbnV4IHBvbGljeSBtaWdodCBub3QgbWF0Y2gNCj4gYW5kIGhvc3QgcG9s
aWN5IG1pZ2h0IGRlbnkgc2VjdXJpdHkuc2VsaW51eCB4YXR0ciBzZXR0aW5nIGJ5IGd1ZXN0DQo+
IG9udG8gaG9zdC4gT3IgaG9zdCBtaWdodCBoYXZlIFNFTGludXggZGlzYWJsZWQgYW5kIGluIHRo
YXQgY2FzZSB0bw0KPiBiZSBhYmxlIHRvIHNldCBzZWN1cml0eS5zZWxpbnV4IHhhdHRyLCB2aXJ0
aW9mc2Qgd2lsbCBuZWVkIHRvIGhhdmUNCj4gQ0FQX1NZU19BRE1JTiAod2hpY2ggd2UgYXJlIHRy
eWluZyB0byBhdm9pZCkuIEJlaW5nIGFibGUgdG8gcmVtYXANCj4gZ3Vlc3Qgc2VjdXJpdHkuc2Vs
aW51eCAob3Igb3RoZXIgeGF0dHJzKSBvbiBob3N0IHRvIHNvbWV0aGluZyBlbHNlDQo+IGlzIGFs
c28gYmV0dGVyIGZyb20gc2VjdXJpdHkgcG9pbnQgb2Ygdmlldy4NCg0KQ2FuIHlvdSBwbGVhc2Ug
cHJvdmlkZSBzb21lIHJhdGlvbmFsZSBmb3IgdGhpcyBhc3NlcnRpb24/DQpJIGhhdmUgYmVlbiB3
b3JraW5nIHdpdGggc2VjdXJpdHkgeGF0dHJzIGxvbmdlciB0aGFuIGFueW9uZQ0KYW5kIGhhdmUg
dHJvdWJsZSBhY2NlcHRpbmcgdGhlIHN0YXRlbWVudC4NCg0KPiBCdXQgd2hlbiB3ZSB0cnkgdGhp
cywgd2Ugbm90aWNlZCB0aGF0IFNFTGludXggcmVsYWJlbGluZyBpbiBndWVzdA0KPiBpcyBmYWls
aW5nIG9uIHNvbWUgc3ltbGlua3MuIFdoZW4gSSBkZWJ1Z2dlZCBhIGxpdHRsZSBtb3JlLCBJDQo+
IGNhbWUgdG8ga25vdyB0aGF0ICJ1c2VyLioiIHhhdHRycyBhcmUgbm90IGFsbG93ZWQgb24gc3lt
bGlua3MNCj4gb3Igc3BlY2lhbCBmaWxlcy4NCj4gDQo+ICJtYW4geGF0dHIiIHNlZW1zIHRvIHN1
Z2dlc3QgdGhhdCBwcmltYXJ5IHJlYXNvbiB0byBkaXNhbGxvdyBpcw0KPiB0aGF0IGFyYml0cmFy
eSB1c2VycyBjYW4gc2V0IHVubGltaXRlZCBhbW91bnQgb2YgInVzZXIuKiIgeGF0dHJzDQo+IG9u
IHRoZXNlIGZpbGVzIGFuZCBieXBhc3MgcXVvdGEgY2hlY2suDQo+IA0KPiBJZiB0aGF0J3MgdGhl
IHByaW1hcnkgcmVhc29uLCBJIGFtIHdvbmRlcmluZyBpcyBpdCBwb3NzaWJsZSB0byByZWxheA0K
PiB0aGUgcmVzdHJpY3Rpb25zIGlmIGNhbGxlciBoYXMgQ0FQX1NZU19SRVNPVVJDRS4gVGhpcyBj
YXBhYmlsaXR5DQo+IGFsbG93cyBjYWxsZXIgdG8gYnlwYXNzIHF1b3RhIGNoZWNrcy4gU28gaXQg
c2hvdWxkIG5vdCBiZQ0KPiBhIHByb2JsZW0gYXRsZWFzdCBmcm9tIHF1b3RhIHBlcnBlY3RpdmUu
DQo+IA0KPiBUaGF0IHdpbGwgYWxsb3cgbWUgdG8gZ2l2ZSBDQVBfU1lTX1JFU09VUkNFIHRvIHZp
cnRpb2ZzIGRlYW1vbg0KPiBhbmQgcmVtYXAgeGF0dHJzIGFyYml0cmFyaWx5Lg0KDQpPbiBhIFNt
YWNrIHN5c3RlbSB5b3Ugc2hvdWxkIHJlcXVpcmUgQ0FQX01BQ19BRE1JTiB0byByZW1hcA0Kc2Vj
dXJpdHkuIHhhdHRycy4gSSBzb3VuZHMgbGlrZSB5b3UncmUgaW4gc2VyaW91cyBkYW5nZXIgb2Yg
cnVubmluZyBhZm91bA0Kb2YgTFNNIGF0dHJpYnV0ZSBwb2xpY3kgb24gYSByZWFzb25hYmxlIGdl
bmVyYWwgbGV2ZWwuDQoNCj4gDQo+IFRoYW5rcw0KPiBWaXZlaw0KPiANCj4gVml2ZWsgR295YWwg
KDEpOg0KPiAgIHhhdHRyOiBBbGxvdyB1c2VyLiogeGF0dHIgb24gc3ltbGluay9zcGVjaWFsIGZp
bGVzIHdpdGgNCj4gICAgIENBUF9TWVNfUkVTT1VSQ0UNCj4gDQo+ICBmcy94YXR0ci5jIHwgMyAr
Ky0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IC0tDQo+IDIuMjUuNA0KDQo=
