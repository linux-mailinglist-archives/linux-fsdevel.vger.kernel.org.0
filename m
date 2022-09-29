Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3A55EF972
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 17:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbiI2PtE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 11:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236059AbiI2Psg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:48:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99731C00FA;
        Thu, 29 Sep 2022 08:48:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB9D4608D5;
        Thu, 29 Sep 2022 15:48:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD70C433C1;
        Thu, 29 Sep 2022 15:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664466486;
        bh=HFVqVM8he9K7QibhHjqjVgJk0ZPotaqgYB2utTtMyrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nj3k92wyH1ZIhG7QfdD8ACdpmTfWEk+9o7i6zFEE/GbRrmQ/dNSC41mHmfZ+5I4pt
         d5D3NzokODjsSi81aEBXpeTPsCV0NqPs4+aGVnhKLuGI7lUCSukSSIUCJ+/xloGJyb
         FMfe+yu4tK7LxmUG7SKhkJoXPj6HkV3MphT+37XEEYEgTfh6p+W7UE+28dvjwpTH5d
         5oIxjgQ7lRJsW/CLkqGNlY71IepZt+c1ug06pWQevuQbnbduGgHc7LjrBG4t8kn4ca
         a6qhhBvYIUHpIY94VelKO2gDopnKqBt2pA2I3Le/3/RMnHCw45dS64Zq9MLq9oWh69
         6miP8BlaGVmuQ==
Date:   Thu, 29 Sep 2022 09:48:03 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, qemu-devel@nongnu.org,
        kvm@vger.kernel.org
Subject: Re: Commit 'iomap: add support for dma aligned direct-io' causes
 qemu/KVM boot failures
Message-ID: <YzW+Mz12JT1BXoZA@kbusch-mbp.dhcp.thefacebook.com>
References: <fb869c88bd48ea9018e1cc349918aa7cdd524931.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb869c88bd48ea9018e1cc349918aa7cdd524931.camel@redhat.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I am aware, and I've submitted the fix to qemu here:

  https://lists.nongnu.org/archive/html/qemu-block/2022-09/msg00398.html
