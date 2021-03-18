Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F09340A5A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 17:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhCRQkW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 12:40:22 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:38800 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbhCRQkQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 12:40:16 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lMvcU-0079z0-3A; Thu, 18 Mar 2021 16:35:34 +0000
Date:   Thu, 18 Mar 2021 16:35:34 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Xiaofeng Cao <cxfcosmos@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaofeng Cao <caoxiaofeng@yulong.com>
Subject: Re: [PATCH] fs/dcache: fix typos and sentence disorder
Message-ID: <YFOBVg8UiQh4Z4II@zeniv-ca.linux.org.uk>
References: <20210318143153.13455-1-caoxiaofeng@yulong.com>
 <20210318150020.GP3420@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318150020.GP3420@casper.infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 18, 2021 at 03:00:20PM +0000, Matthew Wilcox wrote:
> On Thu, Mar 18, 2021 at 10:31:53PM +0800, Xiaofeng Cao wrote:
> > change 'sould' to 'should'
> > change 'colocated' to 'collocated'
> 
> uh.  collocated is incorrect.  colocated is correct.
> https://www.merriam-webster.com/dictionary/colocate
> https://www.merriam-webster.com/dictionary/collocate

A bit more condensed variant: these two are both derived from
con- + loco, but have different meanings -
	colocated: occupying the same place
	collocated: sitting next to each other

In this case it's very much the former - the point of comment is that
the fields in question share the same memory location, but we are
guaranteed that any dentry we find in the alias list of an inode will
have that location used for ->i_dentry.

"co-located" would probably work better there.

PS: history of that word pair is amusing.  Both are (English) past participles,
of co-locate and collocate resp.  The former had the (Latin) prefix applied in
English to borrowing from Latin (co-locate < locate < locatus) , the latter
is straight borrowing (collocate < collocatus).  Incidentally, in both cases
the borrowed form had already been a past participle (of loco and
colloco) resp.  And colloco had the same prefix (com-/con-/co-) applied
in Latin, with regular assimilation of -nl- to -ll-.  But at that stage
the meaning of the verb had been closer to "put in place" than to
"be in place", so that gave "put next to each other" instead of "share
the place".  Shift towards "be found next to each other" happened long after
the prefix had been applied...
