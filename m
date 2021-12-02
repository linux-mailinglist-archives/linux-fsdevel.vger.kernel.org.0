Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1256466397
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 13:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358028AbhLBM0d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 07:26:33 -0500
Received: from shark4.inbox.lv ([194.152.32.84]:46894 "EHLO shark4.inbox.lv"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346852AbhLBM0S (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:26:18 -0500
Received: from shark4.inbox.lv (localhost [127.0.0.1])
        by shark4-out.inbox.lv (Postfix) with ESMTP id 8167EC0199;
        Thu,  2 Dec 2021 14:22:50 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv; s=30062014;
        t=1638447770; bh=neqrILORV8SqsElN1SHhdTvqBGKRhO3YMs913LQNSL8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=L8xvHB+5owKJr2KYgGAIVGqZ1sf/OSzEdiR047eogslRsh90em0/a3MuFdz95qqAu
         e/slCpppm9YpWmV0SRN2nRy1CCFECdmETSrFBL+edKnLfee9KHW3gRqXc8Tct/LSNH
         d3HK5ZEGvcm+MC8uxtxp6+1TtcR3tG7ceykAz3Jc=
Received: from localhost (localhost [127.0.0.1])
        by shark4-in.inbox.lv (Postfix) with ESMTP id 76CE2C0161;
        Thu,  2 Dec 2021 14:22:50 +0200 (EET)
Received: from shark4.inbox.lv ([127.0.0.1])
        by localhost (shark4.inbox.lv [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id AYQhrt8Ve0n0; Thu,  2 Dec 2021 14:22:50 +0200 (EET)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
        by shark4-in.inbox.lv (Postfix) with ESMTP id 4239DC015A;
        Thu,  2 Dec 2021 14:22:50 +0200 (EET)
Date:   Thu, 2 Dec 2021 21:22:40 +0900
From:   Alexey Avramov <hakavlad@inbox.lv>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Darrick Wong <djwong@kernel.org>, regressions@lists.linux.dev,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
Message-ID: <20211202212240.7f9ee7f5@mail.inbox.lv>
In-Reply-To: <20211202121554.GY3366@techsingularity.net>
References: <20211125151853.8540-1-mgorman@techsingularity.net>
        <20211127011246.7a8ac7b8@mail.inbox.lv>
        <20211129150117.GO3366@techsingularity.net>
        <20211201010348.31e99637@mail.inbox.lv>
        <20211130172754.GS3366@techsingularity.net>
        <20211201033836.4382a474@mail.inbox.lv>
        <20211201140005.GU3366@techsingularity.net>
        <20211202204229.5ed83f31@mail.inbox.lv>
        <20211202121554.GY3366@techsingularity.net>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: OK
X-ESPOL: EZqEIBwB6gdL+J/+N+Yf6uLl2rTHW1slvCTzybU26ndFz9PMtNdrcW+QBYXqHxy6dn8=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>can I add

sure
