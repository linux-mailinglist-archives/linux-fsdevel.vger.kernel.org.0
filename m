Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99365613E30
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 20:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiJaTZS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 15:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJaTZQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:25:16 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FDD12D1E
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 12:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667244315; x=1698780315;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=msQOHppB3lXYppfvIRfgCtehW9aqvZSqXRnqVtrLh74=;
  b=RK3dqDYMIPRBmKMs81ZXmd2Qkwla0isTgxHvP4twfpNoqzNl92SD+UbQ
   WaOTLmkuSWSbOhx7o9/tFs9NPTPb5WaHj+OpRBY4kQUM5xhFHluWvmU4H
   DgEZtkDCAy6YbGcZrmyFy4Iy8P0koAHSW2D8xaqUS/VmpO5VrabyAzkNM
   ffnjPxkVXDzN2+XgIbd74RaNMwsJ+47HWWgCBVJ8DeBMLvRqCJXuankso
   /p4MEQyxo6U2kPCuo8G3gS9YsYvBlETOwCfZAWy9csdcQnrEQMk0769Zi
   fue+gHCOL9L6HzS9YmfMhaGiUb+clfwvnoCxFZFy/mGgg/336B73W2Dsh
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="292277567"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="292277567"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 12:25:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="611600802"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="611600802"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 31 Oct 2022 12:25:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 12:25:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 31 Oct 2022 12:25:13 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 31 Oct 2022 12:25:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kb7AFmQ6CqfmbBO9U0ucXXR+gCgGT49rR1I6fuML1LsnqNtvKqz1Nner7vhmtIIxbzC7Rfvm40lB6J0xkBrOq4Jy5f/ERSYHIrFVIT8+F8gOO576Q27q4YpZ0N9S7+ddyOGQFK8s13mUbIJXuE5vcaJSbESlyQCjshUvW/z8ONfdIGl+vvo2no/9d7XzEE9oexNmkUEfteU9s7KwAF/6zSaf79D/6uSWoC9okGoKPA2T7CslBU4w3pDxev8xMHNyEihWZfviTD93d6a4u0ys7NYw507Q1sm4D9wVFjkWRPvwV7rKKQY4gu+7Ni0oKDpEYGPzIeVZYU5HAun2J6pwOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rasyKy6G0MEjPTYDD5tQAv2JDTP3mbulJKkigyOox+Q=;
 b=fafgajy1eI1YLesEUCM/Cz4qK5GIaSEmm9/yFtvUZVpzHIfoiC0qiWlDEDtnwwi590WIxOxPiR6YCH4da9PhoaZZB+7EaNmxFCxS0NDrnrV6izg2qLqHJfnkCUwkr0AoFp9XdeJiKdB5ZgIxOtkFLrFQrN5j3UYcJovREiHwz6xAIWNSX52HhGjukknaoqZeh8JdUH5CWAL6/v768HoKMAy/Wzm0gQplbItEM3oWV8N4pqHRUCXZzTG6/+G0hKtD+Wgos6/tZY53neNnbmcUQX243zhXwk6UI1mLVyumQfz4sfdr5QVqQihQ7m+fCjGozrJFYD+DAxGlBrB1MbO5aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3978.namprd11.prod.outlook.com (2603:10b6:5:19a::14)
 by DS0PR11MB6469.namprd11.prod.outlook.com (2603:10b6:8:c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Mon, 31 Oct
 2022 19:25:06 +0000
Received: from DM6PR11MB3978.namprd11.prod.outlook.com
 ([fe80::1b68:f941:6705:2288]) by DM6PR11MB3978.namprd11.prod.outlook.com
 ([fe80::1b68:f941:6705:2288%7]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 19:25:06 +0000
From:   "Pulavarty, Badari" <badari.pulavarty@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bfoster@redhat.com" <bfoster@redhat.com>,
        "huangzhaoyang@gmail.com" <huangzhaoyang@gmail.com>,
        "ke.wang@unisoc.com" <ke.wang@unisoc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "zhaoyang.huang@unisoc.com" <zhaoyang.huang@unisoc.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        "Tang, Feng" <feng.tang@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: RE: [RFC PATCH] mm: move xa forward when run across zombie page
Thread-Topic: [RFC PATCH] mm: move xa forward when run across zombie page
Thread-Index: AQHY5Zz4BT/DMcb+H0K5D/9RcgEw0q4o776g
Date:   Mon, 31 Oct 2022 19:25:05 +0000
Message-ID: <DM6PR11MB3978F27D63F743CDA577645D9C379@DM6PR11MB3978.namprd11.prod.outlook.com>
References: <DM6PR11MB3978E31FE5149BA89D371E079C2D9@DM6PR11MB3978.namprd11.prod.outlook.com>
 <Y1Md0hzhkqzik/WA@casper.infradead.org>
In-Reply-To: <Y1Md0hzhkqzik/WA@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3978:EE_|DS0PR11MB6469:EE_
x-ms-office365-filtering-correlation-id: 592d402e-e38c-4a92-8fdc-08dabb759dde
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bNqReun2slXHMfCPaiowfmW1bNQwt474r5QkY+1TM6n6RluksGfnNJX3dMWnuLzL0Qqaf03phd8iuyx/F0pLXsZyGqRBk2NEFCIrRY0Ipd6R44VEgRaK2Sn0JZ/5L6WKgOFaeNqu/b8OYREweoDZNe3+BdA7Mnx/Uh0NgFch3iZdQaCUkH+k2/DBCFG6xuP1gXEPWM1tOlidmVSElkqLvqWFFdSuTWeVD/oM31WEFj6BrZuJ13SWrZGDlslVdBvnX2K0E5Qc5vwBORpFex0a8nf4L5fOb49qv44F95sJLrFhR9ZqqBcE0WKvIp4rnqgGdtLu9WZe4O3BOJTNMiHszjyzIgdhCTPk5a2XfY/V3Z9aIvxr1SoaZHOMW458mZBMmZXhyIcxhSlN4CfxJ+40D5/LxRNdYJXJl12KYvbQkSIjZi6Oe2/+K5ClCgKA2S2GfWci99OSSAzb/lyntxv3OrcqSIAgqDQa4pSGBlqhqrUf8C1E5t2OaesaFBSgfu/cBy3MQgEEhgFci/FZdehJryJ3vrgUv1N0yMqYugMQHgWSeeRfoMRkj4ulvSmrMJx/Uzb25ma1xawSFsR/5n3PKKfrAAPJW2TvCg+AWfq2NBfIPQX7favR31t3qW8t+oxsCLHM3b2ps6DUEhwsWilbvo7fWQByP/r4v18FwvsN6r/mCMUFAxadtx/JlkS5fgP9Pf1b8MoTHcNOCH2qsJTrVNX4yxpdDA5OTg2eHwUrVp5zesWTVX3KRZtdW1w+XzKkKlrx8Z7NezJEFQGyHjqtmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199015)(71200400001)(82960400001)(478600001)(316002)(83380400001)(53546011)(66446008)(55016003)(6916009)(54906003)(38100700002)(52536014)(66556008)(8676002)(9686003)(26005)(122000001)(64756008)(66476007)(76116006)(6506007)(7696005)(107886003)(66946007)(41300700001)(8936002)(33656002)(5660300002)(4326008)(38070700005)(2906002)(186003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aJUQKI80f1VhouGa59Ge2q6XDjzC7+vAIloAZOolWU6/K5+QPj6d4gkQqS6C?=
 =?us-ascii?Q?Gwzqy7u/AV8N0FmItIsRH5zsIl9XfcAwsy4aagp74XRg1FFH7iMhfjD2ZBub?=
 =?us-ascii?Q?cNg3WHKv9CYLO1TIPnxGdGPHw8gsqnmgv/ZWnsT2qVC957GCO8YRcbVgQiIv?=
 =?us-ascii?Q?uOheot1B+qL/ZDbIfHDpiB4C6EycZgJjV9ZtVm6oebC9EjDTUi7nB9J6o/1l?=
 =?us-ascii?Q?9QBAibvpsitlD87bRtc8jI+bvCGvC2SkeT4TcoNgjt+3E5MFDEWEpGyRv9MF?=
 =?us-ascii?Q?F+IrBBwkhDLqhOKMFJflCogCy5XJA5LBDvUe4DwnMBl/zu0Ro9BbZUy31CJ2?=
 =?us-ascii?Q?WNzuDkcEuWfpnJiR4mQJ/W1nweZYvSGEt4EAm0lFZqKhZMpQO0aYYJ0UPB6O?=
 =?us-ascii?Q?pyeCPc2ssysDKRD80ERmhkii3e+7315mH0nqkE9G9h/8qgMwNXaG4bCG+/dj?=
 =?us-ascii?Q?BzJ6vMBdxnBekGSoz3mn8tPz085LjwcVsCzMCPgBXUPGLoBNSHNlyYawhxr2?=
 =?us-ascii?Q?77O5l/WlTjBG7b8FIAx+iy4hXn7Q3qjsknKsx17cOzB8xapQeqT3VjPeizTD?=
 =?us-ascii?Q?fcBUQtCI2ENDMsaAh9FxnhDgKVK5mxbJunalIbENWzJVx/SUSRIasiDSc27V?=
 =?us-ascii?Q?hCUTAjmB9yvSYU44bhNotS64vQBjjlbhr7/b55YL+f9RcfK3CR3S27P01mcW?=
 =?us-ascii?Q?iFLxpyhh3JpdTpZOMNurT2ZSKvCesZkrOuFEKymrXNkEXm2hktK0kmxvWi8v?=
 =?us-ascii?Q?qXDrtfOHXWvf3B1e8sd1mDn9fxPY3xedgP1x+YrZlSF7wBL3zIVU5d6Mi8YJ?=
 =?us-ascii?Q?bMNigszns2UWlrzzQtfJl03JFw2+5wnLIGyDzVDHh/Wk0deJWe9tWysVJUlL?=
 =?us-ascii?Q?ml00WRCUKPAVYxulhaxxJV3RBy6A3aWt7ECxAB0uZYVFprrOI578m0LUrXZ4?=
 =?us-ascii?Q?XqnCxjp72QSWOfAC6aJYvLr8ao47+6P6bqdzAWpHVSzETS9GKvmq+cC/A632?=
 =?us-ascii?Q?TG4gsDW920R4uxU5P57SBcV+TWaQOqR9/sVDv/embH/Hnuei27AcD0x2xbx0?=
 =?us-ascii?Q?yhX2mlfUOfYrFAvhMKSAxgar53puO/5dHtDBEKgZkxW1XvVDI+2GCH/0fADc?=
 =?us-ascii?Q?UNPvLvoWq1H43O/07l7w0AuDaeDLJzp/BNHFGe4PHS67oeHMQH7/MNvFicHG?=
 =?us-ascii?Q?wLuLUC7bNdV6TG/+TS9nvGTrinO43rMXfXdZOSU0RERtD4KtnJkrtkhu+3fV?=
 =?us-ascii?Q?pxEjg03h4GOlf/c975HvE28LLkk+YaVhkYbL971FGnb95CiQwzGBfXaNbEPX?=
 =?us-ascii?Q?AwUM2O7DG71cULVxXCZFZJa527j89Q7ROwV/NaPaBlc8JTaSFQob4zwgOb/P?=
 =?us-ascii?Q?GQDTYeXdRwv6+uhZhb3AkwZO3L1TaCfpGNNdm5FxQF78l1NjVR26Z0qBZ2hI?=
 =?us-ascii?Q?egpoikxHMQn8iH6Ye6a+qx8foRyJbvNqNPbAt0K2Po6rGXOm2g/aFFTKAT+5?=
 =?us-ascii?Q?q60ekGtLkkMtqgxGuHBYH9ZqHnUShEwRErC7uJw7Kw2cdtBw5V7siXPSAuWL?=
 =?us-ascii?Q?jH7mXeuthpAY5FCOSkWTtNe89j9alDaNa1kzL3Cn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 592d402e-e38c-4a92-8fdc-08dabb759dde
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 19:25:05.9898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2QOC/yK3tvH7r7JiDmLCoLVJtzBKFVXavjjV7t/4zS2LOALuRjkObdLICVSBFcAvuGfhCk9D2QxdPiNDePI4TZCRG1PNK1ZKlOf8Rh8LMT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6469
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Just want to give an update on the issue, hoping to get more thoughts/sugge=
stions.

I have been adding lot of debug to try to root cause the issue.
When I enabled CONFIG_VM_DEBUG, I run into following assertion failure:

[ 1810.282055] entry: 0 folio: ffe6dfc30e428040=20
[ 1810.282059] page dumped because: VM_BUG_ON_PAGE(entry !=3D folio)
[ 1810.282062] BUG: kernel NULL pointer dereference, address: 0000000000000=
000
[ 1810.282084] #PF: supervisor read access in kernel mode
[ 1810.282095] #PF: error_code(0x0000) - not-present page
[ 1810.282104] PGD 0
[ 1810.282110] Oops: 0000 [#1] PREEMPT SMP NOPTI
[ 1810.282119] CPU: 86 PID: 15043 Comm: kdamond.1 Kdump: loaded Tainted: G =
S          E      6.1.0-rc1+ #32
[ 1810.282145] RIP: 0010:dump_page+0x25/0x340
[ 1810.282156] Code: 0b cc cc cc cc 0f 1f 44 00 00 55 48 89 e5 41 57 49 89 =
ff 41 56 41 55 49 89 f5 41 54 53 48 83 ec 20 48 85 f6 0f 85 7d 72 ab 00 <49=
> 8b 07 48 83 f8 ff 0f 84 82 71 ab 00 49 8b 5f 08 f6 c3 01 0f 85
[ 1810.282185] RSP: 0018:ff3fae02170637b8 EFLAGS: 00010046
[ 1810.282193] RAX: 0000000000000033 RBX: ffe6dfc30e428040 RCX: 00000000000=
00002
[ 1810.282204] RDX: 0000000000000000 RSI: ffffffffb85ad649 RDI: 00000000fff=
fffff
[ 1810.282215] RBP: ff3fae0217063800 R08: 0000000000000000 R09: c0000000fff=
effff
[ 1810.282225] R10: 0000000000000001 R11: ff3fae0217063620 R12: 00000000000=
00001
[ 1810.282234] R13: ffffffffb85c87e0 R14: 0000000000000000 R15: 00000000000=
00000
[ 1810.282244] FS:  0000000000000000(0000) GS:ff25c2ea7e780000(0000) knlGS:=
0000000000000000
[ 1810.282255] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1810.282264] CR2: 0000000000000000 CR3: 000000552f40a006 CR4: 00000000007=
71ee0
[ 1810.282274] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 1810.282284] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 00000000000=
00400
[ 1810.282293] PKRU: 55555554
[ 1810.282299] Call Trace:
[ 1810.282304]  <TASK>
[ 1810.282310]  __delete_from_swap_cache.cold.20+0x33/0x35
[ 1810.282321]  delete_from_swap_cache+0x50/0xa0
[ 1810.282330]  folio_free_swap+0xab/0xe0
[ 1810.282339]  free_swap_cache+0x8a/0xa0
[ 1810.282346]  free_page_and_swap_cache+0x12/0xb0
[ 1810.282356]  split_huge_page_to_list+0xf13/0x10d0     <<<<<<<<<<<<<<<<<<
[ 1810.282365]  madvise_cold_or_pageout_pte_range+0x528/0x1390
[ 1810.282374]  walk_pgd_range+0x5fe/0xa10
[ 1810.282383]  __walk_page_range+0x184/0x190
[ 1810.282391]  walk_page_range+0x120/0x190
[ 1810.282398]  madvise_pageout+0x10b/0x2a0
[ 1810.282406]  ? set_track_prepare+0x48/0x70
[ 1810.282415]  madvise_vma_behavior+0x2f2/0xb10
[ 1810.282422]  ? find_vma_prev+0x72/0xc0
[ 1810.282431]  do_madvise+0x21b/0x440
[ 1810.282439]  damon_va_apply_scheme+0x76/0xa0
[ 1810.282448]  kdamond_fn+0xbe9/0xe10
[ 1810.282456]  ? damon_split_region_at+0x70/0x70
[ 1810.282675]  kthread+0xfc/0x130
[ 1810.282837]  ? kthread_complete_and_exit+0x20/0x20

Since I am not using hugepages explicitly..  I recompiled the kernel with=20

CONFIG_TRANSPARENT_HUGEPAGE=3Dn

And my problem went away (including the original issue).

Thanks,
Badari

-----Original Message-----
From: Matthew Wilcox <willy@infradead.org>=20
Sent: Friday, October 21, 2022 3:32 PM
To: Pulavarty, Badari <badari.pulavarty@intel.com>
Cc: david@fromorbit.com; akpm@linux-foundation.org; bfoster@redhat.com; hua=
ngzhaoyang@gmail.com; ke.wang@unisoc.com; linux-fsdevel@vger.kernel.org; in=
ux-kernel@vger.kernel.org; linux-mm@kvack.org; zhaoyang.huang@unisoc.com; S=
hutemov, Kirill <kirill.shutemov@intel.com>; Tang, Feng <feng.tang@intel.co=
m>; Huang, Ying <ying.huang@intel.com>; Yin, Fengwei <fengwei.yin@intel.com=
>; Hansen, Dave <dave.hansen@intel.com>; Zanussi, Tom <tom.zanussi@intel.co=
m>
Subject: Re: [RFC PATCH] mm: move xa forward when run across zombie page

On Fri, Oct 21, 2022 at 09:37:36PM +0000, Pulavarty, Badari wrote:
> I have been tracking similar issue(s) with soft lockup or panics on my sy=
stem consistently with my workload.
> Tried multiple kernel versions. Issue seem to happen consistently on=20
> 6.1-rc1 (while it seem to happen on 5.17, 5.19, 6.0.X)
>=20
> PANIC: "Kernel panic - not syncing: softlockup: hung tasks"
>=20
>     RIP: 0000000000000001  RSP: ff3d8e7f0d9978ea  RFLAGS: ff3d8e7f0d9978e=
8
>     RAX: 0000000000000000  RBX: 0000000000000000  RCX: 0000000000000000
>     RDX: 000000006b9c66f1  RSI: ff506ca15ff33c20  RDI: 0000000000000000
>     RBP: ffffffff84bc64cc   R8: ff3d8e412cabdff0   R9: ffffffff84c00e8b
>     R10: ff506ca15ff33b69  R11: 0000000000000000  R12: ff506ca15ff33b58
>     R13: ffffffff84bc79a3  R14: ff506ca15ff33b38  R15: 0000000000000000
>     ORIG_RAX: ff506ca15ff33a80  CS: ff506ca15ff33c78  SS: 0000
> #9 [ff506ca15ff33c18] xas_load at ffffffff84b49a7f
> #10 [ff506ca15ff33c28] __filemap_get_folio at ffffffff840985da
> #11 [ff506ca15ff33ce8] swap_cache_get_folio at ffffffff841119db

Oh, this is interesting.  It's the swapper address_space.
I bet that 0xffffffff85044560 (the value of a_ops) is the address of swap_o=
ps in your kernel?

I don't know if it will help, but it's an interesting data point.

> Looking at the crash dump, mapping->host became NULL. Not sure what exact=
ly is happening.

That's always true for the swapper_spaces, AIUI.

>   a_ops =3D 0xffffffff85044560,
