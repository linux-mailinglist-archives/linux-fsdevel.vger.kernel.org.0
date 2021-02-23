Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7116C322E75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 17:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbhBWQNF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 11:13:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:53940 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233428AbhBWQNE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 11:13:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9B6D4AEC4;
        Tue, 23 Feb 2021 16:12:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 51B3D1E14EF; Tue, 23 Feb 2021 17:12:20 +0100 (CET)
Date:   Tue, 23 Feb 2021 17:12:20 +0100
From:   Jan Kara <jack@suse.cz>
To:     linux-api@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Subject: Reporting pids to unpriviledged processes with fanotify events
Message-ID: <20210223161220.GB30433@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Amir is working on exposing part of fanotify functionality (fanotify is
filesystem notification events framework) to unpriviledged processes
(currently fanotify is restricted to CAP_SYS_ADMIN only). The initial plan
is to expose the functionality already provided by inotify and then expand
on that. Now there's one thing I was wondering about: Fanotify reports PID
of the process that caused the filesystem event (open, read, write, ...)
together with the event. Is this information safe to be exposed to
unpriviledged process as well? I'd say PID of a process doing IO is not
very sensitive information but OTOH I don't know of a way how it could be
obtained currently by an unpriviledged user so maybe it could be misused in
some way. Any opinions on that? Thanks for ideas.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
