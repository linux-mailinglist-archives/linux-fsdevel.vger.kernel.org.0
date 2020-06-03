Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53AEB1ED690
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 21:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgFCTNF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 15:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgFCTNC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 15:13:02 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7987FC08C5C0
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2020 12:13:02 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id h185so2233926pfg.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2020 12:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CkoWiDoL/Zq/F+IqZczO+Kwc2nE7mUda1hdD85BeSu0=;
        b=Im7k4BpWHf5cUhJtjP31WluIRC80Dh4kO15KBgHa7MngYAJYq4Nuo86tXjegge1ieG
         c58xCtlZzutl1JRhLS2A4MA1G5dTLq9fB8uy90FytHcJBYI3eXXJagFukzzUqBo19fkO
         WWO4STzP+TmDqTYM4VsmwTGOfF/VGwZapXBJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CkoWiDoL/Zq/F+IqZczO+Kwc2nE7mUda1hdD85BeSu0=;
        b=iZ1tn2tahewx1wxFhSPcoimjNu97RcIXSagwW8FrnUvr2rrwRXP4ueTx3JjszjPvB9
         pFgH3ALzx5f3xqGsc0iag3q2YixByLW1QbF4KPjN9Low8UpqpOXtbDcmZoRCjUHM6HOP
         YnKeORb2smRpEef/jLNlh1uzFyT/hP0glNBUu4N9FtqTL4Od0tG7JK9JG/Zo2bMlw/7L
         x9eP57w2AOJYI4JWNwewu297dqOETKPFmNj2oWoi4rEQp377AdWKdYeogASB7CGX/7fo
         HgE3ZtNhcSl5D3F7hoH0GTqdfDQ7aslHhYM7rDEDF0XmlkqacjHiSqlqSBgoIIBB0CCH
         gsvg==
X-Gm-Message-State: AOAM5327ovQkbyoK1oF+tNXi9r0OMkC+x1Sv7ValUtdxfZuRhoGAP1M+
        y4nQxVowCtwQpSjd3VN88DwQfQ==
X-Google-Smtp-Source: ABdhPJxIstz9B8KRFExR5fLW62d3Pnt2ACFoUcTCLu0REb0tVNc5Zi4u2wL1RDRt2PF3fZ3/q4uaqQ==
X-Received: by 2002:a63:554e:: with SMTP id f14mr808751pgm.191.1591211581537;
        Wed, 03 Jun 2020 12:13:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 9sm3335179pju.1.2020.06.03.12.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 12:13:00 -0700 (PDT)
Date:   Wed, 3 Jun 2020 12:12:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luigi Semenzato <semenzato@chromium.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        NeilBrown <neilb@suse.de>, Yang Shi <yang.shi@linux.alibaba.com>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Kiss <daniel.kiss@arm.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: fs: proc.rst: fix a warning due to a merge
 conflict
Message-ID: <202006031212.6FDDF5AC18@keescook>
References: <cover.1591137229.git.mchehab+huawei@kernel.org>
 <28c4f4c5c66c0fd7cbce83fe11963ea6154f1d47.1591137229.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28c4f4c5c66c0fd7cbce83fe11963ea6154f1d47.1591137229.git.mchehab+huawei@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 03, 2020 at 12:38:14AM +0200, Mauro Carvalho Chehab wrote:
> Changeset 424037b77519 ("mm: smaps: Report arm64 guarded pages in smaps")
> added a new parameter to a table. This causes Sphinx warnings,
> because there's now an extra "-" at the wrong place:
> 
> 	/devel/v4l/docs/Documentation/filesystems/proc.rst:548: WARNING: Malformed table.
> 	Text in column margin in table line 29.
> 
> 	==    =======================================
> 	rd    readable
> 	...
> 	bt  - arm64 BTI guarded page
> 	==    =======================================
> 
> Fixes: 424037b77519 ("mm: smaps: Report arm64 guarded pages in smaps")
> Fixes: c33e97efa9d9 ("docs: filesystems: convert proc.txt to ReST")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
