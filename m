Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F433D1C1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 04:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhGVCMK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 22:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbhGVCMJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 22:12:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A6EC061575;
        Wed, 21 Jul 2021 19:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4agLquFvdJA5wVNZMiRpUkTBkKpTqhUIbJSXnN2uvmM=; b=F3sr48uJgrUvHj7sY1aKavnpXT
        wqXE6VCnW++nuLXrh0DeAldWfUHCota0ODDhvgHnJaLuqxN8Pa29b5SXyl1/PlMbPtGw7Oum2BFr3
        N0M/eBvkbsBvJKgnumt9fCCWH92qLI0MegGsHf2sI6ab3eNuYB1qN7ApA7EFX3x3YOvIMPJMMr0hk
        qGTIh933EbI/p22OVM4WM3V+I9hi0+oq57XKeuNY2576FaOg/6ahGCYYIiwKkKgJYZi+svXGtv4im
        /fRx3+fu26w64pQzcY+95aJ0kCY3AcvlOUn3wGlatXhEPebbAvwmGMbWtHi3jNCeq+mP7f2pru1rt
        6/LN/VYg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6Ooe-009ovT-Ge; Thu, 22 Jul 2021 02:52:14 +0000
Date:   Thu, 22 Jul 2021 03:52:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     butt3rflyh4ck <butterflyhuangxx@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        djwong@kernel.org
Subject: Re: A shift-out-of-bounds in minix_statfs in fs/minix/inode.c
Message-ID: <YPjdVAj7GLS8LyNK@casper.infradead.org>
References: <CAFcO6XOdMe-RgN8MCUT59cYEVBp+3VYTW-exzxhKdBk57q0GYw@mail.gmail.com>
 <YPhbU/umyUZLdxIw@casper.infradead.org>
 <CAFcO6XO0GR8GBVD7hT8VL5qey3cCYriMqvt0Dan72i5yVP6FxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFcO6XO0GR8GBVD7hT8VL5qey3cCYriMqvt0Dan72i5yVP6FxQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 22, 2021 at 10:43:10AM +0800, butt3rflyh4ck wrote:
> On Thu, Jul 22, 2021 at 1:37 AM Matthew Wilcox <willy@infradead.org> wrote:
> >That's not something we're
> > traditionally interested in, unless the filesystem is one customarily
> > used for data interchange (like FAT or iso9660).
> 
> These file systems are my fuzzing targets.

You're not the first.

https://lore.kernel.org/linux-fsdevel/6A96C62E-1D01-44AD-B2C5-7A2258BADC0D@schumilo.de/T/#u
