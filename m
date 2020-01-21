Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 894AD143507
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 02:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgAUBIr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 20:08:47 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:57624 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgAUBIr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 20:08:47 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iti21-00CM3w-Tv; Tue, 21 Jan 2020 01:08:38 +0000
Date:   Tue, 21 Jan 2020 01:08:37 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v19 0/1] fs: Add VirtualBox guest shared folder (vboxsf)
 support
Message-ID: <20200121010837.GH8904@ZenIV.linux.org.uk>
References: <20191212140914.21908-1-hdegoede@redhat.com>
 <ae314c55-905a-fce0-21aa-81c13279c004@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae314c55-905a-fce0-21aa-81c13279c004@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 11, 2020 at 12:46:30PM +0100, Hans de Goede wrote:
> Hi All,
> 
> On 12-12-2019 15:09, Hans de Goede wrote:
> > Hello Everyone,
> > 
> > Here is the 19th version of my cleaned-up / refactored version of the
> > VirtualBox shared-folder VFS driver.
> > 
> > This version addresses all remarks from Al Viro's review of v18.
> > 
> > I believe that this is ready for upstream merging now, if this needs
> > more work please let me know.
> > 
> > Changes in v19:
> > - Misc. small code tweaks suggested by Al Viro (no functional changes)
> > - Do not increment dir_context->pos when dir_emit has returned false.
> > - Add a WARN_ON check for trying to access beyond the end of a
> >    vboxsf directory buffer, this uses WARN_ON as this means the host has
> >    given us corrupt data
> > - Catch the user passing the "nls" opt more then once
> 
> Ping? Can I please either get some feedback on this patch, or can we get
> this merged / queued up for 5.6 please ?

Merged and pushed into #for-next
