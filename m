Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381522B74B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 04:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgKRD2B convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 22:28:01 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2436 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgKRD2A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 22:28:00 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CbStQ72w2z55n3;
        Wed, 18 Nov 2020 11:27:42 +0800 (CST)
Received: from dggemi711-chm.china.huawei.com (10.3.20.110) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 18 Nov 2020 11:27:57 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi711-chm.china.huawei.com (10.3.20.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 18 Nov 2020 11:27:56 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Wed, 18 Nov 2020 11:27:56 +0800
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
Subject: RE: [External] RE: [PATCH v4 00/21] Free some vmemmap pages of
 hugetlb page
Thread-Topic: [External] RE: [PATCH v4 00/21] Free some vmemmap pages of
 hugetlb page
Thread-Index: AQHWuaxO0H5megy+qEKBM1T+1aO5TKnMHhDQ//+HLICAAIXtUP//2OyAgAA21ICAAQU3oA==
Date:   Wed, 18 Nov 2020 03:27:56 +0000
Message-ID: <bcd9b0c8b5b34fb7bcfc97328d9d3dde@hisilicon.com>
References: <20201113105952.11638-1-songmuchun@bytedance.com>
 <349168819c1249d4bceea26597760b0a@hisilicon.com>
 <CAMZfGtUVDJ4QHYRCKnPTkgcKGJ38s2aOOktH+8Urz7oiVfimww@mail.gmail.com>
 <714ae7d701d446259ab269f14a030fe9@hisilicon.com>
 <CAMZfGtWNa=abZdN6HmWE1VBFHfGCbsW9D0zrN-F5zrhn6s=ErA@mail.gmail.com>
 <d04fdbf6c955054fddb152c78bc53db6@suse.de>
In-Reply-To: <d04fdbf6c955054fddb152c78bc53db6@suse.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.123]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> -----Original Message-----
> From: Oscar Salvador [mailto:osalvador@suse.de]
> Sent: Wednesday, November 18, 2020 8:45 AM
> To: Muchun Song <songmuchun@bytedance.com>
> Cc: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>;
> corbet@lwn.net; mike.kravetz@oracle.com; tglx@linutronix.de;
> mingo@redhat.com; bp@alien8.de; x86@kernel.org; hpa@zytor.com;
> dave.hansen@linux.intel.com; luto@kernel.org; peterz@infradead.org;
> viro@zeniv.linux.org.uk; akpm@linux-foundation.org; paulmck@kernel.org;
> mchehab+huawei@kernel.org; pawan.kumar.gupta@linux.intel.com;
> rdunlap@infradead.org; oneukum@suse.com; anshuman.khandual@arm.com;
> jroedel@suse.de; almasrymina@google.com; rientjes@google.com;
> willy@infradead.org; mhocko@suse.com; duanxiongchun@bytedance.com;
> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> linux-fsdevel@vger.kernel.org
> Subject: Re: [External] RE: [PATCH v4 00/21] Free some vmemmap pages of
> hugetlb page
> 
> On 2020-11-17 17:29, Muchun Song wrote:
> > Now for the 2MB HugrTLB page, we only free 6 vmemmap pages.
> > But your words woke me up. Maybe we really can free 7 vmemmap
> > pages. In this case, we can see 8 of the 512 struct page structures
> > has beed set PG_head flag. If we can adjust compound_head()
> > slightly and make compound_head() return the real head struct
> > page when the parameter is the tail struct page but with PG_head
> > flag set. I will start an investigation and a test.
> 
> I would not overcomplicate things at this stage, but rather keep it
> simple as the code is already tricky enough(without counting the LOC
> thatvit adds).
> We can always build on top later on in order to improve things.

Yep. I am not expecting freeing tail page to be done at this stage. This could
be something in the todo list after the first patchset is solid.

> 
> --
> Oscar Salvador
> SUSE L3

Thanks
Barry

