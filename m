Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E37E2B450E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 14:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbgKPNw3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 08:52:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:38150 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728133AbgKPNw3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 08:52:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ED952AC48;
        Mon, 16 Nov 2020 13:52:27 +0000 (UTC)
Date:   Mon, 16 Nov 2020 14:52:24 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
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
Subject: Re: [PATCH v4 02/21] mm/memory_hotplug: Move
 {get,put}_page_bootmem() to bootmem_info.c
Message-ID: <20201116135224.GC32129@linux>
References: <20201113105952.11638-1-songmuchun@bytedance.com>
 <20201113105952.11638-3-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113105952.11638-3-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 13, 2020 at 06:59:33PM +0800, Muchun Song wrote:
> In the later patch, we will use {get,put}_page_bootmem() to initialize
> the page for vmemmap or free vmemmap page to buddy. So move them out of
> CONFIG_MEMORY_HOTPLUG_SPARSE. This is just code movement without any
> functional change.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

The change itself makes sense.
I tried to check the possibles scenarios with different CONFIG_ options
toggled, but I will trust you that you ran the checks :-)

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE L3
