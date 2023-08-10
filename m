Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87AF778001
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 20:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbjHJSLN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 14:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjHJSLM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:11:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EFAE48;
        Thu, 10 Aug 2023 11:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691691069; x=1692295869; i=deller@gmx.de;
 bh=r9C155D6FKUWvgMge2Mcch0kcsQsx9RDIo47jzZI5To=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=VuU1HYOlcxFu9yu0A2qHcWjm+taIzgpziGjYqwtvybVejlAl7JsnG76LA2rSpgAEm78MU2C
 G4pmccoPXr8EYWZhk9dnswvEB9HoAP+9Wn1loRKyuvNIKKd3gtFgRdn+js3v944scNliUUhSY
 Mp7N7Z8sonAFHcGsAh4aWkrr+eoper/Vs5vEDxt7yHvFDIllu6xp0FSVWa+dIln/RWV6f4cNw
 cmE4WZeOaElWU41NRsY/wPqfSqs3vtZl0ZAw3Ftgw3ZPHolgpV9V6Xg8DK4LoKDjHfaL0FpxS
 42oT/CJhIz4PNeuhSxP1BDJ8p2aOYUT9GXtUYEvTnhtb6b90529A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.144.133]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrhQC-1pyOCH1QQ8-00nfbr; Thu, 10
 Aug 2023 20:11:09 +0200
From:   Helge Deller <deller@gmx.de>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>
Subject: [PATCH] proc: Mark arch_report_meminfo() extern
Date:   Thu, 10 Aug 2023 20:10:46 +0200
Message-ID: <20230810181046.147812-1-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pw82Gm6tOfkYrickFuRKQF6z2gVlq7BvEaWYxII5IUPH6QN+L4/
 rHrKUItLQoA4vdwlPJFcwE4OwdMMebVUmbreavrw7ZVvxmpgeEajfxvtCA5eqMzsIxIgz+B
 sTnBg+zQawOYXvgZuKy7DD3pjvcL8Q+g40+/WwxW8CQ8Lj0nsWL/go8B5x5XmmhkZ0L1OrR
 +yU5kLrmKg1yVB53ag70A==
UI-OutboundReport: notjunk:1;M01:P0:Yb00O6hs6Pg=;O3eMuvVr9jbQwOQe1mmozxFtxwJ
 83T0VyqlPglG+LXxjW+yZ9yi4W/e+tV0bSb9TA8OtLEVDXq5f9KCZQxiB6MgYaKpwC2WR0ybl
 oR/zU9FaTeNFXvm1UGA8bvTniSvFp/amQOwfsLG9ZWC4qUe0QPJ5gH0pZh3PXPF2Z6f+zB3j6
 Ypwx3lepVz5ZpsEtCmjGNwKnPFMdAfjRmm6QO1AJ+QKUCPaxdlLl8rqm+83MxSl6y1ESSwksE
 OGPQVhi6iLqlzD27ZvBmK9R/RFDZLF2bzyoyXAUYE5RGIzQfCaFdsuIrBmM1kYmiZlOx6oX18
 uSiefx7eb8UuW3ek8+AmvQ8QbpkfMVD7fYf7OtrwMqsCj0PCQ/uysyMpBTHMjUMW5rLQolZvh
 2k3A+NeValopBQJQ5XgKugDlmEYqCylnTi+m3bR4Ez0xlQMsnHG1QJxljxcybbGXUkgfefQRE
 j2ZqHQceLnkmXKdH20lJpe9rQVTNhN7j1vKUO84CWfSZErRWiCzgjOvAif2nseaKDFIjcPMdg
 f0uVVIE2xRtH5o9dJkKVt+QNHjuNTdFm3twNh7OFwDV44Ld1i9TyTIFvv2T5Px6cxWb6Rds2n
 +O2gI/2j1ncztCgLw0pz5M0UFE8+gA+IIqL4R/u8w7j1fSB9SIBqdRGxp2kSCcaW2ePXzM6XW
 IGNcIDvioJz8ZgdhFDYda2ZkKqbZyuzd7G8PLI9EvcZ8Xc8O3tKsXIHwb9gCYXnXvxxEt06eF
 9BPsEZ4VrqIFrf55hlJ4xq4g4cwR1eCFsSWL0at9OmpGR7LQQBayS3NVH7iN9ox+IAP5qqc/b
 dxjIiZr0uENJ9Ii+uu1mnMt9D0s6HfXz7VMzUI7XfRg7iH4hpA3qL3OuHNHofS7BKFkidzNav
 FbTZCTgAv9vHgAiUSd04eJJa+YUDGRcrAVt4Fb6SDWRylN97MaDOH8eT6hcT2OmjcCkqORiyz
 hPiirw==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix this sparse warning:
arch/parisc/kernel/pdt.c:67:6: warning: symbol 'arch_report_meminfo' was n=
ot declared. Should it be static?

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 include/linux/proc_fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 253f2676d93a..e981ef830252 100644
=2D-- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -158,7 +158,7 @@ int proc_pid_arch_status(struct seq_file *m, struct pi=
d_namespace *ns,
 			struct pid *pid, struct task_struct *task);
 #endif /* CONFIG_PROC_PID_ARCH_STATUS */

-void arch_report_meminfo(struct seq_file *m);
+extern void arch_report_meminfo(struct seq_file *m);

 #else /* CONFIG_PROC_FS */

=2D-
2.41.0

