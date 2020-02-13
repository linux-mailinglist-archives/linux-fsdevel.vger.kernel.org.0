Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B64B15C34D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 16:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgBMPj4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 10:39:56 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43827 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728624AbgBMPjw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:39:52 -0500
Received: by mail-lj1-f193.google.com with SMTP id a13so7110678ljm.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2020 07:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NHktFnZlX6uKMwJC+qraMNZiHbiScODIMZ6tmW6mHl4=;
        b=NftAHAky8nG3HwoLsfo/A8XP/u8putXbTgMDGVG58zTqt/ANXlRTYfcUpPXIjIulCW
         F3frpsniYt6j0+nbWgw7d9lx35BuGxO/FG96mRE8mhOsVGxY+XQjoPIrnqIMuOrN1/sT
         E7/82AQpay1JLLCwW1jOIPaRMJa4OX3nkjmTI4lbVG1YQPVm1h54D4/xbiKtRvEweF0T
         48Vwo0nYCFVEAsONA2QnyFuiJknvu7JV84/cePCypvp5ncTwBb82VdR5tASR8Om68/Xx
         IVLOFu/1sRo6fR4cGOO5EzsJQn35BxU+zKuSxG+WjrfJHZfuceELhp+8PnpUHRqeb8ZM
         UHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NHktFnZlX6uKMwJC+qraMNZiHbiScODIMZ6tmW6mHl4=;
        b=XrnEuKg1oUdeRTiRonJY9sdTAZpmT6oSPtpzuZ/3EWUD1spX7wFvnxXGbrDaDFQYPy
         bNQyz0Ho+iVPu1Y2ps17LF+iwWZZuOyq6xfgkTtmd711Qj1PhK2u2sKnDopKHAyhlhr4
         TpapKgnfxhZaVXgUmLxKBu4r4Nsnq0SJLSbQqtZpOTUJsQ/jw93rp8JBk4YJsW0qeZ7c
         sTxOY4iK1RhngNJ6tQhtSMFF7KWGFrw8WhgVz4KsFxABdxH4fdVp+yPQz/mFnENAShE/
         yQToiX/iyAb97L4MopNyTKykCFjpZ9jDL1ZWGo+y7OoNmcDo+w9Kn6wN3dqiPcahOdiF
         4++w==
X-Gm-Message-State: APjAAAXPVi1JgXL/bj5rRDiVsUYveK04OF3ojkOb5z0NJDgTe0N5fqYE
        JbT/0MBRlRBPhGT+oE0Aex9hxQ==
X-Google-Smtp-Source: APXvYqwEQWxVztZsHujLgYXUzp80jKlSTGmzeS7kguAQ03NeSNKI0seeS7EaeHwwCRbzQupO4lEBBQ==
X-Received: by 2002:a2e:93c5:: with SMTP id p5mr10069149ljh.192.1581608389545;
        Thu, 13 Feb 2020 07:39:49 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id p12sm1474818lfc.43.2020.02.13.07.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 07:39:48 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id F34E7100F25; Thu, 13 Feb 2020 18:40:10 +0300 (+03)
Date:   Thu, 13 Feb 2020 18:40:10 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/25] fs: Introduce i_blocks_per_page
Message-ID: <20200213154010.skb5ut6fixd36cxr@box>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-11-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212041845.25879-11-willy@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 08:18:30PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This helper is useful for both large pages in the page cache and for
> supporting block size larger than page size.  Convert some example
> users (we have a few different ways of writing this idiom).

Maybe we should list what was converted and what wasn't. Like it's
important to know that fs/buffer.c is not covered.

-- 
 Kirill A. Shutemov
