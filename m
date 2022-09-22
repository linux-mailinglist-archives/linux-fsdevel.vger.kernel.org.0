Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2F85E638D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 15:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiIVN1C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 09:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiIVN1A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:27:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE35DE0C1;
        Thu, 22 Sep 2022 06:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663853219; x=1695389219;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A1WiwNbsKdSmcDRyoGbP9I29qWo1Kpwcr563tFlwFVg=;
  b=d0OJEuKr1Nj9Iz5Msf3ake0GetuYBlXEtAG6oKF221MdLMiVPUpmM4gt
   wwY8EhjTV3XGGuTxPQz+0xUK2DXuA/ZpPVc6O6BoTWTmJGVdGOZJZ+aFj
   a97gzE93SHk1ZyVFQlNVL3MYZugXXJV7eGs8CJZShWerYUfP50kP0vdgy
   cXZp3AaOam5N/0zgbN5j7MnDS+eoSHbM6PP3Afuyuzjh14f0CCoWf1HZY
   cLgF1tNjRGPrPI48rn3Ozi9EHTZk3ItPzwcd3/fqS6UWgFvFLbNx04da/
   V24GdGrwlK81AGYswnqlhVKEpRMDbGyQ5WqVpFHpXERBF8KtifLvtAXXw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="287375823"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="287375823"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 06:26:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="570960833"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 22 Sep 2022 06:26:57 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 06:26:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 22 Sep 2022 06:26:56 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 22 Sep 2022 06:26:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3yqmUEhF9Q30rBhgtVM67xZBMyelx+lXuALKE4Fi72w1JLx0/VkeCOFTUG2MFw545l7LSfmhPmNeHJmTwUFsE/2IKeCXbcf1jbeBoW/TJ5L72fLJ5diGKaN5rsi1HxwGMeEsI9QsKtPlj/oNetWkg2fbQxSN+k6MTeQOvJtBvmMYFPA1qPepVTkkUXW2Mz+iWf1L6DAsI9hluw1A08Z4I9SPpoMdEarIVhMJDVruHwglS9CgHBLBJbfBNJv3wb9V4Si/f7KEL9nXLProQ1iQy+LHH9Pc6F6bQpsFwtvMXCu1Ko3/dzgD7r7+0FRwJ/ZvP9OjvMffGCxvs2c26LTHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/V/BpM80Wz3RlG2xGRwHzb4fAHR5QkpKI2TwgGYIN9k=;
 b=VctWu7z48TmuGXY7pTyq1sHjhi21HSObfklAkb+frGe4NxGvHD6ZwHx/s9nj3+y2EwyBoikN8SA0sCPNIgvaxOrsB1dAfNcaXU62uIEajAW+iqesNkMWF+cFIelSLyu8MRzZKK+CalemNEhibY+0MO7rQpU5SKG8f1WZifGNBO6BLb0JuIeVN9iavykL9kBH4PucYSTfuX2Kthrl28aQdBKBznNWUJRFsSEOA0fBDKSBOSUsPqlw/6dvk528hUjIIfMbgEsnDQzek7ah7iNVLWN9jrryoYH8xmkTfMGln7x3ixdTfqr5oZp5/araBZsMiESJZf5ziU0RaZ13BBkarw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 SN7PR11MB6797.namprd11.prod.outlook.com (2603:10b6:806:263::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.18; Thu, 22 Sep 2022 13:26:47 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::817a:fd68:f270:1ea0]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::817a:fd68:f270:1ea0%7]) with mapi id 15.20.5654.016; Thu, 22 Sep 2022
 13:26:47 +0000
From:   "Wang, Wei W" <wei.w.wang@intel.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Christopherson,, Sean" <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Mike Rapoport" <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "ddutile@redhat.com" <ddutile@redhat.com>,
        "dhildenb@redhat.com" <dhildenb@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: RE: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
Thread-Topic: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
Thread-Index: AQHYyRA+DGITW09wp06ZhgFK30MXVK3mRmjw
Date:   Thu, 22 Sep 2022 13:26:47 +0000
Message-ID: <DS0PR11MB63734D4DF4C4F368805EC97DDC4E9@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-2-chao.p.peng@linux.intel.com>
In-Reply-To: <20220915142913.2213336-2-chao.p.peng@linux.intel.com>
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
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|SN7PR11MB6797:EE_
x-ms-office365-filtering-correlation-id: 2b8b7c74-24b5-41c6-847a-08da9c9e199d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NhzEwMN5COxOHRfOeGkCdKBevsmeRgcD7O1QrWr5bdmTvpnXfgo+ubTNzNvCoeB8aMYGFeVWNFRzvjIXPo2PQYpSmYpZ4fYsQdoRUmDA3K/ZoWWQ6+0fWPT0d662FuOVMBrwQmAQuVtmI8C/6wvKQKSG13qwztkIniszXKyZd1F1iii06q76mheWSDsdPnz6dGvQHKJ9LMydO7CaydTVe7Y8UEVD+Vtr/iBJvC2f8xd0sknScUsWEJcTjkHQby+nWMw92dScWzqLTikNmvNJhItE+ZMFrA2G6qLgW882R6kchIEN01IifT5bISIFdyOW4s90uxKkA5CrOV6uR5CAtVQl5A7MtT/lINtMHnIJ1/rc0anhPMVEdYTGxw0gzCkdtOm2w1dlkh7B/v2CMyut1jVeAo5qCBZzrDBUHqC9AQd12iDq0anTaqvv+8cxZQbx8/1uC15P0MRuGKtIbSkUTXEytdSfSxy9oGjYHoDitsnpa9fHQMB+/8hmazpTVZMeC6u6hHZFgjxeDIUAg5gThB7BcVRwWD1tsGxtHutj2KAVVFAO7/iZo38EhJTnGqDAqD3CJzDuea8GOoEzfo1GUN+phQLw5o2veBjiRxWk+dUj/6+BP+xrEg/O7HWg2yvE9LrfKnytwTz1ULYMPZzHRmz9q6xl/+alh7wcCj40tMTBxyfpZnm5+w6y7KtJqjkP97G4RwaoDZOs3zYvbc2mNqvbrgufPdzZUOa9WWfEFSYpJRkKjau9+ew3JHV+eFK8BnQtjipuWL4VggXfgHOZOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199015)(83380400001)(122000001)(5660300002)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(316002)(4326008)(41300700001)(2906002)(8936002)(7406005)(7416002)(4744005)(478600001)(9686003)(52536014)(55016003)(7696005)(26005)(53546011)(6506007)(186003)(54906003)(110136005)(71200400001)(86362001)(33656002)(38100700002)(38070700005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?58l9LnLH13RvsLPyTi5ybfZN/nsHEy9xWnbf+HfclZpSsa/V24E0MnThuvAZ?=
 =?us-ascii?Q?Hyw255rBOagDttJMMH22wfpqTx4R8CkPg05ZhnwNdHfedFyB6i8JhhDcU2m9?=
 =?us-ascii?Q?U1dgqm4phIL2ofrR4sFfYt0Jt67AcKyYSfRlL7sJDxE7h4rcFf2DjgwPl0Fw?=
 =?us-ascii?Q?M1kTuAojgjuohuR6cqjEJxALLoThkeXwh6ykDZ2yE+R3ou+cqwOKTQS2vqZI?=
 =?us-ascii?Q?bMMSJFvak9RDPAUwgd7m5fpzxbXpLXc7eo2pD6DkCLkR+IcMzm8qA07wP3/I?=
 =?us-ascii?Q?mG5T8GlKsDJJSMaDXIxqzaG2eKVI+aFZw0rOSiQXrgfl3xsbT9C8bHdDT/mk?=
 =?us-ascii?Q?GSTS9AwuSMFdRH5V2bVeubr6RO1RK2/aB6m2i4ZFRXXe2sma3yA3yuCAy37j?=
 =?us-ascii?Q?luPL4B9PBYeKnlxrP1BqqxYU+jX+irj+1yzRpzGSUaI6ZlJUiEy178UkIqAS?=
 =?us-ascii?Q?DiP+VCIXJ3HsUWl0/Vdk2Wb7nSWbrRn73UwrwJkUUpAMtDAL4pe98kIPS5K0?=
 =?us-ascii?Q?jG/vKMnslebubdbbEwWORJ/0dZmws0Uh45n6caWb5GZaMmLohfibUYH/zUMr?=
 =?us-ascii?Q?Nd5jzP8RdDAcvj2yb3JdKGoMlqZV3vM5F/BDhZERFgsFz7Pw8lOaNwRegASS?=
 =?us-ascii?Q?bQq/fJq3g2pD9pDGCRBV8dALtd9qsQ74raDNMZBc8JLbbZaxAAxlOtLw5PHC?=
 =?us-ascii?Q?ain5el9zgdY1lkpd09j1N54AOEX2aQR+CSLo3MWv5kT2S4WRWNF1IMVVbemW?=
 =?us-ascii?Q?bK4bn2DLvZvW6olOQNA8yUzxb+f3O4tBp+XEBbVMrc8KLUAe8dZJay/Kv5AV?=
 =?us-ascii?Q?V4ypi2bSNoBa3JLVZPMezvU44PSHFVj6EGRS3Mpuy06yAbTJcJuVdcj42gXB?=
 =?us-ascii?Q?1i600FrdR+RDkmkjwNsbgVJ8xIPK5CAdOjvt9F074lYJ1PVUibyBQejpHHDG?=
 =?us-ascii?Q?NBtBh1jVsAsflSpT+UZ6K0W76PPiHk5/v9EER/jIT/8jfYGQH9lvTA9RTyAo?=
 =?us-ascii?Q?4rADDsfsOmA0Gafo8fCDa7pVi2F0pfHbrEtOWv3Mlup4jEcgaxqEYKE+vsmZ?=
 =?us-ascii?Q?evv2bepWOMqI255F5pmRqgwqdNLgy3JLsSXTHYLYnxb0QJTPbGOEp/RIRepk?=
 =?us-ascii?Q?Z/vaZB8tug8R4t9NAsgUwRT8iN1pF4Hh3jLeqhKnrqR+ng0asvbfXADHUv/Z?=
 =?us-ascii?Q?OxCr+7sGTVOHIRKVsl2jwgrQcQizD1+mOray53N8TamI2jXbkTy4xc3PHL2X?=
 =?us-ascii?Q?M25my5JKBY4prK8tAG+jVxu4Hln7mzgAqoNbjZTsk4Mlvsbp3DdcjckI59Pz?=
 =?us-ascii?Q?1ll6JLpX01weEHQcWYeoz7Yeaacquu3JALXA2DH/KrxjHeIDKyVoLTkP06Ex?=
 =?us-ascii?Q?SssHOxWOCAV03i7Yqmiq86/5hnV+9D752fC67AR13sIqAhu7Ty4BiC9UiEu2?=
 =?us-ascii?Q?A7Q3ZmK0rgYwSCo+FrgNar76++rl7NbHUiBHXr3rjBmCQtfuEm9s3wpyYR3d?=
 =?us-ascii?Q?9Wr5aUpcGLPvl6POxlmgq3TSxcIhTXM9xZxG6ciB7LmfKkVXEH14dQpZ8CrA?=
 =?us-ascii?Q?i8nnSVYWoQOhBnEc8wTIZRT/G/RMeOuYAgfcAl+m?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8b7c74-24b5-41c6-847a-08da9c9e199d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 13:26:47.4397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zJ1bT3jrDR5NTf6cEgGfc0Ajzx9DHFyx4rO3H+oGMILcO56mnBJjDLrOkC5IQrwAZAe8nhAzCfuFTe8c+Q2gSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6797
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday, September 15, 2022 10:29 PM, Chao Peng wrote:
> +int inaccessible_get_pfn(struct file *file, pgoff_t offset, pfn_t *pfn,
> +			 int *order)

Better to remove "order" from this interface?
Some callers only need to get pfn, and no need to bother with
defining and inputting something unused. For callers who need the "order",
can easily get it via thp_order(pfn_to_page(pfn)) on their own.
