Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38C121B1C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 10:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbgGJIzl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jul 2020 04:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbgGJIzl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jul 2020 04:55:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0036FC08C5CE;
        Fri, 10 Jul 2020 01:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yEGHpJitABwnNlPlNCOVM1pFAgUoybFqtClPk1oj300=; b=IQmJrncprtSUcNlwxmRfiThQ1R
        GzdUSE6CiA1pt839GyDhc4lzBtxXug+wlbKxXgkAtW8I2ChexF2QaJvLqBppttZYPug48iRN11AO8
        w7UHwRLcdvzwzgN5q21R/CuTXtcRRqkC1Xkk/4uUxrgtNkkNefCwNc0OBWdHTGfxYQCbJ2XevR3dd
        erK7nWsFsiO9t3B6+TH+kmT/6MwtKjsQG42GhmYXLmn2DzOir5EDPyxrn2QTWAyoIX4+7L2mdxkN0
        wUw600qBK3cHvTeMpK/3PeXyWkod5w1mrDXWNNjD9PFK9QO/cOPZXuIs98aTJHAlrWU04HsXDfRsI
        RSove4Lw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtool-0007xj-4X; Fri, 10 Jul 2020 08:55:39 +0000
Date:   Fri, 10 Jul 2020 09:55:39 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     syzbot <syzbot+e6f77e16ff68b2434a2c@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: WARNING in __kernel_write
Message-ID: <20200710085539.GA28444@infradead.org>
References: <0000000000005f350105aa0af108@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000005f350105aa0af108@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 09, 2020 at 04:54:19PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:

9p fails to validate the fds passed in, triggering the new WARN_ON_ONCE
added in __kernel_write.  Mostly harmless as only the warning is new,
but I'll send a patch to better validate the fds at mount time.
