Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CE5491E59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 04:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343504AbiARD4a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 22:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356782AbiARDyv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 22:54:51 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD38C06C112;
        Mon, 17 Jan 2022 19:03:59 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9emm-002hys-Bh; Tue, 18 Jan 2022 03:03:52 +0000
Date:   Tue, 18 Jan 2022 03:03:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ian Kent <raven@themaw.net>
Cc:     Brian Foster <bfoster@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] vfs: check dentry is still valid in get_link()
Message-ID: <YeYuGO07rVakDpS+@zeniv-ca.linux.org.uk>
References: <164180589176.86426.501271559065590169.stgit@mickey.themaw.net>
 <YeJr7/E+9stwEb3t@zeniv-ca.linux.org.uk>
 <275358741c4ee64b5e4e008d514876ed4ec1071c.camel@themaw.net>
 <YeV+zseKGNqnSuKR@bfoster>
 <YeWZRL88KPtLWlkI@zeniv-ca.linux.org.uk>
 <YeWxHPDbdSfBDtyX@zeniv-ca.linux.org.uk>
 <YeXIIf6/jChv7JN6@zeniv-ca.linux.org.uk>
 <YeYYp89adipRN64k@zeniv-ca.linux.org.uk>
 <0f6c2348dae2c47ea46a986884a75fc7d44bb6fb.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f6c2348dae2c47ea46a986884a75fc7d44bb6fb.camel@themaw.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 18, 2022 at 10:31:53AM +0800, Ian Kent wrote:

> Wouldn't that case be caught by the unlazy call since ->get_link()
> needs to return -ECHILD for the rcu case now (in xfs anyway)?

*shrug*

that'd solve the problem, all right, but it's a serious overkill in
several respects.
