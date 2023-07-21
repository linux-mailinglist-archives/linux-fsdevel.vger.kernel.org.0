Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17B275C766
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 15:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjGUNMT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 09:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjGUNMR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:12:17 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E9BE68
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jul 2023 06:12:16 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-116-181.bstnma.fios.verizon.net [173.48.116.181])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 36LDA9Is023051
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 09:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1689945016; bh=7pgrm/4/sQSsWynyv8Edj5UkbwNV9qRv5dg/RVi0edI=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=NSja1rjOCccsyKizrZwCdTYgMk86cnNU9NyTbVfABTL3g5Xdjaizm20PZ1HDVbu5S
         sozAq6RDeqLxyeymHIE4gZUKXeT4EXqXX5KEeym0sd7Gyn4/XCzQLIOG5SaARm9Hz1
         Ke4i7k2d2XKNAi2rlB/3mLmKS71VYeXUs8k/xqakak1W7zuxvJx90D6XMVjZPorw0C
         hjvVVpMGKAtbExIsA0ZhT0AnA+P/fLn9WUBXUHpkMohhwl5f0qoUDTR8E3kDhJH/y7
         QGwkHW6SYJW6QfveKS6MtKQB5cCvV+FYqG9vOkjZf9Ps847Hn/5AS0pZTMJWwBd2D0
         rHlDkxK2wJRXw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6905E15C04D6; Fri, 21 Jul 2023 09:10:09 -0400 (EDT)
Date:   Fri, 21 Jul 2023 09:10:09 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jeff Layton <jlayton@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+7bb7cd3595533513a9e7@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        christian.brauner@ubuntu.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        ZhangPeng <zhangpeng362@huawei.com>, linux-m68k@vger.kernel.org,
        debian-ports <debian-ports@lists.debian.org>
Subject: Re: [syzbot] [hfs?] WARNING in hfs_write_inode
Message-ID: <20230721131009.GE5764@mit.edu>
References: <50D6A66B-D994-48F4-9EBA-360E57A37BBE@dubeyko.com>
 <CACT4Y+aJb4u+KPAF7629YDb2tB2geZrQm5sFR3M+r2P1rgicwQ@mail.gmail.com>
 <ZLlvII/jMPTT32ef@casper.infradead.org>
 <2d0bd58fb757e7771d13f82050a546ec5f7be8de.camel@physik.fu-berlin.de>
 <ZLl2Fq35Ya0cNbIm@casper.infradead.org>
 <868611d7f222a19127783cc8d5f2af2e42ee24e4.camel@kernel.org>
 <ZLmzSEV6Wk+oRVoL@dread.disaster.area>
 <60b57ae9-ff49-de1d-d40d-172c9e6d43d5@linux-m68k.org>
 <ZLnbN4Mm9L5wCzOK@casper.infradead.org>
 <3eca2dab-df70-9d91-52a1-af779e3c2e04@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3eca2dab-df70-9d91-52a1-af779e3c2e04@linux-m68k.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 21, 2023 at 06:14:04PM +1000, Finn Thain wrote:
> 
> I'm not blaming the unstable API for the bugs, I'm blaming it for the 
> workload. A stable API (like a userspace API) decreases the likelihood 
> that overloaded maintainers have to orphan a filesystem implementation.

You are incorrect.  The HFS file system has gotten zero development
attention and the bugs were not the result of the API changes.  The
main issue here is that the HFS file system does not have maintainer,
and decreasing the workload will not magically make someone appear
with deep knowledge of that particular part of the code base.

It's also the case that the actual amount of work on the "overloaded
maintainers" caused by API changes is minimal --- it's dwarfed by
syzbot noise (complaints from syzbot that aren't really bugs, or for
really outré threat models).

API changes within the kernel are the responsibility of the people
making the change.  For example, consider all of the folio changes
that have been landing in the kernel; the amount of extra work on the
part of most file system maintainers is minimal, because it's the
people making the API changes who update the file system.  I won't say
that it's _zero_ work, because file system maintainers review the
changes, and we run regression tests, and we sometimes need to point
out when a bug has been introduced --- at which point the person
making the API change has the responsibility of fixing or reverting
the change.

An unstable API are much painful for out-of-tree kernel code.  But
upstream kernel developers aren't really concerned with out-of-tree
kernel code, except to point out that the work of the people who are
promulgated out-of-tree modules would be much less if they actually
got them cleaned up and made acceptable for upstream inclusion.

					- Ted
