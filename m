Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D83CEC369A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2019 16:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfJAODv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Oct 2019 10:03:51 -0400
Received: from iota.tcarey.uk ([138.68.159.189]:45274 "EHLO iota.tcarey.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfJAODv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:03:51 -0400
X-Greylist: delayed 624 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Oct 2019 10:03:50 EDT
Received: from kappa (dyn221130.shef.ac.uk [143.167.221.130])
        by iota.tcarey.uk (Postfix) with ESMTPSA id A9C38232BE;
        Tue,  1 Oct 2019 13:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tcarey.uk; s=iota;
        t=1569938005; bh=mrtpspnWZp9SxKOefWW1+TAlxbGTeacgOvvG5fugAhI=;
        h=Date:From:To:Cc:Subject:From;
        b=wCq0aOlwK4+kz448pDWtwCp9yuJiSwLMzZHGCIf9KedHfiye9X0bJhMvNM/K9N3NZ
         AO4CujwGXzxVqBWw/xcjL47VT2M+ac2eOE9Z9gF3YYx8iIE4447pkdaI7JHcN73s1o
         uNCr7COV3PJ4g+feOKHpEpA1nfNL1ZS8LvF5AY92oNsMcIL71Dq940QRsNy3h53wQr
         sbTRIWiHscpvt2TbJLsACC2AG1vdRkeZAwutrIh6CrNAiyhvhRU8xCi2GxepnwBjpT
         NwFvCmRCGDqpGzZAmjvTbpykW5SG5UICLW0OO0e4aUPSrrqBX7DJR3sIN7qPKbdrfu
         8rYdTKmbUg6pQ==
Date:   Tue, 1 Oct 2019 14:53:24 +0100
From:   Torin Carey <torin@tcarey.uk>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/seq_file: export seq_put_hex_ll symbol
Message-ID: <20191001135322.GA26299@kappa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The seq_put_hex_ll symbol should be exported to allow dynamically loaded
modules to call the function.

Signed-off-by: Torin Carey <torin@tcarey.uk>
---
 fs/seq_file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 1600034a929b..9382d3b335fa 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -772,6 +772,7 @@ void seq_put_hex_ll(struct seq_file *m, const char *delimiter,
 	}
 	m->count += len;
 }
+EXPORT_SYMBOL(seq_put_hex_ll);
 
 void seq_put_decimal_ll(struct seq_file *m, const char *delimiter, long long num)
 {
-- 
2.20.1

