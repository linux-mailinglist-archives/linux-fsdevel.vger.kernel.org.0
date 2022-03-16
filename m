Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDDD4DB1CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 14:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354524AbiCPNr2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 09:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241647AbiCPNr0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:47:26 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEB605D65B;
        Wed, 16 Mar 2022 06:46:10 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3ARC8MSKm+Gx15ewHA4EoSTyro5gzqJ0RdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bp2MEmmMcWWyPaa2CZ2D1KthxbYm/8EgDv5LTm9Y3HlRl+CA2RRqmi?=
 =?us-ascii?q?+KfW43BcR2Y0wB+jyH7ZBs+qZ1YM7EsFehsJpPnjkrrYuiJQUVUj/nSHOKmULe?=
 =?us-ascii?q?cY0ideCc/IMsfoUM68wIGqt4w6TSJK1vlVeLa+6UzCnf8s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kur39NEMXQL/OJhXIgX1TM0SgqkEa4HVsjeBgb7xBAatUo2zhc9RZ0shEs4ehD?=
 =?us-ascii?q?wkvJbHklvkfUgVDDmd1OqguFLrveCLl7pfIkhSZG5fr67A0ZK0sBqUU8/h2DUl?=
 =?us-ascii?q?A7/sdLyoHbwzFjOWzqJq7QelEh8ItNsDnMYoT/HZ6wlnxAf8gB5KFXKTO4d5R2?=
 =?us-ascii?q?SwYh8ZSEPKYbM0cARJjbgvHZRJnOVoNDp862uCyiRHXdzxetULQoK8f4Hbaxw8?=
 =?us-ascii?q?316LiWPLTZNCLQMB9mkeDunmA+2X/HwFcONGBoRKH+3ShwOTPgAv8QosZELD+/?=
 =?us-ascii?q?flv6HWXx2oOGFgYTle2v/S9olCxVsgZKEEO/Ccq668o+ySDStj7Qg39o3OeuBM?=
 =?us-ascii?q?Yc8RfHvd86wyXzKfQpQGDCQAsSj9HdcxjpMEtbSIl20XPnN7zAzFr9rqPRhqgG?=
 =?us-ascii?q?h28xd+pEXFNazZcOmlfFk1Yi+QPabob1nrnJuuP2obs5jEtJQzN/g=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AVUg6hKlM/KmWHn+NaQObFCc54BzpDfIQ3DAb?=
 =?us-ascii?q?v31ZSRFFG/Fw9vre+MjzsCWYtN9/Yh8dcK+7UpVoLUm8yXcX2/h1AV7BZniEhI?=
 =?us-ascii?q?LAFugLgrcKqAeQeREWmNQ86Y5QN4B6CPDVSWNxlNvG5mCDeOoI8Z2q97+JiI7l?=
 =?us-ascii?q?o0tQcQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="122733517"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 Mar 2022 21:46:09 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 3582E4D16FC7;
        Wed, 16 Mar 2022 21:46:09 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 16 Mar 2022 21:46:08 +0800
Received: from [10.167.201.9] (10.167.201.9) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Wed, 16 Mar 2022 21:46:08 +0800
Message-ID: <4fd95f0b-106f-6933-7bc6-9f0890012b53@fujitsu.com>
Date:   Wed, 16 Mar 2022 21:46:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v11 1/8] dax: Introduce holder for dax_device
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, david <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>
References: <20220227120747.711169-1-ruansy.fnst@fujitsu.com>
 <20220227120747.711169-2-ruansy.fnst@fujitsu.com>
 <CAPcyv4jAqV7dZdmGcKrG=f8sYmUXaL7YCQtME6GANywncwd+zg@mail.gmail.com>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <CAPcyv4jAqV7dZdmGcKrG=f8sYmUXaL7YCQtME6GANywncwd+zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 3582E4D16FC7.A3D86
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/3/12 7:35, Dan Williams 写道:
> On Sun, Feb 27, 2022 at 4:08 AM Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
>>
>> To easily track filesystem from a pmem device, we introduce a holder for
>> dax_device structure, and also its operation.  This holder is used to
>> remember who is using this dax_device:
>>   - When it is the backend of a filesystem, the holder will be the
>>     instance of this filesystem.
>>   - When this pmem device is one of the targets in a mapped device, the
>>     holder will be this mapped device.  In this case, the mapped device
>>     has its own dax_device and it will follow the first rule.  So that we
>>     can finally track to the filesystem we needed.
>>
>> The holder and holder_ops will be set when filesystem is being mounted,
>> or an target device is being activated.
>>
>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
>> ---
>>   drivers/dax/super.c | 89 +++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/dax.h | 32 ++++++++++++++++
>>   2 files changed, 121 insertions(+)
>>
>> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
>> index e3029389d809..da5798e19d57 100644
>> --- a/drivers/dax/super.c
>> +++ b/drivers/dax/super.c
>> @@ -21,6 +21,9 @@
>>    * @cdev: optional character interface for "device dax"
>>    * @private: dax driver private data
>>    * @flags: state and boolean properties
>> + * @ops: operations for dax_device
>> + * @holder_data: holder of a dax_device: could be filesystem or mapped device
>> + * @holder_ops: operations for the inner holder
>>    */
>>   struct dax_device {
>>          struct inode inode;
>> @@ -28,6 +31,8 @@ struct dax_device {
>>          void *private;
>>          unsigned long flags;
>>          const struct dax_operations *ops;
>> +       void *holder_data;
>> +       const struct dax_holder_operations *holder_ops;
>>   };
>>
>>   static dev_t dax_devt;
>> @@ -193,6 +198,29 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
>>   }
>>   EXPORT_SYMBOL_GPL(dax_zero_page_range);
>>
>> +int dax_holder_notify_failure(struct dax_device *dax_dev, u64 off,
>> +                             u64 len, int mf_flags)
>> +{
>> +       int rc, id;
>> +
>> +       id = dax_read_lock();
>> +       if (!dax_alive(dax_dev)) {
>> +               rc = -ENXIO;
>> +               goto out;
>> +       }
>> +
>> +       if (!dax_dev->holder_ops) {
>> +               rc = -EOPNOTSUPP;
> 
> I think it is ok to return success (0) for this case. All the caller
> of dax_holder_notify_failure() wants to know is if the notification
> was successfully delivered to the holder. If there is no holder
> present then there is nothing to report. This is minor enough for me
> to fix up locally if nothing else needs to be changed.

I thought it could fall back to generic memory failure handler: 
mf_generic_kill_procs(), if holder_ops not exists.

> 
>> +               goto out;
>> +       }
>> +
>> +       rc = dax_dev->holder_ops->notify_failure(dax_dev, off, len, mf_flags);
>> +out:
>> +       dax_read_unlock(id);
>> +       return rc;
>> +}
>> +EXPORT_SYMBOL_GPL(dax_holder_notify_failure);
>> +
>>   #ifdef CONFIG_ARCH_HAS_PMEM_API
>>   void arch_wb_cache_pmem(void *addr, size_t size);
>>   void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
>> @@ -268,6 +296,10 @@ void kill_dax(struct dax_device *dax_dev)
>>
>>          clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
>>          synchronize_srcu(&dax_srcu);
>> +
>> +       /* clear holder data */
>> +       dax_dev->holder_ops = NULL;
>> +       dax_dev->holder_data = NULL;
> 
> Isn't this another failure scenario? If kill_dax() is called while a
> holder is still holding the dax_device that seems to be another
> ->notify_failure scenario to tell the holder that the device is going
> away and the holder has not released the device yet.

Yes.  I should call dax_holder_notify_failure() and then unregister the 
holder.

> 
>>   }
>>   EXPORT_SYMBOL_GPL(kill_dax);
>>
>> @@ -409,6 +441,63 @@ void put_dax(struct dax_device *dax_dev)
>>   }
>>   EXPORT_SYMBOL_GPL(put_dax);
>>
>> +/**
>> + * dax_holder() - obtain the holder of a dax device
>> + * @dax_dev: a dax_device instance
>> +
>> + * Return: the holder's data which represents the holder if registered,
>> + * otherwize NULL.
>> + */
>> +void *dax_holder(struct dax_device *dax_dev)
>> +{
>> +       if (!dax_alive(dax_dev))
>> +               return NULL;
> 
> It's safe for the holder to assume that it can de-reference
> ->holder_data freely in its notify_handler callback because
> dax_holder_notify_failure() arranges for the callback to run in
> dax_read_lock() context.
> 
> This is another minor detail that I can fixup locally.
> 
>> +
>> +       return dax_dev->holder_data;
>> +}
>> +EXPORT_SYMBOL_GPL(dax_holder);
>> +
>> +/**
>> + * dax_register_holder() - register a holder to a dax device
>> + * @dax_dev: a dax_device instance
>> + * @holder: a pointer to a holder's data which represents the holder
>> + * @ops: operations of this holder
>> +
>> + * Return: negative errno if an error occurs, otherwise 0.
>> + */
>> +int dax_register_holder(struct dax_device *dax_dev, void *holder,
>> +               const struct dax_holder_operations *ops)
>> +{
>> +       if (!dax_alive(dax_dev))
>> +               return -ENXIO;
>> +
>> +       if (cmpxchg(&dax_dev->holder_data, NULL, holder))
>> +               return -EBUSY;
>> +
>> +       dax_dev->holder_ops = ops;
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(dax_register_holder);
>> +
>> +/**
>> + * dax_unregister_holder() - unregister the holder for a dax device
>> + * @dax_dev: a dax_device instance
>> + * @holder: the holder to be unregistered
>> + *
>> + * Return: negative errno if an error occurs, otherwise 0.
>> + */
>> +int dax_unregister_holder(struct dax_device *dax_dev, void *holder)
>> +{
>> +       if (!dax_alive(dax_dev))
>> +               return -ENXIO;
>> +
>> +       if (cmpxchg(&dax_dev->holder_data, holder, NULL) != holder)
>> +               return -EBUSY;
>> +       dax_dev->holder_ops = NULL;
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(dax_unregister_holder);
>> +
>>   /**
>>    * inode_dax: convert a public inode into its dax_dev
>>    * @inode: An inode with i_cdev pointing to a dax_dev
>> diff --git a/include/linux/dax.h b/include/linux/dax.h
>> index 9fc5f99a0ae2..262d7bad131a 100644
>> --- a/include/linux/dax.h
>> +++ b/include/linux/dax.h
>> @@ -32,8 +32,24 @@ struct dax_operations {
>>          int (*zero_page_range)(struct dax_device *, pgoff_t, size_t);
>>   };
>>
>> +struct dax_holder_operations {
>> +       /*
>> +        * notify_failure - notify memory failure into inner holder device
>> +        * @dax_dev: the dax device which contains the holder
>> +        * @offset: offset on this dax device where memory failure occurs
>> +        * @len: length of this memory failure event
> 
> Forgive me if this has been discussed before, but since dax_operations
> are in terms of pgoff and nr pages and memory_failure() is in terms of
> pfns what was the rationale for making the function signature byte
> based?

Maybe I didn't describe it clearly...  The @offset and @len here are 
byte-based.  And so is ->memory_failure().

You can find the implementation of ->memory_failure() in 3rd patch:

+static int pmem_pagemap_memory_failure(struct dev_pagemap *pgmap,
+		phys_addr_t addr, u64 len, int mf_flags)
+{
+	struct pmem_device *pmem =
+			container_of(pgmap, struct pmem_device, pgmap);
+	u64 offset = addr - pmem->phys_addr - pmem->data_offset;
+
+	return dax_holder_notify_failure(pmem->dax_dev, offset, len, mf_flags);
+}

> 
> I want to get this series merged into linux-next shortly after
> v5.18-rc1. Then we can start working on incremental fixups rather
> resending the full series with these long reply cycles.


Thanks.  That really helps.


--
Ruan.


