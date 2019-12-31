Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD3EC12D8A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2019 13:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfLaM7J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Dec 2019 07:59:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35224 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfLaM7J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Dec 2019 07:59:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jjIwlw+Ag6P/8YqmQwLGswD9wo5RQIXZ+jPv/s6bcJQ=; b=BR72JQHcMuxtsBv2RelAqWmwj/
        AiuqoQwXjwQzRYQ9PvZV74bLyupbmEwRmIUY3DUhiHySn8edDHxNtwhjDokGltU/QInff7qqONSdJ
        7lCB6jOExIsbytSdNvxqfAS62Azyr3LoKdWXtXUWDbynOBuAv5XsgIGzUQAZOJRVjcK/C5U2Te5J/
        fwjyYA9U0KlARWWxGX4BlSlkoUGgx3vhYBgMImt/q1uqWp0ENsw7Ce6DHCUjafryAai3j66rA4SGd
        FEFx8N2vsDc+Fsdeh1auYNfKTfbAQVWKl5JCRcBYC/o71XPLNHKoeCESexuHyNwgFvV2/d3Die6E8
        zCy6oHUA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1imH76-0002sw-GG; Tue, 31 Dec 2019 12:59:08 +0000
Date:   Tue, 31 Dec 2019 04:59:08 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [LSF/MM TOPIC] Congestion
Message-ID: <20191231125908.GD6788@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


I don't want to present this topic; I merely noticed the problem.
I nominate Jens Axboe and Michael Hocko as session leaders.  See the
thread here:

https://lore.kernel.org/linux-mm/20190923111900.GH15392@bombadil.infradead.org/

Summary: Congestion is broken and has been for years, and everybody's
system is sleeping waiting for congestion that will never clear.

A good outcome for this meeting would be:

 - MM defines what information they want from the block stack.
 - Block stack commits to giving them that information.

