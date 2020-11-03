Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CD82A48E5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 16:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgKCPEK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 10:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgKCPC6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 10:02:58 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F55CC0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 07:02:57 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id l2so22635172lfk.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 07:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7jcPc4llK3umLuED1mkEXvhY3Q7RrHaM1AI2cqwIIJ8=;
        b=tvx1xqsTPdLgHRogOOX9SdNUmX0wsDUfRENvHTZWLdbdH+UyHISAsypSXOQFJ489A6
         tfOXGwSdZ48nF9xEdPXLhYvSgQLBXdnKSB90wOvz+nfP8CE319sdTO0SaTIIE3/tsLJT
         ocwI5Il2HKEhpF7/P3dS2zezlAYcCl+6l3W7HWQ+haQ+V7uPmBRmuHhp5l8VpvHTl6d7
         1rk/Z2vPCCXCj8siVszfyL93gCwZbxOCwyRTwPdo42E2rxKo4Qyvc59nFqjCd3sG9599
         YOMOMN2L7EffCV+14jSZaDdDQqp3wdg4kihTGeNbOvNFmWCuYuDoc4d/5u1p8Prc0G+2
         Z74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7jcPc4llK3umLuED1mkEXvhY3Q7RrHaM1AI2cqwIIJ8=;
        b=Rzau650x3bNCZrn/de0+KVsOerKXnkfEtNaozCjewxg6RCGTLR7ri2H9qLTtMBZ7nw
         W0rtzlYiUbcUmU4+7SJYCIsNIiExM1fm3i8pM0/68nIxsHMKfHh9Sq3aJRCe31toK26+
         tzvmtzhGQJmoOyfXi9GCaiZohFZOgRus5EbhRr4zABpvELKov375Gk1VN7KHIx2cEGiM
         IbsDlpPpBAig58GTmwcHx+U+BnjwxkMEkaGZC7SRth/9WO1KEwytQj+S7hvYaUEdSjU5
         y02n+nB1wS2CLBcw1SoSXry5XebwBYFfXzsJakrvJh41hyK5DWabFtfbCUPlFpjuP0oj
         l3qA==
X-Gm-Message-State: AOAM532ERsSVtgsUf0sx14oy+eBGm29D8xZ40xiDW30bkuol37vuc7et
        46NLR/jZoXgGmetAv5Owbr9UOSJd7Ntwmw==
X-Google-Smtp-Source: ABdhPJwmJPOx1mT33IvdRMNs1KxjItkVvaeqC20e4RkaPSfGvVQoyrzsYzwBMm7hk+ZOcmOj4Irqsg==
X-Received: by 2002:a05:6512:1087:: with SMTP id j7mr7485959lfg.122.1604415776008;
        Tue, 03 Nov 2020 07:02:56 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id m22sm3949065lfb.27.2020.11.03.07.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 07:02:55 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 9755310231C; Tue,  3 Nov 2020 18:02:56 +0300 (+03)
Date:   Tue, 3 Nov 2020 18:02:56 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/19] mm/filemap: Rename generic_file_buffered_read
 subfunctions
Message-ID: <20201103150256.5b3fybreliugegxf@box>
References: <20201029193405.29125-1-willy@infradead.org>
 <20201029193405.29125-6-willy@infradead.org>
 <20201103141601.4szfbauqg33xbyzm@box>
 <20201103144014.GV27442@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103144014.GV27442@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 03, 2020 at 02:40:14PM +0000, Matthew Wilcox wrote:
> On Tue, Nov 03, 2020 at 05:16:01PM +0300, Kirill A. Shutemov wrote:
> > On Thu, Oct 29, 2020 at 07:33:51PM +0000, Matthew Wilcox (Oracle) wrote:
> > > generic_file_buffered_read_readpage -> gfbr_read_page
> > > generic_file_buffered_read_pagenotuptodate -> gfbr_update_page
> > > generic_file_buffered_read_no_cached_page -> gfbr_create_page
> > > generic_file_buffered_read_get_pages -> gfbr_get_pages
> > 
> > Oh.. I hate this. "gfbr" is something you see in a spoon of letter soup.
> > 
> > Maybe just drop few of these words? "buffered_read_" or "file_read_"?
> 
> gfbr became filemap.  See [PATCH 00/17] Refactor generic_file_buffered_read

Okay, works for me.

-- 
 Kirill A. Shutemov
