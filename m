Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1361BCBFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 21:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgD1TBc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 15:01:32 -0400
Received: from ms.lwn.net ([45.79.88.28]:41500 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728564AbgD1TBb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:01:31 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9121944A;
        Tue, 28 Apr 2020 19:01:29 +0000 (UTC)
Date:   Tue, 28 Apr 2020 13:01:28 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
        codalist@coda.cs.cmu.edu, linux-fsdevel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-xfs@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 00/29] Convert files to ReST - part 2
Message-ID: <20200428130128.22c4b973@lwn.net>
In-Reply-To: <cover.1588021877.git.mchehab+huawei@kernel.org>
References: <cover.1588021877.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 27 Apr 2020 23:16:52 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> This is the second part of a series I wrote sometime ago where I manually
> convert lots of files to be properly parsed by Sphinx as ReST files.
> 
> As it touches on lot of stuff, this series is based on today's linux-next, 
> at tag next-20190617.
> 
> The first version of this series had 57 patches. The first part with 28 patches
> were already merged. Right now, there are still ~76  patches pending applying
> (including this series), and that's because I opted to do ~1 patch per converted
>  directory.
> 
> That sounds too much to be send on a single round. So, I'm opting to split
> it on 3 parts for the conversion, plus a final patch adding orphaned books
> to existing ones. 
> 
> Those patches should probably be good to be merged either by subsystem
> maintainers or via the docs tree.

So I'm happy to merge this set, but there is one thing that worries me a
bit... 

>  fs/cachefiles/Kconfig                         |    4 +-
>  fs/coda/Kconfig                               |    2 +-
>  fs/configfs/inode.c                           |    2 +-
>  fs/configfs/item.c                            |    2 +-
>  fs/fscache/Kconfig                            |    8 +-
>  fs/fscache/cache.c                            |    8 +-
>  fs/fscache/cookie.c                           |    2 +-
>  fs/fscache/object.c                           |    4 +-
>  fs/fscache/operation.c                        |    2 +-
>  fs/locks.c                                    |    2 +-
>  include/linux/configfs.h                      |    2 +-
>  include/linux/fs_context.h                    |    2 +-
>  include/linux/fscache-cache.h                 |    4 +-
>  include/linux/fscache.h                       |   42 +-
>  include/linux/lsm_hooks.h                     |    2 +-

I'd feel a bit better if I could get an ack or two from filesystem folks
before I venture that far out of my own yard...what say you all?

Thanks,

jon
