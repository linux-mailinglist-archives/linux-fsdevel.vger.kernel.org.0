Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D298B4DA64D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 00:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351738AbiCOXeu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 19:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236864AbiCOXes (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 19:34:48 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8262B1A1;
        Tue, 15 Mar 2022 16:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647387215; x=1678923215;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aeJ9G/vBC9Kw+cnDBwd/G0lX+CcJ23yAONq3/TKMoQg=;
  b=gj6TO6UEbMtl7LH/vAlamimkzcZ6vm674FVgTlwuxl8LRcvDDqm9oS4v
   7+ZPlH8IXB/pqx0mmPvJCB+w0zod5W0R89gX4AtmJqlpTnjtAgFYUqMRE
   BZXDJA/sXaOgyNH8uNxX18ft1n8C+609Kv2PXKuQGFB2ICkkiXwPga8Le
   9d+qsgnT1V/fiLEJheCbqzYRFxmpZwqYdrZAPQDLLYXqKLL+P7AQvvBO1
   mzJMsSpWJiK8SYkzje8PWMSTl5CnW+7W2b6TddJYIkDonMOg9jrFKfOnw
   bvHCZuHLa42XvcEis/MsdfDE2ql3M4osjVFiHBs126jdcJdUgn60T+UY+
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="238611889"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="238611889"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 16:33:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="690378252"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 15 Mar 2022 16:33:34 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 16:33:34 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Tue, 15 Mar 2022 16:33:34 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Tue, 15 Mar 2022 16:33:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDm+V6GLf8TNVgxTC6Lb+0WbKHLXRrfrTb18Rhm5lPuwYi6/r4xyhywMI5WCdWK4oQDyksC02BuHiZOKfEJ7A6zFaJBnOULnG+8u9HIglDMv8xk3/pAbEc4xAalrwBFwnMilGTWkWLH2smXXPoBYtpbF9CiOoFCQcJ6Tkg2QRaZN90KnzBAdnORdYpfjT9LhY0n534iM1blZGSFR9WujJ97BN9WXKGeg37nvQnWesjY+XJ2hfGebzy4imv1JnmNtOg4WJBfpSKt/NLT7YOT829J1wPmSFxMsRqC6zdhkziu2dSQg1YMq594StxXmyAyVNAIW0/RoohjsxsBFnwrR1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeJ9G/vBC9Kw+cnDBwd/G0lX+CcJ23yAONq3/TKMoQg=;
 b=CF+8IAYNg/pYOZbdcXbi7gCTlVpR95HA1C07whVqYU2Y5+JSgcJno/yDgid4/DGRaN7G5+j1UzxL2vmupD/TAch/a1pvKPY13PcEH4EcRFGAZK2TMuMdYtodsEbyauZH/49v0V9Hb7WkIYmN43Bm0INpZO51YR6xSxtBEpwBxVGpwcuuSJIKFkaowllUnQrn1MjXFbvehU4SOKcxDkVAMs9qA+rM9YZsnF9egplafEIUB5ss3og3eGXxgVpW79vfpitQ9kQwLy6dVc5s8pW6cVgsyPia4T5NM/gDMwGFZeGZ4GEJc1h3z+ebQnvbp+84Qbt3ScsAEXR+dH6IrcWXUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SN6PR11MB3232.namprd11.prod.outlook.com (2603:10b6:805:be::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Tue, 15 Mar
 2022 23:33:31 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::c1ac:4117:326:eff2]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::c1ac:4117:326:eff2%3]) with mapi id 15.20.5061.029; Tue, 15 Mar 2022
 23:33:31 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "ebiederm@xmission.com" <ebiederm@xmission.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Brown, Len" <len.brown@intel.com>
Subject: Re: [PATCH 1/3] x86: Separate out x86_regset for 32 and 64 bit
Thread-Topic: [PATCH 1/3] x86: Separate out x86_regset for 32 and 64 bit
Thread-Index: AQHYOKnIB2wsd8uW6EiQs+9kCgApRqzBEDIfgAAIogA=
Date:   Tue, 15 Mar 2022 23:33:31 +0000
Message-ID: <f6f7efdf860fcf9bb117698bdc849f364d10b212.camel@intel.com>
References: <20220315201706.7576-1-rick.p.edgecombe@intel.com>
         <20220315201706.7576-2-rick.p.edgecombe@intel.com>
         <87y21ayg51.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87y21ayg51.fsf@email.froward.int.ebiederm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba856e49-1396-44ef-4117-08da06dc3748
x-ms-traffictypediagnostic: SN6PR11MB3232:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <SN6PR11MB32323D490D23B50BAAFBF07CC9109@SN6PR11MB3232.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yDOs0DXr9iuwsMBwQqCDl+m2EMK5Z3HuSt1yrxN8D15VZSg5nh+Rznn7g9qbjo1ta0R5euEWoBYXvHruPytTt4bM1SfiVktWu3bVBfCp0aSse04cA/+vBA7PO9hcFdAcqOaVMNTnQqBd/GWIBu0b8pDzhloUcMo+wVAS4uFGlh7hrmJfJofNU2witk/u9ui4aTjTiv4ILiQYvssPSaUIE1BUMUCNc3dSaKds+7HzGFVAswQ0A0Ic5XFKiqagzKmz3o/oqXDPYufApbOmrQKE+/EJwkKIzJNvri5IvJ8sCWB6dmp2JYzUL29E392wo57WdE0a+yI+V1ZKLkDwvANKqS6dp+FhzsOl0d23EtF4Znaht7WA3XTh4DJnMzWaoN62DQoy8Z2IzJXRnwkg55fM6EAZr8j59azVYuom42paJ3c4+mqi5ZzOjfRq6YCx5wAtDexzLWRVjIwirTHs0icZJHidmthR0BhXXbEt5PCLCvTIyoaam/83o7mOfyYatAnPIomw2cCJGrseO1LJbi8rdvKTcRzAr3M0dJfAkmlvpyk018u9F5999TpgV/s0MXSicyYL0p3SWVzk21Sb1nmrwmdCdwWkLuDd1wzArgKlpAs/d64uGgIs1awN//zoy/nSgvWoWtGpdtzLF+bIODSdODzyMNcUOrFve1zn781u1uXM7EoXwv2c21ZENTLFiD/1ZKa7X2oujtIFE+tZL6ee66mKNsyHDvhSvOxTF6ZUFNQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(66446008)(8936002)(71200400001)(64756008)(66476007)(66556008)(66946007)(508600001)(4744005)(6506007)(38100700002)(5660300002)(26005)(186003)(82960400001)(76116006)(6512007)(6916009)(122000001)(6486002)(54906003)(36756003)(2906002)(316002)(4326008)(38070700005)(8676002)(86362001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGFrK2VZTXkyM2RPWjRGcjBlNDdNNDU3MmZjZlJySUlNRVhVZkp1THY4cHAr?=
 =?utf-8?B?d1ZJU3FwM0NwNFVhM3ZYQ3FCQ1RmNFNPNlB4SVBjeklzaGd1UjhpOGl0VWdF?=
 =?utf-8?B?ZmdNZ0x6dk9VSDFHbHdzMlBZR1dnSUFyYWJ5b1puRE1IZzFPY2xFSHNJUXNs?=
 =?utf-8?B?UlpVOFM5d0g2ZFliOTJMcUl3Szlqb3UyYnIvY0N6bW9ScW5GOXI4QklnTTFn?=
 =?utf-8?B?ZmtEWGhMRld5dy9JazQ1b2R0K1hmRzNCZjNkOWNaY2FQYitmT0p4eTBUN3lS?=
 =?utf-8?B?ckhxVDNDaUZFYm1nWENENUhWdWdkWUdtaC9HZU1sWUJtRlh4bVpydEI0ci84?=
 =?utf-8?B?K0w3MUlsbUVubXJaeUNsOXZaQzR4MXhGTURuOFRxOVM4TkNEZHk2MmV3d1Nu?=
 =?utf-8?B?S3B4SWVHSjNYa3R4ckV2YmN6RVQvR1k2TGtYZXJGcmlTUU02cGlqQlhIMFJI?=
 =?utf-8?B?bXdWZ3hBQThhb0g3czAwK2pNa1VzNktsdFQ4Y1JNZEoweFZpUE9FNW9pWENz?=
 =?utf-8?B?a3J0d3Nhek4rWGZLb2hUQjRwSzlnOWttdEUxMzhRRDdudXpFeG5VNkRidE9X?=
 =?utf-8?B?QktkalMrbmoremtuRCtxaXBXLzZITERHVjRKeDUrL0d5dnJ6SklySWRDMCs5?=
 =?utf-8?B?VWhaTzVUaDhFcXFjbC9qZHh4eGlKR2ZJem1YcmQ2eUhKR293aU9rV29adXlD?=
 =?utf-8?B?elB5d2x4bjJqRFRsdU9pdGwyRG9Gc3dxTld0clR6VUZBOU9vYU9INVlJUTI1?=
 =?utf-8?B?bGtxNWlHMjFoa1pPMTN5L1RiL3JRYnVaV2RpR3diMUtXSVU2Rm0wdytiR0NF?=
 =?utf-8?B?WFhIUEtmajFGZXFDMnVtMmtIQVNBNkhkKzFLRExSWFJRNDBCN0U1MncvcDlo?=
 =?utf-8?B?K0I2c0tKRmdLaUdnNmZZWU1jUUlzM3RzbzQzWHZ0M3JzT3diamVFMnp1aWlN?=
 =?utf-8?B?eGIwUWMzRkMrWHJvVFRVdlRLZkg3UjlhQUN3OEtJTktVbTUxT3BGekxmSmdK?=
 =?utf-8?B?VjRVbWRJa3o4Z0p0bll6YlZXdW9mdkR3clhkK2hxdVhWMytiU0hkRVQvblJu?=
 =?utf-8?B?NzI4czhHMGk4VGFsK3RYRUlZeW5ZbXZsd3FuL3pOdWdEMTBPUVNHZnJjemNv?=
 =?utf-8?B?bmFrdU0zZVUvNGlUNEw5MUJmWXBkU3gxNWZseGdUTnZjZUxva3NYaERCS1F6?=
 =?utf-8?B?YzdpSUFhblNKOG8rR3FuUVBuUjNEUHczaVJybjZRRmFYMEErTjA3blRVNWFK?=
 =?utf-8?B?U2VjNWFWVW9yaXpGNWhzNENWTklSK0cyTW0xVXpCT3kveFlna0lSc2ZzTUt6?=
 =?utf-8?B?M00vaHZKREY5MkhmUWw0UmlNR1RTK2RoNW1FNnkxWGNIVTFsekxMTCtVRTVK?=
 =?utf-8?B?eW5kQXVyOUV6V0xETDQrV1pIYkd3Qmx3bndnaHBHVUdrMTBSajB5VE1nbnN6?=
 =?utf-8?B?ZmhZWDhQYThGcjhwWFNmcmt1K1RVSG9hS0YydVF0bkllYXJlWFFzcCsvbXpE?=
 =?utf-8?B?Y0tPSkJaSjJQY0RGTUZMUmF6V25OOUc2UVgyM0JtUUhHZUxJVUk4QWlDOFBE?=
 =?utf-8?B?ODhlS3orT25WcERFOEw0b2tPMmxBRXBRKzV5S2hxZzFhTm01MGJuZkUrVi94?=
 =?utf-8?B?cXNHSmpVdTdacGRrTGtOZGFjcVRMOUlFU0JYQVFpRCtzYzd5VjBVTmhJZVFD?=
 =?utf-8?B?MHljblVuMzA2Z1hmdmoxNStSdHcyWjlOd3J0S3laUUZINk9MYWlMV2NCb0VO?=
 =?utf-8?B?NWtESnd6YW51TmttbUZ0SnpjTXdBRlJNVnBJTi90NUFhdVdBZXBXdzNxUEE4?=
 =?utf-8?B?dVZ3WERSaURXWk41UW5uSTdMZjE2YnMzV0ZIa1pva3NmK3JrNDRJdVpwbDZZ?=
 =?utf-8?B?WjhoT25PcWRMOEp4MEtWZlFPT1lEWlFjdXVFbHJZajBzM2VFWVJiWDFOY09T?=
 =?utf-8?B?eGd0Q2plSmtoVmNsMWJNbVpFMUpoeHNIU0puVnJ0NzVySXVQejV6MC9aeGJ0?=
 =?utf-8?Q?i/ZAD2IBPsiTUHIDGYvD9u1BorNIU8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8BC764FD3483645969D19D02EC37CB9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba856e49-1396-44ef-4117-08da06dc3748
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 23:33:31.4838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hdqIRqocQMWkhUP1pTvsXiC4IkjMstOqIiiXfq2Yz87N07F7F/naGZ9/3ss+6HgAiV3RsxOP5bmLtrfmb6pVj7lFHVnjKuYhXz/hdISw3W4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3232
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCAyMDIyLTAzLTE1IGF0IDE4OjAxIC0wNTAwLCBFcmljIFcuIEJpZWRlcm1hbiB3cm90
ZToNCj4gU28gSSBhbSBsb29raW5nIGF0IHRoaXMgYW5kIGFtIHdvbmRlcmluZyBpZiB0aGUgZW51
bXMgc2hvdWxkIGJlOg0KPiANCj4gZW51bSB4ODZfMzJfcmVnc2V0IHsNCj4gICAgICAgICBSRUdT
RVQzMl9HRU5FUkFMLA0KPiAgICAgICAgIFJFR1NFVDMyX0ZQLA0KPiAgICAgICAgIFJFR1NFVDMy
X1hGUCwNCj4gICAgICAgICBSRUdTRVQzMl9YU1RBVEUsDQo+ICAgICAgICAgUkVHU0VUMzJfVExT
LA0KPiAgICAgICAgIFJFR1NFVDMyX0lPUEVSTTMyLA0KPiB9Ow0KPiANCj4gZW51bSB4ODZfNjRf
cmVnc2V0IHsNCj4gICAgICAgICBSRUdTRVQ2NF9HRU5FUkFMLA0KPiAgICAgICAgIFJFR1NFVDY0
X0ZQLA0KPiAgICAgICAgIFJFR1NFVDY0X0lPUEVSTTY0LA0KPiAgICAgICAgIFJFR1NFVDY0X1hT
VEFURSwNCj4gfTsNCj4gDQo+IA0KPiBUaGF0IGlzIG5hbWVkIGluIHN1Y2ggYSB3YXkgdGhhdCBp
dCBlbXBoYXNpemVzIHRoYXQgdGhlIGRpZmZlcmVuY2UgaXMNCj4gdGhlIGFyY2hpdGVjdHVyZS4g
IE90aGVyd2lzZSBpdCByZWFkcyBsaWtlIHRoZSBkaWZmZXJlbmNlIGlzIHRoZSBzaXplDQo+IG9m
DQo+IHRoZSByZWdpc3RlcnMgaW4gdGhlIHJlZ3NldC4gIEkgYW0gcHJldHR5IGNlcnRhaW4gdGhh
dCBpbiB5b3VyDQo+IFJFR1NFVF9GUDMyIGFuZCBSRUdTRVRfRlA2NCBhbGwgb2YgdGhlIHJlZ2lz
dGVycyBhcmUgODAgYml0cyBsb25nLg0KDQpZZXMsIHRoYXQgbWFrZXMgc2Vuc2UuIEkgaGFkIGp1
c3QgY29waWVkIHRoZSBmb3JtYXQNCm9mIFJFR1NFVF9JT1BFUk0zMi9SRUdTRVRfSU9QRVJNNjQs
IGJ1dCBJJ2xsIGNoYW5nZSBpdCBsaWtlIHlvdSBzdWdnZXN0DQpoZXJlLg0KDQpUaGFua3MsDQoN
ClJpY2sNCg==
