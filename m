Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD8AFF80FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 21:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfKKURl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 15:17:41 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:42367 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfKKURD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:17:03 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MiJdI-1i0zpq2YCs-00fOE5; Mon, 11 Nov 2019 21:16:52 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     y2038@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 19/19] nfsd: remove nfs4_reset_lease() declarations
Date:   Mon, 11 Nov 2019 21:16:39 +0100
Message-Id: <20191111201639.2240623-20-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191111201639.2240623-1-arnd@arndb.de>
References: <20191111201639.2240623-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iafSuqH4Bp5e/AWz4sqAojsBIoYJnl02pkxascDjDPERrJsK5XY
 LuEVM2fqvh7m8JQnJKf732b2ymBeNnsygXViheIEE3f6FrCguecj23HqhwZRfpUdu80LURB
 gckupp9jrTa2thabVPppYnnMb8tsb6lU4wvWKhYMJg5DALwIuE3EC/1jiQkFqODqYrE958R
 YtJs0Lv6+joejC+leu3ZQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xGriYet1jFg=:/7jxH/nP273V1JjwioFy5f
 weSwzG82+77qaVH+KI7EcZrjwsUGhIVamdtpqMdnbCs36cuBxpsagITBnkyJngB6ZGKtZ/1kk
 lXrvwbV4AXeKGg1GnNOXhTM0GP4rP7rfBY7mEfeqiu9upppe0mKPZTlIVcip841Qcqx3Ma0nn
 vePqUtm2Y7a2NU1NHIeBQemiMDkQfV/Z+tCobAE2xfIsTLpi99QRU0FZnGbg7fldgd2XWy8V0
 JpwSqlZKos7f1wWwb7VgMYAHaLisxIzb3JX81eFVmTLbX0uNKMD0voZNZ+cWheh3i+HJaqbsF
 tKIOQ0ll6Y+Q6hndX7mZWCQdVFUeLAMDBSBgoLUs1nbH5a0xdOX7a6gz6ItLyU+BqP4KXH2DV
 rDFIpKRqnZqWvvYTdVqLx23v++HLYTnOu8E7My6GxofEUC3ePXcYWIRR8hp65uR15AdFRV/MS
 CLPyY0OiYkmJh7SU8TaQNza5iokt60ZZfr/rVVCv827HunPlTwtGV/AuAxLsMV2WYFGAg48P7
 Qb69Dlyva9zd4MpPR06pUmR5em8CsMZRDsmynkKANk1Xu6ZpJeQ/388Shfw8bo9PhTVlWZ2n7
 QAJx6wb8JPs7O0Wr12Hw2Ia0MvWpv1iA2vrcuoqlQ83cQLkywWKHRy0Lbrer7uG5YE+NuZByH
 SbTt0S3526fDNdnV8L9Yy2AAdw33Uz61+oC37Rx68D2Oc9JVDqrXcE66K1MIx/I5q2aVTcsPv
 c3SQzwHmdgY8Ub3y3w4m/EicJHOWEJZtHHr/RQiDBOa7uxazVPKTyk+onqlmKdEX+pFXM1jdX
 i754BZt1xhazqH80w7YY2OHBa7aaZ4CMa4ltQuuH/DfirTbR/AAZy3V6/VagRnhk31J7oFSZ4
 7GX3Mi2TvHQhTkiGcQZw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The function was removed a long time ago, but the declaration
and a dummy implementation are still there, referencing the
deprecated time_t type.

Remove both.

Fixes: f958a1320ff7 ("nfsd4: remove unnecessary lease-setting function")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/nfsd/nfsd.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index af2947551e9c..e74979b5849e 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -142,7 +142,6 @@ int nfs4_state_start(void);
 int nfs4_state_start_net(struct net *net);
 void nfs4_state_shutdown(void);
 void nfs4_state_shutdown_net(struct net *net);
-void nfs4_reset_lease(time_t leasetime);
 int nfs4_reset_recoverydir(char *recdir);
 char * nfs4_recoverydir(void);
 bool nfsd4_spo_must_allow(struct svc_rqst *rqstp);
@@ -153,7 +152,6 @@ static inline int nfs4_state_start(void) { return 0; }
 static inline int nfs4_state_start_net(struct net *net) { return 0; }
 static inline void nfs4_state_shutdown(void) { }
 static inline void nfs4_state_shutdown_net(struct net *net) { }
-static inline void nfs4_reset_lease(time_t leasetime) { }
 static inline int nfs4_reset_recoverydir(char *recdir) { return 0; }
 static inline char * nfs4_recoverydir(void) {return NULL; }
 static inline bool nfsd4_spo_must_allow(struct svc_rqst *rqstp)
-- 
2.20.0

