Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7C931B3EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 02:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhBOB03 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Feb 2021 20:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhBOB02 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Feb 2021 20:26:28 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE4CC061756
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Feb 2021 17:25:48 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id t23so2585199vsk.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Feb 2021 17:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nqWxVX3tai8d6xQXNuc7CwStRoLgRKEWoNr21bE/mSo=;
        b=QOpoZzZaeSCQbZPr1cTUfUvf2158J9Niprw8W19J41RTckcu2Nv8IiqjG1ZyyfpZBP
         CxrzJD6dUjPg7Wd3LyI9B4r194w2v0RhKtJ7jd+Ocsy+T54GULfQKFE7NdL5uDGYBx4x
         buYdYsItgZcFvPSVhd2I1nKFsc9X5Cha3B9jU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nqWxVX3tai8d6xQXNuc7CwStRoLgRKEWoNr21bE/mSo=;
        b=EwMwtIZfB0GT7YVTTszrlH7daPE3Z4URVNNWwz4+HS9hfwEca1rd2I3eY7CjOOivYy
         gLFHpKtmFszFx7JdJh03tnQa43Gmk7eFYkH9Dx7d7yseJQwaYVB8GPXCXVSGxbcoMz6U
         CU2HR43tMl6jehWDkH+lBlG12UDQygc1JMt2OCVQfGVAkbMD8jvvse1GLJczIgdIm6io
         U7xW1Hs5cHrozgFL/ZTXCYougvElqUsek7KJdehOipGpdpEAhADXDPheHchnisQIUXxN
         eBvuXjPAJn+8J7NNu9gt7rXAv12tPzkVYTEMUFx4ApxRxl2kWt4TzxUwzQFw+qWRpLV6
         FyNg==
X-Gm-Message-State: AOAM530LjJOnfqnrESM+X6+adLOmrFNGEkk3dxVI+QBOGM+nFHSZTHjn
        ceM3uLMM0YRFLdZnpPlacY0IeDoM9gArh39sEWRyR8v97Co=
X-Google-Smtp-Source: ABdhPJwxzNCcjBfqsq4WyT6GHAU2U4lh0z0W/tdmtYIKR51lPejDwZXlP7EQG7k4rpH4++0lqRrO0kdZtEA/IDdAV2E=
X-Received: by 2002:a67:e119:: with SMTP id d25mr7271805vsl.16.1613352347038;
 Sun, 14 Feb 2021 17:25:47 -0800 (PST)
MIME-Version: 1.0
References: <20210212124354.1.I7084a6235fbcc522b674a6b1db64e4aff8170485@changeid>
 <YCYybUg4d3+Oij4N@kroah.com> <CANMq1KBuPaU5UtRR8qTgdf+J3pt-xAQq69kCVBdaYGx8F+WmFA@mail.gmail.com>
 <YCY+Ytr2J2R5Vh0+@kroah.com> <CAKOQZ8zPFM29DYPwbnUJEhf+a8kPSJ5E_W06JLFjn-5Fy-ZWWw@mail.gmail.com>
 <YCaipZ+iY65iSrui@kroah.com> <20210212230346.GU4626@dread.disaster.area>
 <CAOyqgcX_wN2RGunDix5rSWxtp3pvSpFy2Stx-Ln4GozgSeS2LQ@mail.gmail.com>
 <20210212232726.GW4626@dread.disaster.area> <20210212235448.GH7187@magnolia>
 <20210215003855.GY4626@dread.disaster.area> <CAOyqgcX6HrbPU39nznmRMXJXtMWA0giYNRsio1jt1p5OU1jvOA@mail.gmail.com>
In-Reply-To: <CAOyqgcX6HrbPU39nznmRMXJXtMWA0giYNRsio1jt1p5OU1jvOA@mail.gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 15 Feb 2021 09:25:36 +0800
Message-ID: <CANMq1KDv-brWeKOTt3aUUi_1SOXSpEFo5pS5A6mpRT8k-O88nA@mail.gmail.com>
Subject: Re: [PATCH 1/6] fs: Add flag to file_system_type to indicate content
 is generated
To:     Ian Lance Taylor <iant@golang.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Lozano <llozano@chromium.org>,
        linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 15, 2021 at 9:12 AM Ian Lance Taylor <iant@golang.org> wrote:
>
> On Sun, Feb 14, 2021 at 4:38 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Fri, Feb 12, 2021 at 03:54:48PM -0800, Darrick J. Wong wrote:
> > > On Sat, Feb 13, 2021 at 10:27:26AM +1100, Dave Chinner wrote:
> > >
> > > > If you can't tell from userspace that a file has data in it other
> > > > than by calling read() on it, then you can't use cfr on it.
> > >
> > > I don't know how to do that, Dave. :)
> >
> > If stat returns a non-zero size, then userspace knows it has at
> > least that much data in it, whether it be zeros or previously
> > written data. cfr will copy that data. The special zero length
> > regular pipe files fail this simple "how much data is there to copy
> > in this file" check...
>
> This suggests that if the Go standard library sees that
> copy_file_range reads zero bytes, we should assume that it failed, and
> should use the fallback path as though copy_file_range returned
> EOPNOTSUPP or EINVAL.  This will cause an extra system call for an
> empty file, but as long as copy_file_range does not return an error
> for cases that it does not support we are going to need an extra
> system call anyhow.
>
> Does that seem like a possible mitigation?  That is, are there cases
> where copy_file_range will fail to do a correct copy, and will return
> success, and will not return zero?

I'm a bit worried about the sysfs files that report a 4096 bytes file
size, for 2 reasons:
 - I'm not sure if the content _can_ actually be longer (I couldn't
find a counterexample)
 - If you're unlucky enough to have a partial write in the output
filesystem, you'll get a non-zero return value and probably corrupted
content.

>
> Ian
