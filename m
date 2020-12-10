Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB5A2D5A74
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 13:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbgLJMY7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 07:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731010AbgLJMX4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 07:23:56 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62955C0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 04:23:16 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id i18so5323759ioa.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 04:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nF9+g6mYV6IRupmAkfRb8NxFT8RcS0T8JHL28OEIqos=;
        b=pMAStHjXEcYEnzztKvKbMOGtn2LzFNoE1WmMqF2c2CAfGX/VZHQyduVBdix8dTPlpv
         0NM4B33U7DhfBxOqW1RvtJDnDXD5Yj+eYMvERD5qRpJ6OvlKAhOx8Rq2Yxf7tGh0FED0
         62pR6mejgA3Nz8tXVg9geAtXzDrnY167aHK70E1NtFhZYF4eaQf616aJzX4jM9e8wHbW
         wA5Bv1MsOojzbloSnh9HYPc0GSS2HCKXNVhSJXfUeFfM3dd2JB1TRToVnZZr1VoR/OZl
         IRmyWsOquTQJsWjmOssNAkvWiBo07Jx4urGOeX1WDs1X4PJ7yzCHtTmr0cqLhZ4rSkHs
         hyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nF9+g6mYV6IRupmAkfRb8NxFT8RcS0T8JHL28OEIqos=;
        b=YSvWLCAsCe7bEsScq1O1iIBU5g+tKrjnIlL6TcUlc+qoWIqLFP9JrgRZPHLdrrSaJp
         hIJ8k70Pt9jPVsKkEcZ8X60SZUNiIPPQpECX0Hi/Vg//7SGAPY6rB+tbtvG7qGUe92HE
         OuXRLfNQXizxHQvg0cE1OrahREF5Dsyor1jmleFutyKKgfr1EY4+D9p0/DKzyuWgwieR
         qs7jwseygzTGUV++XKszHP/tToFSckgLMQdOlofzWx7vVUqWJBK2RfIUHPK/xaPNWA3Z
         o4qZyskwi/AcLF7ccfmFDcUwlgmIG64UXgRSxKcTP/1mQveda7+8VQbaizE1ASMIjwB1
         h48w==
X-Gm-Message-State: AOAM533scC64s5kOaWlUbC3bNCLcHKHKQgkWmetuLdsOf9ZkfgdRu84f
        lV5s9tYpSs+06VmMBmlE4+0x8I+2WgIwrzsa/gEGbmeRipc=
X-Google-Smtp-Source: ABdhPJwRnW188oBc7D1K6f0n9rt2RThDrLMfHLW/7kX3Igqo8SaXklNClGzy41bz97DFRE/DAlpSlLfqx2284UWMChc=
X-Received: by 2002:a02:8482:: with SMTP id f2mr8594735jai.93.1607602995670;
 Thu, 10 Dec 2020 04:23:15 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxiOMeGD212Lt6_udbDb6f6M+dt4vUrZz_2Qt-tuvAt--A@mail.gmail.com>
 <20201210112511.GB24151@quack2.suse.cz>
In-Reply-To: <20201210112511.GB24151@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 10 Dec 2020 14:23:04 +0200
Message-ID: <CAOQ4uxj5+sO1PCfUB=xUHxnZjsAWmrCuhJgD7oaourn1R8KaMQ@mail.gmail.com>
Subject: Re: FAN_CREATE_SELF
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 1:43 PM Jan Kara <jack@suse.cz> wrote:
>
> Hi Amir!
>
> On Wed 09-12-20 21:14:53, Amir Goldstein wrote:
> > I have a use case with a listener that uses FAN_REPORT_FID mode.
> > (fid is an index to a db).
> > Most of the time fid can be resolved to the path and that is sufficient.
> > If it cannot, the file will be detected by a later dir scan.
> >
> > I find that with most of the events this use case can handle the events
> > efficiently without the name info except for FAN_CREATE.
> >
> > For files, with most applications, FAN_CREATE will be followed by
> > some other event with the file fid, but it is not guaranteed.
> > For dirs, a single FAN_CREATE event is more common.
> >
> > I was thinking that a FAN_CREATE_SELF event could be useful in some
> > cases, but I don't think it is a must for closing functional gaps.
> > For example, another group could be used with FAN_REPORT_DFID_NAME
> > to listen on FAN_CREATE events only, or on FAN_CREATE (without name)
> > the dir can be scanned, but it is not ideal.
> >
> > Before composing a patch I wanted to ask your opinion on the
> > FAN_CREATE_SELF event. Do you have any thoughts on this?
>
> Well, generating FAN_CREATE_SELF event is kind of odd because you have no
> mark placed on the inode which is being created. So it would seem more
> logical to me that dirent events - create, move, delete - could provide you
> with a FID of object that is affected by the operation (i.e., where DFID +
> name takes you). That would have to be another event info type.

FAN_CREATE_SELF makes sense for a filesystem mark. I forgot to
mention that in the description of my use case.
It also makes sense to API IMO because of symmetry with delete and move self
vs. a completely new type of event.
The application is maintaining a map with entries per accessed file
indexed by fid.
When an object appears on the fs, it would have been nice to be able to update
the map right away, but it is not a deal breaker if it is updated later when the
object is observed in another event.

>
> BTW, what's the problem with just using FAN_REPORT_DFID_NAME? You don't
> want to pay the cost of looking up & copying DFID+name instead of FID for
> cases you don't care about? Is there such a significant difference?

That is the reason. Currently, the application uses FAN_REPORT_DFID_NAME,
but I observed that with some configurations, name info is ONLY relevant for
FAN_CREATE events. For those configurations, if we had FAN_CREATE_SELF,
name info copying, variable size event allocation, less efficient merge, all of
those could be avoided. How much does it actually save? I don't know.

So as I said, I see it as a "nice to have" event, certainly not a
must, but it can
help optimize some workloads.
The honest truth is that I think if I try hard enough I will be able
to find a corner
use case where FAN_CREATE_SELF can actually help to close a functional
gap (or the new type of create event that you mentioned), but I am lazy try,
so I try to use these arguments instead:

The API documentation should be pretty straight forward and natural.
The implementation should be trivial.
So the question is - Why not?

Thanks,
Amir.
