Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7901C7E56
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 02:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgEGAKd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 20:10:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbgEGAKc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 20:10:32 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A13620736;
        Thu,  7 May 2020 00:10:32 +0000 (UTC)
Date:   Wed, 6 May 2020 20:10:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 7/7] tracefs: switch to simplefs inode creation API
Message-ID: <20200506201029.77bde27a@gandalf.local.home>
In-Reply-To: <20200504090032.10367-8-eesposit@redhat.com>
References: <20200504090032.10367-1-eesposit@redhat.com>
        <20200504090032.10367-8-eesposit@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon,  4 May 2020 11:00:32 +0200
Emanuele Giuseppe Esposito <eesposit@redhat.com> wrote:

> Remove tracefs_get_inode(), since it will be substituted
> by new_inode_current_time() in the simplefs_create_dentry call.
> 
> There is no semantic change intended; the code in the libfs.c
> functions in fact was derived from debugfs and tracefs code.
> 
> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
> ---
>  fs/tracefs/inode.c | 96 ++++------------------------------------------
>  1 file changed, 7 insertions(+), 89 deletions(-)
> 
>

I ran this series through some of my tests, and it appears to cause no harm.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
