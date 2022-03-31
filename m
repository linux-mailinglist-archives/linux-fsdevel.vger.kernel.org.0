Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AF94EDE96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 18:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239802AbiCaQVF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 12:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236949AbiCaQVE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:21:04 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1677C4FC6A;
        Thu, 31 Mar 2022 09:19:17 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id f10so55287plr.6;
        Thu, 31 Mar 2022 09:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e0NFNphMTbvRB/765QGz3uyh4+0CVJNMU42wWED3gHw=;
        b=ppkMkJUfBVW5IXqmk/6Fy7slITNic79UZe8uMRhsKhkDhB71elc7viX+X8U3cSVeiD
         tB5VhodXsSSmhkjfsSp9gyOGF6cf40mcBfNdbaJbiArfGXJXHioj8dAOFfHUvkka2HPS
         Ie3ZorhG4+thZYNaHTD6K2gBoBAQTBwXPZrCPhtHTZoJGVsovS2K4cLi/K2y9Uqqu6AU
         Fy32YEH40/oUt+PhvhGmjhnQGGNWF+No05tLPQpcTVqWNWyDRqoOKWzw9UuKaVEMUtfu
         64m+g+7UxgLm2Stjm1v4mMcRgZwqXXipbprsEsFrP08NYvbEd6jqOKeFfyVZ0kCyU4/q
         ZYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e0NFNphMTbvRB/765QGz3uyh4+0CVJNMU42wWED3gHw=;
        b=8MgKC/klHgWoK0Gfe9yn+7WGvzttsTDpmhFnKcv/zkB3ksAc2HkH8+6z4s5NMdSztP
         sWpJrqwysw08LSGdF2dE7TCccp7aN8/jKVBfjQxmFEzHA8h2EKMJzkX6QFhXYId9Un6M
         SYruMc0HvsX1P9cQLtHbPsuBMT1omPj2KczHacj8RcejmYl/9/Dx49TzisL4f7kG3MRy
         VY04turJ9I+LkcdBNfb1qIP6P5HKQVbY8zJmeKX/TTwkOssxZt7y7XROsNlBsJec6d7+
         pxlRIRf8y17fe37OGAb6AZU4SQyXgU5xx2vIYdRIYkmOk8eSt9lguBE/PTnHAFzzLUmQ
         TANA==
X-Gm-Message-State: AOAM530xS6EuUVkKCXuRwwuw6mbVrsSWOPh3bY+LCM95yEATMQfEPA54
        FmLwT+uKmhR/MLegI4zqCGf8ll1TNPY=
X-Google-Smtp-Source: ABdhPJz9DpufEwS9SHBX1qyXs9D0itEAUu4Oz+WMVPPksj/GmIl0QcDB9sx12JJS9f7Szuru/AgFJQ==
X-Received: by 2002:a17:90b:895:b0:1c7:9367:c3ea with SMTP id bj21-20020a17090b089500b001c79367c3eamr6929207pjb.92.1648743556356;
        Thu, 31 Mar 2022 09:19:16 -0700 (PDT)
Received: from localhost ([2406:7400:63:7e03:b065:1995:217b:6619])
        by smtp.gmail.com with ESMTPSA id u17-20020a056a00159100b004faef351ebcsm25671661pfk.45.2022.03.31.09.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 09:19:15 -0700 (PDT)
Date:   Thu, 31 Mar 2022 21:49:11 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCHv3 0/4] generic: Add some tests around journal
 replay/recoveryloop
Message-ID: <20220331161911.7d5dlqfwm2kngnjk@riteshh-domain>
References: <cover.1648730443.git.ritesh.list@gmail.com>
 <20220331145906.2onnohv2bbg3ye6j@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331145906.2onnohv2bbg3ye6j@zlang-mailbox>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/03/31 10:59PM, Zorro Lang wrote:
> On Thu, Mar 31, 2022 at 06:24:19PM +0530, Ritesh Harjani wrote:
> > Hello,
>
> Hi,
>
> Your below patches looks like not pure text format, they might contain
> binary character or some special characers, looks like the "^M" [1].

Ohh, is it. Might be some settings needed to be tweaked for using
gmail for community patches.

>
> So please check how you generate/edit/send these patches, make sure
> they're pure text for Linux then send again.

Sure Zorro, I will check it again at my end. However, when I tried using
b4 am -o - cover.1648730443.git.ritesh.list@gmail.com | git am

It worked fine for me and applied all 4 patches to my local tree.

I also didn't notice any of such characters in my other inbox
("riteshh@in.ibm.com"), which was cc'd too. hmm, strange.

Sure, I will check it once again at my end and resend this.

-ritesh


>
> Thanks,
> Zorro
>
>
> [1]
> # cat -A /path/to/your_patch
> index 95752d3b..5e73cff9 100755^M$
> --- a/tests/generic/468^M$
> +++ b/tests/generic/468^M$
> @@ -34,6 +34,13 @@ _scratch_mkfs >/dev/null 2>&1^M$
>  _require_metadata_journaling $SCRATCH_DEV^M$
>  _scratch_mount^M$
>  ^M$
> +# blocksize and fact are used in the last case of the fsync/fdatasync test.^M$
> +# This is mainly trying to test recovery operation in case where the data^M$
> +# blocks written, exceeds the default flex group size (32768*4096*16) in ext4.^M$
> +blocks=32768^M$
> +blocksize=4096^M$
> +fact=18^M$
> +^M$
> ...
> ...
>
> >
> > The ext4 fast_commit kernel fix has landed into mainline tree [1].
> > In this v3, I have addressed review comments from Darrick.
> > Does this looks good to be picked up?
> >
> > I have tested ext4 1k, 4k (w & w/o fast_commit). Also tested other FS with
> > default configs (like xfs, btrfs, f2fs). No surprises were seen.
> >
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bfdc502a4a4c058bf4cbb1df0c297761d528f54d
> >
> > -ritesh
> >
> > Changelogs:
> > ===========
> >
> > v2 => v3
> > =========
> > 1. Addressed review comments from Darrick.
> > 2. Rebased to latest master.
> >
> > v1 => v2
> > =========
> > Sending v2 with tests/ext4/ converted to tests/generic/
> > (although I had not received any review comments on v1).
> > It seems all of the tests which I had sent in v1 are not ext4 specific anyways.
> > So in v2, I have made those into tests/generic/.
> >
> > Summary
> > =========
> > These are some of the tests which when tested with ext4 fast_commit feature
> > w/o kernel fixes, could cause tests failures and/or KASAN bug (generic/486).
> >
> > I gave these tests a run with default xfs, btrfs and f2fs configs (along with
> > ext4). No surprises observed.
> >
> > [v2]: https://lore.kernel.org/all/cover.1647342932.git.riteshh@linux.ibm.com/
> > [v1]: https://lore.kernel.org/all/cover.1644070604.git.riteshh@linux.ibm.com/
> >
> >
> > Ritesh Harjani (4):
> >   generic/468: Add another falloc test entry
> >   common/punch: Add block_size argument to _filter_fiemap_**
> >   generic/678: Add a new shutdown recovery test
> >   generic/679: Add a test to check unwritten extents tracking
> >
> >  common/punch          |  9 +++---
> >  tests/generic/468     |  8 +++++
> >  tests/generic/468.out |  2 ++
> >  tests/generic/678     | 72 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/678.out |  7 +++++
> >  tests/generic/679     | 65 ++++++++++++++++++++++++++++++++++++++
> >  tests/generic/679.out |  6 ++++
> >  7 files changed, 165 insertions(+), 4 deletions(-)
> >  create mode 100755 tests/generic/678
> >  create mode 100644 tests/generic/678.out
> >  create mode 100755 tests/generic/679
> >  create mode 100644 tests/generic/679.out
> >
> > --
> > 2.31.1
> >
>
