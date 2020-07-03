Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266B6213C08
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 16:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgGCOtD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 10:49:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:56990 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgGCOtD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 10:49:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F2DA8AC24;
        Fri,  3 Jul 2020 14:49:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9ACB31E12EB; Fri,  3 Jul 2020 16:49:01 +0200 (CEST)
Date:   Fri, 3 Jul 2020 16:49:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/20] fsnotify: pass dir argument to handle_event()
 callback
Message-ID: <20200703144901.GE21364@quack2.suse.cz>
References: <20200612093343.5669-1-amir73il@gmail.com>
 <20200612093343.5669-10-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612093343.5669-10-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 12-06-20 12:33:32, Amir Goldstein wrote:
> The 'inode' argument to handle_event(), sometimes referred to as
> 'to_tell' is somewhat obsolete.
> It is a remnant from the times when a group could only have an inode mark
> associated with an event.
> 
> We now pass an iter_info array to the callback, with all marks associated
> with an event.
> 
> Most backends ignore this argument, with two expections:
						^^ exceptions

> 1. dnotify uses it for sanity check that event is on directory
> 2. fanotify uses it to report fid of directory on directory entry
>    modification events
> 
> Remove the 'inode' argument and add a 'dir' argument.
> The callback function signature is deliberately changed, because
> the meaning of the argument has changed and the arguments have
> been documented.
> 
> The 'dir' argument is NULL when "sending" to a non-dir inode.
> When 'file_name' argument is non NULL, 'dir' is always referring to
> the directory that the 'file_name' entry belongs to.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Otherwise the patch looks good to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
