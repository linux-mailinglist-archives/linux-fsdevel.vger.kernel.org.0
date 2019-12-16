Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D686121221
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2019 18:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfLPRqU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 12:46:20 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:58312 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfLPRqU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:46:20 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iguRk-00066U-BG; Mon, 16 Dec 2019 17:46:16 +0000
Date:   Mon, 16 Dec 2019 17:46:16 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jan Kara <jack@suse.cz>
Cc:     David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] pipe: Fix bogus dereference in iov_iter_alignment()
Message-ID: <20191216174616.GN4203@ZenIV.linux.org.uk>
References: <20191216105432.5969-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216105432.5969-1-jack@suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 16, 2019 at 11:54:32AM +0100, Jan Kara wrote:
> We cannot look at 'i->pipe' unless we know the iter is a pipe. Move the
> ring_size load to a branch in iov_iter_alignment() where we've already
> checked the iter is a pipe to avoid bogus dereference.
> 
> Reported-by: syzbot+bea68382bae9490e7dd6@syzkaller.appspotmail.com
> Fixes: 8cefc107ca54 ("pipe: Use head and tail pointers for the ring, not cursor and length")
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  lib/iov_iter.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
>  Al, David, not sure who's going to merge this so sending to both :).

Applied, will push tonight.
