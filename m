Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9FC26C9E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 21:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgIPTfx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 15:35:53 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:40420 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbgIPTfE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 15:35:04 -0400
Received: by mail-lj1-f176.google.com with SMTP id s205so6933792lja.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2020 12:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LHmPIWNds/3Kw39caSIIHtjGVfbumgcK7+Q1wR+rbCI=;
        b=kjU9HEJhgrn83ma+ridlhRkHHFv3HiVLuTdw2jBcr5JEpEq9UUk7sWT5uvWlWR6uHx
         UiiaHHoNzbfk2bLChE2hb309zBV9tgBPEc7wR1VCXxOKwWCywtBHxWzTo4N1Xv+CfGS8
         b7nY3DWOpSUFauPsWr/Fx7muQpkA8zV6HaslQ3FrPwgpG4oAld16iMqeDtAXocbMiJVl
         mADEeEqJzYUjOWnfH8Cukt8tJ+CtQbRKjLYkT7mGLYHpARAIi0tTISLXMfS1rTvjT6QJ
         NqEOnjmbHbME9HSf4hNs59w2LbdRzdQSWUcfHYXCVHqyF60+IAhQPSq8dud1/U8ZLCJx
         wa6Q==
X-Gm-Message-State: AOAM530CB571B1XtJVwTezQQAV9dzF1Uz9TAH65UndRCb5X4F7UgevQT
        FG36lUb7OfXvxhiLKVg9AG8=
X-Google-Smtp-Source: ABdhPJzOyfty7EP2QBlXB3Ti6H87rhhbXt7p3HsNlnPPtGBl3SHPM8I6y3zJgHUXIC2Quyx/n5FU3g==
X-Received: by 2002:a2e:8257:: with SMTP id j23mr8965852ljh.49.1600284902202;
        Wed, 16 Sep 2020 12:35:02 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id i11sm4777086lfe.242.2020.09.16.12.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 12:35:01 -0700 (PDT)
Date:   Wed, 16 Sep 2020 21:35:00 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] fs: Remove duplicated flag O_NDELAY occurring twice
 in VALID_OPEN_FLAGS
Message-ID: <20200916193500.GA25498@rocinante>
References: <20200906223949.62771-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200906223949.62771-1-kw@linux.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[+CC Andrew]

Hello,

Thank you Matthew and Jens for review!

Andrew, do you think this trivial patch is something that could be
included?

I run Coccinelle on a regular basis as part of my build and test process
when working and this warning shows up there all the time.  I thought,
it would be nice to put it to rest.

Thank you in advance!

Krzysztof
