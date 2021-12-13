Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD182472F6B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 15:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239462AbhLMOeu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 09:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239433AbhLMOes (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:34:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E4AC061574;
        Mon, 13 Dec 2021 06:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NHf5mY8GZXoKNe+svXGSA5q5YU2hSkP16Gr4ut6xA0Y=; b=sAQ2vtRnL8tHwHQK19U6OZgm8B
        SAQ0/GoGMzbk0nPJL3GYweunIvz+16SAteIyTNorWfUR5fu/srglA2jPpIR9z8x+8J2iXNwvsxk7q
        QMz13wNlWqL5IIbu/uuoOZEURQfkBexzz+E05njteu6WyMQKcqPz9noVlowaBQLw9nqiws3dCLcu2
        4sHILPxwmzkMWZtlLIQFruLCkn7TLO0o8Rv1T57PiCqHeYIz9QnqSO2fJLzCayCgBRZzck6GIW8al
        ItZ6hdcSgZlEzpU/DEUwznm5KgzXpiNVTfTZk0RnUhYniy6Te6UU6d/HhtOVJqTNdFkaaHra5MVZ2
        WvvQk3pw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwmPX-00CsBK-JW; Mon, 13 Dec 2021 14:34:39 +0000
Date:   Mon, 13 Dec 2021 14:34:39 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>, linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iov-kaddr
Message-ID: <YbdZ/2Odm70modUf@casper.infradead.org>
References: <20211213141907.3064347-1-willy@infradead.org>
 <20211213141907.3064347-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213141907.3064347-4-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 13, 2021 at 02:19:07PM +0000, Matthew Wilcox (Oracle) wrote:
> ---
>  fs/9p/vfs_dir.c     |  5 +----
>  fs/9p/xattr.c       |  6 ++----
>  include/linux/uio.h |  9 +++++++++
>  lib/iov_iter.c      | 32 ++++++++++++++++++++++++++++++++
>  4 files changed, 44 insertions(+), 8 deletions(-)

Ugh, this was NOT supposed to go out.  Sorry, I'll do a v3.
