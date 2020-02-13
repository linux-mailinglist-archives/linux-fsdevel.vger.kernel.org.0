Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 825FB15BFC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 14:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbgBMNvg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 08:51:36 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35564 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730121AbgBMNvg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:51:36 -0500
Received: by mail-lf1-f65.google.com with SMTP id z18so4335947lfe.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2020 05:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1lG9y4Y60ZGG6VZ/pe41Q4KolNDjo1CpYjwUfuOyDDQ=;
        b=NyzKwIB/nqaOMRkb9Q43JHPCN0+0LktJbc5T5aU9knSi6qgM/1tZmDQKiVzznl/UVR
         75tRahnZmakJR0nRQo32r9z+u4nZma+cH7hWKnbGvMTPxV3GDARIvoZbbZ2D3dt2xdfD
         r1shDQWIpcKOylKA+tDsQYiGEACIK9ajrKZgAljbiDQbyRi0OxVjFe4d2DG52n/+Lpmu
         id4dnWKrwqUn9Z0OJMGt14GsFlMnvt3TTLNdW7pjuRiKbeIpZbgXb8hpLpfB/aXiIeCB
         Pu+RFN9pF7jeBEORMAsEPKcWdcgR8j4cx5ed9RD1KOzg1t8aKqyhlLKHe+ebooGVkgSn
         F9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1lG9y4Y60ZGG6VZ/pe41Q4KolNDjo1CpYjwUfuOyDDQ=;
        b=hN7PiJoeypKQ/ZsE2i/LNJqPoV6bZCg/bWTvOypDqX3DmSUZrXcQjpSn9iAOD1gVZC
         s6R9ccPLrj5p8sq07xENJp8crfbJbiuZh72+4AkyZwvog1CpImQZW0hCKV+lPP3dtzIu
         beKW0jZff5kM/o3D4/XV5015OPYXvsBbPRpm/In4DaKjKC+rM3kGP8AHjjJmUsrm148v
         G+AT8xNaYMtjxW66l1IHu2h2TDSloNoCXsQJNboCDNYQCXt6fXxSVM4eVQj1tb4WmLRw
         KBDc9lhNdXZv41jj3UZ8mrFJNzCgFwSlNVIQkRAFOF6DVoGJsOknFFiZhf7v72+SgDvl
         kPfQ==
X-Gm-Message-State: APjAAAXy2G9YboRK7kqMl9cdhGrO2G2ZBiPDS35SNzGFTHRxzaL+dRCB
        0mnw/wvf9njXT5jYdG/f+RJDyQ==
X-Google-Smtp-Source: APXvYqzWuKQ/3f41ZkQFFOSdLEdLeEplpVEvsmF9jt0nklDHYyh1huhxdtI5NjO3NWHolQTzW8+Zkw==
X-Received: by 2002:ac2:5e7a:: with SMTP id a26mr9585633lfr.167.1581601894891;
        Thu, 13 Feb 2020 05:51:34 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id r2sm1670194lff.63.2020.02.13.05.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 05:51:34 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 6F7B0100F25; Thu, 13 Feb 2020 16:51:56 +0300 (+03)
Date:   Thu, 13 Feb 2020 16:51:56 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/25] mm: Unexport find_get_entry
Message-ID: <20200213135156.cqoqokb4bzvro3mp@box>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212041845.25879-5-willy@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 08:18:24PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> No in-tree users (proc, madvise, memcg, mincore) can be built as a module.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
