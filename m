Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97ACA4D731F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Mar 2022 07:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbiCMGs2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Mar 2022 01:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiCMGs0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Mar 2022 01:48:26 -0500
X-Greylist: delayed 120 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 12 Mar 2022 22:47:18 PST
Received: from swift.blarg.de (swift.blarg.de [IPv6:2a01:4f8:c17:52a8::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8CF56E343;
        Sat, 12 Mar 2022 22:47:18 -0800 (PST)
Received: by swift.blarg.de (Postfix, from userid 1000)
        id E67FD41027; Sun, 13 Mar 2022 07:47:17 +0100 (CET)
Date:   Sun, 13 Mar 2022 07:47:17 +0100
From:   Max Kellermann <max@blarg.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] pipe_fs_i.h: add pipe_buf_init()
Message-ID: <Yi2TdX1MdF+xXuU5@swift.blarg.de>
Mail-Followup-To: Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220225185431.2617232-1-max.kellermann@gmail.com>
 <20220225185431.2617232-4-max.kellermann@gmail.com>
 <Yi1Y99MX7yxD2k6m@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yi1Y99MX7yxD2k6m@zeniv-ca.linux.org.uk>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_05,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/03/13 03:37, Al Viro <viro@zeniv.linux.org.uk> wrote:
> *cringe*
> FWIW, packetized case is very rare, so how about turning that into

I have no hard feelings how this API must look like, I only want it to
exist, to reduce code fragility a bit.  Tell me how you want it, and
I'll resubmit.
