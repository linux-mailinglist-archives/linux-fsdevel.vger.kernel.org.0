Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F71647E78A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 19:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238951AbhLWSPO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 13:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbhLWSPN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 13:15:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C61C061401;
        Thu, 23 Dec 2021 10:15:13 -0800 (PST)
Date:   Thu, 23 Dec 2021 19:15:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640283311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u15BsHMoBrJUtjooOKbGSgdqSc8SME1p0Eqjd+SbLoM=;
        b=2rpJr5ksubIlyfDZiXFeBLM3GYv/DVi+GFqjA4b8g2Y0TvbKZOCLJKhlzoIo8NiVL4X7tu
        5x+x+zLgABCqLc7JBCq8FijX0ohGoilRvjcFRy1DywA0wHeojPsIn2GRZ7xPIY6CMMrTni
        6vmkLrvdHs1Ch96ecconCdfYDkll/YRVQvLr/YHRvJGWxatU6zISKa+05dZEPVFuv+ANZw
        IM2+dnFz/J+wG1pPV/s8Zymt9H/uqqBCRjDVUqRPFO/xuzVaZQRtULO9telJlJayLCLeDh
        LX+rcQqodZf0R14CL54rtrTA5ir8baWfKQUrbwviOt+dmgatM9ZjS9ZvKdPwVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640283311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u15BsHMoBrJUtjooOKbGSgdqSc8SME1p0Eqjd+SbLoM=;
        b=ISorxxz9/iFv/aR0ca1jscZRBnoZW5a9JvZrttzSnH9FFpjsagzvLjllric3ygUSpR045p
        pu79+10RLbCuNEBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Gregor Beck <gregor.beck@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH REPOST REPOST v2] fscache: Use only one
 fscache_object_cong_wait.
Message-ID: <YcS8rc64cVIckeW0@linutronix.de>
References: <20211223163500.2625491-1-bigeasy@linutronix.de>
 <901885.1640279829@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <901885.1640279829@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-12-23 17:17:09 [+0000], David Howells wrote:
> Thanks, but this is gone in the upcoming fscache rewrite.  I'm hoping that
> will get in the next merge window.

Yes, I noticed that. What about current tree, v5.16-rc6 and less?
Shouldn't this be addressed?

> David

Sebastian
