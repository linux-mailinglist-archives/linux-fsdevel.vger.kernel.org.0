Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1CBA15BFB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 14:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbgBMNuX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 08:50:23 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36437 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730129AbgBMNuX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:50:23 -0500
Received: by mail-lj1-f195.google.com with SMTP id r19so6681288ljg.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2020 05:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m+rlYvLRsOkN6kq5seXrKF66SMnxnLNdmvwj49/tvgM=;
        b=YDaml+BkRp8WmvdkKF3upnYZA8Xaqpm8c699+QuaD2omLucDmAd+QXX9pEJU+FjjP9
         BrlP9ZsO1HdG+ik4aNS6DeYHjv8l2GIw70YKSmrCaB/E6+QRTqUb5cWOjLf0h8BNg079
         RXzWyfdReFPfN0TWJaAFQqunuN9+kaO4AzcReIhxcf/JGcZXIu1oTYIe5vQzdO5vXhZ8
         Vw5InDmnZpVoBYSnedvAhOSQxreTQOgxLWmns09D5KyQPoFLkn1CrcfgKQtn+G+1BDe1
         OlGHN6ZByyF+IuitV9K6ZCMtFgQkdIlIW5dm9Nf5qZ+HbZ9ALG8EZ9XkB0srB6nEX1Lv
         nxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m+rlYvLRsOkN6kq5seXrKF66SMnxnLNdmvwj49/tvgM=;
        b=Se2igoKmCm2xbIaZRMtphi5CuwVQFrH9TM3o2V3C6wpelYZ6miS2NDOBGHNpTZGueG
         Ox28+YMsEJLG4PToRQ2fTnXslAV638SkrI4FamL0x3CrihCYDLAWdxmI8GVtCFGUlKMa
         JZMU2+cSO10MY8psp/eCb5PZpXt8CS7YEBRZvEiiEbCxc2DVITmR+Zbx4646kqI9H7na
         IbTNWgyc3PJYQZkmtYh4F/kJju3jaedQd6LfB4FRzfvQzEz6DvAs5cPAYdmxWd+O3Im+
         4QBS0+axRVLvyGgWe7SoIJNn+wn+TRIOHZVohsQgDriP28/nXmdArcB5I4U/H+RcLHo1
         syHg==
X-Gm-Message-State: APjAAAWc2zq4S33d27/AGb3/Fhy4QjRwLwSFmJH+eiyUggYQE4fNGrtz
        BVN9y68qcsrbCcyI6Y5IbjGX8g==
X-Google-Smtp-Source: APXvYqygarQzTkN8U4SIQp/1aCbyaGE04Manoyi2AcEtokx4Tzg1tb70e4h4S/bMK5X/3aysyIkiOA==
X-Received: by 2002:a2e:721a:: with SMTP id n26mr11205396ljc.128.1581601820951;
        Thu, 13 Feb 2020 05:50:20 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i4sm1492140ljg.102.2020.02.13.05.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 05:50:20 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 7F1B3100F25; Thu, 13 Feb 2020 16:50:42 +0300 (+03)
Date:   Thu, 13 Feb 2020 16:50:42 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/25] mm: Use VM_BUG_ON_PAGE in
 clear_page_dirty_for_io
Message-ID: <20200213135042.jag2wruqllkuecx6@box>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212041845.25879-4-willy@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 08:18:23PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Dumping the page information in this circumstance helps for debugging.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
