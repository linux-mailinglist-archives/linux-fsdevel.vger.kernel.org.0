Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C137E4C7FC4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 01:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiCAAyg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 19:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiCAAyg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 19:54:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703E3F70;
        Mon, 28 Feb 2022 16:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:To:From:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=NZ91IYeIblNdDBut8MLpWdnA9o4cCrnTYppf7PU1ers=; b=H7pOJZasUim98q+EC7q64TPboV
        6lvIwmzxOyQqh4fWhPFUSlFXc1wm7Wc+PsoRyU27Z5LbRF0TZzx6a/wfh2GmXLDz1si+K+yS5H5Uf
        cMRbY7DeT4cV8Du4l/9uBzfPIRGskTowCD+EtZWNUpurwoB8vkxQ5lwgySfz7+nHjJvbdnqv8exnn
        XwDACrsks/9xXHLoNqEg5asUjT5RvoHp58sK9sbEyoCQqFi4kANgwWa4vcYLYEyg1IeEvHQ3mZxfV
        oTzl6ANrfzWCnxVF8bvjC8gODSyj38Dsk5vD58SCARnhJ2jQiL5kCxsEMQA8O8pxXrXf/yNmIEErE
        nKibrs0g==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOqlx-0095DT-UI; Tue, 01 Mar 2022 00:53:50 +0000
Message-ID: <c35bb2e5-0538-1247-a5a4-7eb34836947a@infradead.org>
Date:   Mon, 28 Feb 2022 16:53:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: mmotm 2022-02-28-14-45 uploaded
 (drivers/tty/serial/sunplus-uart.c:)
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        mhocko@suse.cz, sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hammer Hsieh <hammerh0314@gmail.com>
References: <20220228224600.44415C340EE@smtp.kernel.org>
 <1e91ecfb-0432-8c0c-e537-49954313abff@infradead.org>
In-Reply-To: <1e91ecfb-0432-8c0c-e537-49954313abff@infradead.org>
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



On 2/28/22 16:46, Randy Dunlap wrote:
> 
> 
> On 2/28/22 14:45, Andrew Morton wrote:
>> The mm-of-the-moment snapshot 2022-02-28-14-45 has been uploaded to
>>
>>    https://www.ozlabs.org/~akpm/mmotm/
>>
>> mmotm-readme.txt says
>>
>> README for mm-of-the-moment:
>>
>> https://www.ozlabs.org/~akpm/mmotm/
>>
>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>> more than once a week.
>>
>> You will need quilt to apply these patches to the latest Linus release (5.x
>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
>> https://ozlabs.org/~akpm/mmotm/series
> 
> on x86_64 or i386:
> 
> when CONFIG_SERIAL_SUNPLUS_CONSOLE is not set:
> 
> ../drivers/tty/serial/sunplus-uart.c:574:12: error: ‘sunplus_uart_console’ undeclared here (not in a function); did you mean ‘sunplus_uart_ops’?
>   .cons  = &sunplus_uart_console,
>             ^~~~~~~~~~~~~~~~~~~~

Huh. On a different build, another build error was found,
also with CONFIG_SERIAL_SUNPLUS_CONSOLE not set:

../drivers/tty/serial/sunplus-uart.c: In function ‘sunplus_poll_put_char’:
../drivers/tty/serial/sunplus-uart.c:464:2: error: implicit declaration of function ‘wait_for_xmitr’; did you mean ‘wait_on_bit’? [-Werror=implicit-function-declaration]
  wait_for_xmitr(port);
  ^~~~~~~~~~~~~~


-- 
~Randy
