Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AF75B2A93
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 01:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiIHXqc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 19:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiIHXqb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 19:46:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A7F6DF9C;
        Thu,  8 Sep 2022 16:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6ryY9pyjhsl0mIepyesVJLW8YpzwUv2KoNY4IzOxFHw=; b=kuKqS1bbIAzPwzkBQAbq9SRgAY
        dTz2HkE24OkBMm7d0WsDsMeOpz6819EshNOvQ+ZzoEl9EQ3RnnLddR0HyIFQM9IaO88YgRR+QUt/B
        3gCcuPq7PyJyW/VD6SFflXrqhqmMf+n8ZlcVZ3mQVTR4n0QYGvG9wefhRup/BcO2wGJ56Bzt+7UBj
        dZ3cKrzdMDoQpXCHC4ZuS5Gsp82oJJEqYerFOQd/e5N/lxgJx53Rkf+JKCWNbY9IgvPmjguHP5ugU
        GRz/GD404SY1a53qKakTsAXTcWjEvoaYhrthHyZ5IoccTweNfaCjmo87mlLz9K1c8bi0GqP8AORgH
        9xc4+qbw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWRE4-009vIS-2g; Thu, 08 Sep 2022 23:46:28 +0000
Date:   Thu, 8 Sep 2022 16:46:28 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dong Chuanjian <chuanjian@nfschina.com>
Cc:     keescook@chromium.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel@nfschina.com
Subject: Re: [PATCH] kernel/sysctl.c: remove unnecessary (void*) conversions
Message-ID: <Yxp+1KN0tJXgD2eI@bombadil.infradead.org>
References: <20220822063049.5115-1-chuanjian@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822063049.5115-1-chuanjian@nfschina.com>
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

On Mon, Aug 22, 2022 at 02:30:49PM +0800, Dong Chuanjian wrote:
> remove unnecessary void* type casting
> 
> Signed-off-by: Dong Chuanjian <chuanjian@nfschina.com>

Thanks, queued up to sysctl-testing.

  Luis
