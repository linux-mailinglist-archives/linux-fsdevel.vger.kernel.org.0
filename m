Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84181C8902
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2019 14:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfJBMqz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Oct 2019 08:46:55 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52776 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725747AbfJBMqz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Oct 2019 08:46:55 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x92CkpbR023681
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Oct 2019 08:46:52 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 451AA42088C; Wed,  2 Oct 2019 08:46:51 -0400 (EDT)
Date:   Wed, 2 Oct 2019 08:46:51 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Daegyu Han <dgswsk@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: How can I completely evict(remove) the inode from memory and
 access the disk next time?
Message-ID: <20191002124651.GC13880@mit.edu>
References: <CA+i3KrYpvd4X7uD_GMAp8UZMbR_DhmWvgzw2bHuSQ7iBvpsJQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+i3KrYpvd4X7uD_GMAp8UZMbR_DhmWvgzw2bHuSQ7iBvpsJQg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 02, 2019 at 05:30:21PM +0900, Daegyu Han wrote:
> Hi linux file system experts,
> 
> I'm so sorry that I've asked again the general question about Linux
> file systems.
> 
> For example, if there is a file a.txt in the path /foo/ bar,
> what should I do to completely evict(remove) the inode of bar
> directory from memory and read the inode via disk access?

There is no API to do this from userspace.  The only way to do this is
to unmount the entire file system.

From the kernel, it's *way* more complicated than this.  Making a
shared-disk file system requires a lot more changes to the kernel
code.  You might want to take a look at ocfs2.  This was a file system
that started using the ext3 file system code, and **extensive**
kernel-level code changes were made to make it be a shared-disk file
system.

						- Ted
						
