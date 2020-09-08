Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94679261AF4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 20:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731211AbgIHSta (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 14:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgIHStG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 14:49:06 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7024FC061573;
        Tue,  8 Sep 2020 11:49:05 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFifp-00CnK8-Ad; Tue, 08 Sep 2020 18:48:57 +0000
Date:   Tue, 8 Sep 2020 19:48:57 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Hao Lee <haolee.swjtu@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Eliminate a local variable to make the code more
 clear
Message-ID: <20200908184857.GT1236603@ZenIV.linux.org.uk>
References: <20200729151740.GA3430@haolee.github.io>
 <20200908130656.GC22780@haolee.github.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908130656.GC22780@haolee.github.io>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 08, 2020 at 01:06:56PM +0000, Hao Lee wrote:
> ping
> 
> On Wed, Jul 29, 2020 at 03:21:28PM +0000, Hao Lee wrote:
> > The dentry local variable is introduced in 'commit 84d17192d2afd ("get
> > rid of full-hash scan on detaching vfsmounts")' to reduce the length of
> > some long statements for example
> > mutex_lock(&path->dentry->d_inode->i_mutex). We have already used
> > inode_lock(dentry->d_inode) to do the same thing now, and its length is
> > acceptable. Furthermore, it seems not concise that assign path->dentry
> > to local variable dentry in the statement before goto. So, this function
> > would be more clear if we eliminate the local variable dentry.

How does it make the function more clear?  More specifically, what
analysis of behaviour is simplified by that?
