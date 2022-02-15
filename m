Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0198C4B64CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 08:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbiBOHxu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 02:53:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiBOHxt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:53:49 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E828BBE2E;
        Mon, 14 Feb 2022 23:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hnw9xkRuc4ues9CW3Dh+UCeHDGbgQJSKcCkZxiQo0C4=; b=3lKoiv+COq4nMv9ufcWmv8048W
        YKapperCP77bT2JhDfHmAj0QsqGaZKh9zJEU6N6qn9Emr3z0v7x/mmQhwpyP2rr5+D1DoaJW2YG4D
        edY7VpOM5ztG6ZEnvw0SDd7ytPED+nK3awt1vBm7ZCg9PUvwYpU1Ovd+boxmFYO4gy3jWzgHALQ3M
        AXT1vUkrsFNBWSUMoQgyg6iGI6UAwc9mD9POypKNbkkecb6Mm3tlZVm+43MxSaZF3sU2ycc89Mn22
        Qro7mGq51NYXiGFKkMtlezPEoKow49BlFpE4/xvsxv17riCUTsZmqKXjXUsbLN6GiAdH/FGHLIMgA
        FjuxDP1g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJseT-001NvL-2h; Tue, 15 Feb 2022 07:53:33 +0000
Date:   Mon, 14 Feb 2022 23:53:33 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Zhen Ni <nizhen@uniontech.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, keescook@chromium.org,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/8] sched: Move rt_period/runtime sysctls to rt.c
Message-ID: <Ygtb/SuK0qQeBFbh@bombadil.infradead.org>
References: <20220215052214.5286-4-nizhen@uniontech.com>
 <202202151509.TszSxsaB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202202151509.TszSxsaB-lkp@intel.com>
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

Zhen,

please get lkp to add your git tree to test it before you submit
patches. The FAQ for Intel lkp describes what to do.

 Luis
