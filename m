Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A9D7233DB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 02:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjFFAAC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 20:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjFFAAB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 20:00:01 -0400
X-Greylist: delayed 715 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Jun 2023 16:59:58 PDT
Received: from mail.heimpalkorhaz.hu (hpkpacs.heimpalkorhaz.hu [193.224.51.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B863E115
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 16:59:58 -0700 (PDT)
Received: from mail.heimpalkorhaz.hu (localhost [127.0.0.1])
        (Authenticated sender: prosinger@heimpalkorhaz.hu)
        by mail.heimpalkorhaz.hu (Postfix) with ESMTPA id ED45B381535667;
        Tue,  6 Jun 2023 01:47:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.heimpalkorhaz.hu ED45B381535667
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heimpalkorhaz.hu;
        s=default; t=1686008878;
        bh=yKVhkcaDegeUScoZnkCqS/w4l/7NS8OD6bTQPhDeXZo=;
        h=Date:From:To:Reply-To:From;
        b=BEpT5quKy9BOZv6A02mbauPXnLpBxT1tGTN40REEQiB8kiB9e4hPbfigeXIer2dZK
         F7SlcHxX8OG6FNxQ4LLL6K/b8o0TFVUmkn8Ah86Kjt99DrU9NDQVJUFPD6slF27Ooo
         5DsYVi8DZN1rz4H++OzjcNttnbnstDpCi0nNNDMd5GDmzJbnTxu024DDtzDYPrYBLK
         cJpluB/0Zj71vvUyjJjWSwNYz2V6qHotzOp7otv1y2Ny8k6V9JZQgSx3jwStn149Nj
         2N284BSs9hgHWqDUBGGLLg97zcREWeNa0OdsAg+Ay9T+zfGoMsOiINf6dpSgKH/EUt
         i1FUY+YiZ4Zpg==
MIME-Version: 1.0
Date:   Tue, 06 Jun 2023 00:47:57 +0100
From:   Rowell Hambrick <prosinger@heimpalkorhaz.hu>
To:     undisclosed-recipients:;
Reply-To: rowellhambrick07@gmail.com
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <0167a44dca5b77fb3e5fbeb160fb4d67@heimpalkorhaz.hu>
X-Sender: prosinger@heimpalkorhaz.hu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.00 / 20.00];
        FROM_DOMAINS_WHITELIST(0.00)[heimpalkorhaz.hu];
        TAGGED_RCPT(0.00)[]
X-Rspamd-Server: mail.heimpalkorhaz.hu
X-Rspamd-Queue-Id: ED45B381535667
X-Rspamd-Pre-Result: action=no action;
        module=multimap;
        Matched map: FROM_DOMAINS_WHITELIST
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,MISSING_SUBJECT,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Did you get my last message
