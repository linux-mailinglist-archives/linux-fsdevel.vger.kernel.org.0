Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58C5AC99AB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2019 10:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbfJCIVQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Oct 2019 04:21:16 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45191 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfJCIVP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Oct 2019 04:21:15 -0400
Received: by mail-io1-f68.google.com with SMTP id c25so3429364iot.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Oct 2019 01:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SLUXPRqEOCygu/EGgdl2O2z0foonvyQ6ZBGr8u4DDCw=;
        b=j7uCFhGnDcTfGd9C9paYejhHB74a6nNQtbtnb0HInonQwB1s+AQY9FDZF8m44u9dfN
         7Gt11+q0G+/ZxEmyC8mJdWk+z58fzsYt5CEl8HKd7cio977ku0tDKDpAa6SI1GljShFA
         hDmeMdwzayLvw40tl8qMr88agAoFqlhvyciK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SLUXPRqEOCygu/EGgdl2O2z0foonvyQ6ZBGr8u4DDCw=;
        b=tmUqrlio4E74DclcpLSV5tXRGzh8lg/8/2M8EtwuuLj4ju/idM3YHPlW4E0TiYIwAi
         +8XQhO5QJbqWDGAnTiz11MriXKM9ITXSS2C4IpGQbdYqZMRdHW6bsLRShFp12AR8Fdu9
         nXu3nsTIGUs5U4s+CilP+KeRwrbEHaQB1YkDQ2V6x2LWcXRgVIuyJVTwqWfQ/qlApPW7
         EdoOS4Yg5HTi26qnWoIt1d7eaNqG0z+7MPVlXtMkjd4FeULO+dUwiVV+FcgvWg+mKIMP
         GRppZ5i0MAyfbw5jk0tZODuuw6tz87Xqi6ATMXaOyGPx0Ju5JIlLLBQOM+S5Cn6dlR1w
         v/+w==
X-Gm-Message-State: APjAAAWT3lmGRNeZc+xCulgRinRLEZW9pBP3xylk9JgcSItoBG53HWnq
        lntjWlpksqC9t+ppo9+DBWKMOVxN6byv0VHuBDDh2w==
X-Google-Smtp-Source: APXvYqy4Fzd3kvw63DCpxYSiPXoXOG4fCbSTFKpqvVSDmZ3mTPbijgIBFiRuA8AHLoBsTe2bqMFjuxiIPhRP+Lchwwg=
X-Received: by 2002:a92:d5c5:: with SMTP id d5mr8196061ilq.63.1570090873314;
 Thu, 03 Oct 2019 01:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <c09509ef-982e-d4bd-ed0b-da8389a7d066@virtuozzo.com>
In-Reply-To: <c09509ef-982e-d4bd-ed0b-da8389a7d066@virtuozzo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 3 Oct 2019 10:21:02 +0200
Message-ID: <CAJfpegtSLNBHDSTEm9aRhi2J+8JNPnZjcBBB_j5cjA6NtqZZOg@mail.gmail.com>
Subject: Re: [PATCH] fuse: redundant get_fuse_inode() calls in fuse_writepages_fill()
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 19, 2019 at 7:48 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> Currently fuse_writepages_fill() calls get_fuse_inode() few times with
> the same argument.

Thanks, applied.

Miklos
