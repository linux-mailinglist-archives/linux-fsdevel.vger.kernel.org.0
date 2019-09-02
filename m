Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81073A5C13
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 20:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfIBSHn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 14:07:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51622 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfIBSHn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 14:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=c5UKk/WUqmxqtU3WpUzbuDwbt+WLxvtk3T/wDs7cTaI=; b=tFFWIXxuHlrcBDXTEYoGRQIOX
        yiVt+S4Nlh9YE9muq1/9s8LrreLMTC8sogsYkYEJ048MHkTLkp1T4ipminIZuUDIFDu3EhwyGJarq
        5HQPFfFkfXpYEm4GcLm76SyhP4Z0qUOfQ86XH2Al1Ek02sxxaJTfA2jNd9VOzm1ZzfVfIedRN/zPW
        WGZbFtfGyC7/qBnyJDDOdpRA0E/qvfIwMzdmoUkHrPBpTMlhbJmAKEyLyJgFwepqn+eEyWJMCL6Qp
        4fI3uvV4h9GFnl62ajWxX7cEL1BwyS2ZoUfox16rkHQeXZ6cQVfeDGxaxUfOtGC8mc+NJ7fuXF+/B
        fbgpOogFg==;
Received: from [2601:1c0:6200:6e8::4f71]
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i4qjt-0004SO-MG; Mon, 02 Sep 2019 18:07:41 +0000
Subject: Re: linux-next: Tree for Sep 2 (exfat)
To:     Greg KH <greg@kroah.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <20190902224310.208575dc@canb.auug.org.au>
 <cecc2af6-7ef6-29f6-569e-b591365e45ad@infradead.org>
 <20190902174631.GB31445@kroah.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <13e2db80-0c89-0f36-6876-f9639f0d30ab@infradead.org>
Date:   Mon, 2 Sep 2019 11:07:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190902174631.GB31445@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/2/19 10:46 AM, Greg KH wrote:
> On Mon, Sep 02, 2019 at 10:39:39AM -0700, Randy Dunlap wrote:
>> On 9/2/19 5:43 AM, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> News: I will only be doing 2 more releases before I leave for Kernel
>>> Summit (there may be some reports on Thursday, but I doubt I will have
>>> time to finish the full release) and then no more until Sept 30.
>>>
>>> Changes since 20190830:
>>>
>>
>> Hi,
>> I am seeing lots of exfat build errors when CONFIG_BLOCK is not set/enabled.
>> Maybe its Kconfig should also say
>> 	depends on BLOCK
>> ?
> 
> Here's what I committed to my tree:
> 
> 
> From e2b880d3d1afaa5cad108c29be3e307b1917d195 Mon Sep 17 00:00:00 2001
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date: Mon, 2 Sep 2019 19:45:06 +0200
> Subject: staging: exfat: make exfat depend on BLOCK
> 
> This should fix a build error in some configurations when CONFIG_BLOCK
> is not selected.  Also properly set the dependancy for no FAT support at
> the same time.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

That works. Thanks.
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

> ---
>  drivers/staging/exfat/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/exfat/Kconfig b/drivers/staging/exfat/Kconfig
> index f52129c67f97..290dbfc7ace1 100644
> --- a/drivers/staging/exfat/Kconfig
> +++ b/drivers/staging/exfat/Kconfig
> @@ -1,11 +1,13 @@
>  config EXFAT_FS
>  	tristate "exFAT fs support"
> +	depends on BLOCK
>  	select NLS
>  	help
>  	  This adds support for the exFAT file system.
>  
>  config EXFAT_DONT_MOUNT_VFAT
>  	bool "Prohibit mounting of fat/vfat filesysems by exFAT"
> +	depends on EXFAT_FS
>  	default y
>  	help
>  	  By default, the exFAT driver will only mount exFAT filesystems, and refuse
> 


-- 
~Randy
