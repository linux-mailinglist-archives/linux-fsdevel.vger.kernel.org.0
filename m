Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60E54306B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 04:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfEaCmi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 May 2019 22:42:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:61451 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbfEaCmh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 May 2019 22:42:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 May 2019 19:42:37 -0700
X-ExtLoop1: 1
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.29])
  by fmsmga001.fm.intel.com with ESMTP; 30 May 2019 19:42:35 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     <akpm@linux-foundation.org>, <broonie@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-next@vger.kernel.org>,
        <mhocko@suse.cz>, <mm-commits@vger.kernel.org>,
        <sfr@canb.auug.org.au>
Subject: Re: mmotm 2019-05-29-20-52 uploaded
References: <20190530035339.hJr4GziBa%akpm@linux-foundation.org>
        <fac5f029-ef20-282e-b0d2-2357589839e8@oracle.com>
        <87lfyn5rgu.fsf@yhuang-dev.intel.com>
Date:   Fri, 31 May 2019 10:42:35 +0800
In-Reply-To: <87lfyn5rgu.fsf@yhuang-dev.intel.com> (Ying Huang's message of
        "Fri, 31 May 2019 09:43:13 +0800")
Message-ID: <87h89b5opw.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Huang, Ying" <ying.huang@intel.com> writes:

> Hi, Mike,
>
> Mike Kravetz <mike.kravetz@oracle.com> writes:
>
>> On 5/29/19 8:53 PM, akpm@linux-foundation.org wrote:
>>> The mm-of-the-moment snapshot 2019-05-29-20-52 has been uploaded to
>>> 
>>>    http://www.ozlabs.org/~akpm/mmotm/
>>> 
>>
>> With this kernel, I seem to get many messages such as:
>>
>> get_swap_device: Bad swap file entry 1400000000000001
>>
>> It would seem to be related to commit 3e2c19f9bef7e
>>> * mm-swap-fix-race-between-swapoff-and-some-swap-operations.patch
>
> Hi, Mike,
>
> Thanks for reporting!  I find an issue in my patch and I can reproduce
> your problem now.  The reason is total_swapcache_pages() will call
> get_swap_device() for invalid swap device.  So we need to find a way to
> silence the warning.  I will post a fix ASAP.

I have sent out a fix patch in another thread with title

"[PATCH -mm] mm, swap: Fix bad swap file entry warning"

Can you try it?

Best Regards,
Huang, Ying

