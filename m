Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37AB59AABE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 04:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243591AbiHTCjk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 22:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiHTCjj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 22:39:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9FAA1D3D
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Aug 2022 19:39:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F303E61950
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Aug 2022 02:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFBBC433C1;
        Sat, 20 Aug 2022 02:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660963177;
        bh=iH1pavw6wGlgv07NQq9XNjQRZrUdrB+HqyoCKsTLZj0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fAtgHZIzgi0xHlh8MIWZqqowRAVXQuWrpL+CG02PYeoXpbDi9zKDtSua6q1Q7NQE4
         K+T/iQoEsbccQDhZxlXVVH52SZTpaD8O6U4iRJAYxJERPiFElCQeo+oYVHG+tLG8ZB
         Z+QaUFKUXj8LqXKXwSr4bPts95d6GGEEX9tE/Aq5h9Us3t+mWLlYuomRESsBptLFfJ
         ch7Qrk6SV4se//YlthWK2wlgLf0zsQ7PTzGfai4+iQUNk2pPdMo8Ag+/Syg7iq3SK5
         LiP48Wyrb8CosTHoZXe3o68khP7UU4jm+dahjJgHGM8oZROHyTEc58mPBH13l/6MAH
         AMvb8nVOkpfRw==
Message-ID: <a2e3faf6-dedc-7ee7-0b08-8a5f2bfc2d25@kernel.org>
Date:   Sat, 20 Aug 2022 10:39:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: use memcpy_{to, from}_page() where
 possible
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
References: <20220819223300.9128-1-ebiggers@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220819223300.9128-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/8/20 6:33, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> This is simpler, and as a side effect it replaces several uses of
> kmap_atomic() with its recommended replacement kmap_local_page().
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
