Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDD065DCE0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 20:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbjADTgn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 14:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239897AbjADTga (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:36:30 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E87F6
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jan 2023 11:36:29 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id n1so36542351ljg.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Jan 2023 11:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nedJwGeuyK9BaKMH/VpUsQXi9ymDa9Tca8FBMVkOEG0=;
        b=VoZaTVGUfuTHprCCRn9ywV9B4jk1ct/6ItwpC3TdoRS/77/0f3LmnC2z/4D8WEep45
         gZHfU2dRElnXYdVM6XkPth3Cj1slZodbxbL8pIP8yuQA8agGIbFqEBlbP8rQg3Vk8pYI
         ZBWEsVfAra2XcR2/TmIbcl5fFN/TIqjbyz0WLafj1/48ifwztEmeNKhVGWze6R1LS/Be
         MGAqJ0PClV6CN21OL/92uQM5fqjrLX2VQQk4VrBoQXnba8OwDMP0QqSJ7RCnQEfAEcae
         6HThB0IV9gIXUZI7Tzmp/N7+hwIO5Dmv1iiPnV3uUKzIHjcFE7SAsCYLrqfTOKIw+SB/
         AUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nedJwGeuyK9BaKMH/VpUsQXi9ymDa9Tca8FBMVkOEG0=;
        b=He4mlV3dM/smTQtXaJtYNrjhE3IZKHRP0+KiSui11ro3l98vjOJ3O3v2l3lK+PV6b6
         +VxTfaQwLH/DvKSFdnS+cAI355L2+bv5nNyumSDmpRWL7BuC06AIG28V4egXUesgwuwI
         dpsYly3lyLYcM2ILUrmLWPHbo4BWJodv4a/fuwndoGtRglzs4AZy0WqLzJbj/BlVnZd4
         rKB+0tCW/tt7uGWXNlSHdQmYI/VWH9lIAiXmkk+yzKeWFZ4plvNe5SDsbRGnMdjt9Noy
         cRMf4TorJ9ooaxjFxLD3QfNKrAOkpfuvxLQSC3wjwMsWPBgcHP5pA/xwMJjXjV38R1Q3
         /uag==
X-Gm-Message-State: AFqh2koNxmMHzrGZ960EqQYFqqvEc0LIfQd6DyILKQPuNdSNqmfAEy8t
        Mfv2lahxKTEtR7Lb8FAY+GiCcarZwO/W1m9damA=
X-Google-Smtp-Source: AMrXdXu2Pl04YEX3T3e1RXJxh8CCEYwgGZmDFkjYyk6a+Hof9IOcj3haV/qwxSEpjZV7YrBtbBKNMS/zE5GdIPtZUHQ=
X-Received: by 2002:a2e:b814:0:b0:27f:ef45:ee14 with SMTP id
 u20-20020a2eb814000000b0027fef45ee14mr1015254ljo.434.1672860987932; Wed, 04
 Jan 2023 11:36:27 -0800 (PST)
MIME-Version: 1.0
References: <CAPr0N2i3mo=SP+AdpMz=qHXejsKWs+JLTPaJVGwrzopaWOfVdA@mail.gmail.com>
 <CAOQ4uxh8c1=eBVihamhzCCAvRr38j0HCmth9ke3bo_nKsv62=A@mail.gmail.com>
 <CAPr0N2gtz79Z1fNmOc_UHjQrZfqUwzx2rJ7+4X0jFbMAAoh3-Q@mail.gmail.com> <Y7W2j0yFT3Y0GLR2@magnolia>
In-Reply-To: <Y7W2j0yFT3Y0GLR2@magnolia>
From:   Zbigniew Halas <zhalas@gmail.com>
Date:   Wed, 4 Jan 2023 20:36:16 +0100
Message-ID: <CAPr0N2hV0KOmNcu4uvoFnrVS_WcXf_DfRx3j8LACyDaDFemPBQ@mail.gmail.com>
Subject: Re: FIDEDUPERANGE claims to succeed for non-identical files
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Filipe Manana <fdmanana@kernel.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
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

On Wed, Jan 4, 2023 at 6:25 PM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Thu, Dec 22, 2022 at 03:41:30PM +0100, Zbigniew Halas wrote:
> > On Thu, Dec 22, 2022 at 9:25 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > Thanks for the analysis.
> > > Would you be interested in trying to fix the bug and writing a test?
> > > I can help if you would like.
> >
> > I can give it a try unless it turns out that some deep VFS changes are
> > required, but let's try to narrow down the reasonable API semantics
> > first.
> >
> > > It's hard to follow all the changes since
> > > 54dbc1517237 ("vfs: hoist the btrfs deduplication ioctl to the vfs")
> > > in v4.5, but it *looks* like this behavior might have been in btrfs,
> > > before the ioctl was promoted to vfs.. not sure.
> > >
> > > We have fstests coverage for the "good" case of same size src/dst
> > > (generic/136), but I didn't find a test for the non-same size src/dst.
> > >
> > > In any case, vfs_dedupe_file_range_one() and ->remap_file_range()
> > > do not even have an interface to return the actual bytes_deduped,
>
> The number of bytes remapped is passed back via the loff_t return value
> of ->remap_file_range.  If CAN_SHORTEN is set, the VFS and the fs
> implementation are allowed to reduce the @len parameter as much as they
> want.  TBH I'm mystified why the original btrfs dedupe ioctl wouldn't
> allow deduplication of common prefixes, which means that len only gets
> shortened to avoid weird problems when dealing with eof being in the
> middle of a block.
>
> (Or not, since there's clearly a bug.)
>
> > > so I do not see how any of the REMAP_FILE_CAN_SHORTEN cases
> > > are valid, regardless of EOF.
> >
> > Not sure about this, it looks to me that they are actually returning
> > the number of bytes deduped, but the value is not used, but maybe I'm
> > missing something.
> > Anyway I think there are valid cases when REMAP_FILE_CAN_SHORTEN makes sense.
> > For example if a source file content is a prefix of a destination file
> > content and we want to dedup the whole range of the source file
> > without REMAP_FILE_CAN_SHORTEN,
> > then the ioctl will only succeed when the end of the source file is at
> > the block boundary, otherwise it will just fail. This will render the
> > API very inconsistent.
>
> <nod> I'll try to figure out where the len adjusting went wrong here and
> report back.

Hey Darrick,

Len adjustment happens in generic_remap_checks, specifically here:
    if (pos_in + count == size_in &&
        (!(remap_flags & REMAP_FILE_DEDUP) || pos_out + count == size_out)) {
        bcount = ALIGN(size_in, bs) - pos_in;
    } else {
        if (!IS_ALIGNED(count, bs))
            count = ALIGN_DOWN(count, bs);
        bcount = count;
    }
the problem is that in this particular case length is set to zero, and
it makes generic_remap_file_range_prep to succeed.
I think that 2 things are needed to make this API behave reasonably:
* always use the original length for the file content comparison, not
the truncated one (there currently is also a short circuit for zero
length that skips comparison, this would need to be revisited as well)
- otherwise we may report successful deduplication, despite the ranges
being clearly different and only the truncated ranges being the same.
* report real, possibly truncated deduplication length to the userland

Cheers,
Zbigniew
