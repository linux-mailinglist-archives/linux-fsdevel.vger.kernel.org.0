Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D29115BFDE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 14:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbgBMN6q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 08:58:46 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36746 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729991AbgBMN6q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:58:46 -0500
Received: by mail-lj1-f194.google.com with SMTP id r19so6713555ljg.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Feb 2020 05:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MXKPRgQyjfEBEssBb4S8+9+QLdHW4asZtIOfI7X/G9o=;
        b=VVu0rajxgf9FqovZRSAKOCd2ZcTalbIBV+HO8Py2CjfXwk8MWsbIbghaQuasvcF/+U
         H/quroMyQicpHYeLnx1g5na9K3FojygRUMbyNHGQcIYgc8dUiecYmSe7AyYRZ2MvaYpk
         fgopSMEUF4Me49fLQoyNVl1ps4Ql0JwNEIO3OFInKW+y4S/XqOxvgef7jv2j4Ome5/yF
         ZSxDlgryZ/1J4CRia648T1vvgzRLl9AhZMg1NzvtFP7Ca5m3fGneuoht2xaKP4r4HYKZ
         XSBrqRv8a92f5ie59ZGd8obKZvKzR8vCkcm9sHzB9G7oj4b4bveBhCbnuQADDkUp+AmX
         ZQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MXKPRgQyjfEBEssBb4S8+9+QLdHW4asZtIOfI7X/G9o=;
        b=hjF/Bd9VEu18dN/B651xeTqcNQj2D/dHaREoR9sfipUw2ggRw0Oq8gMlle7X8TcPY7
         ea/Qz5FO1CUCCR0OQWzo89pI09KYCxOlhBdga9WVKTe0Y57ti/A1gsvV7TvuDzb1JCG5
         UocSQOBcT30iw9/XH9f5IN5OW/yRXobYF9Mz84De+cy4b9X16G3Tq1Blw9E/gcVCoVeA
         yAtMuRMvo4HcoF3aSAptke3kHBmduA8ZR+dF1RHBTHJ6wycrLr7fo5Vs57a9036UfXrZ
         gHskNpYuothcZwSOSNPYZm1PgCD4Lz1ca6LCqkAbLLyEVdee8pwbGi2zGZL0bjitJAjb
         KZdw==
X-Gm-Message-State: APjAAAV5rsN/U3Up/ylrCAkaIkSl8v+dyHwH6xVC/6opGyHqI1D4Ybth
        mv/4U7HiRFL8WNKWBizOkI8Qog==
X-Google-Smtp-Source: APXvYqxtQ5xhvBNlTf/I5i2m5kmfUVMJeeTpcg3PxBH6F239q4SAWYQkxIWdvMTJ35Rx0Rht6aAqRQ==
X-Received: by 2002:a2e:b8d0:: with SMTP id s16mr10492992ljp.32.1581602323947;
        Thu, 13 Feb 2020 05:58:43 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id d20sm1513385ljg.95.2020.02.13.05.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 05:58:43 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 685D3100F25; Thu, 13 Feb 2020 16:59:05 +0300 (+03)
Date:   Thu, 13 Feb 2020 16:59:05 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/25] mm: Fix documentation of FGP flags
Message-ID: <20200213135905.wvpeiw7tyma75tsq@box>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212041845.25879-6-willy@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 08:18:25PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> We never had PCG flags

We actually had :P But it's totally different story.

See git log for include/linux/page_cgroup.h.

-- 
 Kirill A. Shutemov
