Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCEEA6AD4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 16:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbfICOIC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 10:08:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbfICOIC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:08:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 26B66C05AA52;
        Tue,  3 Sep 2019 14:08:02 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F2EB60C18;
        Tue,  3 Sep 2019 14:07:52 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 0D019220292; Tue,  3 Sep 2019 10:07:52 -0400 (EDT)
Date:   Tue, 3 Sep 2019 10:07:52 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 00/13] virtio-fs: shared file system for virtual
 machines
Message-ID: <20190903140752.GA10983@redhat.com>
References: <20190821173742.24574-1-vgoyal@redhat.com>
 <CAJfpegvPTxkaNhXWhiQSprSJqyW1cLXeZEz6x_f0PxCd-yzHQg@mail.gmail.com>
 <20190903041507-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903041507-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 03 Sep 2019 14:08:02 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 04:31:38AM -0400, Michael S. Tsirkin wrote:

[..]
> +	/* TODO lock */
> give me pause.
> 
> Cleanup generally seems broken to me - what pauses the FS

I am looking into device removal aspect of it now. Thinking of adding
a reference count to virtiofs device and possibly also a bit flag to
indicate if device is still alive. That way, we should be able to cleanup
device more gracefully.

> 
> What about the rest of TODOs in that file?

I will also take a closer look at TODOs now. Better device cleanup path
might get rid of some of them. Some of them might not be valid anymore.

> 
> use of usleep is hacky - can't we do better e.g. with a
> completion?

Agreed.

Thanks
Vivek
