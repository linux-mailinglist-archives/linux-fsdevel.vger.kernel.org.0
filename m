Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E404DB140
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 14:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356394AbiCPNWT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 09:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356452AbiCPNWJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:22:09 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322342BB34
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Mar 2022 06:20:42 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 17-20020a9d0611000000b005b251571643so1412142otn.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Mar 2022 06:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U6KqhFI4KMB+IC4qnRY9p1qx52so3v0/vbNiuaSJcBU=;
        b=fGcqbVpIyaQkjWbqegI/d4IWXhgG/WXl2VePWV6+DOwGU+SxhUleeweGi14nWvmQmj
         u0ECs3Pwraag0HsQLSL3WySqkhQoq/1dZXPu3HIxzgZtPKQ+c8Q/DsmTv0YWkF/9lt12
         4DafMzJTDh6BYqysIlI6+dlMjeLQwwWS6DrqqmupAOCwtFQgaDAuLBJplsnuwo7QAUhl
         NDO3TJFGP9NlYijiceLhOdFVuQ7BHeWOLdgOR19W2t6p1pXbBCw0dP/b6nbK0SWZn+qn
         hKrLxOyY5x6TL91bTJlQxIJEG7FEAIWGyBqFaBNjthP9w7sdOYLsdVnZKSk89USCGH7u
         NN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U6KqhFI4KMB+IC4qnRY9p1qx52so3v0/vbNiuaSJcBU=;
        b=Q8B5tXCp0CmPywC8SXWnoi009C475MMmIProI+ro6rmAxwafaSmnTe07WMbP/lwa11
         cfWk85MSin8pYjoI2EjaoYMMavtGD9xpVGkHoNY+WJqzwwwBs9oqIY5nuN/WcaRSPRxl
         XNwzT5Y44pPvAey4jlZ0LeKs/+YK3G3fHFIf00BTKk9Et4udub0aGTlzOa/htwKu/99n
         oyAHtYEyI8VFdavcfNDMT5NF5t8fvN1AjNAjJcd5IWz4qvm0dCbvgAHdmTcOt8kwyOxY
         NnLCepcElGx7z/4rOsycUcC9YTXiZARQzkoIfr0qGvYESLLYdOw0L8sV7oJSOBtFMYR+
         biYw==
X-Gm-Message-State: AOAM533Il4NUhjfZlI/Jr0gLXxu8MECylonm6aPLPimK816SpvMJcraP
        ZX3EqiKIGnP9BcNuaye0mrwVj2w9V1jtjviATXI=
X-Google-Smtp-Source: ABdhPJxGuk0eW/dqMYYgE9/LCc4QA9Z6XmT+3sd7Rnl4CVZYg4axvRP/W0PMfCR4rGvk3Irf6IZ4KRTJaKhaBdxU0Bo=
X-Received: by 2002:a9d:5cc8:0:b0:5b2:35ae:7ad6 with SMTP id
 r8-20020a9d5cc8000000b005b235ae7ad6mr13999852oti.275.1647436841455; Wed, 16
 Mar 2022 06:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <1357949524.990839.1647084149724.ref@mail.yahoo.com>
 <1357949524.990839.1647084149724@mail.yahoo.com> <20220314084706.ncsk754gjywkcqxq@quack3.lan>
 <CAOQ4uxiDubhONM3w502anndtbqy73q_Kt5bOQ07zbATb8ndvVA@mail.gmail.com> <20220316115632.khj6m4npjrjviimi@quack3.lan>
In-Reply-To: <20220316115632.khj6m4npjrjviimi@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 16 Mar 2022 15:20:30 +0200
Message-ID: <CAOQ4uxj9wxwgaR3KHxtRAg7+tcfygko4OTw8Hh9J8PLTnO-oBQ@mail.gmail.com>
Subject: Re: Fanotify Directory exclusion not working when using FAN_MARK_MOUNT
To:     Jan Kara <jack@suse.cz>
Cc:     Srinivas <talkwithsrinivas@yahoo.co.in>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 16, 2022 at 1:56 PM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 14-03-22 11:28:23, Amir Goldstein wrote:
> > On Mon, Mar 14, 2022 at 10:47 AM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Sat 12-03-22 11:22:29, Srinivas wrote:
> > > > If a  process calls fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT=
,
> > > > FAN_OPEN_PERM, 0, "/mountpoint") no other directory exclusions can =
be
> > > > applied.
> > > >
> > > > However a path (file) exclusion can still be applied using
> > > >
> > > > fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_IGNORED_MASK |
> > > > FAN_MARK_IGNORED_SURV_MODIFY, FAN_OPEN_PERM | FAN_CLOSE_WRITE, AT_F=
DCWD,
> > > > "/tmp/fio/abc");  =3D=3D=3D> path exclusion that works.
> > > >
> > > > I think the directory exclusion not working is a bug as otherwise A=
V
> > > > solutions cant exclude directories when using FAN_MARK_MOUNT.
> > > >
> > > > I believe the change should be simple since we are already supporti=
ng
> > > > path exclusions. So we should be able to add the same for the direc=
tory
> > > > inode.
> > > >
> > > > 215676 =E2=80=93 fanotify Ignoring/Excluding a Directory not workin=
g with
> > > > FAN_MARK_MOUNT (kernel.org)
> > >
> > > Thanks for report! So I believe this should be fixed by commit 4f0b90=
3ded
> > > ("fsnotify: fix merge with parent's ignored mask") which is currently
> > > sitting in my tree and will go to Linus during the merge (opening in =
a
> > > week).
> >
> > Actually, in a closer look, that fix alone is not enough.
> >
> > With the current upstream kernel this should work to exclude events
> > in a directory:
> >
> > fanotify_mark(fd, FAN_MARK_ADD, FAN_EVENT_ON_CHILD |
> >                        FAN_OPEN_PERM | FAN_CLOSE_WRITE,
> >                        AT_FDCWD, "/tmp/fio/");
> > fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_IGNORED_MASK |
> >                        FAN_MARK_IGNORED_SURV_MODIFY,
> >                        FAN_OPEN_PERM | FAN_CLOSE_WRITE,
> >                        AT_FDCWD, "/tmp/fio/");
>
> Thinking about this again, it could also be considered a bug (although
> convenient at times ;), that in current upstream kernel this combination =
of
> marks results in ignoring the OPEN_PERM & CLOSE_WRITE events on children =
of
> /tmp/fio, couldn't it? We probably should not consider the parent's ignor=
e
> mask for events on children to maintain compatibility with older kernels?
> In theory it could bite someone unexpectedly...
>
> And to enable this convenient functionality we should rather introduce th=
e
> new bit we've discussed. What do you think?
>

I kind of made this "convenient bug" public on several occasions.
Considering how useful this bug is, I think it is more likely that someone
will be bit by "fixing" the "bug" in a stable kernel that is it likely for
someone to be bit by the "bug".

Also, if taking away the "convenient bug" from stable kernels without
providing the new API is not very fair. and making sure that the "bug fix"
is not backported to any stable kernel is not sustainable.

IOW, I do not see good coming from changing behavior now.
We can document that behavior of ON_CHILD/ONDIR in ignored mask
is "undefined" and then make the behavior defined with a new
FAN_MARK_IGNORED_MASK_* flag.

Thanks,
Amir.
