Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C3C5EDCA1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 14:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbiI1M3j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 08:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbiI1M31 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:29:27 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FC0915E4
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Sep 2022 05:29:26 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id u189so12550463vsb.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Sep 2022 05:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=GSg++amhscw5Egy/W4NgwNwOMBTHVhfEtTFCV60gt3E=;
        b=oGml3jepKx2lcKrZfBDkK9g5tSRiR8RlM8kjZU+4Fw0o0Y3wQ/vj6UFJgFKqh6ah4X
         VpF8x3f9ioN05yV+Lr9WljbamF2DWHEYpinvJHs5EnBv7IyoMOvrOP4nnV7m/uASh8kk
         vSwChjKfXTErPzaQ9H5SL4snjkN7/CMuyrxZlZf8ttG4x75nY8kV3cAhCk5e1zuKHEiw
         1X2mouQzyINpcpvzWRH7ArzAtNcuzbFayzf/XpsdHZJPp3rIFWVUKlXM8U8rt2drhGe7
         gsKXs+O8O4YiN04AtUA0jdzCwspAybBKoVBX8iQ1COU5EAIxUzihlvVGFhxgwDbJmgMY
         19iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=GSg++amhscw5Egy/W4NgwNwOMBTHVhfEtTFCV60gt3E=;
        b=Tqq86x8e2zk1INJFrhD/BET23Xxm2hIELOU889XfXth02LHdkOzb4ctLqWVvoso1ek
         FtT1Hoz1qAVqV4gHOJMCyTWxwzWwmQUhUvWXS0BYICIVd6T0XNBGz7ha8Htlmx/m+U/E
         tKyRpFwvsBQTqaXrvMgB7Y2n5BkQHIzU+upENzqJGmudE0d0bFau6dPfJfyM4aOQbpbU
         yp/F++Aoc5i8sHqvHSrjRQ4Qb/6aw113lWuBHnYSycjbA+NTfSNPznLAHUrtvw7etoUP
         u1ozsF15kugeTsLo5jbvVbzJ+SvjiP4UkvpNrKbByl3NMB/J8pUALffuNsei3/wY8678
         vk/w==
X-Gm-Message-State: ACrzQf3Exoaw7bn0PRFgvAW0BTHLyLi4oyb30/Kf6jNIFhyc9m3GofKb
        uhhxOEPfFOB4itPJQ+b6/70T7rBuLtyv6oRI0cR2XgvCKxY=
X-Google-Smtp-Source: AMsMyM6FnIjH2E/UzSwIfdg49K+SXjtNeGXBuOrFYYFa5FAOIXnZsS3r+EshuB6W08I335aFnpKSMrhyTdrQ8Ij153k=
X-Received: by 2002:a67:c18a:0:b0:398:2f16:3f94 with SMTP id
 h10-20020a67c18a000000b003982f163f94mr14585369vsj.36.1664368165617; Wed, 28
 Sep 2022 05:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxhrQ7hySTyHM0Atq=uzbNdHyGV5wfadJarhAu1jDFOUTg@mail.gmail.com>
 <20220912125734.wpcw3udsqri4juuh@quack3> <CAOQ4uxgE5Wicsq_O+Vc6aOaLeYMhCEWrRVvAW9C1kEMMqBwJ9Q@mail.gmail.com>
 <CAOQ4uxgyWEvsTATzimYxuKNkdVA5OcfzQOc1he5=r-t=GX-z6g@mail.gmail.com>
 <20220914103006.daa6nkqzehxppdf5@quack3> <CAOQ4uxh6C=jMftsFQD3s1u7D_niRDmBaxKTymboJQGTmPD6bXQ@mail.gmail.com>
 <CAOQ4uxjHu4k2-sdM1qtnFPvKRHv-OFWo0cYDZbvjv0sd9bXGZQ@mail.gmail.com>
 <20220922104823.z6465rfro7ataw2i@quack3> <CAOQ4uxj_xr4WvHNneeswZO2GEtEGgabc6r-91YR-1P+gPHPhdA@mail.gmail.com>
 <20220926152735.fgvx37rppdfhuokz@quack3>
In-Reply-To: <20220926152735.fgvx37rppdfhuokz@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 28 Sep 2022 15:29:13 +0300
Message-ID: <CAOQ4uxgU4q1Pj2-9q7DZGZiw1EPZKXbc_Cp=H_Tu5_sxD6-twA@mail.gmail.com>
Subject: Re: thoughts about fanotify and HSM
To:     Jan Kara <jack@suse.cz>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Plaster, Robert" <rplaster@deepspacestorage.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Fufu Fang <fangfufu2003@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 26, 2022 at 6:27 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 22-09-22 16:03:41, Amir Goldstein wrote:
> > On Thu, Sep 22, 2022 at 1:48 PM Jan Kara <jack@suse.cz> wrote:
> > > On Tue 20-09-22 21:19:25, Amir Goldstein wrote:
> > > > For the next steps of POC, I could do:
> > > > - Report FAN_ACCESS_PERM range info to implement random read
> > > >   patterns (e.g. unzip -l)
> > > > - Introduce FAN_MODIFY_PERM, so file content could be downloaded
> > > >   before modifying a read-write HSM cache
> > > > - Demo conversion of a read-write FUSE HSM implementation
> > > >   (e.g. https://github.com/volga629/davfs2)
> > > > - Demo HSM with filesystem mark [*] and a hardcoded test filter
> > > >
> > > > [*] Note that unlike the case with recursive inotify, this POC HSM
> > > > implementation is not racy, because of the lookup permission events.
> > > > A filesystem mark is still needed to avoid pinning all the unpopulated
> > > > cache tree leaf entries to inode cache, so that this HSM could work on
> > > > a very large scale tree, the same as my original use case for implementing
> > > > filesystem mark.
> > >
> > > Sounds good! Just with your concern about pinning - can't you use evictable
> > > marks added on lookup for files / dirs you want to track? Maybe it isn't
> > > great design for other reasons but it would save you some event
> > > filtering...
> > >
> >
> > With the current POC, there is no trigger to re-establish the evicted mark,
> > because the parent is already populated and has no mark.
>
> So my original thinking was that you'd place FAN_LOOKUP_PERM mark on top of
> the directory tree and then you'd add evictable marks to all the subdirs
> that are looked up from the FAN_LOOKUP_PERM event handler. That way I'd
> imagine you can place evictable marks on all directories that are used in a
> race-free manner.
>

Maybe I am missing something.
I don't see how that can scale up to provide penalty free fast path lookup
for fully populated subtrees.

> > A hook on instantiate of inode in inode cache could fill that gap.
> > It could still be useful to filter FAN_INSTANTIATE_PERM events in the
> > kernel but it is not a must because instantiate is more rare than (say) lookup
> > and then the fast lookup path (RCU walk) on populated trees suffers almost
> > no overhead when the filesystem is watched.
> >
> > Please think about this and let me know if you think that this is a direction
> > worth pursuing, now, or as a later optimization.
>
> I think an event on instantiate seems to be depending too much on kernel
> internals instead of obvious filesystem operations. Also it might be a bit
> challenging during startup when you don't know what is cached and what not
> so you cannot rely on instantiate events for placing marks. So I'd leave
> this for future optimization.
>

Perhaps a user FAN_INSTANTIATE_PERM is too much, but I was
trying to figure out a way to make automatic inode marks work.
If we can define reasonable use cases for automatic inode marks that
kernel can implement (e.g. inheriting from parent on dentry instantiate)
then this could possibly get us something useful.
Maybe that is what you meant with the suggestion above?

The other use case of automatic inode marks I was thinking about,
which are even more relevant for $SUBJECT is this:
When instantiating a dentry with an inode that has xattr
"security.fanotify.mask" (a.k.a. persistent inode mark), an inode
mark could be auto created and attached to a group with a special sb
mark (we can limit a single special mark per sb).
This could be implemented similar to get_acl(), where i_fsnotify_mask
is always initialized with a special value (i.e. FS_UNINITIALIZED)
which is set to either 0 or non-zero if "security.fanotify.mask" exists.

The details of how such an API would look like are very unclear to me,
so I will try to focus on the recursive auto inode mark idea.

Thanks,
Amir.
