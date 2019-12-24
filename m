Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3165F129D27
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2019 04:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfLXDty (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Dec 2019 22:49:54 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:37573 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfLXDty (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Dec 2019 22:49:54 -0500
Received: by mail-il1-f193.google.com with SMTP id t8so15634988iln.4;
        Mon, 23 Dec 2019 19:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/708R472+qTd5WDXzJfQhTlWRyfvA2l4g2vikkLt5ws=;
        b=AkoNtmpyEhOvM3YAPGE9OTpvqbr5VtvVLLL3SCRdrAnNN5t8heVxGuQbdPpkxeimfR
         fG137NwEtN/qpXA3ztJ8uammLbMSzKU+D8xpwE7p4ZM/MTdz6SwrHcUxRLRpTQxBXY3t
         LfZW0I4AvVhPVWOc2eesP5CLPOrcQA8zMEpMyPKzqHLgd72dnPNgCFV6Wd7GyuTQThHk
         Kt26JdtnEiJG3F9jitVdCBdbwHvKUIUNM8t0y12VeoKikH3gY4BHHpCP18Y/Ng+Ua3Vd
         D9sHo7R7kgKHwj+CrwqGIkk74vZr4MG2yEHsPGFgdZV+iAXuBs+xE5Q0jH7gF3Fgtlm7
         zZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/708R472+qTd5WDXzJfQhTlWRyfvA2l4g2vikkLt5ws=;
        b=A1Gaty5PnuGhZZAFKV5jDb1nYFY5dhrfaoi1A3GbBjORYwvg6vzLToXY3y5ntNSuvo
         ueGoMG/skdYasWu2W185FzSkvXlWR/m6QsLBzqQHqbUmJh41pP4h7GmJQJrFCyRW+YJX
         re5ajZFska0TaqIDlR6haKN/1d+qMsrModTBNgoMDYSFDoqhpD8Hn9V2tZcyjxgLkF5d
         9NnrZ0noUNcK3tmwmuQI6CEAnaR+Ip/bWAImiDpI97VJ0b2HjCk8T8LAF5asfiZsYvpO
         2tCVo8E/uBsvmEsHMvjOxyn4b7vHWBxEg2h9gqoMijOkzuR7pyExrwgv6ZB/GAKKoGne
         WmRQ==
X-Gm-Message-State: APjAAAVtw7CDU92Cgd3Ko8FsaS5HSSmUYmXI+tTf8G0uUdXX9qaz1Iep
        2MTsaCRmDTqChpcp8NYbjJnNOvGcodX4yIb415EUcegz
X-Google-Smtp-Source: APXvYqy0EHmcYMYrThIaT9/S4+q2UJbA1cLcAQ/FJYHemQMRtjp3vJeoUVoEYrsUQpDmSPIXGJqwi8BIalK6bl5cvKQ=
X-Received: by 2002:a92:1711:: with SMTP id u17mr28780981ill.72.1577159393911;
 Mon, 23 Dec 2019 19:49:53 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxiKqEq9ts4fEq_husQJpus29afVBMq8P1tkeQT-58RBFg@mail.gmail.com>
 <CADKPpc33UGcuRB9p64QoF8g88emqNQB=Z03f+OnK4MiCoeVZpg@mail.gmail.com>
 <20191204173455.GJ8206@quack2.suse.cz> <CAOQ4uxjda6iQ1D0QEVB18TcrttVpd7uac++WX0xAyLvxz0x7Ew@mail.gmail.com>
 <20191204190206.GA8331@bombadil.infradead.org> <CAOQ4uxiZWKCUKcpBt-bHOcnHoFAq+nghWmf94rJu=3CTc5VhRA@mail.gmail.com>
 <20191211100604.GL1551@quack2.suse.cz> <CAOQ4uxij13z0AazCm7AzrXOSz_eYBSFhs0mo6eZFW=57wOtwew@mail.gmail.com>
 <CAOQ4uxiKzom5uBNbBpZTNCT0XLOrcHmOwYy=3-V-Qcex1mhszw@mail.gmail.com>
 <CAOQ4uxgBcLPGxGVddjFsfWJvcNH4rT+GrN6-YhH8cz5K-q5z2g@mail.gmail.com>
 <20191223181956.GB17813@quack2.suse.cz> <CAOQ4uxhUGCLQyq76nqREETT8kBV9uNOKsckr+xmJdR9Xm=cW3Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxhUGCLQyq76nqREETT8kBV9uNOKsckr+xmJdR9Xm=cW3Q@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 24 Dec 2019 05:49:42 +0200
Message-ID: <CAOQ4uxjwy4_jWitzHc9hSaBJwVZM68xxJTub50ZfrtgFSZFH8A@mail.gmail.com>
Subject: Re: File monitor problem
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mo Re Ra <more7.rev@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Wez Furlong <wez@fb.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > I can see the need for FAN_DIR_MODIFIED_WITH_NAME
> > (stupid name, I know) - generated when something changed with names in a
> > particular directory, reported with FID of the directory and the name
> > inside that directory involved with the change. Directory watching
> > application needs this to keep track of "names to check". Is the name
> > useful with any other type of event? _SELF events cannot even sensibly have
> > it so no discussion there as you mention below. Then we have OPEN, CLOSE,
> > ACCESS, ATTRIB events. Do we have any use for names with those?
> >
>
> The problem is that unlike dir fid, file fid cannot be reliably resolved
> to path, that is the reason that I implemented  FAN_WITH_NAME
> for events "possible on child" (see branch fanotify_name-wip).
>
> A filesystem monitor typically needs to be notified on name changes and on
> data/metadata modifications.
>
> So maybe add just two new event types:
> FAN_DIR_MODIFY
> FAN_CHILD_MODIFY
>
> Both those events are reported with name and allowed only with init flag
> FAN_REPORT_FID_NAME.
> User cannot filter FAN_DIR_MODIFY by part of create/delete/move.
> User cannot filter FAN_CHILD_MODIFY by part of attrib/modify/close_write.

Nah, that won't do. I now remember discussing this with out in-house monitor
team and they said they needed to filter out FAN_MODIFY because it was too
noisy and rely on FAN_CLOSE_WRITE. And other may want open/access as
well.

There is another weird way to obfuscate the event type.
I am not sure if users will be less confused about it:
Each event type belongs to a group (i.e. self, dirent, poss_on_child)
User may set any event type in the mask (e.g. create|delete|open|close)
When getting an event from event group A (e.g. create), all event types
of that group will be reported (e.g. create|delete).

To put it another way:
#define FAN_DIR_MODIFY (FAN_CREATE | FAN_MOVE | FAN_DELETE)

For example in fanotify_group_event_mask():
if (event_with_name) {
    if (marks_mask & test_mask & FAN_DIR_MODIFY)
        test_mask |= marks_mask & FAN_DIR_MODIFY
...

Did somebody say over-engineering? ;)

TBH, I don't see how we can do event type obfuscation
that is both usable and not confusing, because the concept is
confusing. I understand the reasoning behind it, but I don't think
that many users will.

I'm hoping that you can prove me wrong and find a way to simplify
the API while retaining fair usability.

Thanks,
Amir.
