Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BC24407C5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Oct 2021 08:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhJ3Gzz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Oct 2021 02:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhJ3Gzy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Oct 2021 02:55:54 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE78C061570;
        Fri, 29 Oct 2021 23:53:24 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id f9so15147318ioo.11;
        Fri, 29 Oct 2021 23:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9DLFjFHWATsITDnmuok3ifT9gh+RmIc4iBUCeUP+Fuw=;
        b=kGCCoGhqNLCCfUvzA3j0IX6B0QZExWMttN2ijaNEVKLLXXlpUiUEfJxI4HFIcoiCGW
         xFZ8bpdvrHy70BB8nUCpwMPeAnxoDB23ndIVoZUlEpgh/9gL3T5yHCB9wwzIi5lWr0MQ
         WGCwnaEI6YnmnJPFwmVSJSa4P9/b0FuzQlIxy+4SRuZAnGqMYXqkKllJ1hHrIBlk8zNk
         1TaE7w6iNHy4IlMe5U+naKU+b44TXxp62GxLT6OSYPBeueAxy/U7xycf9YbfGUgEvo8Q
         euB6tZBpO9l00SMPDauzGqiXtENh/k4+Ld011xYzP+6TNhehXnWvnbRmi8IlP2+Lf/CY
         sOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9DLFjFHWATsITDnmuok3ifT9gh+RmIc4iBUCeUP+Fuw=;
        b=wYv6YP4ZIFMuFQsKsgFMUfF4xXYFLj7d4LoSxJ4mEcO8dq96FMMSFQM3iEscIewDx4
         XcofW3deCw6ggHHvS1/Mk/OGZ3XZwKyIG82lF8AdsQGYwJcx182HK26thLsH3oGb8peD
         +Zl9r1DMZmdSykshk6W5qPiHHIP1zg62fVNOcBAPOg+lyk0XPgo4C1zg6JDYUZIn3RoI
         okvvSSn3itNK+muynSCYBIK73SCGAvp2aCA5uoY3hfC+jO8K+/ycd0wJT1WY03qaE00G
         kgp/nCUk+XSccuO5/mEFD9LoDpVyfh3Vi/k3WciDTJtJykCzZSeQWUOxuYlweLkpODxs
         nZxA==
X-Gm-Message-State: AOAM5305QVxrMYAml4Vpji5DuFbx6GMKeCobDzvaTRA69dQluIhKX+vr
        hlsZPwyOLlss71E7gbtUQoUfKJh1VUXCs2cjxxc=
X-Google-Smtp-Source: ABdhPJxW9rfudOkuXU/Yx6uClLSO2PSUG3+/SrYKj3EUJ/bjIWgX7+6F3I8gwitR7Mt2e8ukxp2bMkJDCPA936yQe9E=
X-Received: by 2002:a02:880a:: with SMTP id r10mr11165186jai.40.1635576803946;
 Fri, 29 Oct 2021 23:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211025192746.66445-1-krisman@collabora.com> <CAOQ4uxhth8NP4hS53rhLppK9_8ET41yrAx5d98s1uhSqrSzVHg@mail.gmail.com>
 <20211027112243.GE28650@quack2.suse.cz> <CAOQ4uxgUdvAx6rWTYMROFDX8UOd8eVzKhDcpB0Qne1Uk9oOMAw@mail.gmail.com>
 <87y26ed3hq.fsf@collabora.com> <CAOQ4uxh4ikTUHM6=s09+bq=VAjBsZeU9UXPv8K1XpvxwVU6tMw@mail.gmail.com>
 <8735oja2ro.fsf@collabora.com>
In-Reply-To: <8735oja2ro.fsf@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 30 Oct 2021 09:53:12 +0300
Message-ID: <CAOQ4uxj8gPReemQ3z3gJo21E-+NE6F=xtK-EANfEJFEBKVFuxg@mail.gmail.com>
Subject: Re: [PATCH v9 00/31] file system-wide error monitoring
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com,
        Jeff Layton <jlayton@kernel.org>, andres@anarazel.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 30, 2021 at 1:24 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Amir Goldstein <amir73il@gmail.com> writes:
>
> >> Also, thank you both for the extensive review and ideas during the
> >> development of this series.  It was really appreciated!
> >>
> >
> > Thank you for your appreciated effort!
> > It was a wild journey through some interesting experiments, but
> > you survived it well ;-)
> >
> > Would you be interested in pursuing FAN_WB_ERROR after a due rest
> > and after all the dust on FAN_FS_ERROR has settled?
>
> I think it would make sense for me to continue working on it, yes.  But,
> before that, I think I still have some support to add to FAN_FS_ERROR,
> like a detailed, fs-specific, info record, and an error location info
> record, which has a use-case in Google Cloud environments.  I have to
> discuss priorities internally, but we (collabora) do have an interest in
> supporting WB_ERROR too.
>
> For the detailed error report, fanotify could have a new info record
> that carries a structure sent out by the file system.  fanotify could
> handle the lifetime of this object, by keeping a larger mempool, or
> delegate its allocation/destruction to the filesystem.
>

Before you try anything radical, please check the size of prospect
fs-specific data.
My hunch says that in most cases fs-specific data could fit cozy along side the
file handle within MAX_HANDLE_SZ and if this is true, then we do not need to
worry about extreme cases right now.
If there comes a time when we have a justified case of a filesystem that needs
to report much bigger fs-specific data, we can consider it then.
Until that time, we simply drop the over sized fs-specific data same as we do
if filesystem passed in a file handle larger than MAX_HANDLE_SZ.

> Like I proposed in an earlier version of FAN_FS_ERROR, the format could
> be as simple as:
>
> struct fanotify_error_data_info {
>    struct fanotify_event_info_header hdr;
>    char data[];
> }
>

We can add char data[] field to the end of struct fanotify_event_info_error.
It does not change the layout nor size of the structure and the info record
is variable size per definition anyway.

I know Jan didn't like this so much at the time and contemplated a
separate info record for filename, but eventually, fanotify_event_info_fid
also has an optional name following the unsigned char handle[].

> I think xfs, at least, would be able to make good use of this record with
> xfs_scrub, as the xfs maintainers mentioned.

I am not sure if that was the final conclusion.
xfs_scrub is proactive and should have no problem reporting its own findings,
but I have no objections to fs-specific details in FS_ERROR event.

Thanks,
Amir.
