Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772FC57BF13
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 22:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiGTUL5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 16:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiGTULv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 16:11:51 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42B56D55A;
        Wed, 20 Jul 2022 13:11:37 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id m30so7444466vkl.4;
        Wed, 20 Jul 2022 13:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iJiq0GN/fT31bSbr6oSGyoX3W9d2NQyN8PKQd1yXMAw=;
        b=mqMGsUj9uK8k8/wVLR67MI1YzVOH2veL57rSYZvQJIJLBhDNmgHYAWNqjIDcOWwePk
         60VK4YvYyjtAgZl1TkDVaDIhGVV8JDHwhHEQJGua9DRvHw0vnhb7OancY7UNN6W43KOG
         DldSmFRYvpvAtO6qs8sFBNyY3pUDFtDlV69VTtlamMw5Cf0lufOIIT73IM/5T/KOikho
         EMj4sKtqevPwQ6ClzDEscauv3wam95cQMk2CurAtc5a6SgiUWroE76rJRKU628igd9wp
         JAoGsA7b1ftlKofoiRO+aexwzdx09icdJUhvKbgcd/DQRUp14Xt0/UK82etFAHmT0tVR
         H4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iJiq0GN/fT31bSbr6oSGyoX3W9d2NQyN8PKQd1yXMAw=;
        b=Jwv4KZoGRlvWWsxg/CsNgxQlVWsB7CkZnZDMDKr4xrRC9SHV1x8i+r2pWe/LZfAv6+
         8G45M+Kr2fvYNaxIuHSmgxjVdCNhH+Bsq1p5CTR8Tjpd8q84Zfds6t1FKG/szZ161n3i
         1WjTZzAnG9E0hiLJ33xS7XF6RJegcXdmUVIHH7vbAx2vDM7p8i4f3gLmi+z29vjmcoQO
         vg6O7eERRf3oj+e6HW0/uzVpZNHyolCxCcB7NZJ6v3mY99qKQalbDwgzKx456ufQF4aE
         50LyT7heEDV+EPGzM9hCQDuJvEfjcwI8OFexCW0Z/s2QFzfkUsMyc5er/MsCkmmTi70m
         xWgg==
X-Gm-Message-State: AJIora/puoymEiStKXk/0xLvBqFYTPOe1PNKEE2WWkSrq/wkAg/FRpMR
        uRp+d+aN60oZ7OQ9grV5n4IeYX43BsECsG78XZU=
X-Google-Smtp-Source: AGRyM1ufDZZkUG0mbDb2ZdSgICJ83UBZIrFIwZzq60MP3blu+7rQwgc/0rwLCkkqNtVwjnQCPU/5Y122veX+kIcubzM=
X-Received: by 2002:a1f:f44a:0:b0:374:b7ce:2337 with SMTP id
 s71-20020a1ff44a000000b00374b7ce2337mr14234888vkh.15.1658347896829; Wed, 20
 Jul 2022 13:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220719234131.235187-1-bongiojp@gmail.com> <Ytd0G0glVWdv+iaD@casper.infradead.org>
 <Ytd28d36kwdYWkVZ@magnolia> <YtgNCfMcuX7DGg7z@casper.infradead.org>
 <YthCucuMk/SAL0qN@mit.edu> <YthI9qp+VeNbFQP3@casper.infradead.org>
 <YthNrO4PMR+5ao+6@magnolia> <YthSysIGldWhK6f+@casper.infradead.org>
In-Reply-To: <YthSysIGldWhK6f+@casper.infradead.org>
From:   Jeremy Bongio <bongiojp@gmail.com>
Date:   Wed, 20 Jul 2022 13:11:25 -0700
Message-ID: <CANfQU3xMtYE8egLim0MS6N0SCCNX5yihQgafptop6ACrO8MGbw@mail.gmail.com>
Subject: Re: [PATCH v4] Add ioctls to get/set the ext4 superblock uuid.
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
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

On Wed, Jul 20, 2022 at 12:09 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Jul 20, 2022 at 11:47:08AM -0700, Darrick J. Wong wrote:
> > On Wed, Jul 20, 2022 at 07:27:02PM +0100, Matthew Wilcox wrote:
> > > On Wed, Jul 20, 2022 at 02:00:25PM -0400, Theodore Ts'o wrote:
> > > > On Wed, Jul 20, 2022 at 03:11:21PM +0100, Matthew Wilcox wrote:
> > > > > Uhhh.  So what are the semantics of len?  That is, on SET, what does
> > > > > a filesystem do if userspace says "Here's 8 bytes" but the filesystem
> > > > > usually uses 16 bytes?  What does the same filesystem do if userspace
> > > > > offers it 32 bytes?  If the answer is "returns -EINVAL", how does
> > > > > userspace discover what size of volume ID is acceptable to a particular
> > > > > filesystem?
> > > > >
> > > > > And then, on GET, does 'len' just mean "here's the length of the buffer,
> > > > > put however much will fit into it"?  Should filesystems update it to
> > > > > inform userspace how much was transferred?
> > > >
> > > > What I'd suggest is that for GET, the length field when called should
> > > > be the length of the buffer, and if the length is too small, we should
> > > > return some error --- probably EINVAL or ENOSPC.  If the buffer size
> > > > length is larger than what is needed, having the file system update it
> > > > with the size of the UUID that was returned.
> >
> > I'd suggest something different -- calling the getfsuuid ioctl with a
> > null argument should return the filesystem's volid/uuid size as the
> > return value.  If userspace supplies a non-null argument, then fsu_len
> > has to match the filesystem's volid/uuid size or else you get EINVAL.
>
> Or userspace passes in 0 for the len and the filesystem returns -EINVAL
> and sets ->len to what the valid size would be?  There's a few ways of
> solving this.

This solution seems more intuitive to me. If EXT4_IOCTL_GETFSUUID is
called with fsu_len set to 0, then fsu_len will be set to the required
UUID length and return with an error code.

I discussed this solution when first developing the ioctl, but I left
it out since for ext4 I don't have a use case. However since other
filesystems will likely implement this ioctl, it makes sense to add.

I'll send out a new manpage with that detail added and update the code.
