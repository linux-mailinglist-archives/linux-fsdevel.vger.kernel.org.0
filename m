Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8585A2A47D4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 15:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbgKCORC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 09:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729359AbgKCOQC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 09:16:02 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9492CC0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 06:16:02 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id 126so22348477lfi.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 06:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a9gv5kRF1TAOEsPNy0ASAI0MDTfRXeZ38ProsMVeXYQ=;
        b=1uKcWqxfPVgTGjaKzWFN4y0aYEYIe1k4mmfFhSdUGVJOFcCfQ3DrLY+HLkBKHcDKoG
         lHzl0qSMqjBvoDValimJMHTzHKRCdnHz5TuqMSyBCbuslc8bU252nXn7TbJ1pDf0Q3AH
         YRbEACl602dG9U7kfPad0ol6nyKbuXjecC15cgO/VGbHW+KgpHToZOnTXl+IkxgE0RvU
         NON1vvvtWBo0tjp8/DmyC0Aft7uNBf9Z/97/OESA5gTEukHUf4cxWnY36m3L4zjQucGw
         oY7CLxiiKPvWOeYbDT3XzNz+2avuo2DvciQ8XvhcAF4MFul3rlz0Y/ma8pBpfdylCY6Y
         SVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a9gv5kRF1TAOEsPNy0ASAI0MDTfRXeZ38ProsMVeXYQ=;
        b=LB6J1KpfeF8f299y/QEVIt9tvdyYL4WNeJYOnMH6kpl/Ke7y/GfIkr13dtt8AkH0ia
         8ekJ6R/SkbGZt/IldKtsikILGtanVF7xf+igKseXqlM8dT1BqODvS8qxHZMRMGr4Gomb
         beRYSFnCodS+3D0uhBUEKOCl7sL6AykJSJOLG8hdGrBjbw+NP8ddEyeJdEEpj7w0kbdE
         VpHS7tgt/e/+TtAFnT1Prhg4fq4is877AEFs1H5eoGharDOpjPhzkcpaZGLtwmTeBz8x
         jn/2tlcf+wI0R1X1x+jSwVZQqd//MWFv9BQBvWcewLEMRY2O4zsFkmH2tSdYjEqfDRIp
         NtJQ==
X-Gm-Message-State: AOAM5311T8TCBHOpSBoSkTEsx0CBscadWubfXTuytDljGK2NVRAjlSrO
        afAE24dk0C24zWNKwOuoKTkArQ6J1UIYqQ==
X-Google-Smtp-Source: ABdhPJwnyyyrroqZF05jvl4O9xQ5ovDUuXNo/iH48fqaU94GprB7snvK5YYvvDCUsa6cndaeDB+ZKA==
X-Received: by 2002:a19:7cf:: with SMTP id 198mr8412275lfh.266.1604412961000;
        Tue, 03 Nov 2020 06:16:01 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id e10sm4314433ljl.41.2020.11.03.06.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 06:16:00 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id A5E6D10231C; Tue,  3 Nov 2020 17:16:01 +0300 (+03)
Date:   Tue, 3 Nov 2020 17:16:01 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/19] mm/filemap: Rename generic_file_buffered_read
 subfunctions
Message-ID: <20201103141601.4szfbauqg33xbyzm@box>
References: <20201029193405.29125-1-willy@infradead.org>
 <20201029193405.29125-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029193405.29125-6-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 29, 2020 at 07:33:51PM +0000, Matthew Wilcox (Oracle) wrote:
> generic_file_buffered_read_readpage -> gfbr_read_page
> generic_file_buffered_read_pagenotuptodate -> gfbr_update_page
> generic_file_buffered_read_no_cached_page -> gfbr_create_page
> generic_file_buffered_read_get_pages -> gfbr_get_pages

Oh.. I hate this. "gfbr" is something you see in a spoon of letter soup.

Maybe just drop few of these words? "buffered_read_" or "file_read_"?

-- 
 Kirill A. Shutemov
