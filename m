Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2613D90B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 16:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbhG1Oce (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 10:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235405AbhG1Ocd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 10:32:33 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA65C061757
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jul 2021 07:32:31 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id j10so1524501vsl.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jul 2021 07:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EJo0PHoVbiVKIGpz4WbEXWXkHC4bfOhyP6K61KoB2LM=;
        b=S395aemGWoIdwNFYBBqyRA8mmCGQwttnLueWYxgibXsl/9W9ctYNpsyNsdJ7suhCFl
         iH9a/7h92eGx82xC6tg4Zs2lOEIeZg85gZbNLH47hCl1haxCJBTa2gL3dD8ezJOaoPpD
         CCY+Bl6InYozLIUDPOSDUU/WkLEF6OyWS4WCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EJo0PHoVbiVKIGpz4WbEXWXkHC4bfOhyP6K61KoB2LM=;
        b=M0nFFSo7Obd7IOPCpVjbsEtyAC6FWACwmu5rNIaGX4sDWUM54hWi4YtpGXqY3URGim
         0cl0zmxy+l+IGo+M8/SNKcS3y55rqUOtrnFqvw8+bPcgmXxpvOoSqRvru1lF1bHGTW/3
         /PfBTIZw2QaUrHPr01MITqHYhHBU5W29nKvk/BarmS/ihcfv8vUl6zcZwN6SvXG7OkWU
         tVW5+a4oSIQ07RXk7ysytrFovN8waIhBqlWunW861shXjhmskrjQvyNs5/xrBtrGS4TK
         hMXbDI3qdp+sGWwskur3u14/CRDWhggY1rOtCtr1jyS3wwoc/ihLc8zBK2ePEzEjIwLm
         BsAw==
X-Gm-Message-State: AOAM531QdAayuQnE6xSpoVVmiuiUg+k0wzosA6BFdl6584STPlk85NFy
        PQoz07yx9lWKw2ryWsIurykY76E+MVI8QF2GXLHvhQ==
X-Google-Smtp-Source: ABdhPJykaCzneBxaJdJtv56s3tLVJvYpO/nycTzEPfmIqI1jhBvMvWYg6rp0W6fqxmetTLMPXxBObPZmifwXmXznxhM=
X-Received: by 2002:a05:6102:2ca:: with SMTP id h10mr22658074vsh.7.1627482751123;
 Wed, 28 Jul 2021 07:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000052a12105c82facde@google.com>
In-Reply-To: <00000000000052a12105c82facde@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 28 Jul 2021 16:32:20 +0200
Message-ID: <CAJfpeguXWAJRyRn=8tLRq41kqjuSnX9VNqNT_V2+jhuttC0nEw@mail.gmail.com>
Subject: Re: [syzbot] possible deadlock in iter_file_splice_write (2)
To:     syzbot <syzbot+4bdbcaa79e8ee36fe6af@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git
overlayfs-next
