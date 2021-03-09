Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9655633302B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 21:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbhCIUpK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 15:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhCIUpH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 15:45:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC4AC06174A;
        Tue,  9 Mar 2021 12:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CPEHefCp1tuR5XHcbGjm34KQ8Gbf/1TnR/LUOCtpSwg=; b=STNF1QMeQUGVuG7WzsXIdYHEPw
        mlJcL27bhjlqcoYUQpTiuDMicf30um8+4Hr22vNDWrwhhqVnBZ8ahGqv7N5Eso8U3ZsG9Dlrrg4+z
        k1StGmPmU7UIJ4e5CtadlvKL3cXYMaKoslo0OLEwIOYFfT8jFOGL7clOuQTMkQrwAfT6znevvfwiD
        s+9o6vjTtDL0lU+zAIKlHZbjuOLox6j8Q7JVTNhe1vMXJpeIjmFI7DoPEgxNoIRxgniNKi1Rs0z3l
        d+G8y/v0ZxGaK2zM26PrLchgRx1LSIbHGO4/0wLvMHBu+eslb7jG1OumCForpV7MPSXwkcdwrCTCg
        8tdPTPng==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lJjDy-001Kx2-74; Tue, 09 Mar 2021 20:45:02 +0000
Date:   Tue, 9 Mar 2021 20:45:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
Subject: Re: mmotm 2021-03-08-21-52 uploaded
Message-ID: <20210309204502.GL3479805@casper.infradead.org>
References: <20210309055255.QSi-xADe2%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309055255.QSi-xADe2%akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 08, 2021 at 09:52:55PM -0800, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2021-03-08-21-52 has been uploaded to
> 
>    https://www.ozlabs.org/~akpm/mmotm/
...
> This mmotm tree contains the following patches against 5.12-rc2:
> (patches marked "*" will be included in linux-next)

Hi Stephen,

Something seems to have gone wrong in next-20210309.  There are a number
of patches listed here which are missing, and some patches are included
that aren't listed here.

> * mm-use-rcu_dereference-in-in_vfork.patch

This was the one I noticed was missing.

