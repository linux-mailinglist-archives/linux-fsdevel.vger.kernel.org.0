Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1356619FAD4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 18:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgDFQzX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 12:55:23 -0400
Received: from nautica.notk.org ([91.121.71.147]:54276 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729089AbgDFQzX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:55:23 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 6473CC01B; Mon,  6 Apr 2020 18:55:21 +0200 (CEST)
Date:   Mon, 6 Apr 2020 18:55:06 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Sergey Alirzaev <l29ah@cock.li>
Subject: Re: [GIT PULL] 9p update for 5.7
Message-ID: <20200406165506.GA26216@nautica>
References: <20200406110702.GA13469@nautica>
 <CAHk-=whVEPEsKhU4w9y_sjbg=4yYHKDfgzrpFdy=-f9j+jTO3w@mail.gmail.com>
 <20200406164057.GA18312@nautica>
 <20200406164641.GF21484@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200406164641.GF21484@bombadil.infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox wrote on Mon, Apr 06, 2020:
> POSIX may well "allow" short reads, but userspace programmers basically
> never check the return value from read().  Short reads aren't actually
> allowed.  That's why signals are only allowed to interrupt syscalls if
> they're fatal (and the application will never see the returned value
> because it's already dead).

I've seen tons of programs not check read return value yes but these
also have no idea what O_NONBLOCK is so I'm not sure how realistic a
use-case that is?

The alternative I see would be making pipes go through the server as I
said, but that would probably mean another mount option for this; pipes
work as local pipes like they do in nfs currently.

-- 
Dominique
