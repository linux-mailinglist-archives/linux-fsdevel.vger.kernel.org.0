Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D1F49DB02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 07:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbiA0Gwx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 01:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236970AbiA0Gwx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 01:52:53 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E662EC061714;
        Wed, 26 Jan 2022 22:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=dCJQMJKL5IVz1Z8zwkX2bymXH1fFjLGZs4aTLD4gTKE=; b=QMQYP7stSyLIc5Ob038zt/GXVe
        FxbqDCMpQFpyu72raeYh8/gsSU0GxZGbp3s9Pt+nlgmA4ozYtJtOy8+yucVxFFfQrInSuXMAlsvJm
        KHEKni20loUi3hYE11abbNDAhPjVR4ICMNZ+iwQV5exKQakXuyZRnt9/o8sgjfdxTvcwXti1h2qjt
        74dt/UOUjm4fZ4GkZySsGJPMM82uhEldZf5f9IgQk6j5eh/ES/UAi5+JaZAIgVo1xdgfRgc2YmHH7
        LTcGr2zViVo2evZvrQHyTXzrpBNaYBq1bkakrPWJSzYNMQbL6gfSNhjRPFKJjsh2qYilsdK47u1pM
        GviCG0bg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCyeH-0045So-Bn; Thu, 27 Jan 2022 06:52:49 +0000
Message-ID: <6b4f3d82-01e8-5bf3-927f-33ac62178fd5@infradead.org>
Date:   Wed, 26 Jan 2022 22:52:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: mmotm 2022-01-26-21-04 uploaded (gpu/drm/i915/i915_gem_evict.h)
Content-Language: en-US
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
References: <20220127050456.M1eh-ltbc%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220127050456.M1eh-ltbc%akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1/26/22 21:04, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2022-01-26-21-04 has been uploaded to
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
(from linux-next.patch)


  HDRTEST drivers/gpu/drm/i915/i915_gem_evict.h
In file included from <command-line>:0:0:
./../drivers/gpu/drm/i915/i915_gem_evict.h:15:15: error: ‘struct i915_gem_ww_ctx’ declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
        struct i915_gem_ww_ctx *ww,
               ^~~~~~~~~~~~~~~
./../drivers/gpu/drm/i915/i915_gem_evict.h:21:14: error: ‘struct i915_gem_ww_ctx’ declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
       struct i915_gem_ww_ctx *ww,
              ^~~~~~~~~~~~~~~
./../drivers/gpu/drm/i915/i915_gem_evict.h:25:16: error: ‘struct i915_gem_ww_ctx’ declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
         struct i915_gem_ww_ctx *ww);
                ^~~~~~~~~~~~~~~
cc1: all warnings being treated as errors


-- 
~Randy
