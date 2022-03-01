Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E81F4C7F97
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 01:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiCAArI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 19:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiCAArH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 19:47:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329601CFDA;
        Mon, 28 Feb 2022 16:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=6kLooZJqwGGXeVVaSJP06IJVzbhf/g8lxAgwKUZTKkQ=; b=OibTSq6yzv7ONGW8VvnYgQrrEv
        5KZXpoYlNennpum1jNu3fUeCUaZ2uwA/+/EN6S3kvydscWR3ai3JyrE0HPVnxvL+eGn7YwpvXsSnK
        1kuvYe+9VOZ95TkqbuzuYkt6yAW62u4M5e6g+B1J3Vki69gIekQVJEsSQbVcMYDdubwggu2gty4pj
        igK7cLFtxs4QDUrIoboG6GrFtKtvd4YR9y1x9B9/W06Cj2QDNrfWMAHbrID3RrI97sRxyL2x44AMJ
        of9dpt7+ltreM13WOu7kWxDDmRsi/vufxKYAtItg5XvSCk+eJCXgNiNa2aG6+1UgFUHjsxn1M3B/h
        X0sVMgHw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOqeh-0094bj-Vo; Tue, 01 Mar 2022 00:46:20 +0000
Message-ID: <1e91ecfb-0432-8c0c-e537-49954313abff@infradead.org>
Date:   Mon, 28 Feb 2022 16:46:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: mmotm 2022-02-28-14-45 uploaded
 (drivers/tty/serial/sunplus-uart.c:)
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        mhocko@suse.cz, sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hammer Hsieh <hammerh0314@gmail.com>
References: <20220228224600.44415C340EE@smtp.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220228224600.44415C340EE@smtp.kernel.org>
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



On 2/28/22 14:45, Andrew Morton wrote:
> The mm-of-the-moment snapshot 2022-02-28-14-45 has been uploaded to
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

on x86_64 or i386:

when CONFIG_SERIAL_SUNPLUS_CONSOLE is not set:

../drivers/tty/serial/sunplus-uart.c:574:12: error: ‘sunplus_uart_console’ undeclared here (not in a function); did you mean ‘sunplus_uart_ops’?
  .cons  = &sunplus_uart_console,
            ^~~~~~~~~~~~~~~~~~~~



-- 
~Randy
