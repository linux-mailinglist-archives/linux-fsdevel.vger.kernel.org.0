Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A444FAE64
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Apr 2022 17:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240116AbiDJPOK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Apr 2022 11:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiDJPOH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Apr 2022 11:14:07 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD2913E2A
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Apr 2022 08:11:56 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id c1so1570604qke.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Apr 2022 08:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t33LvskK9pGNs38fGUKKrowbgorYZtmjTOq7nZ1LoEc=;
        b=RnrllopOs3DkyWioDg6eckEIqOM7GtUtwQ1L7PPx0jzDt4k9QKLNX1TrWgGts4MADB
         SegYzdqGMkMOA8fz1K2VOZhRmhtaRyOAmW9apUa2qoSh1EjcCnwxo+kdU+Omkgy8sbz/
         bNH2uLJb++5W0BbrwWAw07DH7uE0kB0z8xUJN+/hDG2xPrvTQzUJWHcqGRmEhIgruUHw
         tRkfjqRlXVN2qZRGlJFsb4H8lUUIWZgRbFxZMVc2ZU02GrmZciddWvq33hK9fgKkd0ed
         P71CWoPSjIvZ9mrV5MNgtZ1t/NTNK+XlEs8CmqOtndOhPcTSnM9vBO1dptFzPjwCwDl2
         Hsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t33LvskK9pGNs38fGUKKrowbgorYZtmjTOq7nZ1LoEc=;
        b=jkve73HcQkUGz8/cEQVSOnc0uJrOFpHrgTWGDgCGy86TfzKYkgmRzh53ubO7FqSmlb
         trh8j6j8fVX4aAJAIBDQYX38e1M+5IUy3+ZZczRHoexh/G9Y/sX5HLzGwQyID7eIHpex
         Ad4wL85CP6MjKWuUH4yFpFzUuc0Be0VzHDJd8b9PhDSJWw4U4tdDnaO1GbIoTGXtoyPZ
         XOweQDbSQ63IAKY1awnKv19SVOjT8vyMr4WSZ8KvkbNdpXQWmKP6SY0VKPDeKnsqRsit
         WCz6AcgFV2tm0ZCCCjJKiUXjbuaFOqYTFZ1JyrihadhME5JCB03WmVbxw++lV3g5fulW
         REEQ==
X-Gm-Message-State: AOAM530J+J/7PNCOqfUTjy3SLkXcM7obzPLdqmj8OeusxFJlyBboJ9f2
        bmqZV1BlB0GvDJPc6pjzUNcv5Ye6qPw8B1D2G2c=
X-Google-Smtp-Source: ABdhPJwqP8ZErKHbxqDOLRjrME2nM4vQKfW5lYkC8HC43d4/v88muBz7s++NHbywi0Gf4bh3dsSdOZg4oc52AorXf8w=
X-Received: by 2002:a05:620a:1aa6:b0:680:ca4b:461c with SMTP id
 bl38-20020a05620a1aa600b00680ca4b461cmr18929059qkb.19.1649603516006; Sun, 10
 Apr 2022 08:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190212170012.GF69686@sasha-vm> <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
 <YicrMCidylefTC3n@kroah.com> <YieG8rZkgnfwygyu@mit.edu> <CAOQ4uxjvwKRAWZRZy53PW2H_BrC1ufThX4ps0HOHYZ4xgXjPrA@mail.gmail.com>
In-Reply-To: <CAOQ4uxjvwKRAWZRZy53PW2H_BrC1ufThX4ps0HOHYZ4xgXjPrA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 10 Apr 2022 18:11:44 +0300
Message-ID: <CAOQ4uxjL8-ZmbBWNKV3P985sUVXU5fFbeRpiaXL+ckFaWD5Hfg@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
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

On Tue, Mar 29, 2022 at 11:24 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Mar 8, 2022 at 6:40 PM Theodore Ts'o <tytso@mit.edu> wrote:
> >
> > On Tue, Mar 08, 2022 at 11:08:48AM +0100, Greg KH wrote:
> > > > When one looks at xfstest bug reports on the list for xfs on kernels > v4.19
> > > > one has to wonder if using xfs on kernels v5.x.y is a wise choice.
> > >
> > > That's up to the xfs maintainers to discuss.
> > >
> > > > Which makes me wonder: how do the distro kernel maintainers keep up
> > > > with xfs fixes?
> > >
> > > Who knows, ask the distro maintainers that use xfs.  What do they do?
> >
> > This is something which is being worked, so I'm not sure we'll need to
> > discuss the specifics of the xfs stable backports at LSF/MM.  I'm
> > hopeful that by May, we'll have come to some kind of resolution of
> > that topic.
> >
> > One of my team members has been working with Darrick to set up a set
> > of xfs configs[1] recommended by Darrick, and she's stood up an
> > automated test spinner using gce-xfstests which can watch a git branch
> > and automatically kick off a set of tests whenever it is updated.
> > Sasha has also provided her with a copy of his scripts so we can do
> > automated cherry picks of commits with Fixes tags.  So the idea is
> > that we can, hopefully in a mostly completely automated fashion,
>
> Here is a little gadget I have been working on in my spare time,
> that might be able to assist us in the process of selecting stable
> patch candidates.
>
> Many times, the relevant information for considering a patch for
> stable tree is in the cover letter of the patch series. It is also a lot
> more efficient to skim over 23 cover letter subjects than it is to skim
> over 103 commits of the xfs pull request for 5.15 [2].
>
> I've added the command "b4 rn" [1] to produce a list of lore links
> to patch series from a PULL request to Linus.
>
> This gadget could be improved to interactively select the patch
> series from within a PR to be saved into an mbox.
>
> In any case, I do intend to start surveying the xfs patches that got
> merged since v5.10 and stage a branch with my own selections, so we
> will be able to compare my selections to Shasha's AUTOSEL selections.
>

FYI, I've enhanced the "br rn" gadget to report fstests that were mentioned
on ML discussions on the patch sets, for example:
--
- [PATCH 1/3] mm: Add kvrealloc()
  [https://lore.kernel.org/r/20210714023440.2608690-2-david@fromorbit.com]
  Tests: generic/040 generic/041
--

This can help to understand if some fstests failure seen on LTS baseline
run may already have a fix upstream that could be backported.

You can see example release notes for XFS v5.10..v5.17 [1] and the
subset of fixes [2] manually selected for my 5.10.y backport branch [3].

I am working with Luis so start testing these backports with his
kdevops [4] framework.

Thanks,
Amir.

[1] https://github.com/amir73il/b4/blob/xfs-5.10.y/xfs-5.10..5.17-rn.rst
[2] https://github.com/amir73il/b4/blob/xfs-5.10.y/xfs-5.10..5.17-fixes.rst
[3] https://github.com/amir73il/linux/commits/xfs-5.10.y
[4] https://github.com/mcgrof/kdevops
