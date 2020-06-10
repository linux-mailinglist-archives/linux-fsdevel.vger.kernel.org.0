Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAE91F5BF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 21:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbgFJTWv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 15:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgFJTWv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 15:22:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F11C03E96B;
        Wed, 10 Jun 2020 12:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P5rggfV60XhCsWbRt7CAvNpgOpL+AJhTczIH3X0CdJs=; b=oIEtbNrQ1u3XaCtrmnDdBj5uf+
        VEN1KBfUJu+CTgd2NYg7Rn0y7FodIFOEKuQ0L9v9uidmJ/4w/hvtnBuRC16gmAu+A3uMLIzQlFmfl
        2/R6G36etHTpOpUMaWSMxOb1fsJF8HDwFbHziroy/tvq4i3kpkU5F1k6XeyvWTIL5zgqzc8QQLO2+
        X2+LTH4nBfIdXUnfQ8zf44WbodIMF8ULE29R5EihjMQpZ1Ef5HwY0ko1/KhP0m0lOHxdvwlLbJLd5
        1N7D4l/Mxb6Xx83IwV1iMCDhCLJwRU5fz+TQeXBy4hlGIpvt0b7vffYIOPyWOuPt76guv6kwAnh5D
        bL7Oau4w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj6JA-00079P-IL; Wed, 10 Jun 2020 19:22:44 +0000
Date:   Wed, 10 Jun 2020 12:22:44 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Tetsuhiro Kohada <kohada.t2@gmail.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Subject: Re: [PATCH v2] exfat: add missing brelse() calls on error paths
Message-ID: <20200610192244.GK19604@bombadil.infradead.org>
References: <20200610172213.GA90634@mwanda>
 <740ce77a-5404-102b-832f-870cbec82d56@web.de>
 <20200610184517.GC4282@kadam>
 <b44caf20-d3fc-30ac-f716-2375ed55dc9a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b44caf20-d3fc-30ac-f716-2375ed55dc9a@web.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 10, 2020 at 08:56:26PM +0200, Markus Elfring wrote:
> >>> If the second exfat_get_dentry() call fails then we need to release
> >>> "old_bh" before returning.  There is a similar bug in exfat_move_file().
> >>
> >> Would you like to convert any information from this change description
> >> into an imperative wording?
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=5b14671be58d0084e7e2d1cc9c2c36a94467f6e0#n151
> >
> > I really feel like imperative doesn't add anything.  I understand that
> > some people feel really strongly about it, but I don't know why.  It
> > doesn't make commit messages more understandable.
> 
> Do you insist to deviate from the given guideline?
> 
> 
> > The important thing is that the problem is clear, the fix is clear and
> > the runtime impact is clear.
> 
> I have got further ideas to improve also this commit message.
> I am curious if other contributors would like to add another bit of
> patch review.

You're nitpicking commit messages.  This is exactly the kind of thing
which drives people away.  Dan's commit message is fine.

It's actually hilarious because your emails are so unclear that I
can't understand them.  I have no idea what "collateral evolution"
means and yet you use it in almost every email.  Why can't you use the
same terminology the rest of us use?
