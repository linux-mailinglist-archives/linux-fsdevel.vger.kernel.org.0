Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6231032676A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 20:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhBZTZr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Feb 2021 14:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhBZTZq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Feb 2021 14:25:46 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C741C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Feb 2021 11:25:06 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id mm21so16358733ejb.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Feb 2021 11:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AdceXkUat0y3I1W10TQaOb2nva8EpX5XfJ5IibDVBuM=;
        b=DPa6Vh392csOE5ijiNRTWgG7GUi3kKjY8LOBEhxF6H7gF7J8KahKgnxLlU4iYgfSeY
         Pbs8Vc17TTolZLRSHhw5iCYfpNtd2t1xcYFFKQ3fO0G0P2fg3i+ZYVYW+wfvE3qrVPet
         2E/m7gPkNFcdJheH9N9j50LssiHOaF6yNI0g6wZFo6yWh/hSm23Riv3KyIzgVx7k/Ls4
         o1Y4ydnYLrl3SjoziD977quqS+lhcudZ1ex+w4C30hrZA/3+lOd2xJK7KGuApblCVUbP
         zyMwzpY2cHE2rR0/qLP0kT+5zg0IYM1Io+3P8b8kf1zp5BxfcTw8rv+QxLhplFhOrvcR
         Yw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AdceXkUat0y3I1W10TQaOb2nva8EpX5XfJ5IibDVBuM=;
        b=nlKNlNm1LWqfvrIt5EL0kHTHQSJHN7flJDgMnBxcRPEtWJs2PmdjxZ9HQ9yAb3gxIu
         UItQgWOWpMsKpKFzp/bq+LLdSvSQnfmwpC6EgsNjP9SavJMn8SNn+tbLHE6iDrVhGNYE
         KNRe1tNuXkxCDDCFO7FawLqDXob0YujMcB0gV5slfm7jOP6Zp1KAj71OOX7GdW+uUGq2
         3LIXo7A4mUjc37+1wRcCNYlo5PjTZo4VQRVpRpWnn6wBsUaZox6wf84MnaviOTzZzAc7
         Dm4m+rDlHO7InbBBmiTTO7ZIVjFlS6F/xQ4r51yfGbEk4GY7EL/oArXZeKCI3JQbqP00
         EeJQ==
X-Gm-Message-State: AOAM530ACNlbJRWRUfYXQ/kc6alcnVgrPxU1an9zqZAOiTs2vcPnVJlj
        wNe154u3LM1kWTwEL3Fc7vfwathOEBvd2zRyNVXzWg==
X-Google-Smtp-Source: ABdhPJzUZ1ukwr7S7OH8h0lWao0WUwN2w4vieDP+yhbhYknurSEDgZngirw/nE+KWvrmB7T8lvwVfPOXST5nKZQzUdo=
X-Received: by 2002:a17:906:6088:: with SMTP id t8mr5106839ejj.323.1614367504798;
 Fri, 26 Feb 2021 11:25:04 -0800 (PST)
MIME-Version: 1.0
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <OSBPR01MB2920899F1D71E7B054A04E39F49D9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <20210226190454.GD7272@magnolia>
In-Reply-To: <20210226190454.GD7272@magnolia>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 26 Feb 2021 11:24:53 -0800
Message-ID: <CAPcyv4iJiYsM5FQdpMvCi24aCi7RqUnnxC6sM0umFqiN+Q59cg@mail.gmail.com>
Subject: Re: Question about the "EXPERIMENTAL" tag for dax in XFS
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>,
        "fnstml-iaas@cn.fujitsu.com" <fnstml-iaas@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 26, 2021 at 11:05 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Fri, Feb 26, 2021 at 09:45:45AM +0000, ruansy.fnst@fujitsu.com wrote:
> > Hi, guys
> >
> > Beside this patchset, I'd like to confirm something about the
> > "EXPERIMENTAL" tag for dax in XFS.
> >
> > In XFS, the "EXPERIMENTAL" tag, which is reported in waring message
> > when we mount a pmem device with dax option, has been existed for a
> > while.  It's a bit annoying when using fsdax feature.  So, my initial
> > intention was to remove this tag.  And I started to find out and solve
> > the problems which prevent it from being removed.
> >
> > As is talked before, there are 3 main problems.  The first one is "dax
> > semantics", which has been resolved.  The rest two are "RMAP for
> > fsdax" and "support dax reflink for filesystem", which I have been
> > working on.
>
> <nod>
>
> > So, what I want to confirm is: does it means that we can remove the
> > "EXPERIMENTAL" tag when the rest two problem are solved?
>
> Yes.  I'd keep the experimental tag for a cycle or two to make sure that
> nothing new pops up, but otherwise the two patchsets you've sent close
> those two big remaining gaps.  Thank you for working on this!
>
> > Or maybe there are other important problems need to be fixed before
> > removing it?  If there are, could you please show me that?
>
> That remains to be seen through QA/validation, but I think that's it.
>
> Granted, I still have to read through the two patchsets...

I've been meaning to circle back here as well.

My immediate concern is the issue Jason recently highlighted [1] with
respect to invalidating all dax mappings when / if the device is
ripped out from underneath the fs. I don't think that will collide
with Ruan's implementation, but it does need new communication from
driver to fs about removal events.

[1]: http://lore.kernel.org/r/CAPcyv4i+PZhYZiePf2PaH0dT5jDfkmkDX-3usQy1fAhf6LPyfw@mail.gmail.com
