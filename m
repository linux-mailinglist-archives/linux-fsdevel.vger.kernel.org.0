Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BEF46D734
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 16:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbhLHPpY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 10:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbhLHPpY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:45:24 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE9AC061746;
        Wed,  8 Dec 2021 07:41:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D7D98CE1FAC;
        Wed,  8 Dec 2021 15:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8349FC00446;
        Wed,  8 Dec 2021 15:41:48 +0000 (UTC)
Date:   Wed, 8 Dec 2021 10:41:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] tracefs: Use d_inode() helper function to get the
 dentry inode
Message-ID: <20211208104147.1428cf22@gandalf.local.home>
In-Reply-To: <20211208153309.egtqqql75czhc5ms@wittgenstein>
References: <20211208103052.706253b4@gandalf.local.home>
        <20211208153309.egtqqql75czhc5ms@wittgenstein>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 8 Dec 2021 16:33:09 +0100
Christian Brauner <christian.brauner@ubuntu.com> wrote:

> It's honestly not that big of a deal but yeah, looks good! :)

That's why I didn't add a Fixes tag ;-)

> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Thanks!

-- Steve
