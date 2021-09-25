Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF7A4182F7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Sep 2021 16:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343834AbhIYO7I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Sep 2021 10:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbhIYO7H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Sep 2021 10:59:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4659C061570;
        Sat, 25 Sep 2021 07:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PyFYuyGZybL7cSTK0f665wfGUh8dtwTELe7jzY8FD1U=; b=G8TN7WiaFixroDwBeMBD/BPUaJ
        qThH/nviuNwMQjvjmzk5nEYoPB0Tesoef21VSwULA6cbYUS760umGbUtQR33MtNHktReSp38Q1Zx3
        q0g/iUSA0juTjCeCPzefvXHQnY1ZdIXXNZdZg0wemCk7jWS91mlmeCYEq8TkNE69ERMgNaiXZk4tX
        fIV6QgFBgBxJ67EPz7q4tZdsism+N4M3GXQ2IZc4GhftzXgGiAcG2UxjcVE2XvIk7Fwx/g29V7zkW
        DtIP+qQjmjVbihZ1+8eMs3KcT9fHmT0W2NkOX6DusUpkqjc1xp5U7AYcs5P85A6CPk7OENlX1tcgY
        QXREXmGA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mU96b-008BsC-Hu; Sat, 25 Sep 2021 14:56:54 +0000
Date:   Sat, 25 Sep 2021 15:56:45 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     hch@lst.de, trond.myklebust@primarydata.com,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, darrick.wong@oracle.com,
        viro@zeniv.linux.org.uk, jlayton@kernel.org,
        torvalds@linux-foundation.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 9/9] mm: Remove swap BIO paths and only use DIO paths
Message-ID: <YU84rYOyyXDP3wjp@casper.infradead.org>
References: <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
 <163250396319.2330363.10564506508011638258.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163250396319.2330363.10564506508011638258.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 24, 2021 at 06:19:23PM +0100, David Howells wrote:
> Delete the BIO-generating swap read/write paths and always use ->swap_rw().
> This puts the mapping layer in the filesystem.

Is SWP_FS_OPS now unused after this patch?

Also, do we still need ->swap_activate and ->swap_deactivate?
