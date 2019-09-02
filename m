Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1884EA5BDC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 19:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfIBRjl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 13:39:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51242 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfIBRjl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 13:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hEGWoA2tYnse4FOhsxlEH/jFHn84yJrgUujZ+4IiIa0=; b=SGnGV0+pbDM5rhHxiPkQ4xpwq
        x1hSrK8wB/eqxQj3w8PwB2x4+zvIj6JAHzC+MizEH1JZoXlBabDFBRikErFoxpY+2tFaqzqyZxCb7
        zshjdYup4vA0RmXnCa+RP/n2e7uT3KgxbWASVCh4pYb9Y3W+dZlIAkVCkCkJMPZ39uRtU24LuyrPr
        uKv77MJGwrZ9gHUYW3bggdXVm69N9NSDZS6EIxtpHmZ8ge9WW99zy6Azz1FdaUJXeFfLVcH1p94fw
        MTym2Yo6Tk26Cv5APe8XiGV4gtZYylywthwojnHyPQzlDd8gA9Q85UPLZBAu9oSaKOUqIgyv5uALy
        fq5BSxPWw==;
Received: from [2601:1c0:6200:6e8::4f71]
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i4qIm-0004GB-Di; Mon, 02 Sep 2019 17:39:40 +0000
Subject: Re: linux-next: Tree for Sep 2 (exfat)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <20190902224310.208575dc@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cecc2af6-7ef6-29f6-569e-b591365e45ad@infradead.org>
Date:   Mon, 2 Sep 2019 10:39:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190902224310.208575dc@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/2/19 5:43 AM, Stephen Rothwell wrote:
> Hi all,
> 
> News: I will only be doing 2 more releases before I leave for Kernel
> Summit (there may be some reports on Thursday, but I doubt I will have
> time to finish the full release) and then no more until Sept 30.
> 
> Changes since 20190830:
> 

Hi,
I am seeing lots of exfat build errors when CONFIG_BLOCK is not set/enabled.
Maybe its Kconfig should also say
	depends on BLOCK
?

-- 
~Randy
