Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424481AEC2E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 13:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbgDRLr7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 07:47:59 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34200 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgDRLr6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 07:47:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03IBiRl5096448;
        Sat, 18 Apr 2020 11:47:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=81gTzqIjlHBm7QAubrLSzvHClUl9G4hCGInOrxEy1uU=;
 b=hyR3wxbbq99P3U4oKqLG0qsVhsZ3X6XJQAV9I/kjDU6DQ+val8+dJnlx3RP7LU1iV2dm
 RCi4MRsxCYRXqwN0RN0Y/WtBXgRi3+jjInIKGhczqlcLGS7ujElhIbY5La5HOk6MPVe1
 jpV5nFxqta/pwf+N9DosRlL/8U75tIm+qlsNacla3rIuZRp3d9/Lkn4t/uzGc4PibP1g
 2+Od9dLbdgdM/cnaXAvLJqu87C60e0maid9przZ1lUoNss/NWfCaEAff97GJz2tZ33Zg
 RRJxZPV2DvyGOU+Vk9dFGhaDQjQiVlBn9z4ZfrGbsxjJ1wb1MwirRKl2ZFH+6S7O3ytK nQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 30fxkjr79d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Apr 2020 11:47:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03IBg0Y2044227;
        Sat, 18 Apr 2020 11:47:43 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 30fpnrttd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Apr 2020 11:47:43 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03IBlfw8003405;
        Sat, 18 Apr 2020 11:47:41 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 18 Apr 2020 04:47:40 -0700
Date:   Sat, 18 Apr 2020 14:47:25 +0300
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
Message-ID: <20200418114725.GF12862@kadam>
References: <20200220004825.23372-1-scott.branden@broadcom.com>
 <20200220004825.23372-7-scott.branden@broadcom.com>
 <20200220104321.GX7838@kadam>
 <63c9dcda-7a31-78a7-1d11-9d9af38add46@broadcom.com>
 <20200418114516.GE12862@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418114516.GE12862@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9594 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004180096
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9594 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004180096
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 18, 2020 at 02:45:16PM +0300, Dan Carpenter wrote:
> On Fri, Apr 17, 2020 at 02:49:11PM -0700, Scott Branden wrote:
> > > > +static int bcm_vk_dma_alloc(struct device *dev,
> > > > +			    struct bcm_vk_dma *dma,
> > > > +			    int direction,
> > > > +			    struct _vk_data *vkdata)
> > > > +{
> > > > +	dma_addr_t addr, sg_addr;
> > > > +	int err;
> > > > +	int i;
> > > > +	int offset;
> > > > +	uint32_t size;
> > > > +	uint32_t remaining_size;
> > > > +	uint32_t transfer_size;
> > > > +	uint64_t data;
> > > > +	unsigned long first, last;
> > > > +	struct _vk_data *sgdata;
> > > > +
> > > > +	/* Get 64-bit user address */
> > > > +	data = get_unaligned(&(vkdata->address));
> > > Extra parens.
> > removed
> > > 
> > > > +
> > > > +	/* offset into first page */
> > > > +	offset = offset_in_page(data);
> > > > +
> > > > +	/* Calculate number of pages */
> > > > +	first = (data & PAGE_MASK) >> PAGE_SHIFT;
> > > > +	last  = ((data + vkdata->size - 1) & PAGE_MASK) >> PAGE_SHIFT;
> > > > +	dma->nr_pages = last - first + 1;
> > > > +
> > > > +	/* Allocate DMA pages */
> > > > +	dma->pages = kmalloc_array(dma->nr_pages,
> > > > +				   sizeof(struct page *),
> > > > +				   GFP_KERNEL);
> > > > +	if (dma->pages == NULL)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	dev_dbg(dev, "Alloc DMA Pages [0x%llx+0x%x => %d pages]\n",
> > > > +		data, vkdata->size, dma->nr_pages);
> > > > +
> > > > +	dma->direction = direction;
> > > > +
> > > > +	/* Get user pages into memory */
> > > > +	err = get_user_pages_fast(data & PAGE_MASK,
> > > > +				  dma->nr_pages,
> > > > +				  direction == DMA_FROM_DEVICE,
> > > > +				  dma->pages);
> > > > +	if (err != dma->nr_pages) {
> > > > +		dma->nr_pages = (err >= 0) ? err : 0;
> > > > +		dev_err(dev, "get_user_pages_fast, err=%d [%d]\n",
> > > > +			err, dma->nr_pages);
> > > > +		return err < 0 ? err : -EINVAL;
> > > > +	}
> > > > +
> > > > +	/* Max size of sg list is 1 per mapped page + fields at start */
> > > > +	dma->sglen = (dma->nr_pages * sizeof(*sgdata)) +
> > > > +		     (sizeof(uint32_t) * SGLIST_VKDATA_START);
> > > > +
> > > > +	/* Allocate sglist */
> > > > +	dma->sglist = dma_alloc_coherent(dev,
> > > > +					 dma->sglen,
> > > > +					 &dma->handle,
> > > > +					 GFP_KERNEL);
> > > 
> > > 	dma->sglist = dma_alloc_coherent(dev, dma->sglen, &dma->handle,
> > > 					 GFP_KERNEL);
> > done
> > > 
> > > 
> > > 
> > > > +	if (!dma->sglist)
> > > > +		return -ENOMEM;
> > > No cleanup?
> > what needs to be cleaned up?
> 
> dma->pages should be freed probably?  And a put_user_pages_fast()?

Sorry put_user_pages_fast() isn't a function.  My bad.

regards,
dan carpenter
