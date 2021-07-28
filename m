Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35C73D85DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 04:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbhG1CVA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 22:21:00 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:40582 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbhG1CU7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 22:20:59 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8Z7N-004Wpx-W6; Wed, 28 Jul 2021 02:16:22 +0000
Date:   Wed, 28 Jul 2021 02:16:21 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     NeilBrown <neilb@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 05/11] VFS: new function: mount_is_internal()
Message-ID: <YQC99cfMkbGz3u1q@zeniv-ca.linux.org.uk>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <162742546552.32498.14429836898036234922.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162742546552.32498.14429836898036234922.stgit@noble.brown>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 28, 2021 at 08:37:45AM +1000, NeilBrown wrote:
> This patch introduces the concept of an "internal" mount which is a
> mount where a filesystem has create the mount itself.
> 
> Both the mounted-on-dentry and the mount's root dentry must refer to the
> same superblock (they may be the same dentry), and the mounted-on dentry
> must be an automount.

And what happens if you mount --move it?
