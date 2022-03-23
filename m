Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2E94E4E83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 09:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242864AbiCWIti convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 04:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242862AbiCWIth (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:49:37 -0400
X-Greylist: delayed 38494 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Mar 2022 01:48:07 PDT
Received: from 6.mo583.mail-out.ovh.net (6.mo583.mail-out.ovh.net [178.32.119.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D49393E4
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Mar 2022 01:48:06 -0700 (PDT)
Received: from player694.ha.ovh.net (unknown [10.109.156.60])
        by mo583.mail-out.ovh.net (Postfix) with ESMTP id E689223D31
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Mar 2022 05:09:46 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player694.ha.ovh.net (Postfix) with ESMTPSA id 27E4B28977B6A;
        Wed, 23 Mar 2022 05:09:41 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-99G0030a29b9fe-1317-4aa6-b294-7148a9ed8fa2,
                    404CC6C5AE1CA2DD881B97E5F464CB0C121347F9) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
Date:   Wed, 23 Mar 2022 06:09:39 +0100
From:   Stephen Kitt <steve@sk2.org>
To:     Matthew Wilcox <willy@infradead.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
CC:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] idr: Remove unused ida_simple_{get,remove}
User-Agent: K-9 Mail for Android
In-Reply-To: <20220322220602.985011-1-steve@sk2.org>
References: <20220322220602.985011-1-steve@sk2.org>
Message-ID: <E131FD3F-4FC1-4EC0-8DE0-42BFC6708384@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Ovh-Tracer-Id: 12365195729709270662
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudegiedgjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffufggjfhfkgggtgfesthhqmhdttderjeenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepvdeitedvheelgeefieefieevudekveetheeuleekueeuvdehtddtheekheejtdeunecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrieelgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22 March 2022 23:06:02 CET, Stephen Kitt <steve@sk2.org> wrote:
>These are no longer used anywhere, remove them; update the
>nvmem-prodiver.h to refer to ida_alloc() which is what is used now
>(see drivers/nvmem/core.c).
>
>Signed-off-by: Stephen Kitt <steve@sk2.org>
>---
> include/linux/idr.h            | 8 --------
> include/linux/nvmem-provider.h | 2 +-
> 2 files changed, 1 insertion(+), 9 deletions(-)
>
>diff --git a/include/linux/idr.h b/include/linux/idr.h
>index a0dce14090a9..273b2158a428 100644
>--- a/include/linux/idr.h
>+++ b/include/linux/idr.h
>@@ -314,14 +314,6 @@ static inline void ida_init(struct ida *ida)
> 	xa_init_flags(&ida->xa, IDA_INIT_FLAGS);
> }
> 
>-/*
>- * ida_simple_get() and ida_simple_remove() are deprecated. Use
>- * ida_alloc() and ida_free() instead respectively.
>- */
>-#define ida_simple_get(ida, start, end, gfp)	\
>-			ida_alloc_range(ida, start, (end) - 1, gfp)
>-#define ida_simple_remove(ida, id)	ida_free(ida, id)
>-
> static inline bool ida_is_empty(const struct ida *ida)
> {
> 	return xa_empty(&ida->xa);
>diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
>index c9a3ac9efeaa..e957cdc56619 100644
>--- a/include/linux/nvmem-provider.h
>+++ b/include/linux/nvmem-provider.h
>@@ -75,7 +75,7 @@ struct nvmem_keepout {
>  *
>  * Note: A default "nvmem<id>" name will be assigned to the device if
>  * no name is specified in its configuration. In such case "<id>" is
>- * generated with ida_simple_get() and provided id field is ignored.
>+ * generated with ida_alloc() and provided id field is ignored.
>  *
>  * Note: Specifying name and setting id to -1 implies a unique device
>  * whose name is provided as-is (kept unaltered).
>
>base-commit: 5191290407668028179f2544a11ae9b57f0bcf07

Apologies for the waste of time, these are far from unused. I'm not sure why my searches didn't find anything yesterday...

Regards,

Stephen
