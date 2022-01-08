Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1356B4884B4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jan 2022 17:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbiAHQsD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Jan 2022 11:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbiAHQsD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Jan 2022 11:48:03 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0709BC06173F
        for <linux-fsdevel@vger.kernel.org>; Sat,  8 Jan 2022 08:48:03 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id y17so8937654qtx.9
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Jan 2022 08:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=dhqMeei64OF/ubfAHBfRR5b89m3kuJbFEb//rPjiGzw=;
        b=eE8w5O2stUaq9nrs5MoySs7Vb9Dbxhi+j1qN3dpusHOzGbQPzfEs0LpafrN4x8F2jB
         HOsmUh+chf0fAwJJD2/Xr1SSt5xYdNUNfU89MkGr8nWinQMLxgDqyUUjOpPXhaRCb2qy
         vWDquecxstlDyanvgCOekQxEUynTaCA0QK2YYrOSupHmEg50tIuDKdxTcTismMQedFr7
         /y/KvjnoGzMaUgAcT8yBtpivbvSfg/G6E46yTky4skBIWi/HtAwv1olM+rrngYzVg+Be
         Y1TG4GEpnh0fMocNIDa0UyKtbTPwejDzsf0xoUQAyTng+Pa0btN6AeSB8dPilSmYEeL5
         Z2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=dhqMeei64OF/ubfAHBfRR5b89m3kuJbFEb//rPjiGzw=;
        b=BEsAA5yaYvYE3c2rCMktgZHSNTxid0i9+faCv5Yz/UEIWBvSYE60DOX1a87W/IlVar
         5MHFjVmuR7mA7dhIqiwjIkTh+0/O3mrph8BAo7Bb76LvZbH2Z3dso2Q7FS4KYTRuXAeD
         0RIEqXyQWTJ09+d39VghnJzOwRA1IPSO13QLWZTHi7e4uj+ewdL70jwrNeA1/vFCCHJ7
         7gSTv8DoxETCxuRJNRXHf2FdM9UVFCIhpld+RDGDhS4V77M39uFRd1wyOM2+6ypTJ3zG
         P1TLjobY/UtkoCp34nmfv028YudJmFidcYqCMx4fwSEcJL8UpvvgDuO39rVUIwj6G3YZ
         qPxA==
X-Gm-Message-State: AOAM532ItfTGsSm/YFvG9uYlZ7k4lW+qcn26S+/5PzToovmKBhM+PMjJ
        Wir3c24eUzKwxABN0ZBhogG0EVGe+rbSXA==
X-Google-Smtp-Source: ABdhPJynIP2KXbVi9fxPl0tSwdCw65LQ4YtrEVctAauAV2jduPR0hev6OqFdYAoP/qeYY2mf3Qc1xw==
X-Received: by 2002:ac8:5994:: with SMTP id e20mr61089722qte.75.1641660482070;
        Sat, 08 Jan 2022 08:48:02 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y8sm1281751qtx.74.2022.01.08.08.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 08:48:01 -0800 (PST)
Date:   Sat, 8 Jan 2022 08:47:49 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 00/48] Folios for 5.17
In-Reply-To: <Ydkh9SXkDlYJTd35@casper.infradead.org>
Message-ID: <a5433775-23b0-4ac-51c7-1178fad73fc@google.com>
References: <20211208042256.1923824-1-willy@infradead.org> <YdHQnSqA10iwhJ85@casper.infradead.org> <Ydkh9SXkDlYJTd35@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 8 Jan 2022, Matthew Wilcox wrote:
> On Sun, Jan 02, 2022 at 04:19:41PM +0000, Matthew Wilcox wrote:
> > On Wed, Dec 08, 2021 at 04:22:08AM +0000, Matthew Wilcox (Oracle) wrote:
> > > This all passes xfstests with no new failures on both xfs and tmpfs.
> > > I intend to put all this into for-next tomorrow.
> > 
> > As a result of Christoph's review, here's the diff.  I don't
> > think it's worth re-posting the entire patch series.
> 
> After further review and integrating Hugh's fixes, here's what
> I've just updated the for-next tree with.  A little late, but that's
> this time of year ...

I don't see any fix to shmem_add_to_page_cache() in this diff, my 3/3
shmem: Fix "Unused swap" messages - I'm not sure whether you decided
my fix has to be adjusted or not, but some fix is needed there.

Hugh
