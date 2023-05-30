Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DBB717090
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 00:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbjE3WQz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 18:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjE3WQy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 18:16:54 -0400
X-Greylist: delayed 2647 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 30 May 2023 15:16:51 PDT
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [217.182.43.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1815B2;
        Tue, 30 May 2023 15:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=misterjones.org; s=dkim20211231; h=Content-Transfer-Encoding:Content-Type:
        Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FBurYPzx/P+7K1ew3kZobFLL4iaIkaDFy2j8U6Qpz1k=; b=PrFh6GN2xQH9skp71JIvMYYZaa
        LIncg4/qmMiMllhKjO0lm7V+jeUI82BEwQLByUUAghydE1/mNpBjPAFZxF/yFfbyTn8nsMdQeUSbR
        OEr1HsLJqZTQHAmq56LqgMRFdTxnKVGD0y76WBVYNFE4D2oZXvth2yJnWyst2zD+NHUnTgfrQ1N6U
        WaLi50qb9DwIS2HyDgVmbqvJ4obeEl5evjdhTYneYt9QNWwVwe9b+TNkygw4wGNt3zdrZSp2l7nAW
        jOl3suEKcaOT7lfI/++mLLo3alWHhHY5LB9GyOfqDPMxchXKDcGQDouye+89sfLH1hmIK1F27HgFX
        t1m/q0pA==;
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@misterjones.org>)
        id 1q46x5-001SHy-2X;
        Tue, 30 May 2023 22:32:23 +0100
MIME-Version: 1.0
Date:   Tue, 30 May 2023 22:32:22 +0100
From:   Marc Zyngier <maz@misterjones.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        dri-devel@lists.freedesktop.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        samba-technical@lists.samba.org
Subject: Re: [linux-next:master] BUILD REGRESSION
 8c33787278ca8db73ad7d23f932c8c39b9f6e543
In-Reply-To: <20230530182123.UilBt%lkp@intel.com>
References: <20230530182123.UilBt%lkp@intel.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <d65700431ed60877d3ec8e88e1211a97@misterjones.org>
X-Sender: maz@misterjones.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: lkp@intel.com, akpm@linux-foundation.org, linux-mm@kvack.org, dri-devel@lists.freedesktop.org, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-perf-users@vger.kernel.org, samba-technical@lists.samba.org
X-SA-Exim-Mail-From: maz@misterjones.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-05-30 19:21, kernel test robot wrote:
> tree/branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> master
> branch HEAD: 8c33787278ca8db73ad7d23f932c8c39b9f6e543  Add linux-next
> specific files for 20230530
> 
> Error/Warning reports:
> 
> https://lore.kernel.org/oe-kbuild-all/202305070840.X0G3ofjl-lkp@intel.com
> 
> Error/Warning: (recently discovered and may have been fixed)
> 
> include/drm/drm_print.h:456:39: error: format '%ld' expects argument
> of type 'long int', but argument 4 has type 'size_t' {aka 'unsigned
> int'} [-Werror=format=]
> 
> Unverified Error/Warning (likely false positive, please contact us if
> interested):
> 
> arch/arm64/kvm/mmu.c:147:3-9: preceding lock on line 140

This warning looks wrong. The "issue" seems that we acquire the lock
before exiting the function, but the the whole point is that the
lock is supposed to be held all along (it is dropped and then acquired
again).

I guess the coccinelle checker doesn't spot this construct?

         M.
-- 
Who you jivin' with that Cosmik Debris?
