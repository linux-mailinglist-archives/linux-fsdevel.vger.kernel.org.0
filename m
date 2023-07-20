Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D515875B9AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 23:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjGTVjF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 17:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGTVjE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 17:39:04 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52342711;
        Thu, 20 Jul 2023 14:39:03 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-5634d8d1db0so897181eaf.0;
        Thu, 20 Jul 2023 14:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689889143; x=1690493943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dYRT8gR63QqqutiXBMjJgTOolNJSeb3NYTp1ggZnVKs=;
        b=VUKpGzl0QmLZoG4AixW1FNm6MZLVscI7HSnH+yQ2S69X9KvLvYNNcPWo+9fTGgG69C
         XkWMW0FSBeM2JfnQeqf05ws31rzZNmsHAr6oXuR2TWdDTGbJhS1u0ooVFIM1X4mJOSva
         AuaYKm6PwaLRzCaOL/kff4xXwUuNzPDMVBuvIxLnRfgwQNqQ0BE7ZGwdIPwe0mIxVM+U
         tS3kBrn27axHlaGVlR7wg+RoJL50fwx3iNJmu+fjhlZkDZ09pR/3Pk6FzzsoWVyeKyZT
         tafEnuzOm3ZOUMqDi3GzRPVfQk7PNwNw26gFNYHLCqsgwgOfG21mlqNZl0skPu45bRFI
         IqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689889143; x=1690493943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dYRT8gR63QqqutiXBMjJgTOolNJSeb3NYTp1ggZnVKs=;
        b=eCtj62K69IKKic66G7frMa+cFaQYhV0f3yZbVkOEPmmCqaRi0IK6E+cNgvBmcvML7B
         tmA35fJ+EmKL+Eq9aAEaQYxiv1FiKSyrK+BgsK13316HiTfQWXBL39d2mO/8TXYfZUjB
         ozNzqLv67FGzGZDzGYZ11zcEsVzIcTO9EB7NJLqMtgISygEZeNMMAojPyI/NixNWgDsI
         XzfCCR4BKdaRHCIooKQTe0VgqBz/714kML81ob7u9Hoa7shOaMfxGWsaXw4qq7Wm3mz+
         XFFqjL6GLxecAqTk/Kwj8L0Rb3FE+NQH4O+hSd1PGN6CXNvV8VLzuqe69CKp22DXh2n4
         ln3A==
X-Gm-Message-State: ABy/qLZKTrKf5LiOcIouqsG5sdHLh1+bg/OREJwG8IIuEo4Lo83JXugN
        nRhNYQDgmFediAtQT/8HrCQSS742AC3u1I5WjOY=
X-Google-Smtp-Source: APBJJlFkP7d8cztDg5vTHEWZqe100qSHRs8QuvUy5m3xEBh4upu9IXMIuup4mlqAcJscbYhC7cBhJQQCzzbZNb7BSw4=
X-Received: by 2002:a4a:391b:0:b0:567:27f4:8c45 with SMTP id
 m27-20020a4a391b000000b0056727f48c45mr93537ooa.8.1689889143157; Thu, 20 Jul
 2023 14:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <5f45bb9a-5e00-48dd-82b0-46b19b1b98a3@app.fastmail.com>
 <CAHk-=wi8XyAUF9_z6-oa4Ava6PVZeE-=TVNcFK1puQHpOtqLLw@mail.gmail.com>
 <ab7a9477-ddc7-430f-b4ee-c67251e879b0@app.fastmail.com> <2575F983-D170-4B79-A6BA-912D4ED2CC73@dubeyko.com>
 <46F233BB-E587-4F2B-AA62-898EB46C9DCE@dubeyko.com> <Y7bw7X1Y5KtmPF5s@casper.infradead.org>
 <50D6A66B-D994-48F4-9EBA-360E57A37BBE@dubeyko.com> <CACT4Y+aJb4u+KPAF7629YDb2tB2geZrQm5sFR3M+r2P1rgicwQ@mail.gmail.com>
 <ZLlvII/jMPTT32ef@casper.infradead.org> <2d0bd58fb757e7771d13f82050a546ec5f7be8de.camel@physik.fu-berlin.de>
 <ZLl2Fq35Ya0cNbIm@casper.infradead.org>
In-Reply-To: <ZLl2Fq35Ya0cNbIm@casper.infradead.org>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Thu, 20 Jul 2023 17:38:52 -0400
Message-ID: <CAH8yC8=BwacXyFQret5pKVCzXXO0jLM_u9eW3bTdyPi4y8CSfw@mail.gmail.com>
Subject: Re: [syzbot] [hfs?] WARNING in hfs_write_inode
To:     Matthew Wilcox <willy@infradead.org>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        syzbot <syzbot+7bb7cd3595533513a9e7@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        christian.brauner@ubuntu.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        ZhangPeng <zhangpeng362@huawei.com>,
        linux-m68k@lists.linux-m68k.org,
        debian-ports <debian-ports@lists.debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 20, 2023 at 2:39=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Jul 20, 2023 at 07:50:47PM +0200, John Paul Adrian Glaubitz wrote=
:
> > > Then we should delete the HFS/HFS+ filesystems.  They're orphaned in
> > > MAINTAINERS and if distros are going to do such a damnfool thing,
> > > then we must stop them.
> >
> > Both HFS and HFS+ work perfectly fine. And if distributions or users ar=
e so
> > sensitive about security, it's up to them to blacklist individual featu=
res
> > in the kernel.
> >
> > Both HFS and HFS+ have been the default filesystem on MacOS for 30 year=
s
> > and I don't think it's justified to introduce such a hard compatibility
> > breakage just because some people are worried about theoretical evil
> > maid attacks.
> >
> > HFS/HFS+ mandatory if you want to boot Linux on a classic Mac or PowerM=
ac
> > and I don't think it's okay to break all these systems running Linux.
>
> If they're so popular, then it should be no trouble to find somebody
> to volunteer to maintain those filesystems.  Except they've been
> marked as orphaned since 2011 and effectively were orphaned several
> years before that (the last contribution I see from Roman Zippel is
> in 2008, and his last contribution to hfs was in 2006).

One data point may help.. I've been running Linux on an old PowerMac
and an old Intel MacBook since about 2014 or 2015 or so. I have needed
the HFS/HFS+ filesystem support for about 9 years now (including that
"blessed" support for the Apple Boot partition).

There's never been a problem with Linux and the Apple filesystems.
Maybe it speaks to the maturity/stability of the code that already
exists. The code does not need a lot of attention nowadays.

Maybe the orphaned status is the wrong metric to use to determine
removal. Maybe a better metric would be installation base. I.e., how
many users use the filesystem.

Jeff
