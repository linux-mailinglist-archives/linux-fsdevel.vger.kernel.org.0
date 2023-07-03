Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C421A7458F9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 11:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjGCJuC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 05:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjGCJtx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:49:53 -0400
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 450B11B4;
        Mon,  3 Jul 2023 02:49:50 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-c7-64a299b31a63
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
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
        boqun.feng@gmail.com, longman@redhat.com, hdanton@sina.com,
        her0gyugyu@gmail.com
Subject: [PATCH v10 rebased on v6.4 15/25] locking/lockdep, cpu/hotplus: Use a weaker annotation in AP thread
Date:   Mon,  3 Jul 2023 18:47:42 +0900
Message-Id: <20230703094752.79269-16-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230703094752.79269-1-byungchul@sk.com>
References: <20230703094752.79269-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxiG977nnPecVstOKtuO8GOmC1ExIi66PDFmIdmSnS0xMfGPw2Ta
        rCejSkGLFtlHhit+lUKACB20uFKW0rRVpMVEhpAKEUSDVCRYK54Ic04CCGEWrYDaYvbnyZX7
        yX39ujlK3cGkcfqCo5KxQJuvIUpaObO6aXOw3qXLDg3uhGprNsSen6HB0eonEL7oQ+BvP4Fh
        8vpXcG9hGsHi4BAFttowgqbxhxS098kIujy/Ebj7OAVGYrMEBmrLCZibWwncmVrCMFZXg8EX
        2AW3qlwYQvF/abBNErDbzDhxnmKIu70suEszYMLTwMLS+FYYkEcZ6IpugvrzYwSudg3Q0Hdl
        AsPdvxwEZP8bBm713aAhXF3BwIVnLgJTC24K3LFZFoZDTgyXyhKiU/+9ZqC/IoTh1J9tGEbu
        dyLoPvMIQ8A/SqA3No0hGKil4FXLdQQTlTMsnLTGWbCfqERQfrKOhqHlfgbKxrbD4ksHydkh
        9k7PUmJZsFjsWnDS4k2XIHY0PGTFsu4oKzoDx8SgJ1NsvjqJxab5GCMGvGeJGJivYUXLzAgW
        n92+zYo3fl+kxccjNrw7PVe5Uyfl602SccvnB5R55+4v48Mt7PG5v+1sKaogFqTgBH6bMHth
        nLUgboV9tRnJmPDrhUgkTiU5lV8nBCueMBak5Cj+9CrBMze40l3DG4TuHplNMs1nCJGhy3TS
        o+I/E2Rr8Tv9x4LvUmjFo0jE/7ysRElW89uFsXqZJJ0Cb1MInc9b6HeFtcI1T4SuQiones+L
        1PoCk0Grz9+WlVdSoD+e9X2hIYASg3L/srTvCpoP7+lBPIc0q1WRn5p0akZrKiox9CCBozSp
        KvP4Hzq1Sqct+VEyFu43HsuXinpQOkdrPlJ9ulCsU/M/aI9KhyTpsGT8/4s5RVopMqTlmuJr
        yZeJfSJriRMrvrP79fIna6yNc42p/aacnO4tv0r727znpuOtma/C5lyU5Z4x762L2pt7L0fT
        czsf1ES+FvZ0TA0PV73/hepnOdr25MNIzr3O0UJux67MNy5HytN9siPF98GEu/Hshm+WU1+0
        H2l4UV3uvWjZmH3wWw1dlKfdmkkZi7RvAbLwAENMAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTVxzGd86999xLpdu1ot6oi1sTMuMrGDH/6TTGLx4xM/PDMsdisNqb
        0QDFtFBlZglIdVopAxQRClpgqw2wqbea4EYJQijiW5kQrKY2wpxIADHONnS8OGrilye/PE/y
        +/QIjMbBLREMxlzZZNRlaYmKVe3eXLTGU1WvT6qNJEJZcRKE35xkoeZyM4He35sQNF8rxDDS
        tQMeRsYQTN3zM1BZ0YugbvAJA9d8IQRe9zECfc8+hP7wBIGeitMEihouE/hrdBpD8Fw5hibl
        S7hTWo+hPTrMQuUIAUdlEZ6LFxiirkYeXAWJMOSu5mF6MBl6QgMcdNb2cOB9vAqqLgQJtHp7
        WPC1DGHo+6OGQKj5LQd3fLdY6C2zc/Dby3oCoxEXA67wBA8P2p0YrljnbCf+neWg296O4cQv
        VzH0P/oTQdvJpxiU5gECneExDB6lgoH/LnUhGCoZ5+F4cZQHR2EJgtPHz7Hgn+nmwBpMganJ
        GrJtM+0cm2Co1XOYeiNOlt6ul+iN6ic8tbY95qlTyaMe90ra0DqCad3rMEeVxlOEKq/LeWob
        78f05f37PL11foqlz/or8VfL0lRf6OUsg0U2rdu6X5Vx9tEMPnSJP/LqbwdfgOzEhgRBEjdI
        TRWJNhQnEPEzKRCIMjFOED+RPPbnnA2pBEb8aZ7kfnWPxIYFYrbU1hHiY8yKiVLAf52NedTi
        RilUfDhWS+JyqelK+ztP3Fz9z2QJirFGTJGCVSFSilRO9EEjSjAYLdk6Q1bKWnNmRr7RcGTt
        wZxsBc1dxvXjdFkLetO3owOJAtLGqwNH6/QaTmcx52d3IElgtAnqosGLeo1ar8v/QTblpJvy
        smRzB1oqsNrF6tRv5P0a8Xtdrpwpy4dk0/sVC3FLChD1tu1ar3y6rHyvQXc0krZgZsO6uwdW
        vZ1dfSHV0lKV617jvxmfvzC9c6ez++riYJT2LWrYRSw+33rH7i3eyfmLbGc2/nw7fWCFdbvS
        OuEfNQ+b6/bZk6ozC7+bOrb329T4j2a6lNk91w8Y0j42GEu/9teO5wU+T/71zKac4YKbs3d9
        WtacoUteyZjMuv8Bvvgvmy4DAAA=
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
index f4a2c5845bcb..19076f798b34 100644
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

