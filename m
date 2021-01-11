Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003BD2F1D1F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 18:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390015AbhAKRut (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 12:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389923AbhAKRut (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:50:49 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE5FC061794;
        Mon, 11 Jan 2021 09:50:08 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kz1KN-009KiU-Fr; Mon, 11 Jan 2021 17:50:03 +0000
Date:   Mon, 11 Jan 2021 17:50:03 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH] iov_iter: fix the uaccess area in
 copy_compat_iovec_from_user
Message-ID: <20210111175003.GA3579531@ZenIV.linux.org.uk>
References: <20210111171926.1528615-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111171926.1528615-1-hch@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 11, 2021 at 06:19:26PM +0100, Christoph Hellwig wrote:
> sizeof needs to be called on the compat pointer, not the native one.
> 
> Fixes: 89cd35c58bc2 ("iov_iter: transparently handle compat iovecs in import_iovec")
> Reported-by: David Laight <David.Laight@ACULAB.COM>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied.
