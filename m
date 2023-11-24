Return-Path: <linux-fsdevel+bounces-3679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F377F77C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 16:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE620B215AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 15:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9472EAE5;
	Fri, 24 Nov 2023 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wHtmdvQI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE07B1985
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 07:26:39 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso22473a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 07:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700839598; x=1701444398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9eOTiJRT5tAYEp6WQwpb4QnKWMhr1jjUH9P1tvXDqE=;
        b=wHtmdvQI5ZYbCxdqnJi/A5AV8/Q5mw8vxg5b1ubxcELBLAJ1B01Z+tPzu47bb0+Gj/
         Gt9+qo4TfcKOcdlozug0DM/0HWxxD0woYoEeuhUtkl/CrsQVOHChrl7QaZ4pP6iuyLRv
         LUND/2qDPcFLkiku4i5+RpWxZgZgMhvZ8/6YoHVleHtj7H8xl15vclxMamwDF0a3tN9a
         1SQNg0roxxWt8TJ6ysa6aljdGBvIApZS7nL6PKM0PaB5zoNpcAxVWdsstBLtqEk4aUHW
         tBpEanQRP+3DSIqSoYjG1qSi2dZFPqJVzNLxFW267UtoWpvNIYGeTxSPjavzQQZYoE8K
         BYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700839598; x=1701444398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9eOTiJRT5tAYEp6WQwpb4QnKWMhr1jjUH9P1tvXDqE=;
        b=mME7Pj/moadmx9czSe+bOBaQLiOpOErVBjxEiDJvo6A2N66//+3DdvbtMA6oEETr8e
         ld1aertFqC45IEnhlkKVmAfsYzs4SxbpWea0V+us0xM38ionSSqtreYWJDBLD2sg8Bdn
         VpbWfHP93HM9MNlNWHPvtRQeAzZqD5Dj3hDoQeqO9aeaTfJhTqJ6fa0titMN9qFwz0Hl
         z/P736wk1JNLFVp5lFzUMSpece1T4cQReNjhxgzbXikNKmpkFkgTyppmxQOUDB6vcPsS
         Wk9ej/sYCilzHe92Fohu83fRmqXwdhRQXq6JTwQNX8UeNMCksBlhv0SUMEWgD38TTqYV
         98aA==
X-Gm-Message-State: AOJu0Yxk/aic0UC8YWv7NiJRobEdYlhsVyv0mWeqqTbGVvtR0/q32FES
	CDHKVMqJa2iKv+LQMbxWIiszpww9lpOChYNx4vNvJQ==
X-Google-Smtp-Source: AGHT+IEZRZrgTJQBje/frdbB1nFc6/Ki+XP+QH6veRpKt8y0jX8UQmYIDjFaOpU9dwbgIK3axfJj++DtHfw3lixxdts=
X-Received: by 2002:a05:6402:b4c:b0:54a:e781:ce76 with SMTP id
 bx12-20020a0564020b4c00b0054ae781ce76mr116550edb.6.1700839598271; Fri, 24 Nov
 2023 07:26:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxjssgw1tZrUQvtHHVacSgR9NE0yF8DA3+R5LNFAocCvVQ@mail.gmail.com>
 <000000000000258ac60606589787@google.com> <CAG48ez2UkCR7LMaQfCQVLW4VOZG9CuPDMHG7cBtaAitM=zPBCg@mail.gmail.com>
In-Reply-To: <CAG48ez2UkCR7LMaQfCQVLW4VOZG9CuPDMHG7cBtaAitM=zPBCg@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 24 Nov 2023 16:26:02 +0100
Message-ID: <CAG48ez2_XT1XDML756zM2D07BjcJnw22pFiHHrOm-yHvGJHvdw@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] KASAN: invalid-free in ovl_copy_up_one
To: amir73il@gmail.com, 
	syzbot <syzbot+477d8d8901756d1cbba1@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 4:11=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Wed, Sep 27, 2023 at 5:10=E2=80=AFPM syzbot
> <syzbot+477d8d8901756d1cbba1@syzkaller.appspotmail.com> wrote:
> > syzbot has tested the proposed patch and the reproducer did not trigger=
 any issue:
> >
> > Reported-and-tested-by: syzbot+477d8d8901756d1cbba1@syzkaller.appspotma=
il.com
> >
> > Tested on:
> >
> > commit:         8e9b46c4 ovl: do not encode lower fh with upper sb_wri.=
.
> > git tree:       https://github.com/amir73il/linux.git ovl_want_write
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D10d10ffa680=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbb54ecdfa19=
7f132
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D477d8d8901756=
d1cbba1
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for=
 Debian) 2.40
>
> It looks like the fix was submitted without the Reported-by tag, so
> syzkaller doesn't recognize that the fix has landed... I'll tell
> syzkaller now which commit the fix is supposed to be in, please
> correct me if this is wrong:
>
> #syz fix: ovl: do not encode lower fh with upper sb_writers held

(Ah, and just for the record: I hadn't realized when writing this that
the fix was actually in a newer version of the same patch... "git
range-diff 44ef23e481b02df2f17599a24f81cf0045dc5256~1..44ef23e481b02df2f175=
99a24f81cf0045dc5256
5b02bfc1e7e3811c5bf7f0fa626a0694d0dbbd77~1..5b02bfc1e7e3811c5bf7f0fa626a069=
4d0dbbd77"
shows an added "ovl_get_index_name", I guess that's the fix?)

