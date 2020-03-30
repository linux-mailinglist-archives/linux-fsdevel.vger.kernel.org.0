Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 713BB19846E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 21:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgC3T3a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 15:29:30 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34735 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbgC3T33 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 15:29:29 -0400
Received: by mail-io1-f65.google.com with SMTP id h131so19100702iof.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2020 12:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ypuhrRM8vdQuOVvAVGS42Y7Ui55RAVx891wwhREVaoo=;
        b=R/4VZvJH1LKxdxmcIF9afm1MXMxPjyKTerAXVhHWe77aTuKiOUQigGxi2/fDmpDkJ/
         Zz+2dzt0qL+6SyxxUiNBO72/gNd8I3ErfxlLd/Lmo8bNfjTCo2wlNIrYQWUt4ZgoiKmk
         WzW32bZ2ubD+d7tXLfSNTcbvmT83Zn2G2F9kCumrTDddcYNbUqTfk0fIRUEVkm8eEcIo
         93t5rInOSheMseT0/HHM30PeBsnGQAs/DLJy5gBPMD9SwKde77cEIqcmLW6tIFawoO8I
         J4C8qNlHdBMOPJVnjBxzDgDsLpDLzAMN762T2fHmQxwfCz2OPDXlamcCftOd8/5FHQEa
         cjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ypuhrRM8vdQuOVvAVGS42Y7Ui55RAVx891wwhREVaoo=;
        b=mrvITWOC9Plqie+4Gn2yRSeXlnGxdCbj3fy/1/pXLsUpxVjcb40IyBC4AIj9LBHfj7
         nLlsuu7GBTJexKw9mv2tvziJnNjnevUeCdiDc5B6V/H6g/7jctzzNVRna4SrIsFY+TVh
         X/p3S+GOXNfENMC1YQ94XIGwo+eovzSmgJgC66vil/Umw9UwM85ImjMT3M1rY/B5r1nW
         ZebGqMY0gFgYqnGSsPRFNkV+oYqKL03w9RoR4oEenRM6WCbiUmUmZCWTt1YyDxyuc3fV
         HiK9SrzUe8wl4JRyPlLIzKwvin3M+6FADDi3qRDoRirV3MxGJbWkjF7dmAr36gnD8x53
         POJA==
X-Gm-Message-State: ANhLgQ1E/n8PxQ+4Qrt6oBrg4aJgTPtNYfT7jBdx8gd2ElU67WIQZxcu
        VshW7YIkZmuCo23k0/X7rl8FBRXChcShl5Z0iDwO2m3t
X-Google-Smtp-Source: ADFU+vt0BrGLhIgF3pD8Gotcw5d9fzPvpKK8WjSEJ4JJXEMd4JRxqaUH8lKNdhPLYIHo/s7bhbu2N7SVD5nTLxA4CuQ=
X-Received: by 2002:a02:cc4e:: with SMTP id i14mr11831675jaq.93.1585596568795;
 Mon, 30 Mar 2020 12:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxgW9Jcj_hG639nw=j0rFQ1fGxBHJJz=nHKTPBat=L+mXg@mail.gmail.com>
 <CAOQ4uxih7zhAj6qUp39B_a_On5gv80SKm-VsC4D8ayCrC6oSRw@mail.gmail.com>
 <20200227112755.GZ10728@quack2.suse.cz> <CAOQ4uxgavT6e97dYEOLV9BUOXQzMw2ADjMoZHTT0euERoZFoJg@mail.gmail.com>
 <20200227133016.GD10728@quack2.suse.cz> <CAOQ4uxghKxf4Gfw9GX1QZ_ju3RhZcOLxtYnhAn9A3MJtt3PMCQ@mail.gmail.com>
 <CAOQ4uxiHA5fM9SjA+XXcGQOg2u4UPvs_-nm+sKXcNXoGKxVgTg@mail.gmail.com>
 <20200305154908.GK21048@quack2.suse.cz> <CAOQ4uxgJPkYOL5-jj=b+z5dG5DK8spzYUD7_OfMdBwh4gnTUYg@mail.gmail.com>
 <CAOQ4uxg4tRCALm+JaAQt9eWuU_23c55eaPivdRbb3yH=kcey8Q@mail.gmail.com>
 <20200318175131.GK22684@quack2.suse.cz> <CAOQ4uxj7Q8wMWzhgvTt1YkZUuWn55U6aWPvtGv7PmknHBApONQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxj7Q8wMWzhgvTt1YkZUuWn55U6aWPvtGv7PmknHBApONQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 30 Mar 2020 22:29:17 +0300
Message-ID: <CAOQ4uxitb7dP+8MQvCcNqEWQ5qBaGmPvEeDh1P+Hvs_jn_k82w@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] fanotify: prepare to encode both parent and
 child fid's
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 18, 2020 at 8:50 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> > > Pushed the work to fanotify_name branch.
> > > Let me know if you want me to post v3.
> >
> > So I went through the patches - had only minor comments for most of them.
> > Can you post the next revision by email and I'll pickup at least the
> > obvious preparatory patches to my tree. Thanks!
> >
>
> Will do.
> Most of your comments were minor, but the last comments on
> FAN_REPORT_NAME patch send me to do some homework.
>

I know this patch is for next next release, but I was just investigating
so wanted to publish the results.
For the records, your question about the FAN_REPORT_NAME
patch was: "... this seems to be somewhat duplicating the functionality
of __fsnotify_parent(). Can't we somehow join these paths?"

I remembered that I started with this approach and moved to
taking name snapshots inside fanotify event handler for a reason,
but did not remember what it was. So I went digging back and
found that I wanted to avoid the situation where in mount/sb
marks events are reported in two flavors, one with name and
one without name. I ended up with something that works, but the
logic is quite hard to follow and to document.

So decided it is best to go back to fsnotify_parent() approach and
let the two flavors of events be reported for sb/mount marks.
I pushed the end result to branch fanotify_name and adjusted the
LTP test to expect the extra events.

I will see how that ends up looking in the man page.

Thanks,
Amir.
