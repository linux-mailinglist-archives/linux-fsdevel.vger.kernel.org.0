Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C79B348B94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 09:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhCYIan (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 04:30:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229904AbhCYIaU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 04:30:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D53A161A16;
        Thu, 25 Mar 2021 08:30:18 +0000 (UTC)
Date:   Thu, 25 Mar 2021 09:30:16 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: split receive_fd_replace from __receive_fd
Message-ID: <20210325083016.nwn2dbtuyearrxfd@wittgenstein>
References: <20210325082209.1067987-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210325082209.1067987-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 25, 2021 at 09:22:08AM +0100, Christoph Hellwig wrote:
> The receive_fd_replace case shares almost no logic with the more general
> __receive_fd case, so split it into a separate function.
> 
> BTW, I'm not sure if receive_fd_replace is such a useful primitive to
> start with, why not just open code it in seccomp?

I tend to agree and argued in a similar fashion back when we added this
but we ultimately decided to add it. So now we're back to the original
argument. :)

Christian
