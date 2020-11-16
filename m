Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354552B46F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 15:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbgKPO7g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 09:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730942AbgKPO7b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:59:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BECBC0613D2;
        Mon, 16 Nov 2020 06:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=EaJZ5ZAOnqbW7jE+L2UIcq37a6pYwqJsY9OEaGa0ZMg=; b=K6aOl6Wl4emIGya7dNO3VK4giB
        RrLVrsnwciZD9REImiBOJpS2BGk+3cuN8NTeyZW6ZmMA+Ukg9E6g4MhMrK0UXSjMffjzCiXFaNE4M
        m4oa3O5ssF8kIfuRc5iypBIY7oPwn4MqZ8RIsE00NolXLG9oID81czwJRVsYg++Qn00gT96xEJQUM
        Ec1vaaBm2mYbzA5lP0j//6Qj5PKpmwe+PEfLM5StATuQF7VH1Qfpk0ZyhDEV4WuoGeO82mUEUBDbW
        5wEhqM9fHL89MPwukGt/c3OSiaQo7/iQTTTm0h0fIdu3fV/o7VasqFVwsBqQbeYd6zaP2j8kmeyHU
        dptQrB0w==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kefyS-00042Q-Vn; Mon, 16 Nov 2020 14:59:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 50/78] z2ram: reindent
Date:   Mon, 16 Nov 2020 15:57:41 +0100
Message-Id: <20201116145809.410558-51-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

reindent the driver using Lident as the code style was far away from
normal Linux code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/block/z2ram.c | 493 ++++++++++++++++++++----------------------
 1 file changed, 236 insertions(+), 257 deletions(-)

diff --git a/drivers/block/z2ram.c b/drivers/block/z2ram.c
index 0e734802ee7cc6..eafecc9a72b38d 100644
--- a/drivers/block/z2ram.c
+++ b/drivers/block/z2ram.c
@@ -42,7 +42,6 @@
 
 #include <linux/zorro.h>
 
-
 #define Z2MINOR_COMBINED      (0)
 #define Z2MINOR_Z2ONLY        (1)
 #define Z2MINOR_CHIPONLY      (2)
@@ -50,17 +49,17 @@
 #define Z2MINOR_MEMLIST2      (5)
 #define Z2MINOR_MEMLIST3      (6)
 #define Z2MINOR_MEMLIST4      (7)
-#define Z2MINOR_COUNT         (8) /* Move this down when adding a new minor */
+#define Z2MINOR_COUNT         (8)	/* Move this down when adding a new minor */
 
 #define Z2RAM_CHUNK1024       ( Z2RAM_CHUNKSIZE >> 10 )
 
 static DEFINE_MUTEX(z2ram_mutex);
-static u_long *z2ram_map    = NULL;
-static u_long z2ram_size    = 0;
-static int z2_count         = 0;
-static int chip_count       = 0;
-static int list_count       = 0;
-static int current_device   = -1;
+static u_long *z2ram_map = NULL;
+static u_long z2ram_size = 0;
+static int z2_count = 0;
+static int chip_count = 0;
+static int list_count = 0;
+static int current_device = -1;
 
 static DEFINE_SPINLOCK(z2ram_lock);
 
@@ -71,7 +70,7 @@ static blk_status_t z2_queue_rq(struct blk_mq_hw_ctx *hctx,
 {
 	struct request *req = bd->rq;
 	unsigned long start = blk_rq_pos(req) << 9;
-	unsigned long len  = blk_rq_cur_bytes(req);
+	unsigned long len = blk_rq_cur_bytes(req);
 
 	blk_mq_start_request(req);
 
@@ -92,7 +91,7 @@ static blk_status_t z2_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 		if (len < size)
 			size = len;
-		addr += z2ram_map[ start >> Z2RAM_CHUNKSHIFT ];
+		addr += z2ram_map[start >> Z2RAM_CHUNKSHIFT];
 		if (rq_data_dir(req) == READ)
 			memcpy(buffer, (char *)addr, size);
 		else
@@ -106,228 +105,214 @@ static blk_status_t z2_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_OK;
 }
 
-static void
-get_z2ram( void )
+static void get_z2ram(void)
 {
-    int i;
-
-    for ( i = 0; i < Z2RAM_SIZE / Z2RAM_CHUNKSIZE; i++ )
-    {
-	if ( test_bit( i, zorro_unused_z2ram ) )
-	{
-	    z2_count++;
-	    z2ram_map[z2ram_size++] = (unsigned long)ZTWO_VADDR(Z2RAM_START) +
-				      (i << Z2RAM_CHUNKSHIFT);
-	    clear_bit( i, zorro_unused_z2ram );
+	int i;
+
+	for (i = 0; i < Z2RAM_SIZE / Z2RAM_CHUNKSIZE; i++) {
+		if (test_bit(i, zorro_unused_z2ram)) {
+			z2_count++;
+			z2ram_map[z2ram_size++] =
+			    (unsigned long)ZTWO_VADDR(Z2RAM_START) +
+			    (i << Z2RAM_CHUNKSHIFT);
+			clear_bit(i, zorro_unused_z2ram);
+		}
 	}
-    }
 
-    return;
+	return;
 }
 
-static void
-get_chipram( void )
+static void get_chipram(void)
 {
 
-    while ( amiga_chip_avail() > ( Z2RAM_CHUNKSIZE * 4 ) )
-    {
-	chip_count++;
-	z2ram_map[ z2ram_size ] =
-	    (u_long)amiga_chip_alloc( Z2RAM_CHUNKSIZE, "z2ram" );
+	while (amiga_chip_avail() > (Z2RAM_CHUNKSIZE * 4)) {
+		chip_count++;
+		z2ram_map[z2ram_size] =
+		    (u_long) amiga_chip_alloc(Z2RAM_CHUNKSIZE, "z2ram");
 
-	if ( z2ram_map[ z2ram_size ] == 0 )
-	{
-	    break;
+		if (z2ram_map[z2ram_size] == 0) {
+			break;
+		}
+
+		z2ram_size++;
 	}
 
-	z2ram_size++;
-    }
-	
-    return;
+	return;
 }
 
 static int z2_open(struct block_device *bdev, fmode_t mode)
 {
-    int device;
-    int max_z2_map = ( Z2RAM_SIZE / Z2RAM_CHUNKSIZE ) *
-	sizeof( z2ram_map[0] );
-    int max_chip_map = ( amiga_chip_size / Z2RAM_CHUNKSIZE ) *
-	sizeof( z2ram_map[0] );
-    int rc = -ENOMEM;
-
-    device = MINOR(bdev->bd_dev);
-
-    mutex_lock(&z2ram_mutex);
-    if ( current_device != -1 && current_device != device )
-    {
-	rc = -EBUSY;
-	goto err_out;
-    }
-
-    if ( current_device == -1 )
-    {
-	z2_count   = 0;
-	chip_count = 0;
-	list_count = 0;
-	z2ram_size = 0;
-
-	/* Use a specific list entry. */
-	if (device >= Z2MINOR_MEMLIST1 && device <= Z2MINOR_MEMLIST4) {
-		int index = device - Z2MINOR_MEMLIST1 + 1;
-		unsigned long size, paddr, vaddr;
-
-		if (index >= m68k_realnum_memory) {
-			printk( KERN_ERR DEVICE_NAME
-				": no such entry in z2ram_map\n" );
-		        goto err_out;
-		}
-
-		paddr = m68k_memory[index].addr;
-		size = m68k_memory[index].size & ~(Z2RAM_CHUNKSIZE-1);
-
-#ifdef __powerpc__
-		/* FIXME: ioremap doesn't build correct memory tables. */
-		{
-			vfree(vmalloc (size));
-		}
+	int device;
+	int max_z2_map = (Z2RAM_SIZE / Z2RAM_CHUNKSIZE) * sizeof(z2ram_map[0]);
+	int max_chip_map = (amiga_chip_size / Z2RAM_CHUNKSIZE) *
+	    sizeof(z2ram_map[0]);
+	int rc = -ENOMEM;
 
-		vaddr = (unsigned long)ioremap_wt(paddr, size);
+	device = MINOR(bdev->bd_dev);
 
-#else
-		vaddr = (unsigned long)z_remap_nocache_nonser(paddr, size);
-#endif
-		z2ram_map = 
-			kmalloc_array(size / Z2RAM_CHUNKSIZE,
-                                      sizeof(z2ram_map[0]),
-                                      GFP_KERNEL);
-		if ( z2ram_map == NULL )
-		{
-		    printk( KERN_ERR DEVICE_NAME
-			": cannot get mem for z2ram_map\n" );
-		    goto err_out;
-		}
+	mutex_lock(&z2ram_mutex);
+	if (current_device != -1 && current_device != device) {
+		rc = -EBUSY;
+		goto err_out;
+	}
 
-		while (size) {
-			z2ram_map[ z2ram_size++ ] = vaddr;
-			size -= Z2RAM_CHUNKSIZE;
-			vaddr += Z2RAM_CHUNKSIZE;
-			list_count++;
-		}
+	if (current_device == -1) {
+		z2_count = 0;
+		chip_count = 0;
+		list_count = 0;
+		z2ram_size = 0;
 
-		if ( z2ram_size != 0 )
-		    printk( KERN_INFO DEVICE_NAME
-			": using %iK List Entry %d Memory\n",
-			list_count * Z2RAM_CHUNK1024, index );
-	} else
-
-	switch ( device )
-	{
-	    case Z2MINOR_COMBINED:
-
-		z2ram_map = kmalloc( max_z2_map + max_chip_map, GFP_KERNEL );
-		if ( z2ram_map == NULL )
-		{
-		    printk( KERN_ERR DEVICE_NAME
-			": cannot get mem for z2ram_map\n" );
-		    goto err_out;
-		}
+		/* Use a specific list entry. */
+		if (device >= Z2MINOR_MEMLIST1 && device <= Z2MINOR_MEMLIST4) {
+			int index = device - Z2MINOR_MEMLIST1 + 1;
+			unsigned long size, paddr, vaddr;
 
-		get_z2ram();
-		get_chipram();
-
-		if ( z2ram_size != 0 )
-		    printk( KERN_INFO DEVICE_NAME 
-			": using %iK Zorro II RAM and %iK Chip RAM (Total %dK)\n",
-			z2_count * Z2RAM_CHUNK1024,
-			chip_count * Z2RAM_CHUNK1024,
-			( z2_count + chip_count ) * Z2RAM_CHUNK1024 );
-
-	    break;
-
-    	    case Z2MINOR_Z2ONLY:
-		z2ram_map = kmalloc( max_z2_map, GFP_KERNEL );
-		if ( z2ram_map == NULL )
-		{
-		    printk( KERN_ERR DEVICE_NAME
-			": cannot get mem for z2ram_map\n" );
-		    goto err_out;
-		}
+			if (index >= m68k_realnum_memory) {
+				printk(KERN_ERR DEVICE_NAME
+				       ": no such entry in z2ram_map\n");
+				goto err_out;
+			}
 
-		get_z2ram();
+			paddr = m68k_memory[index].addr;
+			size = m68k_memory[index].size & ~(Z2RAM_CHUNKSIZE - 1);
 
-		if ( z2ram_size != 0 )
-		    printk( KERN_INFO DEVICE_NAME 
-			": using %iK of Zorro II RAM\n",
-			z2_count * Z2RAM_CHUNK1024 );
+#ifdef __powerpc__
+			/* FIXME: ioremap doesn't build correct memory tables. */
+			{
+				vfree(vmalloc(size));
+			}
 
-	    break;
+			vaddr = (unsigned long)ioremap_wt(paddr, size);
 
-	    case Z2MINOR_CHIPONLY:
-		z2ram_map = kmalloc( max_chip_map, GFP_KERNEL );
-		if ( z2ram_map == NULL )
-		{
-		    printk( KERN_ERR DEVICE_NAME
-			": cannot get mem for z2ram_map\n" );
-		    goto err_out;
+#else
+			vaddr =
+			    (unsigned long)z_remap_nocache_nonser(paddr, size);
+#endif
+			z2ram_map =
+			    kmalloc_array(size / Z2RAM_CHUNKSIZE,
+					  sizeof(z2ram_map[0]), GFP_KERNEL);
+			if (z2ram_map == NULL) {
+				printk(KERN_ERR DEVICE_NAME
+				       ": cannot get mem for z2ram_map\n");
+				goto err_out;
+			}
+
+			while (size) {
+				z2ram_map[z2ram_size++] = vaddr;
+				size -= Z2RAM_CHUNKSIZE;
+				vaddr += Z2RAM_CHUNKSIZE;
+				list_count++;
+			}
+
+			if (z2ram_size != 0)
+				printk(KERN_INFO DEVICE_NAME
+				       ": using %iK List Entry %d Memory\n",
+				       list_count * Z2RAM_CHUNK1024, index);
+		} else
+			switch (device) {
+			case Z2MINOR_COMBINED:
+
+				z2ram_map =
+				    kmalloc(max_z2_map + max_chip_map,
+					    GFP_KERNEL);
+				if (z2ram_map == NULL) {
+					printk(KERN_ERR DEVICE_NAME
+					       ": cannot get mem for z2ram_map\n");
+					goto err_out;
+				}
+
+				get_z2ram();
+				get_chipram();
+
+				if (z2ram_size != 0)
+					printk(KERN_INFO DEVICE_NAME
+					       ": using %iK Zorro II RAM and %iK Chip RAM (Total %dK)\n",
+					       z2_count * Z2RAM_CHUNK1024,
+					       chip_count * Z2RAM_CHUNK1024,
+					       (z2_count +
+						chip_count) * Z2RAM_CHUNK1024);
+
+				break;
+
+			case Z2MINOR_Z2ONLY:
+				z2ram_map = kmalloc(max_z2_map, GFP_KERNEL);
+				if (z2ram_map == NULL) {
+					printk(KERN_ERR DEVICE_NAME
+					       ": cannot get mem for z2ram_map\n");
+					goto err_out;
+				}
+
+				get_z2ram();
+
+				if (z2ram_size != 0)
+					printk(KERN_INFO DEVICE_NAME
+					       ": using %iK of Zorro II RAM\n",
+					       z2_count * Z2RAM_CHUNK1024);
+
+				break;
+
+			case Z2MINOR_CHIPONLY:
+				z2ram_map = kmalloc(max_chip_map, GFP_KERNEL);
+				if (z2ram_map == NULL) {
+					printk(KERN_ERR DEVICE_NAME
+					       ": cannot get mem for z2ram_map\n");
+					goto err_out;
+				}
+
+				get_chipram();
+
+				if (z2ram_size != 0)
+					printk(KERN_INFO DEVICE_NAME
+					       ": using %iK Chip RAM\n",
+					       chip_count * Z2RAM_CHUNK1024);
+
+				break;
+
+			default:
+				rc = -ENODEV;
+				goto err_out;
+
+				break;
+			}
+
+		if (z2ram_size == 0) {
+			printk(KERN_NOTICE DEVICE_NAME
+			       ": no unused ZII/Chip RAM found\n");
+			goto err_out_kfree;
 		}
 
-		get_chipram();
-
-		if ( z2ram_size != 0 )
-		    printk( KERN_INFO DEVICE_NAME 
-			": using %iK Chip RAM\n",
-			chip_count * Z2RAM_CHUNK1024 );
-		    
-	    break;
-
-	    default:
-		rc = -ENODEV;
-		goto err_out;
-	
-	    break;
+		current_device = device;
+		z2ram_size <<= Z2RAM_CHUNKSHIFT;
+		set_capacity(z2ram_gendisk, z2ram_size >> 9);
 	}
 
-	if ( z2ram_size == 0 )
-	{
-	    printk( KERN_NOTICE DEVICE_NAME
-		": no unused ZII/Chip RAM found\n" );
-	    goto err_out_kfree;
-	}
-
-	current_device = device;
-	z2ram_size <<= Z2RAM_CHUNKSHIFT;
-	set_capacity(z2ram_gendisk, z2ram_size >> 9);
-    }
-
-    mutex_unlock(&z2ram_mutex);
-    return 0;
+	mutex_unlock(&z2ram_mutex);
+	return 0;
 
 err_out_kfree:
-    kfree(z2ram_map);
+	kfree(z2ram_map);
 err_out:
-    mutex_unlock(&z2ram_mutex);
-    return rc;
+	mutex_unlock(&z2ram_mutex);
+	return rc;
 }
 
-static void
-z2_release(struct gendisk *disk, fmode_t mode)
+static void z2_release(struct gendisk *disk, fmode_t mode)
 {
-    mutex_lock(&z2ram_mutex);
-    if ( current_device == -1 ) {
-    	mutex_unlock(&z2ram_mutex);
-    	return;
-    }
-    mutex_unlock(&z2ram_mutex);
-    /*
-     * FIXME: unmap memory
-     */
+	mutex_lock(&z2ram_mutex);
+	if (current_device == -1) {
+		mutex_unlock(&z2ram_mutex);
+		return;
+	}
+	mutex_unlock(&z2ram_mutex);
+	/*
+	 * FIXME: unmap memory
+	 */
 }
 
-static const struct block_device_operations z2_fops =
-{
-	.owner		= THIS_MODULE,
-	.open		= z2_open,
-	.release	= z2_release,
+static const struct block_device_operations z2_fops = {
+	.owner = THIS_MODULE,
+	.open = z2_open,
+	.release = z2_release,
 };
 
 static struct kobject *z2_find(dev_t dev, int *part, void *data)
@@ -340,89 +325,83 @@ static struct request_queue *z2_queue;
 static struct blk_mq_tag_set tag_set;
 
 static const struct blk_mq_ops z2_mq_ops = {
-	.queue_rq	= z2_queue_rq,
+	.queue_rq = z2_queue_rq,
 };
 
-static int __init 
-z2_init(void)
+static int __init z2_init(void)
 {
-    int ret;
+	int ret;
 
-    if (!MACH_IS_AMIGA)
-	return -ENODEV;
+	if (!MACH_IS_AMIGA)
+		return -ENODEV;
 
-    ret = -EBUSY;
-    if (register_blkdev(Z2RAM_MAJOR, DEVICE_NAME))
-	goto err;
+	ret = -EBUSY;
+	if (register_blkdev(Z2RAM_MAJOR, DEVICE_NAME))
+		goto err;
 
-    ret = -ENOMEM;
-    z2ram_gendisk = alloc_disk(1);
-    if (!z2ram_gendisk)
-	goto out_disk;
+	ret = -ENOMEM;
+	z2ram_gendisk = alloc_disk(1);
+	if (!z2ram_gendisk)
+		goto out_disk;
 
-    z2_queue = blk_mq_init_sq_queue(&tag_set, &z2_mq_ops, 16,
+	z2_queue = blk_mq_init_sq_queue(&tag_set, &z2_mq_ops, 16,
 					BLK_MQ_F_SHOULD_MERGE);
-    if (IS_ERR(z2_queue)) {
-	ret = PTR_ERR(z2_queue);
-	z2_queue = NULL;
-	goto out_queue;
-    }
+	if (IS_ERR(z2_queue)) {
+		ret = PTR_ERR(z2_queue);
+		z2_queue = NULL;
+		goto out_queue;
+	}
 
-    z2ram_gendisk->major = Z2RAM_MAJOR;
-    z2ram_gendisk->first_minor = 0;
-    z2ram_gendisk->fops = &z2_fops;
-    sprintf(z2ram_gendisk->disk_name, "z2ram");
+	z2ram_gendisk->major = Z2RAM_MAJOR;
+	z2ram_gendisk->first_minor = 0;
+	z2ram_gendisk->fops = &z2_fops;
+	sprintf(z2ram_gendisk->disk_name, "z2ram");
 
-    z2ram_gendisk->queue = z2_queue;
-    add_disk(z2ram_gendisk);
-    blk_register_region(MKDEV(Z2RAM_MAJOR, 0), Z2MINOR_COUNT, THIS_MODULE,
-				z2_find, NULL, NULL);
+	z2ram_gendisk->queue = z2_queue;
+	add_disk(z2ram_gendisk);
+	blk_register_region(MKDEV(Z2RAM_MAJOR, 0), Z2MINOR_COUNT, THIS_MODULE,
+			    z2_find, NULL, NULL);
 
-    return 0;
+	return 0;
 
 out_queue:
-    put_disk(z2ram_gendisk);
+	put_disk(z2ram_gendisk);
 out_disk:
-    unregister_blkdev(Z2RAM_MAJOR, DEVICE_NAME);
+	unregister_blkdev(Z2RAM_MAJOR, DEVICE_NAME);
 err:
-    return ret;
+	return ret;
 }
 
 static void __exit z2_exit(void)
 {
-    int i, j;
-    blk_unregister_region(MKDEV(Z2RAM_MAJOR, 0), Z2MINOR_COUNT);
-    unregister_blkdev(Z2RAM_MAJOR, DEVICE_NAME);
-    del_gendisk(z2ram_gendisk);
-    put_disk(z2ram_gendisk);
-    blk_cleanup_queue(z2_queue);
-    blk_mq_free_tag_set(&tag_set);
-
-    if ( current_device != -1 )
-    {
-	i = 0;
-
-	for ( j = 0 ; j < z2_count; j++ )
-	{
-	    set_bit( i++, zorro_unused_z2ram ); 
-	}
+	int i, j;
+	blk_unregister_region(MKDEV(Z2RAM_MAJOR, 0), Z2MINOR_COUNT);
+	unregister_blkdev(Z2RAM_MAJOR, DEVICE_NAME);
+	del_gendisk(z2ram_gendisk);
+	put_disk(z2ram_gendisk);
+	blk_cleanup_queue(z2_queue);
+	blk_mq_free_tag_set(&tag_set);
+
+	if (current_device != -1) {
+		i = 0;
+
+		for (j = 0; j < z2_count; j++) {
+			set_bit(i++, zorro_unused_z2ram);
+		}
 
-	for ( j = 0 ; j < chip_count; j++ )
-	{
-	    if ( z2ram_map[ i ] )
-	    {
-		amiga_chip_free( (void *) z2ram_map[ i++ ] );
-	    }
-	}
+		for (j = 0; j < chip_count; j++) {
+			if (z2ram_map[i]) {
+				amiga_chip_free((void *)z2ram_map[i++]);
+			}
+		}
 
-	if ( z2ram_map != NULL )
-	{
-	    kfree( z2ram_map );
+		if (z2ram_map != NULL) {
+			kfree(z2ram_map);
+		}
 	}
-    }
 
-    return;
-} 
+	return;
+}
 
 module_init(z2_init);
 module_exit(z2_exit);
-- 
2.29.2

