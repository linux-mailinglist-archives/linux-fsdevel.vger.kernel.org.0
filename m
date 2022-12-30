Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC345659783
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Dec 2022 12:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiL3LQf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 06:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiL3LQe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 06:16:34 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0C3FD00
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Dec 2022 03:16:31 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-48641a481dfso120271477b3.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Dec 2022 03:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8NIrxIRXisjc7VqszBoIV+J9dlqwzzX8xAgY333gQQU=;
        b=EPPbZVXO7tPNtwFNZ/ty7sJODpmiExop0d4qcnJxYObAMmH1XBZPQ4PfPzXs5+zSQc
         mYx3YvecKNuTFBvqbLuUEewfuDIy3Al2rTL7TQGVLRmAGG0rxZ/FDgywAv/LcExIokCP
         Yo7V7a9PUF6bWcIJX4d+ea2ECO4Ssdh4RoDjE6DHYaZvJF1xGRupOCJ8Fg1E9yMynkjv
         y/eEZ9zKly+A09HFJzole5GKJxf9Vc7qWjyeGMuiln9ESSvh42afajCNkOm7p+buLyiQ
         pUsRW/w4qkgUc0/wS/2PdK08Gel4VAkazAhk78oPKf9KIsZ3B97IsgsET2MVWgWpDu2Z
         YdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8NIrxIRXisjc7VqszBoIV+J9dlqwzzX8xAgY333gQQU=;
        b=t30pB9H/J4VdZ2MBykP1Q/8xxPHgFZ3ZNeW6K3jC9v+FUP8ByYJECEZHsCI12OjyHV
         gXbkCZfGo+4jd9ewtqTv6zrZA7NmadXeX4Ho1t5ik1tiMiUwOL/BpP+Lkt0NWM2yqah5
         HY50JN8GMMgiNPurSgBKgI6BB2K+ArKhSCn47hIUe7GpNEembjcBxKZF7gqotVQ16jlo
         cwKLXLIWdtbGpvDYPRAtQj6LVIMlIP37SUi7agEqtzM1P+ZH8+dkVSE9QKrinK3GekMz
         V8uiG38tOyn/Jnb1APSzqcvpFh2dgbAJWUPgDt0LpBGw/keTQkiPmbf2rHCFk2FvmyRa
         cuzg==
X-Gm-Message-State: AFqh2kpcFPFH6TGv47jbX4qnHzxnpO076hzVBKXjJXabLpNqSaRdbWFt
        74lU4KakaSWmW7doToyRnQ0GV6rVzos8O1yYkfuo+wFgVUU=
X-Google-Smtp-Source: AMrXdXs66pa+MPVOAeQgV9XoMJqdcAD4OrCo7pPH3HLG24iHIymWlNAgLYVcaWbqjtnSPWMunlyBlGtO6wMWbZdoDLo=
X-Received: by 2002:a81:1605:0:b0:475:d2f4:6522 with SMTP id
 5-20020a811605000000b00475d2f46522mr2607462yww.120.1672398990576; Fri, 30 Dec
 2022 03:16:30 -0800 (PST)
MIME-Version: 1.0
References: <CAM7-yPQOZx85f3KxKO1feSPcwYTZGRNNVEgqn4D_+nhhXvqQzQ@mail.gmail.com>
 <Y67EPM+fIu41hlCO@casper.infradead.org> <CAM7-yPROANYjeGn3ECfqmn0sLzEQPUpzCyU5zSN3-mJv3UA4CA@mail.gmail.com>
In-Reply-To: <CAM7-yPROANYjeGn3ECfqmn0sLzEQPUpzCyU5zSN3-mJv3UA4CA@mail.gmail.com>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Fri, 30 Dec 2022 20:16:19 +0900
Message-ID: <CAM7-yPSDZG6Sd9pcm+5zXteMfKYujZ8bjpywwJV4whrmRr+ELQ@mail.gmail.com>
Subject: Fwd: [Question] Unlinking original file of bind mounted file.
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> No, that's not correct.  Here's how to think about Unix files (not just
> ext4, going all the way back to the 1970s).  Each inode has a reference
> count.  All kinds of things hold a reference count to an inode; some of
> the more common ones are a name in a directory, an open file, a mmap of
> that open file, passing a file descriptor through a unix socket, etc, etc.
>
> Unlink removes a name from a directory.  That causes the reference count
> to be decreased, but the inode will only be released if that causes the
> reference count to drop to 0.  If the file is open, or it has multiple
> names, it won't be removed.
>
> mount --bind obviously isn't traditional Unix, but it fits in the same
> paradigm.  It causes a new reference count to be taken on the inode.
> So you can remove the original name that was used to create the link,
> and that causes i_nlink to drop to 0, but the in-memory refcount is
> still positive, so the inode will not be reused.
>

Actually, when the bind mount happens on the some file, it doesn't
increase the inode->i_count,
Instead of that, it increases dentry's refcount.
So, If we do "mount --bind a b"
it just increases the reference of dentry of a, not i_count of a.

So, when rm -f a, it just put the reference of dentry, but not
decreased the reference count of inode->i_count.
When the unlink on b, finally the dentry is killed and free the inode.

That's the reason why inode's count sustains "1" though a was unlinked
but makes the inode->n_link as 0.

Here is What I saw via crash the b's inode's reference count which
after unlink the original a.

// 0xffff0000c6af9d18 is the inode which unlinks the original file.
(mentioned as b above).
crash> struct inode.i_count 0xffff0000c6af9d18
  i_count = {
    counter = 1
  },
crash> struct inode.i_nlink 0xffff0000c6af9d18
    i_nlink = 0,
