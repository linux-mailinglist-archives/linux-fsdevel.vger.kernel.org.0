Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D0843D2F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 22:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243960AbhJ0Ujq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 16:39:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51647 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243944AbhJ0Ujp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 16:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635367038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HMeHxvkrIXoskqvvjCVbvSOKzxFlMmMPMGH4IRICiLE=;
        b=AuHlPCRNfMYaJg0DhQnQStSfr6QSFxwOcBV4LlcVgZsg/iHqYQTOPEtjpuIIE81Zs6tZeH
        ZB/Ra75U7Igob1gZzhgaP3p5/bfFVlsB6N1OvnW4IeydjwU6KIKUJIddQ28gF9ptX4E6Io
        yLeriqQQ+EoV9FrRZFlj1n/Wwdx03Gc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-EP9f_yuHMIqt26ILqORw-A-1; Wed, 27 Oct 2021 16:37:14 -0400
X-MC-Unique: EP9f_yuHMIqt26ILqORw-A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86A371014BEC;
        Wed, 27 Oct 2021 20:37:13 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.34.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6423860BF1;
        Wed, 27 Oct 2021 20:37:13 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id E9BC4220562; Wed, 27 Oct 2021 16:37:12 -0400 (EDT)
Date:   Wed, 27 Oct 2021 16:37:12 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Ioannis Angelakopoulos <iangelak@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>
Subject: Re: [RFC PATCH 0/7] Inotify support in FUSE and virtiofs
Message-ID: <YXm4eNztvEyGGp4L@redhat.com>
References: <20211025204634.2517-1-iangelak@redhat.com>
 <CAOQ4uxieK3KpY7pf0YTKcrNHW7rnTATTDZdK9L4Mqy32cDwV8w@mail.gmail.com>
 <YXgqRb21hvYyI69D@redhat.com>
 <CAOQ4uxhpCKK2MYxSmRJYYMEWaHKy5ezyKgxaM+YAKtpjsZkD-g@mail.gmail.com>
 <YXhIm3mOvPsueWab@redhat.com>
 <CAO17o20sdKAWQN6w7Oe0Ze06qcK+J=6rrmA_aWGnY__MRVDCKw@mail.gmail.com>
 <CAOQ4uxhA+f-GZs-6SwNtSYZvSwfsYz4_=8_tWAUqt9s-49bqLw@mail.gmail.com>
 <20211027132319.GA7873@quack2.suse.cz>
 <YXm2tAMYwFFVR8g/@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXm2tAMYwFFVR8g/@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 27, 2021 at 04:29:41PM -0400, Vivek Goyal wrote:
> On Wed, Oct 27, 2021 at 03:23:19PM +0200, Jan Kara wrote:
> > On Wed 27-10-21 08:59:15, Amir Goldstein wrote:
> > > On Tue, Oct 26, 2021 at 10:14 PM Ioannis Angelakopoulos
> > > <iangelak@redhat.com> wrote:
> > > > On Tue, Oct 26, 2021 at 2:27 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > The problem here is that the OPEN event might still be travelling towards the guest in the
> > > > virtqueues and arrives after the guest has already deleted its local inode.
> > > > While the remote event (OPEN) received by the guest is valid, its fsnotify
> > > > subsystem will drop it since the local inode is not there.
> > > >
> > > 
> > > I have a feeling that we are mixing issues related to shared server
> > > and remote fsnotify.
> > 
> > I don't think Ioannis was speaking about shared server case here. I think
> > he says that in a simple FUSE remote notification setup we can loose OPEN
> > events (or basically any other) if the inode for which the event happens
> > gets deleted sufficiently early after the event being generated. That seems
> > indeed somewhat unexpected and could be confusing if it happens e.g. for
> > some directory operations.
> 
> Hi Jan,
> 
> Agreed. That's what Ioannis is trying to say. That some of the remote events
> can be lost if fuse/guest local inode is unlinked. I think problem exists
> both for shared and non-shared directory case.

Thinking more about it, one will need remote fsnotify support only if
this is a case of shared direcotry. If there are no clients doing parallel
operations in shared dir (like dropping some new files), then local
inotify should be good enough. And I think Ioannis mentioned that local
inotify already work with fuse.

For example, kata container developers wanted to use inotify on virtiofs,
because a process on host (kubernetes?) will update some sort of config
file in shared directory. They wanted to monitor that config in guest,
get an inotify event and then act on updated config file. That's the
case of shared dir.

Given we do not support inotify yet, I think they went ahead with some
sort of polling mechanism to take care of there use case.

Thanks
Vivek

