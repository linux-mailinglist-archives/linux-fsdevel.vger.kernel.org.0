Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2371A733
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2019 10:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfEKIkr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 May 2019 04:40:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45860 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbfEKIkr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 May 2019 04:40:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 376BD86676;
        Sat, 11 May 2019 08:40:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 388585D705;
        Sat, 11 May 2019 08:40:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190509155801.8369-2-christian@brauner.io>
References: <20190509155801.8369-2-christian@brauner.io> <20190509155801.8369-1-christian@brauner.io>
To:     Christian Brauner <christian@brauner.io>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] fsopen: use square brackets around "fscontext"
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9346.1557564045.1@warthog.procyon.org.uk>
Date:   Sat, 11 May 2019 09:40:45 +0100
Message-ID: <9347.1557564045@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Sat, 11 May 2019 08:40:47 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <christian@brauner.io> wrote:

> Make the name of the anon inode fd "[fscontext]" instead of "fscontext".
> This is minor but most core-kernel anon inode fds already carry square
> brackets around their name:
> 
> [eventfd]
> [eventpoll]
> [fanotify]
> [io_uring]
> [pidfd]
> [signalfd]
> [timerfd]
> [userfaultfd]
> 
> For the sake of consistency lets do the same for the fscontext anon inode
> fd that comes with the new mount api.
> 
> Signed-off-by: Christian Brauner <christian@brauner.io>

Reviewed-by: David Howells <dhowells@redhat.com>
