Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BE44C3449
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 19:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbiBXSF2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 13:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiBXSF2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 13:05:28 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45FC674C7;
        Thu, 24 Feb 2022 10:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=cJwoEaVvvYLAlik9YwBxkUiII/mzymj+DJDxr+/UFjI=; b=kaoXWa9/LCvq/dsK7GYIHAVRqj
        t6h6MjOTEfYdrxdtvSuX4dAQS79bV95Y9zFfRDQolYgeq38GznJTO27YdmEQ6CUs0pQx1NGBfvZ01
        q9G6ESlFU28pbqEmlS/csaNof3P44yXN8KrsmwYSnIIRjpWVlnBws3eO+kYS7QMPjMahm8JLEptdM
        qF93cfb8cmSq1yrMF/Rd5B2XRIqmumgyIx62nupruebgcYIe9tNnBX0mQ4A8CcXKAU6MPlXLzoeyd
        7Qudpxmr8qnqLceKGlRi1nvcChnRPWX5SfoavOvL77x0Lv/OC1Zu2s4D2AClLJjxAlM+H5JIL6KBE
        by19IE4Q==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNITw-00Cgl5-K1; Thu, 24 Feb 2022 18:04:48 +0000
Message-ID: <52f0922c-143a-8a40-b1e1-23d562ca6f80@infradead.org>
Date:   Thu, 24 Feb 2022 10:04:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: mmotm 2022-02-23-21-20 uploaded
 [drivers/scsi/hisi_sas/hisi_sas_main.ko]
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        mhocko@suse.cz, sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        linux-scsi@vger.kernel.org, John Garry <john.garry@huawei.com>
References: <20220224052137.BFB10C340E9@smtp.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220224052137.BFB10C340E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2/23/22 21:21, Andrew Morton wrote:
> The mm-of-the-moment snapshot 2022-02-23-21-20 has been uploaded to
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

on  i386:

ERROR: modpost: "sas_execute_ata_cmd" [drivers/scsi/hisi_sas/hisi_sas_main.ko] undefined!

CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
# CONFIG_SCSI_SAS_ATA is not set
CONFIG_SCSI_SAS_HOST_SMP=y


-- 
~Randy
