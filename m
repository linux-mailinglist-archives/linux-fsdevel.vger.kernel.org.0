Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA14357569
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 22:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349033AbhDGUGs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 16:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348993AbhDGUGs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:06:48 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E267BC06175F;
        Wed,  7 Apr 2021 13:06:37 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a25so6679766ejk.0;
        Wed, 07 Apr 2021 13:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aI6cOghiWYjCiHchhUfiqlnmiN5p4vpRRk7oBn0oTfc=;
        b=pTRv6KdXntHuZQbgOqen/DUsVLkp5O76CbG+CFvIi1N/0cRhoV3XTLnxuxlmtxWP3Y
         5Dj7myJ2kYsD75gvIxq6WKhbLeg4QqtJp26lKQsVPUCOxpZ0ZlUZy32zJKfr5Zws5LrO
         Sye8kjaojoYZUunptpvQeheovFfIFgyLWxa84GJvcrtprh3EblbSC4TXhCuLG4U7Hk/t
         0Cf0+f9dAPWiDjkQy5Lyb6tITCHxGCGrDtA3XN2cInurfEfT2Hek7nKNBNOVXeeZ04Jv
         X2tvEXkAw6agFpDMzISd4QsRh+kV61TEDy9+Be2QpklepEwjwGSIVWXWDDLuik9lLP17
         XlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aI6cOghiWYjCiHchhUfiqlnmiN5p4vpRRk7oBn0oTfc=;
        b=c+R3xqnGd1CcV5T77gWDyA/G0qeVnH2FyJyXKgIxQ1VGQILQhtpRpwBtf1n5wj5bq0
         Vgs4iS6odrYXDPZs4MXQAOUf810lBXxBnW5cG8oUxPDD2Xph4JFlsTipRkUfjJYSnXO8
         IK9e/OG62CSNnBOgLnwoNVMws8wfruDtXI6SJuG3Q59jOXj3ANPvi06Wc2sIjgI1Cxo2
         1Xay2/dgwRSbbwiX+WAUrA9bArsugEsjGUJWpJkaZF0RKXx7KqlUlwdqztmyA5ncOSKJ
         ZQ8fQwpIjlSaMEoOchCRosdcRbRbbSpWK02XV6Ml9fyb130GjlJDmZV6xPtcfrxkuEXI
         dfZg==
X-Gm-Message-State: AOAM533wGeSHWd6L1ThXA7f6lN9UQBE0GDwMLjrXxLjyugtFihYbD15m
        IEjE+RJp0FT/Y3AyikNsSC36YI2/EA==
X-Google-Smtp-Source: ABdhPJy2EsZT9JRFlsWFJzIJKhXXNJihCCrih/+ZUzzmfUUT4DhP2RhPo/S3+e4u9l9ARN60H9XLfg==
X-Received: by 2002:a17:906:2704:: with SMTP id z4mr5691197ejc.137.1617825996663;
        Wed, 07 Apr 2021 13:06:36 -0700 (PDT)
Received: from localhost.localdomain ([46.53.252.73])
        by smtp.gmail.com with ESMTPSA id gn19sm12802439ejc.4.2021.04.07.13.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 13:06:36 -0700 (PDT)
Date:   Wed, 7 Apr 2021 23:06:34 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: smoke test lseek()
Message-ID: <YG4QymNCjgGR/cPk@localhost.localdomain>
References: <20210328221524.ukfuztGsl%akpm@linux-foundation.org>
 <YG4OIhChOrVTPgdN@localhost.localdomain>
 <20210407195809.GG2531743@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210407195809.GG2531743@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 07, 2021 at 08:58:09PM +0100, Matthew Wilcox wrote:
> On Wed, Apr 07, 2021 at 10:55:14PM +0300, Alexey Dobriyan wrote:
> > Now that ->proc_lseek has been made mandatory it would be nice to test
> > that nothing has been forgotten.
> 
> > @@ -45,6 +45,8 @@ static void f_reg(DIR *d, const char *filename)
> >  	fd = openat(dirfd(d), filename, O_RDONLY|O_NONBLOCK);
> >  	if (fd == -1)
> >  		return;
> > +	/* struct proc_ops::proc_lseek is mandatory if file is seekable. */
> > +	(void)lseek(fd, 0, SEEK_SET);
> >  	rv = read(fd, buf, sizeof(buf));
> >  	assert((0 <= rv && rv <= sizeof(buf)) || rv == -1);
> >  	close(fd);
> 
> why throw away the return value?  if it returns an error seeking to
> offset 0, something is terribly wrong.

Some files may use nonseekable_open().
This smoke test doesn't verify that seeking is done correctly anyway.
