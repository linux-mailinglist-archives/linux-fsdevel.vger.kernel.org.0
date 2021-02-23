Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913C7323417
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 00:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbhBWXCx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 18:02:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:47642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233676AbhBWW73 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 17:59:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73C6364E22;
        Tue, 23 Feb 2021 22:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1614121118;
        bh=RtRoOTyhYhmAVbBJEAnS00IV7odqX+cIq2Gc7KyyO+0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nnDmKUI+an7HxBWXTfc/+LQX0Kzrt+gSsILWltt5UKePJ9RnutTzgCEDala2MLrIj
         Pcq+roAl6O4fsGsTrsMkU3x4iIhPLAJKNENtttLpG90OpPoHX9gskFmVJdZIDU+9qv
         gfKx0wU0+z5KjUiCaSLt3b8wqhuUJ/anmCUad8FA=
Date:   Tue, 23 Feb 2021 14:58:36 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        hughd@google.com, hch@lst.de, hannes@cmpxchg.org,
        yang.shi@linux.alibaba.com, dchinner@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/16] Overhaul multi-page lookups for THP
Message-Id: <20210223145836.cb588a6ec6c34e54ad26f9bf@linux-foundation.org>
In-Reply-To: <20201112212641.27837-1-willy@infradead.org>
References: <20201112212641.27837-1-willy@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Do you feel this patchset is ready to merge up?

https://lore.kernel.org/linux-mm/000000000000f6914405b49d9c9d@google.com/
was addressed by 0060ef3b4e6dd ("mm: support THPs in
zero_user_segments"), yes?

"mm/truncate,shmem: Handle truncates that split THPs" and "mm/filemap:
Return only head pages from find_get_entries" were dropped.  I guess
you'll be having another go at those sometime?

https://lore.kernel.org/linux-fsdevel/20201114100648.GI19102@lst.de/
wasn't responded to?

