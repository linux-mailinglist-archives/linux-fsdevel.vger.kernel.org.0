Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BB74E618A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Mar 2022 11:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349407AbiCXKMl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Mar 2022 06:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349354AbiCXKMk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Mar 2022 06:12:40 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17513A0BC0;
        Thu, 24 Mar 2022 03:11:09 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id k25-20020a056830151900b005b25d8588dbso2948304otp.4;
        Thu, 24 Mar 2022 03:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S+w5gQeWrpb/XbqkaI0BNbmlQiC1qWCEcAULViUkDF4=;
        b=UuAlTa02hJYOlFS+gD4t++HAdmJo2ODYTrKaQqD5kqH7Xact6W0VT+lkcKstNg3WPq
         rjD4ESaZGyY4lC0b8TaelNWAZpc+WXAamWMxzKMrZhlDHGH1Sl7m7UEJlx3kj8iupzBq
         fUVJIdnPD9UC6xhwViaMU8HJDvIGBbjbBnOtloVB4MTgMy+4Oa0CkrOgUmC4ifBAmKrd
         mB1f9hKjdut3hkTPUT863E1u3uOwfDXwIrhYXYYU//fIKnkYvOPKRAbIBMWHF/zU3bwF
         5yrezpFA95i1uNcngrt/P+LMIDFFZOXTtXCl8C02XlS+PSZFkWh8sEqVgYKTr88jmHiF
         523Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S+w5gQeWrpb/XbqkaI0BNbmlQiC1qWCEcAULViUkDF4=;
        b=GZ075ZI0+hSJrTXKd55HWqr8pXP4pcdzUltCbXwCEDzATQofQGV1GOQHasvzUPm68L
         Nn2NbB6KqRr3yiiZ6eSiup+cmYN8v4zeyi7KcxtN+h+0f6l0uXk2SYXJvKawoKhwauRy
         ZLHiESvTe7Qcznp6cVIn40NuryRmHqsOqQeY9NR0Mz8yjIDN213ahPltw3KhCwcEPDTk
         JEaEdTty+UXsnpYOqK4Km+LUnTh5iVUQyiLbrnkea+5czWfhXfQQ6s5tCHQoXPxiBKXH
         onihfdsY0XHKK24yUdvefOky9fNtNiRM1mkh5oX+0MD/ogxqHbSJxhhEUDZqo9E5XXpo
         DpAQ==
X-Gm-Message-State: AOAM533mtCV6BSaCE5u6bsyzcyIob9oo4Zmbr6R52O78qfWcT3tdlDTk
        B1gXdBCK3ZcHEaSedMnuNzPfyWU+UdiaOS2FE6hqroS834Q=
X-Google-Smtp-Source: ABdhPJzU1+OD5UkRqIzwow6OKyn6w/fDLznCKTx2tFUwkDnoAsQ30/1TOVtoypACpsI6vCc/p6rEOTJtV/8/31tZIw8=
X-Received: by 2002:a9d:5cc8:0:b0:5b2:35ae:7ad6 with SMTP id
 r8-20020a9d5cc8000000b005b235ae7ad6mr1658484oti.275.1648116668030; Thu, 24
 Mar 2022 03:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1647894991.git.dsterba@suse.com> <CAADWXX-uX74SETx8QNnGDyBGMJHY-6wr8jC9Sjpv4ARqUca0Xw@mail.gmail.com>
 <Yjo3tQO+fNNlZ4/i@localhost.localdomain> <20220322211935.GC8182@magnolia>
In-Reply-To: <20220322211935.GC8182@magnolia>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 24 Mar 2022 12:10:56 +0200
Message-ID: <CAOQ4uxjNqNxF6YQK7Euo9qCg3sTHrWESw+H_G0c8QaXFDQhGRA@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs updates for 5.18
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
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

On Thu, Mar 24, 2022 at 1:35 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Tue, Mar 22, 2022 at 04:55:17PM -0400, Josef Bacik wrote:
> > On Tue, Mar 22, 2022 at 11:23:21AM -0700, Linus Torvalds wrote:
> > > On Mon, Mar 21, 2022 at 2:37 PM David Sterba <dsterba@suse.com> wrote:
> > > >
> > > > - allow reflinks/deduplication from two different mounts of the same
> > > >   filesystem
> > >
> > > So I've pulled this, and it looks ok, but I'm not getting the warm and fuzzies.
> > >
> > > In particular, I'm not seeing any commentary about different
> > > filesystems for this.
> > >
> > > There are several filesystems that use that ->remap_file_range()
> > > operation, so these relaxed rules don't just affect btrfs.
> > >
> > > Yes, yes, checking for i_sb matching does seem sensible, but I'd
> > > *really* have liked some sign that people checked with other
> > > filesystem maintainers and this is ok for all of them, and they didn't
> > > make assumptions about "always same mount" rather than "always same
> > > filesystem".
> > >
> >
> > > This affects at least cifs, nfs, overlayfs and ocfs2.
> >
> > I had a talk with Darrick Wong about this on IRC, and his Reviewed-by is on the
> > patch.  This did surprise nfsd when xfstests started failing, but talking with
> > Bruce he didn't complain once he understood what was going on.
>
> FWIW, I remember talking about this with Bruce and (probably Anna too)
> during a hallway BOF at the last LSFMMBPFBBQ that I went to, which was
> 2018(?)  At the time, I think we resolved that nfs42_remap_file_range
> was capable of detecting and dealing with unsupported requests, so a
> direct comparison of the ->remap_file_range or ->f_op wasn't necessary
> for them.
>
> > Believe me I
> > have 0 interest in getting the other maintainers upset with me by sneaking
> > something by them, I made sure to run it by people first, tho I probably should
> > have checked with people directly other than Darrick.
>
> I /am/ a little curious what Steve French has to say w.r.t CIFS.
>
> AFAICT overlayfs passes the request down to the appropriate fs
> under-layer, so its correctness mostly depends on the under-layer's
> implementation.  But I'll let Amir or someone chime in on that. ;)
>

The thing is, overlayfs ALREADY does cross-mnt clone_file_range()
on underlying layers. So if there was a bug with allowing cross mnt
clones on xfs it would have been in the wild for a long time already.

OTOH, overlayfs doesn't support nfs/cifs/ocfs2 as upper fs.

If you mount an overlay with lower and upper layer on the same
xfs/btrfs sb the original mnt of lower path and upper patch is irrelevant.

Overlayfs uses different private mnt per layer anyway, so if the source
file is on lower layer then even if originally the overlay mount was done
with different upper/lower mounts of the same sb, clone via overlayfs
would work.

Allowing cross overlayfs mount clone makes very little difference.

Thanks,
Amir.
