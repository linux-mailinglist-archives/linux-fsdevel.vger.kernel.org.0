Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79D73D118A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 16:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238110AbhGUN74 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 09:59:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37259 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232976AbhGUN7z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 09:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626878431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pe6IL0lY4+BmYk7TYzqnbY5CUvQ+ZXsB2yM3wwA1rMA=;
        b=ELU0aiSBJH/lR0dvWu/84JthV7wm2YylNNT7BWC8rurZeqCNt/f+VQCyPL1bST+cAw1d/w
        6ZyZ1rQHmuxTnoIsCTbU+tycqPy7obb/2bTrOuAyThLWlCqoypQLSmrPsHdRzH3JqSSii5
        XTnDIbB6aMXK11FKnZjpB+TjVTm4Qxs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-nUsPwB42Mn-jARrDsSXGXw-1; Wed, 21 Jul 2021 10:40:30 -0400
X-MC-Unique: nUsPwB42Mn-jARrDsSXGXw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 386F564ADA;
        Wed, 21 Jul 2021 14:40:29 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB37A5C1BB;
        Wed, 21 Jul 2021 14:40:23 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 3514C223E70; Wed, 21 Jul 2021 10:40:23 -0400 (EDT)
Date:   Wed, 21 Jul 2021 10:40:23 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 3/4] fuse: add per-file DAX flag
Message-ID: <YPgx10F0ZMDnhGex@redhat.com>
References: <20210716104753.74377-1-jefflexu@linux.alibaba.com>
 <20210716104753.74377-4-jefflexu@linux.alibaba.com>
 <YPXWA+Uo5vFuHCH0@redhat.com>
 <61bca75f-2efa-f032-41d6-fcb525d8b528@linux.alibaba.com>
 <YPcjlN1ThL4UX8dn@redhat.com>
 <0ad3b5d2-3d19-a33b-7841-1912ea30c081@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ad3b5d2-3d19-a33b-7841-1912ea30c081@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 21, 2021 at 10:14:44PM +0800, JeffleXu wrote:
[..]
> > Also, please copy virtiofs list (virtio-fs@redhat.com) when you post
> > patches next time.
> > 
> 
> Got it. By the way, what's the git repository of virtiofsd? AFAIK,
> virtiofsd included in qemu (git@github.com:qemu/qemu.git) doesn't
> support DAX yet?

Yes virtiofsd got merged in qemu upstream. And it does not support dax
yet. David is still sorting out couple of issues based on feedback. I
think following is the branch where he had pushed his latest patches.

https://gitlab.com/virtio-fs/qemu/-/tree/virtio-fs-dev

David, please correct me if that's not the case.

Vivek

