Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86681222493
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 16:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgGPN77 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 09:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729147AbgGPN74 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:59:56 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF30C08C5CE
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 06:59:56 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id i18so5102448ilk.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 06:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bdkQjTl9YT4De4hIvtdv9tqZOUbpCIox3m108UK//Es=;
        b=rskd09gNEfp0ZnW8QmgfW8IKoxacW1yMGAbHOS0H0Tz5O1HhL3n+azWpHpanw4UKNV
         g8MbZIY7zJHAf8Toc0mDxK3blGtEirTKPQZOZV3VoR/0vQMMcRsI5TMpfJ12mAqx66Ua
         JELpC57Ac1CnjiueV+JWWM9decVD8+AuF+Zt1iotX4SeyknJBsugDdgbrPI4KXWN8qe8
         84DtTlF9f3UrKJ9DL48ePsFjx2ZVV1QbPTSqzC8c3fklCTLy2cG5TiyUyDsdzHsuMz/x
         bvrB8QBKWyN/JV6NaS0C1uA1il1E0aHlpHsnflRP8X7ilqG5vmd1lBtnCgOHuWquUfSj
         tGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bdkQjTl9YT4De4hIvtdv9tqZOUbpCIox3m108UK//Es=;
        b=rTIeVh/sivt4nkFxqpl5eQL9T9KRoKTJ2FagmwQUvpsZo/kyprgcaXFq4i2lRVUuei
         3kS/HzEjsXaq1TEGxKDoUk393B5RRe/SosSM+vjhYDDdeREGrF1bex5VYEWKbc0zZMi6
         xQxrJ4PrS8xt/JcHOcA4Eo0xLE6C14FjV3j9VkLBX1CG3iGpZiLNI7lyD/aYTkwNNcxP
         mkxRfYt5iyklYx0AIeOE/bOjJesiF//YWsvonig8GwPv5HhpIhWIftLrp6s82zOpMfOj
         rwK/c1vviZrQ+S9D/mcFdDSD5pTMYMWZzypUuhhWrr51mG3OWyTxk7HMU6OHENSs4q5T
         BMog==
X-Gm-Message-State: AOAM531sSJAFFuSmN6EZ3tAZbaFBZXNtJ3KgsHF+47b8H3iAjSazyWIk
        QbE/21fqTDkaJEbtZWx02WFFcSlBueFFR+mNmGyF1Q==
X-Google-Smtp-Source: ABdhPJyKiF113AUjyzfBQmZn+Qt4nGws/uK4WVJShHSDC0gbRw9d8JWyyQKjwuHhtbCAB94WaggCQJ1QfoRitOER8mg=
X-Received: by 2002:a92:490d:: with SMTP id w13mr4735775ila.250.1594907996111;
 Thu, 16 Jul 2020 06:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200716084230.30611-1-amir73il@gmail.com> <20200716084230.30611-18-amir73il@gmail.com>
 <20200716134556.GE5022@quack2.suse.cz>
In-Reply-To: <20200716134556.GE5022@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 16 Jul 2020 16:59:44 +0300
Message-ID: <CAOQ4uxiYAviCUAzp0oz8dEmDzJvCW1z_Cyh0FiCONH7kY72rFQ@mail.gmail.com>
Subject: Re: [PATCH v5 17/22] fsnotify: send MOVE_SELF event with parent/name info
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 4:45 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 16-07-20 11:42:25, Amir Goldstein wrote:
> > MOVE_SELF event does not get reported to a parent watching children
> > when a child is moved, but it can be reported to sb/mount mark or to
> > the moved inode itself with parent/name info if group is interested
> > in parent/name info.
> >
> > Use the fsnotify_parent() helper to send a MOVE_SELF event and adjust
> > fsnotify() to handle the case of an event "on child" that should not
> > be sent to the watching parent's inode mark.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> What I find strange about this is that the MOVE_SELF event will be reported
> to the new parent under the new name (just due to the way how dentry
> handling in vfs_rename() works). That seems rather arbitrary and I'm not
> sure it would be useful? I guess anybody needing dir info with renames
> will rather use FS_MOVED_FROM / FS_MOVED_TO where it is well defined?
>
> So can we leave FS_MOVE_SELF as one of those cases that doesn't report
> parent + name info?
>

I can live with that.
I didn't have a use case for it.
This patch may be dropped from the series without affecting the rest.

Thanks,
Amir.
