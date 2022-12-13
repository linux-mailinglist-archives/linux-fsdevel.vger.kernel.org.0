Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840A764C0E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Dec 2022 00:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbiLMXti (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 18:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236739AbiLMXtg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:49:36 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C516EDB4;
        Tue, 13 Dec 2022 15:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670975375; x=1702511375;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9oZjeGOrwiM0pgvEHLTPAdlofMlPmq7JSJrS9SV2bRY=;
  b=En/ZUnYA+HRCii3hhoP7P5UIBr8HZqqbl+cynnOOJzw6TyRrFf9m14AJ
   o+pm2EP2+yK3Dcp0cP//xRT/dn4LrfxUlXUbsvJX3Tb0mKza658jmsQoo
   PfANnO/zvwa9kcKR3Du6qUbUk6pZDzoLQslQvCkmn647jDfqym0i+90SY
   RmoGeIbK9q3YGf93PnD/vxubt/T8cbqfW/8oLhnhxb45xCZFqGzyjAkeb
   sviwtiWkc05dGYBsNoPZi6uy8+qIeJQ4cIQHIdi7f04Yw4cn37Ww5y4vS
   f7uEcC2TBKMfa4azdvy4/FlLNeSUeD9E8vtBpgNaPtV+xmpLv30KWCgcN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="345336566"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="345336566"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 15:49:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="626512482"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="626512482"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 13 Dec 2022 15:49:31 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 13 Dec 2022 15:49:24 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 13 Dec 2022 15:49:24 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 13 Dec 2022 15:49:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRihj97m41PwR2oMYUfMM3oABGc7hJN5+gdqvwBtuNBbVJLN1zd7Vns01+8qZNv6rYyiM5/kb4SpJzGe4pK8QwL8f71rmEJ6zUZwg85tYie0l01tJa81N+U9y/bOnRSjRz9XFn3ZKdCjHeyRZDpey3Fj4AisVJQzGJMtqnNrSDd1fxVhQZrZJIE8mQfy04IjWSNBWNx+v5IQdyLMzriPmQR3JGao+i/uah/ibyS3RSNk97zAI3wppEuqhaUrA2mOievuQVDW6njZ8J1iuWro0AmS9ZL1+KxqXC18H7mhd7vIhWMuYt2nZwYHYIQV4/PnFnlgyUrqXxtNUQyXv/kfgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9oZjeGOrwiM0pgvEHLTPAdlofMlPmq7JSJrS9SV2bRY=;
 b=ePsTjMe2V4gKvl4ksg2laMH88ahkyGLJxp0HbKwHLT2JxUQbcx83JQMJKqp7iQKMi1bnQ37fIP4gRlqs453d8wS1UMMnWU2rTie3If/5vPyMa2kgLL6CdlXpX87508wDwNHvA+grreWBlMe29syQkdzNjneEkA8sg733ZHzOF+juBSHe+8MdPhRqrMddvzogoVtwaNZaF3XwItK2WBidRJaO4ZqHzcuS5Q/NE6VLCAq1qi64Ptung0Lbn38RcOLOXIFDr2/LC7RtNXRtgvpgR3NHbEhOCWY/ML1HISzMNvYfQhr6vdIp/vtRJGBTjrvvwfEFMH1lbXHTlY2zxkmveQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB6168.namprd11.prod.outlook.com (2603:10b6:8:ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 23:49:14 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::2fb7:be18:a20d:9b6e]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::2fb7:be18:a20d:9b6e%8]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 23:49:13 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "jmattson@google.com" <jmattson@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "tabba@google.com" <tabba@google.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        "michael.roth@amd.com" <michael.roth@amd.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "vannapurve@google.com" <vannapurve@google.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "mail@maciej.szmigiero.name" <mail@maciej.szmigiero.name>,
        "qperret@google.com" <qperret@google.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "ddutile@redhat.com" <ddutile@redhat.com>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "yu.c.zhang@linux.intel.com" <yu.c.zhang@linux.intel.com>,
        "hughd@google.com" <hughd@google.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "Wang, Wei W" <wei.w.wang@intel.com>
Subject: Re: [PATCH v10 1/9] mm: Introduce memfd_restricted system call to
 create restricted user memory
Thread-Topic: [PATCH v10 1/9] mm: Introduce memfd_restricted system call to
 create restricted user memory
Thread-Index: AQHZBhXuq53UEB1w4kqtU0OzCkPOIq5sjtQA
Date:   Tue, 13 Dec 2022 23:49:13 +0000
Message-ID: <5c6e2e516f19b0a030eae9bf073d555c57ca1f21.camel@intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
         <20221202061347.1070246-2-chao.p.peng@linux.intel.com>
In-Reply-To: <20221202061347.1070246-2-chao.p.peng@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB6168:EE_
x-ms-office365-filtering-correlation-id: bca47517-8fe7-492b-5edc-08dadd64a372
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p4ry0rHZVQzeonkmhMHSLwIIMG/3VUDtSkPn2DApSFAd/4cFG+xqOEqX8Z+KIAvOp4iGXIf/BjnHN0hSPgp8EeBjIibmHb3e0t9NDAyNvLf0NnPQXmldnqyurApz2Fw6zcH6JnK8AZ4B7kd6H6gnCKkt8Xfn7QrFhKpgmo79DEghe7epgY8Q262jNK8tHyWF4DnfK/NARPGbHj4iXMuXGo/uTRWswTvADcUYPeLwSNmEUsIQV6JSPZzTy9tOGJQSO3dpIhJq5NDTuc1GWd699CW+zQo6foOurPLlte8o90LIiwG4EImLMAG7NFw+F0C3LYRhMgeBJkbiS0rm9gMfHvXCj3iGhByNfYBybV0KflYZifvFXBI5rqZEocOu6/+AZMfBb7a0CoaqcHLKJdk5WrsTZbZBSuOb0B5bju/8pzG0tDqfnJIOxmzX+RdxneZIuugK/srWhy9qURltjuTzYK8jiFn/OFTijiotbZo9wnsunRW1AxGMaMMZaEebJtZb/eM0LG0z6zYFlXGtllgpElMECvVWpj+sNTIC3tEOp+X5mq834tcoRGvCOJ+IYQg7IudaJeqf0HuYfyASsmq0cFBkSCpt1uNsGQWltbhgPc4Hi1Hf7Jc7bQoLu1VDlWmOp7GVLi8pVsORkUbFxzwmAN047JFmH1SoHOMVLnzRAmSGY/L6OO+rRwS58EgDCC5DRneDTCwRwDjHKG6N1pYrqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199015)(36756003)(38070700005)(478600001)(122000001)(41300700001)(66946007)(71200400001)(2906002)(7406005)(82960400001)(38100700002)(5660300002)(86362001)(7416002)(6486002)(2616005)(66476007)(54906003)(6506007)(110136005)(8676002)(316002)(76116006)(91956017)(64756008)(66556008)(66446008)(4326008)(6512007)(186003)(8936002)(83380400001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUNuYW40REZQb0c0eWgxbU1Va3VhNHF2QituSUV4TEsvRHZsTWd1azJSY2pG?=
 =?utf-8?B?YXQzN3JUMUl4Q3pIVlJER214ZnhFNEdHWGc0QnY1RVJCUUk2T2J1U1Q5S1BQ?=
 =?utf-8?B?VUIvQlorTER0d2RyTkdkdUJpTmhnVHFIQlI3ayt0b1dFRi9hOW5FR1ZHVUpE?=
 =?utf-8?B?aC9pRVFLaDgwQ3JLMmdvakhPSnZlempmL2MvK0hjdytWQTFDTWo2LzdwcU9D?=
 =?utf-8?B?bDVNVE1WRDJrTHFRK2pvN0wvNDc3Y3NFN0dxOWk0NjdSbzVRMVpmcTM5RmV4?=
 =?utf-8?B?ZWozb1E3TlV3UEhPaGhHNFQzNjZOYTRlR0tqRWZ6a3JiZUx3aXR1VThENGtj?=
 =?utf-8?B?eDFRUVc1dStZb1BiaXlyNGxGNUtnNVJGT3pjZW82N1pnSFg4VnNpZWt6ZnRp?=
 =?utf-8?B?emRiOG04K3FwaW5xWXd6a3ZyMWRlRFprRWhaRVdaeWtFaC9Jbi9DQy93RllU?=
 =?utf-8?B?YzlvQWVXU3l5TU91emZzS1lZYXdRZnB6R2lQNExvb2V1YUdLZkFROWdyTmpX?=
 =?utf-8?B?MjB6YkFrak1SL3lHQWk1QVIwazdoU3Q0MUhCSVljdmRvL0RPNGhRTVQwVFVM?=
 =?utf-8?B?dis0WTkwYi8rb0ROZm82UnFDRXE2NUM2RkdkQ1FXTGNiY1NtNzhZU0xnNngv?=
 =?utf-8?B?aVpKdys1SXFKNG52TEN5KzhUVnUxbndrdWV6MGFtWllqNEE3TzZseEhkeHFh?=
 =?utf-8?B?dFQ4LzlLazZZNEZ1VVRNR1VwMlhPTmVlRHFGTFJxNkdGbkNDZksxaHNkOEJU?=
 =?utf-8?B?OE9MQW1Uekt6M0xyT0NVM0dJeVMva3JIb0JDejh6R05HOHE2dS9XM0FGUTlW?=
 =?utf-8?B?TXdLSlBqUy8xY2I3UHRteVJYUUVZbDRoQWoveHRxTUZHdk9ud2dDQW5WNENC?=
 =?utf-8?B?SEZSU2FWME15NndyN0p4WkNaaEZPc252bE52cmlwVmJ6UEFqRXEzZW9JRFdq?=
 =?utf-8?B?RVo4d3hPcVRNbmtRODBZOUNyN3JWV3J1clFpUVBFZlVGSjlvNHBmL3ZPdlZQ?=
 =?utf-8?B?WDg2MHV3RDlkQnRTMDlsejZsa1NFcXV3aS84ZTJ2QXJWVVNUM2o3NGM1d1k2?=
 =?utf-8?B?S1dqZnQ5eUdXODJZdnV5N2JuUlFXTDFjU05qZTVjYkZud1hqRUhtS0I0RnJs?=
 =?utf-8?B?Z05rOWFkNzB3M09rTXVsVXB6TnB1WmJZcmdYMWluSTVmWWNPUUFOMUltUmp5?=
 =?utf-8?B?ODlONUlBTzZhdHQwdUdSSk1ZalVKYU5vNmRaaThuR2hjYiszV1ZNWmlyeFZo?=
 =?utf-8?B?NW1FZi81TTRkZUdxS0FZNzNvNTdqNFJSeHo3SVdVMzQvVmhtZ2w5YjdKTmx1?=
 =?utf-8?B?MzY3RU50UDdFdnhKa1psdEIxQ0JxMjc3YTYzRnQ4V0NCcVZ3ZzVjdVVLMmxh?=
 =?utf-8?B?ZVN6S0Vsc2FOL1RWbU8wazBPTnpJWGNDTm1wSGR3YStrUUJ5K1R0UXZOMk8x?=
 =?utf-8?B?QXY1MHhuSUtJSWlTKzI1bFdkQWN0YjRrREpVd0RnVWhvRkZ6MGZPaVR5RWQx?=
 =?utf-8?B?SDFuZUhHbkRpb2RsZWZVMHZFVk5CWHQ4WW1zTjMzWS9OZGEyWTN6MnVhTWU0?=
 =?utf-8?B?NVd6TzYwVThwTCtXRmVLa3VNYWhLYUZkMFE4S2Jlc1dxVFdYNE5Ta1FMcEx4?=
 =?utf-8?B?NDg5aFRnV0J4bUZqV2EyMFM4dnNqcWhXSm9UTk55Q0NESWRqV0pycjM3ZThK?=
 =?utf-8?B?cFhVNGFMVytleWcvZldndEJoUk1GOHR4eWdka2hlZDIxQ2ErZ01QZVhGV2pq?=
 =?utf-8?B?SzhVK0ZVcDl3WU1FL3Z6WkNJUnRabFVhcmYrbm50NWdEaWZTb0JHRTQ0MkFS?=
 =?utf-8?B?MU55UmxyWEtTWXhxd09DK0FQSkgvWXY2VzJmU1YwZk5RN1lNSW9RbFhrR2Zx?=
 =?utf-8?B?MSthSGtjTVEzdnY3SWU4aFpraFZ3RUdkTFk3dk9NWkVydWZwOThpOW8wTStO?=
 =?utf-8?B?dG5nZXlpWFppellwVXFWMVcwT3hlQThSbVpOMEIvV0ZZVDFSQnRtNlZieHU3?=
 =?utf-8?B?YkZmd2dFUlk0YzFaQzdnd3FSK094R0ZaT1NMVHgzYmRoblRPaUNUcmEycWRJ?=
 =?utf-8?B?SnRYUkhGNUpyRXJacmYxYzJkSXBZVjRoRWR4VnZrL3FFVWRmbkU5eUZNZ3Nz?=
 =?utf-8?B?eFdUM29acGVETnZBdGtsTVVkM1o4bHlWMk9sT3NXaHZyRnRKaEd6a3lpRlMy?=
 =?utf-8?B?UlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F424E400C47EC42861EECF3BE738DB3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bca47517-8fe7-492b-5edc-08dadd64a372
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 23:49:13.4683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D9z33whZ7wM0REESxhtfLqvF5LzhEcBjT4DH50UOk1uvNg2BPkGHfY+a0/nPX1XTQkmBoQvBAMyARNCuOAAzUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6168
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiANCj4gbWVtZmRfcmVzdHJpY3RlZCgpIGl0c2VsZiBpcyBpbXBsZW1lbnRlZCBhcyBhIHNoaW0g
bGF5ZXIgb24gdG9wIG9mIHJlYWwNCj4gbWVtb3J5IGZpbGUgc3lzdGVtcyAoY3VycmVudGx5IHRt
cGZzKS4gUGFnZXMgaW4gcmVzdHJpY3RlZG1lbSBhcmUgbWFya2VkDQo+IGFzIHVubW92YWJsZSBh
bmQgdW5ldmljdGFibGUsIHRoaXMgaXMgcmVxdWlyZWQgZm9yIGN1cnJlbnQgY29uZmlkZW50aWFs
DQo+IHVzYWdlLiBCdXQgaW4gZnV0dXJlIHRoaXMgbWlnaHQgYmUgY2hhbmdlZC4NCj4gDQo+IA0K
SSBkaWRuJ3QgZGlnIGZ1bGwgaGlzdHJveSwgYnV0IEkgaW50ZXJwcmV0IHRoaXMgYXMgd2UgZG9u
J3Qgc3VwcG9ydCBwYWdlDQptaWdyYXRpb24gYW5kIHN3YXBwaW5nIGZvciByZXN0cmljdGVkIG1l
bWZkIGZvciBub3cuICBJTUhPICJwYWdlIG1hcmtlZCBhcw0KdW5tb3ZhYmxlIiBjYW4gYmUgY29u
ZnVzZWQgd2l0aCBQYWdlTW92YWJsZSgpLCB3aGljaCBpcyBhIGRpZmZlcmVudCB0aGluZyBmcm9t
DQp0aGlzIHNlcmllcy4gIEl0J3MgYmV0dGVyIHRvIGp1c3Qgc2F5IHNvbWV0aGluZyBsaWtlICJ0
aG9zZSBwYWdlcyBjYW5ub3QgYmUNCm1pZ3JhdGVkIGFuZCBzd2FwcGVkIi4NCg0KWy4uLl0NCg0K
PiArDQo+ICsJLyoNCj4gKwkgKiBUaGVzZSBwYWdlcyBhcmUgY3VycmVudGx5IHVubW92YWJsZSBz
byBkb24ndCBwbGFjZSB0aGVtIGludG8gbW92YWJsZQ0KPiArCSAqIHBhZ2VibG9ja3MgKGUuZy4g
Q01BIGFuZCBaT05FX01PVkFCTEUpLg0KPiArCSAqLw0KPiArCW1hcHBpbmcgPSBtZW1mZC0+Zl9t
YXBwaW5nOw0KPiArCW1hcHBpbmdfc2V0X3VuZXZpY3RhYmxlKG1hcHBpbmcpOw0KPiArCW1hcHBp
bmdfc2V0X2dmcF9tYXNrKG1hcHBpbmcsDQo+ICsJCQkgICAgIG1hcHBpbmdfZ2ZwX21hc2sobWFw
cGluZykgJiB+X19HRlBfTU9WQUJMRSk7DQoNCkJ1dCwgSUlVQyByZW1vdmluZyBfX0dGUF9NT1ZB
QkxFIGZsYWcgaGVyZSBvbmx5IG1ha2VzIHBhZ2UgYWxsb2NhdGlvbiBmcm9tIG5vbi0NCm1vdmFi
bGUgem9uZXMsIGJ1dCBkb2Vzbid0IG5lY2Vzc2FyaWx5IHByZXZlbnQgcGFnZSBmcm9tIGJlaW5n
IG1pZ3JhdGVkLiAgTXkNCmZpcnN0IGdsYW5jZSBpcyB5b3UgbmVlZCB0byBpbXBsZW1lbnQgZWl0
aGVyIGFfb3BzLT5taWdyYXRlX2ZvbGlvKCkgb3IganVzdA0KZ2V0X3BhZ2UoKSBhZnRlciBmYXVs
dGluZyBpbiB0aGUgcGFnZSB0byBwcmV2ZW50Lg0KDQpTbyBJIHRoaW5rIHRoZSBjb21tZW50IGFs
c28gbmVlZHMgaW1wcm92ZW1lbnQgLS0gSU1ITyB3ZSBjYW4ganVzdCBjYWxsIG91dA0KY3VycmVu
dGx5IHRob3NlIHBhZ2VzIGNhbm5vdCBiZSBtaWdyYXRlZCBhbmQgc3dhcHBlZCwgd2hpY2ggaXMg
Y2xlYXJlciAoYW5kIHRoZQ0KbGF0dGVyIGp1c3RpZmllcyBtYXBwaW5nX3NldF91bmV2aWN0YWJs
ZSgpIGNsZWFybHkpLg0KDQoNCg==
