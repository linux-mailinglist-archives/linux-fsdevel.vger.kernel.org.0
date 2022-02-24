Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4744C3414
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 18:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbiBXRyL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 12:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiBXRyK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:54:10 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BB5105AB0;
        Thu, 24 Feb 2022 09:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=kQHeo2nASnd3RHKQkdJ+lrEtvFNIHRGWegfOM2KZ9Mg=; b=BXrpOGxevX81BeDpHiVA2YwzTS
        XPfQz/uJW0Tk1l4sbm2j+vfRxZL9ywOYv9iQk1ls7Cnpgi5xMTeAlR3M7C1kXpHfz7R4CHlWtnFgh
        BPt/ll6UNu6FMRcD46y13e1Zc5bJrLShphZtUdgaZaABvJiDp7oE/+CfHPoCFV5GwS7z5h/H+1IUf
        QjYKnLEX8aW0OuxuB6zh6AbetdMf4XgzrBkt39MBPLBJn7FFVre/RRQgV0xm0wj8Ey8mwbo0Z9d9C
        EKCLRAJjF4Ta2bExtkNMV8XXufNmSwxYNqPX1df32FwIA9mtw+jPQeD65A4zQMQiIQ/S8T4MMm++g
        NB+5SGlA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNIJ0-00CgaS-NO; Thu, 24 Feb 2022 17:53:31 +0000
Message-ID: <fbfc360c-d68f-d83b-5124-d6d930235b8c@infradead.org>
Date:   Thu, 24 Feb 2022 09:53:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: mmotm 2022-02-23-21-20 uploaded (kernel/sched/rt.c)
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        mhocko@suse.cz, sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220224052137.BFB10C340E9@smtp.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220224052137.BFB10C340E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

on x86_64:

# CONFIG_SYSCTL is not set
# CONFIG_PROC_SYSCTL is not set

../kernel/sched/rt.c:3020:12: warning: ‘sched_rr_handler’ defined but not used [-Wunused-function]
 static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
            ^~~~~~~~~~~~~~~~
../kernel/sched/rt.c:2981:12: warning: ‘sched_rt_handler’ defined but not used [-Wunused-function]
 static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
            ^~~~~~~~~~~~~~~~

-- 
~Randy
