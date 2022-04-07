Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1254F7D5A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 12:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244354AbiDGK7T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 06:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiDGK7S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 06:59:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228DBD0825;
        Thu,  7 Apr 2022 03:57:18 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649329036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cK/2bkoA02UyzP4mMhmuqQ/iW/61hv9fi4vsvs8ceCU=;
        b=TfW9zlJRKaDll5Jy+B33MGMmjIDAdRs0zOJo6bfLMzAlQ04oXktXoRg+amsZx1WleMd8uP
        FenTKCJ1Y39Hs9fGhZ0V+SOLXFxeUF0CLOOSXXZNUEDajKsAfWCu7WT183lMnZ/eJHh+JY
        vFa79b7fOQVCDjLAwFqj8c+GBykf+o0hBiab2B8JGEMA7lMq9OJBi4kV6mdNdcbR8lKxbg
        jTSflHsb1/Q2IA4KZLJEJ7+FM2C8m23OHXhAfSedfCGD/ElJ1WOIrDDoqE5KX+hNUjhvRz
        PCxFnIsyl00yXApO4+Nw5NXjxpuQEJIHjRxuWakNwnv/HeuCxlhCR3Z/dVuvDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649329036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cK/2bkoA02UyzP4mMhmuqQ/iW/61hv9fi4vsvs8ceCU=;
        b=h6JLYSTQ62JWr8RAJ7YLStxO5ydQ6a5Fd3Yg89BAmXhr8wypFathLq3Ks7YDGJt6nHI1ew
        26gZ4oPMOYbQ05BQ==
To:     Liao Chang <liaochang1@huawei.com>, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, liaochang1@huawei.com,
        clg@kaod.org, nitesh@redhat.com, edumazet@google.com,
        peterz@infradead.org, joshdon@google.com, masahiroy@kernel.org,
        nathan@kernel.org, akpm@linux-foundation.org, vbabka@suse.cz,
        gustavoars@kernel.org, arnd@arndb.de, chris@chrisdown.name,
        dmitry.torokhov@gmail.com, linux@rasmusvillemoes.dk,
        daniel@iogearbox.net, john.ogness@linutronix.de, will@kernel.org,
        dave@stgolabs.net, frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        heying24@huawei.com, guohanjun@huawei.com, weiyongjun1@huawei.com
Subject: Re: [RFC 0/3] softirq: Introduce softirq throttling
In-Reply-To: <20220406025241.191300-1-liaochang1@huawei.com>
References: <20220406025241.191300-1-liaochang1@huawei.com>
Date:   Thu, 07 Apr 2022 12:57:15 +0200
Message-ID: <87bkxdjh4k.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 06 2022 at 10:52, Liao Chang wrote:

Why are you sending this twice within a few hours? See
Documentation/process/

Thanks,

        tglx
