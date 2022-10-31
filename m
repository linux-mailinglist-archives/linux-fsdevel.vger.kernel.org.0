Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E567D613E3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 20:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJaTbN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 15:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiJaTbM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:31:12 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F6712611;
        Mon, 31 Oct 2022 12:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rviBbapsFxtWmQob7Vnc9MthAUgA4/FDwFEapwwXp1U=; b=sSBvc8kL9xrdIC44Mbm9uYQqrW
        co7WSoKvJybAqXUBX1LBmFMeTmWyIGD+1kErq91jUnPZFujZhKb+6llEtinYR1dK45QUHGBupOl5e
        EfD+8I9uLohRmzdVCHBbzlBf6iDrfrGt6z3t96mwPAD5eozatX52S7G3m55X9rW1Mx7qE4aCfUtPi
        ueQDlcHoFzxOqvKORJDAsYtBqE114/X89+62r5zt2wYfaios15U6E0lYbSnnmtQxoa1C/W/0oSoh0
        SmdbbFyBVDEFZ+Ew34Q4sLotc5TUw7v+MJtV8NAKZZFL0fSTg8R2cZ9xdZdZp5Qdbmq2gbzXMW0hA
        EgoV3tqg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1opaV1-00Gm7q-2i;
        Mon, 31 Oct 2022 19:31:07 +0000
Date:   Mon, 31 Oct 2022 19:31:07 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>, Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] fs: use acquire ordering in __fget_light()
Message-ID: <Y2Aie8Aeu6AxHpVr@ZenIV>
References: <20221031175256.2813280-1-jannh@google.com>
 <Y2APCmYNjYOYLf8G@ZenIV>
 <CAG48ez094n05c3QJMy7vZ5U=z87MzqYeKU97Na_R9O36_LJSXw@mail.gmail.com>
 <Y2AYecOnLTkhmZB1@ZenIV>
 <CAHk-=whynVDmGUG0qNLhGboUKXbTCnKudEr4R=GN5mH-Bz9gLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whynVDmGUG0qNLhGboUKXbTCnKudEr4R=GN5mH-Bz9gLg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 31, 2022 at 12:07:36PM -0700, Linus Torvalds wrote:
> On Mon, Oct 31, 2022 at 11:48 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Anyway, it's unrelated to the patch itself.  I'm fine with it in the current
> > form.  Will apply for the next merge window, unless Linus wants it in right
> > now.
> 
> It doesn't strike me as hugely critical, so I'm fine with it being put
> in any random pile of "fixes to be applied" as long as it doesn't get
> lost entirely. But if y ou have a "fixes" branch that may end up
> coming to me before this release is over, that's not the wrong place
> either.

Applied to #fixes and pushed out...
