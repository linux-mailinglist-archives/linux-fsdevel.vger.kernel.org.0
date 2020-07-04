Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E8E2142B7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jul 2020 05:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGDDAp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 23:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgGDDAp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 23:00:45 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1949C061794;
        Fri,  3 Jul 2020 20:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=ud82YyKdwRzOkxligMfHBrg7GpvgBKz6ipGqofQVEDU=; b=DkGv2CUQcqqlCqddo0SThRRgFH
        2JBsugUhvWgBnAh8UNA9qIOHN9wyAMa72PXZV8PwYvU3CopRyQiv11IULfUVRYDxJJPVx0QXmzYC3
        rQjF0hG5Y4rtHtDe4RQhxLlgNBbo8MQf6MTGuE2e9syiyhArMghmujIea5WWGNnYVSfGBFmHT1Pwj
        BhBvGIot8tu5OKZRRGd/AbR1q4SH17+Cdp6QNTMjYoqkTpGrBrMrUs4OXpcYvfpEXe+tY3KpR9p7f
        HDt+yHH4Zxgm8bsdzJ4/NvimJI+1qPWo2stQb7nQSPGyj6OQFu1NmfKxF0fZ0qsl7NItlEkp0C3Al
        qzoXIvHw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrYPw-0005js-Br; Sat, 04 Jul 2020 03:00:40 +0000
Subject: Re: mmotm 2020-07-03-15-03 uploaded (drivers/soc/qcom/qcom-geni-se.c)
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Rob Herring <robh+dt@kernel.org>
References: <20200703220423.GEbKTUJ0A%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d77d33e0-4d52-2d63-6224-095c9f21638d@infradead.org>
Date:   Fri, 3 Jul 2020 20:00:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200703220423.GEbKTUJ0A%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/3/20 3:04 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2020-07-03-15-03 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> http://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 

This patch from 2020-June-29 is (still) needed to fix some
build errors in drivers/soc/qcom/qcom-geni-se.c:

https://lore.kernel.org/lkml/ce0d7561-ff93-d267-b57a-6505014c728c@infradead.org/


The patch provides a stub for of_get_next_parent().

-- 
~Randy

