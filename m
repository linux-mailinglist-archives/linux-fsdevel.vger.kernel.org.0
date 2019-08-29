Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F121A196D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 13:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfH2L61 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 07:58:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbfH2L61 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:58:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4ED03308FC4A;
        Thu, 29 Aug 2019 11:58:27 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0EA1160872;
        Thu, 29 Aug 2019 11:58:23 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 966A12206F5; Thu, 29 Aug 2019 07:58:22 -0400 (EDT)
Date:   Thu, 29 Aug 2019 07:58:22 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 00/13] virtio-fs: shared file system for virtual
 machines
Message-ID: <20190829115822.GA10416@redhat.com>
References: <20190821173742.24574-1-vgoyal@redhat.com>
 <CAJfpegv_XS=kLxw_FzWNM2Xao5wsn7oGbk3ow78gU8tpXwo-sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegv_XS=kLxw_FzWNM2Xao5wsn7oGbk3ow78gU8tpXwo-sg@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 29 Aug 2019 11:58:27 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 29, 2019 at 11:28:27AM +0200, Miklos Szeredi wrote:
> On Wed, Aug 21, 2019 at 7:38 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > Hi,
> >
> > Here are the V3 patches for virtio-fs filesystem. This time I have
> > broken the patch series in two parts. This is first part which does
> > not contain DAX support. Second patch series will contain the patches
> > for DAX support.
> >
> > I have also dropped RFC tag from first patch series as we believe its
> > in good enough shape that it should get a consideration for inclusion
> > upstream.
> 
> Pushed out to
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#for-next
> 

Awesome.

> Major changes compared to patchset:
> 
>  - renamed to "virtiofs".  Filesystem names don't usually have
> underscore before "fs" postfix.
> 

Sound good to me.

>  - removed option parsing completely.  Virtiofs config is fixed to "-o
> rootmode=040000,user_id=0,group_id=0,allow_other,default_permissions".
> Does this sound reasonable?

These are the options we are using now and looks like they make lot of
sense for virtiofs. I guess if somebody needs a different configuration
later we can introduce option parsing and override these defaults.

> 
> There are miscellaneous changes, so needs to be thoroughly tested.

I will test these.

> 
> I think we also need something in
> "Documentation/filesystems/virtiofs.rst" which describes the design
> (how  request gets to userspace and back) and how to set up the
> server, etc...  Stefan, Vivek can you do something like that?

Sure, I will write up something and take Stefan's input as well.

Thanks
Vivek
