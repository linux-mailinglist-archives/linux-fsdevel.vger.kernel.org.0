Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124812BA50B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 09:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbgKTIrx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 03:47:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:37016 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727087AbgKTIrw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 03:47:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605862071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ne2Avj6pW7QhAkPMQhJ1kGPytq/nN9ye3Utj+34UF5o=;
        b=vQQkZSJ2ooVHAE/UeNSDrpa0kIxqFyhcazCo3f1cxOe0H8LHXtTCsb33uRGR7XYsDXvvaO
        ihl/3/UJk5/y2doTc5Q7iN2ftZl1BkFjT4Zka5X+8iaU3ulnImlMUHuhmp+RXkSRV7zpgT
        IHUEWLIQBPogg+skXx9tw+dgWF58WQ8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6C970AD21;
        Fri, 20 Nov 2020 08:47:51 +0000 (UTC)
Date:   Fri, 20 Nov 2020 09:47:50 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v5 03/21] mm/hugetlb: Introduce a new
 config HUGETLB_PAGE_FREE_VMEMMAP
Message-ID: <20201120084750.GK3200@dhcp22.suse.cz>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120064325.34492-4-songmuchun@bytedance.com>
 <20201120074950.GB3200@dhcp22.suse.cz>
 <CAMZfGtWuCuuR+N8h-509BbDL8CN+s_djsodPN0Wb1+YHbF9PHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtWuCuuR+N8h-509BbDL8CN+s_djsodPN0Wb1+YHbF9PHw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 20-11-20 16:35:16, Muchun Song wrote:
[...]
> > That being said, unless there are huge advantages to introduce a
> > config option I would rather not add it because our config space is huge
> > already and the more we add the more future code maintainance that will
> > add. If you want the config just for dependency checks then fine by me.
> 
> Yeah, it is only for dependency checks :)

OK, I must have misread the definition to think that it requires user to
enable explicitly.

Anyway this feature cannot be really on by default due to overhead. So
the command line option default has to be flipped.

-- 
Michal Hocko
SUSE Labs
