Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3090379667
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 19:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbhEJRu6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 13:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbhEJRu5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 13:50:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C28C061574;
        Mon, 10 May 2021 10:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=dGzXWiBIPYg+gHFXCo5+gYyyl/xbSNUj05YBsxBkKe8=; b=TzsLk/UPp7TTb4MvqcVD9zoDXZ
        rHyMKq6Q4jRNs6yCv+32xySjEIIwt/9pgX7/ATzcEiwl6eBanM1u+HOLd1XZZq+36foWXNQ8ZOGad
        P3YSTooLH0o9NQFObpg0MNMXVW1d01T4/wQaHyQEeoqx8cK40MJO2WJ+Vp5K/pxFv1D5TiB31b4YW
        svhBv2ogYl9gn+D7ZKG0LGvKk0E3JD08NviomHnZ3BGASC8RE29FCVUiToBGaRfs1gqCpmi7q/trW
        TVlX02Vei9TkHCk3iLLx+03Un471Xp67kV9iqJzBzUc4620f7o81FMCEaqZ6fTqxGRiflCwNeRtVV
        QAGE9yFA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgA1H-006QxS-PK; Mon, 10 May 2021 17:48:55 +0000
Date:   Mon, 10 May 2021 18:48:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] Block device congestion
Message-ID: <YJlx9+FQUBu5HmcI@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


I wish to re-nominate this topic from last year:

https://lore.kernel.org/linux-mm/20191231125908.GD6788@bombadil.infradead.org/

I don't think we've made any progress on it, and likely won't until
everybody is forced into a room and the doors are locked.

