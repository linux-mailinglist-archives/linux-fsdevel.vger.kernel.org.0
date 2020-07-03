Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D78214117
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 23:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgGCVnw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 17:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgGCVnu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:43:50 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9454DC061794;
        Fri,  3 Jul 2020 14:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XgkoY4xveG3VkV8u/FmdfbDCcEsFmWj1mDtzRzE6Cb0=; b=K7vx/R/sSraYOl1w73NtPpHEGc
        dEiuafIPa6nEEOOyhC4Kc8RrPrfeKkDPtsWLWIJUHypVc/fHZ+f53HVF7Me603JAQ5o0fjvxoPDCN
        AKCxAQVRqUA6ME+vNUrawhygb3yEMXMbrfv6xBFb+D52zul+sGS15P8iqTldhAvK0eIe8JWqjFgCI
        aFOVn/OReNbY2enMAbxI9avXPuagwutCMCY+izJNOQN0ve6/uUTotikb5aErhgRqV7fq/Z4RZ77ax
        Qf84sNaEy3Mkm1LnszaEEYfq8LuGNNrTbbbd28k/+sA3reF5Gw+W3DqTXv+LHKyrBA57oBDEDqfYj
        lkljdg8w==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrTTI-0006uZ-4I; Fri, 03 Jul 2020 21:43:48 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Ian Kent <raven@themaw.net>, autofs@vger.kernel.org,
        David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>, linux-fscrypt@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org
Subject: [PATCH 03/10] Documentation: filesystems: configfs: drop doubled word
Date:   Fri,  3 Jul 2020 14:43:18 -0700
Message-Id: <20200703214325.31036-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703214325.31036-1-rdunlap@infradead.org>
References: <20200703214325.31036-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Drop the doubled word "be".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Christoph Hellwig <hch@lst.de>
---
 Documentation/filesystems/configfs.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/filesystems/configfs.rst
+++ linux-next-20200701/Documentation/filesystems/configfs.rst
@@ -226,7 +226,7 @@ filename.  configfs_attribute->ca_mode s
 If an attribute is readable and provides a ->show method, that method will
 be called whenever userspace asks for a read(2) on the attribute.  If an
 attribute is writable and provides a ->store  method, that method will be
-be called whenever userspace asks for a write(2) on the attribute.
+called whenever userspace asks for a write(2) on the attribute.
 
 struct configfs_bin_attribute
 =============================
