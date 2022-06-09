Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4207544E55
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 16:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239193AbiFIOD6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 10:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbiFIOD5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:03:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7BB5DD29;
        Thu,  9 Jun 2022 07:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kUhQxA1qelKtwWVRv8G+kYYr7+zVRWwYVB7OXsyGkpY=; b=tUJNUJDk+Y2q2PVRf8tCJfqbNU
        7qqWsSwyqH1Q4nchLpSKJoGqXEhHtvhxXwVM5J6aIkiv4R4ooQM8yQd7zVLic8eGmed1AQl/sFnCT
        PcclJrG+lL9ekfLq6qYaQN9ln9YGmdX2NIvPw9+g5OQBUV3qr86XHurnOVFA/HbZ6uyZQolZaW4u6
        rqS2PhQIksT2k8zt27kbBzLCHB7KZzbzwPU4egvuMctDdCdWJ7UE34+bAfofJ0STHTceEXrva03ga
        9pwzvsHy1+IYgzwnfRpaFPRjlGqq6T48DR9MgZym5AD7FfAD62WlStSSciFmyZuWTOONIxeZLl+Gm
        dqeX9NIQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzIlO-002OHe-GB; Thu, 09 Jun 2022 14:03:54 +0000
Date:   Thu, 9 Jun 2022 07:03:54 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     bh1scw@gmail.com
Cc:     keescook@chromium.org, yzaikin@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com
Subject: Re: [PATCH] kernel/sysctl.c: Clean up indentation, replace spaces
 with tab.
Message-ID: <YqH9yp/ZTXZuC1A/@bombadil.infradead.org>
References: <20220522052933.829296-1-bh1scw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220522052933.829296-1-bh1scw@gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 22, 2022 at 01:29:33PM +0800, bh1scw@gmail.com wrote:
> From: Fanjun Kong <bh1scw@gmail.com>
> 
> This patch fixes two coding style issues:
> 1. Clean up indentation, replace spaces with tab
> 2. Add space after ','
> 
> Signed-off-by: Fanjun Kong <bh1scw@gmail.com>

Queued up to sysctl-next, thanks!

  Luis
