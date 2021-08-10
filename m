Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13A73E5C9A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 16:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241898AbhHJOL6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 10:11:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240651AbhHJOL5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 10:11:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C8FB60EC0;
        Tue, 10 Aug 2021 14:11:31 +0000 (UTC)
Date:   Tue, 10 Aug 2021 16:11:25 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: Questions re the new mount_setattr(2) manual page
Message-ID: <20210810141125.nxmvnwpyjxajvxl4@wittgenstein>
References: <b58e2537-03f4-6f6c-4e1b-8ddd989624cc@gmail.com>
 <b23122c0-893a-c1b4-0b2d-3a332af4151f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b23122c0-893a-c1b4-0b2d-3a332af4151f@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 10, 2021 at 09:12:14AM +0200, Michael Kerrisk (man-pages) wrote:
> Hi Christian,
> 
> One more question...
> 
> >>       The propagation field is used to specify the propagation typ
> >>       of the mount or mount tree.  Mount propagation options are
> >>       mutually exclusive; that is, the propagation values behave
> >>       like an enum.  The supported mount propagation types are:
> 
> The manual page text doesn't actually say it, but if the 'propagation'
> field is 0, then this means leave the propagation type unchanged, 
> right? This of course should be mentioned in the manual page.

Yes, if none of the documented values is set the propagation is unchanged.

Christian
