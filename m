Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA5BF173776
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 13:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgB1MqG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 07:46:06 -0500
Received: from relay.sw.ru ([185.231.240.75]:51230 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgB1MqG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 07:46:06 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1j7f1l-00051W-Cu; Fri, 28 Feb 2020 15:46:01 +0300
Subject: Re: [PATCH RFC 0/5] fs, ext4: Physical blocks placement hint for
 fallocate(0): fallocate2(). TP defrag.
To:     xiaohui li <lixiaohui1@xiaomi.corp-partner.google.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, viro@zeniv.linux.org.uk,
        adilger.kernel@dilger.ca, snitzer@redhat.com, jack@suse.cz,
        ebiggers@google.com, riteshh@linux.ibm.com, krisman@collabora.com,
        surajjs@amazon.com, dmonakhov@gmail.com, mbobrowski@mbobrowski.org,
        enwlinux@gmail.com, sblbir@amazon.com, khazhy@google.com,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
 <CAAJeciXSq9yThwuFJ0WFO8-qiYzTD4GqVpVKHS0q5DHJ0f8X-Q@mail.gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <ddc3639e-7afa-eb50-eb0c-4ee8a93d51df@virtuozzo.com>
Date:   Fri, 28 Feb 2020 15:46:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAAJeciXSq9yThwuFJ0WFO8-qiYzTD4GqVpVKHS0q5DHJ0f8X-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Xiaohui,

On 28.02.2020 10:07, xiaohui li wrote:
> hi Kirill Tkhai:
> 
> I agree with your idea very much.
> I had also implemented a similar fallocate interface with the unique
> flag which call tell ext4 filesystems to allocate the special free
> physical extents.
> I had done the same work as your fallocate2 work last year.
> 
> but i think it has modified the core ext4 physical blocks allocator a
> lot, so the ext4 community may not accept it.
> so I didn't share it openly.
> 
> but i think this fallocate2 interface just same as my work is also
> very useful in android mobile phone world.
> 
> today android phone has large capacity memory and storage, just the
> same as a computer.
> and current days, customer treat phone and make full use of it by just
> the same way as they treat computer in past days.
> so after install many software and unstall them for many times in
> android phone,  the ext4 physical layout on disk has become more
> fragmented
> (the number of extents per group is large).
> at this moment, when run a sequential write workload, you will find
> the sequential write performance is very bad.
> 
> but after do defragment work on some fragmented ext4 groups, and then
> run the same workload again, the sequential write performance has
> improved greatly.
> and the fallocate2 interface is a necessary component of this
> defragment work shown above.
> 
> so i also think this fallocate2 interface is an important and useful
> tools for ext4 filesystems.

I hope fs people in their comments will help to formulate an interface,
which is suitable fs philosophy and for our necessities.

Do you have your defrag util hosted on some of github repositories?

Kirill
