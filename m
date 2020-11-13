Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCD62B1B23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 13:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgKMM2v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 07:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgKMM2u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 07:28:50 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60630C0613D1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 04:28:50 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdYC5-00551m-TF; Fri, 13 Nov 2020 12:28:46 +0000
Date:   Fri, 13 Nov 2020 12:28:45 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Chirantan Ekbote <chirantan@chromium.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Subject: Re: [PATCH 2/2] fuse: Implement O_TMPFILE support
Message-ID: <20201113122845.GG3576660@ZenIV.linux.org.uk>
References: <20201109100343.3958378-1-chirantan@chromium.org>
 <20201109100343.3958378-3-chirantan@chromium.org>
 <CAJfpegv5DdgCqdtSzUS43P9JQeUg9fSyuRXETLNy47=cZyLtuQ@mail.gmail.com>
 <CAJFHJrqZMg6A_QnoOL3e5gNZtYquUPSr4B0ZLZMSKQH6o7sxag@mail.gmail.com>
 <CAJfpegsjeRSeabJK5xLr4g7mDkwT88u+iOnhwCj_78-HT+HVqA@mail.gmail.com>
 <CAJFHJroPwxB3EW+wFg=NgYsKiQAswd7MNm6Ha3jUAPdp6PMMsg@mail.gmail.com>
 <CAJfpegv4X2m=-N69iB+Q_6fneeX_0uMNyzkVqfU+qQXdqXSUNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegv4X2m=-N69iB+Q_6fneeX_0uMNyzkVqfU+qQXdqXSUNw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 13, 2020 at 11:52:09AM +0100, Miklos Szeredi wrote:

> It's the wrong interface, and we'll have to live with it forever if we
> go this route.
> 
> Better get the interface right and *then* think about the
> implementation.  I don't think adding ->atomic_tmpfile() would be that
> of a big deal, and likely other distributed fs would start using it in
> the future.

Let me think about it; I'm very unhappy with the amount of surgery it has
taken to somewhat sanitize the results of ->atomic_open() introduction, so
I'd prefer to do it reasonably clean or not at all.
