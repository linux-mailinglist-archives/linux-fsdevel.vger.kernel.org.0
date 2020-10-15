Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C9328EB6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 05:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgJODS1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 23:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgJODS0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 23:18:26 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A201BC061755;
        Wed, 14 Oct 2020 20:18:26 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kStmV-000WGW-EN; Thu, 15 Oct 2020 03:18:19 +0000
Date:   Thu, 15 Oct 2020 04:18:19 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] vfs: move the clone/dedupe/remap helpers to a single
 file
Message-ID: <20201015031819.GN3576660@ZenIV.linux.org.uk>
References: <160272187483.913987.4254237066433242737.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160272187483.913987.4254237066433242737.stgit@magnolia>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 14, 2020 at 05:31:14PM -0700, Darrick J. Wong wrote:

> AFAICT, nobody is attempting to land any major changes in any of the vfs
> remap functions during the 5.10 window -- for-next showed conflicts only
> in the Makefile, so it seems like a quiet enough time to do this.  There
> are no functional changes here, it's just moving code blocks around.
> 
> So, I have a few questions, particularly for Al, Andrew, and Linus:
> 
> (1) Do you find this reorganizing acceptable?

No objections, assuming that it's really a move (it's surprisingly easy to
screw that up - BTDT ;-/)

I have not done function-by-function comparison, but assuming it holds...
no problem.

> (2) I was planning to rebase this series next Friday and try to throw it
> in at the end of the merge window; is that ok?  (The current patches are
> based on 5.9, and applying them manually to current master and for-next
> didn't show any new conflicts.)

Up to Linus.  I don't have anything in vfs.git around that area; the
only remaining stuff touching fs/read_write.c is nowhere near those,
AFAICS.
