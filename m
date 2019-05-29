Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3C0A2E0A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 17:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfE2PKz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 11:10:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbfE2PKz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 11:10:55 -0400
Received: from localhost (unknown [207.225.69.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BD4C23B8C;
        Wed, 29 May 2019 15:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559142654;
        bh=Mr53O7RleTzao/dC3tr4uYgD841gD6k8Bfp9NeUAZNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cyZDYlLhz99DlaSRHVOISk3X1d11X1h9Fiz3jTrszIeyByTGLo2bl0E7oNhgidbW/
         VJ8N+GNkh9ZZy3qTa+Vmy92q5T2mmnFSfExvTgnpUfERO9Qe7mgd5l1GOtalC9z9xE
         RTTffwT/PNMfhmHHx+8OlwnVhmiphlqO2+oGPpvk=
Date:   Wed, 29 May 2019 08:10:53 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 0/7] Mount, FS, Block and Keyrings notifications
Message-ID: <20190529151053.GA10231@kroah.com>
References: <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
 <CAOQ4uxjC1M7jwjd9zSaSa6UW2dbEjc+ZbFSo7j9F1YHAQxQ8LQ@mail.gmail.com>
 <20190529142504.GC32147@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529142504.GC32147@quack2.suse.cz>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 29, 2019 at 04:25:04PM +0200, Jan Kara wrote:
> > I am not asking that you implement fs_notify() before merging sb_notify()
> > and I understand that you have a use case for sb_notify().
> > I am asking that you show me the path towards a unified API (how a
> > typical program would look like), so that we know before merging your
> > new API that it could be extended to accommodate fsnotify events
> > where the final result will look wholesome to users.
> 
> Are you sure we want to combine notification about file changes etc. with
> administrator-type notifications about the filesystem? To me these two
> sound like rather different (although sometimes related) things.

This patchset is looking to create a "generic" kernel notification
system, so I think the question is valid.  It's up to the requestor to
ask for the specific type of notification.

thanks,

greg k-h
