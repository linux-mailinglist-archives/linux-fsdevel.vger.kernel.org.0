Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 193C9156EFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 06:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgBJF7R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 00:59:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:32832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgBJF7R (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 00:59:17 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A117620715;
        Mon, 10 Feb 2020 05:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581314356;
        bh=gen+p1pFnIU8o+B3LZ0bBFZMWZcmf68UCd/c53E3oNM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WWsNwanaO7+EEpMHfeNBJN6Cu7OiSM99BzOgSKbJNMGRZR1uVv0uaJknlj3XCGeSw
         okHlvn0wrMPbB26pKbOGPG8NI6F49IutIgphGqxs2r2izq/BEcLSS3cvBHLENu+rS+
         HsiBl8FYBseNdSrjKQVrOygENoSUDA+LQvb1aGkU=
Date:   Sun, 9 Feb 2020 21:59:16 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Max Neunhoeffer <max@arangodb.com>,
        Christopher Kohlhoff <chris.kohlhoff@clearpool.io>,
        Davidlohr Bueso <dbueso@suse.de>,
        Jason Baron <jbaron@akamai.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] epoll: fix possible lost wakeup on epoll_ctl() path
Message-Id: <20200209215916.15640598689d3e40aa3f9e72@linux-foundation.org>
In-Reply-To: <549916868753e737316f509640550b66@suse.de>
References: <20200203205907.291929-1-rpenyaev@suse.de>
        <51f29f23a4d996810bfad12b9634ee12@suse.de>
        <20200204083237.7fa30aea@cakuba.hsd1.ca.comcast.net>
        <549916868753e737316f509640550b66@suse.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 04 Feb 2020 18:20:03 +0100 Roman Penyaev <rpenyaev@suse.de> wrote:

> On 2020-02-04 17:32, Jakub Kicinski wrote:
> > On Tue, 04 Feb 2020 11:41:42 +0100, Roman Penyaev wrote:
> >> Hi Andrew,
> >> 
> >> Could you please suggest me, do I need to include Reported-by tag,
> >> or reference to the bug is enough?
> > 
> > Sorry to jump in but FWIW I like the Reported-and-bisected-by tag to
> > fully credit the extra work done by the reporter.
> 
> Reported-by: Max Neunhoeffer <max@arangodb.com>
> Bisected-by: Max Neunhoeffer <max@arangodb.com>
> 
> Correct?

We could do that, but preferably with Max's approval (please?).

Because people sometimes have issues with having their personal info
added to the kernel commit record without having being asked.

