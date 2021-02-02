Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1B030B553
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 03:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhBBChu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Feb 2021 21:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhBBCht (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Feb 2021 21:37:49 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282CBC061573
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Feb 2021 18:37:09 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id e70so18415918ote.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Feb 2021 18:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cp+38YK8pcqsyfP21l71TpOip32TpbwgQ2f3fopEZbk=;
        b=XFKzQfpqY91dFL+q6OycCFvduUPJfsaB6xg/dX41K05p8M9MCshtlq5K69AX7mtywv
         ZS677TpPe4QS6cOIiSH/K9GBCPdPDrEPxb9ILC70V30al1kIyNtMBQcVoeQViBT/RAA4
         StxT7U+96A0Uz9y+EabxeQ/zvVvZXfGPwAvdQNCYYiLO/NFcT5QCvSeYAP5+UXtaqOHl
         +Gou0DFAE5GK+XJP59nU8RTzvFFO+P4oWD1NdnnW1rvcwRFkGkFgtrRgfZZGfhXqqwB+
         CeKh/c/FMqx+AdrMFpbeX3WjVSwG+EccG5UvL39GwvnlDgaMw3Y3Jyfc/xb3S+bRxkTy
         R1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cp+38YK8pcqsyfP21l71TpOip32TpbwgQ2f3fopEZbk=;
        b=hfS7mVJHGnoP/mdq6vnhFUokOHOIcvrYRxzMQixM9j6e0U+Q2b9KVeNd7nTuJz1rt7
         +TM7qNybd3hYIJbsF7GjhTAp9kBMb1AYju5eug3CPgVHLdUh7vGgvkz2ZZAXiUVeS0ei
         vNr5rxb9dsc4gQkPwOb4ChZwwWGLFFCD+boCNUuHjeftO7Am4kurYHnG86aXCLlWrLVM
         jyIqLdEZNODtc3zyB8ffbO4kdY1OeKhivIxPXEIoPUBXnhACNWbqonoVq6CFHmG5gi/f
         ANzCZPaogtps6hoRjKP4HAPGrAaNhxej2Z5FFaMnKi2Jgtwal+a5OS+gUyDvL9Z9mM4D
         MijA==
X-Gm-Message-State: AOAM5306qwTfnsbsVLZP8reWApoSGYEs18qxv+Lq9whUHsONCyPYlVG0
        RXKlIq+uPCC+mB0HqQL0+GFascHHtR8+2ZGVopj+7vEHhec=
X-Google-Smtp-Source: ABdhPJwqWnJpqB5mClN/UjE5hfEZ/8Mo9kVzVhkNzqgixo1elbk4zy4bci36FYfWa8oIKZUs+g7u8TJd2pAVofVQ2AQ=
X-Received: by 2002:a9d:1421:: with SMTP id h30mr14157352oth.45.1612233428574;
 Mon, 01 Feb 2021 18:37:08 -0800 (PST)
MIME-Version: 1.0
References: <CAE1WUT63RUz0r2LaJZ7hvayzfLadEdsZjymg8UYU481de+6wLA@mail.gmail.com>
 <20210202014802.GB7187@magnolia>
In-Reply-To: <20210202014802.GB7187@magnolia>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Mon, 1 Feb 2021 18:36:57 -0800
Message-ID: <CAE1WUT4wY+MKXNsF8T1wvxUOJ6oJTS4QiTw6y=BebDxP91+iow@mail.gmail.com>
Subject: Re: Using bit shifts for VXFS file modes
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 1, 2021 at 5:48 PM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Mon, Feb 01, 2021 at 03:49:20PM -0800, Amy Parker wrote:
> > Hello filesystem developers!
> >
> > I was scouting through the FreeVXFS code, when I came across this in
> > fs/freevxfs/vxfs.h:
> >
> > enum vxfs_mode {
> >         VXFS_ISUID = 0x00000800, /* setuid */
> >         VXFS_ISGID = 0x00000400, /* setgid */
> >         VXFS_ISVTX = 0x00000200, /* sticky bit */
> >         VXFS_IREAD = 0x00000100, /* read */
> >         VXFS_IWRITE = 0x00000080, /* write */
> >         VXFS_IEXEC = 0x00000040, /* exec */
> >
> > Especially in an expanded form like this, these are ugly to read, and
> > a pain to work with.
>
> I would personally just change those to use the constants in
> include/uapi/linux/stat.h.  They're userspace ABI and I don't think
> anyone's going to come up with a good reason to change the numbering
> after nearly 50 years.

This is a great idea. Didn't think of that, thank you.

>
> That said, on the general principle of "anything you touch you get to
> QA" I would leave it alone.
>

Yeah, I guess that's there too.

Best regards,
Amy Parker
(she/her/hers)
