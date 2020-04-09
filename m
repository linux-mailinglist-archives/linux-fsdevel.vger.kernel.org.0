Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E55A1A3A82
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 21:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgDITaP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 15:30:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36206 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgDITaP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:30:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id k1so13344086wrm.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2020 12:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NsjOKGXentYDDokuXe/XReIcUx0CQbs/gEh6adR3eUE=;
        b=bQjKqQUI+WriaUFk7xC5dWrEColZfJxiTGwdraq1/yjkXtK2f20dVt8qYwlzWVclcv
         sJ0pG4DSRTEka4Gn9Qlah7AE7PKoLWM9T97bC7OOuR1S0g+3BiA4BHX7MdL5CsDoFCNF
         mwZvIhycErReGP9XlDuSeBPnzmIObs1m2JOKvwPlUFwQZ6L2z/33XFnONh86Fo333ZOR
         bYgKQ/SzgW1EhJZVLbJpuAU/E7O0oUeV4ABsuiluhzfat7LwVgvnEOA/MoVurXXHf93e
         x1kjbF7xqBtrmjmdiegAS6Vrlxub0aNmYgxc4ggvVW7FukkwuGH2pbEI9jfye3zIqHK3
         34Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NsjOKGXentYDDokuXe/XReIcUx0CQbs/gEh6adR3eUE=;
        b=MXX3YU55az+5ybUxMVrXzrFcDeVDAuPABj7UeRWEUgrFAOFidrVVKnxLYzs802DHZH
         ND+p/3D2CNV4DWndtwAJjjcZ3Z/yfIcDeHXaQIPNCueTiMNBlxdNrTlb6X6W/fYGmCwr
         KyCWEodjqnan4Hm4EVwyAWhJV1OGJmkJ56nxtr98etjl0I10lB9z97ylic7XA4PP8+6Y
         bwsv3NOdN6xUNi+YlM7aYBezKshHpAcUXjIHu87O6+rZQwm63PA3UdwVMOUrWlZs483E
         LaPhGou7e1oacWVfRODLkYD9qw6o1H86Lu09bbLVd1BX+3fAJTV/46p6GvarwqNf4yHN
         tl5A==
X-Gm-Message-State: AGi0PuaWMHnua+uc9W+BWmx/DAizIm1scz+3YJA2NZ143ebUy4Ir+OIm
        abSaQ7X7ZozpffBowT2yH85T/NbKDY4gqUu/tqI=
X-Google-Smtp-Source: APiQypJ+rNdhtGhyrPq00cHkeV6kLvhPcDkuL3Kz3EFUYweumZWfBmzAIrlIZ3MLjjqfajL5lTOIY1gA3Q884Qx/eYQ=
X-Received: by 2002:a5d:63d2:: with SMTP id c18mr650474wrw.385.1586460614270;
 Thu, 09 Apr 2020 12:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyF9JX1VaevFcvDKAcHa1XTgYznOMwW+LMigA-awqn_m7w@mail.gmail.com>
 <20200409185132.GY21484@bombadil.infradead.org>
In-Reply-To: <20200409185132.GY21484@bombadil.infradead.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 9 Apr 2020 15:30:02 -0400
Message-ID: <CAN-5tyE1NGOf_v+HrTdDTYkHeAwUnYpeK0_LDtPMMHpGrCe-5Q@mail.gmail.com>
Subject: Re: is this hang in a rename syscall is known?
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 9, 2020 at 2:51 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Apr 09, 2020 at 12:44:25PM -0400, Olga Kornievskaia wrote:
> > Hi folks,
> >
> > Getting this hang on a 5.5 kernel, is this a known issue? Thank you.
>
> I haven't seen it reported.
>
> > Apr  7 13:34:53 scspr1865142002 kernel:      Not tainted 5.5.7 #1
> > Apr  7 13:34:53 scspr1865142002 kernel: "echo 0 >
> > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > Apr  7 13:34:53 scspr1865142002 kernel: dt              D    0 24788
> > 24323 0x00000080
> > Apr  7 13:34:53 scspr1865142002 kernel: Call Trace:
> > Apr  7 13:34:53 scspr1865142002 kernel: ? __schedule+0x2ca/0x6e0
> > Apr  7 13:34:53 scspr1865142002 kernel: schedule+0x4a/0xb0
> > Apr  7 13:34:53 scspr1865142002 kernel: schedule_preempt_disabled+0xa/0x10
> > Apr  7 13:34:53 scspr1865142002 kernel: __mutex_lock.isra.11+0x233/0x4e0
> > Apr  7 13:34:53 scspr1865142002 kernel: ? strncpy_from_user+0x47/0x160
> > Apr  7 13:34:53 scspr1865142002 kernel: lock_rename+0x28/0xd0
>
> This task is doing a cross-directory rename() operation.  We only allow
> one of those in progress per filesystem at any given time (because they're
> quite rare and rearranging the tree like that plays merry havoc with the
> locking, which you need to prevent a directory becoming its own ancestor).
>
> So the question is, who else is in the middle of a rename operation and
> has blocked for a long time while holding the s_vfs_rename_mutex?
>
> As I recall, you work on NFS, so has something weird been going on with
> your network?

Yes indeed the renames were on NFS. I'll take a look at the network
trace (it didn't look like there was an unanswered renamed that would
have been holding a VFS lock). Thanks for reply so far.
