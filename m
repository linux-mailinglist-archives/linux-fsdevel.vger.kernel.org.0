Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356FA327E05
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 13:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhCAMO4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 07:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbhCAMOr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 07:14:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1734FC061788;
        Mon,  1 Mar 2021 04:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I5VnGAaPxZ0y2ywJ0sQMfHrbJRwx3BFwKw9Ug1bzDd8=; b=PCA1Ce/XsJA09ZivVvyVlxo0RN
        RYEsoAuPxwIKJ2Xnvvy2vKMxwuN2vtSd+mp/xx83U9BAke+uHJdhWmUmDRSAPAPnF1xGgW9y4AhAy
        33GWt/MxYyfQoCkJzIiUon76k9ARKbyvxfHjaMQ/tgfVoDQzDESvIWtTp8blGEUepP1IB9qVsRxdx
        1YhRK0E7QT14vtzqyyHh0VfZd84Nay7uCBEpNBmvn8TbXlqk1v0p+d30/M/xgbGgn+OYm2hbM51gP
        YKAiZmFwPbRxmm1Ah63LHnZ8wsL35lQ51sOCw5s39QqR5xZ3cugRTaQV8iEfEMUELJqntdRwFaw6u
        1zkSRBvw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lGhQk-00Fgq1-Pw; Mon, 01 Mar 2021 12:13:51 +0000
Date:   Mon, 1 Mar 2021 12:13:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Pintu Kumar <pintu@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, jaewon31.kim@samsung.com,
        yuzhao@google.com, shakeelb@google.com, guro@fb.com,
        mchehab+huawei@kernel.org, xi.fengfei@h3c.com,
        lokeshgidra@google.com, hannes@cmpxchg.org, nigupta@nvidia.com,
        famzheng@amazon.com, andrew.a.klychkov@gmail.com,
        bigeasy@linutronix.de, ping.ping@gmail.com, vbabka@suse.cz,
        yzaikin@google.com, keescook@chromium.org, mcgrof@kernel.org,
        corbet@lwn.net, pintu.ping@gmail.com
Subject: Re: [PATCH] mm: introduce clear all vm events counters
Message-ID: <20210301121342.GP2723601@casper.infradead.org>
References: <1614595766-7640-1-git-send-email-pintu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614595766-7640-1-git-send-email-pintu@codeaurora.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 01, 2021 at 04:19:26PM +0530, Pintu Kumar wrote:
> +EXPORT_SYMBOL_GPL(clear_all_vm_events);

What module uses this function?
