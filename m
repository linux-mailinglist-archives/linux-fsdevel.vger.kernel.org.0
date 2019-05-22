Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11FE326029
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 11:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbfEVJLn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 05:11:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:45300 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728536AbfEVJLn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 05:11:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6AE2DB116;
        Wed, 22 May 2019 09:11:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 22 May 2019 11:11:42 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Azat Khuzhin <azat@libevent.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 13/13] epoll: implement epoll_create2() syscall
In-Reply-To: <20190521193312.42a3fdda1774b1922730e459@linux-foundation.org>
References: <20190516085810.31077-1-rpenyaev@suse.de>
 <20190516085810.31077-14-rpenyaev@suse.de>
 <CAK8P3a2-fN_BHEnEHvf4X9Ysy4t0_SnJetQLvFU1kFa3OtM0fQ@mail.gmail.com>
 <41b847c48ccbe0c406bd54c16fbc1bf0@suse.de>
 <20190521193312.42a3fdda1774b1922730e459@linux-foundation.org>
Message-ID: <304bd75b754218b4b21f7a456cdd94f3@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-05-22 04:33, Andrew Morton wrote:
> On Thu, 16 May 2019 12:20:50 +0200 Roman Penyaev <rpenyaev@suse.de> 
> wrote:
> 
>> On 2019-05-16 12:03, Arnd Bergmann wrote:
>> > On Thu, May 16, 2019 at 10:59 AM Roman Penyaev <rpenyaev@suse.de>
>> > wrote:
>> >>
>> >> epoll_create2() is needed to accept EPOLL_USERPOLL flags
>> >> and size, i.e. this patch wires up polling from userspace.
>> >
>> > Could you add the system call to all syscall*.tbl files at the same
>> > time here?
>> 
>> For all other archs, you mean?  Sure.  But what is the rule of thumb?
>> Sometimes people tend to add to the most common x86 and other tables
>> are left untouched, but then you commit the rest, e.g.
>> 
>> commit 39036cd2727395c3369b1051005da74059a85317
>> Author: Arnd Bergmann <arnd@arndb.de>
>> Date:   Thu Feb 28 13:59:19 2019 +0100
>> 
>>      arch: add pidfd and io_uring syscalls everywhere
>> 
> 
> I thought the preferred approach was to wire up the architectures on
> which the submitter has tested the syscall, then allow the arch
> maintainers to enable the syscall independently?
> 
> And to help them in this, provide a test suite for the new syscall
> under tools/testing/selftests/.
> 
> https://github.com/rouming/test-tools/blob/master/userpolled-epoll.c
> will certainly help but I do think it would be better to move the test
> into the kernel tree to keep it maintained and so that many people run
> it in their various setups on an ongoing basis.

Yes, on a next iteration I will add the tool to selftests. Thanks.

--
Roman


