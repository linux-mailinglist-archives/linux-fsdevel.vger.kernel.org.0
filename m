Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BC75B6562
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 04:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiIMCHq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 22:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIMCHp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 22:07:45 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F145246C
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 19:07:44 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id i1so10903378vsc.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 19:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=5VmgfOdiLA6pH7L5mhmpnNIs4IMof9JNaAhni5vx2LY=;
        b=At3JUi7Lwi6B6JLdr4VfdNVyvPt0SOWOmwu2JBDUKXzfFbe7QWWy36TQ9glZY15g96
         r7Njle3a3YCcpEBbuW8mZSMvQi+4T/wCjF80F2KXJJCBlwD7E2oMbBcqndpbjiyLe7K7
         61WO3R1A3WhB3/2MGLDQ0o2AUJ06gr/f9y8iINOzmVdQaDf6adcq0ustZcvDMH8hKdCC
         vjkIE2rHEBLAGR5x4tdyCcszYtsYee2sPgLRkSr79JDmvilz5gYBFFmLmoCIs3PtbXg5
         Osst9VOTL8v184sR6PtQCUfefZl4IIBXhANWn/sc5BoGr1lhmDr22++POGukCee7rmrR
         Ef3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5VmgfOdiLA6pH7L5mhmpnNIs4IMof9JNaAhni5vx2LY=;
        b=MeDwZwAhVpRN+o5RvFOUqFgSZFtCTjdFUZ0jzsK84//n9ZA1Wl+59pMnTvowgZxS/q
         AqRfSMzsyAQTsuTmOvbNmsz/UcmvCMxpY5oSl1XVzZKVWy4FJX4122zw5NJmpcZVMLcX
         2p8XSOAxYcpuSOqLOxvUfg58hb0jcckqF5CuSjvZV7HfT1H6yRSWLOooKGeIoS4BHq4Q
         s/afJagWh0aGaqJGNOWXCw2C0zbJQBLWmlieN8Ue4uOuyTAmUAac5RnCsdrN+LE7FL4k
         nDO6h0VHymMfxjHQCM26NQE2olRbbWoTH4MLy7Vu3pw4B+QuKYaEQAwd26XbeMz2fRaa
         EMhQ==
X-Gm-Message-State: ACgBeo1YCjqchL7JzQZWEVBxINIBFMMC957XkeVsX1WLpbO51tT5DGtC
        v+DalKlQyrguHeGHc+A8DncMzsf+4MHFMwxUMC2cy0Zzx3U=
X-Google-Smtp-Source: AA6agR4GdiO5BdVxJxRqeWLv0sLYVRNT9FQp4XLMZft8MslGtHTXugBcIN/aCU7UID8e8hz2fpoEBz71qKyLTlnsSgo=
X-Received: by 2002:a67:a243:0:b0:398:a30e:1566 with SMTP id
 t3-20020a67a243000000b00398a30e1566mr1403708vsh.2.1663034862996; Mon, 12 Sep
 2022 19:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <dc696835-bbb5-ed4e-8708-bc828d415a2b@virtuozzo.com>
 <CAOQ4uxg0XVEEzc+HyyC63WWZuA2AsRjJmbZBuNimtj=t+quVyg@mail.gmail.com>
 <20200922210445.GG57620@redhat.com> <CAOQ4uxg_FV8U833qVkgPaAWJ4MNcnGoy9Gci41bmak4_ROSc3g@mail.gmail.com>
 <CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com>
 <CAOQ4uxiJ3qxb_XNWdmQPZ3omT3fjEhoMfG=3CSKucvoJbj6JSg@mail.gmail.com>
 <Yx8xEhxrF5eFCwJR@redhat.com> <CAOQ4uxikeG5Ys4Hm2nr7CuJ7cDpNmOP-PRKjezi-DTwDUP42kw@mail.gmail.com>
 <Yx9DuJwWN3l5T4jL@redhat.com> <CAOQ4uxhTksMqScNuRbRNNtXvs+JhTbcggPQpXfzqHJtYmTKuRA@mail.gmail.com>
 <Yx+O/0gVFso5YNxG@redhat.com>
In-Reply-To: <Yx+O/0gVFso5YNxG@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 13 Sep 2022 05:07:32 +0300
Message-ID: <CAOQ4uxg8iChHexh_rP=uoV2M3H113sVgPxV6TpTWnwzN3ygsdg@mail.gmail.com>
Subject: Re: Persistent FUSE file handles (Was: virtiofs uuid and file handles)
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 12, 2022 at 10:56 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Mon, Sep 12, 2022 at 06:07:42PM +0300, Amir Goldstein wrote:
> > On Mon, Sep 12, 2022 at 5:35 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Mon, Sep 12, 2022 at 04:38:48PM +0300, Amir Goldstein wrote:
> > > > On Mon, Sep 12, 2022 at 4:16 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > >
> > > > > On Sun, Sep 11, 2022 at 01:14:49PM +0300, Amir Goldstein wrote:
> > > > > > On Wed, Sep 23, 2020 at 10:44 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > > > > >
> > > > > > > One proposal was to add  LOOKUP_HANDLE operation that is similar to
> > > > > > > LOOKUP except it takes a {variable length handle, name} as input and
> > > > > > > returns a variable length handle *and* a u64 node_id that can be used
> > > > > > > normally for all other operations.
> > > > > > >
> > > > > > > The advantage of such a scheme for virtio-fs (and possibly other fuse
> > > > > > > based fs) would be that userspace need not keep a refcounted object
> > > > > > > around until the kernel sends a FORGET, but can prune its node ID
> > > > > > > based cache at any time.   If that happens and a request from the
> > > > > > > client (kernel) comes in with a stale node ID, the server will return
> > > > > > > -ESTALE and the client can ask for a new node ID with a special
> > > > > > > lookup_handle(fh, NULL).
> > > > > > >
> > > > > > > Disadvantages being:
> > > > > > >
> > > > > > >  - cost of generating a file handle on all lookups
> > > > > > >  - cost of storing file handle in kernel icache
> > > > > > >
> > > > > > > I don't think either of those are problematic in the virtiofs case.
> > > > > > > The cost of having to keep fds open while the client has them in its
> > > > > > > cache is much higher.
> > > > > > >
> > > > > >
> > > > > > I was thinking of taking a stab at LOOKUP_HANDLE for a generic
> > > > > > implementation of persistent file handles for FUSE.
> > > > >
> > > > > Hi Amir,
> > > > >
> > > > > I was going throug the proposal above for LOOKUP_HANDLE and I was
> > > > > wondering how nodeid reuse is handled.
> > > >
> > > > LOOKUP_HANDLE extends the 64bit node id to be variable size id.
> > >
> > > Ok. So this variable size id is basically file handle returned by
> > > host?
> > >
> > > So this looks little different from what Miklos had suggested. IIUC,
> > > he wanted LOOKUP_HANDLE to return both file handle as well as *node id*.
> > >
> > > *********************************
> > > One proposal was to add  LOOKUP_HANDLE operation that is similar to
> > > LOOKUP except it takes a {variable length handle, name} as input and
> > > returns a variable length handle *and* a u64 node_id that can be used
> > > normally for all other operations.
> > > ***************************************
> > >
> >
> > Ha! Thanks for reminding me about that.
> > It's been a while since I looked at what actually needs to be done.
> > That means that evicting server inodes from cache may not be as
> > easy as I had imagined.
> >
> > > > A server that declares support for LOOKUP_HANDLE must never
> > > > reuse a handle.
> > > >
> > > > That's the basic idea. Just as a filesystem that declares to support
> > > > exportfs must never reuse a file handle.
> > >
> > > >
> > > > > IOW, if server decides to drop
> > > > > nodeid from its cache and reuse it for some other file, how will we
> > > > > differentiate between two. Some sort of generation id encoded in
> > > > > nodeid?
> > > > >
> > > >
> > > > That's usually the way that file handles are implemented in
> > > > local fs. The inode number is the internal lookup index and the
> > > > generation part is advanced on reuse.
> > > >
> > > > But for passthrough fs like virtiofsd, the LOOKUP_HANDLE will
> > > > just use the native fs file handles, so virtiofsd can evict the inodes
> > > > entry from its cache completely, not only close the open fds.
> > >
> > > Ok, got it. Will be interesting to see how kernel fuse changes look
> > > to accomodate this variable sized nodeid.
> > >
> >
> > It may make sense to have a FUSE protocol dialect where nodeid
> > is variable size for all commands, but it probably won't be part of
> > the initial LOOKUP_HANDLE work.
> >
> > > >
> > > > That is what my libfuse_passthough POC does.
> > >
> > > Where have you hosted corresponding kernel changes?
> > >
> >
> > There are no kernel changes.
> >
> > For xfs and ext4 I know how to implement open_by_ino()
> > and I know how to parse the opaque fs file handle to extract
> > ino+generation from it and return them in FUSE_LOOKUP
> > response.
>
> Aha, interesting. So is this filesystem specific. Works on xfs/ext4 but
> not necessarily on other filesystems like nfs. (Because they have their
> own way of encoding things in file handle).

Correct.
If it is not xfs/ext4, the passthrough implementation uses open fds.
In the non xfs/ext4 case, an NFS client may get ESTALE errors after
server restart and worse - get the content of the wrong object
if server has reused nodeid+genration after restart.

>
> >
> > So I could manage to implement persistent NFS file handles
> > over the existing FUSE protocol with 64bit node id.
>
> And that explains that why you did not have to make kernel changes. But
> this does not allow sever to close the fd associate with nodeid? Or there
> is a way for server to generate file handle and then call
> open_by_handle_at().
>

Yes, that's what the server does in case of ext4/xfs:
https://github.com/amir73il/libfuse/blob/fuse_passthrough/passthrough/fuse_passthrough.cpp#L912

Thanks,
Amir.
