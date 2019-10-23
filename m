Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEFEFE1633
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 11:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390874AbfJWJdb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 05:33:31 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:36384 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390165AbfJWJdb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:33:31 -0400
Received: by mail-il1-f194.google.com with SMTP id s75so8508912ilc.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 02:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=116GRbWRknHRdRn7G8LOwHPp/W7xoUtuA8MkgJo/JNY=;
        b=Y5e5rpa8apPDSIxarbl12SrvmpjvueFu4yncLw9u/h+AeLJuruHMYzoKGpngsec/9n
         ROjQP5YjhTK4q3tnr+sS5evKitTJAYP26ufyUhTlUg+btOXbj/CbLPdirk78hncFNLve
         BFDwPel5ovCmXERo8QxDiFCo1pTIaZs2iY3Ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=116GRbWRknHRdRn7G8LOwHPp/W7xoUtuA8MkgJo/JNY=;
        b=lISDiNTlHMNYelZw9gx/737BNEl7sYxKSU53ZkR6GwuiHAl2LpI5MXv9fo5b1JuNhb
         x1rIpheIrqtSeGNpohhOQTY2XbJPPH+ZdCHi3Um6Mfm1bQaawtaFNzDnjMyRf/Jkg7um
         WAAgMvF66FLub81NTbz17LearjiuxhuGrR8u6vFvqU+9Dl4aOa2RpkS6YEk+su3sSLgc
         Bto//gQrneiZ77BbL1HzBfxbSm5uAuzfoEav4A4c+o92nki8IMLgbiacT+otmP4zWvom
         rFNqnqrWhBYM0h1zetkr+XdhhlpUBYjG4uZ5z99o6nemijo32j/DOWj8GYK5ljgPwb2G
         wSVw==
X-Gm-Message-State: APjAAAVK44m2JjtzL03OG/7EdptWhMBvoUTMKz6xOOSTis796Kp1/RJ4
        zOJGWPrtfdGT58Un4Xt5kXgy9MQBgYklL3NSrKe92w==
X-Google-Smtp-Source: APXvYqxT//3o5/3+uKVqyNa/6Sfjf6VT1h1r0mifIGrn/mFSvmMeqiIVx3cn3crB++Lhru9RWOGY1QGIAon10Fh7CmQ=
X-Received: by 2002:a92:6a04:: with SMTP id f4mr36504369ilc.252.1571823210048;
 Wed, 23 Oct 2019 02:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <1571796169-61061-1-git-send-email-zhengbin13@huawei.com>
In-Reply-To: <1571796169-61061-1-git-send-email-zhengbin13@huawei.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 23 Oct 2019 11:33:19 +0200
Message-ID: <CAJfpegtGJC=uR1ZHhPxpp=8XCkP7kEi5m_zuSM3GLcBB7YSdQA@mail.gmail.com>
Subject: Re: [PATCH] virtiofs: Remove set but not used variable 'fc'
To:     zhengbin <zhengbin13@huawei.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 23, 2019 at 3:56 AM zhengbin <zhengbin13@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> fs/fuse/virtio_fs.c: In function virtio_fs_wake_pending_and_unlock:
> fs/fuse/virtio_fs.c:983:20: warning: variable fc set but not used [-Wunused-but-set-variable]
>
> It is not used since commit 7ee1e2e631db ("virtiofs:
> No need to check fpq->connected state")

Thanks, applied.

Miklos
