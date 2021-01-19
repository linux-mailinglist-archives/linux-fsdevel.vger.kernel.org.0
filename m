Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39472FC426
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 23:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbhASWxc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 17:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbhASWvv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 17:51:51 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515F8C0613C1;
        Tue, 19 Jan 2021 14:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=NAZnclwqIVnkHL0Jf2KXZeJMQN1hBYGTWVtka1kZllk=; b=d2QrYoOSerK3IeTm2nTNWffhnM
        8TP+801lP1Emqg8TpYQtwK8f5GszUXmLo/SN97dMuWPoKXFjx1vTL5MORlIi9f/oiSV2xrwOG9gnA
        6gZzzF0xEbBtVQOyOpDvjfIZR3I7CkG6quICum7MsZ7gp2EGA5VqyU7QeJk3B8zWROdAGFzvVHNg3
        Pzfu81MwNJTrFlUfuo87UD1Hgn3J0hPf7sGaJPfGHdtX8Qk1obZx2Y1oCGd2rmWkbXK0nqTmpHob8
        KBzn0Ko2t2Y1KZMs5DjVMuqcMxvex9UQb2gjjWsPGQkiH4PKjl78bvgzu/amQV1INAOYRfumueuQe
        2J7rgkqQ==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l1zpz-0002rJ-0v; Tue, 19 Jan 2021 22:50:59 +0000
Subject: Re: mmotm 2021-01-19-13-36 uploaded (ZONE_DEVICE)
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Dan Williams <dan.j.williams@intel.com>
References: <20210119213727.pkiuSGW9i%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3dccaa7e-f6e1-2e03-04c0-e055eb42c9b0@infradead.org>
Date:   Tue, 19 Jan 2021 14:50:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210119213727.pkiuSGW9i%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/19/21 1:37 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2021-01-19-13-36 has been uploaded to
> 
>    https://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> https://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 
> You will need quilt to apply these patches to the latest Linus release (5.x
> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> https://ozlabs.org/~akpm/mmotm/series
> 
> The file broken-out.tar.gz contains two datestamp files: .DATE and
> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> followed by the base kernel version against which this patch series is to
> be applied.

on x86_64: (several build failures so far)

../mm/memory_hotplug.c: In function ‘move_pfn_range_to_zone’:
../mm/memory_hotplug.c:772:24: error: ‘ZONE_DEVICE’ undeclared (first use in this function); did you mean ‘ZONE_MOVABLE’?
  if (zone_idx(zone) == ZONE_DEVICE) {

when CONFIG_ZONE_DEVICE is not set/enabled.


-- 
~Randy
"He closes his eyes and drops the goggles.  You can't get hurt
by looking at a bitmap.  Or can you?"
(Neal Stephenson: Snow Crash)
