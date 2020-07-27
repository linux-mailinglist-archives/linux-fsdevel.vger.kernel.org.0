Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1679C22F7DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 20:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730574AbgG0Sih (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 14:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730376AbgG0Sig (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 14:38:36 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD02C061794
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2020 11:38:36 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k081D-003p01-Ex; Mon, 27 Jul 2020 18:38:35 +0000
Date:   Mon, 27 Jul 2020 19:38:35 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: define inode flags using bit numbers
Message-ID: <20200727183835.GJ794331@ZenIV.linux.org.uk>
References: <20200713030952.192348-1-ebiggers@kernel.org>
 <20200727164809.GG1138@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727164809.GG1138@sol.localdomain>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 27, 2020 at 09:48:09AM -0700, Eric Biggers wrote:
> On Sun, Jul 12, 2020 at 08:09:52PM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Define the VFS inode flags using bit numbers instead of hardcoding
> > powers of 2, which has become unwieldy now that we're up to 65536.
> > 
> > No change in the actual values.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Al, any interest in taking this patch?

*shrug*

I don't see much point in that, but... might as well.  Applied.
