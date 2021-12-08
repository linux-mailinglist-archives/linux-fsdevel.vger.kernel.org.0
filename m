Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230B346D709
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 16:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbhLHPgu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 10:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbhLHPgu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:36:50 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA0AC061746;
        Wed,  8 Dec 2021 07:33:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 93064CE1FAC;
        Wed,  8 Dec 2021 15:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229CFC341C6;
        Wed,  8 Dec 2021 15:33:12 +0000 (UTC)
Date:   Wed, 8 Dec 2021 16:33:09 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] tracefs: Use d_inode() helper function to get the dentry
 inode
Message-ID: <20211208153309.egtqqql75czhc5ms@wittgenstein>
References: <20211208103052.706253b4@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211208103052.706253b4@gandalf.local.home>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 10:30:52AM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Instead of referencing the inode from a dentry via dentry->d_inode, use
> the helper function d_inode(dentry) instead. This is the considered the
> correct way to access it.
> 
> Reported-by: Christian Brauner <christian.brauner@ubuntu.com>
> Reported: https://lore.kernel.org/all/20211208104454.nhxyvmmn6d2qhpwl@wittgenstein/
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---

It's honestly not that big of a deal but yeah, looks good! :)
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
