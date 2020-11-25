Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292262C4772
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 19:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733058AbgKYSRK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 13:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733005AbgKYSRK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 13:17:10 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F82FC0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 10:16:54 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id e7so2838477wrv.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 10:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j5gTn7rnt46vXkbVABsd/nLFo1oDvs2e/sre8ZiKqDQ=;
        b=2RcIEuqtZY++KbyHHJ/8Al35LHvGEMfjFhX1wg6Sx1lnUQGdB99z0SrLom14WDlOHC
         JzFjfP0tNkkwXcu6XzC6NAhOhzQoKp7yho7CnvBk07fTG44rTUd8izJ5QltWtboAdbOs
         aCwthm9Lwh07mqfBhvxEgEy62qR7qdqH+QrYogMcZX0700fvS9sUweRgeTkiom3OxL5l
         QQq2a/7Luu4pPuoc8nmOoPM+g7UUK1JTIHbOZYOZsTOa1alHfkhxBDNUi3/IBmDcpRRF
         G0Vssw/bwybi4EgR5nUVohtKi/g9Eh+ZHJX4b7hFPGkxVT5uexQ6SNfhT0tVKhkKie1I
         gk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j5gTn7rnt46vXkbVABsd/nLFo1oDvs2e/sre8ZiKqDQ=;
        b=LlYT/yCPKzAzKoMwKgF2sPaXkTOuza8kRe2YUpaf8fBzDnkWx77VSXVv0QFjQ4na+N
         XbmIIdFa8+DR5r4LlN6cjvnWp7Szg5l0GgVRSGzLTbs8xLZ6hb6tXgZe9ajiHNmiJUD1
         X34L4GzmBy91lOGQcR7KiJmVd9S1piqN7HpF9nILmA7trn1SactQU0N9Wz6I+WrnNJFC
         OAKDQ6+TGkbCqjkJv5Jf5CT6XhpvcxtSTqvcEuINUkjd3PpM9+Q3DFEIcYthyK+NOfGT
         FMKxFCl3yfdCZTe1kuC+1/mBv8rxKJQb0n4CxxaxY9WkFUSgrqC5Rcd2OwOvJ+4vSQZ0
         b9+A==
X-Gm-Message-State: AOAM533RRqEoJVJkTUSWzT7eRYrrKm/vZ0axCPFp+nB4iXoy/StA3dMY
        BroWYQuPzbUPk8NgXWLoLIyWr0Bxmx122gwwZd9OZA==
X-Google-Smtp-Source: ABdhPJwQ8WelxJodfMPdFHmQdz1O8TGE9MrvKPhhxxXuE5dHnylhfXIpx/XMn0moXpHiTw1HBA2/nw6OzXt+/ScISSw=
X-Received: by 2002:adf:e509:: with SMTP id j9mr5578411wrm.354.1606328213209;
 Wed, 25 Nov 2020 10:16:53 -0800 (PST)
MIME-Version: 1.0
References: <20201125162532.1299794-1-daniel.vetter@ffwll.ch>
 <20201125162532.1299794-5-daniel.vetter@ffwll.ch> <CAKMK7uGXfqaPUtnX=VgA3tFn3S+Gt9GV+kPguakZ6FF_n8LKuA@mail.gmail.com>
 <20201125180606.GQ5487@ziepe.ca>
In-Reply-To: <20201125180606.GQ5487@ziepe.ca>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Wed, 25 Nov 2020 18:16:42 +0000
Message-ID: <CAPj87rP-=yXjdPc48WrwiZj8pYVfZsMhzsAqt-1MrrV2LoOPMQ@mail.gmail.com>
Subject: Re: [PATCH] drm/ttm: don't set page->mapping
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Linux MM <linux-mm@kvack.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Brian Paul <brianp@vmware.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Wed, 25 Nov 2020 at 18:06, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Wed, Nov 25, 2020 at 05:28:32PM +0100, Daniel Vetter wrote:
> > Apologies again, this shouldn't have been included. But at least I
> > have an idea now why this patch somehow was included in the git
> > send-email. Lovely interface :-/
>
> I wrote a bit of a script around this because git send-email just too
> hard to use
>
> The key workflow change I made was to have it prepare all the emails
> to send and open them in an editor for review - exactly as they would
> be sent to the lists.
>
> It uses a empty 'cover-letter' commit and automatically transforms it
> into exactly the right stuff. Keeps track of everything you send in
> git, and there is a little tool to auto-run git range-diff to help
> build change logs..

This sounds a fair bit like patman, which does something similar and
also lets you annotate commit messages with changelogs.

But of course, suggesting different methods of carving patches into
stone tablets to someone who's written their own, is even more of a
windmill tilt than rDMA. ;)

Cheers,
Daniel
