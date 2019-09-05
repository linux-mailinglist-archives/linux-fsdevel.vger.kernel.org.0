Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB15AA953
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 18:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389865AbfIEQrG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 12:47:06 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38338 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389741AbfIEQrF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 12:47:05 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.1 #3 (Red Hat Linux))
        id 1i5uuR-0002Cj-Kq; Thu, 05 Sep 2019 16:47:00 +0000
Date:   Thu, 5 Sep 2019 17:46:59 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Qian Cai <cai@lca.pw>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "fs/namei.c: keep track of nd->root refcount status" causes boot
 panic
Message-ID: <20190905164659.GO1131@ZenIV.linux.org.uk>
References: <7C6CCE98-1E22-433C-BF70-A3CBCDED4635@lca.pw>
 <20190903123719.GF1131@ZenIV.linux.org.uk>
 <20190903130456.GA9567@infradead.org>
 <20190903134832.GH1131@ZenIV.linux.org.uk>
 <20190903135024.GA8274@infradead.org>
 <20190903135354.GI1131@ZenIV.linux.org.uk>
 <20190903153930.GA2791@infradead.org>
 <20190903175610.GM1131@ZenIV.linux.org.uk>
 <20190904123940.GA24520@infradead.org>
 <CA+G9fYtwEfp482+8qzGKD9NSHOGtKyp4pKbVxQK8G4L94UvOVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtwEfp482+8qzGKD9NSHOGtKyp4pKbVxQK8G4L94UvOVQ@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 05, 2019 at 02:43:12PM +0530, Naresh Kamboju wrote:
> Hi Christoph and Al Viro,
> 
> Linux next 20190904 boot PASS now.
> May i know which patch fixed this problem ?

commit 84a2bd39405ffd5fa6d6d77e408c5b9210da98de
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Tue Jul 16 21:20:17 2019 -0400

    fs/namei.c: keep track of nd->root refcount status

	And I'm not going to abstain from folding the trivial fix
(LOOKUP_ROOT_GRABBED had been given the same value as LOOKUP_EMPTY)
into the commit.  Sorry.  I don't know how to tell CI systems out
there about cases like that ("earlier version of this commit used
to have a bug, fix folded in").  Something like
Supersedes: <list of sha1>
might or might not be useful for tracking; not sure.
