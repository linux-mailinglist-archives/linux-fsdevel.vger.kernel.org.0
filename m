Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119B94884EA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jan 2022 18:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbiAHRU1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Jan 2022 12:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiAHRU0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Jan 2022 12:20:26 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FA7C06173F
        for <linux-fsdevel@vger.kernel.org>; Sat,  8 Jan 2022 09:20:26 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id ke6so8956953qvb.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Jan 2022 09:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=NS6xZ3k2ptD1ngV7iuDVWu/5o23kt9imwB2Z3/xXb7s=;
        b=I6AFxtkkev5cOvPUqvXIaaAtQuuuOMGbXx20bA39MRd4pj/+s/ShP7QPLoxY+v0UWl
         upRNgNOJhHXndOyEIoAy7lyzf6oAoMu0N+NtXXOPDbOV3jUI7lN5srVRBJ+2Jxxo4uHl
         fmBhiUPJEZ36Ba5sWdeNBiPkZ3+MDx91LZgLZCMlKWVcrJcHNimrv6ueMkLzk3kn+sk8
         mJLGPQ781Y+zrGG9o7G9w2VCM1qqdviBE09H8nteT1rTLIPlcJLcwGLbIkm3o5oDVjpa
         MgAuc8HkNEJb87Pk2CR5o9E5lzRlwmkfAugzswpZkb3YYvT/7QK7uE+VPJyV2ZK3mhpJ
         qyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=NS6xZ3k2ptD1ngV7iuDVWu/5o23kt9imwB2Z3/xXb7s=;
        b=thHHNedE6xYcdKDPm3gml0UgbHWvnPatD+HoWSDVHa7ue43pcQOT1kJWqQZGTVXHoG
         p/e89IZl8K9byj2Kz8aPD7Kg5B/3NiHlT0/c5TMvQU+KcdNV5djau1s+8QI7KHxI+b75
         IzvrB6daX25d9iugxwf6SqMTfrs14kr0KK3UTwaJSqHdImhDVQl25TZd8q/TUQXvZEck
         Dau/8w/dKsV0pSBcqupX4LBBpKe4VocdIWPbK83wX+TgtmruDA2NM4pwYLsBZ6vyL2zD
         OmKcKoj/2cjiD89ECaUYyb5YnxJvkYS61CC8HJZo0ZzIrfiI3RPqSaK1xvZwd9tvIgxF
         6F7w==
X-Gm-Message-State: AOAM532DaVsng3k2GfjaKRbFS5Zqu19Lwaj4fOQBmuenLAJ2Zc50omrI
        POLsm9lMtGZQITSF4Ls9FK0GgxpvJhLltg==
X-Google-Smtp-Source: ABdhPJyaofUJNNZcRsCyhRrVzbzfDTfn+/paah5kaLZaMSpupd8rgWCGMjzOk6RwBgnfTBGOs+SMtA==
X-Received: by 2002:a05:6214:e46:: with SMTP id o6mr11715150qvc.110.1641662425518;
        Sat, 08 Jan 2022 09:20:25 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id bm30sm1315889qkb.4.2022.01.08.09.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 09:20:24 -0800 (PST)
Date:   Sat, 8 Jan 2022 09:20:13 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 00/48] Folios for 5.17
In-Reply-To: <YdnBcaSLv4TAGjfL@casper.infradead.org>
Message-ID: <b151e2b3-3315-533e-a06e-b0b6e4d2e74c@google.com>
References: <20211208042256.1923824-1-willy@infradead.org> <YdHQnSqA10iwhJ85@casper.infradead.org> <Ydkh9SXkDlYJTd35@casper.infradead.org> <a5433775-23b0-4ac-51c7-1178fad73fc@google.com> <YdnBcaSLv4TAGjfL@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 8 Jan 2022, Matthew Wilcox wrote:
> On Sat, Jan 08, 2022 at 08:47:49AM -0800, Hugh Dickins wrote:
> > On Sat, 8 Jan 2022, Matthew Wilcox wrote:
> > > On Sun, Jan 02, 2022 at 04:19:41PM +0000, Matthew Wilcox wrote:
> > > > On Wed, Dec 08, 2021 at 04:22:08AM +0000, Matthew Wilcox (Oracle) wrote:
> > > > > This all passes xfstests with no new failures on both xfs and tmpfs.
> > > > > I intend to put all this into for-next tomorrow.
> > > > 
> > > > As a result of Christoph's review, here's the diff.  I don't
> > > > think it's worth re-posting the entire patch series.
> > > 
> > > After further review and integrating Hugh's fixes, here's what
> > > I've just updated the for-next tree with.  A little late, but that's
> > > this time of year ...
> > 
> > I don't see any fix to shmem_add_to_page_cache() in this diff, my 3/3
> > shmem: Fix "Unused swap" messages - I'm not sure whether you decided
> > my fix has to be adjusted or not, but some fix is needed there.
> 
> I pushed that earlier because I had more confidence in my understanding
> of that patch.  Here's what's currently in for-next:

Okay, thanks: I tried that variant when you proposed it, and it worked fine.

Hugh
