Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12AA620B138
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 14:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgFZMRF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 08:17:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46007 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbgFZMRE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 08:17:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id a127so4555835pfa.12;
        Fri, 26 Jun 2020 05:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DsE2wAMRmQbvTNE8N6VxmuoaI9A47onJe1cGAUDjN50=;
        b=HhhowDwsKIIIB4cM298MMBZ03ELMfv5rYV6GfanmTor+HVEuB3ikE605OF39RUQacL
         4hyBcC6UF3rPZHQBzzLkOOwKoGCGhwFsyEU0fme476xqWF7kUogPCt/7yotHfkslHyIu
         ySOkkstmJnM06zzfcav0k1gMX/7LqanBB+ft6gRB1i8bb6/mju8qb/rXK24OJZ9l+YBf
         qC47iIy42IZbp3O7cgCknAW3VqYlA+WI86O37+9m+WslI8lphryG3OWjqKD/34nImx/B
         2nNJlE6xC3D5TpmNmj9GVFqrJYBkegHv4y/HEACJ99DyVRxP67bcnk8ZG9+680N83Mng
         s1fA==
X-Gm-Message-State: AOAM530aVTluKHeYcRVHS32nvt+U9VblsnIS4V4mniO53M5XtTJPLk2q
        gyy2ndYH3DzjDcqYqPhAsKo=
X-Google-Smtp-Source: ABdhPJwKPCfOPErb9QfKR/PTVjk9VWTUGqdxZW5FaJYMAQDflzqzSbvwxBnY0csptyJYBMj1ntPOtg==
X-Received: by 2002:a63:7313:: with SMTP id o19mr2540204pgc.307.1593173824266;
        Fri, 26 Jun 2020 05:17:04 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 204sm1332367pfc.18.2020.06.26.05.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 05:17:02 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 0897040B24; Fri, 26 Jun 2020 12:17:02 +0000 (UTC)
Date:   Fri, 26 Jun 2020 12:17:01 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 6/9] sysctl: Call sysctl_head_finish on error
Message-ID: <20200626121701.GM4332@42.do-not-panic.com>
References: <20200626075836.1998185-1-hch@lst.de>
 <20200626075836.1998185-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626075836.1998185-7-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 26, 2020 at 09:58:33AM +0200, Christoph Hellwig wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This error path returned directly instead of calling sysctl_head_finish().

And if the commit log can say why this was bad. Found through code
inspection from what I recall right?

  Luis
