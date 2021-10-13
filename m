Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F4442C942
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 21:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239085AbhJMTCz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 15:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238997AbhJMTCx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 15:02:53 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1C8C061764;
        Wed, 13 Oct 2021 12:00:48 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r18so11638810wrg.6;
        Wed, 13 Oct 2021 12:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tZ0DTHwbOklA/q8ADpPUERCncvmwsxaymoMbHXl9IcQ=;
        b=lN+J43KGo0zUaPFO850xZAG/ULwXxvlMdNWRUPoKoxTcZPFTw2hGwNraEYLIfBpwIy
         34t+n19+zMswNCDzVn+UrICgn+NwFsebdGUqYoL6fAFJDaMZ19TQVy35WMi0exwkRsSi
         XXDx7bc9W9I8WFALhD0SfmuWWLF9ETuyyXgZY+SO1bkCdviV/cIddJGur0obC5f9Nnue
         rdgO84+KgmEGQKcbxStnvFa0YuQ7wvtqJpJ7/gc6Ajcx4MWVJ2XmCLzuKb5AQ7ZcHj+6
         PnbavqqyYXvwB6NZwqcK7WBL1PngTsYFMRS/wCbnKDHBcnkZrR4aL/2Qz6DIjrUXaRoZ
         1Iag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=tZ0DTHwbOklA/q8ADpPUERCncvmwsxaymoMbHXl9IcQ=;
        b=0JFfEiW+nnCjXjfq2ws8xmyuUbsBn7CHAD+beEh4ZSgkfK3YWQ63G/NUwTv/ytiFMs
         TFnOUe9a0EyOjr0vcAckD3bP9btxHwRMp3M3DkTwjxqZoet+D9mMC+NQJS7Q4Doqo3JN
         h81/9WG4TCd9BQz5DwTWO3AgJYupwTHkz5/CeR1j/0hKNfdImrDzcaDn7GyVIBVo9rDx
         664fjRGEmfEw24CmQSeA8Cm4XtKcjvdrvE20tS8csB8TONsYCLcjoXLLHSDwRDxqUEkj
         vBRu7Xw07iFbLYJE0aPMw9aKZHRlH0BHDCoetVEEPInLZDUlDH4EUOOHbgYhsfhzgWie
         d4rg==
X-Gm-Message-State: AOAM533rODAdhilVWoQDdxZqQJ5Qxrk2ka9vXMzU4IixZ1TkRbUPxfEi
        jdJXKc/oUigKos6pxfIwoN0=
X-Google-Smtp-Source: ABdhPJygIHrAS8lyrk9ykp9uvwEXxHci5Csm+H/Cluuc0t6nT+hNvSeCQjNVUcjNoQPOPxnn/yCKmA==
X-Received: by 2002:a5d:4344:: with SMTP id u4mr1123536wrr.106.1634151647044;
        Wed, 13 Oct 2021 12:00:47 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id n17sm374014wrq.11.2021.10.13.12.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 12:00:46 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Wed, 13 Oct 2021 21:00:45 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Stephen <stephenackerman16@gmail.com>
Cc:     djwong@kernel.org, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, seanjc@google.com, rppt@kernel.org,
        James.Bottomley@hansenpartnership.com, akpm@linux-foundation.org,
        david@redhat.com, hagen@jauu.net, pbonzini@redhat.com
Subject: Re: kvm crash in 5.14.1?
Message-ID: <YWcs3XRLdrvyRz31@eldamar.lan>
References: <85e40141-3c17-1dff-1ed0-b016c5d778b6@gmail.com>
 <2cd8af17-8631-44b5-8580-371527beeb38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd8af17-8631-44b5-8580-371527beeb38@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Sat, Oct 09, 2021 at 12:00:39PM -0700, Stephen wrote:
> > I'll try to report back if I see a crash; or in roughly a week if the
> system seems to have stabilized.
> 
> Just wanted to provide a follow-up here and say that I've run on both
> v5.14.8 and v5.14.9 with this patch and everything seems to be good; no
> further crashes or problems.

In Debian we got a report as well related to this issue (cf.
https://bugs.debian.org/996175). Do you know did the patch felt
through the cracks?

Regards,
Salvatore
