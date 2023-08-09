Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA9A776795
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 20:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjHISpM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 14:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjHISpL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:45:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3887CC9;
        Wed,  9 Aug 2023 11:45:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5295643FA;
        Wed,  9 Aug 2023 18:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6C1C433C7;
        Wed,  9 Aug 2023 18:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1691606709;
        bh=WCy2YukGF64kPQTe01Lnw8LXAzaGR8i9XeIiDBWpfRc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g6ef4/VtOg15xZZXwc68hTnMmjKk6ReLqWk4DxInjCR1gzA/8J4HIg6aBOaz56Gpe
         wjfoIo7HHCCjtkftCK5v/z5oYNMrlzB4MRl04JvDSsHz6ChGUwGtK7Oo0S+rjd7c7a
         HRaNsURG5f2KK1Ry3HqRpO+SkwRAJb/xyDKoHAyo=
Date:   Wed, 9 Aug 2023 11:45:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Haibo Li <haibo.li@mediatek.com>, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, xiaoming.yu@mediatek.com
Subject: Re: [PATCH] mm/filemap.c:fix update prev_pos after one read request
 done
Message-Id: <20230809114507.57282ff1dd14973f3964e669@linux-foundation.org>
In-Reply-To: <20230809164446.uwxryhrfbjka2lio@quack3>
References: <20230628110220.120134-1-haibo.li@mediatek.com>
        <20230809164446.uwxryhrfbjka2lio@quack3>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 9 Aug 2023 18:44:46 +0200 Jan Kara <jack@suse.cz> wrote:

> Willy, any opinion? Andrew, can you pickup the patch if Willy doesn't
> object?

I added it to mm.git on July 2.
