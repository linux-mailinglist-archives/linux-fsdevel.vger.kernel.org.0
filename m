Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89D881222AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 04:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfLQDmz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 22:42:55 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37232 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfLQDmz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 22:42:55 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ih3l6-0006jg-Ri; Tue, 17 Dec 2019 03:42:52 +0000
Date:   Tue, 17 Dec 2019 03:42:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/12] vfs: don't parse "posixacl" option
Message-ID: <20191217034252.GT4203@ZenIV.linux.org.uk>
References: <20191128155940.17530-1-mszeredi@redhat.com>
 <20191128155940.17530-12-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128155940.17530-12-mszeredi@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 28, 2019 at 04:59:39PM +0100, Miklos Szeredi wrote:
> Unlike the others, this is _not_ a standard option accepted by mount(8).
> 
> In fact SB_POSIXACL is an internal flag, and accepting MS_POSIXACL on the
> mount(2) interface is possibly a bug.
> 
> The only filesystem that apparently wants to handle the "posixacl" option
> is 9p, but it has special handling of that option besides setting
> SB_POSIXACL.

Huh?  For e.g. ceph having -o posixacl and -o acl are currently equivalent;
your patch would seem to break that, wouldn't it?
