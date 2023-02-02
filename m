Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7CA688AF7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 00:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjBBXmx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 18:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjBBXml (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:42:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDF065F21;
        Thu,  2 Feb 2023 15:41:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 183BF61D19;
        Thu,  2 Feb 2023 23:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F346C433EF;
        Thu,  2 Feb 2023 23:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1675381315;
        bh=OFIZjfUwXkOIpzqkXb876+1TuJeDk5K8kjr9J/n4gK0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XiZEw+P2dv1GNEnfAwJ3S3UKZeoaTI4bFojYl1xz9bBLGBqpO/BpxrI1TYHI2vaEM
         tRmX+GhfYhZHB5GZQxJv3U4gZm4ikBi70Tjzyg80lR0d7XrjYV1DU5PUo63PqBc8vQ
         CCKFfH/x+UCci7bul229xeH8pOt54bmYa4757SII=
Date:   Thu, 2 Feb 2023 15:41:54 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chao Yu <chao@kernel.org>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, adobriyan@gmail.com
Subject: Re: [PATCH 1/2] proc: fix to check name length in proc_lookup_de()
Message-Id: <20230202154154.64a087a47bbf2210584b1734@linux-foundation.org>
In-Reply-To: <93c1e281-82a5-d7d0-04b1-67ac2cf3d0fa@kernel.org>
References: <20230131155559.35800-1-chao@kernel.org>
        <93c1e281-82a5-d7d0-04b1-67ac2cf3d0fa@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 1 Feb 2023 21:01:14 +0800 Chao Yu <chao@kernel.org> wrote:

> Hi Andrew,
> 
> Could you please take a look at this patchset? Or should I ping
> Alexey Dobriyan?
> 

[patch 1/2]: Alexey wasn't keen on the v1 patch.  What changed?

[patch 2/2]: What is the benefit from this change?
