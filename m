Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6588715B15D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 20:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgBLTva (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 14:51:30 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:42906 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgBLTva (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 14:51:30 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1y2Y-00BZG4-EI; Wed, 12 Feb 2020 19:51:18 +0000
Date:   Wed, 12 Feb 2020 19:51:18 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, libc-alpha@sourceware.org,
        linux-fsdevel@vger.kernel.org, Rich Felker <dalias@libc.org>
Subject: Re: XFS reports lchmod failure, but changes file system contents
Message-ID: <20200212195118.GN23230@ZenIV.linux.org.uk>
References: <874kvwowke.fsf@mid.deneb.enyo.de>
 <20200212161604.GP6870@magnolia>
 <20200212181128.GA31394@infradead.org>
 <20200212183718.GQ6870@magnolia>
 <87d0ajmxc3.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0ajmxc3.fsf@mid.deneb.enyo.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 12, 2020 at 08:15:08PM +0100, Florian Weimer wrote:

> | Further, I've found some inconsistent behavior with ext4: chmod on the
> | magic symlink fails with EOPNOTSUPP as in Florian's test, but fchmod
> | on the O_PATH fd succeeds and changes the symlink mode. This is with
> | 5.4. Cany anyone else confirm this? Is it a problem?
> 
> It looks broken to me because fchmod (as an inode-changing operation)
> is not supposed to work on O_PATH descriptors.

Why?  O_PATH does have an associated inode just fine; where does
that "not supposed to" come from?
