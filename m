Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942DD2659BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 08:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbgIKG5j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 02:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgIKG5h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 02:57:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24B2C061573;
        Thu, 10 Sep 2020 23:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AWt8e+Mw6r/7C0+LOLgGANF7RmbTfkJ8gpEXJHWIld0=; b=G6cv9eisU0LtwkwwXlXiXiLdhR
        jmkKpqdBGd+Qsm4IhkTCC+p4FisKqwrSIcQ4WzxXmnBQb9HShW57MDI2CdCBOdt87/PmEA5cd9RQd
        TMmlAZqktVm/kEMuPzfQLN6RswYqw39EhZlX5KU7J25019UQo+TZ9NNqY0OUl7J30W7nlPw98UHFt
        m7TDXq7b/WBrv4qgahljvhYOrkyhjvVvZrJ/FqWUlZMZ7u/91o+NY6w8beXkrZpfBZJPQbjVLqnig
        5Mvvi8c7ai5K+fu26Utfic43zLfLMYIRJ+6ZpDxMbfWG6tY1zXJtg1Y0LCplMKVTRNP3F8j+Ngla5
        e0EL5+6A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGd01-0000HK-76; Fri, 11 Sep 2020 06:57:33 +0000
Date:   Fri, 11 Sep 2020 07:57:33 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Rich Felker <dalias@libc.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-api@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: add fchmodat2 syscall
Message-ID: <20200911065733.GA31579@infradead.org>
References: <20200910142335.GG3265@brightrain.aerifal.cx>
 <20200910162059.GA18228@infradead.org>
 <20200910163949.GJ3265@brightrain.aerifal.cx>
 <20200910164234.GA25140@infradead.org>
 <20200910170256.GK3265@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910170256.GK3265@brightrain.aerifal.cx>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 10, 2020 at 01:02:56PM -0400, Rich Felker wrote:
> Would you be happy with a pair of patches where the first blocks chmod
> of symlinks in chmod_common and the second adds the syscall with
> flags? I think this is a clearly understandable fix, but it does
> eliminate the ability to *fix* link access modes that have been set to
> ridiculous values (note: I don't think it really matters since the
> modes don't do anything anyway) in the past.

I'd be much happier with that, yes.
