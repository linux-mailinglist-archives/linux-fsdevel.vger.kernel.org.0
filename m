Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1500799C9B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Sep 2023 06:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345894AbjIJEbb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Sep 2023 00:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239833AbjIJEb3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Sep 2023 00:31:29 -0400
Received: from out-221.mta1.migadu.com (out-221.mta1.migadu.com [95.215.58.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9C518E
        for <linux-fsdevel@vger.kernel.org>; Sat,  9 Sep 2023 21:31:24 -0700 (PDT)
Date:   Sun, 10 Sep 2023 00:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694320282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=4tNz0B7X1/PEX9tMB65gdEDeC5vTYbpdG6j1hg+l2p8=;
        b=TmYYNAVinh2tMEhzdx+cka8W11d3lL7JuuuNsr+K0eJS6QtQxFgqo2G+bSBWjQzbDY+wb9
        bHpkQOWdKR8a5xUytTRaefPvZ6zsBU5bwrA/7DAQTu7bUuBOkXghV7ii5hx2Op61NWYrrP
        RkO9fG0fAHqqHIDOrtJjNdPh2IbiaiM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: bcachefs tree for next
Message-ID: <20230910043118.6xf6jgeffj5es572@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Stephen,

Please include a new tree in linux-next:

http://evilpiepirate.org/git/bcachefs.git for-next

I don't see any merge conflicts with the linux-next master branch

Cheers,
Kent
