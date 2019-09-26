Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70291BF4DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 16:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfIZOPW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 10:15:22 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46839 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbfIZOPW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 10:15:22 -0400
Received: by mail-ed1-f67.google.com with SMTP id t3so2155229edw.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2019 07:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vGFtvroMWb8i1UdgYB+FIzFbUPu5RC5n7gywEg0Ns3c=;
        b=JFYJOt2TB9b5dmR12GgayBbj3a/6oM6CocwMQzb8vdNlNcaueXrxse5cVDSoSa3CMA
         jWz7F/9pNEyCwWevcB2nqWdY8kOXhAetnCnhk0FzXElb9xkWKBs3Zl0Vw2TTyze4OVtQ
         jA6XjwXZsF36fzPI4WI/WDUywLYhhMNW/pFSQKjc+UikmOO4hU+Nmbcxwh5kFTSGmE7J
         rgdL6O4aD8pm+ZtenP+Jvs80CqEJO5X3INxIbDdL8vfv4I4KlRNvOF4AFSDT0BrNaLq1
         Wx+dWvWRkEY0iNzmwQo+OsIVxEHbi8psveBR0XcbigEAo27vZc2NK7kmghiGh1fFPY2o
         kKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vGFtvroMWb8i1UdgYB+FIzFbUPu5RC5n7gywEg0Ns3c=;
        b=R1CYFPsZP1+d2AGiGp2QmEo2etZR0kkCpcBSzti9t3fS4wlAWIs6QTFMLBFr+IWGZg
         vSobReTlhpNwa8TLwQCtdHtpDN58wSPLA96135JSFDiAxzzLG9xwIEiYO4XDku9ZCcTk
         NmmSxvMo9M1xKRhZU11zdFAgI1O/0OGPOuaCNcDLR+7NepFARF5LE4mOXMWjuekwUNto
         zF1zzZc68brcp9AIjcMVnM3TE4ps3SYR0qSwVahVko1fmkBtXY2w2Q7U3oxagHGYDhC7
         1zr02nPM9ijfNriASoOQaaZXz0wPQNwsG5ln+Vcm3m+hl6TmjGlECmwaplo/cPUgfSC2
         GM6Q==
X-Gm-Message-State: APjAAAX+0JL/HVDGdFamR/TQxTau+dUzE1Dd1yv2O24WqCBoKhLP0Ou6
        lsH9vfI8Gtqm+WEw0Cpqh+Q/Ag==
X-Google-Smtp-Source: APXvYqxL1Tay1aeeI2DJfAbE/xiOHQlPvFzqDtA8sro5dyATqS6m3DqDyn6gFl+H9Log7+18MDe2+g==
X-Received: by 2002:a50:b7ed:: with SMTP id i42mr3813685ede.52.1569507320676;
        Thu, 26 Sep 2019 07:15:20 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id g8sm497256edm.82.2019.09.26.07.15.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 07:15:19 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id D5333101CFB; Thu, 26 Sep 2019 17:15:22 +0300 (+03)
Date:   Thu, 26 Sep 2019 17:15:22 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/15] mm: Add __page_cache_alloc_order
Message-ID: <20190926141522.sdjyj45t2ruev2sy@box>
References: <20190925005214.27240-1-willy@infradead.org>
 <20190925005214.27240-9-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925005214.27240-9-willy@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 24, 2019 at 05:52:07PM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This new function allows page cache pages to be allocated that are
> larger than an order-0 page.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
