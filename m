Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4D528EE01
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 09:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgJOH61 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 03:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729184AbgJOH61 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 03:58:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B622C061755;
        Thu, 15 Oct 2020 00:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=khOXuD/IwrhunH2i5AohU0tEnrbxmaci52Dm2WmjsT8=; b=GG4R1ZfBfanYWfixjb94VKLs01
        Jwpqk8PGXip6FuPCgKdurTH/9bwMi8gfJFPzMCX0o3qgPPbpOFOecyFptQ3kgye0q9d6kUG0V8bjv
        Tpe6aNGHnTzBpaJk7CqVTm/cFD2P9mwEX7PVOysyw2lV9mAaC0s63iBb/OPxs4S1Sg+bdwKs62O5F
        d+yjES+JSS4Jo0B9P/rgx0EYtLBjlgZGJKPsgZGqo2uHz7Dq8A9FNGlX38jjyoQwPQfc2ucI+I/mz
        H+q/J+dWFMINTmGrk97Pm13Y7pKkmGnesdFZAVNI+1OsoO8I/t3ISwghuqlZMvKfNgkS5Vi2RB29o
        nGW/rftw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSy9S-0007qt-IS; Thu, 15 Oct 2020 07:58:18 +0000
Date:   Thu, 15 Oct 2020 08:58:18 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     axboe@kernel.dk, hch@infradead.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        ming.lei@redhat.com, joseph.qi@linux.alibaba.com,
        xiaoguang.wang@linux.alibaba.com
Subject: Re: [v2 1/2] block: disable iopoll for split bio
Message-ID: <20201015075818.GA30117@infradead.org>
References: <20201015074031.91380-1-jefflexu@linux.alibaba.com>
 <20201015074031.91380-2-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015074031.91380-2-jefflexu@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +
> +	/*
> +	 * IOpoll is initially for small size, latency sensitive IO.
> +	 *
> +	 * It doesn't work well for big IO, especially when it needs to be split to
> +	 * multiple bios. When it comes to bio split, the returned cookie of
> +	 * __submit_bio_noacct_mq() is indeed the cookie of the last split bio. The
> +	 * completion of *this* last split bio done by polling doesn't mean the whole

Please fix the various overly long lines.
