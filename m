Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88949152219
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 22:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgBDVxE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 16:53:04 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38517 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbgBDVxE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 16:53:04 -0500
Received: by mail-wm1-f65.google.com with SMTP id a9so304876wmj.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2020 13:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zI4HQ9EHGueB8CLG4OLQwHdUL6JYrMc1+B8KS6FEh8M=;
        b=nF2a3cPa3Ab2CImABgRNz5mLOvYz7D7E00fEtLY9dKeN8m2dOFhVRsnG/b+2fR5zue
         Q4jQbC6/bk9IHu3Z2q+prLVoqIBRKeABXlDBDljIIhDIvK+AnSYssFg3IZIN0ZKKl125
         ilUQSc+yuqiZUw4I0/e6iWFZk7N3WVNXOnhe/2WbyHgyRdmurO11rbixULyKQ6p0WBJL
         tpf8k/WTu0kYKehVLt+qZfnbqD5O13VU062q91/oLpnsA0nyV+x/AuOkzlJONaIFMAVO
         cPNcLnAI4zCl7ciO/iF56q2cqzkh7sdjoP9R500desOJZyQem3Sa32RbMmmG1dIEEHNp
         Biuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zI4HQ9EHGueB8CLG4OLQwHdUL6JYrMc1+B8KS6FEh8M=;
        b=dMKcw/ZyPTayYrrBZ9LduNfsifCDEPJDODYnk5JDJxY0ZG+qS8lIAXC2RG68OpcTxw
         JGJtXYO9UuoY5wgbFTCxBl76KP6p9kpvyozzxS2h341fgVneaGtI0c0NMiDepML067ba
         GzPFCIpjM95EeMJTB3msibNYSatAyFbji55Hxud1snBkjblLOxSDgm1wD5lXS+X1dyRM
         RSEUI9KnORKSQD2SP2+L2eX9w+Kek8w/df+HnJMVF1wXMmlHlQr0Z3Pnl8iwAtNXXfEk
         nOpzkiWBYrF7xjLHeNMHp0L8uEzJy6YpLeQ5wVm/kNTErwE3VPQLe/jxFXS1HZSGlyDw
         4U1Q==
X-Gm-Message-State: APjAAAX53D88HbtdsqNxoVwsUbesIYkgqUAQGWqjzUCgdf2/Br86dff+
        VKHXqITR7Ey+KYOy0f2FvKgA8+/GWiNabMu1YLBNPg==
X-Google-Smtp-Source: APXvYqzC4WBQeZFnp2oWsogdZ63yMs2kPKtYlTucpym/9YzzZrs9PnHmSupb23TD/618hwkXM+36zQpeIyud5CySCMg=
X-Received: by 2002:a1c:ddd6:: with SMTP id u205mr1122933wmg.151.1580853181775;
 Tue, 04 Feb 2020 13:53:01 -0800 (PST)
MIME-Version: 1.0
References: <20200204215014.257377-1-zwisler@google.com>
In-Reply-To: <20200204215014.257377-1-zwisler@google.com>
From:   Raul Rangel <rrangel@google.com>
Date:   Tue, 4 Feb 2020 14:52:50 -0700
Message-ID: <CAHQZ30BgsCodGofui2kLwtpgzmpqcDnaWpS4hYf7Z+mGgwxWQw@mail.gmail.com>
Subject: Re: [PATCH v5] Add a "nosymfollow" mount option.
To:     Ross Zwisler <zwisler@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Mattias Nissler <mnissler@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Benjamin Gordon <bmgordon@google.com>,
        Ross Zwisler <zwisler@google.com>,
        Micah Morton <mortonm@google.com>,
        Dmitry Torokhov <dtor@google.com>, Jan Kara <jack@suse.cz>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> --- a/include/uapi/linux/mount.h
> +++ b/include/uapi/linux/mount.h
> @@ -34,6 +34,7 @@
>  #define MS_I_VERSION   (1<<23) /* Update inode I_version field */
>  #define MS_STRICTATIME (1<<24) /* Always perform atime updates */
>  #define MS_LAZYTIME    (1<<25) /* Update the on-disk [acm]times lazily */
> +#define MS_NOSYMFOLLOW (1<<26) /* Do not follow symlinks */
Doesn't this conflict with MS_SUBMOUNT below?
>
>  /* These sb flags are internal to the kernel */
>  #define MS_SUBMOUNT     (1<<26)
