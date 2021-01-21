Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A62A2FF644
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 21:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbhAUUrz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 15:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbhAUUrx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 15:47:53 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26CFC061756
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jan 2021 12:47:12 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id 19so3108338qkh.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jan 2021 12:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/tjtwUwUvkuiNzh76iFV5D8ld1zMDjPWbiessv/dJqU=;
        b=eUKNXJ8zM0JVfJmpFlkOcDWi/HpkA4Uw6XaHP1IH6XXbjYEGcAVUIzwoxYg8m+D38E
         ss5ZPoXyoi9Xwb9ajsHZfgzJDT/cpYDGYmst+Wl313IwLh3AuzCyMZZ6r02R2f5DXBJH
         10sqQ/VivdnaE4iRz4JkrV+o9J647jXPijoHbhwInhj7QHvPMu88PVFFA4W2CXTiXdnA
         eZ23W2p996RCtZE76TjeHcgXf8I3SNkyj6M2Mrs2dO4NmIpwccXKeXM6GO9QkW9ajc4c
         95z97HPxvBxlqlf/UkiJW153pa7YA5bV7+Loih+MO8mnKrfQO4m/r7hbHCDBfWDe6Kku
         ym8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/tjtwUwUvkuiNzh76iFV5D8ld1zMDjPWbiessv/dJqU=;
        b=fdK2LP6u8/9sVFI/BlO/xrD9LNhzZ/a3StrxeFElr3w0cirneo2p0Q0vMSK6XvfvXK
         CpoPRrb0WORVBGaAHCvAQFBY1UukDtM00S3/+m5CSYRJ63XYBpFGECLa1CClkSvkbSJK
         iylsvB3le5SBE77FnAl24wlaxMr7bWPbwa/e6cDUt43Gh+GFFGEqP+MZoLAT9wh0E1J9
         uHWU0IvvA8XGCPDyrnrhhnLKZdV5KapVhwL9vuLkw/0QAqBoAGmftbOKzeDE8pwJNQdY
         mPtRffrtby51Knybnrr7Y1j6IsCTkY2yNXM8OyZUu9wqhTyteNLl3GCO9CZj9L3ixerN
         OFPw==
X-Gm-Message-State: AOAM533t9PudsI+MekOzZoY5b58BTcl8q45iJ1gegzSmi+e4pOVrds4B
        FrehJYYz9fanJ7972ojI6XukXz1UZ0ZlDw==
X-Google-Smtp-Source: ABdhPJymQ68qH/Kk5Gv0vW1cNoekc6T0599882PqygAgCoQEki5Ud+OOT6jsiKXim3g3Bq/F5NrofQ==
X-Received: by 2002:a05:620a:15d0:: with SMTP id o16mr1792985qkm.222.1611262032268;
        Thu, 21 Jan 2021 12:47:12 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:b808])
        by smtp.gmail.com with ESMTPSA id f26sm4184194qtp.97.2021.01.21.12.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 12:47:11 -0800 (PST)
Date:   Thu, 21 Jan 2021 15:47:10 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-nvdimm@lists.01.org, Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v2 4/4] mm: Remove nrexceptional from inode
Message-ID: <YAnoTo1BNADBjL9u@cmpxchg.org>
References: <20201026151849.24232-1-willy@infradead.org>
 <20201026151849.24232-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026151849.24232-5-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 26, 2020 at 03:18:49PM +0000, Matthew Wilcox (Oracle) wrote:
> We no longer track anything in nrexceptional, so remove it, saving 8
> bytes per inode.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Tested-by: Vishal Verma <vishal.l.verma@intel.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
