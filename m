Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3B86B72CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Mar 2023 10:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjCMJki (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Mar 2023 05:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjCMJkO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:40:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A182125A1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Mar 2023 02:39:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A36E861198
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Mar 2023 09:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D3CC433D2;
        Mon, 13 Mar 2023 09:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678700385;
        bh=tSkJZ2imUJW4t2R4SsjfRiLfkxADAi4SR9WVrL87phk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ouStgUs1JK5+WtQfLqAOxAtEiXNoh/skzvxuHXLUfwjD68pEx0Wy45vWGvynLyGJc
         T2YVm1oX5tljFLqPdy/GIvtEJIdFvOLc6tDMH4bXRKQzEBHfhBm0NI/sXBtbWuL7AJ
         ppswlWhyy2oKGbRRNPNfnp/cFjttaw5d32f1P03NePa/UYaZu6m8KIxgI4gs1aI555
         y5YzPsk5fnSZ+SJPDR7Whu6addkYPeYD81w1/LGvdD0XU2JuJE5/f/+ZEn/x7psk6L
         9Hzi+eYAcXkFY1xA6ivato5DAqXHQh5dzHr0u3ey3yX0ySkhnDaGNcXozB66Q//uNV
         33rjq76tgKhTQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Changcheng Liu <changchengx.liu@outlook.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] eventpoll: align comment with nested epoll limitation
Date:   Mon, 13 Mar 2023 10:39:34 +0100
Message-Id: <167870003896.965687.11981357119052932186.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <OSZP286MB162945062EEF86CA39230AE8FEB89@OSZP286MB1629.JPNP286.PROD.OUTLOOK.COM>
References: <OSZP286MB162945062EEF86CA39230AE8FEB89@OSZP286MB1629.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=368; i=brauner@kernel.org; h=from:subject:message-id; bh=b9sbiumDcU/rP8KCO6fg/yYS0CLI4vDDqjiJC3bPOvE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTwvfdVSCzXm9ORvFJo3hmprVcabdyKfeRrZfMPbmB5tyZy 9lHVjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImw3WX4HzxDRMhdZvnaWp9ZNt1tPp mllTOmacpnVouZSXbzMKovYfgfwzA1Qvf4QrHUG3+MvU+4rp/xJsbnRb5R1bd9P2xt93cwAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner (Microsoft) <brauner@kernel.org>


On Sun, 12 Mar 2023 17:25:22 +0800, Changcheng Liu wrote:
> fix comment in commit 02edc6fc4d5f ("epoll: comment the funky #ifdef")
> 
> 

Applied, thanks!

tree: git://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git
branch: fs.misc
[1/1] eventpoll: align comment with nested epoll limitation
      commit: 7059a9aa4b6b8c6daf257a3978a4d8c476c29a96
