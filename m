Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06791127CF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 08:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfECGeg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 02:34:36 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:49428 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfECGef (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 02:34:35 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 74E411F453;
        Fri,  3 May 2019 06:34:35 +0000 (UTC)
Date:   Fri, 3 May 2019 06:34:35 +0000
From:   Eric Wong <e@80x24.org>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        omar.kilani@gmail.com, jbaron@akamai.com, arnd@arndb.de,
        linux-fsdevel@vger.kernel.org, dave@stgolabs.net
Subject: Re: [PATCH] signal: Adjust error codes according to
 restore_user_sigmask()
Message-ID: <20190503063435.446aqcckbc6ri7xx@dcvr>
References: <20190503033440.cow6xm4p4hezgkxv@linux-r8p5>
 <20190503034205.12121-1-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190503034205.12121-1-deepa.kernel@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> Sorry, I was trying a new setup at work. I should have tested it.
> My bad, I've checked this one.

Thanks.  This is good w.r.t. epoll_pwait and ppoll when applied
to 5.0.11 (no fs/io_uring.c).

Can't think of anything which uses pselect or aio on my system;
but it looks right to me.

> I've removed the questionable reported-by, since we're not sure if
> it is actually the same issue.

Yes, I hope Omar can test this, too.

Thanks again, all!
