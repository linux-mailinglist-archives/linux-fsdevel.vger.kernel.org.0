Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC22152258
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 23:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbgBDW3G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 17:29:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:51934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727468AbgBDW3G (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 17:29:06 -0500
Received: from cakuba.hsd1.ca.comcast.net (unknown [199.201.64.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A31382082E;
        Tue,  4 Feb 2020 22:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580855346;
        bh=X2z57f0W9Q3jy6EZ3udFW7xcoHaQk9ZKj62mmcrkJQY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j8LemCnjkG5V3gocN8awDnuEGOA4aEA7K/EnYBuMye/SqtZT77gdx4DjsKBJ9g6jW
         YdenvxL6coQrBOwk2CUC2k3XaHYy+GILO9AQx4WcCXpq5TfZ/4QiiIQJjNTnvBcNFN
         d3JNVazkiNmQStN6r5/LtP1gbf0G7Dfy6brvY0kU=
Date:   Tue, 4 Feb 2020 14:29:04 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Max Neunhoeffer <max@arangodb.com>,
        Christopher Kohlhoff <chris.kohlhoff@clearpool.io>,
        Davidlohr Bueso <dbueso@suse.de>,
        Jason Baron <jbaron@akamai.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] epoll: fix possible lost wakeup on epoll_ctl() path
Message-ID: <20200204142904.17079839@cakuba.hsd1.ca.comcast.net>
In-Reply-To: <549916868753e737316f509640550b66@suse.de>
References: <20200203205907.291929-1-rpenyaev@suse.de>
        <51f29f23a4d996810bfad12b9634ee12@suse.de>
        <20200204083237.7fa30aea@cakuba.hsd1.ca.comcast.net>
        <549916868753e737316f509640550b66@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 04 Feb 2020 18:20:03 +0100, Roman Penyaev wrote:
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

That should work, I like the brevity of the single combined

Reported-and-bisected-by: Max Neunhoeffer <max@arangodb.com>

line but looks like some separate the two even when both point 
to the same person. 

Unfortunately Documentation/process is silent on any "bisected-by" 
use, so you'll have to exercise your own judgement :)
