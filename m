Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DD21ACE8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 19:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgDPRWC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 13:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728101AbgDPRWA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 13:22:00 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BA8C061A0C;
        Thu, 16 Apr 2020 10:21:59 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t14so5740735wrw.12;
        Thu, 16 Apr 2020 10:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6uF4y26rP9r8HAlp2szHdM9nzyjy6h8lehRa7ZcQjQo=;
        b=rvoatJrJ7cVxIifL+iba64dkSdEHsH4D/LOIdjeOdY5bZVbkBklcxyfjsmFILpvQU/
         RU4LgeSEmep+bMDElq3h8kLhrSmonGDkzj3RvudxVrCXoNFu+Lp9nAXUc/3hrEmh42w9
         3L11cxWPRtvqPCYWbsNgg46edKR+dGDmOc2zQ3CTahPgWLjnawpZHYPEWPP7Isut89gY
         n9huxIOVXIpRJ5YaxvjsR5NIc+wxhWjSPgs4ndB5PjgPfqjIjODqij0gRLZdyYSsUuTZ
         d/Jd0+CfKxOitlN6TJorLDgsZHJQCHlH92qRKrDeLYZi9SiQg5QzCubY1uXy0IBzPAT5
         UGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6uF4y26rP9r8HAlp2szHdM9nzyjy6h8lehRa7ZcQjQo=;
        b=iL2H+66of3dHUnN/zTtfd6RL4UDq2mR6dtLgZOFABR6PgLgi0YsHr7xwzKy8O33F7O
         gpJQIMzzwtKxDxWVQVAR974H4FYzhotlkKBt8j2zyH20GYqHDsLp8ZcxAzzUtT5o1XU1
         62nX26IYHjTa4isZUyj9MnP2nPFZK/LbMbeyw+bNtSF72Pnd75h55RQKTS8LxiXW4Sw7
         IlTC2/VBbZncIdZexhixGSNMOHSpR5Tp5msXliV6rwGmJ1Nfg7u7jyJR4h4ESR9H4wZd
         Fjefjdpd+FV2hBEYEM20MBijxGr1uH7HRo4+SAaYk0hgqlmHkgQHYxZrzZE7hzWw6sxY
         h51Q==
X-Gm-Message-State: AGi0PuZA8pBkbKAz23DeOqw8reXkj9vTGvR3XlVSyQkTCSe5cnajfMQE
        pqLGjjpbi+wcKE0OG5izcAVEQc8=
X-Google-Smtp-Source: APiQypJyaRjovGrgKBAedP0lHhuI2POEmDpa7WbfJQ+dSD087QtNDhdPvycgZDdOys8hYg+ObhvMuQ==
X-Received: by 2002:adf:f2c5:: with SMTP id d5mr36395970wrp.409.1587057717698;
        Thu, 16 Apr 2020 10:21:57 -0700 (PDT)
Received: from avx2 ([46.53.249.183])
        by smtp.gmail.com with ESMTPSA id b191sm4447928wmd.39.2020.04.16.10.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 10:21:57 -0700 (PDT)
Date:   Thu, 16 Apr 2020 20:21:55 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: rename "catch" function argument
Message-ID: <20200416172155.GA2280@avx2>
References: <20200331210905.GA31680@avx2>
 <20200415210727.c0cf80b5a981292bb15d9858@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200415210727.c0cf80b5a981292bb15d9858@linux-foundation.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 09:07:27PM -0700, Andrew Morton wrote:
> On Wed, 1 Apr 2020 00:09:05 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > "catch" is reserved keyword in C++, rename it to something
> > both gcc and g++ accept.
> 
> Why? Is someone compiling the kernel with g++?

I do!
https://marc.info/?l=linux-acpi&m=158343373912366&w=4

> > Rename "ign" for symmetry.
> > 
> > Signed-off-by: _Z6Alexeyv <adobriyan@gmail.com>
> 
> Was this intentional?

In Russia, C++ mangles you! :^)
