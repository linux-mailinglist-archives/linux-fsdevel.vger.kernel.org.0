Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D1B3C69CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 07:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhGMFnA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 01:43:00 -0400
Received: from verein.lst.de ([213.95.11.211]:57321 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229782AbhGMFnA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 01:43:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 967F767373; Tue, 13 Jul 2021 07:40:08 +0200 (CEST)
Date:   Tue, 13 Jul 2021 07:40:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Stefan Hajnoczi <stefanha@redhat.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [Virtio-fs] [PATCH 3/2] fs: simplify get_filesystem_list /
 get_all_fs_names
Message-ID: <20210713054008.GA5825@lst.de>
References: <20210621062657.3641879-1-hch@lst.de> <20210622081217.GA2975@lst.de> <YNGhERcnLuzjn8j9@stefanha-x1.localdomain> <20210629205048.GE5231@redhat.com> <20210630053601.GA29241@lst.de> <20210707210404.GB244500@redhat.com> <20210707210636.GC244500@redhat.com> <20210708125936.GA319010@redhat.com> <20210712182130.GC502004@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712182130.GC502004@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 12, 2021 at 02:21:30PM -0400, Vivek Goyal wrote:
> In case you are finding it hard to spend some time on these patches, I 
> can take those patches, merge my changes and repost them.

Yes, please do.  Thanks a lot!
