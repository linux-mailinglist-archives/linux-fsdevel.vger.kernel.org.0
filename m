Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B307F4437C3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 22:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhKBV12 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 17:27:28 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:48281 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229981AbhKBV11 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 17:27:27 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 0C1B73202005;
        Tue,  2 Nov 2021 17:24:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 02 Nov 2021 17:24:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=LWkAPpC13Vvhw
        aICYGoyRdRIfvkIhqrd9vyguQwCkpw=; b=Oc3VR68olnqlNcEPq+nR3zLRplB3w
        z932wS7x79s1G5Jfi3UMDbzWzE6qTRKSdKEJDbVrJOrm+9nxJXfykIQtOVL5QWww
        KpMEZ7vU7xprX1zlQ6ywmHYfjb7A4w6QmiUnxM3GVsskRTJoLTE5DGC1hQ+Doahx
        Zy6/blh4zM3Xvy20aAqoU7wxIG2R2EKtruuWj3pG4lMnfFDvh9ycFxotJvT7fwq1
        NiW9NSsokBjT0yW+ldWkHWgjhow8bhgUtqrTqxIQ9x4EjjvQle/LO/L+UKsXiTaC
        c6jnyLE/UDUa0dYbAs5yr+4BFID9ohwOyeLcLRQ4SBng9esmRe7ZYWZxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=LWkAPpC13VvhwaICYGoyRdRIfvkIhqrd9vyguQwCkpw=; b=CM03nAHg
        y3KoPYjAiFwSilhpz2w5ui+4phmOtDF9erWA+ig/1xrd3hhCSOxZd9C00hERfWrj
        WGjOnP77Ot65HNro3tDV2ardH9k90HKi24wCyvn+4HyxNbZAcRfhi+urKRqBl+aY
        6AQkkOD750C4BuhtvDtP70JsaQ872X9EeIcNqnt01qJX0DgnCFVk35HUVqTgIsTL
        au+nIxQwwHKwGTj70/IEguuFwMENi3VrRYQGhiBawMQyVuuFbRKdAM0ltGTrzvmC
        ODgple+EkBQYRo1pBIAKIkN+mWWgEMAaUXzqtMjR4QkOxrkSMZaeGopdEu0Z4BfI
        egfE+NZvxetEeA==
X-ME-Sender: <xms:o6yBYdx02j3V5hM6qEwUW_LSz2qgCH2f3I7uVJwGfEU-a0WI8OWKDw>
    <xme:o6yBYdSFx2UlFmTFvNxYqNwqoWu5EFukJEAt7lhcQbu3JUCDdxztWyFfltvuCLxmQ
    kVMTtqdnpgzQYsY_A>
X-ME-Received: <xmr:o6yBYXXLAMc9Vah9MLidSdH8nG81TIvjesn87-Cl4XRhpMntRxwSt1tr-M_ohJWs8RKKmCdasKYc0Ygoc1AjKrP1hr-7OtUMbfoQfxIj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrtddtgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeevhhhrihhs
    thhophhhvgcugghuqdeurhhughhivghruceotghvuhgsrhhughhivghrsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeekjeettefgieetvdekudevudduvddvueet
    lefhieevffehudfhveeutdevgfekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegtvhhusghruhhgihgvrhesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:o6yBYfgq4bwFbAvXz13m8Arlvd4oQXVuLVpCYZYl1-4eyCTltrH6uQ>
    <xmx:o6yBYfDfXaH92WeZKClrxTDWUSxdoEg7frunRwSII-ob3WASPOiqnw>
    <xmx:o6yBYYKVUB46opYDj5ogTKkhfzWt5_dReOGxe8_Pjg6dP9gx9ANWvQ>
    <xmx:o6yBYSP7qkX5OEbn5KXGswXWMm1tP2NbhHlfFN_ysiQWpw_RsZvXYA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Nov 2021 17:24:50 -0400 (EDT)
From:   Christophe Vu-Brugier <cvubrugier@fastmail.fm>
To:     linux-fsdevel@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Christophe Vu-Brugier <christophe.vu-brugier@seagate.com>
Subject: [PATCH 1/4] exfat: simplify is_valid_cluster()
Date:   Tue,  2 Nov 2021 22:23:55 +0100
Message-Id: <20211102212358.3849-2-cvubrugier@fastmail.fm>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211102212358.3849-1-cvubrugier@fastmail.fm>
References: <20211102212358.3849-1-cvubrugier@fastmail.fm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christophe Vu-Brugier <christophe.vu-brugier@seagate.com>

Signed-off-by: Christophe Vu-Brugier <christophe.vu-brugier@seagate.com>
---
 fs/exfat/fatent.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index e949e563443c..81f5fc4a9e60 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -84,9 +84,7 @@ int exfat_ent_set(struct super_block *sb, unsigned int loc,
 static inline bool is_valid_cluster(struct exfat_sb_info *sbi,
 		unsigned int clus)
 {
-	if (clus < EXFAT_FIRST_CLUSTER || sbi->num_clusters <= clus)
-		return false;
-	return true;
+	return EXFAT_FIRST_CLUSTER <= clus && clus < sbi->num_clusters;
 }
 
 int exfat_ent_get(struct super_block *sb, unsigned int loc,
-- 
2.20.1

