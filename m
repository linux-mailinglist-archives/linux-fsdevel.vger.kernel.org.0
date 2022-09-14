Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6BE5B8790
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 13:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiINLxH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 07:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiINLxF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:53:05 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4997AC24
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 04:53:04 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id o123so15601814vsc.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 04:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=E1areg6Jpx0avq4XhuuVK9beLz109A7rUhijXBpCrUE=;
        b=P00wqpirob8GqK7L2KGhDBt9BpWdN5bUDj2WBDcbfpso+Ab7pN0esAHNbfVCgkY+PR
         2XbtRC09VwOVsV7DIA4akcP98gnTuI/UjLb3gZY3qyPc8XQGDvpS7SPoIjsfk/kOMoKS
         aE1AgyYVYbZgfiZFc6oHyIZv5iFy/tPD7YDthvVsKGkat4aVBjdMepD8Npkhgtw/klXo
         Xuvqh1OBsoA/m53eJsBMSb1lM4T4nl5jR+zX77BqtFjoUWgZwDz00obtLYtAXFX/ofzg
         PbWwvkUap09ukxm3RrJ8dQurkoOxu9wqhZ/tgwXBsu8bKqAuL9G9zVG/xwcm+yh22RsA
         4pkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=E1areg6Jpx0avq4XhuuVK9beLz109A7rUhijXBpCrUE=;
        b=nNS6F8VLg2KAeygGCLVsfhdBmy09xH6ZKSAx6DrXRcU9sfJyzE2cIFhsGeLrI40K4i
         Ea9k89+FdjvTm7ZxTy+/cXQDkBywtu2xoXLn3ROIUxalKdHByJyOaLQOItDqdPH0bp0X
         gLGa4wNEoanh77KsgBv+C6PpdQ/KJawzvEBO7x8O2KWt4McyA2+pVyA21A/8CvDpw5RW
         IASumMml9KRCjxQEcnUXW398R+4lqih5y/RhXErnUSmMMQgEzrcf0a1DKhYsW62bgTGF
         fbQMYz2GeupO4xXXUpLb2fv/xq4f3HdogkxMLTUZ3G6Zntvcy/R/tBQzekNFlLG2nJWg
         38SA==
X-Gm-Message-State: ACgBeo2i1dd1ljeXOCN6zGahDhw16zpdmVhCpSBF8Dm9vRyNknNyqfQb
        bkhhJIY/kf2XLJky/g+UElML9kddn000wwi48ilBrL7CzhM=
X-Google-Smtp-Source: AA6agR6rsigWdWF7gu+q8+vJ1/B8hQd6eNPU+LBct+VEnaTKyTLkY2bTSlWWM4FsF2YZm8ifLKM1YIgWCykkhTFEvSk=
X-Received: by 2002:a67:c18a:0:b0:398:2f16:3f94 with SMTP id
 h10-20020a67c18a000000b003982f163f94mr10938458vsj.36.1663156383555; Wed, 14
 Sep 2022 04:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxhrQ7hySTyHM0Atq=uzbNdHyGV5wfadJarhAu1jDFOUTg@mail.gmail.com>
 <20220912125734.wpcw3udsqri4juuh@quack3> <CAOQ4uxgE5Wicsq_O+Vc6aOaLeYMhCEWrRVvAW9C1kEMMqBwJ9Q@mail.gmail.com>
 <CAOQ4uxgyWEvsTATzimYxuKNkdVA5OcfzQOc1he5=r-t=GX-z6g@mail.gmail.com> <20220914103006.daa6nkqzehxppdf5@quack3>
In-Reply-To: <20220914103006.daa6nkqzehxppdf5@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 14 Sep 2022 14:52:51 +0300
Message-ID: <CAOQ4uxh6C=jMftsFQD3s1u7D_niRDmBaxKTymboJQGTmPD6bXQ@mail.gmail.com>
Subject: Re: thoughts about fanotify and HSM
To:     Jan Kara <jack@suse.cz>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Plaster, Robert" <rplaster@deepspacestorage.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
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

> > > > So I'd prefer to avoid the major API
> > > > extension unless there are serious users out there - perhaps we will even
> > > > need to develop the kernel API in cooperation with the userspace part to
> > > > verify the result is actually usable and useful.
> >
> > Yap. It should be trivial to implement a "mirror" HSM backend.
> > For example, the libprojfs [5] projects implements a MirrorProvider
> > backend for the Microsoft ProjFS [6] HSM API.
>
> Well, validating that things work using some simple backend is one thing
> but we are probably also interested in whether the result is practical to
> use - i.e., whether the performance meets the needs, whether the API is not
> cumbersome for what HSM solutions need to do, whether the more advanced
> features like range-support are useful the way they are implemented etc.
> We can verify some of these things with simple mirror HSM backend but I'm
> afraid some of the problems may become apparent only once someone actually
> uses the result in practice and for that we need a userspace counterpart
> that does actually something useful so that people have motivation to use
> it :).

Makes sense.

> > Overlayfs provides a method to mark files for slow path
> > ('trusted.overlay.metacopy' xattr), meaning file that has metadata
> > but not the data, but overlayfs does not provide the API to perform
> > "user controlled migration" of the data.
> >
> > Instead of inventing a new API for that, I'd rather extend the
> > known fanotify protocol and allow the new FAN_XXX_PRE events
> > only on filesystems that have the concept of a file without its content
> > (a.k.a. metacopy).
> >
> > We could say that filesystems that support fscache can also support
> > FAN_XXX_PRE events, and perhaps cachefilesd could make use of
> > hooks to implement user modules that populate the fscache objects
> > out of band.
>
> One possible approach is that we would make these events explicitely
> targetted to HSM and generated directly by the filesystem which wants to
> support HSM. So basically when the filesystem finds out it needs the data
> filled in, it will call something like:
>
>   fsnotify(inode, FAN_PRE_GIVE_ME_DATA, perhaps_some_details_here)
>
> Something like what we currently do for filesystem error events but in this
> case the event will work like a permission event. Userspace can be watching
> the filesystem with superblock mark to receive these events. The persistent
> marking of files is completely left upto the filesystem in this case - it
> has to decide when the FAN_PRE_GIVE_ME_DATA event needs to be generated for
> an inode.
>

Woh! that's DMAPI pain all over again.
I do not want to go there.
I have no capacity nor desire to drive this sort of changes through every
single filesystem and convince the maintainers to support those hooks forever.
(seems that you have experienced this pain yourself).

I would like to be able to have a generic vfs implementation.
I do not want to rely on the filesystem at all to decide when local data
is valid or not for the HSM.

That should be completely up to the HSM implementation to decide.
My example with punched file was just to demonstrate how an
implementation that is DMAPI drop-in replacement would look like.

It might be ok for specific filesystems, e.g. overlayfs, to call
fsnotify(inode, FAN_PRE_XXX,...) e.g. before copy up. That would
be done as the remote notifications we discussed for fuse/cifs.
Still need to think about how remote and local notifications are
distinguished, but at least a bit in the event mask for "remote"
should be enough for the eBPF filter to make the decision.

> > There is the naive approach to interpret a "punched hole" in a file as
> > "no content" as DMAPI did, to support FAN_XXX_PRE events on
> > standard local filesystem (fscache does that internally).
> > That would be an opt-in via fanotify_init() flag and could be useful for
> > old DMAPI HSM implementations that are converted to use the new API.
>
> I'd prefer to leave these details upto the filesystem wanting to support
> HSM and not clutter fanotify API with details about file layout.
>

Not clutter fanotify with details about filesystem - agreed.
Clutter filesystem with details about HSM - disagree.
A BPF filter on fanotify mark with the details about specific HSM
should resolve both our objections.

If one wants to write an HSM that works with "chattr +X" filter
then this HSM will require filesystem support, but there are ways
to implement an HSM that would be mostly filesystem agnostic.

> > Practically, the filesystems that allow FAN_XXX_PRE events
> > on punched files would need to advertise this support and maintain
> > an inode flag (i.e. I_NODATA) to avoid a performance penalty
> > on every file access. If we take that route, though, it might be better
> > off to let the HSM daemon set this flag explicitly (e.g. chattr +X)
> > when punching holes in files and removing the flag explicitly
> > when filling the holes.
>
> Again, in what I propose this would be left upto the filesystem - e.g. it
> can have inode flag or xattr or something else to carry the information
> that this file is under HSM and call fsnotify() when the file is accessed.
> It might be challenging to fulfill your desire to generate the event
> outside of any filesystem locks with this design though.
>

Right. Another reason to dislike fs internal hooks.
I think my eBPF suggestion does not suffer from this problem.

> > And there is the most flexible option of attaching a BFP filter to
> > a filesystem mark, but I am afraid that this program will be limited
> > to using information already in the path/dentry/inode struct.
> > At least HSM could use an existing arbitrary inode flag
> > (e.g. chattr+i) as "persistent marks".
> >
> > So many options! I don't know which to choose :)
> >
> > If this plan sounds reasonable, I can start with a POC of
> > "user controlled copy up/down" for overlayfs, using fanotify
> > as the user notification protocol and see where it goes from there.
>

I am not sure anymore if overlayfs is a good place to start this POC.
I think that an easier POC will be to use an example "demo filter" in C
to check some inode flag, until the eBPF filter is implemented and
write a demo backend to demonstrate the usefulness of the API extensions.

> Yeah, that might be interesting to see as an example. Another example of
> "kind-of-hsm" that we already have in the kernel is autofs. So we can think
> whether that could be implemented using the scheme we design as an
> excercise.
>

An interesting exercise, but so far, fsnotify was not dealing with
namespace changes at all, it was completely restricted to notifying
about filesystems changes, so I don't think now would be a good
time to change that paradigm.

Thanks,
Amir.
