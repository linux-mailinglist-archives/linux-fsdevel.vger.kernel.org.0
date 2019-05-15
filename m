Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D37781E650
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 02:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfEOAaG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 20:30:06 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:43805 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726044AbfEOAaG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 20:30:06 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id CCDF8251DB;
        Tue, 14 May 2019 20:30:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 14 May 2019 20:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=q3z4I4gm6Mw+lXsJj
        Da5nhawsrQXblcwi8YUEi0Hioo=; b=M2qu06aapz11eJf9dFDkR3Y/2bM6HB+Fw
        E4nIFtVHWupkNUE/cJnUJQlXVflKVtSjpMNAfvqeqfZ20aeMsKvqK/WG9cbLNy9j
        tQKrK/OrB/jF/ocMthFTOje3K/PqatUPTULewREv0WDn+IFwXofVvBuBMi2m9Zsh
        hBLyOO4qmRsOIN9BSk7Pxgl7BaIhLunPNKUfPRkKPcBbcznZtFft/ddpzrJ2l1Il
        B7NTIA/Kg3OUb47FaU21kLqn1k+aS9NiH2+ATXRk8ljjQ7uef8P3C4OAhRlnB5vq
        oLIyjSeMjfHCRulyn3NTwcV4VkYEDykKB+Atf66jhtYxWn9Dear0w==
X-ME-Sender: <xms:il3bXIKVnGX0OFMlzj72yS4enIZ8VZBbz6bxD6AJt045n56Ca-Fl9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrleejgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhnucev
    rdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkphepud
    dvuddrgeegrddvvdefrddvuddunecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgsihhn
    sehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:il3bXMZLfc105Qj-6yvQ4WrVBAIoMBm6J7oy0nQn2N9WHeuz-z0tFg>
    <xmx:il3bXL3L6uaVf77uMH5hmRy5PwyhDoNv7fJZVSGL9eGFqd7FpiRHWw>
    <xmx:il3bXDvFIsMKHUR8pGmE4MOiDJC_U9XEsq8CJl-UbJjkKr2MWRwJGw>
    <xmx:il3bXMc3ScoLEo--ES8KWZRhgBBR-7GwfLSS8904jjFSlV48I1ZVZQ>
Received: from eros.localdomain (ppp121-44-223-211.bras1.syd2.internode.on.net [121.44.223.211])
        by mail.messagingengine.com (Postfix) with ESMTPA id C075110379;
        Tue, 14 May 2019 20:29:58 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/9] docs: Convert VFS doc to RST
Date:   Wed, 15 May 2019 10:29:04 +1000
Message-Id: <20190515002913.12586-1-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jon,

Here is an updated version of the VFS doc conversion.  This series in no
way represents a final point for the VFS documentation rather it is a
small step towards getting VFS docs updated.  This series does not
update the content of vfs.txt, only does formatting.

Testing: the following produces no new build warnings

	make cleandocs
	make htmldocs 2> pre.stderr

	# apply this patch series

	make cleandocs
	make htmldocs 2> post.stderr
	diff pre.stderr post.stderr
	

thanks,
Tobin.


Tobin C. Harding (9):
  docs: filesystems: vfs: Remove space before tab
  docs: filesystems: vfs: Use uniform space after period.
  docs: filesystems: vfs: Use 72 character column width
  docs: filesystems: vfs: Use uniform spacing around headings
  docs: filesystems: vfs: Use correct initial heading
  docs: filesystems: vfs: Use SPDX identifier
  docs: filesystems: vfs: Fix pre-amble indentation
  docs: filesystems: vfs: Convert spaces to tabs
  docs: filesystems: vfs: Convert vfs.txt to RST

 Documentation/filesystems/index.rst |    1 +
 Documentation/filesystems/vfs.rst   | 1286 +++++++++++++++++++++++++++
 Documentation/filesystems/vfs.txt   | 1264 --------------------------
 3 files changed, 1287 insertions(+), 1264 deletions(-)
 create mode 100644 Documentation/filesystems/vfs.rst
 delete mode 100644 Documentation/filesystems/vfs.txt

-- 
2.21.0

