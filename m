Return-Path: <linux-fsdevel+bounces-72141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF68CDFCD3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Dec 2025 14:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C33533006720
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Dec 2025 13:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F241325708;
	Sat, 27 Dec 2025 12:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IK4hHMTx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF8D325497
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Dec 2025 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766837949; cv=none; b=GmuzheivG1NwS7XDCcvS278KzuwHw2rxfVgySFt17bZ62jPUtvUgKcOE+/XEwkFGI0y/yox2vCuiMp9IDFe99vkEVGibwkC6p+CfH3cZwZmRl1ALoUJic4TAEXT4FYtrE3s0us7iScVtikQ4AmCuAk0/nfkp+kMYC43HLtFM2U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766837949; c=relaxed/simple;
	bh=8apb8xIF3Rmf3METSNa3/bIFoDSqesuSeq+cEdBJRMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pxAJ5AKnCpMxYsvFr3CoF1pgAhBbeEQbGLTMC/hJJ9RbndygqcCHh1oRUmnw9919GV2i+IdJ8ON49g7MjgUqni0wYNbie6+hdM6S6rGDn9/dVHBEEaURXUA8z8evj6cYOYkNomoGO3rcala5D2LWZ5DFf25Uit0v4WYjcR3Vx2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IK4hHMTx; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso75774565e9.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Dec 2025 04:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837946; x=1767442746; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Svns8VRTDcd692NVX/iQ+u99f8RURxgaz6jdCSTwtGo=;
        b=IK4hHMTxQZN+K4bQhW0fepSmAP/QVgftfR+ZUPpZ/0G2gwdQnljjDVicoSp9/0KZWx
         GSPsjwlyN2uVRn2ogT9F6x/mFiZrZ9zrr+Zru7FCDEl9TCt5NSz9/nRgdUatKpPQbc18
         w8+DGa9R7LG1s/QKlVTlG1DvI8SwmzD6F5gUQbEMvYr/d1nR+sEyRs5ISsvy5bMkVoVH
         1tKbAaxi61tbt2xvGobRRQ8Gfcikvphyu1EqC5FB1utqeOwiu64Ay4IFtCIhvHAx087c
         CNTlZkYB70XDcGBovpyDOMFtcaVqycVugOUUtvtQxR1M152RYO6iQ85diOFOQcFvSWha
         bfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837946; x=1767442746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Svns8VRTDcd692NVX/iQ+u99f8RURxgaz6jdCSTwtGo=;
        b=wSccLG99C/dPWerjdhTJ90Ujt2f9bLmoqiS055mpfRM9EVlVhI7qPrtbiX4w5w5ko0
         FDNzndeUHF8+R7MGmAWYW+VSj9izzCPWjbQ7xoqMjbtIFVplbM9wbk5OySX4GaV6DK/J
         l7qqVs0dEelsNqdoDeRG8KTp1+JAlrmL+iOjg52MgOJqqzSsRjHSqm9SzaTWIIaz3bpF
         FIB6eOr5AZ/qbvMGfSYxHAY3603Ok9ETZ+eZOlm6LK3lEULgTFduDwvOzymUSf87xkNX
         SmfQ30GU5IrQeBL4c/4HfGSWv0HCkViwdF+7sKN5ErXmCK5OHaY4/7oL9beVTwjh8J8o
         hDhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbgIoIKxViA0RPvimnY+S+BzuJRCfBXMyqrMU3UsCLJIYgQBcEmQNrK5BbQTWIYR5DxJJ/cTj2GD9oV3VR@vger.kernel.org
X-Gm-Message-State: AOJu0YxRxui5eMGaSj5Z9wvXNo9n7OE2NFk/DI33bxvUwUaZFkq0L1ci
	jTv2tsxiONtFTET0yVnFZ/ERSGmkADf/7mpU5v1IbzLIFYXB4ViqebAYPUDV0dYpKp4=
X-Gm-Gg: AY/fxX5kme/qN6r+G1Ik/apHda7DMhs5n+vq4Ax3xrteVV+FqawnJx+naJ8oPdFeH6R
	L6JkPjueBLu8UcZKVTwpWxUtwjzR8iysb0KHWYwhqc3DSU1T6bu7KL9ClagwJHCq9DvWpOMOIcN
	//eaBMtb+JumAd7oe1JhJJGjZ5jwYMXMtmG/3nm9wjngnxUa1eMuhyGczyU2B3ML9TtCTpvZw3C
	SmPvdSzD+XoPIScK94MYJFPswkr4L3hqLmA8zH3UOho6VtM3kaJiJWuPZHo35WjZo1+nmawEIcc
	Yxv30vXzoMyV0kI8ObDwuDIYu1xdyzwM862bsD0OV3P0bA+dfcHvznW2nwNXWnW/ojUDoMS8BmZ
	xZgsXRcYFc2gPgfrSWPGCsd4l7IqQNEFOyHrPAHCymfYusPt24RZL6HZi6rs321s2rKkTypMYRQ
	YvZyEIKTx4
X-Google-Smtp-Source: AGHT+IFQPHp9+ZXnfJ9gaFXvmbmtROboeRiL3XR0blYfmQMI8wXzbSWqjXdBS1sjkb/JteTKHl2ZOA==
X-Received: by 2002:a05:600c:5303:b0:479:3a86:dc1a with SMTP id 5b1f17b1804b1-47d195c2d7fmr223567305e9.36.1766837946357;
        Sat, 27 Dec 2025 04:19:06 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:19:05 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:22 -0300
Subject: [PATCH 15/19] drivers: tty: serial: mux.c: Migrate to
 register_console_force helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-15-21a291bcf197@suse.com>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
In-Reply-To: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, 
 netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 sparclinux@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=1068;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=8apb8xIF3Rmf3METSNa3/bIFoDSqesuSeq+cEdBJRMg=;
 b=SOQn5veC0enOSDBgUA8xgjFU36YeIU5ltm01mWbteI/FsjC7wSIvDCGkCl9Jt9bptuqtwUiUT
 XJt5OJVOiy0DmhgN+BFidqaWmVu/I5CuRGxAmhAzWOivaZFVrPO2ZNN
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The register_console_force function was introduced to register consoles
even on the presence of default consoles, replacing the CON_ENABLE flag
that was forcing the same behavior.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 drivers/tty/serial/mux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index b417faead20f..5a2d706b9cbc 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -390,7 +390,7 @@ static struct console mux_console = {
 	.write =	mux_console_write,
 	.device =	uart_console_device,
 	.setup =	mux_console_setup,
-	.flags =	CON_ENABLED | CON_PRINTBUFFER,
+	.flags =	CON_PRINTBUFFER,
 	.index =	0,
 	.data =		&mux_driver,
 };
@@ -547,7 +547,7 @@ static int __init mux_init(void)
 		mod_timer(&mux_timer, jiffies + MUX_POLL_DELAY);
 
 #ifdef CONFIG_SERIAL_MUX_CONSOLE
-	        register_console(&mux_console);
+		register_console_force(&mux_console);
 #endif
 	}
 

-- 
2.52.0


