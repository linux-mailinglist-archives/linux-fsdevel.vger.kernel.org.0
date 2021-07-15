Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8393C98C4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 08:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240188AbhGOG1o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 02:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhGOG1o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 02:27:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A51C06175F;
        Wed, 14 Jul 2021 23:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G6VAiyhFZLvdaOInUgaZY4JVmqdLXKgD8FugW1vAebI=; b=ZP5mk6qHJsMQDlj2lu4DgQWMgD
        9/CnnEUhhpKKZa2uIhk/kA4wavYUWqW7jPbJbpbGxoFzsnqSoecHSESqBcK0hHm4pHK5pXIsUfW6N
        QB7OrVbsygJSn6/IvEickJDZRSSfEB33473ra2gpNruHHwn5ZdiE08EZA8PJhDwW8Q6AcpGhJgvDj
        uMQz1IToyXgwHOwudNj1oD3Lag3bBE2RukOPWp/llOJJrtRhw5qg+uJCkA/GCdkTLET/lHsQ3dqVm
        KWf2N6EH/qKOgVEJm0MCXCHFi0WLKlUfH3Hx+xJ81BLU4xCd8QCHurXY0J9l1pyGKiquZIHug6wPZ
        iR1YfOpg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3ums-0033S8-E1; Thu, 15 Jul 2021 06:24:12 +0000
Date:   Thu, 15 Jul 2021 07:23:58 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v3 6/9] fs: add a filemap_fdatawrite_wbc helper
Message-ID: <YO/UfqDrIEizq7Re@infradead.org>
References: <cover.1626288241.git.josef@toxicpanda.com>
 <1a353b1b013f616c2798526a8d21bb0cd609c25f.1626288241.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a353b1b013f616c2798526a8d21bb0cd609c25f.1626288241.git.josef@toxicpanda.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>  extern int filemap_check_errors(struct address_space *mapping);
>  extern void __filemap_set_wb_err(struct address_space *mapping, int err);
> +extern int filemap_fdatawrite_wbc(struct address_space *mapping,
> +				  struct writeback_control *wbc);

No need for the extern here.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
