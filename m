Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26BEB492365
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 10:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbiARJ54 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 04:57:56 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36294 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbiARJ5z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 04:57:55 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B230D1F3B5;
        Tue, 18 Jan 2022 09:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642499874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Sd2Ytc90QMPy0tWSwkafT8zjpZTOiXkQQz7OPV8flag=;
        b=SgyelUvovAOFSx2WkOiNBQTqPUSkjnLoVHa7X/zbv2KLDwkc9X1GTLt7ZMUIxPPEOsfsgD
        Kk3KLTQC0+Vea1O6+jWMcuwwMtcC6SPzAiwOPNVBxPQT1fATPp45WtDexZD929dT1X5out
        19doT309xM2Fx1Rbv8Tp+Gj6yHrIUt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642499874;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Sd2Ytc90QMPy0tWSwkafT8zjpZTOiXkQQz7OPV8flag=;
        b=oNCLfcsfuLVprlQBNDl1AT5RR4gMqFKjE00yvGnXpFCftSgGLuvUtpuZhRH8ufEqCppAfa
        mli8ji5x/125iJBg==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A851FA3B84;
        Tue, 18 Jan 2022 09:57:54 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 62299A05E2; Tue, 18 Jan 2022 10:57:53 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     butt3rflyh4ck <butterflyhuangxx@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] udf: Inline format expansion fixes
Date:   Tue, 18 Jan 2022 10:57:46 +0100
Message-Id: <20220118095449.2937-1-jack@suse.cz>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=160; h=from:subject:message-id; bh=3T4TB3cZAciowCfrNgDk1/loTM6vhswTFL4MtL41RKc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBh5o8HQJKetQ+sFMORubVimgd4/gMlxmluqdsnHRZ/ 8ymFWDWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYeaPBwAKCRCcnaoHP2RA2dZ5CA DdqYlWw3HiL4zlORrBMtwhnma4z9W3HRZ95nHzuBDSBSRjxyvQjiSkJ72pe9VYCEpS9VnAXtza5pb1 7739W8uocG2ruDq0DyQX9Tsiq9VlpT5tldpn0JtPgs75HiGjBllXQ9i9y6u8dp0ZKivSAM5ZdpgL+D bbgf/vuorP9CJrK2NG3Yd8eznsrk6AXleiOvIAtXidZ3/VYTVxipXe6GEKI4V1txmAxAw6m9k+EOQV Ab9n52oY27i+YWyVEfF7S9F8CjkexsJGWjS3/wP7Cz9lOeTL7Uh4F5IHlCPhsmTnNBwXmv0V8u2HFA rrLvz074Mw5mt6xQzTdj/wHrMm9Xyw
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

these two patches fix problems identified by a syzkaller in expansion of
inodes with inline data. I plan to queue them in my tree.

								Honza
