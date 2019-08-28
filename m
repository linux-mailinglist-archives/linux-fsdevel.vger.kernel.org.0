Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6ED0A019A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 14:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfH1M1z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 08:27:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbfH1M1z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 08:27:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 773003082D9E;
        Wed, 28 Aug 2019 12:27:55 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D55E05D9C9;
        Wed, 28 Aug 2019 12:27:49 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 307372206F5; Wed, 28 Aug 2019 08:27:49 -0400 (EDT)
Date:   Wed, 28 Aug 2019 08:27:49 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [PATCH 02/13] fuse: Use default_file_splice_read for direct IO
Message-ID: <20190828122749.GA912@redhat.com>
References: <20190821173742.24574-1-vgoyal@redhat.com>
 <20190821173742.24574-3-vgoyal@redhat.com>
 <CAJfpegu41FYEBfniEBPtujgLW4nC+w6_6VG2EmNi=kC8ZeNFtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegu41FYEBfniEBPtujgLW4nC+w6_6VG2EmNi=kC8ZeNFtA@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 28 Aug 2019 12:27:55 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 28, 2019 at 09:45:28AM +0200, Miklos Szeredi wrote:
> On Wed, Aug 21, 2019 at 7:38 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > From: Miklos Szeredi <mszeredi@redhat.com>
> 
> Nice patch, except I have no idea why I did this.  Splice with
> FOPEN_DIRECT_IO  seems to work fine without it.

I don't know either. I took it because it was there in one of the branches
you were doing development on.

> 
> Anyway, I'll just drop this, unless someone has an idea why it is
> actually needed.

Sure, drop this patch. If need be, we can dig it up later.

Thanks
Vivek
