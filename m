Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 300EB17C6D8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 21:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgCFUL5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 15:11:57 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:45815 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbgCFUL5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 15:11:57 -0500
Received: by mail-io1-f66.google.com with SMTP id w9so3299459iob.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2020 12:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uGhnsFojeYVgmT7TeltZeDT7YJ6kcqoR7qP83JoZDq8=;
        b=CfCt62LsFryGf6XAIckG0NHQAEF/JWpNRvEH5io6jCC1OozpOAfmnwMJVh8/b3Ye8D
         bHl8CuLt8I/Yaa22343ubc4bKJ8ViDo8o5QJWvc2GKzGU8DIx2OEH9G115Np6QyRFTNV
         H3+9zS2erYPZvp4+Gox0lwRnRuO94El5PeNRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uGhnsFojeYVgmT7TeltZeDT7YJ6kcqoR7qP83JoZDq8=;
        b=PYolzAjY7XsRFpwYFnBCRQrOmgUMvNsZvQopxSxjIU52npyW1tb+ejkKsTF61BZq1y
         QAodLHxHEZlTKDSJNppAAaB40OtqLEa+Zf34Pe2ODt7SrV91CNEnSEE2AE1qOpDNGoQM
         MavzoppFXfe5RCn8pNVzARtzyNj5hpE5i9JIxmrwXDeicRdy/kyZtdpuhYqnwGTYCL4R
         Rlok0Z4yYvUfYFCGEFhPE9eGNyb0arebAJLEmDYBggL6USOPAYMpQAxRbCEupX2BwIqv
         DYG6TA9u+ss25cdNQec7jFRMISvtsijsnEJ4uae/iyzRD6cy+P8G0Fu0sekFjD9G12mE
         cN+A==
X-Gm-Message-State: ANhLgQ2Cdo0ejV2z2CH4yQSgPPYvLyf3TPjY3PhKcfXmWQRD8pQxFj5W
        WetRt/7G27pMA8pFwPMd2M3yF+hoFIDvulhayPqIHw==
X-Google-Smtp-Source: ADFU+vuODDfafR+/1VeQ163p94uyrF+ItUfBzdjUzGnf8TqcDPRfyTMaGnOGRkbWFntLIcfsPdanDzwpQf7p0gmtB/I=
X-Received: by 2002:a02:6a10:: with SMTP id l16mr4545028jac.77.1583525515096;
 Fri, 06 Mar 2020 12:11:55 -0800 (PST)
MIME-Version: 1.0
References: <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com>
 <1582644535.3361.8.camel@HansenPartnership.com> <20200228155244.k4h4hz3dqhl7q7ks@wittgenstein>
 <107666.1582907766@warthog.procyon.org.uk> <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
 <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <20200306162549.GA28467@miu.piliscsaba.redhat.com> <20200306194322.GY23230@ZenIV.linux.org.uk>
 <20200306195823.GZ23230@ZenIV.linux.org.uk> <20200306200522.GA23230@ZenIV.linux.org.uk>
In-Reply-To: <20200306200522.GA23230@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 6 Mar 2020 21:11:43 +0100
Message-ID: <CAJfpegvbw7A6tv-v94QzKAKwk3BOGdXrmV83W4D=R2T=14pXUg@mail.gmail.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 6, 2020 at 9:05 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, Mar 06, 2020 at 07:58:23PM +0000, Al Viro wrote:
> > On Fri, Mar 06, 2020 at 07:43:22PM +0000, Al Viro wrote:
> > > On Fri, Mar 06, 2020 at 05:25:49PM +0100, Miklos Szeredi wrote:
> > > > On Tue, Mar 03, 2020 at 08:46:09AM +0100, Miklos Szeredi wrote:
> > > > >
> > > > > I'm doing a patch.   Let's see how it fares in the face of all these
> > > > > preconceptions.
> > > >
> > > > Here's a first cut.  Doesn't yet have superblock info, just mount info.
> > > > Probably has rough edges, but appears to work.
> > >
> > > For starters, you have just made namespace_sem held over copy_to_user().
> > > This is not going to fly.
> >
> > In case if the above is too terse: you grab your mutex while under
> > namespace_sem (see attach_recursive_mnt()); the same mutex is held
> > while calling dir_emit().  Which can (and normally does) copy data
> > to userland-supplied buffer.
> >
> > NAK for that reason alone, and to be honest I had been too busy
> > suppressing the gag reflex to read and comment any deeper.
> >
> > I really hate that approach, in case it's not clear from the above.
> > To the degree that I don't trust myself to filter out the obscenities
> > if I try to comment on it right now.
> >
> > The only blocking thing we can afford under namespace_sem is GFP_KERNEL
> > allocation.
>
> Incidentally, attach_recursive_mnt() only gets you the root(s) of
> attached tree(s); try mount --rbind and see how much you've missed.

Okay.  Both trivially fixable:

 - the dir_emit() can be taken out from under the mutex and the rb
tree search repeated for every entry; possibly not as efficient, but I
guess at this point that's irrelevant

 - addition of the mountfs entry moved to the right places

Thanks,
Miklos
