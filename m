Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1E3E18F3F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 12:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgCWL57 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 07:57:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:39628 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728174AbgCWL57 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 07:57:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4CEB3AE70;
        Mon, 23 Mar 2020 11:57:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E91E91E10DA; Mon, 23 Mar 2020 12:57:56 +0100 (CET)
Date:   Mon, 23 Mar 2020 12:57:56 +0100
From:   Jan Kara <jack@suse.cz>
To:     Nilesh Awate <Nilesh.Awate@microsoft.com>
Cc:     "jack@suse.cz" <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: Fanotify Ignore mask
Message-ID: <20200323115756.GA28951@quack2.suse.cz>
References: <TY2P153MB0224EE022C428AA2506AD1879CF30@TY2P153MB0224.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY2P153MB0224EE022C428AA2506AD1879CF30@TY2P153MB0224.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hello Nilesh!

On Sun 22-03-20 17:50:50, Nilesh Awate wrote:
> I'm new to Fanotify. I'm approaching you because I see that you have done great work in Fanotify subsystem.
> 
> I've a trivial query. How can we ignore events from a directory, If we have mark "/" as mount.
> 
> fd = fanotify_init(FAN_CLOEXEC | FAN_CLASS_CONTENT | FAN_NONBLOCK,
>                        O_RDONLY | O_LARGEFILE);
> 
> ret = fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT,  FAN_OPEN_PERM | FAN_CLOSE_WRITE,
>                                    AT_FDCWD, "/") ;
> 
> Now I don't want events from "/opt" directory is it possible to ignore all events from /opt directory.
> 
> I see examples from https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/fanotify/fanotify01.c
> But they all taking about a file. Could you pls help me here.

There's no way how you could 'ignore' events in the whole directory, let
alone even the whole subtree under a directory which you seem to imply.
Ignore mask really only work for avoiding generating events from individual
files. Any more sophisticated filtering needs to happen in userspace after
getting the events from the kernel.

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
