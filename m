Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8736500105
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 23:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiDMVSx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 17:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239004AbiDMVSc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:18:32 -0400
Received: from sonic304-25.consmr.mail.gq1.yahoo.com (sonic304-25.consmr.mail.gq1.yahoo.com [98.137.68.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B54993991
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 14:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1649884441; bh=JwDJBXmIBMVPp6KpM4t53S/ZeOI8/fENK+mBdPsfoPc=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=dsXZeNMQBuc4UzrnH1JOlgaOX7BywTSzigWKB4vrBMULuoqjKXv347pehAKTdTOe7Ur3W4fdkioVWHa2bEqsVwb2KVE0ABo667arwr0Hjc2lVueWcGPcpJtan7EEr7kJArdJG9mp5kKi969nnHHTyaFSBuvx639fyeuqZAF9JWQySR40ubAMPWh9oqSrvbrN7QuNn7oMnGYKB5O09tlltviyogpIu4LwRIkAnlkSsMiSVnrN38kt2iIUDmWgnyUSosPUL2hWXAVOQLK+Nw5MdBbLLjAbfqA9evZjw3E0sBimUjC1iIrFK1eMfWPXpX4uPstcm5sdYGI3HdnLMmTmPQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1649884441; bh=4dosHHkJgUtb2ahd4zHwUbhBuCutVzbjsTnpQw47Kys=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=d2V8u0Blp7RPz1X3E9+ezknBPfn9aOKg4N6kqlWNN/WKWBOLXfrnkIuFkR+o33fMsR6C1fnGGIq1O5RI9MBw401lPY4Ibxi2Wxlk9WlNtIh+asm1gUKAHVufSEIWPLO5y51APr5OWUGkO7hZNPlgubtnLNM0lpR/slT7N/no4j+z/nwErTkDuWpqr6g5rtwurlj4ecI40Q9lYKz5ziaNQM6dPQEx7cYF3xy+lwkfTC0y6OdEA/TY5W4t0G52KqDEpw22/dKjQ8VyqvZ+yVDI22c0xCTTW4Dc9j7dzancD5F/IV/lrQn2Am6zbhy54ZF4wbdoCuWQ5i/K+dtWMW/D0g==
X-YMail-OSG: WGuFyh0VM1lyiSCIHjzjPC9AZ37hN2NIFEyWrCvwYHCqWnj6Cl0D9GcF4k9btqK
 sfqSdx1DaydnqrHee6rBE.YyQ4A7uo4ZlZFbHnK.MZrFj6YC.eN_gjzKWpzHJ0je124zmIWNNAfD
 91LL22FnEUqVerc3w2YOh_BmiAD6jUo.GDW.JsDVpVnCmBjdffW279K51Ljyykrw67rx5pWksCby
 Ms4Tol4lDW0b3WoNKcPWDD8KQScf5CJIwnEeDAbjR_3u96amBTJL2nIHSVAMSosbPOLKPLKZz9o0
 9PTLtHnHK5uf8MYU_bOOq5j6AQKdwARBcvhb6BnoWt9SGiGTpHp2jVQ.MZWFtYh8eKIn0Kr7fyxM
 Df0tU_2Dvm110IweNmHz9uiPt703H1pbfUq.KD1f7009rVQSpb0An0hSVGVpMG8R1ZyoK9CcZD8s
 ijsifIL9luJPwECy6AEk3jf9hl6teA0XHbxSbgJ539IWdUzTlzN679GqFT77m_gbQ.dXNyQhOyhb
 r.1jxoa0buT4NIvzGwwHj7cCa7.yfVjR3ee2rCNrh6JJf1ehtDI8G79gjO5IHV_E.yoa56afowL3
 ZdrBWxJ3ft66D6cow.dYMznHwqzh4nvhieEZV_4wPT.IYjrpftDa09KBYK5p6M26z8pvnY9_yGXN
 8diY9qX3HoMjvTtZl_othypPBD5pEpUHx2PGR75WK4CrpfGdWf_TZ5KNiJ7FREyX3AbTtU2jDwdc
 7kB1We.5GjGiYGf_hldNZvEXKknBf3bzAkft9ssvjrb9yShXp3lRuui0wOJDr8wVxhvuzo44Y4yH
 rG4xocCQkl6A9y2eo5R._WagpUayDqrQ1b.1Uacs1unpsfYhSNYj3csnH.FgtNVOIsvzA9gWjsAC
 MIEE4aJCCvhTzGbXVUtSbVagRDzQaL9ddTt0oae0DCG.9KuoUc0ZxQCosgSOZt6b1OWYoLa_sSLY
 LQF4piVmcqmSmM8WYq7aKLGIqF0o209X3NIqz2qFA3QNCBw0gr9ZjqlHwIg2pNkNzq9_rQ0ZAwNr
 tWwTDEGVJ6dtMV02LmGRb3jgnKdM01HapfFnosgy7_76gVA0rkIyvfmM8hF7HzaonQ5Qc8nwVf7D
 V7Gm0.ASkEeVnAzLa9CugtrJUtHmHopyb8GvnaqlPUVgpPmeE4ELSdDUUnTaTve5Rc5KZakLWOSU
 kvTaW6mB1wGJvSqmyCuhTffZosjGv8zLlcCET68Y_dfhyGaRR7F0p1SrUOYUNUPd.SuMsP2lRy32
 DjjXmyp35ZZt7aSMYl3G65L.cG4eAFSK0_O3G_OdKQkOjK8fg9KYEkQ5mtFCcR1tswv07XAB8WsN
 pTBnUrbSfh5j8S4NpDs9IvbT4hKsShBPFHyP4ibtqgMY16MDU5M5d1CXsQlr6QMxzhYdG2omxnCt
 7GIwOKuhFO1xMsp5GfKR4ycc4jU.i_UcSCm05NhJJvfUi5y47UKq97_gkpxwROlZJl0VTKTREATw
 gpx_jtZgm2BZKcYdcT9YBJYaU3fEA9HEbJKYrziXnOFHthFeLMlt35Au4qKNgkdfT3PqFrlPf5fI
 ajz.Nnzht2vOeuManjARZv6Aoxy4ryPYkYBomRgF5nuIo5ihr0IK1T4FbAxDNNUIU6TIfyTvsP.U
 ZfPLbTuQA_CTzaRdmpPkSu6M.ahC2CFnKwGtuyAG2rShBuH2t1dw0M2UFTZ8D8g51y_czYZSmXCs
 SBB5FNmyVGGETU1LjW12LtBE6XgPB9n.bg75Kde9Wm9Zi_UfeA7_Cg3QvQFD_oXtUlh6xCG2r0rT
 y8soGny57gSH5C6PWqFVzD6Ly5v7HezWkBB0qf0oahnmOAip1xq7q_czpEuGV.y.EhHJJbN2JJhP
 et_JmF9zYdfb8.77Rd3.hOWbwrN3VaIBphluYzbmp24mFMoQ0MgM0QAG8ygNxVNtscBlwWpM13NH
 fltlfWGCPTQJZs8jLL0HQEak1sS.fng29i0IbZ0ZfHlMCZa8gbCIrFSAm87ucvH528CqfbZjGzk0
 YdhALh_eJ_del9NdsFPLcdZVwyBXo5ktfVptZaYLp6q.fHybvQv5nDFvqXgVmI9TvobufVV2D5Ua
 J33donMac2X7RqIKs2ZhaWjSDrEEfNw7U77qWAAPzgCT3WBDT6gtN2ND7rCJlj8ikFxwe_ucfmM7
 vl0zVcClSZVmR0g2f_KG7pXfne8f1pF8oWY.XSGCdl9Vuujcgl4szGCcl7qaGVWc9uHjINA6eRfz
 LrPlT7cqBx6jG2wHksFCIjAjm4.OGnJqBe93wmTYTN8UyNhsnC2MuP.uZr34DbXUqO5sHiEKQzQ0
 G
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.gq1.yahoo.com with HTTP; Wed, 13 Apr 2022 21:14:01 +0000
Received: by hermes--canary-production-ne1-855b9c5d98-txrl8 (VZM Hermes SMTP Server) with ESMTPA ID 574483ab8d8a5f0795b3659afa4a2172;
          Wed, 13 Apr 2022 21:13:59 +0000 (UTC)
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Daniel Colascione <dancol@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-api@vger.kernel.org, "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: [PATCH] mm/smaps_rollup: return empty file for kthreads instead of ESRCH
Date:   Wed, 13 Apr 2022 17:13:57 -0400
Message-Id: <20220413211357.26938-1-alex_y_xu@yahoo.ca>
X-Mailer: git-send-email 2.35.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20220413211357.26938-1-alex_y_xu.ref@yahoo.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This restores the behavior prior to 258f669e7e88 ("mm:
/proc/pid/smaps_rollup: convert to single value seq_file"), making it
once again consistent with maps and smaps, and allowing patterns like
awk '$1=="Anonymous:"{x+=$2}END{print x}' /proc/*/smaps_rollup to work.
Searching all Debian packages for "smaps_rollup" did not find any
programs which would be affected by this change.

Fixes: 258f669e7e88 ("mm: /proc/pid/smaps_rollup: convert to single value seq_file")

Signed-off-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
---
 fs/proc/task_mmu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index f46060eb91b5..d7de4584a271 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -883,10 +883,8 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 		return -ESRCH;
 
 	mm = priv->mm;
-	if (!mm || !mmget_not_zero(mm)) {
-		ret = -ESRCH;
+	if (!mm || !mmget_not_zero(mm))
 		goto out_put_task;
-	}
 
 	memset(&mss, 0, sizeof(mss));
 
-- 
2.35.2

