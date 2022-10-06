Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98495F7150
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 00:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbiJFWoi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 18:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiJFWog (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 18:44:36 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681AF142CA4;
        Thu,  6 Oct 2022 15:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=EVVRdLfHGU547JfhyTxvQ1HY3Wn3XFoxK5UyvM0hFKk=; b=S9nw97lEu8mn3bpxd94Yis8KLD
        mhDQD9qFVo6vdZKXGeqT5TqMtK+v08L58XhUUAconTmoklUwrzXczCpugRahGe0mwDG9T/67+BgCt
        PWJMq9Qjv5xaguPzqOeP9pLBovYq5kcbs2QTbpNYjQYXvFkC+uPm8kC8rJMqO7TikM/MXHSw6CIGK
        +6fUs2fR30xVHqYfzh4vYchDr9AUi9irXwTp0qeRsCNqAxzZZYXekk9Czol6TS5yYJkd27TxdJsJM
        ggQoYnHVMNNq+ep8BRYiWV/q1lpcM/gDG3KEOktniroY5yZmEsiuGqL5OP3mSIO74vzhH24+n3ibX
        /yGzGwdQ==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1ogZbS-00C4Q8-B2; Fri, 07 Oct 2022 00:44:31 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     kernel-dev@igalia.com, kernel@gpiccoli.net, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH 6/8] MAINTAINERS: Add a mailing-list for the pstore infrastructure
Date:   Thu,  6 Oct 2022 19:42:10 -0300
Message-Id: <20221006224212.569555-7-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221006224212.569555-1-gpiccoli@igalia.com>
References: <20221006224212.569555-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, this entry contains only the maintainers name. Add hereby
a mailing-list as well, for archiving purposes.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---


Hi Kees / all, not sure if up to me doing that (apologies if not) and
maybe fsdevel is not the proper list, but I think worth having at least
one list explicitely mentioned in MAINTAINERS in order people use that
as a pstore archive of patches. If you prefer other list, lemme know.

Cheers,

Guilherme


 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 72b9654f764c..16a18125bf0a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16465,6 +16465,7 @@ M:	Kees Cook <keescook@chromium.org>
 M:	Anton Vorontsov <anton@enomsg.org>
 M:	Colin Cross <ccross@android.com>
 M:	Tony Luck <tony.luck@intel.com>
+L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
 F:	Documentation/admin-guide/ramoops.rst
-- 
2.38.0

