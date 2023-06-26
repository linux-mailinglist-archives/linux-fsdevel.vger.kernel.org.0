Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DAF73DEC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 14:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjFZMTe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 08:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjFZMT2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:19:28 -0400
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E32210DB;
        Mon, 26 Jun 2023 05:19:03 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-8d-64997d6d8ce5
From:   Byungchul Park <byungchul@sk.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel_team@skhynix.com, torvalds@linux-foundation.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, will@kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org, joel@joelfernandes.org,
        sashal@kernel.org, daniel.vetter@ffwll.ch, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jlayton@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
        boqun.feng@gmail.com, longman@redhat.com, hdanton@sina.com,
        her0gyugyu@gmail.com
Subject: [PATCH v10 15/25] locking/lockdep, cpu/hotplus: Use a weaker annotation in AP thread
Date:   Mon, 26 Jun 2023 20:56:50 +0900
Message-Id: <20230626115700.13873-16-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230626115700.13873-1-byungchul@sk.com>
References: <20230626115700.13873-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTH9zz33ueWaslNJXp1Zm51RoOK1ag5RiKaLPFmyZJlhC+yRRt6
        lUaoWCyKhqUqGiigokIVO4ViagOdYOGDAlVW5G2ooDSsw4pCDAgUcbhWK+1m68uXk1/O/5zf
        +XIklPwOs0ii0R4QdVpVhoJIaenU3KrVmXkX1UrbmzgoLVaC/98CGsx1dgJ912sR2BuPYhhv
        3w5/BXwIZu/3UmAq60NQNfyEgsaOIQRO2zEC/c9jwe2fJtBdVkTgeHUdgYeTIQze8rMYah0/
        QM8ZC4bW4BgNpnECl0zHcaS8wBC01rBgNSyDEVsFC6HhtdA9NMCAc3AlXLzsJdDi7Kah4+YI
        hv4mM4Eh+/8M9HR00dBXWsLA7y8tBCYDVgqs/mkWHrVWYqjPj4gmQk4MJ1//x0BnSWuErt7A
        4P67GcHtgmcYHPYBAm1+H4YGRxkF7661Ixg5NcXCieIgC5eOnkJQdKKcht5wJwP53g0w+9ZM
        tm4W2nzTlJDfcFBwBipp4U8LL9yqeMIK+bcHWaHSoRcabPFCdcs4Fqpm/IzgqCkkgmPmLCsY
        p9xY8A60EOHlgwes0HVhlv5x8Q5polrM0OSIujVbdknTX7UP4qxr7KGwOcGASogRxUh4bj1v
        sPvwZ26rcNFRJtxy3uMJUlGO477mG0pGGSOSSiiueg4/1nWXjQbzuF/40fs+Jso0t4xvailC
        UZZxG/nCc12fDizha+tbP4hiIv3me5YPM3JuA3/M6yJRKc+di+F/c5WjjwsL+T9sHvoMklWi
        L2qQXKPNyVRpMtYnpOdqNYcS0vZlOlDkrax5odSbaKYv2YU4CVLMlSm/uqCWM6qc7NxMF+Il
        lCJONv+tSS2XqVW5h0Xdvp06fYaY7UJfSmjFAtm6wEG1nNujOiDuFcUsUfc5xZKYRQZU+s33
        yjJr1sbhTVcC4TnfWU7vPnkrLTRuTk2ZMJ4u3uv2bDMc6Uku+FlUvqCNrrsLtieG9fH39gd3
        Tsbqu62rDEkDLq2J+ydnzJk66EtOG1GcT1/Ko23OxM7Nz8p72zRuyrPisSPWHU5ptPz67ePV
        o/39q14lpWRJO56aC9bof1LQ2emqtfGULlv1HnZDSDxSAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0wTaRSG/b6Z+WYYrZntIs5iVNIEbxsRsqBnlaj/nGhU3MSsa9Sl2U6k
        0iLbIsImGoRiEKwRDXKxmnJJIcCuWDRRpKRp5SaiKIgItSoxKoJ0g5aI4KU1+ufkyfu+eX4d
        jlKWM+GcNiVNNqSodSrC0/y2dTkrdUdKNdFPu9ZA4clo8L/Lo8FyqZ5Az391COqvHMMw0roJ
        Hk6OIZjuvktBcVEPgvJnjym40uZF4KjJJtD7fC70+X0EOosKCORUXiJwb3QGg+fcGQx19q3Q
        dboCg3PqJQ3FIwTOF+fgwHmFYcpWy4ItKxKGa8pYmHkWA53efgbcFzoZcAz+DKUXPQSaHZ00
        tF0bxtDbZCHgrf/MQFdbBw09hWYG/h2vIDA6aaPA5vexcN9pxdBgCthezzgwHH/7iYF2szNA
        VZcx9D26gaAl7ykGe30/Abd/DEOjvYiCD9WtCIZPvWEh9+QUC+ePnUJQkHuOhrsf2xkweeJg
        +r2FbIyX3GM+SjI1HpYck1ZaulUhStfLHrOSqWWQlaz2Q1JjzQqpsnkES+UTfkay154gkn3i
        DCvlv+nDkqe/mUjjd+6wUkfJNJ2wcDcfr5F12nTZsGp9Ip/0f+sgTq1mMz5aorKQmeSjEE4U
        YkV3mYsOMhGWigMDU1SQQ4UIsdH8gslHPEcJlbPFlx032WDxo7BXfNE9xgSZFiLFpuYCFGSF
        sFo8cbbjm3SxWNfg/CoKCeQ3bld83SiFODHb4yKnEW9Fs2pRqDYlXa/W6uKijMlJmSnajKi/
        DurtKPA4tiMzhdfQu95NLiRwSDVHEb2oRKNk1OnGTL0LiRylClWEvS/WKBUadeY/suHgn4ZD
        OtnoQgs4WjVfsfl3OVEp7FenycmynCobvreYCwnPQtl5Dd7hCc8eH47cubo6Iz831qVur3vS
        WvYTN17irvo1jt9iOmzOu3Uhmd8neq87x807IkZTE/j9P2zfsX3ZhrXhYV7Hk6HZaB7auU1s
        8nXrN3hT52r7jg798iA6Yf7f5Qn6q4548/IlEW2/LaVjLeELHgwd+KMqrdSqjdk1p3dtg4o2
        JqljVlAGo/oLfVzQwzQDAAA=
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

cb92173d1f0 ("locking/lockdep, cpu/hotplug: Annotate AP thread") was
introduced to make lockdep_assert_cpus_held() work in AP thread.

However, the annotation is too strong for that purpose. We don't have to
use more than try lock annotation for that.

Furthermore, now that Dept was introduced, false positive alarms was
reported by that. Replaced it with try lock annotation.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 kernel/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6c0a92ca6bb5..6a9b9c3d90a1 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -356,7 +356,7 @@ int lockdep_is_cpus_held(void)
 
 static void lockdep_acquire_cpus_lock(void)
 {
-	rwsem_acquire(&cpu_hotplug_lock.dep_map, 0, 0, _THIS_IP_);
+	rwsem_acquire(&cpu_hotplug_lock.dep_map, 0, 1, _THIS_IP_);
 }
 
 static void lockdep_release_cpus_lock(void)
-- 
2.17.1

