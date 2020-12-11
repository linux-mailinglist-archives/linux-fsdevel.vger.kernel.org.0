Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303922D7653
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 14:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436710AbgLKNNP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 08:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbgLKNM5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 08:12:57 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57261C0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 05:12:17 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id r17so8706785ilo.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 05:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rxg5yo477fl+0qyR5p5ttifVIuMQx6gpRGaaflRynW0=;
        b=n6Nq+O81/rLMy+o07oWWZYzBuY6/L/S3H/veWtKCSdi/P8/ykNNSoUlAIS9P9an3lS
         301/46nGP9LewIBWBC04dd8wFGCAl+VmOjLrXiM4RwL77W/3Abtxe09fEs+0rHFvMaSB
         G/+gF8P6pwWgn8xVDYlLGI3nLUaw0Ba0kYVO2dm9oxqW8UrlnZ3oEJnVpJiF97bl/tcg
         eKyrFS/oygtPcOSlKqVDjTfHiRKC0JPfYMImfQvestIOCI/TGnPkCkLSdTjHHFR+xXPw
         5nkQpAkWL6BjR3wV3JzwWF00OXrFq8UDJ2u8vBmIpMxKMe0sxnkcgW9HYNY+85olLFdK
         eYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rxg5yo477fl+0qyR5p5ttifVIuMQx6gpRGaaflRynW0=;
        b=luhPxSxEdsVxNPwfxK6CikfGmKiYgA59P/zwFFcpib19OjXxuacqpV4VFxaIyzO3qR
         ZSX3ZB7VmvT9VRyIY2L8x2IVkp49dKWgpdgmkFiChXkJqGR7ZXqZT3YhlYLoVu5yJAsd
         qDwLTxL5I86PofmZ2QD4iyduoFN+oWLs7UoVtNcNg6yGRpCu3SZAzB1W783mztu2PYP0
         zDSfk8IMVC0zFNubO0N8SGq38rdAld4U44fUcgzxjkCbDWZ/mkcDO01Q+82+DxLxyMMf
         LdpKaggsGJoRXod8lNwmPHBvAFr7bS1fsZHn8pnySQE+ytqiXt8ZdxAStDw8AsChyqbG
         oQkQ==
X-Gm-Message-State: AOAM531jHX07YYgxP4PJ5B9JOOar8pWvDra17neYjbqpMAJ5Yp5m/Gyq
        U9vGypuyz+/ed9oHFf1gfop+BZ4z48zm4bCoDOY=
X-Google-Smtp-Source: ABdhPJzad6SF5F/k4gH01xeALvTJEvKQT+F0V3OR13cd/JSz4gG01WgHrewbUqCgrh/eqGPk6/63gOLTxnZ/x0ytYiU=
X-Received: by 2002:a92:6403:: with SMTP id y3mr16115056ilb.72.1607692336561;
 Fri, 11 Dec 2020 05:12:16 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxiOMeGD212Lt6_udbDb6f6M+dt4vUrZz_2Qt-tuvAt--A@mail.gmail.com>
 <20201210112511.GB24151@quack2.suse.cz> <CAOQ4uxj5+sO1PCfUB=xUHxnZjsAWmrCuhJgD7oaourn1R8KaMQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxj5+sO1PCfUB=xUHxnZjsAWmrCuhJgD7oaourn1R8KaMQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 11 Dec 2020 15:12:04 +0200
Message-ID: <CAOQ4uxhEsbfA5+sW4XPnUKgCkXtwoDA-BR3iRO34Nx5c4y7Nug@mail.gmail.com>
Subject: Re: FAN_CREATE_SELF
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 2:23 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Dec 10, 2020 at 1:43 PM Jan Kara <jack@suse.cz> wrote:
> >
> > Hi Amir!
> >
> > On Wed 09-12-20 21:14:53, Amir Goldstein wrote:
> > > I have a use case with a listener that uses FAN_REPORT_FID mode.
> > > (fid is an index to a db).
> > > Most of the time fid can be resolved to the path and that is sufficient.
> > > If it cannot, the file will be detected by a later dir scan.
> > >
> > > I find that with most of the events this use case can handle the events
> > > efficiently without the name info except for FAN_CREATE.
> > >
> > > For files, with most applications, FAN_CREATE will be followed by
> > > some other event with the file fid, but it is not guaranteed.
> > > For dirs, a single FAN_CREATE event is more common.
> > >
> > > I was thinking that a FAN_CREATE_SELF event could be useful in some
> > > cases, but I don't think it is a must for closing functional gaps.
> > > For example, another group could be used with FAN_REPORT_DFID_NAME
> > > to listen on FAN_CREATE events only, or on FAN_CREATE (without name)
> > > the dir can be scanned, but it is not ideal.
> > >
> > > Before composing a patch I wanted to ask your opinion on the
> > > FAN_CREATE_SELF event. Do you have any thoughts on this?
> >
> > Well, generating FAN_CREATE_SELF event is kind of odd because you have no
> > mark placed on the inode which is being created. So it would seem more
> > logical to me that dirent events - create, move, delete - could provide you
> > with a FID of object that is affected by the operation (i.e., where DFID +
> > name takes you). That would have to be another event info type.
>
> FAN_CREATE_SELF makes sense for a filesystem mark. I forgot to
> mention that in the description of my use case.
> It also makes sense to API IMO because of symmetry with delete and move self
> vs. a completely new type of event.

Scratch that please. I misread your reply and I was thinking about it
the wrong way.
I agree with you that FAN_CREATE_SELF makes little or no sense.

One option is adding another info type as you wrote, with yet another
FAN_REPORT_XXX flag I presume.

Another option is adding another event type (as I thought you had suggested).
Something like FAN_LINK, for when an inode is linked into the namespace
but from the perspective of the inode as opposed to the perspective of the
parent dir where the inode is being linked.

We could match it with FAN_UNLINK, or interpret FAN_LINK as any sort
of change with linkage of the inode to the namespace (create/delete/rename)
maybe name the event FAN_LINKS.

Obviously, FAN_EVENT_INFO_TYPE_FID would be that of the (un)linked
inode and FAN_EVENT_INFO_TYPE_DFID would be that of the parent.

Apart from being able to learn the fid of a new object appearing in the
filesystem or a new child or a watched parent, watcher can be watching
a file and be notified when that file has been unlinked from the namespace,
even if the file still has open references delaying the report of
FAN_DELETE_SELF.

Thoughts?

Amir.
