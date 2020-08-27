Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5CE025473F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 16:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgH0Opw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 10:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbgH0OpQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:45:16 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50FBC061264
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 07:45:15 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBJ92-005aaR-1E; Thu, 27 Aug 2020 14:44:52 +0000
Date:   Thu, 27 Aug 2020 15:44:52 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Frank van der Linden <fllinden@amazon.com>,
        Dave Chinner <david@fromorbit.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: file forks vs. xattr (was: xattr names for unprivileged
 stacking?)
Message-ID: <20200827144452.GA1236603@ZenIV.linux.org.uk>
References: <20200824222924.GF199705@mit.edu>
 <3331978.UQhOATu6MC@silver>
 <20200827140107.GH14765@casper.infradead.org>
 <159855515.fZZa9nWDzX@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159855515.fZZa9nWDzX@silver>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 27, 2020 at 04:23:24PM +0200, Christian Schoenebeck wrote:

> Be invited for making better suggestions. But one thing please: don't start 
> getting offending.
> 
> No matter which delimiter you'd choose, something will break. It is just about 
> how much will it break und how likely it'll be in practice, not if.

... which means NAK.  We don't break userland without very good reasons and
support for anyone's pet feature is not one of those.  It's as simple as
that.

> If you are concerned about not breaking anything: keep forks disabled.

s/disabled/out of tree/

One general note: the arguments along the lines of "don't enable that,
then" are either ignorant or actively dishonest; it really doesn't work
that way, as we'd learnt quite a few times by now.  There's no such
thing as "optional feature" - *any* feature, no matter how useless,
might end up a dependency (no matter how needless) of something that
would force distros to enable it.  We'd been down that road too many
times to keep pretending that it doesn't happen.
