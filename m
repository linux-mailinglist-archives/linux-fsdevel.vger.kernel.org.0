Return-Path: <linux-fsdevel+bounces-153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 161937C6429
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 06:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E88A2825E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 04:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F006C63C1;
	Thu, 12 Oct 2023 04:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aTIhyDFW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A93F53A6
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 04:40:16 +0000 (UTC)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC626B8
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 21:40:13 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d9ac31cb021so315431276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 21:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697085613; x=1697690413; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+l9a+mEwNtEsZNHCdrwSvDlM5U4OjWSgjs4wg5g9aAk=;
        b=aTIhyDFWtoGp35tCDGdduIuAL0GUDGZXlYewKzVE/tUjVPLWuR96rCUK8wOGg0is9I
         nqrtXaJIs/EARoXiHEnukbaDHL8IXjMJ75ESnlS2WdcfXvN0O2CJV7jPZN+udbTamnRx
         6GdcZXKevQNNx/5KMNxIjgP4lxYE7p/vZoYgjdDPFRpEL3UKHYJZ8Hf5ipHOStcE5mT/
         DVZdN+9ug+L5h0ebgzokbjFzz/CXvA8mMnK4PnrgXVlx52piQuHX97jkdkdCrEfEFovx
         dt872NETiR2HqZyEsU9fmb9doQcsh7u7F0JxB771bbbAT8cxyyCVxTdLv2VU5I4Tsn1T
         fBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697085613; x=1697690413;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+l9a+mEwNtEsZNHCdrwSvDlM5U4OjWSgjs4wg5g9aAk=;
        b=g9wfLd+3S03bs/3VDS5OoiQusAzl5xICxFGiuS78B0CKWg5ohiE6Rbt1nyiPYEeHk3
         +cvlin8Xk6OVWKtvosS7hqBlJL0jLFrgKFIFkrPS6/Lg887hUq/1ChDeHW7vUdsqHygJ
         Si9vacFsIyu4L1hiWXCkomMUB5Nm3vd2DWc+aoFfmVsDqDc9Arc4kz4J3S4rg86WHgIh
         LgoF0SN1pC0iIu+LmQky/kQoLKNpGIkI8m4QhnKToSQnbCjoy4cWRWum+I0LJYiDQTiy
         t4MhJk6IgrX4GQRkJw4TYJvb7tYKp+3u1rYgRSQObUcz4rRJJ+SixKqMexhbEp0lcMbU
         QXJQ==
X-Gm-Message-State: AOJu0Yz3rJ+eT/sQzN1JsoEEzj1bD5DmvQ0PIRYQoOylbHpnTrPNRnm1
	7dah/X/l/5ckAm08BpsxcaZbFg==
X-Google-Smtp-Source: AGHT+IEy29AB2gZVMxb+IATr0dLpEGj4Y9wZwZWi4zoiPAFB4Rim0MuDfZV+1buXtmaVCIwWelmNMQ==
X-Received: by 2002:a5b:285:0:b0:d7b:9d44:7574 with SMTP id x5-20020a5b0285000000b00d7b9d447574mr20855492ybl.64.1697085612762;
        Wed, 11 Oct 2023 21:40:12 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x142-20020a25ce94000000b00d89679f6d22sm1734993ybe.64.2023.10.11.21.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 21:40:11 -0700 (PDT)
Date: Wed, 11 Oct 2023 21:40:09 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To: Andrew Morton <akpm@linux-foundation.org>
cc: Dave Chinner <david@fromorbit.com>, Tim Chen <tim.c.chen@intel.com>, 
    Dave Chinner <dchinner@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>, 
    Christian Brauner <brauner@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
    Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>, 
    Matthew Wilcox <willy@infradead.org>, Johannes Weiner <hannes@cmpxchg.org>, 
    Axel Rasmussen <axelrasmussen@google.com>, 
    Dennis Zhou <dennisszhou@gmail.com>, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 9/8] percpu_counter: extend _limited_add() to negative
 amounts
In-Reply-To: <ddc21eb0-8fe9-c5c3-82c5-f8ac3e4a5a10@google.com>
Message-ID: <8f86083b-c452-95d4-365b-f16a2e4ebcd4@google.com>
References: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com> <bb817848-2d19-bcc8-39ca-ea179af0f0b4@google.com> <ZR3wzVJ019gH0DvS@dread.disaster.area> <2451f678-38b3-46c7-82fe-8eaf4d50a3a6@google.com> <ZSNGMvICWWaKAaJL@dread.disaster.area>
 <ddc21eb0-8fe9-c5c3-82c5-f8ac3e4a5a10@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Though tmpfs does not need it, percpu_counter_limited_add() can be twice
as useful if it works sensibly with negative amounts (subs) - typically
decrements towards a limit of 0 or nearby: as suggested by Dave Chinner.

And in the course of that reworking, skip the percpu counter sum if it is
already obvious that the limit would be passed: as suggested by Tim Chen.

Extend the comment above __percpu_counter_limited_add(), defining the
behaviour with positive and negative amounts, allowing negative limits,
but not bothering about overflow beyond S64_MAX.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/percpu_counter.h | 11 +++++--
 lib/percpu_counter.c           | 54 +++++++++++++++++++++++++---------
 2 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
index 8cb7c071bd5c..3a44dd1e33d2 100644
--- a/include/linux/percpu_counter.h
+++ b/include/linux/percpu_counter.h
@@ -198,14 +198,21 @@ static inline bool
 percpu_counter_limited_add(struct percpu_counter *fbc, s64 limit, s64 amount)
 {
 	unsigned long flags;
+	bool good = false;
 	s64 count;
 
+	if (amount == 0)
+		return true;
+
 	local_irq_save(flags);
 	count = fbc->count + amount;
-	if (count <= limit)
+	if ((amount > 0 && count <= limit) ||
+	    (amount < 0 && count >= limit)) {
 		fbc->count = count;
+		good = true;
+	}
 	local_irq_restore(flags);
-	return count <= limit;
+	return good;
 }
 
 /* non-SMP percpu_counter_add_local is the same with percpu_counter_add */
diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index 58a3392f471b..44dd133594d4 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -279,8 +279,16 @@ int __percpu_counter_compare(struct percpu_counter *fbc, s64 rhs, s32 batch)
 EXPORT_SYMBOL(__percpu_counter_compare);
 
 /*
- * Compare counter, and add amount if the total is within limit.
- * Return true if amount was added, false if it would exceed limit.
+ * Compare counter, and add amount if total is: less than or equal to limit if
+ * amount is positive, or greater than or equal to limit if amount is negative.
+ * Return true if amount is added, or false if total would be beyond the limit.
+ *
+ * Negative limit is allowed, but unusual.
+ * When negative amounts (subs) are given to percpu_counter_limited_add(),
+ * the limit would most naturally be 0 - but other limits are also allowed.
+ *
+ * Overflow beyond S64_MAX is not allowed for: counter, limit and amount
+ * are all assumed to be sane (far from S64_MIN and S64_MAX).
  */
 bool __percpu_counter_limited_add(struct percpu_counter *fbc,
 				  s64 limit, s64 amount, s32 batch)
@@ -288,10 +296,10 @@ bool __percpu_counter_limited_add(struct percpu_counter *fbc,
 	s64 count;
 	s64 unknown;
 	unsigned long flags;
-	bool good;
+	bool good = false;
 
-	if (amount > limit)
-		return false;
+	if (amount == 0)
+		return true;
 
 	local_irq_save(flags);
 	unknown = batch * num_online_cpus();
@@ -299,7 +307,8 @@ bool __percpu_counter_limited_add(struct percpu_counter *fbc,
 
 	/* Skip taking the lock when safe */
 	if (abs(count + amount) <= batch &&
-	    fbc->count + unknown <= limit) {
+	    ((amount > 0 && fbc->count + unknown <= limit) ||
+	     (amount < 0 && fbc->count - unknown >= limit))) {
 		this_cpu_add(*fbc->counters, amount);
 		local_irq_restore(flags);
 		return true;
@@ -309,7 +318,19 @@ bool __percpu_counter_limited_add(struct percpu_counter *fbc,
 	count = fbc->count + amount;
 
 	/* Skip percpu_counter_sum() when safe */
-	if (count + unknown > limit) {
+	if (amount > 0) {
+		if (count - unknown > limit)
+			goto out;
+		if (count + unknown <= limit)
+			good = true;
+	} else {
+		if (count + unknown < limit)
+			goto out;
+		if (count - unknown >= limit)
+			good = true;
+	}
+
+	if (!good) {
 		s32 *pcount;
 		int cpu;
 
@@ -317,15 +338,20 @@ bool __percpu_counter_limited_add(struct percpu_counter *fbc,
 			pcount = per_cpu_ptr(fbc->counters, cpu);
 			count += *pcount;
 		}
+		if (amount > 0) {
+			if (count > limit)
+				goto out;
+		} else {
+			if (count < limit)
+				goto out;
+		}
+		good = true;
 	}
 
-	good = count <= limit;
-	if (good) {
-		count = __this_cpu_read(*fbc->counters);
-		fbc->count += count + amount;
-		__this_cpu_sub(*fbc->counters, count);
-	}
-
+	count = __this_cpu_read(*fbc->counters);
+	fbc->count += count + amount;
+	__this_cpu_sub(*fbc->counters, count);
+out:
 	raw_spin_unlock(&fbc->lock);
 	local_irq_restore(flags);
 	return good;
-- 
2.35.3


