Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529CE38E079
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 May 2021 06:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhEXEuZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 May 2021 00:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhEXEuY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 May 2021 00:50:24 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1C8C061574;
        Sun, 23 May 2021 21:48:55 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id q6so13597536qvb.2;
        Sun, 23 May 2021 21:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nwnxFWfaR3PSysocZZLALDptS/nHIUftVJcuf7DMZxk=;
        b=hslOdvLyAchoNjqr+Ir2Z9jn9eijDSPKCzMR5IVuerWKlnjcvElToxCxD2euCTuQ0A
         FIMxnvfJkJQ+3S/afJ8Dh9rPaNoXVVEt11Mgr2CYT451/BbGVevtWxtQMWCnDBOOh7tK
         3FaMRolmhphrCKZxaBkKrzsAvzUxlHtKkfE38vLrnCXQnWTO0KS/1PgPTM/sTqF03fFD
         GfW8MPcZDQYFwzXupzzN1ThEX+9KOfubQ/Owb37aesf+MUAvmXIOODn/qiuaddJaLbeW
         q0dkgnuv4e1Ep3HLZWCzmqidWtzXXpKUQGFVGHm9f8SW2jlZ1gCfPTlt45UANdbWJ7Zx
         VBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nwnxFWfaR3PSysocZZLALDptS/nHIUftVJcuf7DMZxk=;
        b=QJfmu+O9hXo1bibAK52g176qmwzKpznB+VRHIgWglI79Qi5VrEGdtuQf899LQuJv87
         cIEg9YgLNCzBuAkHJJSX/6hknLgj67s6dUw5PKPVtIn5t8STqrHqkByoZW8cREgXPdsT
         g1UxLJLmwIt62Zgn3kQcyjOmLhLDTNJMM2QGLB9QgKQftfljioQOhRRY/JTub2JBYOz0
         Ubz2+krK95pYOPXm7CncyUkMTnz/8qamloSFSOeJw+dczca/BNcJNC9LwRBhjdBbOVrx
         jXQ/zW/jk9Mm++fuETLlYpgV7JheWZ1J+gJxx9FOIDEnnJ1eNSNrUUoX3gTSsU8LqVxy
         CJnQ==
X-Gm-Message-State: AOAM530K2tFqASp6xEEvYvuoJlq5GoZvDzlhLVKbfGGvgfy5j0K/m186
        iHJa/+cEB/C0BY5jW/+k2I5bMD8U73mo
X-Google-Smtp-Source: ABdhPJwvVTRS+l8JUQar0MuyDHmsxf7bkIqZRl0FvhT7nikJc7elwnZtVnK8RDJvtumkr2Bx+cFnag==
X-Received: by 2002:a0c:e1cb:: with SMTP id v11mr28443725qvl.52.1621831735040;
        Sun, 23 May 2021 21:48:55 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id 127sm9411814qkl.116.2021.05.23.21.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 21:48:54 -0700 (PDT)
Date:   Mon, 24 May 2021 00:48:53 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Eryu Guan <eguan@linux.alibaba.com>
Cc:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kmo@daterainc.com>
Subject: Re: [PATCH 1/3] Initial bcachefs support
Message-ID: <YKswNcbS2DhaeEOS@moria.home.lan>
References: <20210427164419.3729180-1-kent.overstreet@gmail.com>
 <20210427164419.3729180-2-kent.overstreet@gmail.com>
 <YJfzVSGu2BbE4oMY@desktop>
 <YKrchSzj8Zo4CnDs@moria.home.lan>
 <20210524035604.GD60846@e18g06458.et15sqa>
 <YKsl0ORHo/mhuUBx@moria.home.lan>
 <20210524042253.GE60846@e18g06458.et15sqa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524042253.GE60846@e18g06458.et15sqa>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 24, 2021 at 12:22:53PM +0800, Eryu Guan wrote:
> Oh, I noticed that "with bcachefs fsck finding errors _always_ indicates
> a bug" now.. Then I think using fsck -n is fine here, but better with
> comments to describe why this is ok for bcachefs.
> 
> Also, we could just use _check_scratch_fs here instead of the open-coded
> fsck command. As _check_scratch_fs calls _check_generic_filesystem()
> which calls fsck -n internally, and handles mount/umount device
> correctly and prints pretty log if there's any errors.

That should work.
