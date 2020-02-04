Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 693F9151E56
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 17:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgBDQcj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 11:32:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:51734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbgBDQcj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 11:32:39 -0500
Received: from cakuba.hsd1.ca.comcast.net (unknown [199.201.64.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FC122087E;
        Tue,  4 Feb 2020 16:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580833958;
        bh=nhIjXg292ezbgAlIZENyN4PstFlnPjX6rCq6238b+AQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=REY28gZ63Xv9E55IpQfMcTPlq1idb7DgOTc0V52/75U/w74yDywjihG0dLme9Lf4h
         pot7/zX4tVh33URkDiEewPq3D72qQ0uEwQbnZtYyQvwM2vR+l1xcWDhupEID6XXBzM
         amPWCNHFwcw2ifYYXEiQFQnaSCJwglWL9hc/HMaQ=
Date:   Tue, 4 Feb 2020 08:32:37 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Max Neunhoeffer <max@arangodb.com>,
        Christopher Kohlhoff <chris.kohlhoff@clearpool.io>,
        Davidlohr Bueso <dbueso@suse.de>,
        Jason Baron <jbaron@akamai.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] epoll: fix possible lost wakeup on epoll_ctl() path
Message-ID: <20200204083237.7fa30aea@cakuba.hsd1.ca.comcast.net>
In-Reply-To: <51f29f23a4d996810bfad12b9634ee12@suse.de>
References: <20200203205907.291929-1-rpenyaev@suse.de>
        <51f29f23a4d996810bfad12b9634ee12@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 04 Feb 2020 11:41:42 +0100, Roman Penyaev wrote:
> Hi Andrew,
> 
> Could you please suggest me, do I need to include Reported-by tag,
> or reference to the bug is enough?

Sorry to jump in but FWIW I like the Reported-and-bisected-by tag to
fully credit the extra work done by the reporter.
