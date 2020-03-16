Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B70BA1872F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Mar 2020 20:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732376AbgCPTCp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Mar 2020 15:02:45 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:43793 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732298AbgCPTCp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Mar 2020 15:02:45 -0400
Received: by mail-il1-f193.google.com with SMTP id d14so17101418ilq.10;
        Mon, 16 Mar 2020 12:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=chjWHVuom4ZfeP5zCTPxwSF15SF5FqtFAtdtkGRn8D8=;
        b=nn4T3ea3linZW9wUG7rC2nqWYqOr3ruRP3iMZFzV1ftD/G9PDhetOlyJqOrUkvxlJm
         W6O6VufBNPjBKSZh9J3+xBzasV8F8ls7j1sg88NO+cmQqC21sdFVxoU8n2gatqo9IebD
         LOBW/skpTdsmVkDOUC1KRJgw7/X4pfY570haflK5aBv98cyFRuEbZjdCytlOFZ5ePTGx
         l7/sS+xhZ3b1aCJCnzkz7Qa77wn6i6RF+gIOxkHG9rP9NTcsSQFZVEiR5kiYSK2KF4+q
         dXMs7Cwscc+56r5GrunH73KoDMcjPWDhGeirt5RfcguQ4Cz0YCefbx1CTab/PapB72PE
         oZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=chjWHVuom4ZfeP5zCTPxwSF15SF5FqtFAtdtkGRn8D8=;
        b=l9rEULtTN9PbYO7CESWm/jW/UOI6wP4xhEK1USpwLeqF9yYtaAurxu+M+Qy7AtDWtB
         heQJuigiZgG0jdnf8IZIhnU5+7bEUh+5jSixfOmy+cuUlz3iNoHC/W1IrBHlRCrimgJX
         lZrk0mPOQtSeRvGx7ua5sx5ttP5qzepdS+oLXlNQGhxnqINfNtB3uow9VBj4zfbBs4lt
         U/FvhEbM4MDhg3uxqxqFDJ5w8sWS3pdOo6+0vwKAPwGymf7MT79phmgrMXOAXEWp8u/Z
         DVjzYX2R4TSwEULn9vIQyyhdWRqKINbiyGUZ6gKC7s2zDIXzP4BuyJK8soHE49l+ZlCl
         MdNQ==
X-Gm-Message-State: ANhLgQ27AIWdstQs0rD2vDY0NvuaRoNwN573JHQ2Vfq/uFwVORB53VOv
        3BsP5l1HYWFVFIRgHg3tyoZ8m9+4sDO3RftSn2Y=
X-Google-Smtp-Source: ADFU+vtUp4WdUsZQRLt/aDw26p7dzvd5I6iOAp0ayf/PIBmWCrLq08zv4bC5vNdDOrreOfI6kF3qk4+ODpuDzFmQh58=
X-Received: by 2002:a92:9f1a:: with SMTP id u26mr1306872ili.72.1584385364022;
 Mon, 16 Mar 2020 12:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200131115004.17410-1-mszeredi@redhat.com> <20200131115004.17410-5-mszeredi@redhat.com>
 <20200204145951.GC11631@redhat.com> <CAJfpegtq4A-m9vOPwUftiotC_Xv6w-dnhCi9=E0t-b1ZPJXPGw@mail.gmail.com>
 <CAOQ4uxj_pVp9-EN2Gmq9j6G3xozzpK_zQiRO-brx6PZ9VpgD0Q@mail.gmail.com>
 <CAOQ4uxjFYO28r+0pY+pKxK-dDJcQF2nf2EivnOUBgrgkYTFjPQ@mail.gmail.com>
 <CAOQ4uxhZ8a2ObfB9sUtrc=95mM70qurLtXkaNyHOXYxGEKvxFw@mail.gmail.com>
 <CAOQ4uxhkd5FkN5ynpQxQ0m1MR9MgzTBbvzjkoHfSRA2umb-JTA@mail.gmail.com> <20200316175453.GB4013@redhat.com>
In-Reply-To: <20200316175453.GB4013@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 16 Mar 2020 21:02:32 +0200
Message-ID: <CAOQ4uxgfTJwE2O1GGt-TY+6ijjKE13+ATTarijFGLiM69jk8HA@mail.gmail.com>
Subject: Re: [PATCH 4/4] ovl: alllow remote upper
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 16, 2020 at 8:15 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Sat, Mar 14, 2020 at 03:16:28PM +0200, Amir Goldstein wrote:
> > On Thu, Feb 20, 2020 at 10:00 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Thu, Feb 20, 2020 at 9:52 AM Amir Goldstein <amir73il@gmail.com> wrote:
> > > >
> > > > On Tue, Feb 4, 2020 at 7:02 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > >
> > > > > On Tue, Feb 4, 2020 at 6:17 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > > > >
> > > > > > On Tue, Feb 4, 2020 at 3:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > > > >
> > > > > > > On Fri, Jan 31, 2020 at 12:50:04PM +0100, Miklos Szeredi wrote:
> > > > > > > > No reason to prevent upper layer being a remote filesystem.  Do the
> > > > > > > > revalidation in that case, just as we already do for lower layers.
> > > > > > > >
> > > > > > > > This lets virtiofs be used as upper layer, which appears to be a real use
> > > > > > > > case.
> > > > > > >
> > > > > > > Hi Miklos,
> > > > > > >
> > > > > > > I have couple of very basic questions.
> > > > > > >
> > > > > > > - So with this change, we will allow NFS to be upper layer also?
> > > > > >
> > > > > > I haven't tested, but I think it will fail on the d_type test.
> > > > >
> > > > > But we do not fail mount on no d_type support...
> > > > > Besides, I though you were going to add the RENAME_WHITEOUT
> > > > > test to avert untested network fs as upper.
> > > > >
> > > >
> > > > Pushed strict remote upper check to:
> > > > https://github.com/amir73il/linux/commits/ovl-strict-upper
> > > >
> >
> > Vivek,
> >
> > Could you please make sure that the code in ovl-strict-upper branch
> > works as expected for virtio as upper fs?
>
> Hi Amir,
>
> Right now it fails becuase virtiofs doesn't seem to support tmpfile yet.
>
> overlayfs: upper fs does not support tmpfile
> overlayfs: upper fs missing required features.
>
> Will have to check what's required to support it.
>
> I also wanted to run either overlay xfstests or unionmount-testsuite. But
> none of these seem to give me enough flexibility where I can specify
> that overlayfs needs to be mounted on top of virtiofs.
>
> I feel that atleast for unionmount-testsuite, there should be an
> option where we can simply give a target directory and tests run
> on that directory and user mounts that directory as needed.
>

Need to see how patches look.
Don't want too much configuration complexity, but I agree that some
flexibly is needed.
Maybe the provided target directory should be the upper/work basedir?

> > I have rebased it on latest overlayfs-next merge into current master.
> >
> > I would very much prefer that the code merged to v5.7-rc1 will be more
> > restrictive than the current overlayfs-next.
>
> In general I agree that if we want to not support some configuration
> with remote upper, this is the time to introduce that restriction
> otherwise we will later run into backward compatibility issue.
>
> Having said that, tmpfile support for upper sounds like a nice to
> have feature. Not sure why to make it mandatory.
>

Agreed, I just went automatic on all the warnings.
tmpfile should not be a requirement for upper.
Could you please verify that if dropping the tmpfile strict check,
virtio can be used as upper.

Thanks,
Amir.
