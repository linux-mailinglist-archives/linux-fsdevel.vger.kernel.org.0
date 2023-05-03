Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5B66F5BDD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 18:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjECQYT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 12:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjECQYS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 12:24:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0F74EF9;
        Wed,  3 May 2023 09:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=48XGDRTu5lC8Uq10mtv4Awaa56oho69zyl02Hq2NT4Y=; b=qo7q+PA//KUaWkz8gKt1od2gj4
        Ml9SHSN/AxdU84MJW9bdwUvo1WrYcfx4S1D07dNh9zFEXOMZLXYa/QFJof7vtqY9D4SFTDisOuXNt
        8XQUwf1vkKxzR8G8vqXUWY1G0Vj+McrwfrfDLq6IUxwHQzCP/SmS4mCEFejJwEYkicZm4G9vzSZA8
        822dGR0B5pBvO5ZGjiuMO7aaRrS9r+j9z5jeLpRKjb2f76D52YlHixOA7dYvkIUKePpkbpLm3H0hH
        DOfh5sg/13Up2MkIHb3GqWseg59GjHx7tgkQDksiZ4vIgfb2eQ53PFJ16Q4BTcSbqtLqmgzevlmYu
        v1IiMqVQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1puFGv-0054hC-0x;
        Wed, 03 May 2023 16:24:05 +0000
Date:   Wed, 3 May 2023 09:24:05 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        ebiggers@kernel.org, jeffxu@google.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] sysctl: death to register_sysctl_paths()
Message-ID: <ZFKKpQdx4nO8gWUT@bombadil.infradead.org>
References: <20230503023329.752123-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503023329.752123-1-mcgrof@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 02, 2023 at 07:33:27PM -0700, Luis Chamberlain wrote:
> You can give it a day for a warm fuzzy build test result.

0-day gives its blessings.

  Luis
