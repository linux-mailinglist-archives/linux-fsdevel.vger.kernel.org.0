Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094142CB3A8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 05:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgLBECo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 23:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgLBECn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 23:02:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758F7C0613CF
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Dec 2020 20:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WIagzzrMlbtp5fDLih1Rxksw8l5DeLlQbDxYoNcxJWs=; b=mJu9I5AuqjZSiYuuZMCH/7iF0e
        vXLnxV+Mqt3SNbBU0o4jJLZH7l5hrrQ93LccjajaVTXNcYnnbOnDk8NyDCxKyEbMO9c6C/MSi/Q9b
        wy1IucHcHS9dUwlSgcdz7QEwiVTSfUAUrmh3/GyNuhpwZzc4l0On4J0OFvu4u1Mf/JBPTWPHzwsSQ
        usgozKEzkXuD6VUAisIJE3qW943b3jWpKNbXKcTbhywIuql9XVy+Qk8N3SpqGWZlIk5Nk+zJVO7fI
        PGc4wlNX3ojLXP9UXG54jh6wf+S4k2PFVr3QpcV1Qea6JxRO5FpPxP5DotXdv8GeHdXTBj8xsQERR
        VK9Fd+nQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkJL6-0000Ex-Pj; Wed, 02 Dec 2020 04:02:00 +0000
Date:   Wed, 2 Dec 2020 04:02:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Gong, Sishuai" <sishuai@purdue.edu>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: PROBLEM: potential concurrency bug between do_vfs_ioctl() and
 do_readv()
Message-ID: <20201202040200.GE11935@casper.infradead.org>
References: <ED916641-1E2F-4256-9F4B-F3DEAEBE17E7@purdue.edu>
 <DFE6D155-3123-488D-B6E3-02E8757A7585@purdue.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DFE6D155-3123-488D-B6E3-02E8757A7585@purdue.edu>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 02, 2020 at 03:18:26AM +0000, Gong, Sishuai wrote:
> We want to report another error message we saw which might be related to this bug.

https://syzkaller.appspot.com/upstream

There are over a thousand open bugs already.  Why are the extra bugs
being found by your group useful?
