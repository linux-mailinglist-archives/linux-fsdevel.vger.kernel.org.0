Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBA119C16A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 14:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388156AbgDBMs6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Apr 2020 08:48:58 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36185 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgDBMs6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Apr 2020 08:48:58 -0400
Received: by mail-lj1-f194.google.com with SMTP id b1so3108173ljp.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2020 05:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lYeihsyD1fgtsaaviUySdwiJfpdDCETrX8ZlRRWpccU=;
        b=Abg7GjJoYnAraCf6aOfosb6FqG+eTOdeNrL3mrDUdjLkPCzuwCC0hPu9eq3CalyDF/
         3ZiKdr5g5TqX0rMe7iojDUEzNW3864dXxaekOrcZyBwRMBfafEgVVDZt20YBe6aVjxmB
         pH2URGJFaflrntTX+zCKhiK9vcUn2suRm7cWh9FNvScdn0zD3MiU9UdSOHKhobT47fq5
         HAYbqPz/VzSKkmmyB4nbT8qCKbeq7cdyek2zZNL7c7GVLGHlsef7pSLwQCJ8OPROi9/+
         kM5FTn7oTnigbKDXP1A6wYIFP36+ZZlP3k1yDmfPjq5nIqgHI6lTZGBOCKJf/dDeS96O
         ZFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lYeihsyD1fgtsaaviUySdwiJfpdDCETrX8ZlRRWpccU=;
        b=QzQWpeCm2ZKHdB1KnNTG+RAwRM03hIpYFNA7g6BF2Po/H2tCWs8aDQsQmG2H0ktNdK
         rbC8HBooWPeZOY2qfGJ6e/zEpO22qdi6egw8L/v+ZwHax2f2PBwenAGMcttsTCgCWfOI
         eiThrP48h92mnTEA6zYBA82vqPnLwM45s/3iHWqy4ns1t2KxXdGFFS+oIvYqPYikr1iT
         Vg1IGEXZ5Y4JxtolbITDC78yzYehbAu15PHBQg/EfgQvSj7f95bs/w6+P/IXzPR/aEyF
         Pl8FLarHFsEdfr0qWRutpgl5e3jbcxIEMdDr4HwQUR/Pl5oA2HW0iChP4gxN5cumle8N
         vQPQ==
X-Gm-Message-State: AGi0PuY9D78X1CZevkJAIyjmmrAqvJp2rGxQzl2OZFKK5w6fb13+iRX/
        2wrNYvhvZ5E8ighJqcpkaetgBg==
X-Google-Smtp-Source: APiQypKp1RSSi+KJ9nyHwlVlnanUdnQdtiTt1QU8FU/HfLDSUahcRJzq4dyXY4ovVbElFTtpO/nXLg==
X-Received: by 2002:a2e:9912:: with SMTP id v18mr1818390lji.199.1585831735731;
        Thu, 02 Apr 2020 05:48:55 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id m11sm4164861lfj.90.2020.04.02.05.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 05:48:54 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 0B0711020A6; Thu,  2 Apr 2020 15:48:54 +0300 (+03)
Date:   Thu, 2 Apr 2020 15:48:54 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Samuel Williams <samuel.williams@oriontransfer.co.nz>
Cc:     adobriyan@gmail.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] Fix alignment of value in /proc/$pid/smaps
Message-ID: <20200402124854.n3wteh22uputorz3@box>
References: <20191230084125.267040-1-samuel.williams@oriontransfer.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230084125.267040-1-samuel.williams@oriontransfer.co.nz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 30, 2019 at 09:41:25PM +1300, Samuel Williams wrote:
> The /proc/$pid/smaps output has an alignment issue for the field
> FilePmdMapped and THPeligible.
> 
> Increases the alignment of FilePmdMapped by 1 space, and converts the
> alignment of THPeligible to use spaces instead of tabs, to be consistent
> with the other fields.
> 
> Signed-off-by: Samuel Williams <samuel.williams@oriontransfer.co.nz>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
