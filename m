Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 911E56C05B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 19:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387770AbfGQR1j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jul 2019 13:27:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65354 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727260AbfGQR1i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jul 2019 13:27:38 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6HHOpIW025074
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2019 13:27:37 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tt7pj12wt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2019 13:27:36 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Wed, 17 Jul 2019 18:27:34 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 17 Jul 2019 18:27:30 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6HHRFcj39846292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 17:27:15 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39AB3A405C;
        Wed, 17 Jul 2019 17:27:29 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1850A4064;
        Wed, 17 Jul 2019 17:27:28 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.219])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 17 Jul 2019 17:27:28 +0000 (GMT)
Date:   Wed, 17 Jul 2019 19:27:25 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-nvdimm@lists.01.org, miklos@szeredi.hu,
        stefanha@redhat.com, dgilbert@redhat.com, swhiteho@redhat.com,
        Sebastian Ott <sebott@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Collin Walling <walling@linux.ibm.com>
Subject: Re: [PATCH v2 18/30] virtio_fs, dax: Set up virtio_fs dax_device
In-Reply-To: <20190515192715.18000-19-vgoyal@redhat.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
        <20190515192715.18000-19-vgoyal@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19071717-0012-0000-0000-00000333CFDF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071717-0013-0000-0000-0000216D4F30
Message-Id: <20190717192725.25c3d146.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-17_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907170201
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 15 May 2019 15:27:03 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

> From: Stefan Hajnoczi <stefanha@redhat.com>
> 
> Setup a dax device.
> 
> Use the shm capability to find the cache entry and map it.
> 
> The DAX window is accessed by the fs/dax.c infrastructure and must have
> struct pages (at least on x86).  Use devm_memremap_pages() to map the
> DAX window PCI BAR and allocate struct page.
>

Sorry for being this late. I don't see any more recent version so I will
comment here.

I'm trying to figure out how is this supposed to work on s390. My concern
is, that on s390 PCI memory needs to be accessed by special
instructions. This is taken care of by the stuff defined in
arch/s390/include/asm/io.h. E.g. we 'override' __raw_writew so it uses
the appropriate s390 instruction. However if the code does not use the
linux abstractions for accessing PCI memory, but assumes it can be
accessed like RAM, we have a problem.

Looking at this patch, it seems to me, that we might end up with exactly
the case described. For example AFAICT copy_to_iter() (3) resolves to
the function in lib/iov_iter.c which does not seem to cater for s390
oddities.

I didn't have the time to investigate this properly, and since virtio-fs
is virtual, we may be able to get around what is otherwise a
limitation on s390. My understanding of these areas is admittedly
shallow, and since I'm not sure I'll have much more time to
invest in the near future I decided to raise concern.

Any opinions?

[CCing some s390 people who are probably more knowledgeable than my on
these matters.]

Regards,
Halil


> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
> ---

[..]
  
> +/* Map a window offset to a page frame number.  The window offset will have
> + * been produced by .iomap_begin(), which maps a file offset to a window
> + * offset.
> + */
> +static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
> +				    long nr_pages, void **kaddr, pfn_t *pfn)
> +{
> +	struct virtio_fs *fs = dax_get_private(dax_dev);
> +	phys_addr_t offset = PFN_PHYS(pgoff);
> +	size_t max_nr_pages = fs->window_len/PAGE_SIZE - pgoff;
> +
> +	if (kaddr)
> +		*kaddr = fs->window_kaddr + offset;

(2) Here we use fs->window_kaddr, basically directing the access to the
virtio shared memory region.

> +	if (pfn)
> +		*pfn = phys_to_pfn_t(fs->window_phys_addr + offset,
> +					PFN_DEV | PFN_MAP);
> +	return nr_pages > max_nr_pages ? max_nr_pages : nr_pages;
> +}
> +
> +static size_t virtio_fs_copy_from_iter(struct dax_device *dax_dev,
> +				       pgoff_t pgoff, void *addr,
> +				       size_t bytes, struct iov_iter *i)
> +{
> +	return copy_from_iter(addr, bytes, i);
> +}
> +
> +static size_t virtio_fs_copy_to_iter(struct dax_device *dax_dev,
> +				       pgoff_t pgoff, void *addr,
> +				       size_t bytes, struct iov_iter *i)
> +{
> +	return copy_to_iter(addr, bytes, i);

(3) And this should be the access to it. Which does not seem to use.

> +}
> +
> +static const struct dax_operations virtio_fs_dax_ops = {
> +	.direct_access = virtio_fs_direct_access,
> +	.copy_from_iter = virtio_fs_copy_from_iter,
> +	.copy_to_iter = virtio_fs_copy_to_iter,
> +};
> +
> +static void virtio_fs_percpu_release(struct percpu_ref *ref)
> +{
> +	struct virtio_fs_memremap_info *mi =
> +		container_of(ref, struct virtio_fs_memremap_info, ref);
> +
> +	complete(&mi->completion);
> +}
> +
> +static void virtio_fs_percpu_exit(void *data)
> +{
> +	struct virtio_fs_memremap_info *mi = data;
> +
> +	wait_for_completion(&mi->completion);
> +	percpu_ref_exit(&mi->ref);
> +}
> +
> +static void virtio_fs_percpu_kill(struct percpu_ref *ref)
> +{
> +	percpu_ref_kill(ref);
> +}
> +
> +static void virtio_fs_cleanup_dax(void *data)
> +{
> +	struct virtio_fs *fs = data;
> +
> +	kill_dax(fs->dax_dev);
> +	put_dax(fs->dax_dev);
> +}
> +
> +static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
> +{
> +	struct virtio_shm_region cache_reg;
> +	struct virtio_fs_memremap_info *mi;
> +	struct dev_pagemap *pgmap;
> +	bool have_cache;
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_DAX_DRIVER))
> +		return 0;
> +
> +	/* Get cache region */
> +	have_cache = virtio_get_shm_region(vdev,
> +					   &cache_reg,
> +					   (u8)VIRTIO_FS_SHMCAP_ID_CACHE);
> +	if (!have_cache) {
> +		dev_err(&vdev->dev, "%s: No cache capability\n", __func__);
> +		return -ENXIO;
> +	} else {
> +		dev_notice(&vdev->dev, "Cache len: 0x%llx @ 0x%llx\n",
> +			   cache_reg.len, cache_reg.addr);
> +	}
> +
> +	mi = devm_kzalloc(&vdev->dev, sizeof(*mi), GFP_KERNEL);
> +	if (!mi)
> +		return -ENOMEM;
> +
> +	init_completion(&mi->completion);
> +	ret = percpu_ref_init(&mi->ref, virtio_fs_percpu_release, 0,
> +			      GFP_KERNEL);
> +	if (ret < 0) {
> +		dev_err(&vdev->dev, "%s: percpu_ref_init failed (%d)\n",
> +			__func__, ret);
> +		return ret;
> +	}
> +
> +	ret = devm_add_action(&vdev->dev, virtio_fs_percpu_exit, mi);
> +	if (ret < 0) {
> +		percpu_ref_exit(&mi->ref);
> +		return ret;
> +	}
> +
> +	pgmap = &mi->pgmap;
> +	pgmap->altmap_valid = false;
> +	pgmap->ref = &mi->ref;
> +	pgmap->kill = virtio_fs_percpu_kill;
> +	pgmap->type = MEMORY_DEVICE_FS_DAX;
> +
> +	/* Ideally we would directly use the PCI BAR resource but
> +	 * devm_memremap_pages() wants its own copy in pgmap.  So
> +	 * initialize a struct resource from scratch (only the start
> +	 * and end fields will be used).
> +	 */
> +	pgmap->res = (struct resource){
> +		.name = "virtio-fs dax window",
> +		.start = (phys_addr_t) cache_reg.addr,
> +		.end = (phys_addr_t) cache_reg.addr + cache_reg.len - 1,
> +	};
> +
> +	fs->window_kaddr = devm_memremap_pages(&vdev->dev, pgmap);

(1) Here we assign fs->window_kaddr basically from the virtio shm region.

> +	if (IS_ERR(fs->window_kaddr))
> +		return PTR_ERR(fs->window_kaddr);
> +
> +	fs->window_phys_addr = (phys_addr_t) cache_reg.addr;
> +	fs->window_len = (phys_addr_t) cache_reg.len;
> +
> +	dev_dbg(&vdev->dev, "%s: window kaddr 0x%px phys_addr 0x%llx"
> +		" len 0x%llx\n", __func__, fs->window_kaddr, cache_reg.addr,
> +		cache_reg.len);
> +
> +	fs->dax_dev = alloc_dax(fs, NULL, &virtio_fs_dax_ops);
> +	if (!fs->dax_dev)
> +		return -ENOMEM;
> +
> +	return devm_add_action_or_reset(&vdev->dev, virtio_fs_cleanup_dax, fs);
> +}
> +

[..]

