Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9EF5BA2FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 00:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiIOWu7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 18:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiIOWu5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 18:50:57 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFF14DB51
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Sep 2022 15:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663282256; x=1694818256;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QNko31aa+FdmahYizNR0c8/KDKNLEIInUJRVx5w8ciQ=;
  b=Q6xO6XAXKHgK2+0k+qMNkrUgDPAV5ul7hEOqDNcJ1tpYSegFyrGvKV9P
   KXMkXqyfGVoo/SPoLarEmXtH9qqaAsJ7BJGJjeBXUdsYaKNt1KkdfHuVA
   EIXk3FWh0JOU7Q54DF90ankJ2DXDPBnVNwGbKU1NhMnvKyFwg5vNeYLLX
   1vxYjF8HE6jdHjP+/s9AwPYqfUNJFiBn6paI5K7e9NReI57g4qrQ5OpSh
   lB+gcYmIA6YcM35odexH4+BrdkF23uBacqlSX/x8DCu4HF3HcIdQvs2zT
   mkOW859eNrsBWOiFMoBS1sybmsFk++BMLqqtf78dNtILJHCN+o/8/peYP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="360601164"
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="360601164"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 15:50:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,319,1654585200"; 
   d="scan'208";a="679732855"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 15 Sep 2022 15:50:50 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 15 Sep 2022 15:50:50 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 15 Sep 2022 15:50:50 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 15 Sep 2022 15:50:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0D+iyork4+8c84X41yJ60SR+oNp2NoM+CzawcWuOqsC1eU7SOBvZ9VV1N3i85RfOh3DMWOoRIbAbbBrRx976vORGHMrMjUYD3w4gUrNHs2GoqlJ5Gq/E/Bk9ld4+TjFGW726vYz2dOhRQ2WTBlSQPzi/EvEPVEtsY8zzFRooENGt9RLuObM173WOBbdaCclTLt11uq2ecVLHJoBwPJRUgHPkffCB+ttU1ExK3nPOxD5hnwSwt29MacrIIs9RL1SPZswFm4OyQFX9YR/iJhyI7G6nv8hxm2Kk4/HOg7omOaZw/q6BVa/A1r6BZUo7h8ial47nemmPoVvQiLKYVPumQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNko31aa+FdmahYizNR0c8/KDKNLEIInUJRVx5w8ciQ=;
 b=B3L6CjUYpJhA/4whKZUT02XzMQyfdeUu8aeYtFzcfHUXrrA9fV81r5Jb/KL4qQ+XheDf5FOiH0jOyBUuh3WGrndAy0dur16zy72pF+vN1eEmHzN8zqS6bEgReVrFDaEzrPjZAIzNBBvoUyWZsbq2pHgETRsDby/nF+oRJV9FMjWNy5gEGyvgTETHSOnRZvex8dEUho8/4qJJFY6NHXrPxuJ1UBWHWaC96EUl5NtUWdEYiYSCEUWZuYCz/21bxRhLg796uhsQ5rO2pVWqR0dZ05gTheGmyc+6OxXcsRci0nv5KvvfXMUvMstuxyWNFl9bbZVhDd43NCzilUu8pgf50g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CY8PR11MB7105.namprd11.prod.outlook.com (2603:10b6:930:53::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 22:50:48 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::10a6:b76c:4fb1:2d60%5]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 22:50:48 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "chu, jane" <jane.chu@oracle.com>, Borislav Petkov <bp@alien8.de>,
        "djwong@kernel.org" <djwong@kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: Is it possible to corrupt disk when writeback page with
 undetected UE?
Thread-Topic: Is it possible to corrupt disk when writeback page with
 undetected UE?
Thread-Index: AQHYyVOZuHnP7uLChkm+T/SiMC7uC63hFndw
Date:   Thu, 15 Sep 2022 22:50:47 +0000
Message-ID: <SJ1PR11MB6083C1EC4FB338F25315B723FC499@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <44fe39d7-ac92-0abc-220b-5f5875faf3a9@oracle.com>
In-Reply-To: <44fe39d7-ac92-0abc-220b-5f5875faf3a9@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CY8PR11MB7105:EE_
x-ms-office365-filtering-correlation-id: c6bda370-e8a3-40a9-30d6-08da976cbb3a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2RxgtJYGvpxxZe4Xl1EiuN8t0Gi4LdaPNZtQ3FZwF1uZFFQr8IujXUpX+Bz+1XYhs4ePWeqjQlN88jI6z7dJRmzrw/bvx15j0ChJ3T/9FjNDYd2GD+8PGA7TdpW9tRvWBBVUhd8BdqbLsSBbrPST1M16wjf6jmQ73mQMdexArjoUwGYcpfLE7jJOa3QGJIsSYvC6QBLd0i02x1uK967mkP0ZY3R/RiTWKF/pmu0olVe2CZd3QOjFjW4MiuZPmep4sOUgujXANJrEG3yYWt4CxH6phXl5fpDNzRyifXy1X31sJFYkjACXteQFfSX/RNUiDotQejFeS1IN2Km44Q0ytTLSbZcyWbpwW4JcVAlaf/yV3TXgz8/tbs5iUfmRGL2rZkAu1MY9iF09E2LKeWoOgFiD3R7CHiYHVz5ECEno8RoLeq+0P9Ikq/W5ZHRjQIOLvcciemhULq94A8YxBoPHx0EOD3BBgGsIpac2TJN2S63TyvpFKmKqzEh+dawj1nAO9vshfFQ2cj4Qoo0yVXV66tJUe2z4HLrwi11T0FF9p/iTpZwAN1lo0D7pSnDMuZuC5FldcGOF03/xqE7SRu0HjNKtoJjdJd2aV7w9TvD0x9T3XKDgd2k/TkVGUo3w5MDrEkutE3YKwjUTh7W/VXYTifnWIDGWRKstgwMGppoP7EFv7RwilT1f15xUhNXdvMEIvRLlmwT/llDqtx5hXhWFLLmpLWcgx//fMGpecyJnwR0hKApkIXgCo7KHPRoLBdpeo3UGughFld6JJUvaKxbcSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199015)(66556008)(54906003)(8936002)(4326008)(66476007)(66946007)(64756008)(33656002)(76116006)(2906002)(66446008)(41300700001)(316002)(8676002)(110136005)(38070700005)(26005)(186003)(9686003)(83380400001)(478600001)(6506007)(38100700002)(122000001)(82960400001)(55016003)(71200400001)(7696005)(86362001)(52536014)(4744005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mm5BajZwTE9uY05qbUhyZTJHYjE0a1RaeFpISStSMWU5NDlieW9OK2F6SU1X?=
 =?utf-8?B?eFR4M2JleTA1a3FhU1I2cHlNYmpxN1o4TjRjcXVTOXUxeG1nUGpSZ1ZiamNt?=
 =?utf-8?B?ZDhNSDMxTTlOMDdaRWhCUCtiQk85eStFMUlOQytValRYaEpTbDdCa2RmTHhO?=
 =?utf-8?B?V2Z4OUVYMzdNb3hmZFdjSU5hRGdaSUZkNkcvUE11eG4rL1lFSXdFYng5T2Vv?=
 =?utf-8?B?eXZNQ1BHWXc5RGZ0czVsUGZEYm1KQUpBU2VqWjFDNE1udjF5aWN0UXZSbEY3?=
 =?utf-8?B?NHdtV3hyRHlVcUNicDhmbDdNejdJczJVK0tUSE9hMzZoTnVtVlNpKzVDd01Q?=
 =?utf-8?B?VzlEdlRuY1lHNGpqMkZJSG1rSmtRZWVwbVMvanhaZE5uT1dYUHhFNDhsTlNt?=
 =?utf-8?B?M0V5MklqaGJGK1kzcWpLM2M5dENEdEI3WnZId3lGYi92S09DOGpONTJXWHBS?=
 =?utf-8?B?ZGE3SG9hYk9SV1h5WThoNXdrUUlLOGo4Zkx3MG5rcm5ZTCttVnkvYTkrSXRG?=
 =?utf-8?B?VEQwc0QvWFJGTFhKT2dXMGFSVmlqdVYxRGtmaFhlL210SkxUMko3Nmx5ZWpk?=
 =?utf-8?B?NlYwWG8vak5WUU03WHNPR2Q5bWNVOUdjVzAwWlFHQzV2c2hxbTFFT3FpVERa?=
 =?utf-8?B?UDU5bmtGZWJKYWloTUhUdTlhdE4wOUVRU003Nmg2eFpYU3NGQ253dEtPK2xy?=
 =?utf-8?B?U0VKTG9HalQwVWtESkRjZEViazBmZUVmU3czdHhyUFlZOVM0TG1SL2NNWHJ0?=
 =?utf-8?B?WGs0aFMyeTd4Qit5SmJ0c2F0Wm9pRWR2YmhBRVhGVVNXbVNyRi9WYXJIWkN2?=
 =?utf-8?B?Ni9KTDh4SUx1VnRNZml2VHZCRnNZWVdzQW5sTnE5UE5IT0phams5TjEyZytS?=
 =?utf-8?B?SnZJOUJLbStqbmo2cEwvUnlMSEtFMUdQbGpCc0UyUkt3bnN6Q3BIV3FacFFU?=
 =?utf-8?B?NVpSTnBic2R6UXAyb0sxc3NuK0RMUGhxamJKK2ZJVGdncWJTb1NVb1J4Z3VE?=
 =?utf-8?B?dTAzYzg3blZhQnNtYlkrVUdxVlFhK3kzZGNCSjNtdlUvckxGVnN2czVzVEVR?=
 =?utf-8?B?eHpFbmdJK1RUUWhBVTFEVVhHY254R3JoRk4yQ1d2K09TbVZZaVFaekZyMDFH?=
 =?utf-8?B?QkZHemtOQjU2NWpNRzA5YVY2WU1LamhWN29oZkRXTU1EVkZXczRoUXJDcXNI?=
 =?utf-8?B?SGRiTnZMV0xZMTlqbFBlRmxlc1d1RmpmeDU1c0VpN3hHU1p0Z2FEY0JjZ1NW?=
 =?utf-8?B?Unc2Z05KMmtHbE52ZTZDeUdrdm5IaS9UcEl3MmFJUmRGcEpSS09rUlFlNURF?=
 =?utf-8?B?cjNKWmpoeGFEdnp2TStuazErTFZNLzRObm5vWGZnaVAxVjI2VU9PaTBTQ0sx?=
 =?utf-8?B?dWJWSkxLb3VqMUc4ZDhieS9wSUR1VEMzcEQzZVpjWXdBK3JQallqd3VpZW1R?=
 =?utf-8?B?VkRoSHhGaUhwTGxFdHRaZTRCVFpKL3hhU3NXajJRcjBsRUZoNU1SMnQ0cGtF?=
 =?utf-8?B?MXBjMVFJM3diYWorT1o3aFpDMk1XWDh4cHlTUzhHYS9sb2t5VXVBSnVkUHZp?=
 =?utf-8?B?K241NkgxQ0s5a1VBWmdudTIxb0tnais1SDFNeTNSVGNIbkZzQ3lFSFRia3hT?=
 =?utf-8?B?WWQrYVR1ZEZ2dER3QmpiMkpVSUlJTGdmSjZlOEM4cFFBdUJUWTI1ZnhmK0tu?=
 =?utf-8?B?TjFteDkwK3B1cGxDVzBVOUI2cjFieG5yamt1SWE3SlhxUVZoVUx5OHhYM0Va?=
 =?utf-8?B?K2x1NHQ5YVdvZjBlcjh4R2ZKK05hMTJrdHJKYVJ3aEdPVEF4R2NKVFVUYTd0?=
 =?utf-8?B?Uk1ycG4wMXVld1FvNGlrSS9MbnplU1pTSitKVVlUWFZDRnNaUUp5OEdVUVNT?=
 =?utf-8?B?SEdRdjRxK0k2L3NzZDY1QTJzL0prd01QaHJXY21ka0J0ZFhXWTI4STN3ZkpT?=
 =?utf-8?B?bXF6OUdLSXJncmJWTTlmSVVQYmZHOWdyYitiSjR6K2thdjMzNm5BWm5Ya2h0?=
 =?utf-8?B?NXNnTUNXZndVU2tHSlNLZytsTmFKMDZrWUFWSXdqMTFkR1FSbjloeGtTUlNK?=
 =?utf-8?B?WnNxenAwY1Z0Q1R6UHFXSTIrKzZkOEJmRUQ4WjBneTlucUxIVk4rMmVwMHds?=
 =?utf-8?Q?8FfjpkbWywALXhsjnGABll/w8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6bda370-e8a3-40a9-30d6-08da976cbb3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 22:50:47.9449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o2So2mVZpor+DuEd8lTKWHcxuBPZlForLYiBKiRH+lGtT1Mb7FUhS7kOKKgxG0SBQlc7N/kPgEuWWRrs6a/NQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7105
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBTdXBwb3NlIHRoZXJlIGlzIGEgVUUgaW4gYSBEUkFNIHBhZ2UgdGhhdCBpcyBiYWNrZWQgYnkg
YSBkaXNrIGZpbGUuDQo+IFRoZSBVRSBoYXNuJ3QgYmVlbiByZXBvcnRlZCB0byB0aGUga2VybmVs
LCBidXQgbG93IGxldmVsIGZpcm13YXJlDQo+IGluaXRpYXRlZCBzY3J1YmJpbmcgaGFzIGFscmVh
ZHkgbG9nZ2VkIHRoZSBVRS4NCj4NCj4gVGhlIHBhZ2UgaXMgdGhlbiBkaXJ0aWVkIGJ5IGEgd3Jp
dGUsIGFsdGhvdWdoIHRoZSB3cml0ZSBjbGVhcmx5IGZhaWxlZCwNCj4gaXQgZGlkbid0IHRyaWdn
ZXIgYW4gTUNFLg0KPg0KPiBBbmQgd2l0aG91dCBhIHN1YnNlcXVlbnQgcmVhZCBmcm9tIHRoZSBw
YWdlLCBhdCBzb21lIHBvaW50LCB0aGUgcGFnZSBpcw0KPiB3cml0dGVuIGJhY2sgdG8gdGhlIGRp
c2ssIGxlYXZpbmcgYSBQQUdFX1NJWkUgb2YgemVyb3MgaW4gdGhlIHRhcmdldGVkDQo+IGRpc2sg
YmxvY2tzLg0KPg0KPiBJcyB0aGlzIG1vZGUgb2YgZGlzayBjb3JydXB0aW9uIHBvc3NpYmxlPw0K
DQpJIGRpZG4ndCBsb29rIGF0IHdoYXQgd2FzIHdyaXR0ZW4gdG8gZGlzaywgYnV0IEkgaGF2ZSBz
ZWVuIHRoaXMuIE15IHRlc3Qgc2VxdWVuY2UNCndhcyB0byBjb21waWxlIGFuZCB0aGVuIGltbWVk
aWF0ZWx5IHJ1biBhbiBlcnJvciBpbmplY3Rpb24gdGVzdCBwcm9ncmFtIHRoYXQNCmluamVjdGVk
IGEgbWVtb3J5IFVDIGVycm9yIHRvIGFuIGluc3RydWN0aW9uLg0KDQpCZWNhdXNlIHRoZSBwcm9n
cmFtIHdhcyBmcmVzaGx5IGNvbXBpbGVkLCB0aGUgZXhlY3V0YWJsZSBmaWxlIHdhcyBpbiB0aGUN
CnBhZ2UgY2FjaGUgd2l0aCBhbGwgcGFnZXMgbWFya2VkIGFzIG1vZGlmaWVkLiBMYXRlciBhIHN5
bmMgKG9yIG1lbW9yeQ0KcHJlc3N1cmUpIHdyb3RlIHRoZSBkaXJ0eSBwYWdlIHdpdGggcG9pc29u
IHRvIGZpbGVzeXN0ZW0uDQoNCkkgZGlkIHNlZSBhbiBlcnJvciByZXBvcnRlZCBieSB0aGUgZGlz
ayBjb250cm9sbGVyLg0KDQotVG9ueQ0K
