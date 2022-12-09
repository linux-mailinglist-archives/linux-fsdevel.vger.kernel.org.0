Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812F5648944
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Dec 2022 20:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiLIT5I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Dec 2022 14:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiLIT5H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Dec 2022 14:57:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82246B9BA;
        Fri,  9 Dec 2022 11:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x7Gwys9SNjHVJLGOYQXtB+2ZEnoPv6+IPnEj4HTbkCg=; b=vPoo33iwT/577sbyr5Mwpyi32J
        eByDrcmHYbf5nJo9kicg/1RWr69oLU0wJ6sBckDUhIZhtGCcIrJlUvwFAr4jzLs3jWFrUNx0ztKPE
        5H7y4g1l3wwS0l48PrQHUyKLFrHEpIHiogxLrNqUGcVcJ0D8rPt8huUS7D8zW6yOxlEvyNKPKbRWI
        HGl+W6qLJwIRJR7hAGBqofsd5VwbzHYwMVa8i2fMJKDJ3UvHyqMdFzIEZYJi5rfl54ADkj5U6eG9l
        EVlqPwHFjKIW0rDlu7F1+E8ad/SG5OUiQ7WYDV+XtrXUBr4zIRsw4NGLUAXN1+P4G3ajjTGQzDHDC
        iXms/C7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p3jUV-008Lm5-5e; Fri, 09 Dec 2022 19:57:03 +0000
Date:   Fri, 9 Dec 2022 19:57:03 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+919c5a9be8433b8bf201@syzkaller.appspotmail.com>
Cc:     dvyukov@google.com, elver@google.com, hdanton@sina.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: [syzbot] WARNING in do_mkdirat
Message-ID: <Y5OTDzE6grKZWrH6@casper.infradead.org>
References: <00000000000064d06705eeed9b4e@google.com>
 <000000000000f865be05ef6a77fa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f865be05ef6a77fa@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 09, 2022 at 11:50:41AM -0800, syzbot wrote:
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145fde33880000

I see that ntfs3 is involved.  It's probably the known issue where ntfs3
corrupts the lockdep database.
