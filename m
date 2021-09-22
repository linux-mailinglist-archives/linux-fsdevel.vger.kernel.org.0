Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C17414BF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 16:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbhIVOc3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 10:32:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32196 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232401AbhIVOc2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 10:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632321058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H9MFwjIYK3NzURsIL5ZeXXjauXt11emCz529o4qozFY=;
        b=RDXhkccJok5H6fMPJGPvKH+D6VD23YKtFt/ITvNl23chYDBPmro6xOAki/ASCUvIiJpedt
        p4sYdNyUVSCZtoVc6qc5Qtx9BYL26hjJiVPyIzxeF581VD0HbTZcYXqM7mYPoXSAvUNoZV
        6+TE/dPBTNIl92KYWgr9eh+ZDHsAOzc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-KnOO83a4OgWab3KjQLmzFw-1; Wed, 22 Sep 2021 10:30:56 -0400
X-MC-Unique: KnOO83a4OgWab3KjQLmzFw-1
Received: by mail-qv1-f69.google.com with SMTP id ci14-20020a056214054e00b0037a75ff56f9so11439601qvb.23
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Sep 2021 07:30:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H9MFwjIYK3NzURsIL5ZeXXjauXt11emCz529o4qozFY=;
        b=rBUGfZtc1whzMS67huVuH2U3q6LLhbu0FEZAwiWVLqO4MFeEEIRZkPusjonBIw9eWj
         I6LAMSRH9KBGa6mT4urLpXUSDfz+9VNS/lNZPLV8FmlBmtWKb/OgsaBKKvrZkZQqcS2A
         OvzX976p2i+ZhXBM+y4eoQxKfYZzBtWfoSPDDtnezC5+E8z5BUZfSBc46yBx0xlwgNPK
         gqLM4bHwUMJCu6gA+btZmTtRBOarS9Dtv5gBjlFtiQY94zdweMKaEsV0uHvwLg5uknEa
         jMWVjbDOurZMovRQRBWcNtTrrRBItqUdHZk3v+r8SgpbNubAE+AnmI2QiUrVFlSHaV/e
         zcCg==
X-Gm-Message-State: AOAM530Sxqv8d0OD0pEBf5blJ4q94XO7gwXyedfzgpMXpSdOxoGNix/+
        CKoEWm51m4kcmJMOXavUFUgFLFL8DiJgCxqKmnIPTpyFPejUeP1dFJZRJqIwI+jpX/6CtgXNRqj
        bIcqjOYQAS9s3kyPcI15bQh3jPw==
X-Received: by 2002:ac8:1c6:: with SMTP id b6mr32958211qtg.221.1632321056090;
        Wed, 22 Sep 2021 07:30:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQAVBr6hBwwFSYKO7U1/khHUr5y9tSTMCIoPdoZ894eUZ+OrVYZ3xfOPFjOhJbFSSfttPIFg==
X-Received: by 2002:ac8:1c6:: with SMTP id b6mr32958174qtg.221.1632321055765;
        Wed, 22 Sep 2021 07:30:55 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d3ec])
        by smtp.gmail.com with ESMTPSA id f83sm1917615qke.79.2021.09.22.07.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 07:30:55 -0700 (PDT)
Date:   Wed, 22 Sep 2021 10:30:53 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH] userfaultfd: fix a race between writeprotect and
 exit_mmap()
Message-ID: <YUs+HZOf6mnI6mm2@t490s>
References: <20210921200247.25749-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210921200247.25749-1-namit@vmware.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 21, 2021 at 01:02:47PM -0700, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> A race is possible when a process exits, its VMAs are removed
> by exit_mmap() and at the same time userfaultfd_writeprotect() is
> called.
> 
> The race was detected by KASAN on a development kernel, but it appears
> to be possible on vanilla kernels as well.
> 
> Use mmget_not_zero() to prevent the race as done in other userfaultfd
> operations.
> 
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: 63b2d4174c4ad ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
> Signed-off-by: Nadav Amit <namit@vmware.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks!

-- 
Peter Xu

