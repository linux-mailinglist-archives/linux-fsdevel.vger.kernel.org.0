Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBF9942AEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 17:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409369AbfFLP31 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 11:29:27 -0400
Received: from fieldses.org ([173.255.197.46]:51294 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405706AbfFLP31 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:29:27 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 0A0C41E3B; Wed, 12 Jun 2019 11:29:27 -0400 (EDT)
Date:   Wed, 12 Jun 2019 11:29:27 -0400
From:   "J . Bruce Fields" <bfields@fieldses.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jeff Layton <jlayton@poochiereds.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH 1/2] vfs: replace i_readcount with a biased i_count
Message-ID: <20190612152927.GE16331@fieldses.org>
References: <20190608135717.8472-1-amir73il@gmail.com>
 <20190608135717.8472-2-amir73il@gmail.com>
 <1560343899.4578.9.camel@linux.ibm.com>
 <CAOQ4uxhooVwtHcDCr4hu+ovzKGUdWfQ+3F3nbgK3HXgV+fUK9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhooVwtHcDCr4hu+ovzKGUdWfQ+3F3nbgK3HXgV+fUK9w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 12, 2019 at 06:09:59PM +0300, Amir Goldstein wrote:
> But if I am following Miklos' suggestion to make i_count 64bit, inode
> struct size is going to grow for 32bit arch when  CONFIG_IMA is not
> defined, so to reduce impact, I will keep i_readcount as a separate
> member and let it be defined also when BITS_PER_LONG == 64
> and implement inode_is_open_rdonly() using d_count and i_count
> when i_readcount is not defined.

How bad would it be just to let the inode be a little bigger?  How big
is it already on 32 bit architectures?  How much does this change e.g.
how many inodes you can cache per megabyte?

--b.
