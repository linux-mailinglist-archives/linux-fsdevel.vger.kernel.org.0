Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F371A2C22FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 11:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731911AbgKXKbT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 05:31:19 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2442 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731488AbgKXKbT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:31:19 -0500
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CgKzx3Yjkz4xlG;
        Tue, 24 Nov 2020 18:30:53 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 24 Nov 2020 18:31:13 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi761-chm.china.huawei.com (10.1.198.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 24 Nov 2020 18:31:12 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Tue, 24 Nov 2020 18:31:12 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>
CC:     "corbet@lwn.net" <corbet@lwn.net>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "oneukum@suse.com" <oneukum@suse.com>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "almasrymina@google.com" <almasrymina@google.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "duanxiongchun@bytedance.com" <duanxiongchun@bytedance.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH v6 07/16] x86/mm/64: Disable PMD page mapping of vmemmap
Thread-Topic: [PATCH v6 07/16] x86/mm/64: Disable PMD page mapping of vmemmap
Thread-Index: AQHWwkhOPqtKcyIq80+fWoEXOrKJHKnWjWGAgACFgQA=
Date:   Tue, 24 Nov 2020 10:31:12 +0000
Message-ID: <c938bb225ea84c06844b31023dad96c1@hisilicon.com>
References: <20201124095259.58755-1-songmuchun@bytedance.com>
 <20201124095259.58755-8-songmuchun@bytedance.com>
 <20201124102441.GA24718@linux>
In-Reply-To: <20201124102441.GA24718@linux>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.209]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> -----Original Message-----
> From: owner-linux-mm@kvack.org [mailto:owner-linux-mm@kvack.org] On
> Behalf Of Oscar Salvador
> Sent: Tuesday, November 24, 2020 11:25 PM
> To: Muchun Song <songmuchun@bytedance.com>
> Cc: corbet@lwn.net; mike.kravetz@oracle.com; tglx@linutronix.de;
> mingo@redhat.com; bp@alien8.de; x86@kernel.org; hpa@zytor.com;
> dave.hansen@linux.intel.com; luto@kernel.org; peterz@infradead.org;
> viro@zeniv.linux.org.uk; akpm@linux-foundation.org; paulmck@kernel.org;
> mchehab+huawei@kernel.org; pawan.kumar.gupta@linux.intel.com;
> rdunlap@infradead.org; oneukum@suse.com; anshuman.khandual@arm.com;
> jroedel@suse.de; almasrymina@google.com; rientjes@google.com;
> willy@infradead.org; mhocko@suse.com; Song Bao Hua (Barry Song)
> <song.bao.hua@hisilicon.com>; duanxiongchun@bytedance.com;
> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> linux-fsdevel@vger.kernel.org
> Subject: Re: [PATCH v6 07/16] x86/mm/64: Disable PMD page mapping of
> vmemmap
> 
> On Tue, Nov 24, 2020 at 05:52:50PM +0800, Muchun Song wrote:
> > If we enable the CONFIG_HUGETLB_PAGE_FREE_VMEMMAP, we can just
> > disbale PMD page mapping of vmemmap to simplify the code. In this
> > case, we do not need complex code doing vmemmap page table
> > manipulation. This is a way to simply the first version of this
> > patch series. In the future, we can add some code doing page table
> > manipulation.
> 
> IIRC, CONFIG_HUGETLB_PAGE_FREE_VMEMMAP was supposed to be enabled
> by default,
> right?
> And we would control whether we __really__ want to this by a boot option,
> which was disabled by default?
> 
> If you go for populating the memmap with basepages by checking
> CONFIG_HUGETLB_PAGE_FREE_VMEMMAP, would not everybody, even the
> ones that
> did not enable this by the boot option be affected?
> 

I would believe we could only bypass the pmd mapping of vmemmap while
free_vmemmap is explicitly enabled.
pmd mapping shouldn't be disabled in default. Would a cmdline of enabling
vmemmap_free be used for the first patchset?

> --
> Oscar Salvador
> SUSE L3

Thanks
Barry
