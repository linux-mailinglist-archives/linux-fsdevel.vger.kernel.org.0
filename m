Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D5F34768F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 11:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbhCXKxd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 06:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbhCXKxW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:53:22 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0410AC0613DE
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 03:53:22 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id s25so11085570vsa.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 03:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=93ckUpQ97JYDAlaqK6dyZt+DFJZfWSRfcVZ5qbI+eMs=;
        b=nBQRzUz1L8n0WYXo6rlGUMY9Mm18aCHJlptS5Iy6CieByW+eO6W70qPKT2dnXSzAcJ
         u04q2T6A+cFbLFbyliKk6ZKUwKz/97/wkcZvqO5LXK7Qit3pRImHkZaYtmNREZ2R4FfL
         oitayKU/3ji0FdtEcViOClcmQsLTSjaF5OFqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=93ckUpQ97JYDAlaqK6dyZt+DFJZfWSRfcVZ5qbI+eMs=;
        b=toL4qH9on3jEX+AtJFSaekSTZr24w3p6ek1YttB08uDb7tRDwgBUFLc3XrH2xGfebE
         N7fSY9o2YhNf5vrwn2aODAF54TCsFrdlQ5+34b8XIuKT+C9/zm8K8jjZlLoENCoTyRQF
         jtXv4QXgNDMoOefvtT/9xHWaluFbNaniW00WTRxi52rr7Th9cdS0OlHDHfTarKoqQFir
         8T5SDiwy7ypc0R3KUKOOXnxcIDBqH32RKDOSLGNBkvRnbIiHDrg5czuzhjAKvH/l28Ew
         7pn35vljFhpOgxCsRYJWDyhUC+tTyJWkb0ADnHrdrvmV5NE9EHLy1WJnt43ATeYM+GLu
         W8FA==
X-Gm-Message-State: AOAM532KGiaXdwCNTFPX4cMNCZ0wLPg1jgf4Sbzt3P4AY8yCZI0ZoGRY
        j6EAZxumUYkzM0aVKCrwp9JSIKRw7i4gvEhEsFc88w==
X-Google-Smtp-Source: ABdhPJxVq1Tf+GVyRJH4m2hw35vIV9V5TlOJe6DrMCKCc+eMVTNFYbiGpTo3oJSe939tVnzJcZsK3TaSPdIOxPlkrJ4=
X-Received: by 2002:a67:ffc1:: with SMTP id w1mr1150387vsq.47.1616583201278;
 Wed, 24 Mar 2021 03:53:21 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000003f5e4805bd53a5c5@google.com>
In-Reply-To: <0000000000003f5e4805bd53a5c5@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 24 Mar 2021 11:53:10 +0100
Message-ID: <CAJfpegutVjhx=d9N=q=vNdR+W2uJCryrmxvKAJwz4PgWP0va1w@mail.gmail.com>
Subject: Re: [syzbot] INFO: task hung in walk_component (2)
To:     syzbot <syzbot+c6aadfbde93979999512@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

#syz fix: fuse: fix live lock in fuse_iget()
