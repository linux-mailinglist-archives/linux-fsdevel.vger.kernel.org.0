Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013F54ACBEC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 23:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238051AbiBGWRN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 17:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiBGWRM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 17:17:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B194C061355;
        Mon,  7 Feb 2022 14:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X1ShOwEYAB5oYTeuRBJN6WR9bsYvhghEdGxqRNvPJ1c=; b=mE2GmJHd79ApPhR7LodrzM8AsB
        +LfghcvwDiaSH1HcHBULa0x6lrmNQY28IT++USz+A46FkMQ3FJ94Dw8tVkFhpwnVHZga3tDp03j0i
        IeCLEzISHe2Ugw8PBi+6tdvG09ztInGaFNYFfHiwMHfVbGL5bcNBenOVFJ+Jo/UQtUhAnGUXdMCXI
        mcjzmeUjJSAagwuppAbyNsL6lqRKJJC8iK7GR8SqpvpNazS9qd+X7sOuyRklqiVph7jCAKgmHSxTb
        n6KZIAzb7tfmFIrH6MYwzVUpStoNeuaUpHricMqELbwCLjmKqYvGs8kGKL0wadzDM+Pdf4+tqw8FI
        XDikwaew==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHCJk-00Bqw8-OR; Mon, 07 Feb 2022 22:17:04 +0000
Date:   Mon, 7 Feb 2022 14:17:04 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Chen, Rong A" <rong.a.chen@intel.com>,
        tangmeng <tangmeng@uniontech.com>
Cc:     kernel test robot <lkp@intel.com>,
        tangmeng <tangmeng@uniontech.com>, tglx@linutronix.de,
        keescook@chromium.org, yzaikin@google.com, john.stultz@linaro.org,
        sboyd@kernel.org, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [kbuild-all] Re: [PATCH v2] kernel/time: move timer sysctls to
 its own file
Message-ID: <YgGaYIuVaM4URxKH@bombadil.infradead.org>
References: <20220128085106.27031-1-tangmeng@uniontech.com>
 <202201290325.Jyor2i8O-lkp@intel.com>
 <YfnvE9rPffDb4JHy@bombadil.infradead.org>
 <fc36323c-dfd9-b98f-4147-5e5b9ecd1177@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc36323c-dfd9-b98f-4147-5e5b9ecd1177@intel.com>
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

On Mon, Feb 07, 2022 at 02:41:08PM +0800, Chen, Rong A wrote:
> Hi Luis,
> 
> Thanks for the feedback, we'll take a look.

Sorry for the noise but it could also have been an ifdef is needed when
proc sysctl is disabled. In either case tangmeng said he'd look into it.

 Luis
