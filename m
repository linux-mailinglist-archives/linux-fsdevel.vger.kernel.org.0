Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6102F20353
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 12:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfEPKUx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 06:20:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:51606 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726336AbfEPKUx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 06:20:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ACBE0AC2C;
        Thu, 16 May 2019 10:20:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 16 May 2019 12:20:50 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Azat Khuzhin <azat@libevent.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 13/13] epoll: implement epoll_create2() syscall
In-Reply-To: <CAK8P3a2-fN_BHEnEHvf4X9Ysy4t0_SnJetQLvFU1kFa3OtM0fQ@mail.gmail.com>
References: <20190516085810.31077-1-rpenyaev@suse.de>
 <20190516085810.31077-14-rpenyaev@suse.de>
 <CAK8P3a2-fN_BHEnEHvf4X9Ysy4t0_SnJetQLvFU1kFa3OtM0fQ@mail.gmail.com>
Message-ID: <41b847c48ccbe0c406bd54c16fbc1bf0@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-05-16 12:03, Arnd Bergmann wrote:
> On Thu, May 16, 2019 at 10:59 AM Roman Penyaev <rpenyaev@suse.de> 
> wrote:
>> 
>> epoll_create2() is needed to accept EPOLL_USERPOLL flags
>> and size, i.e. this patch wires up polling from userspace.
> 
> Could you add the system call to all syscall*.tbl files at the same 
> time here?

For all other archs, you mean?  Sure.  But what is the rule of thumb?
Sometimes people tend to add to the most common x86 and other tables
are left untouched, but then you commit the rest, e.g.

commit 39036cd2727395c3369b1051005da74059a85317
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Thu Feb 28 13:59:19 2019 +0100

     arch: add pidfd and io_uring syscalls everywhere



--
Roman
