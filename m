Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21A7279A2E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Sep 2020 16:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgIZOq1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Sep 2020 10:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgIZOq1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Sep 2020 10:46:27 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511FAC0613CE
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2020 07:46:27 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMBSv-006gVF-5T; Sat, 26 Sep 2020 14:46:21 +0000
Date:   Sat, 26 Sep 2020 15:46:21 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/4] fs: simplify vfs_path_lookup
Message-ID: <20200926144621.GY3421308@ZenIV.linux.org.uk>
References: <20200926092051.115577-1-hch@lst.de>
 <20200926092051.115577-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926092051.115577-5-hch@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 26, 2020 at 11:20:51AM +0200, Christoph Hellwig wrote:
> vfs_path_lookup is only used to lookup mount points.  So drop the dentry
> parameter that is always set to mnt->mnt_root, remove the unused export
> and rename the function to mount_path_lookup.

NAK.  It's a general-purpose API and simplifications are not worth bothering
with.
