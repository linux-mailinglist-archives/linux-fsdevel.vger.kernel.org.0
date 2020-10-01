Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B9328005B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 15:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732229AbgJANnS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 09:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732178AbgJANnS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 09:43:18 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D7FC0613D0;
        Thu,  1 Oct 2020 06:43:18 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNyrd-009rLc-2e; Thu, 01 Oct 2020 13:43:17 +0000
Date:   Thu, 1 Oct 2020 14:43:17 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Qian Cai <cai@redhat.com>
Cc:     David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pipe: Fix memory leaks in create_pipe_files()
Message-ID: <20201001134317.GF3421308@ZenIV.linux.org.uk>
References: <20201001125055.5042-1-cai@redhat.com>
 <20201001131659.GE3421308@ZenIV.linux.org.uk>
 <68ab61d0ba3a6ddd7838bc293c9e24f5d8002e27.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68ab61d0ba3a6ddd7838bc293c9e24f5d8002e27.camel@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 01, 2020 at 09:37:02AM -0400, Qian Cai wrote:

> > 	Fixed by providing a dummy wath_queue_init() in !CONFIG_WATCH_QUEUE
				   watch_queue_init(), that is
> > case and by having failures of wath_queue_init() handled the same way
				   ditto
> > we handle alloc_file_pseudo() ones.
> > 
> > Fixes: c73be61cede5 ("pipe: Add general notification queue support")
> > Signed-off-by: Qian Cai <cai@redhat.com>
> > =======================
> 
> Thanks Al. This looks very good to me.

Applied with that commit message (and typos above corrected) to #fixes
and pushed
