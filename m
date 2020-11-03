Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D512A48D8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 16:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgKCPAU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 10:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbgKCO7J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 09:59:09 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696E1C0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 06:59:06 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id m143so9295476oig.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 06:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=XgwA0kfD5euhArPMwDakM5tznPe6JUSWz2QPkoCQaFM=;
        b=JYvVyN/lQoii51ZQfR6GHH/yXmY0wgRytoa/Ok1veaC/9N4xCvniTrxbRPzIkPBeAL
         j1qQk1RM2SSZqN49zsghBlpc/IDQSViHN9UPG5S5i6BrJN7zvepG4LwKpKWpSFKhiu3V
         +KBg4HQVmg1sYm6bz5DntUoy4+XJ0WyUe8+q1i0Hvn3vhoP5OagZr7usJ/0tcKZNphGU
         t01cEdg1cBFn520CSdOXoG2nGGXlMmLntnzloYXPzszSgUMBkDG48n++DtTD/eH+HJ60
         VpbyqabDKR75gxJH6hCUMGoTUVTdnspxhX10qB+PsWOqmpONcA/EAcHvhN9H29HGw7rj
         ThXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XgwA0kfD5euhArPMwDakM5tznPe6JUSWz2QPkoCQaFM=;
        b=lAsWOamOOlLLz8Y6d2a2Mcavc/vsA07i3cQ4bAMPX3AqMrktZZ5EKIuQoeIO9pcUF9
         jODdrJr90mqAXexmZ217d7EeEOdBRa1NGRN6QFXLFm5DVkn8cBnL7bTj/QO2v9A7ycr9
         59ixaMbAveXoHMG03+1OVMsbQcYOdIxXl7dmoTEBpS34Gnj0n+NQtT/52CrKUtqrDw64
         ntFTmTY7C41KfkR/TyQicW98HCBGIELEGMNRzbBLWmConNNGqPF+IKt7ArHkzQB/LdVn
         ImG4uGDbBVk5+mTqWd1NA6kCPkSJz+xg4Zlq62RtSl/Zwp+De0Z+K7raMKLaJ3+iG/pZ
         fcnQ==
X-Gm-Message-State: AOAM530XzNdDdzNPHvjA+/h2bAqQl/eybbULZkmrUb4p0EHALAGKXAgL
        AIVE2/ExMMnzxwNg8cXG7xZY2n+1fH76ryUoPBsxb4t+Q7A5eA==
X-Google-Smtp-Source: ABdhPJz0DQkAkUvjKgC7Abm/TYge7++ZTeZGlXlQzayklHyBgKBgNHIg9UCSCcGp0Vnm6Iq+xszB3MadmN/anKZYx9o=
X-Received: by 2002:aca:2111:: with SMTP id 17mr60966oiz.139.1604415545624;
 Tue, 03 Nov 2020 06:59:05 -0800 (PST)
MIME-Version: 1.0
From:   Amy Parker <enbyamy@gmail.com>
Date:   Tue, 3 Nov 2020 06:58:55 -0800
Message-ID: <CAE1WUT6Q2-fC5Zo-dmjt9FJEt6ADmy1rijYX41aBmWwtO6Dp6Q@mail.gmail.com>
Subject: befs: TODO needs updating
To:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current TODO in fs/befs/TODO is horrendously out of date. The last
time it was updated was with the merge of 2.6.12-rc2 back in 2005.

Some examples of points in the TODO that need a glance (I have no clue
if these have been resolved as no one has updated the TODO in 20
years):

> Befs_fs.h has gotten big and messy. No reason not to break it up into smaller peices.
On top of the spelling fix, fs/befs/Befs_fs.h no longer exists. When
did this last exist?

> See if Alexander Viro's option parser made it into the kernel tree. Use that if we can. (include/linux/parser.h)
This parser is now at include/linux/fs_parser.h. It did make it in. Is
such a shift still needed? Such header is never included in any files
in fs/befs.


Best regards,
Amy Parker
(they/them)
