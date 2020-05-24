Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1B71DFEC2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 May 2020 13:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgEXL5K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 May 2020 07:57:10 -0400
Received: from verein.lst.de ([213.95.11.211]:36936 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbgEXL5K (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 May 2020 07:57:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 576A468C4E; Sun, 24 May 2020 13:57:07 +0200 (CEST)
Date:   Sun, 24 May 2020 13:57:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-ext4@vger.kernel.org,
        jack@suse.cz, tytso@mit.edu, adilger@dilger.ca,
        riteshh@linux.ibm.com, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: fiemap cleanups v4
Message-ID: <20200524115706.GA1800@lst.de>
References: <20200523073016.2944131-1-hch@lst.de> <20200523155216.GZ23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523155216.GZ23230@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 23, 2020 at 04:52:16PM +0100, Al Viro wrote:
> Hmmm...  I can do an immutable shared branch, no problem.  What would
> you prefer for a branchpoint for that one?

This needs pretty much latest Linus' tree as it sits on top of the bug
fixes merged this week.  But then again I'm not sure we even need
a shared tree, as there shouldn't be any conflicts.  But looking at
linux-next it seems Ted has actually pulled in the whole series, so
I think we actually are done.

But while I've got you attention:  Can you take a look at my
"clean up kernel_{read,write} & friends v2" series?
