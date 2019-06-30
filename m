Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27AEF5B064
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jun 2019 17:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfF3P12 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jun 2019 11:27:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42846 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfF3P11 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jun 2019 11:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LCpUTi3xHdozJnaR/G7priP4/VBDokVwOv7n3lYabYA=; b=NedaD1rmEjYLf8cBrouKko05j
        qB5L4Xadzac9Q7+U6hqYLO0lULRLd7pTvQXxkUOgs+UWJ8R3wMbvTU4IoyiAaNZOIS2ALAbayfr/z
        94/JFbYe1phYYPzndpfWn/MV/jD9KQn2/Hg+SwavjCyGEKJjjuD4yLH0K7qZGceWk1xHT89rI/2+q
        5cTQqOk6HhAPomfdj+uprHDh6WRnrZlf7Q4kLhXkwFxuST41LbUgmL9YBmmNqPejN5IDMMSAOPFYP
        OaqOWYcm9QxLwq4UhU96/1Q8eth9n+jfKUUgGV7ec64ELxISqqz7WuMd+nnk9sPzJelyET3KX7ZtU
        X87HIUpYw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hhbji-0005ii-Pj; Sun, 30 Jun 2019 15:27:26 +0000
Date:   Sun, 30 Jun 2019 08:27:26 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@redhat.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/16] locks: create a new notifier chain for lease
 attempts
Message-ID: <20190630152726.GB15900@bombadil.infradead.org>
References: <20190630135240.7490-1-trond.myklebust@hammerspace.com>
 <20190630135240.7490-2-trond.myklebust@hammerspace.com>
 <20190630135240.7490-3-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190630135240.7490-3-trond.myklebust@hammerspace.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 30, 2019 at 09:52:26AM -0400, Trond Myklebust wrote:
> +++ b/fs/locks.c
> @@ -212,6 +212,7 @@ struct file_lock_list_struct {
>  static DEFINE_PER_CPU(struct file_lock_list_struct, file_lock_list);
>  DEFINE_STATIC_PERCPU_RWSEM(file_rwsem);
>  
> +
>  /*
>   * The blocked_hash is used to find POSIX lock loops for deadlock detection.
>   * It is protected by blocked_lock_lock.

*cough*

