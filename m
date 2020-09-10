Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857502653EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 23:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbgIJL4f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 07:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730520AbgIJLzF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 07:55:05 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B7FC061756
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2020 04:55:01 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGLAI-00DiX0-TX; Thu, 10 Sep 2020 11:54:58 +0000
Date:   Thu, 10 Sep 2020 12:54:58 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Sergey Nikitin <nikitins@oktetlabs.ru>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: PROBLEM: epoll_wait() does not return events when running in
 multiple threads
Message-ID: <20200910115458.GZ1236603@ZenIV.linux.org.uk>
References: <8076083c-0ae3-9cef-6238-9a651b026ade@oktetlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8076083c-0ae3-9cef-6238-9a651b026ade@oktetlabs.ru>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 10, 2020 at 12:48:34PM +0300, Sergey Nikitin wrote:
> Hi!
> 
> epoll does not report an event to all the threads running epoll_wait() on
> the same epoll descriptor.
> The behavior appeared in recent kernel versions starting with 5.6 probably.
> 
> How to reproduce:
> - create a pair of sockets
> - create epoll instance
> - register the socket on the epoll instance, listen for EPOLLIN events
> - start 2 threads running epoll_wait()
> - send some data to the socket
> - see that epoll_wait() within one of the threads reported an event, unlike
> another.

Could you reproduce it on mainline kernel and try to bisect it?
