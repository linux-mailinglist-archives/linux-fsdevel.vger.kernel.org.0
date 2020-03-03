Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9812C178372
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 20:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731051AbgCCTze (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 14:55:34 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39536 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbgCCTze (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 14:55:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so6006451wrn.6;
        Tue, 03 Mar 2020 11:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JPZHFz1S3KxGvD56s0WXcckfBOsRfQeB6jcOHU6BoPM=;
        b=iSd/Et3lfurhrFI+9rmorI2XWdbXb/DLsc1uKWmIPXhUTvRDV+UegABbLgTUBllFNJ
         gFB1Rg/nwOF/4FLWY6usDdBC6Skn/e4ZO/GnvQ6hPhzmW8wdBeKRXfxpeiIkwn5UeVS7
         /QucDaxEQKBQelwVzr9+sWZi3t94Nw4+hDXJ8FMgpjKLdqfUdA4orvRphmbIiY0UwVde
         Aq5XJDdPFGGZQPMRUX8WL/7y6x4+VEtfJnueXVQhiwhDfEw2Naps+RlIW2Ye/EPO9GbO
         eyVXHhciQZsUr2C+VP56KLnfTppv1GxxeJz65+4jf6UhE2h1FwEHHhoKfPnm6s6Ea3AY
         B/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JPZHFz1S3KxGvD56s0WXcckfBOsRfQeB6jcOHU6BoPM=;
        b=iGqGDE5FCsTc2xEJrc2eD6WVjlybaSGmL1zEl9Fh27jtFLKFCAMQ0EO91yjL3MpWsg
         Uf3HiSkIGRAhBzCPShrtJD0Oy9u0cFBTE5/I2e24VDnXyX/bwcl1hCXO0HYrU95b2Zfp
         Tb24ljnDt4mcVP56iroQT+LJSDLvApOpcva8asJkR1h26avPwdtGIc3sep9TdW9HkpsJ
         WGRSS6u6f4U1nNw3JEJVYphww1VZaGthtotOhm4vPC+755dMC2m6osY/pCclNjKp1oGZ
         jhUKIzpilDh47Np4vfK0ykcRfLmi4OujPK6iwawUvSSlhPxDCg2/OdiV/GAFExsi2YZx
         aOZw==
X-Gm-Message-State: ANhLgQ3bsFjNuJSCOPn+iOJRgn4vdrYXW8K+LQuA6FyZKgzF/BSAnA29
        kKAuNljk8ggXESupOx2myhGsp6I=
X-Google-Smtp-Source: ADFU+vtBGub5tyGbDlbtuQyF+hFSHcxHzbo7i6p7NlmkzRIpuer8ENm8MJzFJZCugYXsQoRWWMeXQQ==
X-Received: by 2002:adf:f7c4:: with SMTP id a4mr6900027wrq.91.1583265332558;
        Tue, 03 Mar 2020 11:55:32 -0800 (PST)
Received: from avx2 ([46.53.249.49])
        by smtp.gmail.com with ESMTPSA id a9sm218928wmm.15.2020.03.03.11.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 11:55:31 -0800 (PST)
Date:   Tue, 3 Mar 2020 22:55:29 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] proc: Use ppos instead of m->version
Message-ID: <20200303195529.GA17768@avx2>
References: <20200229165910.24605-1-willy@infradead.org>
 <20200229165910.24605-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200229165910.24605-4-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 29, 2020 at 08:59:08AM -0800, Matthew Wilcox wrote:
> -static void *m_next(struct seq_file *m, void *v, loff_t *pos)
> +static void *m_next(struct seq_file *m, void *v, loff_t *ppos)

This looks like hungarian notation.
