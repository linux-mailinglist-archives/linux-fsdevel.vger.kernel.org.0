Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5437EB5565
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 20:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfIQSek (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 14:34:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48048 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbfIQSek (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 14:34:40 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1BD7B369AC;
        Tue, 17 Sep 2019 18:34:40 +0000 (UTC)
Received: from work-vm (ovpn-116-53.ams2.redhat.com [10.36.116.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C1FD19C6A;
        Tue, 17 Sep 2019 18:34:28 +0000 (UTC)
Date:   Tue, 17 Sep 2019 19:34:25 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        David Howells <dhowells@redhat.com>, virtio-fs@redhat.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [Virtio-fs] [PATCH] init/do_mounts.c: add virtiofs root fs
 support
Message-ID: <20190917183425.GJ3370@work-vm>
References: <20190906100324.8492-1-stefanha@redhat.com>
 <CAFLxGvw-n2VYcYR9kei7Hu2RBhCG9PeWuW7Z+SaiyDQVBRiugw@mail.gmail.com>
 <20190909070039.GB13708@stefanha-x1.localdomain>
 <CAFLxGvw51qeifCLwhV-8DKXNwC9=_5hFf==e7h4YCvFE5_Wz0A@mail.gmail.com>
 <20190917183029.GH1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917183029.GH1131@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 17 Sep 2019 18:34:40 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Al Viro (viro@zeniv.linux.org.uk) wrote:
> On Tue, Sep 17, 2019 at 08:19:55PM +0200, Richard Weinberger wrote:
> 
> > mtd, ubi, virtiofs and 9p have one thing in common, they are not block devices.
> > What about a new miscroot= kernel parameter?
> 
> How about something like xfs!sda5 or nfs!foo.local.net/bar, etc.?  With
> ubi et.al. covered by the same syntax...

Would Stefan's patch work if there was just a way to test for non-block
based fileystsmes and we replaced
   !strcmp(root_fs_names, "virtiofs") by
   not_block_based_fs(root_fs_names)

Or is there some magic that the other filesystems do that's specific?

Dave

> _______________________________________________
> Virtio-fs mailing list
> Virtio-fs@redhat.com
> https://www.redhat.com/mailman/listinfo/virtio-fs
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
