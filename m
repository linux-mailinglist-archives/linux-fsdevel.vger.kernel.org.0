Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4CF4902CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 08:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237370AbiAQHPG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 02:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237362AbiAQHPF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 02:15:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A56EC061574;
        Sun, 16 Jan 2022 23:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dcj+k+dnKwv8utbn7047Y7LI1Qf+IRrotlxSCqVyYNg=; b=3jIrOmp0lrVzvR48PKVscMr/tl
        CQtr9Q2C00/YtrWddqCYxoQ52Fb6JqrY2cyWSbub5N6yu8xe3AiPfizJV5AqroG0cVdW16ASWTIHo
        BPJvaEOSMxuhQ0f19yLZ2lf5IxkTlw+ENb7YrGKxrh9iDYqhwDxogFuYWZoLPMD2Uqq++Qrc0eHbH
        86sDbU6ymxKEb9h106RgljWqGO+3L1/BnRxZAhajqItnLAOVTjBRb/Gie4FneRQ1z0iDQada1RlWn
        xbni4UAavD+CjKEQkkq7HPMvcZwwGQ2IsnqSkWvPpTG8nlEz7XSRDAlcqiMRnn0Aj6VEk1WKOnuNr
        iqVTRssQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9MEC-00Dmv7-Oe; Mon, 17 Jan 2022 07:14:56 +0000
Date:   Sun, 16 Jan 2022 23:14:56 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mpage: remove ineffective __GFP_HIGH flag
Message-ID: <YeUXcK3/6vIXw7Ju@infradead.org>
References: <20220115144150.1195590-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220115144150.1195590-1-shakeelb@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FYI, I have a patch removing mpage_alloc entirely as part of a bio
allocation refactoring series about to be sent out.  So while your
analysis here is correct I'd prefer to hold this as the issue goes away
entirely.
