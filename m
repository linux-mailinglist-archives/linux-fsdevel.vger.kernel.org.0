Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3A738F9C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 07:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhEYFDH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 01:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbhEYFDG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 01:03:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F865C061574;
        Mon, 24 May 2021 22:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Eb7bQQUEft/Wjyg3gjcZ6KFSxs3l21/AcHNdMKpY2sc=; b=Ymf6gC5mmvc9AQebvhRkJHBy1l
        4DSm7zYm7/UILpLKDq8sENTtemjWG0wmRRjZKAlcJN8cUn7eACq9EXltP3M6mn/nzGWJSGQGLWs13
        Lce2evxqEhHFs7SjDh4PaLS2yBKz5kYz1TX2RqAFdmlOqx19kj/qW15kl/GbQKYhdfV1s87lZJkEw
        DWlkUVnDN5j1itZ8PhPlN3Ftaat6Lf+gwMkLDBWf6xFQ2S+LIa9+QyOfM9JXZX/GuHXYHbURg4hr+
        vMqdfKhOwK51ndgqvY68nUcm/qodARrjqQHoxwtYhT3qSihLI9mfQsyfEHXrnk1B4PBcJdLSQblV4
        2jvEtpBA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1llPBb-0038Z5-A5; Tue, 25 May 2021 05:01:07 +0000
Date:   Tue, 25 May 2021 06:00:59 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Andreas Dilger <adilger@dilger.ca>,
        David Howells <dhowells@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>, Chris Mason <clm@fb.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-cachefs@redhat.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>
Subject: Re: How capacious and well-indexed are ext4, xfs and btrfs
 directories?
Message-ID: <YKyEi06Y8uNCr9BE@infradead.org>
References: <206078.1621264018@warthog.procyon.org.uk>
 <6E4DE257-4220-4B5B-B3D0-B67C7BC69BB5@dilger.ca>
 <YKntRtEUoxTEFBOM@localhost>
 <20210525042136.GA202068@locust>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525042136.GA202068@locust>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 24, 2021 at 09:21:36PM -0700, Darrick J. Wong wrote:
> Synchronous discard is slow, even on NVME.

That really depends on the device.  Some are specifically optimized for
that workload due to customer requirements.
