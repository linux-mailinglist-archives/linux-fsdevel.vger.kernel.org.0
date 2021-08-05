Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636DA3E0B12
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 02:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbhHEAE6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 20:04:58 -0400
Received: from sonic304-25.consmr.mail.gq1.yahoo.com ([98.137.68.206]:39189
        "EHLO sonic304-25.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229991AbhHEAE5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 20:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1628121883; bh=Px8nlLLH6Ndx1EN/tjAFhxnmFATVGBm9MtGprGQu7l8=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=klz2LRcMmTQ+82Cewoijf4xcyROAAd/q5TtybEGGXkrTE9QbyvzCvTz7KQVa78atK0C8Usl0n2JwjC8wt7I4PV4YSVgRrRFaCLpKcgrsH8pTdisVEK96Dp5w9+Op0eqnd8Rl02CcAdiEGNbmI3HjhqY8jZaH6gl9Ud6xCkpf52jPBDoshUaYFH6qfhpZCEc6N58gg/+ID8LQCB3+jlU1l4h+cLhA0ZA3hTHHxvISgbmShLIsswtv+zuCl2sA00y+ijM19TE3HotofBtCipoyUk6MJ8zuBayldswWEw6XzLGKRT/duJ+lulqFeUi6OXHgtGL7IVQH3UcQtBGzRGWutQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1628121883; bh=4bVZhNLThSBycdrdTcCuPlk2Xule4gNTmLRVIugiHx1=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=uiM9X9SNbs6/dM8+4iGoP7sUAr2dhBrEl3cmqMU2fzxHCiFULDuhmPv/W3cXVBveyjNhXphztxcBtQ5fSles5LopszMxfDzObTnRJGh7obR2bFSK5DTcqyk+v2X4FblnhVa1dCDLVfGyvO+n9yAw2v1Z5Pgwhi0z69dngeZNAXKw5T6MvDABz1DwehTnYPLBzfpD1HoePn6GNKGX+374G7jHQL5vImV8cgLiPVTORogtUMIn++4fr+QvyCjqXPJLRAhCxJf6p+EgDJLk2GD4fL0PU0psj2eE8cOzd/mzZPco1Jep8fCMpfu1N46TnDxiavGpeFxfPh1v3ErMQDXj2w==
X-YMail-OSG: Ut64WiMVM1mxv7Orgh0IVRL93eKlPeW1mj6CJ6RV1o23dUlgWRdU8_33C1V9mFU
 tDYZJ52_8vck6CJbNruXSNzdQCF361C8OMpdawxru51wZPBSinVyil1oCa_YxvFJIZi3RnYy0IwC
 d_B_INsS7t6MIoInpZvvLMWcHQHj2sGFqdg.rDRoKGmeiDLdBJduR91hphmJcSkOOM3KvdvAhu1Q
 bywDg..J62C9A_zxtixya5mtSIuLEJ6q1fzivVP4SHNkMadJImKq4YzHbKIQ2QQJtXSVQjOYymhP
 zMnM4aMdfqHh2D_hLx_lf5FuGo6j_Y_I4Ljd8sXI8VQb1VSotHAz5n7MHhDaVWHBZlNNg2cxRsFu
 AXfX1N.z.DzYUhCvgBNEIgAq0OS4S_cZqKZ0guhxTmX1bqBDWx0CtL5bHlp5WXVe0QrzNqYA0_bt
 eUxVhBNSidXQlpMQZLKp79C3cVfrCFrrQV0fb_46lBovIpFk5l9CyBcv2_xn8Ms7hEZzxQ6NQ0Fe
 mHxkHaol0BeNV24uQ.nlOsI_QvCa9bHU7GwXTMu1zzSqFW9Cbb536qzMeu8aOd8fevqArW9JIOOH
 uJa.ggvW1kWEueRnRBDdexPQaatDxiCe6Mp.I3csaQbitvJsTpkSWGXnJNVWyTPe8QuKUvGFuTjm
 dw_UNolrhrJEWVWlhxunBnY0w5y8AiyKIKpXEA3qi0CUUTLJcCLnuyOgaq.4dv072cohuhmORUTH
 p8C4BG3SmkeJckEml4m30D6incpJcYTq.UT_HhtUDZsD6j2TGivFEXpjLAZBqVnoae9iIDkfkPH0
 zYyZlsTcqMHkcJLJEd6ny5zIMoIXRWKlfhMKInTIjihieKFVR49SstJ1zAlpDnwpKzFStO_Rf_9B
 NG1GUwdzgrv1cRbDr4UvaCglrZkzkg885KorkkU4tLnmsY.SVqQaTaLS.nsH7GdqeRjY0CW_p06k
 YltU_nFhbIW.xwwdbsJV64ZLRm1djnAMkoAIErbrDq1.0rNYfVPzMLFiwIO1hAzf91_M67JTYLFc
 1_IxBhEkPqGXkkFBcwBXDzHJ4GzEGAH3UNRMnpWAAz1UmRArgQ_sisO.ifEY0RqlEpPLo9DQVYJW
 XyN_PRENxsUMQSuoEdwepGG9Axx0HsxT08qAi8oh7rQcQN1K8T2SOvgstJ6kyiQj9ClNCcV5kt6p
 zFT49SRoXv1Cj.yfR4O78WQ6_xYUctfKWLng8of_L5OR24WlVNYHahxyH7ar6S9NWh.a1bVrgh0G
 SYXR940ajd8AiimHVAPp2QkNYAd_RwmLrJz66_CU7.b6YKY4wYE7Rf0hhfW81WAI38tKslTXzH4Y
 af44tGtzsPW7U8Dh_R18i0QaYUZ1UeT4wYT3.EPJyUPNQ9sj01dB0muvfVEoxCoZVleZk0PcAmC.
 22z9AeckmGcnfB2AU..GHyggKnhgQfExtnMf4I.sRhXMFI08VaFT6taLQAijvs6.1T8jKHvTfbq6
 P2wszjsYGIoxeQoh4GEuveg6nqAfqpeH.iFspGXTM_A4EVeWUC6NsB5oJoMFWbzz8j2kra1cPAkK
 0agJ0gh_0w0D_5yLw17dvRcMWT6IeIAVvq_liSP3JCELoTpScQoRp6C8I.ym_HCBj0vmckfEFcY8
 pxHWOL_hIoOWnpES3Tc6lYp29.lo8DfSt6ftITUXNStxuok1KsNzDEHJFLNYJudCM1ScVcXQQoPJ
 1KU2gtGH_XhXMvQM92K6fE.CJJrpSRqsMpSkReeR5x8mj8V4Hgx5gJIIFXCZIS4ujkSbs7TaZ1RS
 R5PJBCDZW3pMytqlBx4IaayXBnO9nyUTR1jCF1m_mMiwk1pKYS8dxckAGP7T6q4vNHa4I2L92pZM
 DaPpiM5aeBaj7DLxmm1cSuhCODDb3GBngqj5JoOyOIrhdkrPZ5QKSYoHplgcC9_dhvXcYy32oN0W
 LS.Ufdp5vwc5X.bxDKNpBzaqlvKtyxhnxv5okvVr8yyH77n0QCdmXyI1ky7oo9ygg_4tPjx8I1MI
 6PswxJZ0kea5m923Sj7omdMb3iZlWK6RXwJoXlqIhS0OEMjRE1kA7ZlPi9DQ7Ps1GkGXNmNE898Q
 vW8TxqMBVaLsf8Q3sFBdp1vX6RwjPRz_MHxgo_lkCY9xr4pvUFJVAU4W5dNJHTcXD1BhUWBIvgfN
 XUU1eXk_bSAGMy5f04o.SnLRTkToW9R7c3x_.Po4lUCh3YzfiiW5n6WCFRi7ZhP1Pm2vCLglSOX8
 tTSzPoRozgl7XfGSWfbxg7mP3eIgROUXIEtn4VZrmiPRhkY9NaylzB6lXWlJPaa3aY2F29uvFcqS
 YCHqQxruucBGxGWsG3HFb2Puuhv9XbnmC9yzzsErTBmHQZP.onvrXOqZ4T6IOuD_MgsR9FNl5Nl5
 v6Dnhp2SY8afnWRJonMbTGOgRgksCYw7hjdb68CvdkqaTaDK37XLHomWuQBNU5d1FDNtqOGoTx6a
 hgPm3ybxX3BGbeK9K6L_yVyhqqWWmLodV5tGZD9XjFHpgvLJB5QjoMkqFQdqiZ9ZAwZqrBv2_u1k
 76e6pJZl_UyxsCp4jpwLpoh_tLzn6ERtwIywsK9GEGcCiyZqhdyBXr194L5qo9hPLiNeTjGbOhYa
 bBrrupqlOltyGyRatp11LETCJXv9Cf7_XHhPKWlN6cNiP1Rmbf4G7n_.MTJuKT7cy9_Cyv9WRtmg
 rjTfV.Z8akF.xlmiIql7TsziNJ_YCKl3Lgy7H4T2Wv1ab.GPwb21SqbfiSSrap2Hh.RspK5QpJ48
 eTIhqkWX_DzsX.3rdjitnezWHcnnxUDmO.Fn0EAZ358qandFyVjjt.7APiL0Qgbn9IWzcNRWj9V1
 ou5aQN.j0m8Aw8JblbA48b9P_0cf6OrAqWRyCzEu6PpTQZaAY7AHybr0hCnDYfOXGKCHQPnBcCjd
 mSIFk5wBHCbz1l.N55X786GMaEgkga7GsxMUkhqiAmlQ3r8GCUuTG5OBGnwVRKJJnSHKxfceYCOw
 oyOmHcwqC4W4G3SSIAmOWWPyDZFLiwo3iYfZEnQXYcUWlXFKR9MEsbkXBphruKZtlUQrB0hD_wyz
 9kFxrU2THEJ3d5sAm7Qd3Z4TwfBVaL_eFelZRwAurT1rzvjnCf6QXY0eoxoyKupoTYA4bFfFSTgC
 j0ENR63K8S2Rxj2DepVTBDbiJnFx4jwA9eW1HCOTiQO5RD2KkKRo4UwSXpjj5Z.ZiUmZrq9pipqq
 jETPnhXOCjQTpHWcpC8iuJg6Z3x9WAUISsbgpY08iemm65HSVVdtcWmlkFgU6YttO.6XWo9fHVAv
 ycho0t8VQX6HYE1_8kO.FZLAt4aBvqL09FXpZX1SU
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.gq1.yahoo.com with HTTP; Thu, 5 Aug 2021 00:04:43 +0000
Received: by kubenode542.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 7a8253fde8c36a750343d2fbeabffa3e;
          Thu, 05 Aug 2021 00:04:38 +0000 (UTC)
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
To:     torvalds@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.or, dhowells@redhat.com,
        linux@rasmusvillemoes.dk, gregkh@linuxfoundation.org,
        peterz@infradead.org, nicolas.dichtel@6wind.com, raven@themaw.net,
        christian@brauner.io, "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: [PATCH] pipe: increase minimum default pipe size to 2 pages
Date:   Wed,  4 Aug 2021 20:04:35 -0400
Message-Id: <20210805000435.10833-1-alex_y_xu@yahoo.ca>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20210805000435.10833-1-alex_y_xu.ref@yahoo.ca>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Before this patch, the following program prints 4096 and hangs.
Afterwards, it prints 8192 and exits successfully. Note that you may
need to increase your RLIMIT_NOFILE before running the program.

int main() {
    int pipefd[2];
    for (int i = 0; i < 1025; i++)
        if (pipe(pipefd) == -1)
            return 1;
    size_t bufsz = fcntl(pipefd[1], F_GETPIPE_SZ);
    printf("%zd\n", bufsz);
    char *buf = calloc(bufsz, 1);
    write(pipefd[1], buf, bufsz);
    read(pipefd[0], buf, bufsz-1);
    write(pipefd[1], buf, 1);
}

Signed-off-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
---

See discussion at https://lore.kernel.org/lkml/1628086770.5rn8p04n6j.none@localhost/.

 fs/pipe.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 9ef4231cce61..8e6ef62aeb1c 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -31,6 +31,21 @@
 
 #include "internal.h"
 
+/*
+ * New pipe buffers will be restricted to this size while the user is exceeding
+ * their pipe buffer quota. The general pipe use case needs at least two
+ * buffers: one for data yet to be read, and one for new data. If this is less
+ * than two, then a write to a non-empty pipe may block even if the pipe is not
+ * full. This can occur with GNU make jobserver or similar uses of pipes as
+ * semaphores: multiple processes may be waiting to write tokens back to the
+ * pipe before reading tokens: https://lore.kernel.org/lkml/1628086770.5rn8p04n6j.none@localhost/.
+ *
+ * Users can reduce their pipe buffers with F_SETPIPE_SZ below this at their
+ * own risk, namely: pipe writes to non-full pipes may block until the pipe is
+ * emptied.
+ */
+#define PIPE_MIN_DEF_BUFFERS 2
+
 /*
  * The max size that a non-root user is allowed to grow the pipe. Can
  * be set by root in /proc/sys/fs/pipe-max-size
@@ -781,8 +796,8 @@ struct pipe_inode_info *alloc_pipe_info(void)
 	user_bufs = account_pipe_buffers(user, 0, pipe_bufs);
 
 	if (too_many_pipe_buffers_soft(user_bufs) && pipe_is_unprivileged_user()) {
-		user_bufs = account_pipe_buffers(user, pipe_bufs, 1);
-		pipe_bufs = 1;
+		user_bufs = account_pipe_buffers(user, pipe_bufs, PIPE_MIN_DEF_BUFFERS);
+		pipe_bufs = PIPE_MIN_DEF_BUFFERS;
 	}
 
 	if (too_many_pipe_buffers_hard(user_bufs) && pipe_is_unprivileged_user())
-- 
2.32.0

