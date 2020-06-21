Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852D5202DB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 01:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgFUXiO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Jun 2020 19:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgFUXiO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Jun 2020 19:38:14 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9E7C061794
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jun 2020 16:38:14 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 9so17219086ljv.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jun 2020 16:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5p+NU18lU91xQBZ5zztQJpz+xQ+8jgFHRpUqzbl4PWM=;
        b=A2IZIyQO5nbeJOQNuBIVPjMJ/AzeeqlMM+VTn0j8H9xBbN6nfQvRTaCVgpR3FP/9zB
         5UPhDxMSWOlQiL/RgWuj0AAvuxWUm+s4bCrE3uZzyV54zqRwG4hiPoYIo055K1LcpVJ3
         U4sQJZuldIFaOPnsibCHaapPf3BIi/b91RW3rNza4rEArdJLCMFY8sCZ/49pRAxmZY7p
         KWXZu/g3KW+xfguINGJtVvRUu1DwxVyqPOQzNUHp2apG/rFjhCaVqi3Z/Tfx9wVcXXMk
         HYAfCPqNggYoLditjxw1E3sgMNorSbsOk5M3tZUSSCNbBEFgFIlwpST537dumTLCzool
         rWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5p+NU18lU91xQBZ5zztQJpz+xQ+8jgFHRpUqzbl4PWM=;
        b=OFLHaNM3dFewBo6VRyk+vYWyHUgJgniRX0k8Cg0xPhS+wN31trbaeTj8oaiKPlH8xG
         zqdcoQdnwekvJekemnjp4M3eUfP2+unUuv9RxMsGifRMYxBCLi5Pdrd9WK40cbkw4jud
         /e3rD8DvIkE0L13Yl1UF3u1m0jYFXgNC8MWTTmYZf0EdCwUZRcbqAPK9GUPrt3qZyH2o
         d6e7V1jU7Npd/iwTdMDxwgfN9/axLmOAmd1AtJU6mJ9n1Vfu3MdgWCTzPNnqSuWDS4+P
         uptT+pUrMePPo4dNG0dI8nAmy0DSinWK9lRWLPfuIco4sfWEYnr1nBoMJRGXEPmE7/3c
         06yw==
X-Gm-Message-State: AOAM530/Yn6xXhYuKosoTUqEeVK45usIJ+BtIAIY7Vd6WnqkiHZV6UEm
        OJLOwn7/31ebZ7SC4lk1ftn2PoSEr3h6lMpjNTXcxoTa
X-Google-Smtp-Source: ABdhPJya5nDEd7tjLEcrlkE/krYdUCNnW70cZy3ZsGBRur+YV8sPvzBwK7m9jkVdn96ieVl2wBhoau4nCBEGeCR+jBk=
X-Received: by 2002:a2e:b0ce:: with SMTP id g14mr6835332ljl.49.1592782692514;
 Sun, 21 Jun 2020 16:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200620021611.GD8681@bombadil.infradead.org> <CAK8P3a1UOJa5499mZErTH6vHgLLJzr+R0EYbcbheSbjw0VqsHQ@mail.gmail.com>
 <20200620161531.GE8681@bombadil.infradead.org>
In-Reply-To: <20200620161531.GE8681@bombadil.infradead.org>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sun, 21 Jun 2020 16:38:00 -0700
Message-ID: <CABeXuvqFMnUDFZeU9Ki=5-6kCWQ9hutnO4JQ-5-3zBQmK8aTfA@mail.gmail.com>
Subject: Re: Files dated before 1970
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I included a table of the time ranges supported as part of another
series: https://lkml.org/lkml/2019/8/18/169.
There had been some discussions with individual file system
maintainers about what was the file system's intended range of
supported timestamps.
Eg: https://patchwork.kernel.org/patch/8308691/.

I also added an xfs
test(https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/tests/generic/402)
to test the ranges supported. But, since there was no way to query the
kernel for ranges at that time, the ranges have to be plugged into
xfstests for this to work on all filesystems. This does check for
dates before 1970 if the range allows it.

-Deepa
