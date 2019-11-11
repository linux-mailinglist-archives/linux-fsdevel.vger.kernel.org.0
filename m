Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA600F704B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 10:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfKKJQs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 04:16:48 -0500
Received: from verein.lst.de ([213.95.11.211]:48230 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbfKKJQs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:16:48 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 061B968BE1; Mon, 11 Nov 2019 10:16:45 +0100 (CET)
Date:   Mon, 11 Nov 2019 10:16:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        wugyuan@cn.ibm.com, jlayton@kernel.org, hsiangkao@aol.com,
        Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH][RFC] race in exportfs_decode_fh()
Message-ID: <20191111091644.GA11108@lst.de>
References: <20190927044243.18856-1-riteshh@linux.ibm.com> <20191015040730.6A84742047@d06av24.portsmouth.uk.ibm.com> <20191022133855.B1B4752050@d06av21.portsmouth.uk.ibm.com> <20191022143736.GX26530@ZenIV.linux.org.uk> <20191022201131.GZ26530@ZenIV.linux.org.uk> <20191023110551.D04AE4C044@d06av22.portsmouth.uk.ibm.com> <20191101234622.GM26530@ZenIV.linux.org.uk> <20191102172229.GT20975@paulmck-ThinkPad-P72> <20191102180842.GN26530@ZenIV.linux.org.uk> <20191109031333.GA8566@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191109031333.GA8566@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 09, 2019 at 03:13:33AM +0000, Al Viro wrote:
> Does anyone see objections to the following patch?  Christoph, that seems to
> be your code; am I missing something subtle here?  AFAICS, that goes back to
> 2007 or so...

This goes back to way before that, that series jut factored out proper
export operations from the two inode or superblock methods we had before
with the rest handled in core code somewhere that made a complete
mess of file systems with 64-bit inode numbers.

Otherwise this looks fine, although splitting the refactoring from
the actual change would make for a much more readable series.
