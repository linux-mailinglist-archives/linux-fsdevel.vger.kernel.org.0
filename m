Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891B468A8A5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Feb 2023 08:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjBDHAl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Feb 2023 02:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjBDHAk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Feb 2023 02:00:40 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3F31D922
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Feb 2023 23:00:38 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id az37so3683368vkb.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Feb 2023 23:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MhhLkito86pe0hfmSz5kQ4FyDx4UK/X8nj5EpeKidb4=;
        b=UJrk85hRu8IsnE53OBVoECjEaWeocgKtmI3lwJOyBTjZwNz8B9Ttn3goS7nwl2lI8v
         zNmqJtghhZpyFMAhfJgCG6pkrpV5E3px1f2Ev/qxd4kx+ChhMbaID0wPXgPAwKd27swE
         1aqFm+9x5dk8EWYX7AWAoAh+Fnv1m3vXXjl2AG4GhRa8EEDkIpmPwE9SrhpK/F5oGTW7
         1klKgqe0CzIh9IKPdQjMd/ufJXscRSNs93Ro3AFT/CBwXp+qvbzIpbolkq6/GJ8SucHZ
         Xkpi7GeNLPWFbz4UTgYGmuS6rpR/dlbZulYOKeBIlJNIhHweWQ8/2xGG53zgTcjp3lVy
         ZsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MhhLkito86pe0hfmSz5kQ4FyDx4UK/X8nj5EpeKidb4=;
        b=xTDCKO9vM4/+n8Va7gGcwIR+UTEUqkXMMbmpwX7ablJ6nE9cno5hnL0mpnh/NJsUDS
         T/LeQLEqjoCrEEaqnBqhumbCKnuBmwSu9U1To8EIOdDw1ZYuAAcntwfwcygRMAYMeT22
         zhvnLDrUfJdCAO40Kc3i7DsfU481pW5Wg/wCqfh0+zurcYoMSYLI7gPyTVHIK+HrpWkn
         eBrPi5pYtJjsvJ+l26QUuG9j4PKmsgUjiJnrtJRscfBKNi0gQKblouemiJyfbG9fXEa+
         QhCHhrj4T5Ayl6ieyca9okpbeqCMnJoX1/Aq8i8kiEX5F5rkYyX9I/CXtYfwXTwqn/uz
         W3gg==
X-Gm-Message-State: AO0yUKV1G7vVU5A1p7slK5FMFYUoIUurNhnrCZMtjFmsd4lAJ1iJdBx7
        R+s7RfsSUK0zfVm9izEkKYYRQFpn6Yjib80l43c=
X-Google-Smtp-Source: AK7set/tQdwkKcQyiWEKgw9KHKR/HHcQzm3mQ70AVS0VboAxgfwoCaSM05rsdRj7YQkXnwrnJH/wu1BTZCyxbUaoNoc=
X-Received: by 2002:ac5:c750:0:b0:3e1:9e11:8654 with SMTP id
 b16-20020ac5c750000000b003e19e118654mr1991432vkn.3.1675494037705; Fri, 03 Feb
 2023 23:00:37 -0800 (PST)
MIME-Version: 1.0
References: <CAPr0N2i3mo=SP+AdpMz=qHXejsKWs+JLTPaJVGwrzopaWOfVdA@mail.gmail.com>
 <CAOQ4uxh8c1=eBVihamhzCCAvRr38j0HCmth9ke3bo_nKsv62=A@mail.gmail.com>
 <CAPr0N2gtz79Z1fNmOc_UHjQrZfqUwzx2rJ7+4X0jFbMAAoh3-Q@mail.gmail.com>
 <Y7W2j0yFT3Y0GLR2@magnolia> <CAPr0N2hV0KOmNcu4uvoFnrVS_WcXf_DfRx3j8LACyDaDFemPBQ@mail.gmail.com>
 <Y93BkIA4Nd3IJAk+@magnolia>
In-Reply-To: <Y93BkIA4Nd3IJAk+@magnolia>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 4 Feb 2023 09:00:25 +0200
Message-ID: <CAOQ4uxgrc0oCuEvAmioQBeX=RZW3eXA5vA-2WTR6XfDt1S3Zjg@mail.gmail.com>
Subject: Re: FIDEDUPERANGE claims to succeed for non-identical files
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Zbigniew Halas <zhalas@gmail.com>,
        Filipe Manana <fdmanana@kernel.org>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
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

On Sat, Feb 4, 2023 at 4:23 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Wed, Jan 04, 2023 at 08:36:16PM +0100, Zbigniew Halas wrote:
> > On Wed, Jan 4, 2023 at 6:25 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > >
> > > On Thu, Dec 22, 2022 at 03:41:30PM +0100, Zbigniew Halas wrote:
> > > > On Thu, Dec 22, 2022 at 9:25 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > >
> > > > > Thanks for the analysis.
> > > > > Would you be interested in trying to fix the bug and writing a test?
> > > > > I can help if you would like.
> > > >
> > > > I can give it a try unless it turns out that some deep VFS changes are
> > > > required, but let's try to narrow down the reasonable API semantics
> > > > first.
> > > >
> > > > > It's hard to follow all the changes since
> > > > > 54dbc1517237 ("vfs: hoist the btrfs deduplication ioctl to the vfs")
> > > > > in v4.5, but it *looks* like this behavior might have been in btrfs,
> > > > > before the ioctl was promoted to vfs.. not sure.
> > > > >
> > > > > We have fstests coverage for the "good" case of same size src/dst
> > > > > (generic/136), but I didn't find a test for the non-same size src/dst.
> > > > >
> > > > > In any case, vfs_dedupe_file_range_one() and ->remap_file_range()
> > > > > do not even have an interface to return the actual bytes_deduped,
> > >
> > > The number of bytes remapped is passed back via the loff_t return value
> > > of ->remap_file_range.  If CAN_SHORTEN is set, the VFS and the fs
> > > implementation are allowed to reduce the @len parameter as much as they
> > > want.  TBH I'm mystified why the original btrfs dedupe ioctl wouldn't
> > > allow deduplication of common prefixes, which means that len only gets
> > > shortened to avoid weird problems when dealing with eof being in the
> > > middle of a block.
> > >
> > > (Or not, since there's clearly a bug.)
> > >
> > > > > so I do not see how any of the REMAP_FILE_CAN_SHORTEN cases
> > > > > are valid, regardless of EOF.
> > > >
> > > > Not sure about this, it looks to me that they are actually returning
> > > > the number of bytes deduped, but the value is not used, but maybe I'm
> > > > missing something.
> > > > Anyway I think there are valid cases when REMAP_FILE_CAN_SHORTEN makes sense.
> > > > For example if a source file content is a prefix of a destination file
> > > > content and we want to dedup the whole range of the source file
> > > > without REMAP_FILE_CAN_SHORTEN,
> > > > then the ioctl will only succeed when the end of the source file is at
> > > > the block boundary, otherwise it will just fail. This will render the
> > > > API very inconsistent.
> > >
> > > <nod> I'll try to figure out where the len adjusting went wrong here and
> > > report back.
> >
> > Hey Darrick,
> >
> > Len adjustment happens in generic_remap_checks, specifically here:
> >     if (pos_in + count == size_in &&
> >         (!(remap_flags & REMAP_FILE_DEDUP) || pos_out + count == size_out)) {
> >         bcount = ALIGN(size_in, bs) - pos_in;
> >     } else {
> >         if (!IS_ALIGNED(count, bs))
> >             count = ALIGN_DOWN(count, bs);
> >         bcount = count;
> >     }
> > the problem is that in this particular case length is set to zero, and
> > it makes generic_remap_file_range_prep to succeed.
> > I think that 2 things are needed to make this API behave reasonably:
> > * always use the original length for the file content comparison, not
> > the truncated one (there currently is also a short circuit for zero
> > length that skips comparison, this would need to be revisited as well)
> > - otherwise we may report successful deduplication, despite the ranges
> > being clearly different and only the truncated ranges being the same.
> > * report real, possibly truncated deduplication length to the userland
>
> I was about to send in a patch when git blame told me that Linus was the
> last person to change the last line of this chunk:
>
>                 deduped = vfs_dedupe_file_range_one(file, off, dst_file,
>                                                     info->dest_offset, len,
>                                                     REMAP_FILE_CAN_SHORTEN);
>                 if (deduped == -EBADE)
>                         info->status = FILE_DEDUPE_RANGE_DIFFERS;
>                 else if (deduped < 0)
>                         info->status = deduped;
>                 else
>                         info->bytes_deduped = len;
>
> And then I remembered that I had totally repressed my entire memory of
> this unpleasant discussion wherein I got the short end of the stick not
> because I'd designed the weird btrfs ioctl that eventually became
> FIDEDUPERANGE but because I was the last person to make any real
> changes:
> https://lore.kernel.org/all/a7c93559-4ba1-df2f-7a85-55a143696405@tu-darmstadt.de/
>
> Originally, btrfs returned the request length, but also didn't do any
> checking or operation length reduction to prevent people from remapping
> a partial EOF block into the middle of a file:
> https://elixir.bootlin.com/linux/v3.19/source/fs/btrfs/ioctl.c#L3018
>
> Dave and I spent a long time adapting XFS to this interface and hoisted
> the generic(ish) parts of the btrfs code to the VFS.  The VFS support
> code returned the number of bytes remapped, though at that point either
> the original request succeeded or it didn't, even if doing so set up
> data corruption:
> https://elixir.bootlin.com/linux/v4.5/source/fs/read_write.c#L1655
>
> Miklos went and committed this change containing no description of why
> it was made.  This patch (AFAICT) was never sent to fsdevel and does not
> seem to have been reviewed by anybody.  The patch sets up the current
> broken behavior where the kernel can dedupe fewer bytes than was asked
> for, yet return the original request length:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5740c99e9d30b81fcc478797e7215c61e241f44e
>
> Five months later I noticed and fixed the problems with remapping
> partial eof blocks into the middle of files and fixed it, but none of us
> noticed there was a logic bomb lurking in bytes_deduped:
> https://lore.kernel.org/linux-fsdevel/153981625504.5568.2708520119290577378.stgit@magnolia/
>
> A different person wrote a test for sub-block dedupe, but even he failed
> to notice the broken behavior:
> https://lore.kernel.org/fstests/20181105111445.11870-1-fdmanana@kernel.org/
>
> Four years later (last summer), someone produced an attempt to fix this
> particular weird discrepancy:
> https://lore.kernel.org/all/b5805118-7e56-3d43-28e9-9e0198ee43f3@tu-darmstadt.de/
>
> Which then Dave asked for a revert because it broke generic/517:
> https://lore.kernel.org/all/20220714223238.GH3600936@dread.disaster.area/
>
> Since then, AFAICT there's been no followup to "We just need a bit of
> time to look at the various major dedupe apps and check that they still
> do the right thing w.r.t. proposed change."  The manpage for
> FIDEDUPERANGE says that bytes_deduped contains the number of bytes
> actually remapped, but that doesn't matter because Linus only cares
> about past kernel behavior.  That behavior is now a mess, since every
> LTS kernel since 4.19 has been over-reporting the number of bytes
> deduped.
>

Wow! What a story.

> Unfortunately, while *I* think the correct behavior is to report bytes
> remapped even if that quantity becomes zero due to alignment issues, we
> can't report zero here because duperemove will go into an infinite loop
> because the author did the usual "len += bytes_deduped" without checking
> for a zero length.  This causes generic/561 to run forever.  One could
> argue that we could return "extents differ" in that case, but then that
> breaks generic/517 and generic/182 which aren't expecting that behavior
> either.

But the bug report that started this thread is not about reporting actual vs.
requested dedupe size - it is about reporting that data in two ranges is the
same when it really differs - that could lead to very real data corruption.

Can we solve that by passing the requested len (and not the shotend len)
to {vfs,dax}_dedupe_file_range_compare() and then go on actually deduping
only the shortened len? (or return in case of shortened len == 0).

It does not look like this would break neither generic/517 nor generic/182
unless I am missing something?

>
> It's probably just time for us to just burn FIEDEDUPERANGE to the ground
> and for me to convert another of my other hobbies into my profession.
>

Have you considered a git historian career for retirement? ;)

Thanks,
Amir.
