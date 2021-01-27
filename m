Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7256C30643F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 20:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344577AbhA0TiH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 14:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344587AbhA0Tg5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 14:36:57 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A25BC061573;
        Wed, 27 Jan 2021 11:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=e8MHSFAxiS7UdxXBZlqFbrVKBNkvXqogAmgOIMEikQ8=; b=yvGMjwoP/+k3rHesHCE2f9nLbG
        gUEDn2qyX4KQfjBPkeO/5HRFsYk5/WO5eAMK4s/c32DNGpbsxZNole9VkwCxML/ZvMfMDhprCutw2
        37RcmBVLFLVxuNwVxxfmu006aE0vToyIicusfdagBwrPaPeGhKyDFxOzvE6uw9dNAhXHq9xoB/ib9
        KlPCwdV9ots8gUxsOBp0qbIE3Y88d9FheNRK9C8AlkcbMJuwRQ0lggO22QAdzRyYdB5BcwNuF+dTn
        sNRM1+A4fzKWkwLOl1fRyvInSpaIiWIBp5BzrqM+fupHzHAoLEBVQjghRQeXSGGtd90WaAd1n4cBX
        HfO6NuFg==;
Received: from [2601:1c0:6280:3f0::7650]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4qbp-0002hL-Ag; Wed, 27 Jan 2021 19:36:09 +0000
Subject: Re: mmotm 2021-01-25-21-18 uploaded (drm/i915/Kconfig.debug)
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        dri-devel <dri-devel@lists.freedesktop.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
References: <20210126051917.rcgrHGfQS%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0f9e7192-622d-c016-561f-7b5d5ee9ecd1@infradead.org>
Date:   Wed, 27 Jan 2021 11:36:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210126051917.rcgrHGfQS%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/25/21 9:19 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2021-01-25-21-18 has been uploaded to
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

on x86_64:

when CONFIG_COMPILE_TEST=y:

WARNING: unmet direct dependencies detected for DRM_I915_WERROR
  Depends on [n]: HAS_IOMEM [=y] && DRM_I915 [=m] && EXPERT [=y] && !COMPILE_TEST [=y]
  Selected by [m]:
  - DRM_I915_DEBUG [=y] && HAS_IOMEM [=y] && EXPERT [=y] && DRM_I915 [=m]


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>

