Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401E41D10BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 13:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbgEMLLH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 07:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729288AbgEMLLG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 07:11:06 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2626DC061A0C
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 04:11:06 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id w25so2930771iol.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 04:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HrXBd13QR2GNAaz6g2ER/nKMRt8kvno99Hh0W022IbE=;
        b=Ml4YpFXGdYrloAlRWccAkHWLH15DiTpnsgWwCWk3+73aOEv5s6DSoaI7pSi/9rGg+v
         v/E5FCxwmjdyJYoYKQoq+GObv1bwocXacnxq/ZNKmDj0G/b3S/Z9ek0NqA4K7jVrdZoZ
         G5z+wWSsRHEK4SCnGD1xN22V5Lv+TVPlxmtP0kAfUvqeGpMT+zNlpq3l8tM3ReS8RSii
         tyvhIz2X6SQ38EhG5FaFQ1C2EdFfuyuKvlIZlXS+CIq27H/J7tmhOpbB8MzrMi/s348m
         WShz7YUMnFyVfalOQPvV/d2yg7DQvtpSBZ1wkf1976mDaihxeJ8Bb4DQRWPojYIsuDeu
         uf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HrXBd13QR2GNAaz6g2ER/nKMRt8kvno99Hh0W022IbE=;
        b=IMHULDgifuCimnpjaH3vIPJ9yRj5eRI6dC+qdZBOTA1EFYEn2KpF/EOlNV+4pgjSWj
         1tCIAdQk37Ynue9Nw6z6gzsR8dhNDXT8FRp6erDmho2ZBglJqjjjywQ6KTy6BTJRY48Y
         r8imUmjYU5jDgUiXDTXBAl+xiUvjr+Hk1x9A2lysekNV8LSDrrOVmzoyKMtFY4FC7Jg7
         byJVUirwFuZ0c8pM5ecMy3VQPctj/bILR0vfFctZEYBZyjYCT+QeY0EXBg93i8efeDS1
         UWrGnnMlbJrx8Haw08xhE5rg5BdJnL+QwilxFXmdn5GFRakRUt0SZYhYivakaVp6QAJy
         LgBQ==
X-Gm-Message-State: AGi0PuZPlZG6W4qmfwTNOcSYZ5LhRaz/dbcUEOLAOy1wFjH6w/7paFh8
        jyblXO0++3DzPojaOjSiW5+CdtYLI15lo7FPZ98=
X-Google-Smtp-Source: APiQypJF/jV0pPqZ/Bme0fNWLQjPDB1NDoJ7UKENynZiYOlp6uoK8DItOU1IehwqkC5sAi3OQGAHyGO7o75cMqfC7bc=
X-Received: by 2002:a5e:c817:: with SMTP id y23mr18667449iol.5.1589368265499;
 Wed, 13 May 2020 04:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200512181608.405682-1-fabf@skynet.be> <CAOQ4uxgr7gXBEYPDSPS+ga0+dXY_xDtae_ZQqg5_Bed3PtJMZA@mail.gmail.com>
 <20200513110817.GC27709@quack2.suse.cz>
In-Reply-To: <20200513110817.GC27709@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 13 May 2020 14:10:54 +0300
Message-ID: <CAOQ4uxiUXgW7HyMaHoqFH6kZnrTPNd=Rgfj6duO8aKc87mhCCw@mail.gmail.com>
Subject: Re: [PATCH V2 0/6 linux-next] fs/notify: cleanup
To:     Jan Kara <jack@suse.cz>
Cc:     Fabian Frederick <fabf@skynet.be>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 13, 2020 at 2:08 PM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 12-05-20 21:32:10, Amir Goldstein wrote:
> > On Tue, May 12, 2020 at 9:16 PM Fabian Frederick <fabf@skynet.be> wrote:
> > >
> > > This small patchset does some cleanup in fs/notify branch
> > > especially in fanotify.
> >
> > Patches look fine to me.
> > I would just change the subject of patches from notify: to fsnotify:.
> > The patch "explicit shutdown initialization" is border line unneeded
> > and its subject is not very descriptive.
> > Let's wait and see what Jan has to say before you post another round.
>
> Yeah, I think patch 2 doesn't make sence but the rest looks good. Can I add
> your Reviewed-by Amir when merging them?

Yes.

Thanks,
Amir.
