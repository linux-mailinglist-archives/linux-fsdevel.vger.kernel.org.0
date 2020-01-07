Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3972132EC3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 19:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgAGS4e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 13:56:34 -0500
Received: from mail-io1-f48.google.com ([209.85.166.48]:44442 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGS4e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 13:56:34 -0500
Received: by mail-io1-f48.google.com with SMTP id b10so392795iof.11;
        Tue, 07 Jan 2020 10:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOXk6Pcj/h1claA+ZposabxkWW+4bg9OU4mj2rRp8bM=;
        b=rFTmT4AHZMZ6vYQWAEDELCsFxBP/Fer9sy0dt8jUftWNc49g7SF7PnWXK+ehMlTKFS
         u0M/KnmY1Jps3AXX8UGH93M8FX5ZW4q1nKDKRuE9zS9XUmwPARoJxNhBntVx3RnjJRFQ
         gTm51uPQ7wqUrAa8cvSvAHAMc0jqKMt+X8CfqlmOZjA/mCoJrcbwhKwUJ5NLDUZbt58M
         EXBy0pDDGY9LutQw5iWbHFN/x9YwCYFMAFqJ5BKJrF/NDVcnjudzb8DpWj71s5g+KZC4
         dr0mphs/xzX3R7he7iSu67utF1zs1J/TQgg+SVvgUq9tde6yC6NRcEBMiEWqjunnmJLH
         HRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOXk6Pcj/h1claA+ZposabxkWW+4bg9OU4mj2rRp8bM=;
        b=TR4zJOqtJk7EfXL00vG8cEkQW/hZAS2nLPw7NvivVuGmoS0Pz0E1K6jGaYuTg/HinA
         0+QLEjXDZvWXepXs/q5sRHIcAh8ENyGPzvqxCoycD3HszefqtTDDSzAuRvURrNsuMCt0
         BJicnqSaOhH6Ttoj4VFzS4p4CXpnCxW5sMCY3Jw4gbGgFAKPSRoqbZvtq771NBP6II2Z
         iGE6ohngxxOIAzoy5mkQ/Umi6GEkbRivhsqHT+WkmyFDc/4GMpC55AJHMIao4bs0+pAK
         jNMuzzZ62NvCOkQNjCNcj9GgLqovb2sbX2aPYfMonVUaC2/HuCtbOgiBDDkbzXnJHxqg
         WITQ==
X-Gm-Message-State: APjAAAW6XhqpXmTPH8u4Jdq+OxPewCE24hpp7wVulBu7lXtEDE7TxeEU
        NggAL/JzCYqfi9Oe/H4fTEHbyzgy/qoCL2cNSQI=
X-Google-Smtp-Source: APXvYqyXBOpNzY9CZXZRx6OX2pdUy3aFWqumZv93Vq61mHpBbgzOkBIIKQI/V/vvEeDZlR83xK8CyXTBmZBtqf0yFvE=
X-Received: by 2002:a6b:5904:: with SMTP id n4mr328665iob.9.1578423392252;
 Tue, 07 Jan 2020 10:56:32 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxjda6iQ1D0QEVB18TcrttVpd7uac++WX0xAyLvxz0x7Ew@mail.gmail.com>
 <20191204190206.GA8331@bombadil.infradead.org> <CAOQ4uxiZWKCUKcpBt-bHOcnHoFAq+nghWmf94rJu=3CTc5VhRA@mail.gmail.com>
 <20191211100604.GL1551@quack2.suse.cz> <CAOQ4uxij13z0AazCm7AzrXOSz_eYBSFhs0mo6eZFW=57wOtwew@mail.gmail.com>
 <CAOQ4uxiKzom5uBNbBpZTNCT0XLOrcHmOwYy=3-V-Qcex1mhszw@mail.gmail.com>
 <CAOQ4uxgBcLPGxGVddjFsfWJvcNH4rT+GrN6-YhH8cz5K-q5z2g@mail.gmail.com>
 <20191223181956.GB17813@quack2.suse.cz> <CAOQ4uxhUGCLQyq76nqREETT8kBV9uNOKsckr+xmJdR9Xm=cW3Q@mail.gmail.com>
 <CAOQ4uxjwy4_jWitzHc9hSaBJwVZM68xxJTub50ZfrtgFSZFH8A@mail.gmail.com> <20200107171014.GI25547@quack2.suse.cz>
In-Reply-To: <20200107171014.GI25547@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 7 Jan 2020 20:56:20 +0200
Message-ID: <CAOQ4uxjx_n3f44yu9_2dGxtBGy3WssG0xfZykwjQ+n=Wcii2-w@mail.gmail.com>
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

On Tue, Jan 7, 2020 at 7:10 PM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 24-12-19 05:49:42, Amir Goldstein wrote:
> > > > I can see the need for FAN_DIR_MODIFIED_WITH_NAME
> > > > (stupid name, I know) - generated when something changed with names in a
> > > > particular directory, reported with FID of the directory and the name
> > > > inside that directory involved with the change. Directory watching
> > > > application needs this to keep track of "names to check". Is the name
> > > > useful with any other type of event? _SELF events cannot even sensibly have
> > > > it so no discussion there as you mention below. Then we have OPEN, CLOSE,
> > > > ACCESS, ATTRIB events. Do we have any use for names with those?
> > > >
> > >
> > > The problem is that unlike dir fid, file fid cannot be reliably resolved
> > > to path, that is the reason that I implemented  FAN_WITH_NAME
> > > for events "possible on child" (see branch fanotify_name-wip).
>
> Ok, but that seems to be a bit of an abuse, isn't it? Because with parent
> fid + name you may reconstruct the path but you won't be able to reliably
> identify the object where the operation happened? Even worse users can
> mistakenly think that parent fid + name identify the object but that is
> racy... This is exactly the kind of confusion I'd like to avoid with the
> new API.
>
> OTOH I understand that e.g. a file monitor may want to monitor CLOSE_WRITE
> like you mention below just to record directory FID + name as something
> that needs resyncing. So I agree that names in events other than directory
> events are useful as well. And I also agree that for that usecase what you
> propose would be fine.
>
> > > A filesystem monitor typically needs to be notified on name changes and on
> > > data/metadata modifications.
> > >
> > > So maybe add just two new event types:
> > > FAN_DIR_MODIFY
> > > FAN_CHILD_MODIFY
> > >
> > > Both those events are reported with name and allowed only with init flag
> > > FAN_REPORT_FID_NAME.
> > > User cannot filter FAN_DIR_MODIFY by part of create/delete/move.
> > > User cannot filter FAN_CHILD_MODIFY by part of attrib/modify/close_write.
> >
> > Nah, that won't do. I now remember discussing this with out in-house monitor
> > team and they said they needed to filter out FAN_MODIFY because it was too
> > noisy and rely on FAN_CLOSE_WRITE. And other may want open/access as
> > well.
>
> So for open/close/modify/read/attrib I don't see a need to obfuscate the
> event type. They are already abstract enough so I don't see how they could
> be easily misinterpretted. With directory events the potential for
> "optimizations" that are subtly wrong is IMHO much bigger.
>

OK, that simplifies things quite a bit.

> > There is another weird way to obfuscate the event type.
> > I am not sure if users will be less confused about it:
> > Each event type belongs to a group (i.e. self, dirent, poss_on_child)
> > User may set any event type in the mask (e.g. create|delete|open|close)
> > When getting an event from event group A (e.g. create), all event types
> > of that group will be reported (e.g. create|delete).
> >
> > To put it another way:
> > #define FAN_DIR_MODIFY (FAN_CREATE | FAN_MOVE | FAN_DELETE)
> >
> > For example in fanotify_group_event_mask():
> > if (event_with_name) {
> >     if (marks_mask & test_mask & FAN_DIR_MODIFY)
> >         test_mask |= marks_mask & FAN_DIR_MODIFY
> > ...
> >
> > Did somebody say over-engineering? ;)
> >
> > TBH, I don't see how we can do event type obfuscation
> > that is both usable and not confusing, because the concept is
> > confusing. I understand the reasoning behind it, but I don't think
> > that many users will.
> >
> > I'm hoping that you can prove me wrong and find a way to simplify
> > the API while retaining fair usability.
>
> I was thinking about this. If I understand the problem right, depending on
> the usecase we may need with each event some subset of 'object fid',
> 'directory fid', 'name in directory'. So what if we provided all these
> three things in each event? Events will get somewhat bloated but it may be
> bearable.
>

I agree.

What I like about the fact that users don't need to choose between
'parent fid' and 'object fid' is that it makes some hard questions go away:
1. How are "self" events reported? simple - just with 'object id'
2. How are events on disconnected dentries reported? simple - just
with 'object id'
3. How are events on the root of the watch reported? same answer

Did you write 'directory fid' as opposed to 'parent fid' for a reason?
Was it your intention to imply that events on directories (e.g.
open/close/attrib) are
never reported with 'parent fid' , 'name in directory'?

I see no functional problem with making that distinction between directory and
non-directory, but I have a feeling that 'parent fid', 'name in
directory', 'object id',
regardless of dir/non-dir is going to be easier to document and less confusing
for users to understand, so this is my preference.

> With this information we could reliably reconstruct (some) path (we always
> have directory fid + name), we can reliably identify the object involved in
> the change (we always have object fid). I'd still prefer if we obfuscated
> directory events, without possibility of filtering based of
> CREATE/DELETE/MOVE (i.e., just one FAN_DIR_MODIFY event for this fanotify
> group) - actually I have hard time coming with a usecase where application
> would care about one type of event and not the other one. The other events
> remain as they are. What do you think?

That sounds like a plan.
I have no problem with the FAN_DIR_MODIFY obfuscation.

Will re-work the patches and demo.

Thanks,
Amir.
