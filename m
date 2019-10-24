Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDE48E33B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 15:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502462AbfJXNPA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 09:15:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45050 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502438AbfJXNPA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Jr+KH6TpggeektbjDpZIF11RXPqlwCVR55VLMJFPOz8=; b=j7YKjbvjp/ypi4i4koJ318A42
        d4C0/CCa01kd9EjOIu9zw0/atJE16DTEyTp45ZSWBNSWlc0g+z2PyF+/6pzkSAY3WRUdm70WN7mSz
        6me42ElrJoWnV27r1xOSBoHPRQg+jeTOQnmVigwvcGJFgO6JkCrEqEFayteNfRbb5OLE4e8yx1BIg
        bzrmoJ/4AaVJi0vB5CE5jYkuBHOj+j1m41vxDZc0BS7HPtIdD6fVgsSUy5igabNFG7bt7Pt1bEJ4A
        gbX86oq8hvlyHJy0RibiCU0XNgLI3amTKX1KHXyIj1x9ony+LGASM8qFYMOp7tGg+6mAV8XNOaTik
        deajIeL1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNcx6-0005MS-Mb; Thu, 24 Oct 2019 13:14:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A53C3300489;
        Thu, 24 Oct 2019 15:13:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0CF8B2B1C8A31; Thu, 24 Oct 2019 15:14:54 +0200 (CEST)
Date:   Thu, 24 Oct 2019 15:14:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/10] pipe: Notification queue preparation [ver #2]
Message-ID: <20191024131454.GB4114@hirez.programming.kicks-ass.net>
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 23, 2019 at 09:17:04PM +0100, David Howells wrote:

>  (1) It removes the nr_exclusive argument from __wake_up_sync_key() as this
>      is always 1.  This prepares for step 2.
> 
>  (2) Adds wake_up_interruptible_sync_poll_locked() so that poll can be
>      woken up from a function that's holding the poll waitqueue spinlock.

>  include/linux/wait.h       |   11 +-
>  kernel/sched/wait.c        |   37 ++++--
> 

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
