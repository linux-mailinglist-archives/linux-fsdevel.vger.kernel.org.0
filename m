Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1EB428F86B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 20:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgJOSXh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 14:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgJOSXg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 14:23:36 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92014C061755
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2020 11:23:36 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kT7uY-001463-5d; Thu, 15 Oct 2020 18:23:34 +0000
Date:   Thu, 15 Oct 2020 19:23:34 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/13] Clean up kernel_read/kernel_write
Message-ID: <20201015182334.GQ3576660@ZenIV.linux.org.uk>
References: <20201003025534.21045-1-willy@infradead.org>
 <20201015175641.GC23287@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015175641.GC23287@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 15, 2020 at 07:56:41PM +0200, Christoph Hellwig wrote:
> Al,
> 
> can you pick up patches 1 and 2 to unbreak linux-next?

OK... I really don't like the idea of mangling base.set_fs, so
a bit of bisect hazard will be there - I'd put these two into
a branch on top of base.set_fs (#work.set_fs).  Regenerated
with addition of your reviewed-by, added to #for-next and pushed
out.
