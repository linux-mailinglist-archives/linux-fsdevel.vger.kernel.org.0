Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB4C1C620
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 11:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfENJeV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 05:34:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40260 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfENJeV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 05:34:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 41D56C1306E5;
        Tue, 14 May 2019 09:34:20 +0000 (UTC)
Received: from [10.36.117.118] (ovpn-117-118.ams2.redhat.com [10.36.117.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 132E0608AC;
        Tue, 14 May 2019 09:34:05 +0000 (UTC)
Subject: Re: [PATCH v8 2/6] virtio-pmem: Add virtio pmem driver
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-acpi@vger.kernel.org,
        qemu-devel@nongnu.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org,
        dan j williams <dan.j.williams@intel.com>,
        zwisler@kernel.org, vishal l verma <vishal.l.verma@intel.com>,
        dave jiang <dave.jiang@intel.com>, mst@redhat.com,
        jasowang@redhat.com, willy@infradead.org, rjw@rjwysocki.net,
        hch@infradead.org, lenb@kernel.org, jack@suse.cz, tytso@mit.edu,
        adilger kernel <adilger.kernel@dilger.ca>,
        darrick wong <darrick.wong@oracle.com>, lcapitulino@redhat.com,
        kwolf@redhat.com, imammedo@redhat.com, jmoyer@redhat.com,
        nilal@redhat.com, riel@surriel.com, stefanha@redhat.com,
        aarcange@redhat.com, david@fromorbit.com, cohuck@redhat.com,
        xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
        pbonzini@redhat.com, kilobyte@angband.pl,
        yuval shaia <yuval.shaia@oracle.com>, jstaron@google.com
References: <20190510155202.14737-1-pagupta@redhat.com>
 <20190510155202.14737-3-pagupta@redhat.com>
 <f2ea35a6-ec98-447c-44fe-0cb3ab309340@redhat.com>
 <752392764.28554139.1557826022323.JavaMail.zimbra@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <86298c2c-cc7c-5b97-0f11-335d7da8c450@redhat.com>
Date:   Tue, 14 May 2019 11:34:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <752392764.28554139.1557826022323.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 14 May 2019 09:34:20 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>>
>>> +	}
>>> +
>>> +	/* When host has read buffer, this completes via host_ack */
>>
>> "A host repsonse results in "host_ack" getting called" ... ?
>>
>>> +	wait_event(req->host_acked, req->done);
>>> +	err = req->ret;
>>> +ret:
>>> +	kfree(req);
>>> +	return err;
>>> +};
>>> +
>>> +/* The asynchronous flush callback function */
>>> +int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
>>> +{
>>> +	int rc = 0;
>>> +
>>> +	/* Create child bio for asynchronous flush and chain with
>>> +	 * parent bio. Otherwise directly call nd_region flush.
>>> +	 */
>>> +	if (bio && bio->bi_iter.bi_sector != -1) {
>>> +		struct bio *child = bio_alloc(GFP_ATOMIC, 0);
>>> +
>>> +		if (!child)
>>> +			return -ENOMEM;
>>> +		bio_copy_dev(child, bio);
>>> +		child->bi_opf = REQ_PREFLUSH;
>>> +		child->bi_iter.bi_sector = -1;
>>> +		bio_chain(child, bio);
>>> +		submit_bio(child);
>>
>> return 0;
>>
>> Then, drop the "else" case and "int rc" and do directly
>>
>> if (virtio_pmem_flush(nd_region))
>> 	return -EIO;
> 
> and another 'return 0' here :)
> 
> I don't like return from multiple places instead I prefer
> single exit point from function.

Makes this function more complicated than necessary. I agree when there
are locks involved.

>  
>>
>>> +
>>> +	return 0;
>>> +};
>>> +
>>> +static int virtio_pmem_probe(struct virtio_device *vdev)
>>> +{
>>> +	int err = 0;
>>> +	struct resource res;
>>> +	struct virtio_pmem *vpmem;
>>> +	struct nd_region_desc ndr_desc = {};
>>> +	int nid = dev_to_node(&vdev->dev);
>>> +	struct nd_region *nd_region;
>>
>> Nit: use reverse Christmas tree layout :)
> 
> Done.
> 
>>
>>> +
>>> +	if (!vdev->config->get) {
>>> +		dev_err(&vdev->dev, "%s failure: config access disabled\n",
>>> +			__func__);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	vpmem = devm_kzalloc(&vdev->dev, sizeof(*vpmem), GFP_KERNEL);
>>> +	if (!vpmem) {
>>> +		err = -ENOMEM;
>>> +		goto out_err;
>>> +	}
>>> +
>>> +	vpmem->vdev = vdev;
>>> +	vdev->priv = vpmem;
>>> +	err = init_vq(vpmem);
>>> +	if (err)
>>> +		goto out_err;
>>> +
>>> +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
>>> +			start, &vpmem->start);
>>> +	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
>>> +			size, &vpmem->size);
>>> +
>>> +	res.start = vpmem->start;
>>> +	res.end   = vpmem->start + vpmem->size-1;
>>> +	vpmem->nd_desc.provider_name = "virtio-pmem";
>>> +	vpmem->nd_desc.module = THIS_MODULE;
>>> +
>>> +	vpmem->nvdimm_bus = nvdimm_bus_register(&vdev->dev,
>>> +						&vpmem->nd_desc);
>>> +	if (!vpmem->nvdimm_bus)
>>> +		goto out_vq;
>>> +
>>> +	dev_set_drvdata(&vdev->dev, vpmem->nvdimm_bus);
>>> +
>>> +	ndr_desc.res = &res;
>>> +	ndr_desc.numa_node = nid;
>>> +	ndr_desc.flush = async_pmem_flush;
>>> +	set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
>>> +	set_bit(ND_REGION_ASYNC, &ndr_desc.flags);
>>> +	nd_region = nvdimm_pmem_region_create(vpmem->nvdimm_bus, &ndr_desc);
>>> +
>>
>> I'd drop this empty line.
> 
> hmm.
> 

The common pattern after allocating something, immediately check for it
in the next line (like you do throughout this patch ;) )

...
>> You are not freeing "vdev->priv".
> 
> vdev->priv is vpmem which is allocated using devm API.

I'm confused. Looking at drivers/virtio/virtio_balloon.c:

static void virtballoon_remove(struct virtio_device *vdev)
{
	struct virtio_balloon *vb = vdev->priv;

	...

	kfree(vb);
}

I think you should do the same here, vdev->priv is allocated in
virtio_pmem_probe.

But maybe I am missing something important here :)

>>
>>> +	nvdimm_bus_unregister(nvdimm_bus);
>>> +	vdev->config->del_vqs(vdev);
>>> +	vdev->config->reset(vdev);
>>> +}
>>> +

-- 

Thanks,

David / dhildenb
