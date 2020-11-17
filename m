Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C9D2B6F23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 20:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbgKQTpd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 14:45:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:47558 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730564AbgKQTpY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:45:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 00F9FABDE;
        Tue, 17 Nov 2020 19:45:23 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 17 Nov 2020 20:45:21 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        mhocko@suse.com, duanxiongchun@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [External] RE: [PATCH v4 00/21] Free some vmemmap pages of
 hugetlb page
In-Reply-To: <CAMZfGtWNa=abZdN6HmWE1VBFHfGCbsW9D0zrN-F5zrhn6s=ErA@mail.gmail.com>
References: <20201113105952.11638-1-songmuchun@bytedance.com>
 <349168819c1249d4bceea26597760b0a@hisilicon.com>
 <CAMZfGtUVDJ4QHYRCKnPTkgcKGJ38s2aOOktH+8Urz7oiVfimww@mail.gmail.com>
 <714ae7d701d446259ab269f14a030fe9@hisilicon.com>
 <CAMZfGtWNa=abZdN6HmWE1VBFHfGCbsW9D0zrN-F5zrhn6s=ErA@mail.gmail.com>
User-Agent: Roundcube Webmail
Message-ID: <d04fdbf6c955054fddb152c78bc53db6@suse.de>
X-Sender: osalvador@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-11-17 17:29, Muchun Song wrote:
> Now for the 2MB HugrTLB page, we only free 6 vmemmap pages.
> But your words woke me up. Maybe we really can free 7 vmemmap
> pages. In this case, we can see 8 of the 512 struct page structures
> has beed set PG_head flag. If we can adjust compound_head()
> slightly and make compound_head() return the real head struct
> page when the parameter is the tail struct page but with PG_head
> flag set. I will start an investigation and a test.

I would not overcomplicate things at this stage, but rather keep it 
simple as the code is already tricky enough(without counting the LOC 
thatvit adds).
We can always build on top later on in order to improve things.

-- 
Oscar Salvador
SUSE L3
