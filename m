Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F994AC1E8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 15:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345191AbiBGOxm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 09:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392419AbiBGOac (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:30:32 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F754C0401C1
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Feb 2022 06:30:30 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220207142320epoutp02131abb2e319a257d541011b4fc0e3b7f~RhwZXiFzc0484404844epoutp024
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Feb 2022 14:23:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220207142320epoutp02131abb2e319a257d541011b4fc0e3b7f~RhwZXiFzc0484404844epoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644243800;
        bh=tBQFE3WFiAD3SmmzsrY7l8JP3Ohwj7KJRxzPt0V4dY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M7fdvdbDAeSLOTOn5lJo7G26jLGvmLveJSWCa5dPrdKyBuT4hk7M2ozYNCttNGRhb
         Ywuo6aLJT+oFBH95b7u61iYMdHJp0njdq2kXaeQ0/Dq6Ueh01GGBWk40vGtq0cFMlW
         q166qfF/qieAc0l07Wa5YsEptzFKqSDg2iXKK5FI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220207142318epcas5p3b1123df79785323b248f178f11e8fe55~RhwXwSDWL2018020180epcas5p3N;
        Mon,  7 Feb 2022 14:23:18 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JspJw2XFbz4x9Pt; Mon,  7 Feb
        2022 14:23:12 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.5F.06423.05B21026; Mon,  7 Feb 2022 23:23:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220207141958epcas5p25f1cd06726217696d13c2dfbea010565~Rhtdfm5sO3248332483epcas5p2p;
        Mon,  7 Feb 2022 14:19:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220207141958epsmtrp1221a394489b65997528cfb37ddda6c9f~RhtdecjlP0764707647epsmtrp1_;
        Mon,  7 Feb 2022 14:19:58 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-62-62012b50a9d0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.04.29871.E8A21026; Mon,  7 Feb 2022 23:19:58 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220207141954epsmtip18bd4227bed3f9bd9d383b66dee449b51~RhtZkitwJ0282702827epsmtip1W;
        Mon,  7 Feb 2022 14:19:54 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     mpatocka@redhat.com
Cc:     javier@javigon.com, chaitanyak@nvidia.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, roland@purestorage.com, hare@suse.de,
        kbusch@kernel.org, hch@lst.de, Frederick.Knight@netapp.com,
        zach.brown@ni.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
        nj.shetty@samsung.com, SelvaKumar S <selvakuma.s1@samsung.com>
Subject: [PATCH v2 10/10] dm kcopyd: use copy offload support
Date:   Mon,  7 Feb 2022 19:43:48 +0530
Message-Id: <20220207141348.4235-11-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.30.0-rc0
In-Reply-To: <20220207141348.4235-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TezBcZxTvd+/u3ZVW5gapj6lks5rpiEdsw/oYtDORzE01HU07ydS0lVvu
        YKzdzS6JdkIslVS8qXcHbTo1qEfFK8mipBhWY9XbEBZ5kAQh9WgkuuvS5r/f+Z3fOb9zzjcf
        Hzep4Vnyg6VhjEJKS4TELk7dbRsbex9b8JXjwBSJ1CPLXFQ2nkKgrMV1HC20THNRekoOD/XN
        7EaN8/lcpF1TYWi6ehND6p/SMVRS1oahB8XXAIrXaDG0oROhts0nBEpvHQSocdQWqRs7Oajw
        l3s8lDDUQKCmR404Ku54iaG07wYwdCdvg0B1zwtxdPvuAAeVbSD0aK2TQHGJ6zw01/zl+/uo
        vn5vKi12nkfFFo1xqL4/w6nq0niCuv7zJSpjuBhQt0aiCSqmuw2ncpaeEdRQdz1GJcXOE9TT
        e6Mcqk6XxKMWmgYIKrmmFPiY+Ya4BzF0AKMQMFJ/WUCwNNBD6P2J31E/Z7GjyF7kilyEAikd
        yngIvT70sT8eLNFfSig4T0vC9ZQPrVQKD3u6K2ThYYwgSKYM8xAy8gCJ3EnuoKRDleHSQAcp
        E+YmcnR811kvPBsSVKOb4sgHBBEVPV1YNFiwvAqM+JB0glWDMRwDNiFvAViwhK6CXXq8BGDi
        +gSPDVYAvBKjAzsV95eu4GyiEcDk6REuG8RhcKqnVp/h8wnSFmo2+YYCM9IcbmjrgEGDkz9w
        oWp9dsvPlPSAyyrWm0MehLX1NwkDNibdYG1LCY91s4Y/6lq4Bmyk51c2sjisZg/szJ3Zwji5
        H8bW5m9NBMlRIxitTuQYhoCkF6xPdWH7mMK5jprtnpZwNuUyj9UnALjWPYGxQQ6AsamxBKt6
        D/aqX2CGRjhpAytvHmZpK5jZVYGxxrth0vMZjOWNYUPBDraGv1YWbbexgIOrqm1MwYX8YoK9
        Vj+ALyYWualAkPfKQnmvLJT3v3URwEuBBSNXhgYySme5SMpc+O+Z/WWh1WDr+xw60QDGJxcd
        WgHGB60A8nGhmfFbCZu0iXEA/fU3jELmpwiXMMpW4Ky/eBpuuddfpv9/0jA/kZOro5NYLHZy
        PSIWCc2NNYFVtAkZSIcxIQwjZxQ7dRjfyDIaK3PSzmqfulcllHz8u4yvTm4fPfeahLSK/MIz
        e7a8/PvfOkwrnG/M+WosNInHn7kltNzRXXf0PW9k+0ev6tjSX9p5sdm+/eq/j0pTPaZS1jLP
        9NS8sfRBXEXHQY9vmyUrHz38J+ltuwtW86vmRx6/E3WO+jTabvn1a+Tn4S6TDyNOUyvrvDOV
        b/IjNAfMJh0K2q1s5i9etutd87ybyX055r45vAccsI4szD25GinMPtt9LLu4y6s94/GoxraQ
        mC6PuqQ1cTklLymK59o+6Y+qlDadGq8uKBKTMapASxu/5ppI79OekdV5OblRey+uD8cXLH7W
        lOUwlPHgZJbg/thaCZ2t4t3oFXKUQbToEK5Q0v8CGEaU48cEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUhTexjH+Z1zdnYcTI7T2C/tWqwMMjLXy/VHZNd/qqMFRcHCoJeVB5dN
        XZtmL9zr3Lil00xXSL6EZaU5qcy3rXSmq2Gm6WjOrKvB0hy0nNUikpa7zRH034fn8/0+zz8P
        hQvcRCR1LCuHVWZJ5SKSR3Q8FkWvKY0FR+JNjxahrldeDmqauEiiio9zOJrtneQg/cUrXGSf
        CkVmTzUH2b4VYGiyxY+hrjo9hhqbrBhyNdwAqGjAhiGfU4ys/hkS6S2jAJlfr0Zd5n4C1da/
        46LilyYSdbvNOGrom8dQeaEDQ0NVPhJ1fK/F0eM3DgI1+RByf+sn0b8lc1z0/tHBpGjGPrKD
        Kdd6uIz22jjB2J/nMi2GIpJpvZnPXBprAEznKzXJaAatOHPl8xeSeTloxJgLWg/JfHr3mmA6
        nBe4zGy3g2RK2wxgd8R+3uY0Vn7sJKtcu+UwT9bmfEsoHMtO3R1+hqnBbKQOhFCQ3gCnP5/H
        dYBHCehOAN+Pt4GgWAzrfzzBgxwOG+dd3GBIi8FbBV5SByiKpFfDAT8VyETQQuizdYBABqct
        HDg/9GGhHE4nQm+BhggwQcfAduNDMsB8ehNs723kBg8sh9edvZwAh/ycf/VVEMFjagDVQ7c5
        wUIY7K+cWliE00uhtr0aLwN01W+q6jd1DWAGsJhVqDLTM1VihTiLzYtTSTNVuVnpcUezM1vA
        wj/ErjIBo+FjnAVgFLAASOGiCP6SYr9UwE+Tnj7DKrMPKXPlrMoCoihCJOTbdP2HBHS6NIc9
        zrIKVvnLYlRIpBoryXceSPFQN/4aMX61uu3liQ6NZgpMG+JD8/SVvLKeIn5MjjpMQ5z06tZH
        fxL/12z+4/atmV3//LBIzPzE5hUbPfmpb8aqm0z3WsnNldRKoXfprr+NL5IlksGteOp36YCk
        e3T0KX01Qd63l6Dck7Q+zy+oqHa5ClNQxtlllrHd6gJad27t8FSCXSiPcuW2Z9eHuR6eUkzf
        mS+xb7nsll0+Uvds3dXQndt7tm14m9GTPFBz+LoxJuPPUn+57ETciPC+eaK2T1zXJdl+aVVC
        89kht3mCWmSzPv2ShHempiU7IofjZa17sNOF2Qll+2po04HmiQdzxZKo8fCSlJkkEaGSScWx
        uFIl/R8pW8O7fgMAAA==
X-CMS-MailID: 20220207141958epcas5p25f1cd06726217696d13c2dfbea010565
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220207141958epcas5p25f1cd06726217696d13c2dfbea010565
References: <CAOSviJ0HmT9iwdHdNtuZ8vHETCosRMpR33NcYGVWOV0ki3EYgw@mail.gmail.com>
        <20220207141348.4235-1-nj.shetty@samsung.com>
        <CGME20220207141958epcas5p25f1cd06726217696d13c2dfbea010565@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: SelvaKumar S <selvakuma.s1@samsung.com>

Introduce copy_jobs to use copy-offload, if supported by underlying devices
otherwise fall back to existing method.

run_copy_jobs() calls block layer copy offload API, if both source and
destination request queue are same and support copy offload.
On successful completion, destination regions copied count is made zero,
failed regions are processed via existing method.

Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/md/dm-kcopyd.c | 57 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-kcopyd.c b/drivers/md/dm-kcopyd.c
index 37b03ab7e5c9..64f17cc7b069 100644
--- a/drivers/md/dm-kcopyd.c
+++ b/drivers/md/dm-kcopyd.c
@@ -74,18 +74,20 @@ struct dm_kcopyd_client {
 	atomic_t nr_jobs;
 
 /*
- * We maintain four lists of jobs:
+ * We maintain five lists of jobs:
  *
- * i)   jobs waiting for pages
- * ii)  jobs that have pages, and are waiting for the io to be issued.
- * iii) jobs that don't need to do any IO and just run a callback
- * iv) jobs that have completed.
+ * i)	jobs waiting to try copy offload
+ * ii)   jobs waiting for pages
+ * iii)  jobs that have pages, and are waiting for the io to be issued.
+ * iv) jobs that don't need to do any IO and just run a callback
+ * v) jobs that have completed.
  *
- * All four of these are protected by job_lock.
+ * All five of these are protected by job_lock.
  */
 	spinlock_t job_lock;
 	struct list_head callback_jobs;
 	struct list_head complete_jobs;
+	struct list_head copy_jobs;
 	struct list_head io_jobs;
 	struct list_head pages_jobs;
 };
@@ -579,6 +581,44 @@ static int run_io_job(struct kcopyd_job *job)
 	return r;
 }
 
+static int run_copy_job(struct kcopyd_job *job)
+{
+	int r, i, count = 0;
+	unsigned long flags = 0;
+	struct range_entry range;
+
+	struct request_queue *src_q, *dest_q;
+
+	for (i = 0; i < job->num_dests; i++) {
+		range.dst = job->dests[i].sector << SECTOR_SHIFT;
+		range.src = job->source.sector << SECTOR_SHIFT;
+		range.len = job->source.count << SECTOR_SHIFT;
+
+		src_q = bdev_get_queue(job->source.bdev);
+		dest_q = bdev_get_queue(job->dests[i].bdev);
+
+		if (src_q != dest_q && !src_q->limits.copy_offload)
+			break;
+
+		r = blkdev_issue_copy(job->source.bdev, 1, &range,
+			job->dests[i].bdev, GFP_KERNEL, flags);
+		if (r)
+			break;
+
+		job->dests[i].count = 0;
+		count++;
+	}
+
+	if (count == job->num_dests) {
+		push(&job->kc->complete_jobs, job);
+	} else {
+		push(&job->kc->pages_jobs, job);
+		r = 0;
+	}
+
+	return r;
+}
+
 static int run_pages_job(struct kcopyd_job *job)
 {
 	int r;
@@ -659,6 +699,7 @@ static void do_work(struct work_struct *work)
 	spin_unlock_irq(&kc->job_lock);
 
 	blk_start_plug(&plug);
+	process_jobs(&kc->copy_jobs, kc, run_copy_job);
 	process_jobs(&kc->complete_jobs, kc, run_complete_job);
 	process_jobs(&kc->pages_jobs, kc, run_pages_job);
 	process_jobs(&kc->io_jobs, kc, run_io_job);
@@ -676,6 +717,8 @@ static void dispatch_job(struct kcopyd_job *job)
 	atomic_inc(&kc->nr_jobs);
 	if (unlikely(!job->source.count))
 		push(&kc->callback_jobs, job);
+	else if (job->source.bdev->bd_disk == job->dests[0].bdev->bd_disk)
+		push(&kc->copy_jobs, job);
 	else if (job->pages == &zero_page_list)
 		push(&kc->io_jobs, job);
 	else
@@ -916,6 +959,7 @@ struct dm_kcopyd_client *dm_kcopyd_client_create(struct dm_kcopyd_throttle *thro
 	spin_lock_init(&kc->job_lock);
 	INIT_LIST_HEAD(&kc->callback_jobs);
 	INIT_LIST_HEAD(&kc->complete_jobs);
+	INIT_LIST_HEAD(&kc->copy_jobs);
 	INIT_LIST_HEAD(&kc->io_jobs);
 	INIT_LIST_HEAD(&kc->pages_jobs);
 	kc->throttle = throttle;
@@ -971,6 +1015,7 @@ void dm_kcopyd_client_destroy(struct dm_kcopyd_client *kc)
 
 	BUG_ON(!list_empty(&kc->callback_jobs));
 	BUG_ON(!list_empty(&kc->complete_jobs));
+	WARN_ON(!list_empty(&kc->copy_jobs));
 	BUG_ON(!list_empty(&kc->io_jobs));
 	BUG_ON(!list_empty(&kc->pages_jobs));
 	destroy_workqueue(kc->kcopyd_wq);
-- 
2.30.0-rc0

