Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCFD6CD4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 13:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389786AbfGRLVL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 07:21:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47314 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727914AbfGRLVL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 07:21:11 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6IB3vtT138880
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2019 07:21:10 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ttpxct6ca-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2019 07:21:09 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Thu, 18 Jul 2019 12:21:07 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 18 Jul 2019 12:21:02 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6IBL0lK56098986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jul 2019 11:21:00 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92BAC11C058;
        Thu, 18 Jul 2019 11:21:00 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37D5711C04C;
        Thu, 18 Jul 2019 11:21:00 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.219])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 18 Jul 2019 11:21:00 +0000 (GMT)
Date:   Thu, 18 Jul 2019 13:20:49 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-nvdimm@lists.01.org, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, swhiteho@redhat.com,
        Sebastian Ott <sebott@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Collin Walling <walling@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 18/30] virtio_fs, dax: Set up virtio_fs dax_device
In-Reply-To: <20190718110417.561f6475.cohuck@redhat.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
        <20190515192715.18000-19-vgoyal@redhat.com>
        <20190717192725.25c3d146.pasic@linux.ibm.com>
        <20190718110417.561f6475.cohuck@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19071811-0008-0000-0000-000002FEA506
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071811-0009-0000-0000-0000226C22D8
Message-Id: <20190718132049.37bea675.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907180122
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 18 Jul 2019 11:04:17 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 17 Jul 2019 19:27:25 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Wed, 15 May 2019 15:27:03 -0400
> > Vivek Goyal <vgoyal@redhat.com> wrote:
> > 
> > > From: Stefan Hajnoczi <stefanha@redhat.com>
> > > 
> > > Setup a dax device.
> > > 
> > > Use the shm capability to find the cache entry and map it.
> > > 
> > > The DAX window is accessed by the fs/dax.c infrastructure and must have
> > > struct pages (at least on x86).  Use devm_memremap_pages() to map the
> > > DAX window PCI BAR and allocate struct page.
> > >  
> > 
> > Sorry for being this late. I don't see any more recent version so I will
> > comment here.
> 
> [Yeah, this one has been sitting in my to-review queue far too long as
> well :(]
> 
> > 
> > I'm trying to figure out how is this supposed to work on s390. My concern
> > is, that on s390 PCI memory needs to be accessed by special
> > instructions. This is taken care of by the stuff defined in
> > arch/s390/include/asm/io.h. E.g. we 'override' __raw_writew so it uses
> > the appropriate s390 instruction. However if the code does not use the
> > linux abstractions for accessing PCI memory, but assumes it can be
> > accessed like RAM, we have a problem.
> > 
> > Looking at this patch, it seems to me, that we might end up with exactly
> > the case described. For example AFAICT copy_to_iter() (3) resolves to
> > the function in lib/iov_iter.c which does not seem to cater for s390
> > oddities.
> 
> What about the new pci instructions recently introduced? Not sure how
> they differ from the old ones (which are currently the only ones
> supported in QEMU...), but I'm pretty sure they are supposed to solve
> an issue :)
> 

I'm struggling to find the connection between this topic and the new pci
instructions. Can you please explain in more detail?

> > 
> > I didn't have the time to investigate this properly, and since virtio-fs
> > is virtual, we may be able to get around what is otherwise a
> > limitation on s390. My understanding of these areas is admittedly
> > shallow, and since I'm not sure I'll have much more time to
> > invest in the near future I decided to raise concern.
> > 
> > Any opinions?
> 
> Let me point to the thread starting at
> https://marc.info/?l=linux-s390&m=155048406205221&w=2 as well. That
> memory region stuff is still unsolved for ccw, and I'm not sure if we
> need to do something for zpci as well.
> 

Right virtio-ccw is another problem, but at least there we don't have the
need to limit ourselves to a very specific set of instructions (for
accessing memory).

zPCI i.e. virtio-pci on z should require much less dedicated love if any
at all. Unfortunately I'm not very knowledgeable on either PCI in general
or its s390 variant.

> Does s390 work with DAX at all? ISTR that DAX evolved from XIP, so I
> thought it did?
> 

Documentation/filesystems/dax.txt even mentions dcssblk: s390 dcss block
device driver as a source of inspiration. So I suppose it does work.

Regards,
Halil

> > 
> > [CCing some s390 people who are probably more knowledgeable than my
> > on these matters.]
> > 
> > Regards,
> > Halil
> > 
> > 
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > > Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > > Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
> > > ---  
> > 
> > [..]
> >   
> > > +/* Map a window offset to a page frame number.  The window offset
> > > will have
> > > + * been produced by .iomap_begin(), which maps a file offset to a
> > > window
> > > + * offset.
> > > + */
> > > +static long virtio_fs_direct_access(struct dax_device *dax_dev,
> > > pgoff_t pgoff,
> > > +				    long nr_pages, void **kaddr,
> > > pfn_t *pfn) +{
> > > +	struct virtio_fs *fs = dax_get_private(dax_dev);
> > > +	phys_addr_t offset = PFN_PHYS(pgoff);
> > > +	size_t max_nr_pages = fs->window_len/PAGE_SIZE - pgoff;
> > > +
> > > +	if (kaddr)
> > > +		*kaddr = fs->window_kaddr + offset;  
> > 
> > (2) Here we use fs->window_kaddr, basically directing the access to
> > the virtio shared memory region.
> > 
> > > +	if (pfn)
> > > +		*pfn = phys_to_pfn_t(fs->window_phys_addr +
> > > offset,
> > > +					PFN_DEV | PFN_MAP);
> > > +	return nr_pages > max_nr_pages ? max_nr_pages : nr_pages;
> > > +}
> > > +
> > > +static size_t virtio_fs_copy_from_iter(struct dax_device *dax_dev,
> > > +				       pgoff_t pgoff, void *addr,
> > > +				       size_t bytes, struct
> > > iov_iter *i) +{
> > > +	return copy_from_iter(addr, bytes, i);
> > > +}
> > > +
> > > +static size_t virtio_fs_copy_to_iter(struct dax_device *dax_dev,
> > > +				       pgoff_t pgoff, void *addr,
> > > +				       size_t bytes, struct
> > > iov_iter *i) +{
> > > +	return copy_to_iter(addr, bytes, i);  
> > 
> > (3) And this should be the access to it. Which does not seem to use.
> > 
> > > +}
> > > +
> > > +static const struct dax_operations virtio_fs_dax_ops = {
> > > +	.direct_access = virtio_fs_direct_access,
> > > +	.copy_from_iter = virtio_fs_copy_from_iter,
> > > +	.copy_to_iter = virtio_fs_copy_to_iter,
> > > +};
> > > +
> > > +static void virtio_fs_percpu_release(struct percpu_ref *ref)
> > > +{
> > > +	struct virtio_fs_memremap_info *mi =
> > > +		container_of(ref, struct virtio_fs_memremap_info,
> > > ref); +
> > > +	complete(&mi->completion);
> > > +}
> > > +
> > > +static void virtio_fs_percpu_exit(void *data)
> > > +{
> > > +	struct virtio_fs_memremap_info *mi = data;
> > > +
> > > +	wait_for_completion(&mi->completion);
> > > +	percpu_ref_exit(&mi->ref);
> > > +}
> > > +
> > > +static void virtio_fs_percpu_kill(struct percpu_ref *ref)
> > > +{
> > > +	percpu_ref_kill(ref);
> > > +}
> > > +
> > > +static void virtio_fs_cleanup_dax(void *data)
> > > +{
> > > +	struct virtio_fs *fs = data;
> > > +
> > > +	kill_dax(fs->dax_dev);
> > > +	put_dax(fs->dax_dev);
> > > +}
> > > +
> > > +static int virtio_fs_setup_dax(struct virtio_device *vdev, struct
> > > virtio_fs *fs) +{
> > > +	struct virtio_shm_region cache_reg;
> > > +	struct virtio_fs_memremap_info *mi;
> > > +	struct dev_pagemap *pgmap;
> > > +	bool have_cache;
> > > +	int ret;
> > > +
> > > +	if (!IS_ENABLED(CONFIG_DAX_DRIVER))
> > > +		return 0;
> > > +
> > > +	/* Get cache region */
> > > +	have_cache = virtio_get_shm_region(vdev,
> > > +					   &cache_reg,
> > > +
> > > (u8)VIRTIO_FS_SHMCAP_ID_CACHE);
> > > +	if (!have_cache) {
> > > +		dev_err(&vdev->dev, "%s: No cache capability\n",
> > > __func__);
> > > +		return -ENXIO;
> > > +	} else {
> > > +		dev_notice(&vdev->dev, "Cache len: 0x%llx @
> > > 0x%llx\n",
> > > +			   cache_reg.len, cache_reg.addr);
> > > +	}
> > > +
> > > +	mi = devm_kzalloc(&vdev->dev, sizeof(*mi), GFP_KERNEL);
> > > +	if (!mi)
> > > +		return -ENOMEM;
> > > +
> > > +	init_completion(&mi->completion);
> > > +	ret = percpu_ref_init(&mi->ref, virtio_fs_percpu_release,
> > > 0,
> > > +			      GFP_KERNEL);
> > > +	if (ret < 0) {
> > > +		dev_err(&vdev->dev, "%s: percpu_ref_init failed
> > > (%d)\n",
> > > +			__func__, ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret = devm_add_action(&vdev->dev, virtio_fs_percpu_exit,
> > > mi);
> > > +	if (ret < 0) {
> > > +		percpu_ref_exit(&mi->ref);
> > > +		return ret;
> > > +	}
> > > +
> > > +	pgmap = &mi->pgmap;
> > > +	pgmap->altmap_valid = false;
> > > +	pgmap->ref = &mi->ref;
> > > +	pgmap->kill = virtio_fs_percpu_kill;
> > > +	pgmap->type = MEMORY_DEVICE_FS_DAX;
> > > +
> > > +	/* Ideally we would directly use the PCI BAR resource but
> > > +	 * devm_memremap_pages() wants its own copy in pgmap.  So
> > > +	 * initialize a struct resource from scratch (only the
> > > start
> > > +	 * and end fields will be used).
> > > +	 */
> > > +	pgmap->res = (struct resource){
> > > +		.name = "virtio-fs dax window",
> > > +		.start = (phys_addr_t) cache_reg.addr,
> > > +		.end = (phys_addr_t) cache_reg.addr +
> > > cache_reg.len - 1,
> > > +	};
> > > +
> > > +	fs->window_kaddr = devm_memremap_pages(&vdev->dev,
> > > pgmap);  
> > 
> > (1) Here we assign fs->window_kaddr basically from the virtio shm
> > region.
> > 
> > > +	if (IS_ERR(fs->window_kaddr))
> > > +		return PTR_ERR(fs->window_kaddr);
> > > +
> > > +	fs->window_phys_addr = (phys_addr_t) cache_reg.addr;
> > > +	fs->window_len = (phys_addr_t) cache_reg.len;
> > > +
> > > +	dev_dbg(&vdev->dev, "%s: window kaddr 0x%px phys_addr
> > > 0x%llx"
> > > +		" len 0x%llx\n", __func__, fs->window_kaddr,
> > > cache_reg.addr,
> > > +		cache_reg.len);
> > > +
> > > +	fs->dax_dev = alloc_dax(fs, NULL, &virtio_fs_dax_ops);
> > > +	if (!fs->dax_dev)
> > > +		return -ENOMEM;
> > > +
> > > +	return devm_add_action_or_reset(&vdev->dev,
> > > virtio_fs_cleanup_dax, fs); +}
> > > +  
> > 
> > [..]
> > 
> 

