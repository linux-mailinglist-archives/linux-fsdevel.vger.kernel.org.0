Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18EA124ED4A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Aug 2020 15:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgHWNEw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Aug 2020 09:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgHWNEv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Aug 2020 09:04:51 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332A1C061573
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Aug 2020 06:04:51 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id m23so5413536iol.8
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Aug 2020 06:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hGMvms2xVf+agxOId6Q5JQfaDwLsbkP+HKlV2az1+t4=;
        b=lBEq/UkJ+i6FitqQl6cKqdRkGPj7VTPKPkqhYgQbGiFHSaupgfEdqdy5xDtFmfwn9S
         P/pbVZcp4P6ds1PTdxmCrsRukBEZ3ZTZUcdADEjlxgWbWFm7IxveNTQ2t9Y4+6fK87P2
         ucjRLw+KbyKtYLPWTmp2DTMEnNrhsd5SSg1Sh/t5B86W6a61SYvH5rFN+3YIm/u3Z3mE
         M0gt+YQ4G8b1l5qsS8UxmQCEv++GDVR+1my7d/ihiJDB78OPb4USkZffvPPXSctMJiqI
         T7ZlHC8Up9eP2+eK8PsN35hVhaUJIBII6OgENPt2rAuOTanycwtBtL9UR9z73b2tns0g
         fMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hGMvms2xVf+agxOId6Q5JQfaDwLsbkP+HKlV2az1+t4=;
        b=qfH7wswTotVOY0DaylTKS0BIjgoXuAJuzWM03KoYU+ypaBZ9NUvWVuh97o1QVcQ4yJ
         MMhtg/SPOHfNpd6+l+olRIxQj9Ngp1DfGNiyzdazAjkJzNn5SSVaX5MiN5Q4dY84WnQz
         0fSO8vT+SzHCZw+NGrzWtihAPJbSFM4c+xeOivh7ciylZdIskt+SoFttcBEcOn3WoWr7
         /cTxT3Mcv8cqBLNyvRTpscb2pxZX26o3p0FXD+pPXvndI/rvSl0J58GQtA1AniQsfqz+
         CGo7l1EfYQKMMH0i3pRRvrp2axl6PK3hRLnnn0c/JPJV3xVSVJVPmHKkvG/9wf819lhN
         FxRA==
X-Gm-Message-State: AOAM530+A5zdonyiEGTUZG7lUEF/SihwUY9Pw5/rvCCWGOfWPzr0mffp
        0KqEUqx+6gUKozKy1l05dVTHNer7sY9hmBA9uW+PsfczfcM=
X-Google-Smtp-Source: ABdhPJznZt5/wxaFaPuiyq+abI9h7kKEGRc7AIZtG3beSeOcNLlCC9YPO0+XjGZ4m2RCat+/4cSroLGwiclF6skkETk=
X-Received: by 2002:a05:6602:1d6:: with SMTP id w22mr1066977iot.64.1598187890506;
 Sun, 23 Aug 2020 06:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <dde082eb-b3eb-859e-b442-a65846cff6fa@mail.de> <CAOQ4uxjEm=vj5Be5VoUyB9Q+YVq=+aO_4PfXp-iEYZA7qzO1Gw@mail.gmail.com>
 <9def9581-cc09-7a79-ea27-e9b8b75bbd6a@mail.de>
In-Reply-To: <9def9581-cc09-7a79-ea27-e9b8b75bbd6a@mail.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 23 Aug 2020 16:04:39 +0300
Message-ID: <CAOQ4uxiTCKrVBCjYrBsNWjRad+Tt_cONfD-nQCBr8x=TyLb_ww@mail.gmail.com>
Subject: Re: fanotify feature request FAN_MARK_PID
To:     Tycho Kirchner <tychokirchner@mail.de>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Any further help is appreciated.
>

A patch along those line (fill in the missing pieces) looks useful to me.
It could serve a use case where applications are using fanotify filesystem
mark, but developer would like to limit those application's scope inside
"system containers".

Perhaps an even more useful API would be FAN_FILTER_MOUNT_NS.
FAN_FILTER_PID_NS effectively means that kernel will drop events
that are expected to report pid 0.
FAN_FILTER_MOUNT_NS would mean that kernel will drop events that
are expected to report an fd, whose /proc/<pid>/fd/<fd> symlink cannot
be resolved (it shows "/") because the file's mount is outside the scope
of the listener's mount namespace.

The burden of proof that this will be useful is still on you ;-)

Thanks,
Amir.

--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -685,6 +685,11 @@ static int fanotify_handle_event(struct
fsnotify_group *group, u32 mask,

        pr_debug("%s: group=%p mask=%x\n", __func__, group, mask);

+       /* Interested only in events from group's pid ns */
+       if (FAN_GROUP_FLAG(group, FAN_FILTER_PID_NS) &&
+           !pid_nr_ns(task_pid(current), group->fanotify_data.pid_ns))
+               return 0;
+
        if (fanotify_is_perm_event(mask)) {
                /*
                 * fsnotify_prepare_user_wait() fails if we race with mark
