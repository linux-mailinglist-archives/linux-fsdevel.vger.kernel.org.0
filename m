Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603DB3A7C06
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 12:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhFOKgK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 06:36:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55235 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231616AbhFOKgJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 06:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623753244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J4lRhuj374UIXgRyezuo9R6wl7r9Khqqb2b2P4801fc=;
        b=VBLaxidogodkO59HbtWV3wdQIIavT60OFAE4XKJ7tYX+608bPnu7X9YUFkjvuqE11rfEsq
        XYipaLxUl0/2GiPd7MQAFubnx25nNBd/+lq9tu0uysK01zDYBmhpI+vTsPLZ1vxSFbaoy+
        dUHZzNE0uaC8hz9SPLSlKbCVwN1Fnmg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-9LFWH__QPGmKlXvjUdka0A-1; Tue, 15 Jun 2021 06:34:03 -0400
X-MC-Unique: 9LFWH__QPGmKlXvjUdka0A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26F851084F40;
        Tue, 15 Jun 2021 10:34:02 +0000 (UTC)
Received: from localhost (ovpn-114-133.ams2.redhat.com [10.36.114.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85C875D6D1;
        Tue, 15 Jun 2021 10:33:58 +0000 (UTC)
Date:   Tue, 15 Jun 2021 11:33:57 +0100
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        eblake@redhat.com, libguestfs@redhat.com,
        Shachar Sharon <synarete@gmail.com>
Subject: Re: [PATCH v4] fuse: Allow fallocate(FALLOC_FL_ZERO_RANGE)
Message-ID: <20210615103357.GP26415@redhat.com>
References: <20210512161848.3513818-1-rjones@redhat.com>
 <20210512161848.3513818-2-rjones@redhat.com>
 <CAJfpegv=C-tUwbAi+JMWrNb+pai=HiAU8YCDunE5yUZB7qMK1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegv=C-tUwbAi+JMWrNb+pai=HiAU8YCDunE5yUZB7qMK1g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 18, 2021 at 03:56:25PM +0200, Miklos Szeredi wrote:
> On Wed, 12 May 2021 at 18:19, Richard W.M. Jones <rjones@redhat.com> wrote:
> >
> > The current fuse module filters out fallocate(FALLOC_FL_ZERO_RANGE)
> > returning -EOPNOTSUPP.  libnbd's nbdfuse would like to translate
> > FALLOC_FL_ZERO_RANGE requests into the NBD command
> > NBD_CMD_WRITE_ZEROES which allows NBD servers that support it to do
> > zeroing efficiently.
> >
> > This commit treats this flag exactly like FALLOC_FL_PUNCH_HOLE.
> 
> Thanks, applied.

Hi Miklos, did this patch get forgotten?

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top

