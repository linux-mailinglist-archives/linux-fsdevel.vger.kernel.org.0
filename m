Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1184E48F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 23:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237594AbiCVWLR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 18:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbiCVWLP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:11:15 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200FD2E6B9;
        Tue, 22 Mar 2022 15:09:47 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id v75so20987651oie.1;
        Tue, 22 Mar 2022 15:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bKuz828VF2fnqYJiDhQ6BxBBrI6Befe+ANMb2LWyLXY=;
        b=ZDnDdMJWQuK1ca6YkV3PDtYUPMv7B5K5vI9G1jUja55fsuCVw53EdAjkV1kEdDjYX4
         aEwZX8yMW4WDoExgNXcsaOmFpLTyNGPCmR846z8rP9EHA0hDKNICAj69qNjNSOPvZP1P
         u6f29pKTH+AwTHFAlh+XgtaTyx3wffpT9NByQH4ZUCNEl3lew1teYRSPCvM6zovHHo7z
         LE4yJCx4xGM/m9fTFOW3k3F0bbN73GeaxzX/9B+WlDZoQkrHziC0vKam7muOjx4+xRdm
         sLeNPltHCnRU0z2RSvvKfCJrSEgb0lJbuFgUC1TNN8y6Y4QCdmQffkknlFyhk3h75r03
         anSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bKuz828VF2fnqYJiDhQ6BxBBrI6Befe+ANMb2LWyLXY=;
        b=gYYzqI+x3Di8r+EN88jVdEGdofzmKVdxsf+dQTSH8Jpp6uXvubqFiCgLQvCE9WZUm6
         hT+MdxjzP1L5g/e4pdDdF5KJNQwncTtyTi5K6TfT40PmVlQ22sDsTEOYfcwfQrbUnJVm
         G9U22QUX+1cFD47lXMoiYnWdaSjkRWXE1RAG0H5MuG52WPuQszeqbkgzKdt3hX6Q7V+Q
         4XenKAhudCR3qoGC60mKOIGsJKs1loyue1NNIpr4bvC/MUzjJGdzGC93ltYyaoKhONWN
         zcDQ5ipeuE/RW9mDIqT3vlPmESVu2Kw1Vq06a8VPDcjE0XcjLf9DrUbzRAMtFbsWaVkw
         J0bg==
X-Gm-Message-State: AOAM532+OMwZcFhEHX/qYAs6X7eTUCEZrZDsc6zzfcr03XIgWHEGb265
        CbK8vyo/pUnUU3irExc/lFD5HlPIfWsxEHFt0EvEiofGV5w=
X-Google-Smtp-Source: ABdhPJw4fbgDr8owvDovV1TIhrd/gb5Uw8fQ5Ih+kAorfMegwd43bmhuMXPNkxL2bM0rImL9OgvAmSBzkIMmPUB3sqY=
X-Received: by 2002:a05:6808:23c1:b0:2da:30fd:34d9 with SMTP id
 bq1-20020a05680823c100b002da30fd34d9mr3230452oib.203.1647986986429; Tue, 22
 Mar 2022 15:09:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1647894991.git.dsterba@suse.com> <CAADWXX-uX74SETx8QNnGDyBGMJHY-6wr8jC9Sjpv4ARqUca0Xw@mail.gmail.com>
In-Reply-To: <CAADWXX-uX74SETx8QNnGDyBGMJHY-6wr8jC9Sjpv4ARqUca0Xw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 23 Mar 2022 00:09:35 +0200
Message-ID: <CAOQ4uxgfrwW1eeNtOrs338GizpQx_XFVEyBb9PvqXyvJsOvbqg@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs updates for 5.18
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Sterba <dsterba@suse.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Steve French <smfrench@gmail.com>
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

On Tue, Mar 22, 2022 at 10:11 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Mar 21, 2022 at 2:37 PM David Sterba <dsterba@suse.com> wrote:
> >
> > - allow reflinks/deduplication from two different mounts of the same
> >   filesystem
>
> So I've pulled this, and it looks ok, but I'm not getting the warm and fuzzies.
>
> In particular, I'm not seeing any commentary about different
> filesystems for this.
>
> There are several filesystems that use that ->remap_file_range()
> operation, so these relaxed rules don't just affect btrfs.
>
> Yes, yes, checking for i_sb matching does seem sensible, but I'd
> *really* have liked some sign that people checked with other
> filesystem maintainers and this is ok for all of them, and they didn't
> make assumptions about "always same mount" rather than "always same
> filesystem".
>
> This affects at least cifs, nfs, overlayfs and ocfs2.

overlayfs shouldn't have a problem with that change.

IIUC, cifs would also gain from this, because clone is implemented
on server side and even two different sb's could technically do
server side  duplicate_extents.
Same goes for nfs v4.2.

There was a lot of discussion on these aspects when cross server
(i.e. cross sb) copy was implemented not so long ago.
Relaxing cross-mnt clone is nothing compared to that.


>
> Adding fsdevel, and pointing to that
>
> -       if (src_file->f_path.mnt != dst_file->f_path.mnt)
> +       if (file_inode(src_file)->i_sb != file_inode(dst_file)->i_sb)
>
> change in commit 9f5710bbfd30 ("fs: allow cross-vfsmount reflink/dedupe")
>
> And yes, there was already a comment about "Practically, they only
> need to be on the same file system" from before that matches the new
> behavior, but hey, comments have been known to be wrong in the past
> too.

As the one who left this comment I can say it is based only on common
sense, similar to the rationale in this recent commit.
If it is any help, overlayfs has been doing cross mnt clones since
  913b86e92e1f vfs: allow vfs_clone_file_range() across mount points
I left the comment because I did not need to take responsibility for changing
user behavior at the time, but I do not see any immediate harm from the user
behavior changes now.

>
> And yes, I'm also aware that do_clone_file_range() already had that
> exact same i_sb check and it's not new, but since ioctl_file_clone()
> cheched for the mount path, I don't think you could actually reach it
> without being on the same mount.
>
> And while discussing these sanity checks: wouldn't it make sense to
> check that *both* the source file and the destination file support
> that remap_file_range() op, and it's the same op?
>
> Yes, yes, it probably always is in practice, but I could imagine some
> type confusion thing. So wouldn't it be nice to also have something
> like
>
>     if (dst_file->f_op != src_file->f_op)
>           goto out_drop_write;
>
> in there? I'm thinking "how about dedupe from a directory to a regular
> file" kind of craziness...

Both S_ISDIR and !S_ISREG cases are already checked for both clone
and dedupe on both files (twice in fact), so at least that is not a concern.

There may be other reasons to worry about, but I can't think of any.

Thanks,
Amir.
