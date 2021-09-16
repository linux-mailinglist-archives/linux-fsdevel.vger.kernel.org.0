Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889AD40D5DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 11:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbhIPJQb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 05:16:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236388AbhIPJQE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:16:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD47560F93;
        Thu, 16 Sep 2021 09:14:42 +0000 (UTC)
Date:   Thu, 16 Sep 2021 11:14:40 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     viro@zeniv.linux.org.uk,
        Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, xu.xin16@zte.com.cn,
        Christoph Hellwig <hch@infradead.org>, zhang.yunkai@zte.com.cn
Subject: Re: [PATCH] init/do_mounts.c: Harden split_fs_names() against buffer
 overflow
Message-ID: <20210916091440.zk2qvdmldo6wkryi@wittgenstein>
References: <YUIPnPV2ttOHNIcX@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUIPnPV2ttOHNIcX@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 15, 2021 at 11:22:04AM -0400, Vivek Goyal wrote:
> split_fs_names() currently takes comma separated list of filesystems
> and converts it into individual filesystem strings. Pleaces these
> strings in the input buffer passed by caller and returns number of
> strings.
> 
> If caller manages to pass input string bigger than buffer, then we
> can write beyond the buffer. Or if string just fits buffer, we will
> still write beyond the buffer as we append a '\0' byte at the end.
> 
> Will be nice to pass size of input buffer to split_fs_names() and
> put enough checks in place so such buffer overrun possibilities
> do not occur.
> 
> Hence this patch adds "size" parameter to split_fs_names() and makes
> sure we do not access memory beyond size. If input string "names"
> is larger than passed in buffer, input string will be truncated to
> fit in buffer.
> 
> Reported-by: xu xin <xu.xin16@zte.com.cn>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---

Strange but probably reasonable,
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
