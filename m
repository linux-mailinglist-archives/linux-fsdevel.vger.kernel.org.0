Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFD5D13666B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 06:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgAJFDu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jan 2020 00:03:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39160 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgAJFDu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jan 2020 00:03:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yem7mNV6de7IX0DO/36hylIc+6dUlrfXgqqGPK5W0k4=; b=Z0IE3wfgrmq+qtQwy1TI67pGE
        E/pcYuE9l9EM9UdFVEsfN9t8ybwEr/jd6xeOo6ClBUIIwKwgeoq75YchaemoDUQ+YiwHsJ/lXMm6G
        yVfo4kI8uYGx0z1YcUUBdXcPS131fUdR8eLL6CCI+ob75O7a9rXJ8KW1KSkyfSzf+SofQ7APDGQTr
        z2gj1WJbRMXT0sKnQUQA/1wVccjke37aCVJaHe1etZ6SzglPz1u+MChU1WrKFkiZB7x7g4NxE9Wb8
        R7CS2kpvypJPNVfoJC7dB42DQMRoBulD5D+MDgg0xO9iR9hsps68yWioSYZVEPBcaMKpjAruBxl4d
        50QDTOqCg==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipmSX-00054i-0S; Fri, 10 Jan 2020 05:03:46 +0000
Subject: Re: mmotm 2020-01-09-17-33 uploaded (PHY_EXYNOS5250_SATA)
To:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Kishon Vijay Abraham I <kishon@ti.com>
References: <20200110013413.NNeLcxiMi%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <19fac75f-ad09-dbf5-1d11-6e91c759aa02@infradead.org>
Date:   Thu, 9 Jan 2020 21:03:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20200110013413.NNeLcxiMi%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/9/20 5:34 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2020-01-09-17-33 has been uploaded to
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

on i386:


WARNING: unmet direct dependencies detected for I2C_S3C2410
  Depends on [n]: I2C [=y] && HAS_IOMEM [=y] && HAVE_S3C2410_I2C [=n]
  Selected by [m]:
  - PHY_EXYNOS5250_SATA [=m] && (SOC_EXYNOS5250 || COMPILE_TEST [=y]) && HAS_IOMEM [=y] && OF [=y]


I also notice that PHY_EXYNOS5250_SATA also selects I2C.
It is preferable not to select an entire subsystem.  If a user wants a subsystem
enabled, then the user should enable it.  This driver should instead depend on I2C.

-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
