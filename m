Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3145507FD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jun 2022 05:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiFSDHL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 23:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFSDHK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 23:07:10 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA40FD118
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jun 2022 20:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1Z4sPmeFeCUFZX3Tr1UV9t2uFGlacXvTuEdqBspDvso=; b=WheQ26rF0gnakKBcdfcyczJGP2
        70RQkzxjFBLKFOauaYxLtN1Yo6vRptmzy740KiYVypG3BvqZZi4msI+RQ3VX6DNca7YGluETu3xV2
        g3MxX/F2Ic0VRzUEgXtqfwKLHDND0W5lHEVZQ4u5mH24HWWgnbkFUx+zxvFoM+9XOSyU/9zwXahT/
        RW2W+QZmV9sO9QOBxcWi7ZST0JW0FGQPo9YDr1QDZiYPgNd9qFEtRBmJbh0vVxdHr5SFSHzOHYJmt
        APiefhSoZjbgYn1LSGGLJQsKL7Tv+Xt/FNTkUJQrqEUkE55jmzThzoE3zMlsH+f+AObxrrJQXHZXZ
        bKsoPvSA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2lHG-001vGU-SA;
        Sun, 19 Jun 2022 03:07:07 +0000
Date:   Sun, 19 Jun 2022 04:07:06 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 13/31] iov_iter_get_pages(): sanity-check arguments
Message-ID: <Yq6S2poyPe5Si8Zz@ZenIV>
References: <Yq1iNHboD+9fz60M@ZenIV>
 <20220618053538.359065-1-viro@zeniv.linux.org.uk>
 <20220618053538.359065-14-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618053538.359065-14-viro@zeniv.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 18, 2022 at 06:35:20AM +0100, Al Viro wrote:

> +	if (!maxsize || maxpages)

	if (!maxsize || !maxpages)

obviously...  That's only a bisect hazard, since 16/31 fixes it.
