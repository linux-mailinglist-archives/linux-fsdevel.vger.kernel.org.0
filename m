Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B775F2D4C56
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 21:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbgLIU7O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 15:59:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:58626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbgLIU7L (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 15:59:11 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C311123B99;
        Wed,  9 Dec 2020 20:58:30 +0000 (UTC)
Date:   Wed, 9 Dec 2020 15:58:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: fs/namei.c: Make status likely to be ECHILD in lookup_fast()
Message-ID: <20201209155828.7109f8dd@gandalf.local.home>
In-Reply-To: <20201209203500.GQ3579531@ZenIV.linux.org.uk>
References: <20201209152403.6d6cf9ba@gandalf.local.home>
        <20201209203500.GQ3579531@ZenIV.linux.org.uk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 9 Dec 2020 20:35:00 +0000
Al Viro <viro@zeniv.linux.org.uk> wrote:

> > And most of the d_revalidate() functions have:
> > 
> > 	if (flags & LOOKUP_RCU)
> > 		return -ECHILD;  
> 
> Umm...  That depends upon the filesystem mix involved; said that, I'd rather
> drop that "unlikely"...

Sure enough. I'll send a v2.

Thanks,

-- Steve
