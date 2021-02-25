Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D4C324B00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbhBYHLC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:11:02 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54936 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhBYHIi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:08:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614236917; x=1645772917;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LeAvg38TfE+J/qYTQXG9nwkLSb8PcQeHGw+zvx/IKEM=;
  b=RBQEZWDcjWvz4saCMaLXAoq2v9lwVzMuvMA2CeC4RY07EBYbVeQj7zzH
   zOh2Hko0+sWigyhkRO7e0fgJfhWKxxkdT6syASdZ4dXFiqKczBk5mMMkR
   fO64cMT9WWrSc9KEmDOowaRJG9SC66NOuYGJpP2y949ygfeajtyur6NBK
   z6y+SAkI64klcmgWzFwXn1sH1CaHW8vgqaUns0rnD6m2+j0mHvIK6ifqM
   y6yPC2hcCCG3+7TnnEaz48kGpUahlKjAlF81nloacMtLHfdMFBAuhcSJA
   4RyOgP1o4NnJK1Esa68W9wF0JQzmY7sHc9mdXt1aVZw10+NnmD3OxGBSc
   g==;
IronPort-SDR: z7v+OOqEKcTpEYQACtrrzTGP+NaQ8j0vEp0kDhMTrzXgETeKdpoitkZXfFxFDyQRooBUYl7V7E
 JCzOcOrcP/3GJbLE94fBB5/0TwmO3W9h6IYM94EWK9xbonulE9zUWKct7muJm5QEMLGOVfPtMt
 E+OA4DNS1GTSynXBDZToU/y84PGABVYvBKeaQz4mNYH1cQprPU9z0mQMmg/F23OOMQ24oDJrQe
 10t34y1R4k4BhI/EnfjzrP6HQrCshOB7PVGcRYYyrlkasukIJ29FkZ4aZGCLQYgWTTUC7/FHKd
 FuA=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="160778088"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:07:23 +0800
IronPort-SDR: Es2PK+QhwFwz2l5ZxBzlGr3niCVYebFkuxpvXDXLI/FznVX1VFht5AF205yJjiWw+WCIa1k8hM
 e3Fn0czgKytl/gxIqpbyaWU2VoyPL6rU4GV80o9d5Nbdpl2BVpvB4IaD15YIXcu3HwOSxyzxA9
 QbfuWMyLMfin/Cs6d9F49rspYuTiXbs+oivXuFNdNjn9jO8xRwWNhLWLGXA8PCw/4Zkq6qgyUt
 wNm0+cqcaxFRzoP/EXypWmybagttEob28BM3shJC1s8SEPfoexsphso24ofbMhPRxj9vY/PmB1
 5HvCK0yaFS1QVhx6UZPXxHWU
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:50:39 -0800
IronPort-SDR: fHcv2t4JbP2TvYb/jPZgpXkNjncpqR00V00dzCRYR1rhlm/bxdnQPjzjdlx0hYobBOrqdDr0Q5
 n3vrPHcthtoDB8LeD6H/kMWE+GEbGzeqzrsH3o14bX/hYvNgx5IlToGPTPG082U0pOGuydD127
 DLm0kKEzxf47aWg4pdsnF3RFqVKMhK59aWeOoHmXnWI3sNwO8tCt8uJKQPPfWlFu2dxkeF0OtO
 wKr0ItK/ZZA2AFkKl14kIU5AzjR8R9pX8KuX8UkX16UMoZY1hI1tLUP+P1zTIR3zYumFcp5N65
 du8=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:07:23 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 34/39] blktrace: implement setup-start-stop ioclts
Date:   Wed, 24 Feb 2021 23:02:26 -0800
Message-Id: <20210225070231.21136-35-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
References: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement newly introduced IOCTLs for setup/start/stop/teardown.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/uapi/linux/fs.h |   5 +
 kernel/trace/blktrace.c | 294 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 299 insertions(+)

diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index f44eb0a04afd..ca722ecbd3de 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -184,6 +184,11 @@ struct fsxattr {
 #define BLKSECDISCARD _IO(0x12,125)
 #define BLKROTATIONAL _IO(0x12,126)
 #define BLKZEROOUT _IO(0x12,127)
+#define BLKTRACESETUP_EXT _IOWR(0x12,128,struct blk_user_trace_setup_ext)
+#define BLKTRACESTART_EXT _IO(0x12,129)
+#define BLKTRACESTOP_EXT _IO(0x12,130)
+#define BLKTRACETEARDOWN_EXT _IO(0x12,131)
+
 /*
  * A jump here: 130-131 are reserved for zoned block devices
  * (see uapi/linux/blkzoned.h)
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index f707ebde0062..3bd56b741379 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -609,6 +609,17 @@ static void get_probe_ref(void)
 	mutex_unlock(&blk_probe_mutex);
 }
 
+static void blk_trace_free_ext(struct blk_trace_ext *bt)
+{
+	debugfs_remove(bt->msg_file);
+	debugfs_remove(bt->dropped_file);
+	relay_close(bt->rchan);
+	debugfs_remove(bt->dir);
+	free_percpu(bt->sequence);
+	free_percpu(bt->msg_data);
+	kfree(bt);
+}
+
 static void put_probe_ref(void)
 {
 	mutex_lock(&blk_probe_mutex);
@@ -624,6 +635,13 @@ static void blk_trace_cleanup(struct blk_trace *bt)
 	put_probe_ref();
 }
 
+static void blk_trace_cleanup_ext(struct blk_trace_ext *bt)
+{
+	synchronize_rcu();
+	blk_trace_free_ext(bt);
+	put_probe_ref();
+}
+
 static int __blk_trace_remove(struct request_queue *q)
 {
 	struct blk_trace *bt;
@@ -639,12 +657,28 @@ static int __blk_trace_remove(struct request_queue *q)
 	return 0;
 }
 
+static int __blk_trace_remove_ext(struct request_queue *q)
+{
+	struct blk_trace_ext *bt;
+
+	bt = xchg(&q->blk_trace_ext, NULL);
+	if (!bt)
+		return -EINVAL;
+
+	if (bt->trace_state != Blktrace_running)
+		blk_trace_cleanup_ext(bt);
+
+	return 0;
+}
+
 int blk_trace_remove(struct request_queue *q)
 {
 	int ret;
 
 	mutex_lock(&q->debugfs_mutex);
 	ret = __blk_trace_remove(q);
+	if (ret)
+		__blk_trace_remove_ext(q);
 	mutex_unlock(&q->debugfs_mutex);
 
 	return ret;
@@ -662,6 +696,17 @@ static ssize_t blk_dropped_read(struct file *filp, char __user *buffer,
 	return simple_read_from_buffer(buffer, count, ppos, buf, strlen(buf));
 }
 
+static ssize_t blk_dropped_read_ext(struct file *filp, char __user *buffer,
+				size_t count, loff_t *ppos)
+{
+	struct blk_trace_ext *bt = filp->private_data;
+	char buf[16];
+
+	snprintf(buf, sizeof(buf), "%u\n", atomic_read(&bt->dropped));
+
+	return simple_read_from_buffer(buffer, count, ppos, buf, strlen(buf));
+}
+
 static const struct file_operations blk_dropped_fops = {
 	.owner =	THIS_MODULE,
 	.open =		simple_open,
@@ -669,6 +714,13 @@ static const struct file_operations blk_dropped_fops = {
 	.llseek =	default_llseek,
 };
 
+static const struct file_operations blk_dropped_fops_ext = {
+	.owner =	THIS_MODULE,
+	.open =		simple_open,
+	.read =		blk_dropped_read_ext,
+	.llseek =	default_llseek,
+};
+
 static ssize_t blk_msg_write(struct file *filp, const char __user *buffer,
 				size_t count, loff_t *ppos)
 {
@@ -689,6 +741,26 @@ static ssize_t blk_msg_write(struct file *filp, const char __user *buffer,
 	return count;
 }
 
+static ssize_t blk_msg_write_ext(struct file *filp, const char __user *buffer,
+				size_t count, loff_t *ppos)
+{
+	char *msg;
+	struct blk_trace_ext *bt;
+
+	if (count >= BLK_TN_MAX_MSG)
+		return -EINVAL;
+
+	msg = memdup_user_nul(buffer, count);
+       if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	bt = filp->private_data;
+	__trace_note_message_ext(bt, NULL, "%s", msg);
+	kfree(msg);
+
+	return count;
+}
+
 static const struct file_operations blk_msg_fops = {
 	.owner =	THIS_MODULE,
 	.open =		simple_open,
@@ -696,6 +768,13 @@ static const struct file_operations blk_msg_fops = {
 	.llseek =	noop_llseek,
 };
 
+static const struct file_operations blk_msg_fops_ext = {
+	.owner =	THIS_MODULE,
+	.open =		simple_open,
+	.write =	blk_msg_write_ext,
+	.llseek =	noop_llseek,
+};
+
 /*
  * Keep track of how many times we encountered a full subbuffer, to aid
  * the user space app in telling how many lost events there were.
@@ -730,12 +809,31 @@ static struct dentry *blk_create_buf_file_callback(const char *filename,
 					&relay_file_operations);
 }
 
+static int blk_subbuf_start_callback_ext(struct rchan_buf *buf, void *subbuf,
+				     void *prev_subbuf, size_t prev_padding)
+{
+	struct blk_trace_ext *bt;
+
+	if (!relay_buf_full(buf))
+		return 1;
+
+	bt = buf->chan->private_data;
+	atomic_inc(&bt->dropped);
+	return 0;
+}
+
 static const struct rchan_callbacks blk_relay_callbacks = {
 	.subbuf_start		= blk_subbuf_start_callback,
 	.create_buf_file	= blk_create_buf_file_callback,
 	.remove_buf_file	= blk_remove_buf_file_callback,
 };
 
+static struct rchan_callbacks blk_relay_callbacks_ext = {
+	.subbuf_start		= blk_subbuf_start_callback_ext,
+	.create_buf_file	= blk_create_buf_file_callback,
+	.remove_buf_file	= blk_remove_buf_file_callback,
+};
+
 static void blk_trace_setup_lba(struct blk_trace *bt,
 				struct block_device *bdev)
 {
@@ -748,6 +846,18 @@ static void blk_trace_setup_lba(struct blk_trace *bt,
 	}
 }
 
+static void blk_trace_setup_lba_ext(struct blk_trace_ext *bt,
+				struct block_device *bdev)
+{
+	if (bdev) {
+		bt->start_lba = bdev->bd_start_sect;
+		bt->end_lba = bdev->bd_start_sect + bdev_nr_sectors(bdev);
+	} else {
+		bt->start_lba = 0;
+		bt->end_lba = -1ULL;
+	}
+}
+
 /*
  * Setup everything required to start tracing
  */
@@ -858,6 +968,106 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	return ret;
 }
 
+static int do_blk_trace_setup_ext(struct request_queue *q, char *name, dev_t dev,
+			      struct block_device *bdev,
+			      struct blk_user_trace_setup_ext *buts)
+{
+	struct blk_trace_ext *bt = NULL;
+	struct dentry *dir = NULL;
+	int ret;
+
+	if (q->blk_trace) {
+		pr_err("queue is already associated with legecy trace\n");
+		return -EINVAL;
+	}
+	if (!buts->buf_size || !buts->buf_nr)
+		return -EINVAL;
+
+	if (!blk_debugfs_root)
+		return -ENOENT;
+
+	strncpy(buts->name, name, BLKTRACE_BDEV_SIZE);
+	buts->name[BLKTRACE_BDEV_SIZE - 1] = '\0';
+
+	/*
+	 * some device names have larger paths - convert the slashes
+	 * to underscores for this to work as expected
+	 */
+	strreplace(buts->name, '/', '_');
+
+	bt = kzalloc(sizeof(*bt), GFP_KERNEL);
+	if (!bt)
+		return -ENOMEM;
+
+	ret = -ENOMEM;
+	bt->sequence = alloc_percpu(unsigned long);
+	if (!bt->sequence)
+		goto err;
+
+	bt->msg_data = __alloc_percpu(BLK_TN_MAX_MSG, __alignof__(char));
+	if (!bt->msg_data)
+		goto err;
+
+	ret = -ENOENT;
+
+	dir = debugfs_lookup(buts->name, blk_debugfs_root);
+	if (!dir)
+		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
+	if (!dir)
+		goto err;
+
+	bt->dev = dev;
+	atomic_set(&bt->dropped, 0);
+	INIT_LIST_HEAD(&bt->running_ext_list);
+
+	ret = -EIO;
+	bt->dropped_file = debugfs_create_file("dropped", 0444, dir, bt,
+					       &blk_dropped_fops_ext);
+	if (!bt->dropped_file)
+		goto err;
+
+	bt->msg_file = debugfs_create_file("msg", 0222, dir, bt, &blk_msg_fops_ext);
+	if (!bt->msg_file)
+		goto err;
+
+	bt->rchan = relay_open("trace", dir, buts->buf_size,
+				buts->buf_nr, &blk_relay_callbacks_ext, bt);
+	if (!bt->rchan)
+		goto err;
+
+	bt->act_mask = buts->act_mask;
+	if (!bt->act_mask)
+		bt->act_mask = (u64) -1ULL;
+
+	bt->prio_mask = buts->prio_mask;
+
+	blk_trace_setup_lba_ext(bt, bdev);
+
+	/* overwrite with user settings */
+	if (buts->start_lba)
+		bt->start_lba = buts->start_lba;
+	if (buts->end_lba)
+		bt->end_lba = buts->end_lba;
+
+	bt->pid = buts->pid;
+	bt->trace_state = Blktrace_setup;
+
+	ret = -EBUSY;
+	if (cmpxchg(&q->blk_trace_ext, NULL, bt))
+		goto err;
+
+	get_probe_ref();
+
+	ret = 0;
+err:
+	if (dir && !bt->dir)
+		dput(dir);
+	if (ret)
+		blk_trace_free_ext(bt);
+	return ret;
+}
+
+
 static int __blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 			     struct block_device *bdev, char __user *arg)
 {
@@ -879,6 +1089,27 @@ static int __blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	return 0;
 }
 
+static int __blk_trace_setup_ext(struct request_queue *q, char *name, dev_t dev,
+			     struct block_device *bdev, char __user *arg)
+{
+	struct blk_user_trace_setup_ext buts;
+	int ret;
+
+	ret = copy_from_user(&buts, arg, sizeof(buts));
+	if (ret)
+		return -EFAULT;
+
+	ret = do_blk_trace_setup_ext(q, name, dev, bdev, &buts);
+	if (ret)
+		return ret;
+
+	if (copy_to_user(arg, &buts, sizeof(buts))) {
+		__blk_trace_remove_ext(q);
+		return -EFAULT;
+	}
+	return 0;
+}
+
 int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 		    struct block_device *bdev,
 		    char __user *arg)
@@ -969,12 +1200,57 @@ static int __blk_trace_startstop(struct request_queue *q, int start)
 	return ret;
 }
 
+static int __blk_trace_startstop_ext(struct request_queue *q, int start)
+{
+	int ret;
+	struct blk_trace_ext *bt;
+
+	bt = rcu_dereference_protected(q->blk_trace_ext,
+				       lockdep_is_held(&q->debugfs_mutex));
+	if (bt == NULL)
+		return -EINVAL;
+
+	/*
+	 * For starting a trace, we can transition from a setup or stopped
+	 * trace. For stopping a trace, the state must be running
+	 */
+	ret = -EINVAL;
+	if (start) {
+		if (bt->trace_state == Blktrace_setup ||
+		    bt->trace_state == Blktrace_stopped) {
+			blktrace_seq++;
+			smp_mb();
+			bt->trace_state = Blktrace_running;
+			spin_lock_irq(&running_trace_ext_lock);
+			list_add(&bt->running_ext_list,
+					&running_trace_ext_list);
+			spin_unlock_irq(&running_trace_ext_lock);
+
+			trace_note_time_ext(bt);
+			ret = 0;
+		}
+	} else {
+		if (bt->trace_state == Blktrace_running) {
+			bt->trace_state = Blktrace_stopped;
+			spin_lock_irq(&running_trace_ext_lock);
+			list_del_init(&bt->running_ext_list);
+			spin_unlock_irq(&running_trace_ext_lock);
+			relay_flush(bt->rchan);
+			ret = 0;
+		}
+	}
+
+	return ret;
+}
+
 int blk_trace_startstop(struct request_queue *q, int start)
 {
 	int ret;
 
 	mutex_lock(&q->debugfs_mutex);
 	ret = __blk_trace_startstop(q, start);
+	if (ret)
+		ret = __blk_trace_startstop_ext(q, start);
 	mutex_unlock(&q->debugfs_mutex);
 
 	return ret;
@@ -1011,6 +1287,10 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 		bdevname(bdev, b);
 		ret = __blk_trace_setup(q, b, bdev->bd_dev, bdev, arg);
 		break;
+	case BLKTRACESETUP_EXT:
+		bdevname(bdev, b);
+		ret = __blk_trace_setup_ext(q, b, bdev->bd_dev, bdev, arg);
+		break;
 #if defined(CONFIG_COMPAT) && defined(CONFIG_X86_64)
 	case BLKTRACESETUP32:
 		bdevname(bdev, b);
@@ -1023,9 +1303,18 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
 	case BLKTRACESTOP:
 		ret = __blk_trace_startstop(q, start);
 		break;
+	case BLKTRACESTART_EXT:
+		start = 1;
+		/* fallthrough */
+	case BLKTRACESTOP_EXT:
+		ret = __blk_trace_startstop_ext(q, start);
+		break;
 	case BLKTRACETEARDOWN:
 		ret = __blk_trace_remove(q);
 		break;
+	case BLKTRACETEARDOWN_EXT:
+		ret = __blk_trace_remove_ext(q);
+		break;
 	default:
 		ret = -ENOTTY;
 		break;
@@ -1049,6 +1338,11 @@ void blk_trace_shutdown(struct request_queue *q)
 		__blk_trace_remove(q);
 	}
 
+	if (rcu_dereference_protected(q->blk_trace_ext,
+				      lockdep_is_held(&q->debugfs_mutex))) {
+		__blk_trace_startstop_ext(q, 0);
+		__blk_trace_remove_ext(q);
+	}
 	mutex_unlock(&q->debugfs_mutex);
 }
 
-- 
2.22.1

