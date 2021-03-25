Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8F83494E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 16:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhCYPGN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 11:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhCYPFu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 11:05:50 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EF9C06174A;
        Thu, 25 Mar 2021 08:05:50 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id z9so2396491ilb.4;
        Thu, 25 Mar 2021 08:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T0ZXskV+v2eOjijTKmp/FmZzZMW02GfP2dSDhj5SEdU=;
        b=PwnqSDf3Wburv79I41iv5iPvrkqRFOuvYpe65c7xucgerxvaD7QQsoVhWWR8dlsPpN
         qsHGdr65tBhmuyoKyZOGKAnLl/3jNcoSnZ7lwSkjUyvsHQIGYFK3Ao2yKU3uyAuMLAl0
         e7ON/OlduZlycrkfLGc+z/xNz1wHh9Nxqa9IckFUsstLS7RWL/WG1Dgl66eMGWoHeHuT
         jW11Uyz6jqmyxU+VgqX7j9QAVwzjsfJqs2maX5PdX8PTv5c4alRA7TbICK8R3eizqXE3
         9J4rf433uM+/Myx38wpwR1hdei7u3IGt78t5HR8sKVagvoXM2EPTEaduGe8HMsM9Uk77
         GZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T0ZXskV+v2eOjijTKmp/FmZzZMW02GfP2dSDhj5SEdU=;
        b=nWnfeoVR2tJxJu156w5NDulo2kw5HSNBuphX3tkeuiQBOXyfhonwh3HzfV6yDXa+te
         D8sdBjvA0PkA1DE4usgfZiJr7be349SwfE5MOP5j+2Z6cjVHMo+ISFy+uiNZ/eIat/EC
         VC+VN54Edr6NBcfSkb1/X4Uq3k5IGBzM5lIzwNuN+WDH0AAcmZpCmbqv3egkdO9ofDOG
         DmofjxFDR62naxa6u7x+JgjbUfH8gC2OQllPqSZCAD1jZOOrjnMWWhcY5nsO7riwhkYJ
         lLMctMaPli8TQeGOIPd/mcNYMQqIsavI1TUFw2bU71oaWavi8CZnLoAfTWygGkbC7Qxi
         DrcQ==
X-Gm-Message-State: AOAM533GRE13/WjbS9VKdE6i5D+vcL3CZit2J1CbdC0ZLLB1bT9i+4RS
        wStPwK8lgsfToLlaBAL9oig6cRE1VlQZhrTLLd+bdgtqqXA=
X-Google-Smtp-Source: ABdhPJy17+6geo4Uz+QIoKyy13gLIJlvdxVHd3+jbggeKOAYweSa7Jvm8a6QCk4swbbjEX9mzWpe4noRnwIl1v1rLcg=
X-Received: by 2002:a92:b74e:: with SMTP id c14mr1017326ilm.275.1616684749932;
 Thu, 25 Mar 2021 08:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210304112921.3996419-1-amir73il@gmail.com> <20210316155524.GD23532@quack2.suse.cz>
 <CAOQ4uxgCv42_xkKpRH-ApMOeFCWfQGGc11CKxUkHJq-Xf=HnYg@mail.gmail.com>
 <20210317114207.GB2541@quack2.suse.cz> <CAOQ4uxi7ZXJW3_6SN=vw_XJC+wy4eMTayN6X5yRy_HOV6323MA@mail.gmail.com>
 <20210318154413.GA21462@quack2.suse.cz> <CAOQ4uxhpB+1iFSSoZy2NuF2diL=8uJ-j8JJVNnujqtphW147cw@mail.gmail.com>
 <CAOQ4uxj4OC5cSwJMizBG=bmarxMwSVfqYnds4wYabieEDM_+eQ@mail.gmail.com>
 <20210324114847.GA17458@quack2.suse.cz> <CAOQ4uxgjM8qC-Kre9ahMQzzhsOFtCXu4Vzd2HYUsSOstgf9Jyw@mail.gmail.com>
 <20210325134924.GA13673@quack2.suse.cz>
In-Reply-To: <20210325134924.GA13673@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 25 Mar 2021 17:05:38 +0200
Message-ID: <CAOQ4uxjR300J9UZoS=LbdqPk-=edeN9drOfos-QYOdx=huYQVw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] unprivileged fanotify listener
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > I would like the system admin to be able to limit 100 sb marks on /home
> > (filtered or not) because that impacts the send_to_group iteration.
>
> OK, so per-sb limitation of sb mark number...
>
> > I would also like systemd to be able to grant a smaller quota of filtered
> > sb marks per user when creating and mapping the idmapped mounts
> > at /home/foo$N
>
> ... and a ucount to go with it?
>
> > I *think* we can achieve that, by accounting the sb marks to uid 0
> > (who mounted /home) in ucounts entry "fanotify_sb_marks".
>
> But a superblock can be mounted in multiple places, in multiple user
> namespaces, potentially by different users (think of nested containers)? So
> if we want a per-sb limit on sb marks, I think that accounting those per
> user won't really achieve that?
>

I agree. It won't.
We can start with the global max_fanotify_sb_marks.
I do not have an idea how to make that workable using ucounts.

Thanks,
Amir.
