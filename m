Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F927A15F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 08:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjIOGOo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 02:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjIOGOn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 02:14:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80642718;
        Thu, 14 Sep 2023 23:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694758473; x=1726294473;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=HZMbCZelhu36ygYyynRyqeUx95U5zs8SUE7ZZO1LmY4=;
  b=eVcTWnjkCkASoI5OFzbJAOZu5M+AchYmHID8cRavJKuzaaT2VvEr2r3L
   GvLVHLfUQ2xfgjLE608UyOq/kyzrdUqN4PU0VOqQzmtZypTFFrC3NJa05
   bTE8x6LZxUrFwoSVB5EbjZZKtqnO9OwV8fQqdw5fLQxO/xsVtVON6qVAJ
   jdMN/C4B+xMok8/k/AAGzh655wUR45/p061gOyEhWiI7yUNTMykLnNEPi
   v4bV01P4bqTOag2vJwDZZgncjjwHNm/zCG1HJmQzrkcZYzYPqPdwLe7US
   gY9GykRFc3WU8+3hr9XagQDIl+TU8D3M3MArsLqeQu7TpE7IdwcMQClRE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="445627408"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="445627408"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 23:08:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="744842944"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; 
   d="scan'208";a="744842944"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 23:08:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 23:08:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 23:08:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 23:08:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFhyF/HZyVlvjh8N18MdKVcxgoU0y6fYpky+ymsCBme+tRht1HvMfZE570L7aIGt4gwIxksMZ7S04tZ5uGFuP48KwpxHl25hFLMriOehW48m+pAF9AiVhIfwx7TkJRSHHyDuCyGb6qDOerUr/S2hAghoqXdXaytu5SORzzoi0Ug2OWlnf25iVEB5t01g7nrzEhlDJ5ELy9U/GqCApD/qN4lEIy3dbH8wDcNNDWbAJ+JfpLMO6ZyVQiy8tDe7dJjfEfqnv6zrSl0coo05qaeth7CHWqrHFCRXNXBplwYhtHYm9tAectdeocvKxe7QNsaF38cHln60PIHsvNqA/7Iq2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpu28DmXm6A1XkXBryuH7hR7TnWPAtI5Us2qwoMSvw8=;
 b=kNcUModrGUmHPINpDBTFNnILZRyp4nwjBKDXsV6gjAt4gvR+6aDW4D2RYhs2oI8lTRDqmz2Dvzy+4udOWX2aSpqccLQ9EtkzhEptA8Fmv9ld8OFoZYZeI8NoZazk9ybwhJh+b0XhjMWfCfFW5ipzC2c8eXgo05hlMPyatuwiFyyDKD7WDby31c/f2eMwTK6FeIn5w9/L63cr3R17grVjPL0AjvqWVuh6N0xwnvmww8YW42MEEQCwmG6m/NebzcJd6ycLcZ+oqohhLaUbUcTJOAPDEP5uxiz8KDwXejpbH39ZtHWyPyBeAVb5xnMeMEcRoPd/cgAzrUgjgjYaq+/+5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 BN9PR11MB5242.namprd11.prod.outlook.com (2603:10b6:408:133::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 06:08:04 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::5e79:2d52:51e:f602]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::5e79:2d52:51e:f602%6]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 06:08:04 +0000
Date:   Fri, 15 Sep 2023 13:40:00 +0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     Sean Christopherson <seanjc@google.com>
CC:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        "Oliver Upton" <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, <kvm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
        <linux-mips@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <kvm-riscv@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Chao Peng" <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        "Jarkko Sakkinen" <jarkko@kernel.org>,
        Anish Moorthy <amoorthy@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        "Xu Yilun" <yilun.xu@intel.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Vishal Annapurve" <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC PATCH v12 18/33] KVM: x86/mmu: Handle page fault for
 private memory
Message-ID: <ZQPuMK6D/7UzDH+D@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20230914015531.1419405-1-seanjc@google.com>
 <20230914015531.1419405-19-seanjc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230914015531.1419405-19-seanjc@google.com>
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|BN9PR11MB5242:EE_
X-MS-Office365-Filtering-Correlation-Id: 2565bab3-13d1-47da-6156-08dbb5b21f53
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S+zDc2lULBJdvPOkh2FPKWDoTr5B51mLcT74DEhoUXqG8yYN80NbHvB8ZYEkc8cf7X7tX75g6pIQp4K/AL5OCSxTpaZNbj5er3wQP99E4wZTXsrGRg5YCAXPYye8UdGI6zjFpnr55b0gVgFYj6FmTchWPbxO5k29b2z8It7TDX8dfnjgkmhy9n5hwggUxBbmdJzy18DFNEoLscEpl75dPODbZy9M+60YIqMu4U+enKDnp3hcbUeOPifLcocTVmE+Yt8cF2Jd7WoNJYczK6LbW5utZKRO7yl2e03GdzSdofb+Y5qx6zisWOk/50PhyadhjTuNqPAejIFlKx0j1ss0gBah6ntVXOCusL2TyJsiMW4wRrWWlQ3Sfeppy1fk4IbQesmc7XtUfL522hOdT8Wiln20TQRTgkdjbm5m557yQIdcq4xOX/Did/czTPBuEFiSVhBVkWV82uWD4pIgw9TXZFhkgUetNQmSeIhZLbXnruDHY2CF80thYfvvx+GdIfvrowMLDlK/S4M2jSNC30yyagtHjf9OFATUKy709Qgu6CkXo89btOazrOwQhtjjmMKs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39860400002)(366004)(376002)(451199024)(1800799009)(186009)(6506007)(6486002)(7416002)(7406005)(6512007)(2906002)(26005)(66556008)(3450700001)(5660300002)(38100700002)(66476007)(316002)(8676002)(4326008)(41300700001)(8936002)(6916009)(54906003)(66946007)(82960400001)(6666004)(478600001)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oGkly7Efjpo2HEAbxPMZ4aGaRk5erelMBtYaeumhRSf4JPCcurMCNUlhg6XS?=
 =?us-ascii?Q?rR03HAnPXj0TXpRj6S5dCtd9r2fZHRsEZrCNvvh4od2lCl9b0lTcKhKs5L5T?=
 =?us-ascii?Q?vGdOizc0+Bb9ThdIj19RlqORbIW7tNqOnSwuu+GkyXRUz+RjjgvZtvH0HMtG?=
 =?us-ascii?Q?1nqnOgV4aSBAJi4J7QDjZCHKSA34Rnly+gc+2ARRYA9ihvbjk43QxxQRa0as?=
 =?us-ascii?Q?H4Khy39GIXg/rL/EUmC6OQQUBsbGJhdXrfnALvOE339+qenGJS0TD6g4N8sz?=
 =?us-ascii?Q?FFo7rHn+Z/fLfvACJobHwdbiit/APLktfaLTShYpl/aITPD4abUXeLNzb2gj?=
 =?us-ascii?Q?a1w88RH4bHeLOWtbtixiwS1mYr09WDxzFuaMNfxYYmK4S2rjuSvxAkUyYcab?=
 =?us-ascii?Q?9/o6FjexIl0lP+Yj37fGg/jcdiDt6lU/IKLagqRQvUJ33ULbO7u6dWCLO89L?=
 =?us-ascii?Q?Bju9PhWKAbrEod6tC0/rn4abWlVCQ44TVg2qPXYdQndBa6Gh5bdOMB13dfU5?=
 =?us-ascii?Q?+omdo1Afi2bEQ8GF4BLtQb0e4l44o3jX43Y4CBWVD9TinfYHX1cGUILcxdWr?=
 =?us-ascii?Q?bHoLWouNRfzuN1kU11hwKP1xi9fTmDkT2wnfaZU+Al1/2Ud0RHqh6t4bmgCg?=
 =?us-ascii?Q?0WtgrewIRrjHgQYjHDN9FdCu7/ha+Q9nR69xbrCyJ+ctDJlj9cq3I3aEyK8m?=
 =?us-ascii?Q?YoOxA42ph6t331rDokxzABFOas+fJKbADCfrxC4NpOdBh7cxU2UdMokWPUXa?=
 =?us-ascii?Q?jexYETkzp8NV5X9EW7iFP30CKoZC1fpyY969hN69zjhWrOKLL2Rsk0LANxUC?=
 =?us-ascii?Q?xjuFyKpecKlBLcvfrFRBVR7VS1i212OHf6qK24rnTHZCKoOcSfoabZOHUxXo?=
 =?us-ascii?Q?yh85Npo/kTOW7HzVlJgjwu5bmYaEA6mA0LD3tJxB2faWz5lJ7kWat+P9GRde?=
 =?us-ascii?Q?MLEirzmJPCTi+ZKo8leXrRC+ttG2joFcRHg114jxmSBgg0PWQA+Rn+kmj0u2?=
 =?us-ascii?Q?4qURY/EVoGDdPuVZwDm+GxoRAruzKwDrzpuw5QVr1IdpkCkxGvXmIZnUTj8p?=
 =?us-ascii?Q?atWkBapA8ihG8/PXz/IVOqwnNKaY4AfQttxv1Vp5j+GjsKabo3IplExvObGn?=
 =?us-ascii?Q?kY5UZu5DAJuH6eNOpXCk/gFw2VSeYKZER9eztJPRuZ7Hhh+HpFUdWvR9xkE4?=
 =?us-ascii?Q?KNlovuUmfpSLj+IdIiJ025QnXHeT728U4ppH1cXl8Bq4cJf5jk6HGPsTnsjj?=
 =?us-ascii?Q?P+9GymwmG0UFmWCgVww2wzZ7U8h4OS7Xp9vFjSU9MC3pNNlsDwJtS5PfN9SC?=
 =?us-ascii?Q?LiELTa9f0zFLnfZY/IIsWbENc1d2ar13W3PuwXetj100K6LccieSIln8lv1h?=
 =?us-ascii?Q?1YBwPObMB1bYptkBMDuoV5WruEdMGzT6xDvF2JBjIXeSoNtTq6B5C68dQ8YI?=
 =?us-ascii?Q?NhWBBlpJiT/miwAlrVpOzicMpQ9eAWLItd3n+auG63KRdn+IQ1peEcb4nSrd?=
 =?us-ascii?Q?6UEGqT3MjD7LtckP/0+O3PH/7/eVwGgR/nVg4Cg/1t6t4XpCVJ/zAwADOPz2?=
 =?us-ascii?Q?gKG2iP58jk+EdSvqLD+fHoD4iw1lAqQt+g0sN2p3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2565bab3-13d1-47da-6156-08dbb5b21f53
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 06:08:04.0409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3BqdQQt6ZGtrfK54GbYMi54+OeE95wRqXTESwBFb5sP4OU+uWGKyzzSwlaywaLAnTI3P5b9sVJMBR7ffdEqLyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5242
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 13, 2023 at 06:55:16PM -0700, Sean Christopherson wrote:
....
> +static void kvm_mmu_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
> +					      struct kvm_page_fault *fault)
> +{
> +	kvm_prepare_memory_fault_exit(vcpu, fault->gfn << PAGE_SHIFT,
> +				      PAGE_SIZE, fault->write, fault->exec,
> +				      fault->is_private);
> +}
> +
> +static int kvm_faultin_pfn_private(struct kvm_vcpu *vcpu,
> +				   struct kvm_page_fault *fault)
> +{
> +	int max_order, r;
> +
> +	if (!kvm_slot_can_be_private(fault->slot)) {
> +		kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
> +		return -EFAULT;
> +	}
> +
> +	r = kvm_gmem_get_pfn(vcpu->kvm, fault->slot, fault->gfn, &fault->pfn,
> +			     &max_order);
> +	if (r) {
> +		kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
> +		return r;
> +	}
> +
> +	fault->max_level = min(kvm_max_level_for_order(max_order),
> +			       fault->max_level);
> +	fault->map_writable = !(fault->slot->flags & KVM_MEM_READONLY);
> +
> +	return RET_PF_CONTINUE;
> +}
> +
>  static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
>  {
>  	struct kvm_memory_slot *slot = fault->slot;
> @@ -4293,6 +4356,14 @@ static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
>  			return RET_PF_EMULATE;
>  	}
>  
> +	if (fault->is_private != kvm_mem_is_private(vcpu->kvm, fault->gfn)) {
In patch 21,
fault->is_private is set as:
	".is_private = kvm_mem_is_private(vcpu->kvm, cr2_or_gpa >> PAGE_SHIFT)",
then, the inequality here means memory attribute has been updated after
last check.
So, why an exit to user space for converting is required instead of a mere retry?

Or, is it because how .is_private is assigned in patch 21 is subjected to change
in future? 

> +		kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
> +		return -EFAULT;
> +	}
> +
> +	if (fault->is_private)
> +		return kvm_faultin_pfn_private(vcpu, fault);
> +
>  	async = false;
>  	fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, false, false, &async,
>  					  fault->write, &fault->map_writable,
> @@ -7184,6 +7255,19 @@ void kvm_mmu_pre_destroy_vm(struct kvm *kvm)
>  }
>  
 
