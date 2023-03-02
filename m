Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2727F6A8C38
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 23:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjCBWwN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 17:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjCBWvp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:51:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6132855526;
        Thu,  2 Mar 2023 14:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KjqT5KSCirrDSNNpHe8xR/eXHKVE9kgZCdB1mB56qVA=; b=O7CIJgPahJKYoadAO2D0qi36b3
        XpThpTOIrHtZJsAYtwRwG5hFtQAn21jbH9E7ST64vWoogOqEMJACqEEw6ppNlekgn1aP6+naZr+YJ
        cstPt5krMM6qUXj+LUPhNuhWLf/pcWHlUaketh0czdju8iyM+D+EwOpQ/hEVTptQZXfNBfEtdEiZN
        sgTpZSS+GQQiwAvu5QyMKhFRjgK7A6TURMqQ8DF2nwwnSI4SC98uWyUW1muU9nDHHw74AUHk9X0BD
        xe7iLOZ/XmB/LvbwrOF1s4PXaH+vg7iYWMT9sGNKw9+qiobB6XvlpG5MQ/rCJnKggMAJk9tii4t/w
        V5OrWqxQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXqwo-003SJs-0W; Thu, 02 Mar 2023 21:58:46 +0000
Date:   Thu, 2 Mar 2023 13:58:45 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     akpm@linux-foundation.org, peterx@redhat.com,
        jthoughton@google.com, Liam.Howlett@oracle.com,
        viro@zeniv.linux.org.uk, keescook@chromium.org, yzaikin@google.com,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] userfaultfd: move unprivileged_userfaultfd sysctl to its
 own file
Message-ID: <ZAEcFVkOR64psDEJ@bombadil.infradead.org>
References: <20230301100627.3505739-1-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301100627.3505739-1-zhangpeng362@huawei.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 01, 2023 at 10:06:27AM +0000, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> The sysctl_unprivileged_userfaultfd is part of userfaultfd, move it to
> its own file.
> 
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>

Looks good, I've queued this up for sysctl-testing, before all the
patches I just posted. Keep it up, hopefully soon the vm array
on kernel/sysctl.c will be gone.

  Luis
