Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F71382955
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 12:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbhEQKHI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 06:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236256AbhEQKFM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 06:05:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07401C061763;
        Mon, 17 May 2021 03:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ckgZjUQxdMOTLeNpdl3Cyb4DA2f/xWwrvKCpphG2X9A=; b=o4PUJhbYrH+ptqeYkQ2ry6dPb8
        +i7+JViJDkMfRh0w2q1ZeUtfHcmURAoSjG23mQZ/q2gHlFxlTyvazQmpphLFAnf4oGp2j2uIEzzR/
        lkULs1Ru+nYRsyEtbGHh0rITSrcpHbDgq3POx/6ERVJ1Ykvt6KYuR1oLgQa/WyuyM+9rv9ygeq9nG
        0Bu/6ggTTUGyexJIiPmglukmscrqA4i6FvxQ2xs9fEmyjEbM2bVSyjiaDKaI6BTuJaSZfOlmU3F3k
        WF5SJzmD/OaMeVWXXcm4jTWf255nZtde+dCqC49pEsErGJ/2GL9YbsBAcFqm88i06maypgBLCE6eh
        f6fYuspw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lia3D-00Cmcn-KB; Mon, 17 May 2021 10:00:46 +0000
Date:   Mon, 17 May 2021 11:00:39 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [LSF/MM/BPF TOPIC] Memory folios
Message-ID: <YKI+xzOZ4wPpvo66@infradead.org>
References: <YJlzwcADaxO/JHRE@casper.infradead.org>
 <YJ636tQhuc9X7ZzR@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ636tQhuc9X7ZzR@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 14, 2021 at 06:48:26PM +0100, Matthew Wilcox wrote:
> it would need to be evaluated on its merits.  Personally, I'd rather
> see us move to a (phys_addr, length) pair, but I'm a little busy at the
> moment.

This is on my todo list.  Fairly high, but after another block layer
heavy lifting project.
