Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A08E4183DC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Sep 2021 20:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhIYSEa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Sep 2021 14:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhIYSE3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Sep 2021 14:04:29 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DD0C061570;
        Sat, 25 Sep 2021 11:02:54 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUC0g-007HJ0-Gg; Sat, 25 Sep 2021 18:02:50 +0000
Date:   Sat, 25 Sep 2021 18:02:50 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Rustam Kovhaev <rkovhaev@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        binutils@sourceware.org, gdb-patches@sourceware.org
Subject: Re: [RFC][PATCH] coredump: save timestamp in ELF core
Message-ID: <YU9kSgEmojalPybp@zeniv-ca.linux.org.uk>
References: <20210925171507.1081788-1-rkovhaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210925171507.1081788-1-rkovhaev@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 25, 2021 at 10:15:07AM -0700, Rustam Kovhaev wrote:
> Hello Alexander and linux-fsdevel@,
> 
> I would like to propose saving a new note with timestamp in core file.
> I do not know whether this is a good idea or not, and I would appreciate
> your feedback.
> 
> Sometimes (unfortunately) I have to review windows user-space cores in
> windbg, and there is one feature I would like to have in gdb.
> In windbg there is a .time command that prints timestamp when core was
> taken.
> 
> This might sound like a fixed problem, kernel's core_pattern can have
> %t, and there are user-space daemons that write timestamp in the
> report/journal file (apport/systemd-coredump), and sometimes it is
> possible to correctly guess timestamp from btime/mtime file attribute,
> and all of the above does indeed solve the problem most of the time.
> 
> But quite often, especially while researching hangs and not crashes,
> when dump is written by gdb/gcore, I get only core.PID file and some
> application log for research and there is no way to figure out when
> exactly the core was taken.
> 
> I have posted a RFC patch to gdb-patches too [1] and I am copying
> gdb-patches@ and binutils@ on this RFC.
> Thank you!

IDGI.  What's wrong with the usual way of finding the creation date of any
given file, including the coredump one?
