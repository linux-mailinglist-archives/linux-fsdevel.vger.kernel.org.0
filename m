Return-Path: <linux-fsdevel+bounces-48870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE47AB523A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CF9D4C1294
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 10:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C54328DB6F;
	Tue, 13 May 2025 10:08:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5008D288502;
	Tue, 13 May 2025 10:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130895; cv=none; b=VIw9CyHbjHgxQgxZEyq80tQgNICbIj02ThgdCipzx6i/aQ+nJ/2ouxlkBFnzZ1PH3gDZy1x5aHNHYVLXcUrWWFsmb988e4YcHaSLeM3ITW+MQKOLL/x77ABVRQN7B+nc4zyh22DRRgW8xg7ZJi51NSmMwyR0T1BH/bCNH18cb+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130895; c=relaxed/simple;
	bh=oQEw6Eo1ZD4NTR5FBfSUcltAFBYsFRqKtAgptAn2JR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=k75douOyX2hEMb8iYX8hYP5mia8uatbz44tn8XjseS6aPrg3ooJo9kRC0i8vwfrAd5hH67W/6i9B9aVfKKqpe1KfmSNNWIGpWh1VHv0uHiMBjc9AHj6tjFlpg9ZGYXJ/T+CNxs/VoeFFa6LyepWKIn+2GF+u+83mjW4fRj/vCPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-fe-682319f2b3f9
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org
Cc: kernel_team@skhynix.com,
	torvalds@linux-foundation.org,
	damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	will@kernel.org,
	tglx@linutronix.de,
	rostedt@goodmis.org,
	joel@joelfernandes.org,
	sashal@kernel.org,
	daniel.vetter@ffwll.ch,
	duyuyang@gmail.com,
	johannes.berg@intel.com,
	tj@kernel.org,
	tytso@mit.edu,
	willy@infradead.org,
	david@fromorbit.com,
	amir73il@gmail.com,
	gregkh@linuxfoundation.org,
	kernel-team@lge.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	minchan@kernel.org,
	hannes@cmpxchg.org,
	vdavydov.dev@gmail.com,
	sj@kernel.org,
	jglisse@redhat.com,
	dennis@kernel.org,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	vbabka@suse.cz,
	ngupta@vflare.org,
	linux-block@vger.kernel.org,
	josef@toxicpanda.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	dan.j.williams@intel.com,
	hch@infradead.org,
	djwong@kernel.org,
	dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com,
	hamohammed.sa@gmail.com,
	harry.yoo@oracle.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	yskelg@gmail.com,
	yunseong.kim@ericsson.com,
	yeoreum.yun@arm.com,
	netdev@vger.kernel.org,
	matthew.brost@intel.com,
	her0gyugyu@gmail.com
Subject: [PATCH v15 36/43] i2c: rename wait_for_completion callback to wait_for_completion_cb
Date: Tue, 13 May 2025 19:07:23 +0900
Message-Id: <20250513100730.12664-37-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250513100730.12664-1-byungchul@sk.com>
References: <20250513100730.12664-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSWUxTWxSG3fuMrRaPlasHNVGrRsXhglNWjAPxxX2jJhoTHyAKjZzQhklb
	QHCIIOAAUkEvElGwoCkNHKQWgyMGUahccxGVSVNBiKINU4K2EQS11fiy8uX7s/71snhK7WBm
	8fq4BMkQp43RsEpaOTilZMVIwAJdkKskENxfTtNwpUpmoeVGBQL5VhoGV8NW6PAMIPj2/3MK
	CvJbEJT0vKXgVmMXglrrCRZevfeDVvcwC0352SykX6ti4UX/OAbnxfMYKuw7oNvSR8Oz3FIM
	BS4WLhekY+/4hGHUUs6BJXUR9FoLORjvCYamrnYGat8sg0vFThYe1DbR0HinF8Ore1dY6JJ/
	MPCs8SkNHtNsaMnLYaByqJSFfo+FAot7mIOXdWYMjeYZYMvwFp78/J0BR04dhpPXb2JofX0f
	wcPT7zDY5XYWHrsHMFTb8ykYK2tA0Gsa5CDz7CgHl9NMCLIzL9KQ4VwL3756Lxd9CYa0qzYa
	KifaUchGIhfLiDweGKZIRvUhMuZuY0mtx0yT/0pFcrfwLUcyHr7hiNmeSKqtgeTaAxcmJSNu
	htjLz7DEPnKeI1mDrZgMNTdzO+eEKjdESjH6JMnw96YIpa7fJTMHKsVkh1yKU1GPfxZS8KKw
	RnQ6ZJyF+F/8MVXyaVZYLHZ2jlI+9hfmidU5fUwWUvKU0D5Z7Ch6jXzBdGGvWDhkwz6mhUXi
	ubF/WR+rhHVizYtx6nf/XLHCVveLFV4/UdZM+1gtrBVzzRW0r1QULijEJ21O7vdCgPjI2knn
	IpUZTSpHan1cUqxWH7NmpS4lTp+8cn98rB1538tybDzsDhpp2V2PBB5ppqieuubr1Iw2yZgS
	W49EntL4q9Jue5UqUptyWDLEhxsSYyRjPZrN05qZqlWeQ5FqIUqbIEVL0gHJ8CfFvGJWKqo6
	E0ntCPnrQ2XYztFua0d0/vHt2W0hF+b07orffSr2nyNbgv26w9cr8o72v5taM0PZl2lOnFqD
	/VYUn91sNUY4vv+wRkeEBO1Pd5QbotYHEeTXsNqjz5vWk7MkTA49mHzcZFPaOqKK9k0sDaUT
	wpe3Jm6rN6XvmXnqflnAxMsjC0FDG3Xa4EDKYNT+BHvcCUVaAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzHfb+/x47jt9z4CcOZ2Ypok32MNX8YvyH8xWYeOvrN3VS4uyIP
	253rSJTTShNxHa7TXcoVQpFaJQ+nXFKtojzeSk266EnubP5577X3e5/P+583SwTeooJYVZxW
	VMcpYuS0hJRsWmlY3D9jvnLpmYdTwTuQTMKVQgcN9bftCBwlegye6nXwbrAHwcir1wRkZdYj
	yO1sJ6CkpgNBue0kDe5Pk6HR20dDXeZZGgzXC2lo6B7F0HYxHYPdGQnvrV9IeGGyYMjy0HA5
	y4B98g3DkDWfAatuAXTZshkY7QyDuo4mCqpy6igobw2BS1fbaCgrryOhprQLg/vhFRo6HOMU
	vKh5RsJg2kyov5BKQUGvhYbuQSsBVm8fA28qzBhqzNOgKMn39dTPPxTUplZgOHXjDobGlkcI
	Hid/wOB0NNFQ5e3BUOzMJGA4rxpBV9p3Boznhhi4rE9DcNZ4kYSktnAY+e1rzhkIA/21IhIK
	xprQ6gjBcdWBhKqePkJIKj4sDHvf0kL5oJkUnlt44UF2OyMkPW5lBLMzXii2BQvXyzxYyO33
	UoIz/wwtOPvTGSHleyMWel0uZsvs7ZJV0WKMKkFUL4mIkii7PQ7qYAF/pNZhwTrUKUtBLMtz
	y/ivOjEFBbA0t5Bvbh4i/Czj5vLFqV+oFCRhCa5pIv8upwX5g6ncTj67twj7meQW8OeHM2g/
	S7nl/L2G0X/HPDeHtxdV/OMAnz+W5yL9HMiF8yaznTQhiRlNyEcyVVxCrEIVEx6q2a9MjFMd
	Cd17INaJfAOynhi9UIoG3OsqEcci+STpM888ZSClSNAkxlYiniXkMqn+vs+SRisSj4rqA7vV
	8TGiphLNZEn5dOn6bWJUILdPoRX3i+JBUf0/xWxAkA7d2q4n2yWhi1y2cw3V482m8BMzPt9F
	8bNmrYx050XtODrlo9zyZDEcKphvXXRoNqeqythjtHPGtTvHJcFDdpd2w/mQ5Jsryn7dj5eZ
	OPWSLT8ieo9bdIb0IO0r22St4Zht67TSibUjGWNzuJeWXe7nuRsjk08HGJ9qN0+Y19ypWyMn
	NUpFWDCh1ij+AhyQGK48AwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Functionally no change.  This patch is a preparation for DEPT(DEPendency
Tracker) to track dependencies related to a scheduler API,
wait_for_completion().

Unfortunately, struct i2c_algo_pca_data has a callback member named
wait_for_completion, that is the same as the scheduler API, which makes
it hard to change the scheduler API to a macro form because of the
ambiguity.

Add a postfix _cb to the callback member to remove the ambiguity.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/i2c/algos/i2c-algo-pca.c      | 2 +-
 drivers/i2c/busses/i2c-pca-isa.c      | 2 +-
 drivers/i2c/busses/i2c-pca-platform.c | 2 +-
 include/linux/i2c-algo-pca.h          | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-pca.c b/drivers/i2c/algos/i2c-algo-pca.c
index 384af88e58ad..3647e4e19360 100644
--- a/drivers/i2c/algos/i2c-algo-pca.c
+++ b/drivers/i2c/algos/i2c-algo-pca.c
@@ -30,7 +30,7 @@ static int i2c_debug;
 #define pca_clock(adap) adap->i2c_clock
 #define pca_set_con(adap, val) pca_outw(adap, I2C_PCA_CON, val)
 #define pca_get_con(adap) pca_inw(adap, I2C_PCA_CON)
-#define pca_wait(adap) adap->wait_for_completion(adap->data)
+#define pca_wait(adap) adap->wait_for_completion_cb(adap->data)
 
 static void pca_reset(struct i2c_algo_pca_data *adap)
 {
diff --git a/drivers/i2c/busses/i2c-pca-isa.c b/drivers/i2c/busses/i2c-pca-isa.c
index 85e8cf58e8bf..0cbf2f509527 100644
--- a/drivers/i2c/busses/i2c-pca-isa.c
+++ b/drivers/i2c/busses/i2c-pca-isa.c
@@ -95,7 +95,7 @@ static struct i2c_algo_pca_data pca_isa_data = {
 	/* .data intentionally left NULL, not needed with ISA */
 	.write_byte		= pca_isa_writebyte,
 	.read_byte		= pca_isa_readbyte,
-	.wait_for_completion	= pca_isa_waitforcompletion,
+	.wait_for_completion_cb	= pca_isa_waitforcompletion,
 	.reset_chip		= pca_isa_resetchip,
 };
 
diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index 87da8241b927..c0f35ebbe37d 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -180,7 +180,7 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 	}
 
 	i2c->algo_data.data = i2c;
-	i2c->algo_data.wait_for_completion = i2c_pca_pf_waitforcompletion;
+	i2c->algo_data.wait_for_completion_cb = i2c_pca_pf_waitforcompletion;
 	if (i2c->gpio)
 		i2c->algo_data.reset_chip = i2c_pca_pf_resetchip;
 	else
diff --git a/include/linux/i2c-algo-pca.h b/include/linux/i2c-algo-pca.h
index 7c522fdd9ea7..e305bf32e40a 100644
--- a/include/linux/i2c-algo-pca.h
+++ b/include/linux/i2c-algo-pca.h
@@ -71,7 +71,7 @@ struct i2c_algo_pca_data {
 	void 				*data;	/* private low level data */
 	void (*write_byte)		(void *data, int reg, int val);
 	int  (*read_byte)		(void *data, int reg);
-	int  (*wait_for_completion)	(void *data);
+	int  (*wait_for_completion_cb)	(void *data);
 	void (*reset_chip)		(void *data);
 	/* For PCA9564, use one of the predefined frequencies:
 	 * 330000, 288000, 217000, 146000, 88000, 59000, 44000, 36000
-- 
2.17.1


