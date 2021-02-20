Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65CA532038E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Feb 2021 04:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhBTDmQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Feb 2021 22:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhBTDmQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Feb 2021 22:42:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D034C061574;
        Fri, 19 Feb 2021 19:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XpvZFAZWm4e9oqz8w8ibm0Bom9IPmTuwwRBgBGscJZA=; b=uIPlh9WpDecD8Ibg0yXcBx7CPF
        +sbNQlkopxvZ4MXYAyqMz6SV7UWJyu2OnjyoMyy5t3YQ8uDrArQb79n0qUhgWQgJn6v0ndTAApEHN
        EVUVcDUIURS225DjOxUyB3+wp4qxr5QyhBNkMgNAREHW7Nd6Ml8Be7n2txmcIAjET+FNsxkXlIFXq
        B3K6xjcxU+Euvq4ZPLuGeztnS6OVSSW1ocBDqLhyIeXdLkETzCoQJ7PxGHqVHcaGqI0xvCFJNNg7a
        sgjs7xsLSguyCRA2zcLftGONGldVJTsvAe5/kdY7SQHTNcWnO94/5fhJVNepscRlWbr5JO86//d5y
        HkjUW1cQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lDJ7t-003aax-Gv; Sat, 20 Feb 2021 03:40:32 +0000
Date:   Sat, 20 Feb 2021 03:40:13 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Erik Jensen <erikjensen@rkjnsn.net>
Cc:     Theodore Ts'o <tytso@mit.edu>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: page->index limitation on 32bit system?
Message-ID: <20210220034013.GB2858050@casper.infradead.org>
References: <1783f16d-7a28-80e6-4c32-fdf19b705ed0@gmx.com>
 <20210218121503.GQ2858050@casper.infradead.org>
 <af1aac2f-e7dc-76f3-0b3a-4cb36b22247f@gmx.com>
 <20210218133954.GR2858050@casper.infradead.org>
 <e0faf229-ce7f-70b8-8998-ed7870c702a5@gmx.com>
 <YC/jYW/K9krbfnfl@mit.edu>
 <a79562ac-1b87-8761-05a6-43b911e093a0@rkjnsn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a79562ac-1b87-8761-05a6-43b911e093a0@rkjnsn.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 19, 2021 at 06:20:43PM -0800, Erik Jensen wrote:
> I assume the 4KiB entry size in the page cache is fundamental, and can't be,
> e.g., increased to 16KiB to allow addressing up to 64TiB of storage?

The bootlin link i sent in the other email does exactly that.
