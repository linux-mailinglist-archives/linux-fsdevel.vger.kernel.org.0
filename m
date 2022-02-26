Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6AB4C5801
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Feb 2022 21:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiBZUgq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Feb 2022 15:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiBZUgp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Feb 2022 15:36:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73AB24F196;
        Sat, 26 Feb 2022 12:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fEAcGaJUxo5Ad6zgJJsq56UKYNjoUAjSyB/+tIvNrjw=; b=WCO2JsowcBFILaTJUdMmCHOClo
        qj2mQTVqqoWNY+aZPD7Ch1W9hE40Emz7sQYT+atEkNJUrGXvGujdx04ELlFZujt0OeLDhGXnQ6JSA
        o5QlD8DrjNGOtiOzCToYOGoOQIP/X5nigz5FXB9QurN57iSJquM0RBrnhMkpzN5YW0nUnRe1/B+CG
        4JKYzmhRfwpo3+WeY0g16NzxPgnb8Ebgd8R27FjCbT/vxPAC+DAYgEvihwu69Xn65WdssWkgCwqPT
        OkxneNnPEPH0kEwGpT/8TnWmSWqLn7UfwYnRMtUxB1hbyMBcOeFf+Oe7gbLH7vF14BbwuufhHTtKI
        R6yhlOZQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nO3n8-008Ucn-18; Sat, 26 Feb 2022 20:35:46 +0000
Date:   Sat, 26 Feb 2022 12:35:46 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Wei Xiao <xiaowei66@huawei.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, keescook@chromium.org,
        yzaikin@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, young.liuyang@huawei.com,
        zengweilin@huawei.com, nixiaoming@huawei.com
Subject: Re: [PATCH v2 sysctl-next] ftrace: move sysctl_ftrace_enabled to
 ftrace.c
Message-ID: <YhqPIvyDtMM7Ehpl@bombadil.infradead.org>
References: <20220223111153.234411-1-xiaowei66@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223111153.234411-1-xiaowei66@huawei.com>
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

On Wed, Feb 23, 2022 at 07:11:53PM +0800, Wei Xiao wrote:
> This moves ftrace_enabled to trace/ftrace.c.
> 
> We move sysctls to places where features actually belong to improve
> the readability of the code and reduce the risk of code merge conflicts.
> At the same time, the proc-sysctl maintainers do not want to know what
> sysctl knobs you wish to add for your owner piece of code, we just care
> about the core logic.

Thanks for using a commit log message which helps folks understand why
we are doing this.

> 
> Signed-off-by: Wei Xiao <xiaowei66@huawei.com>

Thanks, queued on sysctl-next!

  Luis
