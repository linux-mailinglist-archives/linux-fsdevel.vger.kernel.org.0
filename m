Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41532D6963
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 22:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393910AbgLJVGU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 16:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393977AbgLJVGB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 16:06:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50882C0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 13:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=BTDjt3nvSsN1ZiwoHBURwufx/oDbLa2gi089tmu1f9U=; b=AbaqnYkSSNf6gtVyRvZXHCEhBb
        yZY8wYZYt+RKZhaIMLGPwQqEn7laKio7qQddUIlTcP1/oi5JTlS20JyyYyrBMyKMalluUa/6sWQNY
        90dokiHU1HBs9fgoHKZrnzpaXmVuQ6PzeppD5dEoT5PGkuwEGFZLKaTfI2JbKUTTtw5Cplzgfka8s
        I4c6JMpDfwcp7lE8K6watd2JXmK/KuLHTgWyWpndNVEJd9FpJ7mWH8rzckKZfk7dR9glBEabwzVnr
        ag9haS45zZjN7ew3oghCV5owYvkYaiRR2J9TCYCWhP+AqiCPkOfvu96smSjaLMUmdOasMIIiY+N0y
        BUc57RUg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knT7n-0004yT-Sj; Thu, 10 Dec 2020 21:05:19 +0000
Date:   Thu, 10 Dec 2020 21:05:19 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Zoom call about Page Folios tomorrow
Message-ID: <20201210210519.GC7338@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Time: 18:00 UTC (7pm Prague, 1pm Montreal, 10am Los Angeles,
		3am Saturday Tokyo, 5am Saturday Melbourne)
Zoom Meeting ID: 960 8868 8749
Password: 2097152

Since we don't have physical conferences any more, I'd like to talk to
anyone who's interested in Page Folios (see my announcement earlier this
week [1])

I don't have a presentation prepared, this is a discussion.  Feel free
to just call in and listen.

[1] https://lore.kernel.org/linux-mm/20201208194653.19180-1-willy@infradead.org/
