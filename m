Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731F62648EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 17:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731295AbgIJPiY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 11:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731372AbgIJPhg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:37:36 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA99C061367;
        Thu, 10 Sep 2020 08:18:31 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGOLE-00Dnc6-N4; Thu, 10 Sep 2020 15:18:28 +0000
Date:   Thu, 10 Sep 2020 16:18:28 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Rich Felker <dalias@libc.org>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: add fchmodat2 syscall
Message-ID: <20200910151828.GD1236603@ZenIV.linux.org.uk>
References: <20200910142335.GG3265@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910142335.GG3265@brightrain.aerifal.cx>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 10, 2020 at 10:23:37AM -0400, Rich Felker wrote:

> It was determined (see glibc issue #14578 and commit a492b1e5ef) that,
> on some filesystems, performing chmod on the link itself produces a
> change in the inode's access mode, but returns an EOPNOTSUPP error.

Which filesystem types are those?
