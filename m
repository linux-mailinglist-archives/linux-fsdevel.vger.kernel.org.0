Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98BB52FB8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2019 14:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfE3M10 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 May 2019 08:27:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbfE3M10 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 May 2019 08:27:26 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1693248B4;
        Thu, 30 May 2019 12:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559219245;
        bh=Zu7egCdvljXGfB3X0g+OTpnio/1b3nMmqQhAksx//C8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OAxxz+p9rIs3KejKTK3Xx9a83hMQfV1WIAwhfVxPIfN5IiCGs1XNp/TREDK7DcyJ7
         62tp6cGMIhBr/OE0WaC619zni6LuxLnBjWEIsAFElcbjyUiRq6fg3XQ1D+6P7NEm7N
         fLxBtBe91NhXw1jrcYWqfm48gSp0k5kI067tnf6Y=
Date:   Thu, 30 May 2019 05:27:25 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     David Sterba <dsterba@suse.com>, Christoph Hellwig <hch@lst.de>,
        Joel Becker <jlbec@evilplan.org>,
        John Johansen <john.johansen@canonical.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v3 06/10] debugfs: simplify __debugfs_remove_file()
Message-ID: <20190530122725.GA17734@kroah.com>
References: <20190526143411.11244-1-amir73il@gmail.com>
 <20190526143411.11244-7-amir73il@gmail.com>
 <CAOQ4uxjr50juBR=48c8BqnRhZv0yBri4k_zF9ap2Rsypd36EoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjr50juBR=48c8BqnRhZv0yBri4k_zF9ap2Rsypd36EoA@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 30, 2019 at 08:49:52AM +0300, Amir Goldstein wrote:
> On Sun, May 26, 2019 at 5:34 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > Move simple_unlink()+d_delete() from __debugfs_remove_file() into
> > caller __debugfs_remove() and rename helper for post remove file to
> > __debugfs_file_removed().
> >
> > This will simplify adding fsnotify_unlink() hook.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Hi Greg,
> 
> Will be you be able to provide an ACK on this debugfs patch and the next one.

It's only been 4 days, and I'm traveling this week, give me a chance...

