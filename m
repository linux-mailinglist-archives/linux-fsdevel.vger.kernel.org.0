Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E96EFA7205
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 19:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbfICR4N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 13:56:13 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:33200 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfICR4N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 13:56:13 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.1 #3 (Red Hat Linux))
        id 1i5D2I-00046p-T4; Tue, 03 Sep 2019 17:56:11 +0000
Date:   Tue, 3 Sep 2019 18:56:10 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Qian Cai <cai@lca.pw>, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "fs/namei.c: keep track of nd->root refcount status" causes boot
 panic
Message-ID: <20190903175610.GM1131@ZenIV.linux.org.uk>
References: <7C6CCE98-1E22-433C-BF70-A3CBCDED4635@lca.pw>
 <20190903123719.GF1131@ZenIV.linux.org.uk>
 <20190903130456.GA9567@infradead.org>
 <20190903134832.GH1131@ZenIV.linux.org.uk>
 <20190903135024.GA8274@infradead.org>
 <20190903135354.GI1131@ZenIV.linux.org.uk>
 <20190903153930.GA2791@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903153930.GA2791@infradead.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 08:39:30AM -0700, Christoph Hellwig wrote:

> > There's much nastier situation than "new upstream kernel released,
> > need to rebuild" - it's bisect in mainline trying to locate something...
> 
> I really don't get the point.  And it's not like we've card about
> this anywhere else.  And jumping wildly around with the numeric values
> for constants will lead to bugs like the one you added and fixed again
> and again.

The thing is, there are several groups - it's not as if all additions
were guaranteed to be at the end.  So either we play with renumbering
again and again, or we are back to the square one...

Is there any common trick that would allow to verify the lack of duplicates
at the build time?

Or we can reorder the list by constant value, with no grouping visible
anywhere...
