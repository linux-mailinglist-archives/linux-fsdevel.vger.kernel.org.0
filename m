Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DA81AEC29
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 13:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgDRLsB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 07:48:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50470 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgDRLsA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 07:48:00 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03IBhXbT004545;
        Sat, 18 Apr 2020 11:47:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=geNGJb1RrJxWb0w/CU4ApZuniBkI/7P5uf5lu013oAE=;
 b=t2iSbsfziUEBwdbtU8HZdZhnoP9Vand4ApDhgnJUZ4o9BGyClCEImEMJ0brOkJVANNwR
 UbL0fP90ajYf1W6YOmJ0g650cMH3gTTj7Tc9i+fDQefuytufhmyt2Jw7U56YpdIXtPeY
 SfXxeoG+Fn73nxbrM3zqthIaVqikAPGo2PhfMidYcto13GemuC59LgFwgjTiULN7po7h
 I8re3ZWnFfQFQ2FRnb0TBmzgQ5LVvyFIOhuyy8Bpwo91jKlWTte91/UR2we87MpxE4ix
 QywSCbPc+IxQH6S0u3W6UFolnimIMtgg6wzgwAIuXUy/M0PbSEEyayf5EUePsCoUrhMu ZQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30fsgkgyx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Apr 2020 11:47:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03IBhDWx187986;
        Sat, 18 Apr 2020 11:45:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30frvkqcut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Apr 2020 11:45:42 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03IBjWXk014081;
        Sat, 18 Apr 2020 11:45:32 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 18 Apr 2020 04:45:31 -0700
Date:   Sat, 18 Apr 2020 14:45:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Desmond Yan <desmond.yan@broadcom.com>,
        James Hu <james.hu@broadcom.com>
Subject: Re: [PATCH v2 6/7] misc: bcm-vk: add Broadcom VK driver
Message-ID: <20200418114516.GE12862@kadam>
References: <20200220004825.23372-1-scott.branden@broadcom.com>
 <20200220004825.23372-7-scott.branden@broadcom.com>
 <20200220104321.GX7838@kadam>
 <63c9dcda-7a31-78a7-1d11-9d9af38add46@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63c9dcda-7a31-78a7-1d11-9d9af38add46@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9594 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004180096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9594 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004180096
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 17, 2020 at 02:49:11PM -0700, Scott Branden wrote:
> > > +static int bcm_vk_dma_alloc(struct device *dev,
> > > +			    struct bcm_vk_dma *dma,
> > > +			    int direction,
> > > +			    struct _vk_data *vkdata)
> > > +{
> > > +	dma_addr_t addr, sg_addr;
> > > +	int err;
> > > +	int i;
> > > +	int offset;
> > > +	uint32_t size;
> > > +	uint32_t remaining_size;
> > > +	uint32_t transfer_size;
> > > +	uint64_t data;
> > > +	unsigned long first, last;
> > > +	struct _vk_data *sgdata;
> > > +
> > > +	/* Get 64-bit user address */
> > > +	data = get_unaligned(&(vkdata->address));
> > Extra parens.
> removed
> > 
> > > +
> > > +	/* offset into first page */
> > > +	offset = offset_in_page(data);
> > > +
> > > +	/* Calculate number of pages */
> > > +	first = (data & PAGE_MASK) >> PAGE_SHIFT;
> > > +	last  = ((data + vkdata->size - 1) & PAGE_MASK) >> PAGE_SHIFT;
> > > +	dma->nr_pages = last - first + 1;
> > > +
> > > +	/* Allocate DMA pages */
> > > +	dma->pages = kmalloc_array(dma->nr_pages,
> > > +				   sizeof(struct page *),
> > > +				   GFP_KERNEL);
> > > +	if (dma->pages == NULL)
> > > +		return -ENOMEM;
> > > +
> > > +	dev_dbg(dev, "Alloc DMA Pages [0x%llx+0x%x => %d pages]\n",
> > > +		data, vkdata->size, dma->nr_pages);
> > > +
> > > +	dma->direction = direction;
> > > +
> > > +	/* Get user pages into memory */
> > > +	err = get_user_pages_fast(data & PAGE_MASK,
> > > +				  dma->nr_pages,
> > > +				  direction == DMA_FROM_DEVICE,
> > > +				  dma->pages);
> > > +	if (err != dma->nr_pages) {
> > > +		dma->nr_pages = (err >= 0) ? err : 0;
> > > +		dev_err(dev, "get_user_pages_fast, err=%d [%d]\n",
> > > +			err, dma->nr_pages);
> > > +		return err < 0 ? err : -EINVAL;
> > > +	}
> > > +
> > > +	/* Max size of sg list is 1 per mapped page + fields at start */
> > > +	dma->sglen = (dma->nr_pages * sizeof(*sgdata)) +
> > > +		     (sizeof(uint32_t) * SGLIST_VKDATA_START);
> > > +
> > > +	/* Allocate sglist */
> > > +	dma->sglist = dma_alloc_coherent(dev,
> > > +					 dma->sglen,
> > > +					 &dma->handle,
> > > +					 GFP_KERNEL);
> > 
> > 	dma->sglist = dma_alloc_coherent(dev, dma->sglen, &dma->handle,
> > 					 GFP_KERNEL);
> done
> > 
> > 
> > 
> > > +	if (!dma->sglist)
> > > +		return -ENOMEM;
> > No cleanup?
> what needs to be cleaned up?

dma->pages should be freed probably?  And a put_user_pages_fast()?

regards,
dan carpenter

