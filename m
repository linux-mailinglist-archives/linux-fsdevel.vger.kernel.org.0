Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F353A0E04
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 09:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237151AbhFIHsn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Wed, 9 Jun 2021 03:48:43 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:39603 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235987AbhFIHsn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Jun 2021 03:48:43 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-9YzCg37yOaSVqD-GcmL0zw-1; Wed, 09 Jun 2021 03:46:45 -0400
X-MC-Unique: 9YzCg37yOaSVqD-GcmL0zw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40AAE1922961;
        Wed,  9 Jun 2021 07:46:44 +0000 (UTC)
Received: from bahia.lan (ovpn-112-166.ams2.redhat.com [10.36.112.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C4BA60853;
        Wed,  9 Jun 2021 07:46:39 +0000 (UTC)
Date:   Wed, 9 Jun 2021 09:46:38 +0200
From:   Greg Kurz <groug@kaod.org>
To:     Max Reitz <mreitz@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2 0/7] fuse: Some fixes for submounts
Message-ID: <20210609094638.197ca7fc@bahia.lan>
In-Reply-To: <c3d49438-6ee1-32b1-1be4-41be78cec2ce@redhat.com>
References: <20210604161156.408496-1-groug@kaod.org>
        <c3d49438-6ee1-32b1-1be4-41be78cec2ce@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 8 Jun 2021 17:52:13 +0200
Max Reitz <mreitz@redhat.com> wrote:

> On 04.06.21 18:11, Greg Kurz wrote:
> > v2:
> >
> > - add an extra fix (patch 2) : mount is now added to the list before
> >    unlocking sb->s_umount
> > - set SB_BORN just before unlocking sb->s_umount, just like it would
> >    happen when using fc_mount() (Max)
> > - don't allocate a FUSE context for the submounts (Max)
> > - introduce a dedicated context ops for submounts
> > - add a extra cleanup : simplify the code even more with fc_mount()
> >
> > v1:
> >
> > While working on adding syncfs() support in FUSE, I've hit some severe
> > bugs with submounts (a crash and an infinite loop). The fix for the
> > crash is straightforward (patch 1), but the fix for the infinite loop
> > is more invasive : as suggested by Miklos, a simple bug fix is applied
> > first (patch 2) and the final fix (patch 3) is applied on top.
> 
> Thanks a lot for these patches. I’ve had a style nit on patch 6, but 
> other than that, looks nice to me.
> 

Thanks a lot for the review !

Cheers,

--
Greg

> Max
> 

