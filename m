Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7195B2A9F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 01:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiIHXyF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 19:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiIHXyE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 19:54:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240A9A6AE2;
        Thu,  8 Sep 2022 16:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kukmqgp2SSkl+E6zj8L6ZjulyQQ13O7eDJQDQHr8gkU=; b=ueaRdOsKvzyTTLGgzoO1zkNaMy
        7ms0DDQjq2u1tNvcep0fGiHxSa65Ng2/D61URjOCjkGXfewUeVeMQgZDnHeVAKrrkom34F18Pnjed
        ZDZb1fLCG+dQVRalQHIpXqf0ItC2FJ/wzmaxfYRecVt4aCigCopFfdC0k/bmqja3Tl4Jd4xSALLc+
        0Ru5tmX1/9VntHH9mGCkSFQMj791Bw1tucChceVUqmPf/sdZKSeFwTTczXLe6Mzc+WMwJn8GMexdR
        Pj6FGF0ZxLsV3znBP4CZdE1NKaJN37df0VKb1TDPPbXYqJV/V4Xvb5TDO0Xj3pSXXuGVETuK+Gbbp
        wCF/L8cg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWRLN-009zff-0Z; Thu, 08 Sep 2022 23:54:01 +0000
Date:   Thu, 8 Sep 2022 16:54:00 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Li zeming <zeming@nfschina.com>
Cc:     keescook@chromium.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc/proc_sysctl: Remove unnecessary 'NULL' values from
 Pointer
Message-ID: <YxqAmIqBugwS74bS@bombadil.infradead.org>
References: <20220905012110.2946-1-zeming@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905012110.2946-1-zeming@nfschina.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 05, 2022 at 09:21:10AM +0800, Li zeming wrote:
> Pointer variables allocate memory first, and then judge. There is no
> need to initialize the assignment.
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>

you sent the same patch before, and with a different subject...
Anyway the first one was queued up already, in the future please
use a bit better subject.

  Luis
