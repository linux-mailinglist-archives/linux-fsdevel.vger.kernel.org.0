Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7C9560CB5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 22:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfGEUrN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 16:47:13 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33806 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfGEUrN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 16:47:13 -0400
Received: by mail-oi1-f194.google.com with SMTP id l12so8017593oil.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jul 2019 13:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zHIrtg718g0WHs7Hj87xhDHbK+5NmnTf/nYBQ5bI8FU=;
        b=z5aWE93oZm4VY6336F7Hx637JaCvs1KP2e6aFHe39/v1CvzQ//JzyGx5K2O03K4vMn
         6dsmDxsN94WUAkHSJIQ2C4y1lkUe3PIeJrXtYpdDEduo3Ejag4b3oKYm3mWE2QMn4V0c
         iDl2l2lm7FR+5eOMQCkWrBGZP+0mPYmO59S/0aLpZYOvIuSNavN6DV+DXfg+YZ9aHAI2
         JOgkjHUs5nJN8o5AFBMW2tTjqHXc+A4RNSxu2vGyFbryn8rql8zaceUYEhz4qtkTasfj
         NIXToSoJDNCvq6x5S0l0WY7vyILjciV8CG+b/MLs/5WKJHlXmQbf14kzYuUyjQ7R5w+N
         F6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zHIrtg718g0WHs7Hj87xhDHbK+5NmnTf/nYBQ5bI8FU=;
        b=mxPDlChv5Gxpn68Q9c9mwK0L//M/SBmqymxaybsneczyElswV2wdwEUKX+6BCNocMH
         5VnIIP4ZbMiCcbR9kIs58hXHppGZIFfbhttPazUvYAaiNX+vCmETZH7i509yEvassp2V
         XivyaYc0AaVWP3GP+RsNLg/FS9gS2w/VS0lGq1q6cjkjg3mjbSyvpnQp8rMfrr8iXAyt
         j/Bvcn8YbOjw9EKOE4yNX2504wtHmtOe0WxzrZJQ/ZUFzZNomvPR4HWk8NQmw437VZhS
         qEyZhSGuYQACa1vPHtadHE4nTkpbYpmQGeD+nk86HanrvLKEMB06k+7IMj2EUxFWa821
         Ok3A==
X-Gm-Message-State: APjAAAWYmideaynOrOS3FcDEFeQ5Q4kv3k2b6VgV7Jv+TWhM1IL3kkYV
        YsyaFa+5m/t8VrGyH8ysyergbL29TqX1LfqjulZ8bw==
X-Google-Smtp-Source: APXvYqwawhLvWvIrzpwxMWzgP7wwZwEPPN+s7paFPexwD07PA8+imMpQDN6OtD+9cY4aZpoPZYIEOLRJmbzqzmVYcM0=
X-Received: by 2002:aca:ba02:: with SMTP id k2mr2871848oif.70.1562359632596;
 Fri, 05 Jul 2019 13:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <156213869409.3910140.7715747316991468148.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190703121743.GH1729@bombadil.infradead.org> <CAPcyv4jgs5LTtTXR+2CyfbjJE85B_eoPFuXQsGBDnVMo41Jawg@mail.gmail.com>
 <20190703195302.GJ1729@bombadil.infradead.org> <CAPcyv4iPNz=oJyc_EoE-mC11=gyBzwMKbmj1ZY_Yna54=cC=Mg@mail.gmail.com>
 <20190704032728.GK1729@bombadil.infradead.org> <20190704165450.GH31037@quack2.suse.cz>
 <20190704191407.GM1729@bombadil.infradead.org> <CAPcyv4gUiDw8Ma9mvbW5BamQtGZxWVuvBW7UrOLa2uijrXUWaw@mail.gmail.com>
 <20190705191004.GC32320@bombadil.infradead.org>
In-Reply-To: <20190705191004.GC32320@bombadil.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 5 Jul 2019 13:47:02 -0700
Message-ID: <CAPcyv4jVARa38Qc4NjQ04wJ4ZKJ6On9BbJgoL95wQqU-p-Xp_w@mail.gmail.com>
Subject: Re: [PATCH] dax: Fix missed PMD wakeups
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Boaz Harrosh <openosd@gmail.com>,
        stable <stable@vger.kernel.org>,
        Robert Barror <robert.barror@intel.com>,
        Seema Pandit <seema.pandit@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 5, 2019 at 12:10 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Jul 04, 2019 at 04:27:14PM -0700, Dan Williams wrote:
> > On Thu, Jul 4, 2019 at 12:14 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Thu, Jul 04, 2019 at 06:54:50PM +0200, Jan Kara wrote:
> > > > On Wed 03-07-19 20:27:28, Matthew Wilcox wrote:
> > > > > So I think we're good for all current users.
> > > >
> > > > Agreed but it is an ugly trap. As I already said, I'd rather pay the
> > > > unnecessary cost of waiting for pte entry and have an easy to understand
> > > > interface. If we ever have a real world use case that would care for this
> > > > optimization, we will need to refactor functions to make this possible and
> > > > still keep the interfaces sane. For example get_unlocked_entry() could
> > > > return special "error code" indicating that there's no entry with matching
> > > > order in xarray but there's a conflict with it. That would be much less
> > > > error-prone interface.
> > >
> > > This is an internal interface.  I think it's already a pretty gnarly
> > > interface to use by definition -- it's going to sleep and might return
> > > almost anything.  There's not much scope for returning an error indicator
> > > either; value entries occupy half of the range (all odd numbers between 1
> > > and ULONG_MAX inclusive), plus NULL.  We could use an internal entry, but
> > > I don't think that makes the interface any easier to use than returning
> > > a locked entry.
> > >
> > > I think this iteration of the patch makes it a little clearer.  What do you
> > > think?
> > >
> >
> > Not much clearer to me. get_unlocked_entry() is now misnamed and this
>
> misnamed?  You'd rather it was called "try_get_unlocked_entry()"?

I was thinking more along the lines of
get_unlocked_but_sometimes_locked_entry(), i.e. per Jan's feedback to
keep the interface simple.
