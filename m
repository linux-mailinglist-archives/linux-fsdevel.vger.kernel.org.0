Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC71649296
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Dec 2022 06:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiLKFy5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Dec 2022 00:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiLKFy4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Dec 2022 00:54:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F48120B8;
        Sat, 10 Dec 2022 21:54:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AED660C97;
        Sun, 11 Dec 2022 05:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD88EC433EF;
        Sun, 11 Dec 2022 05:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670738094;
        bh=1FZSvg1VV5fd0X4IXRQ/3Im/8nHJEAEA/6Sohp7gUlQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uAyt4p6s8439vGHDMi+wDqrs/UBniW407/oGUr/VlX4oqYU3iycP0srZfI3sWJrAk
         oofuNsR7Elnf0oZ8BKt0dS8axjhtZvJ0j6tiES7ahWt8kev9t3inWkARx2/K9nG7cI
         k6FKY9tE8hDPlm49a8f0N4xqTeHWaPvHHYzjzjelrk8tw1BRP0HcAY7IfZQqjqjOx5
         NqFxpgU19OcEQb5mNonszOHGo3VC3rR1Z5N6Mkl35bDxXd3J+6JjocaYz71guctbAq
         fWZGh8HuNf8SsH1AjBSLmBvZRFHFPCOiOsvCp82IrSyo8IkRQpwaC4Usy+UVYMCA/E
         BZsWe7ADG/bzw==
Message-ID: <38c34b59-bf57-4eb8-b74b-8b387b792cb8@kernel.org>
Date:   Sun, 11 Dec 2022 13:54:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [f2fs-dev] [PATCH v4 15/23] f2fs: Convert last_fsync_dnode() to
 use filemap_get_folios_tag()
Content-Language: en-US
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-cifs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org
References: <20221102161031.5820-1-vishal.moola@gmail.com>
 <20221102161031.5820-16-vishal.moola@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221102161031.5820-16-vishal.moola@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/11/3 0:10, Vishal Moola (Oracle) wrote:
> Convert to use a folio_batch instead of pagevec. This is in preparation for
> the removal of find_get_pages_range_tag().
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,
