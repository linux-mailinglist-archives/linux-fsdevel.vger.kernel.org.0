Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7623D2FD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jul 2021 00:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhGVVyG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 17:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbhGVVyG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 17:54:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702EDC061575;
        Thu, 22 Jul 2021 15:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=ePleACZs1ZsydqUvDnxgo+oZtae2ZwTuTK5A4YacCoI=; b=SqGQvGubmRSX5z6BjCjuw+xEDr
        I6P/kC+e4Tk6N+of1b2zAJDnnHUqwHk3E/t5gR1d3ktMRWwtx9Kg2TCYIomWfDEAPHQlM17+zgKkt
        Xn/RYJwQ50sjdfd4EguIuEopwtI8uo2nMuFD7HyFylL3MDlwFq2YyRqXto2SJlejjxs9CBi3nOEiy
        JMtkT8N2sXCzpgbb/oDr90EnS4b2tgrpoLYCxjUD8rfd1deEJSANI5pMZWX+KXzfr78l2k9nNg8BM
        Fi/ZxQM5/pwmq9qOM7ffeWpTh6HfWhO+DElp+RamcyEWm/5UO5eXBGbMD7KQEkFsux8/ahD5J8ptK
        4oyfef2Q==;
Received: from [2601:1c0:6280:3f0:7629:afff:fe72:e49d]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6hH3-002tcC-VI; Thu, 22 Jul 2021 22:34:38 +0000
Subject: Re: A shift-out-of-bounds in minix_statfs in fs/minix/inode.c
To:     Theodore Ts'o <tytso@mit.edu>, Matthew Wilcox <willy@infradead.org>
Cc:     butt3rflyh4ck <butterflyhuangxx@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <CAFcO6XOdMe-RgN8MCUT59cYEVBp+3VYTW-exzxhKdBk57q0GYw@mail.gmail.com>
 <YPhbU/umyUZLdxIw@casper.infradead.org> <YPnp/zXp3saLbz03@mit.edu>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e494c34c-1118-584f-a001-2929df747f8b@infradead.org>
Date:   Thu, 22 Jul 2021 15:34:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPnp/zXp3saLbz03@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/22/21 2:58 PM, Theodore Ts'o wrote:
...

> 
> So I do care about this for ext4, although I don't guarantee immediate
> response, as it's something that I usually end up doing on my own
> time.  I do get cranky that Syzkaller makes it painful to extract out
> the fuzzed file system image, and I much prefer those fuzzing systems
> which provide the file system image and the C program used to trigger
> the failre as two seprate files.  Or failing that, if there was some

gosh yes. I have added a patch to the syzkaller C reproducer multiple times
so that it would write out the fs image and then I could just use that
with 'mount' etc. instead of running the (unreadable) C reproducer.

> trivial way to get the syzkaller reproducer program to disgorge the
> file system image to a specified output file.  As a result, if I have
> a choice of spending time investigating fuzzing report from a more
> file-system friendly fuzzing program and syzkaller, I'll tend choose
> to spend my time dealing with other file system fuzzing reports first.



-- 
~Randy

