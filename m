Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 180E76B526
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 05:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbfGQDuP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jul 2019 23:50:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37252 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbfGQDuP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jul 2019 23:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LRyB1JKPo1g9viozQbn+8G4YzmKA4nqslPwu0uoBl1E=; b=swMFO0oK0G+l+YUUlFZXG0x6y
        cKnODAhceBjMyRkEWsnSyoMTW8b6HsRXZO2blKLfhvtoX7Uc6r+tgXFU+wbZYn1WHxjYymZ5HOwDM
        0qMq+aj5fOUmxHMdimh3JCFhu0oZtLwoVEAuTfFchx1BnpL5sPfwtu0lbHDXche91qHIGWvFYtoCd
        lpUZj0XRztKsPIB6+QwXKBvVZcAj0t1iJFOIbkk0rka0l2HRnTzKD7loQlUQxv28OgdK28u8txI7h
        lkDAyFnpqJTyXRZ7rXJ555r2TKmdVnOK2Vje34oiDBTh03FKATcyXBhMWmJaWX4oAUWVgl/5ezm1L
        5Paiqsa9g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hnaxK-0003P0-QH; Wed, 17 Jul 2019 03:50:14 +0000
Subject: Re: mmotm 2019-07-16-17-14 uploaded
To:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
References: <20190717001534.83sL1%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8165e113-6da1-c4c0-69eb-37b2d63ceed9@infradead.org>
Date:   Tue, 16 Jul 2019 20:50:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190717001534.83sL1%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/16/19 5:15 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2019-07-16-17-14 has been uploaded to
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

drivers/gpu/drm/amd/amdgpu/Kconfig contains this (from linux-next.patch):

--- a/drivers/gpu/drm/amd/amdgpu/Kconfig~linux-next
+++ a/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -27,7 +27,12 @@ config DRM_AMDGPU_CIK
 config DRM_AMDGPU_USERPTR
 	bool "Always enable userptr write support"
 	depends on DRM_AMDGPU
+<<<<<<< HEAD
 	depends on HMM_MIRROR
+=======
+	depends on ARCH_HAS_HMM
+	select HMM_MIRROR
+>>>>>>> linux-next/akpm-base
 	help
 	  This option selects CONFIG_HMM and CONFIG_HMM_MIRROR if it
 	  isn't already selected to enabled full userptr support.

which causes a lot of problems.


-- 
~Randy
