Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226F66237E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Nov 2022 01:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiKJACs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 19:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiKJACq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 19:02:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F6E13DD3;
        Wed,  9 Nov 2022 16:02:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3906A615C2;
        Thu, 10 Nov 2022 00:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5787DC433C1;
        Thu, 10 Nov 2022 00:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1668038564;
        bh=j6yzhjIpuLv6wJ1F0UxC3RkmUzTVXtd2eF1BGHk+O4I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FevZdUzAnJclXU3QM9xe4Z0BbQjPNVtXEYhT0nrS10QTM/MvRYRsF8MY25aI0eLaW
         40oZEov2E4ZMgptIRoZFDD4mfgcWueUGouC3h4KmBm6BcfCQRGdsKtqyncxXlZejoY
         BNTxhHvlV4iTi741iWh/VrjRxJQVhtE+4NfYDpdI=
Date:   Wed, 9 Nov 2022 16:02:43 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Punit Agrawal <punit.agrawal@bytedance.com>
Cc:     shuah@kernel.org, adobriyan@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/2] selftests: proc: Fix proc-empty-vm build error
 on non x86_64
Message-Id: <20221109160243.0db030ca1cbae5f180af3855@linux-foundation.org>
In-Reply-To: <20221109221104.1797802-1-punit.agrawal@bytedance.com>
References: <20221109221104.1797802-1-punit.agrawal@bytedance.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed,  9 Nov 2022 22:11:03 +0000 Punit Agrawal <punit.agrawal@bytedance.com> wrote:

> The proc-empty-vm test is implemented for x86_64 and fails to build
> for other architectures. Rather then emitting a compiler error it
> would be preferable to only build the test on supported architectures.

Why does it fail?  What would be involved in making it available
on other architectures?
