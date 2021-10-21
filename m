Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80EC14362EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 15:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhJUNby (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 09:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhJUNbx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 09:31:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D02C0613B9
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 06:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S6fEVf4FCVCGQuOytgp6zxC0eaL+m2tRL4ELpFKYXS4=; b=Kcnqm8FezbF5qRKYoVJWbuc2F4
        gwGXjwEMVGBPbcKwGQJkhNldp/ApYiqVzTXx+Zljian67SqN+BPv6EfBy1+lyKMs3Ok/a0vVI5QF+
        QIWf7xKy+n+0wwo7BzMrfkDrXJPnPcgJ502yiaRgrqLmsRznEeMZb8OdbMb8yDSru6mk4XDY+kwjQ
        k6h0SO9a8emj4CjEOMgtcC2BlnErlzQTmKqMUWvEDVdVEEWzHilSuBV9L1ypc6vQwelXaGprn2GZY
        ogr2q/je3KnGh2Uw+dV9p+RoyYp3PRpCBCgCAvcFqW82NKjRfUADM4rNl8D0hLS569oYxSIRcVt5k
        li1JZfJA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdY6j-00DIAj-Cm; Thu, 21 Oct 2021 13:28:31 +0000
Date:   Thu, 21 Oct 2021 14:27:45 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Azat.Nurgaliev@dlr.de
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: Turn off readahead completely
Message-ID: <YXFq0QYhDBQC5G0l@casper.infradead.org>
References: <8aa213d5d5464236b7e47aaa6bb93bb8@dlr.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aa213d5d5464236b7e47aaa6bb93bb8@dlr.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 21, 2021 at 01:16:46PM +0000, Azat.Nurgaliev@dlr.de wrote:
> Hello everyone,
> 
> I need to turn readahead off completely in order to do my experiments. 
> Is there any way to turn it off completely?
> 
> Setting /sys/block/<dev>/queue/read_ahead_kb to 0 causes readahead to become 4kb.

That's entirely intentional.  What experiment are you actually trying to
perform?
